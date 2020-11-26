#Const RemoteOcr = 0
#Const Redemption = 1
#Const UseEmailChunks = 1

Imports System.Data.SqlClient
Imports System.IO
Imports System.Threading
Imports System.Xml
Imports Microsoft.Office.Interop
Imports Microsoft.Office.Interop.Outlook
Imports ECMEncryption

Public Class clsEmailFunctions
    Inherits clsArchiver

    Dim ISO As New clsIsolatedStorage
    Dim DBLocal As New clsDbLocal

    Dim skippedEmails As Integer = 0
    Dim srv_DetailedLogging As Boolean = False
    Dim TotalMemory As Double = 0
    Dim TotalOcr As Integer = 0
    Dim TotalOcrFailed As Integer = 0

    Dim DaysToHold As Integer = 365

    Dim ATYPE As New clsATTACHMENTTYPE
    Dim EMAIL As New clsEMAIL
    Dim RECIPS As New clsRECIPIENTS
    Dim ZF As New clsZipFiles

    Dim DBARCH As New clsDatabaseARCH

#If Redemption Then
    Const PR_ICON_INDEX = &H10800003
#End If

    Dim TotalEmailsInArchive As Integer = 0
    Dim dDebug_clsEmailFunctions As Boolean = False

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim ENC As new ECMEncrypt

    Dim SL As New SortedList
    Dim SL2 As New SortedList

    Sub New()

        Dim sDebug As String = getUserParm("debug_clsEmailFunc")
        If sDebug.Equals("0") Then
            dDebug_clsEmailFunctions = False
        Else
            dDebug_clsEmailFunctions = True
            LOG.WriteToArchiveLog("Starting: clsEmailFunctions, Debug configuration is ON")
        End If
    End Sub

    Sub LaunchExchangeDownload()

        If isArchiveDisabled("EXCHANGE") = True Then
            LOG.WriteToArchiveLog("LaunchExchangeDownload: Exchange Archive is LAUNCHED ")
            Return
        End If

        If gCurrentArchiveGuid.Length = 0 Then
            gCurrentArchiveGuid = Guid.NewGuid.ToString
        End If
        Dim t As Thread
        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("Entering LaunchExchangeDownload from clsEmailFunctions")
        LOG.WriteToArchiveLog("Entering LaunchExchangeDownload from clsEmailFunctions")
        LOG.WriteToArchiveLog("GetExchangeFolders LaunchExchangeDownload 100")
        t = New Thread(AddressOf Me.ProcessExchangeServers)
        LOG.WriteToArchiveLog("GetExchangeFolders LaunchExchangeDownload 200")
        t.Priority = ThreadPriority.Lowest
        t.Start()
        LOG.WriteToArchiveLog("Thread executing LaunchExchangeDownload from clsEmailFunctions")
    End Sub

    ' Sub xxProcessExchangePopMail()

    ' If isArchiveDisabled("EXCHANGE") = True Then Return End If

    ' frmExchangeMonitor.Show() frmExchangeMonitor.Location = New Point(25, 50)
    ' frmExchangeMonitor.Refresh() System.Windows.Forms.Application.DoEvents()

    ' LOG.WriteToArchiveLog("Exchange Archive started @ " + Now.ToString)

    ' Try If gCurrentArchiveGuid .Length = 0 Then gCurrentArchiveGuid = Guid.NewGuid.ToString End If

    ' If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("Starting ProcessExchangePopMail from
    ' clsEmailFunctions") Dim ArchiveGuid = System.Guid.NewGuid.ToString()

    ' Dim S = "Select
    ' [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL,
    ' IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM
    ' [ExchangeHostPop] order by [HostNameIp] ,[UserLoginID]" Dim rsData As SqlDataReader

    ' Dim DaysToRetain As Integer = 1000000 Dim HostNameIp = "" Dim UserLoginID = "" Dim LoginPw = ""
    ' Dim LeaveOnServer As Boolean = True Dim DeleteAfterDownload As Boolean = False Dim PortNbr = ""
    ' Dim RetentionCode = "" Dim retentionYears As Integer = 10 Dim SSL As Boolean = False Dim IMap
    ' As Boolean = False Dim FolderName = "" Dim LibraryName = "" Dim isPublic As Boolean = False Dim
    ' strReject = "" Dim ConvertEmlToMSG As Boolean = False

    ' rsData = SqlQryNewConn(S)

    ' If rsData.HasRows Then Do While rsData.Read() System.Windows.Forms.Application.DoEvents() '0
    ' [HostNameIp], '1 [UserLoginID], '2 [LoginPw], '3 [PortNbr], '4 [DeleteAfterDownload], '5
    ' [RetentionCode], '6 SSL, '7 IMap, '8 FolderName, '9 LibraryName, '10 isPublic '11 DaysToHold
    ' '12 strReject '13 ConvertEmlToMSG If gTerminateImmediately Then Return End If

    ' Try ConvertEmlToMSG = rsData.GetBoolean(13) Catch ex As System.Exception ConvertEmlToMSG =
    ' False End Try

    ' Try LibraryName = rsData.GetValue(9).ToString Catch ex As System.Exception LibraryName = "NA"
    ' End Try

    ' Try isPublic = rsData.GetBoolean(10) Catch ex As System.Exception isPublic = False End Try

    ' Try DaysToRetain = rsData.GetInt32(11) Catch ex As System.Exception DaysToRetain = 1000000 End
    ' Try Try strReject = rsData.GetValue(12).ToString Catch ex As System.Exception strReject = ""
    ' End Try

    ' Dim LibraryOwnerUserID = "" If LibraryName.Trim.Length > 0 Then LibraryOwnerUserID =
    ' GetLibOwnerByName(LibraryName ) End If

    ' Try HostNameIp = rsData.GetValue(0).ToString Catch ex As System.Exception HostNameIp = "" End Try

    ' Try UserLoginID = rsData.GetValue(1).ToString Catch ex As System.Exception UserLoginID = "" End Try

    ' 'If ConvertEmlToMSG = True And gRedemptionDllExists = False Then ' If gRunUnattended = False
    ' Then ' if gRunUnattended = false then messagebox.show("ERROR ERROR - ProcessExchangeMail - It
    ' appears the Redemption DLL is missing, this folder '" + HostNameIp + " :" + LibraryName + " : "
    ' + UserLoginID + "' will not be processed.") ' End If ' log.WriteToArchiveLog("ERROR ERROR -
    ' ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp + "
    ' :" + LibraryName + " : " + UserLoginID + "' will not be processed.") ' GoTo NextBox 'End If

    ' LoginPw = rsData.GetValue(2).ToString LoginPw = ENC.AES256DecryptString(LoginPw)

    ' Try PortNbr = rsData.GetValue(3).ToString Catch ex As System.Exception PortNbr = "" End Try Try
    ' Dim tDeleteAfterDownload = rsData.GetValue(4).ToString If tDeleteAfterDownload .Equals("False")
    ' Then DeleteAfterDownload = False Else DeleteAfterDownload = True End If Catch ex As
    ' System.Exception DeleteAfterDownload = False End Try Try RetentionCode =
    ' rsData.GetValue(5).ToString Catch ex As System.Exception RetentionCode = "" End Try Try Dim
    ' tSSL = rsData.GetValue(6).ToString If tSSL.Equals("False") Then SSL = False Else SSL = True End
    ' If Catch ex As System.Exception SSL = False End Try Try Dim tIMap = rsData.GetValue(7).ToString
    ' If tIMap .Equals("False") Then IMap = False Else IMap = True End If Catch ex As
    ' System.Exception IMap = False End Try

    ' If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 500 : " +
    ' HostNameIp )

    ' retentionYears = getRetentionPeriod(RetentionCode )

    ' If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 500.1 : " +
    ' retentionYears.ToString) If DeleteAfterDownload = False Then LeaveOnServer = True Else
    ' LeaveOnServer = False End If

    ' LOG.WriteToArchiveLog("Processing Exchange Box " + HostNameIp + " emails by " + UserLoginID)

    ' frmExchangeMonitor.lblServer.Text = HostNameIp frmExchangeMonitor.lblMessageInfo.Text =
    ' UserLoginID System.Windows.Forms.Application.DoEvents()

    ' If SSL = True And IMap = False Then If PortNbr .Trim.Length = 0 Then PortNbr = "995" End If If
    ' PortNbr .Equals("-1") Then PortNbr = "995" End If

    '                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 600 PortNbr : " + PortNbr )
    '                        LOG.WriteToArchiveLog("Processing Exchange SSL " + HostNameIp  + " emails by " + UserLoginID)
    '                        ReadEmailUsingSSL(HostNameIp , UserLoginID , LoginPw, _
    '                                          PortNbr , LeaveOnServer, retentionYears, _
    '                                          RetentionCode , LibraryName, isPublic, DaysToRetain, _
    '                                          strReject , ConvertEmlToMSG)
    '                    ElseIf IMap = True And SSL = True Then
    '                        If PortNbr .Trim.Length = 0 Then
    '                            PortNbr  = "993"
    '                        End If
    '                        If PortNbr .Equals("-1") Then
    '                            PortNbr  = "993"
    '                        End If
    '                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 700 PortNbr : " + PortNbr )
    '                        LOG.WriteToArchiveLog("Processing Exchange IMAP " + HostNameIp  + " emails by " + UserLoginID)
    '                        getImapEmailSSL(HostNameIp , _
    '                                           PortNbr , _
    '                                           UserLoginID , LoginPw, LeaveOnServer, _
    '                                           RetentionCode , retentionYears, _
    '                                           LibraryName, isPublic, DaysToRetain, strReject , ConvertEmlToMSG)
    '                    ElseIf IMap = True And SSL = False Then
    '                        If PortNbr .Trim.Length = 0 Then
    '                            PortNbr  = "993"
    '                        End If
    '                        If PortNbr .Equals("-1") Then
    '                            PortNbr  = "993"
    '                        End If
    '                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 800 PortNbr : " + PortNbr )
    '                        LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL " + HostNameIp  + " emails by " + UserLoginID)
    '                        Me.getIMapEmail(HostNameIp , UserLoginID , LoginPw, _
    '                                        LeaveOnServer, RetentionCode , retentionYears, _
    '                                        LibraryName, isPublic, DaysToRetain, strReject , _
    '                                        ConvertEmlToMSG)
    '                    Else
    '                        If PortNbr .Trim.Length = 0 Then
    '                            PortNbr  = "110"
    '                        End If
    '                        If PortNbr .Equals("-1") Then
    '                            PortNbr  = "110"
    '                        End If
    '                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 900 PortNbr : " + PortNbr )
    '                        LOG.WriteToArchiveLog("Processing Exchange POP " + HostNameIp  + " emails by " + UserLoginID)
    '                        ReadEmailFromServer(HostNameIp , PortNbr , UserLoginID , LoginPw, _
    '                                            LeaveOnServer, RetentionCode, retentionYears, _
    '                                            LibraryName, isPublic, DaysToRetain, strReject , _
    '                                            ConvertEmlToMSG)
    '                    End If
    'NextBox:
    '                Loop
    '            End If
    '            rsData.Close()
    '            rsData = Nothing
    '        Catch ex As System.Exception
    '            log.WriteToArchiveLog("ERROR 641.92.2 ProcessExchangePopMail - " + ex.Message)
    '        End Try
    '        LOG.WriteToArchiveLog("Exchange Archive completed @ " + Now.ToString)
    '        frmExchangeMonitor.Dispose()
    '    End Sub

    Function GetMailServerFromEmailAddr(ByVal EmailAddr As String) As String

        Dim ServerName As String = ""
        Dim mailman As New Chilkat.MailMan()
        mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")

        Dim fromAddr As String
        fromAddr = EmailAddr

        Dim mailServer As String
        mailServer = mailman.MxLookup(fromAddr)
        If (mailServer Is Nothing) Then
            ServerName = ""
        Else
            ServerName = mailServer
        End If
        Return ServerName
    End Function

    Sub DownloadExchangeEmail()
        Try
            Dim mailman As New Chilkat.MailMan()

            Dim EmailFrom As String = ""
            Dim EmailSubject As String = ""
            Dim EmailBody As String = ""

            ' Any string passed to UnlockComponent automatically begins a 30-day trial.
            Dim success As Boolean
            success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
            If (success <> True) Then
                If gRunUnattended = False Then MessageBox.Show(mailman.LastErrorText)
                Exit Sub
            End If

            ' Set our POP3 hostname, login and password
            mailman.MailHost = "mail.chilkatsoft.com"
            mailman.PopUsername = "login"
            mailman.PopPassword = "password"

            ' Connecting via SSL is possible by adding these lines:
            'mailman.PopSsl = true;
            ' Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
            'mailman.MailPort = 995;
            ' Download email from the POP3 server by calling TransferMail
            Dim bundle As Chilkat.EmailBundle

            ' WARNING - TransferMail() Deletes all transfered mail from the server. bundle =
            ' mailman.TransferMail() CopyMail() will leave it on the server
            bundle = mailman.CopyMail()

            If bundle Is Nothing Then
                MessageBox.Show(mailman.LastErrorText)
                Return
            End If

            Dim i As Integer
            Dim n As Integer = bundle.MessageCount
            For i = 0 To n - 1
                Dim email As Chilkat.Email = bundle.GetEmail(i)

                EmailFrom = email.From
                EmailSubject = email.Subject
                EmailBody = email.Body

            Next i
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 641.92.1 DownloadExchangeEmail - " + ex.Message)
        End Try

    End Sub

    Sub LoadEmGetAttachments(ByVal FQN As String, ByVal DownLoadDir As String)
        'Load an EML file containing the MIME source of an email and save the attachments.
        Dim myEmaileml As String = FQN
        Dim email As New Chilkat.Email()
        'email.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
        email.LoadEml(myEmaileml)
        email.SaveAllAttachments(DownLoadDir)
    End Sub

    Sub FixDate(ByRef tStr As String)

        Dim S As String = tStr.Trim
        Dim CH As String = ""
        For i As Integer = 1 To S.Length
            CH = Mid(S, i, 1)
            If CH.Equals("/") Then
                Mid(S, i, 1) = "."
            ElseIf CH.Equals(":") Then
                Mid(S, i, 1) = "."
            ElseIf CH.Equals(" ") Then
                Mid(S, i, 1) = "."
            End If
        Next
        tStr = S
    End Sub

    Sub RemoveBadChars(ByRef tStr As String)

        Dim S As String = tStr.Trim
        Dim CH As String = ""
        Dim GoodChrCnt As Integer = 0
        Dim GoodChars As String = "abcdefghijklmnopqrstuvwxyz1234567890@_"
        For i As Integer = 1 To S.Length
            CH = Mid(S, i, 1)
            If InStr(GoodChars, CH, CompareMethod.Text) > 0 Then
                GoodChrCnt += 1
            Else
                Mid(S, i, 1) = " "
            End If
        Next
        tStr = S
    End Sub

    Sub ReadEmailFromServer(ByVal UID As String, ByVal ServerName As String, ByVal PortNbr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer,
                            ByVal LibraryName As String,
                            ByVal isPublic As Boolean,
                            ByVal DaysToRetain As Integer,
                            ByVal strReject As String,
                            ByVal bEmlToMSG As Boolean)
        'ServerName  = "pop.dmachicago.com"
        'read mail from a POP3 server.
        Dim mailman As New Chilkat.MailMan()
        mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")

        Dim CurrMailFolder As String = ServerName + ":" + UserLoginID
        Dim I As Integer = 0
        Dim J As Integer = 0

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100")

        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim EmailDir As String = TempDir + "Email"

        If Not Directory.Exists(EmailDir) Then
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.1")
            Directory.CreateDirectory(EmailDir)
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.2")
        End If
        If Not Directory.Exists(AttachmentDir) Then
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.3")
            Directory.CreateDirectory(AttachmentDir)
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.4")
        End If

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.5")
        DMA.deleteDirectoryFiles(EmailDir)

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.6")
        DMA.deleteDirectoryFiles(AttachmentDir)

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 100.7")
        mailman.MailHost = ServerName
        mailman.PopPassword = LoginPassWord
        mailman.PopUsername = UserLoginID

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 200")

        '******************************************************************************************************
        LOG.WriteToArchiveLog("Applying POP Bundle by " + UserLoginID)
        Dim SuccessfulRun As Boolean = False

        SuccessfulRun = ApplyEmailBundleV2(UID, mailman, ServerName, UserLoginID, LoginPassWord, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG)
        If Not SuccessfulRun Then
            ApplyEmailBundle(UID, mailman, ServerName, UserLoginID, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG)
        End If
        '******************************************************************************************************

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ReadEmailFromServer 300 Ended ")

        DMA.deleteDirectoryFiles(EmailDir)
        DMA.deleteDirectoryFiles(AttachmentDir)

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Sub

    Sub getDirectoryFiles(ByVal DirFQN As String, ByRef DirFiles As List(Of String))

        Try
            'DirFiles.Clear()
            Dim strFileSize As String = ""
            Dim di As New IO.DirectoryInfo(DirFQN)
            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
            Dim fi As IO.FileInfo
            For Each fi In aryFi
                If Not DirFiles.Contains(fi.FullName) Then
                    DirFiles.Add(fi.FullName)
                End If
            Next
        Catch ex As System.Exception

        End Try

    End Sub

    Sub SendHighPriorityEmail(ByVal ServerName As String, ByVal UserLoginID As String, ByVal LoginPassWord As String)
        Dim mailman As New Chilkat.MailMan()

        ' Any string passed to UnlockComponent automatically begins a 30-day trial.
        Dim success As Boolean
        success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
        If (success <> True) Then
            If gRunUnattended = False Then MessageBox.Show(mailman.LastErrorText)
            Exit Sub
        End If

        ' Set the SMTP server.
        'mailman.SmtpHost = "smtp.earthlink.net"
        mailman.SmtpHost = ServerName

        ' Create a high-priority email.
        Dim email As New Chilkat.Email()

        ' Set the basic email stuff: body, subject, "from", "to"
        email.Body = "This is the email body"
        email.Subject = "This is the email subject"
        email.AddTo("Chilkat Support", "support@chilkatsoft.com")
        email.From = "Programmer <programmer@chilkatsoft.com>"

        'You can add the X-Priority header field and give it the value string "1".
        'For example: email.AddHeaderField "X-Priority","1" This is the most common way of
        ' setting the priority of an email. "3" is normal, and "5" is the lowest.
        ' "2" and "4" are in-betweens, and frankly I've never seen anything
        ' but "1" or "3" used. Microsoft Outlook adds these header fields when
        ' setting a message to High priority:
        ' X-Priority: 1 (Highest)
        ' X-MSMail-Priority: High
        ' Importance: High
        ' This field alone is enough to make the email high-priority.
        email.AddHeaderField("X-Priority", "1")

        success = mailman.SendEmail(email)
        If success Then
            LOG.WriteToArchiveLog("NOTICE: Sent high-priority email!")
        Else
            LOG.WriteToArchiveLog("ERROR: " + mailman.LastErrorText)
        End If

    End Sub

    ' Download email from a POP3 server, save and remove attachments, and save the email bundle
    ' (without attachments) as XML.
    Private Sub EmailCopyAndSave(ByVal ServerName As String, ByVal UserLoginID As String, ByVal LoginPassWord As String)
        Try
            Dim AttachmentDir As String = "C:\temp\DownloadedEmails\Attachments"
            Dim EmailDir As String = "C:\temp\DownloadedEmails"

            Dim mailman As New Chilkat.MailMan()
            mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
            mailman.MailHost = ServerName
            mailman.PopUsername = UserLoginID
            mailman.PopPassword = LoginPassWord

            Dim bundle As Chilkat.EmailBundle
            Dim bundle2 As New Chilkat.EmailBundle()

            bundle = mailman.CopyMail()
            If (Not (bundle Is Nothing)) Then
                Dim i As Long
                Dim email As Chilkat.Email
                For i = 0 To bundle.MessageCount - 1
                    email = bundle.GetEmail(i)
                    email.SaveAllAttachments(AttachmentDir)
                    email.DropAttachments()
                    ' Add the email (without attachments) to bundle2.
                    bundle2.AddEmail(email)
                Next
            End If
            ' Save the email bundle without attachments.
            bundle2.SaveXml("bundle.xml")
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR- clsEmailFuncitons:EmailCopyAndSave " + environment.NewLine + ex.Message)
            LOG.WriteToArchiveLog("ERROR- clsEmailFuncitons:EmailCopyAndSave " + environment.NewLine + ex.StackTrace)
        End Try
    End Sub

    Sub ApplyEmailBundle(ByVal UID As String,
                         ByVal mailman As Chilkat.MailMan,
                         ByVal ServerName As String,
                         ByVal UserLoginID As String,
                         ByVal LeaveOnServer As Boolean,
                         ByVal retentionYears As Integer,
                         ByVal RetentionCode As String,
                         ByVal LibraryName As String,
                         ByVal isPublic As Boolean,
                         ByVal DaysToHold As Integer,
                         ByVal strReject As String,
                         ByVal bEmlToMSG As Boolean)

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 100")

        Dim I As Integer = 0
        Dim J As Integer = 0
        'System.IO.Path.GetTempPath
        Dim TempDir As String = UTIL.getTempProcessingDir
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim EmailDir As String = TempDir + "Email"
        Dim CurrMailFolder As String = ServerName + ":" + UserLoginID
        Dim bundle As Chilkat.EmailBundle

        Dim ArrayOfEntryID As Chilkat.StringArray

        ArrayOfEntryID = mailman.GetUidls()
        If (ArrayOfEntryID Is Nothing) Then
            LOG.WriteToArchiveLog("Error 100.13.21 could not acquire email UID's.")
            Exit Sub
        End If

        Dim n As Long
        n = ArrayOfEntryID.Count

        Dim email As Chilkat.Email
        Dim EntryID As String

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 200")
        Dim iCount As Integer = mailman.GetMailboxCount
        frmMain.SB.Text = "Waiting for email download." + Now.ToString
        frmExchangeMonitor.Show()
        '********************************************************************

        frmExchangeMonitor.lblServer.Text = ServerName + " : " + UserLoginID
        frmExchangeMonitor.lblMessageInfo.Text = "Downloading emails... standby."
        frmExchangeMonitor.lblMsg.Text = "Waiting for email download." + Now.ToString
        frmExchangeMonitor.Refresh()
        System.Windows.Forms.Application.DoEvents()

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300")

        If LeaveOnServer Then
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.1")
            LOG.WriteToArchiveLog("Applying Bundle Leave On Server Emails Count = " + iCount.ToString)
            bundle = mailman.CopyMail
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.2")
        Else
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.3")
            LOG.WriteToArchiveLog("Applying Bundle Remove from Server Emails Count = " + iCount.ToString)
            bundle = mailman.TransferMail
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.4")
        End If

        If bundle Is Nothing Then
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 400")
            LOG.WriteToArchiveLog("Applying Bundle from Server NO Emails to process.")
            LOG.WriteToArchiveLog("NOTICE: Exchange Email Read 100.45.2 - " + ServerName + " : " + UserLoginID)
            LOG.WriteToArchiveLog(mailman.LastErrorText)
            If gClipBoardActive = True Then Console.WriteLine(mailman.LastErrorText)
            frmExchangeMonitor.Close()
            Return
        End If
        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 500")

        frmMain.SB.Text = "Download complete." + Now.ToString

        LOG.WriteToArchiveLog("Applying Bundle Message Count = " + bundle.MessageCount.ToString)
        frmExchangeMonitor.lblMsg.Text = "Applying Messages: #" + bundle.MessageCount.ToString

        Dim bEmailAlreadyExists As Boolean = False
        'For I = 0 To bundle.MessageCount - 1
        For I = 0 To n - 1

            EntryID = ArrayOfEntryID.GetString(I)
            email = mailman.FetchEmail(EntryID)
            If (email Is Nothing) Then
                LOG.WriteToArchiveLog("Processed Message Count = " + I.ToString)
                Exit For
            End If

            bEmailAlreadyExists = DBLocal.ExchangeExists(EntryID)
            If bEmailAlreadyExists Then
                DBLocal.MarkExchangeFound(EntryID)
                GoTo NextRec
            End If

            frmExchangeMonitor.lblMessageInfo.Text = "Downloading " + I.ToString
            frmExchangeMonitor.Refresh()
            System.Windows.Forms.Application.DoEvents()
            'frmReconMain.SB.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString + " of " + bundle.MessageCount.ToString

            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 600a: bundle.MessageCount " + bundle.MessageCount.ToString)
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 600b: " + I.ToString)
            frmExchangeMonitor.lblMessageInfo.Text = UserLoginID + " : Message# " & I & " of " & bundle.MessageCount.ToString
            frmExchangeMonitor.Refresh()
            System.Windows.Forms.Application.DoEvents()

            Dim NewGuid As String = System.Guid.NewGuid.ToString()

            'email = bundle.GetEmail(I)

            Dim Subject As String = email.Subject
            Dim EmailFrom As String = email.From
            Dim FromAddress As String = email.FromAddress
            Dim FromName As String = email.FromName
            Dim From As String = email.From
            Dim CreateTime As Date = email.EmailDate

            If strReject.Trim.Length > 0 Then
                Dim A As String() = strReject.Split(",")
                For II As Integer = 0 To UBound(A)
                    Dim S1 As String = A(II).Trim
                    If S1.Trim.Length > 0 Then
                        If InStr(Subject, S1, CompareMethod.Text) Then
                            LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject)
                            GoTo NextRec
                        End If
                    End If
                Next
            End If

            Dim NumDaysOld As Integer = email.NumDaysOld
            If NumDaysOld > DaysToHold Then
                Dim success As Boolean = mailman.DeleteEmail(email)
                If (success <> True) Then
                    Dim Msg As String = "Subject: " + Subject + environment.NewLine
                    Msg += "FromName: " + FromName + environment.NewLine
                    Msg += "FromAddress: " + FromAddress + environment.NewLine
                    LOG.WriteToArchiveLog("ERROR ApplyEmailBundle: Failed to delete email:" + environment.NewLine + Msg)
                End If
            End If

            Dim NumAlternatives As Integer = email.NumAlternatives
            Dim NumAttachedMessages As Integer = email.NumAttachedMessages
            Dim NumAttachments As Integer = email.NumAttachments
            Dim NumBcc As Integer = email.NumBcc
            Dim NumCC As Integer = email.NumCC
            Dim NumTo As Integer = email.NumTo
            Dim ReplyTo As String = email.ReplyTo
            Dim SignedBy As String = email.SignedBy
            Dim EmailSize As Integer = email.Size
            Dim ReceivedDate As String = email.LocalDate.ToString
            Dim GMT As String = email.EmailDate.ToString
            Dim Header As String = email.Header
            Dim EmailBody As String = email.Body

            Dim Recipients As New ArrayList
            Dim EmailTo As New ArrayList
            Dim EmailToAddr As New ArrayList
            Dim EmailToName As New ArrayList
            Dim Bcc As New ArrayList
            Dim BccAddr As New ArrayList
            Dim BccName As New ArrayList
            Dim CC As New ArrayList
            Dim CcAddr As New ArrayList
            Dim CcName As New ArrayList
            Dim bLoadAttachments As Boolean = False

            Dim tGMT As String = GMT.ToString
            FixDate(tGMT)
            Dim tSubject As String = Mid(Subject, 1, 100)
            RemoveBadChars(tSubject)

            Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.FromAddress, Subject)
            Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 700: " + I.ToString)
            'Dim B As Boolean = ExchangeEmailExists(EmailIdentifier, EmailHashCode)
            Dim B As Boolean = ExchangeEmailExists(EmailIdentifier)
            If B Then
                If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("INFO: ApplyEmailBundle 700X email already exists in Repository: " + I.ToString)
                GoTo NextRec
            End If

            Dim EmailFQN As String = TempDir + "EMAIL." + NewGuid + ".MSG"

            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 800: " + I.ToString)
            If NumAttachments > 0 Then
                '** Clean out the directory
                DMA.deleteDirectoryFiles(AttachmentDir)
                ' Save attachments to the "attachments" directory.
                email.SaveAllAttachments(AttachmentDir)
                bLoadAttachments = True
            End If

            Dim iLevel As Integer = 1
            If NumAttachedMessages > 0 Then
                'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                For II As Integer = 0 To NumAttachedMessages - 1
                    'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                    Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                    'ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, iLevel)
                    ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                    objEmail = Nothing
                Next
            End If

            For J = 0 To NumCC - 1
                CC.Add(email.GetCC(J).ToString)
                CcAddr.Add(email.GetCcAddr(J).ToString)
                CcName.Add(email.GetCcName(J).ToString)
                If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                    Recipients.Add(email.GetCcAddr(J).ToString)
                End If
            Next
            For J = 0 To NumBcc - 1
                Bcc.Add(email.GetBcc(J).ToString)
                BccName.Add(email.GetBccName(J).ToString)
                BccAddr.Add(email.GetBccAddr(J).ToString)
                If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                    Recipients.Add(email.GetBccAddr(J).ToString)
                End If
            Next
            For J = 0 To NumTo - 1
                EmailTo.Add(email.GetTo(J).ToString)
                EmailToAddr.Add(email.GetToAddr(J).ToString)
                EmailToName.Add(email.GetToName(J).ToString)
                If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                    Recipients.Add(email.GetToAddr(J).ToString)
                End If
            Next

            ' Save the email to XML
            'email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

            ' Save the email to EML
            'Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 900.0: " + I.ToString)
            email.SaveEml(EmailFQN)

            'log.WriteToArchiveLog("Notice from ApplyEmailBundle 200 : FQN '" + EmailFQN  + "'")

            '**********************************************************
            'IF CONVERT TO MSG THEN
            'READ IN THE NEW EML
            'CONVERT IT TO MSG
            'WRITE OUT THE MSG
            'SAVE THE MSG IMAGE INTO THE REPOSITORY.
            If bEmlToMSG = True Then
                EmailFQN = convertEmlToMsg(EmailFQN)
                If EmailFQN.Trim.Length = 0 Then
                    LOG.WriteToArchiveLog("Unrecoverable Error: 100 ApplyEmailBundle - failed to convert EML to MSG File.")
                    LOG.WriteToArchiveLog("NOTE : 100 Most likely the Redemption DLL is not installed properly")
                    GoTo NextRec
                End If
                'log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'")
            End If

            '**********************************************************

            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 900.1: " + I.ToString)
            Dim AttachedFiles As New List(Of String)
            getDirectoryFiles(AttachmentDir, AttachedFiles)

            Dim DB_ID As String = "ECM.Library"
            Dim Server_UserID_StoreID As String = CurrMailFolder

            '** Now, Load the EMAIL and its metadata into the repository
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 900.2: " + I.ToString)
            'log.WriteToArchiveLog("Notice from ApplyEmailBundle 400 : FQN '" + EmailFQN  + "'")
            Dim AttachmentsLoaded As Boolean = False

            ArchiveExchangeEmails(UID, NewGuid,
                                EmailBody,
                                Subject,
                                CcAddr,
                                BccAddr,
                                EmailToAddr,
                                Recipients,
                                ServerName,
                                FromAddress,
                                FromName, CDate(ReceivedDate),
                                UserLoginID, Now, CDate(ReceivedDate),
                                DB_ID,
                                CurrMailFolder,
                                Server_UserID_StoreID,
                                retentionYears,
                                RetentionCode,
                                EmailSize,
                                AttachedFiles,
                                EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)
