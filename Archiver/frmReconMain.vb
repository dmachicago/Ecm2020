#Const RemoteOcr = 0

Imports System.Deployment.Application
Imports System.Reflection
Imports System.Web
Imports System.Collections
Imports System.Collections.Specialized
Imports System.Data.SqlServerCe

#Const EnableSingleSource = 0

Imports System.Security.Principal
Imports System.IO
Imports System.Threading

Imports Microsoft.SqlServer

Imports Microsoft.VisualBasic
Imports System.Security.Permissions
Imports Microsoft.Win32


Public Class frmReconMain

    Dim Proxy As New SVCCLCArchive.Service1Client
    Dim ProxyFS As New SvcFS.Service1Client
    Dim VerifyEmbeddedZipFiles As String = ""
    Dim SkipPermission As Boolean = False
    Dim LocalDBBackUpComplete As Boolean = False

    Dim bUseRemoteServer As Boolean = False
    Dim MachineIDcurr As String = ""
    Dim UIDcurr As String = ""
    Dim ArgsPassedIn As Boolean = False
    Dim gbEmailWidth As Integer = 0

    Dim args As String() = Nothing
    Dim SI As New clsSAVEDITEMS
    Dim LoginAsNewUser As Boolean = False

    Dim ISO As New clsIsolatedStorage
    Dim DBLocal As New clsDbLocal
    Dim REG As New clsRegistry
    Dim LM As New clsLicenseMgt
    Dim AssignedLibraries As New List(Of String)
    Dim ArchiveActive As Boolean = False
    Dim ActivityThread As Thread
    Dim t2 As Thread
    Dim t3 As Thread
    Dim t4 As Thread
    Dim t5 As Thread
    Dim t6 As Thread
    Dim t7 As Thread
    Dim t8 As Thread
    Dim t As Thread

    Dim UseThreads As Boolean = True

    Public ThreadCnt As Integer = 0
    Dim MiniArchiveRunning As Boolean = False
    Dim ListenersDefined As Boolean = False
    Dim ListenForChanges As Boolean = False
    Dim ListenDirectory As Boolean = False
    Dim ListenSubDirectory As Boolean = False
    Dim DirGuid As String = ""


    Dim MachineName$ = Environment.MachineName.ToString

    Dim FoldersRefreshed As Boolean = False
    Dim AllEmailFoldersShowing As Boolean = False
    Dim bApplyingDirParms As Boolean = False
    Dim bSingleInstanceContent As Boolean = False
    Dim bAddThisFileAsNewVersion As Boolean = False

    Dim NbrFilesInDir As Integer = 0

    Dim ParentFolder$ = ""
    Dim FQNFolder$ = ""
    Dim bActiveChange As Boolean = False
    Dim isOutlookAvail As Boolean = False

    Public EmailsBackedUp As Integer = 0
    Public EmailsSkipped As Integer = 0
    Public FilesBackedUp As Integer = 0
    Public FilesSkipped As Integer = 0

    Dim CurrentDirectory$ = ""

    Dim ImageSizeDouble As Double = 0
    Dim ImageGuid$ = ""

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
    Dim ENC As New clsEncrypt

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    'Dim KAT As New clsChilKat

    Dim CMODI As New clsModi

    'Public gCurrUserGuidID = ""
    Public CurrIdentity$ = ""
    Dim formloaded As Boolean = False

    Dim bUseAttachData As Boolean = False
    Dim CompanyID As String = ""
    Dim RepoID As String = ""

    Dim DOCS As New clsDATASOURCE_V2
    Dim AVL As New clsAVAILFILETYPES
    Dim DBASES As New clsDATABASES
    Dim EMPARMS As New clsEMAILARCHPARMS
    Dim EMF As New clsEMAILFOLDER
    Dim EXL As New clsEXCLUDEDFILES
    Dim INL As New clsINCLUDEDFILES
    Dim RUSER As New clsReconUSERS
    Dim DB As New clsDatabase
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

    'Dim Proxy As New SVCCLCArchive.Service1Client


    'Sub New()
    '    ' This call is required by the Windows Form Designer.
    '    InitializeComponent()

    '    ' Add any initialization after the InitializeComponent() call.


    'End Sub

    'Private Sub frmReconMain_Activated(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Activated

    '    Dim ClientOnly$ = System.Configuration.ConfigurationManager.AppSettings("ClientOnly")

    '    Dim iClient As Integer = CInt(ClientOnly)
    '    If iClient = 1 Then
    '        Me.Visible = False
    '        ckDisable.Checked = True
    '        cbInterval.Text = "Disable"

    '        saveStartUpParms()
    '        Return
    '    End If

    '    GetLocation(Me)
    '    LOG.WriteToArchiveFileTraceLog("", True)

    '    Dim S$ = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] " ' where ProfileName = 'XX'"
    '    DB.PopulateComboBox(cbProfile, "ProfileName", S)

    'End Sub

    ''' <summary>
    ''' Initializes a new instance of the <see cref="frmReconMain" /> class.
    ''' </summary>
    Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

        If My.Settings("UpgradeSettings") = True Then
            Try
                LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 100")
                My.Settings.Upgrade()
                My.Settings.Reload()
                My.Settings("UpgradeSettings") = False
                My.Settings.Save()
                LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 200: " + My.Settings("UserDefaultConnString"))
                LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 300: " + My.Settings("UserThesaurusConnString"))

                DBLocal.RestorepDirTbl()
                DBLocal.RestorepFileTbl()
                DBLocal.RestorepInventoryTbl()

            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: INSTALL 100: " + ex.Message)
            End Try
        End If

        Dim strUseRemoteServer As String = System.Configuration.ConfigurationManager.AppSettings("UseRemoteServer")
        If strUseRemoteServer.Equals("1") Then
            bUseRemoteServer = True
        Else
            bUseRemoteServer = False
        End If

        ExitToolStripMenuItem.Visible = True

        Try
            VerifyEmbeddedZipFiles = System.Configuration.ConfigurationManager.AppSettings("VerifyEmbeddedZipFiles")
        Catch ex As Exception
            VerifyEmbeddedZipFiles = "0"
        End Try


        gMachineID = LOG.getEnvVarMachineName

        DBLocal.cleanZipFiles()

        UTIL.cleanTempWorkingDir()


    End Sub

    Private Sub frmReconMain_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing

        UTIL.cleanTempWorkingDir()

        Try
            GC.Collect()
        Catch ex As Exception
            MessageBox.Show("ERROR Closing: " + ex.Message)
        End Try


    End Sub

    Private Sub frmReconMain_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim ContentOnly As Boolean = False
        Dim OutlookOnly As Boolean = False
        Dim ExchangeOnly As Boolean = False
        Dim ArchiveALL As Boolean = False

        Dim LL As Double = 0
        Dim CurrUserGuidID As String = ""
        MachineIDcurr = DMA.GetCurrMachineName

        Dim CurrentLoginID As String = System.Environment.UserName

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
                    : LL = 69
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
                    : LL = 149
                    If Arg.ToUpper.Equals("?") Then
                        Dim MSG$ = "" : LL = 151
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

            gCurrentConnectionString = "" : LL = 166.1
            Try
                CompanyID = REG.ReadEcmRegistrySubKey("CompanyID") : LL = 167.2
            Catch ex As Exception
                CompanyID = "" : LL = 167.21
            End Try
            Try
                RepoID = REG.ReadEcmRegistrySubKey("RepoID") : LL = 168.3
            Catch ex As Exception
                RepoID = "" : LL = 168.31
            End Try

            'gCurrentConnectionString = REG.ReadEcmRegistrySubKey("EncConnectionString")
            If CompanyID Is Nothing Then : LL = 168.31
                CompanyID = " " : LL = 168.32
            End If
            If RepoID Is Nothing Then : LL = 168.33
                RepoID = " " : LL = 168.34
            End If
            LL = 168.35
            If CompanyID.Trim.Length > 0 And RepoID.Trim.Length > 0 Then
                LL = 165.4
                Dim ProxyAttach As New SVCGateway.Service1Client : LL = 165.5
                Dim EncCS As String = ""
                Dim RC As Boolean = False
                Dim RetMsg As String = "" : LL = 165.6
                EncCS = ProxyAttach.getConnection(CompanyID, RepoID, RC, RetMsg) : LL = 165.7
                If EncCS.Trim.Length > 0 Then
                    : LL = 165.7
                    Try
                        gCurrentConnectionString = ENC.AES256DecryptString(EncCS) : LL = 165.8
                    Catch ex As Exception
                        gCurrentConnectionString = EncCS : LL = 165.8
                    End Try
                    If gCurrentConnectionString.Length > 0 Then
                        Dim bReg As Boolean = REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS) : LL = 165.9
                        If Not bReg Then : LL = 165.1
                            bReg = REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS) : LL = 165.11
                        End If : LL = 165.12
                    End If
                Else
                    : LL = 165.13
                    gCurrentConnectionString = ""
                    : LL = 165.14
                End If
                : LL = 165.15
                ProxyAttach = Nothing
                bUseAttachData = True
                : LL = 165.16
            Else : LL = 165.17
                bUseAttachData = False
                : LL = 165.18
            End If
            : LL = 165.19
            'bUseAttachData = ISO.ReadAttachData(CompanyID, RepoID)

            Dim defaultUserId As String = My.Settings.DefaultLoginID : LL = 165.2
            If defaultUserId.Trim.Length > 0 Then : LL = 165.3
                CurrentLoginID = defaultUserId : LL = 165.4
                Dim EPW As String = My.Settings.DefaultLoginPW : LL = 165.5
                EPW = ENC.AES256DecryptString(EPW) : LL = 165.6
            End If : LL = 165.7

            Dim bDbConnectionGood = DB.ckDbConnection("frmReconMain 100") : LL = 200.1

            If bDbConnectionGood = False Then : LL = 201.2
                If gRunUnattended = True Then : LL = 202.1
                    LOG.WriteToArchiveLog("ABORTING frmReconMain_Load run - Failed to connect to the database, closing ECM.") : LL = 203.1
                    Application.Exit()
                Else : LL = 204.1
                    Dim ConnStr As String = DB.getConnStr
                    MessageBox.Show("ABORTING - Failed to connect to the database, contact an administrator - closing ECM." + vbCrLf + ConnStr) : LL = 205.1
                    Application.Exit()
                End If
                tsTunnelConn.Text = "Tunnel:OFF"
            Else
                tsTunnelConn.Text = "Tunnel:ON"
            End If : LL = 213.15

            Dim bWebDbConn As Boolean = Proxy.ckDbConnection(CurrentLoginID, MachineIDcurr)
            LL = 213.2
            If bWebDbConn Then
                LL = 213.3
                tsServiceDBConnState.Text = "SaaS:ON"
            Else
                LL = 213.4
                tsServiceDBConnState.Text = "SaaS:OFF"
                MessageBox.Show("Could not attach to SaaS - closing the application.")
                Application.Exit()
            End If
            LL = 213.5
            ImpersonateLoginToolStripMenuItem.Visible = False

            Dim iRunningInstances As Integer = 0 : LL = 213.6
            iRunningInstances = UTIL.countApplicationInstances("ECMARCHIVESETUP") : LL = LL = 213.7
            If iRunningInstances > 2 Then : LL = 213.8
                frmMsg.txtMsg.Text = "ECM Archiver already running - closing." : LL = 213.9
                frmMsg.Show()
                Thread.Sleep(10000)
                End
            End If
            LL = 213.11
            Dim PrevArchiverExecPath As String = ""
            Try
                REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath) : LL = 7.11
                PrevArchiverExecPath = REG.ReadEcmRegistrySubKey("EcmArchiverDir") : LL = 7.12
            Catch ex As Exception
                REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath) : LL = 9.1
            End Try

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
            : LL = 23
            Dim PrevArchiverBuildDate As String = REG.ReadEcmRegistrySubKey("EcmSetupAppCreateDate") : LL = 24
            If PrevArchiverBuildDate.Trim.Length = 0 Then : LL = 25
                REG.CreateEcmRegistrySubKey("EcmSetupAppCreateDate", CurrBuildDate.ToString) : LL = 26
            End If : LL = 27
            : LL = 28
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
            : LL = 39
            If Not CurrBuildID.Equals(PrevArchiverBuildID) Then : LL = 40
                '** Resync all scheduled archive jobs to point to the new path. : LL = 41
                Console.WriteLine("Resync archive jobs.") : LL = 42
                frmSchedule.ValidateExecPath() : LL = 43
                REG.UpdateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID) : LL = 44
            End If : LL = 45
            : LL = 46
            gContentArchiving = False : LL = 47
            gOutlookArchiving = False : LL = 48
            gExchangeArchiving = False : LL = 49
            gContactsArchiving = False
            : LL = 50
            REG.CreateEcmSubKey() : LL = 51
            REG.SetEcmSubKey() : LL = 52
            Console.WriteLine(REG.ReadEcmSubKey("")) : LL = 53
            TimerEndRun.Enabled = False : LL = 54
            'Timer1.Enabled = False : LL = 55
            TimerUploadFiles.Enabled = False : LL = 56
            TimerListeners.Enabled = False : LL = 57
            : LL = 58
            Dim B As Boolean = False : LL = 59

            If gRunMode = "X" Then : LL = 167
                Me.WindowState = FormWindowState.Minimized : LL = 168
            End If : LL = 169

            Try : LL = 171
                If My.Settings("UpgradeSettings") = True Then : LL = 172
                    Try : LL = 173
                        LOG.WriteToInstallLog("NOTICE frmReconMain: New INSTALL detected 100") : LL = 174
                        My.Settings.Upgrade() : LL = 175
                        My.Settings.Reload() : LL = 176
                        My.Settings("UpgradeSettings") = False : LL = 177
                        My.Settings.Save() : LL = 178
                        LOG.WriteToInstallLog("NOTICE: New INSTALL detected 200: " + My.Settings("UserDefaultConnString")) : LL = 179
                        LOG.WriteToInstallLog("NOTICE: New INSTALL detected 300: " + My.Settings("UserThesaurusConnString")) : LL = 180
                    Catch ex As Exception : LL = 181
                        LOG.WriteToInstallLog("ERROR: INSTALL 100: " + ex.Message) : LL = 182
                    End Try : LL = 183
                Else : LL = 184
                    LOG.WriteToInstallLog("NOTICE: NO New INSTALL 100-A") : LL = 185
                End If : LL = 186
            Catch ex As Exception : LL = 187
                Console.WriteLine("ERROR 1XA1: - " + ex.Message) : LL = 188
            End Try : LL = 189
            : LL = 190
            My.Settings("UpgradeSettings") = False : LL = 191
            My.Settings.Save() : LL = 192
            Dim strUseRemoteServer As String = System.Configuration.ConfigurationManager.AppSettings("UseRemoteServer") : LL = 193

            If strUseRemoteServer.Equals("1") Then : LL = 194
                gCurrThesaurusCS = DB.getThesaurusConnStr : LL = 195
                gCurrRepositoryCS = DB.getConnStr : LL = 196
            Else
                gCurrThesaurusCS = REG.ReadEcmCurrentConnectionString("TheasaurusCS") : LL = 197
                gCurrRepositoryCS = REG.ReadEcmCurrentConnectionString("RepositoryCS") : LL = 198
            End If

            : LL = 199
            B = DB.ckDbConnection("frmReconMain 100") : LL = 200
            If B = False Then : LL = 201
                If gRunUnattended = True Then : LL = 202
                    LOG.WriteToArchiveLog("ABORTING - Failed to connect to the database, closing ECM.") : LL = 203
                    Application.Exit()
                Else : LL = 204
                    MessageBox.Show("ABORTING - Failed to connect to the database, closing ECM.") : LL = 205
                    Application.Exit()
                End If : LL = 212
            End If : LL = 213
            : LL = 214
            '************************ : LL = 215
            SetDateFormats() : LL = 216
            '************************ : LL = 217
            : LL = 218
            Dim bLicenseExists As Boolean = DB.LicenseExists : LL = 219
            If bLicenseExists = False Then : LL = 220
                Dim msg$ = "ABORTING - A license for the product does not exist - contact an administrator. "
                MessageBox.Show(msg)
                Application.Exit()
            End If : LL = 223
            : LL = 224
            ShowMsgHeader("Standby please, fetching setup parameters.") : LL = 225
            : LL = 226
            ListenersDefined = DB.isListeningOn : LL = 227
            : LL = 228
            Dim sDebug$ = DB.getUserParm("debug_SetupScreen") : LL = 229
            : LL = 230
            If sDebug.Equals("0") Then : LL = 231
                ddebug = False : LL = 232
            Else : LL = 233
                ddebug = True : LL = 234
                LOG.WriteToArchiveLog("Starting: frmReconMain, Debug configuration is ON") : LL = 235
            End If : LL = 236
            : LL = 237
            Dim ImpersonateID As String = ""
            Dim bImpersonateID As Boolean = UTIL.isImpersonationSet(ImpersonateID)
            If bImpersonateID Then
                gCurrLoginID = ImpersonateID
                CurrentLoginID = ImpersonateID
                CurrUserGuidID = DB.getUserGuidByLoginID(ImpersonateID)
                LogIntoSystem(CurrentLoginID) : LL = 238
                gCurrLoginID = CurrentLoginID
            Else
                LogIntoSystem(gCurrLoginID) : LL = 238
            End If
            ckLicense() : LL = 240

            CurrUserGuidID = DB.getUserGuidID(CurrentLoginID) : LL = 279
            gCurrUserGuidID = CurrUserGuidID
            UIDcurr = CurrUserGuidID
            If CurrUserGuidID.Length = 0 Then
                '** This can be caused by IMPERSONATION using an unidentified user id.
                '** Start by removing impersonation.
                Dim msg$ = "The USER ID currently in use, '" + gCurrUserGuidID + "', is not identified to the database, please contact an administrator. Exiting the program."
                MessageBox.Show(msg)
                Return : LL = 243
            End If : LL = 244

            formloaded = True : LL = 246
            GetLocation(Me) : LL = 247
            formloaded = False : LL = 248
            isAdmin = DB.isAdmin(CurrUserGuidID) : LL = 250
            If HelpOn Then : LL = 252
                DB.getFormTooltips(Me, TT, True) : LL = 253
                TT.Active = True : LL = 254
                bHelpLoaded = True : LL = 255
            Else : LL = 256
                TT.Active = False : LL = 257
            End If : LL = 258
            : LL = 259

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
                CurrUserGuidID = DB.getUserGuidID(CurrentLoginID) : LL = 279
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
            Dim TgtFolder$ = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            Dim bOutlook As Boolean = UTIL.isOutLookRunning
            LL = 291
            If bOutlook = True Then
                frmOutlookNotice.Show()
            End If
            LL = 292
            setMsgHeader("Fetching outlook folder names.")
            LL = 293
            ARCH.OutlookFolderNames(TgtFolder$)
            LL = 294
            isOutlookAvail = ARCH.getCurrentOutlookFolders(TgtFolder$, CF)
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
            Dim SS As String : LL = 332
            For Each SS In CF.Keys : LL = 333
                Dim CurrName$ = SS.ToString : LL = 334
                Dim iKey As Integer = CF.IndexOfKey(CurrName) : LL = 336
                Dim CurrKey$ = CF.Item(CurrName) : LL = 337
                Dim MySql$ = "" : LL = 339
                CurrName$ = UTIL.RemoveSingleQuotes(CurrName$) : LL = 340
                ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder) : LL = 341
                MySql = "update EmailFolder set FolderID = '" + CurrKey$ + "' where FolderName = '" + CurrName$ + "' and ParentFolderName  = '" + ParentFolder + "' " : LL = 342
                Dim B1 As Boolean = DB.ExecuteSqlNewConn(MySql, False) : LL = 343
                If Not B1 Then : LL = 344
                    If ddebug Then LOG.WriteToArchiveLog("NOTICE frmReconMain:Load process 5X.1 unsuccessful.") : LL = 345
                End If : LL = 346
            Next : LL = 347
            'End If : LL = 348
            : LL = 349
            CurrIdentity$ = DB.getUserLoginByUserid(CurrUserGuidID) : LL = 350
            If CurrIdentity$.Trim.Length = 0 Then : LL = 351
                Return : LL = 352
            End If : LL = 353
            'SB.Text = "Current User: " + System.Environment.UserName : LL = 354
            SB.Text = "Current User: " + CurrIdentity$ : LL = 355
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 5 successful.") : LL = 356
            Try : LL = 357
                setMsgHeader("Setting process memory, just a moment.") : LL = 358
                ARCH.DeleteOutlookMessages(CurrUserGuidID) : LL = 359
            Catch ex As Exception : LL = 360
                LOG.WriteToArchiveLog("WARNING 2005.32.22 - call DeleteOutlookMessages failed.") : LL = 361
            End Try : LL = 362
            : LL = 363
            setMsgHeader("Initializing archive parameters, this could take a few seconds.") : LL = 364
            ckInitialData() : LL = 365
            : LL = 366
            DB.LoadAvailFileTypes(cbFileTypes) : LL = 367
            DB.LoadAvailFileTypes(cbPocessType) : LL = 368
            DB.LoadAvailFileTypes(cbAsType) : LL = 369
            DB.LoadAvailFileTypes(lbAvailExts) : LL = 370
            : LL = 371
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 6 successful.") : LL = 372
            : LL = 373
            DB.LoadRetentionCodes(cbRetention) : LL = 374
            DB.LoadRetentionCodes(cbEmailRetention) : LL = 375
            : LL = 376
            Dim IMax As Integer = 0 : LL = 377
            ARCH.getOutlookParentFolderNames(Me.cbParentFolders) : LL = 378
            If cbParentFolders.Items.Count > 0 Then : LL = 379
                IMax = cbParentFolders.Items.Count - 1 : LL = 380
                ParentFolder$ = cbParentFolders.Items(IMax).ToString : LL = 381
            Else : LL = 382
                ParentFolder$ = "Unknown" : LL = 383
            End If
            DB.GetActiveEmailFolders(ParentFolder$, lbActiveFolder, CurrUserGuidID, CF, ArchivedEmailFolders) : LL = 386
            : LL = 387
            DB.GetActiveDatabases(cbEmailDB) : LL = 388
            DB.GetActiveDatabases(cbFileDB) : LL = 389
            : LL = 390
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 7 successful.") : LL = 391
            : LL = 392
            DB.GetDirectories(lbArchiveDirs, CurrUserGuidID, False) : LL = 393
            : LL = 394
            GetExecParms() : LL = 395
            : LL = 396
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 8a successful.") : LL = 397
            : LL = 398
            DB.GetProcessAsList(cbProcessAsList) : LL = 399
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 8b successful.") : LL = 400
            DB.getExcludedEmails(CurrUserGuidID) : LL = 401
            : LL = 402
            Dim tVal$ = DB.UserParmRetrive("ckUseLastProcessDateAsCutoff", CurrUserGuidID) : LL = 403
            If tVal.ToUpper.Equals("TRUE") Then : LL = 404
                ckUseLastProcessDateAsCutoff.Checked = True : LL = 405
            Else : LL = 406
                ckUseLastProcessDateAsCutoff.Checked = False : LL = 407
            End If : LL = 408
            tVal = DB.UserParmRetrive("ckArchiveBit", CurrUserGuidID) : LL = 409
            If tVal.ToUpper.Equals("TRUE") Then : LL = 410
                ckArchiveBit.Checked = True : LL = 411
            Else : LL = 412
                ckArchiveBit.Checked = False : LL = 413
            End If : LL = 414
            : LL = 415
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 9 successful.") : LL = 416
            : LL = 417
            Dim S$ = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] " ' where ProfileName = 'XX'" : LL = 418
            DB.PopulateComboBox(cbProfile, "ProfileName", S) : LL = 419
            : LL = 420
            If Not isOutlookAvail Then : LL = 421
                ckDisableOutlookEmailArchive.Checked = True : LL = 422
                SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL." : LL = 426
            End If : LL = 424

            Dim T As New Thread(AddressOf GetRidOfOldMessages) : LL = 429
            T.IsBackground = True : LL = 430
            T.Priority = ThreadPriority.Lowest : LL = 431
            T.TrySetApartmentState(ApartmentState.STA) : LL = 432
            T.Start() : LL = 433
            : LL = 434
            formloaded = True : LL = 435
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 10 successful.") : LL = 436
            : LL = 437
            If cbParentFolders.Items.Count > 0 Then : LL = 438
                cbParentFolders.Text = cbParentFolders.Items(cbParentFolders.Items.Count - 1) : LL = 439
                btnActive_Click(Nothing, Nothing) : LL = 440
            End If : LL = 441

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

            If gOffice2007Installed = False Then : LL = 479
                'ckOcr.Enabled = False : LL = 480
                TT.SetToolTip(ckOcr, "Only available when Office 2007 is installed.") : LL = 481
                TT.SetToolTip(ckMetaData, "Only available when Office 2007 is installed.") : LL = 483
                TT.SetToolTip(ckOcrPdf, "Only available when Office 2007 is installed.") : LL = 483
                ckMetaData.Enabled = False : LL = 482
                'ckOcr.Enabled = False : LL = 482
                'ckOcrPdf.Enabled = False : LL = 482
            End If : LL = 484

            If DB.isPublicAllowed = False Then : LL = 486
                Me.ckPublic.Visible = False : LL = 487
            Else : LL = 488
                Me.ckPublic.Visible = True : LL = 489
            End If : LL = 490
            btnInclFileType.Visible = False : LL = 492
            btnExclude.Visible = False : LL = 493
            S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]" : LL = 495
            DB.PopulateComboBox(Me.cbDirProfile, "ProfileName", S) : LL = 496
            lbActiveFolder.Items.Clear() : LL = 498
            : LL = 499
            If isAdmin = False Then : LL = 500
                btnSaveDirProfile.Enabled = False : LL = 501
                btnUpdateDirectoryProfile.Enabled = False : LL = 502
                btnDeleteDirProfile.Enabled = False : LL = 503
                ckArchiveBit.Enabled = False : LL = 504
            End If : LL = 505
            If ddebug Then LOG.WriteToArchiveLog("frmReconMain:Load process 11 successful.") : LL = 506

            CloseMsgHeader() : LL = 508
            SetUnattendedFlag() : LL = 509
            SetUnattendedCheckBox() : LL = 510

            ckPauseListener.Checked = False : LL = 512

            Dim NbrListeners As Integer = LISTEN.LoadListeners(MachineName) : LL = 514

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
            tssAuth.Text = DB.getAuthority(CurrUserGuidID) : LL = 556
            SetVersionAndServer() : LL = 557

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

            formloaded = False
            Dim iHours As Integer = My.Settings("BackupIntervalHours")
            If iHours > 0 Then
                NumericUpDown1.Value = iHours
            End If
            formloaded = True

            'If isAdmin Then
            '    asyncVerifyRetainDates_DoWork(Nothing, Nothing)
            'End If

        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR frmReconMain_Load 01: " & LL & vbCrLf & ex.Message)
            Clipboard.Clear()
            Clipboard.SetText(ex.Message)
            MessageBox.Show("ERROR frmReconMain_Load 01 check the logs: " + LL.ToString + vbCrLf + ex.Message)
        End Try

        If DB.isAdmin(CurrUserGuidID) Then
            ImpersonateLoginToolStripMenuItem.Visible = True
            ckDeleteAfterArchive.Enabled = True
        Else
            ImpersonateLoginToolStripMenuItem.Visible = False
            ckDeleteAfterArchive.Enabled = False
        End If

        tssUser.Text = CurrUserGuidID : LL = 555
        tssAuth.Text = DB.getAuthority(CurrUserGuidID) : LL = 556

        SetVersionAndServer()

        gCurrUserGuidID = CurrUserGuidID
        UIDcurr = CurrUserGuidID

        populateCompanyCombo()

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

    End Sub

    Sub GetRidOfOldMessages()

        ARCH.CreateEcmHistoryFolder()
        Try
            ARCH.DeleteOutlookMessages(gCurrUserGuidID)
        Catch ex As Exception
            log.WriteToArchiveLog("WARNING 2005.32.21 - call DeleteOutlookMessages failed.")
        End Try
    End Sub

    Sub ckInitialData()
        AddInitialDB()
        'wdm()
        'Dim BB As Boolean = DB.ckUserExists(gCurrUserGuidID)
        ''gCurrUserGuidID = gCurrUserGuidID
        'If Not BB Then
        '    RUSER.setUserid(gCurrUserGuidID)
        '    RUSER.Insert()
        '    AddInitialEmailFolder("Inbox")
        '    AddInitialEmailFolder("Sentmail")
        'End If

        Dim BB = DB.ckFileExtExists()
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
            AVL.setExtcode(".cmd")
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

        Dim iCnt As Integer = DB.getTableCount("Attributes")
        If iCnt < 3 Then
            AddFileAttributes()
        End If

        iCnt = DB.getTableCount("SourceType")
        If iCnt = 0 Then
            DB.AddSecondarySOURCETYPE(".ascx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".asm", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".asp", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".aspx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".bat", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".c", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".cmd", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".cpp", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".cxx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".def", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".dic", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".doc", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".dot", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".h", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".hhc", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".hpp", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".htm", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".html", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".htw", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".htx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".hxx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".ibq", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".idl", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".inc", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".inf", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".ini", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".inx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".js", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".log", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".m3u", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".mht", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".msg", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".obd", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".obt", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".odc", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".pl", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".pot", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".ppt", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".rc", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".reg", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".rtf", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".stm", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".txt", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".url", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".vbs", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".wtx", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".xlb", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".xlc", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".xls", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".xlt", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".xml", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".pdf", "Word Splitter", "0", "1")
            DB.AddSecondarySOURCETYPE(".zip", "Word Splitter", "0", "0")
        End If
        iCnt = DB.getTableCount("AttachmentType")
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
            ATCH_TYPE.setAttachmentcode(".cmd")
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
        If ckRemoveAfterXDays.Checked Then
            NumericUpDown3.Enabled = True
        Else
            NumericUpDown3.Enabled = False
        End If
    End Sub

    Private Sub lbActiveFolder_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles lbActiveFolder.MouseDown
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

        Dim EmailFolderName$ = ""
        Dim RemoveAfterArchive$ = ""
        Dim SetAsDefaultFolder$ = ""
        Dim ArchiveAfterXDays$ = ""
        Dim ArchiveXDays$ = ""
        Dim RemoveAfterXDays$ = ""
        Dim RemoveXDays$ = ""
        Dim DBID$ = ""
        Dim ArchiveEmails$ = ""
        Dim ArchiveOnlyIfRead$ = ""
        Dim SystemFolder$ = ""


        Dim FolderName$ = lbActiveFolder.SelectedItem.ToString.Trim
        Dim KeyFolderName$ = ParentFolder + "|" + FolderName$
        KeyFolderName$ = UTIL.RemoveSingleQuotes(KeyFolderName$)
        Dim WhereClause$ = " where UserID = '" + gCurrUserGuidID + "' and FolderName = '" + KeyFolderName$ + "' "

        Dim aParms$() = DB.SelectOneEmailParm(WhereClause$)

        If aParms$(8) = Nothing Then
            aParms$(8) = FolderName$
            aParms$(1) = ""
            aParms$(2) = ""
            aParms$(3) = ""
            aParms$(4) = ""
            aParms$(7) = ""
            aParms$(5) = ""
            aParms$(6) = ""
            aParms$(9) = ""
            aParms$(10) = ""
            aParms$(11) = ""
        End If

        AddNewDirectory()

        ShowSellectedLibs(KeyFolderName$, "EMAIL")


    End Sub
    Sub AddNewDirectory()
        Dim EmailFolderName$ = ""
        Dim RemoveAfterArchive$ = ""
        Dim SetAsDefaultFolder$ = ""
        Dim ArchiveAfterXDays$ = ""
        Dim ArchiveXDays$ = ""
        Dim RemoveAfterXDays$ = ""
        Dim RemoveXDays$ = ""
        Dim DBID$ = ""
        Dim ArchiveEmails$ = ""
        Dim ArchiveOnlyIfRead$ = ""
        Dim SystemFolder$ = ""


        Dim FolderName$ = lbActiveFolder.SelectedItem.ToString.Trim
        Dim KeyFolderName$ = ParentFolder + "|" + FolderName$
        KeyFolderName$ = UTIL.RemoveSingleQuotes(KeyFolderName$)
        Dim WhereClause$ = " where UserID = '" + gCurrUserGuidID + "' and FolderName = '" + KeyFolderName$ + "' "

        Dim aParms$() = DB.SelectOneEmailParm(WhereClause$)

        If aParms$(8) = Nothing Then
            aParms$(8) = FolderName$
            aParms$(1) = ""
            aParms$(2) = ""
            aParms$(3) = ""
            aParms$(4) = ""
            aParms$(7) = ""
            aParms$(5) = ""
            aParms$(6) = ""
            aParms$(9) = ""
            aParms$(10) = ""
            aParms$(11) = ""
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
        Dim tEmailFolderName$ = aParms$(8)

        Dim A$() = tEmailFolderName$.Split("|")
        EmailFolderName$ = A(UBound(A))

        ArchiveEmails$ = aParms$(1)
        RemoveAfterArchive$ = aParms$(2)
        SetAsDefaultFolder$ = aParms$(3)
        ArchiveAfterXDays$ = aParms$(4)
        ArchiveXDays$ = aParms$(7)
        RemoveAfterXDays$ = aParms$(5)
        RemoveXDays$ = aParms$(6)
        DBID$ = aParms$(9)
        ArchiveOnlyIfRead$ = aParms$(10)
        SystemFolder$ = aParms$(11)

        If SystemFolder$.ToUpper.Equals("TRUE") Then
            ckSystemFolder.Checked = True
        Else
            ckSystemFolder.Checked = False
        End If

        If ArchiveEmails$.Equals("Y") Then
            ckArchiveFolder.Checked = True
        Else
            ckArchiveFolder.Checked = False
        End If
        If ArchiveOnlyIfRead$.Equals("Y") Then
            Me.ckArchiveRead.Checked = True
        Else
            ckArchiveRead.Checked = False
        End If

        If RemoveAfterXDays$.Equals("Y") Then
            ckRemoveAfterXDays.Checked = True

        Else
            ckRemoveAfterXDays.Checked = False
        End If
        If RemoveAfterXDays$.Equals("Y") Then
            ckRemoveAfterXDays.Checked = True
            NumericUpDown3.Value = RemoveXDays$
            NumericUpDown3.Enabled = True
        Else
            ckRemoveAfterXDays.Checked = False
            NumericUpDown3.Value = "0"
            NumericUpDown3.Enabled = False
        End If

        cbEmailRetention.Text = DB.GetEmailRetentionCode(tEmailFolderName$, gCurrUserGuidID)
        cbEmailDB.Text = DBID$
    End Sub
    Sub RemoveAlreadyArchived(ByVal ParentFolder$, ByVal HideArchived As Boolean)
        Dim I As Integer = 0
        Dim k As Integer = 0

        For I = lbActiveFolder.Items.Count - 1 To 0 Step -1
            'Console.WriteLine("--------------")
            Dim S1$ = lbActiveFolder.Items(I).ToString
            'S1 = ParentFolder$ + "|" + S1
            For j As Integer = 0 To ArchivedEmailFolders.Count - 1
                Dim s2$ = ArchivedEmailFolders.Item(j).ToString
                'WDM Remove this
                If gClipBoardActive = True Then Console.WriteLine(s2 + " : " + S1)
                Me.SB.Text = S1
                Me.SB.Refresh()
                Application.DoEvents()
                If UCase(S1).Equals(UCase(s2)) Then
                    If HideArchived = True Then
                        lbActiveFolder.Items.RemoveAt(I)
                    Else
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
        AllEmailFoldersShowing = True
        'ARCH.RegisterOutlookContainers()

        Me.Cursor = Cursors.AppStarting

        ParentFolder$ = cbParentFolders.Text

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

        DB.CleanUpEmailFolders()

        'btnDeleteEmailEntry.Enabled = False
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub btnActive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnActive.Click
        AllEmailFoldersShowing = False
        ParentFolder$ = cbParentFolders.Text

        If ParentFolder.Trim.Length = 0 Then
            messagebox.show("Please select an Outlook Folder to process.")
            Return
        End If
        Me.Cursor = Cursors.AppStarting

        DB.GetActiveEmailFolders(ParentFolder$, lbActiveFolder, gCurrUserGuidID, CF, ArchivedEmailFolders)
        btnDeleteEmailEntry.Enabled = True

        DB.CleanUpEmailFolders()

        Me.Cursor = Cursors.Default

    End Sub
    Sub VerifyEmailFolderExists(ByVal ContainerName$, ByVal FolderName$)
        Me.Cursor = Cursors.AppStarting
        Dim i As Integer = EMF.cnt_IDX_FolderName(ContainerName, FolderName, gCurrUserGuidID)
        If i = 0 Then
            ARCH.getOutlookFolderNames(ParentFolder$)
        End If
        Me.Cursor = Cursors.Default
    End Sub
    Private Sub btnSaveConditions_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveConditions.Click

        Dim RetentionCode$ = cbEmailRetention.Text
        If RetentionCode$.Length = 0 Then
            cbEmailRetention.Text = DB.getRetentionPeriodMax()
            RetentionCode$ = cbEmailRetention.Text
        End If

        If cbParentFolders.Text.Trim.Length = 0 Then
            messagebox.show("Please select a Parent Folder")
            Return
        End If

        If Not ckArchiveFolder.Checked Then
            messagebox.show("The Archive Email folder was not checked, please take note...")
            'ckArchiveFolder.Checked = True
        End If

        Dim RetentionYears As Integer = 0
        RetentionYears = DB.getRetentionPeriod(RetentionCode$)

        Try
            Me.Cursor = Cursors.AppStarting
            Dim ContainerName$ = ""
            For Each sFolderName As String In lbActiveFolder.SelectedItems

                Dim FolderName$ = sFolderName.ToString
                FQNFolder$ = ParentFolder + "|" + FolderName$

                ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder)
                FolderName$ = UTIL.RemoveSingleQuotes(FolderName$)
                FQNFolder$ = UTIL.RemoveSingleQuotes(FQNFolder$)

                'ContainerName$ = cbParentFolders.Text
                ContainerName$ = ParentFolder

                'Dim EDIR As New clsEMAILFOLDER
                'EDIR.cnt_IDX_FolderName(FolderName$, gCurrUserGuidID)
                'EDIR = Nothing

                Dim aParms$(0)

                EMPARMS.setFoldername(FQNFolder$)
                EMPARMS.setUserid(gCurrUserGuidID)

                If ckArchiveRead.Checked Then
                    EMPARMS.setArchiveonlyifread("Y")
                Else
                    EMPARMS.setArchiveonlyifread("N")
                End If

                If ckArchiveFolder.Checked Then
                    EMPARMS.setArchiveemails("Y")
                    DB.SetFolderAsActive(FolderName$, "Y")
                Else
                    EMPARMS.setArchiveemails("N")
                    DB.SetFolderAsActive(FolderName$.Trim, "N")
                End If

                If ckRemoveAfterXDays.Checked Then
                    EMPARMS.setRemoveafterxdays("Y")
                    EMPARMS.setRemovexdays(NumericUpDown3.Value.ToString)
                Else
                    EMPARMS.setRemoveafterxdays("N")
                    EMPARMS.setRemovexdays("0")
                End If
                If ckSystemFolder.Checked Then
                    Dim msg$ = "This folder will become mandatory for everyone, are you sure?"
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
                Dim B As Boolean = DB.ckFolderExists(ContainerName$, gCurrUserGuidID, FQNFolder$)

                'For iCnt As Integer = 0 To CF.Count - 1
                '    Dim SS$ = CF.Keys(iCnt).ToString
                '    Console.WriteLine(SS)
                'Next
                If Not B Then

                    Dim iFolder As Integer = EMF.cnt_IDX_FolderName(ContainerName, FQNFolder$, gCurrUserGuidID)
                    If iFolder = 0 Then
                        Console.WriteLine("Folder " + FQNFolder$ + " does not exist.")
                    End If

                    EMPARMS.Insert(ContainerName$)

                    Dim WhereClause$ = "Where ContainerName = '" + ContainerName + "' and [UserID] = '" + gCurrUserGuidID + "' and [FolderName] = '" + FQNFolder$ + "' "
                    EMPARMS.Update(WhereClause)

                    If isAdmin = True Then
                        Dim S As String = ""
                        If ckSystemFolder.Checked = True Then
                            S$ = "update [EmailFolder]"
                            S$ = S$ + " set isSysDefault = 1"
                            S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        Else
                            S$ = "update [EmailFolder]"
                            S$ = S$ + " set isSysDefault = 0"
                            S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        End If

                        Dim BB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If

                    If ckArchiveFolder.Checked Then
                        Dim S As String = "update [EmailFolder]"
                        S$ = S$ + " set SelectedForArchive = 'Y' "
                        S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        Dim BB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    Else
                        Dim S As String = "update [EmailFolder]"
                        S$ = S$ + " set SelectedForArchive = 'N' "
                        S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        Dim BB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If

                Else
                    Dim WhereClause$ = "Where [UserID] = '" + gCurrUserGuidID + "' and [FolderName] = '" + FQNFolder$ + "'"
                    EMPARMS.Update(WhereClause)

                    If isAdmin = True Then
                        Dim S As String = ""
                        If ckSystemFolder.Checked = True Then
                            S$ = "update [EmailFolder]"
                            S$ = S$ + " set isSysDefault = 1"
                            'S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName$ + "' and ParentFolderName = '" + ParentFolder + "' "
                            S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        Else
                            S$ = "update [EmailFolder]"
                            S$ = S$ + " set isSysDefault = 0"
                            'S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName$ + "' and ParentFolderName = '" + ParentFolder + "' "
                            S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        End If
                        Dim BB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            LOG.WriteToArchiveLog("Notice: frmReconMain:btnSaveConditions: 23.441 - 100 Failed to update isSysDefault")
                        End If
                    End If

                    If ckArchiveFolder.Checked Then
                        Dim S As String = "update [EmailFolder]"
                        S$ = S$ + " set SelectedForArchive = 'Y' "
                        S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        Dim BB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    Else
                        Dim S As String = "update [EmailFolder]"
                        S$ = S$ + " set SelectedForArchive = 'N' "
                        S$ = S$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                        Dim BB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If

                End If
SKIPFOLDER:
                Dim xSql$ = ""
                xSql$ = "update [EmailFolder] "
                xSql$ = xSql$ + " set RetentionCode = '" + RetentionCode + "' "
                'xSql$ = xSql$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName$ + "' and ParentFolderName = '" + ParentFolder + "' "
                xSql$ = xSql$ + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FQNFolder$ + "'"
                Dim BB1 As Boolean = DB.ExecuteSqlNewConn(xSql, False)
                If Not BB1 Then
                    LOG.WriteToArchiveLog("Notice: frmReconMain:btnSaveConditions: 23.441 - 200 Failed to update RetentionCode")
                End If

                SB.Text = FolderName + " activated."
            Next
        Catch ex As Exception
            log.WriteToArchiveLog("ERROR 195-43.2 frmReconMain:btnSaveConditions_Click - " + ex.Message)
        End Try

        DB.CleanUpEmailFolders()

        Me.Cursor = Cursors.Default


    End Sub

    Private Sub btnSelDir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelDir.Click

        If cbRetention.Text.Trim.Length = 0 Then
            messagebox.show("Please select a retention policy to apply to this directory before adding it to the system.")
            Return
        End If

        Dim tDir$ = ""

        If CurrentDirectory$.Length > 0 Then
            FolderBrowserDialog1.SelectedPath = CurrentDirectory$
        End If

        FolderBrowserDialog1.ShowDialog()
        If FolderBrowserDialog1.SelectedPath.Length > 0 Then
            tDir = FolderBrowserDialog1.SelectedPath
            CurrentDirectory$ = FolderBrowserDialog1.SelectedPath
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

    End Sub

    Private Sub btnAddFiletype_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddFiletype.Click
        If Not DB.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            messagebox.show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If

        Dim FileExt$ = Me.cbFileTypes.Text.Trim

        If InStr(FileExt$, ".") = 0 Then
            FileExt = "." + FileExt
        End If

        Dim B As Boolean = DB.ckExtExists(FileExt$)

        DB.delSecondarySOURCETYPE(FileExt$)
        DB.AddSecondarySOURCETYPE(FileExt$, "Added by user", "0", "1")


        If B Then
            SB.Text = "Extension already defined to system."
        Else
            AVL.setExtcode(FileExt$)
            AVL.Insert()
            DB.LoadAvailFileTypes(cbFileTypes)
            DB.LoadAvailFileTypes(cbPocessType)
            DB.LoadAvailFileTypes(cbAsType)
            DB.LoadAvailFileTypes(lbAvailExts)
        End If

    End Sub

    Private Sub ckRemoveAfterDays_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckRemoveFileType.Click
        If Not DB.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            messagebox.show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If

        'select count(*) from  [DataSource] where [SourceTypeCode] = 'YYYY' and [DataSourceOwnerUserID] = 'XXX'
        Dim FileExt$ = Me.cbFileTypes.Text.Trim

        Dim B As Boolean = DB.iCount("DataSource", "where [SourceTypeCode] = '" + FileExt$ + "' and [DataSourceOwnerUserID] = '" + gCurrUserGuidID + "'")

        If B Then
            messagebox.show("Cannot remove filetype " + FileExt$ + ". There are files of that type in the repository.")
            Return
        End If


        AVL.setExtcode(FileExt$)
        AVL.Delete("Where ExtCode = '" + FileExt$ + "'")

        DB.delSecondarySOURCETYPE(FileExt$)

        DB.LoadAvailFileTypes(cbFileTypes)
        DB.LoadAvailFileTypes(cbPocessType)
        DB.LoadAvailFileTypes(cbAsType)
        DB.LoadAvailFileTypes(lbAvailExts)
    End Sub



    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        If Not DB.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            messagebox.show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        Dim ParentFT$ = cbPocessType.Text
        Dim ChildFT$ = cbAsType.Text
        SB.Text = AP.SaveNewAssociations(ParentFT$, ChildFT$)
        DB.GetProcessAsList(cbProcessAsList)
    End Sub

    Private Sub ckIncludeAllTypes_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
        If iCnt <= 0 Then
            messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            Return
        End If
        'If ckIncludeAllTypes.Checked Then
        '    Me.lbIncludeExts.Items.Clear()
        '    For i As Integer = 0 To lbAvailExts.Items.Count - 1
        '        Dim S$ = Me.lbAvailExts.Items(i).ToString
        '        lbIncludeExts.Items.Add(S)
        '    Next
        'End If
    End Sub

    Private Sub lbArchiveDirs_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles lbArchiveDirs.MouseDown
        If e.Button = MouseButtons.Right Then
            Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
            If iCnt = 0 Then
                messagebox.show("You must select a Directory first... aborting")
                Return
            End If
            Dim FolderName$ = Me.lbArchiveDirs.SelectedItem.ToString
            FolderName = UTIL.RemoveSingleQuotes(FolderName)
            If e.Button = MouseButtons.Right Then
                frmLibraryAssignment.setFolderName(FolderName)
                frmLibraryAssignment.SetTypeContent(True)
                frmLibraryAssignment.ShowDialog()
            End If
        End If
    End Sub

    Private Sub ListBox2_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbArchiveDirs.SelectedIndexChanged

        If bApplyingDirParms = True Then
            Return
        End If

        Dim I As Integer = lbArchiveDirs.SelectedItems.Count
        If I = 0 Then
            SB.Text = "You must select an item from the listbox..."
            Return
        End If

        If I <> 1 Then
            CkMonitor.Visible = False
        Else
            CkMonitor.Visible = True
        End If


        bActiveChange = True

        Dim DirName$ = lbArchiveDirs.SelectedItem.ToString.Trim
        Me.txtDir.Text = DirName$
        'DB.LoadAvailFileTypes(lbAvailExts)
        Dim DBID$ = ""
        Dim IncludeSubDirs$ = ""
        Dim VersionFiles$ = ""
        Dim FolderDisabled$ = ""
        Dim isMetaData$ = ""
        Dim isPublic$ = ""
        Dim OcrDirectory$ = ""
        Dim OcrPdf$ = ""
        Dim isSysDefault$ = ""
        Dim DeleteOnArchive As String = ""

        DB.GetDirectoryData(gCurrUserGuidID, DirName, DBID$, IncludeSubDirs$, VersionFiles$, FolderDisabled$, isMetaData$, isPublic$, OcrDirectory, isSysDefault, Me.ckArchiveBit.Checked, ListenForChanges, ListenDirectory, ListenSubDirectory, DirGuid, OcrPdf, DeleteOnArchive)

        cbFileDB.Text = DBID$
        ckSubDirs.Checked = cvtTF(IncludeSubDirs$)
        Me.ckVersionFiles.Checked = cvtTF(VersionFiles$)
        Me.ckDisableDir.Checked = cvtTF(FolderDisabled$)

        DB.LoadIncludedFileTypes(lbIncludeExts, gCurrUserGuidID, DirName$)
        DB.LoadExcludedFileTypes(Me.lbExcludeExts, gCurrUserGuidID, DirName$)

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
        If isMetaData$ = "Y" Then
            Me.ckMetaData.Checked = True
        Else
            Me.ckMetaData.Checked = False
        End If
        If IncludeSubDirs$.Equals("Y") Then
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

        Dim bDisabled As Boolean = DB.isDirAdminDisabled(gCurrUserGuidID, DirName)
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

        ShowSellectedLibs(DirName$, "CONTENT")

        bActiveChange = False

    End Sub
    Sub ShowSellectedLibs(ByVal DirName$, ByVal TypeList$)

        If ckShowLibs.Checked Then

            frmLibraryAssgnList.LIbraryName = DirName$
            DB.GetListOfAssignedLibraries(DirName$, TypeList$, AssignedLibraries)
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

        Try
            Dim SelectedFileType$ = lbIncludeExts.SelectedItem.ToString
            INL.setUserid(gCurrUserGuidID)
            INL.setFqn(Me.lbArchiveDirs.SelectedItem.ToString)
            INL.setExtcode(SelectedFileType$)
            'INL.Delete("where UserID = '" + gCurrUserGuidID + "' and FQN = '" + Me.lbArchiveDirs.SelectedItem.ToString + "' and Extcode = '" + SelectedFileType$ + "' ")
        Catch ex As Exception
            SB.Text = ("Both a directory and the Included File Type must be selected...")
        End Try

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
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

        Dim II As Integer = DB.getTableCount("Databases")

        If II > 0 Then
            Return
        End If

        Dim S$ = ""
        S = S + " INSERT INTO [Databases]"
        S = S + " ([DB_ID]"
        S = S + " ,[DB_CONN_STR])"
        S = S + " VALUES"
        S = S + " ('DMA.UD'"
        S = S + " ,'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True')"
        Try
            Dim b As Boolean = DB.ExecuteSqlNewConn(S, False)
        Catch ex As Exception
            messagebox.show("ERROR 219.23.4: Call Administrator" + vbCrLf + ex.Message)
        End Try

        S$ = ""
        S = S + " INSERT INTO [Databases]"
        S = S + " ([DB_ID]"
        S = S + " ,[DB_CONN_STR])"
        S = S + " VALUES"
        S = S + " ('ECMREPO'"
        S = S + " ,'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True')"
        Try
            Dim b As Boolean = DB.ExecuteSqlNewConn(S, False)
        Catch ex As Exception
            messagebox.show("ERROR 219.23.4: Call Administrator" + vbCrLf + ex.Message)
        End Try

        S$ = ""
        S = S + " INSERT INTO [Databases]"
        S = S + " ([DB_ID]"
        S = S + " ,[DB_CONN_STR])"
        S = S + " VALUES"
        S = S + " ('ECMREPO'"
        S = S + " ,'Data Source=<your source name here>;Initial Catalog=ECM.Library;Integrated Security=True')"
        Try
            Dim b As Boolean = DB.ExecuteSqlNewConn(S, False)
        Catch ex As Exception
            messagebox.show("ERROR 219.23.4: Call Administrator" + vbCrLf + ex.Message)
        End Try

    End Sub
    Private Sub AddInitialEmailFolder(ByVal ContainerName$, ByVal FolderName$)

        AddInitialDB()

        Me.Cursor = Cursors.AppStarting
        Dim aParms$(0)

        'PARMS.EmailFolderName$ = FolderName$
        EMPARMS.setFoldername(FolderName$)
        EMPARMS.setUserid(gCurrUserGuidID)
        EMPARMS.setArchiveemails("Y")
        EMPARMS.setRemoveafterarchive("Y")
        EMPARMS.setSetasdefaultfolder("N")
        EMPARMS.setArchivexdays("N")
        EMPARMS.setArchivexdays("0")
        EMPARMS.setRemoveafterarchive("N")
        EMPARMS.setRemovexdays("0")
        EMPARMS.setDb_id(CurrDbName)
        EMPARMS.Insert(ContainerName$)


        Me.Cursor = Cursors.Default
    End Sub

    Private Sub ckRunAtStartup_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If formloaded = False Then
            Return
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
        Catch ex As Exception
            MessageBox.Show("Failed to set start up parameter." + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter." + vbCrLf + ex.Message)
        End Try

    End Sub

    Private Sub ckDisable_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisable.CheckedChanged
        If formloaded = False Then
            Return
        End If

        'formloaded = False
        'Me.saveStartUpParms()
        'formloaded = True
        saveStartUpParms()
        SB.Text = "Disabled set to " + ckDisable.Checked.ToString
    End Sub
    Sub GetExecParms()

        Dim ArchiveType$ = ""
        ArchiveType$ = DB.getRconParm(gCurrUserGuidID, "ArchiveType")
        'If ArchiveType$.Length > 0 Then
        '    cbInterval.Text = ArchiveType$
        'Else
        '    cbInterval.Text = ""
        'End If

        Dim C$ = ""
        C = DB.getRconParm(gCurrUserGuidID, "ArchiveInterval")
        'If C.Length > 0 Then
        '    cbTimeUnit.Text = C
        'Else
        '    cbTimeUnit.Text = "5"
        'End If
        C = DB.getRconParm(gCurrUserGuidID, "LoadAtStartup")
        'If C.Length > 0 Then
        '    If C.Equals("True") Then
        '        ckRunAtStartup.Checked = True
        '    Else
        '        ckRunAtStartup.Checked = False
        '    End If
        'Else
        '    ckRunAtStartup.Checked = False
        'End If

        C = DB.getRconParm(gCurrUserGuidID, "Disabled")
        If C.Length > 0 Then
            If C.Equals("True") Then
                ckDisable.Checked = True
                'Me.Timer1.Enabled = True
                ''Me.Timer1.Interval = Val(cbTimeUnit.Text.Trim) * 60000
                'Me.Timer1.Interval = 5 * 60000
            Else
                ckDisable.Checked = False
                'Me.Timer1.Enabled = True
                'Me.Timer1.Interval = 5 * 60000
            End If
        Else
            ckDisable.Checked = False
            'Me.Timer1.Enabled = True
            'Me.Timer1.Interval = Val(cbTimeUnit.Text.Trim) * 60000
        End If

        C = DB.getRconParm(gCurrUserGuidID, "ContentDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckDisableContentArchive.Checked = True
        Else
            Me.ckDisableContentArchive.Checked = False
        End If
        C = DB.getRconParm(gCurrUserGuidID, "OutlookDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckDisableOutlookEmailArchive.Checked = True
        Else
            Me.ckDisableOutlookEmailArchive.Checked = False
        End If
        C = DB.getRconParm(gCurrUserGuidID, "ExchangeDisabled")
        If C.ToUpper.Equals("TRUE") Then
            Me.ckDisableExchange.Checked = True
        Else
            Me.ckDisableExchange.Checked = False
        End If
    End Sub

    Private Sub SenderMgtToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        frmSenderMgt.Show()
    End Sub
    Sub IncludeDirectory(ByVal DirFqn$)

        ckSubDirs.Checked = True
        'ckOcr.Checked = True
        ckVersionFiles.Checked = True

        Try
            If cbRetention.Text.Trim.Length = 0 Then
                messagebox.show("Please select a retention policy to apply to this directory before adding it to the system.")
                Return
            End If

            PBx.Minimum = 0
            PBx.Maximum = 10

            Dim RetentionCode$ = cbRetention.Text.Trim

            Try
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor


                SB.Text = "Beginning Include"

                Try
                    PBx.Value = 1
                Catch ex As Exception

                End Try

                Dim FQN$ = txtDir.Text.Trim
                FQN = UTIL.RemoveSingleQuotes(FQN)
                txtDir.Text = FQN

                Dim DBID$ = cbFileDB.Text.Trim

                Dim getMetaData$ = "N"
                If ckMetaData.Checked Then
                    getMetaData$ = "Y"
                End If

                Dim OcrDirectory$ = "N"
                If ckOcr.Checked Then
                    OcrDirectory$ = "Y"
                Else
                    OcrDirectory$ = "N"
                End If

                lbIncludeExts.Items.Clear()
                lbExcludeExts.Items.Clear()
                AuthorizedFileTypes.Clear()
                UnAuthorizedFileTypes.Clear()

                SB.Text = "Adding directory"
                Dim SUBDIR$ = cvtCkBox(ckSubDirs)
                Dim VersionFiles$ = cvtCkBox(Me.ckVersionFiles)
                Dim I As Integer = 0

                SB.Text = "Adding Included File Types"

                Try
                    PBx.Value = 2
                Catch ex As Exception

                End Try

                AuthorizedFileTypes.Clear()
                If lbIncludeExts.Items.Count Then
                    For I = 0 To lbIncludeExts.Items.Count - 1
                        Dim InclExt$ = lbIncludeExts.Items(I).ToString
                        AuthorizedFileTypes.Add(InclExt$)
                    Next
                End If

                'UnAuthorizedFileTypes.Clear()
                'If lbExcludeExts.Items.Count > 0 Then
                '    For I = 0 To Me.lbExcludeExts.Items.Count - 1
                '        Dim InclExt$ = Me.lbExcludeExts.Items(I).ToString
                '        UnAuthorizedFileTypes.Add(InclExt$)
                '    Next
                'End If

                Dim BB As Boolean = DB.ckDirectoryExists(gCurrUserGuidID, FQN$)
                If BB Then
                    messagebox.show("Directory already defined to system, you must SAVE the new setup.")
                    SB.Text = "Directory already defined to system, you must SAVE the new setup."
                Else
                    IncludeListHasChanged = True
                    DIRS.setDb_id(DBID)
                    DIRS.setFqn(FQN)
                    DIRS.setIncludesubdirs(SUBDIR$)
                    DIRS.setVersionfiles(VersionFiles)
                    DIRS.setUserid(gCurrUserGuidID)
                    DIRS.setCkmetadata(getMetaData$)
                    DIRS.setQuickRefEntry("0")
                    DIRS.setOcrDirectory(OcrDirectory$)

                    DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString)

                    DIRS.Insert()

                    '**************************************************************************************************************
                    'AddSubDirs(FQN$, ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory$, clAdminDir.Checked, RetentionCode$)
                    '**************************************************************************************************************

                    Dim FileExt$ = ""

                    SB.Text = "Adding Included File Types"

                    Try
                        PBx.Value = 4
                    Catch ex As Exception

                    End Try

                    For I = 0 To AuthorizedFileTypes.Count - 1
                        FileExt$ = AuthorizedFileTypes.Item(I).ToString
                        SB.Text = "Including File Type: " + FileExt$
                        FQN = UTIL.RemoveSingleQuotes(FQN)
                        Dim b As Boolean = INL.DeleteExisting(gCurrUserGuidID, FQN$)
                        b = InclAddList(lbIncludeExts, gCurrUserGuidID, FQN$)
                        Application.DoEvents()
                    Next

                    SB.Text = "Fetching Directories"

                    Try
                        PBx.Value = 7
                    Catch ex As Exception

                    End Try

                    DB.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)

                    SB.Text = "Fetching Included Files"

                    Try
                        PBx.Value = 9
                    Catch ex As Exception

                    End Try

                    DB.GetIncludedFiles(lbIncludeExts, gCurrUserGuidID, FQN$)

                    If isAdmin = True Then
                        Dim S As String = ""
                        If clAdminDir.Checked = True Then
                            If ckSubDirs.Checked = True Then
                                S$ = "update [Directory] set [isSysDefault] = 1 where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%'"
                            Else
                                S$ = "update [Directory] set [isSysDefault] = 1 where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "'"
                            End If
                        Else
                            If ckSubDirs.Checked = True Then
                                S$ = "update [Directory] set [isSysDefault] = 0  where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%'"
                            Else
                                S$ = "update [Directory] set [isSysDefault] = 0  where [UserID] = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "'"
                            End If
                        End If
                        Dim BBB As Boolean = DB.ExecuteSqlNewConn(S, False)
                        If Not BBB Then
                            Debug.Print("Failed to update isSysDefault")
                        End If
                    End If
                    SB.Text = "Directory added."

                    'Dim Msg2$ = "Please remember, your next step is to set the archive parameters " + vbCrLf
                    'Msg2 += "and press the Save Changes button to activate this directory." + vbCrLf + vbCrLf
                    ''Msg2 += "Once content is archived, parameter changes CANNOT be updated from this screen." + vbCrLf
                    ''Msg2 += "This includes metadata, OCR this directory and public access."
                    'messagebox.show(Msg2, MsgBoxStyle.Exclamation)

                    Me.Cursor = System.Windows.Forms.Cursors.Default
                    IncludeListHasChanged = False
                End If
                Me.PBx.Value = 0
            Catch ex As Exception
                SB.Text = ("Error: please review trace log last entry. (Trace Log Icon in main screen)")
                log.WriteToArchiveLog("frmReconMain:btnAddDir_Click: " + ex.Message)
            End Try
            Me.Cursor = System.Windows.Forms.Cursors.Default
        Catch ex As Exception
            log.WriteToArchiveLog("ERROR IncludeDirectory 144.23.11: Failed to add directories.")
        End Try
    End Sub
    Private Sub btnAddDir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddDir.Click

        Dim DirFQN$ = txtDir.Text.Trim
        IncludeDirectory(DirFQN$)

    End Sub
    Sub AddSubDirs(ByVal FQN$, ByVal isPublic As Boolean, ByVal isEnabled As Boolean, ByVal OcrDirectory$, ByVal clAdminDir As Boolean, ByVal RetentionCode$)
        Dim PublicFlag$ = ""
        Dim DirEnabled$ = ""
        If isPublic Then
            PublicFlag$ = "Y"
        Else
            PublicFlag$ = "N"
        End If
        If isEnabled Then
            DirEnabled$ = "Y"
        Else
            DirEnabled$ = "N"
        End If

        If clAdminDir Then
            clAdminDir = 1
        Else
            clAdminDir = 0
        End If

        FQN$ = UTIL.RemoveSingleQuotes(FQN$)
        SubDirectories.Clear()
        If Me.ckSubDirs.Checked = True Then
            Dim A$(0)
            Dim SubDirFound As Boolean = DMA.RecursiveSearch(FQN, A$)
            If SubDirFound Then
                DB.delSubDirs(gCurrUserGuidID, FQN$)
                Dim tFqn$ = FQN
                SUBDIRECTORY.setUserid(gCurrUserGuidID)
                SUBDIRECTORY.setFqn(FQN)
                SUBDIRECTORY.setSubfqn(tFqn)
                SUBDIRECTORY.setCkpublic(PublicFlag)
                SUBDIRECTORY.setCkdisabledir(DirEnabled)
                SUBDIRECTORY.setOcrDirectory(OcrDirectory$)
                SUBDIRECTORY.Insert()

                SB2.Text = FQN
                SB2.Refresh()
                Application.DoEvents()

                Dim IntClAdminDir As Integer = 0

                If clAdminDir = True Then
                    IntClAdminDir = 1
                End If

                Dim S As String = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString + " where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                DB.ExecuteSqlNewConn(S, False)

                S$ = "Update SubDir set RetentionCode = '" + RetentionCode + "' where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                DB.ExecuteSqlNewConn(S, False)

                AuthorizedFileTypes.Add(tFqn)
                UnAuthorizedFileTypes.Add(tFqn)
                Dim iObj As Integer = SubDirectories.Count
                Me.PBx.Value = 0
                Me.PBx.Maximum = iObj + 2
                iObj = 0
                For Each O As Object In SubDirectories
                    tFqn$ = O.ToString.Trim
                    SUBDIRECTORY.setUserid(gCurrUserGuidID)
                    SUBDIRECTORY.setFqn(FQN)
                    SUBDIRECTORY.setSubfqn(tFqn)
                    SUBDIRECTORY.setCkpublic(PublicFlag)
                    SUBDIRECTORY.setOcrDirectory(OcrDirectory$)
                    SUBDIRECTORY.Insert()

                    S$ = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString + " where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                    DB.ExecuteSqlNewConn(S, False)

                    S$ = "Update SubDir set RetentionCode = '" + RetentionCode + "' where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                    DB.ExecuteSqlNewConn(S, False)

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
                DB.delSubDirs(gCurrUserGuidID, FQN$)
                Dim tFqn$ = FQN
                SUBDIRECTORY.setUserid(gCurrUserGuidID)
                SUBDIRECTORY.setFqn(FQN)
                SUBDIRECTORY.setSubfqn(tFqn)
                SUBDIRECTORY.setCkpublic(PublicFlag)
                SUBDIRECTORY.setOcrDirectory(OcrDirectory$)
                SUBDIRECTORY.Insert()

                Dim S As String = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString + " where UserID = '" + gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' "
                DB.ExecuteSqlNewConn(S, False)

                AuthorizedFileTypes.Add(tFqn)
                UnAuthorizedFileTypes.Add(tFqn)
            End If
        End If

        SB.Text = ""
        SB.Refresh()
        Application.DoEvents()

    End Sub
    Sub addSubDirs(ByVal FQN$, ByRef LB As List(Of String))
        LB.Clear()
        FQN$ = UTIL.RemoveSingleQuotes(FQN$)
        LB.Add(FQN)

        If Me.ckSubDirs.Checked = True Then
            Dim A$(0)
            Dim SubDirFound As Boolean = DMA.RecursiveSearch(FQN, A$)
            If SubDirFound Then
                Dim tFqn$ = FQN
                LB.Add(tFqn)
                For i As Integer = 0 To UBound(A)
                    If A(i) = Nothing Then
                    Else
                        tFqn$ = A(i).ToString
                        LB.Add(tFqn)
                    End If
                Next
            Else
                Dim tFqn$ = FQN
                LB.Add(tFqn)
            End If
        End If
    End Sub
    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveChanges.Click
        Dim FQN$ = txtDir.Text.Trim

        If ckArchiveBit.Checked Then
            Dim tMsg$ = ""
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
                Dim tCmd$ = ""
                If ckSubDirs.Checked Then
                    tCmd$ = " " + FQN$ + "\*.* +a /s"
                    'System.Diagnostics.Process.Start("attrib.exe", tFQN$)
                    Dim p As Process = Process.Start("attrib.exe", tCmd$)
                    'p.WaitForExit()
                Else
                    tCmd$ = "attrib " + FQN$ + "\*.* +a"
                    Dim p As Process = Process.Start("attrib.exe", tCmd$)
                    'p.WaitForExit()
                End If
            End If

            SB.Text = " "
        End If

        btnSaveChanges.BackColor = Color.LightGray

        Dim RetentionCode$ = cbRetention.Text
        If RetentionCode$.Length = 0 Then
            cbRetention.Text = DB.getRetentionPeriodMax()
            RetentionCode$ = cbRetention.Text
        End If

        Dim RetentionPeriod As Integer = 0
        If RetentionCode$.Trim.Length = 0 Then
            RetentionPeriod = 10
        End If
        RetentionPeriod = DB.getRetentionPeriod(RetentionCode$)

        Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
        If txtDir.Text.Length > 0 Then
            SB.Text = "Updating " + txtDir.Text.Trim
        ElseIf iCnt <= 0 Then
            messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            Return
        End If
        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor

        FQN$ = UTIL.RemoveSingleQuotes(FQN$)
        txtDir.Text = FQN
        'Dim DBID = cbFileDB.SelectedItem.ToString
        Dim DBID As String = "ECMREPO"
        Dim SUBDIR As String = cvtCkBox(ckSubDirs)

        Dim DeleteOnArchive As String = cvtCkBox(ckDeleteAfterArchive)

        Dim VersionFiles$ = cvtCkBox(Me.ckVersionFiles)
        Dim I As Integer = 0
        Dim DisableDir$ = "N"

        If DBID.Length = 0 Then
            messagebox.show("Please select a repository...")
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Return
        End If
        If lbIncludeExts.Items.Count = 0 Then
            messagebox.show("Please remember to include one or more filetypes in this archive...")
        End If

        Dim OcrPdf As String = "N"
        If ckOcrPdf.Checked Then
            OcrPdf = "Y"
            gPdfExtended = True
        Else
            OcrPdf = "N"
            gPdfExtended = False
        End If

        Dim OcrDirectory$ = "N"
        If ckOcr.Checked Then
            OcrDirectory$ = "Y"
        Else
            OcrDirectory$ = "N"
        End If

        Dim getMetaData$ = "N"
        If ckMetaData.Checked Then
            getMetaData$ = "Y"
        End If

        Dim SetToPublic$ = "N"
        If Me.ckPublic.Checked Then
            SetToPublic = "Y"
            DB.AddSysMsg(FQN$ + " set to PUBLIC access.")
        Else
            SetToPublic = "N"
            DB.AddSysMsg(FQN$ + " set to PRIVATE access.")
        End If

        If DB.isPublicAllowed = False Then
            Me.ckPublic.Checked = False
            SetToPublic = "N"
        End If

        If ckDisableDir.Checked Then
            DisableDir = "Y"
        Else
            DisableDir = "N"
        End If

        Dim BB As Boolean = DB.ckDirectoryExists(gCurrUserGuidID, FQN$)
        If Not BB Then
            messagebox.show("Directory IS NOT defined to system, adding it.")
            btnAddDir_Click(Nothing, Nothing)
        Else
            DIRS.setDb_id(DBID)
            DIRS.setFqn(FQN)
            SUBDIR = UTIL.RemoveSingleQuotes(SUBDIR)
            DIRS.setIncludesubdirs(SUBDIR)
            DIRS.setUserid(gCurrUserGuidID)
            DIRS.setVersionfiles(VersionFiles$)
            DIRS.setCkmetadata(getMetaData$)
            DIRS.setCkpublic(SetToPublic)
            DIRS.setCkdisabledir(DisableDir)
            DIRS.setQuickRefEntry("0")
            DIRS.setOcrDirectory(OcrDirectory$)
            DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString)
            DIRS.setOcrPdf(OcrPdf)
            DIRS.setDeleteOnArchive(DeleteOnArchive)

            AuthorizedFileTypes.Clear()
            UnAuthorizedFileTypes.Clear()

            AuthorizedFileTypes.Add(FQN)
            UnAuthorizedFileTypes.Add(FQN)

            Dim WhereClause$ = ""
            If ckOcr.Checked Then
                OcrDirectory = "Y"
            Else
                OcrDirectory = "N"
            End If

            If SUBDIR.Equals("Y") Then
                'WhereClause$ = "where UserID = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%\' and AdminDisabled <> 1 and ckDisableDir <> 'Y'"
                'DIRS.Update(WhereClause$, OcrDirectory)

                WhereClause$ = "where UserID = '" + gCurrUserGuidID + "' and [FQN] = '" + FQN + "'"
                DIRS.Update(WhereClause$, OcrDirectory)
            Else
                WhereClause$ = "where UserID = '" + gCurrUserGuidID + "' and [FQN] = '" + FQN + "'"
                DIRS.Update(WhereClause$, OcrDirectory)
            End If

            If clAdminDir.Checked Then
                Dim msg$ = "This Directory will become mandatory for everyone, are you sure?"
                Dim dlgRes As DialogResult = MessageBox.Show(msg, "Mandatory Directory", MessageBoxButtons.YesNo)
                If dlgRes = Windows.Forms.DialogResult.No Then
                    Return
                End If
                Dim S As String = "Update Directory set isSysDefault = 1 " + WhereClause$
                Dim bb1 As Boolean = DB.ExecuteSqlNewConn(S, False)
                If Not bb1 Then
                    Console.WriteLine("Error 1994.23.1 - did not update isSysDefault")
                End If
            Else
                Dim S As String = "Update Directory set isSysDefault = 0 " + WhereClause$
                Dim bb1 As Boolean = DB.ExecuteSqlNewConn(S, False)
                If Not bb1 Then
                    Console.WriteLine("Error 1994.23.1 - did not update isSysDefault")
                End If
            End If

            Dim tSql1$ = "Update Directory set RetentionCode = '" + RetentionCode + "' " + WhereClause$
            Dim BB2 As Boolean = DB.ExecuteSqlNewConn(tSql1, False)
            If Not BB2 Then
                Console.WriteLine("Error 1994.23.1x - did not update RetentionCode")
            End If

            Me.SB.Text = "Step 1 of 4 standby..."
            DB.SetDocumentPublicFlagByOwnerDir(FQN$, Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory$)

            Me.SB.Text = "Step 2 of 4 standby... "
            'DB.SetDocumentPublicFlagByOwnerDir(FQN$, Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory$)

            Me.SB.Text = "Step 3 of 4 standby..."

            Dim sSql As String = "delete from [IncludedFiles] where FQN = '" + FQN$ + "'"
            BB = DB.ExecuteSqlNewConn(sSql)

            Me.PBx.Maximum = AuthorizedFileTypes.Count
            Me.PBx.Value = 0
            For I = 0 To AuthorizedFileTypes.Count - 1
                FQN = AuthorizedFileTypes.Item(I).ToString
                Dim b As Boolean = INL.DeleteExisting(gCurrUserGuidID, FQN$)
                b = InclAddList(lbIncludeExts, gCurrUserGuidID, FQN$)
                If Not b Then
                    If Not b Then
                        DB.xTrace(87925, "FrmReconMain:btnSaveChanges:AddList", "Failed for: " + FQN + " : " + gCurrUserGuidID)
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
                Dim b As Boolean = Me.EXL.DeleteExisting(gCurrUserGuidID, FQN$)
                b = Me.ExcludeAddList(Me.lbExcludeExts, gCurrUserGuidID, FQN$)
                If Not b Then
                    If Not b Then
                        DB.xTrace(87925.22, "FrmReconMain:btnSaveChanges:AddList", "Failed for: " + FQN + " : " + gCurrUserGuidID)
                    End If
                End If
                '** WDM DB.SetDocumentPublicFlag(gCurrUserGuidID, FQN$, Me.ckPublic.Checked, Me.ckDisableDir.Checked)
                If I Mod 5 = 0 Then
                    Me.SB.Text = "Adding subdirectories... standby: " + I.ToString
                End If
                Application.DoEvents()
                Application.DoEvents()
                DB.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)
                DB.GetIncludedFiles(lbIncludeExts, gCurrUserGuidID, FQN$)
                Application.DoEvents()
            Next
            Me.Cursor = Cursors.AppStarting
            If Me.ckPublic.Checked Then
                SetToPublic = "Y"
                Dim S As String = "Update [Directory] set ckPublic = 'Y' "
                S = S + " where FQN = '" + FQN$ + "' "
                S = S + " and UserID = '" + gCurrUserGuidID + "'"
                DB.ExecuteSqlNewConn(S)
                If ckPublic.Enabled Then
                    SB.Text = "Standby, updating the repository, this can take a long time."
                    Me.Refresh()
                    Application.DoEvents()
                    Me.Cursor = Cursors.AppStarting
                    S = "update DataSource set isPublic = 'Y' where FileDirectory = '" + FQN$ + "' and DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
                    DB.ExecuteSqlNewConn(S)
                    Me.Cursor = Cursors.Default
                End If
            Else
                SetToPublic = "N"
                Dim S As String = "Update [Directory] set ckPublic = 'N' "
                S = S + " where FQN = '" + FQN$ + "' "
                S = S + " and UserID = '" + gCurrUserGuidID + "'"
                DB.ExecuteSqlNewConn(S)
                If ckPublic.Enabled Then
                    SB.Text = "Standby, updating the repository, this can take a long time."
                    Me.Refresh()
                    Application.DoEvents()
                    Me.Cursor = Cursors.AppStarting
                    S = "update DataSource set isPublic = 'N' where FileDirectory = '" + FQN$ + "' and DataSourceOwnerUserID = '" + gCurrUserGuidID + "'"
                    DB.ExecuteSqlNewConn(S)
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

            'If ckDirProfileMaint.Checked Then

            'End If

            'If txtDir.Text.Trim.Length = 0 Then
            '    messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            '    Return
            'End If
            Dim S1$ = lbAvailExts.SelectedItem.ToString

            For Each S As String In lbAvailExts.SelectedItems
                Dim ItemAlreadyExists As Boolean = False
                For I As Integer = 0 To lbIncludeExts.Items.Count - 1
                    Dim ExistingItem$ = lbIncludeExts.Items(I)
                    If S.ToUpper.Equals(ExistingItem$.ToUpper) Then
                        ItemAlreadyExists = True
                        Exit For
                    End If
                Next
                If ItemAlreadyExists = False Then
                    lbIncludeExts.Items.Add(S)
                    btnSaveChanges.BackColor = Color.OrangeRed
                End If
            Next
        Catch ex As Exception
            log.WriteToArchiveLog("ERROR btnInclFileType_Click : " + ex.Message)
            SB.Text = "Error - please refer to error log."
        End Try

        btnSaveChanges.BackColor = Color.OrangeRed

    End Sub

    Private Sub btnRemoveDir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveDir.Click
        Try

            If clAdminDir.Checked Then
                messagebox.show("Cannot remove a mandatory directory, returning.")
                Return
            End If

            If CkMonitor.Checked Then
                messagebox.show("Cannot remove a directory assigned to a listener, returning.")
                Return
            End If

            Dim iCnt As Integer = lbArchiveDirs.SelectedItems.Count
            If iCnt <= 0 Then
                messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
                Return
            End If
            Dim msg$ = "This will DELETE the selected directory AND ALL SUB-DIRECTORIES from the archive process, are you sure?"
            Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo)
            If dlgRes = Windows.Forms.DialogResult.No Then
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Return
            End If

            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            Dim FQN$ = txtDir.Text.Trim

            Dim S$ = ""
            S += "select DirGuid from Directory "
            S += " where "
            S += " FQN like 'C:\dir%'"
            S += " and UserID = '4841903f-46ff-4cd1-bcf3-6b6d770ff752'"

            Dim B As Boolean = False
            If ckSubDirs.Checked Then
                S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
                S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
                S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
                S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
            Else
                S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
                S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
                S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
                S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + gCurrUserGuidID + "')"
                B = DB.ExecuteSqlNewConn(S)
            End If

            DB.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)

        Catch ex As Exception
            log.WriteToArchiveLog("ERROR btnRemoveDir_Click : No file type selected.")
        End Try

        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        If btnRefresh.Text.Equals("Show Enabled") Then
            lbArchiveDirs.Items.Clear()
            DB.GetDirectories(lbArchiveDirs, gCurrUserGuidID, False)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            btnRefresh.Text = "Show Disabled"
        Else
            lbArchiveDirs.Items.Clear()
            DB.GetDirectories(lbArchiveDirs, gCurrUserGuidID, True)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            btnRefresh.Text = "Show Enabled"
        End If

    End Sub
    Function cvtCkBox(ByVal CB As CheckBox) As String
        Dim S$ = ""
        If CB.Checked = True Then
            S = "Y"
        Else
            S = "N"
        End If
        Return S
    End Function
    Function cvtTF(ByVal tVal) As Boolean
        tVal = UCase(tVal)
        If tVal = "Y" Then
            Return True
        Else
            Return False
        End If

    End Function

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        If Not DB.isAdmin(gCurrUserGuidID) Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            messagebox.show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        Dim msg$ = "This will remove the associated file types, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim ParentFT$ = ""
        Dim ChildFT$ = ""
        Dim S$ = cbProcessAsList.Text
        If S.Length = 0 Then
            messagebox.show("Please select an item to process... returning.")
            Return
        End If

        Dim I As Integer = 0
        Dim J As Integer = 0
        I = InStr(S, "-")
        ParentFT$ = Mid(S, 1, I - 1).Trim
        J = InStr(S, ">")
        ChildFT$ = Mid(S, J + 1).Trim
        PFA.setExtcode(ParentFT$)
        PFA.setProcessextcode(ChildFT$)
        Dim B As Boolean = DB.ckProcessAsExists(ParentFT$)
        If B Then
            B = PFA.Delete("where [ExtCode] = '" + ParentFT$ + "' ")
            If Not B Then
                messagebox.show("Delete failed...")
            Else
                S = "update  [DataSource] set [SourceTypeCode] = '" + ParentFT + "' where [SourceTypeCode] = '" + ChildFT$ + "' and [DataSourceOwnerUserID] = '" + gCurrUserGuidID + "'"
                B = DB.ExecuteSqlNewConn(S, False)
                If B Then
                    SB.Text = ChildFT$ + " Reset to process as " + ParentFT$
                End If
            End If
            DB.GetProcessAsList(cbProcessAsList)
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
            '    Dim D As Double = DB.getDataSourceImageLength(ImageGuid)
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

    Sub ArchiveContent(ByVal CurrUserGuidID As String)

        Dim bExplodeZipFile As Boolean = False
        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)
        Dim ERR_FQN As String = System.Configuration.ConfigurationManager.AppSettings("MoveErrorDir")

        If Not Directory.Exists(ERR_FQN) Then

            Try
                Directory.CreateDirectory(ERR_FQN)
            Catch ex As Exception
                MessageBox.Show("FATAL ERROR: Could not create the directory " + ERR_FQN + ", aborting archive.")
                Return
            End Try

        End If

        Dim ListOfFilesToDelete As New SortedList(Of String, String)
        Dim DeleteOnArchive As String = ""

        Dim ExistingFileTypes As New Dictionary(Of String, Integer)
        DB.LoadFileTypeDictionary(ExistingFileTypes)


        If CurrUserGuidID Is Nothing Then
            CurrUserGuidID = UIDcurr
        End If
        If CurrUserGuidID.Length = 0 Then
            CurrUserGuidID = UIDcurr
        End If

        gContactsArchiving = True

        If gRunMinimized = True Then
            frmNotify.WindowState = FormWindowState.Minimized
        Else
            frmNotify.Show()
        End If

        If gRunMinimized Then
            frmNotify.WindowState = FormWindowState.Minimized
        End If
        frmNotify.Text = "Content"
        frmNotify.Label1.Text = "CONTENT"
        frmNotify.Location = New Point(25, 300)

        If gRunMode.Equals("M-END") Then
            frmNotify.WindowState = FormWindowState.Minimized
        End If

        Dim iContent As Integer = 0
        Dim LastVerNbr As Integer = 0
        Dim NextVersionNbr As Integer = 0
        Dim CRC As String = ""

        If DB.isArchiveDisabled("CONTENT") = True Then
            gContentArchiving = False
            My.Settings("LastArchiveEndTime") = Now
            My.Settings.Save()
            Return
        End If

        Dim PrevParentDir$ = ""


        PROC.getCurrentApplications()

        If ddebug Then log.WriteToArchiveLog("frmReconMain : ArchiveContent :8000 : trace log.")

        Dim RetentionYears As Integer = Val(DB.getSystemParm("RETENTION YEARS"))

        Dim rightNow As Date = Now.AddYears(RetentionYears)
        Dim RetentionExpirationDate$ = rightNow.ToString
        Dim EmailFQN$ = ""
        ZipFilesContent.Clear()
        Dim a$(0)

        CompletedPolls = CompletedPolls + 1

        If UseThreads = False Then SB5.Text = Now & " : Archiving data... standby: " & CompletedPolls

        'Dim ActiveFolders(0)
        Dim ActiveFolders As New List(Of String)
        Dim FolderName$ = ""
        Dim DeleteFile As Boolean = False
        Dim OcrDirectory$ = ""
        Dim OcrPdf As String = ""
        Dim ListOfDisabledDirs As New List(Of String)
        Dim FilesToArchive As New List(Of String)
        Dim LibraryList As New List(Of String)
        Dim DirLibraryList As New List(Of String)

        Dim ThisFileNeedsToBeMoved As Boolean = False
        Dim ThisFileNeedsToBeDeleted As Boolean = False

        '********************************************************************
        DB.GetContentArchiveFileFolders(CurrUserGuidID, ActiveFolders, "")
        DB.getDisabledDirectories(ListOfDisabledDirs)
        '********************************************************************

        Dim cFolder$ = ""
        Dim pFolder$ = "XXX"
        Dim ArchiveMsg$ = ""
        Dim RetentionCode$ = ""

#If EnableSingleSource Then
        bSingleInstanceContent = DB.isSingleInstance() 
        Dim tNewGuid As Guid = GE.AddItem(MachineIDcurr, "GlobalMachine", False)
#Else
        bSingleInstanceContent = False
#End If

        Dim PauseThreadMS As Integer = 0
        Try
            PauseThreadMS = CInt(DB.getUserParm("UserEmail_Pause"))
        Catch ex As Exception
            PauseThreadMS = 0
        End Try


        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8001 : trace log.")

        FilesBackedUp = 0
        FilesSkipped = 0

        If UseThreads = False Then PBx.Value = 0
        If UseThreads = False Then PBx.Maximum = ActiveFolders.Count + 2

        Dim isPublic As String = ""

        Try
            For i As Integer = 0 To ActiveFolders.Count - 1

                iContent += 1
                System.Threading.Thread.Sleep(50)
                Try
                    frmNotify.Label1.Text = "CONTENT " + iContent.ToString
                Catch ex As Exception
                    frmNotify.Close()
                    frmNotify.Show()
                    If gRunMode.Equals("M-END") Then
                        frmNotify.WindowState = FormWindowState.Minimized
                    End If
                End Try
                Application.DoEvents()

                If gTerminateImmediately Then
                    Try
                        Me.Cursor = Cursors.Default
                    Catch ex As Exception

                    End Try

                    If UseThreads = False Then SB5.Text = "Terminated archive!"
                    frmNotify.Close()
                    gContentArchiving = False
                    My.Settings("LastArchiveEndTime") = Now
                    My.Settings.Save()
                    Return
                End If

                If UseThreads = False Then PBx.Value = i
                If UseThreads = False Then PBx.Refresh()
                Application.DoEvents()

                If i >= ActiveFolders.Count Then
                    Exit For
                End If

                Dim FolderParmStr As String = ActiveFolders(i).ToString.Trim
                Dim FolderParms() As String = FolderParmStr.Split("|")

                Dim FOLDER_FQN$ = FolderParms(0)

                If FOLDER_FQN$.Trim.Length > 260 Then
                    FOLDER_FQN$ = getShortDirName(FOLDER_FQN$)
                End If

                Dim bDisabled As Boolean = DB.ckFolderDisabled(CurrUserGuidID, FOLDER_FQN)

                If bDisabled Then
                    LOG.WriteToArchiveLog("Notice: Folder " + FOLDER_FQN + " disabled.")
                    GoTo NextFolder
                End If

                If gClipBoardActive = True Then Console.WriteLine("Arciving : " + FOLDER_FQN$)
                If InStr(FOLDER_FQN$, "%userid%", CompareMethod.Text) Then
                    Dim S1$ = ""
                    Dim S2$ = ""
                    Dim iLoc As Integer = InStr(FOLDER_FQN, "%userid%", CompareMethod.Text)
                    S1 = Mid(FOLDER_FQN, 1, iLoc - 1)
                    S2 = Mid(FOLDER_FQN, iLoc + Len("%userid%"))
                    Dim UserName As String = System.Environment.UserName
                    FOLDER_FQN = S1 + UserName + S2
                End If

                If ListOfDisabledDirs.Contains(FOLDER_FQN$) Then
                    LOG.WriteToArchiveLog("NOTICE: Folder '" + FOLDER_FQN$ + "' is disabled from archive, skipping.")
                    LOG.WriteToArchiveLog("NOTICE: Folder '" + FOLDER_FQN$ + "' is disabled from archive, skipping.")
                    GoTo NextFolder
                End If

                If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8002 :FOLDER_FQN$: " + FOLDER_FQN$)
                Dim ParmMsg As String = ""
                Dim FOLDER_IncludeSubDirs As String = FolderParms(1)
                ParmMsg += "FOLDER_IncludeSubDirs set to " + FOLDER_IncludeSubDirs + " for " + FOLDER_FQN + vbCrLf

                Dim FOLDER_DBID$ = FolderParms(2)
                ParmMsg += "FOLDER_DBID$ set to " + FOLDER_DBID$ + " for " + FOLDER_FQN + vbCrLf

                Dim FOLDER_VersionFiles$ = FolderParms(3)
                ParmMsg += "FOLDER_VersionFiles$ set to " + FOLDER_VersionFiles$ + " for " + FOLDER_FQN + vbCrLf

                Dim DisableDir$ = FolderParms(4)
                ParmMsg += "DisableDir$ set to " + DisableDir$ + " for " + FOLDER_FQN + vbCrLf

                OcrDirectory$ = FolderParms(5)
                ParmMsg += "OcrDirectory$ set to " + OcrDirectory$ + " for " + FOLDER_FQN + vbCrLf

                Dim ParentDir$ = FolderParms(7)
                ParmMsg += "ParentDir$ set to " + ParentDir$ + " for " + FOLDER_FQN + vbCrLf

                Dim skipArchiveBit$ = FolderParms(8)
                ParmMsg += "skipArchiveBit$ set to " + skipArchiveBit$ + " for " + FOLDER_FQN + vbCrLf


                OcrPdf = FolderParms(9)
                If OcrPdf.Equals("Y") Then
                    gPdfExtended = True
                Else
                    gPdfExtended = False
                End If

                DeleteOnArchive = FolderParms(10)
                ParmMsg += "DeleteOnArchive set to " + DeleteOnArchive + " for " + FOLDER_FQN + vbCrLf

                isPublic = FolderParms(11)
                ParmMsg += "isPublic set to " + isPublic + " for " + FOLDER_FQN + vbCrLf

                '***************************
                'MessageBox.Show(ParmMsg)
                '***************************

                Dim ckArchiveBit As Boolean = False

                If skipArchiveBit$.ToUpper.Equals("TRUE") Then
                    ckArchiveBit = True
                Else
                    ckArchiveBit = False
                End If

                FOLDER_FQN$ = UTIL.ReplaceSingleQuotes(FOLDER_FQN$)

                If (Directory.Exists(FOLDER_FQN$)) Then
                    If UseThreads = False Then SB5.Text = "Processing Dir: " + FOLDER_FQN$
                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8003 :FOLDER Exists: " + FOLDER_FQN$)
                    If ddebug Then LOG.WriteToArchiveLog("Archive Folder: " + FOLDER_FQN$)
                Else
                    If UseThreads = False Then SB5.Text = FOLDER_FQN$ + " does not exist, skipping."
                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN$)
                    If ddebug Then LOG.WriteToArchiveLog("Archive Folder FOUND MISSING: " + FOLDER_FQN$)
                    GoTo NextFolder
                End If
                If (DisableDir$.Equals("Y")) Then
                    GoTo NextFolder
                End If

                If ddebug Then
                    If InStr(FOLDER_FQN$, "'") > 0 Then
                        Console.WriteLine("Single Quote found: " + FOLDER_FQN$)
                    End If
                End If

                '******************************************************************************
                If PrevParentDir$ <> ParentDir Then
                    Console.WriteLine(FOLDER_FQN)
                    If InStr(FOLDER_FQN, "army", CompareMethod.Text) > 0 Then
                        Console.WriteLine("HERRE 773")
                    End If
                    DB.GetAllIncludedFiletypes(ParentDir$, IncludedTypes, FOLDER_IncludeSubDirs)
                    DB.GetAllExcludedFiletypes(ParentDir$, ExcludedTypes, FOLDER_IncludeSubDirs)
                End If
                If IncludedTypes.Count = 0 Then
                    DB.GetAllIncludedFiletypes(ParentDir$, IncludedTypes, FOLDER_IncludeSubDirs)
                    DB.GetAllExcludedFiletypes(ParentDir$, ExcludedTypes, FOLDER_IncludeSubDirs)
                End If
                '******************************************************************************
                PrevParentDir$ = ParentDir
                If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8005 : Trace: " + FOLDER_FQN$)
                Dim bChanged As Boolean = False

                If FOLDER_FQN$ <> pFolder$ Then

                    If ddebug Then
                        LOG.WriteToArchiveLog("NOTICE ddebug - 200a: Processing Directory: " + FOLDER_FQN$ + " - defined to " + IncludedTypes.Count.ToString + " filetype codes.")
                    End If

                    '********************************************************************************************************************
                    Dim tFOLDER_FQN As String = UTIL.RemoveSingleQuotes(FOLDER_FQN)
                    Dim iCntFolderIsdefinedForArchive As Integer = 0
                    Dim SS$ = "Select COUNT(*) from Directory where FQN = '" + tFOLDER_FQN + "' and UserID = '" + CurrUserGuidID + "'"
                    iCntFolderIsdefinedForArchive = DB.iCount(SS)
                    If iCntFolderIsdefinedForArchive > 0 Then
                        DB.GetAllIncludedFiletypes(FOLDER_FQN$, IncludedTypes, FOLDER_IncludeSubDirs)
                        DB.GetAllExcludedFiletypes(FOLDER_FQN$, ExcludedTypes, FOLDER_IncludeSubDirs)
                        DB.AddIncludedFiletypes(FOLDER_FQN$, IncludedTypes, FOLDER_IncludeSubDirs)
                        DB.AddExcludedFiletypes(FOLDER_FQN$, ExcludedTypes, FOLDER_IncludeSubDirs)
                    Else
                        DB.GetAllIncludedFiletypes(ParentDir$, IncludedTypes, FOLDER_IncludeSubDirs)
                        DB.GetAllExcludedFiletypes(ParentDir$, ExcludedTypes, FOLDER_IncludeSubDirs)
                        DB.AddIncludedFiletypes(ParentDir$, IncludedTypes, FOLDER_IncludeSubDirs)
                        DB.AddExcludedFiletypes(ParentDir$, ExcludedTypes, FOLDER_IncludeSubDirs)
                    End If
                    '********************************************************************************************************************

#If EnableSingleSource Then
                Dim tDirGuid As Guid  = GE.AddItem(FOLDER_FQN$, "GlobalDirectory", False)
#End If

                    Dim ParentDirForLib As String = ""
                    Dim bLikToLib As Boolean = False
                    bLikToLib = ARCH.isDirInLibrary(FOLDER_FQN$, ParentDirForLib)

                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8006 : Folder Changed: " + FOLDER_FQN$ + ", " + pFolder$)

                    FolderName = FOLDER_FQN$

                    If bLikToLib Then
                        ARCH.GetDirectoryLibraries(ParentDirForLib, LibraryList)
                    Else
                        ARCH.GetDirectoryLibraries(FOLDER_FQN, LibraryList)
                    End If

                    Application.DoEvents()
                    '** Verify that the DIR still exists
                    If (Directory.Exists(FolderName)) Then
                        If UseThreads = False Then SB5.Text = "Processing Dir: " + FolderName
                    Else
                        If UseThreads = False Then SB5.Text = FolderName + " does not exist, skipping."
                        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN$)
                        GoTo NextFolder
                    End If

                    RetentionCode = DB.GetDirRetentionCode(ParentDir$, CurrUserGuidID)
                    If RetentionCode.Length > 0 Then
                        RetentionYears = DB.getRetentionPeriod(RetentionCode)
                    Else
                        RetentionYears = Val(DB.getSystemParm("RETENTION YEARS"))
                    End If

                    DB.getDirectoryParms(a$, ParentDir$, CurrUserGuidID)

                    Dim IncludeSubDirs$ = a(0)
                    Dim VersionFiles$ = a(1)
                    Dim ckMetaData$ = a(2)
                    OcrDirectory$ = a(3)
                    RetentionCode = a(4)
                    OcrPdf = a(5)
                    isPublic = a(6)
                    'a(0) = IncludeSubDirs$
                    'a(1) = VersionFiles$
                    'a(2) = ckMetaData$
                    'a(3) = OcrDirectory
                    'a(4) = RetentionCode
                    'a(5) = OcrPdf
                    'a(6) = ckPublic

                    '*****************************************************************************
                    '** Get all of the files in this folder
                    '*****************************************************************************
                    Dim StepTimer As Date = Now
                    Dim bSubDirFlg As Boolean = False
                    Try
                        If ddebug Then LOG.WriteToArchiveLog("Starting File capture")
                        FilesToArchive.Clear()
                        If ddebug Then LOG.WriteToArchiveLog("Starting File capture: Init FilesToArchive")

                        '**************************************************************************
                        If UseThreads = False Then SB5.Text = FOLDER_FQN$
                        Application.DoEvents()
                        LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "START")
                        'NbrFilesInDir = DMA.getFilesInDir(FOLDER_FQN$, FilesToArchive, IncludedTypes, ExcludedTypes, ckArchiveBit)

                        Dim MSG As String = ""
                        Dim strFileSize As String = ""
                        Dim FilterList As New List(Of String)
                        'Dim ArchiveAttr As Boolean = False
                        Dim sTemp As String = ""

                        For XX As Integer = 0 To IncludedTypes.Count - 1
                            sTemp = IncludedTypes(XX)
                            If InStr(IncludedTypes(XX), ".") = 0 Then
                                sTemp = "." + sTemp
                            End If
                            If InStr(IncludedTypes(XX), "*") = 0 Then
                                sTemp = "*" + sTemp
                            End If
                            FilterList.Add(sTemp)
                        Next

                        If FOLDER_IncludeSubDirs.ToUpper.Equals("Y") Then
                            bSubDirFlg = True
                        End If
                        frmNotify.lblFileSpec.Text = "Standby, directory inventory."
                        frmNotify.Refresh()
                        Dim iInventory As Integer = 0
                        UTIL.GetFilesToArchive(iInventory, ckArchiveBit, bSubDirFlg, FOLDER_FQN$, FilterList, FilesToArchive)
                        frmNotify.lblFileSpec.Text = "Directory inventory complete"
                        frmNotify.Refresh()
                        NbrFilesInDir = FilesToArchive.Count
                        Console.WriteLine("Start: " + Now.ToString)

                        LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "STOP", StepTimer)
                        '**************************************************************************
                        If ddebug Then LOG.WriteToArchiveLog("Starting File capture: Loaded files")
                        If NbrFilesInDir = 0 Then
                            LOG.WriteToArchiveLog("Archive Folder HAD NO FILES: " + FOLDER_FQN$)
                            'GoTo NextFolder
                        End If
                        If ddebug Then LOG.WriteToArchiveLog("Starting File capture: start ckFilesNeedUpdate")
                        '*******************************
                        StepTimer = Now
                        LOG.WriteToTimerLog("ArchiveContent-01", "ckFilesNeedUpdate", "START")
                        If Not DeleteOnArchive.Equals("Y") Then
                            DB.ckFilesNeedUpdate(FilesToArchive, ckArchiveBit)
                        End If

                        LOG.WriteToTimerLog("ArchiveContent-01", "ckFilesNeedUpdate", "STOP", StepTimer)
                        '*******************************
                        If ddebug Then LOG.WriteToArchiveLog("Starting File capture: end ckFilesNeedUpdate")
                    Catch ex As Exception
                        LOG.WriteToArchiveLog("ERROR Archive Folder Acquisition Failure : " + FOLDER_FQN$)
                        GoTo NextFolder
                    End Try
                    Dim ArchIndicator As String = ""
                    '** Process all of the files
                    Dim iTotal As Integer = FilesToArchive.Count
                    iContent += 1
                    Dim InventoryFQN As String = ""
                    For K As Integer = 0 To FilesToArchive.Count - 1

                        bExplodeZipFile = True
                        ThisFileNeedsToBeMoved = False
                        ThisFileNeedsToBeDeleted = False

                        iContent += 1

                        If K Mod 2 = 0 Then
                            If UseThreads = False Then SB5.Text = K & " of " & iTotal
                            Application.DoEvents()
                        End If

                        ArchIndicator = ""
                        If FilesToArchive(K) = Nothing Then
                            GoTo DoneWithIt
                        End If

                        If FilesToArchive(K).Length > 5 Then
                            ArchIndicator = Mid(FilesToArchive(K), 1, 5).ToUpper
                            If ArchIndicator.Equals("FALSE") And ckArchiveBit = True Then
                                GoTo NextFile
                            End If
                        End If



                        If PauseThreadMS > 0 Then
                            System.Threading.Thread.Sleep(50)
                        End If

                        '************************************************************************
                        Dim FileAttributes() As String = FilesToArchive(K).Split("|")
                        Dim file_ArchiveBit As String = FileAttributes(0).ToUpper

                        Dim file_Name As String = FileAttributes(1)
                        Dim file_Extension As String = FileAttributes(2)
                        Dim file_DirectoryName As String = FileAttributes(3)

                        If K > FilesToArchive.Count Then
                            GoTo NextFolder
                        End If
                        If FilesToArchive(K) = Nothing Then
                            GoTo NextFile
                        End If
                        'ArchiveAttr & "|" & fi.Name & "|" & fi.Extension & "|" & fi.DirectoryName & "|" & fi.Length & "|" & fi.CreationTime & "|" & fi.LastWriteTime & "|" & fi.LastAccessTime
                        If ckArchiveBit = True And file_ArchiveBit.Equals("FALSE") Then
                            GoTo NextFile
                        End If

                        '************************************************************************

                        InventoryFQN = file_DirectoryName + "\" + file_Name

                        Dim UpdateTimerMain As Date = Now

                        If InStr(FilesToArchive(K), ".pdf", CompareMethod.Text) > 0 Then
                            Console.WriteLine("Here XXX: " + FilesToArchive(K))
                        End If

                        frmNotify.Label1.Text = "CONTENT " + iContent.ToString & " - " & iTotal

                        frmNotify.Refresh()
                        Application.DoEvents()

                        If gTerminateImmediately Then
                            Try
                                Me.Cursor = Cursors.Default
                            Catch ex As Exception

                            End Try
                            If UseThreads = False Then SB5.Text = "Terminated archive!"
                            frmNotify.Close()
                            gContentArchiving = False
                            My.Settings("LastArchiveEndTime") = Now
                            My.Settings.Save()
                            Return
                        End If

                        '________________________________________
                        CRC = ""
                        '________________________________________
                        'If K Mod 10 = 0 Then
                        If UseThreads = False Then SB5.Text = "Directory Files processed: " + K.ToString + " OF " & FilesToArchive.Count
                        Application.DoEvents()

                        'End If

                        '**************************************************************
                        '**************************************************************

                        If ListOfDisabledDirs.Contains(file_DirectoryName) Then
                            GoTo NextFile
                        End If
                        Dim file_Length As Integer = Val(FileAttributes(4))
                        If file_Length = 0 Then
                            GoTo NextFile
                        End If
                        Dim file_CreationTime As Date = CDate(FileAttributes(5))
                        Dim file_LastWriteTime As Date = CDate(FileAttributes(6))
                        Dim file_LastAccessTime As Date = CDate(FileAttributes(7))

                        Dim file_FullName As String = file_DirectoryName + "\" + file_Name
                        '*******************************************************************
                        If DeleteOnArchive.Equals("Y") Then
                            If Not ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                ListOfFilesToDelete.Add(file_FullName, "UKN")
                            End If
                        End If
                        '*******************************************************************
                        Dim SourceGuid As String = DB.getGuid()

                        'LOG.WriteToFileProcessLog(file_FullName)
                        LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "START")

                        If InStr(file_FullName, "\ECM\ErrorFile\", CompareMethod.Text) > 0 Then
                            Console.WriteLine("Skipping: " + file_FullName)
                            GoTo DoneWithIt
                        End If

                        If gMaxSize > 0 Then
                            If Val(file_Length) > gMaxSize Then
                                LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.")
                                GoTo NextFile
                            End If
                        End If

                        file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                        file_FullName = UTIL.RemoveSingleQuotes(file_FullName)

#If EnableSingleSource Then
                    Dim tFileGuid As Guid = GE.AddItem(file_FullName, "GlobalFile", False)
#End If

                        'FrmMDIMain.SB4.Text = file_FullName

                        Dim ckFileKey As Boolean = False
                        If ckFileKey Then
                            Dim UniqueFileKey$ = FI.genFileKey(file_FullName)
                            Dim sHash$ = ENC.AES256EncryptString(UniqueFileKey$, "EcmLibrary")
                            'This area of code will be used to provide single instance files
                            'Uses tables:
                            'FileKey - Search this table for UniqueFileKey$
                            'FileKeyMachine - Search this table Unique SOurce file and Machine
                            'FileKeyMachineDir - Search this table Unique SOurce file and Machine and Directory
                        End If

                        'Dim bIsArchivedAlready As Boolean = DMA.isFileArchiveAttributeSet(file_FullName)
                        'If bIsArchivedAlready = True And ckArchiveBit.Checked = True Then
                        '    If ddebug Then log.WriteToArchiveLog("File : " + file_FullName + " archive bit was found TRUE, skipped file.")
                        '    If ddebug Then log.WriteToArchiveLog("NOTICE: File : " + file_FullName + " archive bit was found TRUE, skipped file.")
                        '    GoTo NextFile
                        'End If

                        'Dim file_DirName = DMA.GetFilePath(file_FullName)
                        'Dim file_Extension = FileAttributes(3)

                        '** If version files is NO and already in REPO, skip it right here
                        'If UCase(FOLDER_VersionFiles$).Equals("N") Then
                        '    Dim bFileAlreadyExist As Boolean = DB.ckDocumentExists(file_FullName, MachineName$, CurrUserGuidID)
                        '    If bFileAlreadyExist = True Then
                        '        GoTo NextFile
                        '    End If
                        'End If

                        If file_Extension.Equals(".msg") Then
                            LOG.WriteToArchiveLog("NOTICE: Content Archive File : " + file_FullName + " was found to be a message file, moved file.")
                            If MsgNotification = False Or gRunUnattended = True Then
                                Dim DisplayMsg$ = "A message file was encounted in a backup directory." + vbCrLf
                                DisplayMsg$ = DisplayMsg$ + "It has been moved to the EMAIL Working directory." + vbCrLf
                                DisplayMsg$ = DisplayMsg$ + "To archive a MSG file, it should be imported into outlook." + vbCrLf
                                DisplayMsg$ = DisplayMsg$ + "This file has ALSO been added to the CONTENT repository." + vbCrLf
                                frmHelp.MsgToDisplay$ = DisplayMsg$
                                frmHelp.CallingScreenName$ = "ECM Archive"
                                frmHelp.CaptionName$ = "MSG File Encounted in Content Archive"
                                frmHelp.Timer1.Interval = 10000
                                frmHelp.Show()
                                MsgNotification = True
                                If gRunUnattended = True Then
                                    LOG.WriteToArchiveLog("WARNING: ArchiveContent 100: " + vbCrLf + DisplayMsg)
                                End If
                            End If

                            Dim EmailWorkingDirectory$ = DB.getWorkingDirectory(CurrUserGuidID, "EMAIL WORKING DIRECTORY")

                            EmailWorkingDirectory$ = UTIL.RemoveSingleQuotes(EmailWorkingDirectory$)
                            file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                            EmailFQN$ = EmailWorkingDirectory$ + "\" + file_FullName.Trim

                            file_FullName = UTIL.RemoveSingleQuotes(file_FullName)

                            If File.Exists(EmailFQN) Then
                                Dim tMsg$ = "Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN
                                LOG.WriteToArchiveLog(tMsg$)
                                DB.xTrace(965, "ArchiveContent", tMsg)
                                'FilesSkipped += 1
                            Else
                                File.Copy(file_FullName, EmailFQN)
                                Dim tMsg$ = "Email File Encountered, moved to EMAIL WORKING DIRECTORY and entered into repository: " + EmailFQN
                                DB.xTrace(966, "ArchiveContent", tMsg)
                                'FilesSkipped += 1
                            End If
                            'GoTo NextFile
                        End If

                        'Dim file_LastAccessTime As String = FileAttributes(4)
                        'Dim file_CreationTime = FileAttributes(5)
                        'Dim file_LastWriteTime = FileAttributes(6)
                        'Dim file_Extension = file_Extension

                        'Console.WriteLine(CDate(file_LastAccessTime))

                        ARCH.ckSourceTypeCode(file_Extension)

                        If LCase(file_Extension).Equals(".pdf") Then
                            Debug.Print(file_FullName)
                        End If
                        If LCase(file_Extension).Equals(".zip") Then
                            Debug.Print(file_FullName)
                        End If
                        If LCase(file_Extension).Equals(".png") Then
                            Debug.Print(file_FullName)
                        End If
                        If LCase(file_Extension).Equals(".jpg") Then
                            Debug.Print(file_FullName)
                        End If
                        If LCase(file_Extension).Equals(".iso") Then
                            Debug.Print(file_FullName)
                        End If


                        Dim isZipFile As Boolean = ZF.isZipFile(file_FullName)
                        'If isZipFile = True Then
                        '    Dim ExistingParentZipGuid$ = DB.GetGuidByFqn(file_FullName, 0)
                        '    If ExistingParentZipGuid.Length > 0 Then
                        '        ZipFilesContent.Add(file_FullName.Trim + "|" + ExistingParentZipGuid)
                        '    Else
                        '        ZipFilesContent.Add(file_FullName.Trim + "|" + SourceGuid)
                        '    End If
                        'End If

                        Application.DoEvents()

                        If Not isZipFile Then
                            Dim bExt As Boolean = DMA.isExtExcluded(file_Extension, ExcludedTypes)
                            If bExt Then
                                FilesSkipped += 1
                                GoTo NextFile
                            End If
                            '** See if the STAR is in the INCLUDE list, if so, all files are included
                            bExt = DMA.isExtIncluded(file_Extension, ExcludedTypes)
                            If bExt Then
                                FilesSkipped += 1
                                GoTo NextFile
                            End If
                        Else
                            Console.WriteLine("Zipfile Found.")
                        End If

                        '** This NEEDS to be in a keyed array
                        Dim bcnt As Integer = 0
                        If ExistingFileTypes.ContainsKey(file_Extension) Then
                            bcnt = 1
                        End If
                        'Dim bcnt As Integer = DB.iGetRowCount("SourceType", "where SourceTypeCode = '" + file_Extension + "'")

                        If bcnt = 0 Then
                            Dim SubstituteFileType$ = DB.getProcessFileAsExt(file_Extension)
                            If SubstituteFileType$ = Nothing Then
                                Dim MSG$ = "The file type '" + file_Extension + "' is undefined." + vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + vbCrLf + "This will allow content to be archived, but not searched."
                                'Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                                If ddebug Then LOG.WriteToArchiveLog(MSG)

                                UNASGND.setApplied("0")
                                UNASGND.setFiletype(file_Extension)
                                Dim xCnt As Integer = UNASGND.cnt_PK_AFTU(file_Extension)
                                If xCnt = 0 Then
                                    UNASGND.Insert()
                                End If

                                Dim ST As New clsSOURCETYPE
                                ST.setSourcetypecode(file_Extension)
                                ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm")
                                ST.setIndexable("0")
                                ST.setStoreexternal(0)
                                ST.Insert()

                            Else
                                file_Extension = SubstituteFileType$
                            End If

                        End If

                        EmailFQN$ = UTIL.RemoveSingleQuotes(EmailFQN)
                        file_FullName = UTIL.RemoveSingleQuotes(file_FullName)

                        Dim ssFile As String = ""
                        ssFile = DMA.getFileName(file_FullName)
                        frmNotify.lblFileSpec.Text = "FILE: " + ssFile + " : " + file_Length.ToString
                        frmNotify.Refresh()

                        Dim StoredExternally$ = "N"

                        Dim iCnt As Integer = 0

                        'If bSingleInstanceContent = True And Not FOLDER_VersionFiles$.Equals("Y") Then
                        If bSingleInstanceContent = True Then
                            CRC$ = DMA.CalcCRC(file_FullName)
                            Dim VersionNbr = 0
                            Dim tSourceGuid$ = DB.getCountDataSourceFiles(file_Name, file_Extension, Val(file_Length), CRC$)
                            If tSourceGuid$.Length = 0 Then
                                '** It is new - just fall thru and let 'er rip
                                bAddThisFileAsNewVersion = True
                                DB.GetMaxDataSourceVersionNbr(file_Name, CRC$, file_Length)
                                NextVersionNbr = LastVerNbr + 1
                                DB.AddMachineSource(file_FullName, SourceGuid)

                                DB.AddContentOwner(SourceGuid, CurrUserGuidID)

                                GoTo InsertNewVersion
                            Else
                                '** It already exist somewhere
                                bAddThisFileAsNewVersion = False

                                DB.AddMachineSource(file_FullName, tSourceGuid$)
                                DB.AddContentOwner(SourceGuid, CurrUserGuidID)

                                GoTo NextFile
                            End If
                        Else
                            iCnt = DOCS.cnt_PI_FQN_USERID(CurrUserGuidID, file_FullName)
                        End If

                        Application.DoEvents()

                        '***********************************************************************'
                        '** New file
                        '***********************************************************************'
                        Dim BB As Boolean = False
                        If iCnt = 0 Then

                            Dim TS As TimeSpan
                            Dim sTime As Date = Now
                            Dim sMin As String = ""
                            Dim sSec As String = ""
                            If ddebug Then LOG.WriteToArchiveLog("INFO: File - " + file_FullName + " was found to be NEW and not in the repository.")
                            'Me.if UseThreads = false then SB5.Text = "Loading: " + file_Name
                            Application.DoEvents()
                            LastVerNbr = 0

                            iCnt = DB.getCountDataSourceFiles(CurrUserGuidID, file_FullName, LastVerNbr.ToString)
                            If iCnt > 0 Then
                                If ddebug Then LOG.WriteToArchiveLog("Warning File : " + file_FullName + " was found to be NEW and WAS ACTUALLY in the repository, skipped it.")
                                FilesSkipped += 1
                                GoTo NextFile
                            End If
                            frmNotify.lblFileSpec.ForeColor = Color.Black
                            frmNotify.lblFileSpec.BackColor = Color.White
                            Dim BytesLoading As Double = file_Length
                            Dim Units As String = ""
                            If BytesLoading > 1000 Then
                                BytesLoading = BytesLoading / 1000
                                Units = "KB"
                                Math.Round(BytesLoading - 0.005, 2)
                            End If
                            If BytesLoading > 100000 Then
                                BytesLoading = BytesLoading / 1000
                                Units = "KB"
                                Math.Round(BytesLoading - 0.005, 2)
                                frmNotify.lblFileSpec.BackColor = Color.WhiteSmoke
                                frmNotify.lblFileSpec.ForeColor = Color.Black
                            End If
                            If BytesLoading > 1000000 Then
                                BytesLoading = BytesLoading / 1000000
                                Units = "MB"
                                Math.Round(BytesLoading - 0.005, 2)
                                frmNotify.lblFileSpec.ForeColor = Color.Red
                            End If
                            If BytesLoading > 1000000000 Then
                                BytesLoading = BytesLoading / 1000000000
                                Units = "GB"
                                Math.Round(BytesLoading - 0.005, 2)
                                frmNotify.lblFileSpec.BackColor = Color.Red
                                frmNotify.lblFileSpec.ForeColor = Color.White
                            End If

                            Application.DoEvents()

                            If Val(file_Length) > 1000000000 Then
                                frmNotify.lblFileSpec.Text = "Huge File:" + BytesLoading.ToString + Units
                                Application.DoEvents()
                                DisplayActivity = True
                                If ActivityThread Is Nothing Then
                                    frmPercent.TopLevel = True
                                    ActivityThread = New Thread(AddressOf ActivateProgressBar)
                                    ActivityThread.Priority = ThreadPriority.Lowest
                                    ActivityThread.IsBackground = True
                                    ActivityThread.Start()
                                End If
                                gfile_Length = Val(file_Length)
                            ElseIf Val(file_Length) > 3000000 Then
                                gfile_Length = Val(file_Length)
                                frmNotify.lblFileSpec.Text = "Large File:" + BytesLoading.ToString + Units
                                Application.DoEvents()
                                DisplayActivity = True
                                If ActivityThread Is Nothing Then
                                    frmPercent.TopLevel = True
                                    ActivityThread = New Thread(AddressOf ActivateProgressBar)
                                    ActivityThread.Priority = ThreadPriority.Lowest
                                    ActivityThread.IsBackground = True
                                    ActivityThread.Start()
                                End If
                            End If

                            If iCnt = 0 Then
                                StepTimer = Now
                                LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content", "START")
                                'file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                                'file_Name = UTIL.RemoveSingleQuotes(file_Name)

                                DOCS.setSourceguid(SourceGuid)
                                DOCS.setFqn(file_FullName)
                                DOCS.setSourcename(file_Name)
                                DOCS.setSourcetypecode(file_Extension)
                                DOCS.setLastaccessdate(file_LastAccessTime)
                                DOCS.setCreatedate(file_CreationTime)
                                DOCS.setCreationdate(file_CreationTime)
                                DOCS.setLastwritetime(file_LastWriteTime)
                                DOCS.setDatasourceowneruserid(CurrUserGuidID)
                                DOCS.setVersionnbr("0")
                                BB = DOCS.Insert()
                                LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content: " + file_FullName, "STOP", StepTimer)
                                If BB Then

                                    If Not DeleteOnArchive.Equals("Y") Then
                                        DBLocal.addInventoryForce(file_FullName, ckArchiveBit)
                                    Else
                                        DBLocal.delFile(file_FullName)
                                    End If

                                    Dim UpdateTimer As Date = Now

                                    '*************************************************
                                    DB.AddContentOwner(SourceGuid, CurrUserGuidID)
                                    '*************************************************

                                    UpdateTimer = Now
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage", "START")
                                    Dim OriginalFileName As String = DMA.getFileName(file_FullName)
                                    BB = DB.UpdateSourceImage(OriginalFileName, UIDcurr, MachineIDcurr, SourceGuid, file_LastAccessTime, file_CreationTime, file_LastWriteTime, LastVerNbr, file_FullName, RetentionCode, isPublic)
                                    DB.addContentHashKey(SourceGuid, 0, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage", "STOP", UpdateTimer)
                                    '****************************************************************************************************************************
                                    If Not BB Then
                                        'Dim isIncludedAsSubDir As Boolean = DB.isSubDirIncluded(FOLDER_FQN$)
                                        Dim MySql$ = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'"
                                        DB.ExecuteSqlNewConn(MySql)
                                        LOG.WriteToErrorLog("Unrecoverable LOAD Error - removed file '" + file_FullName + "' from the repository.")
                                        If UseThreads = False Then SB5.BackColor = Color.Red
                                        If UseThreads = False Then SB5.ForeColor = Color.Yellow

                                        Dim DisplayMsg$ = "A source file failed to load. Review ERROR log."
                                        frmHelp.MsgToDisplay$ = DisplayMsg$
                                        frmHelp.CallingScreenName$ = "ECM Archive"
                                        frmHelp.CaptionName$ = "Fatal Load Error"
                                        frmHelp.Timer1.Interval = 10000
                                        frmHelp.Show()
                                    Else
                                        If LibraryList.Count > 0 Then
                                            For II As Integer = 0 To LibraryList.Count - 1
                                                Dim LibraryName$ = LibraryList(II)
                                                ARCH.AddLibraryItem(SourceGuid, file_Name, file_Extension, LibraryName$)
                                            Next
                                        End If
                                    End If
                                Else
                                    LOG.WriteToArchiveLog("Error 22.345.23a - Failed to add source:" + file_FullName)
                                End If

                                file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                                file_Name = UTIL.RemoveSingleQuotes(file_Name)
                            End If

                            'If iCnt = 0 Then
                            '    TS = Now().Subtract(sTime)
                            '    sMin = TS.Minutes.ToString
                            '    sSec = TS.Seconds.ToString
                            '    frmNotify.lblFileSpec.Text = "Size: " + BytesLoading.ToString + Units + " / " + TS.Hours.ToString + ":" + sMin + ":" + sSec
                            '    frmNotify.Refresh()
                            '    Application.DoEvents()
                            'End If


                            If BB Then
                                FilesBackedUp += 1

                                file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                                file_Name = UTIL.RemoveSingleQuotes(file_Name)

                                If DeleteOnArchive.Equals("Y") Then
                                    If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                        'Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                        Try
                                            ListOfFilesToDelete.Item(file_FullName) = "DELETE"
                                        Catch ex As Exception
                                            Console.WriteLine(ex.Message)
                                        End Try
                                    ElseIf Not ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                        ListOfFilesToDelete.Add(file_FullName, "DELETE")
                                    End If
                                End If

                                If CRC$.Length = 0 Then
                                    CRC$ = DMA.CalcCRC(file_FullName)
                                End If
                                ARCH.UpdateDocCrc(SourceGuid, CRC$)

                                If file_Extension.ToUpper.Equals(".PDF") Then
                                    If OcrPdf.Equals("Y") Then
                                        Dim bPdfSearchable = UTIL.ckPdfSearchable(file_FullName)
                                        If bPdfSearchable Then
                                            Dim tSql As String = "Update DataSource set PdfIsSearchable = 'Y' where SourceGuid = '" + SourceGuid + "' "
                                            DB.ExecuteSqlNewConn(tSql)
                                        Else
                                            Dim tSql As String = "Update DataSource set PdfIsSearchable = 'N' where SourceGuid = '" + SourceGuid + "' "
                                            DB.ExecuteSqlNewConn(tSql)
                                        End If

                                        If bPdfSearchable = True Then
                                            LOG.WriteToArchiveLog("Notification: PDF " + file_FullName + " appears to be searchable, skipped OCR.")
                                        Else
#If RemoteOcr Then
                                            Dim CMODI As New clsModi
                                            Dim DTE3 As Date = Now
                                            LOG.WriteToTimerLog("ArchiveContent", "PDFExtract", "START")

                                            Dim PDF As New clsPdfAnalyzer
                                            Dim PageCnt As Integer = PDF.CountPdfImages(file_FullName)
                                            frmNotify.lblPdgPages.Text = "PDF: " + PageCnt.ToString
                                            frmNotify.Refresh()
                                            PDF = Nothing
                                            GC.Collect()

                                            CMODI.PDFExtract(SourceGuid, file_FullName, "CONTENT")
                                            LOG.WriteToTimerLog("ArchiveContent", "PDFExtract", "START", DTE3)
                                            CMODI = Nothing
#Else
                                            Dim CMODI As New clsModi
                                            Dim DTE3 As Date = Now

                                            Dim PDF As New clsPdfAnalyzer
                                            Dim PageCnt As Integer = PDF.CountPdfImages(file_FullName)
                                            frmNotify.lblPdgPages.Text = "PDF: " + PageCnt.ToString
                                            frmNotify.Refresh()
                                            PDF = Nothing
                                            GC.Collect()

                                            CMODI.PdfExtractLocal("CONTENT", file_FullName, SourceGuid)
                                            CMODI = Nothing
                                            frmNotify.lblPdgPages.Text = " "
                                            GC.Collect()
                                            GC.WaitForPendingFinalizers()
#End If

                                        End If
                                    Else
                                        LOG.WriteToArchiveLog("NOTICE: PDF Ocr is not selected - " + file_FullName)
                                    End If
                                End If

                                Dim bIsImageFile As Boolean = DB.isImageFile(file_FullName)

                                DB.UpdateCurrArchiveStats(file_FullName, file_Extension)
                                If OcrDirectory$.Equals("Y") And bIsImageFile = True Then
                                    Dim OcrTimer As Date = Now
                                    Application.DoEvents()
                                    LOG.WriteToTimerLog("ArchiveContent-01", "OcrThisFile", "START", OcrTimer)
                                    If InStr(file_FullName, "ECM.PDF.Image", CompareMethod.Text) Then
                                        If UseThreads = False Then SB5.Text = "OCR PDF Image"
                                    Else
                                        If UseThreads = False Then SB5.Text = "OCR Graphic"
                                    End If

                                    Dim sFile As String = DMA.getFileName(file_FullName)
                                    frmNotify.lblFileSpec.Text = "OCR: " + sFile
                                    frmNotify.Refresh()
#If RemoteOcr Then
                                    Dim RC As Boolean = False
                                    CMODI.OcrThisFile(False, file_FullName, SourceGuid, RC)
                                    If Not RC Then
                                        LOG.WriteToArchiveLog("ERROR OCR Failed 1055.55e - " + file_FullName)
                                        If DeleteOnArchive.Equals("Y") Then
                                            If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                                ListOfFilesToDelete.Item(file_FullName) = "MOVE"
                                            ElseIf Not ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                ListOfFilesToDelete.Add(file_FullName, "MOVE")
                                            End If
                                        End If
                                    End If
                                    LOG.WriteToTimerLog("ArchiveContent-01", "OcrThisFile", "STOP", Now)
                                    Application.DoEvents()
#Else
                                    Dim RC As Boolean = False
                                    CMODI.OcrThisFile(False, file_FullName, SourceGuid, RC)
                                    If Not RC Then
                                        LOG.WriteToArchiveLog("ERROR OCR Failed 1055.55e - " + file_FullName)
                                        If DeleteOnArchive.Equals("Y") Then
                                            If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                                ListOfFilesToDelete.Item(file_FullName) = "MOVE"
                                            ElseIf Not ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                ListOfFilesToDelete.Add(file_FullName, "MOVE")
                                            End If
                                        End If
                                    End If
                                    LOG.WriteToTimerLog("ArchiveContent-01", "OcrThisFile", "STOP", Now)
                                    Application.DoEvents()
#End If


                                End If
                                If OcrDirectory$.Equals("N") And bIsImageFile = True Then
                                    DB.SetOcrAttributesToNotPerformed(SourceGuid)
                                End If
                            Else
                                FilesSkipped += 1
                                If ddebug Then LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.")
                                If ddebug Then LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.")
                                Debug.Print("FAILED TO LOAD: " + file_FullName)
                                If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :FAILED TO LOAD: 8013a: " + file_FullName)
                            End If


                            If Val(file_Length) > 1000000 Then
                                If UseThreads = False Then SB5.Text = "Large file Load completed..."
                                DisplayActivity = False
                                If Not ActivityThread Is Nothing Then
                                    ActivityThread.Abort()
                                    ActivityThread = Nothing
                                End If
                                Me.PBx.Value = 0
                                Application.DoEvents()
                            End If
                            If BB Then
                                Dim UpdateTimer2 As Date = Now
                                LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "START")

                                Application.DoEvents()
                                DB.UpdateDocFqn(SourceGuid, file_FullName)
                                DB.UpdateDocSize(SourceGuid, file_Length)
                                DB.UpdateDocDir(SourceGuid, file_FullName)
                                DB.UpdateDocOriginalFileType(SourceGuid, file_Extension)
                                DB.UpdateZipFileIndicator(SourceGuid, isZipFile)
                                Application.DoEvents()
                                If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8015")
                                If Not isZipFile Then
                                    'Dim TheFileIsArchived As Boolean = True
                                    'DMA.setFileArchiveAttributeSet(file_FullName, TheFileIsArchived)
                                    DMA.setArchiveBitOff(file_FullName)
                                End If

                                'DB.delFileParms(SourceGuid)
                                If CRC$.Length = 0 Then
                                    CRC$ = DMA.CalcCRC(file_FullName)
                                End If
                                ARCH.UpdateDocCrc(SourceGuid, CRC$)

                                '** Removed Attribution Classification by WDM 9/10/2009
                                UpdateSrcAttrib(SourceGuid, "CRC", CRC$, file_Extension)
                                UpdateSrcAttrib(SourceGuid, "FILENAME", file_Name, file_Extension)
                                UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreationTime, file_Extension)
                                UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, file_Extension)
                                UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessTime, file_Extension)
                                UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, file_Extension)

                                DB.AddMachineSource(file_FullName, SourceGuid)

                                If Val(file_Length) > 1000000000 Then
                                    'FrmMDIMain.SB4.Text = "Extreme File: " + file_Length + " bytes - standby"
                                ElseIf Val(file_Length) > 2000000 Then
                                    'FrmMDIMain.SB4.Text = "Large File: " + file_Length + " bytes"
                                End If
                                If (LCase(file_Extension).Equals(".mp3") Or LCase(file_Extension).Equals(".wma") Or LCase(file_Extension).Equals("wma")) Then
                                    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)
                                    Application.DoEvents()
                                ElseIf (LCase(file_Extension).Equals(".tiff") Or LCase(file_Extension).Equals(".jpg")) Then
                                    '** This functionality will be added at a later time
                                    'KAT.getXMPdata(file_FullName)
                                    Application.DoEvents()
                                ElseIf (LCase(file_Extension).Equals(".png") Or LCase(file_Extension).Equals(".gif")) Then
                                    '** This functionality will be added at a later time
                                    'KAT.getXMPdata(file_FullName)
                                    Application.DoEvents()
                                    'ElseIf LCase(file_Extension).Equals(".wav") Then
                                    '    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)
                                ElseIf LCase(file_Extension).Equals(".wma") Then
                                    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)
                                ElseIf LCase(file_Extension).Equals(".tif") Then
                                    '** This functionality will be added at a later time
                                    'KAT.getXMPdata(file_FullName)
                                    Application.DoEvents()
                                End If
                                Application.DoEvents()
                                If (LCase(file_Extension).Equals(".doc") _
                                        Or LCase(file_Extension).Equals(".docx")) _
                                        And ckMetaData$.Equals("Y") Then
                                    GetWordDocMetadata(file_FullName, SourceGuid, file_Extension)
                                    GC.Collect()
                                End If
                                If (file_Extension.Equals(".xls") _
                                            Or file_Extension.Equals(".xlsx") _
                                            Or file_Extension.Equals(".xlsm")) _
                                            And ckMetaData$.Equals("Y") Then
                                    GetExcelMetaData(file_FullName, SourceGuid, file_Extension)
                                    GC.Collect()
                                End If
                                LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "STOP", UpdateTimer2)
                            End If

                            TS = Now().Subtract(sTime)
                            sMin = TS.Minutes.ToString
                            sSec = TS.Seconds.ToString
                            frmNotify.lblFileSpec.Text = "Size: " + BytesLoading.ToString + Units + " / " + TS.Hours.ToString + ":" + sMin + ":" + sSec
                            frmNotify.Refresh()
                            Application.DoEvents()

                            isZipFile = ZF.isZipFile(file_FullName)
                            If isZipFile = True Then
                                Dim ExistingParentZipGuid$ = DB.GetGuidByFqn(file_FullName, 0)
                                bExplodeZipFile = False
                                StackLevel = 0
                                ListOfFiles.Clear()
                                If ExistingParentZipGuid.Length > 0 Then
                                    DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, False)
                                    ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                    'ZipFilesContent.Add(file_FullName.Trim + "|" + ExistingParentZipGuid)
                                Else
                                    DBLocal.addZipFile(file_FullName, SourceGuid, False)
                                    ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                    'ZipFilesContent.Add(file_FullName.Trim + "|" + SourceGuid)
                                End If
                            End If

                        Else

                            '***********************************************************************'
                            '** File Exists, has it changed?
                            If Not DeleteOnArchive.Equals("Y") Then
                                DBLocal.addInventoryForce(file_FullName, ckArchiveBit)
                            Else
                                DBLocal.delFile(file_FullName)
                            End If

                            Dim ParentSourceGuid As String = DB.getSourceGuidByFqn(file_FullName, gCurrUserGuidID)
                            DB.addContentHashKey(ParentSourceGuid, LastVerNbr, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)
                            '***********************************************************************'

                            If ddebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " found to already EXIST in the repository.")
                            If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8020")
                            If UCase(FOLDER_VersionFiles$).Equals("Y") Then
                                If ddebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " Versioned.")
                                If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8021")
                                '** Get the last version number of this file in the repository,

                                LastVerNbr = DB.GetMaxDataSourceVersionNbr(CurrUserGuidID, file_FullName)


                                NextVersionNbr = LastVerNbr + 1
                                '** See if this version has been changed
                                bChanged = DB.isSourcefileOlderThanLastEntry(CurrUserGuidID, _
                                          SourceGuid, _
                                          file_FullName, _
                                          file_FullName, _
                                          file_Extension, _
                                          file_Length, _
                                          file_LastAccessTime, _
                                          file_CreationTime, _
                                          file_LastWriteTime, _
                                          LastVerNbr.ToString)
                                '** If it has, add it to the repository
                                If bChanged Then

                                    Dim UpdateTimer As Date = Now
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage3", "START")

                                    If ddebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " is Versioned and has Changed.")
                                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8022")
InsertNewVersion:
                                    BB = DB.InsertSourcefile(UIDcurr, MachineIDcurr, SourceGuid, _
                                                             file_FullName, _
                                                             file_Name, _
                                                             file_Extension, _
                                                             file_LastAccessTime, _
                                                             file_CreationTime, _
                                                             file_LastWriteTime, _
                                                             CurrUserGuidID, _
                                                             NextVersionNbr, RetentionCode, isPublic)
                                    If BB Then
                                        DB.addContentHashKey(SourceGuid, NextVersionNbr, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)
                                        isZipFile = ZF.isZipFile(file_FullName)
                                        If isZipFile = True Then
                                            bExplodeZipFile = False
                                            Dim ExistingParentZipGuid$ = DB.GetGuidByFqn(file_FullName, NextVersionNbr)
                                            StackLevel = 0
                                            ListOfFiles.Clear()
                                            If ExistingParentZipGuid.Length > 0 Then
                                                DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, False)
                                                ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                            Else
                                                DBLocal.addZipFile(file_FullName, SourceGuid, False)
                                                ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                            End If
                                        End If

                                        DB.AddContentOwner(SourceGuid, CurrUserGuidID)

                                        If LibraryList.Count > 0 Then
                                            'wdmxx
                                            For II As Integer = 0 To LibraryList.Count - 1
                                                Dim LibraryName$ = LibraryList(II)
                                                ARCH.AddLibraryItem(SourceGuid, file_Name, file_Extension, LibraryName$)
                                            Next
                                        End If

                                        FilesBackedUp += 1
                                        If ddebug Then LOG.WriteToArchiveLog("File : " + file_FullName + " Change applied.")
                                        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8023")

                                        If CRC$.Length = 0 Then
                                            CRC$ = DMA.CalcCRC(file_FullName)
                                        End If
                                        ARCH.UpdateDocCrc(SourceGuid, CRC$)

                                        If file_Extension.ToUpper.Equals(".PDF") Then
                                            If OcrPdf.Equals("Y") Then

                                                Dim bPdfSearchable = UTIL.ckPdfSearchable(file_FullName)
                                                If bPdfSearchable Then
                                                    Dim tSql As String = "Update DataSource set PdfIsSearchable = 'Y' where SourceGuid = '" + SourceGuid + "' "
                                                    DB.ExecuteSqlNewConn(tSql)
                                                Else
                                                    Dim tSql As String = "Update DataSource set PdfIsSearchable = 'N' where SourceGuid = '" + SourceGuid + "' "
                                                    DB.ExecuteSqlNewConn(tSql)
                                                End If

                                                If bPdfSearchable = True Then
                                                    LOG.WriteToArchiveLog("Notification: PDF " + file_FullName + " appears to be searchable, skipped OCR.")
                                                Else
#If RemoteOcr Then
                                                    Dim PDF As New clsPdfAnalyzer
                                                    Dim PageCnt As Integer = PDF.CountPdfImages(file_FullName)
                                                    frmNotify.lblPdgPages.Text = "PDF: " + PageCnt.ToString
                                                    frmNotify.Refresh()
                                                    PDF = Nothing
                                                    GC.Collect()

                                                    Dim CMODI As New clsModi
                                                    CMODI.PDFExtract(SourceGuid, file_FullName, "CONTENT")
                                                    CMODI = Nothing
#Else
                                                    Dim PDF As New clsPdfAnalyzer
                                                    Dim PageCnt As Integer = PDF.CountPdfImages(file_FullName)
                                                    frmNotify.lblPdgPages.Text = "PDF: " + PageCnt.ToString
                                                    frmNotify.Refresh()
                                                    PDF = Nothing
                                                    GC.Collect()

                                                    Dim CMODI As New clsModi
                                                    CMODI.PdfExtractLocal("CONTENT", file_FullName, SourceGuid)
                                                    CMODI = Nothing
#End If
                                                End If
                                            Else
                                                LOG.WriteToArchiveLog("NOTICE: PDF Ocr is not selected - " + file_FullName)
                                            End If
                                        End If

                                        DB.UpdateCurrArchiveStats(file_FullName, file_Extension)
                                        Dim bIsImageFile As Boolean = DB.isImageFile(file_FullName)

                                        If OcrDirectory$.Equals("Y") Then
#If RemoteOcr Then
                                            Dim RC As Boolean = False
                                            CMODI.OcrThisFile(False, file_FullName, SourceGuid, RC)
                                            If Not RC Then
                                                LOG.WriteToArchiveLog("ERROR OCR Failed 1001.22a - " + file_FullName)
                                                If DeleteOnArchive.Equals("Y") Then
                                                    If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                        Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                                        ListOfFilesToDelete.Item(file_FullName) = "MOVE"
                                                    ElseIf Not ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                        ListOfFilesToDelete.Add(file_FullName, "MOVE")
                                                    End If
                                                End If
                                            End If
#Else
                                            Dim RC As Boolean = False
                                            If bIsImageFile Then
                                                CMODI.OcrThisFile(False, file_FullName, SourceGuid, RC)
                                                If Not RC Then
                                                    LOG.WriteToArchiveLog("ERROR OCR Failed 1001.22a - " + file_FullName)
                                                    If DeleteOnArchive.Equals("Y") Then
                                                        If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                            Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                                            ListOfFilesToDelete.Item(file_FullName) = "MOVE"
                                                        ElseIf Not ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                            ListOfFilesToDelete.Add(file_FullName, "MOVE")
                                                        End If
                                                    End If
                                                End If
                                            End If

#End If
                                        End If
                                        '******************************************************
                                        If DeleteOnArchive.Equals("Y") Then
                                            'MessageBox.Show("Tuning on delete at 001")
                                            ThisFileNeedsToBeDeleted = True
                                            If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                                ListOfFilesToDelete.Item(file_FullName) = "DELETE"
                                            End If
                                        End If
                                        '******************************************************
                                    Else
                                        '******************************************************
                                        If DeleteOnArchive.Equals("Y") Then
                                            'MessageBox.Show("Tuning on delete at 002")
                                            ThisFileNeedsToBeMoved = True
                                            If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                                Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                                ListOfFilesToDelete.Item(file_FullName) = "MOVE"
                                            End If
                                            LOG.WriteToArchiveLog("ERROR Failed to UPLOAD 1001.22b moved on server - " + file_FullName)
                                        End If
                                        '******************************************************
                                        '** There was an issue, remove this file.
                                        LOG.WriteToArchiveLog("ERROR 943.2188 in file '" + file_FullName + "', did not save binary to Repository, removing from repository.")
                                        LOG.WriteToArchiveLog("ERROR 943.2188 in file '" + file_FullName + "', did not save binary to Repository, removing from repository.")
                                        Dim ErrSql$ = "Delete from DataSource "
                                        GoTo NextFile
                                    End If

                                    DB.setRetentionDate(SourceGuid, RetentionCode$, file_Extension)
                                    DB.UpdateDocFqn(SourceGuid, file_FullName)
                                    DB.UpdateDocSize(SourceGuid, file_Length)
                                    DB.UpdateDocDir(SourceGuid, file_FullName)
                                    DB.UpdateDocOriginalFileType(SourceGuid, file_Extension)
                                    DB.UpdateZipFileIndicator(SourceGuid, isZipFile)

                                    If Not isZipFile Then
                                        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8025")
                                        'DMA.ToggleArchiveBit(file_FullName)
                                        DMA.setArchiveBitOff(file_FullName)
                                    End If

                                    'DB.delFileParms(SourceGuid)

                                    If CRC$.Length = 0 Then
                                        CRC$ = DMA.CalcCRC(file_FullName)
                                    End If
                                    ARCH.UpdateDocCrc(SourceGuid, CRC$)

                                    UpdateSrcAttrib(SourceGuid, "CRC", CRC$, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "FILENAME", file_Name, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreationTime, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessTime, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, file_Extension)

                                    DB.AddMachineSource(file_FullName, SourceGuid)

                                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8026")
                                    If (LCase(file_Extension).Equals(".mp3") Or LCase(file_Extension).Equals(".wma") Or LCase(file_Extension).Equals("wma")) Then
                                        MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)
                                    End If
                                    If (LCase(file_Extension).Equals(".tiff") Or LCase(file_Extension).Equals(".jpg")) Then
                                        '** This functionality will be added at a later time
                                        'KAT.getXMPdata(file_FullName)
                                    End If
                                    If (LCase(file_Extension).Equals(".png") Or LCase(file_Extension).Equals(".gif")) Then
                                        '** This functionality will be added at a later time
                                        'KAT.getXMPdata(file_FullName)
                                    End If

                                    If (LCase(file_Extension).Equals(".doc") Or LCase(file_Extension).Equals(".docx")) And ckMetaData$.Equals("Y") Then
                                        GetWordDocMetadata(file_FullName, SourceGuid, file_Extension)
                                    End If
                                    If (file_Extension.Equals(".xls") _
                                                Or file_Extension.Equals(".xlsx") Or file_Extension.Equals(".xlsm")) And ckMetaData$.Equals("Y") Then
                                        Me.GetExcelMetaData(file_FullName, SourceGuid, file_Extension)
                                    End If
                                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8027")
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage3", "START", UpdateTimer)
                                End If

                                '** The following is set in the APP.CONFIG file. **
                                If VerifyEmbeddedZipFiles.Equals("1") And bExplodeZipFile Then
                                    isZipFile = ZF.isZipFile(file_FullName)
                                    If isZipFile = True Then
                                        Dim ExistingParentZipGuid$ = DB.GetGuidByFqn(file_FullName, LastVerNbr)
                                        StackLevel = 0
                                        bExplodeZipFile = False
                                        ListOfFiles.Clear()
                                        If ExistingParentZipGuid.Length > 0 Then
                                            DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, False)
                                            ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                            'ZipFilesContent.Add(file_FullName.Trim + "|" + ExistingParentZipGuid)
                                        Else
                                            DBLocal.addZipFile(file_FullName, SourceGuid, False)
                                            ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                            'ZipFilesContent.Add(file_FullName.Trim + "|" + SourceGuid)
                                        End If
                                    End If
                                End If
                                If DeleteOnArchive.Equals("Y") Then
                                    ThisFileNeedsToBeDeleted = True
                                    If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                        Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                        ListOfFilesToDelete.Item(file_FullName) = "DELETE"
                                    End If
                                    LOG.WriteToArchiveLog("Notice No change in file - " + file_FullName)
                                End If
                            Else
                                '** The document has changed, but versioning is not on...
                                '** Delete and re-add.
                                '** If zero add
                                '** if 1, see if changed and if so, update, if not skip it   

                                If Not DeleteOnArchive.Equals("Y") Then
                                    DBLocal.addInventoryForce(file_FullName, ckArchiveBit)
                                Else
                                    DBLocal.delFile(file_FullName)
                                End If

                                LastVerNbr = DB.GetMaxVersionNbr(file_FullName)

                                DB.addContentHashKey(SourceGuid, LastVerNbr, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)

                                isZipFile = ZF.isZipFile(file_FullName)
                                If isZipFile = True Then
                                    Dim ExistingParentZipGuid$ = DB.GetGuidByFqn(file_FullName, LastVerNbr)
                                    StackLevel = 0
                                    ListOfFiles.Clear()
                                    bExplodeZipFile = False
                                    If ExistingParentZipGuid.Length > 0 Then
                                        DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, False)
                                        ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                        'ZipFilesContent.Add(file_FullName.Trim + "|" + ExistingParentZipGuid)
                                    Else
                                        DBLocal.addZipFile(file_FullName, SourceGuid, False)
                                        ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
                                        'ZipFilesContent.Add(file_FullName.Trim + "|" + SourceGuid)
                                    End If
                                End If

                                bChanged = DB.isSourcefileOlderThanLastEntry(CurrUserGuidID, _
                                          SourceGuid, _
                                          file_FullName, _
                                          file_FullName, _
                                          file_Extension, _
                                          file_Length, _
                                          file_LastAccessTime, _
                                          file_CreationTime, _
                                          file_LastWriteTime, _
                                          LastVerNbr.ToString)
                                '** If it has, add it to the repository
                                If bChanged Then
                                    Dim UpdateTimer As Date = Now
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage4", "START")
                                    '**************************************************
                                    '********* Set the SourceGuid to the pre-existing
                                    SourceGuid = DB.GetGuidByFqn(file_FullName, LastVerNbr.ToString)
                                    '**************************************************

                                    If CRC$.Length = 0 Then
                                        CRC$ = DMA.CalcCRC(file_FullName)
                                    End If
                                    ARCH.UpdateDocCrc(SourceGuid, CRC$)

                                    FilesBackedUp += 1
                                    BB = False

                                    '****************************************************************************************************************************
                                    Dim OriginalFileName As String = DMA.getFileName(file_FullName)
                                    BB = DB.UpdateSourceImage(OriginalFileName, UIDcurr, MachineIDcurr, SourceGuid, file_LastAccessTime, file_CreationTime, file_LastWriteTime, LastVerNbr, file_FullName, RetentionCode, isPublic)
                                    '****************************************************************************************************************************

                                    If DeleteOnArchive.Equals("Y") And BB Then
                                        'MessageBox.Show("Tuning on delete at 003")
                                        ThisFileNeedsToBeDeleted = True
                                        If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                            Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                            ListOfFilesToDelete.Item(file_FullName) = "DELETE"
                                        End If
                                    End If
                                    If DeleteOnArchive.Equals("Y") And Not BB Then
                                        'MessageBox.Show("Tuning on MOVE at 001")
                                        ThisFileNeedsToBeMoved = True
                                        If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                            Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                            ListOfFilesToDelete.Item(file_FullName) = "MOVE"
                                        End If
                                    End If

                                    If BB Then

                                        If LibraryList.Count > 0 Then
                                            'wdmxx
                                            For II As Integer = 0 To LibraryList.Count - 1
                                                Dim LibraryName$ = LibraryList(II)
                                                ARCH.AddLibraryItem(SourceGuid, file_Name, file_Extension, LibraryName$)
                                            Next
                                        End If

                                        DB.UpdateCurrArchiveStats(file_FullName, file_Extension)
                                        DB.AddContentOwner(SourceGuid, CurrUserGuidID)

                                        DB.addContentHashKey(SourceGuid, NextVersionNbr, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)

                                    Else
                                        Dim MySql$ = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'"
                                        DB.ExecuteSqlNewConn(MySql)
                                        LOG.WriteToErrorLog("Unrecoverable Error - removed file '" + file_FullName + "' from the repository.")
                                        If UseThreads = False Then SB5.BackColor = Color.Red
                                        If UseThreads = False Then SB5.ForeColor = Color.Yellow

                                        Dim DisplayMsg$ = "A source file failed to load. Review ERROR log."
                                        frmHelp.MsgToDisplay$ = DisplayMsg$
                                        frmHelp.CallingScreenName$ = "ECM Archive"
                                        frmHelp.CaptionName$ = "Fatal Load Error"
                                        frmHelp.Timer1.Interval = 10000
                                        frmHelp.Show()

                                    End If

                                    DB.UpdateDocFqn(SourceGuid, file_FullName)
                                    DB.UpdateDocSize(SourceGuid, file_Length)
                                    DB.UpdateDocOriginalFileType(SourceGuid, file_Extension)
                                    DB.UpdateZipFileIndicator(SourceGuid, isZipFile)
                                    DB.UpdateDocDir(SourceGuid, file_FullName)

                                    'DB.delFileParms(SourceGuid)
                                    If CRC$.Length = 0 Then
                                        CRC$ = DMA.CalcCRC(file_FullName)
                                    End If
                                    ARCH.UpdateDocCrc(SourceGuid, CRC$)

                                    UpdateSrcAttrib(SourceGuid, "CRC", CRC$, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "FILENAME", file_Name, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreationTime, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessTime, file_Extension)
                                    UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, file_Extension)

                                    DB.AddMachineSource(file_FullName, SourceGuid)

                                    DB.addContentHashKey(SourceGuid, NextVersionNbr, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)

                                    If Not isZipFile Then
                                        'Dim TheFileIsArchived As Boolean = True
                                        'DMA.setFileArchiveAttributeSet(file_FullName, TheFileIsArchived)
                                        DMA.ToggleArchiveBit(file_FullName)
                                    End If

                                    If (LCase(file_Extension).Equals(".doc") Or LCase(file_Extension).Equals(".docx")) And ckMetaData$.Equals("Y") Then
                                        GetWordDocMetadata(file_FullName, SourceGuid, file_Extension)
                                    End If
                                    If (file_Extension.Equals(".xls") _
                                                Or file_Extension.Equals(".xlsx") Or file_Extension.Equals(".xlsm")) And ckMetaData$.Equals("Y") Then
                                        Me.GetExcelMetaData(file_FullName, SourceGuid, file_Extension)
                                    End If
                                    LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage4", "STOP", UpdateTimer)
                                Else
                                    '** This file has not changed
                                    FilesSkipped += 1

                                    If DeleteOnArchive.Equals("Y") Then
                                        'MessageBox.Show("Tuning on delete at 005")
                                        ThisFileNeedsToBeDeleted = True
                                        If ListOfFilesToDelete.ContainsKey(file_FullName) Then
                                            Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
                                            ListOfFilesToDelete.Item(file_FullName) = "DELETE"
                                        End If
                                    End If

                                    Dim ReinitMetadata As Boolean = False

                                    If ReinitMetadata = True Then

                                        If CRC$.Length = 0 Then
                                            CRC$ = DMA.CalcCRC(file_FullName)
                                        End If

                                        If LibraryList.Count > 0 Then
                                            'wdmxx
                                            For II As Integer = 0 To LibraryList.Count - 1
                                                Dim LibraryName$ = LibraryList(II)
                                                ARCH.AddLibraryItem(SourceGuid, file_Name, file_Extension, LibraryName$)
                                            Next
                                        End If

                                        ARCH.UpdateDocCrc(SourceGuid, CRC$)
                                        UpdateSrcAttrib(SourceGuid, "CRC", CRC$, file_Extension)
                                        UpdateSrcAttrib(SourceGuid, "FILENAME", file_Name, file_Extension)
                                        UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreationTime, file_Extension)
                                        UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, file_Extension)
                                        UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessTime, file_Extension)
                                        UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, file_Extension)
                                        DB.AddMachineSource(file_FullName, SourceGuid)

                                        DB.addContentHashKey(SourceGuid, NextVersionNbr, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)

                                        GC.Collect()
                                    End If
                                End If
                            End If
                        End If
NextFile:
                        If UseThreads = False Then SB5.Text = "Processing Dir: " + FolderName + " # " + K.ToString
                        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8032")
                        Application.DoEvents()
                        If ddebug Then LOG.WriteToArchiveLog("============== File : " + file_FullName + " Was processed as above.")

                        file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                        file_Name = UTIL.RemoveSingleQuotes(file_Name)

                        If gTerminateImmediately Then
                            If UseThreads = False Then SB5.Text = "Terminated archive!"
                            frmNotify.Close()
                            gContentArchiving = False
                            My.Settings("LastArchiveEndTime") = Now
                            My.Settings.Save()
                            Return
                        End If

                        If ckArchiveBit = True And Not file_Name Is Nothing Then
                            DMA.setArchiveBitOff(file_FullName)
                        End If
DoneWithIt:
                        '******************************************************
                        If DeleteOnArchive.Equals("Y") And ThisFileNeedsToBeDeleted And file_FullName IsNot Nothing Then
                            LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "DELETED", UpdateTimerMain)
                            Try
                                ListOfFilesToDelete.Item(file_FullName) = "DELETE"
                                'ISO.saveIsoFile("$FilesToDelete.dat", file_FullName + "|")
                                'File.Delete(file_FullName)
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR Failed to DELETE: " + file_FullName)
                            End Try
                        ElseIf DeleteOnArchive.Equals("Y") And ThisFileNeedsToBeMoved And file_FullName IsNot Nothing Then
                            LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "MOVED", UpdateTimerMain)
                            Try
                                Dim FI As New FileInfo(file_FullName)
                                Dim fNameOnly As String = FI.Name
                                Dim fDirName As String = FI.DirectoryName
                                Dim NewName As String = ERR_FQN + "\" + fNameOnly
                                FI = Nothing
                                File.Move(file_FullName, NewName)
                            Catch ex As Exception
                                LOG.WriteToArchiveLog("ERROR Failed to MOVE: " + file_FullName)
                            End Try
                        End If
                        '******************************************************
                        If file_FullName IsNot Nothing Then
                            LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "STOP", UpdateTimerMain)
                        End If
                    Next
                Else
                    If ddebug Then Debug.Print("Duplicate Folder: " + FolderName$)
                    If ddebug Then LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8034")
                End If
NextFolder:
                pFolder$ = FolderName$
                If gTerminateImmediately Then
                    Me.Cursor = Cursors.Default
                    If UseThreads = False Then SB5.Text = "Terminated archive!"
                    frmNotify.Close()
                    gContentArchiving = False
                    My.Settings("LastArchiveEndTime") = Now
                    My.Settings.Save()
                    Return
                End If
            Next
        Catch ex As Exception
            LOG.WriteToArchiveLog("FATAL ERROR: ArchiveContent " + ex.Message)
        Finally
            If DeleteOnArchive.Equals("Y") Then
                For Each FQN As String In ListOfFilesToDelete.Keys
                    Dim IDX As Integer = ListOfFilesToDelete.IndexOfKey(FQN)
                    Dim tAction As String = ListOfFilesToDelete.Values(IDX)
                    Try
                        If tAction.Equals("DELETE") Then
                            If File.Exists(FQN) Then
                                ISO.saveIsoFile("$FilesToDelete.dat", FQN + "|")
                                File.Delete(FQN)
                            End If
                        ElseIf tAction.Equals("MOVE") Then
                            If File.Exists(FQN) Then
                                Dim FI As New FileInfo(FQN)
                                Dim fNameOnly As String = FI.Name
                                Dim fDirName As String = FI.DirectoryName
                                Dim NewName As String = ERR_FQN + "\" + fNameOnly
                                FI = Nothing
                                File.Move(FQN, NewName)
                            End If
                        Else
                            LOG.WriteToArchiveLog("ERROR/Advisory Notice - File " + FQN + " had no known disposition, it was moved to the error directory.")
                            If File.Exists(FQN) Then
                                Dim FI As New FileInfo(FQN)
                                Dim fNameOnly As String = FI.Name
                                Dim fDirName As String = FI.DirectoryName
                                Dim NewName As String = ERR_FQN + "\" + fNameOnly
                                FI = Nothing
                                File.Move(FQN, NewName)
                            End If
                        End If
                    Catch ex As Exception
                        If Not gRunUnattended Then
                            MessageBox.Show("Could not remove the file " + FQN + "." + vbCrLf + ex.Message)
                        Else
                            LOG.WriteToArchiveLog("Could not remove the file " + FQN + ". - " + ex.Message)
                        End If
                    End Try
                Next
            End If
        End Try


        If UseThreads = False Then SB5.Text = "Files Completed"
        PBx.Value = 0

        'Timer1.Enabled = True
        If ddebug Then LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with Content Archive.")

        PROC.getProcessesToKill()
        PROC.KillOrphanProcesses()
        'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"


        StackLevel = 0
        ListOfFiles.Clear()

        For i As Integer = 0 To ZipFilesContent.Count - 1
            bExplodeZipFile = False
            'FrmMDIMain.SB.Text = "Processing Quickref"
            'If i >= 24 Then
            '    Debug.Print("here")
            'End If
            Dim cData$ = ZipFilesContent(i).ToString
            Dim ParentGuid$ = ""
            Dim FQN$ = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid$ = Mid(cData, K + 1)
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN$, ParentGuid$, ckArchiveBit.Checked, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next

        ListOfFiles = Nothing
        GC.Collect()

        frmNotify.Close()
        gContactsArchiving = False
        gContentArchiving = False

        My.Settings("LastArchiveEndTime") = Now
        My.Settings.Save()


        frmNotify.lblFileSpec.Text = "Content archive complete."
        frmNotify.Refresh()

    End Sub

    Sub ArchiveData(ByVal UID As String, ByVal ContainerName$, ByVal TopFolder$, ByRef SL As SortedList)

        CompletedPolls = CompletedPolls + 1
        SB.Text = Now & " : Archiving data... standby: " & CompletedPolls

        Dim ActiveFolders$(0)
        Dim FolderName$ = ""
        Dim DeleteFile As Boolean = False

        Dim ArchiveEmails$ = ""
        Dim RemoveAfterArchive$ = ""
        Dim SetAsDefaultFolder$ = ""
        Dim ArchiveAfterXDays$ = ""
        Dim RemoveAfterXDays$ = ""
        Dim RemoveXDays$ = ""
        Dim ArchiveXDays$ = ""
        Dim DB_ID$ = ""
        Dim ArchiveOnlyIfRead$ = ""

        Dim EmailFolders$(0)

        DB.GetEmailFolders(gCurrUserGuidID, EmailFolders$)

        For i As Integer = 0 To UBound(EmailFolders$)
            FolderName$ = EmailFolders$(i).ToString.Trim
            Dim BB As Boolean = DB.GetEmailFolderParms(TopFolder$, gCurrUserGuidID, FolderName$, ArchiveEmails$, RemoveAfterArchive$, SetAsDefaultFolder$, ArchiveAfterXDays$, RemoveAfterXDays$, RemoveXDays$, ArchiveXDays$, DB_ID$, ArchiveOnlyIfRead$)
            If BB Then

                'ARCH.getSubFolderEmails(FolderName$, bDeleteMsg)
                ARCH.getSubFolderEmailsSenders(UID, TopFolder$, FolderName$, DeleteFile, ArchiveEmails$, _
                RemoveAfterArchive$, _
                SetAsDefaultFolder$, _
                ArchiveAfterXDays$, _
                RemoveAfterXDays$, _
                RemoveXDays$, _
                ArchiveXDays$, ContainerName$)
                'ARCH.GetEmails(FolderName$, ArchiveEmails$, RemoveAfterArchive$, SetAsDefaultFolder$, ArchiveAfterXDays$, RemoveAfterXDays$, RemoveXDays$, ArchiveXDays$, DB_ID$)                
            End If
        Next

    End Sub

    '    Public Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
    '        If ckDisable.Checked Then
    '            SB.Text = "DISABLE ALL is checked - no archive allowed."
    '            Return
    '        End If
    '        Dim frm As Form
    '        Try
    '            For Each frm In My.Application.OpenForms
    '                Application.DoEvents()
    '                If frm Is My.Forms.frmNotify Then
    '                    Return
    '                End If
    '                If frm Is My.Forms.frmNotify2 Then
    '                    Return
    '                End If
    '                If frm Is My.Forms.frmExchangeMonitor Then
    '                    Return
    '                End If
    '            Next
    '        Catch ex As Exception
    '            Console.WriteLine("Timer1_Tick forms")
    '        End Try
    '        frm = Nothing

    '        If Not t2 Is Nothing Then
    '            If t2.IsAlive Then
    '                Return
    '            End If
    '        End If
    '        If Not t3 Is Nothing Then
    '            If t3.IsAlive Then
    '                Return
    '            End If
    '        End If
    '        If Not t4 Is Nothing Then
    '            If t4.IsAlive Then
    '                Return
    '            End If
    '        End If
    '        If Not t5 Is Nothing Then
    '            If t5.IsAlive Then
    '                Return
    '            End If
    '        End If

    '        Timer1.Enabled = False

    '        Dim LastYearArchive As Integer = 0
    '        Dim LastMonthArchive As Integer = 0
    '        Dim LastDayArchive As Integer = 0
    '        Dim LastMinuteArchive As Integer = 0

    '        Dim TodayYear As Integer = Now.Year
    '        Dim TodayDay As Integer = Now.Day
    '        Dim TodayMonth As Integer = Now.Month
    '        Dim TodayMinute As Integer = Now.Minute
    '        Dim TodayHour As Integer = Now.Hour

    '        Dim TS As TimeSpan = Nothing

    '        Dim Days As Integer = 0
    '        Dim Hours As Integer = 0

    '        '** Now, we determine if we archive or not

    '        Application.DoEvents()
    '        Dim isDisabled As Boolean = False

    '        If ckDisable.Checked = True Then
    '            SB.Text = "ALL Archive disabled - " + Now.ToString
    '            'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString
    '            Timer1.Enabled = True

    '            If DB.isArchiveDisabled("ALL") = True Then
    '                isDisabled = True
    '                SB.Text = "ALL Archive disabled - " + Now.ToString
    '                'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString
    '            Else
    '                isDisabled = True
    '                SB.Text = "Archive disabled - " + Now.ToString
    '                'FrmMDIMain.SB.Text = "Archive disabled " + Now.ToString
    '            End If

    '            ArchiveALLToolStripMenuItem.Enabled = True
    '            ContentToolStripMenuItem.Enabled = True
    '            ExchangeEmailsToolStripMenuItem.Enabled = True
    '            OutlookEmailsToolStripMenuItem.Enabled = True

    '            'LOG.WriteToArchiveLog("ALL Archive disabled.")

    '            Return
    '        Else
    '            SB.Text = "Archive enabled - " + Now.ToString
    '            'FrmMDIMain.SB.Text = "Archive enabled " + Now.ToString
    '            Timer1.Enabled = True
    '            ArchiveALLToolStripMenuItem.Enabled = True
    '            ContentToolStripMenuItem.Enabled = True
    '            ExchangeEmailsToolStripMenuItem.Enabled = True
    '            OutlookEmailsToolStripMenuItem.Enabled = True
    '            If gIsServiceManager = True Then
    '                LOG.WriteToArchiveLog("ServiceManager Archive.")
    '                gbPolling.Enabled = False
    '                ckUseLastProcessDateAsCutoff.Enabled = False
    '                btnRefreshFolders.Enabled = False
    '                btnActive.Enabled = False
    '                cbParentFolders.Enabled = False
    '                lbActiveFolder.Enabled = False
    '                ckArchiveFolder.Enabled = False
    '                ckArchiveRead.Enabled = False
    '                ckRemove.Enabled = False
    '                ckArchAfterDays.Enabled = False
    '                NumericUpDown2.Enabled = False
    '                ckRemoveAfterXDays.Enabled = False
    '                NumericUpDown3.Enabled = False
    '                ckSystemFolder.Enabled = False
    '                cbEmailRetention.Enabled = False
    '                btnSaveConditions.Enabled = False
    '                btnDeleteEmailEntry.Enabled = False
    '                OutlookEmailsToolStripMenuItem.Enabled = False
    '                ExchangeEmailsToolStripMenuItem.Enabled = False
    '                ContentToolStripMenuItem.Enabled = False
    '                ArchiveALLToolStripMenuItem.Enabled = False
    '                ckArchiveBit.Enabled = True
    '            End If
    '        End If

    '        Dim RetentionCode$ = cbEmailRetention.Text
    '        Dim RetentionYears As Integer = 0
    '        RetentionYears = DB.getRetentionPeriod(RetentionCode$)

    '        If gCurrentArchiveGuid.Length = 0 Then
    '            gCurrentArchiveGuid$ = Guid.NewGuid.ToString
    '        End If

    '        Dim UnitValue$ = ""
    '        Dim ArchiveType$ = ""
    '        ArchiveType$ = DB.getRconParm(gCurrUserGuidID, "ArchiveType")
    '        UnitValue$ = DB.getRconParm(gCurrUserGuidID, "ArchiveInterval")

    '        Dim CurrStatus$ = "Running"
    '        Dim WC$ = STATS.wc_PI02_ArchiveStats(CurrStatus$, gCurrUserGuidID)

    '        ArchiveALLToolStripMenuItem.Enabled = False
    '        ContentToolStripMenuItem.Enabled = False
    '        ExchangeEmailsToolStripMenuItem.Enabled = False
    '        OutlookEmailsToolStripMenuItem.Enabled = False

    '        Dim LastSuccessFullArchiveDate As Date = Now
    '        Dim BackupNow As Boolean = False

    '        '***********************************************************************************************
    '        LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType$, gCurrUserGuidID)
    '        '***********************************************************************************************

    '        If LastSuccessFullArchiveDate = Nothing Then
    '            LOG.WriteToArchiveLog("Last Archivesuccessful - ready for archive to execute.")
    '            BackupNow = True
    '        Else
    '            LastYearArchive = LastSuccessFullArchiveDate.Year
    '            LastMonthArchive = LastSuccessFullArchiveDate.Month
    '            LastDayArchive = LastSuccessFullArchiveDate.Day
    '            LastMinuteArchive = LastSuccessFullArchiveDate.Minute
    '            LOG.WriteToArchiveLog("Last Archivesuccessful RESET.")
    '        End If
    '        SB.Text = "AUTO Archive running"
    '        SB2.Text = "AUTO Archive running"
    '        If ArchiveType$.Equals("Disable") Then
    '            LOG.WriteToArchiveLog("Archive Type is DISABLED.")
    '            Timer1.Enabled = True
    '            ArchiveALLToolStripMenuItem.Enabled = True
    '            ContentToolStripMenuItem.Enabled = True
    '            ExchangeEmailsToolStripMenuItem.Enabled = True
    '            OutlookEmailsToolStripMenuItem.Enabled = True
    '            Return
    '        ElseIf ArchiveType$.Equals("Monthly") Then
    '            'lblUnit.Text = "day of the month"
    '            SB.Text = "Backup every month on day " + UnitValue$
    '            LOG.WriteToArchiveLog("Backup every month on day " + UnitValue$)
    '            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType$, gCurrUserGuidID)

    '            LastYearArchive = 0
    '            LastMonthArchive = 0
    '            LastDayArchive = 0
    '            LastMinuteArchive = 0

    '            TS = Now.Subtract(LastSuccessFullArchiveDate)
    '            Days = TS.Days

    '            If LastMonthArchive = 12 And LastSuccessFullArchiveDate.Month = 1 Then
    '                LastMonthArchive = 0
    '            End If
    '            If Now.Month >= LastSuccessFullArchiveDate.Month Then
    '                BackupNow = True
    '            End If
    '            LOG.WriteToArchiveLog("Backup every month Backup Now is " + BackupNow.ToString)
    '            If BackupNow = True And Now.Month = LastSuccessFullArchiveDate.Month Then
    '                If CInt(UnitValue$) < TodayDay Then
    '                    LOG.WriteToArchiveLog("Backup every month Backup Now is NOT due.")
    '                    ArchiveALLToolStripMenuItem.Enabled = True
    '                    ContentToolStripMenuItem.Enabled = True
    '                    ExchangeEmailsToolStripMenuItem.Enabled = True
    '                    OutlookEmailsToolStripMenuItem.Enabled = True
    '                    Return
    '                Else
    '                    BackupNow = True
    '                    LOG.WriteToArchiveLog("Backup every month Backup Now is DUE.")
    '                    GoTo DoItNow
    '                End If
    '            End If
    '            If Now.Month > LastSuccessFullArchiveDate.Month Then
    '                BackupNow = True
    '            Else
    '                Return
    '            End If
    '        ElseIf ArchiveType$.Equals("Daily") Then
    '            'lblUnit.Text = "time of day (24 hr) clock"
    '            SB.Text = "Backup daily immediately after " + UnitValue$ + " hours."
    '            LOG.WriteToArchiveLog("Backup daily immediately after " + UnitValue$)
    '            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType$, gCurrUserGuidID)
    '            If LastSuccessFullArchiveDate = Nothing Then
    '                LOG.WriteToArchiveLog("Backup daily immediately BackupNow =  " + BackupNow.ToString)
    '                BackupNow = True
    '            Else

    '                LastYearArchive = LastSuccessFullArchiveDate.Year
    '                LastMonthArchive = LastSuccessFullArchiveDate.Month
    '                LastDayArchive = LastSuccessFullArchiveDate.Day
    '                LastMinuteArchive = LastSuccessFullArchiveDate.Minute

    '                'Dim DayOfWeek$ = LastSuccessFullArchiveDate.DayOfWeek.ToString

    '                'If DayOfWeek$.ToUpper.Equals("SUNDAY") Then

    '                'End If

    '                Dim BackupHour As Integer = CInt(UnitValue$) / 100

    '                TS = Now.Subtract(LastSuccessFullArchiveDate)
    '                Hours = TS.Hours

    '                If Hours >= 24 And Val(UnitValue$) >= Now.Hour Then
    '                    LOG.WriteToArchiveLog("Backup daily immediately BackupNow is TRUE")
    '                    BackupNow = True
    '                Else
    '                    LOG.WriteToArchiveLog("Backup daily immediately BackupNow is False")
    '                    BackupNow = False
    '                    Return
    '                End If
    '            End If
    '        ElseIf ArchiveType$.Equals("Hourly") Then
    '            'lblUnit.Text = "minutes past the hour"
    '            SB.Text = "Backup hourly immediately " + UnitValue$ + " minutes after the hour."
    '            LOG.WriteToArchiveLog("Backup hourly immediately " + UnitValue$ + " minutes after the hour.")
    '            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType$, gCurrUserGuidID)

    '            LastYearArchive = LastSuccessFullArchiveDate.Year
    '            LastMonthArchive = LastSuccessFullArchiveDate.Month
    '            LastDayArchive = LastSuccessFullArchiveDate.Day
    '            LastMinuteArchive = LastSuccessFullArchiveDate.Minute

    '            TS = Now.Subtract(LastSuccessFullArchiveDate)
    '            Hours = TS.Hours

    '            If Hours >= 1 Then
    '                LOG.WriteToArchiveLog("Backup hourly is TRUE - 1.")
    '                BackupNow = True
    '            Else
    '                ArchiveALLToolStripMenuItem.Enabled = True
    '                ContentToolStripMenuItem.Enabled = True
    '                ExchangeEmailsToolStripMenuItem.Enabled = True
    '                OutlookEmailsToolStripMenuItem.Enabled = True
    '                LOG.WriteToArchiveLog("Backup hourly is NOT TRUE - 2.")
    '                Return
    '            End If
    '        ElseIf ArchiveType$.Equals("Minutes") Then
    '            'lblUnit.Text = "minutes"            
    '            SB.Text = "Backup every " + UnitValue$ + " minutes."
    '            LOG.WriteToArchiveLog("Backup every " + UnitValue$ + " minutes.")
    '            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType$, gCurrUserGuidID)

    '            LastYearArchive = LastSuccessFullArchiveDate.Year
    '            LastMonthArchive = LastSuccessFullArchiveDate.Month
    '            LastDayArchive = LastSuccessFullArchiveDate.Day
    '            LastMinuteArchive = LastSuccessFullArchiveDate.Minute

    '            TS = Now.Subtract(LastSuccessFullArchiveDate)
    '            Dim Minutes As Integer = TS.Minutes

    '            If Minutes >= Val(UnitValue$) Then
    '                BackupNow = True
    '            Else
    '                BackupNow = False
    '            End If

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

    '        LOG.WriteToArchiveLog("Scheduled Archive stared @ " + Now.ToString)

    '        '******************************
    '        SetUnattendedFlag()
    '        '******************************

    '        If BackupNow Then

    '            STATS.setArchivestartdate(Now.ToString)
    '            STATS.setArchiveenddate(Now.ToString)
    '            STATS.setArchivetype(ArchiveType$)
    '            STATS.setStatguid(gCurrentArchiveGuid)
    '            STATS.setStatus("Running")
    '            STATS.setSuccessful("N")
    '            STATS.setUserid(gCurrUserGuidID)
    '            STATS.setTotalcontentinrepository("0")
    '            STATS.setTotalemailsinrepository("0")

    '            Me.SB.Text = "Scheduled Archive Starting."
    '            SB.Refresh()
    '            Application.DoEvents()

    '            gbEmail.Enabled = False
    '            gbContentMgt.Enabled = False

    '            '*****************************************************
    '            ArchiveALLToolStripMenuItem_Click(Nothing, Nothing)
    '            '*****************************************************

    '            gbEmail.Enabled = True
    '            gbContentMgt.Enabled = True

    '            Cursor = Cursors.Default

    '            ALR.ProcessAutoReferences()

    '            Cursor = Cursors.Default

    '            '*********************************************
    '            '** WDM DB.UpdateAttachmentCounts()
    '            '*********************************************

    '            TimerEndRun.Enabled = True

    '            Cursor = Cursors.Default
    '        End If

    '        ArchiveALLToolStripMenuItem.Enabled = True
    '        ContentToolStripMenuItem.Enabled = True
    '        ExchangeEmailsToolStripMenuItem.Enabled = True
    '        OutlookEmailsToolStripMenuItem.Enabled = True

    '        LOG.WriteToArchiveLog("Scheduled Archive ended @ " + Now.ToString)
    '        Timer1.Enabled = True

    '        SB.Text = "AUTO Archive complete"
    '        SB2.Text = "AUTO Archive complete"

    '    End Sub

    Private Sub btnDeleteEmailEntry_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeleteEmailEntry.Click
        ParentFolder$ = cbParentFolders.Text

        If ParentFolder.Trim.Length = 0 Then
            messagebox.show("Please select a Parent Folder to process.")
            Return
        End If

        Dim msg$ = "This will remove the selected mail folder from the archive process, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Remove Email Folder", MessageBoxButtons.YesNo)

        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Me.Cursor = Cursors.AppStarting

        For Each S As String In lbActiveFolder.SelectedItems
            Try
                Dim FolderName$ = ParentFolder + "|" + S.ToString
                Debug.Print(FolderName$)
                Dim aParms$(0)

                'PARMS.EmailFolderName$ = FolderName$
                EMPARMS.setFoldername(FolderName$)
                EMPARMS.setUserid(gCurrUserGuidID)

                '** Remove it from the parameter table.
                Dim WhereClause$ = "Where [UserID] = '" + gCurrUserGuidID + "' and [FolderName] = '" + FolderName + "'"
                EMPARMS.Delete(WhereClause)

                '** Reset the archive flag.
                Dim WC$ = "where FolderName = '" + FolderName$ + "' and UserID = '" + gCurrUserGuidID + "'"
                'DB.UpdateArchiveFlag(ParentFolder, gCurrUserGuidID, "N", S.ToString)
                DB.DeleteEmailArchiveFolder(ParentFolder, gCurrUserGuidID, "N", FolderName$)

            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        Next

        DB.GetActiveEmailFolders(ParentFolder, lbActiveFolder, gCurrUserGuidID, CF, ArchivedEmailFolders)

        DB.setActiveEmailFolders(ParentFolder$, gCurrUserGuidID)

        DB.CleanUpEmailFolders()

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
    Sub InsertAttrib(ByVal aName$, ByVal aDesc$, ByVal aType$)
        ATTRIB.setAttributename(aName)
        ATTRIB.setAttributedesc(aDesc)
        ATTRIB.setAttributedatatype(aType)
        ATTRIB.Insert()
    End Sub

    Sub InsertSrcAttrib(ByVal SGUID$, ByVal aName$, ByVal aVal$, ByVal OriginalFileType$)
        SRCATTR.setSourceguid(SGUID)
        SRCATTR.setAttributename(aName)
        SRCATTR.setAttributevalue(aVal)
        SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
        SRCATTR.setSourcetypecode(OriginalFileType$)
        SRCATTR.Insert()
    End Sub

    Sub UpdateSrcAttrib(ByVal SGUID$, ByVal aName$, ByVal aVal$, ByVal SourceType$)
        Dim iCnt As Integer = SRCATTR.cnt_PK35(aName, gCurrUserGuidID, SGUID)
        If iCnt = 0 Then
            SRCATTR.setSourceguid(SGUID)
            SRCATTR.setAttributename(aName)
            SRCATTR.setAttributevalue(aVal)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(SourceType$)
            SRCATTR.Insert()
        Else
            Dim WC$ = SRCATTR.wc_PK35(aName, gCurrUserGuidID, SGUID)
            SRCATTR.setSourceguid(SGUID)
            SRCATTR.setAttributename(aName)
            SRCATTR.setAttributevalue(aVal)
            SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
            SRCATTR.setSourcetypecode(SourceType$)
            SRCATTR.Update(WC)
        End If

    End Sub

    Sub GetWordDocMetadata(ByVal FQN As String, ByVal SourceGUID As String, ByVal OriginalFileType As String)
        Try
            Dim TempDir$ = System.IO.Path.GetTempPath
            Dim fName$ = DMA.getFileName(FQN)
            Dim NewFqn$ = TempDir + fName

            File.Copy(FQN, NewFqn, True)

            Dim WDOC As New clsMsWord
            WDOC.initWordDocMetaData(NewFqn, SourceGUID$, OriginalFileType)

            ISO.saveIsoFile("$FilesToDelete.dat", NewFqn$ + "|")
            'File.Delete(NewFqn$)
        Catch ex As Exception
            DB.xTrace(3655, "Failed to process word metadata", "GetWordDocMetadata", ex)
            LOG.WriteToArchiveLog("Failed to process word metadata: GetWordDocMetadata" + ex.Message)
        End Try

    End Sub
    Sub GetExcelMetaData(ByVal FQN$, ByVal SourceGUID$, ByVal OriginalFileType$)

        Dim TempDir$ = System.IO.Path.GetTempPath
        Dim fName$ = DMA.getFileName(FQN)
        Dim NewFqn$ = TempDir + fName

        Try
            Try
                File.Copy(FQN, NewFqn, True)
                Dim WDOC As New clsMsWord
                WDOC.initExcelMetaData(NewFqn$, SourceGUID$, OriginalFileType$)
                WDOC = Nothing
            Catch ex As Exception
                DB.xTrace(340123, "Failed to open XL work book.", FQN, ex)
                log.WriteToArchiveLog("Failed to open XL work book: GetExcelMetaData" + ex.Message)
            Finally
                ISO.saveIsoFile("$FilesToDelete.dat", NewFqn$ + "|")
                'File.Delete(NewFqn$)
            End Try
        Catch ex As Exception
            log.WriteToArchiveLog("NOTICE: GetExcelMetaData" + ex.Message)
        End Try



    End Sub
    Public Function InclAddList(ByVal LB As ListBox, ByVal UserGuid$, ByVal PassedFQN$) As Boolean

        For i As Integer = 0 To LB.Items.Count - 1
            INL.setExtcode(LB.Items(i).ToString)
            INL.setFqn(PassedFQN)
            INL.setUserid(UserGuid)
            INL.Insert()
        Next
        Return True
    End Function
    Public Function ExcludeAddList(ByVal LB As ListBox, ByVal UserGuid$, ByVal PassedFQN$) As Boolean

        For i As Integer = 0 To LB.Items.Count - 1
            Me.EXL.setExtcode(LB.Items(i).ToString)
            EXL.setFqn(PassedFQN)
            EXL.setUserid(UserGuid)
            Debug.Print(LB.Items(i).ToString + " : " + PassedFQN)
            EXL.Insert()
        Next
        Return True
    End Function
    Public Function ExlAddList(ByVal LB As ListBox, ByVal PassedFQN$, ByVal typeCode$, ByVal InclSubDirs As Boolean) As Boolean

        'For i As Integer = 0 To LB.Items.Count - 1
        '    EXL.setExtcode(LB.Items(i).ToString)
        '    EXL.setFqn(PassedFQN)
        '    EXL.setUserid(gCurrUserGuidID)
        '    EXL.Insert()
        'Next

        Dim lDirs As New List(Of String)
        Dim B As Boolean = False

        lDirs.Clear()
        lDirs.Add(PassedFQN$)

        If InclSubDirs Then
            AddSubDirs(PassedFQN$, lDirs)
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
            Dim WC$ = "where UserID = '" + gCurrUserGuidID + "' and FQN = '" + PassedFQN + "' and Extcode = '" + typeCode + "' "
            Dim II As Integer = DB.iGetRowCount("ExcludedFiles", WC)
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
    Sub GetAllSubDirs(ByVal lDirs As List(Of String), ByVal PassedFQN$)
        lDirs.Clear()
        lDirs.Add(PassedFQN$)
        AddSubDirs(PassedFQN$, lDirs)
    End Sub
    Public Function AddList(ByVal LB As ListBox, ByVal PassedFQN$, ByVal typeCode$, ByVal InclSubDirs As Boolean) As Boolean

        Dim lDirs As New List(Of String)
        Dim B As Boolean = False

        lDirs.Clear()
        lDirs.Add(PassedFQN$)

        If InclSubDirs Then
            AddSubDirs(PassedFQN$, lDirs)
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
            Dim WC$ = "where UserID = '" + gCurrUserGuidID + "' and FQN = '" + PassedFQN + "' and Extcode = '" + typeCode + "' "
            Dim II As Integer = DB.iGetRowCount("IncludedFiles", WC)
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

        Dim NewVal As String = ""

        formloaded = False

        Dim B As Boolean = False

        'Dim ArchiveType$ = Me.cbInterval.Text
        'RPARM.setUserid(gCurrUserGuidID)
        'RPARM.setParm("ArchiveType")
        'RPARM.setParmvalue(ArchiveType)
        'B = DB.ckReconParmExists(gCurrUserGuidID, "ArchiveType")
        'If Not B Then
        '    RPARM.Insert()
        'Else
        '    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveType'")
        'End If


        NewVal$ = ""
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("ArchiveInterval")
        RPARM.setParmvalue(NewVal$)

        B = DB.ckReconParmExists(gCurrUserGuidID, "ArchiveInterval")
        If Not B Then
            RPARM.Insert()
            'Else
            '    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveInterval'")
        End If

        If gCurrUserGuidID.Length = 0 Then
            Return
        End If

        NewVal$ = ckDisable.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("Disabled")
        RPARM.setParmvalue(NewVal$)

        B = DB.ckReconParmExists(gCurrUserGuidID, "Disabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'Disabled'")
        End If

        If gCurrUserGuidID.Length = 0 Then
            Return
        End If

        NewVal$ = Me.ckDisableContentArchive.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("ContentDisabled")
        RPARM.setParmvalue(NewVal$)

        B = DB.ckReconParmExists(gCurrUserGuidID, "ContentDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ContentDisabled'")
        End If

        NewVal$ = Me.ckDisableOutlookEmailArchive.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("OutlookDisabled")
        RPARM.setParmvalue(NewVal$)

        B = DB.ckReconParmExists(gCurrUserGuidID, "OutlookDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'OutlookDisabled'")
        End If

        NewVal$ = Me.ckDisableExchange.Checked.ToString
        RPARM.setUserid(gCurrUserGuidID)
        RPARM.setParm("ExchangeDisabled")
        RPARM.setParmvalue(NewVal$)

        B = DB.ckReconParmExists(gCurrUserGuidID, "ExchangeDisabled")
        If Not B Then
            RPARM.Insert()
        Else
            RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ExchangeDisabled'")
        End If

        'NewVal$ = cExecAtStartup.Checked.ToString
        'RPARM.setUserid(gCurrUserGuidID)
        'RPARM.setParm("LoadAtStartup")
        'RPARM.setParmvalue(NewVal$)

        'B = DB.ckReconParmExists(gCurrUserGuidID, "LoadAtStartup")
        'If Not B Then
        '    RPARM.Insert()
        'Else
        '    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'LoadAtStartup'")
        'End If

        'GetExecParms()

        formloaded = True

        SB.Text = "Startup parms saved..."

    End Sub
    Private Sub btnSaveSchedule_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveSchedule.Click

        saveStartUpParms()

    End Sub

    'Private Sub cbInterval_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
    '    Dim Interval$ = cbInterval.Text
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
    '            Dim C$ = ii.ToString
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

        Try
            'If txtDir.Text.Trim.Length = 0 Then
            '    messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
            '    Return
            'End If
            Dim S1$ = lbAvailExts.SelectedItem.ToString

            For Each S As String In lbAvailExts.SelectedItems
                Dim ItemAlreadyExists As Boolean = False
                For I As Integer = 0 To lbExcludeExts.Items.Count - 1
                    Dim ExistingItem$ = lbExcludeExts.Items(I)
                    If S.ToUpper.Equals(ExistingItem$.ToUpper) Then
                        ItemAlreadyExists = True
                        Exit For
                    End If
                Next
                If ItemAlreadyExists = False Then
                    lbExcludeExts.Items.Add(S)
                    btnSaveChanges.BackColor = Color.OrangeRed
                End If
            Next
        Catch ex As Exception
            log.WriteToArchiveLog("ERROR btnInclFileType_Click : " + ex.Message)
            SB.Text = "Error - please refer to error log."
        End Try
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub btnRemoveExclude_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveExclude.Click

        SB.Text = "Profile maintenance selected, will not affect directory setup."
        For i As Integer = lbExcludeExts.SelectedItems.Count To 0 Step -1
            Dim II As Integer = lbExcludeExts.SelectedIndex
            If II >= 0 Then
                lbExcludeExts.Items.RemoveAt(II)
            End If
        Next


        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub
    Function FolderExists(ByVal FolderName As String)

        Dim TgtFolder$ = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")

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
        Dim S1$ = ""
        Dim SA As New SortedList(Of String, String)

        For K As Integer = 0 To lbIncludeExts.Items.Count - 1
            S1$ = lbIncludeExts.SelectedItem.ToString.ToLower
            If SA.IndexOfKey(S1$) < 0 Then
                SA.Add(S1, S1)
            End If
        Next
        S1$ = lbIncludeExts.SelectedItem.ToString
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
        If InStr(txtDir.Text, "%userid%", CompareMethod.Text) > 0 Then
            clAdminDir.Checked = True
        End If
    End Sub

    Private Sub ckUseLastProcessDateAsCutoff_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckUseLastProcessDateAsCutoff.CheckedChanged
        DB.UserParmInsertUpdate("ckUseLastProcessDateAsCutoff", gCurrUserGuidID, ckUseLastProcessDateAsCutoff.Checked)
    End Sub

    Private Sub frmReconMain_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize

        If formloaded = False Then
            Return
        End If
        ResizeControls(Me)

    End Sub
    Sub resetBadDates()

        Dim S$ = "Update Email set CreationDate = getdate() where CreationDate is NULL ;"
        Dim B As Boolean = DB.ExecuteSqlNewConn(S)

        S$ = "update Email set SentOn = CreationDate where SentOn > '1/1/4500' and UserID = '" + gCurrUserGuidID + "'"
        B = DB.ExecuteSqlNewConn(S)

        If Not B Then
            LOG.WriteToArchiveLog("Warning : Check email senton dates as some were found to be invalid in the emails.")
        End If
    End Sub

    Sub GetExchangeFolders(ByVal bNewThread As Boolean)

        If DB.isArchiveDisabled("EXCHANGE") = True Then
            Return
        End If

        Dim EM As New clsEmailFunctions
        If gCurrentArchiveGuid$.Length = 0 Then
            gCurrentArchiveGuid$ = Guid.NewGuid.ToString
        End If

        LOG.WriteToArchiveLog("GetExchangeFolders 100")
        'FrmMDIMain.SB.Text = "Archiving Exchange Folders - you can continue to work."

        If bNewThread Then
            'SB.Text = "Launching Exchange Archive - it will run in background."
            If ddebug Then
                LOG.WriteToTraceLog("Entering LaunchExchangeDownload from frmReconMain")
            End If
            EM.LaunchExchangeDownload()
        Else
            'SB.Text = "Launching Exchange Archive"
            If ddebug Then
                LOG.WriteToTraceLog("Entering ProcessExchangePopMail from frmReconMain")
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
        Dim pName$ = cbProfile.Text
        If pName$.Trim.Length = 0 Then
            messagebox.show("Please select a profile.")
            Return
        End If
        pName$ = UTIL.RemoveSingleQuotes(pName$)
        Dim S$ = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = '" + pName$ + "' order by SourceTypeCode"
        DB.PopulateListBoxMerge(Me.lbIncludeExts, "SourceTypeCode", S)
        DB.PopulateListBoxRemove(Me.lbExcludeExts, "SourceTypeCode", S)
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub btnExclProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExclProfile.Click
        Dim pName$ = cbProfile.Text
        If pName$.Trim.Length = 0 Then
            messagebox.show("Please select a profile.")
            Return
        End If
        pName$ = UTIL.RemoveSingleQuotes(pName$)
        Dim S$ = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = '" + pName$ + "' order by SourceTypeCode"
        DB.PopulateListBoxMerge(Me.lbExcludeExts, "SourceTypeCode", S)
        DB.PopulateListBoxRemove(Me.lbIncludeExts, "SourceTypeCode", S)
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Sub SetArchiveEndStats(ByVal ArchiveType$)
        STATS.setArchiveenddate(Now.ToString)
        STATS.setArchivetype(ArchiveType$)
        STATS.setStatus("Successful")
        STATS.setSuccessful("Y")
        STATS.setUserid(gCurrUserGuidID)

        Dim iCnt As Integer = 0
        iCnt = DB.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + gCurrUserGuidID + "'")
        log.WriteToArchiveLog("Archive Count: Source Files - " + iCnt.ToString)
        STATS.setTotalcontentinrepository(iCnt.ToString)
        iCnt = DB.iGetRowCount("Email", "where UserID = '" + gCurrUserGuidID + "'")
        log.WriteToArchiveLog("Archive Count: Emails - " + iCnt.ToString)
        STATS.setTotalemailsinrepository(iCnt.ToString)

        iCnt = STATS.cnt_PK_ArchiveStats(gCurrentArchiveGuid)
        If iCnt = 0 Then
            Dim BB As Boolean = STATS.Insert
            If Not BB Then
                log.WriteToArchiveLog("error 2345.01.1 - DID NOT INSERT STATS.")
            End If
        End If
        If iCnt > 0 Then
            Dim WC$ = STATS.wc_PK_ArchiveStats(gCurrentArchiveGuid)
            Dim b As Boolean = STATS.Update(WC)
            If Not b Then
                log.WriteToArchiveLog("Failed to update archive statistics: " + Now.ToString)
            End If
        End If
    End Sub
    Sub SetArchiveBeginStats(ByVal ArchiveType$, ByVal NewGuid$)
        STATS.setArchivestartdate(Now.ToString)
        STATS.setArchiveenddate(Now.ToString)
        STATS.setArchivetype(ArchiveType$)
        STATS.setStatguid(NewGuid)
        STATS.setStatus("Running")
        STATS.setSuccessful("N")
        STATS.setUserid(gCurrUserGuidID)
        STATS.setTotalcontentinrepository("0")
        STATS.setTotalemailsinrepository("0")

        Dim iCnt As Integer = 0
        iCnt = DB.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + gCurrUserGuidID + "'")
        STATS.setTotalcontentinrepository(iCnt.ToString)
        iCnt = DB.iGetRowCount("Email", "where UserID = '" + gCurrUserGuidID + "'")
        STATS.setTotalemailsinrepository(iCnt.ToString)

        iCnt = STATS.cnt_PK_ArchiveStats(NewGuid)
        If iCnt = 0 Then
            Dim BB As Boolean = STATS.Insert
            If Not BB Then
                SB.Text = ("error 2345.01.1a - DID NOT INSERT STATS.")
                log.WriteToArchiveLog("error 2345.01.1a - DID NOT INSERT STATS.")
            End If
        End If
        If iCnt > 0 Then
            Dim WC$ = STATS.wc_PK_ArchiveStats(NewGuid)
            Dim b As Boolean = STATS.Update(WC)
            If Not b Then
                SB.Text = ("error 2345.01.1b - DID NOT INSERT STATS.")
                log.WriteToArchiveLog("error 2345.01.1b - DID NOT INSERT STATS.")
            End If
        End If
    End Sub

    Private Sub cbParentFolders_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbParentFolders.SelectedIndexChanged
        'If formloaded Then
        '    If cbParentFolders.Text.Trim.Length > 0 Then
        '        btnRefreshFolders_Click(Nothing, Nothing)
        '    End If
        'End If
        ParentFolder = cbParentFolders.Text.Trim
    End Sub

    Private Sub ResetSelectedMailBoxesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ResetSelectedMailBoxesToolStripMenuItem.Click
        Dim msg$ = "This will remove all of your mailbox selections" + vbCrLf + "it will not remove any archives. Are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Reset Email Folders", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim S$ = ""
        S = "DELETE FROM [EmailArchParms] "
        S = S + " WHERE UseriD = '" + gCurrUserGuidID + "'"

        Dim B As Boolean = DB.ExecuteSqlNewConn(S, False)
        If B Then
            S = "DELETE FROM [EmailFolder] "
            S = S + " WHERE UseriD = '" + gCurrUserGuidID + "'"

            B = DB.ExecuteSqlNewConn(S, False)

            If B Then
                SB.Text = "Mailboxes successfully reset"
            Else
                SB.Text = "Mailboxes DID NOT reset"
            End If

        Else
            SB.Text = "Mailboxes DID NOT reset"
        End If

        If Now < #10/5/2009# Then
            Dim TgtFolder$ = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
            Dim SS$ = "update Email set originalfolder = '" + TgtFolder$ + "' + '|' + originalfolder where originalfolder not like '%|%' "
            DB.ExecuteSqlNewConn(SS$)
        End If

    End Sub

    Private Sub ContextMenuStrip1_Opening(ByVal sender As System.Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles ContextMenuStrip1.Opening

    End Sub

    Private Sub EmailLibraryReassignmentToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmailLibraryReassignmentToolStripMenuItem.Click
        'Me.lbArchiveDirs.SelectedItem.ToString
        Dim FolderName$ = Me.lbActiveFolder.SelectedItem.ToString
        FolderName = cbParentFolders.Text.Trim + "|" + FolderName
        FolderName = UTIL.RemoveSingleQuotes(FolderName)

        'frmLibraryAssignment.MdiParent = 'FrmMDIMain
        frmLibraryAssignment.setFolderName(FolderName)
        frmLibraryAssignment.SetTypeContent(False)
        frmLibraryAssignment.Show()

    End Sub

    Private Sub cbFileDB_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbFileDB.SelectedIndexChanged

    End Sub

    Private Sub Label8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label8.Click

    End Sub

    Private Sub lbAvailExts_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbAvailExts.SelectedIndexChanged
        If lbAvailExts.SelectedItems.Count > 0 Then
            btnInclFileType.Visible = True
            btnExclude.Visible = True
        Else
            btnInclFileType.Visible = False
            btnExclude.Visible = False
        End If
    End Sub

    Private Sub ckTerminate_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckTerminate.CheckedChanged
        If ckTerminate.Checked = True Then
            gTerminateImmediately = True
        Else
            gTerminateImmediately = False
        End If
    End Sub

    Private Sub btnSaveDirProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveDirProfile.Click

        Dim DirProfileName$ = cbDirProfile.Text.Trim
        If DirProfileName$.Length = 0 Then
            messagebox.show("A directory profile name must be supplied, returning.")
            Return
        End If

        DirProfileName$ = UTIL.RemoveSingleQuotes(DirProfileName$)
        Dim Parms$ = buildDirProfileParms()
        Dim S$ = "Select count(*) from DirProfiles where ProfileName = '" + DirProfileName$ + "'"

        Dim iCnt As Integer = DB.iCount(S)

        If iCnt = 0 Then

            S = ""
            S = S + " INSERT INTO [DirProfiles]"
            S = S + " ([ProfileName]"
            S = S + " ,[Parms])"
            S = S + "  VALUES "
            S = S + " ('" + DirProfileName$ + "'"
            S = S + " ,'" + Parms$ + "')"

            Dim B As Boolean = DB.ExecuteSqlNewConn(S)
            If B Then
                SB.Text = "Added the new directory profile, " + DirProfileName$
                S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]"
                DB.PopulateComboBox(Me.cbDirProfile, "ProfileName", S)
                cbDirProfile.Text = DirProfileName$
            Else
                SB.Text = "Failed to add the directory profile, " + DirProfileName$ + " Please check the error logs."
            End If
        Else
            messagebox.show("The profile named '" + DirProfileName$ + "' already exists in the repository, returning.")
            SB.Text = "The profile named '" + DirProfileName$ + "' already exists in the repository, returning."
            Return
        End If

    End Sub

    Private Sub btnApplyDirProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApplyDirProfile.Click
        Dim DirProfileName As String = cbDirProfile.Text.Trim
        If DirProfileName$.Length = 0 Then
            messagebox.show("A directory profile name must be supplied, returning.")
            Return
        End If

        bApplyingDirParms = True

        Dim Parms As String = DB.getDirProfile(DirProfileName$)
        applyDirProfileParms(Parms)

        bApplyingDirParms = False
        btnSaveChanges.BackColor = Color.OrangeRed

    End Sub

    Private Sub btnUpdateDirectoryProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdateDirectoryProfile.Click

        Dim DirProfileName$ = cbDirProfile.Text.Trim
        If DirProfileName$.Length = 0 Then
            messagebox.show("A directory profile name must be supplied, returning.")
            Return
        End If

        Dim Parms$ = buildDirProfileParms()

        DirProfileName$ = UTIL.RemoveSingleQuotes(DirProfileName$)
        Dim S$ = "Update DirProfiles set Parms = '" + Parms$ + "' where ProfileName = '" + DirProfileName$ + "'"
        Dim B As Boolean = DB.ExecuteSqlNewConn(S)
        If B Then
            SB.Text = "Directory Profile: " + DirProfileName + " updated."
        Else
            SB.Text = "Directory Profile: " + DirProfileName + " failed to update."
        End If

    End Sub

    Private Sub btnDeleteDirProfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDeleteDirProfile.Click
        Dim DirProfileName$ = cbDirProfile.Text.Trim
        If DirProfileName$.Length = 0 Then
            messagebox.show("A directory profile name must be supplied, returning.")
            Return
        End If

        DirProfileName$ = UTIL.RemoveSingleQuotes(DirProfileName$)
        Dim S$ = "delete from DirProfiles where ProfileName = '" + DirProfileName$ + "'"
        Dim B As Boolean = DB.ExecuteSqlNewConn(S)
        If B Then
            S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]"
            DB.PopulateComboBox(Me.cbDirProfile, "ProfileName", S)
            SB.Text = DirProfileName + " deleted."
        Else
            SB.Text = DirProfileName + " failed to delete."
        End If

    End Sub

    Function buildDirProfileParms() As String

        Dim Parms$ = ""
        Parms += "cbRetention" + Chr(253) + cbRetention.Text + Chr(254)

        Parms += "ckSubDirs" + Chr(253) + ckSubDirs.Checked.ToString + Chr(254)
        Parms += "ckOcr" + Chr(253) + ckOcr.Checked.ToString + Chr(254)
        Parms += "ckVersionFiles" + Chr(253) + ckVersionFiles.Checked.ToString + Chr(254)
        Parms += "ckMetaData" + Chr(253) + ckMetaData.Checked.ToString + Chr(254)
        Parms += "ckPublic" + Chr(253) + ckPublic.Checked.ToString + Chr(254)
        Parms += "clAdminDir" + Chr(253) + clAdminDir.Checked.ToString + Chr(254)

        Dim xFiles$ = "InclExt" + Chr(253)

        For I As Integer = 0 To lbIncludeExts.Items.Count - 1
            Try
                xFiles += lbIncludeExts.Items(I).ToString + Chr(252)
            Catch ex As Exception

            End Try
        Next
        xFiles += Chr(254)
        Parms += xFiles

        xFiles$ = "ExclExt" + Chr(253)
        For I As Integer = 0 To lbExcludeExts.Items.Count - 1
            Try
                xFiles += Me.lbExcludeExts.Items(I).ToString + Chr(252)
            Catch ex As Exception

            End Try

        Next
        xFiles += Chr(254)
        Parms += xFiles

        Parms$ = UTIL.RemoveSingleQuotes(Parms$)

        Return Parms

    End Function

    Sub applyDirProfileParms(ByVal Parms$)

        Dim ParmArray$() = Parms.Split(Chr(254))
        Dim Parm$ = ""
        Dim ParmValue$ = ""

        For i As Integer = 0 To UBound(ParmArray$)
            Dim tParm$ = ParmArray(i)
            Dim A$() = tParm.Split(Chr(253))

            If UBound(A) = 1 Then
                Parm = A(0)
                ParmValue$ = A(1)
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
                Dim aExt$() = ParmValue.Split(Chr(252))
                For ii As Integer = 0 To UBound(aExt)
                    If aExt(ii).Trim.Length > 0 Then
                        lbIncludeExts.Items.Add(aExt(ii))
                    End If
                Next
            End If
            If Parm.Equals("ExclExt") Then
                lbExcludeExts.Items.Clear()
                Dim aExt$() = ParmValue.Split(Chr(252))
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

    End Sub

    Private Sub ckArchiveBit_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckArchiveBit.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        Dim S$ = ""
        S = "Whenever a file is created or changed, the operating system activates the Archive Bit or modified bit. Unless you select to use backup methods that depend on a date and time stamp, ECM Library uses the archive bit to determine whether a file has been backed up, which is an important element of your backup strategy. It is dangerous if other archive methods, processes or tools access an identified directory." + vbCrLf
        S = S + "Selecting the following backup methods can affect the archive bit: " + vbCrLf
        S = S + "  •  Full - Back up files - Using archive bit (reset archive bit) + vbcrlf"
        S = S + "  •  Differential - Back up changed files since last full - Using archive bit (does not reset archive bit) + vbcrlf"
        S = S + "  •  Incremental - Back up changed files since last full or incremental - Using archive bit (reset archive bit) + vbcrlf"
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
        If Not ckDisable.Checked Then
            CkMonitor.Checked = False
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckOcr_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckOcr.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckVersionFiles_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckVersionFiles.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckMetaData_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckMetaData.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub clAdminDir_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles clAdminDir.CheckedChanged
        If bActiveChange = True Then
            Return
        End If
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub CkMonitor_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CkMonitor.CheckedChanged
        If bActiveChange = True Then
            Return
        End If

        If formloaded = False Then
            Return
        End If

        If lbArchiveDirs.SelectedItems.Count <> 1 Then
            Return
        End If

        'Dim LISTEN As New clsListener

        If CkMonitor.Checked = True Then
            LISTEN.AddDirListener(DirGuid, ckDisableDir.Checked, 0, 1, 0, 1, ckSubDirs.Checked, MachineName$)
            LISTEN.setDirListernerON(DirGuid$)
            LISTEN.PauseDirListener(DirGuid, False)

            LISTEN.LoadListeners(MachineName)

            SB.Text = "Listener Added."

        Else
            LISTEN.deleteDirListener(DirGuid$)
            LISTEN.setDirListernerOFF(DirGuid$)
            LISTEN.PauseDirListener(DirGuid, True)
            If ckRunUnattended.Checked = True Then
                LISTEN.LoadListeners(MachineName)
                SB.Text = "Listener disabled - restart of ECM required to remove it."
            Else
                MessageBox.Show("Listener disabled - restart of ECM required to completely remove it.", "LISTENER", System.Windows.Forms.MessageBoxButtons.OK)
            End If

        End If

        'LISTEN = Nothing

        'btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Private Sub ckRunUnattended_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckRunUnattended.CheckedChanged

        If formloaded = False Then
            Return
        End If

        Dim S$ = ""
        Dim B As Boolean = False

        If ckRunUnattended.Checked Then
            frmAgreement.txtAgreement.Text = "Running in unattended mode will cause all warnings and errors that HALT the system to be written to a log and NOT shown or displayed. By selecting this option, you agree to accept full responsibility to review this log for errors. ECM Library accepts no responsibility to notify you of errors outside of the log when running in unattended mode."
            frmAgreement.ShowDialog()
            B = gLegalAgree
            If B = False Then
                S$ = "UPDATE [RunParms] SET [ParmValue] = '0' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + gCurrUserGuidID + "' "
                B = DB.ExecuteSqlNewConn(S)
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

        Dim ckVal$ = DB.getUserParm("user_RunUnattended")
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

            B = DB.ExecuteSqlNewConn(S, False)
        End If

        If ckRunUnattended.Checked Then
            S$ = "UPDATE [RunParms] SET [ParmValue] = '1' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + gCurrUserGuidID + "' "
            B = DB.ExecuteSqlNewConn(S)
            If B Then
                gRunUnattended = True
                SB.Text = "System set to run in unattended mode."
                'FrmMDIMain.SB4.BackColor = Color.Red
                'FrmMDIMain.SB4.Text = "Unattended ON"
            Else
                gRunUnattended = False
            End If
        Else
            S$ = "UPDATE [RunParms] SET [ParmValue] = '0' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + gCurrUserGuidID + "' "
            B = DB.ExecuteSqlNewConn(S)
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

        Dim S$ = ""
        Dim B As Boolean = DB.SysParmExists("srv_RunUnattended")
        If B = False Then
            S$ = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)"
            S = S + " values ('srv_RunUnattended','This allows the archive functions to run unattended.','N','Y')"
            B = DB.ExecuteSqlNewConn(S)
            If B Then
                gRunUnattended = False
                SB.Text = "Unattended mode turned off."
            Else
                SB.Text = "Failed to turned off RUN UNATTENDED mode - no change to current state."
            End If
        End If

        Dim ckVal$ = DB.getUserParm("user_RunUnattended")
        If ckVal$.Equals("1") Then
            gRunUnattended = True
        ElseIf ckVal$.Equals("0") Then
            gRunUnattended = False
        ElseIf ckVal$.ToUpper.Equals("Y") Then
            gRunUnattended = True
        ElseIf ckVal$.ToUpper.Equals("N") Then
            gRunUnattended = False
        Else
            gRunUnattended = False
        End If
    End Sub
    Sub SetUnattendedCheckBox()
        formloaded = False

        Dim ckVal$ = DB.getUserParm("user_RunUnattended")

        If ckVal$.Equals("1") Then
            gRunUnattended = True
            Me.ckRunUnattended.Checked = gRunUnattended
        ElseIf ckVal$.Equals("0") Then
            gRunUnattended = False
            Me.ckRunUnattended.Checked = gRunUnattended
        ElseIf ckVal$.ToUpper.Equals("Y") Then
            gRunUnattended = True
            Me.ckRunUnattended.Checked = gRunUnattended
        ElseIf ckVal$.ToUpper.Equals("N") Then
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
            Dim Container$ = cbParentFolders.Items(I).ToString
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
        Catch ex As Exception
            TempList = Nothing
            LOG.WriteToArchiveLog("WARNING: TICK - 001: " + ex.Message)
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
        Static ListenersLoaded As Boolean = False
        If ckPauseListener.Checked = True Then
            LISTEN.PauseListeners(MachineName$, True)
            TimerListeners.Enabled = False
        Else
            If ListenersLoaded = False Then
                ListenersLoaded = True
                LISTEN.LoadListeners(MachineName)
            End If

            LISTEN.PauseListeners(MachineName$, False)
            TimerListeners.Enabled = True
        End If
        'LISTEN = Nothing
    End Sub

    ''** process table DirectoryListenerFiles
    Sub ProcessListenerFiles(ByVal UseThreads As Boolean)

        Dim L As New SortedList(Of String, Integer)
        '**********************************************
        'DB.GetListenerFiles(L)
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

            DirGuid = DB.getDirGuid(DirName, MachineName)
            DirName = DB.getDirListenerNameByGuid(DirGuid$)
            'DirGuid$ = DB.getDirGuid(DirName, MachineIDcurr)

            DirGuid = DirGuid.Trim

            Successful = False
            LOG.WriteToListenLog("ArchiveSingleFile: archiving " + FQN + " From machine " + MachineName + ".")

            Dim fExt As String = DMA.getFileExtension(FQN)
            If File.Exists(FQN) Then
                ARCH.ArchiveSingleFile(UIDcurr, MachineName$, DirName, FQN, DirGuid, Successful)
                If Successful Then
                    DBLocal.MarkListenersProcessed(FQN)
                End If
            Else
                DBLocal.MarkListenersProcessed(FQN)
                'Dim SX As String = "delete FROM [DirectoryListenerFiles] where SourceFile = '" + FQN + "'  and DirGuid   = '" + DirGuid$ + "'"
                'DB.ExecuteSqlNewConn(SX)
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
        Catch ex As Exception
            Console.WriteLine("TimerUploadFiles forms")
        End Try
        frm = Nothing

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
            Dim tFQN$ = cPath + "\ListenerFilesLog.ECM"
            Dim NewFile$ = tFQN + ".rdy"

            If Not File.Exists(tFQN$) Then
                gListenerActivityStart = Now
                'TimerUploadFiles.Enabled = False
                Return
            Else
                gListenerActivityStart = Now
            End If

            LOG.WriteToInstallLog("ACTIVATED the TimerUploadFiles !")

            TimerUploadFiles.Enabled = False

            '**********************************************
            DB.getModifiedFiles()
            '**********************************************
            TimerUploadFiles.Enabled = True
            TimerListeners.Enabled = True

            If Not File.Exists(NewFile) Then
                ISO.saveIsoFile("$FilesToDelete.dat", NewFile + "|")
                'File.Delete(NewFile)
            End If

        End If

    End Sub

    Private Sub TimerEndRun_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TimerEndRun.Tick

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
        Catch ex As Exception
            Console.WriteLine("TimerEndRun_Tick forms")
        End Try
        frm = Nothing

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


        Dim ArchiveType$ = ""
        ArchiveType$ = DB.getRconParm(gCurrUserGuidID, "ArchiveType")
        STATS.setArchiveenddate(Now.ToString)
        STATS.setArchivetype(ArchiveType$)
        STATS.setStatus("Successful")
        STATS.setSuccessful("Y")
        STATS.setUserid(gCurrUserGuidID)

        Dim iCnt As Integer = 0
        iCnt = DB.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + gCurrUserGuidID + "'")
        STATS.setTotalcontentinrepository(iCnt.ToString)
        iCnt = DB.iGetRowCount("Email", "where UserID = '" + gCurrUserGuidID + "'")
        STATS.setTotalemailsinrepository(iCnt.ToString)

        Dim BB As Boolean = STATS.Insert
        If Not BB Then
            log.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.")
            LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.")
        End If

        Me.SetArchiveEndStats(ArchiveType)

        TimerEndRun.Enabled = False

        If UseThreads = False Then
            DB.UpdateAttachmentCounts()
        Else
            ThreadCnt += 1
            t6 = New Thread(AddressOf DB.UpdateAttachmentCounts)
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

        gCurrentArchiveGuid$ = ""

    End Sub

    Private Sub btnRefreshRetent_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshRetent.Click
        DB.LoadRetentionCodes(cbRetention)
        DB.LoadRetentionCodes(cbEmailRetention)
    End Sub

    Private Sub ckShowLibs_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckShowLibs.CheckedChanged
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
        btnSaveChanges.BackColor = Color.OrangeRed
    End Sub

    Sub SetDateFormats()

        Dim dateString, format As String
        Dim result As Date

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

        Dim LT As String = Nothing
        Dim bLicenseExists As Boolean = DB.LicenseExists
        If Not bLicenseExists Then
            messagebox.show("There does not appear to be an active license for this installation, please contact an administrator - or install a valid license.")
        Else
            '** Check the expiration date and the service expiration date
            Dim MachineName$ = DMA.GetCurrMachineName

            DB.RegisterMachineToDB(MachineName$)

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 12")

            LT = DB.GetXrt
            Dim isLease As Boolean = LM.isLease
            gMaxClients = LM.getMaxClients

            If gMaxClients > 0 Then
                Dim SS$ = "Select count(*) from LoginClient"
                Dim EcmClientsDefinedToSystem As Integer = DB.iCount(SS$)
                If EcmClientsDefinedToSystem > gMaxClients Then
                    Dim MSG$ = "It appears all ECM Client licenses have been used." + vbCrLf
                    MSG += "Please logon from a licensed machine," + vbCrLf + vbCrLf
                    MSG += "or contact ECM Library for additional client licenses." + vbCrLf + vbCrLf
                    MSG += "Thank you, closing down." + vbCrLf
                    messagebox.show(MSG)
                    End
                End If
            End If

            DB.RegisterEcmClient(MachineName$)

            gNbrOfSeats = Val(LM.ParseLic(LT$, "txtNbrSeats"))
            gLicenseType = LM.LicenseType
            gIsSDK = LM.SdkLicenseExists

            tssUser.Text = "Seats:" + gNbrOfSeats.ToString
            gNbrOfUsers = Val(LM.ParseLic(LT$, "txtNbrSimlSeats"))
            tssServer.Text = "Server: ?"

            '**********************************************************
            Dim CurrNbrOfUsers As Integer = DB.GetNbrUsers
            Dim CurrNbrOfMachine As Integer = DB.GetNbrMachine
            '**********************************************************

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 13")

            If CurrNbrOfUsers >= gNbrOfUsers Then
                Dim Msg$ = ""
                Msg = Msg + "FrmMDIMain : MachineName : 1103 : " + vbCrLf
                Msg = Msg + "     Number of licenses warning : '" + MachineName + "'" + vbCrLf
                Msg = Msg + "     We are very sorry, but the maximum number of USERS has been exceeded." + vbCrLf
                Msg = Msg + "     ECM found " + CurrNbrOfUsers.ToString + " users currently registered in the system." + vbCrLf
                Msg = Msg + "     Your license awards " + gNbrOfUsers.ToString + " users." + vbCrLf
                Msg = Msg + "You will have to login with an existing User ID and Password." + vbCrLf + "Please contact admin for support."
                log.WriteToArchiveLog(Msg)
                MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                Me.LoginAsDifferenctUserToolStripMenuItem_Click(Nothing, Nothing)
            End If

            If CurrNbrOfMachine >= gNbrOfSeats Then
                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 14")
                Dim IP$ = DMA.getIpAddr
                gIpAddr$ = IP$
                MachineIDcurr = MachineName$
                DB.updateIp(MachineIDcurr$, gIpAddr$, 0)
                DB.updateIp(MachineIDcurr$, gIpAddr$, 1)
                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 15")
                Dim Msg$ = ""
                Msg = Msg + "FrmMDIMain : Current Users : 1103b : " + vbCrLf
                Msg = Msg + "     Number of current SEATS warning : '" + MachineName + "'" + vbCrLf
                Msg = Msg + "     We are very sorry, but the maximum number of seats (WorkStations) has been exceeded." + vbCrLf
                Msg = Msg + "     ECM found " + CurrNbrOfMachine.ToString + " machines registered in the system." + vbCrLf
                Msg = Msg + "     Your license awards " + gNbrOfSeats.ToString + " seats." + vbCrLf
                Msg = Msg + "You will have to login from a WorkStation already defined to ECM." + vbCrLf + "Please contact admin for support."
                log.WriteToArchiveLog(Msg)
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
                        messagebox.show("Restarting the application.")
                        Application.Restart()
                    End If
                End If
            Else
                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 16")
                Dim iExists As Integer = DB.GetNbrMachine(MachineName)
                If iExists = 0 Then
                    Dim MySql$ = "insert into Machine (MachineName) values ('" + MachineName + "')"
                    Dim B As Boolean = DB.ExecuteSqlNewConn(MySql, False)
                    If Not B Then
                        log.WriteToArchiveLog("FrmMDIMain : MachineName : 921 : Failed to register machine : '" + MachineName + "'")
                    End If
                End If
                Dim IP$ = DMA.getIpAddr

                gIpAddr$ = IP$
                MachineIDcurr$ = MachineName$

                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 17")

                DB.updateIp(MachineIDcurr$, gIpAddr$, 0)
                DB.updateIp(MachineIDcurr$, gIpAddr$, 2)

                If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 18")

            End If

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 19")

            If isLease = True Then

                Dim ExpirationDate As Date = CDate(LM.ParseLic(LT$, "dtExpire"))

                Dim dtStartDate As Date = "1/1/2007"
                Dim tsTimeSpan As TimeSpan
                Dim iNumberOfDays As Integer
                Dim strMsgText As String
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
                    log.WriteToArchiveLog("FrmMDIMain : 1001 We are very sorry, but your software LEASE has expired. Please contact ECM Library support.")
                    MessageBox.Show("We are very sorry, but your software license has expired." + vbCrLf + vbCrLf + "Please contact ECM Library support.", "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK)
                    frmLicense.ShowDialog()
                    messagebox.show("The application will now end, please restart with the new license.")
                End If
            End If

            If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 21")
            Dim MaintExpire As Date = CDate(LM.ParseLic(LT$, "dtMaintExpire"))
            If Now > MaintExpire Then
                frmNotifyMessage.MsgToDisplay = "We are very sorry to inform you, but your maintenance agreement has expired." + vbCrLf + vbCrLf + "Please contact ECM Library support."
                frmNotifyMessage.Show()
                log.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.")
            End If
            'If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 22")
            'CustomerID = LM.ParseLic(LT$, "txtCustID")
            'If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 23")
        End If
    End Function

    Private Sub OutlookEmailsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OutlookEmailsToolStripMenuItem.Click

        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If
        If ckDisableOutlookEmailArchive.Checked Then
            SB.Text = "DISABLE Exchange is checked - no archive allowed."
            Return
        End If

        If BackgroundWorker1.IsBusy Then
            Return
        End If

        Try
            BackgroundWorker1.RunWorkerAsync()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try


    End Sub

    Private Sub ExchangeEmailsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExchangeEmailsToolStripMenuItem.Click
        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If
        If ckDisableExchange.Checked Then
            SB.Text = "DISABLE Exchange Archive is checked - no archive allowed."
            Return
        End If

        If BackgroundWorker2.IsBusy Then
            Return
        End If

        Try
            BackgroundWorker2.RunWorkerAsync()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try

    End Sub

    Private Sub ContentToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ContentToolStripMenuItem.Click
        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If
        If ckDisableContentArchive.Checked Then
            SB.Text = "DISABLE Content Archive is checked - no archive allowed."
            Return
        End If

        If BackgroundWorker3.IsBusy Then
            Return
        End If

        Try
            BackgroundWorker3.RunWorkerAsync()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try

    End Sub

    Private Sub ArchiveALLToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ArchiveALLToolStripMenuItem.Click

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
        If Not BackgroundWorker3.IsBusy Then
            BackgroundWorker3.RunWorkerAsync()
        End If
        If Not BackgroundWorkerContacts.IsBusy Then
            BackgroundWorkerContacts.RunWorkerAsync()
        End If
        'If Not asyncBatchOcrPending.IsBusy Then
        '    ReOcrPendingGraphics()
        'End If

    End Sub

    Private Sub LoginAsDifferenctUserToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LoginAsDifferenctUserToolStripMenuItem.Click
        CloseChildWindows()
        LoginAsNewUser = True
        gCurrLoginID = ""
        Me.LogIntoSystem(gCurrLoginID)
        tssUser.Text = gCurrUserGuidID
        tssAuth.Text = DB.getAuthority(gCurrUserGuidID)
    End Sub
    Sub CloseChildWindows()
        Dim form As System.Windows.Forms.Form
        For Each form In Me.MdiChildren
            form.Close()
        Next form
    End Sub
    Sub LogIntoSystem(ByVal OverRideLoginID As String)
        Try
            For Each f As Form In Me.MdiChildren
                f.Close()
            Next f
        Catch ex As Exception

        End Try
        Try
            Me.SB.Text = "Loading, standby"
            FilesToDelete.Clear()

            Me.SB.Text = "Ready"
            Dim SaveName$ = "UserStartUpParameters"
            Dim SaveTypeCode$ = "StartUpParm"
            Dim CurrentLoginID$ = ""
            Dim iAttempts As Integer = 1
Retry:
            If iAttempts >= 4 Then
                messagebox.show("Too many failed login attempts, closing down.")
                Me.Close()
                Me.Dispose()
                End
            End If

            Dim X1$ = System.Configuration.ConfigurationManager.AppSettings("LoginByMachineIdAndLoginID")
            If X1.Equals("1") And LoginAsNewUser = False Then
                Dim LoggedInUser$ = LOG.getEnvVarUserID
                If OverRideLoginID.Length > 0 Then
                    LoggedInUser$ = OverRideLoginID
                End If
                If LoggedInUser$.Length = 0 Then
                    LoggedInUser$ = DMA.GetCurrMachineName()
                End If

                gCurrUserGuidID = DB.getUserGuidID(LoggedInUser$)
                If gCurrUserGuidID.Length > 0 Then
                    '** Good login
                    GoTo GoodLogin
                Else
                    GoTo BadAutoLogin
                End If
            End If
BadAutoLogin:
            LoginForm1.ShowDialog()

            If System.Environment.UserName.ToString.Length = 0 Then
                gCurrUserGuidID = DMA.GetCurrMachineName()
                LoginForm1.txtLoginID.Text = DMA.GetCurrMachineName()
            Else
                LoginForm1.txtLoginID.Text = System.Environment.UserName.ToString
            End If

            CurrentLoginID$ = LoginForm1.UID

            Dim BB As Boolean = LoginForm1.bGoodLogin
            If BB And CurrentLoginID$.Trim.Length > 0 Then
                gCurrUserGuidID = DB.getUserGuidID(CurrentLoginID$)
            Else
                messagebox.show("Incorrect login or password supplied, please try again.")
                iAttempts += 1
                LoginForm1.Dispose()
                GoTo Retry
            End If
            LoginForm1.Dispose()
GoodLogin:
            gCurrLoginID$ = CurrentLoginID$.ToUpper

            gCurrUserGuidID = DB.getUserGuidID(gCurrLoginID$)
            If gCurrLoginID.ToUpper.Equals("SERVICEMANAGER") Then
                gIsServiceManager = True
                'QuickArchiveToolStripMenuItem.Visible = False
                CurrentLoginID = gCurrLoginID
            Else
                gIsServiceManager = False
                'QuickArchiveToolStripMenuItem.Visible = True
            End If

            If gCurrUserGuidID.Trim.Length = 0 Then
                CurrentLoginID$ = System.Environment.UserName.ToString
            End If
            If gCurrUserGuidID.Trim.Length = 0 Then
                gCurrUserGuidID = DB.getUserGuidID(CurrentLoginID$)
            End If
            Dim TempDir$ = System.IO.Path.GetTempPath

            SetDefaults()

            'frmQuickSearch.MdiParent = Me
            'frmQuickSearch.Show()
            'frmQuickSearch.WindowState = FormWindowState.Maximized

            Dim b As Integer = DB.ckUserStartUpParameter(gCurrUserGuidID, "CONTENT WORKING DIRECTORY")
            If b = 0 Then
                SI.setSavename(SaveName)
                SI.setSavetypecode(SaveTypeCode$)
                SI.setUserid(gCurrUserGuidID)
                SI.setValname("CONTENT WORKING DIRECTORY")
                SI.setValvalue(TempDir)
                SI.Insert()
            End If
            b = DB.ckUserStartUpParameter(gCurrUserGuidID, "EMAIL WORKING DIRECTORY")
            If b = 0 Then
                SI.setSavename(SaveName)
                SI.setSavetypecode(SaveTypeCode$)
                SI.setUserid(gCurrUserGuidID)
                SI.setValname("EMAIL WORKING DIRECTORY")
                SI.setValvalue(TempDir)
                SI.Insert()
            End If
            SB.Text = "Logged in as " + CurrentLoginID$
        Catch ex As Exception
            log.WriteToArchiveLog("FrmMDIMain : ReLogIntoSystem : 100 : " + ex.Message)
            messagebox.show("LogIntoSystem: Login failed.")
        End Try

        isAdmin = DB.isAdmin(gCurrUserGuidID)
        isGlobalSearcher = DB.isGlobalSearcher(gCurrUserGuidID)

        If isAdmin Then
            SB.Text = "ADMIN Logged in as: " + DB.getUserLoginByUserid(gCurrUserGuidID)
        Else
            SB.Text = "Logged in as: " + DB.getUserLoginByUserid(gCurrUserGuidID)
        End If

        If DB.isSuperAdmin(gCurrUserGuidID) Then
            ImpersonateLoginToolStripMenuItem.Visible = True
        Else
            ImpersonateLoginToolStripMenuItem.Visible = False
        End If

    End Sub
    Sub SetDefaults()

        DB.LoadProcessDates()
        'bFormLoaded = True

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 25")

        isAdmin = DB.isAdmin(gCurrUserGuidID)
        isGlobalSearcher = DB.isGlobalSearcher(gCurrUserGuidID)

        DB.UserParmInsertUpdate("CurrSearchCriteria", gCurrUserGuidID, " ")
        ''DB.UserParmInsertUpdate("CurrSearchThesaurus", gCurrUserGuidID, txtThesaurus.Text.Trim)
        DB.UserParmInsertUpdate("ckLimitToExisting", gCurrUserGuidID, "0")
        DB.DeleteMarkedImageCopyFiles()
        TurnHelpOn(0)
        Me.Activate()
        bInitialized = True
        'DfltData.PopulateLookupTables()

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 27")

        'DB.UserParmInsert("SoundOn", gCurrUserGuidID, "ON")
        'RMT.getHelpQuiet()
        Dim SoundOn As String = DB.UserParmRetrive("SoundOn", gCurrUserGuidID)
        If UCase(SoundOn).Equals("ON") Then
            gVoiceOn = True
        Else
            gVoiceOn = False
        End If
        If gVoiceOn = True Then
            Dim Phrase$ = "Welcome to E C M Library."
            SB.Text = Phrase
            DMA.SayWords(Phrase$)
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
        Dim Msg2$ = "Login: " + DMA.GetCurrUserName
        Msg2 = Msg2 + ", " + DMA.GetCurrMachineName
        Msg2 = Msg2 + ", " + DMA.GetCurrOsVersionName
        'DB.xTrace(99276, Msg2, "frmMdiMain:Load")

        SystemSqlTimeout$ = DB.getSystemParm("SqlServerTimeout")
        'ListControls()

        If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 29")

        If isAdmin = False Then
            'AdminToolStripMenuItem.Visible = False
        Else
            'AdminToolStripMenuItem.Visible = True
        End If

        Dim sEcmCrawlerAvailable$ = System.Configuration.ConfigurationManager.AppSettings("EcmCrawlerAvailable")
        If isAdmin Then
            If sEcmCrawlerAvailable$.Equals("Y") Then
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

        DB.ckMissingWorkingDirs()
        Dim sDebug$ = DB.getUserParm("user_showContactMenu")

        Try
            Dim strDaysToKeepTraceLogs$ = DB.getUserParm("user_DaysToKeepTraceLogs")
            If strDaysToKeepTraceLogs$.Trim.Length > 0 Then
                gDaysToKeepTraceLogs = CInt(strDaysToKeepTraceLogs$)
            End If
        Catch ex As Exception
            gDaysToKeepTraceLogs = 3
        End Try

        SetVersionAndServer()

        isAdmin = DB.isAdmin(gCurrUserGuidID)
        isGlobalSearcher = DB.isGlobalSearcher(gCurrUserGuidID)

        If isAdmin = False Then
            'AdminToolStripMenuItem.Visible = False
            SB.Text = "Logged in as a user."
        Else
            'AdminToolStripMenuItem.Visible = True
            SB.Text = "Logged in as an Admin."
        End If

        Dim bEmbededJPGMetadata As Boolean = DB.ShowGraphicMetaDataScreen

    End Sub

    Public Sub SetVersionAndServer()
        Try
            Dim S$ = " VER:" & My.Application.Info.Version.Major & "." & My.Application.Info.Version.Minor & "." & My.Application.Info.Version.Build & "." & My.Application.Info.Version.Revision & " "
            tssVersion.Text = S
            Dim SvrName = DB.getNameOfCurrentServer()
            Dim CurrCS As String = DB.getConnStr
            tssServer.Text = SvrName + ":" + getServer(CurrCS)
            If InStr(tssServer.Text, "unknown", CompareMethod.Text) > 0 Then
                tssServer.Text = getServer(System.Configuration.ConfigurationManager.AppSettings("ECMREPO"))
                log.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN.")
            End If
        Catch ex As Exception
            Console.WriteLine(ex.Message)
            log.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN." + ex.Message)
        End Try

    End Sub

    Function getServer(ByVal ConnectionString$) As String
        Try
            Dim S$ = DB.setConnStr
            Dim I As Integer = 1
            I = InStr(I, S$, "Data Source=", CompareMethod.Text)
            I = InStr(I + 1, S$, "=", CompareMethod.Text)
            Dim J As Integer = InStr(I + 1, S$, ";", CompareMethod.Text)
            If I > 0 Then
                Return " " + Mid(S$, I + 1, J - I - 1)
            End If
            Return "Unknown"
        Catch ex As Exception
            Return " UKN"
        End Try
    End Function


    Private Sub ParameterExecutionToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ParameterExecutionToolStripMenuItem.Click
        Dim MSG$ = ""
        MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + vbCrLf + vbCrLf
        MSG = MSG + "X = Execute archive and close." + vbCrLf + vbCrLf
        MSG = MSG + "C = Archive CONTENT only." + vbCrLf + vbCrLf
        MSG = MSG + "O = Archive OUTLOOK only." + vbCrLf + vbCrLf
        MSG = MSG + "E = Archive EXCHANGE Servers only." + vbCrLf + vbCrLf
        MSG = MSG + "A = Archive ALL." + vbCrLf + vbCrLf
        MSG = MSG + "To Execute:" + vbCrLf
        MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + vbCrLf
        MSG = MSG + "(E.G.) C:\dev\ECM\EcmLibSvc\EcmLibSvc\bin\Debug\EcmArchiveSetup.exe Q" + vbCrLf
        messagebox.show(MSG)
    End Sub

    Private Sub HistoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HistoryToolStripMenuItem.Click
        frmHistory.Show()
    End Sub

    Private Sub ckExpand_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckExpand.CheckedChanged

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
        saveStartUpParms()
        SB.Text = "Content Disabled set to " + ckDisableContentArchive.Checked.ToString
    End Sub

    Private Sub ckDisableOutlookEmailArchive_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisableOutlookEmailArchive.CheckedChanged
        saveStartUpParms()
        SB.Text = "EMAIL Disabled set to " + ckDisableOutlookEmailArchive.Checked.ToString
    End Sub

    Private Sub ckDisableExchange_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisableExchange.CheckedChanged
        saveStartUpParms()
        If ckDisableExchange.Checked Then
            SB.Text = "Exchange Disabled"
        Else
            SB.Text = "Exchange Enabled"
        End If

    End Sub
    'Public Sub SetVersionAndServer()
    '    Try
    '        Dim S$ = " APP:" & My.Application.Info.Version.Major & "." & My.Application.Info.Version.Minor & "." & My.Application.Info.Version.Build & "." & My.Application.Info.Version.Revision & " "
    '        tssVersion.Text = S
    '        Dim SvrName = DB.getNameOfCurrentServer()
    '        tssServer.Text = SvrName + ":" + getServer(My.Settings.UserDefaultConnString)
    '        If InStr(tssServer.Text, "unknown", CompareMethod.Text) > 0 Then
    '            tssServer.Text = getServer(System.Configuration.ConfigurationManager.AppSettings("ECMREPO"))
    '            log.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN.")
    '        End If
    '    Catch ex As Exception
    '        Console.WriteLine(ex.Message)
    '        log.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN." + ex.Message)
    '    End Try

    'End Sub

    Private Sub ViewLogsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewLogsToolStripMenuItem.Click
        Dim TempFolder$ = LOG.getEnvVarSpecialFolderApplicationData()

        Shell("explorer.exe " + Chr(34) + TempFolder$ + Chr(34), vbNormalFocus)

        If gRunUnattended = True Then
            gUnattendedErrors += 1
            SB.Text = ""
        End If
    End Sub

    Private Sub DirectoryInventoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DirectoryInventoryToolStripMenuItem.Click

        Dim DirToInventory As String = "C:\dev"
        Dim ListOfFiles As String = ""
        Dim ckArchiveBit As Boolean = True
        Dim IncludeSubDirs As Boolean = True
        Dim FileExt As New List(Of String)
        FileExt.Add(".DOC")
        FileExt.Add(".XLS")
        FileExt.Add(".VB")

        Console.WriteLine("Start: " + Now.ToString)
        ListOfFiles = UTIL.getFileToArchive(DirToInventory, FileExt, ckArchiveBit, IncludeSubDirs)
        'Shell("Notepad.exe " + Chr(34) + ListOfFiles + Chr(34), vbNormalFocus)
        Console.WriteLine("End: " + Now.ToString)
        GC.Collect()
        GC.WaitForFullGCApproach()
    End Sub

    Private Sub ListFilesInDirectoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ListFilesInDirectoryToolStripMenuItem.Click
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
        UTIL.GetFilesToArchive(iInventory, ArchiveAttr, False, DirToInventory, FilterList, FilesToArchive)
        'For Each S As String In FilesToArchive
        '    Console.WriteLine(S)
        'Next
        Console.WriteLine("End: " + Now.ToString)
        GC.Collect()
        GC.WaitForFullGCApproach()

    End Sub

    Private Sub GetAllSubdirFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GetAllSubdirFilesToolStripMenuItem.Click

        Dim FilesToArchive As New List(Of String)
        Dim MSG As String = ""
        Dim strFileSize As String = ""
        Dim FilterList As New List(Of String)
        Dim ArchiveAttr As Boolean = False

        FilterList.Add("*.doc")
        FilterList.Add("*.xls")
        FilterList.Add("*.vb")

        Console.WriteLine("Start: " + Now.ToString)
        Dim DirToInventory As String = "C:\dev"
        Dim iInventory As Integer = 0
        UTIL.GetFilesToArchive(iInventory, ArchiveAttr, True, DirToInventory, FilterList, FilesToArchive)
        'For Each S As String In FilesToArchive
        '    Console.WriteLine(S)
        'Next
        Console.WriteLine("End: " + Now.ToString)
        GC.Collect()
        GC.WaitForFullGCApproach()
    End Sub

    Private Sub ViewOCRErrorFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewOCRErrorFilesToolStripMenuItem.Click

        Try
            Dim DirFQN As String = UTIL.getTempPdfWorkingErrorDir()
            Shell("explorer.exe " + Chr(34) + DirFQN + Chr(34), vbNormalFocus)
        Catch ex As Exception
            SB.Text = ex.Message
        End Try


    End Sub

    Private Sub ScheduleToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ScheduleToolStripMenuItem.Click
        frmSchedule.ShowDialog()
    End Sub

    Private Sub RunningArchiverToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RunningArchiverToolStripMenuItem.Click

    End Sub

    Private Sub AboutToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AboutToolStripMenuItem.Click
        AboutBox1.ShowDialog()
    End Sub

    Private Sub ManualEditAppConfigToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ManualEditAppConfigToolStripMenuItem.Click
        Dim aPath As String = System.AppDomain.CurrentDomain.BaseDirectory()
        Dim AppName As String = aPath$ + "EcmArchiveSetup.exe.config"
        System.Diagnostics.Process.Start("notepad.exe", AppName)
    End Sub

    Private Sub NumericUpDown1_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles NumericUpDown1.ValueChanged
        If Not formloaded Then
            Return
        End If
        If NumericUpDown1.Value = 0 Then
            My.Settings("BackupIntervalHours") = 0
            SB2.Text = "Quick archive disabled."
            'TimerQuickArchive.Enabled = False
        Else
            If NumericUpDown1.Value < 4 Then
                NumericUpDown1.Value = 4
            End If
            If NumericUpDown1.Value > 96 Then
                NumericUpDown1.Value = 96
            End If
            My.Settings("BackupIntervalHours") = CInt(NumericUpDown1.Value)
            My.Settings("LastArchiveEndTime") = Now
            My.Settings.Save()
            SB2.Text = NumericUpDown1.Value.ToString + " hours from now, an archive will execute and every " + NumericUpDown1.Value.ToString + " thereafter."
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

        tsLastArchive.Text = My.Settings("LastArchiveEndTime").ToString

        Dim IntervalHours As Integer = 0
        Dim iElapsedHours As Decimal = 0
        Try
            IntervalHours = My.Settings("BackupIntervalHours")
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
        TimerQuickArchive_Tick(Nothing, Nothing)
    End Sub
    ''' <summary>
    ''' This will create a Application Reference file on the users desktop
    ''' if they do not already have one when the program is loaded.
    '    If not debugging in visual studio check for Application Reference
    '    #if (!debug)
    '        CheckForShortcut();
    '    #endif
    ''' </summary
    Private Sub CheckForShortcut()
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
        frmImpersonate.ShowDialog()
    End Sub

    Private Sub AddDesktopIconToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AddDesktopIconToolStripMenuItem.Click
        CheckForShortcut()
    End Sub

    Private Sub btnRefreshRebuild_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshRebuild.Click

        Me.Cursor = Cursors.WaitCursor
        Dim S As String = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "
        DB.LoadProfiles()

        S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "
        DB.PopulateComboBox(cbProfile, "ProfileName", S)

        S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]"
        'S = "select distinct ProfileName from LoadProfileItem order by ProfileName"
        DB.PopulateComboBox(Me.cbDirProfile, "ProfileName", S)
        Me.Cursor = Cursors.Default
    End Sub

    Private Sub AllToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AllToolStripMenuItem.Click
        gbEmail.Visible = True
        gbContentMgt.Visible = True
        gbPolling.Visible = True
        gbFiletypes.Visible = True
    End Sub

    Private Sub EmailToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmailToolStripMenuItem.Click
        gbEmail.Visible = True
        gbContentMgt.Visible = False
        gbPolling.Visible = False
        gbFiletypes.Visible = False
    End Sub

    Private Sub ContentToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ContentToolStripMenuItem1.Click
        gbEmail.Visible = False
        gbContentMgt.Visible = True
        gbPolling.Visible = False
        gbFiletypes.Visible = False
    End Sub

    Private Sub ExecutionControlToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExecutionControlToolStripMenuItem.Click
        gbEmail.Visible = False
        gbContentMgt.Visible = False
        gbPolling.Visible = True
        gbFiletypes.Visible = False
    End Sub

    Private Sub FileTypesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileTypesToolStripMenuItem.Click
        gbEmail.Visible = False
        gbContentMgt.Visible = False
        gbPolling.Visible = False
        gbFiletypes.Visible = True
    End Sub

    Private Sub EncryptStringToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EncryptStringToolStripMenuItem.Click
        frmEncryptString.ShowDialog()
    End Sub

    Private Sub btnRefreshDefaults_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefreshDefaults.Click
        Dim S As String = ""
        Dim B As Boolean = True

        S = "insert into AvailFileTypes (ExtCode) Values ('.act')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ada')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.adb')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ads')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ascx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.asm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.asp')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.aspx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.bat')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.bmp')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.c')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.cmd')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.cpp')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.csv')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.cxx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dct')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.def')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dic')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dll')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.doc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.docm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.docx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dot')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dotm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.dotx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.exe')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.frm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.GIF')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.gz')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.h')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.hhc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.hpp')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.htm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.html')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.htw')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.htx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.hxx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ibq')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.idl')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.inc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.inf')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ini')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.inx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.java')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.JPG')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.JPX')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.js')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.log')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.m3u')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.mht')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.mp3')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.msg')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.obd')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.obj')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.obt')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.odc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pdf')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pfx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pl')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.PNG')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pot')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.potm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.potx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppam')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppsm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppsx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.ppt')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pptm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.pptx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.rc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.reg')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.resx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.rtf')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.sln')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.sql')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.stm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.suo')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.tar')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.tif')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.TIFF')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.TRF')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.txt')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.UKN')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.url')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.vb')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.vbs')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.vbx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.VSD')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.wav')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.wma')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.wtx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.XL * ')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlam')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlb')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xls')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlsm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlsx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xlt')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xltm')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xltx')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xml')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xsc')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xsd')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xslt')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.xss')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.z')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('.zip')"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "insert into AvailFileTypes (ExtCode) Values ('msg')"
        B = DB.ExecuteSqlNewConn(S, False)

        MessageBox.Show("Missing default extension codes readded.")

    End Sub

    Private Sub btnDefaultAsso_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDefaultAsso.Click
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

        Me.Cursor = Cursors.WaitCursor
        AddSourceTypeDefaults()

        Dim S As String = ""
        Dim B As Boolean = False

        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'Known graphic file types.', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'All MS Office content.', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - C#', N'Source Code - C#', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'Source Code - VB', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ZIP Files', N'Currently Processed ZIP types', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)

        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ZIP','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.RAR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.GZ','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ISO','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.TAR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ARJ','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CAB','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CHM','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CPIO','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CramFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.DEB','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.DMG','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.FAT','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.HFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.LZH','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.LZMA','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.MBR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.MSI','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.NSIS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.NTFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.RPM','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.SquashFS','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.UDF','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.VHD','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.WIM','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.XAR','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.Z','UKN',0,'ECMLIB', getdate(), getdate())"
        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.one', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pdf', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.txt', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.csv', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xls', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pdf', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.html', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.htm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.docx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.doc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.Tiff', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.tif', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.gif', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.docm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.dotx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.dotm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xltx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xltm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsb', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlam', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pptx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pptm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.potx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.potm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppam', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppsx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppsm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.bmp', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.png', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.vb', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xsd', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xss', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xsc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.ico', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.rpt', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.rdlc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.resx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.sql', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xml', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.sln', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.vbx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.jpg', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)

        S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "
        DB.PopulateComboBox(cbProfile, "ProfileName", S)

        Me.Cursor = Cursors.Default

        MessageBox.Show("Default profiles ready.")

    End Sub

    Sub AddSourceTypeDefaults()

        Dim S As String = Nothing
        Dim B As Boolean = False

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ZIP', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'RAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'GZ', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ISO', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'TAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ARJ', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CAB', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CHM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CPIO', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CramFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'DEB', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'DMG', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'FAT', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'HFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'LZH', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'LZMA', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'MBR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'MSI', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NSIS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NTFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'RPM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'SquashFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'UDF', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'VHD', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'WIM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'XAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Z', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())"

        B = DB.ExecuteSqlNewConn(S, False)

        DB.AddSourceTypeCode(".ZIP", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".RAR", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".GZ", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".ISO", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".TAR", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".ARJ", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".CAB", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".CHM", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".CPIO", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".CramFS", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".DEB", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".DMG", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".FAT", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".HFS", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".LZH", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".LZMA", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".MBR", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".MSI", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".NSIS", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".NTFS", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".RPM", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".SquashFS", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".UDF", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".VHD", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".WIM", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".XAR", 0, "Add by ECM: Compressed File.", 0)
        DB.AddSourceTypeCode(".Z", 0, "Add by ECM: Compressed File.", 0)

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N',dct', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.act', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ada', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.adb', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ads', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.application', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asax', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ascx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ashx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asmmeta', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.aspx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.BAK', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.baml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bas', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bat', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bmp', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.c', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Cache', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.chm', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cls', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cmd', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.compiled', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.config', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cpp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.crt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cs', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.CSproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.css', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.csv', 0, N'Added by user', 1, NULL, NULL, NULL, NULL, NULL)"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cxx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dat', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.data', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.database', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.datasource', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.db', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dct', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.def', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.deploy', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dic', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dll', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.DM1', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dnn', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.doc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.docm', 0, N'Word 2007 XML Macro-Enabled Document', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.docx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dot', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dotm', 0, N'Word 2007 XML Macro-Enabled Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dotx', 0, N'Word 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtsConfig', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.emz', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe_SyncToyBackup_20090311100439812', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe_SyncToyBackup_20090406194350947', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.frm', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.gif', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.grxml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.gz', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.h', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hhc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hlp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hpp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.html', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htw', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hxx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ibq', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ico', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.idl', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ini', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.jar', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.java', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.jpg', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.js', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.kmz', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ldb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ldf', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.lng', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.lnk', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.log', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.m3u', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.manifest', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.master', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mdb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mdf', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.MDI', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mht', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mp3', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mrc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.msg', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.msi', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.myapp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obd', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obj', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.odc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.one', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.opml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.org', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.p7b', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pcap', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pdb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pdf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pfx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.php', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pl', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.png', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pot', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.potm', 0, N'PowerPoint 2007 Macro-Enabled XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.potx', 0, N'PowerPoint 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppam', 0, N'PowerPoint 2007 Macro-Enabled XML Add-In', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppsm', 0, N'PowerPoint 2007 Macro-Enabled XML Show', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppsx', 0, N'PowerPoint 2007 XML Show', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pptm', 0, N'PowerPoint 2007 Macro-Enabled XML Presentation', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pptx', 0, N'PowerPoint 2007 XML Presentation', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.psd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pub', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rar', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rdl', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rdlc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rds', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.reg', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.resources', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.resx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rpt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rptproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rtf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.scc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.settings', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.shs', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sitemap', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.skin', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sln', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sql', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.SqlDataProvider', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sqlsuo', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, NULL, NULL, NULL, NULL)"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sqm', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.stm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.subproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.suo', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tar', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.template', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Text', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.thmx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tif', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Tiff', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tmp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.TRF', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.txt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.UD', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.url', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.user', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vb', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbs', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbx', 0, N'AUTO Defined by System', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vsd', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vspscc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vstemplate', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.WAV', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.webproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wma', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wmv', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wri', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wtx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xaml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlam', 0, N'Excel 2007 XML Macro-Enabled Add-In', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlb', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlk', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xls', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsb', 0, N'Excel 2007 binary workbook (BIFF12)', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsm', 0, N'Excel 2007 XML Macro-Enabled Workbook', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xltm', 0, N'Excel 2007 XML Macro-Enabled Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xltx', 0, N'Excel 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xml', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsl', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xslt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xss', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.z', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.zip', 0, N'Word Splitter', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Added by user', 0, N'.dct', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'docm', 0, N'Word 2007 XML Macro-Enabled Document', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'docx', 0, N'Word 2007 XML Document', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'dotm', 0, N'Word 2007 XML Macro-Enabled Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'dotx', 0, N'Word 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NO SEARCH - AUTO ADDED by Pgm', 0, N'.application', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'potm', 0, N'PowerPoint 2007 Macro-Enabled XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'potx', 0, N'PowerPoint 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppam', 0, N'PowerPoint 2007 Macro-Enabled XML Add-In', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppsm', 0, N'PowerPoint 2007 Macro-Enabled XML Show', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppsx', 0, N'PowerPoint 2007 XML Show', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'pptm', 0, N'PowerPoint 2007 Macro-Enabled XML Presentation', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'pptx', 0, N'PowerPoint 2007 XML Presentation', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlam', 0, N'Excel 2007 XML Macro-Enabled Add-In', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsb', 0, N'Excel 2007 binary workbook (BIFF12)', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsm', 0, N'Excel 2007 XML Macro-Enabled Workbook', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsx', 0, N'Excel 2007 XML Workbook', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xltm', 0, N'Excel 2007 XML Macro-Enabled Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xltx', 0, N'Excel 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'XXXX', 0, N'AUTO Definition - not found', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        B = DB.ExecuteSqlNewConn(S, False)

    End Sub

    Private Sub FileHashToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileHashToolStripMenuItem.Click
        OpenFileDialog1.ShowDialog()

        Dim Ticks As Int64 = 0
        Dim TotalTicks As Integer = 0

        Ticks = Now.Ticks
        Dim FQN As String = OpenFileDialog1.FileName
        Dim CRC32HASH As String = ""
        Dim MD5HASH As String = ""
        Dim SHA1HASH As String = ""
        Dim SHA1QUICK As String = ""

        Ticks = Now.Ticks
        CRC32HASH = ENC.hashCrc32(FQN)
        TotalTicks = Now.Ticks - Ticks
        CRC32HASH += " - Time: " + TotalTicks.ToString

        Ticks = Now.Ticks
        MD5HASH = ENC.hashMd5(FQN)
        TotalTicks = Now.Ticks - Ticks
        MD5HASH += " - Time: " + TotalTicks.ToString

        Ticks = Now.Ticks
        SHA1HASH = ENC.hashSha1(FQN)
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

        If LocalDBBackUpComplete Then
            Return
        End If

        Dim DBL As New clsDbLocal

        DBL.BackupDirTbl()
        DBL.BackupFileTbl()
        DBL.BackupInventoryTbl()
        DBL.BackupExchangeTbl()
        DBL.BackupOutlookTbl()

        DBL = Nothing
        DBLocal = Nothing

        LocalDBBackUpComplete = True

    End Sub 'Finalize


    Private Sub BackgroundWorker1_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorker1.DoWork

        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        If ckTerminate.Checked Then
            If Not gRunUnattended Then
                MessageBox.Show("The TERMINATE immediately box is checked, returning.")
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
            Return
        End If

        DB.CleanUpEmailFolders()
        'PictureBox1.Visible = True
        'ckTerminate.Checked = False

        gEmailsBackedUp = 0
        gEmailsAdded = 0
        'Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        'SB.Text = "Starting Email archive."
        frmHelp.MsgToDisplay$ = "This can be a long running process. It can be minimized and you can continue working."
        frmHelp.CallingScreenName$ = "ECM Archive"
        frmHelp.CaptionName$ = "Execution Beginning"
        frmHelp.Show()

        'Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        'ArchiveALLToolStripMenuItem.Enabled = False
        'ContentToolStripMenuItem.Enabled = False
        'ExchangeEmailsToolStripMenuItem.Enabled = False
        'OutlookEmailsToolStripMenuItem.Enabled = False
        'ArchiveALLToolStripMenuItem.Enabled = True
        'ContentToolStripMenuItem.Enabled = True
        'ExchangeEmailsToolStripMenuItem.Enabled = True
        'OutlookEmailsToolStripMenuItem.Enabled = True

        EmailsBackedUp = 0
        EmailsSkipped = 0
        FilesBackedUp = 0
        FilesSkipped = 0

        '***************************************************  
        SetUnattendedFlag()
        'SB.Text = "Quiet"
        'SB2.Text = "Quiet"

        'If UseThreads = False Then
        '*******************************************************************
        Dim bUseQuickSearch As Boolean = False
        Dim NbrOfIds As Integer = DB.getCountStoreIdByFolder()
        Dim slStoreId As New SortedList

        If NbrOfIds <= 2000000 Then
            bUseQuickSearch = True
        End If

        If bUseQuickSearch Then
            '** 002
            DB.LoadEntryIdByUserID(slStoreId, NbrOfIds)
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

            Return
        End If
        resetBadDates()
        '***************************************************

        ALR.ProcessAllRefEmails(False)
        'Me.Cursor = System.Windows.Forms.Cursors.Default
        DB.UpdateAttachmentCounts()
        'Me.Cursor = System.Windows.Forms.Cursors.Default
        'SB.Text = "Completed Email archive."
        If gEmailsAdded = 0 Then
            gEmailsAdded = 1
        End If
        'Dim Msg$ = "Emails Processed: " + gEmailsBackedUp.ToString + "  /  Updated: " + EmailsSkipped.ToString + " / Added: " + (gEmailsAdded - 1).ToString
        'SB2.Text = Msg

        'ArchiveALLToolStripMenuItem.Enabled = False
        'ContentToolStripMenuItem.Enabled = False
        'ExchangeEmailsToolStripMenuItem.Enabled = False
        'OutlookEmailsToolStripMenuItem.Enabled = False
        'ArchiveALLToolStripMenuItem.Enabled = True
        'ContentToolStripMenuItem.Enabled = True
        'ExchangeEmailsToolStripMenuItem.Enabled = True
        'OutlookEmailsToolStripMenuItem.Enabled = True

        If gTerminateImmediately Then
            'Me.Cursor = Cursors.Default
            'SB.Text = "Terminated archive!"
            'PictureBox1.Visible = False

            'SB.Text = "AUTO Archive exit"
            'SB2.Text = "AUTO Archive exit"

            Return
        End If

        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        For i As Integer = 0 To ZipFilesEmail.Count - 1
            'bExplodeZipFile = False
            Dim cData$ = ZipFilesEmail(i).ToString
            Dim ParentGuid$ = ""
            Dim FQN$ = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid$ = Mid(cData, K + 1)
            'DB.UpdateZipFileIndicator(ParentGuid, True)            
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN$, ParentGuid$, ckArchiveBit.Checked, True, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next

        ListOfFiles = Nothing
        GC.Collect()

    End Sub

    Private Sub BackgroundWorker2_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorker2.DoWork

        Dim isPublic As String = "N"
        Dim RetentionCode As String = "Retain 10"

        If ckTerminate.Checked Then
            MessageBox.Show("The TERMINATE immediately box is checked, returning.")
            Return
        End If

        EmailsBackedUp = 0
        EmailsSkipped = 0
        FilesBackedUp = 0
        FilesSkipped = 0

        'SB.Text = "Launching Exchange Archive - it will run in background."
        If gCurrentArchiveGuid.Length = 0 Then
            gCurrentArchiveGuid$ = Guid.NewGuid.ToString
        End If

        '****************************************************************************
        SetUnattendedFlag()
        'frmExchangeMonitor.Show()

        GetExchangeFolders(False)
        '****************************************************************************

        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        For i As Integer = 0 To ZipFilesExchange.Count - 1
            Dim cData$ = ZipFilesExchange(i).ToString
            Dim ParentGuid$ = ""
            Dim FQN$ = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid$ = Mid(cData, K + 1)
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN$, ParentGuid$, ckArchiveBit.Checked, True, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next
        For i As Integer = 0 To ZipFilesEmail.Count - 1
            Dim cData$ = ZipFilesExchange(i).ToString
            Dim ParentGuid$ = ""
            Dim FQN$ = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid$ = Mid(cData, K + 1)
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN$, ParentGuid$, ckArchiveBit.Checked, True, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next

        ListOfFiles = Nothing
        GC.Collect()

    End Sub

    Private Sub BackgroundWorker3_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorker3.DoWork

        Dim isPublic As String = "N"

        If ckTerminate.Checked Then
            MessageBox.Show("The TERMINATE immediately box is checked, returning.")
            Return
        End If

        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
        End If

        'Timer1.Enabled = False

        'PictureBox1.Visible = True

        ckTerminate.Checked = False

        EmailsBackedUp = 0
        EmailsSkipped = 0
        FilesBackedUp = 0
        FilesSkipped = 0

        'SB.Text = "Starting Content archive."

        LOG.WriteToArchiveLog("Content Archive stared @ " + Now.ToString)

        'Me.Cursor = System.Windows.Forms.Cursors.Default
        MsgNotification = False
        frmHelp.MsgToDisplay$ = "This can be a long running process. It can be minimized and you can continue working?"
        frmHelp.CallingScreenName$ = "ECM Archive"
        frmHelp.CaptionName$ = "Execution Beginning"
        frmHelp.StartPosition = FormStartPosition.CenterScreen
        frmHelp.Timer1.Interval = 5000
        frmHelp.Show()

        'ArchiveALLToolStripMenuItem.Enabled = False
        'ContentToolStripMenuItem.Enabled = False
        'ExchangeEmailsToolStripMenuItem.Enabled = False
        'OutlookEmailsToolStripMenuItem.Enabled = False
        'ArchiveALLToolStripMenuItem.Enabled = True
        'ContentToolStripMenuItem.Enabled = True
        'ExchangeEmailsToolStripMenuItem.Enabled = True
        'OutlookEmailsToolStripMenuItem.Enabled = True

        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : btnArchiveContent :7000 : starting archive.")

        If gCurrentArchiveGuid.Length = 0 Then
            gCurrentArchiveGuid$ = Guid.NewGuid.ToString
        End If

        'Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        'FrmMDIMain.SB.Text = "Archiving Content"

        '*** Here is the primary Module for archive.
        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : btnArchiveContent :7001 : starting archive.")

        If ddebug Then LOG.WriteToArchiveLog("Starting Archive of Content ********************************")

        '***************** ARCHIVE CONTENT **********************'

        SetUnattendedFlag()
        'FrmMDIMain.lblArchiveStatus.Text = "Archive Running"

        '********************
        ArchiveContent(UIDcurr)
        '********************

        'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"

        '********************************************************'
        If ddebug Then LOG.WriteToArchiveLog("frmReconMain : btnArchiveContent :7002 : starting archive.")

        ARCH.ArchiveQuickRefItems(UIDcurr, MachineIDcurr, ckArchiveBit.Checked, False, False, False, False, SB, "", "", "", ZipFilesQuick)

        Dim RetentionCode As String = "Retain 10"


        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        For i As Integer = 0 To ZipFilesQuick.Count - 1
            'FrmMDIMain.SB.Text = "Processing Quickref"
            'If i >= 24 Then
            '    Debug.Print("here")
            'End If
            Dim cData$ = ZipFilesQuick(i).ToString
            Dim ParentGuid$ = ""
            Dim FQN$ = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid$ = Mid(cData, K + 1)
            'DB.UpdateZipFileIndicator(ParentGuid, True)            
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN$, ParentGuid$, ckArchiveBit.Checked, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next

        ListOfFiles = Nothing
        GC.Collect()
        'Me.Cursor = Cursors.Default
        ALR.ProcessAllRefDirs(False)

        'FrmMDIMain.SB.Text = "Ready"
        'SB.Text = "Archive Complete..."
        'FrmMDIMain.SB.Text = "Archive Complete..."
        'Me.Cursor = System.Windows.Forms.Cursors.Default
        'If ddebug Then LOG.WriteToArchiveLog("Ending Archive of Content ********************************")
        'SB.Text = "Completed Content archive."
        'Public EmailsBackedUp As Integer = 0
        'Public EmailsSkipped As Integer = 0
        'Public FilesBackedUp As Integer = 0
        'Public FilesSkipped As Integer = 0
        Dim Msg$ = "Files Backed Up: " + FilesBackedUp.ToString + "  /  Files Updated: " + FilesSkipped.ToString

        LOG.WriteToArchiveLog("Content Archive completed @ " + Now.ToString + " : " + Msg)

        'SB2.Text = Msg
        'FrmMDIMain.SB4.Text = ""

        'ArchiveALLToolStripMenuItem.Enabled = False
        'ContentToolStripMenuItem.Enabled = False
        'ExchangeEmailsToolStripMenuItem.Enabled = False
        'OutlookEmailsToolStripMenuItem.Enabled = False
        'ArchiveALLToolStripMenuItem.Enabled = True
        'ContentToolStripMenuItem.Enabled = True
        'ExchangeEmailsToolStripMenuItem.Enabled = True
        'OutlookEmailsToolStripMenuItem.Enabled = True

        'Application.DoEvents()

        'ArchiveALLToolStripMenuItem.Enabled = True
        'ContentToolStripMenuItem.Enabled = True
        'ExchangeEmailsToolStripMenuItem.Enabled = True
        'OutlookEmailsToolStripMenuItem.Enabled = True
        'Application.DoEvents()
        'Me.Cursor = Cursors.Default
        'PictureBox1.Visible = False

        'SB.Text = "Archiver idle"
        'SB2.Text = "Standing by for next archive"

        'Timer1.Enabled = True
    End Sub

    Private Sub FileUploadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileUploadToolStripMenuItem.Click

        Dim RetentionCode As String = "Retain 10"
        Dim isPublic As String = "N"

        OpenFileDialog1.ShowDialog()
        Dim FQN As String = OpenFileDialog1.FileName
        Dim FI As New FileInfo(FQN)
        Dim OriginalFileName As String = FI.Name
        FI = Nothing
        Dim FileGuid As String = Guid.NewGuid.ToString
        Dim RepositoryTable As String = "DataSource"
        DB.UploadFileImage(OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic)
    End Sub

    Private Sub FileUploadBufferedToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileUploadBufferedToolStripMenuItem.Click

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

        DB.UploadBuffered(4, FileBuffer, OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic)

    End Sub

    Private Sub FileChunkUploadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FileChunkUploadToolStripMenuItem.Click
        OpenFileDialog1.ShowDialog()
        Dim FQN As String = OpenFileDialog1.FileName
        Dim FI As New FileInfo(FQN)
        Dim OriginalFileName As String = FI.Name
        FI = Nothing
        Dim FileGuid As String = Guid.NewGuid.ToString
        DB.ChunkFileUpload(OriginalFileName, FileGuid, FQN, "DataSource")
    End Sub

    Private Sub BackgroundDirListener_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundDirListener.DoWork

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
        Catch ex As Exception
            Console.WriteLine("Collection processed.")
        End Try

        frm = Nothing
        If bDoNotRun = True Then
            Return
        End If


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
            Return
        Else
            ProcessListenerFiles(False)
        End If
        L = Nothing

        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)
        For i As Integer = 0 To ZipFilesListener.Count - 1
            Dim cData$ = ZipFilesListener(i).ToString
            Dim ParentGuid$ = ""
            Dim FQN$ = ""
            Dim K As Integer = InStr(cData, "|")
            FQN = Mid(cData, 1, K - 1)
            ParentGuid$ = Mid(cData, K + 1)
            ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN$, ParentGuid$, ckArchiveBit.Checked, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
        Next

        ListOfFiles = Nothing
        GC.Collect()
    End Sub

    Sub populateCompanyCombo()


        Try
            txtCompany.Text = REG.ReadEcmRegistrySubKey("CompanyID")
        Catch ex As Exception
            Dim CompanyID As String = InputBox("ERROR - CompanyID is not defined to the system, please enter your Company ID.", "Company ID")
            If CompanyID.Length > 0 Then
                Dim bReg As Boolean = False
                bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID)
                If Not bReg Then
                    bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID)
                End If
                txtCompany.Text = CompanyID
            Else
                txtCompany.Text = ""
                Return
            End If

        End Try

        'Dim RC As Boolean = False
        'Dim RetMsg As String = ""
        'Dim Proxy As New SVCGateway.Service1Client

        'Dim SecureLoginCS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        'Dim DecryptedSecureLoginCS As String = ENC.AES256DecryptString(SecureLoginCS)

        'Try
        '    cbCompany.Items.Clear()
        '    'Dim S As String = "Select distinct CompanyID from [Gateway_Attach] order by CompanyID"
        '    Dim Items As String = ""
        '    Dim BlankCS As String = ""
        '    Try
        '        Dim S As String = Proxy.PopulateCombo(BlankCS, CompanyID, RC, RetMsg)
        '        If InStr(S, "|") > 0 Then
        '            Dim A() As String = S.Split("|")
        '            For i As Integer = 0 To A.Count - 1
        '                Dim sItem As String = A(i)
        '                If sItem.Trim.Length > 0 Then
        '                    cbCompany.Items.Add(sItem)
        '                End If
        '            Next
        '        End If
        '    Catch ex As Exception
        '        MessageBox.Show("Error populating the Company Combo: " + ex.Message.ToString)
        '    End Try

        '    If Not RC Then
        '        LOG.WriteToArchiveLog("ERROR: Failed to populate Company Combo - " + RetMsg)
        '    Else
        '        Dim A() As String = Items.Split("|")
        '        For I As Integer = 0 To A.Count - 1
        '            If A(I) IsNot Nothing And A(I).Trim.Length > 0 Then
        '                cbCompany.Items.Add(A(I))
        '            End If
        '        Next
        '    End If
        'Catch ex As Exception
        '    LOG.WriteToArchiveLog("ERROR loading Company Combobox:" + ex.Message)
        'Finally


        'End Try
        If txtCompany.Text.Length > 0 Then
            populateRepoCombo()
        End If

    End Sub
    Sub populateRepoCombo()

        Dim TempCS As String = ""
        cbRepo.Items.Clear()
        Dim CID As String = txtCompany.Text.Trim
        CID = CID.Replace("'", "''")
        Dim S As String = "Select RepoID from [Gateway_Attach] where CompanyID = '" + CID + "' order by RepoID"
        Dim Items As String = ""
        Dim RC As Boolean = False
        Dim RetMsg As String = ""
        Dim ProxyGateway As New SVCGateway.Service1Client
        Try
            Items = ProxyGateway.PopulateRepoCombo(TempCS, CID, RC, RetMsg)
            If Items.Length = 0 Then
                LOG.WriteToArchiveLog("ERROR: 100 Failed to populate company ID  combobox - " + RetMsg)
            Else
                Dim A() As String = Items.Split("|")
                For I As Integer = 0 To A.Count - 1
                    cbRepo.Items.Add(A(I))
                Next
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: 100 Failed to populate company ID  combobox - " + ex.Message)
        Finally
            ProxyGateway = Nothing
            GC.Collect()
        End Try

    End Sub

    Private Sub btnActivate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnActivate.Click

        CompanyID = txtCompany.Text
        RepoID = cbRepo.Text
        Dim bReg As Boolean = False

        If CompanyID.Length > 0 And RepoID.Length > 0 Then
            Dim ProxyAttach As New SVCGateway.Service1Client
            Dim EncCS As String = ""
            Dim RC As Boolean = False
            Dim RetMsg As String = ""
            EncCS = ProxyAttach.getConnection(CompanyID, RepoID, RC, RetMsg)
            If EncCS.Trim.Length > 0 Then
                'gCurrentConnectionString = ENC.AES256DecryptString(EncCS)
                gCurrentConnectionString = EncCS
                If gCurrentConnectionString.Length > 0 Then
                    bReg = REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS)
                    If Not bReg Then
                        bReg = REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS)
                    End If
                End If
                Try
                    gCurrentConnectionString = ENC.AES256DecryptString(EncCS)
                Catch ex As Exception
                    MessageBox.Show("ERROR 121.32.1 : Failed to set new connection.")
                    Return
                End Try
            Else
                gCurrentConnectionString = ""
            End If

            ProxyAttach = Nothing
            bUseAttachData = True
            tsCurrentRepoID.Text = RepoID
            tsCurrentRepoID.Text = "Repo: " + RepoID

            If CompanyID.Length > 0 Then
                bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID)
                If Not bReg Then
                    bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID)
                End If

            End If
            If RepoID.Length > 0 Then
                bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID)
                If Not bReg Then
                    bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID)
                End If
            End If

        Else
            tsCurrentRepoID.Text = "Repo: ??"
            bUseAttachData = False
        End If
    End Sub

    Private Sub GetQueryStringParameters() 'As NameValueCollection
        LOG.WriteToParmLog("Step 01")
        Dim NameValueTable As New NameValueCollection()
        LOG.WriteToParmLog("Step 02")
        Try
            LOG.WriteToParmLog("Step 03")
            If (ApplicationDeployment.IsNetworkDeployed) Then
                LOG.WriteToParmLog("Step 04")
                Dim QueryString As String = ApplicationDeployment.CurrentDeployment.ActivationUri.Query
                LOG.WriteToParmLog("Step 05")
                LOG.WriteToParmLog("QueryString: " + QueryString)
                LOG.WriteToParmLog("Step 06")
                NameValueTable = System.Web.HttpUtility.ParseQueryString(QueryString)
                LOG.WriteToParmLog("Step 07")
            End If

            LOG.WriteToParmLog("Step 08")

            For Each Arg As String In NameValueTable
                LOG.WriteToParmLog("Step 09")
                LOG.WriteToParmLog("ARG: " + Arg)
                LOG.WriteToParmLog("Step 10")
                If InStr(Arg, ";") Then
                    LOG.WriteToParmLog("Step 11")
                    Dim AA() As String = Arg.Split(";")
                    CompanyID = AA(0)
                    RepoID = AA(1)
                    LOG.WriteToParmLog("Step 12")
                    Dim sCompanyID As String = REG.ReadEcmRegistrySubKey("CompanyID")
                    Dim sRepoID As String = REG.ReadEcmRegistrySubKey("RepoID")
                    Dim bReg As Boolean = False
                    LOG.WriteToParmLog("Step 13")
                    If sCompanyID.Length = 0 Then
                        LOG.WriteToParmLog("Step 14")
                        bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID)
                        LOG.WriteToParmLog("Step 15")
                        If Not bReg Then
                            LOG.WriteToParmLog("Step 16")
                            bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID)
                            LOG.WriteToParmLog("Step 17")
                        End If
                        LOG.WriteToParmLog("Step 18")
                    End If
                    LOG.WriteToParmLog("Step 19")
                    If sRepoID.Length = 0 Then
                        LOG.WriteToParmLog("Step 20")
                        bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID)
                        LOG.WriteToParmLog("Step 21")
                        If Not bReg Then
                            LOG.WriteToParmLog("Step 22")
                            bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID)
                            LOG.WriteToParmLog("Step 23")
                        End If
                        LOG.WriteToParmLog("Step 24")
                    End If
                    LOG.WriteToParmLog("Step 25")
                End If
                LOG.WriteToParmLog("Step 26")
            Next
        Catch ex As Exception
            LOG.WriteToParmLog("Step 27")
            LOG.WriteToArchiveLog("ERROR GetQueryStringParameters 100 - " + ex.Message)
            LOG.WriteToParmLog("ERROR GetQueryStringParameters 100 - " + ex.Message)
        Finally
            LOG.WriteToParmLog("Step 28")
            NameValueTable = Nothing
        End Try
        LOG.WriteToParmLog("Step 29")
    End Sub

    Private Sub cbCompany_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        populateRepoCombo()
    End Sub

    Private Sub btnFetch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFetch.Click
        Dim CID As String = txtCompany.Text.Trim.ToUpper
        Dim StoredCompanyID As String = REG.ReadEcmRegistrySubKey("CompanyID")
        StoredCompanyID = StoredCompanyID.ToUpper
        If CID.ToUpper.Equals(StoredCompanyID) Then
            populateRepoCombo()
        Else
            Dim RC As Boolean = False
            Dim RetTxt As String = ""
            Dim TPW As String = InputBox("A password is required to list the repositories within this company, please enter password.", "Password Required")
            TPW = ENC.AES256EncryptString(TPW)
            Dim Proxy As New SVCGateway.Service1Client
            Try
                Dim Items As String = Proxy.PopulateRepoSecure("", CID, TPW, RC, RetTxt)
                If Items.Length > 0 Then
                    cbRepo.Items.Clear()
                    Dim A() As String = Items.Split("|")
                    For I As Integer = 0 To A.Length - 1
                        cbRepo.Items.Add(A(I))
                    Next
                Else
                    MessageBox.Show("No repositories found.")
                End If
            Catch ex As Exception
                MessageBox.Show("ERROR - 100.33.1: " + ex.Message)
                LOG.WriteToArchiveLog("ERROR - 100.33.1: " + ex.Message)
            End Try
            Proxy = Nothing
        End If
    End Sub

    Private Sub ExitToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem.Click
        Application.Exit()
    End Sub

    Private Sub ExitToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExitToolStripMenuItem1.Click
        Application.Exit()
    End Sub

    Private Sub MirrorCEDatabasesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        DBLocal.CopyDatabases()
    End Sub

    Private Sub InstallCLCToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub InstallCLCToolStripMenuItem_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallCLCToolStripMenuItem.Click
        Process.Start("http://www.EcmLibrary.com/Ecm2012/Cloud/ClcDownloader/publish.htm")
    End Sub

    'tsTimeToArchive
    'tsCountDown


    Sub CalcNextArchiveTime()

        Dim LastArchiveDate As Date = Nothing
        Try
            LastArchiveDate = My.Settings("LastArchiveEndTime")
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

            tsCountDown.Text = String.Format("{0}:{1:d2}:{2:d2}", _
                                               remainingTime.Hours, _
                                               remainingTime.Minutes, _
                                               remainingTime.Seconds)
        End If
    End Sub

    Private Sub btnCountFiles_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCountFiles.Click

        Dim I As Integer = lbArchiveDirs.SelectedItems.Count
        If I = 0 Then
            SB.Text = "You must select an item from the listbox..."
            Return
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
        Dim S As String = System.Configuration.ConfigurationManager.AppSettings("AppConfigVerNo")
        MessageBox.Show("App Confing Version: " + S)
    End Sub

    Private Sub ckDeleteAfterArchive_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDeleteAfterArchive.CheckedChanged
        'If ckDeleteAfterArchive.Checked Then
        '    Dim Msg As String = "This will DELETE all files that are successfully archived" + vbCrLf
        '    MessageBox.Show(Msg)
        'End If
    End Sub

    Private Sub BackgroundWorkerContacts_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles BackgroundWorkerContacts.DoWork
        'frmNotify.Label1.Text = "Contacts: "
        ARCH.ArchiveContacts()
    End Sub

    Private Sub ToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToolStripMenuItem1.Click
        If ckDisable.Checked Then
            SB.Text = "DISABLE ALL is checked - no archive allowed."
            Return
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
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    Sub ReOcrPendingGraphics()

        If Not SkipPermission Then
            Dim msg$ = "This process can be  time consuming, are you sure?"
            Dim dlgRes As DialogResult = MessageBox.Show(msg, "Re-OCR Pending", MessageBoxButtons.YesNo)
            If dlgRes = Windows.Forms.DialogResult.No Then
                Return
            End If
        End If

        Dim tgtSourceGuid As String = ""
        Dim RetMsg As String = ""

        Dim ListOfGuids As New System.Collections.Generic.Dictionary(Of String, Integer)

        Proxy.getGuidsOfPendingGraphicFiles(999, ListOfGuids)

        frmNotifyBatchOCR.Show()
        Dim iTot As Integer = ListOfGuids.Keys.Count
        Dim I As Integer = 0
        For Each S As String In ListOfGuids.Keys
            I += 1
            tgtSourceGuid = S
            frmNotifyBatchOCR.lblMsg.Text = "OCR " + I.ToString + " of " + iTot.ToString
            frmNotifyBatchOCR.lblMsg.Refresh()
            frmNotifyBatchOCR.Refresh()
            Application.DoEvents()
            Proxy.ProcessSourceOCR(99, tgtSourceGuid, RetMsg)
        Next

        Proxy.getGuidsOfAllEmailGraphicFiles(999, False, ListOfGuids)

        Dim RC As Boolean = False
        iTot = ListOfGuids.Keys.Count
        I = 0
        For Each S As String In ListOfGuids.Keys
            I += 1
            tgtSourceGuid = S
            frmNotifyBatchOCR.lblMsg.Text = "EMAIL OCR " + I.ToString + " of " + iTot.ToString
            frmNotifyBatchOCR.lblMsg.Refresh()
            frmNotifyBatchOCR.Refresh()
            Application.DoEvents()
            Proxy.ProcessEmailAttachmentOCR(999, tgtSourceGuid, RC, RetMsg)
            If Not RC Then
                Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid)
            End If
        Next

        frmNotifyBatchOCR.Close()
        MessageBox.Show("Complete: " + RetMsg)
    End Sub
    Sub ReOcrAllGraphics()
        Dim msg$ = "This process can be very time consuming, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Re-OCR ALL", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If
        Dim tgtSourceGuid As String = ""
        Dim RetMsg As String = ""

        Dim ListOfGuids As New System.Collections.Generic.Dictionary(Of String, Integer)

        Proxy.getGuidsOfAllGraphicFiles(999, ListOfGuids)

        frmNotifyBatchOCR.Show()
        Dim iTot As Integer = ListOfGuids.Keys.Count
        Dim I As Integer = 0
        For Each S As String In ListOfGuids.Keys
            I += 1
            tgtSourceGuid = S
            frmNotifyBatchOCR.lblMsg.Text = "OCR " + I.ToString + " of " + iTot.ToString
            frmNotifyBatchOCR.lblMsg.Refresh()
            frmNotifyBatchOCR.Refresh()
            Application.DoEvents()
            Proxy.ProcessSourceOCR(99, tgtSourceGuid, RetMsg)
        Next

        Proxy.getGuidsOfAllEmailGraphicFiles(999, True, ListOfGuids)

        Dim RC As Boolean = False
        iTot = ListOfGuids.Keys.Count
        I = 0
        For Each S As String In ListOfGuids.Keys
            I += 1
            tgtSourceGuid = S
            frmNotifyBatchOCR.lblMsg.Text = "EMAIL OCR " + I.ToString + " of " + iTot.ToString
            frmNotifyBatchOCR.lblMsg.Refresh()
            frmNotifyBatchOCR.Refresh()
            Application.DoEvents()
            Proxy.ProcessEmailAttachmentOCR(999, tgtSourceGuid, RC, RetMsg)
            If Not RC Then
                Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid)
            End If
        Next
        frmNotifyBatchOCR.Close()
        MessageBox.Show("Complete: " + RetMsg)
    End Sub

    Private Sub asyncBatchOcrALL_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrALL.DoWork
        ReOcrAllGraphics()
    End Sub

    Private Sub asyncBatchOcrPending_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrPending.DoWork
        ReOcrPendingGraphics()
    End Sub

    Private Sub ReOcrIncompleteGraphicFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ReOcrIncompleteGraphicFilesToolStripMenuItem.Click
        If asyncBatchOcrPending.IsBusy Then
            Return
        End If

        Try
            asyncBatchOcrPending.RunWorkerAsync()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    Private Sub ReOcrALLGraphicFilesToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ReOcrALLGraphicFilesToolStripMenuItem1.Click
        If asyncBatchOcrALL.IsBusy Then
            Return
        End If

        Try
            asyncBatchOcrALL.RunWorkerAsync()
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    Private Sub EstimateNumberOfFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EstimateNumberOfFilesToolStripMenuItem.Click
        Dim Msg As String = ""
        Dim iCnt As Integer = 0

        Dim S As String = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        iCnt = Proxy.iCount(9999, gCurrUserGuidID, S)
        Msg += "Total EMAIL Graphics: " + iCnt.ToString + vbCrLf

        S = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        S += "and (OcrPending is null or OcrPending = 'Y')" + vbCrLf
        iCnt = Proxy.iCount(9999, gCurrUserGuidID, S)
        Msg += "Total pending EMAIL Graphics: " + iCnt.ToString + vbCrLf + vbCrLf

        S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        iCnt = Proxy.iCount(9999, gCurrUserGuidID, S)
        Msg += "Total Source Graphics: " + iCnt.ToString + vbCrLf

        S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + vbCrLf
        S += "and (OcrPending is null or OcrPending = 'Y')" + vbCrLf
        S += "and (OcrPerformed is null or OcrPerformed != 'Y')" + vbCrLf
        iCnt = Proxy.iCount(9999, gCurrUserGuidID, S)
        Msg += "Total Pending Source Graphics: " + iCnt.ToString + vbCrLf

        MessageBox.Show(Msg)

    End Sub

    Private Sub CEDatabasesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CEDatabasesToolStripMenuItem.Click
        Dim msg$ = "This delete the temporary data stores used for performance enhancement, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        DBLocal.truncateDirs()
        DBLocal.truncateFiles()
        DBLocal.truncateInventory()
        DBLocal.truncateOutlook()
        DBLocal.truncateExchange()
        DBLocal.truncateContacts()

        MessageBox.Show("Temporary file stores cleaned up and ready.")
    End Sub

    Private Sub ZIPFilesArchivesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ZIPFilesArchivesToolStripMenuItem.Click
        Dim msg$ = "This deletes the pending ZIP files to be processed, are you sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        DBLocal.zeroizeZipFiles()

        MessageBox.Show("Temporary zip files cleaned up and ready.")
    End Sub

    Private Sub ViewCEDirectoriesToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewCEDirectoriesToolStripMenuItem1.Click
        Dim tPath As String = System.IO.Path.GetTempPath
        tPath = tPath + "EcmLibrary\CE"

        Shell("explorer.exe " + Chr(34) + tPath + Chr(34), vbNormalFocus)
    End Sub

    Private Sub InstallCESP2ToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InstallCESP2ToolStripMenuItem1.Click
        Process.Start("http://www.microsoft.com/downloads/en/details.aspx?FamilyID=e497988a-c93a-404c-b161-3a0b323dce24")
    End Sub

    Private Sub AllToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles AllToolStripMenuItem1.Click
        CEDatabasesToolStripMenuItem_Click(Nothing, Nothing)
        ZIPFilesArchivesToolStripMenuItem_Click(Nothing, Nothing)
    End Sub

    Private Sub RSSPullToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RSSPullToolStripMenuItem.Click
        Dim sUrl As String = "http://pheedo.msnbc.msn.com/id/8874569/device/rss/"
        ARCH.getRssFeed(sUrl)
    End Sub

    Private Sub hlExchange_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles hlExchange.LinkClicked
        Dim B As Boolean = DB.isAdmin(gCurrUserGuidID)
        If Not B Then
            DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.")
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If
        frmExhangeMail.Show()
    End Sub

    Private Sub LinkLabel1_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles LinkLabel1.LinkClicked
        frmPstLoader.UID = UIDcurr
        frmPstLoader.ShowDialog()
    End Sub

    Private Sub asyncVerifyRetainDates_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncVerifyRetainDates.DoWork
        Proxy.VerifyRetentionDates()
    End Sub

    Private Sub OnlineHelpToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OnlineHelpToolStripMenuItem.Click
        Process.Start("http://www.EcmLibrary.com/HelpSaaS/Archive.htm")
    End Sub

    Private Sub ckRunOnStart_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles ckRunOnStart.CheckedChanged
        If formloaded = False Then
            Return
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
        Catch ex As Exception
            MessageBox.Show("Failed to set start up parameter." + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter." + vbCrLf + ex.Message)
        End Try
    End Sub
End Class

