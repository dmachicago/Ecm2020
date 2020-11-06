#Const RemoteOcr = 0

Imports ECMEncryption

Imports System.Deployment.Application
Imports System.Reflection
Imports System.Collections.Specialized

#Const EnableSingleSource = 0

Imports System.IO
Imports System.Threading
Imports Microsoft.Win32
Imports System.Security.Permissions
'Imports Microsoft.Data.Sqlite
Imports System.Data.SQLite

Public Class frmMain : Implements IDisposable

    'Dim ProxySearch As New SVCSearch.Service1Client
    'Dim ProxyArchive As New SVCCLCArchive.Service1Client
    'Dim ProxyFS As New SVCFS.Service1Client

    Public GraphicDict As New List(Of String)
    Public ZipDict As New Dictionary(Of String, String)
    Public AllowDuplicateFiles As String = System.Configuration.ConfigurationManager.AppSettings("AllowDuplicateFiles")
    Dim LoggingPath As String = System.Configuration.ConfigurationManager.AppSettings("LoggingPath")

    Dim TRACEFLOW As String = System.Configuration.ConfigurationManager.AppSettings("TRACEFLOW")
    Dim VerifyEmbeddedZipFiles As String = ""
    Dim SkipPermission As Boolean = False
    Dim LocalDBBackUpComplete As Boolean = False

    Dim DirectoryList As New Dictionary(Of String, String)

    Dim bUseRemoteServer As Boolean = False
    Dim MachineIDcurr As String = ""
    Dim UIDcurr As String = ""
    Dim ArgsPassedIn As Boolean = False
    Dim gbEmailWidth As Integer = 0
    Dim args As String() = Nothing

    Dim SI As New clsSAVEDITEMS
    Dim ISO As New clsIsolatedStorage
    Dim DBLocal As New clsDbLocal
    Dim REG As New clsRegistry
    Dim LM As New clsLicenseMgt

    Dim AssignedLibraries As New List(Of String)
    Dim ArchiveActive As Boolean = False
    Dim ActivityThread As Thread
    Dim LoginAsNewUser As Boolean = False
    Dim t2 As Thread
    Dim t3 As Thread
    Dim t4 As Thread
    Dim t5 As Thread
    Dim t6 As Thread
    Dim t7 As Thread
    Dim t8 As Thread
    Dim t As Thread

    Dim UseLocalSettingsOnly = "0"
    Dim UseThreads As Boolean = True

    Public AutoExecCheck As Integer = 0
    Public ThreadCnt As Integer = 0
    Dim MiniArchiveRunning As Boolean = False
    Dim ListenersDefined As Boolean = False
    Dim ListenForChanges As Boolean = False
    Dim ListenDirectory As Boolean = False
    Dim ListenSubDirectory As Boolean = False
    Dim DirGuid As String = ""

    Dim MachineName As String = Environment.MachineName.ToString

    Dim FoldersRefreshed As Boolean = False
    Dim AllEmailFoldersShowing As Boolean = False
    Dim bApplyingDirParms As Boolean = False
    Dim bSingleInstanceContent As Boolean = True
    Dim bAddThisFileAsNewVersion As Boolean = False

    Dim NbrFilesInDir As Integer = 0

    Dim ParentFolder As String = ""
    Dim FQNFolder As String = ""
    Dim bActiveChange As Boolean = False
    Dim isOutlookAvail As Boolean = False

    Public EmailsBackedUp As Integer = 0
    Public EmailsSkipped As Integer = 0

    Dim CurrentDirectory As String = ""

    Dim ImageSizeDouble As Double = 0
    Dim ImageGuid As String = ""

    Dim GE As New clsGlobalEntity
    Dim LISTEN As New clsListener
    Dim PROC As New clsProcess
    Dim DisplayActivity As Boolean = False
    Dim isAdmin As Boolean = False
    Dim ALR As New clsAutoLibRef
    Dim IncludeListHasChanged As Boolean = False
    Dim RECON As New clsRecon
    Dim ARCH As New clsArchiver
    Dim PARMS As New clsExecParms
    Dim STATS As New clsARCHIVESTATS
    Dim UNASGND As New clsAVAILFILETYPESUNDEFINED
    Dim AP As New clsAppParms
    Dim ZF As New clsZipFiles
    Dim USERS As New clsUSERS
    Dim MP3 As New clsMP3
    Dim MsgNotification As Boolean = False
    Dim FI As New clsFileInfo
    Dim ENC As New ECMEncrypt

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    'Dim KAT As New clsChilKat

    'Dim CMODI As New clsModi

    'Public gCurrUserGuidID = ""
    Public CurrIdentity As String = ""

    Dim formloaded As Boolean = False

    Dim bUseAttachData As Boolean = False
    Dim CompanyID As String = ""
    Dim RepoID As String = ""

    Dim DOCS As New clsDataSource_V2
    Dim AVL As New clsAVAILFILETYPES

    'Dim DBASES As New clsDbARCHS
    Dim EMPARMS As New clsEMAILARCHPARMS

    Dim EMF As New clsEMAILFOLDER
    Dim EXL As New clsEXCLUDEDFILES
    Dim INL As New clsINCLUDEDFILES
    Dim RUSER As New clsReconUSERS
    Dim DBARCH As New clsDatabaseARCH
    Dim RPARM As New clsRUNPARMS
    Dim DIRS As New clsDIRECTORY
    Dim SUBDIRECTORY As New clsSUBDIR
    Dim DMA As New clsDma
    Dim PFA As New clsPROCESSFILEAS
    Dim CompletedPolls As Integer = 0
    Dim ATTRIB As New clsATTRIBUTES
    Dim SRCATTR As New clsSOURCEATTRIBUTE
    Dim ATCH_TYPE As New clsATTACHMENTTYPE

    Public SubDirectories As New ArrayList
    Public IncludedTypes As New ArrayList
    Public ExcludedTypes As New ArrayList
    Public AuthorizedFileTypes As New ArrayList
    Public UnAuthorizedFileTypes As New ArrayList

    Dim ddebug As Boolean = False
    Dim bHelpLoaded As Boolean = False
    Public ArchivedEmailFolders As New ArrayList

    Dim currentDomain As AppDomain = AppDomain.CurrentDomain

    Sub New()
        InitializeComponent()

        ' Define a handler for unhandled exceptions.
        AddHandler currentDomain.UnhandledException, AddressOf MYExnHandler
        ' Define a handler for unhandled exceptions for threads behind forms.
        AddHandler Application.ThreadException, AddressOf MYThreadHandler

        Dim bFrm As Boolean = ckFormOpen("frmMessageBar")
        If Not bFrm Then
            frmMessageBar.Show()
        End If

        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "01")
        ' Add any initialization after the InitializeComponent() call.
        updateMessageBar("1 of 6")

        If My.Settings("UpgradeSettings") = True Then
            Try
                LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 100")
                My.Settings.Upgrade()
                My.Settings.Reload()
                My.Settings("UpgradeSettings") = False
                My.Settings.Save()

                LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 200: " + My.Settings("UserDefaultConnString"))
                LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 300: " + My.Settings("UserThesaurusConnString"))
                'WDM 10-30-2020 Commewnted out next stmtm
                'DBLocal.RestoreSQLite()
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 01 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: INSTALL 100: " + ex.Message)
            End Try
        End If
        updateMessageBar("2 of 6")

        Dim strUseRemoteServer As String = System.Configuration.ConfigurationManager.AppSettings("UseRemoteServer")
        If strUseRemoteServer.Equals("1") Then
            bUseRemoteServer = True
        Else
            bUseRemoteServer = False
        End If
        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "10")
        ExitToolStripMenuItem.Visible = True
        updateMessageBar("3 of 6")

        Try
            VerifyEmbeddedZipFiles = System.Configuration.ConfigurationManager.AppSettings("VerifyEmbeddedZipFiles")
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 02 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            VerifyEmbeddedZipFiles = "0"
        End Try

        gMachineID = LOG.getEnvVarMachineName
        gNetworkID = LOG.getEnvVarNetworkID
        updateMessageBar("4 of 6")

        DBLocal.cleanZipFiles()
        updateMessageBar("5 of 6")

        UTIL.cleanTempWorkingDir()
        updateMessageBar("6 of 6")

        populateZipExtensions()
        updateMessageBar("6 of 6.1")

        populateGraphicExtensions()
        updateMessageBar("6 of 6.2")

        'Me.Show()
        Application.DoEvents()

        Dim bopen As Boolean = ckFormOpen("frmMain")
        If Not bopen Then
            Try
                Me.Show()
            Catch ex As Exception
                Console.WriteLine("Notice: frmMain closed... reopening")
            End Try

        End If

        gAllowedExts = DBARCH.getUsersAllowedFileExt(gCurrUserGuidID)

        TabControl1.SelectedIndex = 1

    End Sub

    Sub ApplyDDUpdates()
        frmDBUpdates.Show()
        frmDBUpdates.Hide()
        Dim DBU As New clsDBUpdate
        DBU.CheckForDBUpdates()
        DBU = Nothing
        frmDBUpdates.Close()
    End Sub

    Function ckFormOpen(fname As String) As Boolean

        Dim xb As Boolean = False
        For Each form In My.Application.OpenForms
            If (form.name = fname) Then
                If form.Visible Then
                    xb = True
                End If
            End If
        Next
        Return xb

    End Function

    Sub setLastArchiveLabel()
        If gUseLastArchiveDate.Equals("1") Then
            lblUseLastArchiveDate.Text = "Last Arch ON: " + gLastArchiveDate.ToString
            lblUseLastArchiveDate.BackColor = Color.Green
            lblUseLastArchiveDate.ForeColor = Color.White
        Else
            lblUseLastArchiveDate.Text = "Last Arch OFF"
            lblUseLastArchiveDate.BackColor = Color.Red
            lblUseLastArchiveDate.ForeColor = Color.Yellow
        End If
    End Sub

    Private Sub frmReconMain_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim OSVer As String = UTIL.getOsVersion()
        Dim isLongFileNamesAvail As Boolean = UTIL.isLongFileNamesAvail

        updateMessageBar("Applying any needed updates, standby...")
        ApplyDDUpdates()

        DBLocal.setFirstUseLastArchiveDateActive()

        DBLocal.getUseLastArchiveDateActive()
        setLastArchiveLabel()
        getLIsteners()

        'INSERT ALL THE REPO ALLOWED EXTENSIONS INTO THE SQLITE DB
        Dim AllowedExts As List(Of String) = DBARCH.getUsedExtension()
        DBLocal.resetExtension()
        DBLocal.addExtension(AllowedExts)

        Dim ContentOnly As Boolean = False
        Dim OutlookOnly As Boolean = False
        Dim ExchangeOnly As Boolean = False
        Dim ArchiveALL As Boolean = False

        Dim LL As Double = 0
        Dim CurrUserGuidID As String = ""
        MachineIDcurr = DMA.GetCurrMachineName

        lblCustomerName.Text = gCustomerName
        lblCustomerID.Text = gCustomerID

        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "30")
        ShowMsgHeader("Standby please, fetching setup parameters.") : LL = 225

        UseLocalSettingsOnly = System.Configuration.ConfigurationManager.AppSettings("UseLocalOnly")

        If UseDirectoryListener.Equals(1) Then
            ContentToolStripMenuItem.Text = "Content (Listener ON)"
        Else
            ContentToolStripMenuItem.Text = "Content (Quick)"
        End If


        Dim CurrentLoginID As String = ""
        'CurrentLoginID = System.Environment.UserName

        CurrentLoginID = LoginForm1.txtLoginID.Text
        gCurrLoginID = CurrentLoginID
        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "40")
        updateMessageBar("1 of 18")

        Try
            args = Environment.GetCommandLineArgs() : LL = 64
            gRunMode = "GUI" : LL = 65
            GetQueryStringParameters() : LL = 69
            If args IsNot Nothing Then : LL = 66.1
                '** The only allowed argument is company id and repo id separated by a semicolon
                '** Or a directory name with or without a file qualifier.
                '** If a directory name is passed in, only that directory will be processed
                '** and its subdirectories if specified as such.
                ArgsPassedIn = True
                For Each Arg As String In args : LL = 67
                    If InStr(Arg, ";") Then
                        Dim AA() As String = Arg.Split(";")
                        CompanyID = AA(0)
                        RepoID = AA(1)
                        Dim sCompanyID As String = REG.ReadEcmRegistrySubKey("CompanyID")
                        Dim sRepoID As String = REG.ReadEcmRegistrySubKey("RepoID")
                        Dim bReg As Boolean = False
                        If sCompanyID.Length = 0 Then
                            bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID)
                            If Not bReg Then
                                bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID)
                            End If
                        End If
                        If sRepoID.Length = 0 Then
                            bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID)
                            If Not bReg Then
                                bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID)
                            End If
                        End If
                    End If
                    Dim xArg As String = Arg.ToString : LL = 68
                    LL = 69
                    If Mid(xArg, 1, 1).Equals("U") Then
                        ArgsPassedIn = True
                        'Execute archive and close app : LL = 71
                        LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.") : LL = 72
                        gCurrLoginID = Mid(Arg, 2) : LL = 73
                        CurrentLoginID = gCurrLoginID
                        SB2.Text = "Running as : '" + gCurrLoginID + "'" : LL = 74
                        SB.Text = "Running as : '" + gCurrLoginID + "'" : LL = 75
                    End If : LL = 76
                    If Arg.ToUpper.Equals("U") Then
                        ArgsPassedIn = True
                        'Execute archive and close app : LL = 78
                        LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.") : LL = 79
                        gCurrLoginID = Mid(Arg, 2) : LL = 80
                        CurrentLoginID = gCurrLoginID
                        SB2.Text = "Running as : '" + gCurrLoginID + "'" : LL = 81
                        SB.Text = "Running as : '" + gCurrLoginID + "'" : LL = 82
                    End If : LL = 83
                    If Arg.ToUpper.Equals("P") Then
                        ArgsPassedIn = True
                        'Execute archive and close app : LL = 85
                        LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.") : LL = 86
                        gEncPassword = Mid(Arg, 2) : LL = 87
                        gUnEncPassword = ENC.AES256DecryptString(gEncPassword) : LL = 88
                    End If : LL = 89
                    If Arg.ToUpper.Equals("RUV") Then
                        ArgsPassedIn = True
                        LOG.WriteToArchiveLog("Notification: upgrading user settings.") : LL = 91
                        My.Settings("UpgradeSettings") = True : LL = 92
                        My.Settings.Save() : LL = 93
                    End If : LL = 94
                    If Arg.ToUpper.Equals("X") Then
                        ArgsPassedIn = True
                        'Execute archive and close app : LL = 96
                        LOG.WriteToArchiveLog("Notification: Scheduled Execute archive and close app.") : LL = 97
                        gRunMode = "X" : LL = 98
                        gRunMinimized = True : LL = 99
                        gRunUnattended = True : LL = 100
                        Me.WindowState = FormWindowState.Minimized : LL = 101
                    End If : LL = 102
                    If Arg.ToUpper.Equals("A") Then
                        ArgsPassedIn = True
                        'Execute archive and close app : LL = 104
                        LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.") : LL = 105
                        gRunMode = "X" : LL = 106
                        gContentArchiving = True : LL = 107
                        gContactsArchiving = True
                        gOutlookArchiving = True : LL = 108
                        gExchangeArchiving = True : LL = 109
                        ArchiveALL = True : LL = 110
                        gRunMinimized = True : LL = 111
                        gRunUnattended = True : LL = 112
                        'ArchiveALLToolStripMenuItem_Click(Nothing, Nothing) : LL = 113
                    Else
                        If Arg.ToUpper.Equals("C") Then
                            ArgsPassedIn = True
                            gContentArchiving = False : LL = 116
                            gContactsArchiving = False
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute CONTENT archives.") : LL = 117
                            'Execute archive and close app : LL = 118
                            ContentOnly = True : LL = 119
                            gRunMinimized = True : LL = 120
                            gRunUnattended = True : LL = 121
                            gContentArchiving = True : LL = 122
                            gContactsArchiving = True
                            gOutlookArchiving = False : LL = 123
                            gExchangeArchiving = False : LL = 124
                        End If : LL = 125
                        If Arg.ToUpper.Equals("O") Then
                            ArgsPassedIn = True
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute OUTLOOK archives.") : LL = 127
                            'Execute outlook and close app : LL = 128
                            gOutlookArchiving = False : LL = 129
                            ExchangeOnly = True : LL = 130
                            gRunMinimized = True : LL = 131
                            gRunUnattended = True : LL = 132
                            gContentArchiving = False : LL = 133
                            gContactsArchiving = False
                            gOutlookArchiving = True : LL = 134
                            gExchangeArchiving = False : LL = 135
                        End If : LL = 136
                        If Arg.ToUpper.Equals("E") Then
                            ArgsPassedIn = True
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute EXCHANGE archives.") : LL = 138
                            'Execute Exchange and close app : LL = 139
                            gExchangeArchiving = False : LL = 140
                            OutlookOnly = True : LL = 141
                            gRunMinimized = True : LL = 142
                            gRunUnattended = True : LL = 143
                            gContentArchiving = False : LL = 144
                            gContactsArchiving = False
                            gOutlookArchiving = False : LL = 145
                            gExchangeArchiving = True : LL = 146
                        End If : LL = 147
                    End If : LL = 148
                    LL = 149
                    If Arg.ToUpper.Equals("?") Then
                        Dim MSG As String = "" : LL = 151
                        MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + vbCrLf + vbCrLf : LL = 152
                        MSG = MSG + "CompanyID;RepoID" + vbCrLf + vbCrLf : LL = 153
                        MSG = MSG + "X = Execute archive and close." + vbCrLf + vbCrLf : LL = 153
                        MSG = MSG + "C = Archive CONTENT only." + vbCrLf + vbCrLf : LL = 154
                        MSG = MSG + "O = Archive OUTLOOK only." + vbCrLf + vbCrLf : LL = 155
                        MSG = MSG + "E = Archive EXCHANGE Servers only." + vbCrLf + vbCrLf : LL = 156
                        MSG = MSG + "A = Archive ALL." + vbCrLf + vbCrLf : LL = 157
                        MSG = MSG + "To Execute:" + vbCrLf : LL = 158
                        MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + vbCrLf : LL = 159
                        MSG = MSG + "(E.G.) C:\dev\ECM\EcmLibSvc\EcmLibSvc\bin\Debug\EcmArchiveSetup.exe Q" + vbCrLf : LL = 160
                        MessageBox.Show(MSG) : LL = 161
                        End : LL = 162
                    End If : LL = 163
                Next
            Else
                ArgsPassedIn = False
            End If : LL = 165.01

            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "50")
            updateMessageBar("2 of 18")

            gCurrentConnectionString = "" : LL = 166.1
            Try
                CompanyID = REG.ReadEcmRegistrySubKey("CompanyID") : LL = 167.2
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 03 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                CompanyID = "" : LL = 167.21
            End Try
            Try
                RepoID = REG.ReadEcmRegistrySubKey("RepoID") : LL = 168.3
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 04 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                RepoID = "" : LL = 168.31
            End Try

            'gCurrentConnectionString = REG.ReadEcmRegistrySubKey("EncConnectionString")
            If CompanyID Is Nothing Then : LL = 168.31
                CompanyID = gCustomerID : LL = 168.32
            End If
            If RepoID Is Nothing Then : LL = 168.33
                RepoID = gRepoID
            End If
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "60")
            If gCustomerID.Trim.Length > 0 And gRepoID.Trim.Length > 0 Then
                LL = 165.4
                'Dim ProxyGateway As New SVCGateway.Service1Client : LL = 165.5
                Dim EncCS As String = ""
                Dim RC As Boolean = False
                Dim RetMsg As String = "" : LL = 165.6

                'If (ProxyGateway Is Nothing) Then
                '    ProxyGateway = New SVCGateway.Service1Client
                'End If
                EncCS = DBARCH.setConnStr() : LL = 165.7

                If EncCS.Trim.Length > 0 Then
                    LL = 165.7

                    gCurrentConnectionString = ENC.AES256DecryptString(EncCS) : LL = 165.8

                    If gCurrentConnectionString.Length > 0 Then
                        Dim bReg As Boolean = REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS) : LL = 165.9
                        If Not bReg Then : LL = 165.1
                            bReg = REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS) : LL = 165.11
                        End If : LL = 165.12
                    End If
                Else
                    LL = 165.13
                    gCurrentConnectionString = ""
                    LL = 165.14
                End If
                LL = 165.15
                'ProxyGateway = Nothing
                bUseAttachData = True
                LL = 165.16
            Else : LL = 165.17
                bUseAttachData = False
                LL = 165.18
            End If
            LL = 165.19
            'bUseAttachData = ISO.ReadAttachData(CompanyID, RepoID)
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "70")
            Dim defaultUserId As String = My.Settings.DefaultLoginID : LL = 165.2
            If defaultUserId.Trim.Length > 0 Then : LL = 165.3
                CurrentLoginID = defaultUserId : LL = 165.4
                Dim EPW As String = My.Settings.DefaultLoginPW : LL = 165.5
                EPW = ENC.AES256DecryptString(EPW) : LL = 165.6
            End If : LL = 165.7

            updateMessageBar("3 of 18")

            Dim bDbConnectionGood = DBARCH.ckDbConnection("frmMain 100") : LL = 200.1

            If bDbConnectionGood = False Then : LL = 201.2
                If gRunUnattended = True Then : LL = 202.1
                    LOG.WriteToArchiveLog("ABORTING frmReconMain_Load run - Failed to connect to the database, closing ECM.") : LL = 203.1
                    Application.Exit()
                Else : LL = 204.1
                    Dim ConnStr As String = DBARCH.getRepoConnStr()
                    MessageBox.Show("ABORTING - Failed to connect to the database, contact an administrator - closing ECM." + vbCrLf + ConnStr) : LL = 205.1
                    Application.Exit()
                End If
                tsTunnelConn.Text = "Tunnel:OFF"
            Else
                tsTunnelConn.Text = "Tunnel:ON"
            End If : LL = 213.15
            Dim strGateWayID As String = gGateWayID.ToString
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "80")
            updateMessageBar("4 of 18")
            'If (ProxyArchive Is Nothing) Then
            '    gResetEndpoints = True
            '    Dim retc As Boolean = setGatewayEndpoints() : LL = 213.16
            'End If
            LL = 213.17

            If (gLoginValidated = False) Then
                gLoginValidated = DBARCH.ckDbConnection("XX001")
            End If

            LL = 213.2
            If gLoginValidated Then
                LL = 213.3
                tsServiceDBConnState.Text = "SaaS:ON"
            Else
                LL = 213.4
                tsServiceDBConnState.Text = "SaaS:OFF"
                MessageBox.Show("Could not attach - closing the application: " + strGateWayID.ToString + " : " + CurrentLoginID.ToString + " : " + MachineIDcurr.ToString)
                Application.Exit()
            End If
            LL = 213.5
            ImpersonateLoginToolStripMenuItem.Visible = False

            Dim iRunningInstances As Integer = 0 : LL = 213.6
            iRunningInstances = UTIL.countApplicationInstances("ECMARCHIVESETUP") : LL = 213.7
            If iRunningInstances > 2 Then : LL = 213.8
                frmMsg.txtMsg.Text = "ECM Archiver already running - closing." : LL = 213.9
                frmMsg.Show()
                Thread.Sleep(10000)
                End
            End If
            LL = 213.11
            updateMessageBar("5 of 18")
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "90")
            Dim PrevArchiverExecPath As String = ""
            Try
                REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath) : LL = 7.11
                PrevArchiverExecPath = REG.ReadEcmRegistrySubKey("EcmArchiverDir") : LL = 7.12
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 4 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)

                REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath) : LL = 9.1
            End Try
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "100")
            If PrevArchiverExecPath.Length = 0 Then : LL = 8
                REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath) : LL = 9.2
            End If : LL = 10
            Dim CurrAppExecPath As String = Application.ExecutablePath : LL = 11
            Dim CurrBuildDate As String = "" : LL = 13
            Dim fApp As New FileInfo(CurrAppExecPath) : LL = 14
            CurrBuildDate = fApp.CreationTime.ToString : LL = 15
            fApp = Nothing : LL = 16
            Dim CurrBuildID As String = System.Configuration.ConfigurationManager.AppSettings("ArchiverBuildID") : LL = 18
            Dim PrevArchiverBuildID As String = REG.ReadEcmRegistrySubKey("EcmArchiverBuildID") : LL = 19
            If PrevArchiverBuildID = Nothing Then : LL = 20
                REG.CreateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID) : LL = 21
            End If : LL = 22
            LL = 23
            Dim PrevArchiverBuildDate As String = REG.ReadEcmRegistrySubKey("EcmSetupAppCreateDate") : LL = 24
            If PrevArchiverBuildDate.Trim.Length = 0 Then : LL = 25
                REG.CreateEcmRegistrySubKey("EcmSetupAppCreateDate", CurrBuildDate.ToString) : LL = 26
            End If : LL = 27
            LL = 28
            If Not CurrBuildDate.Equals(PrevArchiverBuildDate) Then : LL = 29
                '** Resync all scheduled archive jobs to point to the new path. : LL = 30
                Console.WriteLine("Resync archive jobs.") : LL = 31
                frmSchedule.ValidateExecPath() : LL = 32
            End If : LL = 33
            If Not PrevArchiverExecPath.Equals(Application.ExecutablePath) Then : LL = 34
                '** Resync all scheduled archive jobs to point to the new path. : LL = 35
                Console.WriteLine("Resync archive jobs.") : LL = 36
                frmSchedule.ValidateExecPath() : LL = 37
            End If : LL = 38
            LL = 39
            If Not CurrBuildID.Equals(PrevArchiverBuildID) Then : LL = 40
                '** Resync all scheduled archive jobs to point to the new path. : LL = 41
                Console.WriteLine("Resync archive jobs.") : LL = 42
                frmSchedule.ValidateExecPath() : LL = 43
                REG.UpdateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID) : LL = 44
            End If : LL = 45
            LL = 46
            gContentArchiving = False : LL = 47
            gOutlookArchiving = False : LL = 48
            gExchangeArchiving = False : LL = 49
            gContactsArchiving = False
            LL = 50
            REG.CreateEcmSubKey() : LL = 51
            REG.SetEcmSubKey() : LL = 52
            Console.WriteLine(REG.ReadEcmSubKey("")) : LL = 53
            TimerEndRun.Enabled = False : LL = 54
            'Timer1.Enabled = False : LL = 55
            TimerUploadFiles.Enabled = False : LL = 56
            TimerListeners.Enabled = False : LL = 57
            LL = 58
            Dim B As Boolean = False : LL = 59
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "110")
            If gRunMode = "X" Then : LL = 167
                Me.WindowState = FormWindowState.Minimized : LL = 168
            End If : LL = 169

            updateMessageBar("6 of 18")

            Try : LL = 171
                If My.Settings("UpgradeSettings") = True Then : LL = 172
                    Try : LL = 173
                        LOG.WriteToArchiveLog("**********************************************") : LL = 174
                        LOG.WriteToArchiveLog("NOTICE frmMain: New INSTALL detected 100") : LL = 174
                        My.Settings.Upgrade() : LL = 175
                        My.Settings.Reload() : LL = 176
                        My.Settings("UpgradeSettings") = False : LL = 177
                        My.Settings.Save() : LL = 178
                        LOG.WriteToInstallLog("NOTICE: New INSTALL detected 200: " + My.Settings("UserDefaultConnString")) : LL = 179
                        LOG.WriteToInstallLog("NOTICE: New INSTALL detected 300: " + My.Settings("UserThesaurusConnString")) : LL = 180
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 5 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch ex As Exception : LL = 181
                        Dim st As New StackTrace(True)
                        st = New StackTrace(ex, True)
                        LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                        LOG.WriteToInstallLog("ERROR: INSTALL 100: " + ex.Message) : LL = 182
                    End Try : LL = 183
                Else : LL = 184
                    LOG.WriteToInstallLog("NOTICE: NO New INSTALL 100-A") : LL = 185
                End If : LL = 186
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 6 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception : LL = 187
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                Console.WriteLine("ERROR 1XA1: - " + ex.Message) : LL = 188
            End Try : LL = 189
            LL = 190
            My.Settings("UpgradeSettings") = False : LL = 191
            My.Settings.Save() : LL = 192
            Dim strUseRemoteServer As String = System.Configuration.ConfigurationManager.AppSettings("UseRemoteServer") : LL = 193

            If strUseRemoteServer.Equals("1") Then : LL = 194
                gCurrThesaurusCS = DBARCH.getThesaurusConnStr : LL = 195
                gCurrRepositoryCS = DBARCH.getRepoConnStr() : LL = 196
            Else
                gCurrThesaurusCS = REG.ReadEcmCurrentConnectionString("TheasaurusCS") : LL = 197
                gCurrRepositoryCS = REG.ReadEcmCurrentConnectionString("RepositoryCS") : LL = 198
            End If

            LL = 199

            updateMessageBar("7 of 18")
            B = DBARCH.ckDbConnection("frmMain 100") : LL = 200
            If B = False Then : LL = 201
                If gRunUnattended = True Then : LL = 202
                    LOG.WriteToArchiveLog("ABORTING - Failed to connect to the database, closing ECM.") : LL = 203
                    Application.Exit()
                Else : LL = 204
                    MessageBox.Show("ABORTING - Failed to connect to the database, closing ECM.") : LL = 205
                    Application.Exit()
                End If : LL = 212
            End If : LL = 213
            LL = 214
            '************************ : LL = 215
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "120")
            SetDateFormats() : LL = 216
            '************************ : LL = 217
            LL = 218
            Dim bLicenseExists As Boolean = DBARCH.LicenseExists : LL = 219
            If bLicenseExists = False Then : LL = 220
                Dim msg As String = "ABORTING - A license for the product does not exist - contact an administrator. "
                MessageBox.Show(msg)
                Application.Exit()
            End If : LL = 223
            LL = 224

            updateMessageBar("8 of 18")
            LL = 226
            ListenersDefined = DBARCH.isListeningOn : LL = 227
            LL = 228
            Dim sDebug As String = DBARCH.getUserParm("debug_SetupScreen") : LL = 229

            LL = 237
            Dim ImpersonateID As String = ""
            Dim bImpersonateID As Boolean = UTIL.isImpersonationSet(ImpersonateID)
            If bImpersonateID Then
                gCurrLoginID = ImpersonateID
                CurrentLoginID = ImpersonateID
                CurrUserGuidID = DBARCH.getUserGuidByLoginID(ImpersonateID)
                LogIntoSystem(CurrentLoginID) : LL = 238
                gCurrLoginID = CurrentLoginID
            Else
                LogIntoSystem(gCurrLoginID) : LL = 238
            End If
            ckLicense() : LL = 240

            CurrentLoginID = LoginForm1.txtLoginID.Text
            gCurrLoginID = CurrentLoginID

            CurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID) : LL = 279
            gCurrUserGuidID = CurrUserGuidID
            UIDcurr = CurrUserGuidID
            If CurrUserGuidID.Length = 0 Then
                '** This can be caused by IMPERSONATION using an unidentified user id.
                '** Start by removing impersonation.
                Dim msg As String = "The USER ID currently in use, '" + gCurrUserGuidID + "', is not identified to the database, please contact an administrator. Exiting the program."
                MessageBox.Show(msg)
                Return : LL = 243
            End If : LL = 244
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "130")
            formloaded = True : LL = 246
            GetLocation(Me) : LL = 247
            formloaded = False : LL = 248
            isAdmin = DBARCH.isAdmin(CurrUserGuidID) : LL = 250
            If HelpOn Then : LL = 252
                DBARCH.getFormTooltips(Me, TT, True) : LL = 253
                TT.Active = True : LL = 254
                bHelpLoaded = True : LL = 255
            Else : LL = 256
                TT.Active = False : LL = 257
            End If : LL = 258
            LL = 259

            TT.SetToolTip(ckPublic, "Check this item to set all contents of the selected directory to PUBLIC access.") : LL = 263
            TT.SetToolTip(btnDeleteEmailEntry, "Press to remove the selected archive mail folder.") : LL = 264
            TT.SetToolTip(btnRefreshFolders, "Press to show all of your available mail folders.") : LL = 265
            TT.SetToolTip(btnActive, "Press to how only the folders you have selected for archive.") : LL = 266
            TT.SetToolTip(ckDisable, "Check to disable automatic archiving.") : LL = 267
            TT.SetToolTip(btnAddFiletype, "Add the new file type to those available.") : LL = 268
            TT.SetToolTip(ckRemoveFileType, "Remove the selected file type from those available.") : LL = 269

            If HelpOn Then : LL = 271
                TT.Active = True : LL = 272
            Else : LL = 273
                TT.Active = False : LL = 274
            End If : LL = 275

            If CurrUserGuidID.Length = 0 Then : LL = 277
                CurrentLoginID = System.Environment.UserName : LL = 278
                CurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID) : LL = 279
            End If : LL = 280

            If isAdmin = True Then : LL = 282
                clAdminDir.Enabled = True : LL = 283
                ckSystemFolder.Enabled = True : LL = 284
            Else : LL = 285
                clAdminDir.Enabled = False : LL = 286
                ckSystemFolder.Enabled = False : LL = 287
            End If : LL = 288
            clAdminDir.Visible = True : LL = 289

            formloaded = False
            LL = 290
            Dim TgtFolder As String = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            Dim bOutlook As Boolean = UTIL.isOutLookRunning
            LL = 291
            If bOutlook = True Then
                frmOutlookNotice.Show()
            End If
            LL = 292
            setMsgHeader("Fetching outlook folder names.")
            LL = 293
            ARCH.OutlookFolderNames(TgtFolder)
            LL = 294
            isOutlookAvail = ARCH.getCurrentOutlookFolders(TgtFolder, CF)
            LL = 295
            ARCH.setChildFoldersList(CF)
            LL = 296
            frmOutlookNotice.Close()
            LL = 297
            frmOutlookNotice.Hide()
            LL = 298
            ARCH.HistoryFolderExists()
            LL = 299

            '** UPDATE THE CURRENT FOLDERS TO CONTAIN THE FOLDERID'S : LL = 331
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "140")
            updateMessageBar("9 of 18")

            Dim SS As String : LL = 332
            For Each SS In CF.Keys : LL = 333
                Dim CurrName As String = SS.ToString : LL = 334
                Dim iKey As Integer = CF.IndexOfKey(CurrName) : LL = 336
                Dim CurrKey As String = CF.Item(CurrName) : LL = 337
                Dim MySql As String = "" : LL = 339
                CurrName = UTIL.RemoveSingleQuotes(CurrName) : LL = 340
                ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder) : LL = 341
                MySql = "update EmailFolder set FolderID = '" + CurrKey + "' where FolderName = '" + CurrName + "' and ParentFolderName  = '" + ParentFolder + "' " : LL = 342
                Dim B1 As Boolean = DBARCH.ExecuteSqlNewConn(MySql, False) : LL = 343
                If Not B1 Then : LL = 344
                    If ddebug Then LOG.WriteToArchiveLog("NOTICE frmMain:Load process 5X.1 unsuccessful.") : LL = 345
                End If : LL = 346
            Next : LL = 347
            'End If : LL = 348
            LL = 349
            CurrIdentity = DBARCH.getUserLoginByUserid(CurrUserGuidID) : LL = 350
            If CurrIdentity.Trim.Length = 0 Then : LL = 351
                Return : LL = 352
            End If : LL = 353
            'SB.Text = "Current User: " + System.Environment.UserName : LL = 354
            SB.Text = "Current User: " + CurrIdentity : LL = 355
            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 5 successful.") : LL = 356
            Try : LL = 357
                setMsgHeader("Setting process memory, just a moment.") : LL = 358
                ARCH.DeleteOutlookMessages(CurrUserGuidID) : LL = 359
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception : LL = 360
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                LOG.WriteToArchiveLog("WARNING 2005.32.22 - call DeleteOutlookMessages failed.") : LL = 361
            End Try : LL = 362
            LL = 363
            setMsgHeader("Initializing archive parameters, this could take a few seconds.") : LL = 364
            ckInitialData() : LL = 365

            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "150")
            DBARCH.LoadAvailFileTypes(cbFileTypes) : LL = 367
            DBARCH.LoadAvailFileTypes(cbPocessType) : LL = 368
            DBARCH.LoadAvailFileTypes(cbAsType) : LL = 369
            DBARCH.LoadAvailFileTypes(lbAvailExts) : LL = 370

            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 6 successful.") : LL = 372
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "160")
            DBARCH.LoadRetentionCodes(cbRetention) : LL = 374
            DBARCH.LoadRetentionCodes(cbRssRetention)
            DBARCH.LoadRetentionCodes(cbWebPageRetention)
            DBARCH.LoadRetentionCodes(cbWebSiteRetention)
            DBARCH.LoadRetentionCodes(cbEmailRetention) : LL = 375

            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "170")
            Dim IMax As Integer = 0 : LL = 377
            ARCH.getOutlookParentFolderNames(Me.cbParentFolders) : LL = 378
            If cbParentFolders.Items.Count > 0 Then : LL = 379
                IMax = cbParentFolders.Items.Count - 1 : LL = 380
                ParentFolder = cbParentFolders.Items(IMax).ToString : LL = 381
            Else : LL = 382
                ParentFolder = "Unknown" : LL = 383
            End If

            DBARCH.GetActiveEmailFolders(ParentFolder, lbActiveFolder, CurrUserGuidID, CF, ArchivedEmailFolders) : LL = 386
            DBARCH.GetActiveDatabases(cbEmailDB) : LL = 388
            DBARCH.GetActiveDatabases(cbFileDB) : LL = 389

            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 7 successful.") : LL = 391

            DBARCH.GetDirectories(lbArchiveDirs, CurrUserGuidID, False) : LL = 393
            LL = 394

            updateMessageBar("10 of 18")

            GetExecParms() : LL = 395
            LL = 396
            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 8a successful.") : LL = 397
            LL = 398
            DBARCH.GetProcessAsList(cbProcessAsList) : LL = 399
            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 8b successful.") : LL = 400
            DBARCH.getExcludedEmails(CurrUserGuidID) : LL = 401
            LL = 402
            Dim tVal As String = DBARCH.UserParmRetrive("ckUseLastProcessDateAsCutoff", CurrUserGuidID) : LL = 403
            If tVal.ToUpper.Equals("TRUE") Then : LL = 404
                ckUseLastProcessDateAsCutoff.Checked = True : LL = 405
            Else : LL = 406
                ckUseLastProcessDateAsCutoff.Checked = False : LL = 407
            End If : LL = 408
            tVal = DBARCH.UserParmRetrive("ckArchiveBit", CurrUserGuidID) : LL = 409
            If tVal.ToUpper.Equals("TRUE") Then : LL = 410
                ckArchiveBit.Checked = True : LL = 411
            Else : LL = 412
                ckArchiveBit.Checked = False : LL = 413
            End If : LL = 414
            LL = 415
            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 9 successful.") : LL = 416
            LL = 417
            Dim S As String = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] " ' where ProfileName = 'XX'" : LL = 418
            DBARCH.PopulateComboBox(cbProfile, "ProfileName", S) : LL = 419
            LL = 420
            If Not isOutlookAvail Then : LL = 421
                ckDisableOutlookEmailArchive.Checked = True : LL = 422
                SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL." : LL = 426
            End If : LL = 424
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "180")
            Dim T As New Thread(AddressOf GetRidOfOldMessages) : LL = 429
            T.IsBackground = True : LL = 430
            T.Priority = ThreadPriority.Lowest : LL = 431
            T.TrySetApartmentState(ApartmentState.STA) : LL = 432
            T.Start() : LL = 433
            LL = 434
            formloaded = True : LL = 435
            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 10 successful.") : LL = 436
            LL = 437
            If cbParentFolders.Items.Count > 0 Then : LL = 438
                cbParentFolders.Text = cbParentFolders.Items(cbParentFolders.Items.Count - 1) : LL = 439
                btnActive_Click(Nothing, Nothing) : LL = 440
            End If : LL = 441

            updateMessageBar("11 of 18")

            If gIsServiceManager = True Then : LL = 444
                gbPolling.Enabled = True : LL = 445
                ckUseLastProcessDateAsCutoff.Enabled = True : LL = 446
                btnRefreshFolders.Enabled = True : LL = 447
                btnActive.Enabled = True : LL = 448
                cbParentFolders.Enabled = True : LL = 450
                lbActiveFolder.Enabled = True : LL = 451
                ckArchiveFolder.Enabled = True : LL = 452
                ckArchiveRead.Enabled = True : LL = 453
                ckRemoveAfterXDays.Enabled = True : LL = 454
                NumericUpDown3.Enabled = True : LL = 455
                ckSystemFolder.Enabled = True : LL = 456
                cbEmailRetention.Enabled = True : LL = 457
                btnSaveConditions.Enabled = True : LL = 458
                btnDeleteEmailEntry.Enabled = True : LL = 459
                OutlookEmailsToolStripMenuItem.Enabled = True : LL = 460
                ExchangeEmailsToolStripMenuItem.Enabled = True : LL = 461
                ContentToolStripMenuItem.Enabled = True : LL = 462
                ArchiveALLToolStripMenuItem.Enabled = True : LL = 463
                ckArchiveBit.Enabled = True : LL = 464
                CkMonitor.Enabled = True : LL = 465
                TT.SetToolTip(CkMonitor, "Not an available selection for the Service Manager.") : LL = 466
            Else : LL = 467
                TT.SetToolTip(CkMonitor, "Track changes to this directory instantly.") : LL = 468
            End If : LL = 469

            LOG.WriteToTimerLog("MDIMAIN 01", "isOfficeInstalled01", "START") : LL = 471
            gOfficeInstalled = UTIL.isOfficeInstalled : LL = 472
            gOffice2007Installed = UTIL.isOffice2007Installed : LL = 473
            LOG.WriteToTimerLog("MDIMAIN 01", "isOfficeInstalled01", "END", Now) : LL = 474

            If gOfficeInstalled = False Then : LL = 476
                SB.Text = "MS Office appears not to be installed." : LL = 477
            End If : LL = 478
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "190")
            If gOffice2007Installed = False Then : LL = 479
                'ckOcr.Enabled = False : LL = 480
                TT.SetToolTip(ckOcr, "Only available when Office 2007 is installed.") : LL = 481
                TT.SetToolTip(ckMetaData, "Only available when Office 2007 is installed.") : LL = 483
                TT.SetToolTip(ckOcrPdf, "Only available when Office 2007 is installed.") : LL = 483
                ckMetaData.Enabled = False : LL = 482
                'ckOcr.Enabled = False : LL = 482
                'ckOcrPdf.Enabled = False : LL = 482
            End If : LL = 484

            If DBARCH.isPublicAllowed = False Then : LL = 486
                Me.ckPublic.Visible = False : LL = 487
            Else : LL = 488
                Me.ckPublic.Visible = True : LL = 489
            End If : LL = 490
            btnInclFileType.Visible = False : LL = 492
            btnExclude.Visible = False : LL = 493
            S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]" : LL = 495
            DBARCH.PopulateComboBox(Me.cbDirProfile, "ProfileName", S) : LL = 496
            lbActiveFolder.Items.Clear() : LL = 498
            LL = 499
            If isAdmin = False Then : LL = 500
                btnSaveDirProfile.Enabled = False : LL = 501
                btnUpdateDirectoryProfile.Enabled = False : LL = 502
                btnDeleteDirProfile.Enabled = False : LL = 503
                ckArchiveBit.Enabled = False : LL = 504
            End If : LL = 505
            If ddebug Then LOG.WriteToArchiveLog("frmMain:Load process 11 successful.") : LL = 506

            CloseMsgHeader() : LL = 508
            SetUnattendedFlag() : LL = 509
            SetUnattendedCheckBox() : LL = 510
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "200")
            ckPauseListener.Checked = False : LL = 512

            updateMessageBar("12 of 18")

            Dim NbrListeners As Integer = LISTEN.LoadListeners(MachineName) : LL = 514

            updateMessageBar("13 of 18")
            If NbrListeners > 0 Then : LL = 516
                TimerUploadFiles.Enabled = True : LL = 517
                TimerListeners.Enabled = True : LL = 518
            Else : LL = 519
                TimerUploadFiles.Enabled = False : LL = 520
                TimerListeners.Enabled = False : LL = 521
            End If : LL = 522

            If gRunMinimized Then : LL = 524
                Me.WindowState = FormWindowState.Minimized : LL = 525
            End If : LL = 526

            If gRunMode = "X" Then : LL = 528
                TimerEndRun.Enabled = False : LL = 530
                TimerUploadFiles.Enabled = False : LL = 532
                TimerListeners.Enabled = False : LL = 533

                If ArchiveALL = True Then : LL = 535
                    ArchiveALLToolStripMenuItem_Click(Nothing, Nothing) : LL = 536
                Else : LL = 537
                    If ContentOnly = True Then : LL = 538
                        ContentToolStripMenuItem_Click(Nothing, Nothing) : LL = 539
                    End If : LL = 540
                    If OutlookOnly = True Then : LL = 541
                        OutlookEmailsToolStripMenuItem_Click(Nothing, Nothing) : LL = 542
                    End If : LL = 543
                    If ExchangeOnly = True Then : LL = 544
                        ExchangeEmailsToolStripMenuItem_Click(Nothing, Nothing) : LL = 545
                    End If : LL = 546
                End If : LL = 547
            Else : LL = 548
                TimerEndRun.Enabled = False : LL = 549
                TimerUploadFiles.Enabled = False : LL = 551
                TimerListeners.Enabled = True : LL = 552
            End If : LL = 553

            tssUser.Text = CurrUserGuidID : LL = 555
            tssAuth.Text = DBARCH.getAuthority(CurrUserGuidID) : LL = 556
            SetVersionAndServer() : LL = 557
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "210")
            If ArgsPassedIn And (gContactsArchiving Or gContentArchiving Or gOutlookArchiving Or gExchangeArchiving) Then : LL = 559
                Dim StatusBarMsg As String = ""
                If gExchangeArchiving Then
                    StatusBarMsg += " - Exchange - archiving"
                Else
                    StatusBarMsg += " - Exchange - complete"
                End If
                If gOutlookArchiving Then
                    StatusBarMsg += " - Outlook - archiving"
                Else
                    StatusBarMsg += " - Outlook - complete"
                End If
                If gContentArchiving Then
                    StatusBarMsg += " - Content - archiving"
                Else
                    StatusBarMsg += " - Content - complete"
                End If
                If gContactsArchiving Then
                    StatusBarMsg += " - Contacts - archiving"
                Else
                    StatusBarMsg += " - Contacts - complete"
                End If
                LOG.WriteToArchiveLog("INFO: Auto-archive timer started - " + Now.ToString) : LL = 560
                gRunMinimized = True : LL = 561
                gRunUnattended = True : LL = 562
                Me.WindowState = FormWindowState.Minimized : LL = 563
                Dim II As Integer = 0 : LL = 564
                Do While gContentArchiving Or gOutlookArchiving Or gExchangeArchiving Or gContentArchiving
                    II += 1 : LL = 566
                    Application.DoEvents() : LL = 567
                    Thread.Sleep(1000) : LL = 568
                    tbExchange.Text = "Archive running: " + Now.ToString + " / " + II.ToString
                    If gExchangeArchiving Then
                        StatusBarMsg += " - Exchange - archiving"
                    Else
                        StatusBarMsg += " - Exchange - complete"
                    End If
                    If gOutlookArchiving Then
                        StatusBarMsg += " - Outlook - archiving"
                    Else
                        StatusBarMsg += " - Outlook - complete"
                    End If
                    If gContentArchiving Then
                        StatusBarMsg += " - Content - archiving"
                    Else
                        StatusBarMsg += " - Content - complete"
                    End If
                    If gContactsArchiving Then
                        StatusBarMsg += " - Contacts - archiving"
                    Else
                        StatusBarMsg += " - Contacts - complete"
                    End If
                    Me.Refresh() : LL = 572
                Loop : LL = 573
                LOG.WriteToArchiveLog("INFO: Auto-archive execution ended - " + Now.ToString) : LL = 574
                LOG.WriteToArchiveLog("*****************************************************") : LL = 575
                'Application.Exit() : LL = 576
                End : LL = 577
            End If : LL = 578

            'If ArgsPassedIn Then
            '    Application.Exit()
            'End If

            updateMessageBar("14 of 18")
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "220")
            formloaded = False
            Dim iHours As Integer = My.Settings("BackupIntervalHours")
            If iHours > 0 Then
                nbrArchiveHours.Value = iHours
            End If
            formloaded = True

            'If isAdmin Then
            '    asyncVerifyRetainDates_DoWork(Nothing, Nothing)
            'End If
            If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9901, "Main", "230")
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            Dim sMsg As String = "ERROR frmReconMain_Load 01: " & LL & vbCrLf & ex.Message
            LOG.WriteToArchiveLog(sMsg)
            Clipboard.Clear()
            Clipboard.SetText(ex.Message)
            MessageBox.Show("ERROR frmReconMain_Load 01 check the logs: " + LL.ToString + vbCrLf + ex.Message)
        End Try

        If DBARCH.isAdmin(CurrUserGuidID) Then
            ImpersonateLoginToolStripMenuItem.Visible = True
            ckDeleteAfterArchive.Enabled = True
        Else
            ImpersonateLoginToolStripMenuItem.Visible = False
            ckDeleteAfterArchive.Enabled = False
        End If

        tssUser.Text = CurrUserGuidID : LL = 555
        tssAuth.Text = DBARCH.getAuthority(CurrUserGuidID) : LL = 556

        SetVersionAndServer()

        gCurrUserGuidID = CurrUserGuidID
        UIDcurr = CurrUserGuidID

        tsCurrentRepoID.Text = "Repo: " + RepoID
        '** CheckForShortcut()

        If Not isAdmin Then
            ReOcrALLGraphicFilesToolStripMenuItem1.Visible = False
        End If

        '** Add this in 10.05.2011
        If My.Settings.GatewayConnString.Equals("?") Then
            'Dim CSS As String = Proxy.
            'My.Settings.GatewayConnString = CSS
            'My.Settings.Save()
        End If
        '** Add this in 10.05.2011
        If My.Settings.UserDefaultConnString.Equals("?") Then
            'Dim CSS As String = Proxy.
            'My.Settings.UserDefaultConnString = CSS
            'My.Settings.Save()
        End If

        updateMessageBar("15 of 18")
        GetRSS(gGateWayID)

        updateMessageBar("16 of 18")
        GetWebPage(gGateWayID)

        updateMessageBar("17 of 18")
        GetWebSite(gGateWayID)
        updateMessageBar("18 of 18")

        LoginForm1.Hide()

        Label37.Visible = True
        Label39.Visible = True

        TimerAutoExec.Enabled = False
        If Not ckDisable.Checked And Not ckDisableContentArchive.Checked And gAutoExec.Equals(True) Then
            SB2.Text = "LAUNCHING ContentThread"
            ContentThread.RunWorkerAsync()
            'ContentToolStripMenuItem_Click(Nothing, Nothing)
            TimerAutoExec.Enabled = True
        Else
            gAutoExecContentComplete = True
        End If
        If ckDisableContentArchive.Checked Then
            gAutoExecContentComplete = True
        End If
        If Not ckDisable.Checked And Not ckDisableOutlookEmailArchive.Checked And gAutoExec.Equals(True) Then
            OutlookEmailsToolStripMenuItem_Click(Nothing, Nothing)
            TimerAutoExec.Enabled = True
        Else
            gAutoExecEmailComplete = True
        End If
        If ckDisableOutlookEmailArchive.Checked Then
            gAutoExecEmailComplete = True
        End If

        If Not ckDisable.Checked And Not ckDisableExchange.Checked And gAutoExec.Equals(True) Then
            ExchangeEmailsToolStripMenuItem_Click(Nothing, Nothing)
            TimerAutoExec.Enabled = True
        Else
            gAutoExecExchangeComplete = True
        End If
        If ckDisableExchange.Checked Then
            gAutoExecExchangeComplete = True
        End If
        If Not ckDisable.Checked And Not ckRssPullDisabled.Checked And gAutoExec.Equals(True) Then
            'ignore for now
        End If
        If Not ckDisable.Checked And Not ckWebPageTrackerDisabled.Checked And gAutoExec.Equals(True) Then
            'ignore for now
        End If
        If Not ckDisable.Checked And Not ckWebSiteTrackerDisabled.Checked And gAutoExec.Equals(True) Then
            'ignore for now
        End If

    End Sub

    Sub updateMessageBar(strText As String)
        Dim b As Boolean = False
        Try
            frmMessageBar.lblCnt.Text = strText
            If (b = True) Then
                MessageBox.Show(strText)
            End If
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
    End Sub

    Sub GetRidOfOldMessages()

        ARCH.CreateEcmHistoryFolder()
        Try
            ARCH.DeleteOutlookMessages(gCurrUserGuidID)
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("WARNING 2005.32.21 - call DeleteOutlookMessages failed.")
        End Try
    End Sub

    Sub ckInitialData()
        AddInitialDB()
        'wdm()
        'Dim BB As Boolean = DBARCH.ckUserExists(gCurrUserGuidID)
        ''gCurrUserGuidID = gCurrUserGuidID
        'If Not BB Then
        '    RUSER.setUserid(gCurrUserGuidID)
        '    RUSER.Insert()
        '    AddInitialEmailFolder("Inbox")
        '    AddInitialEmailFolder("Sentmail")
        'End If

        Dim BB = DBARCH.ckFileExtExists()
        If Not BB Then
            AVL.setExtcode(".ascx")
            AVL.Insert()
            AVL.setExtcode(".asm")
            AVL.Insert()
            AVL.setExtcode(".asp")
            AVL.Insert()
            AVL.setExtcode(".aspx")
            AVL.Insert()
            AVL.setExtcode(".bat")
            AVL.Insert()
            AVL.setExtcode(".c")
            AVL.Insert()
            AVL.setExtcode(".CMD")
            AVL.Insert()
            AVL.setExtcode(".cpp")
            AVL.Insert()
            AVL.setExtcode(".cxx")
            AVL.Insert()
            AVL.setExtcode(".def")
            AVL.Insert()
            AVL.setExtcode(".dic")
            AVL.Insert()
            AVL.setExtcode(".doc")
            AVL.Insert()
            AVL.setExtcode(".docx")
            AVL.Insert()
            AVL.setExtcode(".dot")
            AVL.Insert()
            AVL.setExtcode(".h")
            AVL.Insert()
            AVL.setExtcode(".hhc")
            AVL.Insert()
            AVL.setExtcode(".hpp")
            AVL.Insert()
            AVL.setExtcode(".htm")
            AVL.Insert()
            AVL.setExtcode(".html")
            AVL.Insert()
            AVL.setExtcode(".htw")
            AVL.Insert()
            AVL.setExtcode(".htx")
            AVL.Insert()
            AVL.setExtcode(".hxx")
            AVL.Insert()
            AVL.setExtcode(".ibq")
            AVL.Insert()
            AVL.setExtcode(".idl")
            AVL.Insert()
            AVL.setExtcode(".inc")
            AVL.Insert()
            AVL.setExtcode(".inf")
            AVL.Insert()
            AVL.setExtcode(".ini")
            AVL.Insert()
            AVL.setExtcode(".inx")
            AVL.Insert()
            AVL.setExtcode(".js")
            AVL.Insert()
            AVL.setExtcode(".log")
            AVL.Insert()
            AVL.setExtcode(".m3u")
            AVL.Insert()
            AVL.setExtcode(".mht")
            AVL.Insert()
            AVL.setExtcode(".msg")
            AVL.Insert()
            AVL.setExtcode(".obd")
            AVL.Insert()
            AVL.setExtcode(".obt")
            AVL.Insert()
            AVL.setExtcode(".odc")
            AVL.Insert()
            AVL.setExtcode(".pl")
            AVL.Insert()
            AVL.setExtcode(".pot")
            AVL.Insert()
            AVL.setExtcode(".ppt")
            AVL.Insert()
            AVL.setExtcode(".rc")
            AVL.Insert()
            AVL.setExtcode(".reg")
            AVL.Insert()
            AVL.setExtcode(".rtf")
            AVL.Insert()
            AVL.setExtcode(".stm")
            AVL.Insert()
            AVL.setExtcode(".txt")
            AVL.Insert()
            AVL.setExtcode(".url")
            AVL.Insert()
            AVL.setExtcode(".vbs")
            AVL.Insert()
            AVL.setExtcode(".wtx")
            AVL.Insert()
            AVL.setExtcode(".xlb")
            AVL.Insert()
            AVL.setExtcode(".xlc")
            AVL.Insert()
            AVL.setExtcode(".xls")
            AVL.Insert()
            AVL.setExtcode(".xlt")
            AVL.Insert()
            AVL.setExtcode(".xml")
            AVL.Insert()
            AVL.setExtcode(".pdf")
            AVL.Insert()
            AVL.setExtcode(".msg")
            AVL.Insert()

        End If

        Dim iCnt As Integer = DBARCH.getTableCount("Attributes")
        If iCnt < 3 Then
            AddFileAttributes()
        End If

        iCnt = DBARCH.getTableCount("SourceType")
        If iCnt = 0 Then
            DBARCH.AddSecondarySOURCETYPE(".ascx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".asm", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".asp", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".aspx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".bat", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".c", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".CMD", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".cpp", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".cxx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".def", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".dic", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".doc", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".dot", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".h", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".hhc", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".hpp", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".htm", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".html", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".htw", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".htx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".hxx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".ibq", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".idl", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".inc", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".inf", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".ini", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".inx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".js", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".log", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".m3u", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".mht", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".msg", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".obd", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".obt", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".odc", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".pl", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".pot", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".ppt", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".rc", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".reg", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".rtf", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".stm", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".txt", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".url", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".vbs", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".wtx", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".xlb", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".xlc", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".xls", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".xlt", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".xml", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".pdf", "Word Splitter", "0", "1")
            DBARCH.AddSecondarySOURCETYPE(".zip", "Word Splitter", "0", "0")
        End If
        iCnt = DBARCH.getTableCount("AttachmentType")
        If iCnt < 5 Then
            ATCH_TYPE.setAttachmentcode(".ascx")
            ATCH_TYPE.setIszipformat("0")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".asm")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".asp")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".aspx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".bat")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".c")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".CMD")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".cpp")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".cxx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".def")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".dic")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".doc")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".docx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".dot")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".h")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".hhc")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".hpp")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".htm")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".html")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".htw")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".htx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".hxx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".ibq")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".idl")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".inc")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".inf")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".ini")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".inx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".js")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".log")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".m3u")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".mht")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".msg")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".obd")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".obt")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".odc")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".pl")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".pot")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".ppt")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".rc")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".reg")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".rtf")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".stm")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".txt")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".url")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".vbs")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".wtx")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".xlb")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".xlc")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".xls")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".xlt")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".xml")
            ATCH_TYPE.Insert()
            ATCH_TYPE.setAttachmentcode(".pdf")
            ATCH_TYPE.Insert()
        End If
    End Sub

    Private Sub ckRemoveAfterXDays_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckRemoveAfterXDays.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If ckRemoveAfterXDays.Checked Then
            NumericUpDown3.Enabled = True
        Else
            NumericUpDown3.Enabled = False
        End If
    End Sub

    Private Sub lbActiveFolder_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles lbActiveFolder.MouseDown
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If e.Button = MouseButtons.Right Then
            If e.Button = MouseButtons.Right Then
                If e.Button = MouseButtons.Right Then
                    Dim PNT As New System.Drawing.Point
                    PNT.X = e.X
                    PNT.Y = e.Y
                    Dim X As Integer = e.X
                    Dim Y As Integer = e.Y
                    If gClipBoardActive = True Then Console.WriteLine(X.ToString + "," + Y.ToString)
                    ContextMenuStrip1.Show(Me.lbActiveFolder, X, Y)
                End If
            End If
        End If
    End Sub

    Private Sub ListBox1_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbActiveFolder.SelectedIndexChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim I As Integer = lbActiveFolder.SelectedItems.Count
        If I = 0 Then
            SB.Text = "You must select an item from the listbox..."
            Return
        End If

        If cbParentFolders.Text.Trim.Length = 0 Then
            MessageBox.Show("Please select a Parent Folder")
            Return
        End If

        SB2.Text = lbActiveFolder.SelectedItem.ToString.Trim

        Dim EmailFolderName As String = ""
        Dim RemoveAfterArchive As String = ""
        Dim SetAsDefaultFolder As String = ""
        Dim ArchiveAfterXDays As String = ""
        Dim ArchiveXDays As String = ""
        Dim RemoveAfterXDays As String = ""
        Dim RemoveXDays As String = ""
        Dim DBID As String = ""
        Dim ArchiveEmails As String = ""
        Dim ArchiveOnlyIfRead As String = ""
        Dim SystemFolder As String = ""

        Dim FolderName As String = lbActiveFolder.SelectedItem.ToString.Trim
        Dim KeyFolderName As String = ParentFolder + "|" + FolderName
        KeyFolderName = UTIL.RemoveSingleQuotes(KeyFolderName)
        Dim WhereClause As String = " where UserID = '" + gCurrUserGuidID + "' and FolderName = '" + KeyFolderName + "' "

        Dim aParms As String() = DBARCH.SelectOneEmailParm(WhereClause)

        If aParms(8) = Nothing Then
            aParms(8) = FolderName
            aParms(1) = ""
            aParms(2) = ""
            aParms(3) = ""
            aParms(4) = ""
            aParms(7) = ""
            aParms(5) = ""
            aParms(6) = ""
            aParms(9) = ""
            aParms(10) = ""
            aParms(11) = ""
        End If

        AddNewDirectory()

        ShowSellectedLibs(KeyFolderName, "EMAIL")

    End Sub

    Sub AddNewDirectory()
        Dim EmailFolderName As String = ""
        Dim RemoveAfterArchive As String = ""
        Dim SetAsDefaultFolder As String = ""
        Dim ArchiveAfterXDays As String = ""
        Dim ArchiveXDays As String = ""
        Dim RemoveAfterXDays As String = ""
        Dim RemoveXDays As String = ""
        Dim DBID As String = ""
        Dim ArchiveEmails As String = ""
        Dim ArchiveOnlyIfRead As String = ""
        Dim SystemFolder As String = ""

        Dim FolderName As String = lbActiveFolder.SelectedItem.ToString.Trim
        Dim KeyFolderName As String = ParentFolder + "|" + FolderName
        KeyFolderName = UTIL.RemoveSingleQuotes(KeyFolderName)
        Dim WhereClause As String = " where UserID = '" + gCurrUserGuidID + "' and FolderName = '" + KeyFolderName + "' "

        Dim aParms As String() = DBARCH.SelectOneEmailParm(WhereClause)

        If aParms(8) = Nothing Then
            aParms(8) = FolderName
            aParms(1) = ""
            aParms(2) = ""
            aParms(3) = ""
            aParms(4) = ""
            aParms(7) = ""
            aParms(5) = ""
            aParms(6) = ""
            aParms(9) = ""
            aParms(10) = ""
            aParms(11) = ""
        End If
        'UserID = a(0)
        'ArchiveEmails = a(1)
        'RemoveAfterArchive = a(2)
        'SetAsDefaultFolder = a(3)
        'ArchiveAfterXDays = a(4)
        'RemoveAfterXDays = a(5)
        'RemoveXDays = a(6)
        'ArchiveXDays = a(7)
        'FolderName = a(8)
        'DB_ID = a(9)
        Dim tEmailFolderName As String = aParms(8)

        Dim A As String() = tEmailFolderName.Split("|")
        EmailFolderName = A(UBound(A))

        ArchiveEmails = aParms(1)
        RemoveAfterArchive = aParms(2)
        SetAsDefaultFolder = aParms(3)
        ArchiveAfterXDays = aParms(4)
        ArchiveXDays = aParms(7)
        RemoveAfterXDays = aParms(5)
        RemoveXDays = aParms(6)
        DBID = aParms(9)
        ArchiveOnlyIfRead = aParms(10)
        SystemFolder = aParms(11)

        If SystemFolder.ToUpper.Equals("TRUE") Then
            ckSystemFolder.Checked = True
        Else
            ckSystemFolder.Checked = False
        End If

        If ArchiveEmails.Equals("Y") Then
            ckArchiveFolder.Checked = True
        Else
            ckArchiveFolder.Checked = False
        End If
        If ArchiveOnlyIfRead.Equals("Y") Then
            Me.ckArchiveRead.Checked = True
        Else
            ckArchiveRead.Checked = False
        End If

        If RemoveAfterXDays.Equals("Y") Then
            ckRemoveAfterXDays.Checked = True
        Else
            ckRemoveAfterXDays.Checked = False
        End If
        If RemoveAfterXDays.Equals("Y") Then
            ckRemoveAfterXDays.Checked = True
            NumericUpDown3.Value = RemoveXDays
            NumericUpDown3.Enabled = True
        Else
            ckRemoveAfterXDays.Checked = False
            NumericUpDown3.Value = "0"
            NumericUpDown3.Enabled = False
        End If

        cbEmailRetention.Text = DBARCH.GetEmailRetentionCode(tEmailFolderName, gCurrUserGuidID)
        cbEmailDB.Text = DBID
    End Sub

    Sub RemoveAlreadyArchived(ByVal ParentFolder As String, ByVal HideArchived As Boolean)

        Dim I As Integer = 0
        Dim k As Integer = 0

        For I = lbActiveFolder.Items.Count - 1 To 0 Step -1
            Dim S1 As String = lbActiveFolder.Items(I).ToString
            For j As Integer = 0 To ArchivedEmailFolders.Count - 1
                Dim s2 As String = ArchivedEmailFolders.Item(j).ToString
                'WDM Remove this
                If gClipBoardActive = True Then Console.WriteLine(s2 + " : " + S1)
                Me.SB.Text = S1
                Me.SB.Refresh()
                Application.DoEvents()
                If UCase(S1).Equals(UCase(s2)) Then
                    If HideArchived = True Then
                        lbActiveFolder.Items.RemoveAt(I)
                        'Else
                        'lbActiveFolder.SetSelected(j, True)
                    End If

                    Exit For
                End If
            Next
        Next
        Me.SB.Text = ""

    End Sub

    Private Sub btnRefreshFolders_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshFolders.Click
        'btnValidateEntry.Visible = False
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If gEmailArchiveDisabled.Equals(False) Then
            LOG.WriteToArchiveLog("NOTICE: EMAIL Archive is disabled.")
            Return
        End If

        AllEmailFoldersShowing = True
        'ARCH.RegisterOutlookContainers()

        Me.Cursor = Cursors.AppStarting

        ParentFolder = cbParentFolders.Text

        If ParentFolder.Trim.Length = 0 Then
            MessageBox.Show("Please select an Outlook Folder to process.")
            Return
        End If

        isOutlookAvail = ARCH.getOutlookFolderNames(ParentFolder, lbActiveFolder)

        If isOutlookAvail = False Then
            ckDisableOutlookEmailArchive.Checked = True
            'gbEmail.Enabled = False
        End If
        If isOutlookAvail = False Then
            SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL."
        End If

        RemoveAlreadyArchived(ParentFolder, ckDoNotShowArchived.Checked)

        DBARCH.CleanUpEmailFolders()

        'btnDeleteEmailEntry.Enabled = False
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub btnActive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnActive.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        AllEmailFoldersShowing = False
        ParentFolder = cbParentFolders.Text

        If ParentFolder.Trim.Length = 0 Then
            MessageBox.Show("Please select an Outlook Folder to process.")
            Return
        End If
        Me.Cursor = Cursors.AppStarting

        DBARCH.GetActiveEmailFolders(ParentFolder, lbActiveFolder, gCurrUserGuidID, CF, ArchivedEmailFolders)
        btnDeleteEmailEntry.Enabled = True

        DBARCH.CleanUpEmailFolders()

        Me.Cursor = Cursors.Default

    End Sub

    Sub VerifyEmailFolderExists(ByVal FileDirectory As String, ByVal FolderName As String)
        Me.Cursor = Cursors.AppStarting
        Dim i As Integer = EMF.cnt_IDX_FolderName(FileDirectory, FolderName, gCurrUserGuidID)
        If i = 0 Then
            ARCH.getOutlookFolderNames(ParentFolder)
        End If
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub btnSaveConditions_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveConditions.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim RetentionCode As String = cbEmailRetention.Text
        If RetentionCode.Length = 0 Then
            cbEmailRetention.Text = DBARCH.getRetentionPeriodMax()
            RetentionCode = cbEmailRetention.Text
        End If

        If cbParentFolders.Text.Trim.Length = 0 Then
            MessageBox.Show("Please select a Parent Folder")
            Return
        End If

        If Not ckArchiveFolder.Checked Then
            MessageBox.Show("The Archive Email folder was not checked, please take note...")
            'ckArchiveFolder.Checked = True
        End If

        Dim RetentionYears As Integer = 0
        RetentionYears = DBARCH.getRetentionPeriod(RetentionCode)

        Try
            Me.Cursor = Cursors.AppStarting
            Dim FileDirectory As String = ""
            For Each sFolderName As String In lbActiveFolder.SelectedItems

                Dim FolderName As String = sFolderName.ToString
                FQNFolder = ParentFolder + "|" + FolderName

                ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder)
                FolderName = UTIL.RemoveSingleQuotes(FolderName)
                FQNFolder = UTIL.RemoveSingleQuotes(FQNFolder)

                'FileDirectory  = cbParentFolders.Text
                FileDirectory = ParentFolder

                'Dim EDIR As New clsEMAILFOLDER
                'EDIR.cnt_IDX_FolderName(FolderName , gCurrUserGuidID)
                'EDIR = Nothing

                Dim aParms(0) As String

                EMPARMS.setFoldername(FQNFolder)
                EMPARMS.setUserid(gCurrUserGuidID)

                If ckArchiveRead.Checked Then
                    EMPARMS.setArchiveonlyifread("Y")
                Else
                    EMPARMS.setArchiveonlyifread("N")
                End If

                If ckArchiveFolder.Checked Then
                    EMPARMS.setArchiveemails("Y")
                    DBARCH.SetFolderAsActive(FolderName, "Y")
                Else
                    EMPARMS.setArchiveemails("N")
                    DBARCH.SetFolderAsActive(FolderName.Trim, "N")
                End If

                If ckRemoveAfterXDays.Checked Then
                    EMPARMS.setRemoveafterxdays("Y")
                    EMPARMS.setRemovexdays(NumericUpDown3.Value.ToString)
                Else
                    EMPARMS.setRemoveafterxdays("N")
                    EMPARMS.setRemovexdays("0")
                End If
                If ckSystemFolder.Checked Then
                    Dim msg As String = "This folder will become mandatory for everyone, are you sure?"
                    Dim dlgRes As DialogResult = MessageBox.Show(msg, "Mandatory Folder", MessageBoxButtons.YesNo)
                    If dlgRes = Windows.Forms.DialogResult.No Then
                        Return
                    End If
                    EMPARMS.setIsSysDefault("1")
                Else
                    EMPARMS.setIsSysDefault("0")
                End If

                If cbEmailDB.Text.Trim = "" Then
                    cbEmailDB.Text = "ECMREPO"
                End If
                EMPARMS.setDb_id(cbEmailDB.Text.Trim)

                'xavier
                Dim B As Boolean = DBARCH.ckFolderExists(FileDirectory, gCurrUserGuidID, FQNFolder)

                'For iCnt As Integer = 0 To CF.Count - 1
                '    Dim SS  = CF.Keys(iCnt).ToString
                '    Console.WriteLine(SS)
                'Next
                If Not B Then

                    Dim iFolder As Integer = EMF.cnt_IDX_FolderName(FileDirectory, FQNFolder, gCurrUserGuidID)
                    If iFolder = 0 Then
                        Console.WriteLine("Folder " + FQNFolder + " does not exist.")
                    End If

                    EMPARMS.Insert(FileDirectory)

                    Dim WhereClause As String = "Where FileDirectory = '" + FileDirectory + "' and [UserID] = '" + gCurrUserGuidID + "' and [FolderName] = '" + FQNFolder + "' "
                    EMPARMS.Update(WhereClause)

                    If isAdmin = True Then
                        Dim S As String = ""
                        If ckSystemFolder.Checked = True Then
                            S = "update [EmailFolder]"
                            S = S + " set isSysDefault = 1"
                            S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        Else
                            S = "update [EmailFolder]"
                            S = S + " set isSysDefault = 0"
                            S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        End If

                        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If

                    If ckArchiveFolder.Checked Then
                        Dim S As String = "update [EmailFolder]"
                        S = S + " set SelectedForArchive = 'Y' "
                        S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    Else
                        Dim S As String = "update [EmailFolder]"
                        S = S + " set SelectedForArchive = 'N' "
                        S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If
                Else
                    Dim WhereClause As String = "Where [UserID] = '" + gCurrUserGuidID + "' and [FolderName] = '" + FQNFolder + "'"
                    EMPARMS.Update(WhereClause)

                    If isAdmin = True Then
                        Dim S As String = ""
                        If ckSystemFolder.Checked = True Then
                            S = "update [EmailFolder]"
                            S = S + " set isSysDefault = 1"
                            'S  = S  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
                            S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        Else
                            S = "update [EmailFolder]"
                            S = S + " set isSysDefault = 0"
                            'S  = S  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
                            S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        End If
                        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            LOG.WriteToArchiveLog("Notice: frmMain:btnSaveConditions: 23.441 - 100 Failed to update isSysDefault")
                        End If
                    End If

                    If ckArchiveFolder.Checked Then
                        Dim S As String = "update [EmailFolder]"
                        S = S + " set SelectedForArchive = 'Y' "
                        S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    Else
                        Dim S As String = "update [EmailFolder]"
                        S = S + " set SelectedForArchive = 'N' "
                        S = S + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                        Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If

                End If
SKIPFOLDER:
                Dim xSql As String = ""
                xSql = "update [EmailFolder] "
                xSql = xSql + " set RetentionCode = '" + RetentionCode + "' "
                'xSql  = xSql  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
                xSql = xSql + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'"
                Dim BB1 As Boolean = DBARCH.ExecuteSqlNewConn(xSql, False)
                If Not BB1 Then
                    LOG.WriteToArchiveLog("Notice: frmMain:btnSaveConditions: 23.441 - 200 Failed to update RetentionCode")
                End If

                SB.Text = FolderName + " activated."
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            LOG.WriteToArchiveLog("ERROR 195-43.2 frmMain:btnSaveConditions_Click - ", ex)
        End Try

        DBARCH.CleanUpEmailFolders()

        Me.Cursor = Cursors.Default

    End Sub

    Private Sub btnSelDir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelDir.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If cbRetention.Text.Trim.Length = 0 Then
            MessageBox.Show("Please select a retention policy to apply to this directory before adding it to the system.")
            Return
        End If

        Dim tDir As String = ""

        If CurrentDirectory.Length > 0 Then
            FolderBrowserDialog1.SelectedPath = CurrentDirectory
        End If

        FolderBrowserDialog1.ShowDialog()
        If FolderBrowserDialog1.SelectedPath.Length > 0 Then
            tDir = FolderBrowserDialog1.SelectedPath
            CurrentDirectory = FolderBrowserDialog1.SelectedPath
        Else
            tDir = ""
        End If
        If tDir.Length = 0 Then
            SB.Text = "Action cancelled."
            Return
        End If

        Me.txtDir.Text = tDir

        btnAddDir_Click(Nothing, Nothing)

        Me.Cursor = System.Windows.Forms.Cursors.Default
        SB.Text = ("Directory added with default archive settings. Change as you wish and update.")
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub GroupBox2_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles gbContentMgt.Enter
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub btnAddFiletype_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddFiletype.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If Not DBARCH.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If

        Dim FileExt As String = Me.cbFileTypes.Text.Trim

        If InStr(FileExt, ".") = 0 Then
            FileExt = "." + FileExt
        End If

        Dim B As Boolean = DBARCH.ckExtExists(FileExt)

        DBARCH.delSecondarySOURCETYPE(FileExt)
        DBARCH.AddSecondarySOURCETYPE(FileExt, "Added by user", "0", "1")

        If B Then
            SB.Text = "Extension already defined to system."
        Else
            AVL.setExtcode(FileExt)
            AVL.Insert()
            DBARCH.LoadAvailFileTypes(cbFileTypes)
            DBARCH.LoadAvailFileTypes(cbPocessType)
            DBARCH.LoadAvailFileTypes(cbAsType)
            DBARCH.LoadAvailFileTypes(lbAvailExts)
        End If

    End Sub

    Private Sub ckRemoveAfterDays_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckRemoveFileType.Click
        If Not DBARCH.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        'select count(*) from  [DataSource] where [SourceTypeCode] = 'YYYY' and [DataSourceOwnerUserID] = 'XXX'
        Dim FileExt As String = Me.cbFileTypes.Text.Trim

        Dim B As Boolean = DBARCH.iCount("DataSource", "where [SourceTypeCode] = '" + FileExt + "' and [DataSourceOwnerUserID] = '" + gCurrUserGuidID + "'")

        If B Then
            MessageBox.Show("Cannot remove filetype " + FileExt + ". There are files of that type in the repository.")
            Return
        End If

        AVL.setExtcode(FileExt)
        AVL.Delete("Where ExtCode = '" + FileExt + "'")

        DBARCH.delSecondarySOURCETYPE(FileExt)
        DBARCH.LoadAvailFileTypes(cbFileTypes)
        DBARCH.LoadAvailFileTypes(cbPocessType)
        DBARCH.LoadAvailFileTypes(cbAsType)
        DBARCH.LoadAvailFileTypes(lbAvailExts)

    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        If Not DBARCH.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ParentFT As String = cbPocessType.Text
        Dim ChildFT As String = cbAsType.Text
        SB.Text = AP.SaveNewAssociations(ParentFT, ChildFT)
        DBARCH.GetProcessAsList(cbProcessAsList)
    End Sub

    Private Sub ckIncludeAllTypes_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
        If iCnt <= 0 Then
            MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            Return
        End If
        'If ckIncludeAllTypes.Checked Then
        '    Me.lbIncludeExts.Items.Clear()
        '    For i As Integer = 0 To lbAvailExts.Items.Count - 1
        '        Dim S  = Me.lbAvailExts.Items(i).ToString
        '        lbIncludeExts.Items.Add(S)
        '    Next
        'End If
    End Sub

    Private Sub lbArchiveDirs_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles lbArchiveDirs.MouseDown
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If e.Button = MouseButtons.Right Then
            Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
            If iCnt = 0 Then
                MessageBox.Show("You must select a Directory first... aborting")
                Return
            End If
            Dim FolderName As String = Me.lbArchiveDirs.SelectedItem.ToString
            FolderName = UTIL.RemoveSingleQuotes(FolderName)
            If e.Button = MouseButtons.Right Then
                frmLibraryAssignment.setFolderName(FolderName)
                frmLibraryAssignment.SetTypeContent(True)
                frmLibraryAssignment.ShowDialog()
            End If
        End If
    End Sub

    Private Sub ListBox2_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbArchiveDirs.SelectedIndexChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If bApplyingDirParms = True Then
            Return
        End If

        Dim I As Integer = lbArchiveDirs.SelectedItems.Count
        If I = 0 Then
            SB.Text = "You must select an item from the listbox..."
            Return
        End If
        If I.Equals(1) Then
            Dim tgtDir As String = lbArchiveDirs.SelectedItems(0)
            If DirectoryList.ContainsKey(tgtDir) Then
                lblListenerState.Text = "Listener ON"
            Else
                lblListenerState.Text = "Listener OFF"
            End If
        End If

        If I > 1 Then
            lblListenerState.Text = ""
        End If

        If I <> 1 Then
            CkMonitor.Visible = False
            CheckBox2.Visible = False
        Else
            CkMonitor.Visible = True
            CheckBox2.Visible = True
        End If

        bActiveChange = True

        Dim DirName As String = lbArchiveDirs.SelectedItem.ToString.Trim
        Me.txtDir.Text = DirName
        'DBARCH.LoadAvailFileTypes(lbAvailExts)
        Dim DBID As String = ""
        Dim IncludeSubDirs As String = ""
        Dim VersionFiles As String = ""
        Dim FolderDisabled As String = ""
        Dim isMetaData As String = ""
        Dim isPublic As String = ""
        Dim OcrDirectory As String = ""
        Dim OcrPdf As String = ""
        Dim isSysDefault As String = ""
        Dim DeleteOnArchive As String = ""

        DBARCH.GetDirectoryData(gCurrUserGuidID, DirName, DBID, IncludeSubDirs, VersionFiles, FolderDisabled, isMetaData, isPublic, OcrDirectory, isSysDefault, Me.ckArchiveBit.Checked, ListenForChanges, ListenDirectory, ListenSubDirectory, DirGuid, OcrPdf, DeleteOnArchive)

        cbFileDB.Text = DBID
        ckSubDirs.Checked = cvtTF(IncludeSubDirs)
        Me.ckVersionFiles.Checked = cvtTF(VersionFiles)
        Me.ckDisableDir.Checked = cvtTF(FolderDisabled)

        DBARCH.LoadIncludedFileTypes(lbIncludeExts, gCurrUserGuidID, DirName)
        DBARCH.LoadExcludedFileTypes(Me.lbExcludeExts, gCurrUserGuidID, DirName)

        If DeleteOnArchive.Equals("Y") Then
            ckDeleteAfterArchive.Checked = True
        Else
            ckDeleteAfterArchive.Checked = False
        End If

        If isSysDefault.ToUpper.Equals("TRUE") Then
            Me.clAdminDir.Checked = True
        Else
            Me.clAdminDir.Checked = False
        End If
        If isMetaData = "Y" Then
            Me.ckMetaData.Checked = True
        Else
            Me.ckMetaData.Checked = False
        End If
        If IncludeSubDirs.Equals("Y") Then
            ckSubDirs.Checked = True
        Else
            ckSubDirs.Checked = False
        End If
        If isPublic.Equals("Y") Then
            ckPublic.Checked = True
        Else
            ckPublic.Checked = False
        End If
        If OcrDirectory.Equals("Y") Then
            Me.ckOcr.Checked = True
        Else
            Me.ckOcr.Checked = False
        End If

        If OcrPdf.Equals("Y") Then
            Me.ckOcrPdf.Checked = True
            gPdfExtended = True
        Else
            Me.ckOcrPdf.Checked = False
            gPdfExtended = False
        End If

        Dim bDisabled As Boolean = DBARCH.isDirAdminDisabled(gCurrUserGuidID, DirName)
        If isAdmin = True And bDisabled = True Then
            SB.Text = "Directory disabled by Administrator, you are an ADMIN, do what you like."
            ckDisableDir.Enabled = True
        ElseIf isAdmin = False And bDisabled = True Then
            SB.Text = "Directory disabled by Administrator, please contact Admin."
            ckDisableDir.Checked = True
            ckDisableDir.Enabled = False
        Else
            ckDisableDir.Enabled = True
            SB.Text = ""
        End If

        If ListenDirectory = True Or ListenSubDirectory = True Then
            CkMonitor.Checked = True
        Else
            CkMonitor.Checked = False
        End If

        ShowSellectedLibs(DirName, "CONTENT")

        bActiveChange = False

    End Sub

    Sub ShowSellectedLibs(ByVal DirName As String, ByVal TypeList As String)

        If ckShowLibs.Checked Then

            frmLibraryAssgnList.LIbraryName = DirName
            DBARCH.GetListOfAssignedLibraries(DirName, TypeList, AssignedLibraries)
            frmLibraryAssgnList.lbLibraries.Items.Clear()
            frmLibraryAssgnList.lbLibraries.Refresh()
            frmLibraryAssgnList.Refresh()
            Application.DoEvents()
            For iList As Integer = 0 To AssignedLibraries.Count - 1
                frmLibraryAssgnList.lbLibraries.Items.Add(AssignedLibraries(iList))
            Next
            frmLibraryAssgnList.Visible = True
        Else
            frmLibraryAssgnList.Visible = False
        End If

    End Sub

    Private Sub lbIncludeExts_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbIncludeExts.SelectedIndexChanged
        If bApplyingDirParms = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            Dim SelectedFileType As String = lbIncludeExts.SelectedItem.ToString
            INL.setUserid(gCurrUserGuidID)
            INL.setFqn(Me.lbArchiveDirs.SelectedItem.ToString)
            INL.setExtcode(SelectedFileType)
            'INL.Delete("where UserID = '" + gCurrUserGuidID + "' and FQN = '" + Me.lbArchiveDirs.SelectedItem.ToString + "' and Extcode = '" + SelectedFileType  + "' ")
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ("Both a directory and the Included File Type must be selected...")
        End Try

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        SB.Text = "Profile maintenance selected, will not affect directory setup."
        For i As Integer = lbIncludeExts.SelectedItems.Count To 0 Step -1
            Dim II As Integer = lbIncludeExts.SelectedIndex
            If II >= 0 Then
                lbIncludeExts.Items.RemoveAt(II)
            End If
        Next

        Me.SB.Text = "Removed Items"

        btnSaveChanges.BackColor = Color.OrangeRed

    End Sub

    Private Sub AddInitialDB()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim II As Integer = DBARCH.getTableCount("Databases")

        If II > 0 Then
            Return
        End If

        Dim S As String = ""
        S = S + " INSERT INTO [Databases]"
        S = S + " ([DB_ID]"
        S = S + " ,[DB_CONN_STR])"
        S = S + " VALUES"
        S = S + " ('DMA.UD'"
        S = S + " ,'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True')"
        Try
            Dim b As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("ERROR 219.23.4: Call Administrator" + vbCrLf + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

        S = ""
        S = S + " INSERT INTO [Databases]"
        S = S + " ([DB_ID]"
        S = S + " ,[DB_CONN_STR])"
        S = S + " VALUES"
        S = S + " ('ECMREPO'"
        S = S + " ,'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True')"
        Try
            Dim b As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("ERROR 219.23.4: Call Administrator" + vbCrLf + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

        S = ""
        S = S + " INSERT INTO [Databases]"
        S = S + " ([DB_ID]"
        S = S + " ,[DB_CONN_STR])"
        S = S + " VALUES"
        S = S + " ('ECMREPO'"
        S = S + " ,'Data Source=<your source name here>;Initial Catalog=ECM.Library;Integrated Security=True')"
        Try
            Dim b As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("ERROR 219.23.4: Call Administrator" + vbCrLf + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Private Sub AddInitialEmailFolder(ByVal FileDirectory As String, ByVal FolderName As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        AddInitialDB()

        Me.Cursor = Cursors.AppStarting
        Dim aParms(0) As String

        'PARMS.EmailFolderName  = FolderName
        EMPARMS.setFoldername(FolderName)
        EMPARMS.setUserid(gCurrUserGuidID)
        EMPARMS.setArchiveemails("Y")
        EMPARMS.setRemoveafterarchive("Y")
        EMPARMS.setSetasdefaultfolder("N")
        EMPARMS.setArchivexdays("N")
        EMPARMS.setArchivexdays("0")
        EMPARMS.setRemoveafterarchive("N")
        EMPARMS.setRemovexdays("0")
        EMPARMS.setDb_id(CurrDbName)
        EMPARMS.Insert(FileDirectory)

        Me.Cursor = Cursors.Default
    End Sub

    Private Sub ckRunAtStartup_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If formloaded = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Me.saveStartUpParms()
        Try
            Dim aPath As String = ""

            aPath = System.Reflection.Assembly.GetExecutingAssembly.Location

            Dim RunAtStart As Boolean = False
            'If ckRunAtStartup.Checked Then
            '    RunAtStart = True
            'End If

            If RunAtStart Then
                Dim oReg As RegistryKey = Registry.CurrentUser
                'Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
                Dim oKey As RegistryKey = oReg.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Run", True)

                Dim SS As String = oKey.GetValue("EcmLibrary").ToString

                oKey.CreateSubKey("EcmLibrary")
                oKey.SetValue("EcmLibrary", aPath)

                SS = oKey.GetValue("EcmLibrary").ToString

                oKey.Close()
            Else

                'Registry.CurrentUser.DeleteSubKey("Software\Microsoft\Windows\CurrentVersion\Run\EcmLibrary")

                Dim oReg As RegistryKey = Registry.CurrentUser
                Dim oKey As RegistryKey = oReg.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Run", True)
                oKey.CreateSubKey("EcmLibrary")
                oKey.SetValue("EcmLibrary", "X")

                Dim SS As String = oKey.GetValue("EcmLibrary").ToString
                oKey.DeleteSubKey("EcmLibrary")
                SS = oKey.GetValue("EcmLibrary").ToString

                oKey.Close()
            End If

            'messagebox.show("Load at startup set to " + ckRunAtStartup.Checked.ToString)

            saveStartUpParms()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("Failed to set start up parameter." + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter.", ex)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Private Sub ckDisable_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisable.CheckedChanged
        If formloaded = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        'formloaded = False
        'Me.saveStartUpParms()
        'formloaded = True
        saveStartUpParms()
        SB.Text = "Disabled set to " + ckDisable.Checked.ToString
    End Sub

    Sub GetExecParms()

        Dim ArchiveType As String = ""
        ArchiveType = DBARCH.getRconParm(gCurrUserGuidID, "ArchiveType")
        'If ArchiveType .Length > 0 Then
        '    cbInterval.Text = ArchiveType
        'Else
        '    cbInterval.Text = ""
        'End If

        Dim C As String = ""
        C = DBARCH.getRconParm(gCurrUserGuidID, "ArchiveInterval")
        'If C.Length > 0 Then
        '    cbTimeUnit.Text = C
        'Else
        '    cbTimeUnit.Text = "5"
        'End If
        C = DBARCH.getRconParm(gCurrUserGuidID, "LoadAtStartup")
        'If C.Length > 0 Then
        '    If C.Equals("True") Then
        '        ckRunAtStartup.Checked = True
        '    Else
        '        ckRunAtStartup.Checked = False
        '    End If
        'Else
        '    ckRunAtStartup.Checked = False
        'End If

        C = DBARCH.getRconParm(gCurrUserGuidID, "Disabled")
        If C.Length > 0 Then
            If C.Equals("True") Then
                ckDisable.Checked = True
            Else
                ckDisable.Checked = False
            End If
        Else
            ckDisable.Checked = False
        End If

        C = DBARCH.getRconParm(gCurrUserGuidID, "ContentDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckDisableContentArchive.Checked = True
        Else
            Me.ckDisableContentArchive.Checked = False
        End If
        C = DBARCH.getRconParm(gCurrUserGuidID, "OutlookDisabled")
        If C.ToUpper.Equals("TRUE") Then
            gEmailArchiveDisabled = True
            Me.ckDisableOutlookEmailArchive.Checked = True
        Else
            gEmailArchiveDisabled = False
            Me.ckDisableOutlookEmailArchive.Checked = False
        End If
        C = DBARCH.getRconParm(gCurrUserGuidID, "ExchangeDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckDisableExchange.Checked = True
        Else
            Me.ckDisableExchange.Checked = False
        End If
        C = DBARCH.getRconParm(gCurrUserGuidID, "RssPullDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckRssPullDisabled.Checked = True
        Else
            Me.ckRssPullDisabled.Checked = False
        End If
        C = DBARCH.getRconParm(gCurrUserGuidID, "WebPageTrackerDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckWebPageTrackerDisabled.Checked = True
        Else
            Me.ckWebPageTrackerDisabled.Checked = False
        End If
        C = DBARCH.getRconParm(gCurrUserGuidID, "WebSiteTrackerDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckWebSiteTrackerDisabled.Checked = True
        Else
            Me.ckWebSiteTrackerDisabled.Checked = False
        End If

    End Sub

    Private Sub SenderMgtToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        frmSenderMgt.Show()
    End Sub

    Sub IncludeDirectory(ByVal DirFqn As String)

        ckSubDirs.Checked = True
        'ckOcr.Checked = True
        ckVersionFiles.Checked = True

        Try
            If cbRetention.Text.Trim.Length = 0 Then
                MessageBox.Show("Please select a retention policy to apply to this directory before adding it to the system.")
                Return
            End If

            PBx.Minimum = 0
            PBx.Maximum = 10

            Dim RetentionCode As String = cbRetention.Text.Trim

            Try
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor

                SB.Text = "Beginning Include"

                Try
                    PBx.Value = 1
                Catch ex As ThreadAbortException
                    LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.")
                    Thread.ResetAbort()
                Catch ex As Exception

                End Try

                Dim FQN As String = txtDir.Text.Trim
                FQN = UTIL.RemoveSingleQuotes(FQN)
                txtDir.Text = FQN

                Dim DBID As String = cbFileDB.Text.Trim

                Dim getMetaData As String = "N"
                If ckMetaData.Checked Then
                    getMetaData = "Y"
                End If

                Dim OcrDirectory As String = "N"
                If ckOcr.Checked Then
                    OcrDirectory = "Y"
                Else
                    OcrDirectory = "N"
                End If

                lbIncludeExts.Items.Clear()
                lbExcludeExts.Items.Clear()
                AuthorizedFileTypes.Clear()
                UnAuthorizedFileTypes.Clear()

                SB.Text = "Adding directory"
                Dim SUBDIR As String = cvtCkBox(ckSubDirs)
                Dim VersionFiles As String = cvtCkBox(Me.ckVersionFiles)
                Dim I As Integer = 0

                SB.Text = "Adding Included File Types"

                Try
                    PBx.Value = 2
                Catch ex As ThreadAbortException
                    LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.")
                    Thread.ResetAbort()
                Catch ex As Exception

                End Try

                AuthorizedFileTypes.Clear()
                If lbIncludeExts.Items.Count Then
                    For I = 0 To lbIncludeExts.Items.Count - 1
                        Dim InclExt As String = lbIncludeExts.Items(I).ToString
                        AuthorizedFileTypes.Add(InclExt)
                    Next
                End If

                'UnAuthorizedFileTypes.Clear()
                'If lbExcludeExts.Items.Count > 0 Then
                '    For I = 0 To Me.lbExcludeExts.Items.Count - 1
                '        Dim InclExt  = Me.lbExcludeExts.Items(I).ToString
                '        UnAuthorizedFileTypes.Add(InclExt )
                '    Next
                'End If

                Dim BB As Boolean = DBARCH.ckDirectoryExists(gCurrUserGuidID, FQN)
                If BB Then
                    MessageBox.Show("Directory already defined to system, you must SAVE the new setup.")
                    SB.Text = "Directory already defined to system, you must SAVE the new setup."
                Else
                    IncludeListHasChanged = True
                    DIRS.setDb_id(DBID)
                    DIRS.setFqn(FQN)
                    DIRS.setIncludesubdirs(SUBDIR)
                    DIRS.setVersionfiles(VersionFiles)
                    DIRS.setUserid(gCurrUserGuidID)
                    DIRS.setCkmetadata(getMetaData)
                    DIRS.setQuickRefEntry("0")
                    DIRS.setOcrDirectory(OcrDirectory)

                    DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString)

                    DIRS.Insert()

                    '**************************************************************************************************************
                    'AddSubDirs(FQN , ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory , clAdminDir.Checked, RetentionCode )
                    '**************************************************************************************************************

                    Dim FileExt As String = ""

                    SB.Text = "Adding Included File Types"

                    Try
                        PBx.Value = 4
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch ex As Exception

                    End Try

                    For I = 0 To AuthorizedFileTypes.Count - 1
                        FileExt = AuthorizedFileTypes.Item(I).ToString
                        SB.Text = "Including File Type: " + FileExt
                        FQN = UTIL.RemoveSingleQuotes(FQN)
                        Dim b As Boolean = INL.DeleteExisting(gCurrUserGuidID, FQN)
                        b = InclAddList(lbIncludeExts, gCurrUserGuidID, FQN)
                        Application.DoEvents()
                    Next

                    SB.Text = "Fetching Directories"

                    Try
                        PBx.Value = 7
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch ex As Exception

                    End Try

                    DBARCH.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)

                    SB.Text = "Fetching Included Files"

                    Try
                        PBx.Value = 9
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch ex As Exception

                    End Try

                    DBARCH.GetIncludedFiles(lbIncludeExts, gCurrUserGuidID, FQN)

                    If isAdmin = True Then
                        Dim S As String = ""
                        If clAdminDir.Checked = True Then
                            If ckSubDirs.Checked = True Then
                                S = "update [Directory] set [isSysDefault] = 1 where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%'"
                            Else
                                S = "update [Directory] set [isSysDefault] = 1 where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "'"
                            End If
                        Else
                            If ckSubDirs.Checked = True Then
                                S = "update [Directory] set [isSysDefault] = 0  where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%'"
                            Else
                                S = "update [Directory] set [isSysDefault] = 0  where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "'"
                            End If
                        End If
                        Dim BBB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                        If Not BBB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If
                    SB.Text = "Directory added."

                    'Dim Msg2  = "Please remember, your next step is to set the archive parameters " + vbCrLf
                    'Msg2 += "and press the Save Changes button to activate this directory." + vbCrLf + vbCrLf
                    ''Msg2 += "Once content is archived, parameter changes CANNOT be updated from this screen." + vbCrLf
                    ''Msg2 += "This includes metadata, OCR this directory and public access."
                    'messagebox.show(Msg2, MsgBoxStyle.Exclamation)

                    Me.Cursor = System.Windows.Forms.Cursors.Default
                    IncludeListHasChanged = False
                End If
                Me.PBx.Value = 0
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 80 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                SB.Text = ("Error: please review trace log last entry. (Trace Log Icon in main screen)")
                LOG.WriteToArchiveLog("frmMain:btnAddDir_Click: " + ex.Message)
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            End Try
            Me.Cursor = System.Windows.Forms.Cursors.Default
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 81 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR IncludeDirectory 144.23.11: Failed to add directories.")
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try
    End Sub

    Private Sub btnAddDir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddDir.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim DirFQN As String = txtDir.Text.Trim
        IncludeDirectory(DirFQN)

    End Sub

    Sub AddSubDirs(ByVal FQN As String, ByVal isPublic As Boolean, ByVal isEnabled As Boolean, ByVal OcrDirectory As String, ByVal clAdminDir As Boolean, ByVal RetentionCode As String)
        Dim PublicFlag As String = ""
        Dim DirEnabled As String = ""
        If isPublic Then
            PublicFlag = "Y"
        Else
            PublicFlag = "N"
        End If
        If isEnabled Then
            DirEnabled = "Y"
        Else
            DirEnabled = "N"
        End If

        If clAdminDir Then
            clAdminDir = 1
        Else
            clAdminDir = 0
        End If

        FQN = UTIL.RemoveSingleQuotes(FQN)
        SubDirectories.Clear()
        If Me.ckSubDirs.Checked = True Then
            Dim A(0) As String
            Dim SubDirFound As Boolean = DMA.RecursiveSearch(FQN, A)
            If SubDirFound Then
                DBARCH.delSubDirs(gCurrUserGuidID, FQN)
                Dim tFqn As String = FQN
                SUBDIRECTORY.setUserid(gCurrUserGuidID)
                SUBDIRECTORY.setFqn(FQN)
                SUBDIRECTORY.setSubfqn(tFqn)
                SUBDIRECTORY.setCkpublic(PublicFlag)
                SUBDIRECTORY.setCkdisabledir(DirEnabled)
                SUBDIRECTORY.setOcrDirectory(OcrDirectory)
                SUBDIRECTORY.Insert()

                SB2.Text = FQN
                SB2.Refresh()
                Application.DoEvents()

                Dim IntClAdminDir As Integer = 0

                If clAdminDir = True Then
                    IntClAdminDir = 1
                End If

                Dim S As String = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString + " where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                DBARCH.ExecuteSqlNewConn(S, False)

                S = "Update SubDir set RetentionCode = '" + RetentionCode + "' where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                DBARCH.ExecuteSqlNewConn(S, False)

                AuthorizedFileTypes.Add(tFqn)
                UnAuthorizedFileTypes.Add(tFqn)
                Dim iObj As Integer = SubDirectories.Count
                Me.PBx.Value = 0
                Me.PBx.Maximum = iObj + 2
                iObj = 0
                For Each O As Object In SubDirectories
                    tFqn = O.ToString.Trim
                    SUBDIRECTORY.setUserid(gCurrUserGuidID)
                    SUBDIRECTORY.setFqn(FQN)
                    SUBDIRECTORY.setSubfqn(tFqn)
                    SUBDIRECTORY.setCkpublic(PublicFlag)
                    SUBDIRECTORY.setOcrDirectory(OcrDirectory)
                    SUBDIRECTORY.Insert()

                    S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString + " where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                    DBARCH.ExecuteSqlNewConn(S, False)

                    S = "Update SubDir set RetentionCode = '" + RetentionCode + "' where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                    DBARCH.ExecuteSqlNewConn(S, False)

                    AuthorizedFileTypes.Add(tFqn)
                    UnAuthorizedFileTypes.Add(tFqn)
                    iObj += 1

                    SB2.Text = FQN + ":" + iObj.ToString
                    SB2.Refresh()
                    Application.DoEvents()

                    If iObj <= SubDirectories.Count Then
                        Me.PBx.Value = iObj
                        Me.PBx.Refresh()
                    End If

                    Application.DoEvents()
                Next
                Me.PBx.Value = 0
            Else
                Dim IntClAdminDir As Integer = 0

                If clAdminDir = True Then
                    IntClAdminDir = 1
                End If
                DBARCH.delSubDirs(gCurrUserGuidID, FQN)
                Dim tFqn As String = FQN
                SUBDIRECTORY.setUserid(gCurrUserGuidID)
                SUBDIRECTORY.setFqn(FQN)
                SUBDIRECTORY.setSubfqn(tFqn)
                SUBDIRECTORY.setCkpublic(PublicFlag)
                SUBDIRECTORY.setOcrDirectory(OcrDirectory)
                SUBDIRECTORY.Insert()

                Dim S As String = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString + " where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                DBARCH.ExecuteSqlNewConn(S, False)

                AuthorizedFileTypes.Add(tFqn)
                UnAuthorizedFileTypes.Add(tFqn)
            End If
        End If

        SB.Text = ""
        SB.Refresh()
        Application.DoEvents()

    End Sub

    Sub addSubDirs(ByVal FQN As String, ByRef LB As List(Of String))
        LB.Clear()
        FQN = UTIL.RemoveSingleQuotes(FQN)
        LB.Add(FQN)

        If Me.ckSubDirs.Checked = True Then
            Dim A(0) As String
            Dim SubDirFound As Boolean = DMA.RecursiveSearch(FQN, A)
            If SubDirFound Then
                Dim tFqn As String = FQN
                LB.Add(tFqn)
                For i As Integer = 0 To UBound(A)
                    If A(i) = Nothing Then
                    Else
                        tFqn = A(i).ToString
                        LB.Add(tFqn)
                    End If
                Next
            Else
                Dim tFqn As String = FQN
                LB.Add(tFqn)
            End If
        End If
    End Sub

    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveChanges.Click
        Dim FQN As String = txtDir.Text.Trim
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ckArchiveBit.Checked Then
            Dim tMsg As String = ""
            tMsg = tMsg + "WARNING! Skip if ARCHIVE bit set a HIGH RISK function." + vbCrLf
            tMsg = tMsg + "ECM Library is not responsible for selecting to use it." + vbCrLf
            tMsg = tMsg + "The file archive bit is a complex and ECM Library is not responsible for " + vbCrLf
            tMsg = tMsg + "missed, skipped, or any other content related mishap due to " + vbCrLf
            tMsg = tMsg + "this function being selected. " + vbCrLf + vbCrLf
            tMsg = tMsg + "YOU UNDERSTAND AND FULLY ACCEPT THE RISK IN CHOOSING " + vbCrLf
            tMsg = tMsg + "TO SKIP CONTENT BASED ON THE ARCHIVE BIT. " + vbCrLf + vbCrLf
            tMsg = tMsg + "Selecting the 'Skip If Archive Bit off' check box exposes the " + vbCrLf
            tMsg = tMsg + "archive to great risk. " + vbCrLf
            tMsg = tMsg + "By agreeing to this disclaimer, you accept fully all the risk " + vbCrLf
            tMsg = tMsg + "associated with skipping content with the archive bit set "
            tMsg = tMsg + "previously Archived."
            Dim dlgRes As DialogResult = MsgBox(tMsg, MsgBoxStyle.YesNo + MsgBoxStyle.Critical, "YOU ACCEPT ALL THE RISK!")
            If dlgRes = Windows.Forms.DialogResult.No Then
                Return
            End If

            tMsg = "Would you like to RESET all files' archive bit in this directory to NEEDS archive?"
            dlgRes = MsgBox(tMsg, MsgBoxStyle.YesNo + MsgBoxStyle.Critical, "THIS CAN TAKE A WHILE")
            If dlgRes = Windows.Forms.DialogResult.No Then
                SB.Text = "Files Archive bit will be USED as is."
            Else
                SB.Text = "Standby - initializing all files archive bit to ON."
                Dim tCmd As String = ""
                If ckSubDirs.Checked Then
                    tCmd = " " + FQN + "\*.* +a /s"
                    'System.Diagnostics.Process.Start("attrib.exe", tFQN )
                    Dim p As Process = Process.Start("attrib.exe", tCmd)
                    'p.WaitForExit()
                Else
                    tCmd = "attrib " + FQN + "\*.* +a"
                    Dim p As Process = Process.Start("attrib.exe", tCmd)
                    'p.WaitForExit()
                End If
            End If

            SB.Text = " "
        End If

        btnSaveChanges.BackColor = Color.LightGray

        Dim RetentionCode As String = cbRetention.Text
        If RetentionCode.Length = 0 Then
            cbRetention.Text = DBARCH.getRetentionPeriodMax()
            RetentionCode = cbRetention.Text
        End If

        Dim RetentionPeriod As Integer = 0
        If RetentionCode.Trim.Length = 0 Then
            RetentionPeriod = 10
        End If
        RetentionPeriod = DBARCH.getRetentionPeriod(RetentionCode)

        Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
        If txtDir.Text.Length > 0 Then
            SB.Text = "Updating " + txtDir.Text.Trim
        ElseIf iCnt <= 0 Then
            MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            Return
        End If
        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor

        FQN = UTIL.RemoveSingleQuotes(FQN)
        txtDir.Text = FQN
        'Dim DBID = cbFileDB.SelectedItem.ToString
        Dim DBID As String = "ECMREPO"
        Dim SUBDIR As String = cvtCkBox(ckSubDirs)

        Dim DeleteOnArchive As String = cvtCkBox(ckDeleteAfterArchive)

        Dim VersionFiles As String = cvtCkBox(Me.ckVersionFiles)
        Dim I As Integer = 0
        Dim DisableDir As String = "N"

        If DBID.Length = 0 Then
            MessageBox.Show("Please select a repository...")
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Return
        End If
        If lbIncludeExts.Items.Count = 0 Then
            MessageBox.Show("Please remember to include one or more filetypes in this archive...")
        End If

        Dim OcrPdf As String = "N"
        If ckOcrPdf.Checked Then
            OcrPdf = "Y"
            gPdfExtended = True
        Else
            OcrPdf = "N"
            gPdfExtended = False
        End If

        Dim OcrDirectory As String = "N"
        If ckOcr.Checked Then
            OcrDirectory = "Y"
        Else
            OcrDirectory = "N"
        End If

        Dim getMetaData As String = "N"
        If ckMetaData.Checked Then
            getMetaData = "Y"
        End If

        Dim SetToPublic As String = "N"
        If Me.ckPublic.Checked Then
            SetToPublic = "Y"
            DBARCH.AddSysMsg(FQN + " set to PUBLIC access.")
        Else
            SetToPublic = "N"
            DBARCH.AddSysMsg(FQN + " set to PRIVATE access.")
        End If

        If DBARCH.isPublicAllowed = False Then
            Me.ckPublic.Checked = False
            SetToPublic = "N"
        End If

        If ckDisableDir.Checked Then
            DisableDir = "Y"
        Else
            DisableDir = "N"
        End If

        Dim BB As Boolean = DBARCH.ckDirectoryExists(gCurrUserGuidID, FQN)
        If Not BB Then
            MessageBox.Show("Directory IS NOT defined to system, adding it.")
            btnAddDir_Click(Nothing, Nothing)
        Else
            DIRS.setDb_id(DBID)
            DIRS.setFqn(FQN)
            SUBDIR = UTIL.RemoveSingleQuotes(SUBDIR)
            DIRS.setIncludesubdirs(SUBDIR)
            DIRS.setUserid(gCurrUserGuidID)
            DIRS.setVersionfiles(VersionFiles)
            DIRS.setCkmetadata(getMetaData)
            DIRS.setCkpublic(SetToPublic)
            DIRS.setCkdisabledir(DisableDir)
            DIRS.setQuickRefEntry("0")
            DIRS.setOcrDirectory(OcrDirectory)
            DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString)
            DIRS.setOcrPdf(OcrPdf)
            DIRS.setDeleteOnArchive(DeleteOnArchive)

            AuthorizedFileTypes.Clear()
            UnAuthorizedFileTypes.Clear()

            AuthorizedFileTypes.Add(FQN)
            UnAuthorizedFileTypes.Add(FQN)

            Dim WhereClause As String = ""
            If ckOcr.Checked Then
                OcrDirectory = "Y"
            Else
                OcrDirectory = "N"
            End If

            If SUBDIR.Equals("Y") Then
                'WhereClause  = "where UserID = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%\' and AdminDisabled <> 1 and ckDisableDir <> 'Y'"
                'DIRS.Update(WhereClause , OcrDirectory)

                WhereClause = "where UserID = '" + gCurrUserGuidID + "' and [FQN] = '" + FQN + "'"
                DIRS.Update(WhereClause, OcrDirectory)
            Else
                WhereClause = "where UserID = '" + gCurrUserGuidID + "' and [FQN] = '" + FQN + "'"
                DIRS.Update(WhereClause, OcrDirectory)
            End If

            If clAdminDir.Checked Then
                Dim msg As String = "This Directory will become mandatory for everyone, are you sure?"
                Dim dlgRes As DialogResult = MessageBox.Show(msg, "Mandatory Directory", MessageBoxButtons.YesNo)
                If dlgRes = Windows.Forms.DialogResult.No Then
                    Return
                End If
                Dim S As String = "Update Directory set isSysDefault = 1 " + WhereClause
                Dim bb1 As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                If Not bb1 Then
                    Console.WriteLine("Error 1994.23.1 - did not update isSysDefault")
                End If
            Else
                Dim S As String = "Update Directory set isSysDefault = 0 " + WhereClause
                Dim bb1 As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                If Not bb1 Then
                    Console.WriteLine("Error 1994.23.1 - did not update isSysDefault")
                End If
            End If

            Dim tSql1 As String = "Update Directory set RetentionCode = '" + RetentionCode + "' " + WhereClause
            Dim BB2 As Boolean = DBARCH.ExecuteSqlNewConn(tSql1, False)
            If Not BB2 Then
                Console.WriteLine("Error 1994.23.1x - did not update RetentionCode")
            End If

            Me.SB.Text = "Step 1 of 4 standby..."
            DBARCH.SetDocumentPublicFlagByOwnerDir(FQN, Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory)

            Me.SB.Text = "Step 2 of 4 standby... "
            'DBARCH.SetDocumentPublicFlagByOwnerDir(FQN , Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory )

            Me.SB.Text = "Step 3 of 4 standby..."

            Dim sSql As String = "delete from [IncludedFiles] where FQN = '" + FQN + "'"
            BB = DBARCH.ExecuteSqlNewConn(90301, sSql)

            Me.PBx.Maximum = AuthorizedFileTypes.Count
            Me.PBx.Value = 0
            For I = 0 To AuthorizedFileTypes.Count - 1
                FQN = AuthorizedFileTypes.Item(I).ToString
                Dim b As Boolean = INL.DeleteExisting(gCurrUserGuidID, FQN)
                b = InclAddList(lbIncludeExts, gCurrUserGuidID, FQN)
                If Not b Then
                    If Not b Then
                        DBARCH.xTrace(87925, "frmMain:btnSaveChanges:AddList", "Failed for: " + FQN + " : " + gCurrUserGuidID)
                    End If
                End If

                If I Mod 5 = 0 Then
                    Me.SB.Text = "Processing SubDir: " & I.ToString + " of " + AuthorizedFileTypes.Count.ToString
                End If
                Me.PBx.Value = I
                Application.DoEvents()
            Next

            lbExcludeExts.Visible = False
            lbIncludeExts.Visible = False
            lbAvailExts.Visible = False
            lbArchiveDirs.Enabled = False
            Me.PBx.Maximum = UnAuthorizedFileTypes.Count + 2

            For I = 0 To UnAuthorizedFileTypes.Count - 1
                PBx.Value = I
                PBx.Refresh()
                'If IncludeListHasChanged = False Then
                '    Exit For
                'End If
                FQN = UnAuthorizedFileTypes.Item(I).ToString
                Dim b As Boolean = Me.EXL.DeleteExisting(gCurrUserGuidID, FQN)
                b = Me.ExcludeAddList(Me.lbExcludeExts, gCurrUserGuidID, FQN)
                If Not b Then
                    If Not b Then
                        DBARCH.xTrace(87925.22, "frmMain:btnSaveChanges:AddList", "Failed for: " + FQN + " : " + gCurrUserGuidID)
                    End If
                End If
                '** WDM DBARCH.SetDocumentPublicFlag(gCurrUserGuidID, FQN , Me.ckPublic.Checked, Me.ckDisableDir.Checked)
                If I Mod 5 = 0 Then
                    Me.SB.Text = "Adding subdirectories... standby: " + I.ToString
                End If
                Application.DoEvents()
                Application.DoEvents()
                DBARCH.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)
                DBARCH.GetIncludedFiles(lbIncludeExts, gCurrUserGuidID, FQN)
                Application.DoEvents()
            Next
            Me.Cursor = Cursors.AppStarting
            If Me.ckPublic.Checked Then
                SetToPublic = "Y"
                Dim S As String = "Update [Directory] set ckPublic = 'Y' "
                S = S + " where FQN = '" + FQN + "' "
                S = S + " and UserID = '" + gCurrUserGuidID + "'"
                DBARCH.ExecuteSqlNewConn(90302, S)
                If ckPublic.Enabled Then
                    SB.Text = "Standby, updating the repository, this can take a long time."
                    Me.Refresh()
                    Application.DoEvents()
                    Me.Cursor = Cursors.AppStarting
                    S = "update DataSource set isPublic = 'Y' where FileDirectory = '" + FQN + "' and DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
                    DBARCH.ExecuteSqlNewConn(90303, S)
                    Me.Cursor = Cursors.Default
                End If
            Else
                SetToPublic = "N"
                Dim S As String = "Update [Directory] set ckPublic = 'N' "
                S = S + " where FQN = '" + FQN + "' "
                S = S + " and UserID = '" + gCurrUserGuidID + "'"
                DBARCH.ExecuteSqlNewConn(90304, S)
                If ckPublic.Enabled Then
                    SB.Text = "Standby, updating the repository, this can take a long time."
                    Me.Refresh()
                    Application.DoEvents()
                    Me.Cursor = Cursors.AppStarting
                    S = "update DataSource set isPublic = 'N' where FileDirectory = '" + FQN + "' and DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
                    DBARCH.ExecuteSqlNewConn(90305, S)
                    Me.Cursor = Cursors.Default
                End If
            End If
            Me.Cursor = Cursors.Default

        End If

        If CkMonitor.Checked = True Then
            CkMonitor_CheckedChanged(Nothing, Nothing)
        End If

        PBx.Value = 0
        lbExcludeExts.Visible = True
        lbIncludeExts.Visible = True
        lbAvailExts.Visible = True
        lbArchiveDirs.Enabled = True

        btnRefresh.Text = "Show Enabled"
        Button5_Click(Nothing, Nothing)

        IncludeListHasChanged = False
        Me.SB.Text = "Complete..."
        Me.PBx.Value = 0
        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private Sub MirrorDirectory(DirName As String)

        lblNotice.Text = "ADDING: " + DirName
        Dim RetentionCode As String = cbRetention.Text
        If RetentionCode.Length = 0 Then
            cbRetention.Text = DBARCH.getRetentionPeriodMax()
            RetentionCode = cbRetention.Text
        End If

        Dim RetentionPeriod As Integer = 0
        If RetentionCode.Trim.Length = 0 Then
            RetentionPeriod = 10
        End If
        RetentionPeriod = DBARCH.getRetentionPeriod(RetentionCode)

        Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
        If DirName.Length > 0 Then
            SB.Text = "Updating " + DirName.Trim
        ElseIf iCnt <= 0 Then
            MessageBox.Show("You have failed to select a PARENT DIRECTORY, pick one and only one, returning.")
            Return
        End If

        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor

        DirName = UTIL.RemoveSingleQuotes(DirName)

        Dim DBID As String = "ECMREPO"
        Dim SUBDIR As String = cvtCkBox(ckSubDirs)

        Dim DeleteOnArchive As String = cvtCkBox(ckDeleteAfterArchive)

        Dim VersionFiles As String = cvtCkBox(Me.ckVersionFiles)
        Dim I As Integer = 0
        Dim DisableDir As String = "N"

        If DBID.Length = 0 Then
            MessageBox.Show("Please select a repository...")
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Return
        End If

        If lbIncludeExts.Items.Count = 0 Then
            MessageBox.Show("Please remember to include one or more filetypes in this archive...")
        End If

        Dim OcrPdf As String = "N"
        If ckOcrPdf.Checked Then
            OcrPdf = "Y"
            gPdfExtended = True
        Else
            OcrPdf = "N"
            gPdfExtended = False
        End If

        Dim OcrDirectory As String = "N"
        If ckOcr.Checked Then
            OcrDirectory = "Y"
        Else
            OcrDirectory = "N"
        End If

        Dim getMetaData As String = "N"
        If ckMetaData.Checked Then
            getMetaData = "Y"
        End If

        Dim SetToPublic As String = "N"
        If Me.ckPublic.Checked Then
            SetToPublic = "Y"
            DBARCH.AddSysMsg(DirName + " set to PUBLIC access.")
        Else
            SetToPublic = "N"
            DBARCH.AddSysMsg(DirName + " set to PRIVATE access.")
        End If

        If DBARCH.isPublicAllowed = False Then
            Me.ckPublic.Checked = False
            SetToPublic = "N"
        End If

        If ckDisableDir.Checked Then
            DisableDir = "Y"
        Else
            DisableDir = "N"
        End If

        Dim BB As Boolean = DBARCH.ckDirectoryExists(gCurrUserGuidID, DirName)
        If Not BB Then
            LOG.WriteToArchiveLog("Directory '" + DirName + "' IS NOT defined to system, adding it.")
            btnAddDir_Click(Nothing, Nothing)
        Else
            DIRS.setDb_id(DBID)
            DIRS.setFqn(DirName)
            SUBDIR = UTIL.RemoveSingleQuotes(SUBDIR)
            DIRS.setIncludesubdirs(SUBDIR)
            DIRS.setUserid(gCurrUserGuidID)
            DIRS.setVersionfiles(VersionFiles)
            DIRS.setCkmetadata(getMetaData)
            DIRS.setCkpublic(SetToPublic)
            DIRS.setCkdisabledir(DisableDir)
            DIRS.setQuickRefEntry("0")
            DIRS.setOcrDirectory(OcrDirectory)
            DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString)
            DIRS.setOcrPdf(OcrPdf)
            DIRS.setDeleteOnArchive(DeleteOnArchive)

            AuthorizedFileTypes.Clear()
            UnAuthorizedFileTypes.Clear()

            AuthorizedFileTypes.Add(DirName)
            UnAuthorizedFileTypes.Add(DirName)

            Dim WhereClause As String = ""
            If ckOcr.Checked Then
                OcrDirectory = "Y"
            Else
                OcrDirectory = "N"
            End If

            If SUBDIR.Equals("Y") Then
                'WhereClause  = "where UserID = '" + gCurrUserGuidID + "' and [DirNAme] like '" + DirNAme + "%\' and AdminDisabled <> 1 and ckDisableDir <> 'Y'"
                'DIRS.Update(WhereClause , OcrDirectory)

                WhereClause = "where UserID = '" + gCurrUserGuidID + "' and [DirNAme] = '" + DirName + "'"
                DIRS.Update(WhereClause, OcrDirectory)
            Else
                WhereClause = "where UserID = '" + gCurrUserGuidID + "' and [DirNAme] = '" + DirName + "'"
                DIRS.Update(WhereClause, OcrDirectory)
            End If

            If clAdminDir.Checked Then
                Dim msg As String = "This Directory will become mandatory for everyone, are you sure?"
                Dim dlgRes As DialogResult = MessageBox.Show(msg, "Mandatory Directory", MessageBoxButtons.YesNo)
                If dlgRes = Windows.Forms.DialogResult.No Then
                    Return
                End If
                Dim S As String = "Update Directory set isSysDefault = 1 " + WhereClause
                Dim bb1 As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                If Not bb1 Then
                    Console.WriteLine("Error 1994.23.1 - did not update isSysDefault")
                End If
            Else
                Dim S As String = "Update Directory set isSysDefault = 0 " + WhereClause
                Dim bb1 As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                If Not bb1 Then
                    Console.WriteLine("Error 1994.23.1 - did not update isSysDefault")
                End If
            End If

            Dim tSql1 As String = "Update Directory set RetentionCode = '" + RetentionCode + "' " + WhereClause
            Dim BB2 As Boolean = DBARCH.ExecuteSqlNewConn(tSql1, False)
            If Not BB2 Then
                Console.WriteLine("Error 1994.23.1x - did not update RetentionCode")
            End If

            Me.SB.Text = "Step 1 of 4 standby..."
            DBARCH.SetDocumentPublicFlagByOwnerDir(DirName, Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory)

            Me.SB.Text = "Step 2 of 4 standby... "
            'DBARCH.SetDocumentPublicFlagByOwnerDir(DirNAme , Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory )

            Me.SB.Text = "Step 3 of 4 standby..."

            Dim sSql As String = "delete from [IncludedFiles] where DirNAme = '" + DirName + "'"
            BB = DBARCH.ExecuteSqlNewConn(90301, sSql)

            Me.PBx.Maximum = AuthorizedFileTypes.Count
            Me.PBx.Value = 0
            For I = 0 To AuthorizedFileTypes.Count - 1
                DirName = AuthorizedFileTypes.Item(I).ToString
                Dim b As Boolean = INL.DeleteExisting(gCurrUserGuidID, DirName)
                b = InclAddList(lbIncludeExts, gCurrUserGuidID, DirName)
                If Not b Then
                    If Not b Then
                        DBARCH.xTrace(87925, "frmMain:btnSaveChanges:AddList", "Failed for: " + DirName + " : " + gCurrUserGuidID)
                    End If
                End If

                If I Mod 5 = 0 Then
                    Me.SB.Text = "Processing SubDir: " & I.ToString + " of " + AuthorizedFileTypes.Count.ToString
                End If
                Me.PBx.Value = I
                Application.DoEvents()
            Next

            lbExcludeExts.Visible = False
            lbIncludeExts.Visible = False
            lbAvailExts.Visible = False
            lbArchiveDirs.Enabled = False
            Me.PBx.Maximum = UnAuthorizedFileTypes.Count + 2

            For I = 0 To UnAuthorizedFileTypes.Count - 1
                PBx.Value = I
                PBx.Refresh()
                'If IncludeListHasChanged = False Then
                '    Exit For
                'End If
                DirName = UnAuthorizedFileTypes.Item(I).ToString
                Dim b As Boolean = Me.EXL.DeleteExisting(gCurrUserGuidID, DirName)
                b = Me.ExcludeAddList(Me.lbExcludeExts, gCurrUserGuidID, DirName)
                If Not b Then
                    If Not b Then
                        DBARCH.xTrace(87925.22, "frmMain:btnSaveChanges:AddList", "Failed for: " + DirName + " : " + gCurrUserGuidID)
                    End If
                End If
                '** WDM DBARCH.SetDocumentPublicFlag(gCurrUserGuidID, DirNAme , Me.ckPublic.Checked, Me.ckDisableDir.Checked)
                If I Mod 5 = 0 Then
                    Me.SB.Text = "Adding subdirectories... standby: " + I.ToString
                End If
                Application.DoEvents()
                Application.DoEvents()
                DBARCH.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)
                DBARCH.GetIncludedFiles(lbIncludeExts, gCurrUserGuidID, DirName)
                Application.DoEvents()
            Next
            Me.Cursor = Cursors.AppStarting
            If Me.ckPublic.Checked Then
                SetToPublic = "Y"
                Dim S As String = "Update [Directory] set ckPublic = 'Y' "
                S = S + " where DirNAme = '" + DirName + "' "
                S = S + " and UserID = '" + gCurrUserGuidID + "'"
                DBARCH.ExecuteSqlNewConn(90302, S)
                If ckPublic.Enabled Then
                    SB.Text = "Standby, updating the repository, this can take a long time."
                    Me.Refresh()
                    Application.DoEvents()
                    Me.Cursor = Cursors.AppStarting
                    S = "update DataSource set isPublic = 'Y' where FileDirectory = '" + DirName + "' and DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
                    DBARCH.ExecuteSqlNewConn(90303, S)
                    Me.Cursor = Cursors.Default
                End If
            Else
                SetToPublic = "N"
                Dim S As String = "Update [Directory] set ckPublic = 'N' "
                S = S + " where DirNAme = '" + DirName + "' "
                S = S + " and UserID = '" + gCurrUserGuidID + "'"
                DBARCH.ExecuteSqlNewConn(90304, S)
                If ckPublic.Enabled Then
                    SB.Text = "Standby, updating the repository, this can take a long time."
                    Me.Refresh()
                    Application.DoEvents()
                    Me.Cursor = Cursors.AppStarting
                    S = "update DataSource set isPublic = 'N' where FileDirectory = '" + DirName + "' and DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
                    DBARCH.ExecuteSqlNewConn(90305, S)
                    Me.Cursor = Cursors.Default
                End If
            End If
            Me.Cursor = Cursors.Default

        End If

        If CkMonitor.Checked = True Then
            CkMonitor_CheckedChanged(Nothing, Nothing)
        End If

        PBx.Value = 0
        lbExcludeExts.Visible = True
        lbIncludeExts.Visible = True
        lbAvailExts.Visible = True
        lbArchiveDirs.Enabled = True

        btnRefresh.Text = "Show Enabled"
        Button5_Click(Nothing, Nothing)

        IncludeListHasChanged = False
        Me.SB.Text = "Complete..."
        Me.PBx.Value = 0
        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private Sub btnInclFileType_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnInclFileType.Click
        Try
            If gTraceFunctionCalls.Equals(1) Then
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
            End If

            'If ckDirProfileMaint.Checked Then

            'End If

            'If txtDir.Text.Trim.Length = 0 Then
            '    messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            '    Return
            'End If
            Dim S1 As String = lbAvailExts.SelectedItem.ToString

            For Each S As String In lbAvailExts.SelectedItems
                Dim ItemAlreadyExists As Boolean = False
                For I As Integer = 0 To lbIncludeExts.Items.Count - 1
                    Dim ExistingItem As String = lbIncludeExts.Items(I)
                    If S.ToUpper.Equals(ExistingItem.ToUpper) Then
                        ItemAlreadyExists = True
                        Exit For
                    End If
                Next
                If ItemAlreadyExists = False Then
                    lbIncludeExts.Items.Add(S)
                    btnSaveChanges.BackColor = Color.OrangeRed
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR btnInclFileType_Click : " + ex.Message)
            SB.Text = "Error - please refer to error log."
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

        btnSaveChanges.BackColor = Color.OrangeRed

    End Sub

    Private Sub btnRemoveDir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveDir.Click
        Try
            If gTraceFunctionCalls.Equals(1) Then
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
            End If

            If clAdminDir.Checked Then
                MessageBox.Show("Cannot remove a mandatory directory, returning.")
                Return
            End If

            If Not lbArchiveDirs.SelectedItems.Count.Equals(1) Then
                MessageBox.Show("One and only one directory must be selected to remove, returning...")
                Return
            End If

            Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
            If iCnt <= 0 Then
                MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
                Return
            End If
            If iCnt > 1 Then
                MessageBox.Show("Please select one and only one directory to remove, returning.")
                Return
            End If

            Dim TgtDir As String = lbArchiveDirs.SelectedItems(0)
            Dim msg As String = "This will DELETE the selected directory AND ALL SUB-DIRECTORIES from the archive process, are you sure?"
            Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo)

            If dlgRes = Windows.Forms.DialogResult.No Then
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Return
            End If

            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            Dim FQN As String = txtDir.Text.Trim
            FQN = lbArchiveDirs.SelectedItems(0).ToString.Trim

            Dim S As String = ""

            If FQN.Contains("'") Then
                FQN.Replace("''", "'")
                FQN.Replace("'", "''")
            End If

            Dim B As Boolean = False
            If ckSubDirs.Checked Then
                S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90306, S)
                S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90307, S)
                S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90308, S)
                S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90309, S)
                ProcessListener(False)
            Else
                S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90310, S)
                S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90311, S)
                S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90312, S)
                S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DBARCH.ExecuteSqlNewConn(90313, S)
                ProcessListener(False)
            End If
            SB.Text = "Directory <" + TgtDir + "> removed."
            ProcessListener(False)
            DBARCH.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR btnRemoveDir_Click : No file type selected.")
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If btnRefresh.Text.Equals("Show Enabled") Then
            lbArchiveDirs.Items.Clear()
            DBARCH.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            btnRefresh.Text = "Show Disabled"
        Else
            lbArchiveDirs.Items.Clear()
            DBARCH.GetDirectories(lbArchiveDirs, gCurrUserGuidID, True)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            btnRefresh.Text = "Show Enabled"
        End If

    End Sub

    Function cvtCkBox(ByVal CB As CheckBox) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        If CB.Checked = True Then
            S = "Y"
        Else
            S = "N"
        End If
        Return S
    End Function

    Function cvtTF(ByVal tVal As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        tVal = UCase(tVal)
        If tVal = "Y" Then
            Return True
        Else
            Return False
        End If

    End Function

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click

        If Not DBARCH.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim msg As String = "This will remove the associated file types, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim ParentFT As String = ""
        Dim ChildFT As String = ""
        Dim S As String = cbProcessAsList.Text
        If S.Length = 0 Then
            MessageBox.Show("Please select an item to process... returning.")
            Return
        End If

        Dim I As Integer = 0
        Dim J As Integer = 0
        I = InStr(S, "-")
        ParentFT = Mid(S, 1, I - 1).Trim
        J = InStr(S, ">")
        ChildFT = Mid(S, J + 1).Trim
        PFA.setExtcode(ParentFT)
        PFA.setProcessextcode(ChildFT)
        Dim B As Boolean = DBARCH.ckProcessAsExists(ParentFT)
        If B Then
            B = PFA.Delete("where [ExtCode] = '" + ParentFT + "' ")
            If Not B Then
                MessageBox.Show("Delete failed...")
            Else
                S = "update  [DataSource] set [SourceTypeCode] = '" + ParentFT + "' where [SourceTypeCode] = '" + ChildFT + "' and [DataSourceOwnerUserID] = '" + gCurrUserGuidID + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)
                If B Then
                    SB.Text = ChildFT + " Reset to process as " + ParentFT
                End If
            End If
            DBARCH.GetProcessAsList(cbProcessAsList)
        End If
    End Sub

    Sub ActivateProgressBar(ByVal FileLength As Double)

        'Dim ImageSizeDouble As Double = 0

        frmPercent.fSize = gfile_Length
        frmPercent.Show()

        frmPercent.Top = Me.Top - 10
        frmPercent.Left = Me.Left
        frmPercent.Width = Me.Width
        'frmPercent.TopLevel = True

        Dim I As Integer = 0
        frmPercent.PB.Value = 0
        frmPercent.PB.Maximum = 1001
        Do While DisplayActivity = True
            I += 1
            Thread.Sleep(250)
            'If I Mod 15 = 0 Then
            '    Dim D As Double = DBARCH.getDataSourceImageLength(ImageGuid)
            '    Me.SB.Text = (D / ImageSizeDouble * 100).ToString + "% Loaded"
            'End If
            If I >= 1000 Then
                I = 1
            End If
            frmPercent.Text = "%"
            frmPercent.PB.Value = I
            frmPercent.PB.Refresh()
            frmPercent.PB.Visible = True
            Application.DoEvents()
        Loop
        frmPercent.Close()
    End Sub

    Sub ArchiveContent(MachineID As String, CurrUserGuidID As String)

        FilesBackedUp = 0
        FilesSkipped = 0

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim LL As Integer = 0
        Dim cFolder As String = ""
        Dim pFolder As String = "XXX"
        Dim ArchiveMsg As String = ""
        Dim RetentionCode As String = ""
        Dim PauseThreadMS As Integer = 0
        Dim FOLDER_FQN As String = "XXX"
        Dim ParentDir As String = "XXX"

        LL = 1
        Dim bExplodeZipFile As Boolean = False : LL = 6
        Dim StackLevel As Integer = 0 : LL = 11
        Dim ListOfFiles As New Dictionary(Of String, Integer) : LL = 16
        Dim ERR_FQN As String = System.Configuration.ConfigurationManager.AppSettings("MoveErrorDir") : LL = 21
        LL = 26
        Dim file_FullName As String = "" : LL = 31
        Dim file_name As String = "" : LL = 36
        LL = 41
        If Not Directory.Exists(ERR_FQN) Then : LL = 46
            LL = 51
            Try
                Directory.CreateDirectory(ERR_FQN) : LL = 61
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                MessageBox.Show("FATAL ERROR: Could not create the directory " + ERR_FQN + ", aborting archive.")
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & LL.ToString)
                Return
            End Try
            LL = 101
        End If : LL = 106
        LL = 111
        Dim ListOfFilesToDelete As New SortedList(Of String, String) : LL = 116
        Dim DeleteOnArchive As String = "" : LL = 121
        LL = 126
        Dim ExistingFileTypes As New Dictionary(Of String, Integer) : LL = 131
        DBARCH.LoadFileTypeDictionary(ExistingFileTypes) : LL = 136
        LL = 141
        If CurrUserGuidID Is Nothing Then : LL = 146
            CurrUserGuidID = UIDcurr : LL = 151
        End If : LL = 156
        If CurrUserGuidID.Length = 0 Then : LL = 161
            CurrUserGuidID = UIDcurr : LL = 166
        End If : LL = 171
        LL = 176
        gContactsArchiving = True : LL = 181
        LL = 186
        If gRunMinimized = True Then : LL = 191
            frmNotify.WindowState = FormWindowState.Minimized : LL = 196
        Else : LL = 201
            frmNotify.Show() : LL = 206
        End If : LL = 211
        LL = 216
        If gRunMinimized Then : LL = 221
            frmNotify.WindowState = FormWindowState.Minimized : LL = 226
        End If : LL = 231
        LL = 236
        frmNotify.Text = "CONTENT" : LL = 241
        frmNotify.Label1.Text = "CONTENT" : LL = 246
        'frmNotify.Location = New Point(25, 300) : LL = 251
        LL = 256
        If gRunMode.Equals("M-END") Then : LL = 261
            frmNotify.WindowState = FormWindowState.Minimized : LL = 266
        End If : LL = 271
        LL = 276
        Dim iContent As Integer = 0 : LL = 281
        Dim LastVerNbr As Integer = 0 : LL = 286
        Dim NextVersionNbr As Integer = 0 : LL = 291
        LL = 296
        If DBARCH.isArchiveDisabled("CONTENT") = True Then : LL = 301
            gContentArchiving = False : LL = 306
            My.Settings("LastArchiveEndTime") = Now : LL = 311
            My.Settings.Save() : LL = 316
            Return : LL = 321
        End If : LL = 326
        LL = 331
        Dim PrevParentDir As String = "" : LL = 336
        LL = 341
        PROC.getCurrentApplications() : LL = 346
        LL = 351
        If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8000 : trace log.") : LL = 356
        LL = 361
        Dim RetentionYears As Integer = Val(DBARCH.getSystemParm("RETENTION YEARS")) : LL = 366
        LL = 371
        Dim rightNow As Date = Now.AddYears(RetentionYears) : LL = 376
        Dim RetentionExpirationDate As String = rightNow.ToString : LL = 381
        Dim EmailFQN As String = "" : LL = 386
        ZipFilesContent.Clear() : LL = 391
        Dim a(0) As String : LL = 396
        LL = 401
        CompletedPolls = CompletedPolls + 1 : LL = 406
        LL = 411
        If UseThreads = False Then SB5.Text = Now & " : Archiving data... standby: " & CompletedPolls : LL = 416
        LL = 421
        'Dim ActiveFolders(0)	:	LL = 	426
        Dim ActiveFolders As New List(Of String) : LL = 431
        Dim FolderName As String = "" : LL = 436
        Dim DeleteFile As Boolean = False : LL = 441
        Dim OcrDirectory As String = "" : LL = 446
        Dim OcrPdf As String = "" : LL = 451
        Dim ListOfDisabledDirs As New List(Of String) : LL = 456
        Dim FilesToArchive As New List(Of String) : LL = 461
        Dim FilesToArchiveID As New List(Of String) : LL = 461
        Dim LibraryList As New List(Of String) : LL = 466
        Dim DirLibraryList As New List(Of String) : LL = 471
        LL = 476
        Dim ThisFileNeedsToBeMoved As Boolean = False : LL = 481
        Dim ThisFileNeedsToBeDeleted As Boolean = False : LL = 486
        LL = 491

        '********************************************************************	:	LL = 	496
        frmNotify.lblPdgPages.Text = "LOCATING FILES"

        If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
            frmNotify.lblPdgPages.Text = ""
            ActiveFolders = DBLocal.getListenerfTopDir()
        Else
            frmNotify.lblPdgPages.Text = ""
            DBARCH.GetContentArchiveFileFolders(CurrUserGuidID, ActiveFolders, "") : LL = 501
            DBARCH.getDisabledDirectories(ListOfDisabledDirs) : LL = 506
        End If
        '********************************************************************	:	LL = 	511

        LL = 516
        Try : LL = 551
            PauseThreadMS = CInt(DBARCH.getUserParm("UserEmail_Pause")) : LL = 556
        Catch ex As Exception
            PauseThreadMS = 0
        End Try

        If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8001 : trace log.") : LL = 581
        If UseThreads = False Then PBx.Value = 0 : LL = 606
        If UseThreads = False Then PBx.Maximum = ActiveFolders.Count + 2 : LL = 611

        Dim isPublic As String = "" : LL = 621
        LL = 626
        Try
            For i As Integer = 0 To ActiveFolders.Count - 1 : LL = 636
                Application.DoEvents()
                Try
                    LL = 641
                    iContent += 1 : LL = 646
                    System.Threading.Thread.Sleep(50) : LL = 651
                    Try : LL = 656
                        frmNotify.Label1.Text = "CONTENT " + iContent.ToString : LL = 661
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                        GC.Collect()
                        GC.WaitForPendingFinalizers()
                    Catch ex As Exception
                        frmNotify.Close()
                        frmNotify.Show()
                        If gRunMode.Equals("M-END") Then
                            frmNotify.WindowState = FormWindowState.Minimized
                        End If
                    End Try
                    Application.DoEvents() : LL = 701
                    LL = 706
                    If gTerminateImmediately Then : LL = 711
                        Try : LL = 716
                            Me.Cursor = Cursors.Default : LL = 721
                        Catch ex As ThreadAbortException
                            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                            Thread.ResetAbort()
                        Catch ex As Exception
                            LOG.WriteToArchiveLog("ERROR ArchiveContent 22x: LL=" + LL.ToString + vbCrLf + ex.Message)
                        End Try
                        LL = 741
                        If UseThreads = False Then SB5.Text = "Terminated archive!" : LL = 746
                        frmNotify.Close() : LL = 751
                        gContentArchiving = False : LL = 756
                        My.Settings("LastArchiveEndTime") = Now : LL = 761
                        My.Settings.Save() : LL = 766
                        Return : LL = 771
                    End If : LL = 776
                    LL = 781
                    If UseThreads = False Then PBx.Value = i : LL = 786
                    If UseThreads = False Then PBx.Refresh() : LL = 791
                    Application.DoEvents() : LL = 796
                    LL = 801
                    If i >= ActiveFolders.Count Then : LL = 806
                        Exit For : LL = 811
                    End If : LL = 816
                    LL = 821

                    Dim FolderParmStr As String = ActiveFolders(i).ToString.Trim : LL = 826
                    Dim FolderParms() As String = FolderParmStr.Split("|") : LL = 831

                    If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                        FOLDER_FQN = Path.GetDirectoryName(ActiveFolders(i))
                        ParentDir = Path.GetDirectoryName(ActiveFolders(i))
                        GoTo Process01
                    End If

                    LL = 836
                    FOLDER_FQN = FolderParms(0) : LL = 841
                    LL = 846
                    If FOLDER_FQN.Trim.Length > 248 Then : LL = 851
                        LOG.WriteToArchiveLog("ERROR: folder name too long: " + FOLDER_FQN)
                        FOLDER_FQN = getShortDirName(FOLDER_FQN) : LL = 856
                        LOG.WriteToArchiveLog("NOTICE: Shortened name: " + FOLDER_FQN)
                        If FOLDER_FQN.Trim.Length > 248 Then : LL = 851
                            LOG.WriteToArchiveLog("ERROR: SHORTENED folder name too long, skipping ENTIRE DIRECTORY")
                            GoTo NextFolder
                        End If : LL = 861
                    End If : LL = 861

                    LL = 866
                    Dim bDisabled As Boolean = DBARCH.ckFolderDisabled(CurrUserGuidID, FOLDER_FQN) : LL = 871
                    LL = 876
                    If bDisabled Then : LL = 881
                        LOG.WriteToArchiveLog("Notice: Folder " + FOLDER_FQN + " disabled.") : LL = 886
                        GoTo NextFolder : LL = 891
                    End If : LL = 896
                    LL = 901
                    If gClipBoardActive = True Then Console.WriteLine("Archiving : " + FOLDER_FQN) : LL = 906
                    If InStr(FOLDER_FQN, "%userid%", CompareMethod.Text) Then : LL = 911
                        Dim S1 As String = "" : LL = 916
                        Dim S2 As String = "" : LL = 921
                        Dim iLoc As Integer = InStr(FOLDER_FQN, "%userid%", CompareMethod.Text) : LL = 926
                        S1 = Mid(FOLDER_FQN, 1, iLoc - 1) : LL = 931
                        S2 = Mid(FOLDER_FQN, iLoc + Len("%userid%")) : LL = 936
                        Dim UserName As String = System.Environment.UserName : LL = 941
                        FOLDER_FQN = S1 + UserName + S2 : LL = 946
                    End If : LL = 951
                    LL = 956
                    If ListOfDisabledDirs.Contains(FOLDER_FQN) Then : LL = 961
                        LOG.WriteToArchiveLog("NOTICE: Folder '" + FOLDER_FQN + "' is disabled from archive, skipping.") : LL = 966
                        GoTo NextFolder : LL = 976
                    End If : LL = 981
                    LL = 986
                    If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8002 :FOLDER_FQN : " + FOLDER_FQN) : LL = 991

                    Dim ParmMsg As String = "" : LL = 996
                    Dim FOLDER_IncludeSubDirs As String = FolderParms(1) : LL = 1001
                    ParmMsg += "FOLDER_IncludeSubDirs set to " + FOLDER_IncludeSubDirs + " for " + FOLDER_FQN + vbCrLf : LL = 1006

                    LL = 1011
                    Dim FOLDER_DBID As String = FolderParms(2) : LL = 1016
                    ParmMsg += "FOLDER_DBID  set to " + FOLDER_DBID + " for " + FOLDER_FQN + vbCrLf : LL = 1021
                    LL = 1026
                    Dim FOLDER_VersionFiles As String = FolderParms(3) : LL = 1031
                    ParmMsg += "FOLDER_VersionFiles  set to " + FOLDER_VersionFiles + " for " + FOLDER_FQN + vbCrLf : LL = 1036
                    LL = 1041
                    Dim DisableDir As String = FolderParms(4) : LL = 1046
                    ParmMsg += "DisableDir  set to " + DisableDir + " for " + FOLDER_FQN + vbCrLf : LL = 1051
                    LL = 1056
                    OcrDirectory = FolderParms(5) : LL = 1061
                    ParmMsg += "OcrDirectory  set to " + OcrDirectory + " for " + FOLDER_FQN + vbCrLf : LL = 1066
                    LL = 1071
                    ParentDir = FolderParms(7) : LL = 1076
                    ParmMsg += "ParentDir  set to " + ParentDir + " for " + FOLDER_FQN + vbCrLf : LL = 1081
                    LL = 1086
                    Dim skipArchiveBit As String = FolderParms(8) : LL = 1091
                    ParmMsg += "skipArchiveBit  set to " + skipArchiveBit + " for " + FOLDER_FQN + vbCrLf : LL = 1096
                    LL = 1101
                    OcrPdf = FolderParms(9) : LL = 1106
                    If OcrPdf.Equals("Y") Then : LL = 1111
                        gPdfExtended = True : LL = 1116
                    Else : LL = 1121
                        gPdfExtended = False : LL = 1126
                    End If : LL = 1131

                    LL = 1136
                    DeleteOnArchive = FolderParms(10) : LL = 1141
                    ParmMsg += "DeleteOnArchive set to " + DeleteOnArchive + " for " + FOLDER_FQN + vbCrLf : LL = 1146
                    LL = 1151
                    isPublic = FolderParms(11) : LL = 1156
                    ParmMsg += "isPublic set to " + isPublic + " for " + FOLDER_FQN + vbCrLf : LL = 1161
                    LL = 1166
                    '***************************	:	LL = 	1171
                    'MessageBox.Show(ParmMsg)	:	LL = 	1176
                    '***************************	:	LL = 	1181
                    LL = 1186
                    Dim ckArchiveBit As Boolean = False : LL = 1191
                    LL = 1196
                    If skipArchiveBit.ToUpper.Equals("TRUE") Then : LL = 1201
                        ckArchiveBit = True : LL = 1206
                    Else : LL = 1211
                        ckArchiveBit = False : LL = 1216
                    End If : LL = 1221
                    LL = 1226
                    FOLDER_FQN = UTIL.ReplaceSingleQuotes(FOLDER_FQN) : LL = 1231
                    LL = 1236
                    If (Directory.Exists(FOLDER_FQN)) Then : LL = 1241
                        If UseThreads = False Then SB5.Text = "Processing Dir: " + FOLDER_FQN : LL = 1246
                        If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8003 :FOLDER Exists: " + FOLDER_FQN) : LL = 1251
                        If ddebug Then LOG.WriteToArchiveLog("Archive Folder: " + FOLDER_FQN) : LL = 1256
                    Else : LL = 1261
                        If UseThreads = False Then SB5.Text = FOLDER_FQN + " does not exist, skipping." : LL = 1266
                        If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN) : LL = 1271
                        If ddebug Then LOG.WriteToArchiveLog("Archive Folder FOUND MISSING: " + FOLDER_FQN) : LL = 1276
                        GoTo NextFolder : LL = 1281
                    End If : LL = 1286
                    If (DisableDir.Equals("Y")) Then : LL = 1291
                        GoTo NextFolder : LL = 1296
                    End If : LL = 1301
                    LL = 1306
                    If ddebug Then : LL = 1311
                        If InStr(FOLDER_FQN, "'") > 0 Then : LL = 1316
                            Console.WriteLine("Single Quote found: " + FOLDER_FQN) : LL = 1321
                        End If : LL = 1326
                    End If : LL = 1331
                    LL = 1336
                    '******************************************************************************	:	LL = 	1341
Process01:
                    If PrevParentDir <> ParentDir Then : LL = 1346
                        Console.WriteLine(FOLDER_FQN) : LL = 1351
                        If InStr(FOLDER_FQN, "army", CompareMethod.Text) > 0 Then : LL = 1356
                            Console.WriteLine("HERRE 773") : LL = 1361
                        End If : LL = 1366
                        IncludedTypes = DBARCH.GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1371
                        ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1376
                    End If : LL = 1381
                    If IncludedTypes.Count = 0 Then : LL = 1386
                        IncludedTypes = DBARCH.GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1391
                        ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1396
                    End If : LL = 1401
                    '******************************************************************************	:	LL = 	1406
                    PrevParentDir = ParentDir : LL = 1411
                    If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8005 : Trace: " + FOLDER_FQN) : LL = 1416
                    Dim bChanged As Boolean = False : LL = 1421
                    LL = 1426
                    If FOLDER_FQN <> pFolder Then : LL = 1431
                        LL = 1436
                        If ddebug Then : LL = 1441
                            LOG.WriteToUploadLog("NOTICE ddebug - 200a: Processing Directory: " + FOLDER_FQN + " - defined to " + IncludedTypes.Count.ToString + " filetype codes.") : LL = 1446
                        End If : LL = 1451
                        LL = 1456
                        '********************************************************************************************************************	:	LL = 	1461
                        Dim tFOLDER_FQN As String = UTIL.RemoveSingleQuotes(FOLDER_FQN) : LL = 1466
                        Dim iCntFolderIsdefinedForArchive As Integer = 0 : LL = 1471
                        Dim SS As String = "Select COUNT(*) from Directory where FQN = '" + tFOLDER_FQN + "' and UserID = '" + CurrUserGuidID + "'" : LL = 1476
                        iCntFolderIsdefinedForArchive = DBARCH.iCount(SS) : LL = 1481
                        'If iCntFolderIsdefinedForArchive > 0 Then : LL = 1486
                        '    IncludedTypes = DBARCH.GetAllIncludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1491
                        '    ExcludedTypes = DBARCH.GetAllExcludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1496
                        '    IncludedTypes = DBARCH.AddIncludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1501
                        '    ExcludedTypes = DBARCH.AddExcludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1506
                        'Else : LL = 1511
                        '    IncludedTypes = DBARCH.GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1516
                        '    ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1521
                        '    IncludedTypes = DBARCH.AddIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1526
                        '    ExcludedTypes = DBARCH.AddExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1531
                        'End If : LL = 1536
                        '********************************************************************************************************************	:	LL = 	1541
                        LL = 1546
#If EnableSingleSource Then
                Dim tDirGuid As Guid  = GE.AddItem(FOLDER_FQN , "GlobalDirectory", False)	:	LL = 	1556
#End If
                        LL = 1566
                        Dim ParentDirForLib As String = "" : LL = 1571
                        Dim bLikToLib As Boolean = False : LL = 1576
                        bLikToLib = ARCH.isDirInLibrary(FOLDER_FQN, ParentDirForLib) : LL = 1581
                        LL = 1586
                        LOG.WriteToArchiveLog("frmMain : ArchiveContent :8006 : Folder Changed: " + FOLDER_FQN + " : " + pFolder) : LL = 1591
                        If Directory.Exists(FOLDER_FQN) Then
                            '** CHECK ACCESS TO FOLDER **
                            Dim f As FileIOPermission = New FileIOPermission(PermissionState.None)
                            f.AllLocalFiles = FileIOPermissionAccess.Read
                            Try
                                f.Demand()
                            Catch sx As Exception
                                LOG.WriteToArchiveLog("ERROR ArchiveContent Permissions: " + vbCrLf + sx.Message)
                            End Try
                            f = Nothing
                        Else
                            LOG.WriteToArchiveLog("ERROR frmMain : ArchiveContent :8006c : Folder '" + FOLDER_FQN + "' DOES NOT exist, skipping.")
                            GoTo NextFolder
                        End If
                        LL = 1596
                        FolderName = FOLDER_FQN : LL = 1601
                        LL = 1606
                        If bLikToLib Then : LL = 1611
                            ARCH.GetDirectoryLibraries(ParentDirForLib, LibraryList) : LL = 1616
                        Else : LL = 1621
                            ARCH.GetDirectoryLibraries(FOLDER_FQN, LibraryList) : LL = 1626
                        End If : LL = 1631
                        LL = 1636
                        Application.DoEvents() : LL = 1641
                        '** Verify that the DIR still exists	:	LL = 	1646
                        If (Directory.Exists(FolderName)) Then : LL = 1651
                            If UseThreads = False Then SB5.Text = "Processing Dir: " + FolderName : LL = 1656
                        Else : LL = 1661
                            If UseThreads = False Then SB5.Text = FolderName + " does not exist, skipping." : LL = 1666
                            If ddebug Then LOG.WriteToArchiveLog("frmMain : ArchiveContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN) : LL = 1671
                            GoTo NextFolder : LL = 1676
                        End If : LL = 1681
                        LL = 1686
                        RetentionCode = DBARCH.GetDirRetentionCode(ParentDir, CurrUserGuidID) : LL = 1691
                        If RetentionCode.Length > 0 Then : LL = 1696
                            RetentionYears = DBARCH.getRetentionPeriod(RetentionCode) : LL = 1701
                        Else : LL = 1706
                            RetentionYears = Val(DBARCH.getSystemParm("RETENTION YEARS")) : LL = 1711
                        End If : LL = 1716
                        LL = 1721
                        DBARCH.getDirectoryParms(a, ParentDir, CurrUserGuidID) : LL = 1726
                        LL = 1731
                        Dim IncludeSubDirs As String = a(0) : LL = 1736
                        Dim VersionFiles As String = a(1) : LL = 1741
                        Dim ckMetaData As String = a(2) : LL = 1746
                        OcrDirectory = a(3) : LL = 1751
                        RetentionCode = a(4) : LL = 1756
                        OcrPdf = a(5) : LL = 1761
                        isPublic = a(6) : LL = 1766
                        'a(0) = IncludeSubDirs	:	LL = 	1771
                        'a(1) = VersionFiles	:	LL = 	1776
                        'a(2) = ckMetaData	:	LL = 	1781
                        'a(3) = OcrDirectory	:	LL = 	1786
                        'a(4) = RetentionCode	:	LL = 	1791
                        'a(5) = OcrPdf	:	LL = 	1796
                        'a(6) = ckPublic	:	LL = 	1801
                        LL = 1806
                        '*****************************************************************************	:	LL = 	1811
                        '** Get all of the files in this folder	:	LL = 	1816
                        '*****************************************************************************	:	LL = 	1821
                        Dim StepTimer As Date = Now : LL = 1826
                        Dim bSubDirFlg As Boolean = False : LL = 1831
                        Try : LL = 1836
                            If ddebug Then LOG.WriteToArchiveLog("Starting File capture") : LL = 1841
                            FilesToArchive.Clear() : LL = 1846
                            If ddebug Then LOG.WriteToArchiveLog("Starting File capture: Init FilesToArchive") : LL = 1851
                            LL = 1856
                            '**************************************************************************	:	LL = 	1861
                            If UseThreads = False Then SB5.Text = FOLDER_FQN : LL = 1866
                            Application.DoEvents() : LL = 1871
                            LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "START") : LL = 1876
                            'NbrFilesInDir = DMA.getFilesInDir(FOLDER_FQN , FilesToArchive, IncludedTypes, ExcludedTypes, ckArchiveBit)	:	LL = 	1881
                            LL = 1886
                            Dim MSG As String = "" : LL = 1891
                            Dim strFileSize As String = "" : LL = 1896
                            Dim FilterList As New List(Of String) : LL = 1901
                            'Dim ArchiveAttr As Boolean = False	:	LL = 	1906
                            Dim sTemp As String = "" : LL = 1911
                            LL = 1916
                            For XX As Integer = 0 To IncludedTypes.Count - 1 : LL = 1921
                                sTemp = IncludedTypes(XX) : LL = 1926
                                If InStr(IncludedTypes(XX), ".") = 0 Then : LL = 1931
                                    sTemp = "." + sTemp : LL = 1936
                                End If : LL = 1941
                                If InStr(IncludedTypes(XX), "*") = 0 Then : LL = 1946
                                    sTemp = "*" + sTemp : LL = 1951
                                End If : LL = 1956
                                FilterList.Add(sTemp) : LL = 1961
                            Next : LL = 1966
                            LL = 1971

                            If IsNothing(FOLDER_IncludeSubDirs) Then
                                FOLDER_IncludeSubDirs = "Y"
                            End If

                            If FOLDER_IncludeSubDirs.ToUpper.Equals("Y") Then : LL = 1976
                                bSubDirFlg = True : LL = 1981
                            End If : LL = 1986
                            frmNotify.lblFileSpec.Text = "Standby, directory inventory." : LL = 1991
                            frmNotify.Refresh() : LL = 1996
                            Dim iInventory As Integer = 0 : LL = 2001
                            '***********************************************************************************************************************
                            If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                FilesToArchive = DBLocal.getListenerfiles()
                                FilesToArchiveID = DBLocal.getListenerfilesID()
                            Else
                                UTIL.GetFilesToArchive(iInventory, ckArchiveBit, bSubDirFlg, FOLDER_FQN, FilterList, FilesToArchive, IncludedTypes, ExcludedTypes) : LL = 2006
                            End If
                            If FilesToArchive.Count.Equals(0) Then
                                GoTo NextFolder
                            End If
                            '***********************************************************************************************************************
                            frmNotify.lblFileSpec.Text = "Directory inventory complete" : LL = 2011
                            frmNotify.Refresh() : LL = 2016
                            NbrFilesInDir = FilesToArchive.Count : LL = 2021
                            Console.WriteLine("Start: " + Now.ToString) : LL = 2026
                            LL = 2031
                            LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "STOP", StepTimer) : LL = 2036
                            '**************************************************************************	:	LL = 	2041
                            If ddebug Then LOG.WriteToArchiveLog("Starting File capture: Loaded files") : LL = 2046
                            If NbrFilesInDir = 0 Then : LL = 2051
                                LOG.WriteToArchiveLog("Archive Folder HAD NO FILES: " + FOLDER_FQN) : LL = 2056
                                'GoTo NextFolder	:	LL = 	2061
                            End If : LL = 2066
                            If ddebug Then LOG.WriteToArchiveLog("Starting File capture: start ckFilesNeedUpdate") : LL = 2071
                        Catch ex As IOException
                            LOG.WriteToArchiveLog("Thread 88 IO exception: " + ex.Message)
                            'LOG.WriteToArchiveLog("Thread 88 IO InnerException: " & ex.InnerException.ToString)
                            LOG.WriteToArchiveLog("FOLDER_FQN 88: " + FOLDER_FQN + vbCrLf + "LL = " + LL.ToString)
                            LOG.WriteToArchiveLog(ex.StackTrace)
                            GC.Collect()
                            GC.WaitForPendingFinalizers()
                        Catch ex As ThreadAbortException
                            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                            Thread.ResetAbort()
                        Catch ex As Exception
                            LOG.WriteToArchiveLog("ERROR Archive Folder Acquisition Failure : " + FOLDER_FQN + vbCrLf + "LL=" + LL.ToString)
                            Dim st As New StackTrace(True)
                            st = New StackTrace(ex, True)
                            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                            GC.Collect()
                            GC.WaitForPendingFinalizers()
                            GoTo NextFolder
                        End Try : LL = 2156
                        Dim ArchIndicator As String = "" : LL = 2161
                        '** Process all of the files	:	LL = 	2166
                        Dim iTotal As Integer = FilesToArchive.Count : LL = 2171
                        iContent += 1 : LL = 2176
                        Dim InventoryFQN As String = "" : LL = 2181
                        Dim ListenerDir As String = ""
                        Dim ArchCnt As Integer = FilesToArchive.Count

                        frmNotify.Text = "CONTENT: Uploading Files"
                        FilesToArchive.Sort()

                        Dim CurrFileSize As Integer = 0
                        Dim CurrFileName As String = ""
                        Dim CurrFQN As String = ""
                        Dim CurrExt As String = ""
                        Dim CurrCreateDate As Date = Now
                        Dim CurrLastUpdate As Date = Now

                        For K As Integer = 0 To FilesToArchive.Count - 1 : LL = 2186

                            If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                ParentDir = Path.GetDirectoryName(FilesToArchive(K))
                                ListenerDir = Path.GetDirectoryName(FilesToArchive(K))
                            End If

                            LL = 2191
                            bExplodeZipFile = True : LL = 2196
                            ThisFileNeedsToBeMoved = False : LL = 2201
                            ThisFileNeedsToBeDeleted = False : LL = 2206
                            LL = 2211
                            iContent += 1 : LL = 2216
                            LL = 2221
                            If K Mod 2 = 0 Then : LL = 2226
                                If UseThreads = False Then SB5.Text = K & " Of " & iTotal : LL = 2231
                                Application.DoEvents() : LL = 2236
                            End If : LL = 2241
                            LL = 2246
                            ArchIndicator = "" : LL = 2251
                            If FilesToArchive(K) = Nothing Then : LL = 2256
                                GoTo DoneWithIt : LL = 2261
                            End If : LL = 2266
                            LL = 2271
                            ''WDM Commentefd out oct-5-2020
                            'If FilesToArchive(K).Length > 5 Then : LL = 2276
                            '    ArchIndicator = Mid(FilesToArchive(K), 1, 5).ToUpper : LL = 2281
                            '    If ArchIndicator.Equals("False") And ckArchiveBit = True Then : LL = 2286
                            '        GoTo NextFile : LL = 2291
                            '    End If : LL = 2296
                            'End If : LL = 2301
                            LL = 2306
                            If PauseThreadMS > 0 Then : LL = 2311
                                System.Threading.Thread.Sleep(50) : LL = 2316
                            End If : LL = 2321
                            LL = 2326

                            '************************************************************************	:	LL = 	2331
                            Dim FileAttributes() As String = FilesToArchive(K).Split("|") : LL = 2336
                            Dim file_ArchiveBit As String = ""
                            Dim file_Extension As String = ""
                            Dim file_DirectoryName As String = ""

                            If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                'FileAttributes() = FilesToArchive(K).Split("|") : LL = 2336
                                file_ArchiveBit = ""
                                file_name = Path.GetFileName(FilesToArchive(K))
                                file_Extension = Path.GetExtension(FilesToArchive(K))
                                file_DirectoryName = Path.GetDirectoryName(FilesToArchive(K))
                                file_FullName = FilesToArchive(K)
                                'frmNotify.lblPdgPages.Text = "Dir: " + ParentDir
                                'frmNotify.lblFileSpec.Text = (K).ToString + " of " + ArchCnt.ToString + " : " + file_name
                            Else
                                file_ArchiveBit = FileAttributes(0).ToUpper : LL = 2341
                                file_name = FileAttributes(1) : LL = 2351
                                file_Extension = FileAttributes(2) : LL = 2356
                                file_DirectoryName = FileAttributes(3) : LL = 2361
                                file_FullName = file_DirectoryName + "\" + file_name
                                'frmNotify.lblPdgPages.Text = "Dir: " + file_DirectoryName
                                'frmNotify.lblFileSpec.Text = (K).ToString + " of " + ArchCnt.ToString + " : " + file_name
                            End If
                            frmNotify.Refresh()

                            'If File.Exists(file_FullName) Then
                            '    Dim Finfo As New FileInfo(file_FullName)
                            '    CurrFileSize = Finfo.Length
                            '    CurrFileName = Finfo.Name
                            '    CurrFQN = Finfo.FullName
                            '    CurrExt = Finfo.Extension
                            '    CurrCreateDate = Finfo.CreationTime
                            '    CurrLastUpdate = Finfo.LastWriteTime
                            '    Finfo = Nothing
                            'End If


                            LL = 2366
                            If K > FilesToArchive.Count Then : LL = 2371
                                GoTo NextFolder : LL = 2376
                            End If : LL = 2381
                            If FilesToArchive(K) = Nothing Then : LL = 2386
                                GoTo NextFile : LL = 2391
                            End If : LL = 2396
                            'wdm commented out oct-5-2020
                            'If ckArchiveBit = True And file_ArchiveBit.Equals("False") Then : LL = 2406
                            '    GoTo NextFile : LL = 2411
                            'End If : LL = 2416
                            LL = 2421
                            '************************************************************************	:	LL = 	2426
                            LL = 2431
                            InventoryFQN = file_DirectoryName + "\" + file_name : LL = 2436
                            If Not File.Exists(InventoryFQN) Then
                                If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                    Dim bUpdt = DBLocal.setListenerfileProcessed(InventoryFQN)
                                End If
                                GoTo NextFile
                            End If
                            'WDM Nov-02-2020 Commented out as it is not needed the bay before we rid ourselves of trump
                            'If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                            '    Dim bUpdt = DBLocal.setListenerfileProcessed(InventoryFQN)
                            '    If bUpdt Then
                            '        LOG.WriteToArchiveLog("NOTICE ArchiveContent BX01 skipped file : " + InventoryFQN)
                            '    Else
                            '        LOG.WriteToArchiveLog("ERROR ArchiveContent BX02 failed to set Processed flag: " + InventoryFQN)
                            '    End If
                            'End If
                            LL = 2441
                            Dim UpdateTimerMain As Date = Now : LL = 2446
                            LL = 2451
                            Application.DoEvents() : LL = 2491
                            LL = 2496
                            If gTerminateImmediately Then : LL = 2501
                                Try : LL = 2506
                                    Me.Cursor = Cursors.Default : LL = 2511
                                Catch ex As ThreadAbortException
                                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                                    Thread.ResetAbort()
                                Catch ex As Exception
                                    GC.Collect()
                                    GC.WaitForPendingFinalizers()
                                End Try : LL = 2526
                                If UseThreads = False Then SB5.Text = "Terminated archive!" : LL = 2531
                                frmNotify.Close() : LL = 2536
                                gContentArchiving = False : LL = 2541
                                My.Settings("LastArchiveEndTime") = Now : LL = 2546
                                My.Settings.Save() : LL = 2551
                                Return : LL = 2556
                            End If : LL = 2561
                            LL = 2566
                            If UseThreads = False Then SB5.Text = "Directory Files processed: " + K.ToString + " OF " & FilesToArchive.Count : LL = 2571
                            Application.DoEvents() : LL = 2576
                            LL = 2581
                            If ListOfDisabledDirs.Contains(file_DirectoryName) Then : LL = 2586
                                GoTo NextFile : LL = 2591
                            End If : LL = 2596

                            Dim file_CreationTime As Date = Nothing
                            Dim file_LastWriteTime As Date = Nothing
                            Dim file_LastAccessTime As Date = Nothing
                            Dim file_Length As Integer = 0

                            file_FullName = InventoryFQN
                            Dim FI As New FileInfo(InventoryFQN)
                            Try
                                file_CreationTime = FI.CreationTime : LL = 2621
                                file_LastWriteTime = FI.LastWriteTime : LL = 2626
                                file_LastAccessTime = FI.LastAccessTimeUtc : LL = 2631
                                file_Length = FI.Length

                                CurrFileSize = FI.Length
                                CurrFileName = FI.Name
                                CurrFQN = FI.FullName
                                CurrExt = FI.Extension
                                CurrCreateDate = FI.CreationTime
                                CurrLastUpdate = FI.LastWriteTime

                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR 22x1 ArchiveContent: " + ex.Message)
                            End Try

                            FI = Nothing

                            If file_Length = 0 Then : LL = 2606
                                GoTo NextFile : LL = 2611
                            End If : LL = 2616

                            LL = 2646
                            '*******************************************************************	:	LL = 	2651
                            '*******************************************************************	:	LL = 	2656
                            file_FullName = file_FullName.Replace("''", "'")
                            If Not File.Exists(file_FullName) Then
                                GoTo NextFile
                            End If

                            Dim FileHash As String = ENC.GenerateSHA512HashFromFile(file_FullName) : LL = 2661
                            Dim xlen As Integer = FileHash.Length
                            If FileHash.Length < 10 Then
                                LOG.WriteToArchiveLog("ERROR HASH: Skipping : " + file_FullName)
                                GoTo NextFile
                            End If

                            If FileHash.Contains("0x0x") Then
                                LOG.WriteToArchiveLog("ERROR HASH: Skipping : " + file_FullName)
                                FileHash.Replace("0x0x", "0x")
                            End If

                            'Changed the below line to NOT recalculate the same has but just set
                            'ImageHash = to FileHash
                            'Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(file_FullName) : LL = 2666
                            Dim ImageHash As String = FileHash
                            Dim NbrFilesFoundInRepo As Integer = DBARCH.getCountDataSourceFiles(file_FullName, FileHash) : LL = 2671

                            If FileHash.Length < 10 Then
                                LOG.WriteToArchiveLog("ERROR ArchiveContent HASH failed: " + file_FullName)
                                If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                    Dim bUpdt = DBLocal.setListenerfileProcessed(file_FullName)
                                    If Not bUpdt Then
                                        LOG.WriteToArchiveLog("ERROR 00A1 failed to set Processed flag: " + file_FullName)
                                    End If
                                End If
                                GoTo NextFile
                            End If

                            If (NbrFilesFoundInRepo > 0) Then : LL = 2681
                                frmNotify.BackColor = Color.LightSalmon : LL = 2686
                                '************************************************************************************************************************
                                Dim ExistingSourceGuid As String = DBARCH.getContentGuid(file_name, FileHash) : LL = 2691
                                DBARCH.saveContentOwner(ExistingSourceGuid, CurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID) : LL = 2696
                                '************************************************************************************************************************
                                If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                    Dim bUpdt = DBLocal.setListenerfileProcessed(file_FullName)
                                    If Not bUpdt Then
                                        LOG.WriteToArchiveLog("ERROR failed to set Processed flag: " + file_FullName)
                                    End If
                                End If
                                frmNotify.BackColor = Color.LightGoldenrodYellow : LL = 2701
                                GoTo NextFile : LL = 2706
                            End If : LL = 2711
                            frmNotify.BackColor = Color.LightGoldenrodYellow : LL = 2716
                            '*******************************************************************	:	LL = 	2721
                            '*******************************************************************	:	LL = 	2726
                            If DeleteOnArchive.Equals("Y") Then : LL = 2731
                                If Not ListOfFilesToDelete.ContainsKey(file_FullName) Then : LL = 2736
                                    ListOfFilesToDelete.Add(file_FullName, "UKN") : LL = 2741
                                End If : LL = 2746
                            End If : LL = 2751
                            '*******************************************************************	:	LL = 	2756
                            '*******************************************************************	:	LL = 	2761
                            Dim SourceGuid As String = DBARCH.getGuid() : LL = 2766
                            LL = 2771
                            LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "START") : LL = 2781
                            LL = 2786
                            If InStr(file_FullName, "\ECM\ErrorFile\", CompareMethod.Text) > 0 Then : LL = 2791
                                Console.WriteLine("Skipping: " + file_FullName) : LL = 2796
                                GoTo DoneWithIt : LL = 2801
                            End If : LL = 2806
                            LL = 2811
                            If gMaxSize > 0 Then : LL = 2816
                                If Val(file_Length) > gMaxSize Then : LL = 2821
                                    LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.") : LL = 2826
                                    GoTo NextFile : LL = 2831
                                End If : LL = 2836
                            End If : LL = 2841
                            LL = 2846
                            'file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 2851
                            'file_name = UTIL.RemoveSingleQuotes(file_name) : LL = 2856
                            LL = 2861
                            If file_Extension.Equals(".msg") Then : LL = 2866
                                LOG.WriteToArchiveLog("NOTICE: Content Archive File : " + file_FullName + " was found to be a message file, moved file.") : LL = 2871
                                If MsgNotification = False Or gRunUnattended = True Then : LL = 2876
                                    Dim DisplayMsg As String = "A message file was encounted in a backup directory." + vbCrLf : LL = 2881
                                    DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + vbCrLf : LL = 2886
                                    DisplayMsg = DisplayMsg + "To archive a MSG file, it should be imported into outlook." + vbCrLf : LL = 2891
                                    DisplayMsg = DisplayMsg + "This file has ALSO been added to the CONTENT repository." + vbCrLf : LL = 2896
                                    frmHelp.MsgToDisplay = DisplayMsg : LL = 2901
                                    frmHelp.CallingScreenName = "ECM Archive" : LL = 2906
                                    frmHelp.CaptionName = "MSG File Encounted in Content Archive" : LL = 2911
                                    frmHelp.Timer1.Interval = 10000 : LL = 2916
                                    frmHelp.Show() : LL = 2921
                                    MsgNotification = True : LL = 2926
                                    If gRunUnattended = True Then : LL = 2931
                                        LOG.WriteToArchiveLog("WARNING: ArchiveContent 100: " + vbCrLf + DisplayMsg) : LL = 2936
                                    End If : LL = 2941
                                End If : LL = 2946
                                LL = 2951
                                Dim EmailWorkingDirectory As String = DBARCH.getWorkingDirectory(CurrUserGuidID, "EMAIL WORKING DIRECTORY") : LL = 2956
                                LL = 2961
                                EmailWorkingDirectory = UTIL.RemoveSingleQuotes(EmailWorkingDirectory) : LL = 2966
                                file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 2971
                                EmailFQN = EmailWorkingDirectory + "\" + file_FullName.Trim : LL = 2976
                                LL = 2981
                                file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 2986
                                LL = 2991
                                If File.Exists(EmailFQN) Then : LL = 2996
                                    Dim tMsg As String = "Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN : LL = 3001
                                    LOG.WriteToArchiveLog(tMsg) : LL = 3006
                                    DBARCH.xTrace(965, "ArchiveContent", tMsg) : LL = 3011
                                    'FilesSkipped += 1	:	LL = 	3016
                                Else : LL = 3021
                                    File.Copy(file_FullName, EmailFQN) : LL = 3026
                                    Dim tMsg As String = "Email File Encountered, moved to EMAIL WORKING DIRECTORY and entered into repository: " + EmailFQN : LL = 3031
                                    DBARCH.xTrace(966, "ArchiveContent", tMsg) : LL = 3036
                                    'FilesSkipped += 1	:	LL = 	3041
                                End If : LL = 3046
                                'GoTo NextFile	:	LL = 	3051
                            End If : LL = 3056
                            LL = 3061
                            ARCH.ckSourceTypeCode(file_Extension) : LL = 3066
                            LL = 3071
                            Dim isZipFile As Boolean = ZF.isZipFile(file_FullName) : LL = 3156
                            LL = 3161
                            Application.DoEvents() : LL = 3166
                            LL = 3171
                            If Not isZipFile Then : LL = 3176
                                Dim bExt As Boolean = DMA.isExtExcluded(file_Extension, ExcludedTypes) : LL = 3181
                                If bExt Then : LL = 3186
                                    FilesSkipped += 1 : LL = 3191
                                    GoTo NextFile : LL = 3196
                                End If : LL = 3201
                                '** See if the STAR is in the INCLUDE list, if so, all files are included	:	LL = 	3206
                                bExt = DMA.isExtIncluded(file_Extension, ExcludedTypes) : LL = 3211
                                If bExt Then : LL = 3216
                                    FilesSkipped += 1 : LL = 3221
                                    GoTo NextFile : LL = 3226
                                End If : LL = 3231
                            Else : LL = 3236
                                Console.WriteLine("Zipfile Found.") : LL = 3241
                            End If : LL = 3246
                            LL = 3251
                            '** This NEEDS to be in a keyed array	:	LL = 	3256
                            Dim bcnt As Integer = 0 : LL = 3261
                            If ExistingFileTypes.ContainsKey(file_Extension.ToLower) Then : LL = 3266
                                bcnt = 1 : LL = 3271
                            ElseIf ExistingFileTypes.ContainsKey(file_Extension.ToUpper) Then : LL = 3276
                                bcnt = 1 : LL = 3281
                            End If : LL = 3286
                            'Dim bcnt As Integer = DBARCH.iGetRowCount("SourceType", "where SourceTypeCode = '" + file_Extension + "'")	:	LL = 	3291
                            LL = 3296
                            If bcnt = 0 Then : LL = 3301
                                Dim SubstituteFileType As String = DBARCH.getProcessFileAsExt(file_Extension) : LL = 3306
                                If SubstituteFileType = Nothing Then : LL = 3311
                                    Dim MSG As String = "The file type '" + file_Extension + "' is undefined." + vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + vbCrLf + "This will allow content to be archived, but not searched." : LL = 3316
                                    'Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)	:	LL = 	3321
                                    LL = 3326
                                    If ddebug Then LOG.WriteToArchiveLog(MSG) : LL = 3331
                                    LL = 3336
                                    UNASGND.setApplied("0") : LL = 3341
                                    UNASGND.setFiletype(file_Extension) : LL = 3346
                                    Dim xCnt As Integer = UNASGND.cnt_PK_AFTU(file_Extension) : LL = 3351
                                    If xCnt = 0 Then : LL = 3356
                                        UNASGND.Insert() : LL = 3361
                                    End If : LL = 3366
                                    LL = 3371
                                    Dim ST As New clsSOURCETYPE : LL = 3376
                                    ST.setSourcetypecode(file_Extension) : LL = 3381
                                    ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm") : LL = 3386
                                    ST.setIndexable("0") : LL = 3391
                                    ST.setStoreexternal(0) : LL = 3396
                                    ST.Insert() : LL = 3401
                                    DBARCH.LoadFileTypeDictionary(ExistingFileTypes) : LL = 3406
                                Else : LL = 3411
                                    file_Extension = SubstituteFileType : LL = 3416
                                End If : LL = 3421
                                LL = 3426
                            End If : LL = 3431
                            LL = 3436
                            EmailFQN = UTIL.RemoveSingleQuotes(EmailFQN) : LL = 3441
                            file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 3446
                            LL = 3451
                            Dim ssFile As String = "" : LL = 3456
                            ssFile = DMA.getFileName(file_FullName) : LL = 3461

                            Dim strNbr As String = UTIL.setFilelenUnits(file_Length) : LL = 3466
                            'wdmxx
                            frmNotify.Label1.Text = file_DirectoryName
                            frmNotify.lblPdgPages.Text = "@: " + strNbr + " / " + ssFile
                            frmNotify.lblFileSpec.Text = "fILE: " + K.ToString + " of " + FilesToArchive.Count.ToString
                            frmNotify.Refresh()

                            LL = 3481
                            Dim StoredExternally As String = "N" : LL = 3486
                            LL = 3491
                            'NbrFilesFoundInRepo = DBARCH.getCountDataSourceFiles(file_Name, FileHash)	:	LL = 	3496
                            'If (NbrFilesFoundInRepo = 0) Then	:	LL = 	3501
                            '    DBARCH.saveContentOwner(SourceGuid, CurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)	:	LL = 	3506
                            'End If	:	LL = 	3511
                            LL = 3516
                            Application.DoEvents() : LL = 3521
                            '***********************************************************************'	:	LL = 	3526
                            '** New file	:	LL = 	3531
                            '***********************************************************************'	:	LL = 	3536
                            Dim bSuccessExecution As Boolean = False : LL = 3541
                            Dim AttachmentCode As String = "C" : LL = 3546
                            LL = 3551
                            LOG.WriteToUploadLog("ArchiveContent: 00 File: " + Now.ToString + file_FullName)

                            '** FILE ALREADY EXISTS IN THE REPOSITORY
                            Dim NbrDUps As Integer = DBARCH.ckFileExistInRepo(MachineID, file_FullName)
                            If NbrDUps > 0 Then
                                '** Update the HASH and the Source Binary
                                '* Get the file hash
                                If FileHash.Length < 10 Then
                                    GoTo NextFile
                                End If
                                bSuccessExecution = DBARCH.UpdateSouceImage(MachineID, file_FullName, FileHash)
                                If Not bSuccessExecution Then
                                    LOG.WriteToArchiveLog("ERROR UpdateSouceImage 0X1: Failed to update ImageHash: " + file_FullName)
                                End If
                            End If

                            If NbrFilesFoundInRepo = 0 And NbrDUps = 0 Then : LL = 3556
                                LL = 3561
                                Dim TS As TimeSpan : LL = 3566
                                Dim sTime As Date = Now : LL = 3571
                                Dim sMin As String = "" : LL = 3576
                                Dim sSec As String = "" : LL = 3581
                                LOG.WriteToUploadLog("INFO: File - " + file_FullName + " was found to be NEW and not in the repository.") : LL = 3586
                                'Me.if UseThreads = false then SB5.Text = "Loading: " + file_Name	:	LL = 	3591
                                Application.DoEvents() : LL = 3596
                                LastVerNbr = 0 : LL = 3601
                                LL = 3606
                                frmNotify.lblFileSpec.ForeColor = Color.Black : LL = 3611
                                frmNotify.lblFileSpec.BackColor = Color.White : LL = 3616
                                Dim BytesLoading As Double = file_Length : LL = 3621
                                Dim Units As String = "" : LL = 3626
                                If BytesLoading > 1000 Then : LL = 3631
                                    BytesLoading = BytesLoading / 1000 : LL = 3636
                                    Units = "KB" : LL = 3641
                                    Math.Round(BytesLoading - 0.005, 2) : LL = 3646
                                End If : LL = 3651
                                If BytesLoading > 100000 Then : LL = 3656
                                    BytesLoading = BytesLoading / 1000 : LL = 3661
                                    Units = "KB" : LL = 3666
                                    Math.Round(BytesLoading - 0.005, 2) : LL = 3671
                                    frmNotify.lblFileSpec.BackColor = Color.WhiteSmoke : LL = 3676
                                    frmNotify.lblFileSpec.ForeColor = Color.Black : LL = 3681
                                End If : LL = 3686
                                If BytesLoading > 1000000 Then : LL = 3691
                                    BytesLoading = BytesLoading / 1000000 : LL = 3696
                                    Units = "MB" : LL = 3701
                                    Math.Round(BytesLoading - 0.005, 2) : LL = 3706
                                    frmNotify.lblFileSpec.ForeColor = Color.Red : LL = 3711
                                End If : LL = 3716
                                If BytesLoading > 1000000000 Then : LL = 3721
                                    BytesLoading = BytesLoading / 1000000000 : LL = 3726
                                    Units = "GB" : LL = 3731
                                    Math.Round(BytesLoading - 0.005, 2) : LL = 3736
                                    frmNotify.lblFileSpec.BackColor = Color.Red : LL = 3741
                                    frmNotify.lblFileSpec.ForeColor = Color.White : LL = 3746
                                End If : LL = 3751
                                LL = 3756
                                Application.DoEvents() : LL = 3761
                                LL = 3766
                                If Val(file_Length) > 1000000000 Then : LL = 3771
                                    'frmNotify.lblFileSpec.Text = "Huge File:" + BytesLoading.ToString + Units : LL = 3776
                                    frmNotify.lblPdgPages.Text = "Huge File:" + BytesLoading.ToString + Units : LL = 3776
                                    Application.DoEvents() : LL = 3781
                                    DisplayActivity = True : LL = 3786
                                    'WDM Commented out the below Oct 6, 2020
                                    'If ActivityThread Is Nothing Then : LL = 3791
                                    '    frmPercent.TopLevel = True : LL = 3796
                                    '    ActivityThread = New Thread(AddressOf ActivateProgressBar) : LL = 3801
                                    '    ActivityThread.Priority = ThreadPriority.Lowest : LL = 3806
                                    '    ActivityThread.IsBackground = True : LL = 3811
                                    '    ActivityThread.Start() : LL = 3816
                                    'End If : LL = 3821
                                    gfile_Length = Val(file_Length) : LL = 3826
                                ElseIf Val(file_Length) > 3000000 Then : LL = 3831
                                    gfile_Length = Val(file_Length) : LL = 3836
                                    'frmNotify.lblFileSpec.Text = "Large File:" + BytesLoading.ToString + Units : LL = 3841
                                    frmNotify.lblPdgPages.Text = "Large File:" + BytesLoading.ToString + Units
                                    Application.DoEvents() : LL = 3846
                                    DisplayActivity = True : LL = 3851
                                    'WDM Commented out the below Oct 6, 2020
                                    'If ActivityThread Is Nothing Then : LL = 3856
                                    '    frmPercent.TopLevel = True : LL = 3861
                                    '    ActivityThread = New Thread(AddressOf ActivateProgressBar) : LL = 3866
                                    '    ActivityThread.Priority = ThreadPriority.Lowest : LL = 3871
                                    '    ActivityThread.IsBackground = True : LL = 3876
                                    '    ActivityThread.Start() : LL = 3881
                                    'End If : LL = 3886
                                End If : LL = 3891
                                LL = 3896
                                StepTimer = Now : LL = 3901
                                LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content", "START") : LL = 3906
                                'file_FullName = UTIL.RemoveSingleQuotes(file_FullName)	:	LL = 	3911
                                'file_Name = UTIL.RemoveSingleQuotes(file_Name)	:	LL = 	3916
                                LL = 3921
                                'DOCS.setSourceguid(SourceGuid) : LL = 3926
                                'DOCS.setFqn(file_FullName) : LL = 3931
                                'DOCS.setSourcename(file_name) : LL = 3936
                                'DOCS.setSourcetypecode(file_Extension) : LL = 3941
                                'DOCS.setLastaccessdate(file_LastAccessTime) : LL = 3946
                                'DOCS.setCreatedate(file_CreationTime) : LL = 3951
                                'DOCS.setCreationdate(file_CreationTime) : LL = 3956
                                'DOCS.setLastwritetime(file_LastWriteTime) : LL = 3961
                                'DOCS.setDatasourceowneruserid(CurrUserGuidID) : LL = 3966
                                'DOCS.setVersionnbr("0") : LL = 3971
                                LL = 3976
                                '******************************* INSERT INTITAL CONTENT DATA **************************************
                                bSuccessExecution = DOCS.Insert(SourceGuid, FileHash) : LL = 3981
                                '**************************************************************************************************
                                If Not bSuccessExecution Then
                                    LOG.WriteToArchiveLog("ERROR Completion 12x: " + SourceGuid + " / " + FileHash)
                                End If
                                LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content: " + file_FullName, "STOP", StepTimer) : LL = 3986
                                LL = 3991
                                Dim bOcrNeeded As Boolean = DBARCH.ckOcrNeeded(file_Extension) : LL = 3996
                                LL = 4001
                                If bOcrNeeded Then : LL = 4006
                                    DBARCH.SetOcrProcessingParms(SourceGuid, "C", file_name) : LL = 4011
                                End If : LL = 4016
                                LL = 4021
                                If bSuccessExecution Then : LL = 4026
                                    Dim UpdateTimer As Date = Now : LL = 4066

                                    '*************************************************	:	LL = 	4076
                                    UpdateTimer = Now : LL = 4081
                                    Dim OriginalFileName As String = DMA.getFileName(file_FullName) : LL = 4091
                                    LL = 4096
                                    '**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	:	LL = 	4111
                                    '**WDM - this is where the upload magic occurs. Upload content to repository	:	LL = 	4116
                                    LOG.WriteToTimerLog("**** ArchiveContent-01", "UpdateSourceImageInRepo", "START")
                                    '******************************************************************************************************************************************************************************************************************************	:	LL = 	4101                                   
                                    SB.Text = "UPLOADING NOW"
                                    bSuccessExecution = DBARCH.UpdateSourceImageInRepo(OriginalFileName, UIDcurr, MachineIDcurr, SourceGuid, file_LastAccessTime, file_CreationTime, file_LastWriteTime, LastVerNbr, file_FullName, RetentionCode, isPublic, FileHash) : LL = 4121
                                    SB.Text = ""
                                    '******************************************************************************************************************************************************************************************************************************	:	LL = 	4101
                                    If bSuccessExecution Then
                                        DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName)
                                        Dim bUpdt = DBLocal.setListenerfileProcessed(file_FullName)
                                        If Not bUpdt Then
                                            LOG.WriteToArchiveLog("ERROR failed to set Processed flag: " + file_FullName)
                                        End If
                                    Else
                                        LOG.WriteToArchiveLog("ERROR: ArchiveContent-AA1 Failed load: " + vbCrLf + file_FullName)
                                    End If
                                    LOG.WriteToTimerLog("****ArchiveContent-01", "UpdateSourceImageInRepo", "STOP", UpdateTimer)
                                    UpdateTimer = Now
                                    LOG.WriteToTimerLog("**** ArchiveContent-01", "saveContentOwner", "START")
                                    DBARCH.saveContentOwner(SourceGuid, CurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID) : LL = 4126
                                    LOG.WriteToTimerLog("****ArchiveContent-01", "saveContentOwner", "STOP", UpdateTimer)
                                    '**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	:	LL = 	4131
                                    '******************************************************************************************************************************************************************************************************************************	:	LL = 	4141
                                    LL = 4146
                                    If Not DeleteOnArchive.Equals("Y") Then
                                        Try
                                            DBLocal.addInventoryForce(file_FullName, ckArchiveBit) : LL = 4147
                                        Catch ex As Exception
                                            LOG.WriteToArchiveLog("ERROR ArchiveContent 02xx LocalDB Failed to add: " + file_FullName)
                                        End Try

                                    Else
                                        DBLocal.delFile(file_FullName) : LL = 4148
                                    End If


                                    If CurrFileName.Length > 0 Then
                                        If CurrExt.Trim.Length = 0 Then
                                            CurrExt = Path.GetExtension(CurrFileName)
                                        End If
                                        Dim NewSql As String = "Update DataSource set OriginalFileType = '" + CurrExt + "' , CreateDate = '" + CurrCreateDate.ToString + "', LastWriteTime = '" + CurrLastUpdate.ToString + "'  where SourceGuid = '" + SourceGuid + "' "
                                        DBARCH.ExecuteSqlNewConn(90076, NewSql)

                                    End If
                                    '****************************************************************************************************************************	:	LL = 	4161
                                    If Not bSuccessExecution Then
                                        'Dim isIncludedAsSubDir As Boolean = DBARCH.isSubDirIncluded(FOLDER_FQN )
                                        Dim MySql As String = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'"
                                        DBARCH.ExecuteSqlNewConn(90314, MySql)
                                        LOG.WriteToErrorLog("Unrecoverable LOAD Error - removed file '" + file_FullName + "' from the repository.")
                                        If UseThreads = False Then SB5.BackColor = Color.Red
                                        If UseThreads = False Then SB5.ForeColor = Color.Yellow

                                        Dim DisplayMsg As String = "A source file failed to load. Review ERROR log." + vbCrLf + file_FullName + "LL: " + LL.ToString
                                        frmHelp.MsgToDisplay = DisplayMsg
                                        frmHelp.CallingScreenName = "ECM Archive"
                                        frmHelp.CaptionName = "Fatal Load Error"
                                        frmHelp.Timer1.Interval = 10000
                                        frmHelp.Show()
                                    Else : LL = 4236
                                        If LibraryList.Count > 0 Then : LL = 4241
                                            For II As Integer = 0 To LibraryList.Count - 1 : LL = 4246
                                                Dim LibraryName As String = LibraryList(II) : LL = 4251
                                                ARCH.AddLibraryItem(SourceGuid, file_name, file_Extension, LibraryName) : LL = 4256
                                            Next : LL = 4261
                                        End If : LL = 4266
                                    End If : LL = 4271
                                Else : LL = 4276
                                    LOG.WriteToArchiveLog("Error 22.345.23a - Failed to add source:" + file_FullName) : LL = 4281
                                End If : LL = 4286
                                LL = 4291
                                'file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 4296
                                'file_name = UTIL.RemoveSingleQuotes(file_name) : LL = 4301
                                LL = 4306
                                If bSuccessExecution Then : LL = 4311
                                    LL = 4321
                                    'file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 4326
                                    'file_name = UTIL.RemoveSingleQuotes(file_name) : LL = 4331
                                    LL = 4336
                                    If DeleteOnArchive.Equals("Y") Then : LL = 4341
                                        If ListOfFilesToDelete.ContainsKey(file_FullName) Then : LL = 4346
                                            Try
                                                ListOfFilesToDelete.Item(file_FullName) = "DELETE" : LL = 4361
                                            Catch ex As ThreadAbortException
                                                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                                                Thread.ResetAbort()
                                            Catch ex As Exception
                                                Console.WriteLine(ex.Message + vbCrLf + "LL=" + LL.ToString)
                                                Dim st As New StackTrace(True)
                                                st = New StackTrace(ex, True)
                                                LOG.WriteToArchiveLog("LL=" + LL.ToString)
                                            End Try
                                        ElseIf Not ListOfFilesToDelete.ContainsKey(file_FullName) Then : LL = 4396
                                            ListOfFilesToDelete.Add(file_FullName, "DELETE") : LL = 4401
                                        End If : LL = 4406
                                    End If : LL = 4411
                                    LL = 4416
                                    'If CRC .Length = 0 Then	:	LL = 	4421
                                    '    CRC  = ENC.getCountDataSourceFiles(file_FullName )	:	LL = 	4426
                                    'End If	:	LL = 	4431
                                    'ARCH.UpdateDocCrc(SourceGuid, CRC )	:	LL = 	4436
                                    LL = 4441
                                    DBARCH.UpdateCurrArchiveStats(file_FullName, file_Extension) : LL = 4446
                                Else : LL = 4451
                                    FilesSkipped += 1 : LL = 4456
                                    If ddebug Then LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.") : LL = 4461
                                    If ddebug Then LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.") : LL = 4466
                                    Debug.Print("FAILED TO LOAD: " + file_FullName) : LL = 4471
                                    If ddebug Then LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :FAILED TO LOAD: 8013a: " + file_FullName) : LL = 4476
                                End If : LL = 4481
                                LL = 4486
                                If Val(file_Length) > 1000000 Then : LL = 4491
                                    If UseThreads = False Then SB5.Text = "Large file Load completed..." : LL = 4496
                                    DisplayActivity = False : LL = 4501
                                    'WDM Commented out the below Oct 6, 2020
                                    'If Not ActivityThread Is Nothing Then : LL = 4506
                                    '    ActivityThread.Abort() : LL = 4511
                                    '    ActivityThread = Nothing : LL = 4516
                                    'End If : LL = 4521
                                    Me.PBx.Value = 0 : LL = 4526
                                    Application.DoEvents() : LL = 4531
                                End If : LL = 4536
                                If bSuccessExecution Then : LL = 4541
                                    Dim UpdateTimer2 As Date = Now : LL = 4546
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "START") : LL = 4551
                                    LL = 4556
                                    Application.DoEvents() : LL = 4561
                                    DBARCH.UpdateDocFqn(SourceGuid, file_FullName) : LL = 4566
                                    DBARCH.UpdateDocSize(SourceGuid, file_Length) : LL = 4571
                                    DBARCH.UpdateDocDir(SourceGuid, file_FullName) : LL = 4576
                                    DBARCH.UpdateDocOriginalFileType(SourceGuid, file_Extension) : LL = 4581
                                    DBARCH.UpdateZipFileIndicator(SourceGuid, isZipFile) : LL = 4586
                                    Application.DoEvents() : LL = 4591
                                    If ddebug Then LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :Success: 8015") : LL = 4596
                                    If Not isZipFile Then : LL = 4601
                                        'Dim TheFileIsArchived As Boolean = True	:	LL = 	4606
                                        'DMA.setFileArchiveAttributeSet(file_FullName, TheFileIsArchived)	:	LL = 	4611
                                        DMA.setArchiveBitOff(file_FullName) : LL = 4616
                                    End If : LL = 4621
                                    LL = 4626
                                    'DBARCH.delFileParms(SourceGuid)	:	LL = 	4631
                                    'If CRC .Length = 0 Then	:	LL = 	4636
                                    '    CRC  = ENC.getCountDataSourceFiles(file_FullName )	:	LL = 	4641
                                    'End If	:	LL = 	4646
                                    'ARCH.UpdateDocCrc(SourceGuid, CRC )	:	LL = 	4651
                                    LL = 4656
                                    '** Removed Attribution Classification by WDM 9/10/2009	:	LL = 	4661
                                    'UpdateSrcAttrib(SourceGuid, "CRC", CRC , file_Extension)	:	LL = 	4666
                                    UpdateSrcAttrib(SourceGuid, "FILENAME", file_name, file_Extension) : LL = 4671
                                    UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreationTime, file_Extension) : LL = 4676
                                    UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, file_Extension) : LL = 4681
                                    UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessTime, file_Extension) : LL = 4686
                                    UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, file_Extension) : LL = 4691
                                    LL = 4696
                                    'DBARCH.AddMachineSource(file_FullName, SourceGuid)	:	LL = 	4701
                                    LL = 4706
                                    If Val(file_Length) > 1000000000 Then : LL = 4711
                                        'FrmMDIMain.SB4.Text = "Extreme File: " + file_Length + " bytes - standby"	:	LL = 	4716
                                    ElseIf Val(file_Length) > 2000000 Then : LL = 4721
                                        'FrmMDIMain.SB4.Text = "Large File: " + file_Length + " bytes"	:	LL = 	4726
                                    End If : LL = 4731
                                    If (LCase(file_Extension).Equals(".mp3") Or LCase(file_Extension).Equals(".wma") Or LCase(file_Extension).Equals("wma")) Then : LL = 4736
                                        MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension) : LL = 4741
                                        Application.DoEvents() : LL = 4746
                                    ElseIf (LCase(file_Extension).Equals(".tiff") Or LCase(file_Extension).Equals(".jpg")) Then : LL = 4751
                                        '** This functionality will be added at a later time	:	LL = 	4756
                                        'KAT.getXMPdata(file_FullName)	:	LL = 	4761
                                        Application.DoEvents() : LL = 4766
                                    ElseIf (LCase(file_Extension).Equals(".png") Or LCase(file_Extension).Equals(".gif")) Then : LL = 4771
                                        '** This functionality will be added at a later time	:	LL = 	4776
                                        'KAT.getXMPdata(file_FullName)	:	LL = 	4781
                                        Application.DoEvents() : LL = 4786
                                        'ElseIf LCase(file_Extension).Equals(".wav") Then	:	LL = 	4791
                                        '    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)	:	LL = 	4796
                                    ElseIf LCase(file_Extension).Equals(".wma") Then : LL = 4801
                                        MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension) : LL = 4806
                                    ElseIf LCase(file_Extension).Equals(".tif") Then : LL = 4811
                                        '** This functionality will be added at a later time	:	LL = 	4816
                                        'KAT.getXMPdata(file_FullName)	:	LL = 	4821
                                        Application.DoEvents() : LL = 4826
                                    End If : LL = 4831
                                    Application.DoEvents() : LL = 4836
                                    If (LCase(file_Extension).Equals(".doc") _
                                            Or LCase(file_Extension).Equals(".docx")) _
                                            And ckMetaData.Equals("Y") Then : LL = 4851
                                        GetWordDocMetadata(file_FullName, SourceGuid, file_Extension) : LL = 4856
                                        GC.Collect() : LL = 4861
                                    End If : LL = 4866
                                    If (file_Extension.Equals(".xls") _
                                                Or file_Extension.Equals(".xlsx") _
                                                Or file_Extension.Equals(".xlsm")) _
                                                And ckMetaData.Equals("Y") Then : LL = 4886
                                        GetExcelMetaData(file_FullName, SourceGuid, file_Extension) : LL = 4891
                                        GC.Collect() : LL = 4896
                                    End If : LL = 4901
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "STOP", UpdateTimer2) : LL = 4906
                                End If : LL = 4911
                                LL = 4916
                                TS = Now().Subtract(sTime) : LL = 4921
                                sMin = TS.Minutes.ToString : LL = 4926
                                sSec = TS.Seconds.ToString : LL = 4931

                                'frmNotify.lblPdgPages.Text = "Size: " + BytesLoading.ToString + Units + " / " + TS.Hours.ToString + ":" + sMin + ":" + sSec
                                'frmNotify.Refresh()
                                'frmNotify.lblFileSpec.Text = "Size: " + BytesLoading.ToString + Units + " / " + TS.Hours.ToString + ":" + sMin + ":" + sSec : LL = 4936
                                'frmNotify.Refresh() : LL = 4941

                                Application.DoEvents() : LL = 4946
                                LL = 4951
                                isZipFile = ZF.isZipFile(file_FullName) : LL = 4956
                                If isZipFile = True Then : LL = 4961
                                    Dim ExistingParentZipGuid As String = DBARCH.GetGuidByFqn(file_FullName, 0) : LL = 4966
                                    bExplodeZipFile = False : LL = 4971
                                    StackLevel = 0 : LL = 4976
                                    ListOfFiles.Clear() : LL = 4981
                                    If ExistingParentZipGuid.Length > 0 Then : LL = 4986
                                        DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, False) : LL = 4991
                                        ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles) : LL = 4996
                                        DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName)
                                    Else : LL = 5006
                                        DBLocal.addZipFile(file_FullName, SourceGuid, False) : LL = 5011
                                        ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles) : LL = 5016
                                        DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName)
                                    End If : LL = 5026
                                End If : LL = 5031
                                LL = 5036

                            End If : LL = 5041
NextFile:                   LL = 5046
                            If UseThreads = False Then SB5.Text = "Processing Dir: " + FolderName + " # " + K.ToString : LL = 5051
                            If ddebug Then LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :Success: 8032") : LL = 5056
                            Application.DoEvents() : LL = 5061

                            If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                Dim bUpdt = DBLocal.setListenerfileProcessed(file_FullName)
                                If Not bUpdt Then
                                    LOG.WriteToArchiveLog("ERROR 12x1 failed to set Processed flag: " + file_FullName)
                                End If
                            End If

                            LL = 5066
                            If gTerminateImmediately Then : LL = 5071
                                If UseThreads = False Then SB5.Text = "Terminated archive!" : LL = 5076
                                frmNotify.Close() : LL = 5081
                                gContentArchiving = False : LL = 5086
                                My.Settings("LastArchiveEndTime") = Now : LL = 5091
                                My.Settings.Save() : LL = 5096
                                Return : LL = 5101
                            End If : LL = 5106
                            LL = 5111
                            If ckArchiveBit = True And Not file_name Is Nothing Then : LL = 5116
                                DMA.setArchiveBitOff(file_FullName) : LL = 5121
                            End If : LL = 5126
DoneWithIt:                 LL = 5131
                            '******************************************************	:	LL = 	5136
                            If DeleteOnArchive.ToUpper.Equals("Y") And ThisFileNeedsToBeDeleted And file_FullName IsNot Nothing Then : LL = 5141
                                LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "DELETED", UpdateTimerMain) : LL = 5146
                                Try : LL = 5151
                                    If ListOfFilesToDelete.ContainsKey(file_FullName) Then : LL = 5156
                                        ListOfFilesToDelete.Item(file_FullName) = "DELETE" : LL = 5161
                                    End If : LL = 5166
                                    'ISO.saveIsoFile(" FilesToDelete.dat", file_FullName + "|")	:	LL = 	5171
                                    'File.Delete(file_FullName)	:	LL = 	5176
                                Catch ex As ThreadAbortException
                                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                                    Thread.ResetAbort()
                                Catch ex As Exception
                                    LOG.WriteToArchiveLog("Warning AF2 Failed to DELETE: " + file_FullName, ex)
                                    Dim st As New StackTrace(True)
                                    st = New StackTrace(ex, True)
                                    LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                                    LOG.WriteToArchiveLog("LL=" + LL.ToString)
                                End Try
                            ElseIf DeleteOnArchive.Equals("Y") And ThisFileNeedsToBeMoved And file_FullName IsNot Nothing Then : LL = 5211
                                LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "MOVED", UpdateTimerMain) : LL = 5216
                                Try : LL = 5221
                                    Dim FI2 As New FileInfo(file_FullName) : LL = 5226
                                    Dim fNameOnly As String = FI2.Name : LL = 5231
                                    Dim fDirName As String = FI2.DirectoryName : LL = 5236
                                    Dim NewName As String = ERR_FQN + "\" + fNameOnly : LL = 5241
                                    FI2 = Nothing : LL = 5246
                                    File.Move(file_FullName, NewName) : LL = 5251
                                Catch ex As ThreadAbortException
                                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                                    Thread.ResetAbort()
                                Catch ex As Exception
                                    LOG.WriteToArchiveLog("ERROR Failed to MOVE: " + file_FullName)
                                    Dim st As New StackTrace(True)
                                    st = New StackTrace(ex, True)
                                    LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                                    LOG.WriteToArchiveLog("LL=" + LL.ToString)
                                End Try
                            End If : LL = 5286
                            '******************************************************	:	LL = 	5291
                            If file_FullName IsNot Nothing Then : LL = 5296
                                LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "STOP", UpdateTimerMain) : LL = 5301
                            End If : LL = 5306
                        Next : LL = 5311
                    Else : LL = 5316
                        If ddebug Then Debug.Print("Duplicate Folder: " + FolderName) : LL = 5321
                        If ddebug Then LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :Success: 8034") : LL = 5326
                    End If : LL = 5331
NextFolder:
                    pFolder = FolderName : LL = 5341
                    If gTerminateImmediately Then : LL = 5346
                        Me.Cursor = Cursors.Default : LL = 5351
                        If UseThreads = False Then SB5.Text = "Terminated archive!" : LL = 5356
                        frmNotify.Close() : LL = 5361
                        gContentArchiving = False : LL = 5366
                        My.Settings("LastArchiveEndTime") = Now : LL = 5371
                        My.Settings.Save() : LL = 5376
                        Return : LL = 5381
                    End If : LL = 5386
                Catch ex As Exception
                    Dim st As New StackTrace(True)
                    st = New StackTrace(ex, True)
                    LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                    LOG.WriteToArchiveLog("LL=" + LL.ToString)
                    LOG.WriteToArchiveLog("ERROR: Failed to ArchiveContent: " + file_FullName + ", skipping : " + ex.Message)
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                End Try
            Next : LL = 5391
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("error ArchiveContent Thread 90 - caught ThreadAbortException - resetting.")
            LOG.WriteToArchiveLog("LL=" + LL.ToString)
            Thread.ResetAbort()
        Catch ex As Exception
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("ERROR: ArchiveContent #22621: " + ex.Message)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            LOG.WriteToArchiveLog("LL=" + LL.ToString)
        Finally
            frmNotify.Text = "CONTENT:"
            If DeleteOnArchive.Equals("Y") Then : LL = 5426
                For Each FQN As String In ListOfFilesToDelete.Keys : LL = 5431
                    Dim IDX As Integer = ListOfFilesToDelete.IndexOfKey(FQN) : LL = 5436
                    Dim tAction As String = ListOfFilesToDelete.Values(IDX) : LL = 5441
                    Try : LL = 5446
                        If tAction.Equals("DELETE") Then : LL = 5451
                            If File.Exists(FQN) Then : LL = 5456
                                ISO.saveIsoFile(" FilesToDelete.dat", FQN + "|") : LL = 5461
                                Try
                                    File.Delete(FQN) : LL = 5466
                                Catch ex As Exception
                                    LOG.WriteToArchiveLog("DELETE FAILURE 00|" + FQN)
                                End Try
                            End If : LL = 5471
                        ElseIf tAction.Equals("MOVE") Then : LL = 5476
                            If File.Exists(FQN) Then : LL = 5481
                                Dim FI As New FileInfo(FQN) : LL = 5486
                                Dim fNameOnly As String = FI.Name : LL = 5491
                                Dim fDirName As String = FI.DirectoryName : LL = 5496
                                Dim NewName As String = ERR_FQN + "\" + fNameOnly : LL = 5501
                                FI = Nothing : LL = 5506
                                File.Move(FQN, NewName) : LL = 5511
                            End If : LL = 5516
                        Else
                            LOG.WriteToArchiveLog("ERROR/Advisory Notice - File " + FQN + " had no known disposition, it was moved to the error directory.") : LL = 5526
                            If File.Exists(FQN) Then : LL = 5531
                                Dim FI As New FileInfo(FQN) : LL = 5536
                                Dim fNameOnly As String = FI.Name : LL = 5541
                                Dim fDirName As String = FI.DirectoryName : LL = 5546
                                Dim NewName As String = ERR_FQN + "\" + fNameOnly : LL = 5551
                                FI = Nothing : LL = 5556
                                File.Move(FQN, NewName) : LL = 5561
                            End If : LL = 5566
                        End If : LL = 5571
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch ex As Exception
                        If Not gRunUnattended Then
                            MessageBox.Show("Could not remove the file " + FQN + "." + vbCrLf + ex.Message)
                        Else
                            LOG.WriteToArchiveLog("Could not remove the file " + FQN + ". - " + ex.Message)
                            Dim st As New StackTrace(True)
                            st = New StackTrace(ex, True)
                            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
                            LOG.WriteToArchiveLog("LL=" + LL.ToString)
                        End If
                    End Try
                Next : LL = 5626
            End If : LL = 5631
        End Try : LL = 5636
        GC.Collect()
        GC.WaitForPendingFinalizers()

        LL = 5641
        If UseThreads = False Then SB5.Text = "Files Completed" : LL = 5646
        PBx.Value = 0 : LL = 5651
        LL = 5656
        'Timer1.Enabled = True	:	LL = 	5661
        If ddebug Then LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with Content Archive.") : LL = 5666
        LL = 5671
        PROC.getProcessesToKill() : LL = 5676
        PROC.KillOrphanProcesses() : LL = 5681
        'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"	:	LL = 	5686
        LL = 5691
        StackLevel = 0 : LL = 5696
        ListOfFiles.Clear() : LL = 5701
        LL = 5706
        For i As Integer = 0 To ZipFilesContent.Count - 1 : LL = 5711
            bExplodeZipFile = False : LL = 5716
            'FrmMDIMain.SB.Text = "Processing Quickref"	:	LL = 	5721
            'If i >= 24 Then	:	LL = 	5726
            '    Debug.Print("here")	:	LL = 	5731
            'End If	:	LL = 	5736
            Dim cData As String = ZipFilesContent(i).ToString : LL = 5741
            Dim ParentGuid As String = "" : LL = 5746
            Dim FQN As String = "" : LL = 5751
            Dim K As Integer = InStr(cData, "|") : LL = 5756
            FQN = Mid(cData, 1, K - 1) : LL = 5761
            ParentGuid = Mid(cData, K + 1) : LL = 5766
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, False, RetentionCode, isPublic, StackLevel, ListOfFiles) : LL = 5771
        Next : LL = 5776

        LL = 5781
        ListOfFiles = Nothing : LL = 5786
        GC.Collect() : LL = 5791
        LL = 5796
        frmNotify.Close() : LL = 5801
        gContactsArchiving = False : LL = 5806
        gContentArchiving = False : LL = 5811
        LL = 5816
        My.Settings("LastArchiveEndTime") = Now : LL = 5821
        My.Settings.Save() : LL = 5826
        LL = 5831
        frmNotify.lblFileSpec.Text = "Content archive complete." : LL = 5836
        frmNotify.Refresh() : LL = 5841
        LL = 5846

        If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
            bUpdated = DBLocal.removeListenerfileProcessed(FilesToArchiveID)
            If Not bUpdated Then
                LOG.WriteToArchiveLog("ERROR 01 failed removeListenerfileProcessed...")
            End If
        End If

        frmNotify.Close()

        GC.Collect()
        GC.WaitForPendingFinalizers()
        GC.WaitForFullGCComplete()

    End Sub

    Sub ArchiveData(ByVal UID As String, ByVal FileDirectory As String, ByVal TopFolder As String, ByRef SL As SortedList)

        CompletedPolls = CompletedPolls + 1
        SB.Text = Now & " : Archiving data... standby: " & CompletedPolls

        Dim ActiveFolders(0) As String
        Dim FolderName As String = ""
        Dim DeleteFile As Boolean = False

        Dim ArchiveEmails As String = ""
        Dim RemoveAfterArchive As String = ""
        Dim SetAsDefaultFolder As String = ""
        Dim ArchiveAfterXDays As String = ""
        Dim RemoveAfterXDays As String = ""
        Dim RemoveXDays As String = ""
        Dim ArchiveXDays As String = ""
        Dim DB_ID As String = ""
        Dim ArchiveOnlyIfRead As String = ""

        Dim EmailFolders(0) As String

        DBARCH.GetEmailFolders(gCurrUserGuidID, EmailFolders)

        For i As Integer = 0 To UBound(EmailFolders)
            FolderName = EmailFolders(i).ToString.Trim
            Dim BB As Boolean = DBARCH.GetEmailFolderParms(TopFolder, gCurrUserGuidID, FolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, ArchiveOnlyIfRead)
            If BB Then

                'ARCH.getSubFolderEmails(FolderName , bDeleteMsg)
                ARCH.getSubFolderEmailsSenders(UID, TopFolder, FolderName, DeleteFile, ArchiveEmails,
                RemoveAfterArchive,
                SetAsDefaultFolder,
                ArchiveAfterXDays,
                RemoveAfterXDays,
                RemoveXDays,
                ArchiveXDays, FileDirectory)
                'ARCH.GetEmails(FolderName , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , DB_ID )
            End If
        Next

    End Sub

    ' Public Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles
    ' Timer1.Tick If ckDisable.Checked Then SB.Text = "DISABLE ALL is checked - no archive allowed."
    ' Return End If Dim frm As Form Try For Each frm In My.Application.OpenForms
    ' Application.DoEvents() If frm Is My.Forms.frmNotify Then Return End If If frm Is
    ' My.Forms.frmNotify2 Then Return End If If frm Is My.Forms.frmExchangeMonitor Then Return End If
    ' Next Catch ex As Exception Console.WriteLine("Timer1_Tick forms") End Try frm = Nothing

    ' If Not t2 Is Nothing Then If t2.IsAlive Then Return End If End If If Not t3 Is Nothing Then If
    ' t3.IsAlive Then Return End If End If If Not t4 Is Nothing Then If t4.IsAlive Then Return End If
    ' End If If Not t5 Is Nothing Then If t5.IsAlive Then Return End If End If

    ' Timer1.Enabled = False

    ' Dim LastYearArchive As Integer = 0 Dim LastMonthArchive As Integer = 0 Dim LastDayArchive As
    ' Integer = 0 Dim LastMinuteArchive As Integer = 0

    ' Dim TodayYear As Integer = Now.Year Dim TodayDay As Integer = Now.Day Dim TodayMonth As Integer
    ' = Now.Month Dim TodayMinute As Integer = Now.Minute Dim TodayHour As Integer = Now.Hour

    ' Dim TS As TimeSpan = Nothing

    ' Dim Days As Integer = 0 Dim Hours As Integer = 0

    ' '** Now, we determine if we archive or not

    ' Application.DoEvents() Dim isDisabled As Boolean = False

    ' If ckDisable.Checked = True Then SB.Text = "ALL Archive disabled - " + Now.ToString
    ' 'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString Timer1.Enabled = True

    ' If DBARCH.isArchiveDisabled("ALL") = True Then isDisabled = True SB.Text = "ALL Archive
    ' disabled - " + Now.ToString 'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString Else
    ' isDisabled = True SB.Text = "Archive disabled - " + Now.ToString 'FrmMDIMain.SB.Text = "Archive
    ' disabled " + Now.ToString End If

    ' ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
    ' ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True

    ' 'LOG.WriteToArchiveLog("ALL Archive disabled.")

    ' Return Else SB.Text = "Archive enabled - " + Now.ToString 'FrmMDIMain.SB.Text = "Archive
    ' enabled " + Now.ToString Timer1.Enabled = True ArchiveALLToolStripMenuItem.Enabled = True
    ' ContentToolStripMenuItem.Enabled = True ExchangeEmailsToolStripMenuItem.Enabled = True
    ' OutlookEmailsToolStripMenuItem.Enabled = True If gIsServiceManager = True Then
    ' LOG.WriteToArchiveLog("ServiceManager Archive.") gbPolling.Enabled = False
    ' ckUseLastProcessDateAsCutoff.Enabled = False btnRefreshFolders.Enabled = False
    ' btnActive.Enabled = False cbParentFolders.Enabled = False lbActiveFolder.Enabled = False
    ' ckArchiveFolder.Enabled = False ckArchiveRead.Enabled = False ckRemove.Enabled = False
    ' ckArchAfterDays.Enabled = False NumericUpDown2.Enabled = False ckRemoveAfterXDays.Enabled =
    ' False NumericUpDown3.Enabled = False ckSystemFolder.Enabled = False cbEmailRetention.Enabled =
    ' False btnSaveConditions.Enabled = False btnDeleteEmailEntry.Enabled = False
    ' OutlookEmailsToolStripMenuItem.Enabled = False ExchangeEmailsToolStripMenuItem.Enabled = False
    ' ContentToolStripMenuItem.Enabled = False ArchiveALLToolStripMenuItem.Enabled = False
    ' ckArchiveBit.Enabled = True End If End If

    ' Dim RetentionCode = cbEmailRetention.Text Dim RetentionYears As Integer = 0 RetentionYears =
    ' DBARCH.getRetentionPeriod(RetentionCode )

    ' If gCurrentArchiveGuid.Length = 0 Then gCurrentArchiveGuid = Guid.NewGuid.ToString End If

    ' Dim UnitValue = "" Dim ArchiveType = "" ArchiveType = DBARCH.getRconParm(gCurrUserGuidID,
    ' "ArchiveType") UnitValue = DBARCH.getRconParm(gCurrUserGuidID, "ArchiveInterval")

    ' Dim CurrStatus = "Running" Dim WC = STATS.wc_PI02_ArchiveStats(CurrStatus , gCurrUserGuidID)

    ' ArchiveALLToolStripMenuItem.Enabled = False ContentToolStripMenuItem.Enabled = False
    ' ExchangeEmailsToolStripMenuItem.Enabled = False OutlookEmailsToolStripMenuItem.Enabled = False

    ' Dim LastSuccessFullArchiveDate As Date = Now Dim BackupNow As Boolean = False

    ' '***********************************************************************************************
    ' LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID) '***********************************************************************************************

    ' If LastSuccessFullArchiveDate = Nothing Then LOG.WriteToArchiveLog("Last Archivesuccessful -
    ' ready for archive to execute.") BackupNow = True Else LastYearArchive =
    ' LastSuccessFullArchiveDate.Year LastMonthArchive = LastSuccessFullArchiveDate.Month
    ' LastDayArchive = LastSuccessFullArchiveDate.Day LastMinuteArchive =
    ' LastSuccessFullArchiveDate.Minute LOG.WriteToArchiveLog("Last Archivesuccessful RESET.") End If
    ' SB.Text = "AUTO Archive running" SB2.Text = "AUTO Archive running" If ArchiveType
    ' .Equals("Disable") Then LOG.WriteToArchiveLog("Archive Type is DISABLED.") Timer1.Enabled =
    ' True ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
    ' ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True
    ' Return ElseIf ArchiveType .Equals("Monthly") Then 'lblUnit.Text = "day of the month" SB.Text =
    ' "Backup every month on day " + UnitValue LOG.WriteToArchiveLog("Backup every month on day " +
    ' UnitValue ) LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)

    ' LastYearArchive = 0 LastMonthArchive = 0 LastDayArchive = 0 LastMinuteArchive = 0

    ' TS = Now.Subtract(LastSuccessFullArchiveDate) Days = TS.Days

    ' If LastMonthArchive = 12 And LastSuccessFullArchiveDate.Month = 1 Then LastMonthArchive = 0 End
    ' If If Now.Month >= LastSuccessFullArchiveDate.Month Then BackupNow = True End If
    ' LOG.WriteToArchiveLog("Backup every month Backup Now is " + BackupNow.ToString) If BackupNow =
    ' True And Now.Month = LastSuccessFullArchiveDate.Month Then If CInt(UnitValue ) < TodayDay Then
    ' LOG.WriteToArchiveLog("Backup every month Backup Now is NOT due.")
    ' ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
    ' ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True
    ' Return Else BackupNow = True LOG.WriteToArchiveLog("Backup every month Backup Now is DUE.")
    ' GoTo DoItNow End If End If If Now.Month > LastSuccessFullArchiveDate.Month Then BackupNow =
    ' True Else Return End If ElseIf ArchiveType .Equals("Daily") Then 'lblUnit.Text = "time of day
    ' (24 hr) clock" SB.Text = "Backup daily immediately after " + UnitValue + " hours."
    ' LOG.WriteToArchiveLog("Backup daily immediately after " + UnitValue )
    ' LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
    ' If LastSuccessFullArchiveDate = Nothing Then LOG.WriteToArchiveLog("Backup daily immediately
    ' BackupNow = " + BackupNow.ToString) BackupNow = True Else

    ' LastYearArchive = LastSuccessFullArchiveDate.Year LastMonthArchive =
    ' LastSuccessFullArchiveDate.Month LastDayArchive = LastSuccessFullArchiveDate.Day
    ' LastMinuteArchive = LastSuccessFullArchiveDate.Minute

    ' 'Dim DayOfWeek = LastSuccessFullArchiveDate.DayOfWeek.ToString

    ' 'If DayOfWeek .ToUpper.Equals("SUNDAY") Then

    ' 'End If

    ' Dim BackupHour As Integer = CInt(UnitValue ) / 100

    ' TS = Now.Subtract(LastSuccessFullArchiveDate) Hours = TS.Hours

    ' If Hours >= 24 And Val(UnitValue ) >= Now.Hour Then LOG.WriteToArchiveLog("Backup daily
    ' immediately BackupNow is TRUE") BackupNow = True Else LOG.WriteToArchiveLog("Backup daily
    ' immediately BackupNow is False") BackupNow = False Return End If End If ElseIf ArchiveType
    ' .Equals("Hourly") Then 'lblUnit.Text = "minutes past the hour" SB.Text = "Backup hourly
    ' immediately " + UnitValue + " minutes after the hour." LOG.WriteToArchiveLog("Backup hourly
    ' immediately " + UnitValue + " minutes after the hour.") LastSuccessFullArchiveDate =
    ' DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)

    ' LastYearArchive = LastSuccessFullArchiveDate.Year LastMonthArchive =
    ' LastSuccessFullArchiveDate.Month LastDayArchive = LastSuccessFullArchiveDate.Day
    ' LastMinuteArchive = LastSuccessFullArchiveDate.Minute

    ' TS = Now.Subtract(LastSuccessFullArchiveDate) Hours = TS.Hours

    ' If Hours >= 1 Then LOG.WriteToArchiveLog("Backup hourly is TRUE - 1.") BackupNow = True Else
    ' ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
    ' ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True
    ' LOG.WriteToArchiveLog("Backup hourly is NOT TRUE - 2.") Return End If ElseIf ArchiveType
    ' .Equals("Minutes") Then 'lblUnit.Text = "minutes" SB.Text = "Backup every " + UnitValue + "
    ' minutes." LOG.WriteToArchiveLog("Backup every " + UnitValue + " minutes.")
    ' LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)

    ' LastYearArchive = LastSuccessFullArchiveDate.Year LastMonthArchive =
    ' LastSuccessFullArchiveDate.Month LastDayArchive = LastSuccessFullArchiveDate.Day
    ' LastMinuteArchive = LastSuccessFullArchiveDate.Minute

    ' TS = Now.Subtract(LastSuccessFullArchiveDate) Dim Minutes As Integer = TS.Minutes

    ' If Minutes >= Val(UnitValue ) Then BackupNow = True Else BackupNow = False End If

    '        Else
    '            Timer1.Enabled = True
    '            ArchiveALLToolStripMenuItem.Enabled = True
    '            ContentToolStripMenuItem.Enabled = True
    '            ExchangeEmailsToolStripMenuItem.Enabled = True
    '            OutlookEmailsToolStripMenuItem.Enabled = True
    '            LOG.WriteToArchiveLog("Backup NOW NOT TRUE : 1 ")
    '            Return
    '        End If
    'DoItNow:

    ' LOG.WriteToArchiveLog("Scheduled Archive stared @ " + Now.ToString)

    ' '****************************** SetUnattendedFlag() '******************************

    ' If BackupNow Then

    ' STATS.setArchivestartdate(Now.ToString) STATS.setArchiveenddate(Now.ToString)
    ' STATS.setArchivetype(ArchiveType ) STATS.setStatguid(gCurrentArchiveGuid)
    ' STATS.setStatus("Running") STATS.setSuccessful("N") STATS.setUserid(gCurrUserGuidID)
    ' STATS.setTotalcontentinrepository("0") STATS.setTotalemailsinrepository("0")

    ' Me.SB.Text = "Scheduled Archive Starting." SB.Refresh() Application.DoEvents()

    ' gbEmail.Enabled = False gbContentMgt.Enabled = False

    ' '*****************************************************
    ' ArchiveALLToolStripMenuItem_Click(Nothing, Nothing) '*****************************************************

    ' gbEmail.Enabled = True gbContentMgt.Enabled = True

    ' Cursor = Cursors.Default

    ' ALR.ProcessAutoReferences()

    ' Cursor = Cursors.Default

    ' '********************************************* '** WDM DBARCH.UpdateAttachmentCounts() '*********************************************

    ' TimerEndRun.Enabled = True

    ' Cursor = Cursors.Default End If

    ' ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
    ' ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True

    ' LOG.WriteToArchiveLog("Scheduled Archive ended @ " + Now.ToString) Timer1.Enabled = True

    ' SB.Text = "AUTO Archive complete" SB2.Text = "AUTO Archive complete"

    ' End Sub

    Private Sub btnDeleteEmailEntry_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeleteEmailEntry.Click
        ParentFolder = cbParentFolders.Text
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ParentFolder.Trim.Length = 0 Then
            MessageBox.Show("Please select a Parent Folder to process.")
            Return
        End If

        Dim msg As String = "This will remove the selected mail folder from the archive process, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Email Folder", MessageBoxButtons.YesNo)

        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Me.Cursor = Cursors.AppStarting

        For Each S As String In lbActiveFolder.SelectedItems
            Try
                Dim FolderName As String = ParentFolder + "|" + S.ToString
                Debug.Print(FolderName)
                Dim aParms(0) As String

                'PARMS.EmailFolderName  = FolderName
                EMPARMS.setFoldername(FolderName)
                EMPARMS.setUserid(gCurrUserGuidID)

                '** Remove it from the parameter table.
                Dim WhereClause As String = "Where [UserID] = '" + gCurrUserGuidID + "' and [FolderName] = '" + FolderName + "'"
                EMPARMS.Delete(WhereClause)

                '** Reset the archive flag.
                Dim WC As String = "where FolderName = '" + FolderName + "' and UserID = '" + gCurrUserGuidID + "'"
                'DBARCH.UpdateArchiveFlag(ParentFolder, gCurrUserGuidID, "N", S.ToString)
                DBARCH.DeleteEmailArchiveFolder(ParentFolder, gCurrUserGuidID, "N", FolderName)
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                Console.WriteLine(ex.Message)
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            End Try
        Next

        DBARCH.GetActiveEmailFolders(ParentFolder, lbActiveFolder, gCurrUserGuidID, CF, ArchivedEmailFolders)

        DBARCH.setActiveEmailFolders(ParentFolder, gCurrUserGuidID)

        DBARCH.CleanUpEmailFolders()

        Me.Cursor = Cursors.Default
    End Sub

    Sub AddFileAttributes()

        InsertAttrib("FILESIZE", "Byte length of a file", "INT")
        InsertAttrib("FILENAME", "The name of a file", "varchar")
        InsertAttrib("FQN", "The fully qualified name of a file", "varchar")
        InsertAttrib("ChangeDate", "The last date the file was updated", "datetime")
        InsertAttrib("CreateDate", "The CREATION date the file was updated", "datetime")
        InsertAttrib("WriteDate", "The last time the file was written to", "datetime")

    End Sub

    Sub InsertAttrib(ByVal aName As String, ByVal aDesc As String, ByVal aType As String)
        ATTRIB.setAttributename(aName)
        ATTRIB.setAttributedesc(aDesc)
        ATTRIB.setAttributedatatype(aType)
        ATTRIB.Insert()
    End Sub

    Sub InsertSrcAttrib(ByVal SGUID As String, ByVal aName As String, ByVal aVal As String, ByVal OriginalFileType As String)
        SRCATTR.setSourceguid(SGUID)
        SRCATTR.setAttributename(aName)
        SRCATTR.setAttributevalue(aVal)
        SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
        SRCATTR.setSourcetypecode(OriginalFileType)
        SRCATTR.Insert()
    End Sub

    Sub UpdateSrcAttrib(ByVal SGUID As String, ByVal aName As String, ByVal aVal As String, ByVal SourceType As String)
        Dim iCnt As Integer = SRCATTR.cnt_PK35(aName, gCurrUserGuidID, SGUID)
        If iCnt = 0 Then
            SRCATTR.setSourceguid(SGUID)
            SRCATTR.setAttributename(aName)
            SRCATTR.setAttributevalue(aVal)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(SourceType)
            SRCATTR.Insert()
        Else
            Dim WC As String = SRCATTR.wc_PK35(aName, gCurrUserGuidID, SGUID)
            SRCATTR.setSourceguid(SGUID)
            SRCATTR.setAttributename(aName)
            SRCATTR.setAttributevalue(aVal)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(SourceType)
            SRCATTR.Update(WC)
        End If

    End Sub

    Sub GetWordDocMetadata(ByVal FQN As String, ByVal SourceGUID As String, ByVal OriginalFileType As String)
        Try
            Dim TempDir As String = System.IO.Path.GetTempPath
            Dim fName As String = DMA.getFileName(FQN)
            Dim NewFqn As String = TempDir + fName

            File.Copy(FQN, NewFqn, True)

            Dim WDOC As New clsMsWord
            WDOC.initWordDocMetaData(NewFqn, SourceGUID, OriginalFileType)

            ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|")
            'File.Delete(NewFqn )
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            DBARCH.xTrace(3655, "GetWordDocMetadata", ex.Message.ToString)
            LOG.WriteToArchiveLog("GetWordDocMetadata: Failed to process word metadata: GetWordDocMetadata - " + vbCrLf + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Sub GetExcelMetaData(ByVal FQN As String, ByVal SourceGUID As String, ByVal OriginalFileType As String)

        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim fName As String = DMA.getFileName(FQN)
        Dim NewFqn As String = TempDir + fName

        Try
            Try
                File.Copy(FQN, NewFqn, True)
                Dim WDOC As New clsMsWord
                WDOC.initExcelMetaData(NewFqn, SourceGUID, OriginalFileType)
                WDOC = Nothing
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                DBARCH.xTrace(340123, "GetExcelMetaData", "Failed to open XL work book: " + FQN + " : " + ex.Message.ToString)
                LOG.WriteToArchiveLog("Failed to open XL work book: GetExcelMetaData" + ex.Message)
                Dim st As New StackTrace(True)
                st = New StackTrace(ex, True)
                LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            Finally
                ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|")
                'File.Delete(NewFqn )
            End Try
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("NOTICE: GetExcelMetaData" + ex.Message)
        End Try

    End Sub

    Public Function InclAddList(ByVal LB As ListBox, ByVal UserGuid As String, ByVal PassedFQN As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        For i As Integer = 0 To LB.Items.Count - 1
            INL.setExtcode(LB.Items(i).ToString)
            INL.setFqn(PassedFQN)
            INL.setUserid(UserGuid)
            INL.Insert()
        Next
        Return True
    End Function

    Public Function ExcludeAddList(ByVal LB As ListBox, ByVal UserGuid As String, ByVal PassedFQN As String) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        For i As Integer = 0 To LB.Items.Count - 1
            Me.EXL.setExtcode(LB.Items(i).ToString)
            EXL.setFqn(PassedFQN)
            EXL.setUserid(UserGuid)
            Debug.Print(LB.Items(i).ToString + " : " + PassedFQN)
            EXL.Insert()
        Next
        Return True
    End Function

    Public Function ExlAddList(ByVal LB As ListBox, ByVal PassedFQN As String, ByVal typeCode As String, ByVal InclSubDirs As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        'For i As Integer = 0 To LB.Items.Count - 1
        '    EXL.setExtcode(LB.Items(i).ToString)
        '    EXL.setFqn(PassedFQN)
        '    EXL.setUserid(gCurrUserGuidID)
        '    EXL.Insert()
        'Next

        Dim lDirs As New List(Of String)
        Dim B As Boolean = False

        lDirs.Clear()
        lDirs.Add(PassedFQN)

        If InclSubDirs Then
            addSubDirs(PassedFQN, lDirs)
        End If

        'UserID = gCurrUserGuidID
        'FQN = PassedFQN
        'FQN = UTIL.RemoveSingleQuotes(FQN)
        'ExtCode = typeCode

        For i As Integer = 0 To lDirs.Count - 1
            PassedFQN = lDirs.Item(i).ToString
            PassedFQN = UTIL.RemoveSingleQuotes(PassedFQN)
            EXL.setExtcode(typeCode)
            EXL.setFqn(PassedFQN)
            EXL.setUserid(gCurrUserGuidID)
            Dim WC As String = "where UserID = '" + gCurrUserGuidID + "' and FQN = '" + PassedFQN + "' and Extcode = '" + typeCode + "' "
            Dim II As Integer = DBARCH.iGetRowCount("ExcludedFiles", WC)
            If II = 0 Then
                B = EXL.Insert()
            End If
            Me.SB.Text = "Processing subdir #" + i.ToString + " : " + PassedFQN
            Application.DoEvents()
        Next
        'LB.Items.Add(typeCode)
        Return B

        Return True
    End Function

    Sub GetAllSubDirs(ByVal lDirs As List(Of String), ByVal PassedFQN As String)
        lDirs.Clear()
        lDirs.Add(PassedFQN)
        addSubDirs(PassedFQN, lDirs)
    End Sub

    Public Function AddList(ByVal LB As ListBox, ByVal PassedFQN As String, ByVal typeCode As String, ByVal InclSubDirs As Boolean) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim lDirs As New List(Of String)
        Dim B As Boolean = False

        lDirs.Clear()
        lDirs.Add(PassedFQN)

        If InclSubDirs Then
            addSubDirs(PassedFQN, lDirs)
        End If

        'UserID = gCurrUserGuidID
        'FQN = PassedFQN
        'FQN = UTIL.RemoveSingleQuotes(FQN)
        'ExtCode = typeCode

        For i As Integer = 0 To lDirs.Count - 1
            PassedFQN = lDirs.Item(i).ToString
            PassedFQN = UTIL.RemoveSingleQuotes(PassedFQN)
            INL.setExtcode(typeCode)
            INL.setFqn(PassedFQN)
            INL.setUserid(gCurrUserGuidID)
            Dim WC As String = "where UserID = '" + gCurrUserGuidID + "' and FQN = '" + PassedFQN + "' and Extcode = '" + typeCode + "' "
            Dim II As Integer = DBARCH.iGetRowCount("IncludedFiles", WC)
            If II = 0 Then
                B = INL.Insert()
            End If
            Me.SB.Text = "Processing subdir #" + i.ToString + " : " + PassedFQN
            Application.DoEvents()
        Next
        'LB.Items.Add(typeCode)
        Return B

    End Function

    'Sub ArchiveEmails()
    '    ARCH.ArchiveAllEmail()
    '    SB2.Text = "Email Complete"
    'End Sub
    Sub saveStartUpParms()
        If Not formloaded Then
            Return
        End If
        If gCurrUserGuidID.Length = 0 Then
            Return
        End If

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim NewVal As String = ""

        formloaded = False

        Dim B As Boolean = False

        'Dim ArchiveType  = Me.cbInterval.Text
        'RPARM.setUserid(gCurrUserGuidID)
        'RPARM.setParm("ArchiveType")
        'RPARM.setParmvalue(ArchiveType)
        'B = DBARCH.ckReconParmExists(gCurrUserGuidID, "ArchiveType")
        'If Not B Then
        '    RPARM.Insert()
        'Else
        '    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveType'")
        'End If

        NewVal = ""
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("ArchiveInterval")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "ArchiveInterval")
        If Not B Then
            RPARM.Insert()
            'Else
            '    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveInterval'")
        End If

        If gCurrUserGuidID.Length = 0 Then
            Return
        End If

        NewVal = ckDisable.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("Disabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "Disabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'Disabled'")
        End If

        If gCurrUserGuidID.Length = 0 Then
            Return
        End If

        NewVal = Me.ckDisableContentArchive.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("ContentDisabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "ContentDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ContentDisabled'")
        End If

        NewVal = Me.ckDisableOutlookEmailArchive.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("OutlookDisabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "OutlookDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'OutlookDisabled'")
        End If

        NewVal = Me.ckDisableExchange.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("ExchangeDisabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "ExchangeDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ExchangeDisabled'")
        End If

        NewVal = Me.ckRssPullDisabled.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("RssPullDisabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "RssPullDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'RssPullDisabled'")
        End If

        NewVal = Me.ckWebPageTrackerDisabled.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("WebPageTrackerDisabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "WebPageTrackerDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'WebPageTrackerDisabled'")
        End If

        NewVal = Me.ckWebSiteTrackerDisabled.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("WebSiteTrackerDisabled")
        RPARM.setParmvalue(NewVal)

        B = DBARCH.ckReconParmExists(gCurrUserGuidID, "WebSiteTrackerDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'WebSiteTrackerDisabled'")
        End If

        formloaded = True

        SB.Text = "Startup parms saved..."

    End Sub

    Private Sub btnSaveSchedule_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveSchedule.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        saveStartUpParms()

    End Sub

    'Private Sub cbInterval_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
    '    Dim Interval  = cbInterval.Text
    '    cbTimeUnit.Items.Clear()

    '    If Interval.Equals("Monthly") Then
    '        lblUnit.Text = "day of the month"
    '        For ii As Integer = 1 To 31
    '            cbTimeUnit.Items.Add(ii)
    '        Next
    '        cbTimeUnit.Text = "1"
    '    End If
    '    If Interval.Equals("Daily") Then
    '        lblUnit.Text = "time of day (24 hr) clock"
    '        For ii As Integer = 1 To 24
    '            Dim C  = ii.ToString
    '            If C.Trim.Length = 1 Then
    '                C = "0" + C + "00"
    '            End If
    '            If C.Trim.Length = 2 Then
    '                C = C + "00"
    '            End If
    '            cbTimeUnit.Items.Add(C)
    '            'For III As Integer = 1 To 3
    '            '    If III = 1 Then
    '            '        C = Mid(C, 1, 2) + "15"
    '            '    End If
    '            '    If III = 2 Then
    '            '        C = Mid(C, 1, 2) + "30"
    '            '    End If
    '            '    If III = 2 Then
    '            '        C = Mid(C, 1, 2) + "45"
    '            '    End If
    '            '    cbTimeUnit.Items.Add(C)
    '            '    If ii = 1 Then
    '            '        cbTimeUnit.Text = "0030"
    '            '    End If
    '            'Next
    '        Next
    '    End If
    '    If Interval.Equals("Hourly") Then
    '        lblUnit.Text = "minutes past the hour"
    '        For ii As Integer = 0 To 59
    '            cbTimeUnit.Items.Add(ii)
    '        Next
    '        cbTimeUnit.Text = "15"
    '    End If
    '    If Interval.Equals("Minutes") Then
    '        lblUnit.Text = "minutes"
    '        For ii As Integer = 1 To 45
    '            cbTimeUnit.Items.Add(ii)
    '        Next
    '        cbTimeUnit.Text = "30"
    '    End If
    'End Sub

    Private Sub cbTimeUnit_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub gbPolling_MouseHover(ByVal sender As Object, ByVal e As System.EventArgs) Handles gbPolling.MouseHover
        SB.Text = "Use these parameters to set up the archive execution."
    End Sub

    Private Sub ckSubDirs_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckSubDirs.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckPublic_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckPublic.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub btnExclude_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExclude.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            'If txtDir.Text.Trim.Length = 0 Then
            '    messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            '    Return
            'End If
            Dim S1 As String = lbAvailExts.SelectedItem.ToString

            For Each S As String In lbAvailExts.SelectedItems
                Dim ItemAlreadyExists As Boolean = False
                For I As Integer = 0 To lbExcludeExts.Items.Count - 1
                    Dim ExistingItem As String = lbExcludeExts.Items(I)
                    If S.ToUpper.Equals(ExistingItem.ToUpper) Then
                        ItemAlreadyExists = True
                        Exit For
                    End If
                Next
                If ItemAlreadyExists = False Then
                    lbExcludeExts.Items.Add(S)
                    btnSaveChanges.BackColor = Color.OrangeRed
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR btnInclFileType_Click : " + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            SB.Text = "Error - please refer to error log."
        End Try
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub btnRemoveExclude_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveExclude.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        SB.Text = "Profile maintenance selected, will not affect directory setup."
        For i As Integer = lbExcludeExts.SelectedItems.Count To 0 Step -1
            Dim II As Integer = lbExcludeExts.SelectedIndex
            If II >= 0 Then
                lbExcludeExts.Items.RemoveAt(II)
            End If
        Next

        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Function FolderExists(ByVal FolderName As String) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim TgtFolder As String = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")

        Dim B As Boolean = False
        Dim OlApp = CreateObject("Outlook.Application")
        Dim NmSpace = OlApp.GetNamespace("MAPI")
        Dim Mailbox = NmSpace.Folders("Mailbox - eBay Bidder") ' Set mailbox to eBay Bidder
        Dim Inbox = Mailbox.Folders("Inbox") 'olFolderInbox
        Dim MySubFolder = Inbox.Folders("eBay") ' Note Case Sensitive!
        Dim MySubFolder2 = MySubFolder.Folders("Auctions")
        Dim MySubFolder3 = MySubFolder2.Folders("Auctions WON")

        For I As Integer = 1 To MySubFolder3.Folders.Count
            If MySubFolder3.Folders(I) = FolderName Then
                B = True
                Exit For
            Else
                B = False
            End If
        Next I
        Return B
    End Function

    Private Sub lbExcludeExts_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbExcludeExts.TextChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim S1 As String = ""
        Dim SA As New SortedList(Of String, String)

        For K As Integer = 0 To lbIncludeExts.Items.Count - 1
            S1 = lbIncludeExts.SelectedItem.ToString.ToLower
            If SA.IndexOfKey(S1) < 0 Then
                SA.Add(S1, S1)
            End If
        Next
        S1 = lbIncludeExts.SelectedItem.ToString
        DMA.FixFileExtension(S1)
        Dim B As Boolean = True
        For i As Integer = lbExcludeExts.Items.Count - 1 To 0 Step -1
            S1 = lbExcludeExts.Items(i).ToString
            If SA.IndexOfKey(S1) > 0 Then
                lbExcludeExts.Items.RemoveAt(i)
            End If
        Next
    End Sub

    Private Sub txtDir_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDir.TextChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If InStr(txtDir.Text, "%userid%", CompareMethod.Text) > 0 Then
            clAdminDir.Checked = True
        End If
    End Sub

    Private Sub ckUseLastProcessDateAsCutoff_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckUseLastProcessDateAsCutoff.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        DBARCH.UserParmInsertUpdate("ckUseLastProcessDateAsCutoff", gCurrUserGuidID, ckUseLastProcessDateAsCutoff.Checked)
    End Sub

    Private Sub frmReconMain_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize

        If formloaded = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ResizeControls(Me)

    End Sub

    Sub resetBadDates()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = "Update Email set CreationDate = getdate() where CreationDate is NULL ;"
        Dim B As Boolean = DBARCH.ExecuteSqlNewConn(90315, S)

        S = "update Email set SentOn = CreationDate where SentOn > '1/1/4500' and UserID = '" + gCurrUserGuidID + "'"
        B = DBARCH.ExecuteSqlNewConn(90316, S)

        If Not B Then
            LOG.WriteToArchiveLog("Warning : Check email senton dates as some were found to be invalid in the emails.")
        End If
    End Sub

    Sub GetExchangeFolders(ByVal bNewThread As Boolean)

        If DBARCH.isArchiveDisabled("EXCHANGE") = True Then
            Return
        End If

        Dim EM As New clsEmailFunctions
        If gCurrentArchiveGuid.Length = 0 Then
            gCurrentArchiveGuid = Guid.NewGuid.ToString
        End If

        LOG.WriteToArchiveLog("GetExchangeFolders 100")
        'FrmMDIMain.SB.Text = "Archiving Exchange Folders - you can continue to work."

        If bNewThread Then
            'SB.Text = "Launching Exchange Archive - it will run in background."
            If ddebug Then
                LOG.WriteToTraceLog("Entering LaunchExchangeDownload from frmMain")
            End If
            EM.LaunchExchangeDownload()
        Else
            'SB.Text = "Launching Exchange Archive"
            If ddebug Then
                LOG.WriteToTraceLog("Entering ProcessExchangePopMail from frmMain")
            End If
            'FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
            gCurrUserGuidID = UIDcurr
            EM.ProcessExchangeServers(UIDcurr)
            'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
            'SB.Text = "Exchange archive complete."
        End If
        If gTerminateImmediately Then
            'Me.Cursor = Cursors.Default
            SB.Text = "Terminated archive!"
            Return
        End If
        EM = Nothing
        GC.Collect()
        GC.WaitForFullGCComplete()
    End Sub

    Private Sub btnInclProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnInclProfile.Click
        Dim pName As String = cbProfile.Text
        If pName.Trim.Length = 0 Then
            MessageBox.Show("Please select a profile.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        pName = UTIL.RemoveSingleQuotes(pName)
        Dim S As String = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = '" + pName + "' order by SourceTypeCode"
        DBARCH.PopulateListBoxMerge(Me.lbIncludeExts, "SourceTypeCode", S)
        DBARCH.PopulateListBoxRemove(Me.lbExcludeExts, "SourceTypeCode", S)
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub btnExclProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExclProfile.Click
        Dim pName As String = cbProfile.Text
        If pName.Trim.Length = 0 Then
            MessageBox.Show("Please select a profile.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        pName = UTIL.RemoveSingleQuotes(pName)
        Dim S As String = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = '" + pName + "' order by SourceTypeCode"
        DBARCH.PopulateListBoxMerge(Me.lbExcludeExts, "SourceTypeCode", S)
        DBARCH.PopulateListBoxRemove(Me.lbIncludeExts, "SourceTypeCode", S)
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Sub SetArchiveEndStats(ByVal ArchiveType As String)
        STATS.setArchiveenddate(Now.ToString)
        STATS.setArchivetype(ArchiveType)
        STATS.setStatus("Successful")
        STATS.setSuccessful("Y")
        STATS.setUserid(gCurrUserGuidID)

        Dim iCnt As Integer = 0
        iCnt = DBARCH.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + gCurrUserGuidID + "'")
        LOG.WriteToArchiveLog("Archive Count: Source Files - " + iCnt.ToString)
        STATS.setTotalcontentinrepository(iCnt.ToString)
        iCnt = DBARCH.iGetRowCount("Email", "where UserID = '" + gCurrUserGuidID + "'")
        LOG.WriteToArchiveLog("Archive Count: Emails - " + iCnt.ToString)
        STATS.setTotalemailsinrepository(iCnt.ToString)

        iCnt = STATS.cnt_PK_ArchiveStats(gCurrentArchiveGuid)
        If iCnt = 0 Then
            Dim BB As Boolean = STATS.Insert
            If Not BB Then
                LOG.WriteToArchiveLog("error 2345.01.1 - DID NOT INSERT STATS.")
            End If
        End If
        If iCnt > 0 Then
            Dim WC As String = STATS.wc_PK_ArchiveStats(gCurrentArchiveGuid)
            Dim b As Boolean = STATS.Update(WC)
            If Not b Then
                LOG.WriteToArchiveLog("Failed to update archive statistics: " + Now.ToString)
            End If
        End If
    End Sub

    Sub SetArchiveBeginStats(ByVal ArchiveType As String, ByVal NewGuid As String)
        STATS.setArchivestartdate(Now.ToString)
        STATS.setArchiveenddate(Now.ToString)
        STATS.setArchivetype(ArchiveType)
        STATS.setStatguid(NewGuid)
        STATS.setStatus("Running")
        STATS.setSuccessful("N")
        STATS.setUserid(gCurrUserGuidID)
        STATS.setTotalcontentinrepository("0")
        STATS.setTotalemailsinrepository("0")

        Dim iCnt As Integer = 0
        iCnt = DBARCH.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + gCurrUserGuidID + "'")
        STATS.setTotalcontentinrepository(iCnt.ToString)
        iCnt = DBARCH.iGetRowCount("Email", "where UserID = '" + gCurrUserGuidID + "'")
        STATS.setTotalemailsinrepository(iCnt.ToString)

        iCnt = STATS.cnt_PK_ArchiveStats(NewGuid)
        If iCnt = 0 Then
            Dim BB As Boolean = STATS.Insert
            If Not BB Then
                SB.Text = ("error 2345.01.1a - DID NOT INSERT STATS.")
                LOG.WriteToArchiveLog("error 2345.01.1a - DID NOT INSERT STATS.")
            End If
        End If
        If iCnt > 0 Then
            Dim WC As String = STATS.wc_PK_ArchiveStats(NewGuid)
            Dim b As Boolean = STATS.Update(WC)
            If Not b Then
                SB.Text = ("error 2345.01.1b - DID NOT INSERT STATS.")
                LOG.WriteToArchiveLog("error 2345.01.1b - DID NOT INSERT STATS.")
            End If
        End If
    End Sub

    Private Sub cbParentFolders_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbParentFolders.SelectedIndexChanged
        ParentFolder = cbParentFolders.Text.Trim
        btnRefreshFolders_Click(Nothing, Nothing)
    End Sub

    Private Sub ResetSelectedMailBoxesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ResetSelectedMailBoxesToolStripMenuItem.Click
        Dim msg As String = "This will remove all of your mailbox selections" + vbCrLf + "it will not remove any archives. Are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Reset Email Folders", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        S = "DELETE FROM [EmailArchParms] "
        S = S + " WHERE UseriD = '" + gCurrUserGuidID + "'"

        Dim B As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
        If B Then
            S = "DELETE FROM [EmailFolder] "
            S = S + " WHERE UseriD = '" + gCurrUserGuidID + "'"

            B = DBARCH.ExecuteSqlNewConn(S, False)

            If B Then
                SB.Text = "Mailboxes successfully reset"
            Else
                SB.Text = "Mailboxes DID NOT reset"
            End If
        Else
            SB.Text = "Mailboxes DID NOT reset"
        End If

        If Now < #10/5/2009# Then
            Dim TgtFolder As String = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            Dim SS As String = "update Email set originalfolder = '" + TgtFolder + "' + '|' + originalfolder where originalfolder not like '%|%' "
            DBARCH.ExecuteSqlNewConn(90317, SS)
        End If

    End Sub

    Private Sub ContextMenuStrip1_Opening(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles ContextMenuStrip1.Opening
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub EmailLibraryReassignmentToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmailLibraryReassignmentToolStripMenuItem.Click
        'Me.lbArchiveDirs.SelectedItem.ToString
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim FolderName As String = Me.lbActiveFolder.SelectedItem.ToString
        FolderName = cbParentFolders.Text.Trim + "|" + FolderName
        FolderName = UTIL.RemoveSingleQuotes(FolderName)

        'frmLibraryAssignment.MdiParent = 'FrmMDIMain
        frmLibraryAssignment.setFolderName(FolderName)
        frmLibraryAssignment.SetTypeContent(False)
        frmLibraryAssignment.Show()

    End Sub

    Private Sub cbFileDB_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbFileDB.SelectedIndexChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub Label8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label8.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub lbAvailExts_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbAvailExts.SelectedIndexChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If lbAvailExts.SelectedItems.Count > 0 Then
            btnInclFileType.Visible = True
            btnExclude.Visible = True
        Else
            btnInclFileType.Visible = False
            btnExclude.Visible = False
        End If
    End Sub

    Private Sub ckTerminate_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckTerminate.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If ckTerminate.Checked = True Then
            gTerminateImmediately = True
        Else
            gTerminateImmediately = False
        End If
    End Sub

    Private Sub btnSaveDirProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveDirProfile.Click

        Dim DirProfileName As String = cbDirProfile.Text.Trim
        If DirProfileName.Length = 0 Then
            MessageBox.Show("A directory profile name must be supplied, returning.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName)
        Dim Parms As String = buildDirProfileParms()
        Dim S As String = "Select count(*) from DirProfiles where ProfileName = '" + DirProfileName + "'"

        Dim iCnt As Integer = DBARCH.iCount(S)

        If iCnt = 0 Then

            S = ""
            S = S + " INSERT INTO [DirProfiles]"
            S = S + " ([ProfileName]"
            S = S + " ,[Parms])"
            S = S + "  VALUES "
            S = S + " ('" + DirProfileName + "'"
            S = S + " ,'" + Parms + "')"

            Dim B As Boolean = DBARCH.ExecuteSqlNewConn(90318, S)
            If B Then
                SB.Text = "Added the new directory profile, " + DirProfileName
                S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]"
                DBARCH.PopulateComboBox(Me.cbDirProfile, "ProfileName", S)
                cbDirProfile.Text = DirProfileName
            Else
                SB.Text = "Failed to add the directory profile, " + DirProfileName + " Please check the error logs."
            End If
        Else
            MessageBox.Show("The profile named '" + DirProfileName + "' already exists in the repository, returning.")
            SB.Text = "The profile named '" + DirProfileName + "' already exists in the repository, returning."
            Return
        End If

    End Sub

    Private Sub btnApplyDirProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApplyDirProfile.Click
        Dim DirProfileName As String = cbDirProfile.Text.Trim
        If DirProfileName.Length = 0 Then
            MessageBox.Show("A directory profile name must be supplied, returning.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        bApplyingDirParms = True

        Dim Parms As String = DBARCH.getDirProfile(DirProfileName)
        applyDirProfileParms(Parms)

        bApplyingDirParms = False
        btnSaveChanges.BackColor = Color.OrangeRed

    End Sub

    Private Sub btnUpdateDirectoryProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdateDirectoryProfile.Click

        Dim DirProfileName As String = cbDirProfile.Text.Trim
        If DirProfileName.Length = 0 Then
            MessageBox.Show("A directory profile name must be supplied, returning.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim Parms As String = buildDirProfileParms()

        DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName)
        Dim S As String = "Update DirProfiles set Parms = '" + Parms + "' where ProfileName = '" + DirProfileName + "'"
        Dim B As Boolean = DBARCH.ExecuteSqlNewConn(90319, S)
        If B Then
            SB.Text = "Directory Profile: " + DirProfileName + " updated."
        Else
            SB.Text = "Directory Profile: " + DirProfileName + " failed to update."
        End If

    End Sub

    Private Sub btnDeleteDirProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeleteDirProfile.Click
        Dim DirProfileName As String = cbDirProfile.Text.Trim
        If DirProfileName.Length = 0 Then
            MessageBox.Show("A directory profile name must be supplied, returning.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName)
        Dim S As String = "delete from DirProfiles where ProfileName = '" + DirProfileName + "'"
        Dim B As Boolean = DBARCH.ExecuteSqlNewConn(90320, S)
        If B Then
            S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]"
            DBARCH.PopulateComboBox(Me.cbDirProfile, "ProfileName", S)
            SB.Text = DirProfileName + " deleted."
        Else
            SB.Text = DirProfileName + " failed to delete A7."
        End If

    End Sub

    Function buildDirProfileParms() As String

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim Parms As String = ""
        Parms += "cbRetention" + Chr(253) + cbRetention.Text + Chr(254)

        Parms += "ckSubDirs" + Chr(253) + ckSubDirs.Checked.ToString + Chr(254)
        Parms += "ckOcr" + Chr(253) + ckOcr.Checked.ToString + Chr(254)
        Parms += "ckVersionFiles" + Chr(253) + ckVersionFiles.Checked.ToString + Chr(254)
        Parms += "ckMetaData" + Chr(253) + ckMetaData.Checked.ToString + Chr(254)
        Parms += "ckPublic" + Chr(253) + ckPublic.Checked.ToString + Chr(254)
        Parms += "clAdminDir" + Chr(253) + clAdminDir.Checked.ToString + Chr(254)

        Dim xFiles As String = "InclExt" + Chr(253)

        For I As Integer = 0 To lbIncludeExts.Items.Count - 1
            Try
                xFiles += lbIncludeExts.Items(I).ToString + Chr(252)
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                LOG.WriteToArchiveLog("XXX1: " + ex.Message)
            End Try
        Next
        xFiles += Chr(254)
        Parms += xFiles

        xFiles = "ExclExt" + Chr(253)
        For I As Integer = 0 To lbExcludeExts.Items.Count - 1
            Try
                xFiles += Me.lbExcludeExts.Items(I).ToString + Chr(252)
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception

            End Try

        Next
        xFiles += Chr(254)
        Parms += xFiles

        Parms = UTIL.RemoveSingleQuotes(Parms)

        Return Parms

    End Function

    Sub applyDirProfileParms(ByVal Parms As String)

        Dim ParmArray As String() = Parms.Split(Chr(254))
        Dim Parm As String = ""
        Dim ParmValue As String = ""

        For i As Integer = 0 To UBound(ParmArray)
            Dim tParm As String = ParmArray(i)
            Dim A As String() = tParm.Split(Chr(253))

            If UBound(A) = 1 Then
                Parm = A(0)
                ParmValue = A(1)
            Else
                GoTo NextRec
            End If
            If Parm.Equals("cbRetention") Then
                cbRetention.Text = ParmValue
            End If
            If Parm.Equals("ckSubDirs") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    ckSubDirs.Checked = True
                Else
                    ckSubDirs.Checked = False
                End If
            End If
            If Parm.Equals("ckOcr") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    ckOcr.Checked = True
                Else
                    ckOcr.Checked = False
                End If
            End If
            If Parm.Equals("ckOcrPdf") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    ckOcrPdf.Checked = True
                Else
                    ckOcr.Checked = False
                End If
            End If
            If Parm.Equals("ckVersionFiles") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    ckVersionFiles.Checked = True
                Else
                    ckVersionFiles.Checked = False
                End If
            End If
            If Parm.Equals("ckMetaData") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    ckMetaData.Checked = True
                Else
                    ckMetaData.Checked = False
                End If
            End If
            If Parm.Equals("ckPublic") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    ckPublic.Checked = True
                Else
                    ckPublic.Checked = False
                End If
            End If
            If Parm.Equals("clAdminDir") Then
                If ParmValue.ToUpper.Equals("TRUE") Then
                    clAdminDir.Checked = True
                Else
                    clAdminDir.Checked = False
                End If
            End If
            If Parm.Equals("InclExt") Then
                lbIncludeExts.Items.Clear()
                Dim aExt As String() = ParmValue.Split(Chr(252))
                For ii As Integer = 0 To UBound(aExt)
                    If aExt(ii).Trim.Length > 0 Then
                        lbIncludeExts.Items.Add(aExt(ii))
                    End If
                Next
            End If
            If Parm.Equals("ExclExt") Then
                lbExcludeExts.Items.Clear()
                Dim aExt As String() = ParmValue.Split(Chr(252))
                For ii As Integer = 0 To UBound(aExt)
                    If aExt(ii).Trim.Length > 0 Then
                        lbExcludeExts.Items.Add(aExt(ii))
                    End If
                Next
            End If
NextRec:
        Next

    End Sub

    Private Sub lbExcludeExts_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbExcludeExts.SelectedIndexChanged
        If bApplyingDirParms = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub ckArchiveBit_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckArchiveBit.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        S = "Whenever a file is created or changed, the operating system activates the Archive Bit or modified bit. Unless you select to use backup methods that depend on a date and time stamp, ECM Library uses the archive bit to determine whether a file has been backed up, which is an important element of your backup strategy. It is dangerous if other archive methods, processes or tools access an identified directory." + vbCrLf
        S = S + "Selecting the following backup methods can affect the archive bit: " + vbCrLf
        S = S + "  �  Full - Back up files - Using archive bit (reset archive bit) + vbcrlf"
        S = S + "  �  Differential - Back up changed files since last full - Using archive bit (does not reset archive bit) + vbcrlf"
        S = S + "  �  Incremental - Back up changed files since last full or incremental - Using archive bit (reset archive bit) + vbcrlf"
        S = S + "Whenever a file has been backed up using either the Full - Back up files - Using archive bit (reset archive bit) or Incremental - Changed Files - Reset Archive Bit backup method, Backup Exec turns the archive bit off, indicating to the system that the file has been backed up. If the file is changed again prior to the next full or incremental backup, the bit is turned on again, and Backup Exec will back up the file in the next full or incremental backup. Backups using the Differential - Changed Files backup method include only files that were created or modified since the last full backup. When this type of differential backup is performed, the archive bit is left intact. + vbcrlf + vbcrlf"
        S = S + "This is dangerous in many ways and you agree to accept all the risk of skipping files with the ARCHIVE bit set!"

        gLegalAgree = False
        frmAgreement.txtAgreement.Text = S
        frmAgreement.ShowDialog()
        If gLegalAgree = False Then
            SB.Text = "Terms refused, SKIP if Archive is not enabled."
            Return
        End If

        If ckArchiveBit.Checked Then
            ckArchiveBit.Checked = True
        Else
            ckArchiveBit.Checked = False
        End If
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckDisableDir_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisableDir.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If Not ckDisable.Checked Then
            CkMonitor.Checked = False
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckOcr_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckOcr.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckVersionFiles_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckVersionFiles.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckMetaData_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckMetaData.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub clAdminDir_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles clAdminDir.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Sub getListeners()

        DirectoryList.Clear()

        Dim tdir As String = ""
        Dim Action As String = ""
        Dim DirsToMonitor As String = System.Configuration.ConfigurationManager.AppSettings("DirsToMonitor")

        Dim stream_reader As New IO.StreamReader(DirsToMonitor)
        Using stream_reader
            line = stream_reader.ReadLine()
            Do While Not (line Is Nothing)
                line = line.Trim()
                If Not line.Substring(0, 1).Equals("#") Then
                    ReadResult = line.Split("|")
                    tdir = ReadResult(0).Trim
                    Action = ReadResult(1).Trim.ToUpper
                    If Not tdir.Substring(1, 1).Equals("#") Then
                        If Not DirectoryList.ContainsKey(tdir) Then
                            DirectoryList.Add(tdir, Action)
                        End If
                    End If
                End If
                line = stream_reader.ReadLine()
            Loop
            stream_reader.Close()
            stream_reader.Dispose()
        End Using
    End Sub

    Sub ProcessListener(SetAction As Boolean)

        Dim DirsToMonitor As String = System.Configuration.ConfigurationManager.AppSettings("DirsToMonitor")

        Dim ProcessSubdirectories As String = ""
        Dim TgtDir As String = ""
        Dim DirToProcess As String = ""

        Dim tdir As String = ""
        Dim action As String = ""

        If lbArchiveDirs.SelectedItems.Count.Equals(0) Then
            MessageBox.Show("Please select 1 or more directories before setting a listener, returning...")
            Return
        End If

        Try
            ' Read the file one line at a time.
            getLIsteners()
StartOver:
            ProcessSubdirectories = ""
            For i = 0 To lbArchiveDirs.SelectedItems.Count - 1
                '****
                Dim DirName As String = lbArchiveDirs.SelectedItem.ToString.Trim
                Me.txtDir.Text = DirName
                'DBARCH.LoadAvailFileTypes(lbAvailExts)
                Dim DBID As String = ""
                Dim IncludeSubDirs As String = ""
                Dim VersionFiles As String = ""
                Dim FolderDisabled As String = ""
                Dim isMetaData As String = ""
                Dim isPublic As String = ""
                Dim OcrDirectory As String = ""
                Dim OcrPdf As String = ""
                Dim isSysDefault As String = ""
                Dim DeleteOnArchive As String = ""

                DBARCH.GetDirectoryData(gCurrUserGuidID, DirName, DBID, IncludeSubDirs, VersionFiles, FolderDisabled, isMetaData, isPublic, OcrDirectory, isSysDefault, Me.ckArchiveBit.Checked, ListenForChanges, ListenDirectory, ListenSubDirectory, DirGuid, OcrPdf, DeleteOnArchive)

                cbFileDB.Text = DBID
                ckSubDirs.Checked = cvtTF(IncludeSubDirs)
                '****
                TgtDir = lbArchiveDirs.SelectedItems(i).ToString.Trim
                If SetAction.Equals(True) Then
                    If ckSubDirs.Checked.Equals(True) Then
                        ProcessSubdirectories = "Y"
                    Else
                        ProcessSubdirectories = "N"
                    End If
                    'Add the directory to the list if it does not exist 
                    If Not DirectoryList.ContainsKey(TgtDir) Then
                        DirectoryList.Add(TgtDir, ProcessSubdirectories)
                    Else
                        DirectoryList(TgtDir) = ProcessSubdirectories
                    End If
                Else
                    'DROP THIS FROM THE LIST OF DIRECTORIES TO PROCESS
                    If DirectoryList.ContainsKey(TgtDir) Then
                        DirectoryList.Remove(TgtDir)
                        GoTo StartOver
                    End If
                End If
            Next

            If File.Exists(DirsToMonitor) Then
                File.Delete(DirsToMonitor)
            End If

            'Dim stream_reader As New IO.StreamReader(DirsToMonitor)
            Using xfile As System.IO.StreamWriter = My.Computer.FileSystem.OpenTextFileWriter(DirsToMonitor, True)
                xfile.WriteLine("#DirectoryName | Y or N for include subdirectories or do not include subdirectories")
                For Each dir As String In DirectoryList.Keys
                    DirToProcess = dir + "|" + DirectoryList(dir).ToUpper.Trim
                    xfile.WriteLine(DirToProcess)
                Next
            End Using

        Catch ex As Exception
            MessageBox.Show("ERROR: Cannot add listener: " + ex.Message)
        End Try

        getLIsteners()

        Return
    End Sub

    Private Sub CkMonitor_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CkMonitor.CheckedChanged
        If lbArchiveDirs.SelectedItems.Count.Equals(0) Then
            MessageBox.Show("To use this, one and only one directory must be selected, returning")
            Return
        End If
        If lbArchiveDirs.SelectedItems.Count > 1 Then
            MessageBox.Show("To use this, one and only one directory must be selected - Please use the Utility Listener item to process multiple listeners, returning")
            Return
        End If
        CkMonitor.Checked = False
        ProcessListener(True)
        MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ")
    End Sub

    Private Sub ckRunUnattended_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckRunUnattended.CheckedChanged

        If formloaded = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        Dim B As Boolean = False

        If ckRunUnattended.Checked Then
            frmAgreement.txtAgreement.Text = "Running in unattended mode will cause all warnings and errors that HALT the system to be written to a log and NOT shown or displayed. By selecting this option, you agree to accept full responsibility to review this log for errors. ECM Library accepts no responsibility to notify you of errors outside of the log when running in unattended mode."
            frmAgreement.ShowDialog()
            B = gLegalAgree
            If B = False Then
                S = "UPDATE [RunParms] SET [ParmValue] = '0' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + gCurrUserGuidID + "' "
                B = DBARCH.ExecuteSqlNewConn(90321, S)
                If B Then
                    gRunUnattended = False
                    SB.Text = "Unattended mode disabled."
                Else
                    SB.Text = "FAILED to enable Unattended mode."
                End If
                SB.Text = "Terms refused, RUN UNATTENDED is not enabled."
                formloaded = False
                ckRunUnattended.Checked = False
                formloaded = True
                Return
            End If
        End If

        Dim ckVal As String = DBARCH.getUserParm("user_RunUnattended")
        If ckVal.Trim.Length = 0 Then

            S = ""
            S = S + " INSERT INTO [RunParms]"
            S = S + " ([Parm]"
            S = S + " ,[ParmValue]"
            S = S + " ,[UserID]"
            S = S + " ,[ParmDesc])"
            S = S + " VALUES "
            S = S + " ('user_RunUnattended'"
            S = S + " ,'0'"
            S = S + " ,'" + gCurrUserGuidID + "'"
            S = S + " ,'A zero turns OFF Unattended Mode, a 1 turns it ON.')"

            B = DBARCH.ExecuteSqlNewConn(S, False)
        End If

        If ckRunUnattended.Checked Then
            S = "UPDATE [RunParms] SET [ParmValue] = '1' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + gCurrUserGuidID + "' "
            B = DBARCH.ExecuteSqlNewConn(90322, S)
            If B Then
                gRunUnattended = True
                SB.Text = "System set to run in unattended mode."
                'FrmMDIMain.SB4.BackColor = Color.Red
                'FrmMDIMain.SB4.Text = "Unattended ON"
            Else
                gRunUnattended = False
            End If
        Else
            S = "UPDATE [RunParms] SET [ParmValue] = '0' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + gCurrUserGuidID + "' "
            B = DBARCH.ExecuteSqlNewConn(90323, S)
            If B Then
                gRunUnattended = False
                SB.Text = "Unattended mode disabled."

                'FrmMDIMain.SB4.Text = "Unattended OFF"
                'FrmMDIMain.SB4.BackColor = Color.Silver
            Else
                SB.Text = "FAILED to enable Unattended mode."
            End If
            ckRunUnattended.Checked = False
        End If

    End Sub

    Sub SetUnattendedFlag()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        Dim B As Boolean = DBARCH.SysParmExists("srv_RunUnattended")
        If B = False Then
            S = "INSERT INTO SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)"
            S = S + " values ('srv_RunUnattended','This allows the archive functions to run unattended.','N','Y')"
            B = DBARCH.ExecuteSqlNewConn(90324, S)
            If B Then
                gRunUnattended = False
                SB.Text = "Unattended mode turned off."
            Else
                SB.Text = "Failed to turned off RUN UNATTENDED mode - no change to current state."
            End If
        End If

        Dim ckVal As String = DBARCH.getUserParm("user_RunUnattended")
        If ckVal.Equals("1") Then
            gRunUnattended = True
        ElseIf ckVal.Equals("0") Then
            gRunUnattended = False
        ElseIf ckVal.ToUpper.Equals("Y") Then
            gRunUnattended = True
        ElseIf ckVal.ToUpper.Equals("N") Then
            gRunUnattended = False
        Else
            gRunUnattended = False
        End If
    End Sub

    Sub SetUnattendedCheckBox()
        formloaded = False

        Dim ckVal As String = DBARCH.getUserParm("user_RunUnattended")

        If ckVal.Equals("1") Then
            gRunUnattended = True
            Me.ckRunUnattended.Checked = gRunUnattended
        ElseIf ckVal.Equals("0") Then
            gRunUnattended = False
            Me.ckRunUnattended.Checked = gRunUnattended
        ElseIf ckVal.ToUpper.Equals("Y") Then
            gRunUnattended = True
            Me.ckRunUnattended.Checked = gRunUnattended
        ElseIf ckVal.ToUpper.Equals("N") Then
            gRunUnattended = False
            Me.ckRunUnattended.Checked = gRunUnattended
        Else
            gRunUnattended = False
            Me.ckRunUnattended.Checked = gRunUnattended
        End If
        formloaded = True
    End Sub

    Sub ValidateEntry()

        If FoldersRefreshed = True Then
            Return
        End If

        Me.Cursor = Cursors.AppStarting

        For I As Integer = 0 To cbParentFolders.Items.Count - 1
            Dim Container As String = cbParentFolders.Items(I).ToString
            cbParentFolders.Text = Container
            '***************************************************
            btnRefreshFolders_Click(Nothing, Nothing)
            '***************************************************
        Next
        FoldersRefreshed = True
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub TimerListeners_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerListeners.Tick

        If ListenersDefined = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bDoNotRun As Boolean = False
        Dim frm As Form
        Try
            For Each frm In My.Application.OpenForms
                Application.DoEvents()
                If frm Is My.Forms.frmNotify Then
                    bDoNotRun = True
                    Exit For
                End If
                If frm Is My.Forms.frmNotify2 Then
                    bDoNotRun = True
                    Exit For
                End If
                If frm Is My.Forms.frmExchangeMonitor Then
                    bDoNotRun = True
                End If
                If frm Is My.Forms.frmNotifyListener Then
                    bDoNotRun = True
                    Exit For
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine("Collection processed.")
        End Try
        Dim TempList As New SortedList(Of String, Integer)
        TempList = gFilesToArchive
        If gFilesToArchive.Count = 0 Then
            Return
        End If

        Try
            For Each sKey As String In TempList.Keys
                If Mid(sKey, 1, 1).Equals("~") Then
                    Console.WriteLine("Skipping: " + sKey)
                Else
                    DBLocal.addListener(sKey)
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            TempList = Nothing
            LOG.WriteToArchiveLog("WARNING: TICK - 001: " + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            Return
        End Try

        TempList = Nothing

        frm = Nothing
        If bDoNotRun = True Then
            Return
        End If

        If ThreadCnt > 0 Then
            Me.Text = "ECM Library Archive System         {Threads: " + ThreadCnt.ToString + "}"
        Else
            Me.Text = "ECM Library Archive System         (no active archives)"
        End If

        If ThreadCnt > 50 Then
            Me.Text = "ECM Library Archive System         {Threads: " + ThreadCnt.ToString + "}  (MAX Threads)"
            Return
        End If

        If BackgroundDirListener.IsBusy Then
            Return
        End If

        'TimerListeners.Enabled = False
        Try
            BackgroundDirListener.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try

        'TimerListeners.Enabled = True
    End Sub

    Private Sub ckPauseListener_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckPauseListener.CheckedChanged
        'Dim LISTEN As New clsListener
        If formloaded = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Static ListenersLoaded As Boolean = False
        If ckPauseListener.Checked = True Then
            LISTEN.PauseListeners(MachineName, True)
            TimerListeners.Enabled = False
        Else
            If ListenersLoaded = False Then
                ListenersLoaded = True
                LISTEN.LoadListeners(MachineName)
            End If

            LISTEN.PauseListeners(MachineName, False)
            TimerListeners.Enabled = True
        End If
        'LISTEN = Nothing
    End Sub

    ''** process table DirectoryListenerFiles
    Sub ProcessListenerFiles(ByVal UseThreads As Boolean)

        Dim L As New SortedList(Of String, Integer)
        '**********************************************
        'DBARCH.GetListenerFiles(L)
        DBLocal.getListenerFiles(L)
        '**********************************************

        LOG.WriteToListenLog("Listener files found = " + L.Count.ToString)

        If L.Count = 0 Then
            Return
        End If

        'If UseThreads = False Then FrmMDIMain.ListenerStatus.Text = "Listener Active"

        frmNotifyListener.Show()

        Dim DirName As String = ""
        Dim FQN As String = ""
        Dim DirGuid As String = ""
        Dim Successful As Boolean = False
        Dim fName As String = ""

        Dim iFiles As Integer = 0
        Dim iSkip As Integer = 1

        For Each FQN In L.Keys

            If gFilesToArchive.ContainsKey(FQN) Then
                gFilesToArchive.Remove(FQN)
            End If

            If Not File.Exists(FQN) Then
                GoTo SKIPTHISREC
            End If

            iSkip = L.Item(FQN)
            If iSkip < 0 Then
                GoTo SKIPTHISREC
            End If

            Dim FI As New FileInfo(FQN)
            DirName = FI.DirectoryName
            fName = FI.Name
            FI = Nothing

            GC.Collect()

            iFiles += 1

            frmNotifyListener.Text = "F:" + iFiles.ToString
            frmNotifyListener.Label1.Text = "Listener Files: " + iFiles.ToString
            frmNotifyListener.Refresh()
            Application.DoEvents()

            Dim IDX As Integer = L.IndexOfKey(FQN)

            DirGuid = DBARCH.getDirGuid(DirName, MachineName)
            DirName = DBARCH.getDirListenerNameByGuid(DirGuid)
            'DirGuid  = DBARCH.getDirGuid(DirName, MachineIDcurr)

            DirGuid = DirGuid.Trim

            Successful = False
            LOG.WriteToListenLog("ArchiveSingleFile: archiving " + FQN + " From machine " + MachineName + ".")

            Dim fExt As String = DMA.getFileExtension(FQN)
            If File.Exists(FQN) Then
                ARCH.ArchiveSingleFile(UIDcurr, MachineName, DirName, FQN, DirGuid, Successful)
                If Successful Then
                    DBLocal.MarkListenersProcessed(FQN)
                End If
            Else
                DBLocal.MarkListenersProcessed(FQN)
                'Dim SX As String = "delete FROM [DirectoryListenerFiles] where SourceFile = '" + FQN + "'  and DirGuid   = '" + DirGuid  + "'"
                'DBARCH.ExecuteSqlNewConn(SX)
            End If
SKIPTHISREC:
        Next

        DBLocal.DelListenersProcessed()

        TimerListeners.Enabled = True
        'If UseThreads = False Then FrmMDIMain.ListenerStatus.Text = "."
        ThreadCnt -= 1
        frmNotifyListener.Close()
        frmNotifyListener.Dispose()
        L = Nothing
    End Sub

    Private Sub TimerUploadFiles_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerUploadFiles.Tick
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim frm As Form
        Try
            For Each frm In My.Application.OpenForms
                Application.DoEvents()
                If frm Is My.Forms.frmNotify Then
                    Return
                End If
                If frm Is My.Forms.frmNotify2 Then
                    Return
                End If
                If frm Is My.Forms.frmExchangeMonitor Then
                    Return
                End If
                If frm Is My.Forms.frmNotifyListener Then
                    Return
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine("TimerUploadFiles 11 forms")
        End Try
        frm = Nothing
        Try
            If Not t2 Is Nothing Then
                If t2.IsAlive Then
                    Return
                End If
            End If
            If Not t3 Is Nothing Then
                If t3.IsAlive Then
                    Return
                End If
            End If
            If Not t4 Is Nothing Then
                If t4.IsAlive Then
                    Return

                End If
            End If
            If Not t5 Is Nothing Then
                If t5.IsAlive Then
                    Return
                End If
            End If

            Dim ElapsedSecs As Integer = ElapsedTimeSec(gListenerActivityStart, Now)
            If ElapsedSecs > 60 Then

                Dim cPath As String = LOG.getTempEnvironDir()
                Dim tFQN As String = cPath + "\ListenerFilesLog.ECM"
                Dim NewFile As String = tFQN + ".rdy"

                If Not File.Exists(tFQN) Then
                    gListenerActivityStart = Now
                    'TimerUploadFiles.Enabled = False
                    Return
                Else
                    gListenerActivityStart = Now
                End If

                LOG.WriteToInstallLog("ACTIVATED the TimerUploadFiles !")

                TimerUploadFiles.Enabled = False

                '**********************************************
                DBARCH.getModifiedFiles()
                '**********************************************
                TimerUploadFiles.Enabled = True
                TimerListeners.Enabled = True

                If Not File.Exists(NewFile) Then
                    ISO.saveIsoFile("FilesToDelete.dat", NewFile + "|")
                    'File.Delete(NewFile)
                End If

            End If
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90.11 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine("TimerUploadFiles 12 forms")
        End Try

    End Sub

    Private Sub TimerEndRun_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerEndRun.Tick
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim frm As Form
        Try
            For Each frm In My.Application.OpenForms
                Application.DoEvents()
                If frm Is My.Forms.frmNotify Then
                    Return
                End If
                If frm Is My.Forms.frmNotify2 Then
                    Return
                End If
                If frm Is My.Forms.frmExchangeMonitor Then
                    Return
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine("TimerEndRun_Tick forms")
        End Try
        frm = Nothing

        Try
            If Not t2 Is Nothing Then
                If t2.IsAlive Then
                    Return
                End If
            End If
            If Not t3 Is Nothing Then
                If t3.IsAlive Then
                    Return
                End If
            End If
            If Not t4 Is Nothing Then
                If t4.IsAlive Then
                    Return
                End If
            End If
            If Not t5 Is Nothing Then
                If t5.IsAlive Then
                    Return
                End If
            End If

            Dim ArchiveType As String = ""
            ArchiveType = DBARCH.getRconParm(gCurrUserGuidID, "ArchiveType")
            STATS.setArchiveenddate(Now.ToString)
            STATS.setArchivetype(ArchiveType)
            STATS.setStatus("Successful")
            STATS.setSuccessful("Y")
            STATS.setUserid(gCurrUserGuidID)

            Dim iCnt As Integer = 0
            iCnt = DBARCH.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + gCurrUserGuidID + "'")
            STATS.setTotalcontentinrepository(iCnt.ToString)
            iCnt = DBARCH.iGetRowCount("Email", "where UserID = '" + gCurrUserGuidID + "'")
            STATS.setTotalemailsinrepository(iCnt.ToString)

            Dim BB As Boolean = STATS.Insert
            If Not BB Then
                LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.")
                LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.")
            End If

            Me.SetArchiveEndStats(ArchiveType)

            TimerEndRun.Enabled = False

            If UseThreads = False Then
                DBARCH.UpdateAttachmentCounts()
            Else
                ThreadCnt += 1
                t6 = New Thread(AddressOf DBARCH.UpdateAttachmentCounts)
                t6.Priority = ThreadPriority.Lowest
                '*******************************************************************
                t6.Start()
            End If

            If UseThreads = False Then
                '*******************************************************************
                resetBadDates()
                '*******************************************************************
            Else
                ThreadCnt += 1
                t7 = New Thread(AddressOf resetBadDates)
                t7.Priority = ThreadPriority.Lowest
                '*******************************************************************
                t7.Start()
                '*******************************************************************
            End If

            SB.Text = "Archive Completed."
            SB2.Text = "Archive Quiet"

            DBLocal.BackUpSQLite()
            gCurrentArchiveGuid = ""
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 90 - TIMER: " + ex.Message)
            MessageBox.Show("ERROR 90 - TIMER: " + ex.Message)
        End Try

    End Sub

    Private Sub btnRefreshRetent_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshRetent.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        DBARCH.LoadRetentionCodes(cbRetention)
        DBARCH.LoadRetentionCodes(cbEmailRetention)
    End Sub

    Private Sub ckShowLibs_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckShowLibs.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        If ckShowLibs.Checked Then
            frmLibraryAssgnList.Show()
        Else
            frmLibraryAssgnList.Close()
        End If
    End Sub

    Private Sub ckOcrPdf_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckOcrPdf.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Sub SetDateFormats()

        Dim dateString As String = ""
        Dim format As String = ""
        'Dim result As Date

        Dim Info As System.Globalization.DateTimeFormatInfo
        Info = System.Globalization.CultureInfo.CurrentUICulture.DateTimeFormat

        Dim S As String = ""
        gDateSeparator = Info.DateSeparator
        gTimeSeparator = Info.TimeSeparator
        gShortDatePattern = Info.ShortDatePattern
        gShortTimePattern = Info.ShortTimePattern

        Console.WriteLine(Now)

    End Sub

    Function ckLicense() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        lblCustomerName.Text = gCustomerName
        lblCustomerID.Text = gCustomerID

        Dim LT As String = Nothing
        Dim bLicenseExists As Boolean = DBARCH.LicenseExists
        If Not bLicenseExists Then
            MessageBox.Show("There does not appear to be an active license for this installation, please contact an administrator - or install a valid license.")
        Else
            '** Check the expiration date and the service expiration date
            Dim MachineName As String = DMA.GetCurrMachineName

            DBARCH.RegisterMachineToDB(MachineName)

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 12")

            LT = DBARCH.GetXrt(gCustomerName, gCustomerID)
            Dim isLease As Boolean = LM.isLease
            gMaxClients = LM.getMaxClients

            If gMaxClients > 0 Then
                Dim SS As String = "Select count(*) from LoginClient"
                Dim EcmClientsDefinedToSystem As Integer = DBARCH.iCount(SS)
                If EcmClientsDefinedToSystem > gMaxClients Then
                    Dim MSG As String = "It appears all ECM Client licenses have been used." + vbCrLf
                    MSG += "Please logon from a licensed machine," + vbCrLf + vbCrLf
                    MSG += "or contact ECM Library for additional client licenses." + vbCrLf + vbCrLf
                    MSG += "Thank you, closing down." + vbCrLf
                    MessageBox.Show(MSG)
                    End
                End If
            End If

            DBARCH.RegisterEcmClient(MachineName)

            gNbrOfSeats = Val(LM.ParseLic(LT, "txtNbrSeats"))
            gLicenseType = LM.LicenseType
            gIsSDK = LM.SdkLicenseExists

            tssUser.Text = "Seats:" + gNbrOfSeats.ToString
            gNbrOfUsers = Val(LM.ParseLic(LT, "txtNbrSimlSeats"))
            tssServer.Text = "Server: ?"

            '**********************************************************
            Dim CurrNbrOfUsers As Integer = DBARCH.GetNbrUsers
            Dim CurrNbrOfMachine As Integer = DBARCH.GetNbrMachine
            '**********************************************************

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 13")

            If CurrNbrOfUsers >= gNbrOfUsers Then
                Dim Msg As String = ""
                Msg = Msg + "FrmMDIMain : MachineName : 1103 : " + vbCrLf
                Msg = Msg + "     Number of licenses warning : '" + MachineName + "'" + vbCrLf
                Msg = Msg + "     We are very sorry, but the maximum number of USERS has been exceeded." + vbCrLf
                Msg = Msg + "     ECM found " + CurrNbrOfUsers.ToString + " users currently registered in the system." + vbCrLf
                Msg = Msg + "     Your license awards " + gNbrOfUsers.ToString + " users." + vbCrLf
                Msg = Msg + "You will have to login with an existing User ID and Password." + vbCrLf + "Please contact admin for support."
                LOG.WriteToArchiveLog(Msg)
                MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                Me.LoginAsDifferenctUserToolStripMenuItem_Click(Nothing, Nothing)
            End If

            If CurrNbrOfMachine >= gNbrOfSeats Then
                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 14")
                Dim IP As String = DMA.getIpAddr
                gIpAddr = IP
                MachineIDcurr = MachineName
                DBARCH.updateIp(MachineIDcurr, gIpAddr, 0)
                DBARCH.updateIp(MachineIDcurr, gIpAddr, 1)
                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 15")
                Dim Msg As String = ""
                Msg = Msg + "FrmMDIMain : Current Users : 1103b : " + vbCrLf
                Msg = Msg + "     Number of current SEATS warning : '" + MachineName + "'" + vbCrLf
                Msg = Msg + "     We are very sorry, but the maximum number of seats (WorkStations) has been exceeded." + vbCrLf
                Msg = Msg + "     ECM found " + CurrNbrOfMachine.ToString + " machines registered in the system." + vbCrLf
                Msg = Msg + "     Your license awards " + gNbrOfSeats.ToString + " seats." + vbCrLf
                Msg = Msg + "You will have to login from a WorkStation already defined to ECM." + vbCrLf + "Please contact admin for support."
                LOG.WriteToArchiveLog(Msg)
                MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                If isAdmin Then
                    Msg = ""
                    Msg = Msg + "You are an administrator for ECM Library." + vbCrLf
                    Msg = Msg + "If you have a new license, would you like " + vbCrLf
                    Msg = Msg + "to open the license management screen and apply a new license."
                    MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                    Dim dlgRes As DialogResult = MessageBox.Show(Msg, "License Update", MessageBoxButtons.YesNo)
                    If dlgRes = Windows.Forms.DialogResult.Yes Then
                        frmLicense.ShowDialog()
                        MessageBox.Show("Restarting the application.")
                        Application.Restart()
                    End If
                End If
            Else
                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 16")
                Dim iExists As Integer = DBARCH.GetNbrMachine(MachineName)
                If iExists = 0 Then
                    Dim MySql As String = "insert into Machine (MachineName) values ('" + MachineName + "')"
                    Dim B As Boolean = DBARCH.ExecuteSqlNewConn(MySql, False)
                    If Not B Then
                        LOG.WriteToArchiveLog("FrmMDIMain : MachineName : 921 : Failed to register machine : '" + MachineName + "'")
                    End If
                End If
                Dim IP As String = DMA.getIpAddr

                gIpAddr = IP
                MachineIDcurr = MachineName

                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 17")

                DBARCH.updateIp(MachineIDcurr, gIpAddr, 0)
                DBARCH.updateIp(MachineIDcurr, gIpAddr, 2)

                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 18")

            End If

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 19")

            If isLease = True Then

                Dim ExpirationDate As Date = CDate(LM.ParseLic(LT, "dtExpire"))

                Dim dtStartDate As Date = "1/1/2007"
                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                Dim strMsgText As String = ""
                tsTimeSpan = ExpirationDate.Subtract(Now)
                iNumberOfDays = tsTimeSpan.Days

                If Now > ExpirationDate.AddDays(30) Then
                    MessageBox.Show("The ECM run license has expired." + vbCrLf + vbCrLf + "Please contact ECM Library support.", "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                    End
                End If

                If iNumberOfDays <= 7 Then
                    infoDaysToExpire.Text = "License! " + iNumberOfDays.ToString
                    infoDaysToExpire.BackColor = Color.Red
                ElseIf iNumberOfDays <= 14 Then
                    infoDaysToExpire.BackColor = Color.LightSalmon
                    infoDaysToExpire.Text = "License! " + iNumberOfDays.ToString
                ElseIf iNumberOfDays <= 30 Then
                    infoDaysToExpire.BackColor = Color.Yellow
                    infoDaysToExpire.Text = "License@ " + iNumberOfDays.ToString
                ElseIf iNumberOfDays <= 60 Then
                    infoDaysToExpire.BackColor = Color.LightSeaGreen
                    infoDaysToExpire.Text = "License? " + iNumberOfDays.ToString
                ElseIf iNumberOfDays < 90 Then
                    infoDaysToExpire.BackColor = Color.Green
                    infoDaysToExpire.Text = "License* " + iNumberOfDays.ToString
                Else
                    infoDaysToExpire.Text = " #" + iNumberOfDays.ToString + " days"
                End If

                If Now > ExpirationDate Then
                    LOG.WriteToArchiveLog("FrmMDIMain : 1001 We are very sorry, but your software LEASE has expired. Please contact ECM Library support.")
                    MessageBox.Show("We are very sorry, but your software license has expired." + vbCrLf + vbCrLf + "Please contact ECM Library support.", "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                    frmLicense.ShowDialog()
                    MessageBox.Show("The application will now end, please restart with the new license.")
                End If
            End If

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 21")
            Dim MaintExpire As Date = CDate(LM.ParseLic(LT, "dtMaintExpire"))
            If Now > MaintExpire Then
                frmNotifyMessage.Show()
                gNotifyMsg = "We are very sorry to inform you, but your maintenance agreement has expired." + vbCrLf + vbCrLf + "Please contact ECM Library support."
                LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.")
            End If
            'If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 22")
            'CustomerID = LM.ParseLic(LT , "txtCustID")
            'If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 23")
        End If
    End Function

    Private Sub OutlookEmailsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OutlookEmailsToolStripMenuItem.Click

        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If
        If ckDisableOutlookEmailArchive.Checked Then
            SB.Text = "DISABLE Outlook is checked - no archive allowed."
            Return
        End If

        If BackgroundWorker1.IsBusy Then
            SB.Text = "Currently archiving, stand by."
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            BackgroundWorker1.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Private Sub ExchangeEmailsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExchangeEmailsToolStripMenuItem.Click
        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            gAutoExecExchangeComplete = True
            Return
        End If
        If ckDisableExchange.Checked Then
            SB.Text = "DISABLE Exchange Archive is checked - no archive allowed."
            gAutoExecExchangeComplete = True
            Return
        End If

        If BackgroundWorker2.IsBusy Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            BackgroundWorker2.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Private Sub ContentToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ContentToolStripMenuItem.Click

        Dim watch As Stopwatch = Stopwatch.StartNew()
        Dim PerformQUickArchive As Boolean = True

        BeginContentArchive(PerformQUickArchive)

        Dim totsecs As Decimal = 0
        totsecs = watch.Elapsed.TotalSeconds
        LOG.WriteToArchiveLog("*** TOTAL TIME FOR QUICK Archive: " + totsecs.ToString + " Seconds")

    End Sub

    Private Sub ArchiveALLToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ArchiveALLToolStripMenuItem.Click

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If

        If Not BackgroundWorker1.IsBusy Then
            BackgroundWorker1.RunWorkerAsync()
        End If
        If Not BackgroundWorker2.IsBusy Then
            BackgroundWorker2.RunWorkerAsync()
        End If
        If Not ContentThread.IsBusy Then
            ContentThread.RunWorkerAsync()
        End If
        If Not BackgroundWorkerContacts.IsBusy Then
            BackgroundWorkerContacts.RunWorkerAsync()
        End If
        If Not asyncRssPull.IsBusy Then
            asyncRssPull.RunWorkerAsync()
        End If
        If Not asyncSpiderWebSite.IsBusy Then
            asyncSpiderWebSite.RunWorkerAsync()
        End If
        If Not asyncSpiderWebPage.IsBusy Then
            asyncSpiderWebPage.RunWorkerAsync()
        End If

    End Sub

    Private Sub LoginAsDifferenctUserToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LoginAsDifferenctUserToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        CloseChildWindows()
        LoginAsNewUser = True
        gCurrLoginID = ""
        Me.LogIntoSystem(gCurrLoginID)
        tssUser.Text = gCurrUserGuidID
        tssAuth.Text = DBARCH.getAuthority(gCurrUserGuidID)
    End Sub

    Sub CloseChildWindows()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim form As System.Windows.Forms.Form
        For Each form In Me.MdiChildren
            form.Close()
        Next form
    End Sub

    Sub LogIntoSystem(ByVal OverRideLoginID As String)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim l As Integer = 0

        Try
            l = 1
            For Each f As Form In Me.MdiChildren
                f.Close()
            Next f
            l = 2
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            l = 3
        End Try
        l = 4
        Try
            l = 5
            Me.SB.Text = "Loading, standby"
            l = 6
            FilesToDelete.Clear()
            l = 7
            Me.SB.Text = "Ready"
            Dim SaveName As String = "UserStartUpParameters"
            Dim SaveTypeCode As String = "StartUpParm"
            Dim CurrentLoginID As String = ""
            Dim iAttempts As Integer = 1
            l = 8
Retry:
            If iAttempts >= 4 Then
                MessageBox.Show("Too many failed login attempts, closing down.")
                Me.Close()
                Me.Dispose()
                End
            End If
            l = 9
            Dim X1 As String = System.Configuration.ConfigurationManager.AppSettings("LoginByMachineIdAndLoginID")
            l = 10
            If X1.Equals("1") And LoginAsNewUser = False Then
                Dim LoggedInUser As String = LOG.getEnvVarUserID : l = 11
                If OverRideLoginID.Length > 0 Then
                    LoggedInUser = OverRideLoginID : l = 12
                End If
                l = 13
                If LoggedInUser.Length = 0 Then
                    LoggedInUser = DMA.GetCurrMachineName() : l = 14
                End If
                l = 15
                gCurrUserGuidID = DBARCH.getUserGuidID(LoggedInUser) : l = 16
                If gCurrUserGuidID.Length > 0 Then
                    '** Good login
                    l = 17
                    GoTo GoodLogin
                Else
                    l = 18
                    GoTo BadAutoLogin
                End If
            End If
BadAutoLogin:
            MessageBox.Show("REMOVE THIS: LoginForm1.ShowDialog 1: " + l.ToString)
            LoginForm1.ShowDialog()

            If System.Environment.UserName.ToString.Length = 0 Then
                gCurrUserGuidID = DMA.GetCurrMachineName()
                LoginForm1.txtLoginID.Text = DMA.GetCurrMachineName()
            Else
                LoginForm1.txtLoginID.Text = System.Environment.UserName.ToString
            End If

            CurrentLoginID = LoginForm1.UID

            Dim BB As Boolean = LoginForm1.bGoodLogin
            If BB And CurrentLoginID.Trim.Length > 0 Then
                gCurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID)
            Else
                MessageBox.Show("Incorrect login or password supplied, please try again.")
                iAttempts += 1
                LoginForm1.Dispose()
                GoTo Retry
            End If
            LoginForm1.Dispose()
GoodLogin:

            CurrentLoginID = LoginForm1.txtLoginID.Text
            gCurrLoginID = CurrentLoginID

            gCurrLoginID = CurrentLoginID.ToUpper

            gCurrUserGuidID = DBARCH.getUserGuidID(gCurrLoginID)
            If gCurrLoginID.ToUpper.Equals("SERVICEMANAGER") Then
                gIsServiceManager = True
                'QuickArchiveToolStripMenuItem.Visible = False
                CurrentLoginID = gCurrLoginID
            Else
                gIsServiceManager = False
                'QuickArchiveToolStripMenuItem.Visible = True
            End If

            If gCurrUserGuidID.Trim.Length = 0 Then
                CurrentLoginID = System.Environment.UserName.ToString
            End If
            If gCurrUserGuidID.Trim.Length = 0 Then
                gCurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID)
            End If
            Dim TempDir As String = System.IO.Path.GetTempPath

            SetDefaults()

            'frmQuickSearch.MdiParent = Me
            'frmQuickSearch.Show()
            'frmQuickSearch.WindowState = FormWindowState.Maximized

            Dim b As Integer = DBARCH.ckUserStartUpParameter(gCurrUserGuidID, "CONTENT WORKING DIRECTORY")
            If b = 0 Then
                SI.setSavename(SaveName)
                SI.setSavetypecode(SaveTypeCode)
                SI.setUserid(gCurrUserGuidID)
                SI.setValname("CONTENT WORKING DIRECTORY")
                SI.setValvalue(TempDir)
                SI.Insert()
            End If
            b = DBARCH.ckUserStartUpParameter(gCurrUserGuidID, "EMAIL WORKING DIRECTORY")
            If b = 0 Then
                SI.setSavename(SaveName)
                SI.setSavetypecode(SaveTypeCode)
                SI.setUserid(gCurrUserGuidID)
                SI.setValname("EMAIL WORKING DIRECTORY")
                SI.setValvalue(TempDir)
                SI.Insert()
            End If
            SB.Text = "Logged in as " + CurrentLoginID
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("FrmMDIMain : ReLogIntoSystem : 100 : " + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
            MessageBox.Show("LogIntoSystem: Login failed.")
        End Try

        isAdmin = DBARCH.isAdmin(gCurrUserGuidID)
        isGlobalSearcher = DBARCH.isGlobalSearcher(gCurrUserGuidID)

        If isAdmin Then
            SB.Text = "ADMIN Logged in as: " + DBARCH.getUserLoginByUserid(gCurrUserGuidID)
        Else
            SB.Text = "Logged in as: " + DBARCH.getUserLoginByUserid(gCurrUserGuidID)
        End If

        If DBARCH.isSuperAdmin(gCurrUserGuidID) Then
            ImpersonateLoginToolStripMenuItem.Visible = True
        Else
            ImpersonateLoginToolStripMenuItem.Visible = False
        End If

    End Sub

    Sub SetDefaults()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DBARCH.LoadProcessDates()
        'bFormLoaded = True

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 25")

        isAdmin = DBARCH.isAdmin(gCurrUserGuidID)
        isGlobalSearcher = DBARCH.isGlobalSearcher(gCurrUserGuidID)

        DBARCH.UserParmInsertUpdate("CurrSearchCriteria", gCurrUserGuidID, " ")
        ''DBARCH.UserParmInsertUpdate("CurrSearchThesaurus", gCurrUserGuidID, txtThesaurus.Text.Trim)
        DBARCH.UserParmInsertUpdate("ckLimitToExisting", gCurrUserGuidID, "0")
        DBARCH.DeleteMarkedImageCopyFiles()
        TurnHelpOn(0)
        Me.Activate()
        bInitialized = True
        'DfltData.PopulateLookupTables()

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 27")

        'DBARCH.UserParmInsert("SoundOn", gCurrUserGuidID, "ON")
        'RMT.getHelpQuiet()
        Dim SoundOn As String = DBARCH.UserParmRetrive("SoundOn", gCurrUserGuidID)
        If UCase(SoundOn).Equals("ON") Then
            gVoiceOn = True
        Else
            gVoiceOn = False
        End If
        If gVoiceOn = True Then
            Dim Phrase As String = "Welcome to E C M Library."
            SB.Text = Phrase
            DMA.SayWords(Phrase)
        End If

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 28")
        '** Turned Off by WDM 7/13/2009
        'If isAdmin = True Then
        '    RepositoryUtilitiesToolStripMenuItem.Visible = True
        '    AdminToolStripMenuItem.Visible = True
        '    SystemDetailsToolStripMenuItem.Visible = True
        '    UsersToolStripMenuItem.Visible = True
        '    UndefinedFiletypeCodesToolStripMenuItem.Visible = True
        'Else
        '    RepositoryUtilitiesToolStripMenuItem.Visible = False
        '    'AdminToolStripMenuItem.Visible = False
        '    AdminToolStripMenuItem.Visible = True
        '    SystemDetailsToolStripMenuItem.Visible = False
        '    UsersToolStripMenuItem.Visible = False
        '    UndefinedFiletypeCodesToolStripMenuItem.Visible = False
        'End If
        Dim Msg2 As String = "Login: " + DMA.GetCurrUserName
        Msg2 = Msg2 + ", " + DMA.GetCurrMachineName
        Msg2 = Msg2 + ", " + DMA.GetCurrOsVersionName
        'DBARCH.xTrace(99276, Msg2, "frmMdiMain:Load")

        SystemSqlTimeout = DBARCH.getSystemParm("SqlServerTimeout")
        'ListControls()

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 29")

        If isAdmin = False Then
            'AdminToolStripMenuItem.Visible = False
        Else
            'AdminToolStripMenuItem.Visible = True
        End If

        Dim sEcmCrawlerAvailable As String = System.Configuration.ConfigurationManager.AppSettings("EcmCrawlerAvailable")
        If isAdmin Then
            If sEcmCrawlerAvailable.Equals("Y") Then
                bEcmCrawlerAvailable = True
                'WebCrawlerSetupToolStripMenuItem.Visible = True
            Else
                bEcmCrawlerAvailable = False
                'WebCrawlerSetupToolStripMenuItem.Visible = False
            End If
        Else
            bEcmCrawlerAvailable = False
            'WebCrawlerSetupToolStripMenuItem.Visible = False
        End If

        MachineIDcurr = DMA.GetCurrMachineName

        DBARCH.ckMissingWorkingDirs()
        Dim sDebug As String = DBARCH.getUserParm("user_showContactMenu")

        Try
            Dim strDaysToKeepTraceLogs As String = DBARCH.getUserParm("user_DaysToKeepTraceLogs")
            If strDaysToKeepTraceLogs.Trim.Length > 0 Then
                gDaysToKeepTraceLogs = CInt(strDaysToKeepTraceLogs)
            End If
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            gDaysToKeepTraceLogs = 3
        End Try

        SetVersionAndServer()

        isAdmin = DBARCH.isAdmin(gCurrUserGuidID)
        isGlobalSearcher = DBARCH.isGlobalSearcher(gCurrUserGuidID)

        If isAdmin = False Then
            'AdminToolStripMenuItem.Visible = False
            SB.Text = "Logged in as a user."
        Else
            'AdminToolStripMenuItem.Visible = True
            SB.Text = "Logged in as an Admin."
        End If

        Dim bEmbededJPGMetadata As Boolean = DBARCH.ShowGraphicMetaDataScreen

    End Sub

    Public Sub SetVersionAndServer()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            Dim S As String = " VER:" & My.Application.Info.Version.Major & "." & My.Application.Info.Version.Minor & "." & My.Application.Info.Version.Build & "." & My.Application.Info.Version.Revision & " "
            tssVersion.Text = S
            Dim SvrName = DBARCH.getNameOfCurrentServer()
            Dim CurrCS As String = DBARCH.setConnStr
            tssServer.Text = SvrName + ":" + getServer(CurrCS)
            If InStr(tssServer.Text, "unknown", CompareMethod.Text) > 0 Then
                tssServer.Text = getServer(System.Configuration.ConfigurationManager.AppSettings("ECMREPO"))
                LOG.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN.")
            End If
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine(ex.Message)
            LOG.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN." + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Function getServer(ByVal ConnectionString As String) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim SVR As String = ""
        Try

            Dim S As String = DBARCH.setConnStr
            Dim I As Integer = 1
            I = InStr(I, S, "Data Source=", CompareMethod.Text)
            I = InStr(I + 1, S, "=", CompareMethod.Text)
            Dim J As Integer = InStr(I + 1, S, ";", CompareMethod.Text)
            If I > 0 Then
                SVR = " " + Mid(S, I + 1, J - I - 1)
            Else
                SVR = "Unknown"
            End If
        Catch ex As Exception
            SVR = " UKN"
        End Try
        Return SVR
    End Function

    Private Sub ParameterExecutionToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ParameterExecutionToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim MSG As String = ""
        MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + vbCrLf + vbCrLf
        MSG = MSG + "X = Execute archive and close." + vbCrLf + vbCrLf
        MSG = MSG + "C = Archive CONTENT only." + vbCrLf + vbCrLf
        MSG = MSG + "O = Archive OUTLOOK only." + vbCrLf + vbCrLf
        MSG = MSG + "E = Archive EXCHANGE Servers only." + vbCrLf + vbCrLf
        MSG = MSG + "A = Archive ALL." + vbCrLf + vbCrLf
        MSG = MSG + "To Execute:" + vbCrLf
        MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + vbCrLf
        MSG = MSG + "(E.G.) C:\dev\ECM\EcmLibSvc\EcmLibSvc\bin\Debug\EcmArchiveSetup.exe Q" + vbCrLf
        MessageBox.Show(MSG)
    End Sub

    Private Sub HistoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HistoryToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        frmHistory.Show()
    End Sub

    Private Sub ckExpand_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckExpand.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ckExpand.Checked Then
            gbEmail.Width = gbContentMgt.Width
            gbContentMgt.Visible = False
            SB2.Visible = False
            SB.Visible = False
            gbPolling.Visible = False
            gbFiletypes.Visible = False
            gbEmail.Anchor = AnchorStyles.Bottom + AnchorStyles.Left + AnchorStyles.Top + AnchorStyles.Right
        Else
            gbEmail.Width = gbContentMgt.Left - 35
            gbContentMgt.Visible = True
            SB2.Visible = True
            SB.Visible = True
            gbPolling.Visible = True
            gbFiletypes.Visible = True
            gbEmail.Anchor = AnchorStyles.Bottom + AnchorStyles.Left + AnchorStyles.Top
        End If
    End Sub

    Private Sub ckDisableContentArchive_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisableContentArchive.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        saveStartUpParms()
        SB.Text = "Content Disabled set to " + ckDisableContentArchive.Checked.ToString
    End Sub

    Private Sub ckDisableOutlookEmailArchive_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisableOutlookEmailArchive.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        saveStartUpParms()
        SB.Text = "EMAIL Disabled set to " + ckDisableOutlookEmailArchive.Checked.ToString
    End Sub

    Private Sub ckDisableExchange_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisableExchange.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        saveStartUpParms()
        If ckDisableExchange.Checked Then
            SB.Text = "Exchange Disabled"
        Else
            SB.Text = "Exchange Enabled"
        End If

    End Sub

    Private Sub ViewLogsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewLogsToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim openFileDialog1 As New OpenFileDialog()

        openFileDialog1.InitialDirectory = LoggingPath
        openFileDialog1.Filter = "ECM Logs (ECM*.*)|ECM*.txt| txt files (*.txt)|*.txt|All files (*.*)|*.*"
        openFileDialog1.FilterIndex = 2
        openFileDialog1.RestoreDirectory = True
        If openFileDialog1.ShowDialog() = System.Windows.Forms.DialogResult.OK Then
            Dim fName As String = openFileDialog1.FileName
            Shell("notepad.exe " + Chr(34) + fName + Chr(34), vbNormalFocus)
            'Shell("notepad.exe " + Chr(34) + TempFolder + "\" + fName + Chr(34), vbNormalFocus)
        End If

    End Sub

    Private Sub DirectoryInventoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DirectoryInventoryToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim DirToInventory As String = "C:\dev"
        Dim ListOfFiles As String = ""
        Dim ckArchiveBit As Boolean = True
        Dim IncludeSubDirs As Boolean = True
        Dim FileExt As New List(Of String) From {
            ".DOC",
            ".XLS",
            ".VB"
        }

        Console.WriteLine("Start: " + Now.ToString)
        ListOfFiles = UTIL.getFileToArchive(DirToInventory, FileExt, ckArchiveBit, IncludeSubDirs)
        'Shell("Notepad.exe " + Chr(34) + ListOfFiles + Chr(34), vbNormalFocus)
        Console.WriteLine("End: " + Now.ToString)
        GC.Collect()
        GC.WaitForFullGCApproach()
    End Sub

    Private Sub ListFilesInDirectoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ListFilesInDirectoryToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        FilesBackedUp = 0
        FilesSkipped = 0

        Dim IncludedExts As New ArrayList
        Dim ExcludedExts As New ArrayList
        Dim FilesToArchive As New List(Of String)
        Dim MSG As String = ""
        Dim strFileSize As String = ""
        Dim FilterList As New List(Of String)
        Dim ArchiveAttr As Boolean = False

        FilterList.Add("*.xls")
        FilterList.Add("*.doc")
        FilterList.Add("*.vb")

        Console.WriteLine("Start: " + Now.ToString)

        Dim DirToInventory As String = "C:\dev"
        Dim iInventory As Integer = 0
        UTIL.GetFilesToArchive(iInventory, ArchiveAttr, False, DirToInventory, FilterList, FilesToArchive, IncludedExts, ExcludedExts)
        'For Each S As String In FilesToArchive
        '    Console.WriteLine(S)
        'Next
        Console.WriteLine("End: " + Now.ToString)
        GC.Collect()
        GC.WaitForFullGCApproach()

    End Sub

    Private Sub GetAllSubdirFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GetAllSubdirFilesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim IncludedTypes As New ArrayList
        Dim ExcludedTypes As New ArrayList

        Dim FilesToArchive As New List(Of String)
        Dim MSG As String = ""
        Dim strFileSize As String = ""
        Dim FilterList As New List(Of String)
        Dim ArchiveAttr As Boolean = False

        FilterList.Add("*.doc")
        FilterList.Add("*.xls")
        FilterList.Add("*.vb")

        FilesBackedUp = 0
        FilesSkipped = 0

        Console.WriteLine("Start: " + Now.ToString)
        Dim DirToInventory As String = "C:\dev"
        Dim iInventory As Integer = 0
        UTIL.GetFilesToArchive(iInventory, ArchiveAttr, True, DirToInventory, FilterList, FilesToArchive, IncludedTypes, ExcludedTypes)
        'For Each S As String In FilesToArchive
        '    Console.WriteLine(S)
        'Next
        Console.WriteLine("End: " + Now.ToString)
        GC.Collect()
        GC.WaitForFullGCApproach()
    End Sub

    Private Sub ViewOCRErrorFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewOCRErrorFilesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            Dim DirFQN As String = UTIL.getTempPdfWorkingErrorDir()
            Shell("explorer.exe " + Chr(34) + DirFQN + Chr(34), vbNormalFocus)
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try

    End Sub

    Private Sub ScheduleToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ScheduleToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        frmSchedule.ShowDialog()
    End Sub

    Private Sub RunningArchiverToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RunningArchiverToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub AboutToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AboutToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        AboutBox1.ShowDialog()
    End Sub

    Private Sub ManualEditAppConfigToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ManualEditAppConfigToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim aPath As String = System.AppDomain.CurrentDomain.BaseDirectory()
        Dim AppName As String = aPath + "EcmArchiveSetup.exe.config"
        System.Diagnostics.Process.Start("notepad.exe", AppName)
    End Sub

    Private Sub NumericUpDown1_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles nbrArchiveHours.ValueChanged
        If Not formloaded Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If nbrArchiveHours.Value = 0 Then
            My.Settings("BackupIntervalHours") = 0
            SB2.Text = "Quick archive disabled."
            'TimerQuickArchive.Enabled = False
        Else
            If nbrArchiveHours.Value < 4 Then
                nbrArchiveHours.Value = 4
            End If
            If nbrArchiveHours.Value > 96 Then
                nbrArchiveHours.Value = 96
            End If
            My.Settings("BackupIntervalHours") = CInt(nbrArchiveHours.Value)
            My.Settings("LastArchiveEndTime") = Now
            My.Settings.Save()
            SB2.Text = nbrArchiveHours.Value.ToString + " hours from now, an archive will execute and every " + nbrArchiveHours.Value.ToString + " thereafter."
            'TimerQuickArchive.Enabled = True
        End If
        My.Settings.Save()
    End Sub

    Private Sub TimerQuickArchive_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerQuickArchive.Tick
        If ckDisable.Checked Then
            Return
        End If
        If gContactsArchiving = True Or gContentArchiving = True Or gOutlookArchiving = True Or gExchangeArchiving = True Then
            '** An archive is already running
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        tsLastArchive.Text = My.Settings("LastArchiveEndTime").ToString

        Dim IntervalHours As Integer = 0
        Dim iElapsedHours As Decimal = 0
        Try
            IntervalHours = My.Settings("BackupIntervalHours")
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            IntervalHours = 0
        End Try
        If IntervalHours > 0 Then
            CalcNextArchiveTime()
        End If

    End Sub

    Public Function ElapsedHours(ByVal tStart As Date) As Decimal
        Dim elapsed_time As TimeSpan
        elapsed_time = Now.Subtract(tStart)
        Return elapsed_time.TotalHours
    End Function

    Private Sub btnArchiveNow_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnArchiveNow.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        TimerQuickArchive_Tick(Nothing, Nothing)
    End Sub

    ''' <summary> This will create a Application Reference file on the users desktop if they do not
    ''' already have one when the program is loaded.
    ' If not debugging in visual studio check for Application Reference #if (!debug)
    ' CheckForShortcut(); #endif
    ''' </summary
    Private Sub CheckForShortcut()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ad As ApplicationDeployment = ApplicationDeployment.CurrentDeployment
        'If ad.IsFirstRun Then
        Dim code As Assembly = Assembly.GetExecutingAssembly()
        Dim company As String = String.Empty
        Dim description As String = String.Empty
        If Attribute.IsDefined(code, GetType(AssemblyCompanyAttribute)) Then
            Dim ascompany As AssemblyCompanyAttribute = DirectCast(Attribute.GetCustomAttribute(code, GetType(AssemblyCompanyAttribute)), AssemblyCompanyAttribute)
            company = ascompany.Company
        End If
        If Attribute.IsDefined(code, GetType(AssemblyDescriptionAttribute)) Then
            Dim asdescription As AssemblyDescriptionAttribute = DirectCast(Attribute.GetCustomAttribute(code, GetType(AssemblyDescriptionAttribute)), AssemblyDescriptionAttribute)
            description = asdescription.Description
        End If
        If company <> String.Empty AndAlso description <> String.Empty Then
            Dim desktopPath As String = String.Empty
            desktopPath = String.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "\", description, ".appref-ms")
            Dim shortcutName As String = String.Empty
            shortcutName = String.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs), "\", company, "\", description, ".appref-ms")
            System.IO.File.Copy(shortcutName, desktopPath, True)
        End If
        'End If

    End Sub

    Private Sub ImpersonateLoginToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ImpersonateLoginToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        frmImpersonate.ShowDialog()
    End Sub

    Private Sub AddDesktopIconToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AddDesktopIconToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        CheckForShortcut()
    End Sub

    Private Sub btnRefreshRebuild_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshRebuild.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Me.Cursor = Cursors.WaitCursor
        Dim S As String = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "
        DBARCH.LoadProfiles()

        S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "
        DBARCH.PopulateComboBox(cbProfile, "ProfileName", S)

        S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]"
        'S = "select distinct ProfileName from LoadProfileItem order by ProfileName"
        DBARCH.PopulateComboBox(Me.cbDirProfile, "ProfileName", S)
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub AllToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AllToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        gbEmail.Visible = True
        gbContentMgt.Visible = True
        gbPolling.Visible = True
        gbFiletypes.Visible = True
    End Sub

    Private Sub EmailToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmailToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        gbEmail.Visible = True
        gbContentMgt.Visible = False
        gbPolling.Visible = False
        gbFiletypes.Visible = False
    End Sub

    Private Sub ContentToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ContentToolStripMenuItem1.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        gbEmail.Visible = False
        gbContentMgt.Visible = True
        gbPolling.Visible = False
        gbFiletypes.Visible = False
    End Sub

    Private Sub ExecutionControlToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExecutionControlToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        gbEmail.Visible = False
        gbContentMgt.Visible = False
        gbPolling.Visible = True
        gbFiletypes.Visible = False
    End Sub

    Private Sub FileTypesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileTypesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        gbEmail.Visible = False
        gbContentMgt.Visible = False
        gbPolling.Visible = False
        gbFiletypes.Visible = True
    End Sub

    Private Sub EncryptStringToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EncryptStringToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        frmEncryptString.ShowDialog()
    End Sub

    Private Sub btnRefreshDefaults_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshDefaults.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = ""
        Dim B As Boolean = True

        S = "insert into AvailFileTypes (ExtCode) Values ('.act')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ada')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.adb')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ads')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ascx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.asm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.asp')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.aspx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.bat')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.bmp')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.c')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.CMD')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.cpp')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.csv')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.cxx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dct')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.def')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dic')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dll')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.doc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.docm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.docx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dot')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dotm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dotx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.exe')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.frm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.GIF')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.gz')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.h')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.hhc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.hpp')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.htm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.html')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.htw')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.htx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.hxx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ibq')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.idl')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.inc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.inf')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ini')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.inx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.java')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.JPG')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.JPX')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.js')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.log')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.m3u')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.mht')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.mp3')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.msg')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.obd')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.obj')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.obt')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.odc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pdf')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pfx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pl')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.PNG')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pot')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.potm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.potx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppam')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppsm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppsx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppt')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pptm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pptx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.rc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.reg')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.resx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.rtf')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.sln')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.sql')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.stm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.suo')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.tar')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.tif')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.TIFF')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.TRF')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.txt')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.UKN')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.url')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.vb')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.vbs')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.vbx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.VSD')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.wav')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.wma')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.wtx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.XL * ')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlam')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlb')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xls')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlsm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlsx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlt')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xltm')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xltx')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xml')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xsc')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xsd')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xslt')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xss')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.z')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.zip')"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('msg')"
        B = DBARCH.ExecuteSqlNewConn(S, False)

        MessageBox.Show("Missing default extension codes readded.")

    End Sub

    Private Sub btnDefaultAsso_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDefaultAsso.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        AP.SaveNewAssociations(".ada", ".txt")
        AP.SaveNewAssociations("adb", ".txt")
        AP.SaveNewAssociations("ads", ".txt")
        AP.SaveNewAssociations("bat", ".txt")
        AP.SaveNewAssociations("css", ".cxx")
        AP.SaveNewAssociations("csv", ".txt")
        AP.SaveNewAssociations("dct", ".txt")
        AP.SaveNewAssociations("def", ".txt")
        AP.SaveNewAssociations("frm", ".vbs")
        AP.SaveNewAssociations("java", ".js")
        AP.SaveNewAssociations("sql", ".txt")
        AP.SaveNewAssociations("url", ".txt")
        AP.SaveNewAssociations("vb", ".vbs")
        MessageBox.Show("Default associations readded.")
    End Sub

    Private Sub btnAddDefaults_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddDefaults.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Me.Cursor = Cursors.WaitCursor
        AddSourceTypeDefaults()

        Dim S As String = ""
        Dim B As Boolean = False

        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'Known graphic file types.', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'All MS Office content.', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - C#', N'Source Code - C#', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'Source Code - VB', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ZIP Files', N'Currently Processed ZIP types', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ZIP','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.RAR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.GZ','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ISO','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.TAR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ARJ','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CAB','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CHM','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CPIO','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CramFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.DEB','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.DMG','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.FAT','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.HFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.LZH','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.LZMA','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.MBR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.MSI','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.NSIS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.NTFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.RPM','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.SquashFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.UDF','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.VHD','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.WIM','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.XAR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.Z','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.one', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pdf', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.txt', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.csv', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xls', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pdf', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.html', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.htm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.docx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.doc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.Tiff', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.tif', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.gif', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.docm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.dotx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.dotm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xltx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xltm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsb', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlam', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pptx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pptm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.potx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.potm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppam', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppsx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppsm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.bmp', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.png', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.vb', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xsd', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xss', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xsc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.ico', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.rpt', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.rdlc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.resx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.sql', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xml', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.sln', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.vbx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.jpg', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "
        DBARCH.PopulateComboBox(cbProfile, "ProfileName", S)

        Me.Cursor = Cursors.Default

        MessageBox.Show("Default profiles ready.")

    End Sub

    Sub AddSourceTypeDefaults()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim S As String = Nothing
        Dim B As Boolean = False

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ZIP', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'RAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'GZ', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ISO', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'TAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ARJ', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CAB', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CHM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CPIO', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CramFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'DEB', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'DMG', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'FAT', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'HFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'LZH', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'LZMA', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'MBR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'MSI', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NSIS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NTFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'RPM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'SquashFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'UDF', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'VHD', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'WIM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'XAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Z', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DBARCH.ExecuteSqlNewConn(S, False)

        DBARCH.AddSourceTypeCode(".ZIP", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".RAR", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".GZ", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".ISO", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".TAR", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".ARJ", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".CAB", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".CHM", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".CPIO", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".CramFS", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".DEB", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".DMG", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".FAT", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".HFS", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".LZH", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".LZMA", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".MBR", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".MSI", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".NSIS", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".NTFS", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".RPM", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".SquashFS", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".UDF", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".VHD", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".WIM", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".XAR", 0, "Add by ECM: Compressed File.", 0)
        DBARCH.AddSourceTypeCode(".Z", 0, "Add by ECM: Compressed File.", 0)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N',dct', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.act', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ada', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.adb', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ads', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.application', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asax', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ascx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ashx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asmmeta', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.aspx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.BAK', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.baml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bas', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bat', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bmp', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.c', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Cache', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.chm', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cls', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.CMD', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.compiled', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.config', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cpp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.crt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cs', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.CSproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.css', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.csv', 0, N'Added by user', 1, NULL, NULL, NULL, NULL, NULL)"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cxx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dat', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.data', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.database', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.datasource', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.DBARCH', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dct', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.def', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.deploy', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dic', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dll', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.DM1', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dnn', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.doc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.docm', 0, N'Word 2007 XML Macro-Enabled Document', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.docx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dot', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dotm', 0, N'Word 2007 XML Macro-Enabled Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dotx', 0, N'Word 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtsConfig', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.emz', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe_SyncToyBackup_20090311100439812', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe_SyncToyBackup_20090406194350947', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.frm', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.gif', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.grxml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.gz', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.h', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hhc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hlp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hpp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.html', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htw', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hxx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ibq', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ico', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.idl', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ini', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.jar', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.java', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.jpg', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.js', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.kmz', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ldb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ldf', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.lng', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.lnk', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.log', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.m3u', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.manifest', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.master', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mdb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mdf', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.MDI', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mht', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mp3', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mrc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.msg', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.msi', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.myapp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obd', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obj', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.odc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.one', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.opml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.org', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.p7b', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pcap', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pdb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pdf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pfx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.php', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pl', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.png', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pot', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.potm', 0, N'PowerPoint 2007 Macro-Enabled XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.potx', 0, N'PowerPoint 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppam', 0, N'PowerPoint 2007 Macro-Enabled XML Add-In', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppsm', 0, N'PowerPoint 2007 Macro-Enabled XML Show', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppsx', 0, N'PowerPoint 2007 XML Show', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pptm', 0, N'PowerPoint 2007 Macro-Enabled XML Presentation', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pptx', 0, N'PowerPoint 2007 XML Presentation', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.psd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pub', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rar', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rdl', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rdlc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rds', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.reg', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.resources', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.resx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rpt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rptproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rtf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.scc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.settings', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.shs', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sitemap', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.skin', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sln', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sql', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.SqlDataProvider', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sqlsuo', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, NULL, NULL, NULL, NULL)"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sqm', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.stm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.subproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.suo', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tar', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.template', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Text', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.thmx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tif', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Tiff', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tmp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.TRF', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.txt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.UD', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.url', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.user', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vb', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbs', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbx', 0, N'AUTO Defined by System', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vsd', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vspscc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vstemplate', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.WAV', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.webproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wma', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wmv', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wri', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wtx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xaml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlam', 0, N'Excel 2007 XML Macro-Enabled Add-In', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlb', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlk', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xls', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsb', 0, N'Excel 2007 binary workbook (BIFF12)', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsm', 0, N'Excel 2007 XML Macro-Enabled Workbook', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xltm', 0, N'Excel 2007 XML Macro-Enabled Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xltx', 0, N'Excel 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xml', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsl', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xslt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xss', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.z', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.zip', 0, N'Word Splitter', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Added by user', 0, N'.dct', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'docm', 0, N'Word 2007 XML Macro-Enabled Document', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'docx', 0, N'Word 2007 XML Document', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'dotm', 0, N'Word 2007 XML Macro-Enabled Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'dotx', 0, N'Word 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NO SEARCH - AUTO ADDED by Pgm', 0, N'.application', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'potm', 0, N'PowerPoint 2007 Macro-Enabled XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'potx', 0, N'PowerPoint 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppam', 0, N'PowerPoint 2007 Macro-Enabled XML Add-In', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppsm', 0, N'PowerPoint 2007 Macro-Enabled XML Show', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppsx', 0, N'PowerPoint 2007 XML Show', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'pptm', 0, N'PowerPoint 2007 Macro-Enabled XML Presentation', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'pptx', 0, N'PowerPoint 2007 XML Presentation', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlam', 0, N'Excel 2007 XML Macro-Enabled Add-In', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsb', 0, N'Excel 2007 binary workbook (BIFF12)', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsm', 0, N'Excel 2007 XML Macro-Enabled Workbook', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsx', 0, N'Excel 2007 XML Workbook', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xltm', 0, N'Excel 2007 XML Macro-Enabled Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xltx', 0, N'Excel 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'XXXX', 0, N'AUTO Definition - not found', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DBARCH.ExecuteSqlNewConn(S, False)

    End Sub

    Private Sub FileHashToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileHashToolStripMenuItem.Click
        OpenFileDialog1.ShowDialog()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim Ticks As Int64 = 0
        Dim TotalTicks As Integer = 0

        Ticks = Now.Ticks
        Dim FQN As String = OpenFileDialog1.FileName
        Dim CRC32HASH As String = ""
        Dim ImageHash As String = ""
        Dim MD5HASH As String = ""
        Dim SHA1HASH As String = ""
        Dim SHA1QUICK As String = ""

        Ticks = Now.Ticks
        CRC32HASH = ENC.GenerateSHA512HashFromFile(FQN)
        ImageHash = ENC.GenerateSHA512HashFromFile(FQN)
        TotalTicks = Now.Ticks - Ticks
        CRC32HASH += " - Time: " + TotalTicks.ToString

        Ticks = Now.Ticks
        MD5HASH = ENC.hashMd5File(FQN)
        TotalTicks = Now.Ticks - Ticks
        MD5HASH += " - Time: " + TotalTicks.ToString

        Ticks = Now.Ticks
        SHA1HASH = ENC.hashSha1File(FQN)
        TotalTicks = Now.Ticks - Ticks
        SHA1HASH += " - Time: " + TotalTicks.ToString

        Ticks = Now.Ticks
        SHA1QUICK = ENC.hashSha1File(FQN)
        TotalTicks = Now.Ticks - Ticks
        SHA1QUICK += " - Time: " + TotalTicks.ToString

        Dim sMsg As String = ""

        sMsg += "CRC32     : " + CRC32HASH + vbCrLf
        sMsg += "MD5       : " + MD5HASH + vbCrLf
        sMsg += "SHA1      : " + SHA1HASH + vbCrLf
        sMsg += "SHA1 Quick: " + SHA1QUICK + vbCrLf

        MessageBox.Show(sMsg)
    End Sub

    Protected Overloads Overrides Sub Finalize()
        MyBase.Finalize()

    End Sub 'Finalize

    Private Sub BackgroundWorker1_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorker1.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Thread.BeginCriticalRegion()
        Try

            ThreadUpdateNotice("PROCESSING EMAIL")

            If ckDisableOutlookEmailArchive.Checked Then
                Thread.EndCriticalRegion()
                Return
            End If

            gAutoExecEmailComplete = False
            Dim isPublic As String = "N"
            Dim RetentionCode As String = "Retain 10"

            If ckTerminate.Checked Then
                If Not gRunUnattended Then
                    MessageBox.Show("The TERMINATE immediately box is checked, returning.")
                    gAutoExecEmailComplete = True
                    Thread.EndCriticalRegion()
                    Return
                Else
                    LOG.WriteToArchiveLog("BackgroundWorker1_DoWork: The TERMINATE immediately box is checked, returning.")
                End If
            End If
            If ckDisable.Checked Then
                SB.Text = "DISABLE ALL is checked - no archive allowed."
                ArchiveALLToolStripMenuItem.Enabled = True
                ContentToolStripMenuItem.Enabled = True
                ExchangeEmailsToolStripMenuItem.Enabled = True
                OutlookEmailsToolStripMenuItem.Enabled = True
                gAutoExecEmailComplete = True
                Thread.EndCriticalRegion()
                Return
            End If

            DBARCH.CleanUpEmailFolders()

            gEmailsBackedUp = 0
            gEmailsAdded = 0

            EmailsBackedUp = 0
            EmailsSkipped = 0
            FilesBackedUp = 0
            FilesSkipped = 0

            '***************************************************
            SetUnattendedFlag()
            '*******************************************************************
            Dim bUseQuickSearch As Boolean = False
            Dim NbrOfIds As Integer = DBARCH.getCountStoreIdByFolder()
            Dim slStoreId As New SortedList

            If NbrOfIds <= 5000000 Then
                bUseQuickSearch = True
            End If

            If bUseQuickSearch Then
                '** 002
                DBLocal.getCE_EmailIdentifiers(slStoreId)
            Else
                slStoreId.Clear()
            End If

            '*******************************************************************
            ARCH.ArchiveEmailFolders(UIDcurr)
            '*******************************************************************

            If gTerminateImmediately Then
                'Me.Cursor = Cursors.Default
                'SB.Text = "Terminated archive!"
                'ArchiveALLToolStripMenuItem.Enabled = True
                'ContentToolStripMenuItem.Enabled = True
                'ExchangeEmailsToolStripMenuItem.Enabled = True
                'OutlookEmailsToolStripMenuItem.Enabled = True
                'PictureBox1.Visible = False

                'SB.Text = "AUTO Archive exit"
                'SB2.Text = "AUTO Archive exit"
                gAutoExecEmailComplete = True
                Thread.EndCriticalRegion()
                Return
            End If
            resetBadDates()
            '***************************************************

            ALR.ProcessAllRefEmails(False)
            'Me.Cursor = System.Windows.Forms.Cursors.Default
            DBARCH.UpdateAttachmentCounts()
            'Me.Cursor = System.Windows.Forms.Cursors.Default
            'SB.Text = "Completed Email archive."
            If gEmailsAdded = 0 Then
                gEmailsAdded = 1
            End If

            If gTerminateImmediately Then
                gAutoExecEmailComplete = True
                Thread.EndCriticalRegion()
                Return
            End If

            Dim StackLevel As Integer = 0
            Dim ListOfFiles As New Dictionary(Of String, Integer)

            For i As Integer = 0 To ZipFilesEmail.Count - 1
                'bExplodeZipFile = False
                Dim cData As String = ZipFilesEmail(i).ToString
                Dim ParentGuid As String = ""
                Dim FQN As String = ""
                Dim K As Integer = InStr(cData, "|")
                FQN = Mid(cData, 1, K - 1)
                ParentGuid = Mid(cData, K + 1)
                'DBARCH.UpdateZipFileIndicator(ParentGuid, True)
                ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, True, RetentionCode, isPublic, StackLevel, ListOfFiles)
            Next

            ListOfFiles = Nothing

            gAutoExecEmailComplete = True
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 1000 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 3012x" + ex.Message)
        End Try

        Thread.EndCriticalRegion()
        GC.Collect()

        gAutoExecEmailComplete = True

    End Sub

    Private Sub BackgroundWorker2_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorker2.DoWork

        If ckDisableExchange.Checked Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Thread.BeginCriticalRegion()

        gAutoExecExchangeComplete = False

        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        If ckTerminate.Checked Then
            Thread.EndCriticalRegion()
            MessageBox.Show("The TERMINATE immediately box is checked, returning.")
            Return
        End If

        EmailsBackedUp = 0
        EmailsSkipped = 0
        FilesBackedUp = 0
        FilesSkipped = 0

        'SB.Text = "Launching Exchange Archive - it will run in background."
        If gCurrentArchiveGuid.Length = 0 Then
            gCurrentArchiveGuid = Guid.NewGuid.ToString
        End If

        '****************************************************************************
        SetUnattendedFlag()
        'frmExchangeMonitor.Show()

        GetExchangeFolders(False)
        '****************************************************************************

        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        For i As Integer = 0 To ZipFilesExchange.Count - 1
            Dim cData As String = ZipFilesExchange(i).ToString
            Dim ParentGuid As String = ""
            Dim FQN As String = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid = Mid(cData, K + 1)
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, True, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next
        For i As Integer = 0 To ZipFilesEmail.Count - 1
            Dim cData As String = ZipFilesExchange(i).ToString
            Dim ParentGuid As String = ""
            Dim FQN As String = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid = Mid(cData, K + 1)
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, True, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next

        Thread.EndCriticalRegion()
        ListOfFiles = Nothing
        GC.Collect()
        gAutoExecExchangeComplete = True

    End Sub

    Private Sub PerformContentArchive()

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim bopen As Boolean = ckFormOpen("frmMain")
        If Not bopen Then
            Me.Show()
        End If
        bopen = ckFormOpen("frmNotify")
        If Not bopen Then
            frmNotify.Show()
            frmNotify.TopMost = True
            frmNotify.Location = New Point(Screen.PrimaryScreen.WorkingArea.Width - Me.Width, Screen.PrimaryScreen.WorkingArea.Height - Me.Height)

        End If

        If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
            frmNotify.Text = "Processing Listener"
            frmNotify.Refresh()
        Else
            frmNotify.Text = "Processing CONTENT"
            frmNotify.Refresh()
        End If

        Try
            If ckDisableContentArchive.Checked Then
                Return
            End If

            'Thread.BeginCriticalRegion()

            gAutoExecContentComplete = False
            Dim isPublic As String = "N"

            If ckTerminate.Checked Then
                'Thread.EndCriticalRegion()
                MessageBox.Show("The TERMINATE immediately box is checked, returning.")
                gAutoExecContentComplete = True
                Return
            End If

            If ckDisable.Checked Then
                'Thread.EndCriticalRegion()
                SB.Text = "DISABLE ALL is checked - no archive allowed."
                gAutoExecContentComplete = True
                Return
            End If

            ckTerminate.Checked = False

            If gTraceFunctionCalls.Equals(1) Then
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
            End If

            EmailsBackedUp = 0
            EmailsSkipped = 0
            FilesBackedUp = 0
            FilesSkipped = 0

            'SB.Text = "Starting Content archive."

            LOG.WriteToArchiveLog("Content Archive stared @ " + Now.ToString)
            MsgNotification = False

            If gCurrentArchiveGuid.Length = 0 Then
                gCurrentArchiveGuid = Guid.NewGuid.ToString
            End If

            '*** Here is the primary Module for archive.
            If ddebug Then LOG.WriteToArchiveLog("frmMain : btnArchiveContent :7001 : starting archive.")

            If ddebug Then LOG.WriteToArchiveLog("Starting Archive of Content ********************************")

            '***************** ARCHIVE CONTENT **********************'
            SetUnattendedFlag()
            'FrmMDIMain.lblArchiveStatus.Text = "Archive Running"

            Dim StartTime As DateTime = Now

            gCurrUserGuidID = UIDcurr
            Try
                '************************************** ArchiveContent ****************************************************************
                frmNotify.TopMost = False
                ArchiveContent(Environment.MachineName, UIDcurr)
                '**********************************************************************************************************************
                LOG.WriteToUploadLog("------------------------------------------------------------")
                LOG.WriteToUploadLog("PerformContentArchive: ArchiveContent: Start" + StartTime.ToString)
                LOG.WriteToUploadLog("PerformContentArchive: ArchiveContent: END" + Now.ToString)
            Catch ex As Exception
                LOG.WriteToArchiveLog("PerformContentArchive/ArchiveContent 01: " + ex.Message)
                LOG.WriteToArchiveLog("PerformContentArchive/ArchiveContent 02: " + ex.StackTrace.ToString)
            End Try

            '********************************************************'
            If ddebug Then LOG.WriteToArchiveLog("frmMain : btnArchiveContent :7002 : starting archive.")

            StartTime = Now
            ARCH.ArchiveQuickRefItems(UIDcurr, MachineIDcurr, ckArchiveBit.Checked, False, False, False, False, SB, "", "", "", ZipFilesQuick)
            LOG.WriteToUploadLog("------------------------------------------------------------")
            LOG.WriteToUploadLog("PerformContentArchive: ArchiveQuickRefItems: Start" + StartTime.ToString)
            LOG.WriteToUploadLog("PerformContentArchive: ArchiveQuickRefItems: END" + Now.ToString)

            Dim RetentionCode As String = "Retain 10"

            Dim StackLevel As Integer = 0
            Dim ListOfFiles As New Dictionary(Of String, Integer)

            StartTime = Now
            For i As Integer = 0 To ZipFilesQuick.Count - 1
                Dim cData As String = ZipFilesQuick(i).ToString
                Dim ParentGuid As String = ""
                Dim FQN As String = ""
                Dim K As Integer = InStr(cData, "|")
                FQN = Mid(cData, 1, K - 1)
                ParentGuid = Mid(cData, K + 1)
                'DBARCH.UpdateZipFileIndicator(ParentGuid, True)
                LOG.WriteToUploadLog("PerformContentArchive 0A: File: " + Now.ToString + FQN)
                ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
            Next

            LOG.WriteToUploadLog("------------------------------------------------------------")
            LOG.WriteToUploadLog("PerformContentArchive: ZipFilesQuick: Start" + StartTime.ToString)
            LOG.WriteToUploadLog("PerformContentArchive: ZipFilesQuick: END" + Now.ToString)

            ListOfFiles = Nothing
            GC.Collect()

            StartTime = Now
            ALR.ProcessAllRefDirs(False)
            LOG.WriteToUploadLog("------------------------------------------------------------")
            LOG.WriteToUploadLog("PerformContentArchive: ProcessAllRefDirs: Start" + StartTime.ToString)
            LOG.WriteToUploadLog("PerformContentArchive: ProcessAllRefDirs: END" + Now.ToString)

            Dim Msg As String = "Files Backed Up: " + FilesBackedUp.ToString + "  /  Files Updated: " + FilesSkipped.ToString

            LOG.WriteToArchiveLog("Content Archive completed @ " + Now.ToString + " : " + Msg)
            gAutoExecContentComplete = True
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 1000 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 421z: " + ex.Message)
        End Try

        'Thread.EndCriticalRegion()
        gAutoExecContentComplete = True

        If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
            bUpdated = DBLocal.removeListenerfileProcessed()
            If Not bUpdated Then
                LOG.WriteToArchiveLog("ERROR 02 failed removeListenerfileProcessed...")
            End If
        End If

        frmNotify.Hide()
        gAutoExecContentComplete = True

    End Sub

    Private Sub FileUploadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileUploadToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim DirName As String = "NA"

        Dim RetentionCode As String = "Retain 10"
        Dim isPublic As String = "N"

        OpenFileDialog1.ShowDialog()
        Dim FQN As String = OpenFileDialog1.FileName
        Dim FI As New FileInfo(FQN)
        Dim OriginalFileName As String = FI.Name
        FI = Nothing
        Dim FileGuid As String = Guid.NewGuid.ToString
        Dim RepositoryTable As String = "DataSource"
        Dim SourceHash As String = ENC.GenerateSHA512HashFromFile(FQN)
        Dim AttachmentCode As String = "C"
        DBARCH.InsertSourceImage(gCurrUserGuidID, Environment.MachineName, OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic, SourceHash, DirName, False)

    End Sub

    Private Sub FileUploadBufferedToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileUploadBufferedToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        OpenFileDialog1.ShowDialog()
        Dim FQN As String = OpenFileDialog1.FileName
        Dim FI As New FileInfo(FQN)
        Dim OriginalFileName As String = FI.Name
        FI = Nothing
        Dim FileGuid As String = Guid.NewGuid.ToString
        Dim RepositoryTable As String = "DataSource"

        Dim FileBuffer() As Byte = Nothing

        Dim oFile As System.IO.FileInfo
        oFile = New System.IO.FileInfo(FQN)

        Dim oFileStream As System.IO.FileStream = oFile.OpenRead()
        Dim lBytes As Long = oFileStream.Length

        If (lBytes > 0) Then
            ReDim FileBuffer(lBytes - 1)
            oFileStream.Read(FileBuffer, 0, lBytes)
            oFileStream.Close()
        End If
        Dim CrcHASH As String = ENC.GenerateSHA512HashFromFile(FQN)
        DBARCH.InsertBufferedSource(4, FileBuffer, OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic, CrcHASH, "NA")

    End Sub

    Private Sub FileChunkUploadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileChunkUploadToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        OpenFileDialog1.ShowDialog()
        Dim FQN As String = OpenFileDialog1.FileName
        Dim FI As New FileInfo(FQN)
        Dim OriginalFileName As String = FI.Name
        FI = Nothing
        Dim FileGuid As String = Guid.NewGuid.ToString
        Dim CrcHASH As String = ENC.GenerateSHA512HashFromFile(FQN)
        DBARCH.ChunkFileUpload(OriginalFileName, FileGuid, FQN, "DataSource", CrcHASH)
    End Sub

    Private Sub BackgroundDirListener_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundDirListener.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Thread.BeginCriticalRegion()

        Dim RetentionCode As String = "Retain 10"
        Dim isPublic As String = "N"

        Dim bFilesToBeArchived As Boolean = DBLocal.ActiveListenerFiles
        'If Not bFilesToBeArchived Then
        '    Return
        'End If

        Dim bDoNotRun As Boolean = False

        Dim frm As Form
        Try
            For Each frm In My.Application.OpenForms
                Application.DoEvents()
                If frm Is My.Forms.frmNotify Then
                    bDoNotRun = True
                End If
                If frm Is My.Forms.frmNotify2 Then
                    bDoNotRun = True
                End If
                If frm Is My.Forms.frmExchangeMonitor Then
                    bDoNotRun = True
                End If
                If frm Is My.Forms.frmNotifyListener Then
                    bDoNotRun = True
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            Console.WriteLine("Collection processed.")
        End Try

        frm = Nothing
        If bDoNotRun = True Then
            Thread.EndCriticalRegion()
            Return
        End If

        Try
            Dim L As New SortedList(Of String, Integer)
            'L = gFilesToArchive
            DBLocal.getListenerFiles(L)
            For Each sKey As String In L.Keys
                If Not File.Exists(sKey) Then
                    DBLocal.removeListenerFile(sKey)
                    If gFilesToArchive.ContainsKey(sKey) Then
                        gFilesToArchive.Remove(sKey)
                    End If
                End If

                Dim FI As New FileInfo(sKey)
                Dim fName As String = FI.Name
                FI = Nothing

                If Mid(fName, 1, 1).Equals("~") Then
                    Console.WriteLine("Skipping: " + sKey)
                    DBLocal.removeListenerFile(sKey)
                    If gFilesToArchive.ContainsKey(sKey) Then
                        gFilesToArchive.Remove(sKey)
                    End If
                End If
                If gFilesToArchive.ContainsKey(sKey) Then
                    gFilesToArchive.Remove(sKey)
                End If
            Next

            DBLocal.getListenerFiles(L)

            If L.Count = 0 And Not bFilesToBeArchived Then
                Thread.EndCriticalRegion()
                Return
            Else
                ProcessListenerFiles(False)
            End If
            L = Nothing

            Dim StackLevel As Integer = 0
            Dim ListOfFiles As New Dictionary(Of String, Integer)
            For i As Integer = 0 To ZipFilesListener.Count - 1
                Dim cData As String = ZipFilesListener(i).ToString
                Dim ParentGuid As String = ""
                Dim FQN As String = ""
                Dim K As Integer = InStr(cData, "|")
                FQN = Mid(cData, 1, K - 1)
                ParentGuid = Mid(cData, K + 1)
                ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
            Next

            ListOfFiles = Nothing
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 1000 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR 2012X - resetting.")
        End Try

        Thread.EndCriticalRegion()
        GC.Collect()
    End Sub

    'Private Sub btnActivate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnActivate.Click

    ' CompanyID = txtCompany.Text RepoID = cbRepo.Text Dim bReg As Boolean = False

    ' If CompanyID.Length > 0 And RepoID.Length > 0 Then If (ProxyGateway Is Nothing) Then
    ' ProxyGateway = New SVCGateway.Service1Client 'If (SVCGateway_Endpoint.Length > 0) Then '
    ' ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(SVCGateway_Endpoint)
    ' 'End If End If

    ' Dim EncCS As String = "" Dim RC As Boolean = False Dim RetMsg As String = "" EncCS =
    ' ProxyGateway.getConnection(CompanyID, RepoID, RC, RetMsg) If EncCS.Trim.Length > 0 Then
    ' 'gCurrentConnectionString = ENC.AES256DecryptString(EncCS) gCurrentConnectionString = EncCS If
    ' gCurrentConnectionString.Length > 0 Then bReg =
    ' REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS) If Not bReg Then bReg =
    ' REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS) End If End If Try
    ' gCurrentConnectionString = ENC.AES256DecryptString(EncCS) Catch ex As Exception
    ' MessageBox.Show("ERROR 121.32.1 : Failed to set new connection.") Return End Try Else
    ' gCurrentConnectionString = "" End If

    ' 'ProxyGateway = Nothing bUseAttachData = True tsCurrentRepoID.Text = RepoID
    ' tsCurrentRepoID.Text = "Repo: " + RepoID

    ' If CompanyID.Length > 0 Then bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID) If Not
    ' bReg Then bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID) End If

    '        End If
    '        If RepoID.Length > 0 Then
    '            bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID)
    '            If Not bReg Then
    '                bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID)
    '            End If
    '        End If
    '    Else
    '        tsCurrentRepoID.Text = "Repo: ??"
    '        bUseAttachData = False
    '    End If
    'End Sub

    Private Sub GetQueryStringParameters() 'As NameValueCollection
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim NameValueTable As New NameValueCollection()
        Try
            If (ApplicationDeployment.IsNetworkDeployed) Then
                Dim QueryString As String = ApplicationDeployment.CurrentDeployment.ActivationUri.Query
                NameValueTable = System.Web.HttpUtility.ParseQueryString(QueryString)
            End If

            For Each Arg As String In NameValueTable
                If InStr(Arg, ";") Then
                    Dim AA() As String = Arg.Split(";")
                    CompanyID = AA(0)
                    RepoID = AA(1)
                    Dim sCompanyID As String = REG.ReadEcmRegistrySubKey("CompanyID")
                    Dim sRepoID As String = REG.ReadEcmRegistrySubKey("RepoID")
                    Dim RepoCS As String = REG.ReadEcmRegistrySubKey("RepoCS")
                    Dim bReg As Boolean = False
                    If sCompanyID.Length = 0 Then
                        bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID)
                        If Not bReg Then
                            bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID)
                        End If
                    End If
                    If sRepoID.Length = 0 Then
                        bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID)
                        If Not bReg Then
                            bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID)
                        End If
                    End If
                    If RepoCS.Length = 0 Then
                        bReg = REG.CreateEcmRegistrySubKey("RepoCS", RepoCS)
                        If Not bReg Then
                            bReg = REG.UpdateEcmRegistrySubKey("RepoCS", RepoCS)
                        End If
                    End If
                End If
            Next
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR GetQueryStringParameters 100 - " + ex.Message)
            LOG.WriteToParmLog("ERROR GetQueryStringParameters 100 - " + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        Finally
            LOG.WriteToParmLog("Step 40")
            NameValueTable = Nothing
        End Try
        LOG.WriteToParmLog("Step 45")
    End Sub

    Private Sub ExitToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Application.Exit()
    End Sub

    Private Sub ExitToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem1.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Application.Exit()
    End Sub

    Private Sub InstallCLCToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub InstallCLCToolStripMenuItem_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    'tsTimeToArchive
    'tsCountDown

    Private Sub CalcNextArchiveTime()

        Dim LastArchiveDate As Date = Nothing
        Try
            LastArchiveDate = My.Settings("LastArchiveEndTime")
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LastArchiveDate = Now
        End Try

        Dim BackupInterval As Integer = CInt(My.Settings("BackupIntervalHours"))
        If BackupInterval = 0 Then
            tsTimeToArchive.Text = "Inactive"
            Return
        End If

        Dim NextArchvieTime As Date = LastArchiveDate.AddHours(BackupInterval)
        tsTimeToArchive.Text = NextArchvieTime.ToString

        If NextArchvieTime < Now Then
            My.Settings("LastArchiveEndTime") = Now
            My.Settings.Save()
            ArchiveALLToolStripMenuItem_Click(Nothing, Nothing)
        Else

            Dim remainingTime As TimeSpan = NextArchvieTime.Subtract(Now)

            tsCountDown.Text = String.Format("{0}:{1:d2}:{2:d2}",
                                               remainingTime.Hours,
                                               remainingTime.Minutes,
                                               remainingTime.Seconds)
        End If
    End Sub

    Private Sub btnCountFiles_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCountFiles.Click

        Dim I As Integer = lbArchiveDirs.SelectedItems.Count
        If I = 0 Then
            SB.Text = "You must select an item from the listbox..."
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If I <> 1 Then
            CkMonitor.Visible = False
        Else
            CkMonitor.Visible = True
        End If

        Me.Cursor = Cursors.WaitCursor

        bActiveChange = True
        Dim DirName As String = lbArchiveDirs.SelectedItem.ToString.Trim

        btnCountFiles.Enabled = False

        If ckSubDirs.Checked Then
            Dim iCnt As Integer = UTIL.GetFileCountSubdir(DirName)
            SB.Text = DirName + " (Subdirs Included) filecount = " + iCnt.ToString
        Else
            Dim iCnt As Integer = UTIL.GetFileCountDir(DirName)
            SB.Text = DirName + " (No Subdirs) filecount = " + iCnt.ToString
        End If

        btnCountFiles.Enabled = True
        Me.Cursor = Cursors.Default

    End Sub

    Private Sub AppConfigVersionToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AppConfigVersionToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim S As String = System.Configuration.ConfigurationManager.AppSettings("AppConfigVerNo")
        MessageBox.Show("App Confing Version: " + S)
    End Sub

    Private Sub ckDeleteAfterArchive_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDeleteAfterArchive.CheckedChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        'If ckDeleteAfterArchive.Checked Then
        '    Dim Msg As String = "This will DELETE all files that are successfully archived" + vbCrLf
        '    MessageBox.Show(Msg)
        'End If
    End Sub

    Private Sub BackgroundWorkerContacts_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorkerContacts.DoWork
        'frmNotify.Label1.Text = "Contacts: "
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ARCH.ArchiveContacts()
    End Sub

    Private Sub ToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem1.Click
        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If ckDisableOutlookEmailArchive.Checked Then
            SB.Text = "Contacts disabled - no archive allowed."
            Return
        End If

        If BackgroundWorkerContacts.IsBusy Then
            Return
        End If

        Try
            BackgroundWorkerContacts.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    'Sub ReOcrPendingGraphics()

    ' If Not SkipPermission Then Dim msg As String = "This process can be time consuming, are you
    ' sure?" Dim dlgRes As DialogResult = MessageBox.Show(msg, "Re-OCR Pending",
    ' MessageBoxButtons.YesNo) If dlgRes = Windows.Forms.DialogResult.No Then Return End If End If

    ' Dim tgtSourceGuid As String = "" Dim RetMsg As String = ""

    ' Dim ListOfGuids As New System.Collections.Generic.Dictionary(Of String, Integer)

    ' 'If (SVCCLCArchive_Endpoint.Length > 0) Then ' ProxyArchive.Endpoint.Address = New
    ' System.ServiceModel.EndpointAddress(SVCCLCArchive_Endpoint) 'End If

    ' 'WDM CHECK THIS getGuidsOfPendingGraphicFiles(gGateWayID, 995, ListOfGuids)

    ' frmNotifyBatchOCR.Show() Dim iTot As Integer = ListOfGuids.Keys.Count Dim I As Integer = 0 For
    ' Each S As String In ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text =
    ' "OCR " + I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
    ' frmNotifyBatchOCR.Refresh() Application.DoEvents() 'WDM CHECK THIS ProcessSourceOCR(gGateWayID,
    ' 996, tgtSourceGuid, RetMsg) Next

    ' 'WDM CHECK THIS getGuidsOfAllEmailGraphicFiles(gGateWayID, 997, False, ListOfGuids)

    ' Dim RC As Boolean = False iTot = ListOfGuids.Keys.Count I = 0 For Each S As String In
    ' ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text = "EMAIL OCR " +
    ' I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
    ' frmNotifyBatchOCR.Refresh() Application.DoEvents() 'WDM CHECK THIS
    ' ProcessEmailAttachmentOCR(gGateWayID, 998, tgtSourceGuid, RC, RetMsg) If Not RC Then
    ' Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid) End If Next

    '    frmNotifyBatchOCR.Close()
    '    MessageBox.Show("Complete: " + RetMsg)
    'End Sub

    'Sub ReOcrAllGraphics()
    '    Dim msg As String = "This process can be very time consuming, are you sure?"
    '    Dim dlgRes As DialogResult = MessageBox.Show(msg, "Re-OCR ALL", MessageBoxButtons.YesNo)
    '    If dlgRes = Windows.Forms.DialogResult.No Then
    '        Return
    '    End If
    '    Dim tgtSourceGuid As String = ""
    '    Dim RetMsg As String = ""

    ' Dim ListOfGuids As New System.Collections.Generic.Dictionary(Of String, Integer)

    ' 'If (SVCCLCArchive_Endpoint.Length > 0) Then ' Endpoint.Address = New
    ' System.ServiceModel.EndpointAddress(SVCCLCArchive_Endpoint) 'End If

    ' getGuidsOfAllGraphicFiles(gGateWayID, 999, ListOfGuids)

    ' frmNotifyBatchOCR.Show() Dim iTot As Integer = ListOfGuids.Keys.Count Dim I As Integer = 0 For
    ' Each S As String In ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text =
    ' "OCR " + I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
    ' frmNotifyBatchOCR.Refresh() Application.DoEvents() 'WDM CHECK THIS ProcessSourceOCR(gGateWayID,
    ' 99, tgtSourceGuid, RetMsg) Next

    ' 'WDM CHECK THIS getGuidsOfAllEmailGraphicFiles(gGateWayID, 999, True, ListOfGuids)

    ' Dim RC As Boolean = False iTot = ListOfGuids.Keys.Count I = 0 For Each S As String In
    ' ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text = "EMAIL OCR " +
    ' I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
    ' frmNotifyBatchOCR.Refresh() Application.DoEvents()

    '        'WDM CHECK THIS
    '        ProcessEmailAttachmentOCR(gGateWayID, 999, tgtSourceGuid, RC, RetMsg)
    '        If Not RC Then
    '            Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid)
    '        End If
    '    Next
    '    frmNotifyBatchOCR.Close()
    '    MessageBox.Show("Complete: " + RetMsg)
    'End Sub

    'Private Sub asyncBatchOcrALL_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrALL.DoWork
    '    ReOcrAllGraphics()
    'End Sub

    'Private Sub asyncBatchOcrPending_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrPending.DoWork
    '    ReOcrPendingGraphics()
    'End Sub

    Private Sub ReOcrIncompleteGraphicFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ReOcrIncompleteGraphicFilesToolStripMenuItem.Click
        If asyncBatchOcrPending.IsBusy Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            asyncBatchOcrPending.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    Private Sub ReOcrALLGraphicFilesToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ReOcrALLGraphicFilesToolStripMenuItem1.Click
        If asyncBatchOcrALL.IsBusy Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Try
            asyncBatchOcrALL.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    Private Sub EstimateNumberOfFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EstimateNumberOfFilesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim Msg As String = ""
        Dim iCnt As Integer = 0

        Dim S As String = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf

        iCnt = DBARCH.iCount(S)
        Msg += "Total EMAIL Graphics: " + iCnt.ToString + vbCrLf

        S = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        S += "and (OcrPending is null or OcrPending = 'Y')" + vbCrLf
        iCnt = DBARCH.iCount(S)
        Msg += "Total pending EMAIL Graphics: " + iCnt.ToString + vbCrLf + vbCrLf

        S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        iCnt = DBARCH.iCount(S)
        Msg += "Total Source Graphics: " + iCnt.ToString + vbCrLf

        S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        S += "and (OcrPending is null or OcrPending = 'Y')" + vbCrLf
        S += "and (OcrPerformed is null or OcrPerformed != 'Y')" + vbCrLf
        iCnt = DBARCH.iCount(S)
        Msg += "Total Pending Source Graphics: " + iCnt.ToString + vbCrLf

        MessageBox.Show(Msg)

    End Sub

    Private Sub CEDatabasesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub ZIPFilesArchivesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim msg As String = "This deletes the pending ZIP files to be processed, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DBLocal.zeroizeZipFiles()

        MessageBox.Show("Temporary zip files cleaned up and ready.")
    End Sub

    Private Sub ViewCEDirectoriesToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim tPath As String = System.IO.Path.GetTempPath
        tPath = tPath + "EcmLibrary\CE"
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Shell("explorer.exe " + Chr(34) + tPath + Chr(34), vbNormalFocus)
    End Sub

    Private Sub InstallCESP2ToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Process.Start("http://www.microsoft.com/downloads/en/details.aspx?FamilyID=e497988a-c93a-404c-b161-3a0b323dce24")
    End Sub

    Private Sub AllToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        CEDatabasesToolStripMenuItem_Click(Nothing, Nothing)
        ZIPFilesArchivesToolStripMenuItem_Click(Nothing, Nothing)
    End Sub

    Private Sub RSSPullToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RSSPullToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim sUrl As String = "http://pheedo.msnbc.msn.com/id/8874569/device/rss/"
        ARCH.getRssFeed(sUrl)
    End Sub

    Private Sub hlExchange_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles hlExchange.LinkClicked
        Dim B As Boolean = DBARCH.isAdmin(gCurrUserGuidID)
        If Not B Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        frmExhangeMail.Show()
    End Sub

    Private Sub LinkLabel1_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel1.LinkClicked
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        frmPstLoader.UID = UIDcurr
        frmPstLoader.ShowDialog()
    End Sub

    Private Sub asyncVerifyRetainDates_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncVerifyRetainDates.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        DBARCH.VerifyRetentionDates()
    End Sub

    Private Sub OnlineHelpToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OnlineHelpToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Process.Start("http://www.EcmLibrary.com/HelpSaaS/Archive.htm")
    End Sub

    Private Sub ckRunOnStart_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles ckRunOnStart.CheckedChanged
        If formloaded = False Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim RunAtStart As Boolean = False
        If ckRunOnStart.Checked = True Then
            RunAtStart = True
        Else
            RunAtStart = False
        End If

        Me.saveStartUpParms()
        Try
            Dim aPath As String = ""

            aPath = System.Reflection.Assembly.GetExecutingAssembly.Location

            If RunAtStart Then
                Dim oReg As RegistryKey = Registry.CurrentUser
                'Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
                Dim oKey As RegistryKey = oReg.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Run", True)

                Dim SS As String = oKey.GetValue("EcmLibrary").ToString

                oKey.CreateSubKey("EcmLibrary")
                oKey.SetValue("EcmLibrary", aPath)

                SS = oKey.GetValue("EcmLibrary").ToString

                oKey.Close()
            Else

                'Registry.CurrentUser.DeleteSubKey("Software\Microsoft\Windows\CurrentVersion\Run\EcmLibrary")

                Dim oReg As RegistryKey = Registry.CurrentUser
                Dim oKey As RegistryKey = oReg.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Run", True)
                oKey.CreateSubKey("EcmLibrary")
                oKey.SetValue("EcmLibrary", "X")

                Dim SS As String = oKey.GetValue("EcmLibrary").ToString
                oKey.DeleteSubKey("EcmLibrary")
                SS = oKey.GetValue("EcmLibrary").ToString

                oKey.Close()
            End If

            'messagebox.show("Load at startup set to " + ckRunAtStartup.Checked.ToString)

            saveStartUpParms()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("Failed to set startup parameter." + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter.", ex)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try
    End Sub

    Private Sub ResetEMAILCRCCodesToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs)

    End Sub

    Private Sub LoginToSystemToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles LoginToSystemToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        MessageBox.Show("REMOVE THIS: LoginForm1.ShowDialog 2")
        LoginForm1.ShowDialog()
    End Sub

    Private Sub ChangeUserPasswordToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles ChangeUserPasswordToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        frmPasswordChange.ShowDialog()
    End Sub

    Private Sub GetOutlookEmailIDsToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs)
        MessageBox.Show("Not currntly implemented...")
    End Sub

    ''' <summary>
    ''' Handles the FormClosing event of the frmMain control. This is the dispose functionality.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">     
    ''' The <see cref="System.Windows.Forms.FormClosingEventArgs"/> instance containing the event data.
    ''' </param>
    Private Sub frmReconMain_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        SB.Text = "STANDBY... cleaning temporary directories..."
        Me.Cursor = Cursors.WaitCursor
        UTIL.cleanTempWorkingDir()
        SB.Text = "STANDBY... Setting retention dates..."
        DBARCH.spUpdateRetention()


        Try
            SB.Text = "STANDBY... backing up SQLite database..."

            Dim AllowedExts As List(Of String) = DBARCH.getUsedExtension()
            DBLocal.resetExtension()
            DBLocal.addExtension(AllowedExts)
            DBLocal.BackUpSQLite()

            GC.Collect()
            GC.WaitForPendingFinalizers()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("ERROR Closing: " + ex.Message)
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

        Me.Cursor = Cursors.Default
        SB.Text = "Goodbye...."

        LoginForm1.Close()
        Try
            Application.Exit()
        Catch ex As Exception
            MessageBox.Show("Could not exist the application, please do a manual shutdown.")
        End Try


    End Sub

    Private Sub WebSitesToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles WebSitesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ARCH.ArchiveWebSites(gCurrUserGuidID)

    End Sub

    Private Sub WebPagesToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles WebPagesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ARCH.ArchiveSingleWebPage(gCurrUserGuidID)

    End Sub

    Private Sub ArchiveRSSPullsToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles ArchiveRSSPullsToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        'Dim ChannelItems As New List(Of rssChannelItem)
        'Dim RSS As New clsRSS
        ''ChannelItems = ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)
        'ChannelItems = RSS.ReadRssDataFromSite("http://feeds.reuters.com/reuters/businessNews", True)
        'RSS = Nothing
        'GC.Collect()
        'GC.WaitForPendingFinalizers()

        If Not asyncRssPull.IsBusy Then
            asyncRssPull.RunWorkerAsync()
        Else
            MessageBox.Show("Appears to be running a RSS archive already...")
        End If

    End Sub

    Sub GetRSS(SecureID As Integer)

        Dim RC As Boolean = True
        Dim WC As String = " where UserID =  '" + gCurrUserGuidID + "' "

        Dim RssBindingSource As New BindingSource
        RssBindingSource.DataSource = DBARCH.GET_RssPull(SecureID, WC, RC)
        dgRss.DataSource = RssBindingSource

    End Sub

    Sub GetWebPage(SecureID As Integer)

        Dim RC As Boolean = True
        Dim WC As String = " where UserID =  '" + gCurrUserGuidID + "' "
        Dim RssBindingSource As New BindingSource

        RssBindingSource.DataSource = DBARCH.GET_WebScreenForGRID(SecureID, WC, RC)
        dgWebPage.DataSource = RssBindingSource

    End Sub

    Sub GetWebSite(SecureID As Integer)

        Dim dItems As New System.Collections.Generic.List(Of DS_WebSite)
        Dim RC As Boolean = True
        Dim WC As String = " where UserID =  '" + gCurrUserGuidID + "' "

        Dim RssBindingSource As New BindingSource

        RssBindingSource = DBARCH.GET_WebSite(SecureID, WC, RC)
        dgWebSite.DataSource = RssBindingSource

    End Sub

    Private Sub btnAddRssFeed_Click(sender As System.Object, e As System.EventArgs) Handles btnAddRssFeed.Click
        Dim tName As String = txtRssName.Text
        Dim tUrl As String = txtRssURL.Text
        Dim RC As Boolean = True
        Dim RetentionCode As String = cbRssRetention.Text
        If RetentionCode.Trim.Length = 0 Then
            MessageBox.Show("Please select a reterntion code.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DBARCH.Save_RssPull(gGateWayID, tName, tUrl, gCurrUserGuidID, RetentionCode, RC)

        If RC Then
            GetRSS(gGateWayID)
        Else
            MessageBox.Show("Failed to save RSS Feed: " + tName)
        End If

    End Sub

    Private Sub btnSaveWebPage_Click(sender As System.Object, e As System.EventArgs) Handles btnSaveWebPage.Click
        Dim tName As String = txtWebScreenName.Text
        Dim tUrl As String = txtWebScreenUrl.Text
        Dim RC As Boolean = True
        Dim RetentionCode As String = cbWebPageRetention.Text
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DBARCH.Save_WebScreenURL(gGateWayID, tName, tUrl, RetentionCode, gCurrUserGuidID, RC)

        If RC Then
            GetWebPage(gGateWayID)
        Else
            MessageBox.Show("Failed to save WEB Page: " + tName)
        End If
    End Sub

    Private Sub btnSaveWebSite_Click(sender As System.Object, e As System.EventArgs) Handles btnSaveWebSite.Click
        Dim tName As String = txtWebSiteName.Text
        Dim tUrl As String = txtWebSiteURL.Text
        Dim depth As Integer = CInt(nbrDepth.Value)
        Dim width As Integer = CInt(nbrOutboundLinks.Value)
        Dim RC As Boolean = True
        Dim RetentionCode As String = cbWebSiteRetention.Text
        DBARCH.Save_WebSiteURL(gGateWayID, tName, tUrl, depth, width, RetentionCode, gCurrUserGuidID, RC)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If RC Then
            GetWebSite(gGateWayID)
        Else
            MessageBox.Show("Failed to save WEB Page: " + tName)
        End If
    End Sub

    Private Sub btnRemoveWebSite_Click(sender As System.Object, e As System.EventArgs) Handles btnRemoveWebSite.Click
        Dim I As Integer = dgWebSite.SelectedRows.Count
        If I <> 1 Then
            MessageBox.Show("One and only one row must be selected.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tName As String = txtWebSiteName.Text
        Dim tUrl As String = txtWebSiteURL.Text
        Dim depth As Integer = CInt(nbrDepth.Value)
        Dim width As Integer = CInt(nbrOutboundLinks.Value)
        Dim RC As Boolean = True

        Dim MySql As String = "delete from WebSite where WebSite = '" + tName + "' and UserID = '" + gCurrUserGuidID + "' "

        RC = DBARCH.ExecuteSqlNewConn(90325, MySql)

        If RC Then
            GetWebSite(gGateWayID)
        Else
            MessageBox.Show("Failed to delete WEB Page A8: " + tName)
        End If
    End Sub

    Private Sub btnRemoveWebPage_Click(sender As System.Object, e As System.EventArgs) Handles btnRemoveWebPage.Click

        Dim I As Integer = dgWebPage.SelectedRows.Count
        If I <> 1 Then
            MessageBox.Show("One and only one row must be selected.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tName As String = txtWebScreenName.Text
        Dim tUrl As String = txtWebScreenUrl.Text
        Dim RC As Boolean = True

        Dim MySql As String = "delete from WebScreen where WebScreen = '" + tName + "' and UserID = '" + gCurrUserGuidID + "' "

        RC = DBARCH.ExecuteSqlNewConn(90326, MySql)

        If RC Then
            GetWebPage(gGateWayID)
        Else
            MessageBox.Show("Failed to DELETE WEB Page A9: " + tName)
        End If
    End Sub

    Private Sub btnRemoveRSSfeed_Click(sender As System.Object, e As System.EventArgs) Handles btnRemoveRSSfeed.Click

        Dim I As Integer = dgRss.SelectedRows.Count
        If I <> 1 Then
            MessageBox.Show("One and only one row must be selected.")
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tName As String = txtRssName.Text
        Dim tUrl As String = txtRssURL.Text
        Dim RC As Boolean = True

        Dim MySql As String = "delete from rssPull where RssName = '" + tName + "' and UserID = '" + gCurrUserGuidID + "' "

        RC = DBARCH.ExecuteSqlNewConn(90327, MySql)

        If RC Then
            GetRSS(gGateWayID)
        Else
            MessageBox.Show("Failed to DELETE RSS Feed A10: " + tName)
        End If
    End Sub

    Private Sub dgRss_MouseClick(sender As System.Object, e As System.Windows.Forms.MouseEventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        SB.Text = "RSS Grid has " + dgRss.Rows.Count.ToString + " rows."
    End Sub

    Private Sub dgRss_SelectionChanged(sender As System.Object, e As System.EventArgs) Handles dgRss.SelectionChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim I As Integer = dgRss.SelectedRows.Count
        If I = 1 Then
            Dim DR As DataGridViewRow = dgRss.SelectedRows(0)
            txtRssName.Text = DR.Cells("RssName").Value.ToString
            txtRssURL.Text = DR.Cells("RssURL").Value.ToString
            cbRssRetention.Text = DR.Cells("RetentionCode").Value.ToString
        Else
            SB.Text = "Only one row can be selected."
        End If
    End Sub

    Private Sub dgWebPage_SelectionChanged(sender As System.Object, e As System.EventArgs) Handles dgWebPage.SelectionChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim I As Integer = dgWebPage.SelectedRows.Count
        If I = 1 Then
            Dim DR As DataGridViewRow = dgWebPage.SelectedRows(0)
            txtWebScreenName.Text = DR.Cells("WebScreen").Value.ToString
            txtWebScreenUrl.Text = DR.Cells("WebUrl").Value.ToString
            cbWebPageRetention.Text = DR.Cells("RetentionCode").Value.ToString
        Else
            SB.Text = "Only one row can be selected."
        End If
    End Sub

    Private Sub dgWebSite_SelectionChanged(sender As System.Object, e As System.EventArgs) Handles dgWebSite.SelectionChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim I As Integer = dgWebSite.SelectedRows.Count
        If I = 1 Then
            Dim DR As DataGridViewRow = dgWebSite.SelectedRows(0)
            txtWebSiteName.Text = DR.Cells("WebSite").Value.ToString
            txtWebSiteURL.Text = DR.Cells("WebUrl").Value.ToString
            nbrDepth.Value = CDec(DR.Cells("Depth").Value)
            nbrOutboundLinks.Value = CDec(DR.Cells("Width").Value)
            cbWebSiteRetention.Text = DR.Cells("RetentionCode").Value.ToString
        Else
            SB.Text = "Only one row can be selected."
        End If
    End Sub

    Private Sub AsyncRssPull_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles asyncRssPull.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        If ckTerminate.Checked Then
            If Not gRunUnattended Then
                MessageBox.Show("The TERMINATE immediately box is checked, returning.")
                Return
            Else
                LOG.WriteToArchiveLog("AsyncRssPull_DoWork: The TERMINATE immediately box is checked, returning.")
            End If
        End If
        If ckDisable.Checked Then
            ArchiveALLToolStripMenuItem.Enabled = True
            ContentToolStripMenuItem.Enabled = True
            ExchangeEmailsToolStripMenuItem.Enabled = True
            OutlookEmailsToolStripMenuItem.Enabled = True
            Return
        End If
        If ckRssPullDisabled.Checked Then
            Return
        End If

        ARCH.ArchiveRSS(gCurrUserGuidID)

    End Sub

    Private Sub asyncSpiderWebSite_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles asyncSpiderWebSite.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        If ckTerminate.Checked Then
            If Not gRunUnattended Then
                MessageBox.Show("The TERMINATE immediately box is checked, returning.")
                Return
            Else
                LOG.WriteToArchiveLog("asyncSpiderWebSite_DoWork: The TERMINATE immediately box is checked, returning.")
            End If
        End If
        If ckDisable.Checked Then
            'SB.Text = "DISABLE ALL is checked - no archive allowed."
            ArchiveALLToolStripMenuItem.Enabled = True
            ContentToolStripMenuItem.Enabled = True
            ExchangeEmailsToolStripMenuItem.Enabled = True
            OutlookEmailsToolStripMenuItem.Enabled = True
            Return
        End If
        If ckWebSiteTrackerDisabled.Checked Then
            'SB.Text = "DISABLE WEB Site Archive checked - no archive allowed."
            Return
        End If
        ARCH.ArchiveWebSites(gCurrUserGuidID)
    End Sub

    Private Sub AsyncSpiderWebPage_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles asyncSpiderWebPage.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        If ckTerminate.Checked Then
            If Not gRunUnattended Then
                MessageBox.Show("The TERMINATE immediately box is checked, returning.")
                Return
            Else
                LOG.WriteToArchiveLog("AsyncSpiderWebPage_DoWork: The TERMINATE immediately box is checked, returning.")
            End If
        End If
        If ckDisable.Checked Then
            'SB.Text = "DISABLE ALL is checked - no archive allowed."
            ArchiveALLToolStripMenuItem.Enabled = True
            ContentToolStripMenuItem.Enabled = True
            ExchangeEmailsToolStripMenuItem.Enabled = True
            OutlookEmailsToolStripMenuItem.Enabled = True
            Return
        End If
        If ckWebPageTrackerDisabled.Checked Then
            'SB.Text = "DISABLE WEB Page Archive checked - no archive allowed."
            Return
        End If

        ARCH.ArchiveSingleWebPage(gCurrUserGuidID)
    End Sub

    Private Sub RetentionRulesToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles RetentionRulesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        frmRetentionCode.ShowDialog()
    End Sub

    Private Sub RulesExecutionToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles RulesExecutionToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        frmRetentionMgt.ShowDialog()
    End Sub

    Private Sub CheckForUpdatesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CheckForUpdatesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim info As UpdateCheckInfo = Nothing

        If (ApplicationDeployment.IsNetworkDeployed) Then
            Dim AD As ApplicationDeployment = ApplicationDeployment.CurrentDeployment

            Try
                info = AD.CheckForDetailedUpdate()
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch dde As DeploymentDownloadException
                MessageBox.Show("The new version of the application cannot be downloaded at this time. " + ControlChars.Lf & ControlChars.Lf & "Please check your network connection, or try again later. Error: " + dde.Message)
                Return
            Catch ioe As InvalidOperationException
                MessageBox.Show("This application cannot be updated. It is likely not a ClickOnce application. Error: " & ioe.Message)
                Return
            End Try

            If (info.UpdateAvailable) Then
                Dim doUpdate As Boolean = True

                If (Not info.IsUpdateRequired) Then
                    Dim dr As DialogResult = MessageBox.Show("An update is available. Would you like to update the application now?", "Update Available", MessageBoxButtons.OKCancel)
                    If (Not System.Windows.Forms.DialogResult.OK = dr) Then
                        doUpdate = False
                    End If
                Else
                    ' Display a message that the app MUST reboot. Display the minimum required version.
                    MessageBox.Show("This application has detected a mandatory update from your current " &
                        "version to version " & info.MinimumRequiredVersion.ToString() &
                        ". The application will now install the update and restart.",
                        "Update Available", MessageBoxButtons.OK,
                        MessageBoxIcon.Information)
                End If

                If (doUpdate) Then
                    Try
                        AD.Update()
                        MessageBox.Show("The application has been upgraded, and will now restart.")
                        Application.Restart()
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch dde As DeploymentDownloadException
                        MessageBox.Show("Cannot install the latest version of the application. " & ControlChars.Lf & ControlChars.Lf & "Please check your network connection, or try again later.")
                        Return
                    End Try
                End If
            End If
        End If

    End Sub

    'Private Sub ShowEndpointsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ShowEndpointsToolStripMenuItem.Click

    ' Dim strProxyFS As String = "" Dim strProxyArchive As String = "" Dim strProxySearch As String =
    ' "" Dim strProxyGateway As String = ""

    ' strProxyFS = ProxyFS.Endpoint.Address.ToString strProxyArchive =
    ' ProxyArchive.Endpoint.Address.ToString strProxySearch = ProxySearch.Endpoint.Address.ToString

    ' 'strProxyGateway = ProxyGateway.Endpoint.Address.ToString

    '    Dim s As String = "CURRENT END POINTS:" + vbCrLf
    '    s += "SVCFS: " + strProxyFS + vbCrLf
    '    s += "SVCGateway: " + strProxyGateway + vbCrLf
    '    s += "SVCCLCArchive: " + strProxyArchive + vbCrLf
    '    s += "SVCSearch: " + strProxySearch + vbCrLf
    '    MessageBox.Show(s)
    'End Sub

    Private Sub ShowSystemVersionToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ShowSystemVersionToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim OSVersion As String = Environment.OSVersion.ToString()
        Dim OSVersionMajor As String = Environment.OSVersion.Version.Major.ToString
        Dim OSVersionMinor As String = Environment.OSVersion.Version.Minor.ToString
        Dim OSVersionMinorRev As String = Environment.OSVersion.Version.MinorRevision.ToString
        MessageBox.Show(OSVersion)
    End Sub

    Private Sub ClearRestoreQueueToolStripMenuItem_Click(sender As Object, e As EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim b As Boolean = DBARCH.ClearRestoreQueue(gGateWayID, gCurrLoginID)
        If b = True Then
            MessageBox.Show("Cleared queue.")
        Else
            MessageBox.Show("Failed to clear queue.")
        End If
    End Sub

    Private Function UnicodeBytesToString(
    ByVal bytes() As Byte) As String

        Return System.Text.Encoding.Unicode.GetString(bytes)
    End Function

    Private Function UnicodeStringToBytes(
    ByVal str As String) As Byte()

        Return System.Text.Encoding.Unicode.GetBytes(str)
    End Function

    Private Sub SelectedFilesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles SelectedFilesToolStripMenuItem.Click
        OpenFileDialog1.Multiselect = True
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim FilesProcessed As String = ""
        Dim AttachmentBinary() As Byte = Nothing
        Dim CF As New clsFile
        Dim FileBytes As Byte() = Nothing
        Dim ListOfFiles As New List(Of DS_Content)
        Dim FileDetails As New DS_Content
        Dim result As DialogResult = OpenFileDialog1.ShowDialog()
        Dim tDict As New Dictionary(Of String, String)
        Dim FQN As String = ""

        If result = Windows.Forms.DialogResult.OK Then
            Dim CurrUserGuidID As String = DBARCH.getUserGuidID(gUserID)

            Try
                For I As Integer = 0 To OpenFileDialog1.FileNames.Count - 1
                    tDict.Clear()
                    FQN = OpenFileDialog1.FileNames(I)
                    'Dim AttachmentBinary() As Byte = File.ReadAllBytes(FQN)
                    Try
                        AttachmentBinary = System.IO.File.ReadAllBytes(FQN)
                        ' AttachmentBinary = My.Computer.FileSystem.ReadAllBytes(FQN)
                    Catch ex As ThreadAbortException
                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                        Thread.ResetAbort()
                    Catch ex As Exception
                        AttachmentBinary = Nothing
                        MessageBox.Show("ERROR: " + ex.Message)
                    End Try

                    If AttachmentBinary.Length.Equals(0) Then
                        MessageBox.Show(FQN + " Has 0 bytes... skipping")
                        GoTo NEXTONE
                    End If

                    tDict.Add("CRC", ENC.GenerateSHA512HashFromFile(FQN))
                    tDict.Add("ImageHash", ENC.GenerateSHA512HashFromFile(FQN))
                    FileBytes = File.ReadAllBytes(FQN)

                    Dim myFile As New FileInfo(FQN)
                    Dim sizeInBytes As Long = myFile.Length

                    Dim bGraphic As Boolean = ckIsGraphic(myFile.Extension)

                    tDict.Add("RowGuid", Guid.NewGuid().ToString)
                    tDict.Add("SourceGuid", Guid.NewGuid().ToString)
                    tDict.Add("CreateDate", myFile.CreationTime)
                    tDict.Add("SourceName", myFile.Name)
                    tDict.Add("SourceImage", UnicodeBytesToString(FileBytes))
                    tDict.Add("SourceTypeCode", myFile.Extension)
                    tDict.Add("FQN", myFile.FullName)
                    tDict.Add("VersionNbr", "")
                    tDict.Add("LastAccessDate", myFile.LastAccessTime)
                    tDict.Add("FileLength", myFile.Length.ToString)
                    tDict.Add("LastWriteTime", myFile.LastAccessTime.ToString)
                    tDict.Add("UserID", gUserID)
                    tDict.Add("DataSourceOwnerUserID", gUserID)
                    tDict.Add("isPublic", "1")
                    tDict.Add("FileDirectory", myFile.DirectoryName)
                    tDict.Add("OriginalFileType", myFile.Extension)
                    tDict.Add("RetentionExpirationDate", "")
                    tDict.Add("IsPublicPreviousState", "")
                    tDict.Add("isAvailable", "1")
                    tDict.Add("isContainedWithinZipFile", "0")
                    Dim bZipfile As Boolean = ckIsZipFile(myFile.Extension)
                    If bZipfile Then
                        tDict.Add("IsZipFile", "1")
                    Else
                        tDict.Add("IsZipFile", "0")
                    End If
                    tDict.Add("DataVerified", "")
                    tDict.Add("ZipFileGuid", "")
                    If bZipfile Then
                        tDict.Add("ZipFileFQN", FQN)
                    Else
                        tDict.Add("ZipFileFQN", "")
                    End If

                    tDict.Add("Description", "")
                    tDict.Add("KeyWords", "")
                    tDict.Add("Notes", "")
                    tDict.Add("isPerm", "1")
                    tDict.Add("isMaster", "")
                    tDict.Add("CreationDate", myFile.CreationTime.ToString)
                    tDict.Add("OcrPerformed", "0")
                    If bGraphic Then
                        tDict.Add("isGraphic", "1")
                    Else
                        tDict.Add("isGraphic", "0")
                    End If
                    tDict.Add("GraphicContainsText", "")
                    tDict.Add("OcrText", "")
                    tDict.Add("ImageHiddenText", "")
                    tDict.Add("isWebPage", "0")
                    tDict.Add("ParentGuid", "")
                    tDict.Add("RetentionCode", "Retain 10")
                    tDict.Add("MachineID", gMachineID)

                    tDict.Add("SharePoint", "")
                    tDict.Add("SharePointDoc", "")
                    tDict.Add("SharePointList", "")
                    tDict.Add("SharePointListItem", "")
                    tDict.Add("StructuredData", "")
                    tDict.Add("HiveConnectionName", "")
                    tDict.Add("HiveActive", "")
                    tDict.Add("RepoSvrName", gServerInstanceName)
                    tDict.Add("RowCreationDate", Now.ToString)
                    tDict.Add("RowLastModDate", Now.ToString)
                    tDict.Add("ContainedWithin", "")
                    tDict.Add("RecLen", "")
                    tDict.Add("RecHash", "")
                    tDict.Add("OriginalSize", sizeInBytes.ToString)
                    tDict.Add("CompressedSize", "")
                    tDict.Add("txStartTime", Now.ToString)
                    tDict.Add("txEndTime", "")
                    tDict.Add("txTotalTime", "")
                    tDict.Add("TransmitTime", "")
                    tDict.Add("FileAttached", "")
                    tDict.Add("BPS", "")
                    tDict.Add("RepoName", gServerInstanceName)
                    tDict.Add("HashFile", ENC.GenerateSHA512HashFromFile(FQN))
                    tDict.Add("HashName", "Sha1")
                    tDict.Add("OcrSuccessful", "")
                    If bGraphic Then
                        tDict.Add("OcrPending", "1")
                    Else
                        tDict.Add("OcrPending", "0")
                    End If
                    tDict.Add("PdfIsSearchable", "")
                    tDict.Add("PdfOcrRequired", "")
                    tDict.Add("PdfOcrSuccess", "")
                    tDict.Add("PdfOcrTextExtracted", "")
                    tDict.Add("PdfPages", "")
                    tDict.Add("PdfImages", "")
                    If bGraphic Then
                        tDict.Add("RequireOcr", "1")
                    Else
                        tDict.Add("RequireOcr", "0")
                    End If
                    tDict.Add("RssLinkFlg", "")
                    tDict.Add("RssLinkGuid", "")
                    tDict.Add("PageURL", "")
                    tDict.Add("RetentionDate", "")
                    tDict.Add("URLHash", "")
                    tDict.Add("WebPagePublishDate", "")
                    tDict.Add("SapData", "")
                    tDict.Add("RowID", "")

                    myFile = Nothing

                    Dim RowID As String = DBARCH.ckContentExists(tDict("SourceName"), tDict("ImageHash"))

                    If RowID.Length.Equals(0) Then
                        Dim b As Boolean = DBARCH.insertNewContent(tDict, FileBytes, "FILE")
                        If b Then
                            SB.Text = ("Inserted: " + FQN)
                            SB.Refresh()
                            FilesProcessed += tDict("SourceName") + vbCrLf
                        End If
                    Else
                        Dim b As Boolean = DBARCH.updateExistingContent(tDict, RowID, FileBytes)
                        If b Then
                            SB.Text = ("Updated: " + FQN)
                            SB.Refresh()
                            FilesProcessed += tDict("SourceName") + vbCrLf
                        End If
                    End If
NEXTONE:
                Next
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                SB.Text = "Error   " + FQN + " @ " + ex.Message.ToString
            End Try
            MessageBox.Show("FILES PROCESSED:" + vbCrLf + FilesProcessed)
            CF = Nothing
        End If
    End Sub

    Private Sub btnArchive1Doc_Click(sender As Object, e As EventArgs) Handles btnArchive1Doc.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        SelectedFilesToolStripMenuItem_Click(Nothing, Nothing)
    End Sub

    Public Function getContentlDictValue(tkey As String) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tval As String = ""
        Select Case tkey
            Case "RowGuid"
                tval = DictContent("RowGuid")
            Case "SourceGuid"
                tval = DictContent("SourceGuid")
            Case "CreateDate"
                tval = DictContent("CreateDate")
            Case "SourceName"
                tval = DictContent("SourceName")
            Case "SourceImage"
                tval = DictContent("SourceImage")
            Case "SourceTypeCode"
                tval = DictContent("SourceTypeCode")
            Case "FQN"
                tval = DictContent("FQN")
            Case "VersionNbr"
                tval = DictContent("VersionNbr")
            Case "LastAccessDate"
                tval = DictContent("LastAccessDate")
            Case "FileLength"
                tval = DictContent("FileLength")
            Case "LastWriteTime"
                tval = DictContent("LastWriteTime")
            Case "UserID"
                tval = DictContent("UserID")
            Case "DataSourceOwnerUserID"
                tval = DictContent("DataSourceOwnerUserID")
            Case "isPublic"
                tval = DictContent("isPublic")
            Case "FileDirectory"
                tval = DictContent("FileDirectory")
            Case "OriginalFileType"
                tval = DictContent("OriginalFileType")
            Case "RetentionExpirationDate"
                tval = DictContent("RetentionExpirationDate")
            Case "IsPublicPreviousState"
                tval = DictContent("IsPublicPreviousState")
            Case "isAvailable"
                tval = DictContent("isAvailable")
            Case "isContainedWithinZipFile"
                tval = DictContent("isContainedWithinZipFile")
            Case "IsZipFile"
                tval = DictContent("IsZipFile")
            Case "DataVerified"
                tval = DictContent("DataVerified")
            Case "ZipFileGuid"
                tval = DictContent("ZipFileGuid")
            Case "ZipFileFQN"
                tval = DictContent("ZipFileFQN")
            Case "Description"
                tval = DictContent("Description")
            Case "KeyWords"
                tval = DictContent("KeyWords")
            Case "Notes"
                tval = DictContent("Notes")
            Case "isPerm"
                tval = DictContent("isPerm")
            Case "isMaster"
                tval = DictContent("isMaster")
            Case "CreationDate"
                tval = DictContent("CreationDate")
            Case "OcrPerformed"
                tval = DictContent("OcrPerformed")
            Case "isGraphic"
                tval = DictContent("isGraphic")
            Case "GraphicContainsText"
                tval = DictContent("GraphicContainsText")
            Case "OcrText"
                tval = DictContent("OcrText")
            Case "ImageHiddenText"
                tval = DictContent("ImageHiddenText")
            Case "isWebPage"
                tval = DictContent("isWebPage")
            Case "ParentGuid"
                tval = DictContent("ParentGuid")
            Case "RetentionCode"
                tval = DictContent("RetentionCode")
            Case "MachineID"
                tval = DictContent("MachineID")
            Case "CRC"
                tval = DictContent("CRC")
            Case "ImageHash"
                tval = DictContent("ImageHash")
            Case "SharePoint"
                tval = DictContent("SharePoint")
            Case "SharePointDoc"
                tval = DictContent("SharePointDoc")
            Case "SharePointList"
                tval = DictContent("SharePointList")
            Case "SharePointListItem"
                tval = DictContent("SharePointListItem")
            Case "StructuredData"
                tval = DictContent("StructuredData")
            Case "HiveConnectionName"
                tval = DictContent("HiveConnectionName")
            Case "HiveActive"
                tval = DictContent("HiveActive")
            Case "RepoSvrName"
                tval = DictContent("RepoSvrName")
            Case "RowCreationDate"
                tval = DictContent("RowCreationDate")
            Case "RowLastModDate"
                tval = DictContent("RowLastModDate")
            Case "ContainedWithin"
                tval = DictContent("ContainedWithin")
            Case "RecLen"
                tval = DictContent("RecLen")
            Case "RecHash"
                tval = DictContent("RecHash")
            Case "OriginalSize"
                tval = DictContent("OriginalSize")
            Case "CompressedSize"
                tval = DictContent("CompressedSize")
            Case "txStartTime"
                tval = DictContent("txStartTime")
            Case "txEndTime"
                tval = DictContent("txEndTime")
            Case "txTotalTime"
                tval = DictContent("txTotalTime")
            Case "TransmitTime"
                tval = DictContent("TransmitTime")
            Case "FileAttached"
                tval = DictContent("FileAttached")
            Case "BPS"
                tval = DictContent("BPS")
            Case "RepoName"
                tval = DictContent("RepoName")
            Case "HashFile"
                tval = DictContent("HashFile")
            Case "HashName"
                tval = DictContent("HashName")
            Case "OcrSuccessful"
                tval = DictContent("OcrSuccessful")
            Case "OcrPending"
                tval = DictContent("OcrPending")
            Case "PdfIsSearchable"
                tval = DictContent("PdfIsSearchable")
            Case "PdfOcrRequired"
                tval = DictContent("PdfOcrRequired")
            Case "PdfOcrSuccess"
                tval = DictContent("PdfOcrSuccess")
            Case "PdfOcrTextExtracted"
                tval = DictContent("PdfOcrTextExtracted")
            Case "PdfPages"
                tval = DictContent("PdfPages")
            Case "PdfImages"
                tval = DictContent("PdfImages")
            Case "RequireOcr"
                tval = DictContent("RequireOcr")
            Case "RssLinkFlg"
                tval = DictContent("RssLinkFlg")
            Case "RssLinkGuid"
                tval = DictContent("RssLinkGuid")
            Case "PageURL"
                tval = DictContent("PageURL")
            Case "RetentionDate"
                tval = DictContent("RetentionDate")
            Case "URLHash"
                tval = DictContent("URLHash")
            Case "WebPagePublishDate"
                tval = DictContent("WebPagePublishDate")
            Case "SapData"
                tval = DictContent("SapData")
            Case "RowID"
                tval = DictContent("RowID")
        End Select
        Return tval
    End Function

    Public Function getEmailDictValue(tkey As String) As String
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim tval As String = ""
        Select Case tkey
            Case "EmailGuid"
                tval = DictEmails("EmailGuid")
            Case "SUBJECT"
                tval = DictEmails("SUBJECT")
            Case "SentTO"
                tval = DictEmails("SentTO")
            Case "Body"
                tval = DictEmails("Body")
            Case "Bcc"
                tval = DictEmails("Bcc")
            Case "BillingInformation"
                tval = DictEmails("BillingInformation")
            Case "CC"
                tval = DictEmails("CC")
            Case "Companies"
                tval = DictEmails("Companies")
            Case "CreationTime"
                tval = DictEmails("CreationTime")
            Case "ReadReceiptRequested"
                tval = DictEmails("ReadReceiptRequested")
            Case "ReceivedByName"
                tval = DictEmails("ReceivedByName")
            Case "ReceivedTime"
                tval = DictEmails("ReceivedTime")
            Case "AllRecipients"
                tval = DictEmails("AllRecipients")
            Case "UserID"
                tval = DictEmails("UserID")
            Case "SenderEmailAddress"
                tval = DictEmails("SenderEmailAddress")
            Case "SenderName"
                tval = DictEmails("SenderName")
            Case "Sensitivity"
                tval = DictEmails("Sensitivity")
            Case "SentOn"
                tval = DictEmails("SentOn")
            Case "MsgSize"
                tval = DictEmails("MsgSize")
            Case "DeferredDeliveryTime"
                tval = DictEmails("DeferredDeliveryTime")
            Case "EntryID"
                tval = DictEmails("EntryID")
            Case "ExpiryTime"
                tval = DictEmails("ExpiryTime")
            Case "LastModificationTime"
                tval = DictEmails("LastModificationTime")
            Case "EmailImage"
                tval = DictEmails("EmailImage")
            Case "Accounts"
                tval = DictEmails("Accounts")
            Case "ShortSubj"
                tval = DictEmails("ShortSubj")
            Case "SourceTypeCode"
                tval = DictEmails("SourceTypeCode")
            Case "OriginalFolder"
                tval = DictEmails("OriginalFolder")
            Case "StoreID"
                tval = DictEmails("StoreID")
            Case "isPublic"
                tval = DictEmails("isPublic")
            Case "RetentionExpirationDate"
                tval = DictEmails("RetentionExpirationDate")
            Case "IsPublicPreviousState"
                tval = DictEmails("IsPublicPreviousState")
            Case "isAvailable"
                tval = DictEmails("isAvailable")
            Case "CurrMailFolderID"
                tval = DictEmails("CurrMailFolderID")
            Case "isPerm"
                tval = DictEmails("isPerm")
            Case "isMaster"
                tval = DictEmails("isMaster")
            Case "CreationDate"
                tval = DictEmails("CreationDate")
            Case "NbrAttachments"
                tval = DictEmails("NbrAttachments")
            Case "CRC"
                tval = DictEmails("CRC")
            Case "ImageHash"
                tval = DictContent("ImageHash")
            Case "Description"
                tval = DictEmails("Description")
            Case "KeyWords"
                tval = DictEmails("KeyWords")
            Case "RetentionCode"
                tval = DictEmails("RetentionCode")
            Case "EmailIdentifier"
                tval = DictEmails("EmailIdentifier")
            Case "ConvertEmlToMSG"
                tval = DictEmails("ConvertEmlToMSG")
            Case "HiveConnectionName"
                tval = DictEmails("HiveConnectionName")
            Case "HiveActive"
                tval = DictEmails("HiveActive")
            Case "RepoSvrName"
                tval = DictEmails("RepoSvrName")
            Case "RowCreationDate"
                tval = DictEmails("RowCreationDate")
            Case "RowLastModDate"
                tval = DictEmails("RowLastModDate")
            Case "UIDL"
                tval = DictEmails("UIDL")
            Case "RecLen"
                tval = DictEmails("RecLen")
            Case "RecHash"
                tval = DictEmails("RecHash")
            Case "OriginalSize"
                tval = DictEmails("OriginalSize")
            Case "CompressedSize"
                tval = DictEmails("CompressedSize")
            Case "txStartTime"
                tval = DictEmails("txStartTime")
            Case "txEndTime"
                tval = DictEmails("txEndTime")
            Case "txTotalTime"
                tval = DictEmails("txTotalTime")
            Case "TransmitTime"
                tval = DictEmails("TransmitTime")
            Case "FileAttached"
                tval = DictEmails("FileAttached")
            Case "BPS"
                tval = DictEmails("BPS")
            Case "RepoName"
                tval = DictEmails("RepoName")
            Case "HashFile"
                tval = DictEmails("HashFile")
            Case "HashName"
                tval = DictEmails("HashName")
            Case "ContainsAttachment"
                tval = DictEmails("ContainsAttachment")
            Case "NbrAttachment"
                tval = DictEmails("NbrAttachment")
            Case "NbrZipFiles"
                tval = DictEmails("NbrZipFiles")
            Case "NbrZipFilesCnt"
                tval = DictEmails("NbrZipFilesCnt")
            Case "PdfIsSearchable"
                tval = DictEmails("PdfIsSearchable")
            Case "PdfOcrRequired"
                tval = DictEmails("PdfOcrRequired")
            Case "PdfOcrSuccess"
                tval = DictEmails("PdfOcrSuccess")
            Case "PdfOcrTextExtracted"
                tval = DictEmails("PdfOcrTextExtracted")
            Case "PdfPages"
                tval = DictEmails("PdfPages")
            Case "PdfImages"
                tval = DictEmails("PdfImages")
            Case "MachineID"
                tval = DictEmails("MachineID")
            Case "notes"
                tval = DictEmails("notes")
            Case "NbrOccurances"
                tval = DictEmails("NbrOccurances")
            Case "RowID"
                tval = DictEmails("RowID")
            Case "RowGuid"
                tval = DictEmails("RowGuid")
        End Select
        Return tval
    End Function

    Function fillEmailDict() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim EmailGuid As String = ""
        Dim SUBJECT As String = ""
        Dim SentTO As String = ""
        Dim Body As String = ""
        Dim Bcc As String = ""
        Dim BillingInformation As String = ""
        Dim CC As String = ""
        Dim Companies As String = ""
        Dim CreationTime As String = ""
        Dim ReadReceiptRequested As String = ""
        Dim ReceivedByName As String = ""
        Dim ReceivedTime As String = ""
        Dim AllRecipients As String = ""
        Dim UserID As String = ""
        Dim SenderEmailAddress As String = ""
        Dim SenderName As String = ""
        Dim Sensitivity As String = ""
        Dim SentOn As String = ""
        Dim MsgSize As String = ""
        Dim DeferredDeliveryTime As String = ""
        Dim EntryID As String = ""
        Dim ExpiryTime As String = ""
        Dim LastModificationTime As String = ""
        Dim EmailImage As String = ""
        Dim Accounts As String = ""
        Dim ShortSubj As String = ""
        Dim SourceTypeCode As String = ""
        Dim OriginalFolder As String = ""
        Dim StoreID As String = ""
        Dim isPublic As String = ""
        Dim RetentionExpirationDate As String = ""
        Dim IsPublicPreviousState As String = ""
        Dim isAvailable As String = ""
        Dim CurrMailFolderID As String = ""
        Dim isPerm As String = ""
        Dim isMaster As String = ""
        Dim CreationDate As String = ""
        Dim NbrAttachments As String = ""
        Dim CRC As String = ""
        Dim ImageHash As String = ""
        Dim Description As String = ""
        Dim KeyWords As String = ""
        Dim RetentionCode As String = ""
        Dim EmailIdentifier As String = ""
        Dim ConvertEmlToMSG As String = ""
        Dim HiveConnectionName As String = ""
        Dim HiveActive As String = ""
        Dim RepoSvrName As String = ""
        Dim RowCreationDate As String = ""
        Dim RowLastModDate As String = ""
        Dim UIDL As String = ""
        Dim RecLen As String = ""
        Dim RecHash As String = ""
        Dim OriginalSize As String = ""
        Dim CompressedSize As String = ""
        Dim txStartTime As String = ""
        Dim txEndTime As String = ""
        Dim txTotalTime As String = ""
        Dim TransmitTime As String = ""
        Dim FileAttached As String = ""
        Dim BPS As String = ""
        Dim RepoName As String = ""
        Dim HashFile As String = ""
        Dim HashName As String = ""
        Dim ContainsAttachment As String = ""
        Dim NbrAttachment As String = ""
        Dim NbrZipFiles As String = ""
        Dim NbrZipFilesCnt As String = ""
        Dim PdfIsSearchable As String = ""
        Dim PdfOcrRequired As String = ""
        Dim PdfOcrSuccess As String = ""
        Dim PdfOcrTextExtracted As String = ""
        Dim PdfPages As String = ""
        Dim PdfImages As String = ""
        Dim MachineID As String = ""
        Dim notes As String = ""
        Dim NbrOccurances As String = ""
        Dim RowID As String = ""
        Dim RowGuid As String = ""

        DictEmails.Add("EmailGuid", EmailGuid)
        DictEmails.Add("SUBJECT", SUBJECT)
        DictEmails.Add("SentTO", SentTO)
        DictEmails.Add("Body", Body)
        DictEmails.Add("Bcc", Bcc)
        DictEmails.Add("BillingInformation", BillingInformation)
        DictEmails.Add("CC", CC)
        DictEmails.Add("Companies", Companies)
        DictEmails.Add("CreationTime", CreationTime)
        DictEmails.Add("ReadReceiptRequested", ReadReceiptRequested)
        DictEmails.Add("ReceivedByName", ReceivedByName)
        DictEmails.Add("ReceivedTime", ReceivedTime)
        DictEmails.Add("AllRecipients", AllRecipients)
        DictEmails.Add("UserID", UserID)
        DictEmails.Add("SenderEmailAddress", SenderEmailAddress)
        DictEmails.Add("SenderName", SenderName)
        DictEmails.Add("Sensitivity", Sensitivity)
        DictEmails.Add("SentOn", SentOn)
        DictEmails.Add("MsgSize", MsgSize)
        DictEmails.Add("DeferredDeliveryTime", DeferredDeliveryTime)
        DictEmails.Add("EntryID", EntryID)
        DictEmails.Add("ExpiryTime", ExpiryTime)
        DictEmails.Add("LastModificationTime", LastModificationTime)
        DictEmails.Add("EmailImage", EmailImage)
        DictEmails.Add("Accounts", Accounts)
        DictEmails.Add("ShortSubj", ShortSubj)
        DictEmails.Add("SourceTypeCode", SourceTypeCode)
        DictEmails.Add("OriginalFolder", OriginalFolder)
        DictEmails.Add("StoreID", StoreID)
        DictEmails.Add("isPublic", isPublic)
        DictEmails.Add("RetentionExpirationDate", RetentionExpirationDate)
        DictEmails.Add("IsPublicPreviousState", IsPublicPreviousState)
        DictEmails.Add("isAvailable", isAvailable)
        DictEmails.Add("CurrMailFolderID", CurrMailFolderID)
        DictEmails.Add("isPerm", isPerm)
        DictEmails.Add("isMaster", isMaster)
        DictEmails.Add("CreationDate", CreationDate)
        DictEmails.Add("NbrAttachments", NbrAttachments)
        DictEmails.Add("CRC", CRC)
        DictEmails.Add("ImageHash", ImageHash)
        DictEmails.Add("Description", Description)
        DictEmails.Add("KeyWords", KeyWords)
        DictEmails.Add("RetentionCode", RetentionCode)
        DictEmails.Add("EmailIdentifier", EmailIdentifier)
        DictEmails.Add("ConvertEmlToMSG", ConvertEmlToMSG)
        DictEmails.Add("HiveConnectionName", HiveConnectionName)
        DictEmails.Add("HiveActive", HiveActive)
        DictEmails.Add("RepoSvrName", RepoSvrName)
        DictEmails.Add("RowCreationDate", RowCreationDate)
        DictEmails.Add("RowLastModDate", RowLastModDate)
        DictEmails.Add("UIDL", UIDL)
        DictEmails.Add("RecLen", RecLen)
        DictEmails.Add("RecHash", RecHash)
        DictEmails.Add("OriginalSize", OriginalSize)
        DictEmails.Add("CompressedSize", CompressedSize)
        DictEmails.Add("txStartTime", txStartTime)
        DictEmails.Add("txEndTime", txEndTime)
        DictEmails.Add("txTotalTime", txTotalTime)
        DictEmails.Add("TransmitTime", TransmitTime)
        DictEmails.Add("FileAttached", FileAttached)
        DictEmails.Add("BPS", BPS)
        DictEmails.Add("RepoName", RepoName)
        DictEmails.Add("HashFile", HashFile)
        DictEmails.Add("HashName", HashName)
        DictEmails.Add("ContainsAttachment", ContainsAttachment)
        DictEmails.Add("NbrAttachment", NbrAttachment)
        DictEmails.Add("NbrZipFiles", NbrZipFiles)
        DictEmails.Add("NbrZipFilesCnt", NbrZipFilesCnt)
        DictEmails.Add("PdfIsSearchable", PdfIsSearchable)
        DictEmails.Add("PdfOcrRequired", PdfOcrRequired)
        DictEmails.Add("PdfOcrSuccess", PdfOcrSuccess)
        DictEmails.Add("PdfOcrTextExtracted", PdfOcrTextExtracted)
        DictEmails.Add("PdfPages", PdfPages)
        DictEmails.Add("PdfImages", PdfImages)
        DictEmails.Add("MachineID", MachineID)
        DictEmails.Add("notes", notes)
        DictEmails.Add("NbrOccurances", NbrOccurances)
        DictEmails.Add("RowID", RowID)
        DictEmails.Add("RowGuid", RowGuid)

    End Function

    Function fillContentDict() As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim RowGuid As String = ""
        Dim SourceGuid As String = ""
        Dim CreateDate As String = ""
        Dim SourceName As String = ""
        Dim SourceImage As String = ""
        Dim SourceTypeCode As String = ""
        Dim FQN As String = ""
        Dim VersionNbr As String = ""
        Dim LastAccessDate As String = ""
        Dim FileLength As String = ""
        Dim LastWriteTime As String = ""
        Dim UserID As String = ""
        Dim DataSourceOwnerUserID As String = ""
        Dim isPublic As String = ""
        Dim FileDirectory As String = ""
        Dim OriginalFileType As String = ""
        Dim RetentionExpirationDate As String = ""
        Dim IsPublicPreviousState As String = ""
        Dim isAvailable As String = ""
        Dim isContainedWithinZipFile As String = ""
        Dim IsZipFile As String = ""
        Dim DataVerified As String = ""
        Dim ZipFileGuid As String = ""
        Dim ZipFileFQN As String = ""
        Dim Description As String = ""
        Dim KeyWords As String = ""
        Dim Notes As String = ""
        Dim isPerm As String = ""
        Dim isMaster As String = ""
        Dim CreationDate As String = ""
        Dim OcrPerformed As String = ""
        Dim isGraphic As String = ""
        Dim GraphicContainsText As String = ""
        Dim OcrText As String = ""
        Dim ImageHiddenText As String = ""
        Dim isWebPage As String = ""
        Dim ParentGuid As String = ""
        Dim RetentionCode As String = ""
        Dim MachineID As String = ""
        Dim CRC As String = ""
        Dim ImageHash As String = ""
        Dim SharePoint As String = ""
        Dim SharePointDoc As String = ""
        Dim SharePointList As String = ""
        Dim SharePointListItem As String = ""
        Dim StructuredData As String = ""
        Dim HiveConnectionName As String = ""
        Dim HiveActive As String = ""
        Dim RepoSvrName As String = ""
        Dim RowCreationDate As String = ""
        Dim RowLastModDate As String = ""
        Dim ContainedWithin As String = ""
        Dim RecLen As String = ""
        Dim RecHash As String = ""
        Dim OriginalSize As String = ""
        Dim CompressedSize As String = ""
        Dim txStartTime As String = ""
        Dim txEndTime As String = ""
        Dim txTotalTime As String = ""
        Dim TransmitTime As String = ""
        Dim FileAttached As String = ""
        Dim BPS As String = ""
        Dim RepoName As String = ""
        Dim HashFile As String = ""
        Dim HashName As String = ""
        Dim OcrSuccessful As String = ""
        Dim OcrPending As String = ""
        Dim PdfIsSearchable As String = ""
        Dim PdfOcrRequired As String = ""
        Dim PdfOcrSuccess As String = ""
        Dim PdfOcrTextExtracted As String = ""
        Dim PdfPages As String = ""
        Dim PdfImages As String = ""
        Dim RequireOcr As String = ""
        Dim RssLinkFlg As String = ""
        Dim RssLinkGuid As String = ""
        Dim PageURL As String = ""
        Dim RetentionDate As String = ""
        Dim URLHash As String = ""
        Dim WebPagePublishDate As String = ""
        Dim SapData As String = ""
        Dim RowID As String = ""

        DictContent.Add("RowGuid", RowGuid)
        DictContent.Add("SourceGuid", SourceGuid)
        DictContent.Add("CreateDate", CreateDate)
        DictContent.Add("SourceName", SourceName)
        DictContent.Add("SourceImage", SourceImage)
        DictContent.Add("SourceTypeCode", SourceTypeCode)
        DictContent.Add("FQN", FQN)
        DictContent.Add("VersionNbr", VersionNbr)
        DictContent.Add("LastAccessDate", LastAccessDate)
        DictContent.Add("FileLength", FileLength)
        DictContent.Add("LastWriteTime", LastWriteTime)
        DictContent.Add("UserID", UserID)
        DictContent.Add("DataSourceOwnerUserID", DataSourceOwnerUserID)
        DictContent.Add("isPublic", isPublic)
        DictContent.Add("FileDirectory", FileDirectory)
        DictContent.Add("OriginalFileType", OriginalFileType)
        DictContent.Add("RetentionExpirationDate", RetentionExpirationDate)
        DictContent.Add("IsPublicPreviousState", IsPublicPreviousState)
        DictContent.Add("isAvailable", isAvailable)
        DictContent.Add("isContainedWithinZipFile", isContainedWithinZipFile)
        DictContent.Add("IsZipFile", IsZipFile)
        DictContent.Add("DataVerified", DataVerified)
        DictContent.Add("ZipFileGuid", ZipFileGuid)
        DictContent.Add("ZipFileFQN", ZipFileFQN)
        DictContent.Add("Description", Description)
        DictContent.Add("KeyWords", KeyWords)
        DictContent.Add("Notes", Notes)
        DictContent.Add("isPerm", isPerm)
        DictContent.Add("isMaster", isMaster)
        DictContent.Add("CreationDate", CreationDate)
        DictContent.Add("OcrPerformed", OcrPerformed)
        DictContent.Add("isGraphic", isGraphic)
        DictContent.Add("GraphicContainsText", GraphicContainsText)
        DictContent.Add("OcrText", OcrText)
        DictContent.Add("ImageHiddenText", ImageHiddenText)
        DictContent.Add("isWebPage", isWebPage)
        DictContent.Add("ParentGuid", ParentGuid)
        DictContent.Add("RetentionCode", RetentionCode)
        DictContent.Add("MachineID", MachineID)
        DictContent.Add("CRC", CRC)
        DictContent.Add("ImageHash", ImageHash)
        DictContent.Add("SharePoint", SharePoint)
        DictContent.Add("SharePointDoc", SharePointDoc)
        DictContent.Add("SharePointList", SharePointList)
        DictContent.Add("SharePointListItem", SharePointListItem)
        DictContent.Add("StructuredData", StructuredData)
        DictContent.Add("HiveConnectionName", HiveConnectionName)
        DictContent.Add("HiveActive", HiveActive)
        DictContent.Add("RepoSvrName", RepoSvrName)
        DictContent.Add("RowCreationDate", RowCreationDate)
        DictContent.Add("RowLastModDate", RowLastModDate)
        DictContent.Add("ContainedWithin", ContainedWithin)
        DictContent.Add("RecLen", RecLen)
        DictContent.Add("RecHash", RecHash)
        DictContent.Add("OriginalSize", OriginalSize)
        DictContent.Add("CompressedSize", CompressedSize)
        DictContent.Add("txStartTime", txStartTime)
        DictContent.Add("txEndTime", txEndTime)
        DictContent.Add("txTotalTime", txTotalTime)
        DictContent.Add("TransmitTime", TransmitTime)
        DictContent.Add("FileAttached", FileAttached)
        DictContent.Add("BPS", BPS)
        DictContent.Add("RepoName", RepoName)
        DictContent.Add("HashFile", HashFile)
        DictContent.Add("HashName", HashName)
        DictContent.Add("OcrSuccessful", OcrSuccessful)
        DictContent.Add("OcrPending", OcrPending)
        DictContent.Add("PdfIsSearchable", PdfIsSearchable)
        DictContent.Add("PdfOcrRequired", PdfOcrRequired)
        DictContent.Add("PdfOcrSuccess", PdfOcrSuccess)
        DictContent.Add("PdfOcrTextExtracted", PdfOcrTextExtracted)
        DictContent.Add("PdfPages", PdfPages)
        DictContent.Add("PdfImages", PdfImages)
        DictContent.Add("RequireOcr", RequireOcr)
        DictContent.Add("RssLinkFlg", RssLinkFlg)
        DictContent.Add("RssLinkGuid", RssLinkGuid)
        DictContent.Add("PageURL", PageURL)
        DictContent.Add("RetentionDate", RetentionDate)
        DictContent.Add("URLHash", URLHash)
        DictContent.Add("WebPagePublishDate", WebPagePublishDate)
        DictContent.Add("SapData", SapData)
        DictContent.Add("RowID", RowID)
    End Function

    Function ckIsGraphic(ext As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ext = ext.ToUpper
        ext = ext.Replace(".", "")
        If GraphicDict.Contains(ext) Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub populateGraphicExtensions()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        GraphicDict.Add("JPG")
        GraphicDict.Add("PNG")
        GraphicDict.Add("GIF")
        GraphicDict.Add("WEBP")
        GraphicDict.Add("TIFF")
        GraphicDict.Add("PSD")
        GraphicDict.Add("RAW")
        GraphicDict.Add("BMP")
        GraphicDict.Add("HEIF")
        GraphicDict.Add("INDD")
        GraphicDict.Add("JPEG 2000")
        GraphicDict.Add("SVG")
        GraphicDict.Add("AI")
        GraphicDict.Add("EPS")
        'GraphicDict.Add("PDF")
        GraphicDict.Add("JPG")
        GraphicDict.Add("JPEG")
        GraphicDict.Add("JPE")
        GraphicDict.Add("JIF")
        GraphicDict.Add("JFIF")
        GraphicDict.Add("JFI")
    End Sub

    Private Sub populateZipExtensions()
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ZipDict.Add("001", "Is an extension that indicates that the archive Is Using the ARJ format For compression. You may also see such files With the extension Of .arj. Used On MS-DOS, although other platforms have tools that will uncompress 001 And ARJ files.")
        ZipDict.Add("7Z", "Is a New format created For use With 7-Zip, an open source Windows-based archiver.")
        ZipDict.Add("ARJ", "files are discussed previously, with 001.")
        ZipDict.Add("BIN", "Is Mac OS-only, & stands For MacBinary. Does very little compression, And creates binary files instead of text files. Leaves Mac-specific data intact & therefore keeping the 'resource fork' together with the 'data fork'. Since both forks are kept together, for example, a decompressed file will still display its actual icon, instead of a generic file icon. Since it's a binary format, you need to transfer .bin files over FTP only after setting your FTP program to 'binary'.")
        ZipDict.Add("BZIP", "and BZIP2 uses the 'Burrows-Wheeler block sorting text compression algorithm' (no, I don't know what that means either). It is used on Linux and other Unix-like systems. Files using this method end in '.bz2.")
        ZipDict.Add("CAB", "is a Microsoft cabinet file, used to distribute software programs.")
        ZipDict.Add("CPIO", "is a Unix command used for copying files into, and out of, archivs. It's not seen very much any more, since it's been pretty much supplanted by TAR and GZIP.")
        ZipDict.Add("DEB", "is used by the Debian distribution of Linux to package software installation files. RPM is a similar tool for different distributions of Linux.")
        ZipDict.Add("EAR", "for Enterprise ARchive, is used with Java 2 Enterprise Edition (J2EE) applications that require multiple JAR and WAR files, discussed afterwards. EAR, like JAR and WAR, uses the same compression method as ZIP.")
        ZipDict.Add("GZ", "is the GNU version of ZIP. It is commonly used on Linux systems.")
        ZipDict.Add("HQX", "is a BinHex file. Converts text and binary files into ASCII text; specifically, the 7 bits that most Unix systems use. Results in larger files than .bin; however, it's safer for traveling around the Internet via email because that fact that it uses ASCII text allows the transfer of binary programs over non-binary transfer protocols like UUCP and sendmail. When using FTP, it doesn't matter if you set your transfer to 'binary' or 'ASCII7'; either way, if you're using .hqx, things will be fine.")
        ZipDict.Add("JAR", "stands for Java ARchive, and is used with archives containing software written in and for the Java programming language. JAR, like EAR and WAR, uses the same compression method as ZIP.")
        ZipDict.Add("LHA", "is a Japanese compression format dating from the 1980s. It proved to be influential, since the source code was made available by Dr. Haruyasu Yoshizaki, its creator. One of the few archivers used on computers running the Amiga operating system.")
        ZipDict.Add("RAR", "is a proprietary format developed by Eugene Roshal. His licensing allows for the free decoding of RAR archives, but encoding is only allowed by his company.")
        ZipDict.Add("RPM", "stands for 'Red Hat Package Manager.') Invented by Red Hat, it is used to build and install individual software packages. Since it is almost entirely used as a tool for Linux software installation, it is extremely rare to find it used to compress normal data files, or to find it on Windows or Mac OS X machines.")
        ZipDict.Add("SEA", "stands for Self-Expanding Archive, and it goes with SIT, discussed next.")
        ZipDict.Add("SIT", "is use with the Mac program StuffIt. Also leaves Mac-specific data intact, like a .bin. This form of compression is proprietary to Alladin Systems, but their 'Expander' program is free for download for both Mac and Windows. Does a pretty good job of compressing files.")
        ZipDict.Add("TAR", "files aren't really compressed; instead, they're conjoined to form one large file. In other words, if you have 100 files, each 3 kb, and you tar them together, you end up with one 300 kb file. At this point, most tar files are compressed using another program, often gzip, resulting in a file with the extension of '.tar.gz' or 'tgz.') Almost never seen on Windows or Mac OS X, and extremely common on Linux computers.")
        ZipDict.Add("WAR", "files are related to JAR archives. WAR, which stands for Web ARchive, brings together all the files that a Java-based Web application needs—Java archives, HTML pages, XML files, and so on—so the application can be run easily on a Web server. Like JAR and EAR, WAR use the same compression method as ZIP.")
        ZipDict.Add("ZIP", "works across a wide variety of computing platforms, including Unix and Linux, VMS, OS/2, MS-DOS, Windows, and Macintosh. The reason for the format's near universality can be attributed to Phil Katz, the developer of the original ZIP compression algorithm, who placed in the public domain the ZIP file format, its compression format, and the .zip filename extension.")

    End Sub

    Function ckIsZipFile(ext As String) As Boolean
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ext = ext.ToUpper
        ext = ext.Replace(".", "")
        If ZipDict.ContainsKey(ext) Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub cbProfile_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbProfile.SelectedIndexChanged
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub OpenLicenseFormToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OpenLicenseFormToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        frmLicense.ShowDialog()
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        Dim FQN As String = "D:\dev\WhitePapers\How To Set Up an OpenVPN Server on Ubuntu 18.docx"
        FQN = FQN.Replace("''", "'")
        FileHash = ENC.hashSha1File(FQN)
        Console.WriteLine(FQN)
        Console.WriteLine(FileHash)

        Try
            DBLocal.GetFileID(FQN, FileHash)
            MessageBox.Show("SQLite Operational")
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            MessageBox.Show("SQLite FAILED")
        End Try

    End Sub

    Private Sub TimerAutoExec_Tick(sender As Object, e As EventArgs) Handles TimerAutoExec.Tick
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        If gAutoExec And gAutoExecContentComplete And gAutoExecEmailComplete And gAutoExecExchangeComplete Then
            gAutoExec = False
            DBLocal.BackUpSQLite()
            Try
                RemoveHandler currentDomain.UnhandledException, AddressOf MYExnHandler
                RemoveHandler Application.ThreadException, AddressOf MYThreadHandler
            Catch ex As Exception
                Console.WriteLine("Archiver closed")
            End Try

            LOG.WriteToArchiveLog("ARCHIVER CLOSING DOWN SUCCESSFULLY.")

            If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                bUpdated = DBLocal.removeListenerfileProcessed()
                If Not bUpdated Then
                    LOG.WriteToArchiveLog("ERROR 00 failed removeListenerfileProcessed...")
                End If
            End If

            LoginForm1.Close()
            Me.Close()
        Else
            AutoExecCheck += 1
        End If
    End Sub

    Private Sub RebuildSQLiteDBToolStripMenuItem_Click(sender As Object, e As EventArgs)
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        DBLocal.RebuildDB()
        MessageBox.Show("Database rebuilt")
    End Sub

    Private Sub asyncBatchOcrALL_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrALL.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub asyncBatchOcrPending_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrPending.DoWork
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

    End Sub

    Private Sub UnhandledExceptionsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles UnhandledExceptionsToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        '' Define a handler for unhandled exceptions.
        'AddHandler currentDomain.UnhandledException, AddressOf MYExnHandler
        '' Define a handler for unhandled exceptions for threads behind forms.
        'AddHandler Application.ThreadException, AddressOf MYThreadHandler

        ' This code will throw an exception and will be caught.
        Dim X As Integer = 5
        X = X / 0 'throws exception will be caught by subs below

        'RemoveHandler currentDomain.UnhandledException, AddressOf MYExnHandler
        'RemoveHandler Application.ThreadException, AddressOf MYThreadHandler
    End Sub

    Private Sub BackupSQLiteDBToolStripMenuItem_Click(sender As Object, e As EventArgs)
        '
        DBLocal.BackUpSQLite()

        MessageBox.Show("Backup Complete...")

    End Sub

    Private Sub RestoreSQLiteDBToolStripMenuItem_Click(sender As Object, e As EventArgs)

        DBLocal.RestoreSQLite()
        MessageBox.Show("Restore Complete...")

    End Sub

    Private Sub BackupSQLiteDBToolStripMenuItem_Click_1(sender As Object, e As EventArgs)
        DBLocal.BackUpSQLite()
        MessageBox.Show("Backup Complete...")
    End Sub

    Private Sub SQLiteInterfaceScreenToolStripMenuItem_Click(sender As Object, e As EventArgs)
        frmSqlite.Show()
    End Sub

    Private Sub InventoryDirectoryToolStripMenuItem_Click(sender As Object, e As EventArgs)

    End Sub

    Public Sub ThreadUpdateNotice(ByVal value As String)
        If InvokeRequired Then
            Me.Invoke(New Action(Of String)(AddressOf ThreadUpdateNotice), New Object() {value})
            Return
        End If

        lblNotice.Text = value
    End Sub

    Public Sub ThreadUpdateSB(ByVal value As String)
        If InvokeRequired Then
            Me.Invoke(New Action(Of String)(AddressOf ThreadUpdateSB), New Object() {value})
            Return
        End If

        SB.Text = value
    End Sub

    Public Sub ThreadUpdateSB2(ByVal value As String)
        If InvokeRequired Then
            Me.Invoke(New Action(Of String)(AddressOf ThreadUpdateSB2), New Object() {value})
            Return
        End If

        SB2.Text = value
    End Sub

    Private Sub ContentThread_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles ContentThread.DoWork
        PerformContentArchive()
        frmNotify.Hide()
        gAutoExecContentComplete = True
    End Sub

    Private Sub GetListenerFilesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles GetListenerFilesToolStripMenuItem.Click
        Dim s As String = ""
        Dim LOF As New List(Of String)
        LOF = DBLocal.getListenerfiles()
        MessageBox.Show("Retrieved " + LOF.ToString + " files to process.")
    End Sub

    Private Sub CompareDirToRepositoryToolStripMenuItem_Click(sender As Object, e As EventArgs)

        Dim msg As String = ""
        Dim targetDirectory As String = ""
        Dim txtFilesArray As String() = Nothing
        Dim ListOfExt As ArrayList = Nothing
        Dim dir As String = ""
        Dim fqn As String = ""
        Dim ext As String = ""
        Dim filename As String = ""
        Dim found As Integer = 0
        Dim missing As Integer = 0
        Dim BadDirCnt As Integer = 0
        Dim GoodDirCnt As Integer = 0
        Dim BadFileCnt As Integer = 0
        Dim GoodFileCnt As Integer = 0
        Dim MissingFileCnt As Integer = 0
        Dim SkippedFileCnt As Integer = 0
        Dim iCurr As Integer = 0
        Dim TotFiles As Integer = 0

        LOG.WriteToDirAnalysisLog("Directories Name Too Long:", True)
        LOG.WriteToDirAnalysisLog("-------------------------", False)
        If (FolderBrowserDialog1.ShowDialog() = DialogResult.OK) Then
            targetDirectory = FolderBrowserDialog1.SelectedPath
        End If

        'Individual components of a filename (i.e. each subdirectory along the path,
        'And the final filename) are limited to 255 characters, And the total path
        'length Is limited To approximately 32, 0 characters. However, on Windows,
        'you can't exceed MAX_PATH value (259 characters for files, 248 for folders)

        Dim ListOfDir As New List(Of String)
        Dim ListOfDirs() As String = Directory.GetDirectories(targetDirectory)

        ListOfDir.Add(targetDirectory)
        For k As Integer = 0 To ListOfDirs.Count - 1
            dir = ListOfDirs(k)
            If Not ListOfDir.Contains(dir) Then
                ListOfDir.Add(dir)
            End If
        Next

        For k As Integer = 0 To ListOfDir.Count - 1
            dir = ListOfDir(k)
            If dir.Length.Equals(0) Then
                ListOfDir(k) = ""
            ElseIf dir.Length > 255 Then
                BadDirCnt += 1
                msg = "   -> " + dir
                LOG.WriteToDirAnalysisLog(msg, False)
                ListOfDir(k) = ""
            Else
                GoodDirCnt += 1
            End If
        Next

        ListOfDir.Sort()
        ListOfDirs = Nothing

        ListOfExt = DBARCH.GetIncludedFiletypes(targetDirectory)

        If ListOfExt.Count.Equals(0) Then
            ListOfExt = DBARCH.GetIncludedFiletypes("")
        End If

        LOG.WriteToDirAnalysisLog(" ", False)
        LOG.WriteToDirAnalysisLog("Directories and Files:", False)
        LOG.WriteToDirAnalysisLog("-------------------------", False)

        Cursor = Cursors.WaitCursor
        For k As Integer = 0 To ListOfDir.Count - 1

            SB2.Text = "Processing Directory #" + (k + 1).ToString + " of " + ListOfDir.Count.ToString
            SB2.Refresh()
            dir = ListOfDir(k).Trim
            If (dir.Length > 0) Then
                txtFilesArray = Directory.GetFiles(dir, "*.*", SearchOption.TopDirectoryOnly)
                msg = "    -->Dir: >" + dir + "< Contains: " + txtFilesArray.Count.ToString + " files."
                LOG.WriteToDirAnalysisLog(msg, False)
                Dim icnt As Integer = 0
                Dim I As Integer = 0
                Dim bProcess As Boolean = False
                TotFiles += txtFilesArray.Count
                For Each fqn In txtFilesArray
                    iCurr += 1
                    lblNotice.Text = "File# " + iCurr.ToString + " of " + txtFilesArray.Length.ToString
                    lblNotice.Refresh()
                    bProcess = True
                    If ListOfExt.Count > 0 Then
                        I = fqn.LastIndexOf(".")
                        If I > 0 Then
                            ext = fqn.Substring(I + 1).ToUpper
                            If ListOfExt.Contains(ext) Then
                                bProcess = True
                            Else
                                SkippedFileCnt += 1
                                bProcess = False
                            End If
                        End If
                    End If
                    icnt += 1
                    lblNotice.Text = icnt.ToString("N0") + " of " + txtFilesArray.Count.ToString("N0")
                    lblNotice.Refresh()

                    If bProcess Then
                        B = DBARCH.ckFQNExists(fqn)
                        If B Then
                            found += 1
                        Else
                            missing += 1
                            msg = "    .. Missing: " + fqn
                            LOG.WriteToDirAnalysisLog(msg, False)
                        End If
                        SB.Text = "Found: " + found.ToString + " : Missing: " + missing.ToString
                    End If
                Next
            End If
        Next
        Cursor = Cursors.Default

        LOG.WriteToDirAnalysisLog("***********************************", False)
        msg = "Total Directories: " + ListOfDir.Count.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Bad Directories  : " + BadDirCnt.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Total Files      : " + TotFiles.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Skipped Files    : " + SkippedFileCnt.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Not in Repo      : " + missing.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "In Repo          : " + found.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)

        MessageBox.Show("Inventory complete...")

    End Sub

    Private Sub ThreadValidateSourceName_DoWork_1(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles ThreadValidateSourceName.DoWork
        Dim MachineName As String = Environment.MachineName.ToString
        DBARCH.CleanupSourceName(MachineName)
    End Sub

    Private Sub LIstWindowsLogsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles LIstWindowsLogsToolStripMenuItem.Click
        Dim remoteEventLogs As EventLog()
        Dim MachineName As String = Environment.MachineName
        remoteEventLogs = EventLog.GetEventLogs(MachineName)
        Console.WriteLine("Number of logs on computer: " & remoteEventLogs.Length)

        For Each log As EventLog In remoteEventLogs
            Console.WriteLine("Log: " & log.Log)
        Next
    End Sub

    Private Sub CheckLogsForListenerInfoToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CheckLogsForListenerInfoToolStripMenuItem.Click
        DisplayEventLogProperties()
    End Sub

    Private Shared Sub DisplayEventLogProperties()
        Dim eventLogs As EventLog() = EventLog.GetEventLogs()

        For Each e As EventLog In eventLogs
            Dim sizeKB As Int64 = 0
            Console.WriteLine()
            Console.WriteLine("{0}:", e.LogDisplayName)
            Console.WriteLine("  Log name = " & vbTab & vbTab & " {0}", e.Log)
            Console.WriteLine("  Number of event log entries = {0}", e.Entries.Count.ToString())
            Dim regEventLog As RegistryKey = Registry.LocalMachine.OpenSubKey("System\CurrentControlSet\Services\EventLog\" & e.Log)

            If regEventLog IsNot Nothing Then
                Dim temp As Object = regEventLog.GetValue("File")

                If temp IsNot Nothing Then
                    Console.WriteLine("  Log file path = " & vbTab & " {0}", temp.ToString())
                    Dim file As FileInfo = New FileInfo(temp.ToString())

                    If file.Exists Then
                        sizeKB = file.Length / 1024

                        If (file.Length Mod 1024) <> 0 Then
                            sizeKB += 1
                        End If

                        Console.WriteLine("  Current size = " & vbTab & " {0} kilobytes", sizeKB.ToString())
                    End If
                Else
                    Console.WriteLine("  Log file path = " & vbTab & " <not set>")
                End If
            End If

            sizeKB = e.MaximumKilobytes
            Console.WriteLine("  Maximum size = " & vbTab & " {0} kilobytes", sizeKB.ToString())
            Console.WriteLine("  Overflow setting = " & vbTab & " {0}", e.OverflowAction.ToString())

            Select Case e.OverflowAction
                Case OverflowAction.OverwriteOlder
                    Console.WriteLine(vbTab & " Entries are retained a minimum of {0} days.", e.MinimumRetentionDays)
                Case OverflowAction.DoNotOverwrite
                    Console.WriteLine(vbTab & " Older entries are not overwritten.")
                Case OverflowAction.OverwriteAsNeeded
                    Console.WriteLine(vbTab & " If number of entries equals max size limit, a new event log entry overwrites the oldest entry.")
                Case Else
            End Select
        Next
    End Sub

    Sub ResetSqlite()

        DBLocal.truncateDirs()
        DBLocal.truncateFiles()
        DBLocal.truncateInventory()
        DBLocal.truncateOutlook()
        DBLocal.truncateExchange()
        DBLocal.truncateContacts()
        DBLocal.truncateDirFiles()

    End Sub

    Private Sub ResetSQLiteArchivesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ResetSQLiteArchivesToolStripMenuItem.Click
        Dim msg As String = "This empties the temporary data store used for performance enhancement, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        ResetSqlite()

        MessageBox.Show("Temporary file stores cleaned up and ready.")
    End Sub

    Private Sub GetOutlookEMailIDsToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles GetOutlookEMailIDsToolStripMenuItem1.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim SL As New SortedList()
        DBARCH.LoadEntryIdByUserID(SL)
        DBLocal.truncateOutlook()
        Dim I As Integer = 0
        Dim K As Integer = SL.Count

        PB1.Value = 0
        PB1.Minimum = 0
        PB1.Maximum = SL.Keys.Count + 1
        For Each sKey As String In SL.Keys
            DBLocal.addOutlook(sKey)
            I += 1
            If I Mod 10 = 0 Then
                PB1.Value = I
                SB.Text = I.ToString + " of " + K.ToString
                SB.Refresh()
            End If
        Next

        PB1.Value = 0
        SB.Text = "Complete."
        MessageBox.Show("Outlook refresh complete.")
        SL = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    Private Sub ResetZIPFilesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ResetZIPFilesToolStripMenuItem.Click
        Dim msg As String = "This deletes the pending ZIP files to be processed, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        DBLocal.zeroizeZipFiles()

        MessageBox.Show("Temporary zip files cleaned up and ready.")
    End Sub

    Private Sub ResetEmailIdentifierCodesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ResetEmailIdentifierCodesToolStripMenuItem.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        DBARCH.setEmailCrcHash(isAdmin)
        GetOutlookEmailIDsToolStripMenuItem_Click(Nothing, Nothing)
    End Sub

    Private Sub RebuildSQLiteDBToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles RebuildSQLiteDBToolStripMenuItem1.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If
        DBLocal.RebuildDB()
        MessageBox.Show("Database rebuilt")
    End Sub

    Private Sub BackupSQLiteDBToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles BackupSQLiteDBToolStripMenuItem1.Click
        DBLocal.BackUpSQLite()
        MessageBox.Show("Backup Complete...")
    End Sub

    Private Sub RestoreSQLiteDBToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles RestoreSQLiteDBToolStripMenuItem1.Click
        DBLocal.RestoreSQLite()
        MessageBox.Show("Restore Complete...")
    End Sub

    Private Sub ClearRestoreQueueToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles ClearRestoreQueueToolStripMenuItem1.Click
        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim b As Boolean = DBARCH.ClearRestoreQueue(gGateWayID, gCurrLoginID)
        If b = True Then
            MessageBox.Show("Cleared queue.")
        Else
            MessageBox.Show("Failed to clear queue.")
        End If
    End Sub

    Private Sub SQToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles SQToolStripMenuItem.Click
        frmSqlite.Show()
    End Sub

    Private Sub CompareDirToRepositoryToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles CompareDirToRepositoryToolStripMenuItem1.Click

        Dim msg As String = ""
        Dim targetDirectory As String = ""
        Dim txtFilesArray As String() = Nothing
        Dim ListOfExt As ArrayList = Nothing
        Dim dir As String = ""
        Dim fqn As String = ""
        Dim ext As String = ""
        Dim filename As String = ""
        Dim found As Integer = 0
        Dim missing As Integer = 0
        Dim BadDirCnt As Integer = 0
        Dim GoodDirCnt As Integer = 0
        Dim BadFileCnt As Integer = 0
        Dim GoodFileCnt As Integer = 0
        Dim MissingFileCnt As Integer = 0
        Dim SkippedFileCnt As Integer = 0
        Dim iCurr As Integer = 0
        Dim TotFiles As Integer = 0

        LOG.WriteToDirAnalysisLog("Directories Name Too Long:", True)
        LOG.WriteToDirAnalysisLog("-------------------------", False)
        If (FolderBrowserDialog1.ShowDialog() = DialogResult.OK) Then
            targetDirectory = FolderBrowserDialog1.SelectedPath
        End If

        'Individual components of a filename (i.e. each subdirectory along the path,
        'And the final filename) are limited to 255 characters, And the total path
        'length Is limited To approximately 32, 0 characters. However, on Windows,
        'you can't exceed MAX_PATH value (259 characters for files, 248 for folders)

        Dim ListOfDir As New List(Of String)
        Dim ListOfDirs() As String = Directory.GetDirectories(targetDirectory)

        ListOfDir.Add(targetDirectory)
        For k As Integer = 0 To ListOfDirs.Count - 1
            dir = ListOfDirs(k)
            If Not ListOfDir.Contains(dir) Then
                ListOfDir.Add(dir)
            End If
        Next

        For k As Integer = 0 To ListOfDir.Count - 1
            dir = ListOfDir(k)
            If dir.Length.Equals(0) Then
                ListOfDir(k) = ""
            ElseIf dir.Length > 255 Then
                BadDirCnt += 1
                msg = "   -> " + dir
                LOG.WriteToDirAnalysisLog(msg, False)
                ListOfDir(k) = ""
            Else
                GoodDirCnt += 1
            End If
        Next

        ListOfDir.Sort()
        ListOfDirs = Nothing

        ListOfExt = DBARCH.GetIncludedFiletypes(targetDirectory)

        If ListOfExt.Count.Equals(0) Then
            ListOfExt = DBARCH.GetIncludedFiletypes("")
        End If

        LOG.WriteToDirAnalysisLog(" ", False)
        LOG.WriteToDirAnalysisLog("Directories and Files:", False)
        LOG.WriteToDirAnalysisLog("-------------------------", False)

        Cursor = Cursors.WaitCursor
        For k As Integer = 0 To ListOfDir.Count - 1

            SB2.Text = "Processing Directory #" + (k + 1).ToString + " of " + ListOfDir.Count.ToString
            SB2.Refresh()
            dir = ListOfDir(k).Trim
            If (dir.Length > 0) Then
                txtFilesArray = Directory.GetFiles(dir, "*.*", SearchOption.TopDirectoryOnly)
                msg = "    -->Dir: >" + dir + "< Contains: " + txtFilesArray.Count.ToString + " files."
                LOG.WriteToDirAnalysisLog(msg, False)
                Dim icnt As Integer = 0
                Dim I As Integer = 0
                Dim bProcess As Boolean = False
                TotFiles += txtFilesArray.Count
                For Each fqn In txtFilesArray
                    iCurr += 1
                    lblNotice.Text = "File# " + iCurr.ToString + " of " + txtFilesArray.Length.ToString
                    lblNotice.Refresh()
                    bProcess = True
                    If ListOfExt.Count > 0 Then
                        I = fqn.LastIndexOf(".")
                        If I > 0 Then
                            ext = fqn.Substring(I + 1).ToUpper
                            If ListOfExt.Contains(ext) Then
                                bProcess = True
                            Else
                                SkippedFileCnt += 1
                                bProcess = False
                            End If
                        End If
                    End If
                    icnt += 1
                    lblNotice.Text = icnt.ToString("N0") + " of " + txtFilesArray.Count.ToString("N0")
                    lblNotice.Refresh()

                    If bProcess Then
                        B = DBARCH.ckFQNExists(fqn)
                        If B Then
                            found += 1
                        Else
                            missing += 1
                            msg = "    .. Missing: " + fqn
                            LOG.WriteToDirAnalysisLog(msg, False)
                        End If
                        SB.Text = "Found: " + found.ToString + " : Missing: " + missing.ToString
                    End If
                Next
            End If
        Next
        Cursor = Cursors.Default

        LOG.WriteToDirAnalysisLog("***********************************", False)
        msg = "Total Directories: " + ListOfDir.Count.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Bad Directories  : " + BadDirCnt.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Total Files      : " + TotFiles.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Skipped Files    : " + SkippedFileCnt.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "Not in Repo      : " + missing.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)
        msg = "In Repo          : " + found.ToString("N0")
        LOG.WriteToDirAnalysisLog(msg, False)

        MessageBox.Show("Inventory complete...")

    End Sub

    Private Sub InventoryDirectoryToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles InventoryDirectoryToolStripMenuItem1.Click
        Dim targetDirectory As String = ""
        Dim txtFilesArray As String() = Nothing
        Dim ListOfExt As ArrayList = Nothing
        Dim dir As String = ""
        Dim fqn As String = ""
        Dim ext As String = ""
        Dim filename As String = ""
        Dim found As Integer = 0
        Dim missing As Integer = 0

        If (FolderBrowserDialog1.ShowDialog() = DialogResult.OK) Then
            targetDirectory = FolderBrowserDialog1.SelectedPath
        End If

        ListOfExt = DBARCH.GetIncludedFiletypes(targetDirectory)
        If ListOfExt.Count.Equals(0) Then
            ListOfExt = DBARCH.GetIncludedFiletypes("")
        End If

        Cursor = Cursors.WaitCursor
        txtFilesArray = Directory.GetFiles(targetDirectory, "*.*", SearchOption.AllDirectories)
        Cursor = Cursors.Default

        Console.WriteLine("txtFilesArray: " + txtFilesArray.Count.ToString)
        Dim icnt As Integer = 0
        Dim I As Integer = 0
        Dim bProcess As Boolean = False
        For Each fqn In txtFilesArray
            bProcess = True
            If ListOfExt.Count > 0 Then
                I = fqn.LastIndexOf(".")
                If I > 0 Then
                    ext = fqn.Substring(I + 1).ToUpper
                    If ListOfExt.Contains(ext) Then
                        bProcess = True
                    Else
                        bProcess = False
                    End If
                End If
            End If
            icnt += 1
            If bProcess Then
                lblNotice.Text = icnt.ToString("N0") + " of " + txtFilesArray.Count.ToString("N0")
                lblNotice.Refresh()
                B = DBARCH.ckFQNExists(fqn)
                LOG.WriteToInventoryLog(B, fqn)
                If B Then
                    found += 1
                Else
                    missing += 1
                End If
                SB2.Text = "Found: " + found.ToString + " : Missing: " + missing.ToString
            End If
        Next

        MessageBox.Show("Inventory complete...")

    End Sub

    Private Sub ValidateDirectoryFilesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ValidateDirectoryFilesToolStripMenuItem.Click
        Dim Dname As String = ""
        If (FolderBrowserDialog1.ShowDialog() = DialogResult.OK) Then
            Dname = FolderBrowserDialog1.SelectedPath
        Else
            Return
        End If

        frmNotify.Show()

        Dim FName As String = ""
        Dim iCnt As Integer = 0
        Dim FilterList As New List(Of String)
        Dim UTIL As New clsUtility
        Dim Files As List(Of FileInfo) = Nothing
        Dim Msg As String = "Inventory Date: " + Now.ToString
        Dim prevdir As String = "XXXXXX"
        Dim iInventoryCnt As Integer = 0
        Dim iDirCnt As Integer = 0
        Dim iBadCnt As Integer = 0
        Dim iSkipCnt As Integer = 0
        Dim iBadDir As Integer = 0

        Me.Cursor = Cursors.WaitCursor

        frmNotify.Refresh()
        frmNotify.lblPdgPages.Text = "Standby, fetching directories and files, this could take a while..."
        frmNotify.Refresh()
        Dim LisOfFiles As String() = Directory.GetFiles(Dname, "*.*", SearchOption.AllDirectories)
        'Files = UTIL.GetFilesRecursive(Dname, FilterList)
        Me.Cursor = Cursors.Default

        frmNotify.Show()

        Dim iTotal As Integer = LisOfFiles.Count.ToString
        frmNotify.Text = ""

        For Each sfile As String In LisOfFiles
            Try
                iInventoryCnt += 1
                Msg = iInventoryCnt.ToString("N0") + " of " + iTotal.ToString("N0")
                Try
                    frmNotify.lblFileSpec.Text = Msg
                    frmNotify.Refresh()
                Catch ex As Exception
                    Console.WriteLine(ex.Message)
                End Try

                If Not File.Exists(sfile) Then
                    GoTo SkipIT
                End If

                Dim FI As New FileInfo(sfile)

                Dname = FI.DirectoryName
                FName = FI.Name
                FQN = FI.FullName
                FileLength = FI.Length
                EXT = FI.Extension.ToUpper
                If EXT.contains(".") Then
                    EXT = EXT.Substring(1)
                End If

                FI = Nothing

                If prevdir <> Dname Then
                    Try
                        frmNotify.lblPdgPages.Text = Dname
                        frmNotify.Refresh()
                    Catch ex As Exception
                        Console.WriteLine(ex.Message)
                    End Try

                    iDirCnt += 1
                    LOG.WriteToDirAnalysisLog("-------------------------------------------", False)
                    LOG.WriteToDirAnalysisLog("DIRECTORY: " + Dname, False)
                    LOG.WriteToDirAnalysisLog("-------------------------------------------", False)
                End If

                If FileLength >= MaxFileToLoadMB * 1000000 Then
                    LOG.WriteToDirAnalysisLog("     File : " + FName + " EXCEEDS MAXIMUM ALLOWED FILE SIZE, SKIPPING.", False)
                    iBadCnt += 1
                    GoTo SkipIT
                End If

                If Dname.Trim.Length > 248 Then
                    LOG.WriteToDirAnalysisLog("     Directory name too long: " + Dname, False)
                    iBadDir += 1
                    Dname = getShortDirName(Dname)
                    LOG.WriteToDirAnalysisLog("     Directory Shortened name: " + Dname, False)
                    If Dname.Trim.Length > 248 Then
                        LOG.WriteToDirAnalysisLog("     SHORTENED directory name too long, skipping ENTIRE DIRECTORY", False)
                        GoTo SkipIT
                    End If
                End If

                If FName.Trim.Length > 260 Then
                    LOG.WriteToDirAnalysisLog("     File name too long: " + FName + " - SKIPPING FILE.", False)
                    iBadCnt += 1
                    GoTo SkipIT
                End If

                Application.DoEvents()

                If (EXT.length > 0) Then
                    If IncludedTypes.Count > 0 Then
                        If Not IncludedTypes.Contains(EXT) Then
                            LOG.WriteToDirAnalysisLog("     File EXT NOT in Included list of Ext's: " + FName, False)
                            iSkipCnt += 1
                            NeedsUpdate = False
                        End If
                    End If

                    If ExcludedTypes.Count > 0 Then
                        LOG.WriteToDirAnalysisLog("     File EXT EXCLUDED, skipping: " + FName, False)
                        If ExcludedTypes.Contains(EXT) Then
                            iSkipCnt += 1
                            NeedsUpdate = False
                        End If
                    End If
                Else
                    LOG.WriteToDirAnalysisLog("     File has no EXT, skipping: " + FName, False)
                    iSkipCnt += 1
                End If
            Catch ex As Exception
                LOG.WriteToDirAnalysisLog("     ERROR: DirectoryInventory: " + ex.Message + vbCrLf + "DIRECTORY:" + Dname + vbCrLf + "File: " + FName, False)
            End Try
SkipIT:
            prevdir = Dname
        Next

        frmNotify.Hide()

        Msg = "Inventory Count: " + iInventoryCnt.ToString + vbCrLf
        Msg += "Directory Count: " + iDirCnt.ToString + vbCrLf
        Msg += "Bad Directories: " + iBadDir.ToString + vbCrLf
        Msg += "Bad Files: " + iBadCnt.ToString + vbCrLf
        Msg += "Skipped Files: " + iSkipCnt.ToString + vbCrLf + vbCrLf
        Msg += "RUN COMPLETE"

        LOG.WriteToDirAnalysisLog("Inventory Count: " + iInventoryCnt.ToString, False)
        LOG.WriteToDirAnalysisLog("Directory Count: " + iDirCnt.ToString, False)
        LOG.WriteToDirAnalysisLog("Bad Directories: " + iBadDir.ToString, False)
        LOG.WriteToDirAnalysisLog("Bad Files: " + iBadCnt.ToString, False)
        LOG.WriteToDirAnalysisLog("Skipped Files: " + iSkipCnt.ToString, False)

        MessageBox.Show(Msg)
    End Sub

    Sub BeginContentArchive(PerformQuickArchive As Boolean)

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If


        DBLocal.getUseLastArchiveDateActive()
        DBLocal.setUseLastArchiveDateActive()
        setLastArchiveLabel()

        Try
            If ckDisable.Checked Then
                LOG.WriteToArchiveLog("DISABLE ALL is checked - no archive allowed.")
                SB.Text = "DISABLE ALL is checked - no archive allowed."
                Return
            End If

            If ckDisableContentArchive.Checked Then
                LOG.WriteToArchiveLog("DISABLE Content Archive is checked - no archive allowed.")
                SB.Text = "DISABLE Content Archive is checked - no archive allowed."
                Return
            End If

            If ContentThread.IsBusy Then
                Return
            End If

            Try
                SB.Text = "Quick CONTENT ARCHIVE LAUNCHED"
                '****************** Execute PerformContentArchive() on a separate thread **********************************
                If Not PerformQuickArchive Then
                    SB.Text = "Full Inventory ARCHIVE LAUNCHED"
                    ResetSqlite()
                End If
                '**********************************************************************************************************
                gAutoExecContentComplete = False
                PerformContentArchive()
                gAutoExecContentComplete = True
                'ContentThread.RunWorkerAsync()
                '**********************************************************************************************************
            Catch ex As ThreadAbortException
                LOG.WriteToArchiveLog("Thread 885 - caught ThreadAbortException - resetting.")
                Thread.ResetAbort()
            Catch ex As Exception
                LOG.WriteToArchiveLog("Thread 888: " + ex.Message)
                SB.Text = ex.Message
            End Try
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 886 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            LOG.WriteToArchiveLog("Thread 887: " + ex.Message)
        End Try

    End Sub

    Private Sub ReapplyALLDBUpdatesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ReapplyALLDBUpdatesToolStripMenuItem.Click

        Dim msg As String = "This will reapply all database updates that might be missing, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "DB Updates", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        DBARCH.ZeroizeDBUpdate()
        SB.Text = "Applying any needed updates, standby..."
        ApplyDDUpdates()
        SB.Text = "Updates reapplied..."

        MessageBox.Show("Updates complete...")

    End Sub

    Private Sub CreateSQLiteDBToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CreateSQLiteDBToolStripMenuItem.Click

        Dim NewDB As String = "c:\temp\TestSQLite.db"
        Dim sqlite_conn As SQLiteConnection

        If Not Directory.Exists("c:\temp") Then
            Directory.CreateDirectory("C:\temp")
        End If

        If File.Exists(NewDB) Then
            File.Delete(NewDB)
        End If

        sqlite_conn = New SQLiteConnection("Data Source=" + NewDB)
        sqlite_conn.Open()

        If File.Exists(NewDB) Then
            MessageBox.Show("Success: " + NewDB + ", created")
        Else
            MessageBox.Show("Failure: " + NewDB + ", failed to create")
        End If

    End Sub

    Private Sub CanLongFilenamesBeTurnedOnToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CanLongFilenamesBeTurnedOnToolStripMenuItem.Click
        Dim isLongFileNamesAvail As Boolean = UTIL.isLongFileNamesAvail
        If isLongFileNamesAvail Then
            MessageBox.Show("This operating system can use Long File names")
        Else
            MessageBox.Show("This operating system can NOT use Long File names")
        End If
    End Sub

    Private Sub TurnONLongFilenamesAdminNeededToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles TurnONLongFilenamesAdminNeededToolStripMenuItem.Click

        Clipboard.Clear()
        Clipboard.SetText("reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /t REG_SZ /v LongPathsEnabled /d 1 /f")
        MessageBox.Show("This Command is in the clipboard." + vbCrLf + "Execute this command from a command prompt as an Administrator" + vbCrLf + vbCrLf + "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /t REG_SZ /v LongPathsEnabled /d 1 /f")

    End Sub

    Private Sub HowToTurnOnLongFilenamesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles HowToTurnOnLongFilenamesToolStripMenuItem.Click

        Dim S As String = ""
        S += "In the past the maximum supported file length was 260 characters (256 usable after the drive characters And termination character). In Windows 10 long file name support can be enabled which allows file names up to 32,767 characters (although you lose a few characters for mandatory characters that are part of the name). To enable this perform the following:" + vbCrLf
        S += vbCrLf
        S += "Start the registry editor (regedit.exe)" + vbCrLf
        S += "Navigate to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" + vbCrLf
        S += "Double Click LongPathsEnabled" + vbCrLf
        S += "Set to 1 And click OK" + vbCrLf
        S += "Reboot" + vbCrLf + vbCrLf
        S += "This can also be enabled via Group Policy via Computer Configuration > Administrative Templates > System > Filesystem > Enable NTFS long paths."
        S += vbCrLf
        S += vbCrLf
        S += "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /t REG_SZ /v LongPathsEnabled /d 1 /f"
        S += vbCrLf
        S += vbCrLf
        S += "This Text has been placed into the clipboard in case you wish to run from the command line as an Administrator"

        Clipboard.Clear()
        Clipboard.SetText(S)

        MessageBox.Show(S)

    End Sub

    Private Sub CheckForViolationsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CheckForViolationsToolStripMenuItem.Click
        If ThreadSetNameHash.IsBusy Then
            SB.Text = "ABORTING, ALREADY EXECUTING..."
            Return
        End If
        Try
            ThreadSetNameHash.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try
    End Sub

    Private Sub FileNamesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FileNamesToolStripMenuItem.Click

    End Sub

    Private Sub LongFilenamesOnOrOFFToolStripMenuItem_Click(sender As Object, e As EventArgs)
        Dim txt As String = My.Computer.Registry.GetValue("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem", "LongPathsEnabled", "")
        MessageBox.Show("Current Value in Registry: " + txt)
    End Sub

    Private Sub LongFilenameHASHToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles LongFilenameHASHToolStripMenuItem.Click

        Dim tgtfqn As String = "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\Documentation\RoleEligibilityTracking-Chad.doc"
        Dim CALCHASH As String = ""
        Dim ENCCHASH As String = ""
        Dim dirs As New Dictionary(Of String, String)
        'C:\DEV\ECM2020\ARCHIVER\Z7\LICENSE.TXT
        dirs = DBARCH.getDSFQN("10", tgtfqn)

        For Each xhash As String In dirs.Keys
            tgtfqn = dirs(xhash).ToUpper
            ENCCHASH = ENC.SHA512SqlServerHash(tgtfqn)
            CALCHASH = DBARCH.getSqlServerHASH(tgtfqn)
            If CALCHASH.ToUpper <> xhash.ToUpper Then
                Console.WriteLine(tgtfqn)
                Console.WriteLine("SQL Server Hash: " + xhash)
                Console.WriteLine("Local Hash: " + CALCHASH)
                Console.WriteLine("---")
            End If
        Next


    End Sub

    Private Sub ValidateLongDirectroryNamesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ValidateLongDirectroryNamesToolStripMenuItem.Click
        If ThreadSetNameHash.IsBusy Then
            SB.Text = "ABORTING, ALREADY EXECUTING..."
            Return
        End If
        Try
            ThreadSetNameHash.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try
        'DBARCH.setDSFQN()
    End Sub

    Private Sub TextStringHashToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles TextStringHashToolStripMenuItem.Click
        Dim DirName As String = "C:\dev\Ecm2020"

        Dim Hash1 As String = ""
        Dim Hash2 As String = ""

        DirName = DirName.ToUpper

        Hash1 = DBARCH.getSqlServerHASH(DirName)
        Hash2 = ENC.SHA512SqlServerHash(DirName)

        Console.WriteLine(Hash1)
        Console.WriteLine(Hash2)

        Console.WriteLine("DONE...")

    End Sub

    Private Sub ThreadSetNameHash_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles ThreadSetNameHash.DoWork
        DBARCH.setDSFQN()
        MessageBox.Show("Analysis of long file names complete...")
    End Sub

    Private Sub ValidateLongDirectroryNamesToolStripMenuItem1_Click(sender As Object, e As EventArgs)
        If ThreadSetNameHash.IsBusy Then
            SB.Text = "ABORTING, ALREADY EXECUTING..."
            Return
        End If
        Try
            ThreadSetNameHash.RunWorkerAsync()
        Catch ex As ThreadAbortException
            LOG.WriteToArchiveLog("Thread 100A - caught ThreadSetNameHash - resetting.")
            Thread.ResetAbort()
        Catch ex As Exception
            SB.Text = ex.Message
            Dim st As New StackTrace(True)
            st = New StackTrace(ex, True)
            LOG.WriteToArchiveLog("Line: " & st.GetFrame(0).GetFileLineNumber().ToString)
        End Try

    End Sub

    Private Sub ValidateFileHASHCodesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ValidateFileHASHCodesToolStripMenuItem.Click
        DBARCH.validateFileHash()
        MessageBox.Show("File Hash validation complete...")
    End Sub

    Private Sub CheckBox2_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox2.CheckedChanged
        If lbArchiveDirs.SelectedItems.Count.Equals(0) Then
            MessageBox.Show("To use this, one and only one directory must be selected, returning")
            Return
        End If
        If lbArchiveDirs.SelectedItems.Count > 1 Then
            MessageBox.Show("To use this, one and only one directory must be selected - Please use the Utility Listener item to process multiple listeners, returning")
            Return
        End If
        CheckBox2.Checked = False
        ProcessListener(False)
        MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ")
    End Sub

    Private Sub ValidateProcessAsFileExtsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ValidateProcessAsFileExtsToolStripMenuItem.Click
        DBARCH.RebuildCrossIndexFileTypes()
    End Sub

    Private Sub LinkLabel2_LinkClicked(sender As Object, e As LinkLabelLinkClickedEventArgs) Handles LinkLabel2.LinkClicked
        MessageBox.Show("NOT Operable at this time...")
    End Sub

    Private Sub ManualEditListenerConfigToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ManualEditListenerConfigToolStripMenuItem.Click
        Dim DirsToMonitor As String = System.Configuration.ConfigurationManager.AppSettings("DirsToMonitor")
        System.Diagnostics.Process.Start("notepad.exe", DirsToMonitor)
    End Sub

    Private Sub ContentNoLIstenerToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ContentNoLIstenerToolStripMenuItem.Click

        Dim watch As Stopwatch = Stopwatch.StartNew()
        TempDisableDirListener = True
        Dim PerformQUickArchive As Boolean = False
        BeginContentArchive(PerformQUickArchive)
        TempDisableDirListener = False
        watch.Stop()
        Dim totsecs As Decimal = 0
        totsecs = watch.Elapsed.TotalSeconds
        LOG.WriteToArchiveLog("*** TOTAL TIME FOR FULL SCAN Archive: " + totsecs.ToString + " Seconds")

    End Sub

    Private Sub ValidateRetentionDatesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ValidateRetentionDatesToolStripMenuItem.Click
        SB.Text = "Verifying Retention Dates"
        DBARCH.spUpdateRetention()
        SB.Text = "Retention Dates VERIFIED"
        MessageBox.Show("Retention Dates VERIFIED")
    End Sub

    Private Sub FulltextLogAnalysisToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FulltextLogAnalysisToolStripMenuItem.Click
        frmFti.Show()
    End Sub

    Private Sub UpdateAvailableIFiltersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles UpdateAvailableIFiltersToolStripMenuItem.Click
        'spAddAvailExtensions
        DBARCH.ExecSP("spAddAvailExtensions")
        MessageBox.Show("Filters updated...")
    End Sub

    Private Sub ReInventoryAllFilesToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ReInventoryAllFilesToolStripMenuItem.Click
        DBLocal.ReInventory()
    End Sub

    Private Sub GetDirFilesByFilterToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles GetDirFilesByFilterToolStripMenuItem.Click
        'Dim sFiles() As String = Directory.GetFiles("c:\dev\Ecm2020", "*.pdf|*.xlsx|*.xls|*.docx|*.doc|*.txt", SearchOption.AllDirectories)
        Dim I As Integer = 0
        Try

            Console.WriteLine("START: ")
            Console.WriteLine(Now)

            Dim FileFilter As String = (".txt,.doc,.docx,*.pdf,")
            Dim DirName As String = "c:\temp"

            If Not Directory.Exists("c:\temp") Then
                MessageBox.Show("Directory C:\temp does not exist and this test is designed to run against that one only... returning.")
                Return
            End If

            DI = New DirectoryInfo(DirName)

            For Each FI As FileInfo In DI.GetFiles("*.*", SearchOption.AllDirectories)
                If FileFilter.Contains(FI.Extension) Then
                    I += 1
                End If
            Next
            Dim msg As String = ""
            msg = ("Number Of Files Found: " + I.ToString()) + Environment.NewLine

            Console.WriteLine("Number Of Files: " + I.ToString())
            Console.WriteLine("END: ")
            Console.WriteLine(Now)

        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try

        MessageBox.Show("Number Of Files: " + I.ToString())
    End Sub

    Private Sub GenWhereINDictToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles GenWhereINDictToolStripMenuItem.Click
        Dim tDict As New Dictionary(Of String, String)
        tDict = DBARCH.getIncludedFileTypeWhereIn(gCurrLoginID)
        For Each str As String In tDict.Keys()
            Console.WriteLine("DIR:" + str + "  WhereIN: " + tDict(str))
        Next

    End Sub

    Private Sub Label13_Click(sender As Object, e As EventArgs) Handles Label13.Click


    End Sub

    Private Sub btnSetLastArchiveON_Click(sender As Object, e As EventArgs) Handles btnSetLastArchiveON.Click
        DBLocal.TurnOnUseLastArchiveDateActive()
        If gUseLastArchiveDate.Equals("1") Then
            lblUseLastArchiveDate.Text = "Last Arch ON"
        Else
            lblUseLastArchiveDate.Text = "Last Arch OFF"
        End If
        DBLocal.getUseLastArchiveDateActive()
        setLastArchiveLabel()
    End Sub

    Private Sub btnSetLastArchiveOFF_Click(sender As Object, e As EventArgs) Handles btnSetLastArchiveOFF.Click
        DBLocal.TurnOffUseLastArchiveDateActive()
        If gUseLastArchiveDate.Equals("1") Then
            lblUseLastArchiveDate.Text = "Last Arch ON"
        Else
            lblUseLastArchiveDate.Text = "Last Arch OFF"
        End If
        DBLocal.getUseLastArchiveDateActive()
        setLastArchiveLabel()
    End Sub

    Private Sub TurnONToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles TurnONToolStripMenuItem.Click
        DBLocal.TurnOnUseLastArchiveDateActive()
        If gUseLastArchiveDate.Equals("1") Then
            lblUseLastArchiveDate.Text = "Last Arch ON"
        Else
            lblUseLastArchiveDate.Text = "Last Arch OFF"
        End If
        DBLocal.getUseLastArchiveDateActive()
        setLastArchiveLabel()
    End Sub

    Private Sub TurnOFFToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles TurnOFFToolStripMenuItem.Click
        DBLocal.TurnOffUseLastArchiveDateActive()
        If gUseLastArchiveDate.Equals("1") Then
            lblUseLastArchiveDate.Text = "Last Arch ON"
        Else
            lblUseLastArchiveDate.Text = "Last Arch OFF"
        End If
        DBLocal.getUseLastArchiveDateActive()
        setLastArchiveLabel()
    End Sub


    Private Sub TurnListenerONToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles TurnListenerONToolStripMenuItem.Click
        ProcessListener(True)
        getListeners()
        MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ")
    End Sub

    Private Sub TurnListenerOFFToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles TurnListenerOFFToolStripMenuItem.Click
        ProcessListener(False)
        getListeners()
        MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ")
    End Sub

    Private Sub InitializeToGivenDateToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles InitializeToGivenDateToolStripMenuItem.Click
        Dim Message, Title, xDefault, MyValue
        Message = "Enter a Date in the form of MM/DD/YYYY"    ' Set prompt.
        Title = "Initialze Last Archive Date"    ' Set title.
        Dim MO As String = Now.Month.ToString
        Dim DA As String = Now.Day.ToString
        Dim YR As String = Now.Year.ToString

        If MO.Length.Equals(1) Then
            MO = "0" + MO
        End If
        If DA.Length.Equals(1) Then
            DA = "0" + DA
        End If

        xDefault = MO + "/" + DA + "/" + YR
        MyValue = InputBox(Message, Title, xDefault)

        If IsDate(MyValue) Then
            DBLocal.InitUseLastArchiveDateActive(MyValue)
            MessageBox.Show(MyValue + " Last Archive date set to: " + MyValue)
        Else
            MessageBox.Show(MyValue + " does not appear to be a valid date, returning.")
        End If

        DBLocal.getUseLastArchiveDateActive()
        setLastArchiveLabel()

    End Sub

    Private Sub ValidateRepoContentsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ValidateRepoContentsToolStripMenuItem.Click

        Dim msg As String = "This process can be very time consuming as few minutes or a few dyas, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Verify ALL Files in Repo", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim watch As Stopwatch = Stopwatch.StartNew()

        SB.Text = "CONTENT ARCHIVE LAUNCHED - Full ReInventory"
        TempDisableDirListener = True
        '------------------------------------------------
        Dim CurrUseDirectoryListener As Int32 = UseDirectoryListener
        UseDirectoryListener = 0
        DBLocal.getUseLastArchiveDateActive()
        Dim CurrUseLastArchiveDate As String = gUseLastArchiveDate
        gUseLastArchiveDate = "N"
        ResetSqlite()
        '***************************************************************
        BeginContentArchive(True)
        TempDisableDirListener = False
        '***************************************************************
        gUseLastArchiveDate = CurrUseLastArchiveDate
        UseDirectoryListener = CurrUseDirectoryListener
        '------------------------------------------------
        TempDisableDirListener = False
        SB.Text = "CONTENT ARCHIVE COMPLETED"

        watch.Stop()
        Dim totsecs As Decimal = 0
        totsecs = watch.Elapsed.TotalSeconds
        LOG.WriteToArchiveLog("*** TOTAL TIME FOR FULL INVENTORY: " + totsecs.ToString + " Seconds")


    End Sub

    Private Sub ArchiveToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ArchiveToolStripMenuItem.Click

    End Sub

    Private Sub ListenerONALLDirsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ListenerONALLDirsToolStripMenuItem.Click
        Try
            Dim I As Int32 = 0
            For I = 0 To lbArchiveDirs.Items.Count - 1
                lbActiveFolder.SetSelected(I, True)
                ProcessListener(True)
                lbActiveFolder.SetSelected(I, False)
            Next i
        Catch ex As Exception
            Console.WriteLine("ERROR: " + ex.Message)
        End Try
        MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ")
    End Sub

    Private Sub ListenerOFFALLDirsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ListenerOFFALLDirsToolStripMenuItem.Click
        Try
            Dim I As Int32 = 0
            For I = 0 To lbArchiveDirs.Items.Count - 1
                lbActiveFolder.SetSelected(I, True)
                ProcessListener(False)
                lbActiveFolder.SetSelected(I, False)
            Next I
        Catch ex As Exception
            Console.WriteLine("ERROR: " + ex.Message)
        End Try

        MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ")
    End Sub

    Private Sub NetworkListenerToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles NetworkListenerToolStripMenuItem.Click
        FrmListenerTest.Show()
    End Sub

    Private Sub SQLiteDBConnectToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles SQLiteDBConnectToolStripMenuItem.Click

        Dim dlg As New FolderBrowserDialog
        Dim slDatabase As String = ""
        Dim SQLiteCONN As New SQLiteConnection()
        Dim result As DialogResult = OpenFileDialog1.ShowDialog()

        If result = Windows.Forms.DialogResult.OK Then
            slDatabase = OpenFileDialog1.FileName
        End If

        If slDatabase.Length.Equals(0) Then
            MessageBox.Show("Cancelled, returning.")
            Return
        End If


        Try
            If Not File.Exists(slDatabase) Then
                MessageBox.Show("SQLite DB MISSING: " + slDatabase)
                Return
            End If

            cs = "data source=" + slDatabase
            gLocalDBCS = cs
            SQLiteCONN.ConnectionString = cs
            SQLiteCONN.Open()
            MessageBox.Show("SQLite Connected!!")
        Catch ex As Exception
            Dim LG As New clsLogging
            MessageBox.Show("ERROR LOCALDB setSLConn: " + ex.Message)
        End Try

    End Sub
End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_RssPull

    <System.Runtime.Serialization.DataMember()>
    Public RssName As String

    <System.Runtime.Serialization.DataMember()>
    Public RssUrl As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_WebSite

    <System.Runtime.Serialization.DataMember()>
    Public WebSite As String

    <System.Runtime.Serialization.DataMember()>
    Public WebUrl As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

    <System.Runtime.Serialization.DataMember()>
    Public depth As Integer

    <System.Runtime.Serialization.DataMember()>
    Public width As Integer

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_WebScreen

    <System.Runtime.Serialization.DataMember()>
    Public WebScreen As String

    <System.Runtime.Serialization.DataMember()>
    Public WebUrl As String

    <System.Runtime.Serialization.DataMember()>
    Public UserID As String

End Class

Public Class DS_Content
    Public RowGuid As String = ""
    Public SourceGuid As String = ""
    Public CreateDate As String = ""
    Public SourceName As String = ""
    Public SourceImage As Byte() = Nothing
    Public SourceTypeCode As String = ""
    Public FQN As String = ""
    Public VersionNbr As String = ""
    Public LastAccessDate As String = ""
    Public FileLength As String = ""
    Public LastWriteTime As String = ""
    Public UserID As String = ""
    Public DataSourceOwnerUserID As String = ""
    Public isPublic As String = ""
    Public FileDirectory As String = ""
    Public OriginalFileType As String = ""
    Public RetentionExpirationDate As String = ""
    Public IsPublicPreviousState As String = ""
    Public isAvailable As String = ""
    Public isContainedWithinZipFile As String = ""
    Public IsZipFile As String = ""
    Public DataVerified As String = ""
    Public ZipFileGuid As String = ""
    Public ZipFileFQN As String = ""
    Public Description As String = ""
    Public KeyWords As String = ""
    Public Notes As String = ""
    Public isPerm As String = ""
    Public isMaster As String = ""
    Public CreationDate As String = ""
    Public OcrPerformed As String = ""
    Public isGraphic As String = ""
    Public GraphicContainsText As String = ""
    Public OcrText As String = ""
    Public ImageHiddenText As String = ""
    Public isWebPage As String = ""
    Public ParentGuid As String = ""
    Public RetentionCode As String = ""
    Public MachineID As String = ""
    Public CRC As String = ""
    Public ImageHash As String = ""
    Public SharePoint As String = ""
    Public SharePointDoc As String = ""
    Public SharePointList As String = ""
    Public SharePointListItem As String = ""
    Public StructuredData As String = ""
    Public HiveConnectionName As String = ""
    Public HiveActive As String = ""
    Public RepoSvrName As String = ""
    Public RowCreationDate As String = ""
    Public RowLastModDate As String = ""
    Public ContainedWithin As String = ""
    Public RecLen As String = ""
    Public RecHash As String = ""
    Public OriginalSize As String = ""
    Public CompressedSize As String = ""
    Public txStartTime As String = ""
    Public txEndTime As String = ""
    Public txTotalTime As String = ""
    Public TransmitTime As String = ""
    Public FileAttached As String = ""
    Public BPS As String = ""
    Public RepoName As String = ""
    Public HashFile As String = ""
    Public HashName As String = ""
    Public OcrSuccessful As String = ""
    Public OcrPending As String = ""
    Public PdfIsSearchable As String = ""
    Public PdfOcrRequired As String = ""
    Public PdfOcrSuccess As String = ""
    Public PdfOcrTextExtracted As String = ""
    Public PdfPages As String = ""
    Public PdfImages As String = ""
    Public RequireOcr As String = ""
    Public RssLinkFlg As String = ""
    Public RssLinkGuid As String = ""
    Public PageURL As String = ""
    Public RetentionDate As String = ""
    Public URLHash As String = ""
    Public WebPagePublishDate As String = ""
    Public SapData As String = ""
    Public RowID As String = ""
End Class

Public Class DS_Email
    Public EmailGuid As String = ""
    Public SUBJECT As String = ""
    Public SentTO As String = ""
    Public Body As String = ""
    Public Bcc As String = ""
    Public BillingInformation As String = ""
    Public CC As String = ""
    Public Companies As String = ""
    Public CreationTime As String = ""
    Public ReadReceiptRequested As String = ""
    Public ReceivedByName As String = ""
    Public ReceivedTime As String = ""
    Public AllRecipients As String = ""
    Public UserID As String = ""
    Public SenderEmailAddress As String = ""
    Public SenderName As String = ""
    Public Sensitivity As String = ""
    Public SentOn As String = ""
    Public MsgSize As String = ""
    Public DeferredDeliveryTime As String = ""
    Public EntryID As String = ""
    Public ExpiryTime As String = ""
    Public LastModificationTime As String = ""
    Public EmailImage As Byte() = Nothing
    Public Accounts As String = ""
    Public ShortSubj As String = ""
    Public SourceTypeCode As String = ""
    Public OriginalFolder As String = ""
    Public StoreID As String = ""
    Public isPublic As String = ""
    Public RetentionExpirationDate As String = ""
    Public IsPublicPreviousState As String = ""
    Public isAvailable As String = ""
    Public CurrMailFolderID As String = ""
    Public isPerm As String = ""
    Public isMaster As String = ""
    Public CreationDate As String = ""
    Public NbrAttachments As String = ""
    Public CRC As String = ""
    Public ImageHash As String = ""
    Public Description As String = ""
    Public KeyWords As String = ""
    Public RetentionCode As String = ""
    Public EmailIdentifier As String = ""
    Public ConvertEmlToMSG As String = ""
    Public HiveConnectionName As String = ""
    Public HiveActive As String = ""
    Public RepoSvrName As String = ""
    Public RowCreationDate As String = ""
    Public RowLastModDate As String = ""
    Public UIDL As String = ""
    Public RecLen As String = ""
    Public RecHash As String = ""
    Public OriginalSize As String = ""
    Public CompressedSize As String = ""
    Public txStartTime As String = ""
    Public txEndTime As String = ""
    Public txTotalTime As String = ""
    Public TransmitTime As String = ""
    Public FileAttached As String = ""
    Public BPS As String = ""
    Public RepoName As String = ""
    Public HashFile As String = ""
    Public HashName As String = ""
    Public ContainsAttachment As String = ""
    Public NbrAttachment As String = ""
    Public NbrZipFiles As String = ""
    Public NbrZipFilesCnt As String = ""
    Public PdfIsSearchable As String = ""
    Public PdfOcrRequired As String = ""
    Public PdfOcrSuccess As String = ""
    Public PdfOcrTextExtracted As String = ""
    Public PdfPages As String = ""
    Public PdfImages As String = ""
    Public MachineID As String = ""
    Public notes As String = ""
    Public NbrOccurances As String = ""
    Public RowID As String = ""
    Public RowGuid As String = ""
End Class