NextRec:
            If LibraryName.Trim.Length > 0 Then

            End If
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 1000: " + I.ToString)
        Next

        ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, 99)
        Dim ConversionDir As String = LOG.getEnvVarSpecialFolderLocalApplicationData + "\WMCONVERT"
        ApplyPendingEmail(UID, ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode)
        frmExchangeMonitor.lblMessageInfo.Text = "Download complete."
        frmExchangeMonitor.Close()
    End Sub

    Sub ApplyIMapBundle(ByVal UID As String, ByVal imap As Chilkat.Imap, ByVal ServerName As String, ByVal UserLoginID As String, ByVal LeaveOnServer As Boolean, ByVal retentionYears As Integer, ByVal RetentionCode As String, ByVal LibraryName As String, ByVal isPublic As Boolean, ByVal DaysToHold As Integer, ByVal strReject As String, ByVal bEmlToMSG As Boolean)

        Dim ID As Integer = 33333
        frmExchangeMonitor.Show()
        frmExchangeMonitor.lblServer.Text = ServerName + " : " + UserLoginID
        frmExchangeMonitor.lblMessageInfo.Text = "Downloading emails... standby."
        frmExchangeMonitor.Refresh()
        System.Windows.Forms.Application.DoEvents()

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 100")
        Dim messageSet As Chilkat.MessageSet
        ' We can choose to fetch UIDs or sequence numbers.
        Dim fetchUids As Boolean
        fetchUids = True
        ' Get the message IDs of all the emails in the mailbox
        messageSet = imap.Search("ALL", fetchUids)
        If (messageSet Is Nothing) Then
            If gRunUnattended = False Then MessageBox.Show(imap.LastErrorText)
            Exit Sub
        End If

        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim EmailDir As String = TempDir + "Email"
        Dim CurrMailFolder As String = ServerName + ":" + UserLoginID

        Dim bundle As Chilkat.EmailBundle
        bundle = imap.FetchBundle(messageSet)
        If (bundle Is Nothing) Then

            If gRunUnattended = False Then MessageBox.Show(imap.LastErrorText)
            Exit Sub
        End If

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 200")
        Dim iCount As Integer = bundle.MessageCount

        '********************************************************************
        frmExchangeMonitor.Show()
        frmExchangeMonitor.lblServer.Text = ServerName + " : " + UserLoginID
        frmExchangeMonitor.lblMessageInfo.Text = "Processing emails... standby."
        frmExchangeMonitor.Refresh()
        System.Windows.Forms.Application.DoEvents()

        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300")

        'If LeaveOnServer Then
        '    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.1")
        '    LOG.WriteToArchiveLog("Applying Bundle Leave On Server Emails Count = " + iCount.ToString)
        '    bundle = MailMan.CopyMail
        '    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.2")
        'Else
        '    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.3")
        '    LOG.WriteToArchiveLog("Applying Bundle Remove from Server Emails Count = " + iCount.ToString)
        '    bundle = MailMan.TransferMail
        '    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.4")
        'End If

        'If bundle Is Nothing Then
        '    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 400")
        '    LOG.WriteToArchiveLog("Applying Bundle from Server NO Emails to process.")
        '    log.WriteToArchiveLog("NOTICE: Exchange Email Read 100.45.2 - " + ServerName  + " : " + UserLoginID )
        '    log.WriteToArchiveLog(MailMan.LastErrorText)
        '    If gClipBoardActive = True Then Console.WriteLine(MailMan.LastErrorText)
        '    Return
        'End If
        'If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 500")

        'Dim DisplayMsg  = "Retrieving " + bundle.MessageCount.ToString + " emails."
        'frmHelp.MsgToDisplay  = DisplayMsg
        'frmHelp.CallingScreenName  = "ECM Exchange"
        'frmHelp.CaptionName  = "Exchange Archive"
        'frmHelp.Timer1.Interval = 10000
        'frmHelp.Show()
        LOG.WriteToArchiveLog("Applying IMAP Bundle Message Count = " + bundle.MessageCount.ToString)
        For I = 0 To bundle.MessageCount - 1
            'frmExchangeMonitor.lblMessageInfo.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString
            'frmReconMain.SB.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString + " of " + bundle.MessageCount.ToString
            System.Windows.Forms.Application.DoEvents()
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 600a: bundle.MessageCount " + bundle.MessageCount.ToString)
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 600b: " + I.ToString)
            frmExchangeMonitor.lblMessageInfo.Text = UserLoginID + " : Message# " & I & " of " & bundle.MessageCount.ToString
            frmExchangeMonitor.Refresh()
            System.Windows.Forms.Application.DoEvents()

            Dim NewGuid As String = System.Guid.NewGuid.ToString()

            Dim email As Chilkat.Email
            email = bundle.GetEmail(I)

            Dim EntryID As String = email.Uidl

            Dim Subject As String = email.Subject
            Dim EmailFrom As String = email.From
            Dim FromAddress As String = email.FromAddress
            Dim FromName As String = email.FromName
            Dim From As String = email.From

            If strReject.Trim.Length > 0 Then
                Dim A As String() = strReject.Split(",")
                For II As Integer = 0 To UBound(A)
                    Dim S1 As String = A(II).Trim
                    If S1.Trim.Length > 0 Then
                        If InStr(Subject, S1, CompareMethod.Text) Then
                            LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject)
                            GoTo NextRec
                        End If
                    End If
                Next
            End If

            Dim NbrDaysOld As Integer = email.NumDaysOld
            If NbrDaysOld > DaysToHold Then
                Dim success As Boolean = imap.SetMailFlag(email, "Deleted", 1)
                If (success <> True) Then
                    Dim Msg As String = "Subject: " + Subject + environment.NewLine
                    Msg += "FromName: " + FromName + environment.NewLine
                    Msg += "FromAddress: " + FromAddress + environment.NewLine
                    LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                End If
            End If

            Dim NumAlternatives As Integer = email.NumAlternatives
            Dim NumAttachedMessages As Integer = email.NumAttachedMessages
            Dim NumAttachments As Integer = email.NumAttachments
            Dim NumBcc As Integer = email.NumBcc
            Dim NumCC As Integer = email.NumCC
            Dim NumTo As Integer = email.NumTo
            Dim ReplyTo As String = email.ReplyTo
            Dim SignedBy As String = email.SignedBy
            Dim EmailSize As Integer = email.Size
            Dim ReceivedDate As String = email.LocalDate.ToString
            Dim GMT As String = email.EmailDate.ToString
            Dim Header As String = email.Header
            Dim EmailBody As String = email.Body

            Dim Recipients As New ArrayList
            Dim EmailTo As New ArrayList
            Dim EmailToAddr As New ArrayList
            Dim EmailToName As New ArrayList
            Dim Bcc As New ArrayList
            Dim BccAddr As New ArrayList
            Dim BccName As New ArrayList
            Dim CC As New ArrayList
            Dim CcAddr As New ArrayList
            Dim CcName As New ArrayList
            Dim bLoadAttachments As Boolean = False

            Dim tGMT As String = GMT.ToString
            FixDate(tGMT)
            Dim tSubject As String = Mid(Subject, 1, 100)
            RemoveBadChars(tSubject)

            'Dim EmailIdentifier as string = EmailSize.ToString + "~" + tGMT  + "~" + FromAddress.Trim + "~" + tSubject  + "~" + gCurrLoginID

            Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.FromAddress, Subject)
            Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

            Dim B As Boolean = ExchangeEmailExists(EmailIdentifier)
            If B Then
                If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 700X already exists: " + I.ToString)
                GoTo NextRec
            End If

            Dim EmailFQN As String = TempDir + "EMAIL." + NewGuid + ".MSG"

            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 800: " + I.ToString)
            If NumAttachments > 0 Then
                '** Clean out the directory
                DMA.deleteDirectoryFiles(AttachmentDir)
                ' Save attachments to the "attachments" directory.
                email.SaveAllAttachments(AttachmentDir)
                bLoadAttachments = True
            End If

            Dim iLevel As Integer = 1
            If NumAttachedMessages > 0 Then
                'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                For II As Integer = 0 To NumAttachedMessages - 1
                    'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                    Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                    'ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, iLevel)
                    ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                    objEmail = Nothing
                Next
            End If

            For J = 0 To NumCC - 1
                CC.Add(email.GetCC(J).ToString)
                CcAddr.Add(email.GetCcAddr(J).ToString)
                CcName.Add(email.GetCcName(J).ToString)
                If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                    Recipients.Add(email.GetCcAddr(J).ToString)
                End If
            Next
            For J = 0 To NumBcc - 1
                Bcc.Add(email.GetBcc(J).ToString)
                BccName.Add(email.GetBccName(J).ToString)
                BccAddr.Add(email.GetBccAddr(J).ToString)
                If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                    Recipients.Add(email.GetBccAddr(J).ToString)
                End If
            Next
            For J = 0 To NumTo - 1
                EmailTo.Add(email.GetTo(J).ToString)
                EmailToAddr.Add(email.GetToAddr(J).ToString)
                EmailToName.Add(email.GetToName(J).ToString)
                If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                    Recipients.Add(email.GetToAddr(J).ToString)
                End If
            Next

            ' Save the email to XML
            'email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

            ' Save the email to EML
            'Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 900.0: " + I.ToString)
            email.SaveEml(EmailFQN)

            'log.WriteToArchiveLog("Notice from ApplyEmailBundle 200 : FQN '" + EmailFQN  + "'")

            '**********************************************************
            'IF CONVERT TO MSG THEN
            'READ IN THE NEW EML
            'CONVERT IT TO MSG
            'WRITE OUT THE MSG
            'SAVE THE MSG IMAGE INTO THE REPOSITORY.
            If bEmlToMSG = True Then
                EmailFQN = convertEmlToMsg(EmailFQN)
                If EmailFQN.Trim.Length = 0 Then
                    LOG.WriteToArchiveLog("Unrecoverable Error: 100 ApplyEmailBundle - failed to convert EML to MSG File.")
                    LOG.WriteToArchiveLog("NOTE : 100 Most likely the Redemption DLL is not installed properly")
                    GoTo NextRec
                End If
                'log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'")
            End If

            '**********************************************************

            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 900.1: " + I.ToString)
            Dim AttachedFiles As New List(Of String)
            getDirectoryFiles(AttachmentDir, AttachedFiles)

            Dim DB_ID As String = "ECM.Library"
            Dim Server_UserID_StoreID As String = CurrMailFolder

            '** Now, Load the EMAIL and its metadata into the repository
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 900.2: " + I.ToString)
            'log.WriteToArchiveLog("Notice from ApplyEmailBundle 400 : FQN '" + EmailFQN  + "'")
            Dim AttachmentsLoaded As Boolean = False

            Try
                ArchiveExchangeEmails(UID, NewGuid,
                                EmailBody,
                                Subject,
                                CcAddr,
                                BccAddr,
                                EmailToAddr,
                                Recipients,
                                ServerName,
                                FromAddress,
                                FromName, CDate(ReceivedDate),
                                UserLoginID, Now, CDate(ReceivedDate),
                                DB_ID,
                                CurrMailFolder,
                                Server_UserID_StoreID,
                                retentionYears,
                                RetentionCode,
                                EmailSize,
                                AttachedFiles,
                                EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)
            Catch ex As System.Exception

                imap.Expunge()
                imap.Disconnect()

                LOG.WriteToArchiveLog("ERROR ApplyIMapBundle 100 : " + ex.Message)
            End Try

NextRec:
            If LibraryName.Trim.Length > 0 Then

            End If
            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 1000: " + I.ToString)
        Next

        bundle = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

        ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, 99)
        Dim ConversionDir As String = LOG.getEnvVarSpecialFolderLocalApplicationData + "\WMCONVERT"
        ApplyPendingEmail(UID, ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode)
        frmExchangeMonitor.lblMessageInfo.Text = "Download complete."
    End Sub

    Function ReadEmailUsingSSL(ByVal UID As String, ByVal ServerName As String,
                          ByVal UserLoginID As String,
                          ByVal LoginPassWord As String,
                          ByVal PortNbr As Integer,
                          ByVal LeaveOnServer As Boolean,
                          ByVal retentionYears As Integer,
                          ByVal RetentionCode As String, ByVal LibraryName As String, ByVal isPublic As Boolean, ByVal DaysToRetain As Integer, ByVal strReject As String, ByVal bEmlToMSG As Boolean) As Boolean
        ' Create a mailman object for reading email.

        Dim RC As Boolean = False
        LOG.WriteToArchiveLog("ReadEmailUsingSSL 1000")

        Dim mailman As New Chilkat.MailMan()
        Dim EmailFrom As String = ""
        Dim EmailSubject As String = ""
        Dim EmailBody As String = ""
        Dim EmailFromAddress = ""
        Dim EmailFromName = ""

        ' Any string passed to UnlockComponent automatically begins a 30-day trial.
        Dim success As Boolean
        success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
        If (success <> True) Then
            If gRunUnattended = False Then MessageBox.Show(mailman.LastErrorText)
            Return False
        End If

        ' Set our POP3 hostname, login and password
        mailman.MailHost = ServerName
        mailman.PopUsername = UserLoginID
        mailman.PopPassword = LoginPassWord

        ' Indicate that the TCP/IP connection with the POP3 server should be SSL. All POP3
        ' communications are secure using SSL.
        mailman.PopSsl = True
        ' Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
        'mailman.MailPort = 995
        mailman.MailPort = PortNbr

        Dim SuccessfulRun As Boolean = False
        SuccessfulRun = ApplyEmailBundleV2(UID, mailman, ServerName, UserLoginID, LoginPassWord, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG)
        If Not SuccessfulRun Then
            ApplyEmailBundle(UID, mailman, ServerName, UserLoginID, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG)
        End If

    End Function

    Sub DownloadEmailAndForward(ByVal MailHost As String,
                                ByVal PopUsername As String,
                                ByVal PopPassword As String,
                                ByVal UseSameLogin As Boolean,
                                ByVal SmtpHost As String,
                                ByVal SmtpUsername As String,
                                ByVal SmtpPassword As String,
                                ByRef ForwardToEmail As String,
                                ByRef ForwardToEmail2 As String)
        ' Read email from a POP3 server and return the complete MIME source of each email. The emails
        ' downloaded from the POP3 server are not loaded into Chilkat.Email objects, therefore they
        ' are not parsed, unwrapped (for encrypted/signed email), or modified in any way.
        Dim mailman As New Chilkat.MailMan
        mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")

        mailman.MailHost = MailHost
        mailman.PopUsername = PopUsername
        mailman.PopPassword = PopPassword

        ' We'll need the SMTP hostname and (optionally) the login to send email...
        If UseSameLogin = True Then
            mailman.SmtpHost = SmtpHost
            mailman.SmtpUsername = PopUsername
            mailman.SmtpPassword = PopPassword
        Else
            mailman.SmtpHost = SmtpHost
            mailman.SmtpUsername = SmtpUsername
            mailman.SmtpPassword = SmtpPassword
        End If

        ' Get the EntryIDs of all the mail messages on the POP3 server.
        Dim allEntryIDs As Chilkat.StringArray
        allEntryIDs = mailman.GetUidls()

        ' mimeArr is an object containing collection of strings
        Dim mimeArr As Chilkat.StringArray
        ' Download the entire mailbox. Call FetchMultipleMime to leave the email on the server. Call
        ' TransferMultipleMime to download and remove from the server.
        mimeArr = mailman.TransferMultipleMime(allEntryIDs)
        'mimeArr = mailman.FetchMultipleMime(allEntryIDs)

        ' Show how many emails were downloaded.
        MessageBox.Show(mimeArr.Count)

        ' Forward each email to another recipient.
        Dim i As Integer
        Dim success As Boolean
        For i = 0 To mimeArr.Count
            success = mailman.SendMime(ForwardToEmail, ForwardToEmail2, mimeArr.GetString(i))
            If (Not success) Then
                MessageBox.Show(mailman.LastErrorText)
                ' ... do whatever else you want...
            End If
        Next
    End Sub

    Sub ReadXmlEmailData(ByVal FQN As String)
        Try
            Dim reader As New XmlTextReader(FQN)

            'message-id

            While reader.Read()
                Dim AttrName As String = reader.Name
                If gClipBoardActive = True Then Console.WriteLine("nbr elements: " + reader.AttributeCount.ToString)
                If gClipBoardActive = True Then Console.WriteLine("reader.GetAttribute: " + reader.GetAttribute("message-id").ToString())
                If reader.HasValue Then
                    Console.WriteLine("Name: " + reader.Name)
                    Console.WriteLine("LocalName: " + reader.LocalName)
                    Console.WriteLine("SchemaAttribute.Name: " + reader.SchemaInfo.SchemaAttribute.Name.ToString)
                    Console.WriteLine("ReadAttributeValue : " + reader.ReadAttributeValue.ToString)
                    Console.WriteLine("ReadString : " + reader.ReadString)
                    Console.WriteLine("Value : " + reader.Value)
                    'Console.WriteLine(reader.GetAttribute(AttrName ))
                End If
            End While
        Catch e As System.Exception
            Console.WriteLine("Exception: {0}", e.ToString())
        End Try
    End Sub

    Sub ReadXmlFileIntoDataSet(ByVal FQN As String)
        Dim xmlFile As XmlReader
        xmlFile = XmlReader.Create(FQN, New XmlReaderSettings())
        Dim ds As New DataSet
        ds.ReadXml(xmlFile)

        Dim K As Integer = ds.Tables(0).Rows.Count
        Dim i As Integer = 0
        For i = 0 To ds.Tables(0).Rows.Count - 1
            Console.WriteLine(ds.Tables(0).Rows(i).Item(1))
        Next

        ds.Dispose()
        ds = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    Sub ReadXmlFile(ByVal FQN As String)
        Dim reader As XmlTextReader = Nothing

        Try
            'Load the reader with the XML file.
            reader = New XmlTextReader(FQN)

            'Read the ISBN attribute.
            reader.MoveToContent()

            Dim MessageID As String = reader.GetAttribute("message-id")
            Console.WriteLine("The MessageID value: " & MessageID)
        Finally
            If Not (reader Is Nothing) Then
                reader.Close()
            End If
        End Try

    End Sub

    Sub deleteFile(ByVal FQN As String)
        Try
            System.IO.File.Delete(FQN)
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteFile - failed to delete file '" + FQN + "'.")
            LOG.WriteToArchiveLog("DELETE FAILURE 04|" + FQN)
        End Try
    End Sub

    Sub getImapEmailSSL(ByVal UID As String, ByVal MailServerAddr As String, ByVal PortNbr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer,
                            ByVal LibraryName As String,
                            ByVal isPublic As Boolean,
                            ByVal DaysToHold As Integer,
                            ByVal strReject As String,
                            ByVal bEmlToMSG As Boolean,
                            ByVal UseSSL As Boolean)

        LOG.WriteToArchiveLog("getImapEmailSSL 100")
        Dim LL As Integer = 1
        Dim imap As New Chilkat.Imap()
        Dim RejectedCount As Integer = 0
        Dim messageSet As Chilkat.MessageSet
        Dim bundle As Chilkat.EmailBundle

        Try
            LL = 2
            Dim ServerName As String = MailServerAddr + ":" + UserLoginID
            LL = 3

            LL = 4

            LL = 5
            Dim success As Boolean = False
            LL = 6
            Dim TempDir As String = System.IO.Path.GetTempPath
            LL = 7
            Dim AttachmentDir As String = TempDir + "Email\Attachment"
            LL = 8
            Dim EmailDir As String = TempDir + "Email"
            LL = 9
            Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID
            LL = 10

            LL = 11
            Dim DownLoadSize As Integer = 0
            LL = 12
            Dim sDownLoadSize As String = ""
            LL = 13
            Dim Increment As Integer = 0
            LL = 14
            Dim NbrDaysOld As Integer = 0
            LL = 15

            LL = 16
            Try
                LL = 17
                sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings("EmailDownLoadSize")
                LL = 18
                DownLoadSize = Val(sDownLoadSize)
                LL = 19
            Catch ex As System.Exception
                DownLoadSize = 100

            End Try
            LL = 22

            LL = 23
            If DownLoadSize = 0 Then
                DownLoadSize = 2500
                LL = 25
            End If
            LL = 26
            Increment = DownLoadSize
            LL = 27

            LL = 28
            ' Anything unlocks the component and begins a fully-functional 30-day trial.
            LL = 29
            success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
            LL = 30
            If (success <> True) Then
                LL = 31
                MessageBox.Show(imap.LastErrorText)
                LL = 32
                Exit Sub
                LL = 33
            End If
            LL = 34

            LL = 35
            ' To use a secure SSL connection, set SSL and the port:
            LL = 36
            imap.Ssl = UseSSL
            LL = 37
            ' The typical port for IMAP SSL is 993
            LL = 38
            If PortNbr.Length = 0 Then
                LL = 39
                imap.Port = 993
                LL = 40
            Else
                LL = 41
                imap.Port = Val(PortNbr)
                LL = 42
            End If
            LL = 43

            LL = 44
            ' Connect to an IMAP server.
            LL = 45
            success = imap.Connect(MailServerAddr)
            LL = 46
            If (success <> True) Then
                LL = 47
                LOG.WriteToArchiveLog("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText)
                LL = 48
                Exit Sub
            Else
                LL = 49
                ''frmExchangeMonitor.txtArchivedFiles.Text = "Login: " + UserLoginID  + " successful."
                ''frmExchangeMonitor.txtArchivedFiles.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            LOG.WriteToArchiveLog("getImapEmailSSL 200")
            LL = 53
            success = imap.Login(UserLoginID, LoginPassWord)
            LL = 54
            If (success <> True) Then
                LL = 55
                LOG.WriteToArchiveLog("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText)
                ''frmExchangeMonitor.txtArchivedFiles.Text = "FAILED Login: " + UserLoginID  + " successful."
                ''frmExchangeMonitor.txtArchivedFiles.Refresh()
                System.Windows.Forms.Application.DoEvents()
                LL = 56
                Exit Sub
            Else
                LL = 57
                ''frmExchangeMonitor.txtArchivedFiles.Text = "Login: " + UserLoginID  + " successful."
                ''frmExchangeMonitor.txtArchivedFiles.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            LL = 58

            LOG.WriteToArchiveLog("getImapEmailSSL 300")
            success = imap.SelectMailbox("Inbox")
            LL = 62
            If (success <> True) Then
                LL = 63
                LOG.WriteToArchiveLog("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText)
                LL = 64
                Exit Sub
                LL = 65
            End If
            System.Windows.Forms.Application.DoEvents()
            Dim NumberOfMessagesInBox As Integer = imap.NumMessages
            LL = 75
            If NumberOfMessagesInBox > 0 Then
                LL = 76
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                LL = 77
            Else
                LL = 78
                LOG.WriteToArchiveLog("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                LL = 79
                GoTo ENDIT
                LL = 80
            End If
            LL = 81

            Dim startSeqNum As Long
            startSeqNum = 1
            Dim numToFetch As Long
            numToFetch = DownLoadSize
            LL = 97
            Dim ExitUponCompletion As Boolean = False
            LL = 98
            Dim fetchUids As Boolean = True
            LL = 100
            Dim NbrOfTries As Integer = 1
            LL = 101
REDO:
            If NbrOfTries >= 3 Then
                LL = 103
                GoTo ENDIT
                LL = 104
            End If
            LL = 105
            If numToFetch > NumberOfMessagesInBox Then
                LL = 125
                numToFetch = NumberOfMessagesInBox
                LL = 126
            End If
            LL = 127
            bundle = imap.FetchSequence(startSeqNum, numToFetch)
            LL = 128
            'End If
            LL = 129

            LOG.WriteToArchiveLog("getImapEmailSSL 400")
            If (bundle Is Nothing) Then
                LL = 132
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400a: " + imap.LastErrorText)
                LL = 133
                LOG.WriteToArchiveLog("        getImapEmailSSL 400b: startSeqNum - " + startSeqNum.ToString)
                LL = 134
                LOG.WriteToArchiveLog("        getImapEmailSSL 400c: numToFetch - " + numToFetch.ToString)
                LL = 135
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400d: messages in mailbox: " + NumberOfMessagesInBox.ToString)
                LL = 136
                NbrOfTries = NbrOfTries + 1
                LL = 137
                GoTo REDO
                LL = 138
            End If
            LL = 139

            LOG.WriteToArchiveLog("getImapEmailSSL 500")
            LL = 160
            LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL #emails = " + NumberOfMessagesInBox.ToString)
            LL = 161

            System.Windows.Forms.Application.DoEvents()
            LL = 170
            Dim MessagesProcessed As Integer = 0
            LL = 171
            Dim MessagesRemainingToProcess As Integer = NumberOfMessagesInBox
            LL = 172
            Dim i As Long
            LL = 174
            TotalEmailsInArchive = 0
            LL = 175
            LOG.WriteToArchiveLog("getImapEmailSSL 600")
            Do While MessagesRemainingToProcess > 0
                LL = 176

                LOG.WriteToArchiveLog("getImapEmailSSL 700")
                For i = 0 To bundle.MessageCount - 1

                    TotalEmailsInArchive += 1
                    LL = 180
                    MessagesRemainingToProcess = MessagesRemainingToProcess - 1
                    LL = 183
                    frmExchangeMonitor.lblMessageInfo.Text = "Msg: " + TotalEmailsInArchive.ToString
                    frmExchangeMonitor.Refresh()
                    frmMain.tbExchange.Text = "Email# " + i.ToString
                    System.Windows.Forms.Application.DoEvents()
                    LL = 185

                    LL = 186
                    Dim NewGuid As String = System.Guid.NewGuid.ToString()
                    LL = 188
                    Dim email As Chilkat.Email
                    LL = 189
                    email = bundle.GetEmail(i)
                    LL = 190
                    Dim EntryID As String = email.Uidl
                    LL = 191
                    Dim Subject As String = email.Subject
                    Subject = UTIL.RemoveSingleQuotes(Subject)
                    LL = 192
                    Dim EmailFrom As String = email.From
                    LL = 193
                    Dim FromAddress As String = email.FromAddress
                    LL = 194
                    Dim FromName As String = email.FromName
                    LL = 195
                    Dim From As String = email.From
                    LL = 196

                    LL = 197
                    If strReject.Trim.Length > 0 Then
                        LL = 198
                        Dim A As String() = strReject.Split(",")
                        LL = 199
                        For II As Integer = 0 To UBound(A)
                            LL = 200
                            Dim S1 As String = A(II).Trim
                            LL = 201
                            If S1.Trim.Length > 0 Then
                                LL = 202
                                If InStr(Subject, S1, CompareMethod.Text) Then
                                    LL = 203
                                    'LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                    LL = 204
                                    RejectedCount += 1
                                    LL = 205
                                    GoTo NextRec
                                    LL = 206
                                End If
                                LL = 207
                            End If
                            LL = 208
                        Next
                        LL = 209
                    End If
                    LL = 210

                    LL = 211
                    NbrDaysOld = email.NumDaysOld
                    LL = 212
                    If NbrDaysOld >= DaysToHold Then
                        LL = 213
                        success = imap.SetMailFlag(email, "Deleted", 1)
                        LL = 214
                        If (success <> True) Then
                            LL = 215
                            Dim Msg As String = "Subject: " + Subject + environment.NewLine
                            LL = 216
                            Msg += "FromName: " + FromName + environment.NewLine
                            LL = 217
                            Msg += "FromAddress: " + FromAddress + environment.NewLine
                            LL = 218
                            LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                            LL = 219
                        End If
                        LL = 220
                    End If
                    LL = 221

                    LL = 222
                    Dim NumAlternatives As Integer = email.NumAlternatives
                    LL = 223
                    Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                    LL = 224
                    Dim NumAttachments As Integer = email.NumAttachments
                    LL = 225
                    Dim NumBcc As Integer = email.NumBcc
                    LL = 226
                    Dim NumCC As Integer = email.NumCC
                    LL = 227
                    Dim NumTo As Integer = email.NumTo
                    LL = 228
                    Dim ReplyTo As String = email.ReplyTo
                    LL = 229
                    Dim SignedBy As String = email.SignedBy
                    LL = 230
                    Dim EmailSize As Integer = email.Size
                    LL = 231
                    Dim LocalDate As String = email.LocalDate.ToString
                    LL = 232
                    Dim EmailDate As String = email.EmailDate.ToString
                    LL = 233
                    Dim Header As String = email.Header
                    LL = 234
                    Dim EmailBody As String = email.Body
                    LL = 235
                    EmailBody = UTIL.RemoveSingleQuotes(EmailBody)
                    LL = 236

                    LL = 237
                    Dim Recipients As New ArrayList
                    LL = 238
                    Dim EmailTo As New ArrayList
                    LL = 239
                    Dim EmailToAddr As New ArrayList
                    LL = 240
                    Dim EmailToName As New ArrayList
                    LL = 241
                    Dim Bcc As New ArrayList
                    LL = 242
                    Dim BccAddr As New ArrayList
                    LL = 243
                    Dim BccName As New ArrayList
                    LL = 244
                    Dim CC As New ArrayList
                    LL = 245
                    Dim CcAddr As New ArrayList
                    LL = 246
                    Dim CcName As New ArrayList
                    LL = 247
                    Dim bLoadAttachments As Boolean = False
                    LL = 248

                    LL = 249
                    Dim J As Integer = 0
                    LL = 250

                    LL = 251
                    Dim tEmailDate As String = EmailDate.ToString
                    LL = 252
                    FixDate(tEmailDate)
                    LL = 253
                    Dim tSubject As String = Mid(Subject, 1, 100)
                    LL = 254
                    RemoveBadChars(tSubject)
                    LL = 255

                    Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject)
                    Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                    Dim bEmailExists As Boolean = ExchangeEmailExists(EmailIdentifier)
                    LL = 260
                    If bEmailExists Then
                        LL = 261

                        LL = 262
                        '''frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
                        LL = 263
                        '''frmExchangeMonitor.lblMessageInfo.Refresh()
                        LL = 264
                        System.Windows.Forms.Application.DoEvents()
                        LL = 265

                        LL = 266
                        Dim DaysOld As Integer = email.NumDaysOld
                        LL = 267
                        If DaysOld > DaysToHold Then
                            LL = 268
                            success = imap.SetMailFlag(email, "Deleted", 1)
                            LL = 269
                            If (success <> True) Then
                                LL = 270
                                Dim Msg As String = "Subject: " + Subject + environment.NewLine
                                LL = 271
                                Msg += "FromName: " + FromName + environment.NewLine
                                LL = 272
                                Msg += "FromAddress: " + FromAddress + environment.NewLine
                                LL = 273
                                LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                                LL = 274
                            End If
                            LL = 275
                        End If
                        LL = 276

                        LL = 277
                        Return
                        LL = 278
                    End If
                    LL = 279

                    LL = 280
                    'Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
                    Dim B As Boolean = ExchangeEmailExists(EmailIdentifier)
                    LL = 282
                    If B Then
                        LL = 283
                        GoTo NextRec
                        LL = 285
                    End If
                    LL = 286

                    LL = 287
                    Dim EmailFQN As String = EmailDir + "\Email~" & NewGuid + "~.EML"
                    LL = 288

                    LL = 289
                    LL = 290
                    If NumAttachments > 0 Then
                        LL = 291
                        '** Clean out the directory
                        LL = 292
                        UTIL.deleteDirectoryFile(AttachmentDir)
                        LL = 293
                        ' Save attachments to the "attachments" directory.
                        LL = 294
                        email.SaveAllAttachments(AttachmentDir)
                        LL = 295
                        bLoadAttachments = True
                        LL = 296
                    End If
                    LL = 297

                    LL = 298
                    If NumAttachedMessages > 0 Then
                        LL = 299
                        'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                        LL = 300
                        For II As Integer = 0 To NumAttachedMessages - 1
                            LL = 301
                            'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                            LL = 302
                            Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                            LL = 303
                            ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                            LL = 304
                            objEmail = Nothing
                            LL = 305
                        Next
                        LL = 306
                    End If
                    LL = 307

                    LL = 308
                    For J = 0 To NumCC - 1
                        LL = 309
                        CC.Add(email.GetCC(J).ToString)
                        LL = 310
                        CcAddr.Add(email.GetCcAddr(J).ToString)
                        LL = 311
                        CcName.Add(email.GetCcName(J).ToString)
                        LL = 312
                        If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                            LL = 313
                            Recipients.Add(email.GetCcAddr(J).ToString)
                            LL = 314
                        End If
                        LL = 315
                    Next
                    LL = 316
                    For J = 0 To NumBcc - 1
                        LL = 317
                        Bcc.Add(email.GetBcc(J).ToString)
                        LL = 318
                        BccName.Add(email.GetBccName(J).ToString)
                        LL = 319
                        BccAddr.Add(email.GetBccAddr(J).ToString)
                        LL = 320
                        If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                            LL = 321
                            Recipients.Add(email.GetBccAddr(J).ToString)
                            LL = 322
                        End If
                        LL = 323
                    Next
                    LL = 324
                    For J = 0 To NumTo - 1
                        LL = 325
                        EmailTo.Add(email.GetTo(J).ToString)
                        LL = 326
                        EmailToAddr.Add(email.GetToAddr(J).ToString)
                        LL = 327
                        EmailToName.Add(email.GetToName(J).ToString)
                        LL = 328
                        If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                            LL = 329
                            Recipients.Add(email.GetToAddr(J).ToString)
                            LL = 330
                        End If
                        LL = 331
                    Next
                    LL = 332
                    email.SaveEml(EmailFQN)
                    LL = 348
                    If bEmlToMSG = True Then
                        LL = 349
                        LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN '" + EmailFQN + "'")
                        LL = 350
                        EmailFQN = convertEmlToMsg(EmailFQN)
                        LL = 351
                    End If
                    LL = 352
                    '**********************************************************
                    Dim AttachedFiles As New List(Of String)
                    LL = 357
                    getDirectoryFiles(AttachmentDir, AttachedFiles)
                    LL = 358

                    LL = 359
                    Dim DB_ID As String = "ECM.Library"
                    LL = 360
                    Dim Server_UserID_StoreID As String = CurrMailFolder
                    LL = 361

                    LL = 362
                    '** Now, Load the EMAIL and its metadata into the repository
                    LL = 363
                    Dim AttachmentsLoaded As Boolean = False
                    LL = 366

                    LOG.WriteToArchiveLog("getImapEmailSSL 800")
                    ArchiveExchangeEmails(UID, NewGuid,
                        EmailBody,
                        Subject,
                        CcAddr,
                        BccAddr,
                        EmailToAddr,
                        Recipients,
                        MailServerAddr,
                        FromAddress,
                        FromName,
                        CDate(EmailDate),
                        UserLoginID,
                        CDate(LocalDate),
                        CDate(EmailDate),
                        DB_ID,
                        CurrMailFolder,
                        Server_UserID_StoreID,
                        retentionYears,
                        RetentionCode,
                        EmailSize,
                        AttachedFiles,
                        EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)
                    LL = 389

                    LOG.WriteToArchiveLog("getImapEmailSSL 900")
                    If AttachmentsLoaded = True Then
                        LL = 391
                        Dim DoThis As Boolean = False
                        LL = 392
                        If DoThis Then
                            LL = 393
                            If AttachmentsLoaded = True Then
                                LL = 394
                                AppendOcrTextEmail(NewGuid)
                                LL = 395
                                AttachmentsLoaded = False
                                LL = 396
                            End If
                            LL = 397
                        End If
                        LL = 398
                    End If
                    LL = 399

                    LL = 400
NextRec:
                    LL = 401

                Next
                LL = 404
                '*****************************************************************************
                LL = 405
                If ExitUponCompletion = True Then
                    LL = 406
                    Exit Do
                    LL = 407
                End If
                LL = 408
                If DownLoadSize > MessagesRemainingToProcess Then
                    LL = 409
                    DownLoadSize = MessagesRemainingToProcess
                    LL = 410
                    'Increment = MessagesRemainingToProcess
                    LL = 411
                    numToFetch = MessagesRemainingToProcess
                    LL = 412
                Else
                    LL = 413
                    numToFetch = DownLoadSize
                    LL = 414
                End If
                LL = 415
                startSeqNum = startSeqNum + Increment
                LL = 416

                LL = 417

                LL = 418
                If numToFetch > 0 Then
                    LL = 419
                    bundle = imap.FetchSequence(startSeqNum, numToFetch)
                    LL = 420
                    If (bundle Is Nothing) Then
                        LL = 421
                        LOG.WriteToArchiveLog("Warning - termination - getImapEmailSSL 400: End of process.")
                        LL = 422
                        Exit Do
                        LL = 423
                    End If
                    LL = 424
                End If
                LL = 425

                LL = 426
            Loop
            LL = 427
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 100 getImapEmailSSL: LL = " + LL.ToString + ": " + ex.Message)
        End Try

ENDIT:
        imap.Expunge()

        LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString)

        ' Disconnect from the IMAP server.
        imap.Disconnect()

        messageSet = Nothing
        imap = Nothing
        bundle = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

        'LOG.WriteToArchiveLog("getImapEmailSSL 1000")

    End Sub

    Sub getIMapEmail(ByVal UID As String, ByVal MailServerAddr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer, ByVal LibraryName As String, ByVal isPublic As Boolean, ByVal DaysToRetain As Integer, ByVal strReject As String, ByVal bEmlToMSG As Boolean)

        LOG.WriteToArchiveLog("getIMapEmail 100")

        ' Create an object, connect to the IMAP server, login, and select a mailbox.
        Dim imap As New Chilkat.Imap()
        imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
        imap.Connect(MailServerAddr)
        imap.Login(UserLoginID, LoginPassWord)
        imap.SelectMailbox("Inbox")

        Dim J As Integer = 0

        LOG.WriteToArchiveLog("getIMapEmail 200")

        ' Get a message set containing all the message IDs in the selected mailbox.
        Dim msgSet As Chilkat.MessageSet
        msgSet = imap.Search("ALL", 1)

        ' Fetch all the mail into a bundle object.
        Dim bundle As New Chilkat.EmailBundle()
        Try
            bundle = imap.FetchBundle(msgSet)
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("NOTICE: getIMapEmail 100 - " + ex.Message)
            Return
        End Try

        If bundle Is Nothing Then
            LOG.WriteToArchiveLog("Applying IMAP Bundle - No messages at this time.")
            Return
        End If

        LOG.WriteToArchiveLog("getIMapEmail 300")

        ' Loop over the bundle and display the From and Subject.
        Dim i As Long
        Dim RecjectCount As Integer = 1
        Try
            LOG.WriteToArchiveLog("Applying IMAP Bundle Message Count = " + bundle.MessageCount.ToString)
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("WARNING: Applying IMAP Bundle Message Count = UNKNOWN.")
        End Try
        frmMain.SB.Text = "Processing Exchange servers: " & bundle.MessageCount
        LOG.WriteToArchiveLog("getIMapEmail 400")
        For i = 0 To bundle.MessageCount - 1
            Try
                Dim NewGuid As String = System.Guid.NewGuid.ToString()

                Dim email As Chilkat.Email
                email = bundle.GetEmail(i)

                Dim Subject As String = email.Subject

                Dim EmailFrom As String = email.From
                Dim FromAddress As String = email.FromAddress
                Dim FromName As String = email.FromName
                Dim From As String = email.From

                If strReject.Trim.Length > 0 Then
                    Dim A As String() = strReject.Split(",")
                    For II As Integer = 0 To UBound(A)
                        Dim S1 As String = A(II).Trim
                        If S1.Trim.Length > 0 Then
                            If InStr(Subject, S1, CompareMethod.Text) Then
                                RecjectCount += 1
                                GoTo NextRec
                            End If
                        End If
                    Next
                End If

                Dim NbrDaysOld As Integer = email.NumDaysOld
                If NbrDaysOld > DaysToRetain Then
                    Dim success As Boolean = imap.SetMailFlag(email, "Deleted", 1)
                    If (success <> True) Then
                        Dim Msg As String = "Subject: " + Subject + environment.NewLine
                        Msg += "FromName: " + FromName + environment.NewLine
                        Msg += "FromAddress: " + FromAddress + environment.NewLine
                        LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                    End If
                End If

                Dim NumAlternatives As Integer = email.NumAlternatives
                Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                Dim NumAttachments As Integer = email.NumAttachments
                Dim NumBcc As Integer = email.NumBcc
                Dim NumCC As Integer = email.NumCC
                Dim NumTo As Integer = email.NumTo
                Dim ReplyTo As String = email.ReplyTo
                Dim SignedBy As String = email.SignedBy
                Dim EmailSize As Integer = email.Size
                Dim LocalDate As String = email.LocalDate.ToString
                Dim EmailDate As String = email.EmailDate.ToString
                Dim Header As String = email.Header
                Dim EmailBody As String = email.Body

                Dim Recipients As New ArrayList
                Dim EmailTo As New ArrayList
                Dim EmailToAddr As New ArrayList
                Dim EmailToName As New ArrayList
                Dim Bcc As New ArrayList
                Dim BccAddr As New ArrayList
                Dim BccName As New ArrayList
                Dim CC As New ArrayList
                Dim CcAddr As New ArrayList
                Dim CcName As New ArrayList
                Dim bLoadAttachments As Boolean = False

                Dim TempDir As String = System.IO.Path.GetTempPath
                Dim AttachmentDir As String = TempDir + "Email\Attachment"
                Dim EmailDir As String = TempDir + "Email"
                Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID

                Dim tEmailDate As String = EmailDate.ToString
                FixDate(tEmailDate)
                Dim tSubject As String = Mid(Subject, 1, 100)
                RemoveBadChars(tSubject)

                Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject)
                Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                Dim B As Boolean = ExchangeEmailExists(EmailIdentifier)
                If B Then
                    If dDebug_clsEmailFunctions Then LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + i.ToString)
                    GoTo NextRec
                End If

                Dim EmailFQN As String = TempDir + "EMAIL." + NewGuid + ".MSG"

                'Console.WriteLine(Header)
                If dDebug_clsEmailFunctions Then LOG.WriteToArchiveLog("ApplyIMapBundle 800: " + i.ToString)
                If NumAttachments > 0 Then
                    '** Clean out the directory
                    DMA.deleteDirectoryFiles(AttachmentDir)
                    ' Save attachments to the "attachments" directory.
                    email.SaveAllAttachments(AttachmentDir)
                    bLoadAttachments = True
                End If

                For J = 0 To NumCC - 1
                    CC.Add(email.GetCC(J).ToString)
                    CcAddr.Add(email.GetCcAddr(J).ToString)
                    CcName.Add(email.GetCcName(J).ToString)
                    If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                        Recipients.Add(email.GetCcAddr(J).ToString)
                    End If
                Next
                For J = 0 To NumBcc - 1
                    Bcc.Add(email.GetBcc(J).ToString)
                    BccName.Add(email.GetBccName(J).ToString)
                    BccAddr.Add(email.GetBccAddr(J).ToString)
                    If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                        Recipients.Add(email.GetBccAddr(J).ToString)
                    End If
                Next
                For J = 0 To NumTo - 1
                    EmailTo.Add(email.GetTo(J).ToString)
                    EmailToAddr.Add(email.GetToAddr(J).ToString)
                    EmailToName.Add(email.GetToName(J).ToString)
                    If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                        Recipients.Add(email.GetToAddr(J).ToString)
                    End If
                Next

                ' Save the email to XML
                'email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

                ' Save the email to EML
                'Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                If dDebug_clsEmailFunctions Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.0: " + i.ToString)
                email.SaveEml(EmailFQN)

                '**********************************************************
                'IF CONVERT TO MSG THEN
                'READ IN THE NEW EML
                'CONVERT IT TO MSG
                'WRITE OUT THE MSG
                'SAVE THE MSG IMAGE INTO THE REPOSITORY.

                If bEmlToMSG = True Then
                    Try
                        EmailFQN = convertEmlToMsg(EmailFQN)
                        If EmailFQN.Length = 0 Then
                            GoTo NextRec
                        End If
                    Catch ex As System.Exception
                        LOG.WriteToArchiveLog("ERROR getIMapEmail 300.20 : " + ex.Message)
                    End Try

                    If EmailFQN.Trim.Length = 0 Then
                        LOG.WriteToArchiveLog("Unrecoverable Error: getImapEmail - failed to convert EML to MSG File.")
                        LOG.WriteToArchiveLog("NOTE : Most likely the Redemption DLL is not installed properly")
                        GoTo NextRec
                    End If
                End If

                '**********************************************************

                If dDebug_clsEmailFunctions Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.1: " + i.ToString)
                Dim AttachedFiles As New List(Of String)
                getDirectoryFiles(AttachmentDir, AttachedFiles)

                Dim DB_ID As String = "ECM.Library"
                Dim Server_UserID_StoreID As String = CurrMailFolder

                '** Now, Load the EMAIL and its metadata into the repository
                If dDebug_clsEmailFunctions Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + i.ToString)
                Dim AttachmentsLoaded As Boolean = False
                ArchiveExchangeEmails(UID, NewGuid,
                                EmailBody,
                                Subject,
                                CcAddr,
                                BccAddr,
                                EmailToAddr,
                                Recipients,
                                ServerName,
                                FromAddress,
                                FromName, CDate(EmailDate),
                                UserLoginID, Now, CDate(EmailDate),
                                DB_ID,
                                CurrMailFolder,
                                Server_UserID_StoreID,
                                retentionYears,
                                RetentionCode,
                                EmailSize,
                                AttachedFiles,
                                email.Uidl, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)
