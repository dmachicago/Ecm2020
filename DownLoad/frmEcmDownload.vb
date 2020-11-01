Imports System.ServiceModel
Imports System.Reflection
Imports System.IO

Public Class frmEcmDownload
    'SOURCE SAFE LOCATION: ECMSaaS.root/Search.Root/Search/EcmCloudWcf/EcmDownloader

    Dim DB As New clsDatabaseDL()
    Dim ENC As New clsEncrypt()
    Dim DLOAD As New clsDownload(SB, Label3, Label4)
    Dim LOG As New clsLogging

    Dim args As String() = Nothing
    Dim UseISO As Boolean = False

    'Dim ProxyGW As SVC_Gateway.IService1 = New SVC_Gateway.Service1Client
    'Dim ProxyDL As SVCclcDownload.IService1 = New SVCclcDownload.Service1Client

    Dim RC As Boolean = True
    Dim RetMsg As String = ""
    Dim CurrUserID As String = ""
    Public PreviewDirectory As String = ""
    Public DownloadDirectory As String = ""
    Public PreviewDirectoryExist As Boolean = False
    Public DownloadDirectoryExist As Boolean = False
    Public NbrPolls As Integer = 0
    Public FilesDownloaded As Integer = 0
    Dim formInitialized As Boolean = False
    Dim RegistrationFQN As String = ""
    Dim RestoreContentGuid As New Dictionary(Of String, String)

    Dim ClassSection As String = "DL"
    Dim GWVersion As String = ""
    Dim DLVersion As String = ""

    Private dirRestore As String = "EcmRestoreFiles"
    Private dirPreview As String = "EcmPreviewFile"
    Dim ECMTrackingAssembly As String = "ECM Tracking Assm: 03.02.05.1107"


    '*****************************************************
    '** Set the below to FALSE to use the endpoints
    '** passed in from the ECM Library searh engine.
    '** Set it to true to use the endpoints defined
    '** within the app config file.    
    '*****************************************************
    Dim bUseConfigEndpoints As Boolean = False

    Sub New()
        ' This call is required by the designer.
        InitializeComponent()
        Dim PassedInRowID As String = ""
        '**********************************************************************************************************
        args = Environment.GetCommandLineArgs()
        If args IsNot Nothing Then
            Dim X As Integer = 0
            '** The only allowed argument is rowid
            For Each Arg As String In args
                If (X = 1) Then
                    PassedInRowID = Arg
                    gRepoID = Arg
                    gSecureID = Convert.ToInt32(Arg)
                End If
                X += 1
            Next
        Else
            MessageBox.Show("ERROR: A Repository ID must be passed in, defaulting to zero.")
            PassedInRowID = ""
            gRepoID = "0"
        End If
        '**********************************************************************************************************

        gUseConfigEndpoints = bUseConfigEndpoints
        gDownloadDIR = ""

        'If My.Settings("UpgradeSettings") = True Then
        '    Try
        '        LOG.WriteLog("NOTICE: New INSTALL detected 100")
        '        My.Settings.Upgrade()
        '        My.Settings.Reload()
        '        My.Settings("UpgradeSettings") = False
        '        My.Settings.Save()
        '        LOG.WriteLog("NOTICE: New INSTALL detected 200: " + My.Settings("UserDefaultConnString"))
        '        LOG.WriteLog("NOTICE: New INSTALL detected 300: " + My.Settings("UserThesaurusConnString"))
        '    Catch ex As Exception
        '        LOG.WriteLog("ERROR: INSTALL 100: " + ex.Message)
        '    End Try
        'Else
        '    LOG.WriteLog("NOTICE: NO New INSTALL 100-A")
        'End If

        Dim bEndPointSet As Boolean = True
        gSystemCurrUserID = System.Environment.UserName.ToString

        If (ProxyGateway Is Nothing) Then
            ProxyGateway = New SVC_Gateway.Service1Client
        End If


        DB.getGatewayCs()
        DB.getRepoCs(gRepoID)
        DB.getEndpoint(gRepoID)

        Dim bSetEP As Boolean = DB.setEndpoints()
        If Not bSetEP Then
            MessageBox.Show("ERROR Setting Endpoints, aborting")
            End
        End If

        'RecallMe()

        Try
            ClassSection = "DL"
            gSessionID = ProxyGateway.getSessionID()
            GWVersion = ProxyGateway.getServiceVersion()

            gEncCS = ENC.AES256EncryptString(gRepoCS)
            'gEncCS = ProxyGateway.getConnection(gCompanyID, gRepoCode, RC, RetMsg, gSystemCurrUserID, gSessionID, "DL")
            LOG.WriteLog("ProxyGateway instantiated.")

            DLVersion = ProxyDownload.getServiceVersion()
            Dim ss As String = ProxyDownload.getdata(99)
            LOG.WriteLog("ProxyDownload instantiated.")

        Catch ex As Exception
            Dim xMsg As String = "001A - End Points Not set: " + vbCrLf + ex.Message
            Clipboard.Clear()
            Clipboard.SetText(xMsg)
            MessageBox.Show(xMsg)
        End Try


        Label3.Text = "SET: " + gGatewayEndPoint
        Label4.Text = "SET: " + gDownloadEndPoint

        DLOAD.PurgeExistingRunningFiles()
        RegistrationFQN = DLOAD.RegisterCLC(CurrUserID)

        getDefaultSaveDir()

        If gDownloadDIR.Trim.Length = 0 Then
            gDownloadDIR = LOG.getEnvVarSpecialFolderMyDocuments() + "\ECM.Restore"
        End If

        Label6.ForeColor = Color.LightYellow
        Label6.Text = "Ver: " + My.Application.Info.Version.Major.ToString + "." + My.Application.Info.Version.Minor.ToString + "." + My.Application.Info.Version.Revision.ToString + "." + My.Application.Info.Version.Build.ToString

        formInitialized = True
    End Sub

    Private Sub ckDisable_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDisable.CheckedChanged
        If ckDisable.Checked Then
            lblScan.Text = "Polling Inactive"
            TPreview.Enabled = False
            TDownload.Enabled = False
        Else
            lblScan.Text = "Polling Active"
            TPreview.Enabled = True
            TDownload.Enabled = True
        End If

    End Sub

    Private Sub TPreview_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TPreview.Tick

        If formInitialized = False Then
            Return
        End If

        Dim RC As Boolean = True
        If UseISO Then
            DLOAD.FindExistingSAASFiles()

            If gActivePreviewPath.Length = 0 Then
                Return
            End If

            NbrPolls += 1
            lblNbrPolls.Text = "Polls: " + NbrPolls.ToString
            TPreview.Enabled = False
            DLOAD.ScanPreviewDir(gActivePreviewPath, PreviewDirectoryExist)
        Else
            If txtLoginID.Text.Trim.Length = 0 Then
                SB.Text = "You must supply a Login User ID, returning."
                SB.BackColor = Color.Red
                SB.ForeColor = Color.Yellow
                MessageBox.Show("You must supply a Login User ID, returning.")
                Return
            Else
                SB.BackColor = Color.LightYellow
                SB.ForeColor = Color.Black
                gCurrentUserID = txtLoginID.Text.Trim
            End If
            NbrPolls += 1
            lblNbrPolls.Text = "Polls: " + NbrPolls.ToString
            SB.Text = "Processing Previews"
            TDownload.Enabled = False
            TPreview.Enabled = False

            Dim iPreviewCnt As Integer = ProxyDownload.ckPreviewFileToProcess(gEncCS, gCurrentUserID, RC)
            If iPreviewCnt > 0 Then
                RestoreContentGuid.Clear()
                'ByVal EncCS As String, ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean, SessionID As String                
                ProxyDownload.getPreviewFileSourceGuid(gEncCS, gCurrentUserID, RestoreContentGuid, RC, gSessionID)

                Dim tMsg As String = ""
                For Each sGuid As String In RestoreContentGuid.Keys
                    tMsg += RC.ToString + " : " + sGuid + vbCrLf
                Next

                Dim isPreview As Boolean = True
                DLOAD.StartProcessFromGuid(gCurrentUserID, isPreview, RestoreContentGuid, gSessionID, SB)
            End If
            SB.Text = ""
        End If

        TPreview.Enabled = True
        TDownload.Enabled = True
        lblPreviewState.Text = "No active previews"
    End Sub

    Private Sub TDownload_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TDownload.Tick

        If formInitialized = False Then
            Return
        End If

        Dim bEndPointSet As Boolean = DLOAD.SetActiveEndPoints(Label3, Label4)
        If bEndPointSet = False Then
            Label3.Text = "ENDPOINTS NOT SET!"
            Return
        Else
            Label3.Text = "SET: " + gGatewayEndPoint
        End If

        If gDownloadDIR.Trim.Length = 0 Then
            If gActiveRestorePath.Length = 0 Then
                gActiveRestorePath = LOG.getEnvVarSpecialFolderMyDocuments() + "\ECM.Restore"
            End If
        End If

        Dim RC As Boolean = True
        Try
            If UseISO Then
                DLOAD.FindExistingSAASFiles()
                If gCLCDIR.Length = 0 Then
                    Dim tgtDir As String = DLOAD.dirCLC
                    Dim CLCDIR As String = DLOAD.FindIsolatedDirectoryPath(tgtDir, "")
                End If

                NbrPolls += 1
                lblNbrPolls.Text = "Polls: " + NbrPolls.ToString
                SB.Text = "Beginning to download " + lblNbrPolls.ToString + " files."
                TDownload.Enabled = False
                DLOAD.ScanDownloadDir(gActiveRestorePath, DownloadDirectoryExist)
            Else
                If txtLoginID.Text.Trim.Length = 0 Then
                    SB.Text = "You must supply a Login User ID, returning."
                Else
                    gCurrentUserID = txtLoginID.Text.Trim
                End If
                NbrPolls += 1
                lblNbrPolls.Text = "Polls: " + NbrPolls.ToString
                SB.Text = "Processing Downloads"
                TDownload.Enabled = False
                Dim iDownloadCnt As Integer = ProxyDownload.ckRestoreFilesToProcess(gEncCS, gCurrentUserID, RC)
                If iDownloadCnt > 0 Then
                    SB.Text = "Beginning to download " + iDownloadCnt.ToString + " files."
                    RestoreContentGuid.Clear()
                    ProxyDownload.getRestoreFileSourceGuid(gEncCS, gCurrentUserID, RestoreContentGuid, RC, gSessionID)
                    If RC = True Then
                        SB.Text = "SUCCESS"
                    Else
                        SB.Text = "FAILURE"
                    End If
                    Dim isPreview As Boolean = False
                    DLOAD.StartProcessFromGuid(gCurrentUserID, isPreview, RestoreContentGuid, gSessionID, SB)
                End If
                SB.Text = ""
            End If
        Catch ex As Exception
            MessageBox.Show("Download 001" + ex.Message)
        End Try

        SB.Text = ""
        TDownload.Enabled = True

    End Sub

    Private Sub frmEcmDownload_FormClosing(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles MyBase.FormClosing
        TPreview.Enabled = False
        TDownload.Enabled = False
        If UseISO Then
            DLOAD.SetCLC_State(gCLCDIR, "OFF")
        End If
        Dim LOG As New clsLogging
        LOG.DeletePreviewFiles()
        'Dim DL As New clsDownload()
        'DL.cleanTempWorkingDir(RestoreDir)
        LOG = Nothing
    End Sub

    Private Sub ContentRestoreFolderToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ContentRestoreFolderToolStripMenuItem.Click
        Dim TempFolder$ = LOG.getRestoreDirContent()
        Shell("explorer.exe " + Chr(34) + TempFolder$ + Chr(34), vbNormalFocus)
    End Sub

    Private Sub EmailRestoreFolderToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmailRestoreFolderToolStripMenuItem.Click
        Dim TempFolder$ = LOG.getRestoreDirEmail()
        Shell("explorer.exe " + Chr(34) + TempFolder$ + Chr(34), vbNormalFocus)
    End Sub

    Private Sub PreviewFolderToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PreviewFolderToolStripMenuItem.Click
        Dim TempFolder$ = LOG.getRestoreDirPreview()
        Shell("explorer.exe " + Chr(34) + TempFolder$ + Chr(34), vbNormalFocus)
    End Sub

    Private Sub ApplicationFolderToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ApplicationFolderToolStripMenuItem.Click
        Dim TempFolder$ = LOG.getEnvApplicationExecutablePath()
        Shell("explorer.exe " + Chr(34) + TempFolder$ + Chr(34), vbNormalFocus)
    End Sub

    Private Sub LogsFolderToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LogsFolderToolStripMenuItem.Click
        Dim TempFolder As String = LOG.getTempEnvironDir
        'Shell("explorer.exe " + Chr(34) + TempFolder$ + Chr(34), vbNormalFocus)
        'Dim TempFolder As String = LOG.getEnvVarSpecialFolderApplicationData()

        Dim openFileDialog1 As New OpenFileDialog()

        openFileDialog1.InitialDirectory = TempFolder
        openFileDialog1.Filter = "Download Logs (ECMLibrary.Download*.*)|ECMLibrary.Download*.txt|ALL ECM Logs (ECM*.*)|ECM*.txt|txt files (*.txt)|*.txt|All files (*.*)|*.*"
        openFileDialog1.FilterIndex = 2
        openFileDialog1.RestoreDirectory = True
        If openFileDialog1.ShowDialog() = System.Windows.Forms.DialogResult.OK Then
            Dim fName As String = openFileDialog1.FileName
            Shell("notepad.exe " + Chr(34) + fName + Chr(34), vbNormalFocus)
            'Shell("notepad.exe " + Chr(34) + TempFolder + "\" + fName + Chr(34), vbNormalFocus)
        End If

    End Sub

    Private Sub CleanOutOldRestoredFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CleanOutOldRestoredFilesToolStripMenuItem.Click

    End Sub

    Private Sub PreviewedFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PreviewedFilesToolStripMenuItem.Click
        LOG.DeletePreviewFiles()
        MsgBox("Old preview files deleted.")
    End Sub

    Private Sub TempRestoredFilesToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TempRestoredFilesToolStripMenuItem.Click
        LOG.DeleteContentFiles()
        MsgBox("Old restored document files deleted.")
    End Sub

    Private Sub TempRestoredEmailsToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TempRestoredEmailsToolStripMenuItem.Click
        LOG.DeleteEMailFiles()
        MsgBox("Old restored email files deleted.")
    End Sub

    Private Sub OpenURL(ByVal URL As String)
        System.Diagnostics.Process.Start(URL)
    End Sub

    Private Sub PreviewToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PreviewToolStripMenuItem.Click
        Dim IsoDir As String = ""
        Dim TempDir As String = DLOAD.FindIsolatedDirectoryPath(dirPreview, IsoDir)
        If IsoDir.Length > 0 Then
            Shell("explorer.exe " + Chr(34) + IsoDir + Chr(34), vbNormalFocus)
        Else
            MsgBox("Directory not found.")
        End If
    End Sub

    Private Sub EmailToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles EmailToolStripMenuItem.Click
        Dim IsoDir As String = ""
        Dim TempDir As String = DLOAD.FindIsolatedDirectoryPath(dirRestore, IsoDir)
        If IsoDir.Length > 0 Then
            Shell("explorer.exe " + Chr(34) + IsoDir + Chr(34), vbNormalFocus)
        Else
            MsgBox("Directory not found.")
        End If
    End Sub

    Public Function checkInstance() As Process
        Dim cProcess As Process = Process.GetCurrentProcess()
        Dim aProcesses() As Process = Process.GetProcessesByName(cProcess.ProcessName)
        'loop through all the processes that are currently running on the 
        'system that have the same name
        For Each process As Process In aProcesses
            Console.WriteLine(cProcess.MainModule.FileName)
            'Ignore the currently running process 
            If process.Id <> cProcess.Id Then
                'Check if the process is running using the same EXE as this one

                If [Assembly].GetExecutingAssembly().Location = cProcess.MainModule.FileName Then
                    'if so return to the calling function with the instance of the process
                    Return process
                End If
            End If
        Next
        'if nothing was found then this is the only instance, so return null
        Return Nothing
    End Function

    Private Sub ViewCLCRegistrationStatusToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ViewCLCRegistrationStatusToolStripMenuItem.Click

        RegistrationFQN = DLOAD.findRegisterCLC(gCurrentUserID)

        Clipboard.Clear()
        Clipboard.SetText(RegistrationFQN)

        Shell("notepad " + Chr(34) + RegistrationFQN + Chr(34), vbNormalFocus)
        MessageBox.Show("Full path to Status File is in the clipboard.")
    End Sub

    Private Sub frmEcmDownload_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        DLOAD.SetCLC_State(gCLCDIR, "OFF")
        Dim LOG As New clsLogging
        LOG.DeletePreviewFiles()
        LOG = Nothing
    End Sub

    Private Sub FindCLCToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FindCLCToolStripMenuItem.Click
        DLOAD.PurgeExistingRunningFiles()
        DLOAD.SetActiveEndPoints(Label3, Label4)
        DLOAD.RegisterCLC(gCurrentUserID)
    End Sub

    Private Sub RegisterCLCAsActiveToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RegisterCLCAsActiveToolStripMenuItem.Click
        DLOAD.FindSAASPath()
    End Sub

    Private Sub InitCLCFoldersToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InitCLCFoldersToolStripMenuItem.Click
        DLOAD.FindExistingSAASFiles()
    End Sub

    Private Sub OpenSearchBrowserToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim SearchURL As String = System.Configuration.ConfigurationManager.AppSettings("ECMSearchURL")
        OpenURL(SearchURL)
    End Sub

    Private Sub PreviewToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PreviewToolStripMenuItem1.Click
        If UseISO Then
            DLOAD.ScanPreviewDir(PreviewDirectory, PreviewDirectoryExist)
        Else
            TPreview_Tick(Nothing, Nothing)
        End If
    End Sub

    Private Sub DownloadToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles DownloadToolStripMenuItem.Click
        If UseISO Then
            DLOAD.ScanDownloadDir(DownloadDirectory, DownloadDirectoryExist)
        Else
            TDownload_Tick(Nothing, Nothing)
        End If

    End Sub

    Sub RememberMe(ByVal UserID As String)
        Dim tDir As String = LOG.getTempEnvironDir + "\LoginID\"
        tDir = tDir.Replace("\\", "\")
        If Not Directory.Exists(tDir) Then
            Directory.CreateDirectory(tDir)
        End If

        Dim FILE_NAME As String = tDir + "UserLoginID.txt"

        Try
            Dim objWriter As New System.IO.StreamWriter(FILE_NAME)
            objWriter.WriteLine(UserID)
            objWriter.Close()
            objWriter.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
            SB.Text = "You are remembered, forever as a friend."
        Catch ex As Exception
            MsgBox("Failed to save User ID")
        End Try


    End Sub
    Sub RecallMe()

        Dim tDir As String = LOG.getTempEnvironDir + "\LoginID\"
        tDir = tDir.Replace("\\", "\")
        If Not Directory.Exists(tDir) Then
            Directory.CreateDirectory(tDir)
        End If

        Dim FILE_NAME As String = tDir + "UserLoginID.txt"

        If Not File.Exists(FILE_NAME) Then
            txtLoginID.Text = ""
            Return
        End If

        Dim sFileName As String = FILE_NAME
        Dim srFileReader As System.IO.StreamReader
        Dim sInputLine As String

        srFileReader = System.IO.File.OpenText(sFileName)
        sInputLine = srFileReader.ReadLine()
        Do Until sInputLine Is Nothing
            txtLoginID.Text = sInputLine
            sInputLine = srFileReader.ReadLine()
        Loop

        srFileReader.Close()
        srFileReader = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Private Sub ckRemember_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckRemember.CheckedChanged
        If ckRemember.Checked Then
            RememberMe(txtLoginID.Text)
        Else
            RememberMe("")
        End If
    End Sub

    Private Sub SetDownLoadDirectoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SetDownLoadDirectoryToolStripMenuItem.Click
        FolderBrowserDialog1.ShowDialog()

        If FolderBrowserDialog1.SelectedPath.Trim.Length = 0 Then
            Return
        End If

        Dim SelectedDir As String = FolderBrowserDialog1.SelectedPath
        Dim SaveDir As String = LOG.getEnvVarSpecialFolderMyDocuments + "\CLC_Parms\"
        SaveDir = SaveDir.Replace("\\", "\")
        If Not Directory.Exists(SaveDir) Then
            Directory.CreateDirectory(SaveDir)
        End If

        Dim SaveParmFile As String = SaveDir + "\DefaultDownLoadDir.txt"
        SaveParmFile = SaveParmFile.Replace("\\", "\")

        Dim objWriter As New System.IO.StreamWriter(SaveParmFile, False)


        objWriter.WriteLine(SelectedDir)
        objWriter.Close()
        objWriter.Dispose()

        lblDownLoadDir.Text = SelectedDir
        gDownloadDIR = SelectedDir

        GC.Collect()

    End Sub

    Sub getDefaultSaveDir()
        Dim SelectedDir As String = FolderBrowserDialog1.SelectedPath
        Dim SaveDir As String = LOG.getEnvVarSpecialFolderMyDocuments + "\CLC_Parms\"
        SaveDir = SaveDir.Replace("\\", "\")
        If Not Directory.Exists(SaveDir) Then
            Directory.CreateDirectory(SaveDir)
        End If

        Dim LineIn As String = ""

        Dim SaveParmFile As String = SaveDir + "\DefaultDownLoadDir.txt"
        SaveParmFile = SaveParmFile.Replace("\\", "\")

        If Not File.Exists(SaveParmFile) Then
            Return
        End If

        Dim oFile As System.IO.File
        Dim oRead As System.IO.StreamReader

        oRead = System.IO.File.OpenText(SaveParmFile)

        While oRead.Peek <> -1
            LineIn = oRead.ReadLine()
            lblDownLoadDir.Text = LineIn
            gDownloadDIR = LineIn
        End While

        oRead.Close()
        oRead.Dispose()
        oFile = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Private Sub Label5_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub Label3_Click(sender As Object, e As EventArgs) Handles Label3.Click

    End Sub

    Private Sub LogFileToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles LogFileToolStripMenuItem.Click
        Dim path As String = LOG.getLogPath()
        Clipboard.Clear()
        Clipboard.SetText(path)
        MessageBox.Show("Log Path: " + path + vbCrLf + "In the clipboard")
    End Sub

    Private Sub PassthruDirectoryToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles PassthruDirectoryToolStripMenuItem.Click
        Clipboard.Clear()
        Clipboard.SetText(gCLCDIR)
        MessageBox.Show("PassThru DIR: " + gCLCDIR + vbCrLf + "In the clipboard")
    End Sub

    Private Sub ShowServiceVersionNumbersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ShowServiceVersionNumbersToolStripMenuItem.Click
        Dim xmsg As String = "Gateway: " + GWVersion + vbCrLf + "Downloader: " + DLVersion + vbCrLf + ECMTrackingAssembly
        MessageBox.Show(xmsg)
    End Sub

    Private Sub Label6_MouseEnter(sender As Object, e As EventArgs) Handles Label6.MouseEnter
        SB.Text = "Ver: " + My.Application.Info.Version.ToString + " / " + ECMTrackingAssembly
    End Sub

    Private Sub Label6_MouseLeave(sender As Object, e As EventArgs) Handles Label6.MouseLeave
        SB.Text = ""
    End Sub

    Private Sub ViewTodaysLogToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ViewTodaysLogToolStripMenuItem.Click
        LOG.ViewTodayLog()
    End Sub

    Private Sub PurgeRestoreQueueToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles PurgeRestoreQueueToolStripMenuItem1.Click
        Dim B As Boolean = DLOAD.ClearRestoreQueue(gSecureID, gUserID, gSessionID)
        If B Then
            MessageBox.Show("Queue emptied.")
        Else
            MessageBox.Show("Queue NOT emptied.")
        End If
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click

    End Sub
End Class
