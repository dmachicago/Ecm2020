Imports System.IO
Imports System.IO.Compression
Imports System.IO.IsolatedStorage

Public Class clsDownload
    Inherits clsDatabaseDL

    Dim ProxyGateway As New SVC_Gateway.Service1Client()

    Dim TM As New clsTopMostMessageBox
    Dim CLCDIR As String = ""
    Dim BX As Boolean = True
    Dim iDirLevel As Integer = 0

    Dim SAAS_Instance As New SortedList(Of Date, String)
    Dim SAAS_Pending As New SortedList(Of Date, String)
    Dim SAAS_Download As New SortedList(Of Date, String)

    Private fileActive As String = "SAAS.RUNNING"

    Public bDoNotOverwriteExistingFile As Boolean = True
    Public bOverwriteExistingFile As Boolean = False
    Public bRestoreToOriginalDirectory As Boolean = False
    Public bRestoreToMyDocuments As Boolean = True
    Public bCreateOriginalDirIfMissing As Boolean = True

    'Dim ProxyDownload As SVCclcDownload.IService1 = New SVCclcDownload.Service1Client

    Public dirEcmGrids As String = "EcmGridParms"
    Public fnAllSearchEmailGrid As String = "dgEmailAll.grid.dat"
    Public fnAllSearchContentGrid As String = "dgContentAll.grid.dat"
    Public fnSearchContentGrid As String = "dgContent.grid.dat"
    Public fnSearchEmailGrid As String = "dgEmail.grid.dat"
    Public dirFormData As String = "EcmForm"
    Public dirTempData As String = "EcmTemp"
    Public dirLogData As String = "EcmLogs"
    Public dirSaveData As String = "EcmSavedData"

    Public dirRestore As String = "ECM.FileRestore.CURR"

    Public dirPreview As String = "EcmPreviewFile"
    Public filePreview As String = "ECM.Preview.CURR"

    Public dirCLC As String = "EcmSearchFilter"

    Private OverWriteFiles As Boolean = False
    Private SkipExistingFiles As Boolean = True
    Private WriteExistingFilesToMyDocuments As Boolean = False
    Private FilesCurrentlyDownloaded As Integer = 0

    Public MyTB As TextBox = Nothing
    Public LB1 As Label = Nothing
    Public LB2 As Label = Nothing

    Dim FileExt As String = ""

    Dim LOG As New clsLogging

    Sub New(TXTBOX As TextBox, Label1 As Label, Label2 As Label)
        MyTB = TXTBOX
        LB1 = Label1
        LB2 = Label2

        If (ProxyGateway Is Nothing) Then
            MessageBox.Show("ProxyGateway is NULL, error.")
        End If
        If (ProxyDownload Is Nothing) Then
            MessageBox.Show("ProxyDownload is NULL, error.")
        End If

        LOG.MakeRestoreDirectories()
    End Sub

    Public Function ClearRestoreQueue(SercureID As Integer, UserID As String, SessionID As String) As Boolean
        Dim RetMsg As String = ""
        Dim MySql As String = "DELETE from RestoreQueue where UserID = '" + UserID + "' "
        Dim BX As Boolean = True
        Try
            BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
        Catch ex As Exception
            BX = False
        End Try
        Return BX
    End Function

    Public Function FindDirectory(ByVal aDir As DirectoryInfo, ByVal tgtDir As String, ByRef PermDirectory As String, ByRef bDirFound As Boolean) As String

        Dim SSAS_PATH As String = FindSAASPath()

        If SSAS_PATH.Length > 0 Then
            PermDirectory = SSAS_PATH
            bDirFound = True
            Return SSAS_PATH
        End If

        Dim TgtFileName As String = "SAAS.RUNNING"

        tgtDir = tgtDir.ToUpper

        Dim DName As String = aDir.Name.ToUpper
        Dim DFullName As String = aDir.FullName
        'Console.WriteLine(aDir.Name)
        'Console.WriteLine(aDir.FullName)
        If InStr(DFullName, "\EcmForm") > 0 Then
            Console.WriteLine("EcmForm found...")
        End If
        If InStr(DFullName, "\ECMSEARCHFILTER") > 0 Then
            Console.WriteLine("EcmForm found...")
        End If
        Dim bFoundIt As Boolean = False
        If tgtDir.Equals("ECMSEARCHFILTER") And DName.Equals(tgtDir) Then
            Dim FilesInDir As New List(Of String)
            For Each sFile As System.IO.FileInfo In aDir.GetFiles("*.*")
                Dim sName As String = sFile.Name
                If sName.Equals(TgtFileName) Then
                    gCLCDIR = DFullName
                    bFoundIt = True
                    SetCLC_State(gCLCDIR, "ON")
                    Exit For
                End If
            Next
        End If
        'EcmPreviewFile
        If tgtDir.Equals("ECMPREVIEWFILE") And DName.Equals(tgtDir) Then
            Dim FilesInDir As New List(Of String)
            For Each sFile As System.IO.FileInfo In aDir.GetFiles("*.dat")
                Dim sName As String = sFile.Name
                If sName.Equals("ECM.Preview.dat") Then
                    bFoundIt = True
                    Return DFullName
                End If
            Next
        End If
        If DName.Equals(tgtDir) And bFoundIt Then
            Console.WriteLine(tgtDir + " found...")
            PermDirectory = DFullName
            gCLCDIR = DFullName
            bDirFound = True
            Return DFullName
        End If

        For Each nextDir In aDir.GetDirectories
            FindDirectory(nextDir, tgtDir, PermDirectory, bDirFound)
        Next
        Return ""
    End Function

    Public Sub WorkWithDirectory(ByVal aDir As DirectoryInfo, ByVal tgtDir As String, ByVal bPreview As Boolean, ByRef PermDirectory As String, ByRef bDirFound As Boolean)

        tgtDir = tgtDir.ToUpper

        Dim DName As String = aDir.Name.ToUpper
        Dim DFullName As String = aDir.FullName
        'Console.WriteLine(aDir.Name)
        'Console.WriteLine(aDir.FullName)
        If InStr(DFullName, "\EcmForm") > 0 Then
            Console.WriteLine("EcmForm found...")
        End If
        If InStr(DFullName, "\EcmRestoreFiles") > 0 Then
            Console.WriteLine("EcmRestoreFiles found...")
        End If
        If InStr(DFullName, "\EcmPreviewFile") > 0 Then
            Console.WriteLine("EcmPreviewFile found...")
        End If

        If DName.Equals(tgtDir) Then
            Console.WriteLine(tgtDir + " found...")
            PermDirectory = DFullName
            bDirFound = True
            'If tgtDir.Equals("ECMPREVIEWFILE") Then
            '    frmEcmDownload.PreviewDirectoryExist = True
            'End If
            WorkWithFilesInDir(aDir, bPreview, gSessionID)
        End If

        For Each nextDir In aDir.GetDirectories
            WorkWithDirectory(nextDir, tgtDir, bPreview, PermDirectory, bDirFound)
        Next
    End Sub

    Public Sub WorkWithFilesInDir(ByVal aDir As DirectoryInfo, ByVal bPreview As Boolean, SessionID As String)
        Dim aFile As FileInfo
        For Each aFile In aDir.GetFiles()
            Console.WriteLine(aFile.FullName)
            If aFile.FullName.Equals("CLC.RUNNING") Then
                Return
            End If
            If bPreview Then
                'Restore and open the file
                StartProcessFromFilefqn(aFile.FullName, bPreview, SessionID)
            End If
            If Not bPreview Then
                'Restore the file
                StartProcessFromFilefqn(aFile.FullName, bPreview, SessionID)
            End If
        Next
    End Sub

    Public Sub StartProcessFromGuid(ByVal UserID As String, ByVal isPreview As Boolean, ByVal GuidDict As Dictionary(Of String, String), SessionID As String, TBox As TextBox)

        Dim TotalFilesRestored As Integer = 0
        Dim FileDirFQN As String = ""
        Dim bContinue As Boolean = True
        Dim FilesToPreview As New List(Of String)
        LOG.WriteLog("StartProcessFromGuid 001")
        If Not Directory.Exists(LOG.getRestoreDirEmail) Then
            Directory.CreateDirectory(LOG.getRestoreDirEmail)
        End If
        If Not Directory.Exists(LOG.getRestoreDirContent) Then
            Directory.CreateDirectory(LOG.getRestoreDirContent)
        End If
        If Not Directory.Exists(LOG.getRestoreDirPreview) Then
            Directory.CreateDirectory(LOG.getRestoreDirPreview)
        End If
        LOG.WriteLog("StartProcessFromGuid 002")
        Dim RestoreDir As String = ""

        Dim bWarmingSet As Boolean = False

        '** Open and read the temp file's data here
        Dim ProcessCode As String = ""
        Dim SourceGuid As String = ""
        Dim RestoreFqn As String = ""
        Dim BinaryFile As Byte() = Nothing
        Dim SourceTypeCode As String = ""
        Dim OriginalSize As Integer = 0
        Dim CompressedSize As Integer = 0
        Dim RC As Boolean = False
        Dim rMsg As String = ""
        'Dim TempRestoreFileFqn As String = FileDirFQN

        Dim AllIsGood As Boolean = True
        'Dim F2Process As New FilesToProcess
        Dim lFileToProcess As New List(Of FilesToProcess)
        LOG.WriteLog("StartProcessFromGuid 003")
        Try
            Dim FileName As String = ""
            Dim fExt As String = ""
            LOG.WriteLog("StartProcessFromGuid 004")
            For Each tgtGuid As String In GuidDict.Keys
                Dim TypeSource As String = GuidDict.Item(tgtGuid)

                If isPreview Then
                    ProcessCode = TypeSource
                    SourceGuid = tgtGuid

                    If isPreview Then
                        RestoreDir = LOG.getRestoreDirPreview
                        RestoreDir = RestoreDir.Replace("\\", "\")
                    ElseIf TypeSource.ToUpper.Equals("EMAIL") Then
                        RestoreDir = LOG.getRestoreDirEmail
                        RestoreDir = RestoreDir.Replace("\\", "\")
                    ElseIf TypeSource.ToUpper.Equals("EMAILATTACHMENT") Then
                        RestoreDir = LOG.getRestoreDirEmail
                        RestoreDir = RestoreDir.Replace("\\", "\")
                    ElseIf TypeSource.ToUpper.Equals("CONTENT") Then
                        RestoreDir = LOG.getRestoreDirContent
                        RestoreDir = RestoreDir.Replace("\\", "\")
                    End If

                    If Not Directory.Exists(RestoreDir) Then
                        Directory.CreateDirectory(RestoreDir)
                    End If

                    ProxyDownload.getFileParameters(gEncCS, tgtGuid, FileName, fExt, TypeSource, RC)
                    Try
                        Dim F2Process As New FilesToProcess
                        F2Process.pRepoTableName = TypeSource
                        F2Process.CurrentGuid = tgtGuid
                        F2Process.FileExt = fExt
                        F2Process.FileFQN = FileName
                        lFileToProcess.Add(F2Process)
                    Catch ex As Exception
                        GoTo SKIPTHISFILE
                    End Try
                Else
                    LOG.WriteLog("StartProcessFromGuid 005")
                    Try

                        ProxyDownload.getFileParameters(gEncCS, tgtGuid, FileName, fExt, TypeSource, RC)
                        Dim F2Process As New FilesToProcess
                        F2Process.pRepoTableName = TypeSource
                        F2Process.CurrentGuid = tgtGuid
                        F2Process.FileExt = fExt
                        F2Process.FileFQN = FileName
                        F2Process.bDoNotOverwriteExistingFile = True
                        F2Process.bOverwriteExistingFile = False
                        F2Process.bRestoreToOriginalDirectory = False
                        F2Process.bRestoreToMyDocuments = True
                        F2Process.bCreateOriginalDirIfMissing = True

                        lFileToProcess.Add(F2Process)
                    Catch ex As Exception
                        GoTo SKIPTHISFILE
                    End Try

                End If
SKIPTHISFILE:
                LOG.WriteLog("StartProcessFromGuid 006")
            Next
        Catch ex As Exception
            LOG.WriteLog("ERROR 10.1a: Failed to open the prefiew file, aborting.")
            AllIsGood = False
            Return
        End Try
        '** Split out the TABLE and the GUID

        If lFileToProcess.Count > 0 Then
            frmEcmDownload.PB.Visible = True
            frmEcmDownload.PB.Maximum = lFileToProcess.Count + 1
        End If

        Dim LoopCnt As Integer = 0
        LOG.WriteLog("StartProcessFromGuid 007")
        For Each F2Process In lFileToProcess
            BinaryFile = Nothing
            ProcessCode = F2Process.pRepoTableName
            Dim sGuid As String = F2Process.CurrentGuid
            Dim sFileName As String = F2Process.FileFQN
            LoopCnt += 1
            frmEcmDownload.PB.Value = LoopCnt
            frmEcmDownload.PB.Refresh()
            Application.DoEvents()
            LOG.WriteLog("StartProcessFromGuid 008")
            If ProcessCode.Equals("EMAIL") Then
                LOG.WriteLog("StartProcessFromGuid 009")
                FilesCurrentlyDownloaded += 1
                frmEcmDownload.FilesDownloaded = FilesCurrentlyDownloaded
                frmEcmDownload.lblNbrDownloadsProcessed.Text = FilesCurrentlyDownloaded.ToString

                SourceGuid = F2Process.CurrentGuid
                SourceTypeCode = F2Process.FileExt

                RestoreFqn = F2Process.FileFQN
                FileDirFQN = ""
                If isPreview Then
                    FileDirFQN = RestoreDir + "\" + RestoreFqn
                    FileDirFQN = FileDirFQN.Replace("\\", "\")
                    If Not FilesToPreview.Contains(FileDirFQN) Then
                        FilesToPreview.Add(FileDirFQN)
                    End If
                Else
                    FileDirFQN = RestoreDir + "\" + RestoreFqn
                    FileDirFQN = FileDirFQN.Replace("\\", "\")
                End If
                'RestoreFqn = FileDirFQN

                If File.Exists(FileDirFQN) Then
                    Dim RetMsg As String = ""
                    Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                    BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                    If BX = False Then
                        LOG.WriteLog("99001: " + MySql)
                    End If
                    If RetMsg.Trim.Length > 0 Then
                        LOG.WriteLog("ERROR: 10061: " + RetMsg)
                        TBox.Text = "ERROR: 10061: " + RetMsg
                    End If
                    TotalFilesRestored += 1
                    GoTo SkipFile
                End If
                If gEncCS.Length = 0 Then
                    'SetActiveEndPOints()
                End If
                '** Download the email, unzip in memory, convert it to a file
                ProxyDownload.writeEmailFromDbToFile(gEncCS, SourceGuid, SourceTypeCode, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                If RC Then
                    If BinaryFile Is Nothing Then
                        Return
                    Else
                        If BinaryFile.Length = 0 Then
                            TBox.Text = "It appears the EMAIL did not download, please try again - aborting preview."
                            Return
                        End If
                    End If
                    CompressedSize = BinaryFile.Length
                    BinaryFile = Decompress(BinaryFile)
                    OriginalSize = BinaryFile.Length
                    'RestoreFqn = "EMAIL." + SourceGuid + "." + SourceTypeCode
                    FileDirFQN = ""
                    If isPreview Then
                        FileDirFQN = RestoreDir + "\" + RestoreFqn
                        FileDirFQN = FileDirFQN.Replace("\\", "\")
                        RestoreFqn = FileDirFQN
                        If Not FilesToPreview.Contains(FileDirFQN) Then
                            FilesToPreview.Add(FileDirFQN)
                        End If
                    Else
                        'FileDirFQN = LOG.getRestoreDirEmail + "\" + RestoreFqn
                        FileDirFQN = RestoreDir + "\" + RestoreFqn
                        FileDirFQN = FileDirFQN.Replace("\\", "\")
                        RestoreFqn = FileDirFQN
                    End If
                    RestoreFqn = FileDirFQN
                    '** Check to see if the file already exists on the local machine
                    If File.Exists(RestoreFqn) Then

                        Dim RetMsg As String = ""
                        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                        BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                        If BX = False Then
                            LOG.WriteLog("99002: " + MySql)
                        End If
                        If RetMsg.Trim.Length > 0 Then
                            LOG.WriteLog("ERROR: 10062: " + RetMsg)
                            TBox.Text = "ERROR: 10062: " + RetMsg
                        End If
                        TotalFilesRestored += 1
                        GoTo SkipFile
                    End If
                    Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                    If bSuccess Then
                        TotalFilesRestored += 1
                        Dim RetMsg As String = ""
                        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                        BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                        If BX = False Then
                            LOG.WriteLog("99003: " + MySql)
                        End If
                        If RetMsg.Trim.Length > 0 Then
                            LOG.WriteLog("ERROR: 10063: " + RetMsg)
                            TBox.Text = "ERROR: 10063: " + RetMsg
                        End If
                    End If
                Else
                    LOG.WriteLog("StartProcessFromGuid 010")
                    TBox.Text = "ERROR Message in Clipboard: Failed to download EMAIL - " + rMsg
                    LOG.WriteLog("ERROR Message in Clipboard: Failed to download EMAIL - " + rMsg)
                    Clipboard.Clear()
                    Clipboard.SetText("ERROR: Failed to download EMAIL - " + rMsg)
                    AllIsGood = False
                End If
            ElseIf ProcessCode.Equals("EMAILATTACHMENT") Then
                LOG.WriteLog("StartProcessFromGuid 011")
                FilesCurrentlyDownloaded += 1
                frmEcmDownload.FilesDownloaded = FilesCurrentlyDownloaded
                frmEcmDownload.lblNbrDownloadsProcessed.Text = FilesCurrentlyDownloaded.ToString

                SourceGuid = F2Process.CurrentGuid
                RestoreFqn = F2Process.FileFQN
                ProxyDownload.writeAttachmentFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                If RC Then
                    LOG.WriteLog("StartProcessFromGuid 012")
                    If BinaryFile Is Nothing And OriginalSize > 0 Then
                    ElseIf BinaryFile.Length = 0 And OriginalSize > 0 Then
                        TBox.Text = "It appears the EMAIL ATTACHMENT did not download, please try again - aborting preview."
                        'AllIsGood = False
                    Else
                        BinaryFile = Decompress(BinaryFile)
                    End If
                Else
                    LOG.WriteLog("StartProcessFromGuid 013")
                    AllIsGood = False
                    LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                    'TBox.Text = "ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                    'Clipboard.Clear()
                    'Clipboard.SetText("ERROR 300: Failed to download Content - " + rMsg)
                End If

                FileDirFQN = ""
                If isPreview Then
                    FileDirFQN = RestoreDir + "\" + RestoreFqn
                    FileDirFQN = FileDirFQN.Replace("\\", "\")
                    If Not FilesToPreview.Contains(FileDirFQN) Then
                        FilesToPreview.Add(FileDirFQN)
                    End If
                Else
                    FileDirFQN = RestoreDir + "\" + RestoreFqn
                    FileDirFQN = FileDirFQN.Replace("\\", "\")
                End If

                RestoreFqn = FileDirFQN
                '** Check to see if the file already exists on the local machine

                If File.Exists(RestoreFqn) Then
                    If isPreview Then
                        If Not FilesToPreview.Contains(FileDirFQN) Then
                            FilesToPreview.Add(FileDirFQN)
                        End If
                    End If
                    Dim msg$ = "This file exists on your local computer, " + vbCrLf
                    msg += "would you like to view that one? " + vbCrLf
                    msg += "    (or NO to download from the repository.)"
                    Dim dlgRes As DialogResult = MessageBox.Show(msg, "Display Existing File", MessageBoxButtons.YesNo)
                    If dlgRes = Windows.Forms.DialogResult.Yes Then
                        GoTo SkipFile
                    End If
                End If

                'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                If bSuccess Then
                    TotalFilesRestored += 1
                    Dim RetMsg As String = ""
                    Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                    BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                    If BX = False Then
                        LOG.WriteLog("99004: " + MySql)
                    End If
                    If RetMsg.Trim.Length > 0 Then
                        LOG.WriteLog("ERROR: 10064: " + RetMsg)
                        TBox.Text = "ERROR: 10064: " + RetMsg
                    End If
                End If
                LOG.WriteLog("StartProcessFromGuid 015")
            Else
                LOG.WriteLog("StartProcessFromGuid 016")
                FilesCurrentlyDownloaded += 1
                frmEcmDownload.FilesDownloaded = FilesCurrentlyDownloaded
                frmEcmDownload.lblNbrDownloadsProcessed.Text = FilesCurrentlyDownloaded.ToString

                SourceGuid = F2Process.CurrentGuid
                Dim TypeSource As String = F2Process.pRepoTableName.ToUpper
                If TypeSource.ToUpper.Equals("EMAIL") Then
                    RestoreDir = LOG.getRestoreDirEmail
                    RestoreDir = RestoreDir.Replace("\\", "\")
                ElseIf TypeSource.ToUpper.Equals("EMAILATTACHMENT") Then
                    RestoreDir = LOG.getRestoreDirEmail
                    RestoreDir = RestoreDir.Replace("\\", "\")
                ElseIf TypeSource.ToUpper.Equals("CONTENT") Then
                    RestoreDir = LOG.getRestoreDirContent
                    RestoreDir = RestoreDir.Replace("\\", "\")
                End If

                RestoreFqn = RestoreDir + "\" + F2Process.FileFQN
                RestoreFqn = RestoreFqn.Replace("\\", "\")

                If InStr(RestoreFqn, "http://", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                    '** This is a WEB based file
                    RestoreFqn = getWebFileName(RestoreFqn)
                    RestoreFqn = LOG.getRestoreDirContent + "\" + RestoreFqn
                    F2Process.FileFQN = RestoreFqn
                End If
                If InStr(RestoreFqn, "https://", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                    '** This is a WEB based file
                    RestoreFqn = getWebFileName(RestoreFqn)
                    RestoreFqn = LOG.getRestoreDirContent + "\" + RestoreFqn
                    F2Process.FileFQN = RestoreFqn
                End If
                LOG.WriteLog("StartProcessFromGuid 017")
                bCreateOriginalDirIfMissing = F2Process.bCreateOriginalDirIfMissing
                bDoNotOverwriteExistingFile = F2Process.bDoNotOverwriteExistingFile
                bOverwriteExistingFile = F2Process.bOverwriteExistingFile
                bRestoreToMyDocuments = F2Process.bRestoreToMyDocuments
                bRestoreToOriginalDirectory = F2Process.bRestoreToOriginalDirectory
                FileExt = F2Process.FileExt

                If bCreateOriginalDirIfMissing Then
                    Dim FN As String = ""
                    Dim DN As String = ""
                    Try
                        Dim FI As New FileInfo(RestoreFqn)

                        Dim F As File
                        FN = FI.Name
                        DN = FI.DirectoryName

                        If Not Directory.Exists(DN) Then
                            Directory.CreateDirectory(DN)
                        End If

                        FI = Nothing
                        FN = Nothing
                        DN = Nothing
                        F = Nothing
                    Catch ex As Exception
                        If bWarmingSet = False Then
                            bWarmingSet = True
                            TBox.Text = "The original directory " + DN + " could not be created, using MyDocuments for these files."
                        End If

                        Console.WriteLine(ex.Message)
                        bRestoreToMyDocuments = True
                        bCreateOriginalDirIfMissing = False

                    End Try
                End If
                LOG.WriteLog("StartProcessFromGuid 018")
                If isPreview Then
                    LOG.WriteLog("StartProcessFromGuid 019")
                    '** Check to see if the file already exists on the local machine
                    If File.Exists(RestoreFqn) Then
                        Dim msg$ = "This file exists on your local computer, " + vbCrLf
                        msg += "would you like to view that one? " + vbCrLf
                        msg += "    (or NO to download from the repository.)"
                        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Display Existing File", MessageBoxButtons.YesNo)
                        If dlgRes = Windows.Forms.DialogResult.Yes Then
                            GoTo SkipFile
                        End If
                    End If
                    Dim TempRestoreFqn As String = RestoreFqn
                    ProxyDownload.writeImageSourceDataFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                    LOG.WriteLog("StartProcessFromGuid 020")
                    If RC Then
                        LOG.WriteLog("StartProcessFromGuid 020.1")
                        If BinaryFile Is Nothing Then
                            LOG.WriteLog("StartProcessFromGuid 020.11")
                            TBox.Text = "It appears the Document did not download, please try again - aborting preview."
                            LOG.WriteLog("StartProcessFromGuid 020.12 - It appears the Document did not download, please try again - aborting preview.")
                            Return
                        ElseIf BinaryFile.Length = 0 Then
                            LOG.WriteLog("StartProcessFromGuid 020.13")
                            TBox.Text = "It appears the Document did not download, please try again - aborting preview."
                            LOG.WriteLog("StartProcessFromGuid 020.14 - It appears the Document did not download, please try again - aborting preview.")
                            Return
                        End If
                        LOG.WriteLog("StartProcessFromGuid 020.15")
                        BinaryFile = Decompress(BinaryFile)
                        LOG.WriteLog("StartProcessFromGuid 020.20")
                    Else
                        LOG.WriteLog("StartProcessFromGuid 020.30")
                        LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                        Clipboard.Clear()
                        Clipboard.SetText("ERROR: Failed to download Content - " + rMsg)
                    End If
                    LOG.WriteLog("StartProcessFromGuid 020.40")
                    Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, TempRestoreFqn, True)
                    LOG.WriteLog("StartProcessFromGuid 020.50")
                    If bSuccess Then
                        LOG.WriteLog("StartProcessFromGuid 020.60")
                        TotalFilesRestored += 1
                        If Not FilesToPreview.Contains(TempRestoreFqn) Then
                            LOG.WriteLog("StartProcessFromGuid 020.70")
                            FilesToPreview.Add(TempRestoreFqn)
                        End If
                        LOG.WriteLog("StartProcessFromGuid 020.80")
                        Dim RetMsg As String = ""
                        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                        LOG.WriteLog("StartProcessFromGuid 020.90")
                        BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                        If BX = False Then
                            LOG.WriteLog("99005: " + MySql)
                        End If
                        LOG.WriteLog("StartProcessFromGuid 020.100")
                        If RetMsg.Trim.Length > 0 Then
                            LOG.WriteLog("StartProcessFromGuid 020.110")
                            LOG.WriteLog("ERROR: 10065: " + RetMsg)
                            TBox.Text = "ERROR: 10065: " + RetMsg
                        End If
                        LOG.WriteLog("StartProcessFromGuid 020.120")
                    End If
                    RestoreFqn = TempRestoreFqn
                    LOG.WriteLog("StartProcessFromGuid 0210")
                Else  '** This is a full RESTORE
                    '** Check to see if the file already exists on the local machine
                    LOG.WriteLog("StartProcessFromGuid 022")
                    Dim FileExistsLocally As Boolean = False

                    If File.Exists(RestoreFqn) Then
                        FileExistsLocally = True
                    End If

                    If bDoNotOverwriteExistingFile And FileExistsLocally Then
                        LOG.WriteLog("StartProcessFromGuid 023")
                        '* Do nothing, it exists
                        Dim RetMsg As String = ""
                        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                        BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                        If BX = False Then
                            LOG.WriteLog("99006: " + MySql)
                        End If
                        If RetMsg.Trim.Length > 0 Then
                            LOG.WriteLog("ERROR: 10066: " + RetMsg)
                            TBox.Text = "ERROR: 10066: " + RetMsg
                        End If
                        TotalFilesRestored += 1
                        GoTo SkipFile
                    ElseIf bRestoreToMyDocuments Then
                        LOG.WriteLog("StartProcessFromGuid 024")
                        'Dim FN As New FileInfo(RestoreFqn)
                        'Dim fName As String = FN.Name
                        'Dim tDir As String = LOG.getRestoreDirContent
                        ''RestoreFqn = tDir + "\" + fName
                        'FN = Nothing
                        Dim MyDocDir As String = RestoreFqn

                        If File.Exists(MyDocDir) Then
                            LOG.WriteLog("StartProcessFromGuid 025")
                            Dim RetMsg As String = ""
                            Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                            BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                            If BX = False Then
                                LOG.WriteLog("99007: " + MySql)
                            End If
                            If RetMsg.Trim.Length > 0 Then
                                LOG.WriteLog("ERROR: 10067: " + RetMsg)
                                TBox.Text = "ERROR: 10067: " + RetMsg
                            End If

                            TotalFilesRestored += 1
                            GoTo SkipFile
                        End If

                        'Dim BB As Boolean = LOG.CreateDirIfMissing(tDir)
                        'If Not BB Then
                        '    TBox.Text = "Could not create directory " + RestoreFqn + ", skipping file.")
                        '    GoTo SkipFile
                        'End If
                        LOG.WriteLog("StartProcessFromGuid 026")
                        Dim TempRestoreFqn As String = RestoreFqn
                        ProxyDownload.writeImageSourceDataFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                        If Not FilesToPreview.Contains(RestoreFqn) Then
                            FilesToPreview.Add(RestoreFqn)
                        End If
                        If RC Then
                            If BinaryFile.Length = 0 Then
                                LOG.WriteLog("StartProcessFromGuid 027")
                                TBox.Text = "It appears the Document did not download, please try again - aborting preview."
                                Return
                            End If
                            BinaryFile = Decompress(BinaryFile)
                        Else
                            LOG.WriteLog("StartProcessFromGuid 028")
                            'TBox.Text = "ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            Clipboard.Clear()
                            Clipboard.SetText("ERROR 100: Failed to download Content - " + rMsg)
                        End If

                        'writeByteArrayToFile(BinaryFile, MyDocDir, True)
                        Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, MyDocDir, True)
                        If bSuccess Then
                            TotalFilesRestored += 1
                            Dim RetMsg As String = ""
                            Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                            BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                            If BX = False Then
                                LOG.WriteLog("99008A: " + MySql)
                            End If
                            If RetMsg.Trim.Length > 0 Then
                                LOG.WriteLog("ERROR: 10068a1: " + RetMsg)
                                TBox.Text = "ERROR: 10068a: " + RetMsg
                            End If
                        End If
                    ElseIf bOverwriteExistingFile Then
                        LOG.WriteLog("StartProcessFromGuid 030")
                        Dim TempRestoreFqn As String = RestoreFqn
                        ProxyDownload.writeImageSourceDataFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                        If Not FilesToPreview.Contains(RestoreFqn) Then
                            FilesToPreview.Add(RestoreFqn)
                        End If
                        If RC Then
                            If BinaryFile.Length = 0 Then
                                TBox.Text = "It appears the Document did not download, please try again - aborting preview."
                                AllIsGood = False
                            End If
                            BinaryFile = Decompress(BinaryFile)
                        Else
                            'TBox.Text = "ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            Clipboard.Clear()
                            Clipboard.SetText("ERROR 200: Failed to download Content - " + rMsg)
                        End If

                        'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                        Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                        If bSuccess Then
                            TotalFilesRestored += 1
                            Dim RetMsg As String = ""
                            Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                            BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                            If BX = False Then
                                LOG.WriteLog("99008: " + MySql)
                            End If
                            If RetMsg.Trim.Length > 0 Then
                                LOG.WriteLog("ERROR: 10068: " + RetMsg)
                                TBox.Text = "ERROR: 10068: " + RetMsg
                            End If
                        End If
                    End If
                    'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                End If

            End If
SkipFile:
        Next

UseExistingFile:
        LOG.WriteLog("StartProcessFromGuid 031")
        If isPreview And RestoreFqn.Length > 0 Then
            LOG.WriteLog("StartProcessFromGuid 032")
            Try
                For Each FQN As String In FilesToPreview
                    Try
                        Process.Start(FQN)
                        GC.Collect()
                        GC.WaitForFullGCComplete()
                    Catch ex As Exception
                        MessageBox.Show("Failed to open: " + FQN)
                    End Try

                Next
                MessageBox.Show("Close when finished previewing files and all will be removed from your hard drive.")
                cleanTempWorkingDir(RestoreDir)
            Catch ex As Exception
                TBox.Text = "Failed to open file for viewing, will attempt to open using Notepad."
                LOG.WriteLog("Failed to open file for viewing: deleted file " + RestoreFqn)
                System.Diagnostics.Process.Start("notepad.exe", FileDirFQN)
                File.Delete(RestoreFqn)
                AllIsGood = False
            End Try
        Else
            Try
                LOG.WriteLog("StartProcessFromGuid 035")
                If TBox Is Nothing Then
                    LOG.WriteLog("StartProcessFromGuid 036")
                Else
                    LOG.WriteLog("StartProcessFromGuid 037")
                    TBox.Text = ("Notice: " + TotalFilesRestored.ToString + " files have been restored to directory- '" + gDownloadDIR + "'.")
                End If
            Catch ex As Exception
                Console.WriteLine("Notice: " + TotalFilesRestored.ToString + " files have been restored to directory- '" + gDownloadDIR + "'.")
            End Try

        End If

        'If AllIsGood Then
        '    File.Delete(FileDirFQN)
        'Else
        '    MessageBox.Show("The file, for whatever reason, " + FileDirFQN + " was not found and will be removed from the process list.")
        '    If File.Exists(FileDirFQN) Then
        '        File.Delete(FileDirFQN)
        '        File.Delete(RestoreFqn)
        '    End If
        'End If

        frmEcmDownload.PB.Value = 0
        frmEcmDownload.PB.Visible = False

    End Sub

    Public Sub cleanTempWorkingDir(ByVal DirToClean As String)
        Dim FilterList As New List(Of String)
        Dim Files As List(Of FileInfo) = Nothing
        Dim IncludeSubDir As Boolean = False
        Dim FI As FileInfo
        Dim StartTime As DateTime
        Dim ElapsedTime As TimeSpan

        Dim NbrOdDaysToKeep As Integer = 0

        FilterList.Add("*.*")
        Files = GetFilesRecursive(DirToClean, FilterList)

        For Each FI In Files
            Try
                Dim CreateDate As Date = FI.CreationTime
                StartTime = Now
                ElapsedTime = Now().Subtract(CreateDate)
                Dim iDays As Integer = CInt(ElapsedTime.TotalDays)
                If iDays >= NbrOdDaysToKeep Then
                    FI.Delete()
                End If
            Catch ex As Exception
                Console.WriteLine("Failed to delete:" + FI.Name)
            End Try
        Next

        FI = Nothing
        GC.Collect()
    End Sub

    Public Function GetFilesRecursive(ByVal initial As String, ByVal FilterList As List(Of String)) As List(Of FileInfo)
        ' This list stores the results.
        Dim result As New List(Of FileInfo)

        ' This stack stores the directories to process.
        Dim stack As New Stack(Of String)

        ' Add the initial directory
        stack.Push(initial)

        ' Continue processing for each stacked directory
        Do While (stack.Count > 0)
            ' Get top directory string
            Application.DoEvents()
            Dim dir As String = stack.Pop
            Try
                ' Add all immediate file paths
                result.AddRange(GetFiles(dir, FilterList))

                ' Loop through all subdirectories and add them to the stack.
                Dim directoryName As String
                For Each directoryName In Directory.GetDirectories(dir)
                    stack.Push(directoryName)
                Next
            Catch ex As Exception
            End Try
        Loop

        ' Return the list
        Return result
    End Function

    Public Function GetFiles(ByVal Path As String, ByVal FilterList As List(Of String)) As List(Of FileInfo)
        Dim d As New DirectoryInfo(Path)
        Dim files As List(Of FileInfo) = New List(Of FileInfo)
        'Iterate through the FilterList
        For Each Filter As String In FilterList
            'the files are appended to the file array
            Application.DoEvents()
            files.AddRange(d.GetFiles(Filter))
        Next
        Return (files)
    End Function

    Public Sub StartProcessFromFilefqn(ByVal fqn As String, ByVal IsThisApreview As Boolean, SessionID As String)

        Dim bContinue As Boolean = True
        Dim FI2 As New FileInfo(fqn)
        If FI2.Name.Equals("CLC.RUNNING") Then
            bContinue = False
        End If
        FI2 = Nothing

        'ECM.Preview.CURR
        Dim FI3 As New FileInfo(fqn)
        If FI3.Name.Equals("ECM.Preview.CURR") Then
            bContinue = False
        End If
        FI3 = Nothing
        'SAAS.RUNNING
        Dim FI4 As New FileInfo(fqn)
        If FI4.Name.Equals("SAAS.RUNNING") Then
            bContinue = False
        End If
        FI4 = Nothing

        If bContinue = False Then
            GC.Collect()
            Return
        End If

        If Not Directory.Exists(LOG.getRestoreDirEmail) Then
            Directory.CreateDirectory(LOG.getRestoreDirEmail)
        End If

        Dim bWarmingSet As Boolean = False

        'EMAILþ302dcfbf-3ad2-4f5f-8107-a311772af027
        '** Open and read the temp file's data here
        Dim ProcessCode As String = ""
        Dim SourceGuid As String = ""
        Dim RestoreFqn As String = ""
        Dim BinaryFile As Byte() = Nothing
        Dim SourceTypeCode As String = ""
        Dim OriginalSize As Integer = 0
        Dim CompressedSize As Integer = 0
        Dim RC As Boolean = False
        Dim rMsg As String = ""
        Dim TempRestoreFileFqn As String = fqn

        Dim AllIsGood As Boolean = True
        Dim F2Process As New FilesToProcess
        Dim lFileToProcess As New List(Of FilesToProcess)

        Try
            Dim sFileName As String
            Dim srFileReader As System.IO.StreamReader
            Dim sInputLine As String
            Dim A() As String
            sFileName = fqn
            srFileReader = System.IO.File.OpenText(sFileName)
            sInputLine = srFileReader.ReadLine()
            Do Until sInputLine Is Nothing
                F2Process = New FilesToProcess
                If Not sInputLine.Contains(ChrW(254)) Then
                    GoTo SKIPTHISFILE
                End If
                A = sInputLine.Split(ChrW(254))
                If IsThisApreview Then
                    ProcessCode = A(0)
                    SourceGuid = A(1)
                    Try
                        RestoreFqn = A(2)
                    Catch ex As Exception
                        Exit Do
                    End Try
                    System.Console.WriteLine(sInputLine)
                    Try
                        F2Process.pRepoTableName = A(0)
                        F2Process.CurrentGuid = A(1)
                        F2Process.FileExt = A(2)
                        F2Process.FileFQN = A(2)
                        lFileToProcess.Add(F2Process)
                    Catch ex As Exception
                        GoTo SKIPTHISFILE
                    End Try
                Else
                    'S += pRepoTableName.ToUpper
                    'S += ChrW(254) + CurrentGuid
                    'S += ChrW(254) + FileExt
                    'S += ChrW(254) + FileFQN
                    'S += ChrW(254) + gDoNotOverwriteExistingFile.ToString
                    'S += ChrW(254) + gOverwriteExistingFile.ToString
                    'S += ChrW(254) + gRestoreToOriginalDirectory.ToString
                    'S += ChrW(254) + gRestoreToMyDocuments.ToString
                    'S += ChrW(254) + gCreateOriginalDirIfMissing.ToString
                    Try
                        F2Process.pRepoTableName = A(0)
                        F2Process.CurrentGuid = A(1)
                        F2Process.FileExt = A(2)
                        F2Process.FileFQN = A(3)
                        System.Console.WriteLine(sInputLine)
                        F2Process.bDoNotOverwriteExistingFile = CBool(A(4))
                        F2Process.bOverwriteExistingFile = CBool(A(5))
                        F2Process.bRestoreToOriginalDirectory = CBool(A(6))
                        F2Process.bRestoreToMyDocuments = CBool(A(7))
                        'bCreateOriginalDirIfMissing = CBool(A(8))
                        F2Process.bCreateOriginalDirIfMissing = True
                        lFileToProcess.Add(F2Process)
                        If F2Process.pRepoTableName.Equals("EMAIL") Then
                            F2Process.FileFQN = "Email." + F2Process.CurrentGuid + "." + F2Process.FileExt
                        End If
                    Catch ex As Exception
                        GoTo SKIPTHISFILE
                    End Try

                End If
SKIPTHISFILE:
                sInputLine = srFileReader.ReadLine()
            Loop
            srFileReader.Close()
            srFileReader.Dispose()
        Catch ex As Exception
            'MessageBox.Show("ERROR 10.1a: Failed to open the prefiew file, aborting.")
            LOG.WriteLog("ERROR 10.1a: Failed to open the prefiew file, aborting.")
            AllIsGood = False
            Return
        End Try
        '** Split out the TABLE and the GUID

        If lFileToProcess.Count > 0 Then
            frmEcmDownload.PB.Visible = True
            frmEcmDownload.PB.Maximum = lFileToProcess.Count + 1
        End If

        Dim LoopCnt As Integer = 0

        For Each F2Process In lFileToProcess
            BinaryFile = Nothing
            ProcessCode = F2Process.pRepoTableName
            Dim sGuid As String = F2Process.CurrentGuid
            Dim sFileName As String = F2Process.FileFQN
            LoopCnt += 1
            frmEcmDownload.PB.Value = LoopCnt
            frmEcmDownload.PB.Refresh()
            Application.DoEvents()
            If ProcessCode.Equals("EMAIL") Then

                FilesCurrentlyDownloaded += 1
                frmEcmDownload.FilesDownloaded = FilesCurrentlyDownloaded
                frmEcmDownload.lblNbrDownloadsProcessed.Text = FilesCurrentlyDownloaded.ToString

                SourceGuid = F2Process.CurrentGuid
                SourceTypeCode = F2Process.FileExt

                RestoreFqn = "EMAIL." + SourceGuid + "." + SourceTypeCode
                Dim TempDir As String = ""
                If IsThisApreview Then
                    TempDir = LOG.getTempEnvironDir() + RestoreFqn
                Else
                    TempDir = LOG.getRestoreDirEmail + "\" + RestoreFqn
                End If
                RestoreFqn = TempDir

                If File.Exists(RestoreFqn) Then
                    GoTo SkipFile
                End If
                If gEncCS.Length = 0 Then
                    SetActiveEndPoints(LB1, LB2)
                End If
                '** Download the email, unzip in memory, convert it to a file
                ProxyDownload.writeEmailFromDbToFile(gEncCS, SourceGuid, SourceTypeCode, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                If RC Then
                    If BinaryFile.Length = 0 Then
                        TM.Show("It appears the EMAIL did not download, please try again - aborting preview.")
                        Return
                    End If
                    CompressedSize = BinaryFile.Length
                    BinaryFile = Decompress(BinaryFile)
                    OriginalSize = BinaryFile.Length
                    RestoreFqn = "EMAIL." + SourceGuid + "." + SourceTypeCode
                    TempDir = ""
                    If IsThisApreview Then
                        TempDir = LOG.getTempEnvironDir() + RestoreFqn
                    Else
                        TempDir = LOG.getRestoreDirEmail + "\" + RestoreFqn
                    End If
                    RestoreFqn = TempDir
                    '** Check to see if the file already exists on the local machine
                    If File.Exists(RestoreFqn) Then
                        GoTo SkipFile
                    End If
                    'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                    Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                    If bSuccess Then
                        Dim RetMsg As String = ""
                        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                        BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                        If BX = False Then
                            LOG.WriteLog("99009: " + MySql)
                        End If
                        If RetMsg.Trim.Length > 0 Then
                            LOG.WriteLog("ERROR: 10069: " + RetMsg)
                        End If
                    End If
                Else
                    'TM.Show("ERROR Message in Clipboard: Failed to download EMAIL - " + rMsg)
                    LOG.WriteLog("ERROR Message in Clipboard: Failed to download EMAIL - " + rMsg)
                    Clipboard.Clear()
                    Clipboard.SetText("ERROR: Failed to download EMAIL - " + rMsg)
                    AllIsGood = False
                End If
            ElseIf ProcessCode.Equals("EMAILATTACHMENT") Then

                FilesCurrentlyDownloaded += 1
                frmEcmDownload.FilesDownloaded = FilesCurrentlyDownloaded
                frmEcmDownload.lblNbrDownloadsProcessed.Text = FilesCurrentlyDownloaded.ToString

                SourceGuid = F2Process.CurrentGuid
                RestoreFqn = F2Process.FileFQN
                ProxyDownload.writeAttachmentFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                If RC Then
                    If BinaryFile.Length = 0 And OriginalSize > 0 Then
                        TM.Show("It appears the EMAIL ATTACHMENT did not download, please try again - aborting preview.")
                        'AllIsGood = False
                    Else
                        BinaryFile = Decompress(BinaryFile)
                    End If
                Else
                    AllIsGood = False
                    LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                    'TM.Show("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                    'Clipboard.Clear()
                    'Clipboard.SetText("ERROR 300: Failed to download Content - " + rMsg)
                End If

                Dim TempDir As String = ""
                If IsThisApreview Then
                    TempDir = LOG.getTempEnvironDir + RestoreFqn
                Else
                    TempDir = LOG.getRestoreDirPreview + RestoreFqn
                End If

                RestoreFqn = TempDir
                '** Check to see if the file already exists on the local machine
                If File.Exists(RestoreFqn) Then
                    Dim msg$ = "This file exists on your local computer, " + vbCrLf
                    msg += "would you like to view that one? " + vbCrLf
                    msg += "    (or NO to download from the repository.)"
                    Dim dlgRes As DialogResult = MessageBox.Show(msg, "Display Existing File", MessageBoxButtons.YesNo)
                    If dlgRes = Windows.Forms.DialogResult.Yes Then
                        GoTo SkipFile
                    End If
                End If
                'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                If bSuccess Then
                    Dim RetMsg As String = ""
                    Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                    BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                    If BX = False Then
                        LOG.WriteLog("99010: " + MySql)
                    End If
                    If RetMsg.Trim.Length > 0 Then
                        LOG.WriteLog("ERROR: 10061: " + RetMsg)
                    End If
                End If
            Else
                FilesCurrentlyDownloaded += 1
                frmEcmDownload.FilesDownloaded = FilesCurrentlyDownloaded
                frmEcmDownload.lblNbrDownloadsProcessed.Text = FilesCurrentlyDownloaded.ToString

                SourceGuid = F2Process.CurrentGuid
                RestoreFqn = F2Process.FileFQN
                If InStr(RestoreFqn, "http://", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                    '** This is a WEB based file
                    RestoreFqn = getWebFileName(RestoreFqn)
                    RestoreFqn = LOG.getRestoreDirContent + "\" + RestoreFqn
                    F2Process.FileFQN = RestoreFqn
                End If
                If InStr(RestoreFqn, "https://", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                    '** This is a WEB based file
                    RestoreFqn = getWebFileName(RestoreFqn)
                    RestoreFqn = LOG.getRestoreDirContent + "\" + RestoreFqn
                    F2Process.FileFQN = RestoreFqn
                End If
                bCreateOriginalDirIfMissing = F2Process.bCreateOriginalDirIfMissing
                bDoNotOverwriteExistingFile = F2Process.bDoNotOverwriteExistingFile
                bOverwriteExistingFile = F2Process.bOverwriteExistingFile
                bRestoreToMyDocuments = F2Process.bRestoreToMyDocuments
                bRestoreToOriginalDirectory = F2Process.bRestoreToOriginalDirectory
                FileExt = F2Process.FileExt

                If bCreateOriginalDirIfMissing Then
                    Dim FN As String = ""
                    Dim DN As String = ""
                    Try
                        Dim FI As New FileInfo(RestoreFqn)

                        Dim F As File
                        FN = FI.Name
                        DN = FI.DirectoryName

                        If Not Directory.Exists(DN) Then
                            Directory.CreateDirectory(DN)
                        End If

                        FI = Nothing
                        FN = Nothing
                        DN = Nothing
                        F = Nothing
                    Catch ex As Exception
                        If bWarmingSet = False Then
                            bWarmingSet = True
                            TM.Show("The original directory " + DN + " could not be created, using MyDocuments for these files.")
                        End If

                        Console.WriteLine(ex.Message)
                        bRestoreToMyDocuments = True
                        bCreateOriginalDirIfMissing = False

                    End Try
                End If

                If IsThisApreview Then
                    '** Check to see if the file already exists on the local machine
                    If File.Exists(RestoreFqn) Then
                        Dim msg$ = "This file exists on your local computer, " + vbCrLf
                        msg += "would you like to view that one? " + vbCrLf
                        msg += "    (or NO to download from the repository.)"
                        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Display Existing File", MessageBoxButtons.YesNo)
                        If dlgRes = Windows.Forms.DialogResult.Yes Then
                            GoTo SkipFile
                        End If
                    Else
                        Dim FN1 As New FileInfo(RestoreFqn)
                        Dim fName1 As String = FN1.Name
                        Dim tDir1 As String = LOG.getTempEnvironDir
                        '** It is a "preview" use the TEMP directory for download.
                        RestoreFqn = tDir1 + fName1
                        FN1 = Nothing
                    End If
                    Dim TempRestoreFqn As String = RestoreFqn
                    ProxyDownload.writeImageSourceDataFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                    If RC Then
                        If BinaryFile.Length = 0 Then
                            TM.Show("It appears the Document did not download, please try again - aborting preview.")
                            Return
                        End If
                        BinaryFile = Decompress(BinaryFile)
                    Else
                        LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                        Clipboard.Clear()
                        Clipboard.SetText("ERROR: Failed to download Content - " + rMsg)
                    End If

                    'writeByteArrayToFile(BinaryFile, TempRestoreFqn, True)
                    Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, TempRestoreFqn, True)
                    If bSuccess Then
                        Dim RetMsg As String = ""
                        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                        BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                        If BX = False Then
                            LOG.WriteLog("99011: " + MySql)
                        End If
                        If RetMsg.Trim.Length > 0 Then
                            LOG.WriteLog("ERROR: 10061: " + RetMsg)
                        End If
                    End If
                    RestoreFqn = TempRestoreFqn
                Else  '** This is a full RESTORE
                    '** Check to see if the file already exists on the local machine
                    Dim FileExistsLocally As Boolean = False

                    If File.Exists(RestoreFqn) Then
                        FileExistsLocally = True
                    End If

                    If bDoNotOverwriteExistingFile And FileExistsLocally Then
                        '* Do nothing, it exists
                        GoTo SkipFile
                    ElseIf bRestoreToMyDocuments Then
                        Dim FN As New FileInfo(RestoreFqn)
                        Dim fName As String = FN.Name
                        Dim tDir As String = LOG.getRestoreDirContent
                        RestoreFqn = tDir + "\" + fName
                        FN = Nothing
                        Dim MyDocDir As String = RestoreFqn

                        If File.Exists(MyDocDir) Then
                            GoTo SkipFile
                        End If

                        Dim BB As Boolean = LOG.CreateDirIfMissing(tDir)
                        If Not BB Then
                            TM.Show("Could not create directory " + RestoreFqn + ", skipping file.")
                            GoTo SkipFile
                        End If

                        Dim TempRestoreFqn As String = RestoreFqn
                        ProxyDownload.writeImageSourceDataFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                        If RC Then
                            If BinaryFile.Length = 0 Then
                                TM.Show("It appears the Document did not download, please try again - aborting preview.")
                                Return
                            End If
                            BinaryFile = Decompress(BinaryFile)
                        Else
                            'TM.Show("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            Clipboard.Clear()
                            Clipboard.SetText("ERROR 100: Failed to download Content - " + rMsg)
                        End If

                        'writeByteArrayToFile(BinaryFile, MyDocDir, True)
                        Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, MyDocDir, True)
                        If bSuccess Then
                            Dim RetMsg As String = ""
                            Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                            BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, , SessionID)
                            If BX = False Then
                                LOG.WriteLog("99012: " + MySql)
                            End If
                            If RetMsg.Trim.Length > 0 Then
                                LOG.WriteLog("ERROR: 10061: " + RetMsg)
                            End If
                        End If
                    ElseIf bOverwriteExistingFile Then

                        Dim TempRestoreFqn As String = RestoreFqn
                        ProxyDownload.writeImageSourceDataFromDbWriteToFile(gEncCS, SourceGuid, RestoreFqn, BinaryFile, OriginalSize, CompressedSize, RC, rMsg)
                        If RC Then
                            If BinaryFile.Length = 0 Then
                                TM.Show("It appears the Document did not download, please try again - aborting preview.")
                                AllIsGood = False
                            End If
                            BinaryFile = Decompress(BinaryFile)
                        Else
                            'TM.Show("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            LOG.WriteLog("ERROR Message in Clipboard: Failed to download Content - " + rMsg)
                            Clipboard.Clear()
                            Clipboard.SetText("ERROR 200: Failed to download Content - " + rMsg)
                        End If

                        'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                        Dim bSuccess As Boolean = writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                        If bSuccess Then
                            Dim RetMsg As String = ""
                            Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + gCurrentUserID + "'"
                            BX = ProxyDownload.ExecuteSqlNewConn(gSecureID, gCurrentUserID, MySql, RetMsg, SessionID)
                            If BX = False Then
                                LOG.WriteLog("99013: " + MySql)
                            End If
                            If RetMsg.Trim.Length > 0 Then
                                LOG.WriteLog("ERROR: 10061: " + RetMsg)
                            End If
                        End If
                    End If
                    'writeByteArrayToFile(BinaryFile, RestoreFqn, True)
                End If

            End If
SkipFile:
        Next

UseExistingFile:
        If IsThisApreview And RestoreFqn.Length > 0 Then
            Try
                Process.Start(RestoreFqn)
                GC.Collect()
                GC.WaitForFullGCComplete()
            Catch ex As Exception
                TM.Show("Failed to open file for viewing, will attempt to open using Notepad.")
                LOG.WriteLog("Failed to open file for viewing: deleted file " + RestoreFqn)
                System.Diagnostics.Process.Start("notepad.exe", fqn)
                File.Delete(RestoreFqn)
                AllIsGood = False
            End Try
        End If

        If AllIsGood Then
            File.Delete(fqn)
        Else
            MessageBox.Show("The file, for whatever reason, " + fqn + " was not found and will be removed from the process list.")
            If File.Exists(fqn) Then
                File.Delete(fqn)
                File.Delete(RestoreFqn)
            End If
        End If

        frmEcmDownload.PB.Value = 0
        frmEcmDownload.PB.Visible = False

    End Sub

    Sub readPreviewFile(ByVal FQN As String)

        Dim sFileName As String
        Dim srFileReader As System.IO.StreamReader
        Dim sInputLine As String

        sFileName = FQN
        srFileReader = System.IO.File.OpenText(sFileName)
        sInputLine = srFileReader.ReadLine()
        Do Until sInputLine Is Nothing
            System.Console.WriteLine(sInputLine)
            sInputLine = srFileReader.ReadLine()
        Loop

    End Sub

    Function FindIsolatedDirectoryPath(ByVal tgtDir As String, ByRef IsoDir As String) As String
        Dim SL_Path As String = ""
        Dim tempPath As String = System.IO.Path.GetTempPath
        Dim I As Integer = InStr(tempPath, "AppData")
        If I > 0 Then
            SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
        Else
            Return ""
        End If

        Dim nameOfDirectory As String = SL_Path

        nameOfDirectory = gCLCDIR

        If nameOfDirectory.Length = 0 Then
            nameOfDirectory = SL_Path
        End If

        Dim myDirectory As DirectoryInfo
        myDirectory = New DirectoryInfo(nameOfDirectory)
        Dim PermDirectory As String = ""
        Dim bDirFound As Boolean = False

        Dim FullDirPath As String = FindDirectory(myDirectory, tgtDir, IsoDir, bDirFound)
        Return FullDirPath

    End Function

    Public Function SetActiveEndPoints(LB1 As Label, LB2 As Label)
        'wdmxx
        Dim LL As Decimal = 0
        Dim B As Boolean = False

        Try
            LL = 1
            If (ProxyGateway Is Nothing) Then
                ProxyGateway = New SVC_Gateway.Service1Client
            End If
            LL = 2
            Dim PrevDate As Date = CDate("01/01/1960")
            Dim CurrDate As Date = Nothing
            Dim SL_Path As String = ""
            Dim ActivePath As String = ""
            Dim tempPath As String = System.IO.Path.GetTempPath
            Dim I As Integer = InStr(tempPath, "AppData")
            LL = 3
            If I > 0 Then
                SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
            Else
                Return False
            End If
            LL = 4
            Dim array As New ArrayList
            LL = 5
            RecursiveSearch(fileActive, SL_Path, array)
            LL = 6
            If array.Count > 0 Then
                LL = 7
                gSearchActive = False
                For I = 0 To array.Count - 1
                    LL = 8
                    Dim FI As New FileInfo(array(I))
                    CurrDate = FI.LastWriteTime
                    LL = 9
                    If CurrDate > PrevDate Then
                        LL = 10
                        gCLCDIR = FI.DirectoryName
                        ActivePath = FI.DirectoryName
                        PrevDate = CurrDate
                        LL = 11
                    End If
                    LL = 12
                Next
                LL = 13
            Else
                LL = 14
                gSearchActive = False
            End If
            LL = 15
            Dim RC As Boolean = False
            Dim RetMsg As String = ""
            LL = 16
            If ActivePath.Length > 0 Then
                LL = 17
                Dim FQN As String = System.IO.Path.Combine(ActivePath, fileActive)
                LL = 18
                Dim FI As New StreamReader(FQN)
                Dim S As String = FI.ReadLine
                LL = 19
                FI.Close()
                FI.Dispose()
                LL = 20
                If InStr(S, "|") > 0 Then
                    'currState = CompanyID + "|" + RepoID + "|" + currState.ToUpper + "|" + GVAR._SecureID.ToString + "|" + GVAR.GatewayEndPoint + "|" + GVAR.ENCGWCS
                    LL = 21
                    Dim A() As String = S.Split("|")
                    If (A(0).Length > 0) Then
                        gCompanyID = A(0)
                    End If
                    LL = 22
                    If (A(1).Length > 0) Then
                        gRepoCode = A(1)
                    End If
                    LL = 23
                    If (A(2).Length > 0) Then
                        gCurrState = A(2)
                    End If
                    LL = 24
                    If (A(3).Length > 0) Then
                        Dim SID As String = A(3)
                        gSecureID = Convert.ToInt32(SID)
                    End If
                    LL = 25
                    If (A(4).Length > 0) Then
                        gGatewayEndPoint = A(4)
                        B = True
                    End If
                    LL = 26
                    If (A(5).Length > 0) Then
                        gENCGWCS = A(5)
                    End If
                    LL = 27
                    If (A(6).Length > 0) Then
                        gDownloadEndPoint = A(6)
                    End If
                    LL = 28

                    Dim bSet As Boolean = setGatewayEndpoints(gCompanyID, gRepoCode, gGatewayEndPoint, gDownloadEndPoint)
                    LL = 28.1
                    If bSet = True Then
                        'MessageBox.Show("ENDPOINTS: Gateway: " + gGatewayEndPoint + " / DownLoader: " + gDownloadEndPoint)
                        LB1.Text = gGatewayEndPoint
                        LB2.Text = gDownloadEndPoint
                        LL = 28.4
                    Else
                        'MessageBox.Show("NO ENDPOINTS: Gateway: " + gGatewayEndPoint + " / DownLoader: " + gDownloadEndPoint)
                        LB1.Text = gGatewayEndPoint + " : default"
                        LB2.Text = gDownloadEndPoint + " : default"
                        LL = 28.7
                    End If
                    LL = 29

                    'gSessionID = ProxyGateway.getSessionID(gSecureID, gSystemCurrUserID, "DL")
                    'LL = 30.1
                    'gEncCS = ProxyGateway.getConnection(gCompanyID, gRepoCode, RC, RetMsg, gSystemCurrUserID, gSessionID, "DL")
                    'LL = 30.2
                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                    gSearchActive = True
                    LL = 31
                Else
                    LL = 32
                    gCompanyID = ""
                    gRepoCode = ""
                    gEncCS = ""
                    gSearchActive = False
                    LL = 33
                    MessageBox.Show("Failed to initialize endpoints, please try running ECM Library first.")
                    LL = 34
                    B = False
                End If
                LL = 35
            End If
        Catch ex As Exception
            MessageBox.Show("Loc: " + LL.ToString + " : " + vbCrLf + ex.Message)
        End Try

        Return B
    End Function

    Public Sub setGatewayEndPoint(GWEndPoint As String)

        Dim CurrEndPoint As String = ""

        If gUseConfigEndpoints.Equals(True) Then
            'USE WHAT IS SPECIFIED IN THE SERVICE CONFICURATION
            'CurrEndPoint = "http://localhost:16720/SVCGateway.svc"
            Return
        Else
            CurrEndPoint = GWEndPoint
        End If

        'SecureEndPoint = "http://97.76.174.190/SecureAttachAdminSvc/SVCGateway.svc"
        Dim GWBinding As System.ServiceModel.BasicHttpBinding = New System.ServiceModel.BasicHttpBinding()
        Dim endpoint As System.ServiceModel.EndpointAddress = New System.ServiceModel.EndpointAddress(New Uri(GWEndPoint))
        ProxyGateway = New SVC_Gateway.Service1Client(GWBinding, endpoint)

        'ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(SecureEndPoint)
        'ProxyDownload.Endpoint.Address = New System.ServiceModel.EndpointAddress(DownloadEndPoint)

        LOG.WriteLog("ProxyGateway.Endpoint: " + GWEndPoint)

        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    Public Sub setDownloaderEndPoint(TgtEndPoint As String)

        Dim CurrEndPoint As String = ""

        If gUseConfigEndpoints = True Then
            'USE WHAT IS SPECIFIED IN THE SERVICE CONFICURATION
            'CurrEndPoint = "http://97.76.174.190/SVCclcDownload/SVCclcDownload.svc"
            Return
        Else
            CurrEndPoint = TgtEndPoint
        End If

        If (CurrEndPoint.Length = 0) Then
            Return
        End If

        Dim DLBinding As System.ServiceModel.BasicHttpBinding = New System.ServiceModel.BasicHttpBinding()
        Dim DLEndpoint As System.ServiceModel.EndpointAddress = New System.ServiceModel.EndpointAddress(New Uri(TgtEndPoint))
        ProxyDownload = New SVCclcDownload.Service1Client(DLBinding, DLEndpoint)

        LOG.WriteLog("ProxyDownload.Endpoint: " + TgtEndPoint)

        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

    Public Sub SetActivePreviewPath()

        Dim FilePattern As String = "ECM.Preview.dat"

        gActivePreviewPath = ""
        Dim PrevDate As Date = CDate("01/01/1960")
        Dim CurrDate As Date = Nothing
        Dim SL_Path As String = ""
        Dim ActivePath As String = ""
        Dim tempPath As String = System.IO.Path.GetTempPath
        Dim I As Integer = InStr(tempPath, "AppData")
        If I > 0 Then
            SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
        Else
            Return
        End If
        Dim array As New ArrayList
        RecursiveSearch(filePreview, SL_Path, array)
        If array.Count > 0 Then
            gSearchActive = False
            For I = 0 To array.Count - 1
                Dim FI As New FileInfo(array(I))
                CurrDate = FI.LastWriteTime
                If CurrDate > PrevDate Then
                    gActivePreviewPath = FI.DirectoryName
                End If
            Next
        Else
            gSearchActive = False
        End If

    End Sub

    Public Sub SetActiveRestorePath()

        Dim FilePattern As String = "*.RestoreDat"

        gActivePreviewPath = ""
        Dim PrevDate As Date = CDate("01/01/1960")
        Dim CurrDate As Date = Nothing
        Dim SL_Path As String = ""
        Dim ActivePath As String = ""
        Dim tempPath As String = System.IO.Path.GetTempPath
        Dim I As Integer = InStr(tempPath, "AppData")
        If I > 0 Then
            SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
        Else
            Return
        End If
        Dim array As New ArrayList
        RecursiveSearch(FilePattern, SL_Path, array)
        If array.Count > 0 Then
            gSearchActive = False
            For I = 0 To array.Count - 1
                Dim FI As New FileInfo(array(I))
                CurrDate = FI.LastWriteTime
                If CurrDate > PrevDate Then
                    gActiveRestorePath = FI.DirectoryName
                End If
            Next
        Else
            gSearchActive = False
        End If

    End Sub

    Private Sub RecursiveSearch(ByVal FilePattern As String, ByRef strDirectory As String, ByRef array As ArrayList)
        Dim dirInfo As New IO.DirectoryInfo(strDirectory)
        ' Try to get the files for this directory
        Dim pFileInfo() As IO.FileInfo
        Try
            pFileInfo = dirInfo.GetFiles(FilePattern)
        Catch ex As UnauthorizedAccessException
            MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Exit Sub
        End Try
        ' Add the file infos to the array
        array.AddRange(pFileInfo)
        If pFileInfo.Length > 0 Then
            For i As Integer = 0 To array.Count - 1
                Dim S As String = array(i).ToString
                If InStr(S, ":") > 0 Then
                Else
                    array(i) = strDirectory + "\" + array(i).ToString
                End If
            Next
        End If

        ' Try to get the subdirectories of this one
        Dim pdirInfo() As IO.DirectoryInfo
        Try
            pdirInfo = dirInfo.GetDirectories()
        Catch ex As UnauthorizedAccessException
            MessageBox.Show(ex.Message, "Exception!", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Exit Sub
        End Try
        ' Iterate through each directory and recurse!
        Dim dirIter As IO.DirectoryInfo
        For Each dirIter In pdirInfo
            RecursiveSearch(FilePattern, dirIter.FullName, array)
        Next dirIter
    End Sub

    ''' <summary>
    ''' Finds and Polls the preview directory for an existing file
    ''' </summary>
    ''' <param name="PermDirectory">
    ''' This is set to the directory name when and where a Preview File exists
    ''' </param>
    ''' <param name="bDirFound">    This is set true for a preview, false for a download</param>
    ''' <remarks></remarks>
    Sub ScanPreviewDir(ByRef PermDirectory As String, ByRef bDirFound As Boolean)

        Dim bPreview As Boolean = True
        Dim SL_Path As String = ""
        Dim tempPath As String = System.IO.Path.GetTempPath
        Dim I As Integer = InStr(tempPath, "AppData")
        If I > 0 Then
            SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
        Else
            Return
        End If

        Dim nameOfDirectory As String = SL_Path
        nameOfDirectory = gCLCDIR
        nameOfDirectory = gActivePreviewPath

        Dim myDirectory As DirectoryInfo
        myDirectory = New DirectoryInfo(nameOfDirectory)
        WorkWithDirectory(myDirectory, "EcmPreviewFile", bPreview, PermDirectory, bDirFound)

    End Sub

    ''' <summary>
    ''' Finds and Polls the download directory for an existing file
    ''' </summary>
    ''' <param name="PermDirectory">
    ''' This is set to the directory name when and where a Download File exists
    ''' </param>
    ''' <param name="bDirFound">    This is set true for a preview, false for a download</param>
    ''' <remarks></remarks>
    Sub ScanDownloadDir(ByRef PermDirectory As String, ByRef bDirFound As Boolean)
        Dim bPreview As Boolean = False
        Dim SL_Path As String = ""
        Dim tempPath As String = System.IO.Path.GetTempPath
        Dim I As Integer = InStr(tempPath, "AppData")
        If I > 0 Then
            SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
        Else
            Return
        End If

        Dim nameOfDirectory As String = SL_Path
        nameOfDirectory = gCLCDIR

        nameOfDirectory = nameOfDirectory.Replace("EcmSearchFilter", "EcmRestoreFiles")

        Dim myDirectory As DirectoryInfo
        myDirectory = New DirectoryInfo(nameOfDirectory)
        WorkWithDirectory(myDirectory, "EcmRestoreFiles", bPreview, PermDirectory, bDirFound)
    End Sub

    'Sub ScanPreviewDir(ByVal ParentDir As String)
    '    Dim bDirFound As Boolean = True
    '    Dim bPreview As Boolean = True
    '    Dim nameOfDirectory As String = ParentDir
    '    Dim myDirectory As DirectoryInfo
    '    myDirectory = New DirectoryInfo(nameOfDirectory)
    '    WorkWithDirectory(myDirectory, "EcmPreviewFile", bPreview, ParentDir, bDirFound)
    'End Sub

    'Sub ScanDownloadDir(ByVal ParentDir As String)
    '    Dim bDirFound As Boolean = True
    '    Dim bPreview As Boolean = False
    '    Dim nameOfDirectory As String = ParentDir
    '    Dim myDirectory As DirectoryInfo
    '    myDirectory = New DirectoryInfo(nameOfDirectory)
    '    WorkWithDirectory(myDirectory, "EcmRestoreFiles", bPreview, ParentDir, bDirFound)
    'End Sub

    Sub PreviewFile()
        Dim GuidToDownLoad As String = ""
        'Dim isoStore As IsolatedStorageFile
        'isoStore = IsolatedStorageFile.GetUserStoreForSite

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or
            IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)

        Dim MO As Integer = Today.Month.ToString
        Dim DA As Integer = Today.Day.ToString

        'Dim FormDataFileName As String = MO + "." + DA + "." + ".Preview." + tgtGuid + ".dat"
        'Dim FQN As String = System.IO.Path.Combine(dirPreview, FormDataFileName)

        'If Not isoStore.FileExists(FQN) Then
        '    Return
        'End If

        Dim dirNames() As String = isoStore.GetDirectoryNames("*")
        Dim fileNames() As String = isoStore.GetFileNames("*")
        Dim name As String

        ' List directories currently in this Isolated Storage.
        If dirNames.Length > 0 Then
            For Each name In dirNames
                Console.WriteLine("Directory Name: " & name)
            Next name
        End If

        ' List the files currently in this Isolated Storage. The list represents all users who have
        ' personal preferences stored for this application.
        If fileNames.Length > 0 Then

            For Each name In fileNames
                Console.WriteLine("File Name: " & name)
            Next name
        End If

    End Sub

    Sub RestoreFiles()

    End Sub

    Public Function ReadFilePreviewData(ByVal tgtGuid As String) As String

        Dim GuidToDownLoad As String = ""
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForSite

        Dim MO As Integer = Today.Month.ToString
        Dim DA As Integer = Today.Day.ToString

        Dim FormDataFileName As String = MO + "." + DA + "." + ".Preview." + tgtGuid + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirPreview, FormDataFileName)

        If Not isoStore.FileExists(FQN) Then
            Return False
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, IO.FileMode.Open, IO.FileAccess.Read, isoStore)

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                Try
                    GuidToDownLoad = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                sr.Close()
                sr.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return GuidToDownLoad
    End Function

    Public Function ReadFileRestoreData(ByVal UID As String, ByRef L As List(Of String)) As Boolean

        Dim FilePattern As String = "*.RestoreDat"
        Dim array As New ArrayList
        RecursiveSearch(FilePattern, dirRestore, array)

        Dim B As Boolean = True
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForSite

        Dim FormDataFileName As String = "Restore." + ".dat"
        Dim FQN As String = System.IO.Path.Combine(dirRestore, FormDataFileName)

        If Not isoStore.FileExists(FQN) Then
            Return False
        End If

        'Dim Buffer() As Byte
        Dim tgtLine As String = ""

        Dim p = New IsolatedStorageFileStream(FQN, IO.FileMode.Open, IO.FileAccess.Read, isoStore)

        Using isoStore
            'Load form data
            Dim filePath As String = System.IO.Path.Combine(dirFormData, FormDataFileName)
            'Check to see if file exists before proceeding
            Dim fLen As Integer = 0
            'If isoStore.FileExists(filePath) Then
            '    fLen = isoStore.fil
            'End If
            Using sr As StreamReader = New StreamReader(isoStore.OpenFile(filePath, FileMode.Open, FileAccess.Read))
                Dim FileToRestore As String = ""
                Try
                    FileToRestore = sr.ReadLine()
                Catch ex As Exception
                    Return True
                End Try
                Dim II As Integer = 0
                Do While Not sr.EndOfStream
                    II += 1
                    If II > 100 Then
                        Exit Do
                    End If
                    If FileToRestore.Trim.Length > 0 Then
                        Dim A() As String = FileToRestore.Split(ChrW(254))
                        Dim tKey As String = A(0)
                        Dim tValue As String = A(1)
                        If L.Contains(FileToRestore) Then
                        Else
                            L.Add(FileToRestore)
                        End If
                        FileToRestore = sr.ReadLine()
                    End If
                Loop
                sr.Close()
                sr.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return B
    End Function

    ''' <summary>
    ''' Compresses the passed in buffer into a byte array and passes it back.
    ''' </summary>
    ''' <param name="BufferToCompress">Pass in a byte array to compress it.</param>
    ''' <returns>Compressed byte array</returns>
    ''' <remarks></remarks>
    Public Function Compress(ByVal BufferToCompress As Byte()) As Byte()
        Dim ms As New MemoryStream()
        Dim zip As New GZipStream(ms, CompressionMode.Compress, True)
        zip.Write(BufferToCompress, 0, BufferToCompress.Length)
        zip.Close()
        ms.Position = 0

        Dim outStream As New MemoryStream()

        Dim compressed As Byte() = New Byte(ms.Length - 1) {}
        ms.Read(compressed, 0, compressed.Length)

        Dim gzBuffer As Byte() = New Byte(compressed.Length + 3) {}
        Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length)
        Buffer.BlockCopy(BitConverter.GetBytes(BufferToCompress.Length), 0, gzBuffer, 0, 4)
        Return gzBuffer
    End Function

    ''' <summary>
    ''' Decompresses the passed in buffer into a byte array and passes it back.
    ''' </summary>
    ''' <param name="BufferToDecompress">Pass in a byte array to decompress it.</param>
    ''' <returns>Decompressed byte array</returns>
    ''' <remarks></remarks>
    Public Function Decompress(ByVal BufferToDecompress As Byte()) As Byte()

        If BufferToDecompress Is Nothing Then
            Return BufferToDecompress
        End If
        If BufferToDecompress.Length = 0 Then
            Return BufferToDecompress
        End If
        Dim ms As New MemoryStream()
        Dim msgLength As Integer = BitConverter.ToInt32(BufferToDecompress, 0)
        ms.Write(BufferToDecompress, 4, BufferToDecompress.Length - 4)

        Dim buffer As Byte() = New Byte(msgLength - 1) {}

        ms.Position = 0
        Dim zip As New GZipStream(ms, CompressionMode.Decompress)
        zip.Read(buffer, 0, buffer.Length)

        Return buffer
    End Function

    Function writeByteArrayToFile(ByVal BinaryFile() As Byte, ByVal FQN As String, ByVal OverWrite As Boolean) As Boolean

        Dim B As Boolean = True

        Try

            If BinaryFile.Length = 0 Then
                Return False
            End If

            Dim K As Long
            K = UBound(BinaryFile)
            Try
                Dim fs As New FileStream(FQN, FileMode.Create, FileAccess.Write)
                '** Dale trys magic - add one extra byte to the read
                fs.Write(BinaryFile, 0, K + 1)
                fs.Close()
                fs = Nothing
            Catch ex As Exception
                LOG.WriteLog("clsDownload : writeByteArrayToFile : 4749 : " + ex.Message + vbCrLf + ex.StackTrace)
            End Try

            GC.Collect()
        Catch ex As Exception
            Dim AppName$ = ex.Source
            LOG.WriteLog("clsDownload : writeByteArrayToFile : 4757 : " + ex.Message)
        End Try
        Return B

    End Function

    Function getWebFileName(ByVal FQN As String) As String
        Dim S As String = FQN
        For I As Integer = S.Length To 1 Step -1
            Dim Ch As String = Mid(S, I, 1)
            If Ch.Equals("/") Then
                S = Mid(S, I + 1)
                Exit For
            End If
        Next
        Return S
    End Function

    Sub SetCLC_State(ByVal TgtDirectory As String, ByVal CurrState As String)

        If gCLCDIR.Length = 0 Then
            CLCDIR = FindIsolatedDirectoryPath(dirCLC, "")
        End If

        If gCLCDIR.Length = 0 Then
            Return
        End If

        Dim tDir = gCLCDIR

        If tDir.Length > 0 Then
            Try
                Dim FILE_NAME As String = TgtDirectory + "\CLC.RUNNING"
                If System.IO.File.Exists(FILE_NAME) And CurrState = "OFF" Then
                    If File.Exists(FILE_NAME) Then
                        File.Delete(FILE_NAME)
                    End If
                End If
                'If Not System.IO.File.Exists(FILE_NAME) And CurrState = "ON" Then
                If CurrState = "ON" Then
                    Dim objWriter As New System.IO.StreamWriter(FILE_NAME)
                    objWriter.Write("ACTIVE")
                    objWriter.Close()
                    objWriter.Dispose()
                    GC.Collect()
                End If
            Catch ex As IOException
                MsgBox(ex.ToString)
            End Try

        End If
    End Sub

    Sub FindCLC()

        If gCLCDIR.Length = 0 Then
            CLCDIR = FindIsolatedDirectoryPath(dirCLC, "")
        End If

        If gCLCDIR.Length = 0 Then
            Return
        End If

        Dim tDir = gCLCDIR

        If tDir.Length > 0 Then
            Try
                Dim FILE_NAME As String = gCLCDIR + "\CLC.RUNNING"

                If System.IO.File.Exists(FILE_NAME) = True Then
                    Dim objWriter As New System.IO.StreamWriter(FILE_NAME)
                    objWriter.Write("ACTIVE")
                    objWriter.Close()
                    objWriter.Dispose()
                    GC.Collect()

                    If File.Exists(FILE_NAME) Then
                        File.Delete(FILE_NAME)
                    End If
                End If
            Catch ex As IOException
                MsgBox(ex.ToString)
            End Try

        End If
    End Sub

    Function findRegisterCLC(ByVal UID As String) As String
        Dim S As String = ""

        CLCDIR = FindIsolatedDirectoryPath(dirCLC, "")
        Dim tDir = gCLCDIR

        If tDir.Length > 0 Then
            Try
                Dim FILE_NAME As String = gCLCDIR + "\CLC.RUNNING"
                S = FILE_NAME
            Catch ex As IOException
                MsgBox(ex.ToString)
            End Try

        End If
        Return S
    End Function

    Function RegisterCLC(ByVal UID As String) As String
        Dim S As String = ""

        If gCLCDIR.Length > 0 Then
            CLCDIR = gCLCDIR
        Else
            CLCDIR = FindIsolatedDirectoryPath(dirCLC, "")
        End If

        Dim tDir = gCLCDIR
        'gCLCDIR = CLCDIR

        If tDir.Length > 0 Then
            Try
                Dim FILE_NAME As String = gCLCDIR + "\CLC.RUNNING"
                Dim objWriter As New System.IO.StreamWriter(FILE_NAME)
                objWriter.Write("ACTIVE")
                objWriter.Close()
                objWriter.Dispose()
                S = FILE_NAME
            Catch ex As IOException
                MsgBox(ex.ToString)
            End Try

        End If
        Return S
    End Function

    Function deleteIsoDir(ByVal TgtDir As String) As String
        Dim B As Boolean = False
        Dim FileName As String = "CLC.RUNNING"
        Dim FQN As String = System.IO.Path.Combine(dirCLC, "*.*")
        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetUserStoreForSite
        If isoStore.DirectoryExists(TgtDir) Then
            isoStore.DeleteDirectory(TgtDir)
        End If
        isoStore.Dispose()
        Return B
    End Function

    Function getIsolatedDirectoryPath() As String
        Dim SL_Path As String = ""
        Try
            Dim tempPath As String = System.IO.Path.GetTempPath
            Dim I As Integer = InStr(tempPath, "AppData")
            If I > 0 Then
                SL_Path = tempPath.Substring(0, I + 7) + "LocalLow\Microsoft\Silverlight"
            Else
                Return ""
            End If
        Catch ex As Exception
            SL_Path = ""
        End Try

        Return SL_Path

    End Function

    ''' <summary>
    ''' Recursive Directory Processing
    ''' </summary>
    ''' <remarks></remarks>
    Sub PurgeExistingRunningFiles()
        Dim nameOfDirectory As String = getIsolatedDirectoryPath()
        Dim myDirectory As DirectoryInfo
        myDirectory = New DirectoryInfo(nameOfDirectory)
        ProcessRecursiveDirectory(myDirectory)
        SetCLC_State(gCLCDIR, "OFF")
    End Sub

    Private Sub ProcessRecursiveDirectory(ByVal aDir As DirectoryInfo)
        Dim nextDir As DirectoryInfo
        ProcessFilesInDir(aDir)
        For Each nextDir In aDir.GetDirectories
            ProcessRecursiveDirectory(nextDir)
        Next
    End Sub

    Private Sub ProcessFilesInDir(ByVal aDir As DirectoryInfo)
        Dim aFile As FileInfo
        For Each aFile In aDir.GetFiles()
            If aFile.Name.Equals("CLC.RUNNING") Then
                File.Delete(aDir.FullName + "\CLC.RUNNING")
                Console.WriteLine(aFile.FullName)
            End If
        Next
    End Sub

    '***********************************************'
    Sub FindExistingSAASFiles()

        iDirLevel = 0
        SAAS_Instance.Clear()
        Dim nameOfDirectory As String = getIsolatedDirectoryPath()
        Dim myDirectory As DirectoryInfo
        myDirectory = New DirectoryInfo(nameOfDirectory)
        ProcessRecursiveSAASDirectory(myDirectory)
        gCLCDIR = FindSAASPath()
        gActivePreviewPath = FindSAASPendingPath()
        gActiveRestorePath = FindSAASDownloadPath()

    End Sub

    Private Sub ProcessRecursiveSAASDirectory(ByVal aDir As DirectoryInfo)
        Dim nextDir As DirectoryInfo
        ProcessSSASFilesInDir(aDir)
        ProcessSSASPendingFolder(aDir)
        ProcessSSASDownloadFolder(aDir)
        For Each nextDir In aDir.GetDirectories
            iDirLevel += 1
            ProcessRecursiveSAASDirectory(nextDir)
        Next
    End Sub

    Private Sub ProcessSSASFilesInDir(ByVal aDir As DirectoryInfo)
        Dim aFile As FileInfo
        For Each aFile In aDir.GetFiles()
            If aFile.Name.Equals("SAAS.RUNNING") Then
                If SAAS_Instance.ContainsKey(aFile.CreationTime) Then
                    Console.WriteLine("File already recorded")
                Else
                    SAAS_Instance.Add(aFile.CreationTime, aFile.FullName)
                End If
            End If
        Next
    End Sub

    Private Sub ProcessSSASPendingFolder(ByVal aDir As DirectoryInfo)
        Dim aFile As FileInfo
        For Each aFile In aDir.GetFiles()
            If aFile.Name.Equals("ECM.Preview.dat") Then
                If SAAS_Pending.ContainsKey(aFile.CreationTime) Then
                    Console.WriteLine("File already recorded")
                Else
                    SAAS_Pending.Add(aFile.CreationTime, aFile.FullName)
                End If
            End If
        Next
    End Sub

    Private Sub ProcessSSASDownloadFolder(ByVal aDir As DirectoryInfo)
        Dim aFile As FileInfo
        For Each aFile In aDir.GetFiles()
            If aFile.Name.ToUpper.Contains(".RESTOREDAT") Then
                If SAAS_Pending.ContainsKey(aFile.CreationTime) Then
                    Console.WriteLine("File already recorded")
                Else
                    SAAS_Pending.Add(aFile.CreationTime, aFile.FullName)
                End If
            End If
        Next
    End Sub

    Sub SetSAAS_State(ByVal SAAS_DIR As String, ByVal CLC_STATE As String)

        Try
            gCLCDIR = SAAS_DIR
            Dim FILE_NAME As String = gCLCDIR + "\CLC.RUNNING"
            If Not System.IO.File.Exists(FILE_NAME) Then
                Dim objWriter As New System.IO.StreamWriter(FILE_NAME)
                objWriter.Write(CLC_STATE)
                objWriter.Close()
                objWriter.Dispose()
                GC.Collect()
                'If File.Exists(FILE_NAME) Then
                '    File.Delete(FILE_NAME)
                'End If
            End If
        Catch ex As IOException
            MsgBox(ex.ToString)
        End Try

    End Sub

    Function FindSAASPath() As String
        Dim SSAS_PATH As String = ""
        Dim SSAS_FILE As String = ""

        'iDirLevel = 0
        'FindExistingSAASFiles()

        If SAAS_Instance.Count = 0 Then
            '** Remove all occurances of the CLC.RUNNING file"
            'PurgeExistingRunningFiles()
            Return ""
        Else
            Dim LastKey As Date = SAAS_Instance.Keys(SAAS_Instance.Count - 1)
            SSAS_FILE = SAAS_Instance.Item(LastKey)
            Dim FI As New FileInfo(SSAS_FILE)
            SSAS_PATH = FI.DirectoryName
            SetSAAS_State(SSAS_PATH, "ACTIVE")
            FI = Nothing
            GC.Collect()
        End If
        Return SSAS_PATH
    End Function

    Function FindSAASPendingPath() As String
        Dim tDateKey As String = ""
        gActivePreviewPath = ""

        If SAAS_Pending.Count = 0 Then
            '** Remove all occurances of the CLC.RUNNING file"
            'PurgeExistingRunningFiles()
            Return ""
        Else
            Dim LastKey As Date = SAAS_Pending.Keys(SAAS_Pending.Count - 1)
            tDateKey = SAAS_Pending.Item(LastKey)
            Dim FI As New FileInfo(tDateKey)
            gActivePreviewPath = FI.DirectoryName
            FI = Nothing
            GC.Collect()
        End If
        Return gActivePreviewPath
    End Function

    Function FindSAASDownloadPath() As String
        Dim tDateKey As String = ""
        gActiveRestorePath = ""

        If SAAS_Download.Count = 0 Then
            '** Remove all occurances of the CLC.RUNNING file"
            'PurgeExistingRunningFiles()
            Return ""
        Else
            Dim LastKey As Date = SAAS_Download.Keys(SAAS_Download.Count - 1)
            tDateKey = SAAS_Download.Item(LastKey)
            Dim FI As New FileInfo(tDateKey)
            gActiveRestorePath = FI.DirectoryName
            FI = Nothing
            GC.Collect()
        End If
        Return gActiveRestorePath
    End Function

End Class

Class FilesToProcess
    Public pRepoTableName As String = ""
    Public CurrentGuid As String = ""
    Public FileExt As String = ""
    Public FileFQN As String = ""
    Public bDoNotOverwriteExistingFile As Boolean
    Public bOverwriteExistingFile As Boolean
    Public bRestoreToOriginalDirectory As Boolean
    Public bRestoreToMyDocuments As Boolean
    Public bCreateOriginalDirIfMissing As Boolean
End Class