NextRec:
                If dDebug_clsEmailFunctions Then LOG.WriteToArchiveLog("ApplyIMapBundle 1000: " + i.ToString)
            Catch ex As System.Exception
                LOG.WriteToArchiveLog("ERROR getIMapEmail 300.21 : " + ex.Message)
            End Try

        Next

        ' Save the email to an XML file
        'bundle.SaveXml("bundle.xml")

        LOG.WriteToArchiveLog("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString)

        ' Disconnect from the IMAP server. This example leaves the email on the IMAP server.
        imap.Disconnect()
    End Sub

    Sub SendImapEmailGmail()
        Dim mailman As New Chilkat.MailMan()

        ' Any string argument automatically begins the 30-day trial.
        Dim success As Boolean
        success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
        If (success <> True) Then
            If gRunUnattended = False Then MessageBox.Show("Component unlock failed")
            Exit Sub
        End If

        ' Use the GMail SMTP server
        mailman.SmtpHost = "smtp.gmail.com"
        mailman.SmtpPort = 587
        mailman.StartTLS = True

        ' Set the SMTP login/password.
        mailman.SmtpUsername = "wdalemiller"
        mailman.SmtpPassword = "Wdmsdm01"

        ' Create a new email object
        Dim email As New Chilkat.Email()

        email.Subject = "This is a test"
        email.Body = "This is a test"
        'email.From = "wdalemiller@gmail.com"
        email.From = "support@EcmLibrary.com"
        email.AddTo("W. Dale Miller", "dale@EcmLibrary.com")
        email.AddTo("Dale Miller", "dale@javamasters.net")
        email.AddTo("D. Miller", "dm@dmachicago.com")

        success = mailman.SendEmail(email)
        If (success <> True) Then
            If gRunUnattended = False Then MessageBox.Show(mailman.LastErrorText)
            Exit Sub
        End If

        If gRunUnattended = False Then MessageBox.Show("Mail Sent!")

    End Sub

    Public Sub readPst(ByVal pstFilePath As String, ByVal pstName As String, ByVal StoreIndexNbr As Integer)

        Dim mailItems As New LinkedList(Of String)
        Dim objOL As Microsoft.Office.Interop.Outlook.Application
        Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
        Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder

        objOL = CreateObject("Outlook.Application")
        objNS = objOL.GetNamespace("MAPI")

        '** Add PST file (Outlook Data File) to Default Profile
        objNS.AddStore(pstFilePath)

        objFolder = objNS.Folders.GetLast
        objFolder.Name = pstName

        Dim rootFolder As Microsoft.Office.Interop.Outlook.MAPIFolder = objNS.Stores(StoreIndexNbr).GetRootFolder
        '** Traverse through all folders in the PST file
        '** TODO: This is not recursive, refactor
        Dim Folder As Microsoft.Office.Interop.Outlook.Folder
        Dim subFolder As Microsoft.Office.Interop.Outlook.Folders

        For Each Folder In rootFolder.Folders
            Console.WriteLine("rootFolder: " + rootFolder.Name)
            Console.WriteLine("rootFolder: " + rootFolder.EntryID)
            Console.WriteLine("Folder: " + Folder.Name)
            Console.WriteLine("Folder EntryID: " + Folder.EntryID)
            Console.WriteLine("Folder Items.Count: " + Folder.Items.Count)
            Dim item As Microsoft.Office.Interop.Outlook.MailItem

            For Each item In Folder.Items
                Console.WriteLine("Subject: " + item.Subject)
            Next
        Next
    End Sub

    Sub SetNewStore(ByVal strFileName As String, ByVal strDisplayName As String)

        Dim objOL As Microsoft.Office.Interop.Outlook.Application
        Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
        Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder

        objOL = CreateObject("Outlook.Application")
        objNS = objOL.GetNamespace("MAPI")
        objNS.AddStore(strFileName)
        objFolder = objNS.Folders.GetLast
        objFolder.Name = strDisplayName

        objOL = Nothing
        objNS = Nothing
        objFolder = Nothing
    End Sub

    Function convertEmlToMsg(ByVal EmlFQN As String) As String

        Dim LL As Integer = 0

        If File.Exists(EmlFQN + ".MSG") Then
            LOG.WriteToArchiveLog("NOTICE: convertEmlToMsg: '" + EmlFQN + "' already processed, skipping.")
            Return ""
            File.Delete(EmlFQN + ".MSG")
        End If

        File.Copy(EmlFQN, EmlFQN + ".MSG")
        LL = 1
        Dim EmlToMsgFQN As String = EmlFQN + ".MSG"
        LL = 3
        Try
            LL = 4
            Dim objPost As Microsoft.Office.Interop.Outlook.PostItem
            Dim objSafePost As Redemption.SafePostItem
            Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
            Dim objJunkMailBox As Microsoft.Office.Interop.Outlook.MAPIFolder
            LL = 5
            Dim objOL As Microsoft.Office.Interop.Outlook.Application
            'Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
            LL = 6
            objOL = CreateObject("Outlook.Application")
            objNS = objOL.GetNamespace("MAPI")
            LL = 7
            objJunkMailBox = objNS.GetDefaultFolder(Microsoft.Office.Interop.Outlook.OlDefaultFolders.olFolderDeletedItems)
            objPost = objJunkMailBox.Items.Add(Microsoft.Office.Interop.Outlook.OlItemType.olPostItem)
            LL = 8
            objSafePost = CreateObject("Redemption.SafePostItem")
            LL = 9
            objPost.Save()
            LL = 10
            objSafePost.Item = objPost

            Dim iAttachCnt As Integer = objSafePost.Attachments.Count
            For I As Integer = 0 To iAttachCnt - 1
                Dim SS As String = objSafePost.Attachments(I).FileName
                Console.WriteLine(SS)
            Next

            'For i As Integer = 0 To 100
            '    Console.WriteLine(objSafePost.Fields(0).ToString)
            'Next

            LL = 11
            objSafePost.Import(EmlFQN, Redemption.RedemptionSaveAsType.olRFC822)
            LL = 13
            objSafePost.MessageClass = "IPM.Note"
            LL = 14
            ' remove IPM.Post icon
            objSafePost.Fields(PR_ICON_INDEX) = ""
            LL = 15
            objSafePost.SaveAs(EmlToMsgFQN, Microsoft.Office.Interop.Outlook.OlSaveAsType.olMSG)
            LL = 16
            objSafePost = Nothing
            objPost = Nothing
            objJunkMailBox = Nothing
            objNS = Nothing
            LL = 17
        Catch ex2 As System.Exception
            LOG.WriteToArchiveLog("ERROR FATAL:convertEmlToMsg 100: LL = " + LL.ToString + environment.NewLine + ex2.Message + environment.NewLine + ":" + EmlFQN + environment.NewLine + ":" + EmlToMsgFQN)
            EmlToMsgFQN = ""
        End Try

        LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 200: LL = " + LL.ToString + environment.NewLine + ":" + EmlFQN + environment.NewLine + ":'" + EmlToMsgFQN + "'.")

        If File.Exists(EmlToMsgFQN) Then
            LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 400: EXISTS.")
        Else
            LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 400:DOES NOT EXIST.")

        End If

        Return EmlToMsgFQN

    End Function

    Function ConvertNTEFtoMSG(ByVal EmailGuid As String, ByVal TnefFQN As String) As String

        Dim ToNAme As String = TnefFQN
        For i As Integer = ToNAme.Length To 0 Step -1
            If Mid(ToNAme, i, 1).Equals(".") Then
                Mid(ToNAme, i, 1) = "_"
                Exit For
            End If
        Next

        Dim LL As Integer = 0

        If File.Exists(TnefFQN + ".MSG") Then
            File.Delete(TnefFQN + ".MSG")
        End If

        'F.Copy(TnefFQN, ToNAme + ".MSG")
        LL = 1
        LL = 2
        Dim NtefToMSG As String = ToNAme + "~" + EmailGuid + ".MSG"
        LL = 3

        If File.Exists(NtefToMSG) Then
            File.Delete(NtefToMSG)
        End If

        'F.Copy(TnefFQN, ToNAme + ".MSG")
        LL = 1
        F = Nothing

        Try
            LL = 4
            Dim objPost As Microsoft.Office.Interop.Outlook.PostItem
            Dim objSafePost As Redemption.SafePostItem
            Dim objNS As Microsoft.Office.Interop.Outlook.NameSpace
            Dim objJunkMailBox As Microsoft.Office.Interop.Outlook.MAPIFolder
            LL = 5
            Dim objOL As Microsoft.Office.Interop.Outlook.Application
            'Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
            LL = 6
            objOL = CreateObject("Outlook.Application")
            objNS = objOL.GetNamespace("MAPI")
            LL = 7
            objJunkMailBox = objNS.GetDefaultFolder(Microsoft.Office.Interop.Outlook.OlDefaultFolders.olFolderDeletedItems)
            objPost = objJunkMailBox.Items.Add(Microsoft.Office.Interop.Outlook.OlItemType.olPostItem)
            LL = 8
            objSafePost = CreateObject("Redemption.SafePostItem")
            LL = 9
            objPost.Save()
            LL = 10
            objSafePost.Item = objPost
            LL = 11
            objSafePost.Import(TnefFQN, Redemption.RedemptionSaveAsType.olTNEF)
            LL = 13
            objSafePost.MessageClass = "IPM.Note"
            LL = 14
            ' remove IPM.Post icon
            objSafePost.Fields(PR_ICON_INDEX) = ""
            LL = 15
            objSafePost.SaveAs(NtefToMSG, Microsoft.Office.Interop.Outlook.OlSaveAsType.olMSG)
            LL = 16
            objSafePost = Nothing
            objPost = Nothing
            objJunkMailBox = Nothing
            objNS = Nothing
            LL = 17
        Catch ex2 As System.Exception
            LOG.WriteToArchiveLog("ERROR FATAL:ConvertNTEF 100: LL = " + LL.ToString + environment.NewLine + ex2.Message + environment.NewLine + ":" + TnefFQN + environment.NewLine + ":" + NtefToMSG)
            NtefToMSG = ""
        End Try

        LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 200: LL = " + LL.ToString + environment.NewLine + ":" + TnefFQN + environment.NewLine + ":'" + NtefToMSG + "'.")

        If File.Exists(NtefToMSG) Then
            LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 400: EXISTS as " + NtefToMSG)
        Else
            LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 400:DOES NOT EXIST.")

        End If

        Return NtefToMSG

    End Function

    Function LoadMsgFile(ByVal UID As String, ByVal MsgFQN As String,
                         ByVal ServerName As String,
                         ByVal CurrMailFolder As String,
                         ByVal LibraryName As String,
                         ByVal RetentionCode As String,
                         ByVal DefaultSubject As String,
                         ByRef Body As String,
                         ByRef AttachedFiles As List(Of String),
                         ByVal bWinMail As Boolean,
                         ByVal ParentGuid As String, ByRef EmailDescription As String) As Boolean

        ''* There is a primary assumption that NO .dat files will be processed in this module

        Dim TempDir As String = UTIL.getTempProcessingDir
        Dim AttachmentDir As String = TempDir + "\Email\Attachment"
        AttachmentDir = AttachmentDir.Replace("\\", "\")

        Dim EmailDir As String = TempDir + "\Email\"
        EmailDir = EmailDir.Replace("\\", "\")

        If Not Directory.Exists(EmailDir) Then
            Directory.CreateDirectory(EmailDir)
        End If
        If Not Directory.Exists(AttachmentDir) Then
            Directory.CreateDirectory(AttachmentDir)
        End If

        Dim deleteThisFile As Boolean = False

        Dim TempSubject As String = DefaultSubject
        Dim TempBody As String = Body

        Dim NewGuid As String = Guid.NewGuid.ToString
        Dim Subject As String = Nothing

        Dim lCC As New ArrayList
        Dim lBCC As New ArrayList
        Dim lEmailToAddr As New ArrayList
        Dim lRecipients As New ArrayList

        Dim CurrMailFolderID_ServerName As String = Nothing
        Dim SenderEmailAddress As String = Nothing
        Dim SenderName As String = Nothing
        Dim SentOn As Date = Nothing
        Dim ReceivedByName As String = Nothing
        Dim ReceivedTime As Date = Nothing
        Dim CreationTime As Date = Nothing
        Dim DB_ID As String = Nothing
        Dim Server_UserID_StoreID As String = Nothing
        Dim RetentionYears As Integer = Nothing
        Dim EmailSize As Integer = Nothing
        Dim EmailIdentifier As String = Nothing
        Dim EmailFQN As String = Nothing

        Dim isPublic As Boolean = Nothing
        Dim bEmlToMSG As Boolean = Nothing

        Dim OL As Outlook.Application
        Dim Msg As Outlook.MailItem

        Dim bx As Integer = 0
        Dim LL As Integer = 0

        Dim bProcessThisFile As Boolean = True
        Dim bExists As Boolean = True

        Try
            LL = 1
            OL = New Outlook.Application : LL = 2
            Msg = OL.CreateItemFromTemplate(MsgFQN) : LL = 3
            ' now use msg to get at the email parts
            Dim msgAttachments As Microsoft.Office.Interop.Outlook.Attachments : LL = 4
            msgAttachments = Msg.Attachments : LL = 5
            Dim EntryID As String = Msg.EntryID
            If Msg.Attachments.Count > 0 Then
                Dim Atmt As Outlook.Attachment
                For Each Atmt In Msg.Attachments
                    Try
                        Dim filename As String = AttachmentDir + "\" + Atmt.FileName
                        filename = filename.Replace("\\", "\")

                        Atmt.SaveAsFile(filename)
                        AttachedFiles.Add(filename)
                    Catch ex As System.Exception
                        LOG.WriteToArchiveLog("WARNING: Attachment not loaded in EMAIL : " + MsgFQN)
                    End Try

                Next Atmt
            End If

            SenderName = Msg.SenderName : LL = 6
            SenderEmailAddress = Msg.SenderEmailAddress : LL = 7

            Dim ReplyRecipients As Microsoft.Office.Interop.Outlook.Recipients : LL = 8
            ReplyRecipients = Msg.ReplyRecipients : LL = 9

            Dim AllRecipientNames As String = ""
            Dim ReplyRecipientNames As String = Msg.ReplyRecipientNames : LL = 10
            Dim Recipients As Microsoft.Office.Interop.Outlook.Recipients : LL = 11
            Recipients = Msg.Recipients
            If Recipients IsNot Nothing Then
                Dim II As Integer = 1
                For II = 1 To Recipients.Count
                    lRecipients.Add(Recipients(II).Name)
                    lEmailToAddr.Add(Recipients(II).Name)
                    AllRecipientNames = AllRecipientNames + Recipients(II).Name + "; "
                Next
            End If

            ReceivedTime = Msg.ReceivedTime : LL = 16
            ReceivedByName = Msg.ReceivedByName : LL = 17
            CreationTime = Msg.CreationTime : LL = 18

            If Msg.CC IsNot Nothing Then
                Dim strCC As String = Msg.CC : LL = 19
                If strCC.Length > 0 Then : LL = 20
                    Dim A As String() = strCC.Split(";") : LL = 21
                    For i As Integer = 0 To UBound(A) : LL = 22
                        lCC.Add(A(i)) : LL = 23
                    Next : LL = 24
                End If : LL = 25
            End If

            Body = Msg.Body + " :: " + TempBody : LL = 26

            EmailDescription += Body

            If Msg.BCC IsNot Nothing Then
                Dim strBCC As String = Msg.BCC : LL = 27
                If strBCC.Length > 0 Then : LL = 28
                    Dim A As String() = strBCC.Split(";") : LL = 29
                    For i As Integer = 0 To UBound(A) : LL = 30
                        lBCC.Add(A(i)) : LL = 31
                        ReceivedByName = ReceivedByName + "; " : LL = 32
                    Next : LL = 33
                End If : LL = 34
            End If

            SentOn = Msg.SentOn : LL = 35
            Subject = Msg.Subject : LL = 36

            EmailDescription += Subject

            If Subject Is Nothing And DefaultSubject.Length > 0 Then
                Subject = DefaultSubject
            Else
                Subject += " :: " + DefaultSubject
            End If

            Dim MsgSize As Integer = Msg.Size : LL = 37

            If MsgSize = 0 And Body IsNot Nothing Then
                MsgSize = Body.Length
            End If

            CurrMailFolderID_ServerName = ServerName : LL = 39
            SenderEmailAddress = Msg.SenderEmailAddress : LL = 40
            SenderName = Msg.SenderName : LL = 41
            SentOn = Msg.SentOn : LL = 42
            ReceivedTime = Msg.ReceivedTime : LL = 43
            CreationTime = Msg.CreationTime : LL = 44
            DB_ID = "ECM.Library" : LL = 45
            CurrMailFolder = CurrMailFolder : LL = 46
            Server_UserID_StoreID = CurrMailFolder : LL = 47

            RetentionYears = getRetentionPeriod(RetentionCode) : LL = 48

            EmailSize = MsgSize : LL = 49

            If EmailSize = 0 Then : LL = 50
                Try
                    EmailSize = Body.Length : LL = 51
                Catch ex As System.Exception
                    Console.WriteLine("Notice 001sx1")
                    EmailSize = 0
                End Try

            End If : LL = 52

            Dim GMT As String = Msg.SentOn.ToString : LL = 53

            FixDate(GMT) : LL = 54
            Dim tSubject As String = Mid(Subject, 1, 100) : LL = 55
            RemoveBadChars(tSubject) : LL = 56

            If EmailSize = 0 Then
                If Body IsNot Nothing Then
                    EmailSize = Body.Length
                Else
                    EmailSize = tSubject.Length
                End If
            End If

            If SenderEmailAddress Is Nothing Then
                SenderEmailAddress = CurrMailFolder
            End If

            EmailIdentifier = UTIL.genEmailIdentifier(Msg.CreationTime, Msg.SenderEmailAddress, Subject)
            'Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

            bExists = ExchangeEmailExists(EmailIdentifier)
            If bExists Then
                bProcessThisFile = False
                GoTo SKIPMSGFILE
            End If

            EmailFQN = MsgFQN : LL = 58

            isPublic = False : LL = 59
            bEmlToMSG = False : LL = 60

            getDirectoryFiles(AttachmentDir, AttachedFiles) : LL = 61

            For II As Integer = 0 To AttachedFiles.Count - 1
                Dim sFqn As String = AttachedFiles(II)
                Dim fExt As String = UTIL.getFileSuffix(sFqn)
                If fExt.ToUpper.Equals("MSG") Then
                    Dim tPath As String = DMA.GetFilePath(sFqn)
                    Dim fName As String = DMA.getFileName(sFqn)
                    Dim NewDirName As String = UTIL.getTempProcessingDir + "\PendingEmail"
                    NewDirName = NewDirName.Replace("\\", "\")

                    If Not Directory.Exists(NewDirName) Then
                        Directory.CreateDirectory(NewDirName)
                    End If

                    Dim MoveFileName As String = NewDirName + "\" + NewGuid.ToString + "." + fName

                    If File.Exists(MoveFileName) Then
                        File.Delete(MoveFileName)
                    End If
                    File.Move(sFqn, MoveFileName)

                    AttachedFiles(II) = ""
                End If
            Next

            OL = Nothing : LL = 62
            Msg = Nothing : LL = 63

            If CreationTime > Now Then
                CreationTime = Now
            End If

            If bWinMail = True Then
                Return True
            End If

            bx = DBARCH.iCount("Select count(*) from Email where EmailGuid = '" + ParentGuid + "'")
            'bx = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier) : LL = 64
            If bx = 0 Then
                ArchiveMsgEmail(UID, NewGuid,
                                   Body,
                                   Subject,
                                   lCC,
                                   lBCC,
                                   lEmailToAddr,
                                   lRecipients,
                                   CurrMailFolderID_ServerName,
                                   SenderEmailAddress,
                                   SenderName,
                                   SentOn,
                                   ReceivedByName,
                                   ReceivedTime,
                                   CreationTime,
                                   DB_ID,
                                   CurrMailFolder,
                                   Server_UserID_StoreID,
                                   RetentionYears,
                                   RetentionCode,
                                   EmailSize,
                                   AttachedFiles,
                                   EntryID, EmailIdentifier,
                                   EmailFQN,
                                   LibraryName,
                                   isPublic,
                                   bEmlToMSG)

            End If
SKIPMSGFILE:
            deleteThisFile = True
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("NOTICE: LoadMsgFile LL = " + LL.ToString + environment.NewLine + ex.Message)
            deleteThisFile = False
        Finally
            If deleteThisFile = True Then
                Try
                    File.Delete(MsgFQN)
                Catch ex As System.Exception
                    LOG.WriteToArchiveLog("Error: Could not remove MSG file : " + MsgFQN)
                End Try
            End If
        End Try

        If bProcessThisFile = True Then
            If NewGuid.Trim.Length > 0 Then
                Body = UTIL.ReplaceSingleQuotes(Body)
                Subject = UTIL.ReplaceSingleQuotes(Subject)
                SenderName = UTIL.ReplaceSingleQuotes(SenderName)
                SenderEmailAddress = UTIL.ReplaceSingleQuotes(SenderEmailAddress)
                Dim tMsg As String = " " + Chr(254) + Body + Chr(254) + Subject + Chr(254) + SenderName + Chr(254) + SenderEmailAddress
                concatEmailBody(tMsg, NewGuid)
            End If
        End If

        Return bx
    End Function

    Sub ArchiveMsgEmail(ByVal UID As String, ByVal NewGuid As String,
                              ByVal Body As String,
                              ByVal Subject As String,
                              ByVal CC As ArrayList,
                              ByVal BCC As ArrayList,
                              ByVal EmailToAddr As ArrayList,
                              ByVal Recipients As ArrayList,
                              ByVal CurrMailFolderID_ServerName As String,
                              ByVal SenderEmailAddress As String,
                              ByVal SenderName As String,
                              ByVal SentOn As Date,
                              ByVal ReceivedByName As String,
                              ByVal ReceivedTime As Date,
                              ByVal CreationTime As Date,
                              ByVal DB_ID As String,
                              ByVal CurrMailFolder As String,
                              ByVal Server_UserID_StoreID As String,
                              ByVal RetentionYears As Integer,
                              ByVal RetentionCode As String,
                              ByVal EmailSize As Integer,
                              ByVal AttachedFiles As List(Of String),
                              ByVal EntryID As String,
                              ByVal EmailIdentifier As String,
                              ByVal EmailFQN As String,
                              ByVal LibraryName As String,
                              ByVal isPublic As Boolean,
                              ByVal bEmlToMSG As Boolean)

        Dim FI As New FileInfo(EmailFQN)
        Dim OriginalName As String = FI.Name
        FI = Nothing

        If CreationTime > Now Then
            CreationTime = Now
        End If

        Dim LastEmailArchRunDate As String = UserParmRetrive("LastEmailArchRunDate", gCurrUserGuidID)
        If LastEmailArchRunDate.Trim.Length = 0 Then
            LastEmailArchRunDate = "1/1/1950"
        End If
        Dim rightNow As Date = Now
        If RetentionYears = 0 Then
            RetentionYears = Val(getSystemParm("RETENTION YEARS"))
        End If

        '** Retain from entry time.
        rightNow = rightNow.AddYears(RetentionYears)
        Dim RetentionExpirationDate As String = rightNow.ToString

        Dim EmailsSkipped As Integer = 0
        Dim DeleteMsg As Boolean = False
        Dim CurrDateTime As Date = Now()
        Dim ArchiveAge As Integer = 0
        Dim RemoveAge As Integer = 0
        Dim XDaysArchive As Integer = 0
        Dim XDaysRemove As Integer = 0
        'Dim EmailFQN = ""
        Dim bRemoveAfterArchive As Boolean = False
        Dim bMsgUnopened As Boolean = False
        Dim CurrMailFolderName As String = ""
        Dim MinProcessDate As Date = CDate("01/1/1910")
        Dim CurrName As String = CurrMailFolder
        Dim ArchiveMsg As String = CurrName + ": "

        Dim DB_ConnectionString As String = ""

        Try
            If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 200: ")
            SL.Clear()
            SL2.Clear()

            CurrMailFolderName = CurrMailFolder
            ' Loop each unread message.
            Dim i As Integer = 0

            EMAIL.setStoreID(CurrMailFolder)
            System.Windows.Forms.Application.DoEvents()

            Try
                Dim EmailGuid As String = NewGuid
                Dim OriginalFolder As String = CurrMailFolder
                Dim FNAME As String = CurrMailFolder

                Dim keyEmailIdentifier As String = NewGuid

                If SentOn = Nothing Then
                    SentOn = #1/1/1899#
                End If

                If ReceivedTime = Nothing Then
                    ReceivedTime = #1/1/1899#
                End If

                If CreationTime = Nothing Then
                    CreationTime = #1/1/1970#
                End If
                If CreationTime < #1/1/1960# Then
                    CreationTime = #1/1/1960#
                End If

                'If frmReconMain.ckUseLastProcessDateAsCutoff.Checked Then
                setLastEmailDate(CurrMailFolderName, CreationTime)

                Dim SourceTypeCode As String = "MSG"

                Dim bAutoForwarded As Boolean = False

                Dim BillingInformation As String = Nothing
                Dim EmailBody As String = Body
                Dim BodyFormat As String = ""
                Dim Categories As String = ""

                Dim Companies As String = ""
                Dim ConversationIndex As String = ""
                Dim ConversationTopic As String = ""

                Dim DeferredDeliveryTime As Date = Nothing
                Dim DownloadState As String = ""

                Dim HTMLBody As String = ""
                Dim Importance As String = ""
                Dim IsMarkedAsTask As Boolean = False
                Dim LastModificationTime As Date = Now
                Dim MessageClass As String = ""
                Dim Mileage As String = ""
                Dim OriginatorDeliveryReportRequested As Boolean = False
                Dim OutlookInternalVersion As String = ""
                Dim ReadReceiptRequested As Boolean = False
                Dim ReceivedByEntryID As String = ""

                If ReceivedByName = Nothing Then
                    ReceivedByName = "Unknown"
                ElseIf ReceivedByName.Length = 0 Then
                    ReceivedByName = "Unknown"
                End If
                Dim ReceivedOnBehalfOfName As String = ""

                Dim KK As Integer = 0
                Dim AllRecipients As String = ""
                For KK = 0 To Recipients.Count - 1
                    AllRecipients = AllRecipients + "; " + Recipients.Item(KK)
                    AddRecipToList(EmailGuid, Recipients.Item(KK), "RECIP")
                Next

                If AllRecipients.Length > 0 Then
                    Dim ch As String = Mid(AllRecipients, 1, 1)
                    If ch.Equals(";") Then
                        Mid(AllRecipients, 1, 1) = " "
                        AllRecipients = AllRecipients.Trim
                    End If
                End If

                Dim ReminderSet As Boolean = False
                Dim ReminderTime As Date = Nothing
                Dim ReplyRecipientNames As Object = Nothing

                If ReplyRecipientNames <> Nothing Then
                    'For Each R In ReplyRecipientNames
                    If xDebug Then If xDebug Then LOG.WriteToArchiveLog("ReplyRecipientNames: " + ReplyRecipientNames)
                    'Next
                End If

                Dim SenderEmailType As String = ""
                Dim Sensitivity As String = ""
                Dim SentOnBehalfOfName As String = ""

                ArchiveMsg = ArchiveMsg + " : " + Subject

                Dim TaskCompletedDate As Date = Nothing
                Dim TaskDueDate As Date = Now
                Dim TaskSubject As String = ""

                Dim VotingOptions As String = ""
                Dim VotingResponse As String = ""
                Dim UserProperties As Object = Nothing
                Dim Accounts As String = "None Supplied"

                Dim NewTime As String = ReceivedTime.ToString.Replace("//", ".")
                NewTime = ReceivedTime.ToString.Replace("/:", ".")
                NewTime = ReceivedTime.ToString.Replace(" ", "_")
                Dim NewSubject As String = Mid(Subject, 1, 200)
                NewSubject = NewSubject.Replace(" ", "_")
                ConvertName(NewSubject)
                ConvertName(NewTime)

                Dim bExcluded As Boolean = isExcludedEmail(SenderEmailAddress)
                If bExcluded Then
                    GoTo LabelSkipThisEmail
                End If

                If SenderEmailAddress.Length = 0 Or SenderEmailAddress = Nothing Then
                    SenderEmailAddress = "Unknown"
                End If

                If SentOn = Nothing Then
                    SentOn = #1/1/1900#
                End If

                If SenderName.Length = 0 Or SenderName = Nothing Then
                    SenderName = "Unknown"
                End If

                If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 200: ")

                '***** Prepare to use the EMAIL IDENTIFIER HERE at a later time *******
                Dim IX As Integer = DBARCH.iCount("Select count(*) from Email where emailguid = '" + NewGuid + "' ")
                'Dim bExists As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
                If IX > 0 Then
                    GoTo LabelSkipThisEmail
                End If

                AllRecipients += ";" + ReceivedByName

                System.Windows.Forms.Application.DoEvents()

                EMAIL.setEmailIdentifier(EmailIdentifier)
                EMAIL.setEntryid(EntryID)
                EMAIL.setEmailguid(EmailGuid)

                If BCC.Count > 0 Then
                    For Each sBcc As String In BCC
                        AllRecipients = AllRecipients + "; " + sBcc
                    Next

                End If
                If CC.Count > 0 Then
                    For Each sBcc As String In CC
                        AllRecipients = AllRecipients + "; " + sBcc
                    Next
                End If

                Dim AllBcc As String = ""
                For Each sBcc As String In BCC
                    AllBcc = AllBcc + "; " + sBcc
                Next
                Dim AllCC As String = ""
                For Each sBcc As String In CC
                    AllCC = AllCC + "; " + sBcc
                Next

                EMAIL.setAllrecipients(AllRecipients)
                EMAIL.setBcc(AllBcc)
                EMAIL.setBillinginformation(BillingInformation)
                EMAIL.setBody(UTIL.RemoveSingleQuotesV1(EmailBody))
                EMAIL.setCc(AllCC)
                EMAIL.setCompanies(Companies)
                EMAIL.setCreationtime(CreationTime)
                EMAIL.setCurrentuser(gCurrUserGuidID)
                EMAIL.setDeferreddeliverytime(DeferredDeliveryTime)
                EMAIL.setDeferreddeliverytime(DeferredDeliveryTime)
                EMAIL.setEmailguid(EmailGuid)
                'EMAIL.setEmailimage()

                EMAIL.setExpirytime(RetentionExpirationDate)
                EMAIL.setLastmodificationtime(LastModificationTime)
                EMAIL.setMsgsize(EmailSize.ToString)
                EMAIL.setReadreceiptrequested(OriginatorDeliveryReportRequested.ToString)
                EMAIL.setReceivedbyname(ReceivedByName)
                EMAIL.setReceivedtime(ReceivedTime)

                SenderEmailAddress = Mid(SenderEmailAddress, 1, 79)
                EMAIL.setSenderemailaddress(SenderEmailAddress)

                SenderName = Mid(SenderName, 1, 79)
                EMAIL.setSendername(SenderName)
                EMAIL.setSensitivity(Sensitivity)
                EMAIL.setSenton(SentOn)

                EMAIL.setSourcetypecode("MSG")

                EMAIL.setOriginalfolder(OriginalFolder)

                Dim SentTo As String = ""
                If Recipients.Count > 0 Then
                    For iI As Integer = 0 To Recipients.Count - 1
                        SentTo += Recipients(iI) + ";"
                    Next
                End If

                EMAIL.setSentto(ReceivedByName)
                EMAIL.setSubject(UTIL.RemoveSingleQuotesV1(Subject))
                Dim ShortSubj As String = Mid(Subject, 1, 240)
                EMAIL.setShortsubj(UTIL.RemoveSingleQuotesV1(ShortSubj))
                Dim MailAdded As Boolean = False

                Dim BB As Boolean = False
                System.Windows.Forms.Application.DoEvents()

                If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 300: ")

                'Dim bx As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
                IX = DBARCH.iCount("Select count(*) from Email where emailguid = '" + NewGuid + "' ")
                If IX = 0 Then
                    '*****  ***********************************************
                    'Convert to MSG and store the image as a MSG file
                    Dim StrHashTemp As String = ENC.getSha1HashKey(EmailIdentifier)
                    BB = EMAIL.InsertNewEmail(gMachineID, gNetworkID, "MSG", EmailIdentifier, StrHashTemp, CurrMailFolder)
                    '*****  ***********************************************

                    If BB Then

                        'EmailsBackedUp += 1
                        'frmExchangeMonitor.lblCnt.Text = EmailsBackedUp.ToString

                        '**********************************************************************************************
                        '** Call Filestream service or standard service here
                        Dim bMail As Boolean = UpdateEmailMsg(OriginalName, 2222.1, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, StrHashTemp, "NA")
                        '**********************************************************************************************
                        If bMail = False Then
                            '** It failed to add an MSG - try saving it as an EML
                            Dim fExt As String = UTIL.getFileSuffix(EmailFQN)
                            If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then
                                Dim TempFQN As String = ""
                                Dim BBX As Boolean = False
                                If fExt.ToUpper.Equals(".MSG") Or fExt.ToUpper.Equals("MSG") Then
                                    EmailFQN = Mid(EmailFQN, 1, InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1)
                                    '**********************************************************************************************
                                    '** Call Filestream service or standard service here
                                    BBX = UpdateEmailMsg(OriginalName, 2222.2, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, StrHashTemp, "NA")
                                    '**********************************************************************************************
                                    If BBX = True Then
                                        EMAIL.setSourcetypecode("EML")
                                    Else
                                        '** It failed again, SKIP IT.
                                        LOG.WriteToArchiveLog("ERROR 299c: Failed to add email" + EmailFQN)
                                        GoTo LabelSkipThisEmail
                                    End If
                                End If
                            End If
                        End If
                        'EmailIdentifier
                        '**WDM Removed below 3/11/2010

                        Dim sSql As String = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'"
                        Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx")
                        End If

                        'LibraryName , ByVal isPublic As Boolean
                        If LibraryName.Trim.Length > 0 Then
                            Dim LibraryOwnerUserID As String = GetLibOwnerByName(LibraryName)
                            Dim S As String = ""
                            Dim LI As New clsLIBRARYITEMS
                            Dim iCnt As Integer = LI.cnt_UniqueEntry(LibraryName, EmailGuid)
                            If iCnt = 0 Then
                                LI.setSourceguid(EmailGuid)
                                LI.setItemtitle(Mid(Subject, 1, 200))
                                LI.setItemtype(SourceTypeCode)
                                LI.setLibraryitemguid(Guid.NewGuid.ToString)
                                LI.setDatasourceowneruserid(gCurrUserGuidID)
                                LI.setLibraryowneruserid(LibraryOwnerUserID)
                                LI.setLibraryname(LibraryName)
                                LI.setAddedbyuserguidid(gCurrUserGuidID)
                                Dim b As Boolean = LI.Insert()
                                If b = False Then
                                    LOG.WriteToArchiveLog("ERROR: 198.171.76 - Filed to add Email Library Item: " + LibraryName + " : + " + Subject)
                                End If
                            End If
                            LI = Nothing
                            GC.Collect()
                        End If
                        If bEmlToMSG = True Then
                            sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'"
                            bbExec = ExecuteSqlNewConn(sSql, False)
                            If Not bbExec Then
                                LOG.WriteToArchiveLog("ERROR: 1234.99zx1")
                            End If
                        End If
                        If isPublic = True Then
                            sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'"
                        Else
                            sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'"
                        End If
                        bbExec = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx2")
                        End If

                        sSql = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID_ServerName + "' where EmailGuid = '" + EmailGuid + "'"
                        bbExec = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99a")
                        End If

                        Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
                        sSql = "Update EMAIL set CRC = '" + EmailHashCode + "' where EmailGuid = '" + EmailGuid + "'"

                        bbExec = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99b")
                        End If

                        'RetentionExpirationDate
                        sSql = "Update EMAIL set RetentionExpirationDate = '" + RetentionExpirationDate + "' where EmailGuid = '" + EmailGuid + "'"
                        bbExec = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99c")
                        End If
                        sSql = "Update EMAIL set RetentionCode = '" + RetentionCode + "' where EmailGuid = '" + EmailGuid + "'"
                        bbExec = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99c")
                        End If

                        setRetentionDate(EmailGuid, RetentionCode, ".EML")

                        If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 500: ")

                        MailAdded = True
                    Else
                        If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 600: ")
                        '**WDM Removed below 3/11/2010

                        Dim sSql As String = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'"
                        Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx12")
                        End If

                        If bEmlToMSG = True Then
                            sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'"
                            bbExec = ExecuteSqlNewConn(sSql, False)
                        End If

                        If LibraryName.Trim.Length > 0 Then
                            Dim LibraryOwnerUserID As String = GetLibOwnerByName(LibraryName)
                            Dim S As String = ""
                            Dim LI As New clsLIBRARYITEMS
                            Dim iCnt As Integer = LI.cnt_UniqueEntry(LibraryName, EmailGuid)
                            If iCnt = 0 Then
                                LI.setSourceguid(EmailGuid)
                                LI.setItemtitle(Mid(Subject, 1, 200))
                                LI.setItemtype(SourceTypeCode)
                                LI.setLibraryitemguid(Guid.NewGuid.ToString)
                                LI.setDatasourceowneruserid(gCurrUserGuidID)
                                LI.setLibraryowneruserid(LibraryOwnerUserID)
                                LI.setLibraryname(LibraryName)
                                LI.setAddedbyuserguidid(gCurrUserGuidID)
                                Dim b As Boolean = LI.Insert()
                                If b = False Then
                                    LOG.WriteToArchiveLog("ERROR: 198.171.76 - Filed to add Email Library Item: " + LibraryName + " : + " + Subject)
                                End If
                            End If
                            LI = Nothing
                            GC.Collect()
                        End If

                        If isPublic = True Then
                            sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'"
                        Else
                            sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'"
                        End If
                        bbExec = ExecuteSqlNewConn(sSql, False)
                        If Not bbExec Then
                            LOG.WriteToArchiveLog("ERROR: 1234.99xx6")
                        End If

                        If xDebug Then LOG.WriteToArchiveLog("Error 0743.23 - failed to archive email.")
                        MailAdded = False
                        If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 700: ")
                    End If
                Else
                    If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 800: ")
                    BB = True
                    MailAdded = False
                End If
                If BB Then
                    'BB = UpdateEmailMsg(EmailFQN, EmailGuid )
                    Try
                        Kill(EmailFQN)
                        If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 900: ")
                    Catch ex As System.Exception
                        Console.WriteLine(ex.Message)
                        If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 1000: ")
                    End Try

                    DeleteMsg = True
                Else
                    If xDebug Then LOG.WriteToArchiveLog("Error 623.45 - Failed to archive email: " + Subject)
                    MailAdded = False
                    If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 2000: ")
                    GoTo LabelSkipThisEmail
                End If

                System.Windows.Forms.Application.DoEvents()

                If MailAdded Then
                    If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 3000: ")
                    SL2.Clear()
                    If Not AllCC Is Nothing Then
                        If AllCC.Trim.Length > 0 Then
                            Dim A(0) As String
                            If InStr(1, AllCC, ";") > 0 Then
                                A = Split(AllCC, ";")
                            Else
                                A(0) = AllCC
                            End If
                            For KK = 0 To UBound(A)
                                Dim SKEY As String = A(KK)
                                If Not SKEY Is Nothing Then
                                    Dim BXX As Boolean = SL.ContainsKey(SKEY)
                                    If Not BXX Then
                                        SL2.Add(SKEY, "CC")
                                    End If
                                End If
                            Next
                        End If
                    End If
                    If Not AllBcc Is Nothing Then
                        If AllBcc.Trim.Length > 0 Then
                            Dim A(0) As String
                            If InStr(1, AllBcc, ";") > 0 Then
                                A = Split(AllBcc, ";")
                            Else
                                A(0) = AllBcc
                            End If
                            For KK = 0 To UBound(A)
                                Dim SKEY As String = A(KK)
                                If Not SKEY Is Nothing Then
                                    Dim BXX As Boolean = SL.ContainsKey(SKEY)
                                    If Not BXX Then
                                        SL2.Add(SKEY, "allbcc")
                                    End If
                                End If
                            Next
                        End If
                    End If

                    'For KK = 0 To Recipients.Count - 1
                    For Each tAddr As String In Recipients
                        'Dim Addr  = Recipients.Item(i)
                        Dim Addr As String = tAddr
                        RECIPS.setEmailguid(EmailGuid)
                        RECIPS.setRecipient(Addr)
                        Dim BXX As Boolean = SL2.ContainsKey(Addr)
                        If Not BXX Then
                            RECIPS.setTyperecp("RECIP")
                        Else
                            Dim iKey As Integer = SL2.IndexOfKey(Addr)
                            Dim TypeCC As String = ""
                            TypeCC = SL2.Item(Addr).ToString
                            RECIPS.setTyperecp(TypeCC)
                        End If
                        RECIPS.Insert()
                    Next

                    Dim bWinMail As Boolean = False
START_WINMAIL_PROCESS:

                    If AttachedFiles.Count > 0 Then
                        If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 4000: ")
                        For Each FileName As String In AttachedFiles
                            'Dim TempDir  = System.IO.Path.GetTempPath
                            'FileName  = AttachedFiles.Item(II)

                            If FileName.Length = 0 Then
                                GoTo SkipThisOne
                            End If

                            Dim FileExt As String = "." + UTIL.getFileSuffix(FileName)

                            Dim fExt2 As String = DMA.getFileExtension(FileName)
                            If fExt2.Length = 0 And InStr(FileName, "UNKNOWN", CompareMethod.Text) > 0 Then
                                '***********************************************************
                                LOG.WriteToArchiveLog("ISSUE/WARNING: An email was sent from Outlook as an RTF formatted attachment - could not be converted '" + FileName + "'.")

                                Dim EMX As New clsEmailFunctions

                                Dim FileNameConverted As String = EMX.ConvertNTEFtoMSG(NewGuid, FileName)
                                If FileNameConverted.Length > 0 Then
                                    Try
                                        Dim EmailDescription As String = ""
                                        If File.Exists(FileNameConverted) Then
                                            EMX.LoadMsgFile(UID, FileNameConverted, ServerName, CurrMailFolder, LibraryName, RetentionCode, Subject, EmailBody, AttachedFiles, True, NewGuid, EmailDescription)
                                        End If
                                        If EmailDescription.Length > 0 Then
                                            EmailDescription = UTIL.RemoveSingleQuotes(EmailDescription)
                                            concatEmailBody(EmailDescription, EmailGuid)
                                        End If
                                    Catch ex As System.Exception
                                        LOG.WriteToArchiveLog("NOTICE: " + FileNameConverted + " processed - " + ex.Message)
                                    End Try

                                End If

                                EMX = Nothing
                                '***********************************************************
                            End If

                            Dim bCnt As Integer = ATYPE.cnt_PK29(FileExt)
                            Dim isZipFile As Boolean = False

                            If InStr(FileName, "winmail.dat", CompareMethod.Text) > 0 Then
                                GoTo SkipThisOne
                            End If

                            If bCnt = 0 Then
                                Dim B1 As Boolean = ZF.isZipFile(FileName)
                                If B1 Then
                                    ATYPE.setIszipformat("1")
                                    isZipFile = True
                                Else
                                    ATYPE.setIszipformat("0")
                                    isZipFile = False
                                End If
                                ATYPE.setAttachmentcode(FileExt)
                                ATYPE.Insert()
                            End If

                            Dim BBB As Boolean = ZF.isZipFile(FileName)

                            ATYPE.setDescription("Auto added this code.")
                            If BBB Then
                                ATYPE.setIszipformat("1")
                                isZipFile = True
                            Else
                                ATYPE.setIszipformat("0")
                                isZipFile = False
                            End If
                            If isZipFile = True Then
                                '** Explode and load
                                Dim AttachmentName As String = FileName
                                Dim SkipIfAlreadyArchived As Boolean = False
                                'ZF.ProcessEmailZipFile(gMachineID, EmailGuid, FileName , gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName)
                                Dim StackLevel As Integer = 0
                                Dim ListOfFiles As New Dictionary(Of String, Integer)
                                ZF.ProcessEmailZipFile(gMachineID, EmailGuid, FileName, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
                                ListOfFiles = Nothing
                                GC.Collect()
                            Else
                                FileExt = "." + UTIL.getFileSuffix(FileName)
                                Dim AttachmentName As String = FileName
                                Dim Sha1Hash As String = ENC.GenerateSHA512HashFromFile(FileName)
                                Dim bbx As Boolean = InsertAttachmentFqn(gCurrUserGuidID, FileName, EmailGuid, AttachmentName, FileExt, gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic, CurrMailFolder)
                            End If
SkipThisOne:
                        Next
                    End If
                    'If bWinMail = True Then
                    '    For Each sFileToRemove As String In AttachedFiles
                    '        If File.Exists(sFileToRemove) Then
                    '            ISO.saveIsoFile(" FilesToDelete.dat", sFileToRemove + "|")
                    '            'File.Delete(sFileToRemove)
                    '        End If
                    '    Next
                    '    bWinMail = False
                    'End If
                End If

                System.Windows.Forms.Application.DoEvents()
                If xDebug Then LOG.WriteToTraceLog("ArchiveExchangeEmails 5000: ")
LabelSkipThisEmail:
            Catch ex As System.Exception
                EmailsSkipped += 1
                LOG.WriteToArchiveLog(ArchiveMsg + " SKIPPED - " + ex.Message)
                LOG.WriteToArchiveLog("clsArchiver : ArchiveEmailsInFolder: 100 - item#" + i.ToString + " : " + ex.Message)
            End Try

            GC.Collect()
            GC.WaitForFullGCComplete()
        Catch ex As System.Exception
            If gRunUnattended = False Then MessageBox.Show(ex.Message)
        End Try

    End Sub

    'Sub ApplyPendingEmail(ByVal UID As String, ByVal ServerName As String, _
    '                     ByVal CurrMailFolder As String, _
    '                     ByVal LibraryName As String, _
    '                     ByVal RetentionCode )

    ' Dim MsgFQN As String = "" Dim DefaultSubject As String = "" Dim Body As String = "" Dim
    ' AttachedFiles As New List(Of String) Dim bWinMail As Boolean = False

    ' Dim I As Integer = 0 Dim J As Integer = 0 Dim TempDir = System.IO.Path.GetTempPath Dim
    ' AttachmentDir = TempDir + "Email\Attachment" Dim PendDir = TempDir +
    ' "Email\Attachment\PendingEmail" Dim EmailDir = TempDir + "Email"

    ' Dim D As Directory If Not D.Exists(PendDir) Then D = Nothing Return End If

    ' Dim storefile As Directory Dim directory As String Dim files As String() Dim File As String Dim
    ' DeleteFiles As Boolean = True

    ' Try files = storefile.GetFiles(PendDir, "*.MSG") For Each File In files
    ' DMA.deleteDirectoryFiles(AttachmentDir ) Dim FQN = File

    ' Dim ParentGuid As String = "" If InStr(File, ".") > 0 Then ParentGuid = Mid(File, 1,
    ' InStr(File, ".") - 1) If isGuid(ParentGuid) = False Then ParentGuid = "" End If End If Dim
    ' EmailDescription As String = "" LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName,
    ' RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, EmailDescription)
    ' Next Catch ex As System.Exception log.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " +
    ' ex.Message) DeleteFiles = False Finally If DeleteFiles = True Then For Each File In files Dim
    ' FQN = PendDir + "\" + File

    ' Next End If

    ' End Try

    'End Sub

    Sub ApplyPendingEmail(ByVal UID As String, ByVal DirectoryName As String, ByVal ServerName As String,
                         ByVal CurrMailFolder As String,
                         ByVal LibraryName As String,
                         ByVal RetentionCode As String)

        Dim MsgFQN As String = ""
        Dim DefaultSubject As String = ""
        Dim Body As String = ""
        Dim AttachedFiles As New List(Of String)
        Dim bWinMail As Boolean = False

        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim PendDir As String = DirectoryName
        Dim EmailDir As String = TempDir + "Email"

        If Not Directory.Exists(PendDir) Then
            Return
        End If

        Dim files As String()
        Dim File As String
        Dim DeleteFiles As Boolean = True

        Try
            files = Directory.GetFiles(PendDir, "*.MSG")
            For Each File In files
                DMA.deleteDirectoryFiles(AttachmentDir)
                Dim FQN As String = File
                Dim ParentGuid As String = ""
                If InStr(File, ".") > 0 Then
                    ParentGuid = Mid(File, 1, InStr(File, ".") - 1)
                    If isGuid(ParentGuid) = False Then
                        ParentGuid = ""
                    End If
                End If
                Dim EmailDescription As String = ""
                LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, EmailDescription)
            Next
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message)
            DeleteFiles = False
        Finally
            If DeleteFiles = True Then
                For Each File In files
                    Dim FQN As String = PendDir + "\" + File

                Next
            End If

        End Try

    End Sub

    Sub ApplyPendingEmail(ByVal UID As String, ByVal SelectedFiles As List(Of String), ByVal ServerName As String,
                         ByVal CurrMailFolder As String,
                         ByVal LibraryName As String,
                         ByVal RetentionCode As String)

        Dim MsgFQN As String = ""
        Dim DefaultSubject As String = ""
        Dim Body As String = ""
        Dim AttachedFiles As New List(Of String)
        Dim bWinMail As Boolean = False

        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        'Dim PendDir  = DirectoryName
        Dim EmailDir As String = TempDir + "Email"

        'Dim D As Directory
        'If Not D.Exists(PendDir) Then
        '    D = Nothing
        '    Return
        'End If

        Dim storefile As Directory
        Dim directory As String
        Dim files As String()
        Dim File As String
        Dim DeleteFiles As Boolean = True

        Try

            For Each File In SelectedFiles
                DMA.deleteDirectoryFiles(AttachmentDir)
                Dim FQN As String = File
                Dim ParentGuid As String = ""
                If InStr(File, ".") > 0 Then
                    ParentGuid = Mid(File, 1, InStr(File, ".") - 1)
                    If isGuid(ParentGuid) = False Then
                        ParentGuid = ""
                    End If
                End If

                Dim EmailDescription As String = ""

                LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, EmailDescription)
            Next
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message)
        End Try

    End Sub

    Sub ArchiveEmbeddedEmailMessage(ByVal UID As String, ByVal EM As Chilkat.Email,
                                    ByVal LibraryName As String,
                                    ByVal EmailBoxName As String,
                                    ByVal RetentionCode As String,
                                    ByVal isPublic As Boolean,
                                    ByVal bEmlToMSG As Boolean,
                                    ByVal ServerName As String,
                                    ByVal ParentGuid As String,
                                    ByVal DaysToHold As Integer,
                                    EmailIdentifier As String,
                                    EntryID As String)
        'ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold)

        Dim LL As Integer = 0

        Dim PauseThreadMS As Integer = 0
        Try
            PauseThreadMS = CInt(getUserParm("UserEmail_Pause"))
        Catch ex As System.Exception
            PauseThreadMS = 0
        End Try

        Try
            Dim TempDir As String = UTIL.getTempProcessingDir : LL = 1
            TempDir = TempDir.Replace("\\", "\")
            Dim AttachmentDir As String = TempDir + "Email\Attachment" : LL = 2
            AttachmentDir = AttachmentDir.Replace("\\", "\")

            Dim EmailDir As String = TempDir + "Email" : LL = 3
            EmailDir = EmailDir.Replace("\\", "\")

            Dim AttachedFiles As New List(Of String) : LL = 4
            Dim Body As String = EM.Body : LL = 6
            Dim BounceAddress As String = EM.BounceAddress : LL = 7
            Dim Charset As String = EM.Charset : LL = 8
            Dim Decrypted As Boolean = EM.Decrypted : LL = 9
            Dim EmailDate As Date = EM.EmailDate : LL = 10
            Dim EncryptedBy As String = EM.EncryptedBy : LL = 11
            Dim FileDistList As String = EM.FileDistList : LL = 12
            Dim From As String = EM.From : LL = 13
            Dim FromAddress As String = EM.FromAddress : LL = 14
            Dim FromName As String = EM.FromName : LL = 15
            Dim Header As String = EM.Header : LL = 16
            Dim Language As String = EM.Language : LL = 17
            Dim LastErrorHtml As String = EM.LastErrorHtml : LL = 18
            Dim LastErrorText As String = EM.LastErrorText : LL = 19
            Dim LastErrorXml As String = EM.LastErrorXml : LL = 20
            Dim LocalDate As Date = EM.LocalDate : LL = 21
            Dim Mailer As String = EM.Mailer : LL = 22
            Dim NumAlternatives As Integer = EM.NumAlternatives : LL = 23
            Dim NumAttachedMessages As Integer = EM.NumAttachedMessages : LL = 24
            Dim NumAttachments As Integer = EM.NumAttachments : LL = 25
            Dim NumBcc As Integer = EM.NumBcc : LL = 26
            Dim NumCC As Integer = EM.NumCC : LL = 27
            Dim NumDaysOld As Integer = EM.NumDaysOld : LL = 28
            Dim NumHeaderFields As Integer = EM.NumHeaderFields : LL = 29
            Dim NumRelatedItems As Integer = EM.NumRelatedItems : LL = 30
            Dim NumReplacePatterns As Integer = EM.NumReplacePatterns : LL = 31
            Dim NumTo As Integer = EM.NumTo : LL = 32
            Dim OverwriteExisting As Boolean = EM.OverwriteExisting : LL = 33
            Dim PreferredCharset As String = EM.PreferredCharset : LL = 34
            Dim ReceivedEncrypted As Boolean = EM.ReceivedEncrypted : LL = 35
            Dim ReceivedSigned As Boolean = EM.ReceivedSigned : LL = 36
            Dim ReplyTo As String = EM.ReplyTo : LL = 37
            Dim ReturnReceipt As Boolean = EM.ReturnReceipt : LL = 38
            Dim SendEncrypted As Boolean = EM.SendEncrypted : LL = 39
            Dim SendSigned As Boolean = EM.SendSigned : LL = 40
            Dim SignaturesValid As Boolean = EM.SignaturesValid : LL = 41
            Dim SignedBy As String = EM.SignedBy : LL = 42
            Dim Size As Integer = EM.Size : LL = 43
            Dim Subject As String = EM.Subject : LL = 44
            Subject = UTIL.RemoveSingleQuotes(Subject) : LL = 45
            Dim Uidl As String = EM.Uidl : LL = 46
            Dim VerboseLogging As Boolean = EM.VerboseLogging : LL = 47

            Dim tGMT As String = EmailDate.ToString : LL = 49
            FixDate(tGMT) : LL = 50
            Dim tSubject As String = Mid(Subject, 1, 100) : LL = 51
            RemoveBadChars(tSubject) : LL = 52
            LL = 53
            If NumAttachedMessages > 0 Then : LL = 54
                '** This is a recursive operating on the EMBEDDED message, not the parent message
                For II As Integer = 0 To NumAttachedMessages - 1 : LL = 55
                    ArchiveEmbeddedEmailMessage(UID, EM, LibraryName, EmailBoxName, RetentionCode, isPublic, bEmlToMSG, ServerName, ParentGuid, DaysToHold, EmailIdentifier, EntryID) : LL = 56
                Next : LL = 57
            End If : LL = 58
            LL = 59

            'Dim EmailIdentifier As String = UTIL.genEmailIdentifier(Body, Size, tGMT, FromAddress.Trim, Subject, NumAttachments)
            'Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

            Dim ToAddr As String = ParentGuid
            UTIL.deleteDirectoryFile(AttachmentDir) : LL = 70

            If NumAttachments > 0 Then : LL = 71
                '** This is operating on the EMBEDDED message, not the parent message
                '** Clean out the directory :LL =  72
                EM.SaveAllAttachments(AttachmentDir) : LL = 73
                getDirectoryFiles(AttachmentDir, AttachedFiles) : LL = 74
            End If : LL = 76
            LL = 77
            Dim NewGuid As String = Guid.NewGuid.ToString : LL = 78
            Dim CcAddr As New ArrayList : LL = 79
            Dim BccAddr As New ArrayList : LL = 80
            Dim EmailToAddr As New ArrayList : LL = 81
            Dim Recipients As New ArrayList : LL = 82
            Dim ReceivedTime As Date = Now : LL = 83
            Dim UserLoginID As String = gCurrLoginID : LL = 84
            Dim DB_ID As String = "ECM.Library" : LL = 85
            Dim CurrMailFolder As String = EmailBoxName : LL = 86
            Dim Server_UserID_StoreID As String = EmailBoxName : LL = 87
            LL = 88
            Dim EmailFQN As String = EmailDir + "\Email.Embedded~" & NewGuid + "~.EML" : LL = 89
            LL = 90
            Dim EmailSize As Integer = Size : LL = 91
            LL = 92
            Dim retentionYears As Integer = getRetentionPeriod(RetentionCode) : LL = 93
            Dim BB As Boolean = EM.SaveEml(EmailFQN) : LL = 94
            If BB = False Then : LL = 95
                LOG.WriteToArchiveLog("ERROR: 001a ArchiveEmbeddedEmailMessage - failed to save EML File." + environment.NewLine + EmailFQN) : LL = 96
                Return : LL = 97
            End If : LL = 98
            If bEmlToMSG = True Then : LL = 99
                If bEmlToMSG = True Then : LL = 100
                    EmailFQN = convertEmlToMsg(EmailFQN) : LL = 101
                    If EmailFQN.Trim.Length = 0 Then : LL = 102
                        LOG.WriteToArchiveLog("FATAL ERROR: 100 ArchiveEmbeddedEmailMessage - failed to convert EML to MSG File.") : LL = 103
                        LOG.WriteToArchiveLog("NOTE:        100 ArchiveEmbeddedEmailMessage:  Most likely the Redemption DLL is not installed properly") : LL = 104
                        Return : LL = 105
                    End If : LL = 106
                    'log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'") :LL =  107
                End If
            End If

            Dim AttachmentsLoaded As Boolean = False

            LL = 110
            ArchiveExchangeEmails(UID, NewGuid,
                                Body,
                                Subject,
                                CcAddr,
                                BccAddr,
                                EmailToAddr,
                                Recipients,
                                ServerName,
                                FromAddress,
                                FromName,
                                ReceivedTime,
                                UserLoginID,
                                Now,
                                ReceivedTime,
                                DB_ID,
                                CurrMailFolder,
                                Server_UserID_StoreID,
                                retentionYears,
                                RetentionCode,
                                EmailSize,
                                AttachedFiles,
                                EntryID,
                                EmailIdentifier,
                                EmailFQN,
                                LibraryName,
                                isPublic,
                                bEmlToMSG, AttachmentsLoaded, DaysToHold)
            LL = 138
            If PauseThreadMS > 0 Then
                System.Threading.Thread.Sleep(PauseThreadMS)
            End If
            LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#4")
            If AttachmentsLoaded = True Then
                Dim DoThis As Boolean = False
                If DoThis Then
                    If AttachmentsLoaded = True Then
                        AppendOcrTextEmail(NewGuid)
                        AttachmentsLoaded = False
                    End If
                End If
            End If

            If ParentGuid.Trim.Length > 0 Then : LL = 139
                Body = UTIL.RemoveSingleQuotes(Body) : LL = 140
                Subject = UTIL.RemoveSingleQuotes(Subject) : LL = 141
                FromName = UTIL.RemoveSingleQuotes(FromName) : LL = 142
                FromAddress = UTIL.RemoveSingleQuotes(FromAddress) : LL = 143
                Dim tMsg As String = " " + Chr(254) + Body + Chr(254) + Subject + Chr(254) + FromName + Chr(254) + FromAddress : LL = 144
                concatEmailBody(tMsg, ParentGuid) : LL = 145
            End If : LL = 146
            LL = 147
            ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold) : LL = 148
            Dim ConversionDir As String = UTIL.getTempProcessingDir + "\WMCONVERT\" : LL = 149

            ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold)

            LL = 150
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: ArchiveEmbeddedEmailMessage 100 - LL = " + LL.ToString + " : " + ex.Message)
        End Try

        LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#5")

SKIPTOHERE:

    End Sub

    Function TestEmailConnection(ByVal EmailServer As String, ByVal UserID As String, ByVal Password As String, ByVal Port As String, ByVal IMap As Boolean, ByVal POP As Boolean, ByVal SSL As Boolean) As Boolean

    End Function

    Function ckImapSSLConnection(ByVal MailServerAddr As String, ByVal PortNbr As Integer, ByVal UserLoginID As String, ByVal LoginPassWord As String) As Boolean

        Dim ENC As New ECMEncrypt
        LoginPassWord = ENC.AES256DecryptString(LoginPassWord)
        ENC = Nothing

        Dim imap As New Chilkat.Imap()

        Dim success As Boolean
        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim EmailDir As String = TempDir + "Email"
        Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID

        ' Anything unlocks the component and begins a fully-functional 30-day trial.
        success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
        If (success <> True) Then
            MessageBox.Show(imap.LastErrorText)
            Return False
        End If

        ' To use a secure SSL connection, set SSL and the port:
        imap.Ssl = True
        ' The typical port for IMAP SSL is 993

        imap.Port = PortNbr

        ' Connect to an IMAP server.
        success = imap.Connect(MailServerAddr)
        If (success <> True) Then
            MessageBox.Show(imap.LastErrorText)
            Return False
        End If

        ' Login
        success = imap.Login(UserLoginID, LoginPassWord)
        If (success <> True) Then
            MessageBox.Show(imap.LastErrorText)
            Return False
        End If

        '' Select an IMAP mailbox
        'success = imap.SelectMailbox("Inbox")
        'If (success <> True) Then
        '    messagebox.show(imap.LastErrorText)
        '    Return False
        'End If

        imap.Disconnect()

        Return True

    End Function

    Function clIMapConnection(ByVal MailServerAddr As String, ByVal PortNbr As Integer, ByVal UserLoginID As String, ByVal LoginPassWord As String) As Boolean

        Dim ENC As New ECMEncrypt
        LoginPassWord = ENC.AES256DecryptString(LoginPassWord)
        ENC = Nothing

        Dim imap As New Chilkat.Imap()
        imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")

        imap.Port = Val(PortNbr)

        Try
            imap.Connect(MailServerAddr)
        Catch ex As System.Exception
            MessageBox.Show(imap.LastErrorText)
            Return False
        End Try

        Try
            imap.Login(UserLoginID, LoginPassWord)
        Catch ex As System.Exception
            MessageBox.Show(imap.LastErrorText)
            Return False
        End Try

        Try
            imap.SelectMailbox("Inbox")
        Catch ex As System.Exception
            MessageBox.Show(imap.LastErrorText)
            Return False
        End Try

        imap.Disconnect()

        Return True

    End Function

    Function ckPopConnection(ByVal ServerName As String, ByVal PortNbr As Integer,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String) As Integer

        Dim ENC As New ECMEncrypt
        LoginPassWord = ENC.AES256DecryptString(LoginPassWord)
        ENC = Nothing

        'ServerName  = "pop.dmachicago.com"
        'read mail from a POP3 server.
        Dim mailman As New Chilkat.MailMan()
        mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")

        mailman.MailHost = ServerName
        mailman.PopPassword = LoginPassWord
        mailman.PopUsername = UserLoginID
        Dim iCnt As Integer = -1

        Try
            iCnt = mailman.GetMailboxCount
            Return iCnt
        Catch ex As System.Exception
            MessageBox.Show(mailman.LastErrorText + environment.NewLine + environment.NewLine + ex.Message)
        End Try

        GC.Collect()
        GC.WaitForFullGCComplete()

    End Function

    Function ckPopSSL(ByVal ServerName As String, ByVal PortNbr As Integer, ByVal UserLoginID As String, ByVal LoginPassWord As String) As Integer

        Dim ENC As New ECMEncrypt
        LoginPassWord = ENC.AES256DecryptString(LoginPassWord)
        ENC = Nothing

        ' Create a mailman object for reading email.
        Dim mailman As New Chilkat.MailMan()
        Dim EmailFrom As String = ""
        Dim EmailSubject As String = ""
        Dim EmailBody As String = ""
        Dim EmailFromAddress = ""
        Dim EmailFromName = ""

        ' Any string passed to UnlockComponent automatically begins a 30-day trial.
        Dim success As Boolean
        success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
        If (success <> True) Then
            If gRunUnattended = False Then MessageBox.Show(mailman.LastErrorText)
            Exit Function
        End If

        ' Set our POP3 hostname, login and password
        mailman.MailHost = ServerName
        mailman.PopUsername = UserLoginID
        mailman.PopPassword = LoginPassWord

        ' Indicate that the TCP/IP connection with the POP3 server should be SSL. All POP3
        ' communications are secure using SSL.
        mailman.PopSsl = True
        ' Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
        'mailman.MailPort = 995
        mailman.MailPort = PortNbr
        Dim iCnt As Integer = -1
        Try
            iCnt = mailman.GetMailboxCount
        Catch ex As System.Exception
            MessageBox.Show(mailman.LastErrorText + environment.NewLine + environment.NewLine + ex.Message)
        End Try

        GC.Collect()
        GC.WaitForFullGCComplete()

        Return iCnt

    End Function

    Sub ProcessExchangeServers(ByVal UID As String)
        If UID Is Nothing Then
            UID = gCurrUserGuidID
        End If
        If UID.Length = 0 And gCurrUserGuidID.Length > 0 Then
            UID = gCurrUserGuidID
        End If
        LOG.WriteToArchiveLog("ProcessExchangeServers 100")
        If isArchiveDisabled("EXCHANGE") = True Then
            gExchangeArchiving = False
            Return
        End If

        LOG.WriteToArchiveLog("ProcessExchangeServers 200")
        If gRunMinimized = True Then
            frmExchangeMonitor.WindowState = FormWindowState.Minimized
        Else
            frmExchangeMonitor.Show()
        End If

        LOG.WriteToArchiveLog("ProcessExchangeServers 300")

        Dim S = "SELECT [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL, IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM [ExchangeHostPop] where Userid = '" + gCurrUserGuidID + "' order by [HostNameIp] ,[UserLoginID]"

        Dim HostNameIp As String = ""
        Dim UserLoginID As String = ""
        Dim LoginPw As String = ""
        Dim LeaveOnServer As Boolean = True
        Dim DeleteAfterDownload As Boolean = False
        Dim PortNbr As String = ""
        Dim RetentionCode As String = ""
        Dim retentionYears As Integer = 10
        Dim SSL As Boolean = False
        Dim IMap As Boolean = False
        Dim FolderName As String = ""
        Dim LibraryName As String = ""
        Dim isPublic As Boolean = False
        Dim strReject As String = ""
        Dim ConvertEmlToMSG As Boolean = False
        Dim DaysToRetain As Integer = 1000000
        Dim LibraryOwnerUserID = ""
        Dim tSSL As String = ""
        Dim DaysToHold As String = ""

        Dim ConnStr As String = ""

        Dim ListOfServers As New List(Of String)

        LOG.WriteToArchiveLog("ProcessExchangeServers 400")
        Dim rsData As SqlDataReader = Nothing
        LOG.WriteToArchiveLog("ProcessExchangeServers 400.1")

        Try
            rsData = SqlQryNewConn(S)
            LOG.WriteToArchiveLog("ProcessExchangeServers 400.2: ")
            Dim LL As Integer = 0
            Dim ArchiveGuid = System.Guid.NewGuid.ToString()
            LOG.WriteToArchiveLog("ProcessExchangeServers 400.3: ")
            LL = 0
            If rsData.HasRows Then
                Do While rsData.Read()
                    'LOG.WriteToArchiveLog("ProcessExchangeServers 600")
                    If gTerminateImmediately = True Then
                        gExchangeArchiving = False
                        Return
                    End If

                    '0 [HostNameIp],
                    '1 [UserLoginID],
                    '2 [LoginPw],
                    '3 [PortNbr],
                    '4 [DeleteAfterDownload],
                    '5 [RetentionCode],
                    '6 SSL,
                    '7 IMap,
                    '8 FolderName,
                    '9 LibraryName,
                    '10 isPublic
                    '11 DaysToHold
                    '12 strReject
                    '13 ConvertEmlToMSG

                    Try
                        DaysToHold = rsData.GetValue(11).ToString
                    Catch ex As System.Exception
                        DaysToHold = False
                    End Try

                    Try
                        ConvertEmlToMSG = rsData.GetBoolean(13)
                    Catch ex As System.Exception
                        ConvertEmlToMSG = False
                    End Try

                    Try
                        LibraryName = rsData.GetValue(9).ToString
                    Catch ex As System.Exception
                        LibraryName = "NA"
                    End Try

                    Try
                        isPublic = rsData.GetBoolean(10)
                    Catch ex As System.Exception
                        isPublic = False
                    End Try

                    Try
                        DaysToRetain = rsData.GetInt32(11)
                    Catch ex As System.Exception
                        DaysToRetain = 1000000
                    End Try
                    Try
                        strReject = rsData.GetValue(12).ToString
                    Catch ex As System.Exception
                        strReject = ""
                    End Try

                    If LibraryName.Trim.Length > 0 Then
                        LibraryOwnerUserID = GetLibOwnerByName(LibraryName)
                        If LibraryOwnerUserID.Trim.Length = 0 Then
                            LOG.WriteToArchiveLog("ERROR: 500 - No Lib Owner found.")
                        End If
                    Else
                        LOG.WriteToArchiveLog("Warning: 500.x01 - No Library found.")
                    End If

                    Try
                        HostNameIp = rsData.GetValue(0).ToString
                    Catch ex As System.Exception
                        HostNameIp = ""
                    End Try

                    Try
                        UserLoginID = rsData.GetValue(1).ToString
                    Catch ex As System.Exception
                        UserLoginID = ""
                    End Try

                    'WDM 03/08/2010If ConvertEmlToMSG = True And RedemptionDllExists = False Then
                    'If ConvertEmlToMSG = True And RedemptionDllExists = False Then
                    '    log.WriteToArchiveLog("ERROR ERROR - ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp  + " :" + LibraryName + " : " + UserLoginID + "' will not be processed.")
                    '    GoTo NextBox
                    'End If

                    LoginPw = rsData.GetValue(2).ToString
                    LoginPw = ENC.AES256DecryptString(LoginPw)

                    Try
                        PortNbr = rsData.GetValue(3).ToString
                    Catch ex As System.Exception
                        PortNbr = ""
                    End Try
                    Try
                        Dim tDeleteAfterDownload = rsData.GetValue(4).ToString
                        If tDeleteAfterDownload.Equals("False") Then
                            DeleteAfterDownload = False
                        Else
                            DeleteAfterDownload = True
                        End If
                    Catch ex As System.Exception
                        DeleteAfterDownload = False
                    End Try
                    Try
                        RetentionCode = rsData.GetValue(5).ToString
                    Catch ex As System.Exception
                        RetentionCode = ""
                    End Try
                    Try
                        tSSL = rsData.GetValue(6).ToString
                        If tSSL.Equals("False") Then
                            SSL = False
                        Else
                            SSL = True
                        End If
                    Catch ex As System.Exception
                        SSL = False
                    End Try
                    Try
                        Dim tIMap As String = rsData.GetValue(7).ToString
                        If tIMap.Equals("False") Then
                            IMap = False
                        Else
                            IMap = True
                        End If
                    Catch ex As System.Exception
                        IMap = False
                    End Try

                    'If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 500 : " + HostNameIp )

                    retentionYears = getRetentionPeriod(RetentionCode)

                    'If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 500.1 : " + retentionYears.ToString)
                    If DeleteAfterDownload = False Then
                        LeaveOnServer = True
                    Else
                        LeaveOnServer = False
                    End If

                    LOG.WriteToArchiveLog("Processing Exchange Box " + HostNameIp + " emails by " + UserLoginID + " : " + Now.ToString)

                    '0 HostNameIp,
                    '1 UserLoginID,
                    '2 LoginPw,
                    '3 PortNbr,
                    '4 DeleteAfterDownload,
                    '5 RetentionCode,
                    '6 SSL,
                    '7 IMap,
                    '8 FolderName,
                    '9 LibraryName,
                    '10 isPublic
                    '11 DaysToHold
                    '12 strReject
                    '13 ConvertEmlToMSG
                    Dim ServerString As String = ""
                    ServerString = ServerString + HostNameIp + Chr(254)     '0
                    ServerString = ServerString + UserLoginID + Chr(254)    '1
                    ServerString = ServerString + LoginPw + Chr(254)        '2
                    ServerString = ServerString + PortNbr + Chr(254)        '3
                    ServerString = ServerString & DeleteAfterDownload & Chr(254)    '4
                    ServerString = ServerString + RetentionCode + Chr(254)  '5
                    ServerString = ServerString & SSL & Chr(254)            '6
                    ServerString = ServerString & IMap & Chr(254)           '7
                    ServerString = ServerString & FolderName & Chr(254)           '8
                    ServerString = ServerString & LibraryName & Chr(254)    '9
                    ServerString = ServerString & isPublic & Chr(254)       '10
                    ServerString = ServerString & DaysToHold & Chr(254)     '11
                    ServerString = ServerString + strReject + Chr(254)      '12
                    ServerString = ServerString & ConvertEmlToMSG & Chr(254)    '13
                    ServerString = ServerString & retentionYears & Chr(254) '14
                    ServerString = ServerString & DaysToRetain              '15

                    ListOfServers.Add(ServerString)

NextBox:
                    LOG.WriteToArchiveLog("ProcessExchangeServers 700")
                Loop
            End If
            LOG.WriteToArchiveLog("ProcessExchangeServers 800")
            rsData.Close()
            LOG.WriteToArchiveLog("ProcessExchangeServers 900")
            rsData = Nothing
            LOG.WriteToArchiveLog("ProcessExchangeServers 1000")
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ProcessExchangeServers 2000")
            LOG.WriteToArchiveLog("ERROR 641.92.2 ProcessExchangeServers - " + ex.Message)
        Finally
            LOG.WriteToArchiveLog("ProcessExchangeServers 3000.1")
            If Not rsData Is Nothing Then
                LOG.WriteToArchiveLog("ProcessExchangeServers 3000.2")
                If Not rsData.IsClosed Then
                    LOG.WriteToArchiveLog("ProcessExchangeServers 4000.1")
                    rsData.Close()
                    LOG.WriteToArchiveLog("ProcessExchangeServers 5000.1")
                End If
                LOG.WriteToArchiveLog("ProcessExchangeServers 6000.1")
                rsData = Nothing
            End If
            LOG.WriteToArchiveLog("ProcessExchangeServers 7000.1")
            GC.Collect()
            LOG.WriteToArchiveLog("ProcessExchangeServers 8000.1")
            GC.WaitForPendingFinalizers()
            LOG.WriteToArchiveLog("ProcessExchangeServers 9000.1")
        End Try

        'frmReconMain.SB.Text = "Processing Exchange servers: " & ListOfServers.Count
        LOG.WriteToArchiveLog("ProcessExchangeServers 10000")

        Try
            Dim I As Integer = 0
            Dim A() As String
            '************************************************************
            '* Process Each Exchange Server
            '************************************************************
            For I = 0 To ListOfServers.Count - 1
                LOG.WriteToArchiveLog("ProcessExchangeServers 10001")
                S = ListOfServers(I)
                If gTerminateImmediately = True Then
                    gExchangeArchiving = False
                    Return
                End If

                A = S.Split(Chr(254))

                HostNameIp = A(0)
                UserLoginID = A(1)
                LoginPw = A(2)
                PortNbr = A(3)
                DeleteAfterDownload = A(4)
                RetentionCode = A(5)
                SSL = A(6)
                IMap = A(7)
                FolderName = A(8)
                LibraryName = A(9)
                isPublic = A(10)
                DaysToHold = A(11)
                strReject = A(12)
                ConvertEmlToMSG = A(13)
                retentionYears = A(14)
                DaysToRetain = A(15)

                If DeleteAfterDownload = False Then
                    LeaveOnServer = True
                Else
                    LeaveOnServer = False
                End If

                'LeaveOnServer, retentionYears, DaysToRetain,
                Dim ddebug As Boolean = False
                Try
                    If SSL = True And IMap = False Then
                        If PortNbr.Trim.Length = 0 Then
                            PortNbr = "995"
                        End If
                        If PortNbr.Equals("-1") Then
                            PortNbr = "995"
                        End If

                        'If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 600 PortNbr : " + PortNbr )
                        LOG.WriteToArchiveLog("Processing Exchange SSL " + HostNameIp + " emails by " + UserLoginID)
                        frmMain.tbExchange.Text = "Processing Exchange: " & Now.ToString
                        If ddebug Then
                            LOG.WriteToArchiveLog("ProcessExchangeServers 1000")
                            LOG.WriteToArchiveLog("HostNameIp: " + HostNameIp)
                            LOG.WriteToArchiveLog("UserLoginID: " + UserLoginID)
                            LOG.WriteToArchiveLog("LoginPw: " + LoginPw)
                            LOG.WriteToArchiveLog("PortNbr: " + PortNbr)
                            LOG.WriteToArchiveLog("LeaveOnServer: " + LeaveOnServer)
                            LOG.WriteToArchiveLog("retentionYears: " + retentionYears)
                            LOG.WriteToArchiveLog("RetentionCode: " + RetentionCode)
                            LOG.WriteToArchiveLog("LibraryName: " + LibraryName)
                            LOG.WriteToArchiveLog("isPublic: " + isPublic)
                            LOG.WriteToArchiveLog("DaysToRetain: " + DaysToRetain)
                            LOG.WriteToArchiveLog("strReject: " + strReject)
                            LOG.WriteToArchiveLog("ConvertEmlToMSG: " + ConvertEmlToMSG)
                        End If

                        frmExchangeMonitor.Show()
                        ReadEmailUsingSSL(UID, HostNameIp, UserLoginID, LoginPw, PortNbr, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG)
                        frmMain.tbExchange.Text = "Done"
                        frmExchangeMonitor.Close()
                    ElseIf IMap = True And SSL = True Then
                        If PortNbr.Trim.Length = 0 Then
                            PortNbr = "993"
                        End If
                        If PortNbr.Equals("-1") Then
                            PortNbr = "993"
                        End If
                        'If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 700 PortNbr : " + PortNbr )
                        LOG.WriteToArchiveLog("Processing Exchange IMAP " + HostNameIp + " emails by " + UserLoginID)
                        frmMain.tbExchange.Text = "Processing Exchange: " & Now.ToString
                        frmExchangeMonitor.Show()
                        Dim BB As Boolean
                        BB = Me.getImapEmailSSLV3(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG, True)
                        If Not BB Then
                            getImapEmailSSL(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG, True)
                        End If
                        frmExchangeMonitor.Close()
                    ElseIf IMap = True And SSL = False Then
                        If PortNbr.Trim.Length = 0 Then
                            PortNbr = "143"
                        End If
                        If PortNbr.Equals("-1") Then
                            PortNbr = "143"
                        End If
                        'If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 800 PortNbr : " + PortNbr )
                        LOG.WriteToArchiveLog("INFO: Processing Exchange IMAP/SSL " + HostNameIp + " emails by " + UserLoginID)
                        frmMain.SB2.Text = "Processing Exchange: " & Now.ToString
                        frmMain.tbExchange.Text = "Processing Exchange: " & Now.ToString
                        LOG.WriteToArchiveLog("ProcessExchangeServers 3000.5")
                        Dim SuccessfulRun As Boolean = True

                        frmExchangeMonitor.Show()
                        SuccessfulRun = getIMapEmailV3(UID, HostNameIp, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG)
                        If Not SuccessfulRun Then
                            getIMapEmail(UID, HostNameIp, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG)
                        End If
                        LOG.WriteToArchiveLog("ProcessExchangeServers 3001.5")
                        frmMain.tbExchange.Text = "..." & Now.ToString
                        frmExchangeMonitor.Close()
                    Else
                        If PortNbr.Trim.Length = 0 Then
                            PortNbr = "110"
                        End If
                        If PortNbr.Equals("-1") Then
                            PortNbr = "110"
                        End If
                        'If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 900 PortNbr : " + PortNbr )
                        LOG.WriteToArchiveLog("Processing Exchange POP " + HostNameIp + " emails by " + UserLoginID)
                        frmMain.tbExchange.Text = "Processing Exchange: " & Now.ToString
                        LOG.WriteToArchiveLog("ProcessExchangeServers 4000")
                        frmExchangeMonitor.Show()
                        ReadEmailFromServer(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG)
                        frmMain.tbExchange.Text = "..." & Now.ToString
                        frmExchangeMonitor.Close()
                    End If
                    LOG.WriteToArchiveLog("ProcessExchangeServers 20000")
                Catch ex As System.Exception
                    LOG.WriteToArchiveLog("ProcessExchangeServers 30000")
                    LOG.WriteToArchiveLog("WARNING 641.92.25 ProcessExchangeServers - " + ex.Message)
                End Try
                LOG.WriteToArchiveLog("ProcessExchangeServers 40000")
            Next
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ProcessExchangeServers 50000")
            LOG.WriteToArchiveLog("ERROR 641.92.5 ProcessExchangeServers - " + ex.Message)
        End Try

        LOG.WriteToArchiveLog("ProcessExchangeServers 60000")
        frmMain.SB.Text = "Processing Exchange COMPLETE: " & Now.ToString
        LOG.WriteToArchiveLog("Exchange Archive completed @ " + Now.ToString)
        frmExchangeMonitor.Close()
        UpdateAttachmentCounts()
        gExchangeArchiving = False

        My.Settings("LastArchiveEndTime") = Now
        My.Settings.Save()

    End Sub

    Sub ApplyPendingEmail(ByVal UID As String, ByVal ServerName As String,
                         ByVal CurrMailFolder As String,
                         ByVal LibraryName As String,
                         ByVal RetentionCode As String, ByVal DaysToHold As Integer)

        Dim MsgFQN As String = ""
        Dim DefaultSubject As String = ""
        Dim Body As String = ""
        Dim AttachedFiles As New List(Of String)
        Dim bWinMail As Boolean = False

        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim PendDir As String = TempDir + "Email\Attachment\PendingEmail"
        Dim EmailDir As String = TempDir + "Email"

        Dim D As Directory
        If Not D.Exists(PendDir) Then
            D = Nothing
            Return
        End If

        Dim storefile As Directory
        Dim directory As String
        Dim files As String()
        Dim File As String
        Dim DeleteFiles As Boolean = True
        Dim FilesToDelete As New List(Of String)
        Try
            files = storefile.GetFiles(PendDir, "*.MSG")
            Dim iFiles As Integer = 0
            For Each File In files
                iFiles += 1
                ''frmExchangeMonitor.lblMsg.Text = "Applying embedded emails: " + iFiles.ToString + " of " + files.Count.ToString
                ''frmExchangeMonitor.lblMsg.Refresh()
                System.Windows.Forms.Application.DoEvents()

                Dim ParentGuid As String = ""
                If InStr(File, ".") > 0 Then
                    ParentGuid = Mid(File, 1, InStr(File, ".") - 1)
                    If isGuid(ParentGuid) = False Then
                        ParentGuid = ""
                    End If
                End If

                UTIL.deleteDirectoryFile(AttachmentDir)
                Dim FQN As String = File
                Dim bAddedMsg As Boolean = LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, DaysToHold)
                If Not bAddedMsg Then
                    LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 500 : Failed to add embedded MSG file: " + environment.NewLine + ServerName + environment.NewLine + " : " + CurrMailFolder)
                Else
                    FilesToDelete.Add(FQN)
                End If
            Next
            ''frmExchangeMonitor.lblMsg.Text = ""
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message)
            DeleteFiles = False
        End Try

        If DeleteFiles = True Then
            Dim F As File
            Dim iFiles As Integer = 0
            For Each sFile As String In FilesToDelete
                iFiles += 1
                Dim FQN As String = sFile
                Try
                    If System.IO.File.Exists(FQN) Then
                        System.IO.File.Delete(FQN)
                    End If
                Catch ex As system.Exception
                    LOG.WriteToArchiveLog("DELETE FAILURE 05|" + FQN)
                End Try

            Next
            F = Nothing
        End If


        'frmExchangeMonitor.lblMsg.Text = ""
    End Sub

    Sub ApplyPendingEmail(ByVal UID As String, ByVal DirectoryName As String, ByVal ServerName As String,
                         ByVal CurrMailFolder As String,
                         ByVal LibraryName As String,
                         ByVal RetentionCode As String, ByVal DaysToHold As Integer)

        Dim MsgFQN As String = ""
        Dim DefaultSubject As String = ""
        Dim Body As String = ""
        Dim AttachedFiles As New List(Of String)
        Dim bWinMail As Boolean = False

        Dim I As Integer = 0
        Dim J As Integer = 0
        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim AttachmentDir As String = TempDir + "Email\Attachment"
        Dim PendDir As String = DirectoryName
        Dim EmailDir As String = TempDir + "Email"

        Dim D As Directory
        If Not D.Exists(PendDir) Then
            D = Nothing
            Return
        End If

        Dim storefile As Directory
        Dim directory As String
        Dim files As String()
        Dim File As String
        Dim DeleteFiles As Boolean = True

        Try
            files = storefile.GetFiles(PendDir, "*.MSG")
            For Each File In files
                UTIL.deleteDirectoryFile(AttachmentDir)

                Dim FQN As String = File

                Dim ParentGuid As String = ""
                If InStr(File, ".") > 0 Then
                    ParentGuid = Mid(File, 1, InStr(File, ".") - 1)
                    If isGuid(ParentGuid) = False Then
                        ParentGuid = ""
                    End If
                End If

                LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, DaysToHold)
            Next
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message)
            DeleteFiles = False
        Finally
            If DeleteFiles = True Then
                For Each File In files
                    Dim FQN As String = PendDir + "\" + File

                Next
            End If

        End Try

    End Sub

    Function ApplyEmailBundleV2(ByVal UID As String, ByVal mailman As Chilkat.MailMan,
                         ByVal ServerName As String,
                         ByVal UserLoginID As String,
                         ByVal PassWord As String,
                         ByVal LeaveOnServer As Boolean,
                         ByVal retentionYears As Integer,
                         ByVal RetentionCode As String,
                         ByVal LibraryName As String,
                         ByVal isPublic As Boolean,
                         ByVal DaysToHold As Integer,
                         ByVal strReject As String,
                         ByVal bEmlToMSG As Boolean) As Boolean

        Dim RC As Boolean = False
        Dim PauseThreadMS As Integer = 0
        Dim L As New SortedList(Of String, String)
        Dim bundle As Chilkat.EmailBundle

        Try
            PauseThreadMS = CInt(getUserParm("UserEmail_Pause"))
        Catch ex As System.Exception
            PauseThreadMS = 0
        End Try

        'Dim bundle As Chilkat.EmailBundle = Nothing
        Dim email As Chilkat.Email = Nothing
        Dim CurrMailFolder As String = ServerName + ":" + UserLoginID
        Dim LL As Integer = 1

        Try
            ' Set our POP3 hostname, login and password
            mailman.MailHost = ServerName
            mailman.PopUsername = UserLoginID
            mailman.PopPassword = PassWord
            'mailman.MailPort = 110
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 500 ApplyEmailBundleV2: LL = " + LL.ToString + ", EX: Could not set login parms.")
            Return False
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()
        Dim CurrLoopCnt As Integer = 0
        Try
            LL = 2
            Dim sDownLoadSize As String = ""
            LL = 3
            Dim DownLoadSize As Integer = 0
            LL = 4
            TotalEmailsInArchive = 0
            LL = 5
            Dim EmailsAdded As Integer = 0
            LL = 2

            LL = 3
            Try
                LL = 4
                sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings("EmailDownLoadSize")
                LL = 5
                DownLoadSize = Val(sDownLoadSize)
                LL = 6
            Catch ex As System.Exception
                DownLoadSize = 100
            End Try
            LL = 9

            LL = 10
            If DownLoadSize = 0 Then
                LL = 11
                DownLoadSize = 5000
                LL = 12
            End If
            LL = 13

            frmExchangeMonitor.lblMessageInfo.Text = "Process Email Bundle V2"
            frmExchangeMonitor.lblMessageInfo.Refresh()
            System.Windows.Forms.Application.DoEvents()

            If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 100 Download Size = " + DownLoadSize.ToString)
            LL = 15

            If ServerName.Length = 0 Then
                LL = 17
                ServerName = gMachineID
                LL = 18
            End If
            LL = 19
            If UserLoginID.Length = 0 Then
                LL = 20
                UserLoginID = "ServerManger"
                LL = 21
            End If
            LL = 23

            frmExchangeMonitor.lblServer.Text = "Email Host: " + ServerName
            LL = 24

            frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
            LL = 25
            System.Windows.Forms.Application.DoEvents()
            LL = 26

            'Dim I As Integer = 0
            LL = 29
            Dim J As Integer = 0
            LL = 30
            Dim TempDir As String = UTIL.getTempProcessingDir + "\"
            TempDir = TempDir.Replace("\\", "\")
            If Not Directory.Exists(TempDir) Then
                Directory.CreateDirectory(TempDir)
            End If

            Dim AttachmentDir As String = TempDir + "\Email\Attachment"
            AttachmentDir = AttachmentDir.Replace("\\", "\")
            If Not Directory.Exists(AttachmentDir) Then
                Directory.CreateDirectory(AttachmentDir)
            End If

            Dim EmailDir As String = TempDir + "\Email"
            EmailDir = EmailDir.Replace("\\", "\")
            If Not Directory.Exists(EmailDir) Then
                Directory.CreateDirectory(EmailDir)
            End If

            If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 200")
            Dim iCnt As Integer = 0
            LL = 37
            Try
                iCnt = 1000
                'iCnt = mailman.GetMailboxCount
            Catch ex As System.Exception
                LOG.WriteToArchiveLog("ApplyEmailBundleV2 100as1 : failed to get email count." + Now.ToString)
            End Try
            'log.WriteToArchiveLog("ApplyEmailBundleV2 100as1.1 : email count = " & iCnt & " : " & Now.ToString)

            LL = 41
            Dim chunkBeginIdx As Long = 0
            LL = 42
            Dim chunkEndIdx As Long = DownLoadSize
            LL = 43
            LL = 44
            ' First, get the list of UIDLs for all emails in the mailbox.
            LL = 45
            Dim sa As New Chilkat.StringArray
            LL = 46
            If sa Is Nothing Then
                LOG.WriteToArchiveLog("ApplyEmailBundleV2 100XX : failed to allocate download array: " + Now.ToString)
                Exit Try
            End If
            Dim iCheck As Integer = mailman.CheckMail
            If iCheck = -1 Then
                LOG.WriteToArchiveLog("ApplyEmailBundleV2 100.66 : Appears to be an error in attaching to Exchange server:  " + UserLoginID + " - " + Now.ToString + ", aborting archive - Library: " + LibraryName)
                Exit Try
            End If

            frmExchangeMonitor.lblMessageInfo.Text = "Fetching group of emails."
            LL = 82
            frmExchangeMonitor.lblMessageInfo.Refresh()
            LL = 83
            System.Windows.Forms.Application.DoEvents()
            LL = 84
            '****************************************************************************
            sa = mailman.GetUidls()
            '****************************************************************************
            If ddebug Then
                Console.WriteLine(mailman.LastErrorText)
                Console.WriteLine("Total: " + sa.Count.ToString)
            End If

            LOG.WriteToArchiveLog("ApplyEmailBundleV2 100as1.1 : email count = " & sa.Count.ToString & " : " & Now.ToString)

            frmExchangeMonitor.lblMessageInfo.Text = "Processing " + sa.Count.ToString + " emails from " + UserLoginID
            frmExchangeMonitor.lblMessageInfo.Refresh()
            LL = 47

            If sa Is Nothing Then
                LOG.WriteToArchiveLog("ApplyEmailBundleV2 100ZZ : No emails found to download: " + Now.ToString + ", aborting archive - Library: " + LibraryName)
                LOG.WriteToArchiveLog("ApplyEmailBundleV2 100ZZ.1 : " + mailman.LastErrorText)
                Exit Try
            End If

            Dim TotalEmailsToProcess As Integer = 0
            'Dim CurrentlyProcessedEmails As Integer = 0
            Dim skippedEmails As Integer = 0
            Dim ProcessedEmails As Integer = 1
            Dim TotalEmailsProcessed As Integer = 0
            Dim TotalEmails As Integer = sa.Count
            Dim uidl As String = ""
            Dim lAvailableMemory As Double = 0
            Dim PercentAvailableMemory As Double = 0
            Dim Warnings As Integer = 0

            Dim MemoryRemaining As Double = 0
            Dim computer_info As New Devices.ComputerInfo
            TotalMemory = computer_info.TotalPhysicalMemory

            'LoadExckKeys(L)
            DBLocal.LoadExchangeKeys(L)

            Dim StartTime As DateTime = Now
            Dim ElapsedTime As TimeSpan
            Dim ElapsedTxTime As TimeSpan

            Dim eAvg As Double = 0
            Dim txAvg As Double = 0
            Dim eAvgTotal As Double = 0
            Dim txAvgTotal As Double = 0

            Dim ProcessedCnt As Integer = 0

            Try
                LL = 62
                For iMails As Integer = 0 To TotalEmails - 1

                    ElapsedTxTime = Now().Subtract(StartTime)
                    StartTime = Now

                    uidl = sa.GetString(iMails)

                    If DBLocal.ExchangeExists(uidl) Then
                        GoTo NEXTBUNDLE
                    End If

                    If L.IndexOfKey(uidl) >= 0 Then
                        GoTo NEXTBUNDLE
                    End If

                    ProcessedCnt += 1

                    '**********************************
                    email = mailman.FetchEmail(uidl)
                    Dim EntryID As String = uidl
                    '**********************************

                    If frmMain.ckTerminate.Checked Then
                        frmExchangeMonitor.lblMsg.Text = "Processing HALTED"
                        frmExchangeMonitor.lblMsg.Refresh()
                        Return True
                    End If
                    If iMails = TotalEmails - 2 Then
                        Console.WriteLine("Almost done")
                    End If

                    Dim ETime As DateInterval = Nothing
                    ElapsedTime = Now().Subtract(StartTime)

                    txAvgTotal += ElapsedTxTime.TotalMilliseconds
                    eAvgTotal += ElapsedTime.TotalMilliseconds
                    eAvg = eAvgTotal / ProcessedCnt
                    txAvg = txAvgTotal / ProcessedCnt

                    If iMails Mod 5 = 0 Then
                        frmExchangeMonitor.lblCnt.Text = "Processing " + iMails.ToString + " of " + TotalEmails.ToString
                        frmExchangeMonitor.lblCnt.Refresh()
                        lAvailableMemory = UTIL.getUsedMemory()
                        'frmExchangeMonitor.lblMsg.Text = "Mem Free: " + lAvailableMemory.ToString + " MB"
                        'frmExchangeMonitor.lblMsg.Refresh()
                        MemoryRemaining = TotalMemory - lAvailableMemory * 1000000
                        PercentAvailableMemory = (lAvailableMemory * 1000000 / TotalMemory)
                        PercentAvailableMemory = (1 - PercentAvailableMemory) * 100
                        If PercentAvailableMemory < 20 And PercentAvailableMemory > 0 Then
                            frmExchangeMonitor.lblMsg.BackColor = Drawing.Color.DarkRed
                            frmExchangeMonitor.lblMsg.Text = "Memory watch: " & PercentAvailableMemory * 100 & "% free"
                            frmExchangeMonitor.lblMsg.Refresh()
                            Warnings += 1
                            If Warnings > 5 Then
                                Reset()
                                DBARCH.CloseConn()
                                LOG.WriteToArchiveLog("NOTICE: Restart may be needed to reclaim memory.")
                                'System.Windows.Forms.Application.Restart()
                                Warnings = 0
                            End If
                            GC.Collect()
                            GC.WaitForPendingFinalizers()
                        End If

                        frmExchangeMonitor.lblServer.Text = "Email Host: " + ServerName
                        frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
                        frmExchangeMonitor.lblSpeed.Text = ElapsedTime.ToString
                        frmExchangeMonitor.txTime.Text = ElapsedTxTime.ToString

                        frmExchangeMonitor.eTimeAvg.Text = eAvg.ToString + "/ms"
                        frmExchangeMonitor.txAvg.Text = txAvg.ToString + "/ms"

                        frmExchangeMonitor.Refresh()

                    End If
                    If iMails Mod 100 = 0 Then
                        frmExchangeMonitor.lblMsg.Text = "Mem Free: " + lAvailableMemory.ToString + " MB @ " & TimeOfDay
                        frmExchangeMonitor.lblMsg.Refresh()
                        System.Windows.Forms.Application.DoEvents()
                        GC.Collect()
                        GC.WaitForPendingFinalizers()
                    End If

                    If PauseThreadMS > 0 Then
                        System.Threading.Thread.Sleep(50)
                    End If

                    'LOG.WriteToKeyLog(uidl, True)
                    'DBARCH.AddExcgKey(uidl)

                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("TotalEmailsProcessed = " + TotalEmailsProcessed.ToString)

                    System.Windows.Forms.Application.DoEvents()

                    If (email Is Nothing) Then
                        GoTo NEXTBUNDLE
                    End If

                    System.Windows.Forms.Application.DoEvents()
                    '  Process the bundle... (processing code)
                    '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
                    LL = 98
                    Dim emailKey As String = ""

                    Dim NewGuid As String = System.Guid.NewGuid.ToString()
                    LL = 113

                    If email Is Nothing Then
                        GoTo NEXTBUNDLE
                    End If

                    LL = 115
                    Dim Subject As String = ""
                    LL = 116
                    Try
                        Subject = email.Subject
                        Subject = LOG.PullOutSingleQuotes(Subject)
                    Catch ex As System.Exception
                        Subject = "NA"
                    End Try

                    LL = 117
                    Dim EmailFrom As String = email.From
                    LL = 118
                    Dim FromAddress As String = email.FromAddress
                    LL = 119
                    Dim FromName As String = email.FromName
                    LL = 120
                    Dim From As String = email.From
                    LL = 121

                    LL = 122
                    If strReject.Trim.Length > 0 Then
                        LL = 123
                        Dim A As String() = strReject.Split(",")
                        LL = 124
                        For II As Integer = 0 To UBound(A)
                            LL = 125
                            Dim S1 As String = A(II).Trim
                            LL = 126
                            If S1.Trim.Length > 0 Then
                                LL = 127
                                If InStr(Subject, S1, CompareMethod.Text) Then
                                    LL = 128
                                    LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject)
                                    LL = 129
                                    GoTo NextRec
                                    LL = 130
                                End If
                                LL = 131
                            End If
                            LL = 132
                        Next
                        LL = 133
                    End If

                    LL = 134
                    Dim NumAlternatives As Integer = email.NumAlternatives
                    LL = 147

                    Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                    LL = 148
                    Dim NumAttachments As Integer = email.NumAttachments
                    LL = 149
                    If NumAttachments > 0 > 0 Then
                        Console.WriteLine("Attachments Here: " + NumAttachments.ToString)
                        LL = 151
                    End If
                    If NumAttachedMessages > 0 Then
                        Console.WriteLine("Attachments Message Here: " + NumAttachments.ToString)
                        LL = 151
                    End If
                    LL = 152
                    Dim NumBcc As Integer = email.NumBcc
                    LL = 153
                    Dim NumCC As Integer = email.NumCC
                    LL = 154
                    Dim NumTo As Integer = email.NumTo
                    LL = 155
                    Dim ReplyTo As String = email.ReplyTo
                    LL = 156
                    Dim SignedBy As String = email.SignedBy
                    LL = 157
                    Dim EmailSize As Integer = email.Size
                    LL = 158
                    Dim ReceivedDate As String = Nothing
                    ReceivedDate = email.LocalDate.ToString
                    LL = 159
                    Dim GMT As String = email.EmailDate.ToString
                    LL = 160
                    Dim Header As String = email.Header
                    LL = 161
                    Dim EmailBody As String = email.Body
                    EmailBody = LOG.PullOutSingleQuotes(EmailBody)
                    LL = 164
                    Dim Recipients As New ArrayList
                    LL = 165
                    Dim EmailTo As New ArrayList
                    LL = 166
                    Dim EmailToAddr As New ArrayList
                    LL = 167
                    Dim EmailToName As New ArrayList
                    LL = 168
                    Dim Bcc As New ArrayList
                    LL = 169
                    Dim BccAddr As New ArrayList
                    LL = 170
                    Dim BccName As New ArrayList
                    LL = 171
                    Dim CC As New ArrayList
                    LL = 172
                    Dim CcAddr As New ArrayList
                    LL = 173
                    Dim CcName As New ArrayList
                    LL = 174
                    Dim bLoadAttachments As Boolean = False
                    LL = 175

                    LL = 176
                    Dim EmailDateTimeGMT As String = GMT
                    LL = 177
                    FixDate(EmailDateTimeGMT)
                    LL = 178
                    Dim tSubject As String = Mid(Subject, 1, 100)
                    LL = 179
                    RemoveBadChars(tSubject)

                    Dim EmailIdentifier As String = EmailSize.ToString + "~" + EmailDateTimeGMT + "~" + FromAddress.Trim + "~" + tSubject + "~" + EmailToAddr.ToString + "~" + UID
                    LL = 182
                    RemoveBlanks(EmailIdentifier)

                    Try
                        If L.ContainsKey(uidl) Then
                            GoTo NextRec
                        End If
                    Catch ex As System.Exception

                    End Try

                    'Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
                    Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
                    Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                    LL = 184
                    If bEmailExists Then
                        LL = 185
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 700X already exists: " + iMails.ToString)
                        LL = 186
                        skippedEmails += 1
                        LL = 187
                        frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
                        LL = 188
                        frmExchangeMonitor.lblMessageInfo.Refresh()
                        LL = 189
                        System.Windows.Forms.Application.DoEvents()
                        LL = 190
                        Dim DaysOld As Integer = email.NumDaysOld
                        LL = 191
                        If DaysOld > DaysToHold Then
                            LL = 192
                            Dim success As Boolean = mailman.DeleteEmail(email)
                            LL = 193
                            If (Not success) Then
                                LL = 194
                                Dim Msg As String = "Subject: " + Subject + environment.NewLine
                                LL = 195
                                Msg += "FromName: " + FromName + environment.NewLine
                                LL = 196
                                Msg += "FromAddress: " + FromAddress + environment.NewLine
                                LL = 197
                                LOG.WriteToArchiveLog("ERROR ApplyEmailBundleV2: Failed to delete email:" + environment.NewLine + Msg)
                                LL = 198
                            End If
                            LL = 199
                        End If
                        LL = 200

                        'LOG.WriteToKeyLog(uidl, True)
                        DBARCH.AddExcgKey(uidl)
                        DBLocal.addExchange(uidl)
                        GoTo NextRec
                        LL = 201
                    End If

                    If bEmailExists Then
                        LL = 206
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 700X already exists: " + iMails.ToString)
                        LL = 207
                        skippedEmails += 1
                        LL = 208
                        frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
                        LL = 209
                        frmExchangeMonitor.lblMessageInfo.Refresh()
                        LL = 210
                        System.Windows.Forms.Application.DoEvents()
                        LL = 211
                        GoTo NextRec
                        LL = 212
                    End If

                    Dim B As Boolean = bEmailExists
                    Dim EmailFQN As String = EmailDir + "\" + NewGuid + "~.EML"
                    EmailFQN = EmailFQN.Replace("\\", "\")
                    If Not Directory.Exists(EmailFQN) Then
                        Directory.CreateDirectory(EmailFQN)
                    End If

                    'Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
                    'Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
                    B = ExchangeEmailExists(EmailIdentifier)
                    If B Then
                        GoTo NextRec
                    End If

                    If NumAttachments > 0 Then
                        '** Clean out the directory
                        deleteDirectoryFile(AttachmentDir)
                        ' Save attachments to the "attachments" directory.
                        email.SaveAllAttachments(AttachmentDir)
                        bLoadAttachments = True
                    End If

                    If NumAttachedMessages > 0 Then
                        'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                        For II As Integer = 0 To NumAttachedMessages - 1
                            'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                            Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                            ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                            objEmail = Nothing
                        Next
                    End If

                    LL = 235
                    For J = 0 To NumCC - 1
                        LL = 236
                        CC.Add(email.GetCC(J).ToString)
                        LL = 237
                        CcAddr.Add(email.GetCcAddr(J).ToString)
                        LL = 238
                        CcName.Add(email.GetCcName(J).ToString)
                        LL = 239
                        If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                            LL = 240
                            Recipients.Add(email.GetCcAddr(J).ToString)
                            LL = 241
                        End If
                        LL = 242
                    Next
                    LL = 243
                    For J = 0 To NumBcc - 1
                        LL = 244
                        Bcc.Add(email.GetBcc(J).ToString)
                        LL = 245
                        BccName.Add(email.GetBccName(J).ToString)
                        LL = 246
                        BccAddr.Add(email.GetBccAddr(J).ToString)
                        LL = 247
                        If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                            LL = 248
                            Recipients.Add(email.GetBccAddr(J).ToString)
                            LL = 249
                        End If
                        LL = 250
                    Next
                    LL = 251
                    For J = 0 To NumTo - 1
                        LL = 252
                        EmailTo.Add(email.GetTo(J).ToString)
                        LL = 253
                        EmailToAddr.Add(email.GetToAddr(J).ToString)
                        LL = 254
                        EmailToName.Add(email.GetToName(J).ToString)
                        LL = 255
                        If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                            LL = 256
                            Recipients.Add(email.GetToAddr(J).ToString)
                            LL = 257
                        End If
                        LL = 258
                    Next
                    LL = 259

                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 900.0: " + iMails.ToString)
                    LL = 266
                    Dim bFileSaved As Boolean = email.SaveEml(EmailFQN)
                    LL = 267

                    LL = 268
                    If bFileSaved Then
                        LL = 269
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("Notice 101a.1- ApplyEmailBundleV2: - Save Email: " + EmailFQN)
                    Else
                        LL = 270
                        LOG.WriteToArchiveLog("ERROR: 101a - ApplyEmailBundleV2: - Failed to save Email file: " + EmailFQN)
                        LL = 271
                    End If
                    LL = 281
                    If bEmlToMSG = True Then
                        LL = 282
                        EmailFQN = convertEmlToMsg(EmailFQN)
                        LL = 283
                        If EmailFQN.Trim.Length = 0 Then
                            LL = 284
                            LOG.WriteToArchiveLog("FATAL ERROR: ApplyEmailBundleV2 - failed to convert EML to MSG File.")
                            LL = 285
                            GoTo NextRec
                        End If
                        LL = 287
                    End If
                    LL = 289
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 900.1: " + iMails.ToString)
                    LL = 294
                    Dim AttachedFiles As New List(Of String)
                    LL = 295

                    getDirectoryFiles(AttachmentDir, AttachedFiles)

                    LL = 297
                    Dim DB_ID As String = "ECM.Library"
                    LL = 298
                    Dim Server_UserID_StoreID As String = CurrMailFolder
                    LL = 299
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 900.2: " + iMails.ToString)
                    LL = 303
                    Dim AttachmentsLoaded As Boolean = False
                    LL = 304
                    ArchiveExchangeEmails(UID, NewGuid,
                            EmailBody,
                            Subject,
                            CcAddr,
                            BccAddr,
                            EmailToAddr,
                            Recipients,
                            ServerName,
                            FromAddress,
                            FromName, CDate(ReceivedDate),
                            UserLoginID, Now, CDate(ReceivedDate),
                            DB_ID,
                            CurrMailFolder,
                            Server_UserID_StoreID,
                            retentionYears,
                            RetentionCode,
                            EmailSize,
                            AttachedFiles,
                            email.Uidl, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)

                    LL = 322

                    If NumAttachments > 0 Then
                        frmExchangeMonitor.lblMessageInfo.Visible = True
                        frmExchangeMonitor.lblMessageInfo.Text = "Processing " + NumAttachments.ToString + " attachments."
                        frmExchangeMonitor.lblMessageInfo.Refresh()
                        System.Windows.Forms.Application.DoEvents()
                        LL = 218
                        Dim dirPath As String = System.IO.Path.GetTempPath
                        dirPath = dirPath + "TempZip"
                        DBARCH.DeleteDirectory(dirPath)
                        DBARCH.CreateDir(dirPath)

                        '** Clean out the directory
                        deleteDirectoryFile(AttachmentDir)
                        email.SaveAllAttachments(AttachmentDir)
                        bLoadAttachments = True
                        LoadEmailAttachments(AttachmentDir, NewGuid)
                        LL = 223
                        frmExchangeMonitor.lblMessageInfo.Visible = False
                    End If

                    PurgeDirectory(AttachmentDir)

                    EmailsAdded += 1
                    LL = 323
                    frmExchangeMonitor.lblMsg.Text = "Emails Added: " + EmailsAdded.ToString
                    LL = 324
                    frmExchangeMonitor.lblMsg.Refresh()
                    LL = 325
                    System.Windows.Forms.Application.DoEvents()
                    LL = 329
                    If AttachmentsLoaded = True Then
                        LL = 330
                        Dim DoThis As Boolean = False
                        LL = 331
                        If DoThis Then
                            LL = 332
                            If AttachmentsLoaded = True Then
                                LL = 333
                                DBARCH.AppendOcrTextEmail(NewGuid)
                                LL = 334
                                AttachmentsLoaded = False
                                LL = 335
                            End If
                            LL = 336
                        End If
                        LL = 337
                    End If
                    LL = 338
                    'LOG.WriteToKeyLog(uidl, True)
                    DBARCH.AddExcgKey(uidl)
                    DBLocal.addExchange(uidl)
NextRec:
                    LL = 342
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundleV2 1000: " + iMails.ToString)
                    LL = 343

                    Dim tsTimeSpan As TimeSpan
                    LL = 345
                    Dim iNumberOfDays As Integer
                    LL = 346
                    Dim strMsgText As String = ""
                    LL = 347
                    'tsTimeSpan = Now.Subtract(CDate(ReceivedDate)
                    If email.LocalDate = Nothing Then
                        LL = 347.1
                        ReceivedDate = Now
                        LL = 347.2
                    ElseIf email.LocalDate.ToString.Length = 0 Then
                        LL = 347.3
                        ReceivedDate = Now
                        LL = 347.4
                    Else
                        LL = 347.5
                        ReceivedDate = email.LocalDate
                        LL = 347.6
                    End If
                    tsTimeSpan = Now.Subtract(ReceivedDate)    '** This represents the received date
                    LL = 348
                    iNumberOfDays = tsTimeSpan.Days
                    LL = 349

                    '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
NEXTBUNDLE:
                    LL = 376
                    If email IsNot Nothing Then
                        email.Dispose()
                    End If
                    ProcessedEmails = ProcessedEmails + 1

                    GC.Collect()
                    GC.WaitForPendingFinalizers()
                Next
ENDITALL:
                LL = 383
            Catch ex As System.Exception
                LOG.WriteToArchiveLog("ERROR 100 ApplyEmailBundleV2: LL = " + LL.ToString + ", EX: " + ex.Message)
                LOG.WriteToArchiveLog("FATAL ERROR: ApplyEmailBundleV2 - 10b: " + mailman.LastErrorText)
            Finally
                LOG.WriteToArchiveLog("NOTICE 500 ApplyEmailBundleV2: last line to execute LL = " + LL.ToString)
                LL = 385
                sa.Dispose()
                sa = Nothing
                'bundle.Dispose()
                If email IsNot Nothing Then
                    email.Dispose()
                End If
                GC.Collect()
                GC.WaitForPendingFinalizers()

            End Try

            frmExchangeMonitor.lblCnt.Text = "Emails Processed: "
            frmExchangeMonitor.lblCnt.Refresh()

            frmExchangeMonitor.lblMessageInfo.Text = ""
            frmExchangeMonitor.lblMsg.Text = ""
            frmExchangeMonitor.lblServer.Text = ""
            frmExchangeMonitor.Refresh()
            RC = True

            DBARCH.UpdateAttachmentCounts()
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 200 ApplyEmailBundleV2: LL = " + LL.ToString + ", EX: " + ex.Message)
            RC = False
        End Try

        mailman.Pop3EndSession()

        ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold)

        frmExchangeMonitor.lblCnt.Text = "Emails Processed: "
        frmExchangeMonitor.lblCnt.Refresh()
        Return RC

    End Function

    Sub deleteDirectoryFile(ByVal DirFQN As String)
        Dim FileName As String
        Try
            For Each FileName In System.IO.Directory.GetFiles(DirFQN)
                Try
                    System.IO.File.Delete(FileName)
                Catch ex As System.Exception
                    LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.")
                End Try
            Next FileName
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir '" + DirFQN + "'.")
        End Try
    End Sub

    Sub ArchiveEmbeddedEmailMessageV2(ByVal UID As String, ByVal EM As Chilkat.Email,
                                    ByVal LibraryName As String,
                                    ByVal EmailBoxName As String,
                                    ByVal RetentionCode As String,
                                    ByVal isPublic As Boolean,
                                    ByVal bEmlToMSG As Boolean,
                                    ByVal ServerName As String,
                                    ByVal ParentGuid As String,
                                    ByVal DaysToHold As Integer,
                                    ByVal EmailIdentifier As String,
                                    ByVal EntryID As String)

        Dim LL As Integer = 0

        Dim PauseThreadMS As Integer = 0
        Try
            PauseThreadMS = CInt(getUserParm("UserEmail_Pause"))
        Catch ex As System.Exception
            PauseThreadMS = 0
        End Try

        Try
            Dim TempDir As String = System.IO.Path.GetTempPath : LL = 1 : LL = 1
            Dim AttachmentDir As String = TempDir + "Email\Attachment" : LL = 2
            Dim EmailDir As String = TempDir + "Email" : LL = 3
            Dim AttachedFiles As New List(Of String) : LL = 4
            Dim Body As String = EM.Body : LL = 6
            Dim BounceAddress As String = EM.BounceAddress : LL = 7
            Dim Charset As String = EM.Charset : LL = 8
            Dim Decrypted As Boolean = EM.Decrypted : LL = 9
            Dim EmailDate As Date = EM.EmailDate : LL = 10
            Dim EncryptedBy As String = EM.EncryptedBy : LL = 11
            Dim FileDistList As String = EM.FileDistList : LL = 12
            Dim From As String = EM.From : LL = 13
            Dim FromAddress As String = EM.FromAddress : LL = 14
            Dim FromName As String = EM.FromName : LL = 15
            Dim Header As String = EM.Header : LL = 16
            Dim Language As String = EM.Language : LL = 17
            Dim LastErrorHtml As String = EM.LastErrorHtml : LL = 18
            Dim LastErrorText As String = EM.LastErrorText : LL = 19
            Dim LastErrorXml As String = EM.LastErrorXml : LL = 20
            Dim LocalDate As Date = EM.LocalDate : LL = 21
            Dim Mailer As String = EM.Mailer : LL = 22
            Dim NumAlternatives As Integer = EM.NumAlternatives : LL = 23
            Dim NumAttachedMessages As Integer = EM.NumAttachedMessages : LL = 24
            Dim NumAttachments As Integer = EM.NumAttachments : LL = 25
            Dim NumBcc As Integer = EM.NumBcc : LL = 26
            Dim NumCC As Integer = EM.NumCC : LL = 27
            Dim NumDaysOld As Integer = EM.NumDaysOld : LL = 28
            Dim NumHeaderFields As Integer = EM.NumHeaderFields : LL = 29
            Dim NumRelatedItems As Integer = EM.NumRelatedItems : LL = 30
            Dim NumReplacePatterns As Integer = EM.NumReplacePatterns : LL = 31
            Dim NumTo As Integer = EM.NumTo : LL = 32
            Dim OverwriteExisting As Boolean = EM.OverwriteExisting : LL = 33
            Dim PreferredCharset As String = EM.PreferredCharset : LL = 34
            Dim ReceivedEncrypted As Boolean = EM.ReceivedEncrypted : LL = 35
            Dim ReceivedSigned As Boolean = EM.ReceivedSigned : LL = 36
            Dim ReplyTo As String = EM.ReplyTo : LL = 37
            Dim ReturnReceipt As Boolean = EM.ReturnReceipt : LL = 38
            Dim SendEncrypted As Boolean = EM.SendEncrypted : LL = 39
            Dim SendSigned As Boolean = EM.SendSigned : LL = 40
            Dim SignaturesValid As Boolean = EM.SignaturesValid : LL = 41
            Dim SignedBy As String = EM.SignedBy : LL = 42
            Dim Size As Integer = EM.Size : LL = 43
            Dim Subject As String = EM.Subject : LL = 44
            Subject = LOG.PullOutSingleQuotes(Subject) : LL = 45
            Dim Uidl As String = EM.Uidl : LL = 46
            Dim VerboseLogging As Boolean = EM.VerboseLogging : LL = 47
            Dim tGMT As String = EmailDate.ToString : LL = 49
            FixDate(tGMT) : LL = 50
            Dim tSubject As String = Mid(Subject, 1, 100) : LL = 51
            RemoveBadChars(tSubject) : LL = 52
            LL = 53
            If NumAttachedMessages > 0 Then : LL = 54
                For II As Integer = 0 To NumAttachedMessages - 1 : LL = 55
                    ArchiveEmbeddedEmailMessage(UID, EM, LibraryName, EmailBoxName, RetentionCode, isPublic, bEmlToMSG, ServerName, ParentGuid, DaysToHold, EmailIdentifier, EntryID) : LL = 56
                Next : LL = 57
            End If : LL = 58
            LL = 59

            'Dim EmailIdentifier As String = LOG.genEmailIdentifier(Size.ToString, tGMT, FromAddress.Trim, Subject, gCurrUserGuidID)
            Dim ToAddr As String = ParentGuid
            'Dim EmailIdentifier as string = MailServerAddr  + "." + EmailSize.ToString + "~" + tEmailDate + "~" + FromAddress.Trim + "~" + tSubject  + gCurrUserGuidID :LL =  61
            RemoveBlanks(EmailIdentifier) : LL = 62
            LL = 63
            '** Not needed here - embedded email :LL =  64
            'Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier, EmailHashCode) :LL =  65
            'If bEmailExists Then :LL =  66
            '    GoTo SKIPTOHERE :LL =  67
            'End If :LL =  68
            LL = 69
            deleteDirectoryFile(AttachmentDir) : LL = 70
            If NumAttachments > 0 Then : LL = 71
                '** Clean out the directory :LL =  72
                EM.SaveAllAttachments(AttachmentDir) : LL = 73
                getDirectoryFiles(AttachmentDir, AttachedFiles) : LL = 74
                ' bLoadAttachments = True :LL = 75
            End If : LL = 76
            LL = 77
            Dim NewGuid As String = Guid.NewGuid.ToString : LL = 78
            Dim CcAddr As New ArrayList : LL = 79
            Dim BccAddr As New ArrayList : LL = 80
            Dim EmailToAddr As New ArrayList : LL = 81
            Dim Recipients As New ArrayList : LL = 82
            Dim ReceivedTime As Date = Now : LL = 83
            Dim UserLoginID As String = "ServiceManager" : LL = 84
            Dim DB_ID As String = "ECM.Library" : LL = 85
            Dim CurrMailFolder As String = EmailBoxName : LL = 86
            Dim Server_UserID_StoreID As String = EmailBoxName : LL = 87
            LL = 88
            Dim EmailFQN As String = EmailDir + "\Email.Embedded~" & NewGuid + "~.EML" : LL = 89
            LL = 90
            Dim EmailSize As Integer = Size : LL = 91
            LL = 92
            Dim retentionYears As Integer = DBARCH.getRetentionPeriod(RetentionCode) : LL = 93
            Dim BB As Boolean = EM.SaveEml(EmailFQN) : LL = 94
            If BB = False Then : LL = 95
                LOG.WriteToArchiveLog("ERROR: 001a ArchiveEmbeddedEmailMessage - failed to save EML File." + environment.NewLine + EmailFQN) : LL = 96
                Return : LL = 97
            End If : LL = 98
            If bEmlToMSG = True Then : LL = 99
                If bEmlToMSG = True Then : LL = 100
                    EmailFQN = convertEmlToMsg(EmailFQN) : LL = 101
                    If EmailFQN.Trim.Length = 0 Then : LL = 102
                        LOG.WriteToArchiveLog("FATAL ERROR: 100 ArchiveEmbeddedEmailMessage - failed to convert EML to MSG File.") : LL = 103
                        LOG.WriteToArchiveLog("NOTE:        100 ArchiveEmbeddedEmailMessage:  Most likely the Redemption DLL is not installed properly") : LL = 104
                        Return : LL = 105
                    End If : LL = 106
                    'log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'") :LL =  107
                End If
            End If

            Dim AttachmentsLoaded As Boolean = False

            LL = 110
            ArchiveExchangeEmails(UID, NewGuid,
                                               Body,
                                               Subject,
                                               CcAddr,
                                               BccAddr,
                                               EmailToAddr,
                                               Recipients,
                                               ServerName,
                                               FromAddress,
                                               FromName,
                                               ReceivedTime,
                                               UserLoginID,
                                               Now,
                                               ReceivedTime,
                                               DB_ID,
                                               CurrMailFolder,
                                               Server_UserID_StoreID,
                                               retentionYears,
                                               RetentionCode,
                                               EmailSize,
                                               AttachedFiles,
                                               EntryID,
                                               EmailIdentifier,
                                               EmailFQN,
                                               LibraryName,
                                               isPublic,
                                               bEmlToMSG, AttachmentsLoaded, DaysToHold)
            LL = 138
            If PauseThreadMS > 0 Then
                System.Threading.Thread.Sleep(PauseThreadMS)
            End If
            LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#4")
            If AttachmentsLoaded = True Then
                Dim DoThis As Boolean = False
                If DoThis Then
                    If AttachmentsLoaded = True Then
                        DBARCH.AppendOcrTextEmail(NewGuid)
                        AttachmentsLoaded = False
                    End If
                End If
            End If

            If ParentGuid.Trim.Length > 0 Then : LL = 139
                Body = LOG.PullOutSingleQuotes(Body) : LL = 140
                Subject = LOG.PullOutSingleQuotes(Subject) : LL = 141
                FromName = LOG.PullOutSingleQuotes(FromName) : LL = 142
                FromAddress = LOG.PullOutSingleQuotes(FromAddress) : LL = 143
                Dim tMsg As String = " " + Chr(254) + Body + Chr(254) + Subject + Chr(254) + FromName + Chr(254) + FromAddress : LL = 144
                DBARCH.concatEmailBody(tMsg, ParentGuid) : LL = 145
            End If : LL = 146
            LL = 147
            ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold) : LL = 148
            Dim ConversionDir As String = LOG.getEnvVarSpecialFolderLocalApplicationData + "\WMCONVERT" : LL = 149

            ApplyPendingEmail(ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold)

            LL = 150
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: ArchiveEmbeddedEmailMessage 100 - LL = " + LL.ToString + " : " + ex.Message)
        End Try

        LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#5")

SKIPTOHERE:

    End Sub

    Sub RemoveBlanks(ByRef tStr As String)
        Dim S As String = tStr
        Dim NewStr As String = ""
        Dim BlankCnt As Integer = 0
        Dim CH As String = ""
        For i As Integer = 1 To S.Length
            CH = Mid(S, i, 1)
            If CH.Equals(" ") Then
                BlankCnt += 1
            ElseIf CH.Equals(Chr(9)) Then
                BlankCnt += 1
            ElseIf CH.Equals(Chr(34)) Then
                BlankCnt += 1
            ElseIf CH.Equals(environment.NewLine) Then
                BlankCnt += 1
            ElseIf CH.Equals(vbCr) Then
                BlankCnt += 1
            ElseIf CH.Equals(vbLf) Then
                BlankCnt += 1
            Else
                NewStr = NewStr + CH
            End If
        Next
        tStr = NewStr
    End Sub

    Function getIMapEmailV2(ByVal UID As String, ByVal MailServerAddr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer,
                            ByVal LibraryName As String,
                            ByVal isPublic As Boolean,
                            ByVal DaysToHold As Integer,
                            ByVal strReject As String,
                            ByVal bEmlToMSG As Boolean) As Boolean

        Dim RC As Boolean = True
        Dim LL As Integer = 0
        Dim imap As New Chilkat.Imap()
        Dim RecjectCount As Integer = 1
        Dim EmailsProcessedThisRun As Integer = 0
        LL = 1
        Dim DownLoadSize As Integer = 0
        Dim sDownLoadSize As String = ""
        Dim Increment As Integer = 0
        Dim I As Long = 0
        imap.ReadTimeout = 360

        LL = 2
        Try
            LL = 3
            Dim ServerName As String = MailServerAddr + ":" + UserLoginID
            LL = 4

            LL = 5
            Dim TempDir As String = System.IO.Path.GetTempPath
            LL = 6
            Dim AttachmentDir As String = TempDir + "Email\Attachment"
            LL = 7
            Dim EmailDir As String = TempDir + "Email"
            LL = 8
            Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID
            LL = 9

            LL = 10
            Dim Success As Boolean = False
            LL = 11

            imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
            LL = 16
            Success = imap.Connect(MailServerAddr)
            If Not Success Then
                Return False
                MessageBox.Show(imap.LastErrorText)
            End If
            LL = 17
            Success = imap.Login(UserLoginID, LoginPassWord)
            If Not Success Then
                MessageBox.Show(imap.LastErrorText)
                Return False
            End If
            LL = 18
            If Not Success Then
                LL = 19
                frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
                LOG.WriteToArchiveLog("FATAL ERROR: IMAP 300.1 Failed to log on to " + MailServerAddr + ", aborting.")
                LL = 20
                Return False
            Else
                frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
                LL = 21
            End If
            LL = 22

            ' Get the names of all the mailboxes.
            Dim mboxes As Chilkat.Mailboxes
            mboxes = imap.ListMailboxes("", "*")

            For iii As Integer = 0 To mboxes.Count - 1
                Console.WriteLine(mboxes.GetName(iii))
                Dim mName As String = mboxes.GetName(iii)
                frmExchangeMonitor.lblMsg.Text = "Mailbox: " + mboxes.GetName(iii)
                frmExchangeMonitor.lblMsg.Refresh()
            Next

            Dim BB As Boolean = imap.SelectMailbox("Inbox")
            If Not BB Then
                Return False
            End If

            LL = 23

            Dim J As Integer = 0
            Dim msgSet As Chilkat.MessageSet
            LL = 30
            msgSet = imap.Search("ALL", 1)
            LL = 76

            LL = 81
            ' Loop over the bundle and display the From and Subject.
            LL = 82
            Try
                LL = 85
                sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings("EmailDownLoadSize")
                LL = 86
                DownLoadSize = Val(sDownLoadSize)
                LL = 87
            Catch ex As System.Exception
                DownLoadSize = 100

            End Try
            LL = 90

            LL = 91
            If DownLoadSize = 0 Then
                LL = 92
                DownLoadSize = 5000
                LL = 93
            End If
            LL = 94
            Increment = DownLoadSize
            LL = 95

            LL = 96
            frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr
            LL = 97
            frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
            LL = 98
            frmExchangeMonitor.lblServer.Refresh()
            LL = 99
            frmExchangeMonitor.lblServer.Refresh()
            LL = 100
            System.Windows.Forms.Application.DoEvents()
            LL = 101

            LL = 102

            LL = 103
            Dim bundle As Chilkat.EmailBundle
            LL = 104
            Dim startSeqNum As Long
            LL = 105
            startSeqNum = 1
            LL = 106
            Dim numToFetch As Long
            LL = 107
            numToFetch = DownLoadSize
            LL = 108

            LL = 109
            Dim ExitUponCompletion As Boolean = False
            LL = 110
            Dim fetchUids As Boolean = True
            LL = 111
            'Dim messageSet As Chilkat.MessageSet
            LL = 112
            Dim NbrOfTries As Integer = 1
            LL = 113
REDO:
            LL = 114

            If NbrOfTries >= 3 Then
                LL = 115
                RC = False
                GoTo ENDIT
                LL = 116
            End If

            LL = 118
            bundle = imap.FetchSequence(startSeqNum, numToFetch)
            LL = 122
            Dim NumberOfMessagesInBox As Integer = bundle.MessageCount
            Do While NumberOfMessagesInBox > 0
                NumberOfMessagesInBox = imap.NumMessages
                LL = 127

                LL = 128
                If (bundle Is Nothing) Then
                    LL = 129
                    LOG.WriteToArchiveLog("NOTICE: getImapEmail 401a: " + imap.LastErrorText)
                    LL = 130
                    LOG.WriteToArchiveLog("        getImapEmail 401b: startSeqNum - " + startSeqNum.ToString)
                    LL = 131
                    LOG.WriteToArchiveLog("        getImapEmail 401c: numToFetch - " + numToFetch.ToString)
                    LL = 132
                    LOG.WriteToArchiveLog("NOTICE: getImapEmail 401d: messages in mailbox: " + NumberOfMessagesInBox.ToString)
                    LL = 133
                    NbrOfTries = NbrOfTries + 1
                    LL = 134
                    GoTo REDO
                    LL = 135
                End If
                LL = 136

                LL = 137
                If NumberOfMessagesInBox > 0 Then
                    LL = 138
                    LOG.WriteToArchiveLog("NOTICE: getImapEmail 401.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                    LL = 139
                Else
                    LL = 140
                    LOG.WriteToArchiveLog("NOTICE: No messages getImapEmail 401.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                    LL = 141
                    GoTo ENDIT
                    LL = 142
                End If
                LL = 143

                LL = 144
                If numToFetch > NumberOfMessagesInBox Then
                    LL = 145
                    numToFetch = NumberOfMessagesInBox
                    LL = 146
                End If

                LL = 167
                LOG.WriteToArchiveLog("Processing Exchange IMAP no SSL #emails = " + NumberOfMessagesInBox.ToString)
                LL = 168
                Dim RejectedCount As Integer = 0
                LL = 169
                ' Loop over the bundle and display the FROM and SUBJECT of each.
                LL = 170

                LL = 171
                frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr
                LL = 172
                frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
                LL = 173
                frmExchangeMonitor.lblServer.Refresh()
                LL = 174
                System.Windows.Forms.Application.DoEvents()
                LL = 176

                LL = 177
                Dim MessagesProcessed As Integer = 0
                LL = 178
                Dim MessagesRemainingToProcess As Integer = NumberOfMessagesInBox
                LL = 179
                Dim LoopCnt As Integer = 1
                LL = 180
                TotalEmailsInArchive = 0
                LL = 181

                LL = 182
                LOG.WriteToArchiveLog("INFO - messages to process #" + NumberOfMessagesInBox.ToString + " in " + MailServerAddr)
                LL = 185
                '*******************************************************************************
                Dim ExitNow As Boolean = False
                Do While MessagesRemainingToProcess > 0
                    LL = 188
                    If numToFetch > NumberOfMessagesInBox Then
                        ExitNow = True
                    End If
                    For I = 0 To bundle.MessageCount - 1

                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("INFO: bundle #" + LoopCnt.ToString + ", Email#" + I.ToString)
                        LL = 190
                        TotalEmailsInArchive += 1
                        LL = 191
                        EmailsProcessedThisRun += 1
                        LL = 192
                        MessagesRemainingToProcess = MessagesRemainingToProcess - 1
                        LL = 193
                        frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString + " of " + NumberOfMessagesInBox.ToString
                        LL = 194
                        frmExchangeMonitor.lblCnt.Refresh()
                        LL = 196
                        System.Windows.Forms.Application.DoEvents()
                        LL = 198
                        Dim NewGuid As String = System.Guid.NewGuid.ToString()
                        LL = 199

                        LL = 200
                        Dim email As Chilkat.Email
                        LL = 201
                        email = bundle.GetEmail(I)
                        LL = 202
                        Dim EntryID As String = email.Uidl
                        LL = 203
                        Dim Subject As String = email.Subject
                        Subject = LOG.PullOutSingleQuotes(Subject)
                        LL = 204
                        Dim EmailFrom As String = email.From
                        LL = 205
                        Dim FromAddress As String = email.FromAddress
                        LL = 206
                        Dim FromName As String = email.FromName
                        LL = 207
                        Dim From As String = email.From
                        LL = 208

                        LL = 209
                        If strReject.Trim.Length > 0 Then
                            LL = 210
                            Dim A As String() = strReject.Split(",")
                            LL = 211
                            For II As Integer = 0 To UBound(A)
                                LL = 212
                                Dim S1 As String = A(II).Trim
                                LL = 213
                                If S1.Trim.Length > 0 Then
                                    LL = 214
                                    If InStr(Subject, S1, CompareMethod.Text) Then
                                        LL = 215
                                        'LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                        LL = 216
                                        RejectedCount += 1
                                        LL = 217
                                        GoTo NextRec
                                        LL = 218
                                    End If
                                    LL = 219
                                End If
                                LL = 220
                            Next
                            LL = 221
                        End If
                        LL = 222

                        LL = 223
                        Dim NbrDaysOld As Integer = email.NumDaysOld
                        LL = 224
                        If NbrDaysOld >= DaysToHold Then
                            LL = 225
                            Success = imap.SetMailFlag(email, "Deleted", 1)
                            LL = 226
                            If (Success <> True) Then
                                LL = 227
                                Dim Msg As String = "Subject: " + Subject + environment.NewLine
                                LL = 228
                                Msg += "FromName: " + FromName + environment.NewLine
                                LL = 229
                                Msg += "FromAddress: " + FromAddress + environment.NewLine
                                LL = 230
                                LOG.WriteToArchiveLog("ERROR: getIMapEmail: Failed to delete email from server:" + environment.NewLine + Msg)
                                LL = 231
                            End If
                            LL = 232
                        End If
                        LL = 233

                        LL = 234
                        Dim NumAlternatives As Integer = email.NumAlternatives
                        LL = 235
                        Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                        LL = 236
                        Dim NumAttachments As Integer = email.NumAttachments
                        LL = 237
                        Dim NumBcc As Integer = email.NumBcc
                        LL = 238
                        Dim NumCC As Integer = email.NumCC
                        LL = 239
                        Dim NumTo As Integer = email.NumTo
                        LL = 240
                        Dim ReplyTo As String = email.ReplyTo
                        LL = 241
                        Dim SignedBy As String = email.SignedBy
                        LL = 242
                        Dim EmailSize As Integer = email.Size
                        LL = 243
                        Dim LocalDate As String = email.LocalDate.ToString
                        LL = 244
                        Dim EmailDate As String = email.EmailDate.ToString
                        LL = 245
                        Dim Header As String = email.Header
                        LL = 246
                        Dim EmailBody As String = email.Body
                        LL = 247
                        EmailBody = LOG.PullOutSingleQuotes(EmailBody)
                        LL = 248

                        LL = 249
                        Dim Recipients As New ArrayList
                        LL = 250
                        Dim EmailTo As New ArrayList
                        LL = 251
                        Dim EmailToAddr As New ArrayList
                        LL = 252
                        Dim EmailToName As New ArrayList
                        LL = 253
                        Dim Bcc As New ArrayList
                        LL = 254
                        Dim BccAddr As New ArrayList
                        LL = 255
                        Dim BccName As New ArrayList
                        LL = 256
                        Dim CC As New ArrayList
                        LL = 257
                        Dim CcAddr As New ArrayList
                        LL = 258
                        Dim CcName As New ArrayList
                        LL = 259
                        Dim bLoadAttachments As Boolean = False
                        LL = 260

                        LL = 261
                        J = 0
                        LL = 262

                        LL = 263
                        Dim tEmailDate As String = EmailDate.ToString
                        LL = 264
                        FixDate(tEmailDate)
                        LL = 265
                        Dim tSubject As String = Mid(Subject, 1, 100)
                        LL = 266
                        RemoveBadChars(tSubject)
                        LL = 267

                        'Dim EmailIdentifier As String = EmailSize.ToString + "~" + tEmailDate.ToString + "~" + FromAddress.Trim + "~" + tSubject  + "~" + EmailToAddr.ToString + "~" + UID
                        Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject)
                        Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                        Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                        LL = 272
                        If bEmailExists Then
                            LL = 276
                            System.Windows.Forms.Application.DoEvents()
                            LL = 277
                            Dim DaysOld As Integer = email.NumDaysOld
                            LL = 278
                            If DaysOld < 0 Then
                                DaysOld = 1
                            End If
                            If DaysOld > DaysToHold Then
                                LL = 279
                                Success = imap.SetMailFlag(email, "Deleted", 1)
                                LL = 280
                                If (Success <> True) Then
                                    LL = 281
                                    Dim Msg As String = "Subject: " + Subject + environment.NewLine
                                    LL = 282
                                    Msg += "FromName: " + FromName + environment.NewLine
                                    LL = 283
                                    Msg += "FromAddress: " + FromAddress + environment.NewLine
                                    LL = 284
                                    LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                                    LL = 285
                                End If
                                LL = 286
                            End If
                            LL = 287
                            GoTo NextRec
                            LL = 288
                        End If
                        LL = 289

                        LL = 290
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + I.ToString)
                        LL = 291
                        Dim B As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                        LL = 292
                        If B Then
                            LL = 293
                            If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + I.ToString)
                            LL = 294
                            GoTo NextRec
                            LL = 295
                        End If
                        LL = 296

                        LL = 297
                        Dim EmailFQN As String = EmailDir + "\Email~" & NewGuid + "~.EML"
                        LL = 298

                        LL = 299
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundle 800.4a: " + I.ToString)
                        LL = 300
                        If NumAttachments > 0 Then
                            LL = 301
                            '** Clean out the directory
                            LL = 302
                            deleteDirectoryFile(AttachmentDir)
                            LL = 303
                            ' Save attachments to the "attachments" directory.
                            LL = 304
                            email.SaveAllAttachments(AttachmentDir)
                            LL = 305
                            bLoadAttachments = True
                            LL = 306
                        End If
                        LL = 307

                        LL = 308
                        If NumAttachedMessages > 0 Then
                            LL = 309
                            'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                            LL = 310
                            For II As Integer = 0 To NumAttachedMessages - 1
                                LL = 311
                                'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                                LL = 312
                                Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                                LL = 313
                                ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                                LL = 314
                                objEmail = Nothing
                                LL = 315
                            Next
                            LL = 316
                        End If
                        LL = 317

                        LL = 318
                        For J = 0 To NumCC - 1
                            LL = 319
                            CC.Add(email.GetCC(J).ToString)
                            LL = 320
                            CcAddr.Add(email.GetCcAddr(J).ToString)
                            LL = 321
                            CcName.Add(email.GetCcName(J).ToString)
                            LL = 322
                            If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                                LL = 323
                                Recipients.Add(email.GetCcAddr(J).ToString)
                                LL = 324
                            End If
                            LL = 325
                        Next
                        LL = 326
                        For J = 0 To NumBcc - 1
                            LL = 327
                            Bcc.Add(email.GetBcc(J).ToString)
                            LL = 328
                            BccName.Add(email.GetBccName(J).ToString)
                            LL = 329
                            BccAddr.Add(email.GetBccAddr(J).ToString)
                            LL = 330
                            If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                                LL = 331
                                Recipients.Add(email.GetBccAddr(J).ToString)
                                LL = 332
                            End If
                            LL = 333
                        Next
                        LL = 334
                        For J = 0 To NumTo - 1
                            LL = 335
                            EmailTo.Add(email.GetTo(J).ToString)
                            LL = 336
                            EmailToAddr.Add(email.GetToAddr(J).ToString)
                            LL = 337
                            EmailToName.Add(email.GetToName(J).ToString)
                            LL = 338
                            If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                                LL = 339
                                Recipients.Add(email.GetToAddr(J).ToString)
                                LL = 340
                            End If
                            LL = 341
                        Next
                        LL = 342

                        email.SaveEml(EmailFQN)
                        LL = 358
                        If bEmlToMSG = True Then
                            LL = 359
                            LOG.WriteToArchiveLog("Notice from getImapEmail 300 : FQN '" + EmailFQN + "'")
                            LL = 360
                            EmailFQN = convertEmlToMsg(EmailFQN)
                            LL = 361
                        End If
                        LL = 362
                        Dim AttachedFiles As New List(Of String)
                        LL = 367
                        getDirectoryFiles(AttachmentDir, AttachedFiles)
                        LL = 369
                        Dim DB_ID As String = "ECM.Library"
                        LL = 370
                        Dim Server_UserID_StoreID As String = CurrMailFolder
                        LL = 371

                        LL = 372
                        '** Now, Load the EMAIL and its metadata into the repository
                        LL = 373
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + I.ToString)
                        LL = 374

                        LL = 375
                        Dim AttachmentsLoaded As Boolean = False
                        LL = 376

                        LL = 377
                        ArchiveExchangeEmails(UID, NewGuid,
                                EmailBody,
                                Subject,
                                CcAddr,
                                BccAddr,
                                EmailToAddr,
                                Recipients,
                                MailServerAddr,
                                FromAddress,
                                FromName,
                                CDate(EmailDate),
                                UserLoginID,
                                CDate(LocalDate),
                                CDate(EmailDate),
                                DB_ID,
                                CurrMailFolder,
                                Server_UserID_StoreID,
                                retentionYears,
                                RetentionCode,
                                EmailSize,
                                AttachedFiles,
                                EntryID,
                                EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)

                        LL = 400
                        If AttachmentsLoaded = True Then
                            LL = 401
                            Dim DoThis As Boolean = False
                            LL = 402
                            If DoThis Then
                                LL = 403
                                If AttachmentsLoaded = True Then
                                    LL = 404
                                    DBARCH.AppendOcrTextEmail(NewGuid)
                                    LL = 405
                                    AttachmentsLoaded = False
                                    LL = 406
                                End If
                                LL = 407
                            End If
                            LL = 408
                        End If
                        LL = 409
NextRec:
                        LL = 410
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 1000: " + I.ToString)
                        LL = 411

                        LL = 412
                    Next
                    LL = 413

                    LL = 414
                    '*****************************************************************************
                    LL = 415
                    If ExitUponCompletion = True Then
                        LL = 416
                        Exit Do
                        LL = 417
                    End If
                    LL = 418

                    LL = 419
                    LOG.WriteToArchiveLog("INFO - getIMapEmail getting next + " + DownLoadSize.ToString + " messages.")
                    LL = 420

                    LL = 421
                    If DownLoadSize > MessagesRemainingToProcess Then
                        LL = 422
                        DownLoadSize = MessagesRemainingToProcess
                        LL = 423
                        'Increment = MessagesRemainingToProcess
                        LL = 424
                        numToFetch = MessagesRemainingToProcess
                        LL = 425
                    Else
                        LL = 426
                        numToFetch = DownLoadSize
                        LL = 427
                    End If
                    LL = 428

                    LL = 429

                    LL = 430

                    LL = 431
                    startSeqNum = startSeqNum + Increment
                    LL = 432
                    LoopCnt = LoopCnt + 1
                    LL = 433
                    If numToFetch > 0 Then
                        LL = 434
                        LOG.WriteToArchiveLog("INFO - downloading bundle #" + LoopCnt.ToString + " from " + MailServerAddr)
                        LL = 435
                        Try
                            LL = 436
                            bundle = imap.FetchSequence(startSeqNum, numToFetch)
                            LL = 443
                            LOG.WriteToArchiveLog("INFO - getIMapEmail successfully getched + " + numToFetch.ToString + " messages.")
                            LL = 445
                        Catch ex As System.Exception
                            LOG.WriteToArchiveLog("ERROR: imap.FetchSequence - " + ex.Message)
                            LL = 447
                        End Try
                        LL = 448
                        Windows.Forms.Application.DoEvents()
                        LL = 455
                        If (bundle Is Nothing) Then
                            LL = 456
                            LOG.WriteToArchiveLog("Warning - termination - getImapEmail 401.5: End of process.")
                            LL = 457
                            Exit Do
                            LL = 458
                        End If
                        LL = 459
                    End If
                    LL = 460

                    LL = 461
                Loop
                LL = 462

                If ExitNow = True Then
                    Exit Do
                End If

                startSeqNum = startSeqNum + numToFetch + 1
                bundle = imap.FetchSequence(startSeqNum, numToFetch)
                LL = 122
                NumberOfMessagesInBox = bundle.MessageCount

            Loop
            '***************************************************************
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: 2699 getIMapEmail - LL = " + LL.ToString + " : " + ex.Message)
            RC = False
        Finally
            ' Disconnect from the IMAP server. This example removes the deleted email on the IMAP server.
            LL = 465
            imap.Expunge()
            LL = 466
            imap.Disconnect()
            LL = 467
        End Try
        LL = 468

ENDIT:
        ' Save the email to an XML file
        'bundle.SaveXml("bundle.xml")

        LOG.WriteToArchiveLog("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString)
        LOG.WriteToArchiveLog("Applying IMAP Bundle PROCESSED Message Count = " + TotalEmailsInArchive.ToString)
        LOG.WriteToArchiveLog("INFO: Emails processed this run  = " + EmailsProcessedThisRun.ToString + " from " + MailServerAddr)

        frmExchangeMonitor.lblMessageInfo.Text = "Emails Processed: "
        frmExchangeMonitor.lblMessageInfo.Refresh()
        Windows.Forms.Application.DoEvents()
        Return RC
    End Function

    Function getImapEmailSSLV2(ByVal UID As String, ByVal MailServerAddr As String, ByVal PortNbr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer,
                            ByVal LibraryName As String,
                            ByVal isPublic As Boolean,
                            ByVal DaysToHold As Integer,
                            ByVal strReject As String,
                            ByVal bEmlToMSG As Boolean,
                            ByVal UseSSL As Boolean) As Boolean

        Dim RC As Boolean = False
        Dim LL As Integer = 1
        Dim imap As New Chilkat.Imap()
        Dim RejectedCount As Integer = 0
        Dim messageSet As Chilkat.MessageSet
        Dim bundle As Chilkat.EmailBundle

        Try
            LL = 2
            Dim ServerName As String = MailServerAddr + ":" + UserLoginID
            LL = 3

            LL = 4

            LL = 5
            Dim success As Boolean = False
            LL = 6
            Dim TempDir As String = System.IO.Path.GetTempPath
            LL = 7
            Dim AttachmentDir As String = TempDir + "Email\Attachment"
            LL = 8
            Dim EmailDir As String = TempDir + "Email"
            LL = 9
            Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID
            LL = 10

            LL = 11
            Dim DownLoadSize As Integer = 0
            LL = 12
            Dim sDownLoadSize As String = ""
            LL = 13
            Dim Increment As Integer = 0
            LL = 14
            Dim NbrDaysOld As Integer = 0
            LL = 15

            LL = 16
            Try
                LL = 17
                sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings("EmailDownLoadSize")
                LL = 18
                DownLoadSize = Val(sDownLoadSize)
                LL = 19
            Catch ex As System.Exception
                DownLoadSize = 100

            End Try
            LL = 22

            LL = 23
            If DownLoadSize = 0 Then
                LL = 24
                DownLoadSize = 5000
                LL = 25
            End If
            LL = 26
            Increment = DownLoadSize
            LL = 27

            LL = 28
            ' Anything unlocks the component and begins a fully-functional 30-day trial.
            LL = 29
            success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
            LL = 30
            If (success <> True) Then
                LL = 31
                MessageBox.Show(imap.LastErrorText)
                LL = 32
                Return False
                LL = 33
            End If
            LL = 34

            LL = 35
            ' To use a secure SSL connection, set SSL and the port:
            LL = 36
            imap.Ssl = UseSSL
            LL = 37
            ' The typical port for IMAP SSL is 993
            LL = 38
            If PortNbr.Length = 0 Then
                LL = 39
                imap.Port = 993
                LL = 40
            Else
                LL = 41
                imap.Port = Val(PortNbr)
                LL = 42
            End If
            LL = 43

            LL = 44
            ' Connect to an IMAP server.
            LL = 45
            success = imap.Connect(MailServerAddr)
            LL = 46
            If (success <> True) Then
                LL = 47
                LOG.WriteToArchiveLog("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText)
                LL = 48
                Return False
            Else
                LL = 49
                frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            LL = 50

            success = imap.Login(UserLoginID, LoginPassWord)
            If (success <> True) Then
                MessageBox.Show(imap.LastErrorText)
                LOG.WriteToArchiveLog("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText)
                frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
                Return False
            Else
                LL = 57
                frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            LL = 58

            ' Get the names of all the mailboxes.
            Dim mboxes As Chilkat.Mailboxes
            mboxes = imap.ListMailboxes("", "*")

            Dim ii As Long
            For ii = 0 To mboxes.Count - 1
                Console.WriteLine(mboxes.GetName(ii))
            Next

            success = imap.SelectMailbox("Inbox")
            LL = 62
            If (success <> True) Then
                LL = 63
                MessageBox.Show(imap.LastErrorText)
                LOG.WriteToArchiveLog("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText)
                LL = 64
                Return False
                LL = 65
            End If
            LL = 66

            LL = 67
            ' After selecting a mailbox, the NumMessages property will
            LL = 68
            ' be updated to reflect the total number of emails in the mailbox:
            LL = 69
            frmExchangeMonitor.lblMsg.Text = "Download: " + imap.NumMessages.ToString + " messages."
            LL = 70
            frmExchangeMonitor.lblMsg.Refresh()
            LL = 71
            System.Windows.Forms.Application.DoEvents()
            LL = 72

            LL = 73
            Dim NumberOfMessagesInBox As Integer = imap.NumMessages
            NumberOfMessagesInBox = bundle.MessageCount
            LL = 74

            LL = 75
            If NumberOfMessagesInBox > 0 Then
                LL = 76
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                LL = 77
            Else
                LL = 78
                LOG.WriteToArchiveLog("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                LL = 79
                GoTo ENDIT
                LL = 80
            End If
            LL = 81

            Dim startSeqNum As Long
            LL = 93
            startSeqNum = 1
            LL = 94
            Dim numToFetch As Long
            LL = 95
            numToFetch = DownLoadSize
            LL = 96

            LL = 97
            Dim ExitUponCompletion As Boolean = False
            LL = 98
            Dim fetchUids As Boolean = True
            LL = 99

            LL = 100
            Dim NbrOfTries As Integer = 1
            LL = 101
REDO:
            LL = 102
            If NbrOfTries >= 3 Then
                LL = 103
                GoTo ENDIT
                LL = 104
            End If

            LL = 124
            If numToFetch > NumberOfMessagesInBox Then
                LL = 125
                numToFetch = NumberOfMessagesInBox
                LL = 126
            End If
            LL = 127
            bundle = imap.FetchSequence(startSeqNum, numToFetch)
            LL = 128
            'End If
            LL = 129

            LL = 130

            LL = 131
            If (bundle Is Nothing) Then
                LL = 132
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400a: " + imap.LastErrorText)
                LL = 133
                LOG.WriteToArchiveLog("        getImapEmailSSL 400b: startSeqNum - " + startSeqNum.ToString)
                LL = 134
                LOG.WriteToArchiveLog("        getImapEmailSSL 400c: numToFetch - " + numToFetch.ToString)
                LL = 135
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400d: messages in mailbox: " + NumberOfMessagesInBox.ToString)
                LL = 136
                NbrOfTries = NbrOfTries + 1
                LL = 137
                GoTo REDO
                LL = 138
            End If
            LL = 139

            LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL #emails = " + NumberOfMessagesInBox.ToString)
            LL = 164
            frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr
            LL = 165
            frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
            LL = 166
            frmExchangeMonitor.lblServer.Refresh()
            LL = 167
            frmExchangeMonitor.lblServer.Refresh()
            LL = 168
            System.Windows.Forms.Application.DoEvents()
            LL = 169

            LL = 170
            Dim MessagesProcessed As Integer = 0
            LL = 171
            Dim MessagesRemainingToProcess As Integer = NumberOfMessagesInBox
            LL = 172
            TotalEmailsInArchive = 0
            LL = 175
            Do While MessagesRemainingToProcess > 0
                LL = 178
                For i = 0 To bundle.MessageCount - 1
                    LL = 179
                    TotalEmailsInArchive += 1
                    LL = 180
                    MessagesRemainingToProcess = MessagesRemainingToProcess - 1
                    LL = 181
                    frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString + " of " + imap.NumMessages.ToString
                    LL = 182
                    frmExchangeMonitor.lblCnt.Refresh()
                    LL = 183
                    System.Windows.Forms.Application.DoEvents()
                    LL = 186
                    Dim NewGuid As String = System.Guid.NewGuid.ToString()
                    LL = 188
                    Dim email As Chilkat.Email
                    LL = 189
                    email = bundle.GetEmail(i)
                    LL = 191
                    Dim Subject As String = email.Subject
                    Subject = LOG.PullOutSingleQuotes(Subject)
                    LL = 192
                    Dim EmailFrom As String = email.From
                    LL = 193
                    Dim FromAddress As String = email.FromAddress
                    LL = 194
                    Dim FromName As String = email.FromName
                    LL = 195
                    Dim From As String = email.From
                    LL = 196
                    Dim EntryID As String = email.Uidl
                    LL = 197
                    If strReject.Trim.Length > 0 Then
                        LL = 198
                        Dim A As String() = strReject.Split(",")
                        LL = 199
                        For ii = 0 To UBound(A)
                            LL = 200
                            Dim S1 As String = A(ii).Trim
                            LL = 201
                            If S1.Trim.Length > 0 Then
                                LL = 202
                                If InStr(Subject, S1, CompareMethod.Text) Then
                                    LL = 203
                                    'LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                    LL = 204
                                    RejectedCount += 1
                                    LL = 205
                                    GoTo NextRec
                                    LL = 206
                                End If
                                LL = 207
                            End If
                            LL = 208
                        Next
                        LL = 209
                    End If
                    LL = 210

                    LL = 211
                    NbrDaysOld = email.NumDaysOld
                    LL = 212
                    If NbrDaysOld >= DaysToHold Then
                        LL = 213
                        success = imap.SetMailFlag(email, "Deleted", 1)
                        LL = 214
                        If (success <> True) Then
                            LL = 215
                            Dim Msg As String = "Subject: " + Subject + environment.NewLine
                            LL = 216
                            Msg += "FromName: " + FromName + environment.NewLine
                            LL = 217
                            Msg += "FromAddress: " + FromAddress + environment.NewLine
                            LL = 218
                            LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                            LL = 219
                        End If
                        LL = 220
                    End If
                    LL = 221

                    LL = 222
                    Dim NumAlternatives As Integer = email.NumAlternatives
                    LL = 223
                    Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                    LL = 224
                    Dim NumAttachments As Integer = email.NumAttachments
                    LL = 225
                    Dim NumBcc As Integer = email.NumBcc
                    LL = 226
                    Dim NumCC As Integer = email.NumCC
                    LL = 227
                    Dim NumTo As Integer = email.NumTo
                    LL = 228
                    Dim ReplyTo As String = email.ReplyTo
                    LL = 229
                    Dim SignedBy As String = email.SignedBy
                    LL = 230
                    Dim EmailSize As Integer = email.Size
                    LL = 231
                    Dim LocalDate As String = email.LocalDate.ToString
                    LL = 232
                    Dim EmailDate As String = email.EmailDate.ToString
                    LL = 233
                    Dim Header As String = email.Header
                    LL = 234
                    Dim EmailBody As String = email.Body
                    LL = 235
                    EmailBody = LOG.PullOutSingleQuotes(EmailBody)
                    LL = 236

                    LL = 237
                    Dim Recipients As New ArrayList
                    LL = 238
                    Dim EmailTo As New ArrayList
                    LL = 239
                    Dim EmailToAddr As New ArrayList
                    LL = 240
                    Dim EmailToName As New ArrayList
                    LL = 241
                    Dim Bcc As New ArrayList
                    LL = 242
                    Dim BccAddr As New ArrayList
                    LL = 243
                    Dim BccName As New ArrayList
                    LL = 244
                    Dim CC As New ArrayList
                    LL = 245
                    Dim CcAddr As New ArrayList
                    LL = 246
                    Dim CcName As New ArrayList
                    LL = 247
                    Dim bLoadAttachments As Boolean = False
                    LL = 248

                    LL = 249
                    Dim J As Integer = 0
                    LL = 250

                    LL = 251
                    Dim tEmailDate As String = EmailDate.ToString
                    LL = 252
                    FixDate(tEmailDate)
                    LL = 253
                    Dim tSubject As String = Mid(Subject, 1, 100)
                    LL = 254
                    RemoveBadChars(tSubject)
                    LL = 255

                    LL = 256
                    Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject)
                    Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                    Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                    LL = 260
                    If bEmailExists Then
                        LL = 261

                        LL = 262
                        'frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
                        LL = 263
                        'frmExchangeMonitor.lblMessageInfo.Refresh()
                        LL = 264
                        System.Windows.Forms.Application.DoEvents()
                        LL = 265

                        LL = 266
                        Dim DaysOld As Integer = email.NumDaysOld
                        LL = 267
                        If DaysOld > DaysToHold Then
                            LL = 268
                            success = imap.SetMailFlag(email, "Deleted", 1)
                            LL = 269
                            If (success <> True) Then
                                LL = 270
                                Dim Msg As String = "Subject: " + Subject + environment.NewLine
                                LL = 271
                                Msg += "FromName: " + FromName + environment.NewLine
                                LL = 272
                                Msg += "FromAddress: " + FromAddress + environment.NewLine
                                LL = 273
                                LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                                LL = 274
                            End If
                            LL = 275
                        End If
                        LL = 276
                        GoTo NextRec
                    End If
                    LL = 279

                    LL = 280
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + i.ToString)
                    LL = 281
                    Dim B As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                    LL = 282
                    If B Then
                        LL = 283
                        If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + i.ToString)
                        LL = 284
                        GoTo NextRec
                        LL = 285
                    End If
                    LL = 286

                    LL = 287
                    Dim EmailFQN As String = EmailDir + "\Email~" & NewGuid + "~.EML"
                    LL = 288

                    LL = 289
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyEmailBundle 800.4: " + i.ToString)
                    LL = 290
                    If NumAttachments > 0 Then
                        LL = 291
                        '** Clean out the directory
                        LL = 292
                        deleteDirectoryFile(AttachmentDir)
                        LL = 293
                        ' Save attachments to the "attachments" directory.
                        LL = 294
                        email.SaveAllAttachments(AttachmentDir)
                        LL = 295
                        bLoadAttachments = True
                        LL = 296
                    End If
                    LL = 297

                    LL = 298
                    If NumAttachedMessages > 0 Then
                        LL = 299
                        'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                        LL = 300
                        For ii = 0 To NumAttachedMessages - 1
                            LL = 301
                            'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                            LL = 302
                            Dim objEmail As Chilkat.Email = email.GetAttachedMessage(ii)
                            LL = 303
                            ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                            LL = 304
                            objEmail = Nothing
                            LL = 305
                        Next
                        LL = 306
                    End If
                    LL = 307

                    LL = 308
                    For J = 0 To NumCC - 1
                        LL = 309
                        CC.Add(email.GetCC(J).ToString)
                        LL = 310
                        CcAddr.Add(email.GetCcAddr(J).ToString)
                        LL = 311
                        CcName.Add(email.GetCcName(J).ToString)
                        LL = 312
                        If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                            LL = 313
                            Recipients.Add(email.GetCcAddr(J).ToString)
                            LL = 314
                        End If
                        LL = 315
                    Next
                    LL = 316
                    For J = 0 To NumBcc - 1
                        LL = 317
                        Bcc.Add(email.GetBcc(J).ToString)
                        LL = 318
                        BccName.Add(email.GetBccName(J).ToString)
                        LL = 319
                        BccAddr.Add(email.GetBccAddr(J).ToString)
                        LL = 320
                        If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                            LL = 321
                            Recipients.Add(email.GetBccAddr(J).ToString)
                            LL = 322
                        End If
                        LL = 323
                    Next
                    LL = 324
                    For J = 0 To NumTo - 1
                        LL = 325
                        EmailTo.Add(email.GetTo(J).ToString)
                        LL = 326
                        EmailToAddr.Add(email.GetToAddr(J).ToString)
                        LL = 327
                        EmailToName.Add(email.GetToName(J).ToString)
                        LL = 328
                        If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                            LL = 329
                            Recipients.Add(email.GetToAddr(J).ToString)
                            LL = 330
                        End If
                        LL = 331
                    Next
                    LL = 332

                    LL = 333
                    ' Save the email to XML
                    LL = 334
                    'email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
                    LL = 335

                    LL = 336
                    ' Save the email to EML
                    LL = 337
                    'Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                    LL = 338
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.0: " + i.ToString)
                    LL = 339
                    email.SaveEml(EmailFQN)
                    LL = 340

                    LL = 341
                    '**********************************************************
                    LL = 342
                    'IF CONVERT TO MSG THEN
                    LL = 343
                    'READ IN THE NEW EML
                    LL = 344
                    'CONVERT IT TO MSG
                    LL = 345
                    'WRITE OUT THE MSG
                    LL = 346
                    'SAVE THE MSG IMAGE INTO THE REPOSITORY.
                    LL = 347

                    LL = 348
                    If bEmlToMSG = True Then
                        LL = 349
                        LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN '" + EmailFQN + "'")
                        LL = 350
                        EmailFQN = convertEmlToMsg(EmailFQN)
                        LL = 351
                    End If
                    LL = 352
                    '**********************************************************
                    LL = 353

                    LL = 354

                    LL = 355
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.1: " + i.ToString)
                    LL = 356
                    Dim AttachedFiles As New List(Of String)
                    LL = 357
                    getDirectoryFiles(AttachmentDir, AttachedFiles)
                    LL = 358

                    LL = 359
                    Dim DB_ID As String = "ECM.Library"
                    LL = 360
                    Dim Server_UserID_StoreID As String = CurrMailFolder
                    LL = 361

                    LL = 362
                    '** Now, Load the EMAIL and its metadata into the repository
                    LL = 363
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + i.ToString)
                    LL = 364

                    LL = 365
                    Dim AttachmentsLoaded As Boolean = False
                    LL = 366

                    LL = 367
                    ArchiveExchangeEmails(UID, NewGuid,
                        EmailBody,
                        Subject,
                        CcAddr,
                        BccAddr,
                        EmailToAddr,
                        Recipients,
                        MailServerAddr,
                        FromAddress,
                        FromName,
                        CDate(EmailDate),
                        UserLoginID,
                        CDate(LocalDate),
                        CDate(EmailDate),
                        DB_ID,
                        CurrMailFolder,
                        Server_UserID_StoreID,
                        retentionYears,
                        RetentionCode,
                        EmailSize,
                        AttachedFiles,
                        EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)
                    LL = 389

                    LL = 390
                    If AttachmentsLoaded = True Then
                        LL = 391
                        Dim DoThis As Boolean = False
                        LL = 392
                        If DoThis Then
                            LL = 393
                            If AttachmentsLoaded = True Then
                                LL = 394
                                DBARCH.AppendOcrTextEmail(NewGuid)
                                LL = 395
                                AttachmentsLoaded = False
                                LL = 396
                            End If
                            LL = 397
                        End If
                        LL = 398
                    End If
                    LL = 400
NextRec:
                    LL = 401
                    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 1000: " + i.ToString)
                    LL = 402

                    LL = 403
                Next
                LL = 404
                '*****************************************************************************
                LL = 405
                If ExitUponCompletion = True Then
                    LL = 406
                    Exit Do
                    LL = 407
                End If
                LL = 408
                If DownLoadSize > MessagesRemainingToProcess Then
                    LL = 409
                    DownLoadSize = MessagesRemainingToProcess
                    LL = 410
                    'Increment = MessagesRemainingToProcess
                    LL = 411
                    numToFetch = MessagesRemainingToProcess
                    LL = 412
                Else
                    LL = 413
                    numToFetch = DownLoadSize
                    LL = 414
                End If
                LL = 415
                startSeqNum = startSeqNum + Increment
                LL = 416

                LL = 417

                LL = 418
                If numToFetch > 0 Then
                    LL = 419
                    bundle = imap.FetchSequence(startSeqNum, numToFetch)
                    LL = 420
                    If (bundle Is Nothing) Then
                        LL = 421
                        LOG.WriteToArchiveLog("Warning - termination - getImapEmailSSL 400: End of process.")
                        LL = 422
                        Exit Do
                        LL = 423
                    End If
                    LL = 424
                End If
                LL = 426
            Loop
            LL = 427
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 100 getImapEmailSSL: LL = " + LL.ToString + ": " + ex.Message)
            RC = False
        End Try

ENDIT:
        imap.Expunge()

        LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString)

        ' Disconnect from the IMAP server.
        imap.Disconnect()

        messageSet = Nothing
        imap = Nothing
        bundle = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

        frmExchangeMonitor.lblCnt.Text = "Emails Processed: "
        frmExchangeMonitor.lblCnt.Refresh()

        Return RC

    End Function

    Function getIMapEmailV3(ByVal UID As String, ByVal MailServerAddr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer,
                            ByVal LibraryName As String,
                            ByVal isPublic As Boolean,
                            ByVal DaysToHold As Integer,
                            ByVal strReject As String,
                            ByVal bEmlToMSG As Boolean) As Boolean
        Dim RC As Boolean = True
        Dim LL As Integer = 0
        Dim imap As New Chilkat.Imap()
        Dim RecjectCount As Integer = 1
        Dim EmailsProcessedThisRun As Integer = 0
        Dim DownLoadSize As Integer = 0
        Dim sDownLoadSize As String = ""
        Dim Increment As Integer = 0
        Dim I As Long = 0
        imap.ReadTimeout = 360
        Try
            Dim ServerName As String = MailServerAddr + ":" + UserLoginID

            Dim TempDir As String = System.IO.Path.GetTempPath
            Dim AttachmentDir As String = TempDir + "Email\Attachment"
            Dim EmailDir As String = TempDir + "Email"
            Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID

            Dim Success As Boolean = False
            imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
            Success = imap.Connect(MailServerAddr)
            If Not Success Then
                Return False
                MessageBox.Show(imap.LastErrorText)
            End If
            Success = imap.Login(UserLoginID, LoginPassWord)
            If Not Success Then
                MessageBox.Show(imap.LastErrorText)
                Return False
            End If
            If Not Success Then
                frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
                LOG.WriteToArchiveLog("FATAL ERROR: IMAP 300.1 Failed to log on to " + MailServerAddr + ", aborting.")
                Return False
            Else
                frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            ' Get the names of all the mailboxes.
            Dim mboxes As Chilkat.Mailboxes
            mboxes = imap.ListMailboxes("", "*")
            For iii As Integer = 0 To mboxes.Count - 1
                Console.WriteLine(mboxes.GetName(iii))
                Dim mName As String = mboxes.GetName(iii)
                frmExchangeMonitor.lblMsg.Text = "Mailbox: " + mboxes.GetName(iii)
                frmExchangeMonitor.lblMsg.Refresh()
            Next

            ' Once the mailbox is selected, the NumMessages property will contain the number of
            ' messages in the mailbox. You may loop from 1 to NumMessages to fetch each message by
            ' sequence number.
            Dim BB As Boolean = imap.SelectMailbox("Inbox")
            If Not BB Then
                Return False
            End If

            Increment = DownLoadSize

            frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr
            frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
            frmExchangeMonitor.lblServer.Refresh()
            frmExchangeMonitor.lblServer.Refresh()
            System.Windows.Forms.Application.DoEvents()

            Dim bundle As Chilkat.EmailBundle

            Dim ExitUponCompletion As Boolean = False
            Dim fetchUids As Boolean = True
REDO:
            Dim NumberOfMessagesInBox As Integer = imap.NumMessages
            Dim RejectedCount As Integer = 0
            Dim bUid As Boolean
            bUid = False
            Dim email As Chilkat.Email
            NumberOfMessagesInBox = imap.NumMessages
            Dim MessagesProcessed As Integer = 0
            Dim MessagesRemainingToProcess As Integer = NumberOfMessagesInBox
            TotalEmailsInArchive = 0

            Dim ElapsedTime As TimeSpan
            Dim ElapsedTxTime As TimeSpan
            Dim ETime As DateInterval
            Dim txTime As DateInterval
            Dim StartTime As DateTime = Now

            For iCnt = 1 To NumberOfMessagesInBox

                ' Download the email by sequence number.
                ElapsedTxTime = Now().Subtract(StartTime)
                StartTime = Now

                email = imap.FetchSingle(iCnt, bUid)
                Dim EntryID As String = email.Uidl

                ElapsedTime = Now().Subtract(StartTime)
                frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr
                frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
                frmExchangeMonitor.lblSpeed.Text = ElapsedTime.ToString
                frmExchangeMonitor.txTime.Text = ElapsedTxTime.ToString
                frmExchangeMonitor.lblServer.Refresh()
                System.Windows.Forms.Application.DoEvents()

                '*******************************************************************************
                Dim ExitNow As Boolean = False
                TotalEmailsInArchive += 1
                EmailsProcessedThisRun += 1
                MessagesRemainingToProcess = MessagesRemainingToProcess - 1
                frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString + " of " + NumberOfMessagesInBox.ToString
                frmExchangeMonitor.lblCnt.Refresh()
                System.Windows.Forms.Application.DoEvents()
                Dim NewGuid As String = System.Guid.NewGuid.ToString()

                Dim Subject As String = email.Subject
                Subject = LOG.PullOutSingleQuotes(Subject)
                Dim EmailFrom As String = email.From
                Dim FromAddress As String = email.FromAddress
                Dim FromName As String = email.FromName
                Dim From As String = email.From

                If strReject.Trim.Length > 0 Then
                    Dim A As String() = strReject.Split(",")
                    For II As Integer = 0 To UBound(A)
                        Dim S1 As String = A(II).Trim
                        If S1.Trim.Length > 0 Then
                            If InStr(Subject, S1, CompareMethod.Text) Then
                                'LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                RejectedCount += 1
                                GoTo NextRec
                            End If
                        End If
                    Next
                End If

                Dim NbrDaysOld As Integer = email.NumDaysOld
                If NbrDaysOld >= DaysToHold Then
                    Success = imap.SetMailFlag(email, "Deleted", 1)
                    If (Success <> True) Then
                        Dim Msg As String = "Subject: " + Subject + environment.NewLine
                        Msg += "FromName: " + FromName + environment.NewLine
                        Msg += "FromAddress: " + FromAddress + environment.NewLine
                        LOG.WriteToArchiveLog("ERROR: getIMapEmail: Failed to delete email from server:" + environment.NewLine + Msg)
                    End If
                End If

                Dim NumAlternatives As Integer = email.NumAlternatives
                Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                Dim NumAttachments As Integer = email.NumAttachments
                Dim NumBcc As Integer = email.NumBcc
                Dim NumCC As Integer = email.NumCC
                Dim NumTo As Integer = email.NumTo
                Dim ReplyTo As String = email.ReplyTo
                Dim SignedBy As String = email.SignedBy
                Dim EmailSize As Integer = email.Size
                Dim LocalDate As String = email.LocalDate.ToString
                Dim EmailDate As String = email.EmailDate.ToString
                Dim Header As String = email.Header
                Dim EmailBody As String = email.Body
                EmailBody = LOG.PullOutSingleQuotes(EmailBody)

                Dim Recipients As New ArrayList
                Dim EmailTo As New ArrayList
                Dim EmailToAddr As New ArrayList
                Dim EmailToName As New ArrayList
                Dim Bcc As New ArrayList
                Dim BccAddr As New ArrayList
                Dim BccName As New ArrayList
                Dim CC As New ArrayList
                Dim CcAddr As New ArrayList
                Dim CcName As New ArrayList
                Dim bLoadAttachments As Boolean = False
                Dim tEmailDate As String = EmailDate.ToString

                FixDate(tEmailDate)
                Dim tSubject As String = Mid(Subject, 1, 100)
                RemoveBadChars(tSubject)

                Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject)
                Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)

                If bEmailExists Then
                    System.Windows.Forms.Application.DoEvents()
                    Dim DaysOld As Integer = email.NumDaysOld
                    If DaysOld < 0 Then
                        DaysOld = 1
                    End If
                    If DaysOld > DaysToHold Then
                        Success = imap.SetMailFlag(email, "Deleted", 1)
                        If (Success <> True) Then
                            Dim Msg As String = "Subject: " + Subject + environment.NewLine
                            Msg += "FromName: " + FromName + environment.NewLine
                            Msg += "FromAddress: " + FromAddress + environment.NewLine
                            LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                        End If
                    End If
                    GoTo NextRec
                End If

                'If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + I.ToString)
                'Dim B As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                'If B Then
                '    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + I.ToString)
                '    GoTo NextRec
                'End If

                Dim EmailFQN As String = EmailDir + "\Email~" & NewGuid + "~.EML"

                If NumAttachedMessages > 0 Then
                    For II As Integer = 0 To NumAttachedMessages - 1
                        'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                        Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                        ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                        objEmail = Nothing
                    Next
                End If

                For J = 0 To NumCC - 1
                    CC.Add(email.GetCC(J).ToString)
                    CcAddr.Add(email.GetCcAddr(J).ToString)
                    CcName.Add(email.GetCcName(J).ToString)
                    If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                        Recipients.Add(email.GetCcAddr(J).ToString)
                    End If
                Next
                For J = 0 To NumBcc - 1
                    Bcc.Add(email.GetBcc(J).ToString)
                    BccName.Add(email.GetBccName(J).ToString)
                    BccAddr.Add(email.GetBccAddr(J).ToString)
                    If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                        Recipients.Add(email.GetBccAddr(J).ToString)
                    End If
                Next
                For J = 0 To NumTo - 1
                    EmailTo.Add(email.GetTo(J).ToString)
                    EmailToAddr.Add(email.GetToAddr(J).ToString)
                    EmailToName.Add(email.GetToName(J).ToString)
                    If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                        Recipients.Add(email.GetToAddr(J).ToString)
                    End If
                Next
                email.SaveEml(EmailFQN)
                If bEmlToMSG = True Then
                    LOG.WriteToArchiveLog("Notice from getImapEmail 300 : FQN '" + EmailFQN + "'")
                    EmailFQN = convertEmlToMsg(EmailFQN)
                End If
                Dim AttachedFiles As New List(Of String)
                getDirectoryFiles(AttachmentDir, AttachedFiles)
                Dim DB_ID As String = "ECM.Library"
                Dim Server_UserID_StoreID As String = CurrMailFolder

                '** Now, Load the EMAIL and its metadata into the repository
                If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + I.ToString)

                Dim AttachmentsLoaded As Boolean = False

                ArchiveExchangeEmails(UID, NewGuid,
                        EmailBody,
                        Subject,
                        CcAddr,
                        BccAddr,
                        EmailToAddr,
                        Recipients,
                        MailServerAddr,
                        FromAddress,
                        FromName,
                        CDate(EmailDate),
                        UserLoginID,
                        CDate(LocalDate),
                        CDate(EmailDate),
                        DB_ID,
                        CurrMailFolder,
                        Server_UserID_StoreID,
                        retentionYears,
                        RetentionCode,
                        EmailSize,
                        AttachedFiles,
                        EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, AttachmentsLoaded, DaysToHold)

                If AttachmentsLoaded = True Then
                    Dim DoThis As Boolean = False
                    If DoThis Then
                        If AttachmentsLoaded = True Then
                            DBARCH.AppendOcrTextEmail(NewGuid)
                            AttachmentsLoaded = False
                        End If
                    End If
                End If

                If NumAttachments > 0 Then
                    'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                    For II As Integer = 0 To NumAttachments - 1
                        ''email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                        'Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                        LoadEmailAttachments(AttachmentDir, NewGuid)
                        'objEmail.Dispose()
                    Next
                End If

NextRec:
            Next
            '***************************************************************
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR: 2699 getIMapEmail: " + ex.Message)
            RC = False
        Finally
            ' Disconnect from the IMAP server. This example removes the deleted email on the IMAP server.
            imap.Expunge()
            imap.Disconnect()

            GC.Collect()
            GC.WaitForPendingFinalizers()

        End Try
ENDIT:
        ' Save the email to an XML file
        'bundle.SaveXml("bundle.xml")
        LOG.WriteToArchiveLog("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString)
        LOG.WriteToArchiveLog("Applying IMAP Bundle PROCESSED Message Count = " + TotalEmailsInArchive.ToString)
        LOG.WriteToArchiveLog("INFO: Emails processed this run  = " + EmailsProcessedThisRun.ToString + " from " + MailServerAddr)
        frmExchangeMonitor.lblMessageInfo.Text = "Emails Processed: "
        frmExchangeMonitor.lblMessageInfo.Refresh()
        Windows.Forms.Application.DoEvents()
        Return RC
    End Function

    Function getImapEmailSSLV3(ByVal UID As String, ByVal MailServerAddr As String, ByVal PortNbr As String,
                            ByVal UserLoginID As String,
                            ByVal LoginPassWord As String,
                            ByVal LeaveOnServer As Boolean,
                            ByVal RetentionCode As String,
                            ByVal retentionYears As Integer,
                            ByVal LibraryName As String,
                            ByVal isPublic As Boolean,
                            ByVal DaysToHold As Integer,
                            ByVal strReject As String,
                            ByVal bEmlToMSG As Boolean,
                            ByVal UseSSL As Boolean) As Boolean
        Dim RC As Boolean = False
        Dim LL As Integer = 1
        Dim imap As New Chilkat.Imap()
        Dim RejectedCount As Integer = 0
        Dim messageSet As Chilkat.MessageSet
        Dim bundle As Chilkat.EmailBundle
        Try
            Dim ServerName As String = MailServerAddr + ":" + UserLoginID

            Dim success As Boolean = False
            Dim TempDir As String = System.IO.Path.GetTempPath
            Dim AttachmentDir As String = TempDir + "Email\Attachment"
            Dim EmailDir As String = TempDir + "Email"
            Dim CurrMailFolder As String = MailServerAddr + ":" + UserLoginID

            ' Anything unlocks the component and begins a fully-functional 30-day trial.
            success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G")
            If (success <> True) Then
                MessageBox.Show(imap.LastErrorText)
                Return False
            End If

            ' To use a secure SSL connection, set SSL and the port:
            imap.Ssl = UseSSL
            ' The typical port for IMAP SSL is 993
            If PortNbr.Length = 0 Then
                imap.Port = 993
            Else
                imap.Port = Val(PortNbr)
            End If

            ' Connect to an IMAP server.
            success = imap.Connect(MailServerAddr)
            If (success <> True) Then
                LOG.WriteToArchiveLog("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText)
                Return False
            Else
                frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            success = imap.Login(UserLoginID, LoginPassWord)
            If (success <> True) Then
                MessageBox.Show(imap.LastErrorText)
                LOG.WriteToArchiveLog("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText)
                frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
                Return False
            Else
                frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful."
                frmExchangeMonitor.lblMessageInfo.Refresh()
                System.Windows.Forms.Application.DoEvents()
            End If
            ' Get the names of all the mailboxes.
            Dim mboxes As Chilkat.Mailboxes
            mboxes = imap.ListMailboxes("", "*")
            Dim ii As Long
            For ii = 0 To mboxes.Count - 1
                Console.WriteLine(mboxes.GetName(ii))
            Next
            success = imap.SelectMailbox("Inbox")
            If (success <> True) Then
                MessageBox.Show(imap.LastErrorText)
                LOG.WriteToArchiveLog("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText)
                Return False
            End If

            ' After selecting a mailbox, the NumMessages property will be updated to reflect the
            ' total number of emails in the mailbox:
            frmExchangeMonitor.lblMsg.Text = "Download: " + imap.NumMessages.ToString + " messages."
            frmExchangeMonitor.lblMsg.Refresh()
            System.Windows.Forms.Application.DoEvents()

            Dim NumberOfMessagesInBox As Integer = imap.NumMessages

            If NumberOfMessagesInBox > 0 Then
                LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
            Else
                LOG.WriteToArchiveLog("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString)
                GoTo ENDIT
            End If

            frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr
            frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID
            frmExchangeMonitor.lblServer.Refresh()
            frmExchangeMonitor.lblServer.Refresh()
            System.Windows.Forms.Application.DoEvents()

            Dim bUid As Boolean
            bUid = False
            Dim email As Chilkat.Email
            NumberOfMessagesInBox = imap.NumMessages
            Dim MessagesProcessed As Integer = 0
            Dim MessagesRemainingToProcess As Integer = NumberOfMessagesInBox
            TotalEmailsInArchive = 0
            For iCnt = 1 To NumberOfMessagesInBox

                ' Download the email by sequence number.
                email = imap.FetchSingle(iCnt, bUid)
                Dim EntryID As String = email.Uidl

                TotalEmailsInArchive += 1
                MessagesRemainingToProcess = MessagesRemainingToProcess - 1
                frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString + " of " + imap.NumMessages.ToString
                frmExchangeMonitor.lblCnt.Refresh()
                System.Windows.Forms.Application.DoEvents()
                Dim NewGuid As String = System.Guid.NewGuid.ToString()
                Dim Subject As String = email.Subject
                Subject = LOG.PullOutSingleQuotes(Subject)
                Dim EmailFrom As String = email.From
                Dim FromAddress As String = email.FromAddress
                Dim FromName As String = email.FromName
                Dim From As String = email.From

                If strReject.Trim.Length > 0 Then
                    Dim A As String() = strReject.Split(",")
                    For ii = 0 To UBound(A)
                        Dim S1 As String = A(ii).Trim
                        If S1.Trim.Length > 0 Then
                            If InStr(Subject, S1, CompareMethod.Text) Then
                                'LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                RejectedCount += 1
                                GoTo NextRec
                            End If
                        End If
                    Next
                End If
                Dim NbrDaysOld As Integer = 0
                NbrDaysOld = email.NumDaysOld
                If NbrDaysOld >= DaysToHold Then
                    success = imap.SetMailFlag(email, "Deleted", 1)
                    If (success <> True) Then
                        Dim Msg As String = "Subject: " + Subject + environment.NewLine
                        Msg += "FromName: " + FromName + environment.NewLine
                        Msg += "FromAddress: " + FromAddress + environment.NewLine
                        LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                    End If
                End If

                Dim NumAlternatives As Integer = email.NumAlternatives
                Dim NumAttachedMessages As Integer = email.NumAttachedMessages
                Dim NumAttachments As Integer = email.NumAttachments
                Dim NumBcc As Integer = email.NumBcc
                Dim NumCC As Integer = email.NumCC
                Dim NumTo As Integer = email.NumTo
                Dim ReplyTo As String = email.ReplyTo
                Dim SignedBy As String = email.SignedBy
                Dim EmailSize As Integer = email.Size
                Dim LocalDate As String = email.LocalDate.ToString
                Dim EmailDate As String = email.EmailDate.ToString
                Dim Header As String = email.Header
                Dim EmailBody As String = email.Body
                EmailBody = LOG.PullOutSingleQuotes(EmailBody)

                Dim Recipients As New ArrayList
                Dim EmailTo As New ArrayList
                Dim EmailToAddr As New ArrayList
                Dim EmailToName As New ArrayList
                Dim Bcc As New ArrayList
                Dim BccAddr As New ArrayList
                Dim BccName As New ArrayList
                Dim CC As New ArrayList
                Dim CcAddr As New ArrayList
                Dim CcName As New ArrayList
                Dim bLoadAttachments As Boolean = False

                Dim J As Integer = 0

                Dim tEmailDate As String = EmailDate.ToString
                FixDate(tEmailDate)
                Dim tSubject As String = Mid(Subject, 1, 100)
                RemoveBadChars(tSubject)

                Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject)
                Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                If bEmailExists Then
                    System.Windows.Forms.Application.DoEvents()
                    Dim DaysOld As Integer = email.NumDaysOld
                    If DaysOld > DaysToHold Then
                        success = imap.SetMailFlag(email, "Deleted", 1)
                        If (success <> True) Then
                            Dim Msg As String = "Subject: " + Subject + environment.NewLine
                            Msg += "FromName: " + FromName + environment.NewLine
                            Msg += "FromAddress: " + FromAddress + environment.NewLine
                            LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + environment.NewLine + Msg)
                        End If
                    End If
                    GoTo NextRec
                End If

                'Dim B As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier, EmailHashCode)
                'If B Then
                '    GoTo NextRec
                'End If

                Dim EmailFQN As String = EmailDir + "\Email~" & NewGuid + "~.EML"

                If NumAttachments > 0 Then
                    '** Clean out the directory
                    deleteDirectoryFile(AttachmentDir)
                    ' Save attachments to the "attachments" directory.
                    email.SaveAllAttachments(AttachmentDir)
                    bLoadAttachments = True
                End If

                If NumAttachedMessages > 0 Then
                    'email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                    For ii = 0 To NumAttachedMessages - 1
                        'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                        Dim objEmail As Chilkat.Email = email.GetAttachedMessage(ii)
                        ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID)
                        objEmail = Nothing
                    Next
                End If

                For J = 0 To NumCC - 1
                    CC.Add(email.GetCC(J).ToString)
                    CcAddr.Add(email.GetCcAddr(J).ToString)
                    CcName.Add(email.GetCcName(J).ToString)
                    If Not Recipients.Contains(email.GetCcAddr(J).ToString) Then
                        Recipients.Add(email.GetCcAddr(J).ToString)
                    End If
                Next
                For J = 0 To NumBcc - 1
                    Bcc.Add(email.GetBcc(J).ToString)
                    BccName.Add(email.GetBccName(J).ToString)
                    BccAddr.Add(email.GetBccAddr(J).ToString)
                    If Not Recipients.Contains(email.GetBccAddr(J).ToString) Then
                        Recipients.Add(email.GetBccAddr(J).ToString)
                    End If
                Next
                For J = 0 To NumTo - 1
                    EmailTo.Add(email.GetTo(J).ToString)
                    EmailToAddr.Add(email.GetToAddr(J).ToString)
                    EmailToName.Add(email.GetToName(J).ToString)
                    If Not Recipients.Contains(email.GetToAddr(J).ToString) Then
                        Recipients.Add(email.GetToAddr(J).ToString)
                    End If
                Next

                ' Save the email to XML
                'email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

                ' Save the email to EML
                'Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                email.SaveEml(EmailFQN)

                '**********************************************************
                'IF CONVERT TO MSG THEN
                'READ IN THE NEW EML
                'CONVERT IT TO MSG
                'WRITE OUT THE MSG
                'SAVE THE MSG IMAGE INTO THE REPOSITORY.

                If bEmlToMSG = True Then
                    LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN '" + EmailFQN + "'")
                    EmailFQN = convertEmlToMsg(EmailFQN)
                End If
                '**********************************************************

                Dim AttachedFiles As New List(Of String)
                getDirectoryFiles(AttachmentDir, AttachedFiles)

                Dim DB_ID As String = "ECM.Library"
                Dim Server_UserID_StoreID As String = CurrMailFolder

                '** Now, Load the EMAIL and its metadata into the repository
                Dim AttachmentsLoaded As Boolean = False

                ArchiveExchangeEmails(UID, NewGuid,
                    EmailBody,
                    Subject,
                    CcAddr,
                    BccAddr,
                    EmailToAddr,
                    Recipients,
                    MailServerAddr,
                    FromAddress,
                    FromName,
                    CDate(EmailDate),
                    UserLoginID,
                    CDate(LocalDate),
                    CDate(EmailDate),
                    DB_ID,
                    CurrMailFolder,
                    Server_UserID_StoreID,
                    retentionYears,
                    RetentionCode,
                    EmailSize,
                    AttachedFiles,
                    EntryID,
                    EmailIdentifier,
                    EmailFQN,
                    LibraryName,
                    isPublic,
                    bEmlToMSG,
                    AttachmentsLoaded,
                    DaysToHold)

                If AttachmentsLoaded = True Then
                    Dim DoThis As Boolean = False
                    If DoThis Then
                        If AttachmentsLoaded = True Then
                            DBARCH.AppendOcrTextEmail(NewGuid)
                            AttachmentsLoaded = False
                        End If
                    End If
                End If
NextRec:
            Next
        Catch ex As System.Exception
            LOG.WriteToArchiveLog("ERROR 100 getImapEmailSSL: LL = " + LL.ToString + ": " + ex.Message)
            RC = False
        End Try
ENDIT:
        imap.Expunge()
        LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString)
        ' Disconnect from the IMAP server.
        imap.Disconnect()
        messageSet = Nothing
        imap = Nothing
        bundle = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()
        frmExchangeMonitor.lblCnt.Text = "Emails Processed: "
        frmExchangeMonitor.lblCnt.Refresh()
        Return RC
    End Function

    Sub LoadEmailAttachments(ByVal DirectoryFQN As String, ByVal EmailGuid As String)

        Dim RetentionCode As String = "Retain 10"
        Dim ispublic As String = "N"

        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(DirectoryFQN)
        Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
        Dim fi As IO.FileInfo

        Dim StackLevel As Integer = 0
        Dim ListOfFiles As New Dictionary(Of String, Integer)

        For Each fi In aryFi

            Dim filename As String = fi.FullName
            Dim FileNameOnly As String = fi.Name
            Dim FileExt As String = fi.Extension

            If File.Exists(filename) Then
                Dim isZipFile As Boolean = ZF.isZipFile(filename)
                If isZipFile = True Then
                    '** Explode and load
                    Dim AttachmentName As String = filename
                    Dim SkipIfAlreadyArchived As Boolean = False
                    Dim AttachmentsLoaded As Boolean = False
                    ZF.ProcessEmailZipFile(gMachineID, EmailGuid, filename, gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
                Else
                    FileExt = "." + UTIL.getFileSuffix(filename)
                    Dim AttachmentName As String = filename
                    Dim Sha1Hash As String = ENC.GenerateSHA512HashFromFile(filename)
                    Dim bbx As Boolean = DBARCH.InsertAttachmentFqn(gCurrUserGuidID, filename, EmailGuid, AttachmentName, FileExt, gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, DirectoryFQN)

                    If FileExt.ToUpper.Equals(".PDF") Then
                        TotalOcr += 1
                        frmExchangeMonitor.lblMsg.Text = "Total OCR: " + TotalOcr.ToString
                        '**WDM DBARCH.PDFXTRACT(EmailGuid, filename , "EMAIL")
                    End If
                End If
            End If

        Next
    End Sub

    Private Sub PurgeDirectory(ByVal DirFqn As String)

        Dim S() As String

        S = Directory.GetFiles(DirFqn)
        Dim DELFILE As String
        For Each DELFILE In S
            File.Delete(DELFILE)
        Next
    End Sub

End Class