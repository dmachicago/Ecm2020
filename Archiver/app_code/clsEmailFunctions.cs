/* TODO ERROR: Skipped DefineDirectiveTrivia *//* TODO ERROR: Skipped DefineDirectiveTrivia *//* TODO ERROR: Skipped DefineDirectiveTrivia */
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using global::System.Data.SqlClient;
using System.Drawing;
using global::System.IO;
using global::System.Threading;
using System.Windows.Forms;
using global::System.Xml;
using global::ECMEncryption;
using global::Microsoft.Office.Interop.Outlook;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsEmailFunctions : clsArchiver
    {
        private clsIsolatedStorage ISO = new clsIsolatedStorage();
        private clsDbLocal DBLocal = new clsDbLocal();
        private int skippedEmails = 0;
        private bool srv_DetailedLogging = false;
        private double TotalMemory = 0d;
        private int TotalOcr = 0;
        private int TotalOcrFailed = 0;
        private int DaysToHold = 365;
        private clsATTACHMENTTYPE ATYPE = new clsATTACHMENTTYPE();
        private clsEMAIL EMAIL = new clsEMAIL();
        private clsRECIPIENTS RECIPS = new clsRECIPIENTS();
        private clsZipFiles ZF = new clsZipFiles();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();

        /* TODO ERROR: Skipped IfDirectiveTrivia */
        private const int PR_ICON_INDEX = 0x10800003;
        /* TODO ERROR: Skipped EndIfDirectiveTrivia */
        private int TotalEmailsInArchive = 0;
        private bool dDebug_clsEmailFunctions = false;
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private ECMEncrypt ENC = new ECMEncrypt();
        private SortedList SL = new SortedList();
        private SortedList SL2 = new SortedList();

        public clsEmailFunctions()
        {
            string sDebug = getUserParm("debug_clsEmailFunc");
            if (sDebug.Equals("0"))
            {
                dDebug_clsEmailFunctions = false;
            }
            else
            {
                dDebug_clsEmailFunctions = true;
                LOG.WriteToArchiveLog("Starting: clsEmailFunctions, Debug configuration is ON");
            }
        }

        public void LaunchExchangeDownload()
        {
            if (isArchiveDisabled("EXCHANGE") == true)
            {
                LOG.WriteToArchiveLog("LaunchExchangeDownload: Exchange Archive is LAUNCHED ");
                return;
            }

            if (modGlobals.gCurrentArchiveGuid.Length == 0)
            {
                modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
            }

            Thread t;
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("Entering LaunchExchangeDownload from clsEmailFunctions");
            LOG.WriteToArchiveLog("Entering LaunchExchangeDownload from clsEmailFunctions");
            LOG.WriteToArchiveLog("GetExchangeFolders LaunchExchangeDownload 100");
            t = new Thread((_) => this.ProcessExchangeServers());
            LOG.WriteToArchiveLog("GetExchangeFolders LaunchExchangeDownload 200");
            t.Priority = ThreadPriority.Lowest;
            t.Start();
            LOG.WriteToArchiveLog("Thread executing LaunchExchangeDownload from clsEmailFunctions");
        }

        // Sub xxProcessExchangePopMail()

        // If isArchiveDisabled("EXCHANGE") = True Then Return End If

        // frmExchangeMonitor.Show() frmExchangeMonitor.Location = New Point(25, 50)
        // frmExchangeMonitor.Refresh() System.Windows.Forms.Application.DoEvents()

        // LOG.WriteToArchiveLog("Exchange Archive started @ " + Now.ToString)

        // Try If gCurrentArchiveGuid .Length = 0 Then gCurrentArchiveGuid = Guid.NewGuid.ToString End If

        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("Starting ProcessExchangePopMail from
        // clsEmailFunctions") Dim ArchiveGuid = System.Guid.NewGuid.ToString()

        // Dim S = "Select
        // [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL,
        // IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM
        // [ExchangeHostPop] order by [HostNameIp] ,[UserLoginID]" Dim rsData As SqlDataReader

        // Dim DaysToRetain As Integer = 1000000 Dim HostNameIp = "" Dim UserLoginID = "" Dim LoginPw = ""
        // Dim LeaveOnServer As Boolean = True Dim DeleteAfterDownload As Boolean = False Dim PortNbr = ""
        // Dim RetentionCode = "" Dim retentionYears As Integer = 10 Dim SSL As Boolean = False Dim IMap
        // As Boolean = False Dim FolderName = "" Dim LibraryName = "" Dim isPublic As Boolean = False Dim
        // strReject = "" Dim ConvertEmlToMSG As Boolean = False

        // rsData = SqlQryNewConn(S)

        // If rsData.HasRows Then Do While rsData.Read() System.Windows.Forms.Application.DoEvents() '0
        // [HostNameIp], '1 [UserLoginID], '2 [LoginPw], '3 [PortNbr], '4 [DeleteAfterDownload], '5
        // [RetentionCode], '6 SSL, '7 IMap, '8 FolderName, '9 LibraryName, '10 isPublic '11 DaysToHold
        // '12 strReject '13 ConvertEmlToMSG If gTerminateImmediately Then Return End If

        // Try ConvertEmlToMSG = rsData.GetBoolean(13) Catch ex As System.Exception ConvertEmlToMSG =
        // False End Try

        // Try LibraryName = rsData.GetValue(9).ToString Catch ex As System.Exception LibraryName = "NA"
        // End Try

        // Try isPublic = rsData.GetBoolean(10) Catch ex As System.Exception isPublic = False End Try

        // Try DaysToRetain = rsData.GetInt32(11) Catch ex As System.Exception DaysToRetain = 1000000 End
        // Try Try strReject = rsData.GetValue(12).ToString Catch ex As System.Exception strReject = ""
        // End Try

        // Dim LibraryOwnerUserID = "" If LibraryName.Trim.Length > 0 Then LibraryOwnerUserID =
        // GetLibOwnerByName(LibraryName ) End If

        // Try HostNameIp = rsData.GetValue(0).ToString Catch ex As System.Exception HostNameIp = "" End Try

        // Try UserLoginID = rsData.GetValue(1).ToString Catch ex As System.Exception UserLoginID = "" End Try

        // 'If ConvertEmlToMSG = True And gRedemptionDllExists = False Then ' If gRunUnattended = False
        // Then ' if gRunUnattended = false then messagebox.show("ERROR ERROR - ProcessExchangeMail - It
        // appears the Redemption DLL is missing, this folder '" + HostNameIp + " :" + LibraryName + " : "
        // + UserLoginID + "' will not be processed.") ' End If ' log.WriteToArchiveLog("ERROR ERROR -
        // ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp + "
        // :" + LibraryName + " : " + UserLoginID + "' will not be processed.") ' GoTo NextBox 'End If

        // LoginPw = rsData.GetValue(2).ToString LoginPw = ENC.AES256DecryptString(LoginPw)

        // Try PortNbr = rsData.GetValue(3).ToString Catch ex As System.Exception PortNbr = "" End Try Try
        // Dim tDeleteAfterDownload = rsData.GetValue(4).ToString If tDeleteAfterDownload .Equals("False")
        // Then DeleteAfterDownload = False Else DeleteAfterDownload = True End If Catch ex As
        // System.Exception DeleteAfterDownload = False End Try Try RetentionCode =
        // rsData.GetValue(5).ToString Catch ex As System.Exception RetentionCode = "" End Try Try Dim
        // tSSL = rsData.GetValue(6).ToString If tSSL.Equals("False") Then SSL = False Else SSL = True End
        // If Catch ex As System.Exception SSL = False End Try Try Dim tIMap = rsData.GetValue(7).ToString
        // If tIMap .Equals("False") Then IMap = False Else IMap = True End If Catch ex As
        // System.Exception IMap = False End Try

        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 500 : " +
        // HostNameIp )

        // retentionYears = getRetentionPeriod(RetentionCode )

        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 500.1 : " +
        // retentionYears.ToString) If DeleteAfterDownload = False Then LeaveOnServer = True Else
        // LeaveOnServer = False End If

        // LOG.WriteToArchiveLog("Processing Exchange Box " + HostNameIp + " emails by " + UserLoginID)

        // frmExchangeMonitor.lblServer.Text = HostNameIp frmExchangeMonitor.lblMessageInfo.Text =
        // UserLoginID System.Windows.Forms.Application.DoEvents()

        // If SSL = True And IMap = False Then If PortNbr .Trim.Length = 0 Then PortNbr = "995" End If If
        // PortNbr .Equals("-1") Then PortNbr = "995" End If

        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 600 PortNbr : " + PortNbr )
        // LOG.WriteToArchiveLog("Processing Exchange SSL " + HostNameIp  + " emails by " + UserLoginID)
        // ReadEmailUsingSSL(HostNameIp , UserLoginID , LoginPw, _
        // PortNbr , LeaveOnServer, retentionYears, _
        // RetentionCode , LibraryName, isPublic, DaysToRetain, _
        // strReject , ConvertEmlToMSG)
        // ElseIf IMap = True And SSL = True Then
        // If PortNbr .Trim.Length = 0 Then
        // PortNbr  = "993"
        // End If
        // If PortNbr .Equals("-1") Then
        // PortNbr  = "993"
        // End If
        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 700 PortNbr : " + PortNbr )
        // LOG.WriteToArchiveLog("Processing Exchange IMAP " + HostNameIp  + " emails by " + UserLoginID)
        // getImapEmailSSL(HostNameIp , _
        // PortNbr , _
        // UserLoginID , LoginPw, LeaveOnServer, _
        // RetentionCode , retentionYears, _
        // LibraryName, isPublic, DaysToRetain, strReject , ConvertEmlToMSG)
        // ElseIf IMap = True And SSL = False Then
        // If PortNbr .Trim.Length = 0 Then
        // PortNbr  = "993"
        // End If
        // If PortNbr .Equals("-1") Then
        // PortNbr  = "993"
        // End If
        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 800 PortNbr : " + PortNbr )
        // LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL " + HostNameIp  + " emails by " + UserLoginID)
        // Me.getIMapEmail(HostNameIp , UserLoginID , LoginPw, _
        // LeaveOnServer, RetentionCode , retentionYears, _
        // LibraryName, isPublic, DaysToRetain, strReject , _
        // ConvertEmlToMSG)
        // Else
        // If PortNbr .Trim.Length = 0 Then
        // PortNbr  = "110"
        // End If
        // If PortNbr .Equals("-1") Then
        // PortNbr  = "110"
        // End If
        // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 900 PortNbr : " + PortNbr )
        // LOG.WriteToArchiveLog("Processing Exchange POP " + HostNameIp  + " emails by " + UserLoginID)
        // ReadEmailFromServer(HostNameIp , PortNbr , UserLoginID , LoginPw, _
        // LeaveOnServer, RetentionCode, retentionYears, _
        // LibraryName, isPublic, DaysToRetain, strReject , _
        // ConvertEmlToMSG)
        // End If
        // NextBox:
        // Loop
        // End If
        // rsData.Close()
        // rsData = Nothing
        // Catch ex As System.Exception
        // log.WriteToArchiveLog("ERROR 641.92.2 ProcessExchangePopMail - " + ex.Message)
        // End Try
        // LOG.WriteToArchiveLog("Exchange Archive completed @ " + Now.ToString)
        // frmExchangeMonitor.Dispose()
        // End Sub

        public string GetMailServerFromEmailAddr(string EmailAddr)
        {
            string ServerName = "";
            var mailman = new Chilkat.MailMan();
            mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            string fromAddr;
            fromAddr = EmailAddr;
            string mailServer;
            mailServer = mailman.MxLookup(fromAddr);
            if (mailServer is null)
            {
                ServerName = "";
            }
            else
            {
                ServerName = mailServer;
            }

            return ServerName;
        }

        public void DownloadExchangeEmail()
        {
            try
            {
                var mailman = new Chilkat.MailMan();
                string EmailFrom = "";
                string EmailSubject = "";
                string EmailBody = "";

                // Any string passed to UnlockComponent automatically begins a 30-day trial.
                bool success;
                success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
                if (success != true)
                {
                    if (modGlobals.gRunUnattended == false)
                        MessageBox.Show(mailman.LastErrorText);
                    return;
                }

                // Set our POP3 hostname, login and password
                mailman.MailHost = "mail.chilkatsoft.com";
                mailman.PopUsername = "login";
                mailman.PopPassword = "password";

                // Connecting via SSL is possible by adding these lines:
                // mailman.PopSsl = true;
                // Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
                // mailman.MailPort = 995;
                // Download email from the POP3 server by calling TransferMail
                Chilkat.EmailBundle bundle;

                // WARNING - TransferMail() Deletes all transfered mail from the server. bundle =
                // mailman.TransferMail() CopyMail() will leave it on the server
                bundle = mailman.CopyMail();
                if (bundle is null)
                {
                    MessageBox.Show(mailman.LastErrorText);
                    return;
                }

                int i;
                int n = bundle.MessageCount;
                var loopTo = n - 1;
                for (i = 0; i <= loopTo; i++)
                {
                    var email = bundle.GetEmail(i);
                    EmailFrom = email.From;
                    EmailSubject = email.Subject;
                    EmailBody = email.Body;
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 641.92.1 DownloadExchangeEmail - " + ex.Message);
            }
        }

        public void LoadEmGetAttachments(string FQN, string DownLoadDir)
        {
            // Load an EML file containing the MIME source of an email and save the attachments.
            string myEmaileml = FQN;
            var email = new Chilkat.Email();
            // email.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
            email.LoadEml(myEmaileml);
            email.SaveAllAttachments(DownLoadDir);
        }

        public void FixDate(ref string tStr)
        {
            string S = tStr.Trim();
            string CH = "";
            for (int i = 1, loopTo = S.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(S, i, 1);
                if (CH.Equals("/"))
                {
                    StringType.MidStmtStr(ref S, i, 1, ".");
                }
                else if (CH.Equals(":"))
                {
                    StringType.MidStmtStr(ref S, i, 1, ".");
                }
                else if (CH.Equals(" "))
                {
                    StringType.MidStmtStr(ref S, i, 1, ".");
                }
            }

            tStr = S;
        }

        public void RemoveBadChars(ref string tStr)
        {
            string S = tStr.Trim();
            string CH = "";
            int GoodChrCnt = 0;
            string GoodChars = "abcdefghijklmnopqrstuvwxyz1234567890@_";
            for (int i = 1, loopTo = S.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(S, i, 1);
                if (Strings.InStr(GoodChars, CH, CompareMethod.Text) > 0)
                {
                    GoodChrCnt += 1;
                }
                else
                {
                    StringType.MidStmtStr(ref S, i, 1, " ");
                }
            }

            tStr = S;
        }

        public void ReadEmailFromServer(string UID, string ServerName, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToRetain, string strReject, bool bEmlToMSG)
        {
            // ServerName  = "pop.dmachicago.com"
            // read mail from a POP3 server.
            var mailman = new Chilkat.MailMan();
            mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            string CurrMailFolder = ServerName + ":" + UserLoginID;
            int I = 0;
            int J = 0;
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ReadEmailFromServer 100");
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string EmailDir = TempDir + "Email";
            if (!Directory.Exists(EmailDir))
            {
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ReadEmailFromServer 100.1");
                Directory.CreateDirectory(EmailDir);
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ReadEmailFromServer 100.2");
            }

            if (!Directory.Exists(AttachmentDir))
            {
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ReadEmailFromServer 100.3");
                Directory.CreateDirectory(AttachmentDir);
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ReadEmailFromServer 100.4");
            }

            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ReadEmailFromServer 100.5");
            DMA.deleteDirectoryFiles(EmailDir);
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ReadEmailFromServer 100.6");
            DMA.deleteDirectoryFiles(AttachmentDir);
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ReadEmailFromServer 100.7");
            mailman.MailHost = ServerName;
            mailman.PopPassword = LoginPassWord;
            mailman.PopUsername = UserLoginID;
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ReadEmailFromServer 200");

            // ******************************************************************************************************
            LOG.WriteToArchiveLog("Applying POP Bundle by " + UserLoginID);
            bool SuccessfulRun = false;
            SuccessfulRun = ApplyEmailBundleV2(UID, mailman, ServerName, UserLoginID, LoginPassWord, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
            if (!SuccessfulRun)
            {
                ApplyEmailBundle(UID, mailman, ServerName, UserLoginID, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
            }
            // ******************************************************************************************************

            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ReadEmailFromServer 300 Ended ");
            DMA.deleteDirectoryFiles(EmailDir);
            DMA.deleteDirectoryFiles(AttachmentDir);
            GC.Collect();
            GC.WaitForFullGCComplete();
        }

        public void getDirectoryFiles(string DirFQN, ref List<string> DirFiles)
        {
            try
            {
                // DirFiles.Clear()
                string strFileSize = "";
                var di = new DirectoryInfo(DirFQN);
                var aryFi = di.GetFiles("*.*");
                foreach (var fi in aryFi)
                {
                    if (!DirFiles.Contains(fi.FullName))
                    {
                        DirFiles.Add(fi.FullName);
                    }
                }
            }
            catch (System.Exception ex)
            {
            }
        }

        public void SendHighPriorityEmail(string ServerName, string UserLoginID, string LoginPassWord)
        {
            var mailman = new Chilkat.MailMan();

            // Any string passed to UnlockComponent automatically begins a 30-day trial.
            bool success;
            success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            if (success != true)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(mailman.LastErrorText);
                return;
            }

            // Set the SMTP server.
            // mailman.SmtpHost = "smtp.earthlink.net"
            mailman.SmtpHost = ServerName;

            // Create a high-priority email.
            var email = new Chilkat.Email();

            // Set the basic email stuff: body, subject, "from", "to"
            email.Body = "This is the email body";
            email.Subject = "This is the email subject";
            email.AddTo("Chilkat Support", "support@chilkatsoft.com");
            email.From = "Programmer <programmer@chilkatsoft.com>";

            // You can add the X-Priority header field and give it the value string "1".
            // For example: email.AddHeaderField "X-Priority","1" This is the most common way of
            // setting the priority of an email. "3" is normal, and "5" is the lowest.
            // "2" and "4" are in-betweens, and frankly I've never seen anything
            // but "1" or "3" used. Microsoft Outlook adds these header fields when
            // setting a message to High priority:
            // X-Priority: 1 (Highest)
            // X-MSMail-Priority: High
            // Importance: High
            // This field alone is enough to make the email high-priority.
            email.AddHeaderField("X-Priority", "1");
            success = mailman.SendEmail(email);
            if (success)
            {
                LOG.WriteToArchiveLog("NOTICE: Sent high-priority email!");
            }
            else
            {
                LOG.WriteToArchiveLog("ERROR: " + mailman.LastErrorText);
            }
        }

        // Download email from a POP3 server, save and remove attachments, and save the email bundle
        // (without attachments) as XML.
        private void EmailCopyAndSave(string ServerName, string UserLoginID, string LoginPassWord)
        {
            try
            {
                string AttachmentDir = @"C:\temp\DownloadedEmails\Attachments";
                string EmailDir = @"C:\temp\DownloadedEmails";
                var mailman = new Chilkat.MailMan();
                mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
                mailman.MailHost = ServerName;
                mailman.PopUsername = UserLoginID;
                mailman.PopPassword = LoginPassWord;
                Chilkat.EmailBundle bundle;
                var bundle2 = new Chilkat.EmailBundle();
                bundle = mailman.CopyMail();
                if (bundle is object)
                {
                    long i;
                    Chilkat.Email email;
                    var loopTo = (long)(bundle.MessageCount - 1);
                    for (i = 0L; i <= loopTo; i++)
                    {
                        email = bundle.GetEmail((int)i);
                        email.SaveAllAttachments(AttachmentDir);
                        email.DropAttachments();
                        // Add the email (without attachments) to bundle2.
                        bundle2.AddEmail(email);
                    }
                }
                // Save the email bundle without attachments.
                bundle2.SaveXml("bundle.xml");
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR- clsEmailFuncitons:EmailCopyAndSave " + Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("ERROR- clsEmailFuncitons:EmailCopyAndSave " + Constants.vbCrLf + ex.StackTrace);
            }
        }

        public void ApplyEmailBundle(string UID, Chilkat.MailMan mailman, string ServerName, string UserLoginID, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
        {
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 100");
            int I = 0;
            int J = 0;
            // System.IO.Path.GetTempPath
            string TempDir = UTIL.getTempProcessingDir();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string EmailDir = TempDir + "Email";
            string CurrMailFolder = ServerName + ":" + UserLoginID;
            Chilkat.EmailBundle bundle;
            Chilkat.StringArray ArrayOfEntryID;
            ArrayOfEntryID = mailman.GetUidls();
            if (ArrayOfEntryID is null)
            {
                LOG.WriteToArchiveLog("Error 100.13.21 could not acquire email UID's.");
                return;
            }

            long n;
            n = ArrayOfEntryID.Count;
            Chilkat.Email email;
            string EntryID;
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 200");
            int iCount = mailman.GetMailboxCount();
            My.MyProject.Forms.frmMain.SB.Text = "Waiting for email download." + DateAndTime.Now.ToString();
            My.MyProject.Forms.frmExchangeMonitor.Show();
            // ********************************************************************

            My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = ServerName + " : " + UserLoginID;
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Downloading emails... standby.";
            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Waiting for email download." + DateAndTime.Now.ToString();
            My.MyProject.Forms.frmExchangeMonitor.Refresh();
            System.Windows.Forms.Application.DoEvents();
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 300");
            if (LeaveOnServer)
            {
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 300.1");
                LOG.WriteToArchiveLog("Applying Bundle Leave On Server Emails Count = " + iCount.ToString());
                bundle = mailman.CopyMail();
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 300.2");
            }
            else
            {
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 300.3");
                LOG.WriteToArchiveLog("Applying Bundle Remove from Server Emails Count = " + iCount.ToString());
                bundle = mailman.TransferMail();
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 300.4");
            }

            if (bundle is null)
            {
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 400");
                LOG.WriteToArchiveLog("Applying Bundle from Server NO Emails to process.");
                LOG.WriteToArchiveLog("NOTICE: Exchange Email Read 100.45.2 - " + ServerName + " : " + UserLoginID);
                LOG.WriteToArchiveLog(mailman.LastErrorText);
                if (modGlobals.gClipBoardActive == true)
                    Console.WriteLine(mailman.LastErrorText);
                My.MyProject.Forms.frmExchangeMonitor.Close();
                return;
            }

            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 500");
            My.MyProject.Forms.frmMain.SB.Text = "Download complete." + DateAndTime.Now.ToString();
            LOG.WriteToArchiveLog("Applying Bundle Message Count = " + bundle.MessageCount.ToString());
            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Applying Messages: #" + bundle.MessageCount.ToString();
            bool bEmailAlreadyExists = false;
            // For I = 0 To bundle.MessageCount - 1
            var loopTo = (int)(n - 1L);
            for (I = 0; I <= loopTo; I++)
            {
                EntryID = ArrayOfEntryID.GetString(I);
                email = mailman.FetchEmail(EntryID);
                if (email is null)
                {
                    LOG.WriteToArchiveLog("Processed Message Count = " + I.ToString());
                    break;
                }

                bEmailAlreadyExists = DBLocal.ExchangeExists(EntryID);
                if (bEmailAlreadyExists)
                {
                    DBLocal.MarkExchangeFound(EntryID);
                    goto NextRec;
                }

                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Downloading " + I.ToString();
                My.MyProject.Forms.frmExchangeMonitor.Refresh();
                System.Windows.Forms.Application.DoEvents();
                // frmReconMain.SB.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString + " of " + bundle.MessageCount.ToString

                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 600a: bundle.MessageCount " + bundle.MessageCount.ToString());
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 600b: " + I.ToString());
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = UserLoginID + " : Message# " + I + " of " + bundle.MessageCount.ToString();
                My.MyProject.Forms.frmExchangeMonitor.Refresh();
                System.Windows.Forms.Application.DoEvents();
                string NewGuid = Guid.NewGuid().ToString();

                // email = bundle.GetEmail(I)

                string Subject = email.Subject;
                string EmailFrom = email.From;
                string FromAddress = email.FromAddress;
                string FromName = email.FromName;
                string From = email.From;
                var CreateTime = email.EmailDate;
                if (strReject.Trim().Length > 0)
                {
                    var A = strReject.Split(',');
                    for (int II = 0, loopTo1 = Information.UBound(A); II <= loopTo1; II++)
                    {
                        string S1 = A[II].Trim();
                        if (S1.Trim().Length > 0)
                        {
                            if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                            {
                                LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject);
                                goto NextRec;
                            }
                        }
                    }
                }

                int NumDaysOld = email.NumDaysOld;
                if (NumDaysOld > DaysToHold)
                {
                    bool success = mailman.DeleteEmail(email);
                    if (success != true)
                    {
                        string Msg = "Subject: " + Subject + Constants.vbCrLf;
                        Msg += "FromName: " + FromName + Constants.vbCrLf;
                        Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                        LOG.WriteToArchiveLog("ERROR ApplyEmailBundle: Failed to delete email:" + Constants.vbCrLf + Msg);
                    }
                }

                int NumAlternatives = email.NumAlternatives;
                int NumAttachedMessages = email.NumAttachedMessages;
                int NumAttachments = email.NumAttachments;
                int NumBcc = email.NumBcc;
                int NumCC = email.NumCC;
                int NumTo = email.NumTo;
                string ReplyTo = email.ReplyTo;
                string SignedBy = email.SignedBy;
                int EmailSize = email.Size;
                string ReceivedDate = email.LocalDate.ToString();
                string GMT = email.EmailDate.ToString();
                string Header = email.Header;
                string EmailBody = email.Body;
                var Recipients = new ArrayList();
                var EmailTo = new ArrayList();
                var EmailToAddr = new ArrayList();
                var EmailToName = new ArrayList();
                var Bcc = new ArrayList();
                var BccAddr = new ArrayList();
                var BccName = new ArrayList();
                var CC = new ArrayList();
                var CcAddr = new ArrayList();
                var CcName = new ArrayList();
                bool bLoadAttachments = false;
                string tGMT = GMT.ToString();
                FixDate(ref tGMT);
                string tSubject = Strings.Mid(Subject, 1, 100);
                RemoveBadChars(ref tSubject);
                string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.FromAddress, Subject);
                string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 700: " + I.ToString());
                // Dim B As Boolean = ExchangeEmailExists(EmailIdentifier, EmailHashCode)
                bool B = ExchangeEmailExists(EmailIdentifier);
                if (B)
                {
                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToTraceLog("INFO: ApplyEmailBundle 700X email already exists in Repository: " + I.ToString());
                    goto NextRec;
                }

                string EmailFQN = TempDir + "EMAIL." + NewGuid + ".MSG";
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 800: " + I.ToString());
                if (NumAttachments > 0)
                {
                    // ** Clean out the directory
                    DMA.deleteDirectoryFiles(AttachmentDir);
                    // Save attachments to the "attachments" directory.
                    email.SaveAllAttachments(AttachmentDir);
                    bLoadAttachments = true;
                }

                int iLevel = 1;
                if (NumAttachedMessages > 0)
                {
                    // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                    for (int II = 0, loopTo2 = NumAttachedMessages - 1; II <= loopTo2; II++)
                    {
                        // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                        var objEmail = email.GetAttachedMessage(II);
                        // ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, iLevel)
                        ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                        objEmail = null;
                    }
                }

                var loopTo3 = NumCC - 1;
                for (J = 0; J <= loopTo3; J++)
                {
                    CC.Add(email.GetCC(J).ToString());
                    CcAddr.Add(email.GetCcAddr(J).ToString());
                    CcName.Add(email.GetCcName(J).ToString());
                    if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                    {
                        Recipients.Add(email.GetCcAddr(J).ToString());
                    }
                }

                var loopTo4 = NumBcc - 1;
                for (J = 0; J <= loopTo4; J++)
                {
                    Bcc.Add(email.GetBcc(J).ToString());
                    BccName.Add(email.GetBccName(J).ToString());
                    BccAddr.Add(email.GetBccAddr(J).ToString());
                    if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                    {
                        Recipients.Add(email.GetBccAddr(J).ToString());
                    }
                }

                var loopTo5 = NumTo - 1;
                for (J = 0; J <= loopTo5; J++)
                {
                    EmailTo.Add(email.GetTo(J).ToString());
                    EmailToAddr.Add(email.GetToAddr(J).ToString());
                    EmailToName.Add(email.GetToName(J).ToString());
                    if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                    {
                        Recipients.Add(email.GetToAddr(J).ToString());
                    }
                }

                // Save the email to XML
                // email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

                // Save the email to EML
                // Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 900.0: " + I.ToString());
                email.SaveEml(EmailFQN);

                // log.WriteToArchiveLog("Notice from ApplyEmailBundle 200 : FQN '" + EmailFQN  + "'")

                // **********************************************************
                // IF CONVERT TO MSG THEN
                // READ IN THE NEW EML
                // CONVERT IT TO MSG
                // WRITE OUT THE MSG
                // SAVE THE MSG IMAGE INTO THE REPOSITORY.
                if (bEmlToMSG == true)
                {
                    EmailFQN = convertEmlToMsg(EmailFQN);
                    if (EmailFQN.Trim().Length == 0)
                    {
                        LOG.WriteToArchiveLog("Unrecoverable Error: 100 ApplyEmailBundle - failed to convert EML to MSG File.");
                        LOG.WriteToArchiveLog("NOTE : 100 Most likely the Redemption DLL is not installed properly");
                        goto NextRec;
                    }
                    // log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'")
                }

                // **********************************************************

                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 900.1: " + I.ToString());
                var AttachedFiles = new List<string>();
                getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                string DB_ID = "ECM.Library";
                string Server_UserID_StoreID = CurrMailFolder;

                // ** Now, Load the EMAIL and its metadata into the repository
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 900.2: " + I.ToString());
                // log.WriteToArchiveLog("Notice from ApplyEmailBundle 400 : FQN '" + EmailFQN  + "'")
                bool AttachmentsLoaded = false;
                ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, Conversions.ToDate(ReceivedDate), UserLoginID, DateAndTime.Now, Conversions.ToDate(ReceivedDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                NextRec:
                ;
                if (LibraryName.Trim().Length > 0)
                {
                }

                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 1000: " + I.ToString());
            }

            ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, 99);
            string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + @"\WMCONVERT";
            ApplyPendingEmail(UID, ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode);
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Download complete.";
            My.MyProject.Forms.frmExchangeMonitor.Close();
        }

        public void ApplyIMapBundle(string UID, Chilkat.Imap imap, string ServerName, string UserLoginID, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
        {
            int ID = 33333;
            My.MyProject.Forms.frmExchangeMonitor.Show();
            My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = ServerName + " : " + UserLoginID;
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Downloading emails... standby.";
            My.MyProject.Forms.frmExchangeMonitor.Refresh();
            System.Windows.Forms.Application.DoEvents();
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 100");
            Chilkat.MessageSet messageSet;
            // We can choose to fetch UIDs or sequence numbers.
            bool fetchUids;
            fetchUids = true;
            // Get the message IDs of all the emails in the mailbox
            messageSet = imap.Search("ALL", fetchUids);
            if (messageSet is null)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(imap.LastErrorText);
                return;
            }

            int I = 0;
            int J = 0;
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string EmailDir = TempDir + "Email";
            string CurrMailFolder = ServerName + ":" + UserLoginID;
            Chilkat.EmailBundle bundle;
            bundle = imap.FetchBundle(messageSet);
            if (bundle is null)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(imap.LastErrorText);
                return;
            }

            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 200");
            int iCount = bundle.MessageCount;

            // ********************************************************************
            My.MyProject.Forms.frmExchangeMonitor.Show();
            My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = ServerName + " : " + UserLoginID;
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Processing emails... standby.";
            My.MyProject.Forms.frmExchangeMonitor.Refresh();
            System.Windows.Forms.Application.DoEvents();
            if (dDebug_clsEmailFunctions)
                LOG.WriteToTraceLog("ApplyEmailBundle 300");

            // If LeaveOnServer Then
            // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.1")
            // LOG.WriteToArchiveLog("Applying Bundle Leave On Server Emails Count = " + iCount.ToString)
            // bundle = MailMan.CopyMail
            // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.2")
            // Else
            // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.3")
            // LOG.WriteToArchiveLog("Applying Bundle Remove from Server Emails Count = " + iCount.ToString)
            // bundle = MailMan.TransferMail
            // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.4")
            // End If

            // If bundle Is Nothing Then
            // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 400")
            // LOG.WriteToArchiveLog("Applying Bundle from Server NO Emails to process.")
            // log.WriteToArchiveLog("NOTICE: Exchange Email Read 100.45.2 - " + ServerName  + " : " + UserLoginID )
            // log.WriteToArchiveLog(MailMan.LastErrorText)
            // If gClipBoardActive = True Then Console.WriteLine(MailMan.LastErrorText)
            // Return
            // End If
            // If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 500")

            // Dim DisplayMsg  = "Retrieving " + bundle.MessageCount.ToString + " emails."
            // frmHelp.MsgToDisplay  = DisplayMsg
            // frmHelp.CallingScreenName  = "ECM Exchange"
            // frmHelp.CaptionName  = "Exchange Archive"
            // frmHelp.Timer1.Interval = 10000
            // frmHelp.Show()
            LOG.WriteToArchiveLog("Applying IMAP Bundle Message Count = " + bundle.MessageCount.ToString());
            var loopTo = bundle.MessageCount - 1;
            for (I = 0; I <= loopTo; I++)
            {
                // frmExchangeMonitor.lblMessageInfo.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString
                // frmReconMain.SB.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString + " of " + bundle.MessageCount.ToString
                System.Windows.Forms.Application.DoEvents();
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 600a: bundle.MessageCount " + bundle.MessageCount.ToString());
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 600b: " + I.ToString());
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = UserLoginID + " : Message# " + I + " of " + bundle.MessageCount.ToString();
                My.MyProject.Forms.frmExchangeMonitor.Refresh();
                System.Windows.Forms.Application.DoEvents();
                string NewGuid = Guid.NewGuid().ToString();
                Chilkat.Email email;
                email = bundle.GetEmail(I);
                string EntryID = email.Uidl;
                string Subject = email.Subject;
                string EmailFrom = email.From;
                string FromAddress = email.FromAddress;
                string FromName = email.FromName;
                string From = email.From;
                if (strReject.Trim().Length > 0)
                {
                    var A = strReject.Split(',');
                    for (int II = 0, loopTo1 = Information.UBound(A); II <= loopTo1; II++)
                    {
                        string S1 = A[II].Trim();
                        if (S1.Trim().Length > 0)
                        {
                            if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                            {
                                LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject);
                                goto NextRec;
                            }
                        }
                    }
                }

                int NbrDaysOld = email.NumDaysOld;
                if (NbrDaysOld > DaysToHold)
                {
                    bool success = imap.SetMailFlag(email, "Deleted", 1);
                    if (success != true)
                    {
                        string Msg = "Subject: " + Subject + Constants.vbCrLf;
                        Msg += "FromName: " + FromName + Constants.vbCrLf;
                        Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                        LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                    }
                }

                int NumAlternatives = email.NumAlternatives;
                int NumAttachedMessages = email.NumAttachedMessages;
                int NumAttachments = email.NumAttachments;
                int NumBcc = email.NumBcc;
                int NumCC = email.NumCC;
                int NumTo = email.NumTo;
                string ReplyTo = email.ReplyTo;
                string SignedBy = email.SignedBy;
                int EmailSize = email.Size;
                string ReceivedDate = email.LocalDate.ToString();
                string GMT = email.EmailDate.ToString();
                string Header = email.Header;
                string EmailBody = email.Body;
                var Recipients = new ArrayList();
                var EmailTo = new ArrayList();
                var EmailToAddr = new ArrayList();
                var EmailToName = new ArrayList();
                var Bcc = new ArrayList();
                var BccAddr = new ArrayList();
                var BccName = new ArrayList();
                var CC = new ArrayList();
                var CcAddr = new ArrayList();
                var CcName = new ArrayList();
                bool bLoadAttachments = false;
                string tGMT = GMT.ToString();
                FixDate(ref tGMT);
                string tSubject = Strings.Mid(Subject, 1, 100);
                RemoveBadChars(ref tSubject);

                // Dim EmailIdentifier as string = EmailSize.ToString + "~" + tGMT  + "~" + FromAddress.Trim + "~" + tSubject  + "~" + gCurrLoginID

                string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.FromAddress, Subject);
                string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                bool B = ExchangeEmailExists(EmailIdentifier);
                if (B)
                {
                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToTraceLog("ApplyEmailBundle 700X already exists: " + I.ToString());
                    goto NextRec;
                }

                string EmailFQN = TempDir + "EMAIL." + NewGuid + ".MSG";
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 800: " + I.ToString());
                if (NumAttachments > 0)
                {
                    // ** Clean out the directory
                    DMA.deleteDirectoryFiles(AttachmentDir);
                    // Save attachments to the "attachments" directory.
                    email.SaveAllAttachments(AttachmentDir);
                    bLoadAttachments = true;
                }

                int iLevel = 1;
                if (NumAttachedMessages > 0)
                {
                    // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                    for (int II = 0, loopTo2 = NumAttachedMessages - 1; II <= loopTo2; II++)
                    {
                        // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                        var objEmail = email.GetAttachedMessage(II);
                        // ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, iLevel)
                        ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                        objEmail = null;
                    }
                }

                var loopTo3 = NumCC - 1;
                for (J = 0; J <= loopTo3; J++)
                {
                    CC.Add(email.GetCC(J).ToString());
                    CcAddr.Add(email.GetCcAddr(J).ToString());
                    CcName.Add(email.GetCcName(J).ToString());
                    if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                    {
                        Recipients.Add(email.GetCcAddr(J).ToString());
                    }
                }

                var loopTo4 = NumBcc - 1;
                for (J = 0; J <= loopTo4; J++)
                {
                    Bcc.Add(email.GetBcc(J).ToString());
                    BccName.Add(email.GetBccName(J).ToString());
                    BccAddr.Add(email.GetBccAddr(J).ToString());
                    if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                    {
                        Recipients.Add(email.GetBccAddr(J).ToString());
                    }
                }

                var loopTo5 = NumTo - 1;
                for (J = 0; J <= loopTo5; J++)
                {
                    EmailTo.Add(email.GetTo(J).ToString());
                    EmailToAddr.Add(email.GetToAddr(J).ToString());
                    EmailToName.Add(email.GetToName(J).ToString());
                    if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                    {
                        Recipients.Add(email.GetToAddr(J).ToString());
                    }
                }

                // Save the email to XML
                // email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

                // Save the email to EML
                // Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 900.0: " + I.ToString());
                email.SaveEml(EmailFQN);

                // log.WriteToArchiveLog("Notice from ApplyEmailBundle 200 : FQN '" + EmailFQN  + "'")

                // **********************************************************
                // IF CONVERT TO MSG THEN
                // READ IN THE NEW EML
                // CONVERT IT TO MSG
                // WRITE OUT THE MSG
                // SAVE THE MSG IMAGE INTO THE REPOSITORY.
                if (bEmlToMSG == true)
                {
                    EmailFQN = convertEmlToMsg(EmailFQN);
                    if (EmailFQN.Trim().Length == 0)
                    {
                        LOG.WriteToArchiveLog("Unrecoverable Error: 100 ApplyEmailBundle - failed to convert EML to MSG File.");
                        LOG.WriteToArchiveLog("NOTE : 100 Most likely the Redemption DLL is not installed properly");
                        goto NextRec;
                    }
                    // log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'")
                }

                // **********************************************************

                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 900.1: " + I.ToString());
                var AttachedFiles = new List<string>();
                getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                string DB_ID = "ECM.Library";
                string Server_UserID_StoreID = CurrMailFolder;

                // ** Now, Load the EMAIL and its metadata into the repository
                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 900.2: " + I.ToString());
                // log.WriteToArchiveLog("Notice from ApplyEmailBundle 400 : FQN '" + EmailFQN  + "'")
                bool AttachmentsLoaded = false;
                try
                {
                    ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, Conversions.ToDate(ReceivedDate), UserLoginID, DateAndTime.Now, Conversions.ToDate(ReceivedDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                }
                catch (System.Exception ex)
                {
                    imap.Expunge();
                    imap.Disconnect();
                    LOG.WriteToArchiveLog("ERROR ApplyIMapBundle 100 : " + ex.Message);
                }

                NextRec:
                ;
                if (LibraryName.Trim().Length > 0)
                {
                }

                if (dDebug_clsEmailFunctions)
                    LOG.WriteToTraceLog("ApplyEmailBundle 1000: " + I.ToString());
            }

            bundle = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, 99);
            string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + @"\WMCONVERT";
            ApplyPendingEmail(UID, ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode);
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Download complete.";
        }

        public bool ReadEmailUsingSSL(string UID, string ServerName, string UserLoginID, string LoginPassWord, int PortNbr, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToRetain, string strReject, bool bEmlToMSG)
        {
            // Create a mailman object for reading email.

            bool RC = false;
            LOG.WriteToArchiveLog("ReadEmailUsingSSL 1000");
            var mailman = new Chilkat.MailMan();
            string EmailFrom = "";
            string EmailSubject = "";
            string EmailBody = "";
            string EmailFromAddress = "";
            string EmailFromName = "";

            // Any string passed to UnlockComponent automatically begins a 30-day trial.
            bool success;
            success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            if (success != true)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(mailman.LastErrorText);
                return false;
            }

            // Set our POP3 hostname, login and password
            mailman.MailHost = ServerName;
            mailman.PopUsername = UserLoginID;
            mailman.PopPassword = LoginPassWord;

            // Indicate that the TCP/IP connection with the POP3 server should be SSL. All POP3
            // communications are secure using SSL.
            mailman.PopSsl = true;
            // Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
            // mailman.MailPort = 995
            mailman.MailPort = PortNbr;
            bool SuccessfulRun = false;
            SuccessfulRun = ApplyEmailBundleV2(UID, mailman, ServerName, UserLoginID, LoginPassWord, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
            if (!SuccessfulRun)
            {
                ApplyEmailBundle(UID, mailman, ServerName, UserLoginID, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
            }

            return default;
        }

        public void DownloadEmailAndForward(string MailHost, string PopUsername, string PopPassword, bool UseSameLogin, string SmtpHost, string SmtpUsername, string SmtpPassword, ref string ForwardToEmail, ref string ForwardToEmail2)
        {
            // Read email from a POP3 server and return the complete MIME source of each email. The emails
            // downloaded from the POP3 server are not loaded into Chilkat.Email objects, therefore they
            // are not parsed, unwrapped (for encrypted/signed email), or modified in any way.
            var mailman = new Chilkat.MailMan();
            mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            mailman.MailHost = MailHost;
            mailman.PopUsername = PopUsername;
            mailman.PopPassword = PopPassword;

            // We'll need the SMTP hostname and (optionally) the login to send email...
            if (UseSameLogin == true)
            {
                mailman.SmtpHost = SmtpHost;
                mailman.SmtpUsername = PopUsername;
                mailman.SmtpPassword = PopPassword;
            }
            else
            {
                mailman.SmtpHost = SmtpHost;
                mailman.SmtpUsername = SmtpUsername;
                mailman.SmtpPassword = SmtpPassword;
            }

            // Get the EntryIDs of all the mail messages on the POP3 server.
            Chilkat.StringArray allEntryIDs;
            allEntryIDs = mailman.GetUidls();

            // mimeArr is an object containing collection of strings
            Chilkat.StringArray mimeArr;
            // Download the entire mailbox. Call FetchMultipleMime to leave the email on the server. Call
            // TransferMultipleMime to download and remove from the server.
            mimeArr = mailman.TransferMultipleMime(allEntryIDs);
            // mimeArr = mailman.FetchMultipleMime(allEntryIDs)

            // Show how many emails were downloaded.
            MessageBox.Show(mimeArr.Count.ToString());

            // Forward each email to another recipient.
            int i;
            bool success;
            var loopTo = mimeArr.Count;
            for (i = 0; i <= loopTo; i++)
            {
                success = mailman.SendMime(ForwardToEmail, ForwardToEmail2, mimeArr.GetString(i));
                if (!success)
                {
                    MessageBox.Show(mailman.LastErrorText);
                    // ... do whatever else you want...
                }
            }
        }

        public void ReadXmlEmailData(string FQN)
        {
            try
            {
                var reader = new XmlTextReader(FQN);

                // message-id

                while (reader.Read())
                {
                    string AttrName = reader.Name;
                    if (modGlobals.gClipBoardActive == true)
                        Console.WriteLine("nbr elements: " + reader.AttributeCount.ToString());
                    if (modGlobals.gClipBoardActive == true)
                        Console.WriteLine("reader.GetAttribute: " + reader.GetAttribute("message-id").ToString());
                    if (reader.HasValue)
                    {
                        Console.WriteLine("Name: " + reader.Name);
                        Console.WriteLine("LocalName: " + reader.LocalName);
                        Console.WriteLine("SchemaAttribute.Name: " + reader.SchemaInfo.SchemaAttribute.Name.ToString());
                        Console.WriteLine("ReadAttributeValue : " + reader.ReadAttributeValue().ToString());
                        Console.WriteLine("ReadString : " + reader.ReadString());
                        Console.WriteLine("Value : " + reader.Value);
                        // Console.WriteLine(reader.GetAttribute(AttrName ))
                    }
                }
            }
            catch (System.Exception e)
            {
                Console.WriteLine("Exception: {0}", e.ToString());
            }
        }

        public void ReadXmlFileIntoDataSet(string FQN)
        {
            XmlReader xmlFile;
            xmlFile = XmlReader.Create(FQN, new XmlReaderSettings());
            var ds = new DataSet();
            ds.ReadXml(xmlFile);
            int K = ds.Tables[0].Rows.Count;
            int i = 0;
            var loopTo = ds.Tables[0].Rows.Count - 1;
            for (i = 0; i <= loopTo; i++)
                Console.WriteLine(ds.Tables[0].Rows[i][1]);
            ds.Dispose();
            ds = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        public void ReadXmlFile(string FQN)
        {
            XmlTextReader reader = null;
            try
            {
                // Load the reader with the XML file.
                reader = new XmlTextReader(FQN);

                // Read the ISBN attribute.
                reader.MoveToContent();
                string MessageID = reader.GetAttribute("message-id");
                Console.WriteLine("The MessageID value: " + MessageID);
            }
            finally
            {
                if (reader is object)
                {
                    reader.Close();
                }
            }
        }

        public void deleteFile(string FQN)
        {
            try
            {
                File.Delete(FQN);
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteFile - failed to delete file '" + FQN + "'.");
            }
        }

        public void getImapEmailSSL(string UID, string MailServerAddr, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG, bool UseSSL)
        {
            LOG.WriteToArchiveLog("getImapEmailSSL 100");
            int LL = 1;
            var imap = new Chilkat.Imap();
            int RejectedCount = 0;
            Chilkat.MessageSet messageSet;
            Chilkat.EmailBundle bundle;
            try
            {
                LL = 2;
                string ServerName = MailServerAddr + ":" + UserLoginID;
                LL = 3;
                LL = 4;
                LL = 5;
                bool success = false;
                LL = 6;
                string TempDir = Path.GetTempPath();
                LL = 7;
                string AttachmentDir = TempDir + @"Email\Attachment";
                LL = 8;
                string EmailDir = TempDir + "Email";
                LL = 9;
                string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
                LL = 10;
                LL = 11;
                int DownLoadSize = 0;
                LL = 12;
                string sDownLoadSize = "";
                LL = 13;
                int Increment = 0;
                LL = 14;
                int NbrDaysOld = 0;
                LL = 15;
                LL = 16;
                try
                {
                    LL = 17;
                    sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings["EmailDownLoadSize"];
                    LL = 18;
                    DownLoadSize = (int)Conversion.Val(sDownLoadSize);
                    LL = 19;
                }
                catch (System.Exception ex)
                {
                    DownLoadSize = 100;
                }

                LL = 22;
                LL = 23;
                if (DownLoadSize == 0)
                {
                    DownLoadSize = 2500;
                    LL = 25;
                }

                LL = 26;
                Increment = DownLoadSize;
                LL = 27;
                LL = 28;
                // Anything unlocks the component and begins a fully-functional 30-day trial.
                LL = 29;
                success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
                LL = 30;
                if (success != true)
                {
                    LL = 31;
                    MessageBox.Show(imap.LastErrorText);
                    LL = 32;
                    return;
                    LL = 33;
                }

                LL = 34;
                LL = 35;
                // To use a secure SSL connection, set SSL and the port:
                LL = 36;
                imap.Ssl = UseSSL;
                LL = 37;
                // The typical port for IMAP SSL is 993
                LL = 38;
                if (PortNbr.Length == 0)
                {
                    LL = 39;
                    imap.Port = 993;
                    LL = 40;
                }
                else
                {
                    LL = 41;
                    imap.Port = (int)Conversion.Val(PortNbr);
                    LL = 42;
                }

                LL = 43;
                LL = 44;
                // Connect to an IMAP server.
                LL = 45;
                success = imap.Connect(MailServerAddr);
                LL = 46;
                if (success != true)
                {
                    LL = 47;
                    LOG.WriteToArchiveLog("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText);
                    LL = 48;
                    return;
                }
                else
                {
                    LL = 49;
                    // 'frmExchangeMonitor.txtArchivedFiles.Text = "Login: " + UserLoginID  + " successful."
                    // 'frmExchangeMonitor.txtArchivedFiles.Refresh()
                    System.Windows.Forms.Application.DoEvents();
                }

                LOG.WriteToArchiveLog("getImapEmailSSL 200");
                LL = 53;
                success = imap.Login(UserLoginID, LoginPassWord);
                LL = 54;
                if (success != true)
                {
                    LL = 55;
                    LOG.WriteToArchiveLog("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText);
                    // 'frmExchangeMonitor.txtArchivedFiles.Text = "FAILED Login: " + UserLoginID  + " successful."
                    // 'frmExchangeMonitor.txtArchivedFiles.Refresh()
                    System.Windows.Forms.Application.DoEvents();
                    LL = 56;
                    return;
                }
                else
                {
                    LL = 57;
                    // 'frmExchangeMonitor.txtArchivedFiles.Text = "Login: " + UserLoginID  + " successful."
                    // 'frmExchangeMonitor.txtArchivedFiles.Refresh()
                    System.Windows.Forms.Application.DoEvents();
                }

                LL = 58;
                LOG.WriteToArchiveLog("getImapEmailSSL 300");
                success = imap.SelectMailbox("Inbox");
                LL = 62;
                if (success != true)
                {
                    LL = 63;
                    LOG.WriteToArchiveLog("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText);
                    LL = 64;
                    return;
                    LL = 65;
                }

                System.Windows.Forms.Application.DoEvents();
                int NumberOfMessagesInBox = imap.NumMessages;
                LL = 75;
                if (NumberOfMessagesInBox > 0)
                {
                    LL = 76;
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                    LL = 77;
                }
                else
                {
                    LL = 78;
                    LOG.WriteToArchiveLog("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                    LL = 79;
                    goto ENDIT;
                    LL = 80;
                }

                LL = 81;
                long startSeqNum;
                startSeqNum = 1L;
                long numToFetch;
                numToFetch = DownLoadSize;
                LL = 97;
                bool ExitUponCompletion = false;
                LL = 98;
                bool fetchUids = true;
                LL = 100;
                int NbrOfTries = 1;
                LL = 101;
                REDO:
                ;
                if (NbrOfTries >= 3)
                {
                    LL = 103;
                    goto ENDIT;
                    LL = 104;
                }

                LL = 105;
                if (numToFetch > NumberOfMessagesInBox)
                {
                    LL = 125;
                    numToFetch = NumberOfMessagesInBox;
                    LL = 126;
                }

                LL = 127;
                bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                LL = 128;
                // End If
                LL = 129;
                LOG.WriteToArchiveLog("getImapEmailSSL 400");
                if (bundle is null)
                {
                    LL = 132;
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400a: " + imap.LastErrorText);
                    LL = 133;
                    LOG.WriteToArchiveLog("        getImapEmailSSL 400b: startSeqNum - " + startSeqNum.ToString());
                    LL = 134;
                    LOG.WriteToArchiveLog("        getImapEmailSSL 400c: numToFetch - " + numToFetch.ToString());
                    LL = 135;
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400d: messages in mailbox: " + NumberOfMessagesInBox.ToString());
                    LL = 136;
                    NbrOfTries = NbrOfTries + 1;
                    LL = 137;
                    goto REDO;
                    LL = 138;
                }

                LL = 139;
                LOG.WriteToArchiveLog("getImapEmailSSL 500");
                LL = 160;
                LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL #emails = " + NumberOfMessagesInBox.ToString());
                LL = 161;
                System.Windows.Forms.Application.DoEvents();
                LL = 170;
                int MessagesProcessed = 0;
                LL = 171;
                int MessagesRemainingToProcess = NumberOfMessagesInBox;
                LL = 172;
                long i;
                LL = 174;
                TotalEmailsInArchive = 0;
                LL = 175;
                LOG.WriteToArchiveLog("getImapEmailSSL 600");
                while (MessagesRemainingToProcess > 0)
                {
                    LL = 176;
                    LOG.WriteToArchiveLog("getImapEmailSSL 700");
                    var loopTo = (long)(bundle.MessageCount - 1);
                    for (i = 0L; i <= loopTo; i++)
                    {
                        TotalEmailsInArchive += 1;
                        LL = 180;
                        MessagesRemainingToProcess = MessagesRemainingToProcess - 1;
                        LL = 183;
                        My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Msg: " + TotalEmailsInArchive.ToString();
                        My.MyProject.Forms.frmExchangeMonitor.Refresh();
                        My.MyProject.Forms.frmMain.tbExchange.Text = "Email# " + i.ToString();
                        System.Windows.Forms.Application.DoEvents();
                        LL = 185;
                        LL = 186;
                        string NewGuid = Guid.NewGuid().ToString();
                        LL = 188;
                        Chilkat.Email email;
                        LL = 189;
                        email = bundle.GetEmail((int)i);
                        LL = 190;
                        string EntryID = email.Uidl;
                        LL = 191;
                        string Subject = email.Subject;
                        Subject = UTIL.RemoveSingleQuotes(Subject);
                        LL = 192;
                        string EmailFrom = email.From;
                        LL = 193;
                        string FromAddress = email.FromAddress;
                        LL = 194;
                        string FromName = email.FromName;
                        LL = 195;
                        string From = email.From;
                        LL = 196;
                        LL = 197;
                        if (strReject.Trim().Length > 0)
                        {
                            LL = 198;
                            var A = strReject.Split(',');
                            LL = 199;
                            for (int II = 0, loopTo1 = Information.UBound(A); II <= loopTo1; II++)
                            {
                                LL = 200;
                                string S1 = A[II].Trim();
                                LL = 201;
                                if (S1.Trim().Length > 0)
                                {
                                    LL = 202;
                                    if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                    {
                                        LL = 203;
                                        // LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                        LL = 204;
                                        RejectedCount += 1;
                                        LL = 205;
                                        goto NextRec;
                                        LL = 206;
                                    }

                                    LL = 207;
                                }

                                LL = 208;
                            }

                            LL = 209;
                        }

                        LL = 210;
                        LL = 211;
                        NbrDaysOld = email.NumDaysOld;
                        LL = 212;
                        if (NbrDaysOld >= DaysToHold)
                        {
                            LL = 213;
                            success = imap.SetMailFlag(email, "Deleted", 1);
                            LL = 214;
                            if (success != true)
                            {
                                LL = 215;
                                string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                LL = 216;
                                Msg += "FromName: " + FromName + Constants.vbCrLf;
                                LL = 217;
                                Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                LL = 218;
                                LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                                LL = 219;
                            }

                            LL = 220;
                        }

                        LL = 221;
                        LL = 222;
                        int NumAlternatives = email.NumAlternatives;
                        LL = 223;
                        int NumAttachedMessages = email.NumAttachedMessages;
                        LL = 224;
                        int NumAttachments = email.NumAttachments;
                        LL = 225;
                        int NumBcc = email.NumBcc;
                        LL = 226;
                        int NumCC = email.NumCC;
                        LL = 227;
                        int NumTo = email.NumTo;
                        LL = 228;
                        string ReplyTo = email.ReplyTo;
                        LL = 229;
                        string SignedBy = email.SignedBy;
                        LL = 230;
                        int EmailSize = email.Size;
                        LL = 231;
                        string LocalDate = email.LocalDate.ToString();
                        LL = 232;
                        string EmailDate = email.EmailDate.ToString();
                        LL = 233;
                        string Header = email.Header;
                        LL = 234;
                        string EmailBody = email.Body;
                        LL = 235;
                        EmailBody = UTIL.RemoveSingleQuotes(EmailBody);
                        LL = 236;
                        LL = 237;
                        var Recipients = new ArrayList();
                        LL = 238;
                        var EmailTo = new ArrayList();
                        LL = 239;
                        var EmailToAddr = new ArrayList();
                        LL = 240;
                        var EmailToName = new ArrayList();
                        LL = 241;
                        var Bcc = new ArrayList();
                        LL = 242;
                        var BccAddr = new ArrayList();
                        LL = 243;
                        var BccName = new ArrayList();
                        LL = 244;
                        var CC = new ArrayList();
                        LL = 245;
                        var CcAddr = new ArrayList();
                        LL = 246;
                        var CcName = new ArrayList();
                        LL = 247;
                        bool bLoadAttachments = false;
                        LL = 248;
                        LL = 249;
                        int J = 0;
                        LL = 250;
                        LL = 251;
                        string tEmailDate = EmailDate.ToString();
                        LL = 252;
                        FixDate(ref tEmailDate);
                        LL = 253;
                        string tSubject = Strings.Mid(Subject, 1, 100);
                        LL = 254;
                        RemoveBadChars(ref tSubject);
                        LL = 255;
                        string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject);
                        string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                        bool bEmailExists = ExchangeEmailExists(EmailIdentifier);
                        LL = 260;
                        if (bEmailExists)
                        {
                            LL = 261;
                            LL = 262;
                            /// frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
                            LL = 263;
                            /// frmExchangeMonitor.lblMessageInfo.Refresh()
                            LL = 264;
                            System.Windows.Forms.Application.DoEvents();
                            LL = 265;
                            LL = 266;
                            int DaysOld = email.NumDaysOld;
                            LL = 267;
                            if (DaysOld > DaysToHold)
                            {
                                LL = 268;
                                success = imap.SetMailFlag(email, "Deleted", 1);
                                LL = 269;
                                if (success != true)
                                {
                                    LL = 270;
                                    string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                    LL = 271;
                                    Msg += "FromName: " + FromName + Constants.vbCrLf;
                                    LL = 272;
                                    Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                    LL = 273;
                                    LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                                    LL = 274;
                                }

                                LL = 275;
                            }

                            LL = 276;
                            LL = 277;
                            return;
                            LL = 278;
                        }

                        LL = 279;
                        LL = 280;
                        // Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
                        bool B = ExchangeEmailExists(EmailIdentifier);
                        LL = 282;
                        if (B)
                        {
                            LL = 283;
                            goto NextRec;
                            LL = 285;
                        }

                        LL = 286;
                        LL = 287;
                        string EmailFQN = EmailDir + @"\Email~" + NewGuid + "~.EML";
                        LL = 288;
                        LL = 289;
                        LL = 290;
                        if (NumAttachments > 0)
                        {
                            LL = 291;
                            // ** Clean out the directory
                            LL = 292;
                            UTIL.deleteDirectoryFile(AttachmentDir);
                            LL = 293;
                            // Save attachments to the "attachments" directory.
                            LL = 294;
                            email.SaveAllAttachments(AttachmentDir);
                            LL = 295;
                            bLoadAttachments = true;
                            LL = 296;
                        }

                        LL = 297;
                        LL = 298;
                        if (NumAttachedMessages > 0)
                        {
                            LL = 299;
                            // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                            LL = 300;
                            for (int II = 0, loopTo2 = NumAttachedMessages - 1; II <= loopTo2; II++)
                            {
                                LL = 301;
                                // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                                LL = 302;
                                var objEmail = email.GetAttachedMessage(II);
                                LL = 303;
                                ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                                LL = 304;
                                objEmail = null;
                                LL = 305;
                            }

                            LL = 306;
                        }

                        LL = 307;
                        LL = 308;
                        var loopTo3 = NumCC - 1;
                        for (J = 0; J <= loopTo3; J++)
                        {
                            LL = 309;
                            CC.Add(email.GetCC(J).ToString());
                            LL = 310;
                            CcAddr.Add(email.GetCcAddr(J).ToString());
                            LL = 311;
                            CcName.Add(email.GetCcName(J).ToString());
                            LL = 312;
                            if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                            {
                                LL = 313;
                                Recipients.Add(email.GetCcAddr(J).ToString());
                                LL = 314;
                            }

                            LL = 315;
                        }

                        LL = 316;
                        var loopTo4 = NumBcc - 1;
                        for (J = 0; J <= loopTo4; J++)
                        {
                            LL = 317;
                            Bcc.Add(email.GetBcc(J).ToString());
                            LL = 318;
                            BccName.Add(email.GetBccName(J).ToString());
                            LL = 319;
                            BccAddr.Add(email.GetBccAddr(J).ToString());
                            LL = 320;
                            if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                            {
                                LL = 321;
                                Recipients.Add(email.GetBccAddr(J).ToString());
                                LL = 322;
                            }

                            LL = 323;
                        }

                        LL = 324;
                        var loopTo5 = NumTo - 1;
                        for (J = 0; J <= loopTo5; J++)
                        {
                            LL = 325;
                            EmailTo.Add(email.GetTo(J).ToString());
                            LL = 326;
                            EmailToAddr.Add(email.GetToAddr(J).ToString());
                            LL = 327;
                            EmailToName.Add(email.GetToName(J).ToString());
                            LL = 328;
                            if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                            {
                                LL = 329;
                                Recipients.Add(email.GetToAddr(J).ToString());
                                LL = 330;
                            }

                            LL = 331;
                        }

                        LL = 332;
                        email.SaveEml(EmailFQN);
                        LL = 348;
                        if (bEmlToMSG == true)
                        {
                            LL = 349;
                            LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN '" + EmailFQN + "'");
                            LL = 350;
                            EmailFQN = convertEmlToMsg(EmailFQN);
                            LL = 351;
                        }

                        LL = 352;
                        // **********************************************************
                        var AttachedFiles = new List<string>();
                        LL = 357;
                        getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                        LL = 358;
                        LL = 359;
                        string DB_ID = "ECM.Library";
                        LL = 360;
                        string Server_UserID_StoreID = CurrMailFolder;
                        LL = 361;
                        LL = 362;
                        // ** Now, Load the EMAIL and its metadata into the repository
                        LL = 363;
                        bool AttachmentsLoaded = false;
                        LL = 366;
                        LOG.WriteToArchiveLog("getImapEmailSSL 800");
                        ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, Conversions.ToDate(EmailDate), UserLoginID, Conversions.ToDate(LocalDate), Conversions.ToDate(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                        LL = 389;
                        LOG.WriteToArchiveLog("getImapEmailSSL 900");
                        if (AttachmentsLoaded == true)
                        {
                            LL = 391;
                            bool DoThis = false;
                            LL = 392;
                            if (DoThis)
                            {
                                LL = 393;
                                if (AttachmentsLoaded == true)
                                {
                                    LL = 394;
                                    AppendOcrTextEmail(NewGuid);
                                    LL = 395;
                                    AttachmentsLoaded = false;
                                    LL = 396;
                                }

                                LL = 397;
                            }

                            LL = 398;
                        }

                        LL = 399;
                        LL = 400;
                        NextRec:
                        ;
                        LL = 401;
                    }

                    LL = 404;
                    // *****************************************************************************
                    LL = 405;
                    if (ExitUponCompletion == true)
                    {
                        LL = 406;
                        break;
                        LL = 407;
                    }

                    LL = 408;
                    if (DownLoadSize > MessagesRemainingToProcess)
                    {
                        LL = 409;
                        DownLoadSize = MessagesRemainingToProcess;
                        LL = 410;
                        // Increment = MessagesRemainingToProcess
                        LL = 411;
                        numToFetch = MessagesRemainingToProcess;
                        LL = 412;
                    }
                    else
                    {
                        LL = 413;
                        numToFetch = DownLoadSize;
                        LL = 414;
                    }

                    LL = 415;
                    startSeqNum = startSeqNum + Increment;
                    LL = 416;
                    LL = 417;
                    LL = 418;
                    if (numToFetch > 0L)
                    {
                        LL = 419;
                        bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                        LL = 420;
                        if (bundle is null)
                        {
                            LL = 421;
                            LOG.WriteToArchiveLog("Warning - termination - getImapEmailSSL 400: End of process.");
                            LL = 422;
                            break;
                            LL = 423;
                        }

                        LL = 424;
                    }

                    LL = 425;
                    LL = 426;
                }

                LL = 427;
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 100 getImapEmailSSL: LL = " + LL.ToString() + ": " + ex.Message);
            }

            ENDIT:
            ;
            imap.Expunge();
            LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString());

            // Disconnect from the IMAP server.
            imap.Disconnect();
            messageSet = null;
            imap = null;
            bundle = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();

            // LOG.WriteToArchiveLog("getImapEmailSSL 1000")

        }

        public void getIMapEmail(string UID, string MailServerAddr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToRetain, string strReject, bool bEmlToMSG)
        {
            LOG.WriteToArchiveLog("getIMapEmail 100");

            // Create an object, connect to the IMAP server, login, and select a mailbox.
            var imap = new Chilkat.Imap();
            imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
            imap.Connect(MailServerAddr);
            imap.Login(UserLoginID, LoginPassWord);
            imap.SelectMailbox("Inbox");
            int J = 0;
            LOG.WriteToArchiveLog("getIMapEmail 200");

            // Get a message set containing all the message IDs in the selected mailbox.
            Chilkat.MessageSet msgSet;
            msgSet = imap.Search("ALL", Conversions.ToBoolean(1));

            // Fetch all the mail into a bundle object.
            var bundle = new Chilkat.EmailBundle();
            try
            {
                bundle = imap.FetchBundle(msgSet);
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE: getIMapEmail 100 - " + ex.Message);
                return;
            }

            if (bundle is null)
            {
                LOG.WriteToArchiveLog("Applying IMAP Bundle - No messages at this time.");
                return;
            }

            LOG.WriteToArchiveLog("getIMapEmail 300");

            // Loop over the bundle and display the From and Subject.
            long i;
            int RecjectCount = 1;
            try
            {
                LOG.WriteToArchiveLog("Applying IMAP Bundle Message Count = " + bundle.MessageCount.ToString());
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("WARNING: Applying IMAP Bundle Message Count = UNKNOWN.");
            }

            My.MyProject.Forms.frmMain.SB.Text = "Processing Exchange servers: " + bundle.MessageCount;
            LOG.WriteToArchiveLog("getIMapEmail 400");
            var loopTo = (long)(bundle.MessageCount - 1);
            for (i = 0L; i <= loopTo; i++)
            {
                try
                {
                    string NewGuid = Guid.NewGuid().ToString();
                    Chilkat.Email email;
                    email = bundle.GetEmail((int)i);
                    string Subject = email.Subject;
                    string EmailFrom = email.From;
                    string FromAddress = email.FromAddress;
                    string FromName = email.FromName;
                    string From = email.From;
                    if (strReject.Trim().Length > 0)
                    {
                        var A = strReject.Split(',');
                        for (int II = 0, loopTo1 = Information.UBound(A); II <= loopTo1; II++)
                        {
                            string S1 = A[II].Trim();
                            if (S1.Trim().Length > 0)
                            {
                                if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                {
                                    RecjectCount += 1;
                                    goto NextRec;
                                }
                            }
                        }
                    }

                    int NbrDaysOld = email.NumDaysOld;
                    if (NbrDaysOld > DaysToRetain)
                    {
                        bool success = imap.SetMailFlag(email, "Deleted", 1);
                        if (success != true)
                        {
                            string Msg = "Subject: " + Subject + Constants.vbCrLf;
                            Msg += "FromName: " + FromName + Constants.vbCrLf;
                            Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                            LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                        }
                    }

                    int NumAlternatives = email.NumAlternatives;
                    int NumAttachedMessages = email.NumAttachedMessages;
                    int NumAttachments = email.NumAttachments;
                    int NumBcc = email.NumBcc;
                    int NumCC = email.NumCC;
                    int NumTo = email.NumTo;
                    string ReplyTo = email.ReplyTo;
                    string SignedBy = email.SignedBy;
                    int EmailSize = email.Size;
                    string LocalDate = email.LocalDate.ToString();
                    string EmailDate = email.EmailDate.ToString();
                    string Header = email.Header;
                    string EmailBody = email.Body;
                    var Recipients = new ArrayList();
                    var EmailTo = new ArrayList();
                    var EmailToAddr = new ArrayList();
                    var EmailToName = new ArrayList();
                    var Bcc = new ArrayList();
                    var BccAddr = new ArrayList();
                    var BccName = new ArrayList();
                    var CC = new ArrayList();
                    var CcAddr = new ArrayList();
                    var CcName = new ArrayList();
                    bool bLoadAttachments = false;
                    string TempDir = Path.GetTempPath();
                    string AttachmentDir = TempDir + @"Email\Attachment";
                    string EmailDir = TempDir + "Email";
                    string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
                    string tEmailDate = EmailDate.ToString();
                    FixDate(ref tEmailDate);
                    string tSubject = Strings.Mid(Subject, 1, 100);
                    RemoveBadChars(ref tSubject);
                    string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject);
                    string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                    bool B = ExchangeEmailExists(EmailIdentifier);
                    if (B)
                    {
                        if (dDebug_clsEmailFunctions)
                            LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + i.ToString());
                        goto NextRec;
                    }

                    string EmailFQN = TempDir + "EMAIL." + NewGuid + ".MSG";

                    // Console.WriteLine(Header)
                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToArchiveLog("ApplyIMapBundle 800: " + i.ToString());
                    if (NumAttachments > 0)
                    {
                        // ** Clean out the directory
                        DMA.deleteDirectoryFiles(AttachmentDir);
                        // Save attachments to the "attachments" directory.
                        email.SaveAllAttachments(AttachmentDir);
                        bLoadAttachments = true;
                    }

                    var loopTo2 = NumCC - 1;
                    for (J = 0; J <= loopTo2; J++)
                    {
                        CC.Add(email.GetCC(J).ToString());
                        CcAddr.Add(email.GetCcAddr(J).ToString());
                        CcName.Add(email.GetCcName(J).ToString());
                        if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetCcAddr(J).ToString());
                        }
                    }

                    var loopTo3 = NumBcc - 1;
                    for (J = 0; J <= loopTo3; J++)
                    {
                        Bcc.Add(email.GetBcc(J).ToString());
                        BccName.Add(email.GetBccName(J).ToString());
                        BccAddr.Add(email.GetBccAddr(J).ToString());
                        if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetBccAddr(J).ToString());
                        }
                    }

                    var loopTo4 = NumTo - 1;
                    for (J = 0; J <= loopTo4; J++)
                    {
                        EmailTo.Add(email.GetTo(J).ToString());
                        EmailToAddr.Add(email.GetToAddr(J).ToString());
                        EmailToName.Add(email.GetToName(J).ToString());
                        if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetToAddr(J).ToString());
                        }
                    }

                    // Save the email to XML
                    // email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

                    // Save the email to EML
                    // Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToArchiveLog("ApplyIMapBundle 900.0: " + i.ToString());
                    email.SaveEml(EmailFQN);

                    // **********************************************************
                    // IF CONVERT TO MSG THEN
                    // READ IN THE NEW EML
                    // CONVERT IT TO MSG
                    // WRITE OUT THE MSG
                    // SAVE THE MSG IMAGE INTO THE REPOSITORY.

                    if (bEmlToMSG == true)
                    {
                        try
                        {
                            EmailFQN = convertEmlToMsg(EmailFQN);
                            if (EmailFQN.Length == 0)
                            {
                                goto NextRec;
                            }
                        }
                        catch (System.Exception ex)
                        {
                            LOG.WriteToArchiveLog("ERROR getIMapEmail 300.20 : " + ex.Message);
                        }

                        if (EmailFQN.Trim().Length == 0)
                        {
                            LOG.WriteToArchiveLog("Unrecoverable Error: getImapEmail - failed to convert EML to MSG File.");
                            LOG.WriteToArchiveLog("NOTE : Most likely the Redemption DLL is not installed properly");
                            goto NextRec;
                        }
                    }

                    // **********************************************************

                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToArchiveLog("ApplyIMapBundle 900.1: " + i.ToString());
                    var AttachedFiles = new List<string>();
                    getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                    string DB_ID = "ECM.Library";
                    string Server_UserID_StoreID = CurrMailFolder;

                    // ** Now, Load the EMAIL and its metadata into the repository
                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + i.ToString());
                    bool AttachmentsLoaded = false;
                    ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, Conversions.ToDate(EmailDate), UserLoginID, DateAndTime.Now, Conversions.ToDate(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, email.Uidl, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                    NextRec:
                    ;
                    if (dDebug_clsEmailFunctions)
                        LOG.WriteToArchiveLog("ApplyIMapBundle 1000: " + i.ToString());
                }
                catch (System.Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR getIMapEmail 300.21 : " + ex.Message);
                }
            }

            // Save the email to an XML file
            // bundle.SaveXml("bundle.xml")

            LOG.WriteToArchiveLog("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString());

            // Disconnect from the IMAP server. This example leaves the email on the IMAP server.
            imap.Disconnect();
        }

        public void SendImapEmailGmail()
        {
            var mailman = new Chilkat.MailMan();

            // Any string argument automatically begins the 30-day trial.
            bool success;
            success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            if (success != true)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("Component unlock failed");
                return;
            }

            // Use the GMail SMTP server
            mailman.SmtpHost = "smtp.gmail.com";
            mailman.SmtpPort = 587;
            mailman.StartTLS = true;

            // Set the SMTP login/password.
            mailman.SmtpUsername = "wdalemiller";
            mailman.SmtpPassword = "Wdmsdm01";

            // Create a new email object
            var email = new Chilkat.Email();
            email.Subject = "This is a test";
            email.Body = "This is a test";
            // email.From = "wdalemiller@gmail.com"
            email.From = "support@EcmLibrary.com";
            email.AddTo("W. Dale Miller", "dale@EcmLibrary.com");
            email.AddTo("Dale Miller", "dale@javamasters.net");
            email.AddTo("D. Miller", "dm@dmachicago.com");
            success = mailman.SendEmail(email);
            if (success != true)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(mailman.LastErrorText);
                return;
            }

            if (modGlobals.gRunUnattended == false)
                MessageBox.Show("Mail Sent!");
        }

        public void readPst(string pstFilePath, string pstName, int StoreIndexNbr)
        {
            var mailItems = new LinkedList<string>();
            Microsoft.Office.Interop.Outlook.Application objOL;
            NameSpace objNS;
            MAPIFolder objFolder;
            objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
            objNS = objOL.GetNamespace("MAPI");

            // ** Add PST file (Outlook Data File) to Default Profile
            objNS.AddStore(pstFilePath);
            objFolder = objNS.Folders.GetLast();
            objFolder.Name = pstName;
            // ** Traverse through all folders in the PST file
            // ** TODO: This is not recursive, refactor
            var rootFolder = objNS.Stores[StoreIndexNbr].GetRootFolder();
            Folders subFolder;
            foreach (Folder Folder in rootFolder.Folders)
            {
                Console.WriteLine("rootFolder: " + rootFolder.Name);
                Console.WriteLine("rootFolder: " + rootFolder.EntryID);
                Console.WriteLine("Folder: " + Folder.Name);
                Console.WriteLine("Folder EntryID: " + Folder.EntryID);
                Console.WriteLine(Conversions.ToDouble("Folder Items.Count: ") + Folder.Items.Count);
                foreach (MailItem item in Folder.Items)
                    Console.WriteLine("Subject: " + item.Subject);
            }
        }

        public void SetNewStore(string strFileName, string strDisplayName)
        {
            Microsoft.Office.Interop.Outlook.Application objOL;
            NameSpace objNS;
            MAPIFolder objFolder;
            objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
            objNS = objOL.GetNamespace("MAPI");
            objNS.AddStore(strFileName);
            objFolder = objNS.Folders.GetLast();
            objFolder.Name = strDisplayName;
            objOL = null;
            objNS = null;
            objFolder = null;
        }

        public string convertEmlToMsg(string EmlFQN)
        {
            int LL = 0;
            if (File.Exists(EmlFQN + ".MSG"))
            {
                LOG.WriteToArchiveLog("NOTICE: convertEmlToMsg: '" + EmlFQN + "' already processed, skipping.");
                return "";
                File.Delete(EmlFQN + ".MSG");
            }

            File.Copy(EmlFQN, EmlFQN + ".MSG");
            LL = 1;
            string EmlToMsgFQN = EmlFQN + ".MSG";
            LL = 3;
            try
            {
                LL = 4;
                PostItem objPost;
                Redemption.SafePostItem objSafePost;
                NameSpace objNS;
                MAPIFolder objJunkMailBox;
                LL = 5;
                Microsoft.Office.Interop.Outlook.Application objOL;
                // Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
                LL = 6;
                objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
                objNS = objOL.GetNamespace("MAPI");
                LL = 7;
                objJunkMailBox = objNS.GetDefaultFolder(OlDefaultFolders.olFolderDeletedItems);
                objPost = (PostItem)objJunkMailBox.Items.Add(OlItemType.olPostItem);
                LL = 8;
                objSafePost = (Redemption.SafePostItem)Interaction.CreateObject("Redemption.SafePostItem");
                LL = 9;
                objPost.Save();
                LL = 10;
                objSafePost.Item = objPost;
                int iAttachCnt = objSafePost.Attachments.Count;
                for (int I = 0, loopTo = iAttachCnt - 1; I <= loopTo; I++)
                {
                    string SS = objSafePost.Attachments[I].FileName;
                    Console.WriteLine(SS);
                }

                // For i As Integer = 0 To 100
                // Console.WriteLine(objSafePost.Fields(0).ToString)
                // Next

                LL = 11;
                objSafePost.Import(EmlFQN, (int)Redemption.RedemptionSaveAsType.olRFC822);
                LL = 13;
                objSafePost.MessageClass = "IPM.Note";
                LL = 14;
                // remove IPM.Post icon
                objSafePost.set_Fields(PR_ICON_INDEX, "");
                LL = 15;
                objSafePost.SaveAs(EmlToMsgFQN, OlSaveAsType.olMSG);
                LL = 16;
                objSafePost = null;
                objPost = null;
                objJunkMailBox = null;
                objNS = null;
                LL = 17;
            }
            catch (System.Exception ex2)
            {
                LOG.WriteToArchiveLog("ERROR FATAL:convertEmlToMsg 100: LL = " + LL.ToString() + Constants.vbCrLf + ex2.Message + Constants.vbCrLf + ":" + EmlFQN + Constants.vbCrLf + ":" + EmlToMsgFQN);
                EmlToMsgFQN = "";
            }

            LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 200: LL = " + LL.ToString() + Constants.vbCrLf + ":" + EmlFQN + Constants.vbCrLf + ":'" + EmlToMsgFQN + "'.");
            if (File.Exists(EmlToMsgFQN))
            {
                LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 400: EXISTS.");
            }
            else
            {
                LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 400:DOES NOT EXIST.");
            }

            return EmlToMsgFQN;
        }

        public string ConvertNTEFtoMSG(string EmailGuid, string TnefFQN)
        {
            string ToNAme = TnefFQN;
            for (int i = ToNAme.Length; i >= 0; i -= 1)
            {
                if (Strings.Mid(ToNAme, i, 1).Equals("."))
                {
                    StringType.MidStmtStr(ref ToNAme, i, 1, "_");
                    break;
                }
            }

            int LL = 0;
            if (File.Exists(TnefFQN + ".MSG"))
            {
                File.Delete(TnefFQN + ".MSG");
            }

            // F.Copy(TnefFQN, ToNAme + ".MSG")
            LL = 1;
            LL = 2;
            string NtefToMSG = ToNAme + "~" + EmailGuid + ".MSG";
            LL = 3;
            if (File.Exists(NtefToMSG))
            {
                File.Delete(NtefToMSG);
            }

            // F.Copy(TnefFQN, ToNAme + ".MSG")
            LL = 1;
            F = null;
            try
            {
                LL = 4;
                PostItem objPost;
                Redemption.SafePostItem objSafePost;
                NameSpace objNS;
                MAPIFolder objJunkMailBox;
                LL = 5;
                Microsoft.Office.Interop.Outlook.Application objOL;
                // Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
                LL = 6;
                objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
                objNS = objOL.GetNamespace("MAPI");
                LL = 7;
                objJunkMailBox = objNS.GetDefaultFolder(OlDefaultFolders.olFolderDeletedItems);
                objPost = (PostItem)objJunkMailBox.Items.Add(OlItemType.olPostItem);
                LL = 8;
                objSafePost = (Redemption.SafePostItem)Interaction.CreateObject("Redemption.SafePostItem");
                LL = 9;
                objPost.Save();
                LL = 10;
                objSafePost.Item = objPost;
                LL = 11;
                objSafePost.Import(TnefFQN, (int)Redemption.RedemptionSaveAsType.olTNEF);
                LL = 13;
                objSafePost.MessageClass = "IPM.Note";
                LL = 14;
                // remove IPM.Post icon
                objSafePost.set_Fields(PR_ICON_INDEX, "");
                LL = 15;
                objSafePost.SaveAs(NtefToMSG, OlSaveAsType.olMSG);
                LL = 16;
                objSafePost = null;
                objPost = null;
                objJunkMailBox = null;
                objNS = null;
                LL = 17;
            }
            catch (System.Exception ex2)
            {
                LOG.WriteToArchiveLog("ERROR FATAL:ConvertNTEF 100: LL = " + LL.ToString() + Constants.vbCrLf + ex2.Message + Constants.vbCrLf + ":" + TnefFQN + Constants.vbCrLf + ":" + NtefToMSG);
                NtefToMSG = "";
            }

            LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 200: LL = " + LL.ToString() + Constants.vbCrLf + ":" + TnefFQN + Constants.vbCrLf + ":'" + NtefToMSG + "'.");
            if (File.Exists(NtefToMSG))
            {
                LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 400: EXISTS as " + NtefToMSG);
            }
            else
            {
                LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 400:DOES NOT EXIST.");
            }

            return NtefToMSG;
        }

        public bool LoadMsgFile(string UID, string MsgFQN, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode, string DefaultSubject, ref string Body, ref List<string> AttachedFiles, bool bWinMail, string ParentGuid, ref string EmailDescription)
        {

            // '* There is a primary assumption that NO .dat files will be processed in this module

            string TempDir = UTIL.getTempProcessingDir();
            string AttachmentDir = TempDir + @"\Email\Attachment";
            AttachmentDir = AttachmentDir.Replace(@"\\", @"\");
            string EmailDir = TempDir + @"\Email\";
            EmailDir = EmailDir.Replace(@"\\", @"\");
            if (!Directory.Exists(EmailDir))
            {
                Directory.CreateDirectory(EmailDir);
            }

            if (!Directory.Exists(AttachmentDir))
            {
                Directory.CreateDirectory(AttachmentDir);
            }

            bool deleteThisFile = false;
            string TempSubject = DefaultSubject;
            string TempBody = Body;
            string NewGuid = Guid.NewGuid().ToString();
            string Subject = null;
            var lCC = new ArrayList();
            var lBCC = new ArrayList();
            var lEmailToAddr = new ArrayList();
            var lRecipients = new ArrayList();
            string CurrMailFolderID_ServerName = null;
            string SenderEmailAddress = null;
            string SenderName = null;
            DateTime SentOn = default;
            string ReceivedByName = null;
            DateTime ReceivedTime = default;
            DateTime CreationTime = default;
            string DB_ID = null;
            string Server_UserID_StoreID = null;
            int RetentionYears = default;
            int EmailSize = default;
            string EmailIdentifier = null;
            string EmailFQN = null;
            bool isPublic = default;
            bool bEmlToMSG = default;
            Microsoft.Office.Interop.Outlook.Application OL;
            MailItem Msg;
            int bx = 0;
            int LL = 0;
            bool bProcessThisFile = true;
            bool bExists = true;
            try
            {
                LL = 1;
                OL = new Microsoft.Office.Interop.Outlook.Application();
                LL = 2;
                Msg = (MailItem)OL.CreateItemFromTemplate(MsgFQN);
                LL = 3;
                // now use msg to get at the email parts
                Attachments msgAttachments;
                LL = 4;
                msgAttachments = Msg.Attachments;
                LL = 5;
                string EntryID = Msg.EntryID;
                if (Msg.Attachments.Count > 0)
                {
                    foreach (Attachment Atmt in Msg.Attachments)
                    {
                        try
                        {
                            string filename = AttachmentDir + @"\" + Atmt.FileName;
                            filename = filename.Replace(@"\\", @"\");
                            Atmt.SaveAsFile(filename);
                            AttachedFiles.Add(filename);
                        }
                        catch (System.Exception ex)
                        {
                            LOG.WriteToArchiveLog("WARNING: Attachment not loaded in EMAIL : " + MsgFQN);
                        }
                    }
                }

                SenderName = Msg.SenderName;
                LL = 6;
                SenderEmailAddress = Msg.SenderEmailAddress;
                LL = 7;
                Recipients ReplyRecipients;
                LL = 8;
                ReplyRecipients = Msg.ReplyRecipients;
                LL = 9;
                string AllRecipientNames = "";
                string ReplyRecipientNames = Msg.ReplyRecipientNames;
                LL = 10;
                Recipients Recipients;
                LL = 11;
                Recipients = Msg.Recipients;
                if (Recipients is object)
                {
                    int II = 1;
                    var loopTo = Recipients.Count;
                    for (II = 1; II <= loopTo; II++)
                    {
                        lRecipients.Add(Recipients[II].Name);
                        lEmailToAddr.Add(Recipients[II].Name);
                        AllRecipientNames = AllRecipientNames + Recipients[II].Name + "; ";
                    }
                }

                ReceivedTime = Msg.ReceivedTime;
                LL = 16;
                ReceivedByName = Msg.ReceivedByName;
                LL = 17;
                CreationTime = Msg.CreationTime;
                LL = 18;
                if (Msg.CC is object)
                {
                    string strCC = Msg.CC;
                    LL = 19;
                    if (strCC.Length > 0)
                    {
                        LL = 20;
                        var A = strCC.Split(';');
                        LL = 21;
                        for (int i = 0, loopTo1 = Information.UBound(A); i <= loopTo1; i++)
                        {
                            LL = 22;
                            lCC.Add(A[i]);
                            LL = 23;
                        }

                        LL = 24;
                    }

                    LL = 25;
                }

                Body = Msg.Body + " :: " + TempBody;
                LL = 26;
                EmailDescription += Body;
                if (Msg.BCC is object)
                {
                    string strBCC = Msg.BCC;
                    LL = 27;
                    if (strBCC.Length > 0)
                    {
                        LL = 28;
                        var A = strBCC.Split(';');
                        LL = 29;
                        for (int i = 0, loopTo2 = Information.UBound(A); i <= loopTo2; i++)
                        {
                            LL = 30;
                            lBCC.Add(A[i]);
                            LL = 31;
                            ReceivedByName = ReceivedByName + "; ";
                            LL = 32;
                        }

                        LL = 33;
                    }

                    LL = 34;
                }

                SentOn = Msg.SentOn;
                LL = 35;
                Subject = Msg.Subject;
                LL = 36;
                EmailDescription += Subject;
                if (Subject is null & DefaultSubject.Length > 0)
                {
                    Subject = DefaultSubject;
                }
                else
                {
                    Subject += " :: " + DefaultSubject;
                }

                int MsgSize = Msg.Size;
                LL = 37;
                if (MsgSize == 0 & Body is object)
                {
                    MsgSize = Body.Length;
                }

                CurrMailFolderID_ServerName = ServerName;
                LL = 39;
                SenderEmailAddress = Msg.SenderEmailAddress;
                LL = 40;
                SenderName = Msg.SenderName;
                LL = 41;
                SentOn = Msg.SentOn;
                LL = 42;
                ReceivedTime = Msg.ReceivedTime;
                LL = 43;
                CreationTime = Msg.CreationTime;
                LL = 44;
                DB_ID = "ECM.Library";
                LL = 45;
                CurrMailFolder = CurrMailFolder;
                LL = 46;
                Server_UserID_StoreID = CurrMailFolder;
                LL = 47;
                RetentionYears = getRetentionPeriod(RetentionCode);
                LL = 48;
                EmailSize = MsgSize;
                LL = 49;
                if (EmailSize == 0)
                {
                    LL = 50;
                    try
                    {
                        EmailSize = Body.Length;
                        LL = 51;
                    }
                    catch (System.Exception ex)
                    {
                        Console.WriteLine("Notice 001sx1");
                        EmailSize = 0;
                    }
                }

                LL = 52;
                string GMT = Msg.SentOn.ToString();
                LL = 53;
                FixDate(ref GMT);
                LL = 54;
                string tSubject = Strings.Mid(Subject, 1, 100);
                LL = 55;
                RemoveBadChars(ref tSubject);
                LL = 56;
                if (EmailSize == 0)
                {
                    if (Body is object)
                    {
                        EmailSize = Body.Length;
                    }
                    else
                    {
                        EmailSize = tSubject.Length;
                    }
                }

                if (SenderEmailAddress is null)
                {
                    SenderEmailAddress = CurrMailFolder;
                }

                EmailIdentifier = UTIL.genEmailIdentifier(Msg.CreationTime, Msg.SenderEmailAddress, Subject);
                // Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                bExists = ExchangeEmailExists(EmailIdentifier);
                if (bExists)
                {
                    bProcessThisFile = false;
                    goto SKIPMSGFILE;
                }

                EmailFQN = MsgFQN;
                LL = 58;
                isPublic = false;
                LL = 59;
                bEmlToMSG = false;
                LL = 60;
                getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                LL = 61;
                for (int II = 0, loopTo3 = AttachedFiles.Count - 1; II <= loopTo3; II++)
                {
                    string sFqn = AttachedFiles[II];
                    string fExt = UTIL.getFileSuffix(sFqn);
                    if (fExt.ToUpper().Equals("MSG"))
                    {
                        string tPath = DMA.GetFilePath(sFqn);
                        string fName = DMA.getFileName(sFqn);
                        string NewDirName = UTIL.getTempProcessingDir() + @"\PendingEmail";
                        NewDirName = NewDirName.Replace(@"\\", @"\");
                        if (!Directory.Exists(NewDirName))
                        {
                            Directory.CreateDirectory(NewDirName);
                        }

                        string MoveFileName = NewDirName + @"\" + NewGuid.ToString() + "." + fName;
                        if (File.Exists(MoveFileName))
                        {
                            File.Delete(MoveFileName);
                        }

                        File.Move(sFqn, MoveFileName);
                        AttachedFiles[II] = "";
                    }
                }

                OL = null;
                LL = 62;
                Msg = null;
                LL = 63;
                if (CreationTime > DateAndTime.Now)
                {
                    CreationTime = DateAndTime.Now;
                }

                if (bWinMail == true)
                {
                    return true;
                }

                bx = DBARCH.iCount("Select count(*) from Email where EmailGuid = '" + ParentGuid + "'");
                // bx = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier) : LL = 64
                if (bx == 0)
                {
                    ArchiveMsgEmail(UID, NewGuid, Body, Subject, lCC, lBCC, lEmailToAddr, lRecipients, CurrMailFolderID_ServerName, SenderEmailAddress, SenderName, SentOn, ReceivedByName, ReceivedTime, CreationTime, DB_ID, CurrMailFolder, Server_UserID_StoreID, RetentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG);
                }

                SKIPMSGFILE:
                ;
                deleteThisFile = true;
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE: LoadMsgFile LL = " + LL.ToString() + Constants.vbCrLf + ex.Message);
                deleteThisFile = false;
            }
            finally
            {
                if (deleteThisFile == true)
                {
                    try
                    {
                        File.Delete(MsgFQN);
                    }
                    catch (System.Exception ex)
                    {
                        LOG.WriteToArchiveLog("Error: Could not remove MSG file : " + MsgFQN);
                    }
                }
            }

            if (bProcessThisFile == true)
            {
                if (NewGuid.Trim().Length > 0)
                {
                    Body = UTIL.ReplaceSingleQuotes(Body);
                    Subject = UTIL.ReplaceSingleQuotes(Subject);
                    SenderName = UTIL.ReplaceSingleQuotes(SenderName);
                    SenderEmailAddress = UTIL.ReplaceSingleQuotes(SenderEmailAddress);
                    string tMsg = " " + Conversions.ToString('þ') + Body + Conversions.ToString('þ') + Subject + Conversions.ToString('þ') + SenderName + Conversions.ToString('þ') + SenderEmailAddress;
                    concatEmailBody(tMsg, NewGuid);
                }
            }

            return Conversions.ToBoolean(bx);
        }

        public void ArchiveMsgEmail(string UID, string NewGuid, string Body, string Subject, ArrayList CC, ArrayList BCC, ArrayList EmailToAddr, ArrayList Recipients, string CurrMailFolderID_ServerName, string SenderEmailAddress, string SenderName, DateTime SentOn, string ReceivedByName, DateTime ReceivedTime, DateTime CreationTime, string DB_ID, string CurrMailFolder, string Server_UserID_StoreID, int RetentionYears, string RetentionCode, int EmailSize, List<string> AttachedFiles, string EntryID, string EmailIdentifier, string EmailFQN, string LibraryName, bool isPublic, bool bEmlToMSG)
        {
            var FI = new FileInfo(EmailFQN);
            string OriginalName = FI.Name;
            FI = null;
            if (CreationTime > DateAndTime.Now)
            {
                CreationTime = DateAndTime.Now;
            }

            string LastEmailArchRunDate = UserParmRetrive("LastEmailArchRunDate", modGlobals.gCurrUserGuidID);
            if (LastEmailArchRunDate.Trim().Length == 0)
            {
                LastEmailArchRunDate = "1/1/1950";
            }

            var rightNow = DateAndTime.Now;
            if (RetentionYears == 0)
            {
                RetentionYears = (int)Conversion.Val(getSystemParm("RETENTION YEARS"));
            }

            // ** Retain from entry time.
            rightNow = rightNow.AddYears(RetentionYears);
            string RetentionExpirationDate = rightNow.ToString();
            int EmailsSkipped = 0;
            bool DeleteMsg = false;
            var CurrDateTime = DateAndTime.Now;
            int ArchiveAge = 0;
            int RemoveAge = 0;
            int XDaysArchive = 0;
            int XDaysRemove = 0;
            // Dim EmailFQN = ""
            bool bRemoveAfterArchive = false;
            bool bMsgUnopened = false;
            string CurrMailFolderName = "";
            DateTime MinProcessDate = Conversions.ToDate("01/1/1910");
            string CurrName = CurrMailFolder;
            string ArchiveMsg = CurrName + ": ";
            string DB_ConnectionString = "";
            try
            {
                if (xDebug)
                    LOG.WriteToTraceLog("ArchiveExchangeEmails 200: ");
                SL.Clear();
                SL2.Clear();
                CurrMailFolderName = CurrMailFolder;
                // Loop each unread message.
                int i = 0;
                EMAIL.setStoreID(ref CurrMailFolder);
                System.Windows.Forms.Application.DoEvents();
                try
                {
                    string EmailGuid = NewGuid;
                    string OriginalFolder = CurrMailFolder;
                    string FNAME = CurrMailFolder;
                    string keyEmailIdentifier = NewGuid;
                    if (SentOn == default)
                    {
                        SentOn = DateTime.Parse("1899-01-01");
                    }

                    if (ReceivedTime == default)
                    {
                        ReceivedTime = DateTime.Parse("1899-01-01");
                    }

                    if (CreationTime == default)
                    {
                        CreationTime = DateTime.Parse("1970-01-01");
                    }

                    if (CreationTime < DateTime.Parse("1960-01-01"))
                    {
                        CreationTime = DateTime.Parse("1960-01-01");
                    }

                    // If frmReconMain.ckUseLastProcessDateAsCutoff.Checked Then
                    modGlobals.setLastEmailDate(CurrMailFolderName, CreationTime);
                    string SourceTypeCode = "MSG";
                    bool bAutoForwarded = false;
                    string BillingInformation = null;
                    string EmailBody = Body;
                    string BodyFormat = "";
                    string Categories = "";
                    string Companies = "";
                    string ConversationIndex = "";
                    string ConversationTopic = "";
                    DateTime DeferredDeliveryTime = default;
                    string DownloadState = "";
                    string HTMLBody = "";
                    string Importance = "";
                    bool IsMarkedAsTask = false;
                    var LastModificationTime = DateAndTime.Now;
                    string MessageClass = "";
                    string Mileage = "";
                    bool OriginatorDeliveryReportRequested = false;
                    string OutlookInternalVersion = "";
                    bool ReadReceiptRequested = false;
                    string ReceivedByEntryID = "";
                    if (ReceivedByName == null)
                    {
                        ReceivedByName = "Unknown";
                    }
                    else if (ReceivedByName.Length == 0)
                    {
                        ReceivedByName = "Unknown";
                    }

                    string ReceivedOnBehalfOfName = "";
                    int KK = 0;
                    string AllRecipients = "";
                    var loopTo = Recipients.Count - 1;
                    for (KK = 0; KK <= loopTo; KK++)
                    {
                        AllRecipients = Conversions.ToString(Operators.AddObject(AllRecipients + "; ", Recipients[KK]));
                        AddRecipToList(EmailGuid, Conversions.ToString(Recipients[KK]), "RECIP");
                    }

                    if (AllRecipients.Length > 0)
                    {
                        string ch = Strings.Mid(AllRecipients, 1, 1);
                        if (ch.Equals(";"))
                        {
                            StringType.MidStmtStr(ref AllRecipients, 1, 1, " ");
                            AllRecipients = AllRecipients.Trim();
                        }
                    }

                    bool ReminderSet = false;
                    DateTime ReminderTime = default;
                    object ReplyRecipientNames = null;
                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectNotEqual(ReplyRecipientNames, null, false)))
                    {
                        // For Each R In ReplyRecipientNames
                        if (xDebug)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog(Conversions.ToString(Operators.AddObject("ReplyRecipientNames: ", ReplyRecipientNames)));
                        }
                        // Next
                    }

                    string SenderEmailType = "";
                    string Sensitivity = "";
                    string SentOnBehalfOfName = "";
                    ArchiveMsg = ArchiveMsg + " : " + Subject;
                    DateTime TaskCompletedDate = default;
                    var TaskDueDate = DateAndTime.Now;
                    string TaskSubject = "";
                    string VotingOptions = "";
                    string VotingResponse = "";
                    object UserProperties = null;
                    string Accounts = "None Supplied";
                    string NewTime = ReceivedTime.ToString().Replace("//", ".");
                    NewTime = ReceivedTime.ToString().Replace("/:", ".");
                    NewTime = ReceivedTime.ToString().Replace(" ", "_");
                    string NewSubject = Strings.Mid(Subject, 1, 200);
                    NewSubject = NewSubject.Replace(" ", "_");
                    ConvertName(ref NewSubject);
                    ConvertName(ref NewTime);
                    bool bExcluded = modGlobals.isExcludedEmail(SenderEmailAddress);
                    if (bExcluded)
                    {
                        goto LabelSkipThisEmail;
                    }

                    if (SenderEmailAddress.Length == 0 | SenderEmailAddress == null)
                    {
                        SenderEmailAddress = "Unknown";
                    }

                    if (SentOn == default)
                    {
                        SentOn = DateTime.Parse("1900-01-01");
                    }

                    if (SenderName.Length == 0 | SenderName == null)
                    {
                        SenderName = "Unknown";
                    }

                    if (xDebug)
                        LOG.WriteToTraceLog("ArchiveExchangeEmails 200: ");

                    // ***** Prepare to use the EMAIL IDENTIFIER HERE at a later time *******
                    int IX = DBARCH.iCount("Select count(*) from Email where emailguid = '" + NewGuid + "' ");
                    // Dim bExists As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
                    if (IX > 0)
                    {
                        goto LabelSkipThisEmail;
                    }

                    AllRecipients += ";" + ReceivedByName;
                    System.Windows.Forms.Application.DoEvents();
                    EMAIL.setEmailIdentifier(ref EmailIdentifier);
                    EMAIL.setEntryid(ref EntryID);
                    EMAIL.setEmailguid(ref EmailGuid);
                    if (BCC.Count > 0)
                    {
                        foreach (string sBcc in BCC)
                            AllRecipients = AllRecipients + "; " + sBcc;
                    }

                    if (CC.Count > 0)
                    {
                        foreach (string sBcc in CC)
                            AllRecipients = AllRecipients + "; " + sBcc;
                    }

                    string AllBcc = "";
                    foreach (string sBcc in BCC)
                        AllBcc = AllBcc + "; " + sBcc;
                    string AllCC = "";
                    foreach (string sBcc in CC)
                        AllCC = AllCC + "; " + sBcc;
                    EMAIL.setAllrecipients(ref AllRecipients);
                    EMAIL.setBcc(ref AllBcc);
                    EMAIL.setBillinginformation(ref BillingInformation);
                    string argval = UTIL.RemoveSingleQuotesV1(EmailBody);
                    EMAIL.setBody(ref argval);
                    EMAIL.setCc(ref AllCC);
                    EMAIL.setCompanies(ref Companies);
                    string argval1 = Conversions.ToString(CreationTime);
                    EMAIL.setCreationtime(ref argval1);
                    EMAIL.setCurrentuser(ref modGlobals.gCurrUserGuidID);
                    string argval2 = Conversions.ToString(DeferredDeliveryTime);
                    EMAIL.setDeferreddeliverytime(ref argval2);
                    string argval3 = Conversions.ToString(DeferredDeliveryTime);
                    EMAIL.setDeferreddeliverytime(ref argval3);
                    EMAIL.setEmailguid(ref EmailGuid);
                    // EMAIL.setEmailimage()

                    EMAIL.setExpirytime(ref RetentionExpirationDate);
                    string argval4 = Conversions.ToString(LastModificationTime);
                    EMAIL.setLastmodificationtime(ref argval4);
                    EMAIL.setMsgsize(ref EmailSize.ToString());
                    EMAIL.setReadreceiptrequested(ref OriginatorDeliveryReportRequested.ToString());
                    EMAIL.setReceivedbyname(ref ReceivedByName);
                    string argval5 = Conversions.ToString(ReceivedTime);
                    EMAIL.setReceivedtime(ref argval5);
                    SenderEmailAddress = Strings.Mid(SenderEmailAddress, 1, 79);
                    EMAIL.setSenderemailaddress(ref SenderEmailAddress);
                    SenderName = Strings.Mid(SenderName, 1, 79);
                    EMAIL.setSendername(ref SenderName);
                    EMAIL.setSensitivity(ref Sensitivity);
                    string argval6 = Conversions.ToString(SentOn);
                    EMAIL.setSenton(ref argval6);
                    string argval7 = "MSG";
                    EMAIL.setSourcetypecode(ref argval7);
                    EMAIL.setOriginalfolder(ref OriginalFolder);
                    string SentTo = "";
                    if (Recipients.Count > 0)
                    {
                        for (int iI = 0, loopTo1 = Recipients.Count - 1; iI <= loopTo1; iI++)
                            SentTo = Conversions.ToString(SentTo + Operators.AddObject(Recipients[iI], ";"));
                    }

                    EMAIL.setSentto(ref ReceivedByName);
                    string argval8 = UTIL.RemoveSingleQuotesV1(Subject);
                    EMAIL.setSubject(ref argval8);
                    string ShortSubj = Strings.Mid(Subject, 1, 240);
                    string argval9 = UTIL.RemoveSingleQuotesV1(ShortSubj);
                    EMAIL.setShortsubj(ref argval9);
                    bool MailAdded = false;
                    bool BB = false;
                    System.Windows.Forms.Application.DoEvents();
                    if (xDebug)
                        LOG.WriteToTraceLog("ArchiveExchangeEmails 300: ");

                    // Dim bx As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
                    IX = DBARCH.iCount("Select count(*) from Email where emailguid = '" + NewGuid + "' ");
                    if (IX == 0)
                    {
                        // *****  ***********************************************
                        // Convert to MSG and store the image as a MSG file
                        string StrHashTemp = ENC.getSha1HashKey(EmailIdentifier);
                        BB = EMAIL.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, StrHashTemp, CurrMailFolder);
                        // *****  ***********************************************

                        if (BB)
                        {

                            // EmailsBackedUp += 1
                            // frmExchangeMonitor.lblCnt.Text = EmailsBackedUp.ToString

                            // **********************************************************************************************
                            // ** Call Filestream service or standard service here
                            bool bMail = UpdateEmailMsg(OriginalName, 2222.1, UID, EmailFQN, EmailGuid, RetentionCode, Conversions.ToString(isPublic), StrHashTemp, "NA");
                            // **********************************************************************************************
                            if (bMail == false)
                            {
                                // ** It failed to add an MSG - try saving it as an EML
                                string fExt = UTIL.getFileSuffix(EmailFQN);
                                if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                {
                                    string TempFQN = "";
                                    bool BBX = false;
                                    if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                    {
                                        EmailFQN = Strings.Mid(EmailFQN, 1, Strings.InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1);
                                        // **********************************************************************************************
                                        // ** Call Filestream service or standard service here
                                        BBX = UpdateEmailMsg(OriginalName, 2222.2, UID, EmailFQN, EmailGuid, RetentionCode, Conversions.ToString(isPublic), StrHashTemp, "NA");
                                        // **********************************************************************************************
                                        if (BBX == true)
                                        {
                                            string argval10 = "EML";
                                            EMAIL.setSourcetypecode(ref argval10);
                                        }
                                        else
                                        {
                                            // ** It failed again, SKIP IT.
                                            LOG.WriteToArchiveLog("ERROR 299c: Failed to add email" + EmailFQN);
                                            goto LabelSkipThisEmail;
                                        }
                                    }
                                }
                            }
                            // EmailIdentifier
                            // **WDM Removed below 3/11/2010

                            string sSql = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'";
                            bool bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx");
                            }

                            // LibraryName , ByVal isPublic As Boolean
                            if (LibraryName.Trim().Length > 0)
                            {
                                string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
                                string S = "";
                                var LI = new clsLIBRARYITEMS();
                                int iCnt = LI.cnt_UniqueEntry(LibraryName, EmailGuid);
                                if (iCnt == 0)
                                {
                                    LI.setSourceguid(ref EmailGuid);
                                    string argval11 = Strings.Mid(Subject, 1, 200);
                                    LI.setItemtitle(ref argval11);
                                    LI.setItemtype(ref SourceTypeCode);
                                    LI.setLibraryitemguid(ref Guid.NewGuid().ToString());
                                    LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                                    LI.setLibraryowneruserid(ref LibraryOwnerUserID);
                                    LI.setLibraryname(ref LibraryName);
                                    LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
                                    bool b = LI.Insert();
                                    if (b == false)
                                    {
                                        LOG.WriteToArchiveLog("ERROR: 198.171.76 - Filed to add Email Library Item: " + LibraryName + " : + " + Subject);
                                    }
                                }

                                LI = null;
                                GC.Collect();
                            }

                            if (bEmlToMSG == true)
                            {
                                sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'";
                                bbExec = ExecuteSqlNewConn(sSql, false);
                                if (!bbExec)
                                {
                                    LOG.WriteToArchiveLog("ERROR: 1234.99zx1");
                                }
                            }

                            if (isPublic == true)
                            {
                                sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'";
                            }
                            else
                            {
                                sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'";
                            }

                            bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx2");
                            }

                            sSql = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID_ServerName + "' where EmailGuid = '" + EmailGuid + "'";
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99a");
                            }

                            string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                            sSql = "Update EMAIL set CRC = '" + EmailHashCode + "' where EmailGuid = '" + EmailGuid + "'";
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99b");
                            }

                            // RetentionExpirationDate
                            sSql = "Update EMAIL set RetentionExpirationDate = '" + RetentionExpirationDate + "' where EmailGuid = '" + EmailGuid + "'";
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99c");
                            }

                            sSql = "Update EMAIL set RetentionCode = '" + RetentionCode + "' where EmailGuid = '" + EmailGuid + "'";
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99c");
                            }

                            setRetentionDate(EmailGuid, RetentionCode, ".EML");
                            if (xDebug)
                                LOG.WriteToTraceLog("ArchiveExchangeEmails 500: ");
                            MailAdded = true;
                        }
                        else
                        {
                            if (xDebug)
                                LOG.WriteToTraceLog("ArchiveExchangeEmails 600: ");
                            // **WDM Removed below 3/11/2010

                            string sSql = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'";
                            bool bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx12");
                            }

                            if (bEmlToMSG == true)
                            {
                                sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'";
                                bbExec = ExecuteSqlNewConn(sSql, false);
                            }

                            if (LibraryName.Trim().Length > 0)
                            {
                                string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
                                string S = "";
                                var LI = new clsLIBRARYITEMS();
                                int iCnt = LI.cnt_UniqueEntry(LibraryName, EmailGuid);
                                if (iCnt == 0)
                                {
                                    LI.setSourceguid(ref EmailGuid);
                                    string argval12 = Strings.Mid(Subject, 1, 200);
                                    LI.setItemtitle(ref argval12);
                                    LI.setItemtype(ref SourceTypeCode);
                                    LI.setLibraryitemguid(ref Guid.NewGuid().ToString());
                                    LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                                    LI.setLibraryowneruserid(ref LibraryOwnerUserID);
                                    LI.setLibraryname(ref LibraryName);
                                    LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
                                    bool b = LI.Insert();
                                    if (b == false)
                                    {
                                        LOG.WriteToArchiveLog("ERROR: 198.171.76 - Filed to add Email Library Item: " + LibraryName + " : + " + Subject);
                                    }
                                }

                                LI = null;
                                GC.Collect();
                            }

                            if (isPublic == true)
                            {
                                sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'";
                            }
                            else
                            {
                                sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'";
                            }

                            bbExec = ExecuteSqlNewConn(sSql, false);
                            if (!bbExec)
                            {
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx6");
                            }

                            if (xDebug)
                                LOG.WriteToArchiveLog("Error 0743.23 - failed to archive email.");
                            MailAdded = false;
                            if (xDebug)
                                LOG.WriteToTraceLog("ArchiveExchangeEmails 700: ");
                        }
                    }
                    else
                    {
                        if (xDebug)
                            LOG.WriteToTraceLog("ArchiveExchangeEmails 800: ");
                        BB = true;
                        MailAdded = false;
                    }

                    if (BB)
                    {
                        // BB = UpdateEmailMsg(EmailFQN, EmailGuid )
                        try
                        {
                            FileSystem.Kill(EmailFQN);
                            if (xDebug)
                                LOG.WriteToTraceLog("ArchiveExchangeEmails 900: ");
                        }
                        catch (System.Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                            if (xDebug)
                                LOG.WriteToTraceLog("ArchiveExchangeEmails 1000: ");
                        }

                        DeleteMsg = true;
                    }
                    else
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("Error 623.45 - Failed to archive email: " + Subject);
                        MailAdded = false;
                        if (xDebug)
                            LOG.WriteToTraceLog("ArchiveExchangeEmails 2000: ");
                        goto LabelSkipThisEmail;
                    }

                    System.Windows.Forms.Application.DoEvents();
                    if (MailAdded)
                    {
                        if (xDebug)
                            LOG.WriteToTraceLog("ArchiveExchangeEmails 3000: ");
                        SL2.Clear();
                        if (AllCC is object)
                        {
                            if (AllCC.Trim().Length > 0)
                            {
                                var A = new string[1];
                                if (Strings.InStr(1, AllCC, ";") > 0)
                                {
                                    A = Strings.Split(AllCC, ";");
                                }
                                else
                                {
                                    A[0] = AllCC;
                                }

                                var loopTo2 = Information.UBound(A);
                                for (KK = 0; KK <= loopTo2; KK++)
                                {
                                    string SKEY = A[KK];
                                    if (SKEY is object)
                                    {
                                        bool BXX = SL.ContainsKey(SKEY);
                                        if (!BXX)
                                        {
                                            SL2.Add(SKEY, "CC");
                                        }
                                    }
                                }
                            }
                        }

                        if (AllBcc is object)
                        {
                            if (AllBcc.Trim().Length > 0)
                            {
                                var A = new string[1];
                                if (Strings.InStr(1, AllBcc, ";") > 0)
                                {
                                    A = Strings.Split(AllBcc, ";");
                                }
                                else
                                {
                                    A[0] = AllBcc;
                                }

                                var loopTo3 = Information.UBound(A);
                                for (KK = 0; KK <= loopTo3; KK++)
                                {
                                    string SKEY = A[KK];
                                    if (SKEY is object)
                                    {
                                        bool BXX = SL.ContainsKey(SKEY);
                                        if (!BXX)
                                        {
                                            SL2.Add(SKEY, "allbcc");
                                        }
                                    }
                                }
                            }
                        }

                        // For KK = 0 To Recipients.Count - 1
                        foreach (string tAddr in Recipients)
                        {
                            // Dim Addr  = Recipients.Item(i)
                            string Addr = tAddr;
                            RECIPS.setEmailguid(ref EmailGuid);
                            RECIPS.setRecipient(ref Addr);
                            bool BXX = SL2.ContainsKey(Addr);
                            if (!BXX)
                            {
                                string argval13 = "RECIP";
                                RECIPS.setTyperecp(ref argval13);
                            }
                            else
                            {
                                int iKey = SL2.IndexOfKey(Addr);
                                string TypeCC = "";
                                TypeCC = SL2[Addr].ToString();
                                RECIPS.setTyperecp(ref TypeCC);
                            }

                            RECIPS.Insert();
                        }

                        bool bWinMail = false;
                        START_WINMAIL_PROCESS:
                        ;
                        if (AttachedFiles.Count > 0)
                        {
                            if (xDebug)
                                LOG.WriteToTraceLog("ArchiveExchangeEmails 4000: ");
                            foreach (string FileName in AttachedFiles)
                            {
                                // Dim TempDir  = System.IO.Path.GetTempPath
                                // FileName  = AttachedFiles.Item(II)

                                if (FileName.Length == 0)
                                {
                                    goto SkipThisOne;
                                }

                                string FileExt = "." + UTIL.getFileSuffix(FileName);
                                string fExt2 = DMA.getFileExtension(FileName);
                                if (fExt2.Length == 0 & Strings.InStr(FileName, "UNKNOWN", CompareMethod.Text) > 0)
                                {
                                    // ***********************************************************
                                    LOG.WriteToArchiveLog("ISSUE/WARNING: An email was sent from Outlook as an RTF formatted attachment - could not be converted '" + FileName + "'.");
                                    var EMX = new clsEmailFunctions();
                                    string FileNameConverted = EMX.ConvertNTEFtoMSG(NewGuid, FileName);
                                    if (FileNameConverted.Length > 0)
                                    {
                                        try
                                        {
                                            string EmailDescription = "";
                                            if (File.Exists(FileNameConverted))
                                            {
                                                EMX.LoadMsgFile(UID, FileNameConverted, ServerName, CurrMailFolder, LibraryName, RetentionCode, Subject, ref EmailBody, ref AttachedFiles, true, NewGuid, ref EmailDescription);
                                            }

                                            if (EmailDescription.Length > 0)
                                            {
                                                EmailDescription = UTIL.RemoveSingleQuotes(EmailDescription);
                                                concatEmailBody(EmailDescription, EmailGuid);
                                            }
                                        }
                                        catch (System.Exception ex)
                                        {
                                            LOG.WriteToArchiveLog("NOTICE: " + FileNameConverted + " processed - " + ex.Message);
                                        }
                                    }

                                    EMX = null;
                                    // ***********************************************************
                                }

                                int bCnt = ATYPE.cnt_PK29(FileExt);
                                bool isZipFile = false;
                                if (Strings.InStr(FileName, "winmail.dat", CompareMethod.Text) > 0)
                                {
                                    goto SkipThisOne;
                                }

                                if (bCnt == 0)
                                {
                                    bool B1 = ZF.isZipFile(FileName);
                                    if (B1)
                                    {
                                        string argval14 = "1";
                                        ATYPE.setIszipformat(ref argval14);
                                        isZipFile = true;
                                    }
                                    else
                                    {
                                        string argval15 = "0";
                                        ATYPE.setIszipformat(ref argval15);
                                        isZipFile = false;
                                    }

                                    ATYPE.setAttachmentcode(ref FileExt);
                                    ATYPE.Insert();
                                }

                                bool BBB = ZF.isZipFile(FileName);
                                string argval16 = "Auto added this code.";
                                ATYPE.setDescription(ref argval16);
                                if (BBB)
                                {
                                    string argval17 = "1";
                                    ATYPE.setIszipformat(ref argval17);
                                    isZipFile = true;
                                }
                                else
                                {
                                    string argval18 = "0";
                                    ATYPE.setIszipformat(ref argval18);
                                    isZipFile = false;
                                }

                                if (isZipFile == true)
                                {
                                    // ** Explode and load
                                    string AttachmentName = FileName;
                                    bool SkipIfAlreadyArchived = false;
                                    // ZF.ProcessEmailZipFile(gMachineID, EmailGuid, FileName , gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName)
                                    int StackLevel = 0;
                                    var ListOfFiles = new Dictionary<string, int>();
                                    ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, FileName, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
                                    ListOfFiles = null;
                                    GC.Collect();
                                }
                                else
                                {
                                    FileExt = "." + UTIL.getFileSuffix(FileName);
                                    string AttachmentName = FileName;
                                    string Sha1Hash = ENC.GenerateSHA512HashFromFile(FileName);
                                    bool bbx = InsertAttachmentFqn(modGlobals.gCurrUserGuidID, FileName, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, Conversions.ToString(isPublic), CurrMailFolder);
                                }

                                SkipThisOne:
                                ;
                            }
                        }
                        // If bWinMail = True Then
                        // For Each sFileToRemove As String In AttachedFiles
                        // If File.Exists(sFileToRemove) Then
                        // ISO.saveIsoFile(" FilesToDelete.dat", sFileToRemove + "|")
                        // 'File.Delete(sFileToRemove)
                        // End If
                        // Next
                        // bWinMail = False
                        // End If
                    }

                    System.Windows.Forms.Application.DoEvents();
                    if (xDebug)
                        LOG.WriteToTraceLog("ArchiveExchangeEmails 5000: ");
                    LabelSkipThisEmail:
                    ;
                }
                catch (System.Exception ex)
                {
                    EmailsSkipped += 1;
                    LOG.WriteToArchiveLog(ArchiveMsg + " SKIPPED - " + ex.Message);
                    LOG.WriteToArchiveLog("clsArchiver : ArchiveEmailsInFolder: 100 - item#" + i.ToString() + " : " + ex.Message);
                }

                GC.Collect();
                GC.WaitForFullGCComplete();
            }
            catch (System.Exception ex)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(ex.Message);
            }
        }

        // Sub ApplyPendingEmail(ByVal UID As String, ByVal ServerName As String, _
        // ByVal CurrMailFolder As String, _
        // ByVal LibraryName As String, _
        // ByVal RetentionCode )

        // Dim MsgFQN As String = "" Dim DefaultSubject As String = "" Dim Body As String = "" Dim
        // AttachedFiles As New List(Of String) Dim bWinMail As Boolean = False

        // Dim I As Integer = 0 Dim J As Integer = 0 Dim TempDir = System.IO.Path.GetTempPath Dim
        // AttachmentDir = TempDir + "Email\Attachment" Dim PendDir = TempDir +
        // "Email\Attachment\PendingEmail" Dim EmailDir = TempDir + "Email"

        // Dim D As Directory If Not D.Exists(PendDir) Then D = Nothing Return End If

        // Dim storefile As Directory Dim directory As String Dim files As String() Dim File As String Dim
        // DeleteFiles As Boolean = True

        // Try files = storefile.GetFiles(PendDir, "*.MSG") For Each File In files
        // DMA.deleteDirectoryFiles(AttachmentDir ) Dim FQN = File

        // Dim ParentGuid As String = "" If InStr(File, ".") > 0 Then ParentGuid = Mid(File, 1,
        // InStr(File, ".") - 1) If isGuid(ParentGuid) = False Then ParentGuid = "" End If End If Dim
        // EmailDescription As String = "" LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName,
        // RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, EmailDescription)
        // Next Catch ex As System.Exception log.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " +
        // ex.Message) DeleteFiles = False Finally If DeleteFiles = True Then For Each File In files Dim
        // FQN = PendDir + "\" + File

        // Next End If

        // End Try

        // End Sub

        public void ApplyPendingEmail(string UID, string DirectoryName, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode)
        {
            string MsgFQN = "";
            string DefaultSubject = "";
            string Body = "";
            var AttachedFiles = new List<string>();
            bool bWinMail = false;
            int I = 0;
            int J = 0;
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string PendDir = DirectoryName;
            string EmailDir = TempDir + "Email";
            if (!Directory.Exists(PendDir))
            {
                return;
            }

            var files = default(string[]);
            string File;
            bool DeleteFiles = true;
            try
            {
                files = Directory.GetFiles(PendDir, "*.MSG");
                foreach (var currentFile in files)
                {
                    File = currentFile;
                    DMA.deleteDirectoryFiles(AttachmentDir);
                    string FQN = File;
                    string ParentGuid = "";
                    if (Strings.InStr(File, ".") > 0)
                    {
                        ParentGuid = Strings.Mid(File, 1, Strings.InStr(File, ".") - 1);
                        if (modGlobals.isGuid(ParentGuid) == false)
                        {
                            ParentGuid = "";
                        }
                    }

                    string EmailDescription = "";
                    LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, ref Body, ref AttachedFiles, bWinMail, ParentGuid, ref EmailDescription);
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message);
                DeleteFiles = false;
            }
            finally
            {
                if (DeleteFiles == true)
                {
                    foreach (var currentFile in files)
                    {
                        File = currentFile;
                        string FQN = PendDir + @"\" + File;
                    }
                }
            }
        }

        public void ApplyPendingEmail(string UID, List<string> SelectedFiles, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode)
        {
            string MsgFQN = "";
            string DefaultSubject = "";
            string Body = "";
            var AttachedFiles = new List<string>();
            bool bWinMail = false;
            int I = 0;
            int J = 0;
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            // Dim PendDir  = DirectoryName
            string EmailDir = TempDir + "Email";

            // Dim D As Directory
            // If Not D.Exists(PendDir) Then
            // D = Nothing
            // Return
            // End If

            Directory storefile;
            string directory;
            string[] files;
            bool DeleteFiles = true;
            try
            {
                foreach (var File in SelectedFiles)
                {
                    DMA.deleteDirectoryFiles(AttachmentDir);
                    string FQN = File;
                    string ParentGuid = "";
                    if (Strings.InStr(File, ".") > 0)
                    {
                        ParentGuid = Strings.Mid(File, 1, Strings.InStr(File, ".") - 1);
                        if (modGlobals.isGuid(ParentGuid) == false)
                        {
                            ParentGuid = "";
                        }
                    }

                    string EmailDescription = "";
                    LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, ref Body, ref AttachedFiles, bWinMail, ParentGuid, ref EmailDescription);
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message);
            }
        }

        public void ArchiveEmbeddedEmailMessage(string UID, Chilkat.Email EM, string LibraryName, string EmailBoxName, string RetentionCode, bool isPublic, bool bEmlToMSG, string ServerName, string ParentGuid, int DaysToHold, string EmailIdentifier, string EntryID)
        {
            // ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold)

            int LL = 0;
            int PauseThreadMS = 0;
            try
            {
                PauseThreadMS = Conversions.ToInteger(getUserParm("UserEmail_Pause"));
            }
            catch (System.Exception ex)
            {
                PauseThreadMS = 0;
            }

            try
            {
                string TempDir = UTIL.getTempProcessingDir();
                LL = 1;
                TempDir = TempDir.Replace(@"\\", @"\");
                string AttachmentDir = TempDir + @"Email\Attachment";
                LL = 2;
                AttachmentDir = AttachmentDir.Replace(@"\\", @"\");
                string EmailDir = TempDir + "Email";
                LL = 3;
                EmailDir = EmailDir.Replace(@"\\", @"\");
                var AttachedFiles = new List<string>();
                LL = 4;
                string Body = EM.Body;
                LL = 6;
                string BounceAddress = EM.BounceAddress;
                LL = 7;
                string Charset = EM.Charset;
                LL = 8;
                bool Decrypted = EM.Decrypted;
                LL = 9;
                var EmailDate = EM.EmailDate;
                LL = 10;
                string EncryptedBy = EM.EncryptedBy;
                LL = 11;
                string FileDistList = EM.FileDistList;
                LL = 12;
                string From = EM.From;
                LL = 13;
                string FromAddress = EM.FromAddress;
                LL = 14;
                string FromName = EM.FromName;
                LL = 15;
                string Header = EM.Header;
                LL = 16;
                string Language = EM.Language;
                LL = 17;
                string LastErrorHtml = EM.LastErrorHtml;
                LL = 18;
                string LastErrorText = EM.LastErrorText;
                LL = 19;
                string LastErrorXml = EM.LastErrorXml;
                LL = 20;
                var LocalDate = EM.LocalDate;
                LL = 21;
                string Mailer = EM.Mailer;
                LL = 22;
                int NumAlternatives = EM.NumAlternatives;
                LL = 23;
                int NumAttachedMessages = EM.NumAttachedMessages;
                LL = 24;
                int NumAttachments = EM.NumAttachments;
                LL = 25;
                int NumBcc = EM.NumBcc;
                LL = 26;
                int NumCC = EM.NumCC;
                LL = 27;
                int NumDaysOld = EM.NumDaysOld;
                LL = 28;
                int NumHeaderFields = EM.NumHeaderFields;
                LL = 29;
                int NumRelatedItems = EM.NumRelatedItems;
                LL = 30;
                int NumReplacePatterns = EM.NumReplacePatterns;
                LL = 31;
                int NumTo = EM.NumTo;
                LL = 32;
                bool OverwriteExisting = EM.OverwriteExisting;
                LL = 33;
                string PreferredCharset = EM.PreferredCharset;
                LL = 34;
                bool ReceivedEncrypted = EM.ReceivedEncrypted;
                LL = 35;
                bool ReceivedSigned = EM.ReceivedSigned;
                LL = 36;
                string ReplyTo = EM.ReplyTo;
                LL = 37;
                bool ReturnReceipt = EM.ReturnReceipt;
                LL = 38;
                bool SendEncrypted = EM.SendEncrypted;
                LL = 39;
                bool SendSigned = EM.SendSigned;
                LL = 40;
                bool SignaturesValid = EM.SignaturesValid;
                LL = 41;
                string SignedBy = EM.SignedBy;
                LL = 42;
                int Size = EM.Size;
                LL = 43;
                string Subject = EM.Subject;
                LL = 44;
                Subject = UTIL.RemoveSingleQuotes(Subject);
                LL = 45;
                string Uidl = EM.Uidl;
                LL = 46;
                bool VerboseLogging = EM.VerboseLogging;
                LL = 47;
                string tGMT = EmailDate.ToString();
                LL = 49;
                FixDate(ref tGMT);
                LL = 50;
                string tSubject = Strings.Mid(Subject, 1, 100);
                LL = 51;
                RemoveBadChars(ref tSubject);
                LL = 52;
                LL = 53;
                if (NumAttachedMessages > 0)
                {
                    LL = 54;
                    // ** This is a recursive operating on the EMBEDDED message, not the parent message
                    for (int II = 0, loopTo = NumAttachedMessages - 1; II <= loopTo; II++)
                    {
                        LL = 55;
                        ArchiveEmbeddedEmailMessage(UID, EM, LibraryName, EmailBoxName, RetentionCode, isPublic, bEmlToMSG, ServerName, ParentGuid, DaysToHold, EmailIdentifier, EntryID);
                        LL = 56;
                    }

                    LL = 57;
                }

                LL = 58;
                LL = 59;

                // Dim EmailIdentifier As String = UTIL.genEmailIdentifier(Body, Size, tGMT, FromAddress.Trim, Subject, NumAttachments)
                // Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)

                string ToAddr = ParentGuid;
                UTIL.deleteDirectoryFile(AttachmentDir);
                LL = 70;
                if (NumAttachments > 0)
                {
                    LL = 71;
                    // ** This is operating on the EMBEDDED message, not the parent message
                    // ** Clean out the directory :LL =  72
                    EM.SaveAllAttachments(AttachmentDir);
                    LL = 73;
                    getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                    LL = 74;
                }

                LL = 76;
                LL = 77;
                string NewGuid = Guid.NewGuid().ToString();
                LL = 78;
                var CcAddr = new ArrayList();
                LL = 79;
                var BccAddr = new ArrayList();
                LL = 80;
                var EmailToAddr = new ArrayList();
                LL = 81;
                var Recipients = new ArrayList();
                LL = 82;
                var ReceivedTime = DateAndTime.Now;
                LL = 83;
                string UserLoginID = modGlobals.gCurrLoginID;
                LL = 84;
                string DB_ID = "ECM.Library";
                LL = 85;
                string CurrMailFolder = EmailBoxName;
                LL = 86;
                string Server_UserID_StoreID = EmailBoxName;
                LL = 87;
                LL = 88;
                string EmailFQN = EmailDir + @"\Email.Embedded~" + NewGuid + "~.EML";
                LL = 89;
                LL = 90;
                int EmailSize = Size;
                LL = 91;
                LL = 92;
                int retentionYears = getRetentionPeriod(RetentionCode);
                LL = 93;
                bool BB = EM.SaveEml(EmailFQN);
                LL = 94;
                if (BB == false)
                {
                    LL = 95;
                    LOG.WriteToArchiveLog("ERROR: 001a ArchiveEmbeddedEmailMessage - failed to save EML File." + Constants.vbCrLf + EmailFQN);
                    LL = 96;
                    return;
                    LL = 97;
                }

                LL = 98;
                if (bEmlToMSG == true)
                {
                    LL = 99;
                    if (bEmlToMSG == true)
                    {
                        LL = 100;
                        EmailFQN = convertEmlToMsg(EmailFQN);
                        LL = 101;
                        if (EmailFQN.Trim().Length == 0)
                        {
                            LL = 102;
                            LOG.WriteToArchiveLog("FATAL ERROR: 100 ArchiveEmbeddedEmailMessage - failed to convert EML to MSG File.");
                            LL = 103;
                            LOG.WriteToArchiveLog("NOTE:        100 ArchiveEmbeddedEmailMessage:  Most likely the Redemption DLL is not installed properly");
                            LL = 104;
                            return;
                            LL = 105;
                        }

                        LL = 106;
                        // log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'") :LL =  107
                    }
                }

                bool AttachmentsLoaded = false;
                LL = 110;
                ArchiveExchangeEmails(UID, NewGuid, Body, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, ReceivedTime, UserLoginID, DateAndTime.Now, ReceivedTime, DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                LL = 138;
                if (PauseThreadMS > 0)
                {
                    Thread.Sleep(PauseThreadMS);
                }

                LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#4");
                if (AttachmentsLoaded == true)
                {
                    bool DoThis = false;
                    if (DoThis)
                    {
                        if (AttachmentsLoaded == true)
                        {
                            AppendOcrTextEmail(NewGuid);
                            AttachmentsLoaded = false;
                        }
                    }
                }

                if (ParentGuid.Trim().Length > 0)
                {
                    LL = 139;
                    Body = UTIL.RemoveSingleQuotes(Body);
                    LL = 140;
                    Subject = UTIL.RemoveSingleQuotes(Subject);
                    LL = 141;
                    FromName = UTIL.RemoveSingleQuotes(FromName);
                    LL = 142;
                    FromAddress = UTIL.RemoveSingleQuotes(FromAddress);
                    LL = 143;
                    string tMsg = " " + Conversions.ToString('þ') + Body + Conversions.ToString('þ') + Subject + Conversions.ToString('þ') + FromName + Conversions.ToString('þ') + FromAddress;
                    LL = 144;
                    concatEmailBody(tMsg, ParentGuid);
                    LL = 145;
                }

                LL = 146;
                LL = 147;
                ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
                LL = 148;
                string ConversionDir = UTIL.getTempProcessingDir() + @"\WMCONVERT\";
                LL = 149;
                ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
                LL = 150;
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ArchiveEmbeddedEmailMessage 100 - LL = " + LL.ToString() + " : " + ex.Message);
            }

            LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#5");
            SKIPTOHERE:
            ;
        }

        public bool TestEmailConnection(string EmailServer, string UserID, string Password, string Port, bool IMap, bool POP, bool SSL)
        {
            return default;
        }

        public bool ckImapSSLConnection(string MailServerAddr, int PortNbr, string UserLoginID, string LoginPassWord)
        {
            var ENC = new ECMEncrypt();
            LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
            ENC = null;
            var imap = new Chilkat.Imap();
            bool success;
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string EmailDir = TempDir + "Email";
            string CurrMailFolder = MailServerAddr + ":" + UserLoginID;

            // Anything unlocks the component and begins a fully-functional 30-day trial.
            success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
            if (success != true)
            {
                MessageBox.Show(imap.LastErrorText);
                return false;
            }

            // To use a secure SSL connection, set SSL and the port:
            imap.Ssl = true;
            // The typical port for IMAP SSL is 993

            imap.Port = PortNbr;

            // Connect to an IMAP server.
            success = imap.Connect(MailServerAddr);
            if (success != true)
            {
                MessageBox.Show(imap.LastErrorText);
                return false;
            }

            // Login
            success = imap.Login(UserLoginID, LoginPassWord);
            if (success != true)
            {
                MessageBox.Show(imap.LastErrorText);
                return false;
            }

            // ' Select an IMAP mailbox
            // success = imap.SelectMailbox("Inbox")
            // If (success <> True) Then
            // messagebox.show(imap.LastErrorText)
            // Return False
            // End If

            imap.Disconnect();
            return true;
        }

        public bool clIMapConnection(string MailServerAddr, int PortNbr, string UserLoginID, string LoginPassWord)
        {
            var ENC = new ECMEncrypt();
            LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
            ENC = null;
            var imap = new Chilkat.Imap();
            imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
            imap.Port = (int)Conversion.Val(PortNbr);
            try
            {
                imap.Connect(MailServerAddr);
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(imap.LastErrorText);
                return false;
            }

            try
            {
                imap.Login(UserLoginID, LoginPassWord);
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(imap.LastErrorText);
                return false;
            }

            try
            {
                imap.SelectMailbox("Inbox");
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(imap.LastErrorText);
                return false;
            }

            imap.Disconnect();
            return true;
        }

        public int ckPopConnection(string ServerName, int PortNbr, string UserLoginID, string LoginPassWord)
        {
            var ENC = new ECMEncrypt();
            LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
            ENC = null;

            // ServerName  = "pop.dmachicago.com"
            // read mail from a POP3 server.
            var mailman = new Chilkat.MailMan();
            mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            mailman.MailHost = ServerName;
            mailman.PopPassword = LoginPassWord;
            mailman.PopUsername = UserLoginID;
            int iCnt = -1;
            try
            {
                iCnt = mailman.GetMailboxCount();
                return iCnt;
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(mailman.LastErrorText + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
            }

            GC.Collect();
            GC.WaitForFullGCComplete();
            return default;
        }

        public int ckPopSSL(string ServerName, int PortNbr, string UserLoginID, string LoginPassWord)
        {
            var ENC = new ECMEncrypt();
            LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
            ENC = null;

            // Create a mailman object for reading email.
            var mailman = new Chilkat.MailMan();
            string EmailFrom = "";
            string EmailSubject = "";
            string EmailBody = "";
            string EmailFromAddress = "";
            string EmailFromName = "";

            // Any string passed to UnlockComponent automatically begins a 30-day trial.
            bool success;
            success = mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
            if (success != true)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show(mailman.LastErrorText);
                return default;
            }

            // Set our POP3 hostname, login and password
            mailman.MailHost = ServerName;
            mailman.PopUsername = UserLoginID;
            mailman.PopPassword = LoginPassWord;

            // Indicate that the TCP/IP connection with the POP3 server should be SSL. All POP3
            // communications are secure using SSL.
            mailman.PopSsl = true;
            // Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
            // mailman.MailPort = 995
            mailman.MailPort = PortNbr;
            int iCnt = -1;
            try
            {
                iCnt = mailman.GetMailboxCount();
            }
            catch (System.Exception ex)
            {
                MessageBox.Show(mailman.LastErrorText + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
            }

            GC.Collect();
            GC.WaitForFullGCComplete();
            return iCnt;
        }

        public void ProcessExchangeServers(string UID)
        {
            if (UID is null)
            {
                UID = modGlobals.gCurrUserGuidID;
            }

            if (UID.Length == 0 & modGlobals.gCurrUserGuidID.Length > 0)
            {
                UID = modGlobals.gCurrUserGuidID;
            }

            LOG.WriteToArchiveLog("ProcessExchangeServers 100");
            if (isArchiveDisabled("EXCHANGE") == true)
            {
                modGlobals.gExchangeArchiving = false;
                return;
            }

            LOG.WriteToArchiveLog("ProcessExchangeServers 200");
            if (modGlobals.gRunMinimized == true)
            {
                My.MyProject.Forms.frmExchangeMonitor.WindowState = FormWindowState.Minimized;
            }
            else
            {
                My.MyProject.Forms.frmExchangeMonitor.Show();
            }

            LOG.WriteToArchiveLog("ProcessExchangeServers 300");
            string S = "SELECT [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL, IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM [ExchangeHostPop] where Userid = '" + modGlobals.gCurrUserGuidID + "' order by [HostNameIp] ,[UserLoginID]";
            string HostNameIp = "";
            string UserLoginID = "";
            string LoginPw = "";
            bool LeaveOnServer = true;
            bool DeleteAfterDownload = false;
            string PortNbr = "";
            string RetentionCode = "";
            int retentionYears = 10;
            bool SSL = false;
            bool IMap = false;
            string FolderName = "";
            string LibraryName = "";
            bool isPublic = false;
            string strReject = "";
            bool ConvertEmlToMSG = false;
            int DaysToRetain = 1000000;
            string LibraryOwnerUserID = "";
            string tSSL = "";
            string DaysToHold = "";
            string ConnStr = "";
            var ListOfServers = new List<string>();
            LOG.WriteToArchiveLog("ProcessExchangeServers 400");
            SqlDataReader rsData = null;
            LOG.WriteToArchiveLog("ProcessExchangeServers 400.1");
            try
            {
                rsData = SqlQryNewConn(S);
                LOG.WriteToArchiveLog("ProcessExchangeServers 400.2: ");
                int LL = 0;
                string ArchiveGuid = Guid.NewGuid().ToString();
                LOG.WriteToArchiveLog("ProcessExchangeServers 400.3: ");
                LL = 0;
                if (rsData.HasRows)
                {
                    while (rsData.Read())
                    {
                        // LOG.WriteToArchiveLog("ProcessExchangeServers 600")
                        if (modGlobals.gTerminateImmediately == true)
                        {
                            modGlobals.gExchangeArchiving = false;
                            return;
                        }

                        // 0 [HostNameIp],
                        // 1 [UserLoginID],
                        // 2 [LoginPw],
                        // 3 [PortNbr],
                        // 4 [DeleteAfterDownload],
                        // 5 [RetentionCode],
                        // 6 SSL,
                        // 7 IMap,
                        // 8 FolderName,
                        // 9 LibraryName,
                        // 10 isPublic
                        // 11 DaysToHold
                        // 12 strReject
                        // 13 ConvertEmlToMSG

                        try
                        {
                            DaysToHold = rsData.GetValue(11).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            DaysToHold = Conversions.ToString(false);
                        }

                        try
                        {
                            ConvertEmlToMSG = rsData.GetBoolean(13);
                        }
                        catch (System.Exception ex)
                        {
                            ConvertEmlToMSG = false;
                        }

                        try
                        {
                            LibraryName = rsData.GetValue(9).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            LibraryName = "NA";
                        }

                        try
                        {
                            isPublic = rsData.GetBoolean(10);
                        }
                        catch (System.Exception ex)
                        {
                            isPublic = false;
                        }

                        try
                        {
                            DaysToRetain = rsData.GetInt32(11);
                        }
                        catch (System.Exception ex)
                        {
                            DaysToRetain = 1000000;
                        }

                        try
                        {
                            strReject = rsData.GetValue(12).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            strReject = "";
                        }

                        if (LibraryName.Trim().Length > 0)
                        {
                            LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
                            if (LibraryOwnerUserID.Trim().Length == 0)
                            {
                                LOG.WriteToArchiveLog("ERROR: 500 - No Lib Owner found.");
                            }
                        }
                        else
                        {
                            LOG.WriteToArchiveLog("Warning: 500.x01 - No Library found.");
                        }

                        try
                        {
                            HostNameIp = rsData.GetValue(0).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            HostNameIp = "";
                        }

                        try
                        {
                            UserLoginID = rsData.GetValue(1).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            UserLoginID = "";
                        }

                        // WDM 03/08/2010If ConvertEmlToMSG = True And RedemptionDllExists = False Then
                        // If ConvertEmlToMSG = True And RedemptionDllExists = False Then
                        // log.WriteToArchiveLog("ERROR ERROR - ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp  + " :" + LibraryName + " : " + UserLoginID + "' will not be processed.")
                        // GoTo NextBox
                        // End If

                        LoginPw = rsData.GetValue(2).ToString();
                        LoginPw = ENC.AES256DecryptString(LoginPw);
                        try
                        {
                            PortNbr = rsData.GetValue(3).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            PortNbr = "";
                        }

                        try
                        {
                            string tDeleteAfterDownload = rsData.GetValue(4).ToString();
                            if (tDeleteAfterDownload.Equals("False"))
                            {
                                DeleteAfterDownload = false;
                            }
                            else
                            {
                                DeleteAfterDownload = true;
                            }
                        }
                        catch (System.Exception ex)
                        {
                            DeleteAfterDownload = false;
                        }

                        try
                        {
                            RetentionCode = rsData.GetValue(5).ToString();
                        }
                        catch (System.Exception ex)
                        {
                            RetentionCode = "";
                        }

                        try
                        {
                            tSSL = rsData.GetValue(6).ToString();
                            if (tSSL.Equals("False"))
                            {
                                SSL = false;
                            }
                            else
                            {
                                SSL = true;
                            }
                        }
                        catch (System.Exception ex)
                        {
                            SSL = false;
                        }

                        try
                        {
                            string tIMap = rsData.GetValue(7).ToString();
                            if (tIMap.Equals("False"))
                            {
                                IMap = false;
                            }
                            else
                            {
                                IMap = true;
                            }
                        }
                        catch (System.Exception ex)
                        {
                            IMap = false;
                        }

                        // If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 500 : " + HostNameIp )

                        retentionYears = getRetentionPeriod(RetentionCode);

                        // If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 500.1 : " + retentionYears.ToString)
                        if (DeleteAfterDownload == false)
                        {
                            LeaveOnServer = true;
                        }
                        else
                        {
                            LeaveOnServer = false;
                        }

                        LOG.WriteToArchiveLog("Processing Exchange Box " + HostNameIp + " emails by " + UserLoginID + " : " + DateAndTime.Now.ToString());

                        // 0 HostNameIp,
                        // 1 UserLoginID,
                        // 2 LoginPw,
                        // 3 PortNbr,
                        // 4 DeleteAfterDownload,
                        // 5 RetentionCode,
                        // 6 SSL,
                        // 7 IMap,
                        // 8 FolderName,
                        // 9 LibraryName,
                        // 10 isPublic
                        // 11 DaysToHold
                        // 12 strReject
                        // 13 ConvertEmlToMSG
                        string ServerString = "";
                        ServerString = ServerString + HostNameIp + Conversions.ToString('þ');     // 0
                        ServerString = ServerString + UserLoginID + Conversions.ToString('þ');    // 1
                        ServerString = ServerString + LoginPw + Conversions.ToString('þ');        // 2
                        ServerString = ServerString + PortNbr + Conversions.ToString('þ');        // 3
                        ServerString = ServerString + DeleteAfterDownload + 'þ';    // 4
                        ServerString = ServerString + RetentionCode + Conversions.ToString('þ');  // 5
                        ServerString = ServerString + SSL + 'þ';            // 6
                        ServerString = ServerString + IMap + 'þ';           // 7
                        ServerString = ServerString + FolderName + 'þ';           // 8
                        ServerString = ServerString + LibraryName + 'þ';    // 9
                        ServerString = ServerString + isPublic + 'þ';       // 10
                        ServerString = ServerString + DaysToHold + 'þ';     // 11
                        ServerString = ServerString + strReject + Conversions.ToString('þ');      // 12
                        ServerString = ServerString + ConvertEmlToMSG + 'þ';    // 13
                        ServerString = ServerString + retentionYears + 'þ'; // 14
                        ServerString = ServerString + DaysToRetain;              // 15
                        ListOfServers.Add(ServerString);
                        NextBox:
                        ;
                        LOG.WriteToArchiveLog("ProcessExchangeServers 700");
                    }
                }

                LOG.WriteToArchiveLog("ProcessExchangeServers 800");
                rsData.Close();
                LOG.WriteToArchiveLog("ProcessExchangeServers 900");
                rsData = null;
                LOG.WriteToArchiveLog("ProcessExchangeServers 1000");
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ProcessExchangeServers 2000");
                LOG.WriteToArchiveLog("ERROR 641.92.2 ProcessExchangeServers - " + ex.Message);
            }
            finally
            {
                LOG.WriteToArchiveLog("ProcessExchangeServers 3000.1");
                if (rsData is object)
                {
                    LOG.WriteToArchiveLog("ProcessExchangeServers 3000.2");
                    if (!rsData.IsClosed)
                    {
                        LOG.WriteToArchiveLog("ProcessExchangeServers 4000.1");
                        rsData.Close();
                        LOG.WriteToArchiveLog("ProcessExchangeServers 5000.1");
                    }

                    LOG.WriteToArchiveLog("ProcessExchangeServers 6000.1");
                    rsData = null;
                }

                LOG.WriteToArchiveLog("ProcessExchangeServers 7000.1");
                GC.Collect();
                LOG.WriteToArchiveLog("ProcessExchangeServers 8000.1");
                GC.WaitForPendingFinalizers();
                LOG.WriteToArchiveLog("ProcessExchangeServers 9000.1");
            }

            // frmReconMain.SB.Text = "Processing Exchange servers: " & ListOfServers.Count
            LOG.WriteToArchiveLog("ProcessExchangeServers 10000");
            try
            {
                int I = 0;
                string[] A;
                // ************************************************************
                // * Process Each Exchange Server
                // ************************************************************
                var loopTo = ListOfServers.Count - 1;
                for (I = 0; I <= loopTo; I++)
                {
                    LOG.WriteToArchiveLog("ProcessExchangeServers 10001");
                    S = ListOfServers[I];
                    if (modGlobals.gTerminateImmediately == true)
                    {
                        modGlobals.gExchangeArchiving = false;
                        return;
                    }

                    A = S.Split('þ');
                    HostNameIp = A[0];
                    UserLoginID = A[1];
                    LoginPw = A[2];
                    PortNbr = A[3];
                    DeleteAfterDownload = Conversions.ToBoolean(A[4]);
                    RetentionCode = A[5];
                    SSL = Conversions.ToBoolean(A[6]);
                    IMap = Conversions.ToBoolean(A[7]);
                    FolderName = A[8];
                    LibraryName = A[9];
                    isPublic = Conversions.ToBoolean(A[10]);
                    DaysToHold = A[11];
                    strReject = A[12];
                    ConvertEmlToMSG = Conversions.ToBoolean(A[13]);
                    retentionYears = Conversions.ToInteger(A[14]);
                    DaysToRetain = Conversions.ToInteger(A[15]);
                    if (DeleteAfterDownload == false)
                    {
                        LeaveOnServer = true;
                    }
                    else
                    {
                        LeaveOnServer = false;
                    }

                    // LeaveOnServer, retentionYears, DaysToRetain,
                    bool ddebug = false;
                    try
                    {
                        if (SSL == true & IMap == false)
                        {
                            if (PortNbr.Trim().Length == 0)
                            {
                                PortNbr = "995";
                            }

                            if (PortNbr.Equals("-1"))
                            {
                                PortNbr = "995";
                            }

                            // If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 600 PortNbr : " + PortNbr )
                            LOG.WriteToArchiveLog("Processing Exchange SSL " + HostNameIp + " emails by " + UserLoginID);
                            My.MyProject.Forms.frmMain.tbExchange.Text = "Processing Exchange: " + DateAndTime.Now.ToString();
                            if (ddebug)
                            {
                                LOG.WriteToArchiveLog("ProcessExchangeServers 1000");
                                LOG.WriteToArchiveLog("HostNameIp: " + HostNameIp);
                                LOG.WriteToArchiveLog("UserLoginID: " + UserLoginID);
                                LOG.WriteToArchiveLog("LoginPw: " + LoginPw);
                                LOG.WriteToArchiveLog("PortNbr: " + PortNbr);
                                LOG.WriteToArchiveLog((Conversions.ToDouble("LeaveOnServer: ") + Conversions.ToDouble(LeaveOnServer)).ToString());
                                LOG.WriteToArchiveLog((Conversions.ToDouble("retentionYears: ") + retentionYears).ToString());
                                LOG.WriteToArchiveLog("RetentionCode: " + RetentionCode);
                                LOG.WriteToArchiveLog("LibraryName: " + LibraryName);
                                LOG.WriteToArchiveLog((Conversions.ToDouble("isPublic: ") + Conversions.ToDouble(isPublic)).ToString());
                                LOG.WriteToArchiveLog((Conversions.ToDouble("DaysToRetain: ") + DaysToRetain).ToString());
                                LOG.WriteToArchiveLog("strReject: " + strReject);
                                LOG.WriteToArchiveLog((Conversions.ToDouble("ConvertEmlToMSG: ") + Conversions.ToDouble(ConvertEmlToMSG)).ToString());
                            }

                            My.MyProject.Forms.frmExchangeMonitor.Show();
                            ReadEmailUsingSSL(UID, HostNameIp, UserLoginID, LoginPw, Conversions.ToInteger(PortNbr), LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
                            My.MyProject.Forms.frmMain.tbExchange.Text = "Done";
                            My.MyProject.Forms.frmExchangeMonitor.Close();
                        }
                        else if (IMap == true & SSL == true)
                        {
                            if (PortNbr.Trim().Length == 0)
                            {
                                PortNbr = "993";
                            }

                            if (PortNbr.Equals("-1"))
                            {
                                PortNbr = "993";
                            }
                            // If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 700 PortNbr : " + PortNbr )
                            LOG.WriteToArchiveLog("Processing Exchange IMAP " + HostNameIp + " emails by " + UserLoginID);
                            My.MyProject.Forms.frmMain.tbExchange.Text = "Processing Exchange: " + DateAndTime.Now.ToString();
                            My.MyProject.Forms.frmExchangeMonitor.Show();
                            bool BB;
                            BB = getImapEmailSSLV3(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG, true);
                            if (!BB)
                            {
                                getImapEmailSSL(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG, true);
                            }

                            My.MyProject.Forms.frmExchangeMonitor.Close();
                        }
                        else if (IMap == true & SSL == false)
                        {
                            if (PortNbr.Trim().Length == 0)
                            {
                                PortNbr = "143";
                            }

                            if (PortNbr.Equals("-1"))
                            {
                                PortNbr = "143";
                            }
                            // If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 800 PortNbr : " + PortNbr )
                            LOG.WriteToArchiveLog("INFO: Processing Exchange IMAP/SSL " + HostNameIp + " emails by " + UserLoginID);
                            My.MyProject.Forms.frmMain.SB2.Text = "Processing Exchange: " + DateAndTime.Now.ToString();
                            My.MyProject.Forms.frmMain.tbExchange.Text = "Processing Exchange: " + DateAndTime.Now.ToString();
                            LOG.WriteToArchiveLog("ProcessExchangeServers 3000.5");
                            bool SuccessfulRun = true;
                            My.MyProject.Forms.frmExchangeMonitor.Show();
                            SuccessfulRun = getIMapEmailV3(UID, HostNameIp, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
                            if (!SuccessfulRun)
                            {
                                getIMapEmail(UID, HostNameIp, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
                            }

                            LOG.WriteToArchiveLog("ProcessExchangeServers 3001.5");
                            My.MyProject.Forms.frmMain.tbExchange.Text = "..." + DateAndTime.Now.ToString();
                            My.MyProject.Forms.frmExchangeMonitor.Close();
                        }
                        else
                        {
                            if (PortNbr.Trim().Length == 0)
                            {
                                PortNbr = "110";
                            }

                            if (PortNbr.Equals("-1"))
                            {
                                PortNbr = "110";
                            }
                            // If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 900 PortNbr : " + PortNbr )
                            LOG.WriteToArchiveLog("Processing Exchange POP " + HostNameIp + " emails by " + UserLoginID);
                            My.MyProject.Forms.frmMain.tbExchange.Text = "Processing Exchange: " + DateAndTime.Now.ToString();
                            LOG.WriteToArchiveLog("ProcessExchangeServers 4000");
                            My.MyProject.Forms.frmExchangeMonitor.Show();
                            ReadEmailFromServer(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
                            My.MyProject.Forms.frmMain.tbExchange.Text = "..." + DateAndTime.Now.ToString();
                            My.MyProject.Forms.frmExchangeMonitor.Close();
                        }

                        LOG.WriteToArchiveLog("ProcessExchangeServers 20000");
                    }
                    catch (System.Exception ex)
                    {
                        LOG.WriteToArchiveLog("ProcessExchangeServers 30000");
                        LOG.WriteToArchiveLog("WARNING 641.92.25 ProcessExchangeServers - " + ex.Message);
                    }

                    LOG.WriteToArchiveLog("ProcessExchangeServers 40000");
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ProcessExchangeServers 50000");
                LOG.WriteToArchiveLog("ERROR 641.92.5 ProcessExchangeServers - " + ex.Message);
            }

            LOG.WriteToArchiveLog("ProcessExchangeServers 60000");
            My.MyProject.Forms.frmMain.SB.Text = "Processing Exchange COMPLETE: " + DateAndTime.Now.ToString();
            LOG.WriteToArchiveLog("Exchange Archive completed @ " + DateAndTime.Now.ToString());
            My.MyProject.Forms.frmExchangeMonitor.Close();
            UpdateAttachmentCounts();
            modGlobals.gExchangeArchiving = false;
            My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
            My.MySettingsProperty.Settings.Save();
        }

        public void ApplyPendingEmail(string UID, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode, int DaysToHold)
        {
            string MsgFQN = "";
            string DefaultSubject = "";
            string Body = "";
            var AttachedFiles = new List<string>();
            bool bWinMail = false;
            int I = 0;
            int J = 0;
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string PendDir = TempDir + @"Email\Attachment\PendingEmail";
            string EmailDir = TempDir + "Email";
            Directory D;
            if (!Directory.Exists(PendDir))
            {
                D = null;
                return;
            }

            Directory storefile;
            string directory;
            string[] files;
            bool DeleteFiles = true;
            var FilesToDelete = new List<string>();
            try
            {
                files = Directory.GetFiles(PendDir, "*.MSG");
                int iFiles = 0;
                foreach (var File in files)
                {
                    iFiles += 1;
                    // 'frmExchangeMonitor.lblMsg.Text = "Applying embedded emails: " + iFiles.ToString + " of " + files.Count.ToString
                    // 'frmExchangeMonitor.lblMsg.Refresh()
                    System.Windows.Forms.Application.DoEvents();
                    string ParentGuid = "";
                    if (Strings.InStr(File, ".") > 0)
                    {
                        ParentGuid = Strings.Mid(File, 1, Strings.InStr(File, ".") - 1);
                        if (modGlobals.isGuid(ParentGuid) == false)
                        {
                            ParentGuid = "";
                        }
                    }

                    UTIL.deleteDirectoryFile(AttachmentDir);
                    string FQN = File;
                    string argEmailDescription = DaysToHold.ToString();
                    bool bAddedMsg = LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, ref Body, ref AttachedFiles, bWinMail, ParentGuid, ref argEmailDescription);
                    if (!bAddedMsg)
                    {
                        LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 500 : Failed to add embedded MSG file: " + Constants.vbCrLf + ServerName + Constants.vbCrLf + " : " + CurrMailFolder);
                    }
                    else
                    {
                        FilesToDelete.Add(FQN);
                    }
                }
            }
            // 'frmExchangeMonitor.lblMsg.Text = ""
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message);
                DeleteFiles = false;
            }
            finally
            {
                if (DeleteFiles == true)
                {
                    File F;
                    int iFiles = 0;
                    foreach (string sFile in FilesToDelete)
                    {
                        iFiles += 1;
                        string FQN = sFile;
                        // frmExchangeMonitor.lblMsg.Text = "Cleanup files: " + iFiles.ToString
                        // frmExchangeMonitor.lblMsg.Refresh()
                        System.Windows.Forms.Application.DoEvents();
                        if (File.Exists(FQN))
                        {
                            File.Delete(FQN);
                        }
                    }

                    F = null;
                }
            }
            // frmExchangeMonitor.lblMsg.Text = ""
        }

        public void ApplyPendingEmail(string UID, string DirectoryName, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode, int DaysToHold)
        {
            string MsgFQN = "";
            string DefaultSubject = "";
            string Body = "";
            var AttachedFiles = new List<string>();
            bool bWinMail = false;
            int I = 0;
            int J = 0;
            string TempDir = Path.GetTempPath();
            string AttachmentDir = TempDir + @"Email\Attachment";
            string PendDir = DirectoryName;
            string EmailDir = TempDir + "Email";
            Directory D;
            if (!Directory.Exists(PendDir))
            {
                D = null;
                return;
            }

            Directory storefile;
            string directory;
            var files = default(string[]);
            string File;
            bool DeleteFiles = true;
            try
            {
                files = Directory.GetFiles(PendDir, "*.MSG");
                foreach (var currentFile in files)
                {
                    File = currentFile;
                    UTIL.deleteDirectoryFile(AttachmentDir);
                    string FQN = File;
                    string ParentGuid = "";
                    if (Strings.InStr(File, ".") > 0)
                    {
                        ParentGuid = Strings.Mid(File, 1, Strings.InStr(File, ".") - 1);
                        if (modGlobals.isGuid(ParentGuid) == false)
                        {
                            ParentGuid = "";
                        }
                    }

                    string argEmailDescription = DaysToHold.ToString();
                    LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, ref Body, ref AttachedFiles, bWinMail, ParentGuid, ref argEmailDescription);
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message);
                DeleteFiles = false;
            }
            finally
            {
                if (DeleteFiles == true)
                {
                    foreach (var currentFile in files)
                    {
                        File = currentFile;
                        string FQN = PendDir + @"\" + File;
                    }
                }
            }
        }

        public bool ApplyEmailBundleV2(string UID, Chilkat.MailMan mailman, string ServerName, string UserLoginID, string PassWord, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
        {
            bool RC = false;
            int PauseThreadMS = 0;
            var L = new SortedList<string, string>();
            Chilkat.EmailBundle bundle;
            try
            {
                PauseThreadMS = Conversions.ToInteger(getUserParm("UserEmail_Pause"));
            }
            catch (System.Exception ex)
            {
                PauseThreadMS = 0;
            }

            // Dim bundle As Chilkat.EmailBundle = Nothing
            Chilkat.Email email = null;
            string CurrMailFolder = ServerName + ":" + UserLoginID;
            int LL = 1;
            try
            {
                // Set our POP3 hostname, login and password
                mailman.MailHost = ServerName;
                mailman.PopUsername = UserLoginID;
                mailman.PopPassword = PassWord;
            }
            // mailman.MailPort = 110
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 500 ApplyEmailBundleV2: LL = " + LL.ToString() + ", EX: Could not set login parms.");
                return false;
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();
            int CurrLoopCnt = 0;
            try
            {
                LL = 2;
                string sDownLoadSize = "";
                LL = 3;
                int DownLoadSize = 0;
                LL = 4;
                TotalEmailsInArchive = 0;
                LL = 5;
                int EmailsAdded = 0;
                LL = 2;
                LL = 3;
                try
                {
                    LL = 4;
                    sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings["EmailDownLoadSize"];
                    LL = 5;
                    DownLoadSize = (int)Conversion.Val(sDownLoadSize);
                    LL = 6;
                }
                catch (System.Exception ex)
                {
                    DownLoadSize = 100;
                }

                LL = 9;
                LL = 10;
                if (DownLoadSize == 0)
                {
                    LL = 11;
                    DownLoadSize = 5000;
                    LL = 12;
                }

                LL = 13;
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Process Email Bundle V2";
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                System.Windows.Forms.Application.DoEvents();
                if (srv_DetailedLogging)
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 100 Download Size = " + DownLoadSize.ToString());
                LL = 15;
                if (ServerName.Length == 0)
                {
                    LL = 17;
                    ServerName = modGlobals.gMachineID;
                    LL = 18;
                }

                LL = 19;
                if (UserLoginID.Length == 0)
                {
                    LL = 20;
                    UserLoginID = "ServerManger";
                    LL = 21;
                }

                LL = 23;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + ServerName;
                LL = 24;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                LL = 25;
                System.Windows.Forms.Application.DoEvents();
                LL = 26;

                // Dim I As Integer = 0
                LL = 29;
                int J = 0;
                LL = 30;
                string TempDir = UTIL.getTempProcessingDir() + @"\";
                TempDir = TempDir.Replace(@"\\", @"\");
                if (!Directory.Exists(TempDir))
                {
                    Directory.CreateDirectory(TempDir);
                }

                string AttachmentDir = TempDir + @"\Email\Attachment";
                AttachmentDir = AttachmentDir.Replace(@"\\", @"\");
                if (!Directory.Exists(AttachmentDir))
                {
                    Directory.CreateDirectory(AttachmentDir);
                }

                string EmailDir = TempDir + @"\Email";
                EmailDir = EmailDir.Replace(@"\\", @"\");
                if (!Directory.Exists(EmailDir))
                {
                    Directory.CreateDirectory(EmailDir);
                }

                if (srv_DetailedLogging)
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 200");
                int iCnt = 0;
                LL = 37;
                try
                {
                    iCnt = 1000;
                }
                // iCnt = mailman.GetMailboxCount
                catch (System.Exception ex)
                {
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 100as1 : failed to get email count." + DateAndTime.Now.ToString());
                }
                // log.WriteToArchiveLog("ApplyEmailBundleV2 100as1.1 : email count = " & iCnt & " : " & Now.ToString)

                LL = 41;
                long chunkBeginIdx = 0L;
                LL = 42;
                long chunkEndIdx = DownLoadSize;
                LL = 43;
                LL = 44;
                // First, get the list of UIDLs for all emails in the mailbox.
                LL = 45;
                var sa = new Chilkat.StringArray();
                LL = 46;
                if (sa is null)
                {
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 100XX : failed to allocate download array: " + DateAndTime.Now.ToString());
                    break;
                }

                int iCheck = mailman.CheckMail();
                if (iCheck == -1)
                {
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 100.66 : Appears to be an error in attaching to Exchange server:  " + UserLoginID + " - " + DateAndTime.Now.ToString() + ", aborting archive - Library: " + LibraryName);
                    break;
                }

                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Fetching group of emails.";
                LL = 82;
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                LL = 83;
                System.Windows.Forms.Application.DoEvents();
                LL = 84;
                // ****************************************************************************
                sa = mailman.GetUidls();
                // ****************************************************************************
                if (ddebug)
                {
                    Console.WriteLine(mailman.LastErrorText);
                    Console.WriteLine("Total: " + sa.Count.ToString());
                }

                LOG.WriteToArchiveLog("ApplyEmailBundleV2 100as1.1 : email count = " + sa.Count.ToString() + " : " + DateAndTime.Now.ToString());
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Processing " + sa.Count.ToString() + " emails from " + UserLoginID;
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                LL = 47;
                if (sa is null)
                {
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 100ZZ : No emails found to download: " + DateAndTime.Now.ToString() + ", aborting archive - Library: " + LibraryName);
                    LOG.WriteToArchiveLog("ApplyEmailBundleV2 100ZZ.1 : " + mailman.LastErrorText);
                    break;
                }

                int TotalEmailsToProcess = 0;
                // Dim CurrentlyProcessedEmails As Integer = 0
                int skippedEmails = 0;
                int ProcessedEmails = 1;
                int TotalEmailsProcessed = 0;
                int TotalEmails = sa.Count;
                string uidl = "";
                double lAvailableMemory = 0d;
                double PercentAvailableMemory = 0d;
                int Warnings = 0;
                double MemoryRemaining = 0d;
                var computer_info = new Microsoft.VisualBasic.Devices.ComputerInfo();
                TotalMemory = computer_info.TotalPhysicalMemory;

                // LoadExckKeys(L)
                DBLocal.LoadExchangeKeys(ref L);
                var StartTime = DateAndTime.Now;
                TimeSpan ElapsedTime;
                TimeSpan ElapsedTxTime;
                double eAvg = 0d;
                double txAvg = 0d;
                double eAvgTotal = 0d;
                double txAvgTotal = 0d;
                int ProcessedCnt = 0;
                try
                {
                    LL = 62;
                    for (int iMails = 0, loopTo = TotalEmails - 1; iMails <= loopTo; iMails++)
                    {
                        ElapsedTxTime = DateAndTime.Now.Subtract(StartTime);
                        StartTime = DateAndTime.Now;
                        uidl = sa.GetString(iMails);
                        if (DBLocal.ExchangeExists(uidl))
                        {
                            goto NEXTBUNDLE;
                        }

                        if (L.IndexOfKey(uidl) >= 0)
                        {
                            goto NEXTBUNDLE;
                        }

                        ProcessedCnt += 1;

                        // **********************************
                        email = mailman.FetchEmail(uidl);
                        string EntryID = uidl;
                        // **********************************

                        if (My.MyProject.Forms.frmMain.ckTerminate.Checked)
                        {
                            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Processing HALTED";
                            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                            return true;
                        }

                        if (iMails == TotalEmails - 2)
                        {
                            Console.WriteLine("Almost done");
                        }

                        DateInterval ETime = default;
                        ElapsedTime = DateAndTime.Now.Subtract(StartTime);
                        txAvgTotal += ElapsedTxTime.TotalMilliseconds;
                        eAvgTotal += ElapsedTime.TotalMilliseconds;
                        eAvg = eAvgTotal / ProcessedCnt;
                        txAvg = txAvgTotal / ProcessedCnt;
                        if (iMails % 5 == 0)
                        {
                            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Processing " + iMails.ToString() + " of " + TotalEmails.ToString();
                            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
                            lAvailableMemory = UTIL.getUsedMemory();
                            // frmExchangeMonitor.lblMsg.Text = "Mem Free: " + lAvailableMemory.ToString + " MB"
                            // frmExchangeMonitor.lblMsg.Refresh()
                            MemoryRemaining = TotalMemory - lAvailableMemory * 1000000d;
                            PercentAvailableMemory = lAvailableMemory * 1000000d / TotalMemory;
                            PercentAvailableMemory = (1d - PercentAvailableMemory) * 100d;
                            if (PercentAvailableMemory < 20d & PercentAvailableMemory > 0d)
                            {
                                My.MyProject.Forms.frmExchangeMonitor.lblMsg.BackColor = Color.DarkRed;
                                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Memory watch: " + PercentAvailableMemory * 100d + "% free";
                                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                                Warnings += 1;
                                if (Warnings > 5)
                                {
                                    FileSystem.Reset();
                                    DBARCH.CloseConn();
                                    LOG.WriteToArchiveLog("NOTICE: Restart may be needed to reclaim memory.");
                                    // System.Windows.Forms.Application.Restart()
                                    Warnings = 0;
                                }

                                GC.Collect();
                                GC.WaitForPendingFinalizers();
                            }

                            My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + ServerName;
                            My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                            My.MyProject.Forms.frmExchangeMonitor.lblSpeed.Text = ElapsedTime.ToString();
                            My.MyProject.Forms.frmExchangeMonitor.txTime.Text = ElapsedTxTime.ToString();
                            My.MyProject.Forms.frmExchangeMonitor.eTimeAvg.Text = eAvg.ToString() + "/ms";
                            My.MyProject.Forms.frmExchangeMonitor.txAvg.Text = txAvg.ToString() + "/ms";
                            My.MyProject.Forms.frmExchangeMonitor.Refresh();
                        }

                        if (iMails % 100 == 0)
                        {
                            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Mem Free: " + lAvailableMemory.ToString() + " MB @ " + DateAndTime.TimeOfDay;
                            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                            System.Windows.Forms.Application.DoEvents();
                            GC.Collect();
                            GC.WaitForPendingFinalizers();
                        }

                        if (PauseThreadMS > 0)
                        {
                            Thread.Sleep(50);
                        }

                        // LOG.WriteToKeyLog(uidl, True)
                        // DBARCH.AddExcgKey(uidl)

                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("TotalEmailsProcessed = " + TotalEmailsProcessed.ToString());
                        System.Windows.Forms.Application.DoEvents();
                        if (email is null)
                        {
                            goto NEXTBUNDLE;
                        }

                        System.Windows.Forms.Application.DoEvents();
                        // Process the bundle... (processing code)
                        // *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
                        LL = 98;
                        string emailKey = "";
                        string NewGuid = Guid.NewGuid().ToString();
                        LL = 113;
                        if (email is null)
                        {
                            goto NEXTBUNDLE;
                        }

                        LL = 115;
                        string Subject = "";
                        LL = 116;
                        try
                        {
                            Subject = email.Subject;
                            Subject = LOG.PullOutSingleQuotes(Subject);
                        }
                        catch (System.Exception ex)
                        {
                            Subject = "NA";
                        }

                        LL = 117;
                        string EmailFrom = email.From;
                        LL = 118;
                        string FromAddress = email.FromAddress;
                        LL = 119;
                        string FromName = email.FromName;
                        LL = 120;
                        string From = email.From;
                        LL = 121;
                        LL = 122;
                        if (strReject.Trim().Length > 0)
                        {
                            LL = 123;
                            var A = strReject.Split(',');
                            LL = 124;
                            for (int II = 0, loopTo1 = Information.UBound(A); II <= loopTo1; II++)
                            {
                                LL = 125;
                                string S1 = A[II].Trim();
                                LL = 126;
                                if (S1.Trim().Length > 0)
                                {
                                    LL = 127;
                                    if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                    {
                                        LL = 128;
                                        LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject);
                                        LL = 129;
                                        goto NextRec;
                                        LL = 130;
                                    }

                                    LL = 131;
                                }

                                LL = 132;
                            }

                            LL = 133;
                        }

                        LL = 134;
                        int NumAlternatives = email.NumAlternatives;
                        LL = 147;
                        int NumAttachedMessages = email.NumAttachedMessages;
                        LL = 148;
                        int NumAttachments = email.NumAttachments;
                        LL = 149;
                        if (Conversions.ToInteger(NumAttachments > 0) > 0)
                        {
                            Console.WriteLine("Attachments Here: " + NumAttachments.ToString());
                            LL = 151;
                        }

                        if (NumAttachedMessages > 0)
                        {
                            Console.WriteLine("Attachments Message Here: " + NumAttachments.ToString());
                            LL = 151;
                        }

                        LL = 152;
                        int NumBcc = email.NumBcc;
                        LL = 153;
                        int NumCC = email.NumCC;
                        LL = 154;
                        int NumTo = email.NumTo;
                        LL = 155;
                        string ReplyTo = email.ReplyTo;
                        LL = 156;
                        string SignedBy = email.SignedBy;
                        LL = 157;
                        int EmailSize = email.Size;
                        LL = 158;
                        string ReceivedDate = null;
                        ReceivedDate = email.LocalDate.ToString();
                        LL = 159;
                        string GMT = email.EmailDate.ToString();
                        LL = 160;
                        string Header = email.Header;
                        LL = 161;
                        string EmailBody = email.Body;
                        EmailBody = LOG.PullOutSingleQuotes(EmailBody);
                        LL = 164;
                        var Recipients = new ArrayList();
                        LL = 165;
                        var EmailTo = new ArrayList();
                        LL = 166;
                        var EmailToAddr = new ArrayList();
                        LL = 167;
                        var EmailToName = new ArrayList();
                        LL = 168;
                        var Bcc = new ArrayList();
                        LL = 169;
                        var BccAddr = new ArrayList();
                        LL = 170;
                        var BccName = new ArrayList();
                        LL = 171;
                        var CC = new ArrayList();
                        LL = 172;
                        var CcAddr = new ArrayList();
                        LL = 173;
                        var CcName = new ArrayList();
                        LL = 174;
                        bool bLoadAttachments = false;
                        LL = 175;
                        LL = 176;
                        string EmailDateTimeGMT = GMT;
                        LL = 177;
                        FixDate(ref EmailDateTimeGMT);
                        LL = 178;
                        string tSubject = Strings.Mid(Subject, 1, 100);
                        LL = 179;
                        RemoveBadChars(ref tSubject);
                        string EmailIdentifier = EmailSize.ToString() + "~" + EmailDateTimeGMT + "~" + FromAddress.Trim() + "~" + tSubject + "~" + EmailToAddr.ToString() + "~" + UID;
                        LL = 182;
                        RemoveBlanks(ref EmailIdentifier);
                        try
                        {
                            if (L.ContainsKey(uidl))
                            {
                                goto NextRec;
                            }
                        }
                        catch (System.Exception ex)
                        {
                        }

                        // Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
                        string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                        bool bEmailExists = DBARCH.ExchangeEmailExists(EmailIdentifier);
                        LL = 184;
                        if (bEmailExists)
                        {
                            LL = 185;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyEmailBundleV2 700X already exists: " + iMails.ToString());
                            LL = 186;
                            skippedEmails += 1;
                            LL = 187;
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString();
                            LL = 188;
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                            LL = 189;
                            System.Windows.Forms.Application.DoEvents();
                            LL = 190;
                            int DaysOld = email.NumDaysOld;
                            LL = 191;
                            if (DaysOld > DaysToHold)
                            {
                                LL = 192;
                                bool success = mailman.DeleteEmail(email);
                                LL = 193;
                                if (!success)
                                {
                                    LL = 194;
                                    string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                    LL = 195;
                                    Msg += "FromName: " + FromName + Constants.vbCrLf;
                                    LL = 196;
                                    Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                    LL = 197;
                                    LOG.WriteToArchiveLog("ERROR ApplyEmailBundleV2: Failed to delete email:" + Constants.vbCrLf + Msg);
                                    LL = 198;
                                }

                                LL = 199;
                            }

                            LL = 200;

                            // LOG.WriteToKeyLog(uidl, True)
                            DBARCH.AddExcgKey(uidl);
                            DBLocal.addExchange(uidl);
                            goto NextRec;
                            LL = 201;
                        }

                        if (bEmailExists)
                        {
                            LL = 206;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyEmailBundleV2 700X already exists: " + iMails.ToString());
                            LL = 207;
                            skippedEmails += 1;
                            LL = 208;
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString();
                            LL = 209;
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                            LL = 210;
                            System.Windows.Forms.Application.DoEvents();
                            LL = 211;
                            goto NextRec;
                            LL = 212;
                        }

                        bool B = bEmailExists;
                        string EmailFQN = EmailDir + @"\" + NewGuid + "~.EML";
                        EmailFQN = EmailFQN.Replace(@"\\", @"\");
                        if (!Directory.Exists(EmailFQN))
                        {
                            Directory.CreateDirectory(EmailFQN);
                        }

                        // Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
                        // Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
                        B = ExchangeEmailExists(EmailIdentifier);
                        if (B)
                        {
                            goto NextRec;
                        }

                        if (NumAttachments > 0)
                        {
                            // ** Clean out the directory
                            deleteDirectoryFile(AttachmentDir);
                            // Save attachments to the "attachments" directory.
                            email.SaveAllAttachments(AttachmentDir);
                            bLoadAttachments = true;
                        }

                        if (NumAttachedMessages > 0)
                        {
                            // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                            for (int II = 0, loopTo2 = NumAttachedMessages - 1; II <= loopTo2; II++)
                            {
                                // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                                var objEmail = email.GetAttachedMessage(II);
                                ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                                objEmail = null;
                            }
                        }

                        LL = 235;
                        var loopTo3 = NumCC - 1;
                        for (J = 0; J <= loopTo3; J++)
                        {
                            LL = 236;
                            CC.Add(email.GetCC(J).ToString());
                            LL = 237;
                            CcAddr.Add(email.GetCcAddr(J).ToString());
                            LL = 238;
                            CcName.Add(email.GetCcName(J).ToString());
                            LL = 239;
                            if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                            {
                                LL = 240;
                                Recipients.Add(email.GetCcAddr(J).ToString());
                                LL = 241;
                            }

                            LL = 242;
                        }

                        LL = 243;
                        var loopTo4 = NumBcc - 1;
                        for (J = 0; J <= loopTo4; J++)
                        {
                            LL = 244;
                            Bcc.Add(email.GetBcc(J).ToString());
                            LL = 245;
                            BccName.Add(email.GetBccName(J).ToString());
                            LL = 246;
                            BccAddr.Add(email.GetBccAddr(J).ToString());
                            LL = 247;
                            if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                            {
                                LL = 248;
                                Recipients.Add(email.GetBccAddr(J).ToString());
                                LL = 249;
                            }

                            LL = 250;
                        }

                        LL = 251;
                        var loopTo5 = NumTo - 1;
                        for (J = 0; J <= loopTo5; J++)
                        {
                            LL = 252;
                            EmailTo.Add(email.GetTo(J).ToString());
                            LL = 253;
                            EmailToAddr.Add(email.GetToAddr(J).ToString());
                            LL = 254;
                            EmailToName.Add(email.GetToName(J).ToString());
                            LL = 255;
                            if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                            {
                                LL = 256;
                                Recipients.Add(email.GetToAddr(J).ToString());
                                LL = 257;
                            }

                            LL = 258;
                        }

                        LL = 259;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyEmailBundleV2 900.0: " + iMails.ToString());
                        LL = 266;
                        bool bFileSaved = email.SaveEml(EmailFQN);
                        LL = 267;
                        LL = 268;
                        if (bFileSaved)
                        {
                            LL = 269;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("Notice 101a.1- ApplyEmailBundleV2: - Save Email: " + EmailFQN);
                        }
                        else
                        {
                            LL = 270;
                            LOG.WriteToArchiveLog("ERROR: 101a - ApplyEmailBundleV2: - Failed to save Email file: " + EmailFQN);
                            LL = 271;
                        }

                        LL = 281;
                        if (bEmlToMSG == true)
                        {
                            LL = 282;
                            EmailFQN = convertEmlToMsg(EmailFQN);
                            LL = 283;
                            if (EmailFQN.Trim().Length == 0)
                            {
                                LL = 284;
                                LOG.WriteToArchiveLog("FATAL ERROR: ApplyEmailBundleV2 - failed to convert EML to MSG File.");
                                LL = 285;
                                goto NextRec;
                            }

                            LL = 287;
                        }

                        LL = 289;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyEmailBundleV2 900.1: " + iMails.ToString());
                        LL = 294;
                        var AttachedFiles = new List<string>();
                        LL = 295;
                        getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                        LL = 297;
                        string DB_ID = "ECM.Library";
                        LL = 298;
                        string Server_UserID_StoreID = CurrMailFolder;
                        LL = 299;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyEmailBundleV2 900.2: " + iMails.ToString());
                        LL = 303;
                        bool AttachmentsLoaded = false;
                        LL = 304;
                        ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, Conversions.ToDate(ReceivedDate), UserLoginID, DateAndTime.Now, Conversions.ToDate(ReceivedDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, email.Uidl, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                        LL = 322;
                        if (NumAttachments > 0)
                        {
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Visible = true;
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Processing " + NumAttachments.ToString() + " attachments.";
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                            System.Windows.Forms.Application.DoEvents();
                            LL = 218;
                            string dirPath = Path.GetTempPath();
                            dirPath = dirPath + "TempZip";
                            DBARCH.DeleteDirectory(dirPath);
                            DBARCH.CreateDir(dirPath);

                            // ** Clean out the directory
                            deleteDirectoryFile(AttachmentDir);
                            email.SaveAllAttachments(AttachmentDir);
                            bLoadAttachments = true;
                            LoadEmailAttachments(AttachmentDir, NewGuid);
                            LL = 223;
                            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Visible = false;
                        }

                        PurgeDirectory(AttachmentDir);
                        EmailsAdded += 1;
                        LL = 323;
                        My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Emails Added: " + EmailsAdded.ToString();
                        LL = 324;
                        My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                        LL = 325;
                        System.Windows.Forms.Application.DoEvents();
                        LL = 329;
                        if (AttachmentsLoaded == true)
                        {
                            LL = 330;
                            bool DoThis = false;
                            LL = 331;
                            if (DoThis)
                            {
                                LL = 332;
                                if (AttachmentsLoaded == true)
                                {
                                    LL = 333;
                                    DBARCH.AppendOcrTextEmail(NewGuid);
                                    LL = 334;
                                    AttachmentsLoaded = false;
                                    LL = 335;
                                }

                                LL = 336;
                            }

                            LL = 337;
                        }

                        LL = 338;
                        // LOG.WriteToKeyLog(uidl, True)
                        DBARCH.AddExcgKey(uidl);
                        DBLocal.addExchange(uidl);
                        NextRec:
                        ;
                        LL = 342;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyEmailBundleV2 1000: " + iMails.ToString());
                        LL = 343;
                        TimeSpan tsTimeSpan;
                        LL = 345;
                        int iNumberOfDays;
                        LL = 346;
                        string strMsgText = "";
                        LL = 347;
                        // tsTimeSpan = Now.Subtract(CDate(ReceivedDate)
                        if (email.LocalDate == default)
                        {
                            LL = 347.1;
                            ReceivedDate = Conversions.ToString(DateAndTime.Now);
                            LL = 347.2;
                        }
                        else if (email.LocalDate.ToString().Length == 0)
                        {
                            LL = 347.3;
                            ReceivedDate = Conversions.ToString(DateAndTime.Now);
                            LL = 347.4;
                        }
                        else
                        {
                            LL = 347.5;
                            ReceivedDate = Conversions.ToString(email.LocalDate);
                            LL = 347.6;
                        }

                        tsTimeSpan = DateAndTime.Now.Subtract(Conversions.ToDate(ReceivedDate));    // ** This represents the received date
                        LL = 348;
                        iNumberOfDays = tsTimeSpan.Days;
                        LL = 349;

                        // *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
                        NEXTBUNDLE:
                        ;
                        LL = 376;
                        if (email is object)
                        {
                            email.Dispose();
                        }

                        ProcessedEmails = ProcessedEmails + 1;
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                    }

                    ENDITALL:
                    ;
                    LL = 383;
                }
                catch (System.Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR 100 ApplyEmailBundleV2: LL = " + LL.ToString() + ", EX: " + ex.Message);
                    LOG.WriteToArchiveLog("FATAL ERROR: ApplyEmailBundleV2 - 10b: " + mailman.LastErrorText);
                }
                finally
                {
                    LOG.WriteToArchiveLog("NOTICE 500 ApplyEmailBundleV2: last line to execute LL = " + LL.ToString());
                    LL = 385;
                    sa.Dispose();
                    sa = null;
                    // bundle.Dispose()
                    if (email is object)
                    {
                        email.Dispose();
                    }

                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                }

                My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: ";
                My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
                My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "";
                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "";
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "";
                My.MyProject.Forms.frmExchangeMonitor.Refresh();
                RC = true;
                DBARCH.UpdateAttachmentCounts();
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 200 ApplyEmailBundleV2: LL = " + LL.ToString() + ", EX: " + ex.Message);
                RC = false;
            }

            mailman.Pop3EndSession();
            ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: ";
            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
            return RC;
        }

        public void deleteDirectoryFile(string DirFQN)
        {
            try
            {
                foreach (var FileName in Directory.GetFiles(DirFQN))
                {
                    try
                    {
                        File.Delete(FileName);
                    }
                    catch (System.Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.");
                    }
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir '" + DirFQN + "'.");
            }
        }

        public void ArchiveEmbeddedEmailMessageV2(string UID, Chilkat.Email EM, string LibraryName, string EmailBoxName, string RetentionCode, bool isPublic, bool bEmlToMSG, string ServerName, string ParentGuid, int DaysToHold, string EmailIdentifier, string EntryID)
        {
            int LL = 0;
            int PauseThreadMS = 0;
            try
            {
                PauseThreadMS = Conversions.ToInteger(getUserParm("UserEmail_Pause"));
            }
            catch (System.Exception ex)
            {
                PauseThreadMS = 0;
            }

            try
            {
                string TempDir = Path.GetTempPath();
                LL = 1;
                LL = 1;
                string AttachmentDir = TempDir + @"Email\Attachment";
                LL = 2;
                string EmailDir = TempDir + "Email";
                LL = 3;
                var AttachedFiles = new List<string>();
                LL = 4;
                string Body = EM.Body;
                LL = 6;
                string BounceAddress = EM.BounceAddress;
                LL = 7;
                string Charset = EM.Charset;
                LL = 8;
                bool Decrypted = EM.Decrypted;
                LL = 9;
                var EmailDate = EM.EmailDate;
                LL = 10;
                string EncryptedBy = EM.EncryptedBy;
                LL = 11;
                string FileDistList = EM.FileDistList;
                LL = 12;
                string From = EM.From;
                LL = 13;
                string FromAddress = EM.FromAddress;
                LL = 14;
                string FromName = EM.FromName;
                LL = 15;
                string Header = EM.Header;
                LL = 16;
                string Language = EM.Language;
                LL = 17;
                string LastErrorHtml = EM.LastErrorHtml;
                LL = 18;
                string LastErrorText = EM.LastErrorText;
                LL = 19;
                string LastErrorXml = EM.LastErrorXml;
                LL = 20;
                var LocalDate = EM.LocalDate;
                LL = 21;
                string Mailer = EM.Mailer;
                LL = 22;
                int NumAlternatives = EM.NumAlternatives;
                LL = 23;
                int NumAttachedMessages = EM.NumAttachedMessages;
                LL = 24;
                int NumAttachments = EM.NumAttachments;
                LL = 25;
                int NumBcc = EM.NumBcc;
                LL = 26;
                int NumCC = EM.NumCC;
                LL = 27;
                int NumDaysOld = EM.NumDaysOld;
                LL = 28;
                int NumHeaderFields = EM.NumHeaderFields;
                LL = 29;
                int NumRelatedItems = EM.NumRelatedItems;
                LL = 30;
                int NumReplacePatterns = EM.NumReplacePatterns;
                LL = 31;
                int NumTo = EM.NumTo;
                LL = 32;
                bool OverwriteExisting = EM.OverwriteExisting;
                LL = 33;
                string PreferredCharset = EM.PreferredCharset;
                LL = 34;
                bool ReceivedEncrypted = EM.ReceivedEncrypted;
                LL = 35;
                bool ReceivedSigned = EM.ReceivedSigned;
                LL = 36;
                string ReplyTo = EM.ReplyTo;
                LL = 37;
                bool ReturnReceipt = EM.ReturnReceipt;
                LL = 38;
                bool SendEncrypted = EM.SendEncrypted;
                LL = 39;
                bool SendSigned = EM.SendSigned;
                LL = 40;
                bool SignaturesValid = EM.SignaturesValid;
                LL = 41;
                string SignedBy = EM.SignedBy;
                LL = 42;
                int Size = EM.Size;
                LL = 43;
                string Subject = EM.Subject;
                LL = 44;
                Subject = LOG.PullOutSingleQuotes(Subject);
                LL = 45;
                string Uidl = EM.Uidl;
                LL = 46;
                bool VerboseLogging = EM.VerboseLogging;
                LL = 47;
                string tGMT = EmailDate.ToString();
                LL = 49;
                FixDate(ref tGMT);
                LL = 50;
                string tSubject = Strings.Mid(Subject, 1, 100);
                LL = 51;
                RemoveBadChars(ref tSubject);
                LL = 52;
                LL = 53;
                if (NumAttachedMessages > 0)
                {
                    LL = 54;
                    for (int II = 0, loopTo = NumAttachedMessages - 1; II <= loopTo; II++)
                    {
                        LL = 55;
                        ArchiveEmbeddedEmailMessage(UID, EM, LibraryName, EmailBoxName, RetentionCode, isPublic, bEmlToMSG, ServerName, ParentGuid, DaysToHold, EmailIdentifier, EntryID);
                        LL = 56;
                    }

                    LL = 57;
                }

                LL = 58;
                LL = 59;

                // Dim EmailIdentifier As String = LOG.genEmailIdentifier(Size.ToString, tGMT, FromAddress.Trim, Subject, gCurrUserGuidID)
                string ToAddr = ParentGuid;
                // Dim EmailIdentifier as string = MailServerAddr  + "." + EmailSize.ToString + "~" + tEmailDate + "~" + FromAddress.Trim + "~" + tSubject  + gCurrUserGuidID :LL =  61
                RemoveBlanks(ref EmailIdentifier);
                LL = 62;
                LL = 63;
                // ** Not needed here - embedded email :LL =  64
                // Dim bEmailExists As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier, EmailHashCode) :LL =  65
                // If bEmailExists Then :LL =  66
                // GoTo SKIPTOHERE :LL =  67
                // End If :LL =  68
                LL = 69;
                deleteDirectoryFile(AttachmentDir);
                LL = 70;
                if (NumAttachments > 0)
                {
                    LL = 71;
                    // ** Clean out the directory :LL =  72
                    EM.SaveAllAttachments(AttachmentDir);
                    LL = 73;
                    getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                    LL = 74;
                    // bLoadAttachments = True :LL = 75
                }

                LL = 76;
                LL = 77;
                string NewGuid = Guid.NewGuid().ToString();
                LL = 78;
                var CcAddr = new ArrayList();
                LL = 79;
                var BccAddr = new ArrayList();
                LL = 80;
                var EmailToAddr = new ArrayList();
                LL = 81;
                var Recipients = new ArrayList();
                LL = 82;
                var ReceivedTime = DateAndTime.Now;
                LL = 83;
                string UserLoginID = "ServiceManager";
                LL = 84;
                string DB_ID = "ECM.Library";
                LL = 85;
                string CurrMailFolder = EmailBoxName;
                LL = 86;
                string Server_UserID_StoreID = EmailBoxName;
                LL = 87;
                LL = 88;
                string EmailFQN = EmailDir + @"\Email.Embedded~" + NewGuid + "~.EML";
                LL = 89;
                LL = 90;
                int EmailSize = Size;
                LL = 91;
                LL = 92;
                int retentionYears = DBARCH.getRetentionPeriod(RetentionCode);
                LL = 93;
                bool BB = EM.SaveEml(EmailFQN);
                LL = 94;
                if (BB == false)
                {
                    LL = 95;
                    LOG.WriteToArchiveLog("ERROR: 001a ArchiveEmbeddedEmailMessage - failed to save EML File." + Constants.vbCrLf + EmailFQN);
                    LL = 96;
                    return;
                    LL = 97;
                }

                LL = 98;
                if (bEmlToMSG == true)
                {
                    LL = 99;
                    if (bEmlToMSG == true)
                    {
                        LL = 100;
                        EmailFQN = convertEmlToMsg(EmailFQN);
                        LL = 101;
                        if (EmailFQN.Trim().Length == 0)
                        {
                            LL = 102;
                            LOG.WriteToArchiveLog("FATAL ERROR: 100 ArchiveEmbeddedEmailMessage - failed to convert EML to MSG File.");
                            LL = 103;
                            LOG.WriteToArchiveLog("NOTE:        100 ArchiveEmbeddedEmailMessage:  Most likely the Redemption DLL is not installed properly");
                            LL = 104;
                            return;
                            LL = 105;
                        }

                        LL = 106;
                        // log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'") :LL =  107
                    }
                }

                bool AttachmentsLoaded = false;
                LL = 110;
                ArchiveExchangeEmails(UID, NewGuid, Body, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, ReceivedTime, UserLoginID, DateAndTime.Now, ReceivedTime, DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                LL = 138;
                if (PauseThreadMS > 0)
                {
                    Thread.Sleep(PauseThreadMS);
                }

                LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#4");
                if (AttachmentsLoaded == true)
                {
                    bool DoThis = false;
                    if (DoThis)
                    {
                        if (AttachmentsLoaded == true)
                        {
                            DBARCH.AppendOcrTextEmail(NewGuid);
                            AttachmentsLoaded = false;
                        }
                    }
                }

                if (ParentGuid.Trim().Length > 0)
                {
                    LL = 139;
                    Body = LOG.PullOutSingleQuotes(Body);
                    LL = 140;
                    Subject = LOG.PullOutSingleQuotes(Subject);
                    LL = 141;
                    FromName = LOG.PullOutSingleQuotes(FromName);
                    LL = 142;
                    FromAddress = LOG.PullOutSingleQuotes(FromAddress);
                    LL = 143;
                    string tMsg = " " + Conversions.ToString('þ') + Body + Conversions.ToString('þ') + Subject + Conversions.ToString('þ') + FromName + Conversions.ToString('þ') + FromAddress;
                    LL = 144;
                    DBARCH.concatEmailBody(tMsg, ParentGuid);
                    LL = 145;
                }

                LL = 146;
                LL = 147;
                ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
                LL = 148;
                string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + @"\WMCONVERT";
                LL = 149;
                ApplyPendingEmail(ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
                LL = 150;
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ArchiveEmbeddedEmailMessage 100 - LL = " + LL.ToString() + " : " + ex.Message);
            }

            LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#5");
            SKIPTOHERE:
            ;
        }

        public void RemoveBlanks(ref string tStr)
        {
            string S = tStr;
            string NewStr = "";
            int BlankCnt = 0;
            string CH = "";
            for (int i = 1, loopTo = S.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(S, i, 1);
                if (CH.Equals(" "))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Conversions.ToString('\t')))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Conversions.ToString('"')))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Constants.vbCrLf))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Constants.vbCr))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Constants.vbLf))
                {
                    BlankCnt += 1;
                }
                else
                {
                    NewStr = NewStr + CH;
                }
            }

            tStr = NewStr;
        }

        public bool getIMapEmailV2(string UID, string MailServerAddr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
        {
            bool RC = true;
            int LL = 0;
            var imap = new Chilkat.Imap();
            int RecjectCount = 1;
            int EmailsProcessedThisRun = 0;
            LL = 1;
            int DownLoadSize = 0;
            string sDownLoadSize = "";
            int Increment = 0;
            long I = 0L;
            imap.ReadTimeout = 360;
            LL = 2;
            try
            {
                LL = 3;
                string ServerName = MailServerAddr + ":" + UserLoginID;
                LL = 4;
                LL = 5;
                string TempDir = Path.GetTempPath();
                LL = 6;
                string AttachmentDir = TempDir + @"Email\Attachment";
                LL = 7;
                string EmailDir = TempDir + "Email";
                LL = 8;
                string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
                LL = 9;
                LL = 10;
                bool Success = false;
                LL = 11;
                imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
                LL = 16;
                Success = imap.Connect(MailServerAddr);
                if (!Success)
                {
                    return false;
                    MessageBox.Show(imap.LastErrorText);
                }

                LL = 17;
                Success = imap.Login(UserLoginID, LoginPassWord);
                if (!Success)
                {
                    MessageBox.Show(imap.LastErrorText);
                    return false;
                }

                LL = 18;
                if (!Success)
                {
                    LL = 19;
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    LOG.WriteToArchiveLog("FATAL ERROR: IMAP 300.1 Failed to log on to " + MailServerAddr + ", aborting.");
                    LL = 20;
                    return false;
                }
                else
                {
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    LL = 21;
                }

                LL = 22;

                // Get the names of all the mailboxes.
                Chilkat.Mailboxes mboxes;
                mboxes = imap.ListMailboxes("", "*");
                for (int iii = 0, loopTo = mboxes.Count - 1; iii <= loopTo; iii++)
                {
                    Console.WriteLine(mboxes.GetName(iii));
                    string mName = mboxes.GetName(iii);
                    My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Mailbox: " + mboxes.GetName(iii);
                    My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                }

                bool BB = imap.SelectMailbox("Inbox");
                if (!BB)
                {
                    return false;
                }

                LL = 23;
                int J = 0;
                Chilkat.MessageSet msgSet;
                LL = 30;
                msgSet = imap.Search("ALL", Conversions.ToBoolean(1));
                LL = 76;
                LL = 81;
                // Loop over the bundle and display the From and Subject.
                LL = 82;
                try
                {
                    LL = 85;
                    sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings["EmailDownLoadSize"];
                    LL = 86;
                    DownLoadSize = (int)Conversion.Val(sDownLoadSize);
                    LL = 87;
                }
                catch (System.Exception ex)
                {
                    DownLoadSize = 100;
                }

                LL = 90;
                LL = 91;
                if (DownLoadSize == 0)
                {
                    LL = 92;
                    DownLoadSize = 5000;
                    LL = 93;
                }

                LL = 94;
                Increment = DownLoadSize;
                LL = 95;
                LL = 96;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr;
                LL = 97;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                LL = 98;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                LL = 99;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                LL = 100;
                System.Windows.Forms.Application.DoEvents();
                LL = 101;
                LL = 102;
                LL = 103;
                Chilkat.EmailBundle bundle;
                LL = 104;
                long startSeqNum;
                LL = 105;
                startSeqNum = 1L;
                LL = 106;
                long numToFetch;
                LL = 107;
                numToFetch = DownLoadSize;
                LL = 108;
                LL = 109;
                bool ExitUponCompletion = false;
                LL = 110;
                bool fetchUids = true;
                LL = 111;
                // Dim messageSet As Chilkat.MessageSet
                LL = 112;
                int NbrOfTries = 1;
                LL = 113;
                REDO:
                ;
                LL = 114;
                if (NbrOfTries >= 3)
                {
                    LL = 115;
                    RC = false;
                    goto ENDIT;
                    LL = 116;
                }

                LL = 118;
                bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                LL = 122;
                int NumberOfMessagesInBox = bundle.MessageCount;
                while (NumberOfMessagesInBox > 0)
                {
                    NumberOfMessagesInBox = imap.NumMessages;
                    LL = 127;
                    LL = 128;
                    if (bundle is null)
                    {
                        LL = 129;
                        LOG.WriteToArchiveLog("NOTICE: getImapEmail 401a: " + imap.LastErrorText);
                        LL = 130;
                        LOG.WriteToArchiveLog("        getImapEmail 401b: startSeqNum - " + startSeqNum.ToString());
                        LL = 131;
                        LOG.WriteToArchiveLog("        getImapEmail 401c: numToFetch - " + numToFetch.ToString());
                        LL = 132;
                        LOG.WriteToArchiveLog("NOTICE: getImapEmail 401d: messages in mailbox: " + NumberOfMessagesInBox.ToString());
                        LL = 133;
                        NbrOfTries = NbrOfTries + 1;
                        LL = 134;
                        goto REDO;
                        LL = 135;
                    }

                    LL = 136;
                    LL = 137;
                    if (NumberOfMessagesInBox > 0)
                    {
                        LL = 138;
                        LOG.WriteToArchiveLog("NOTICE: getImapEmail 401.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                        LL = 139;
                    }
                    else
                    {
                        LL = 140;
                        LOG.WriteToArchiveLog("NOTICE: No messages getImapEmail 401.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                        LL = 141;
                        goto ENDIT;
                        LL = 142;
                    }

                    LL = 143;
                    LL = 144;
                    if (numToFetch > NumberOfMessagesInBox)
                    {
                        LL = 145;
                        numToFetch = NumberOfMessagesInBox;
                        LL = 146;
                    }

                    LL = 167;
                    LOG.WriteToArchiveLog("Processing Exchange IMAP no SSL #emails = " + NumberOfMessagesInBox.ToString());
                    LL = 168;
                    int RejectedCount = 0;
                    LL = 169;
                    // Loop over the bundle and display the FROM and SUBJECT of each.
                    LL = 170;
                    LL = 171;
                    My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr;
                    LL = 172;
                    My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                    LL = 173;
                    My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                    LL = 174;
                    System.Windows.Forms.Application.DoEvents();
                    LL = 176;
                    LL = 177;
                    int MessagesProcessed = 0;
                    LL = 178;
                    int MessagesRemainingToProcess = NumberOfMessagesInBox;
                    LL = 179;
                    int LoopCnt = 1;
                    LL = 180;
                    TotalEmailsInArchive = 0;
                    LL = 181;
                    LL = 182;
                    LOG.WriteToArchiveLog("INFO - messages to process #" + NumberOfMessagesInBox.ToString() + " in " + MailServerAddr);
                    LL = 185;
                    // *******************************************************************************
                    bool ExitNow = false;
                    while (MessagesRemainingToProcess > 0)
                    {
                        LL = 188;
                        if (numToFetch > NumberOfMessagesInBox)
                        {
                            ExitNow = true;
                        }

                        var loopTo1 = (long)(bundle.MessageCount - 1);
                        for (I = 0L; I <= loopTo1; I++)
                        {
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("INFO: bundle #" + LoopCnt.ToString() + ", Email#" + I.ToString());
                            LL = 190;
                            TotalEmailsInArchive += 1;
                            LL = 191;
                            EmailsProcessedThisRun += 1;
                            LL = 192;
                            MessagesRemainingToProcess = MessagesRemainingToProcess - 1;
                            LL = 193;
                            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + NumberOfMessagesInBox.ToString();
                            LL = 194;
                            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
                            LL = 196;
                            System.Windows.Forms.Application.DoEvents();
                            LL = 198;
                            string NewGuid = Guid.NewGuid().ToString();
                            LL = 199;
                            LL = 200;
                            Chilkat.Email email;
                            LL = 201;
                            email = bundle.GetEmail((int)I);
                            LL = 202;
                            string EntryID = email.Uidl;
                            LL = 203;
                            string Subject = email.Subject;
                            Subject = LOG.PullOutSingleQuotes(Subject);
                            LL = 204;
                            string EmailFrom = email.From;
                            LL = 205;
                            string FromAddress = email.FromAddress;
                            LL = 206;
                            string FromName = email.FromName;
                            LL = 207;
                            string From = email.From;
                            LL = 208;
                            LL = 209;
                            if (strReject.Trim().Length > 0)
                            {
                                LL = 210;
                                var A = strReject.Split(',');
                                LL = 211;
                                for (int II = 0, loopTo2 = Information.UBound(A); II <= loopTo2; II++)
                                {
                                    LL = 212;
                                    string S1 = A[II].Trim();
                                    LL = 213;
                                    if (S1.Trim().Length > 0)
                                    {
                                        LL = 214;
                                        if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                        {
                                            LL = 215;
                                            // LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                            LL = 216;
                                            RejectedCount += 1;
                                            LL = 217;
                                            goto NextRec;
                                            LL = 218;
                                        }

                                        LL = 219;
                                    }

                                    LL = 220;
                                }

                                LL = 221;
                            }

                            LL = 222;
                            LL = 223;
                            int NbrDaysOld = email.NumDaysOld;
                            LL = 224;
                            if (NbrDaysOld >= DaysToHold)
                            {
                                LL = 225;
                                Success = imap.SetMailFlag(email, "Deleted", 1);
                                LL = 226;
                                if (Success != true)
                                {
                                    LL = 227;
                                    string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                    LL = 228;
                                    Msg += "FromName: " + FromName + Constants.vbCrLf;
                                    LL = 229;
                                    Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                    LL = 230;
                                    LOG.WriteToArchiveLog("ERROR: getIMapEmail: Failed to delete email from server:" + Constants.vbCrLf + Msg);
                                    LL = 231;
                                }

                                LL = 232;
                            }

                            LL = 233;
                            LL = 234;
                            int NumAlternatives = email.NumAlternatives;
                            LL = 235;
                            int NumAttachedMessages = email.NumAttachedMessages;
                            LL = 236;
                            int NumAttachments = email.NumAttachments;
                            LL = 237;
                            int NumBcc = email.NumBcc;
                            LL = 238;
                            int NumCC = email.NumCC;
                            LL = 239;
                            int NumTo = email.NumTo;
                            LL = 240;
                            string ReplyTo = email.ReplyTo;
                            LL = 241;
                            string SignedBy = email.SignedBy;
                            LL = 242;
                            int EmailSize = email.Size;
                            LL = 243;
                            string LocalDate = email.LocalDate.ToString();
                            LL = 244;
                            string EmailDate = email.EmailDate.ToString();
                            LL = 245;
                            string Header = email.Header;
                            LL = 246;
                            string EmailBody = email.Body;
                            LL = 247;
                            EmailBody = LOG.PullOutSingleQuotes(EmailBody);
                            LL = 248;
                            LL = 249;
                            var Recipients = new ArrayList();
                            LL = 250;
                            var EmailTo = new ArrayList();
                            LL = 251;
                            var EmailToAddr = new ArrayList();
                            LL = 252;
                            var EmailToName = new ArrayList();
                            LL = 253;
                            var Bcc = new ArrayList();
                            LL = 254;
                            var BccAddr = new ArrayList();
                            LL = 255;
                            var BccName = new ArrayList();
                            LL = 256;
                            var CC = new ArrayList();
                            LL = 257;
                            var CcAddr = new ArrayList();
                            LL = 258;
                            var CcName = new ArrayList();
                            LL = 259;
                            bool bLoadAttachments = false;
                            LL = 260;
                            LL = 261;
                            J = 0;
                            LL = 262;
                            LL = 263;
                            string tEmailDate = EmailDate.ToString();
                            LL = 264;
                            FixDate(ref tEmailDate);
                            LL = 265;
                            string tSubject = Strings.Mid(Subject, 1, 100);
                            LL = 266;
                            RemoveBadChars(ref tSubject);
                            LL = 267;

                            // Dim EmailIdentifier As String = EmailSize.ToString + "~" + tEmailDate.ToString + "~" + FromAddress.Trim + "~" + tSubject  + "~" + EmailToAddr.ToString + "~" + UID
                            string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject);
                            string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                            bool bEmailExists = DBARCH.ExchangeEmailExists(EmailIdentifier);
                            LL = 272;
                            if (bEmailExists)
                            {
                                LL = 276;
                                System.Windows.Forms.Application.DoEvents();
                                LL = 277;
                                int DaysOld = email.NumDaysOld;
                                LL = 278;
                                if (DaysOld < 0)
                                {
                                    DaysOld = 1;
                                }

                                if (DaysOld > DaysToHold)
                                {
                                    LL = 279;
                                    Success = imap.SetMailFlag(email, "Deleted", 1);
                                    LL = 280;
                                    if (Success != true)
                                    {
                                        LL = 281;
                                        string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                        LL = 282;
                                        Msg += "FromName: " + FromName + Constants.vbCrLf;
                                        LL = 283;
                                        Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                        LL = 284;
                                        LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                                        LL = 285;
                                    }

                                    LL = 286;
                                }

                                LL = 287;
                                goto NextRec;
                                LL = 288;
                            }

                            LL = 289;
                            LL = 290;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + I.ToString());
                            LL = 291;
                            bool B = DBARCH.ExchangeEmailExists(EmailIdentifier);
                            LL = 292;
                            if (B)
                            {
                                LL = 293;
                                if (srv_DetailedLogging)
                                    LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + I.ToString());
                                LL = 294;
                                goto NextRec;
                                LL = 295;
                            }

                            LL = 296;
                            LL = 297;
                            string EmailFQN = EmailDir + @"\Email~" + NewGuid + "~.EML";
                            LL = 298;
                            LL = 299;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyEmailBundle 800.4a: " + I.ToString());
                            LL = 300;
                            if (NumAttachments > 0)
                            {
                                LL = 301;
                                // ** Clean out the directory
                                LL = 302;
                                deleteDirectoryFile(AttachmentDir);
                                LL = 303;
                                // Save attachments to the "attachments" directory.
                                LL = 304;
                                email.SaveAllAttachments(AttachmentDir);
                                LL = 305;
                                bLoadAttachments = true;
                                LL = 306;
                            }

                            LL = 307;
                            LL = 308;
                            if (NumAttachedMessages > 0)
                            {
                                LL = 309;
                                // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                                LL = 310;
                                for (int II = 0, loopTo3 = NumAttachedMessages - 1; II <= loopTo3; II++)
                                {
                                    LL = 311;
                                    // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                                    LL = 312;
                                    var objEmail = email.GetAttachedMessage(II);
                                    LL = 313;
                                    ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                                    LL = 314;
                                    objEmail = null;
                                    LL = 315;
                                }

                                LL = 316;
                            }

                            LL = 317;
                            LL = 318;
                            var loopTo4 = NumCC - 1;
                            for (J = 0; J <= loopTo4; J++)
                            {
                                LL = 319;
                                CC.Add(email.GetCC(J).ToString());
                                LL = 320;
                                CcAddr.Add(email.GetCcAddr(J).ToString());
                                LL = 321;
                                CcName.Add(email.GetCcName(J).ToString());
                                LL = 322;
                                if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                                {
                                    LL = 323;
                                    Recipients.Add(email.GetCcAddr(J).ToString());
                                    LL = 324;
                                }

                                LL = 325;
                            }

                            LL = 326;
                            var loopTo5 = NumBcc - 1;
                            for (J = 0; J <= loopTo5; J++)
                            {
                                LL = 327;
                                Bcc.Add(email.GetBcc(J).ToString());
                                LL = 328;
                                BccName.Add(email.GetBccName(J).ToString());
                                LL = 329;
                                BccAddr.Add(email.GetBccAddr(J).ToString());
                                LL = 330;
                                if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                                {
                                    LL = 331;
                                    Recipients.Add(email.GetBccAddr(J).ToString());
                                    LL = 332;
                                }

                                LL = 333;
                            }

                            LL = 334;
                            var loopTo6 = NumTo - 1;
                            for (J = 0; J <= loopTo6; J++)
                            {
                                LL = 335;
                                EmailTo.Add(email.GetTo(J).ToString());
                                LL = 336;
                                EmailToAddr.Add(email.GetToAddr(J).ToString());
                                LL = 337;
                                EmailToName.Add(email.GetToName(J).ToString());
                                LL = 338;
                                if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                                {
                                    LL = 339;
                                    Recipients.Add(email.GetToAddr(J).ToString());
                                    LL = 340;
                                }

                                LL = 341;
                            }

                            LL = 342;
                            email.SaveEml(EmailFQN);
                            LL = 358;
                            if (bEmlToMSG == true)
                            {
                                LL = 359;
                                LOG.WriteToArchiveLog("Notice from getImapEmail 300 : FQN '" + EmailFQN + "'");
                                LL = 360;
                                EmailFQN = convertEmlToMsg(EmailFQN);
                                LL = 361;
                            }

                            LL = 362;
                            var AttachedFiles = new List<string>();
                            LL = 367;
                            getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                            LL = 369;
                            string DB_ID = "ECM.Library";
                            LL = 370;
                            string Server_UserID_StoreID = CurrMailFolder;
                            LL = 371;
                            LL = 372;
                            // ** Now, Load the EMAIL and its metadata into the repository
                            LL = 373;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + I.ToString());
                            LL = 374;
                            LL = 375;
                            bool AttachmentsLoaded = false;
                            LL = 376;
                            LL = 377;
                            ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, Conversions.ToDate(EmailDate), UserLoginID, Conversions.ToDate(LocalDate), Conversions.ToDate(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                            LL = 400;
                            if (AttachmentsLoaded == true)
                            {
                                LL = 401;
                                bool DoThis = false;
                                LL = 402;
                                if (DoThis)
                                {
                                    LL = 403;
                                    if (AttachmentsLoaded == true)
                                    {
                                        LL = 404;
                                        DBARCH.AppendOcrTextEmail(NewGuid);
                                        LL = 405;
                                        AttachmentsLoaded = false;
                                        LL = 406;
                                    }

                                    LL = 407;
                                }

                                LL = 408;
                            }

                            LL = 409;
                            NextRec:
                            ;
                            LL = 410;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyIMapBundle 1000: " + I.ToString());
                            LL = 411;
                            LL = 412;
                        }

                        LL = 413;
                        LL = 414;
                        // *****************************************************************************
                        LL = 415;
                        if (ExitUponCompletion == true)
                        {
                            LL = 416;
                            break;
                            LL = 417;
                        }

                        LL = 418;
                        LL = 419;
                        LOG.WriteToArchiveLog("INFO - getIMapEmail getting next + " + DownLoadSize.ToString() + " messages.");
                        LL = 420;
                        LL = 421;
                        if (DownLoadSize > MessagesRemainingToProcess)
                        {
                            LL = 422;
                            DownLoadSize = MessagesRemainingToProcess;
                            LL = 423;
                            // Increment = MessagesRemainingToProcess
                            LL = 424;
                            numToFetch = MessagesRemainingToProcess;
                            LL = 425;
                        }
                        else
                        {
                            LL = 426;
                            numToFetch = DownLoadSize;
                            LL = 427;
                        }

                        LL = 428;
                        LL = 429;
                        LL = 430;
                        LL = 431;
                        startSeqNum = startSeqNum + Increment;
                        LL = 432;
                        LoopCnt = LoopCnt + 1;
                        LL = 433;
                        if (numToFetch > 0L)
                        {
                            LL = 434;
                            LOG.WriteToArchiveLog("INFO - downloading bundle #" + LoopCnt.ToString() + " from " + MailServerAddr);
                            LL = 435;
                            try
                            {
                                LL = 436;
                                bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                                LL = 443;
                                LOG.WriteToArchiveLog("INFO - getIMapEmail successfully getched + " + numToFetch.ToString() + " messages.");
                                LL = 445;
                            }
                            catch (System.Exception ex)
                            {
                                LOG.WriteToArchiveLog("ERROR: imap.FetchSequence - " + ex.Message);
                                LL = 447;
                            }

                            LL = 448;
                            System.Windows.Forms.Application.DoEvents();
                            LL = 455;
                            if (bundle is null)
                            {
                                LL = 456;
                                LOG.WriteToArchiveLog("Warning - termination - getImapEmail 401.5: End of process.");
                                LL = 457;
                                break;
                                LL = 458;
                            }

                            LL = 459;
                        }

                        LL = 460;
                        LL = 461;
                    }

                    LL = 462;
                    if (ExitNow == true)
                    {
                        break;
                    }

                    startSeqNum = startSeqNum + numToFetch + 1L;
                    bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                    LL = 122;
                    NumberOfMessagesInBox = bundle.MessageCount;
                }
            }
            // ***************************************************************
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: 2699 getIMapEmail - LL = " + LL.ToString() + " : " + ex.Message);
                RC = false;
            }
            finally
            {
                // Disconnect from the IMAP server. This example removes the deleted email on the IMAP server.
                LL = 465;
                imap.Expunge();
                LL = 466;
                imap.Disconnect();
                LL = 467;
            }

            LL = 468;
            ENDIT:
            ;

            // Save the email to an XML file
            // bundle.SaveXml("bundle.xml")

            LOG.WriteToArchiveLog("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString());
            LOG.WriteToArchiveLog("Applying IMAP Bundle PROCESSED Message Count = " + TotalEmailsInArchive.ToString());
            LOG.WriteToArchiveLog("INFO: Emails processed this run  = " + EmailsProcessedThisRun.ToString() + " from " + MailServerAddr);
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Emails Processed: ";
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
            System.Windows.Forms.Application.DoEvents();
            return RC;
        }

        public bool getImapEmailSSLV2(string UID, string MailServerAddr, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG, bool UseSSL)
        {
            bool RC = false;
            int LL = 1;
            var imap = new Chilkat.Imap();
            int RejectedCount = 0;
            Chilkat.MessageSet messageSet;
            var bundle = default(Chilkat.EmailBundle);
            try
            {
                LL = 2;
                string ServerName = MailServerAddr + ":" + UserLoginID;
                LL = 3;
                LL = 4;
                LL = 5;
                bool success = false;
                LL = 6;
                string TempDir = Path.GetTempPath();
                LL = 7;
                string AttachmentDir = TempDir + @"Email\Attachment";
                LL = 8;
                string EmailDir = TempDir + "Email";
                LL = 9;
                string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
                LL = 10;
                LL = 11;
                int DownLoadSize = 0;
                LL = 12;
                string sDownLoadSize = "";
                LL = 13;
                int Increment = 0;
                LL = 14;
                int NbrDaysOld = 0;
                LL = 15;
                LL = 16;
                try
                {
                    LL = 17;
                    sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings["EmailDownLoadSize"];
                    LL = 18;
                    DownLoadSize = (int)Conversion.Val(sDownLoadSize);
                    LL = 19;
                }
                catch (System.Exception ex)
                {
                    DownLoadSize = 100;
                }

                LL = 22;
                LL = 23;
                if (DownLoadSize == 0)
                {
                    LL = 24;
                    DownLoadSize = 5000;
                    LL = 25;
                }

                LL = 26;
                Increment = DownLoadSize;
                LL = 27;
                LL = 28;
                // Anything unlocks the component and begins a fully-functional 30-day trial.
                LL = 29;
                success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
                LL = 30;
                if (success != true)
                {
                    LL = 31;
                    MessageBox.Show(imap.LastErrorText);
                    LL = 32;
                    return false;
                    LL = 33;
                }

                LL = 34;
                LL = 35;
                // To use a secure SSL connection, set SSL and the port:
                LL = 36;
                imap.Ssl = UseSSL;
                LL = 37;
                // The typical port for IMAP SSL is 993
                LL = 38;
                if (PortNbr.Length == 0)
                {
                    LL = 39;
                    imap.Port = 993;
                    LL = 40;
                }
                else
                {
                    LL = 41;
                    imap.Port = (int)Conversion.Val(PortNbr);
                    LL = 42;
                }

                LL = 43;
                LL = 44;
                // Connect to an IMAP server.
                LL = 45;
                success = imap.Connect(MailServerAddr);
                LL = 46;
                if (success != true)
                {
                    LL = 47;
                    LOG.WriteToArchiveLog("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText);
                    LL = 48;
                    return false;
                }
                else
                {
                    LL = 49;
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                }

                LL = 50;
                success = imap.Login(UserLoginID, LoginPassWord);
                if (success != true)
                {
                    MessageBox.Show(imap.LastErrorText);
                    LOG.WriteToArchiveLog("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText);
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    return false;
                }
                else
                {
                    LL = 57;
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                }

                LL = 58;

                // Get the names of all the mailboxes.
                Chilkat.Mailboxes mboxes;
                mboxes = imap.ListMailboxes("", "*");
                long ii;
                var loopTo = (long)(mboxes.Count - 1);
                for (ii = 0L; ii <= loopTo; ii++)
                    Console.WriteLine(mboxes.GetName((int)ii));
                success = imap.SelectMailbox("Inbox");
                LL = 62;
                if (success != true)
                {
                    LL = 63;
                    MessageBox.Show(imap.LastErrorText);
                    LOG.WriteToArchiveLog("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText);
                    LL = 64;
                    return false;
                    LL = 65;
                }

                LL = 66;
                LL = 67;
                // After selecting a mailbox, the NumMessages property will
                LL = 68;
                // be updated to reflect the total number of emails in the mailbox:
                LL = 69;
                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Download: " + imap.NumMessages.ToString() + " messages.";
                LL = 70;
                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                LL = 71;
                System.Windows.Forms.Application.DoEvents();
                LL = 72;
                LL = 73;
                int NumberOfMessagesInBox = imap.NumMessages;
                NumberOfMessagesInBox = bundle.MessageCount;
                LL = 74;
                LL = 75;
                if (NumberOfMessagesInBox > 0)
                {
                    LL = 76;
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                    LL = 77;
                }
                else
                {
                    LL = 78;
                    LOG.WriteToArchiveLog("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                    LL = 79;
                    goto ENDIT;
                    LL = 80;
                }

                LL = 81;
                long startSeqNum;
                LL = 93;
                startSeqNum = 1L;
                LL = 94;
                long numToFetch;
                LL = 95;
                numToFetch = DownLoadSize;
                LL = 96;
                LL = 97;
                bool ExitUponCompletion = false;
                LL = 98;
                bool fetchUids = true;
                LL = 99;
                LL = 100;
                int NbrOfTries = 1;
                LL = 101;
                REDO:
                ;
                LL = 102;
                if (NbrOfTries >= 3)
                {
                    LL = 103;
                    goto ENDIT;
                    LL = 104;
                }

                LL = 124;
                if (numToFetch > NumberOfMessagesInBox)
                {
                    LL = 125;
                    numToFetch = NumberOfMessagesInBox;
                    LL = 126;
                }

                LL = 127;
                bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                LL = 128;
                // End If
                LL = 129;
                LL = 130;
                LL = 131;
                if (bundle is null)
                {
                    LL = 132;
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400a: " + imap.LastErrorText);
                    LL = 133;
                    LOG.WriteToArchiveLog("        getImapEmailSSL 400b: startSeqNum - " + startSeqNum.ToString());
                    LL = 134;
                    LOG.WriteToArchiveLog("        getImapEmailSSL 400c: numToFetch - " + numToFetch.ToString());
                    LL = 135;
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400d: messages in mailbox: " + NumberOfMessagesInBox.ToString());
                    LL = 136;
                    NbrOfTries = NbrOfTries + 1;
                    LL = 137;
                    goto REDO;
                    LL = 138;
                }

                LL = 139;
                LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL #emails = " + NumberOfMessagesInBox.ToString());
                LL = 164;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr;
                LL = 165;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                LL = 166;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                LL = 167;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                LL = 168;
                System.Windows.Forms.Application.DoEvents();
                LL = 169;
                LL = 170;
                int MessagesProcessed = 0;
                LL = 171;
                int MessagesRemainingToProcess = NumberOfMessagesInBox;
                LL = 172;
                TotalEmailsInArchive = 0;
                LL = 175;
                while (MessagesRemainingToProcess > 0)
                {
                    LL = 178;
                    for (int i = 0, loopTo1 = bundle.MessageCount - 1; i <= loopTo1; i++)
                    {
                        LL = 179;
                        TotalEmailsInArchive += 1;
                        LL = 180;
                        MessagesRemainingToProcess = MessagesRemainingToProcess - 1;
                        LL = 181;
                        My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + imap.NumMessages.ToString();
                        LL = 182;
                        My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
                        LL = 183;
                        System.Windows.Forms.Application.DoEvents();
                        LL = 186;
                        string NewGuid = Guid.NewGuid().ToString();
                        LL = 188;
                        Chilkat.Email email;
                        LL = 189;
                        email = bundle.GetEmail(i);
                        LL = 191;
                        string Subject = email.Subject;
                        Subject = LOG.PullOutSingleQuotes(Subject);
                        LL = 192;
                        string EmailFrom = email.From;
                        LL = 193;
                        string FromAddress = email.FromAddress;
                        LL = 194;
                        string FromName = email.FromName;
                        LL = 195;
                        string From = email.From;
                        LL = 196;
                        string EntryID = email.Uidl;
                        LL = 197;
                        if (strReject.Trim().Length > 0)
                        {
                            LL = 198;
                            var A = strReject.Split(',');
                            LL = 199;
                            var loopTo2 = (long)Information.UBound(A);
                            for (ii = 0L; ii <= loopTo2; ii++)
                            {
                                LL = 200;
                                string S1 = A[(int)ii].Trim();
                                LL = 201;
                                if (S1.Trim().Length > 0)
                                {
                                    LL = 202;
                                    if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                    {
                                        LL = 203;
                                        // LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                        LL = 204;
                                        RejectedCount += 1;
                                        LL = 205;
                                        goto NextRec;
                                        LL = 206;
                                    }

                                    LL = 207;
                                }

                                LL = 208;
                            }

                            LL = 209;
                        }

                        LL = 210;
                        LL = 211;
                        NbrDaysOld = email.NumDaysOld;
                        LL = 212;
                        if (NbrDaysOld >= DaysToHold)
                        {
                            LL = 213;
                            success = imap.SetMailFlag(email, "Deleted", 1);
                            LL = 214;
                            if (success != true)
                            {
                                LL = 215;
                                string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                LL = 216;
                                Msg += "FromName: " + FromName + Constants.vbCrLf;
                                LL = 217;
                                Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                LL = 218;
                                LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                                LL = 219;
                            }

                            LL = 220;
                        }

                        LL = 221;
                        LL = 222;
                        int NumAlternatives = email.NumAlternatives;
                        LL = 223;
                        int NumAttachedMessages = email.NumAttachedMessages;
                        LL = 224;
                        int NumAttachments = email.NumAttachments;
                        LL = 225;
                        int NumBcc = email.NumBcc;
                        LL = 226;
                        int NumCC = email.NumCC;
                        LL = 227;
                        int NumTo = email.NumTo;
                        LL = 228;
                        string ReplyTo = email.ReplyTo;
                        LL = 229;
                        string SignedBy = email.SignedBy;
                        LL = 230;
                        int EmailSize = email.Size;
                        LL = 231;
                        string LocalDate = email.LocalDate.ToString();
                        LL = 232;
                        string EmailDate = email.EmailDate.ToString();
                        LL = 233;
                        string Header = email.Header;
                        LL = 234;
                        string EmailBody = email.Body;
                        LL = 235;
                        EmailBody = LOG.PullOutSingleQuotes(EmailBody);
                        LL = 236;
                        LL = 237;
                        var Recipients = new ArrayList();
                        LL = 238;
                        var EmailTo = new ArrayList();
                        LL = 239;
                        var EmailToAddr = new ArrayList();
                        LL = 240;
                        var EmailToName = new ArrayList();
                        LL = 241;
                        var Bcc = new ArrayList();
                        LL = 242;
                        var BccAddr = new ArrayList();
                        LL = 243;
                        var BccName = new ArrayList();
                        LL = 244;
                        var CC = new ArrayList();
                        LL = 245;
                        var CcAddr = new ArrayList();
                        LL = 246;
                        var CcName = new ArrayList();
                        LL = 247;
                        bool bLoadAttachments = false;
                        LL = 248;
                        LL = 249;
                        int J = 0;
                        LL = 250;
                        LL = 251;
                        string tEmailDate = EmailDate.ToString();
                        LL = 252;
                        FixDate(ref tEmailDate);
                        LL = 253;
                        string tSubject = Strings.Mid(Subject, 1, 100);
                        LL = 254;
                        RemoveBadChars(ref tSubject);
                        LL = 255;
                        LL = 256;
                        string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject);
                        string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                        bool bEmailExists = DBARCH.ExchangeEmailExists(EmailIdentifier);
                        LL = 260;
                        if (bEmailExists)
                        {
                            LL = 261;
                            LL = 262;
                            // frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
                            LL = 263;
                            // frmExchangeMonitor.lblMessageInfo.Refresh()
                            LL = 264;
                            System.Windows.Forms.Application.DoEvents();
                            LL = 265;
                            LL = 266;
                            int DaysOld = email.NumDaysOld;
                            LL = 267;
                            if (DaysOld > DaysToHold)
                            {
                                LL = 268;
                                success = imap.SetMailFlag(email, "Deleted", 1);
                                LL = 269;
                                if (success != true)
                                {
                                    LL = 270;
                                    string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                    LL = 271;
                                    Msg += "FromName: " + FromName + Constants.vbCrLf;
                                    LL = 272;
                                    Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                    LL = 273;
                                    LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                                    LL = 274;
                                }

                                LL = 275;
                            }

                            LL = 276;
                            goto NextRec;
                        }

                        LL = 279;
                        LL = 280;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + i.ToString());
                        LL = 281;
                        bool B = DBARCH.ExchangeEmailExists(EmailIdentifier);
                        LL = 282;
                        if (B)
                        {
                            LL = 283;
                            if (srv_DetailedLogging)
                                LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + i.ToString());
                            LL = 284;
                            goto NextRec;
                            LL = 285;
                        }

                        LL = 286;
                        LL = 287;
                        string EmailFQN = EmailDir + @"\Email~" + NewGuid + "~.EML";
                        LL = 288;
                        LL = 289;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyEmailBundle 800.4: " + i.ToString());
                        LL = 290;
                        if (NumAttachments > 0)
                        {
                            LL = 291;
                            // ** Clean out the directory
                            LL = 292;
                            deleteDirectoryFile(AttachmentDir);
                            LL = 293;
                            // Save attachments to the "attachments" directory.
                            LL = 294;
                            email.SaveAllAttachments(AttachmentDir);
                            LL = 295;
                            bLoadAttachments = true;
                            LL = 296;
                        }

                        LL = 297;
                        LL = 298;
                        if (NumAttachedMessages > 0)
                        {
                            LL = 299;
                            // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                            LL = 300;
                            var loopTo3 = (long)(NumAttachedMessages - 1);
                            for (ii = 0L; ii <= loopTo3; ii++)
                            {
                                LL = 301;
                                // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                                LL = 302;
                                var objEmail = email.GetAttachedMessage((int)ii);
                                LL = 303;
                                ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                                LL = 304;
                                objEmail = null;
                                LL = 305;
                            }

                            LL = 306;
                        }

                        LL = 307;
                        LL = 308;
                        var loopTo4 = NumCC - 1;
                        for (J = 0; J <= loopTo4; J++)
                        {
                            LL = 309;
                            CC.Add(email.GetCC(J).ToString());
                            LL = 310;
                            CcAddr.Add(email.GetCcAddr(J).ToString());
                            LL = 311;
                            CcName.Add(email.GetCcName(J).ToString());
                            LL = 312;
                            if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                            {
                                LL = 313;
                                Recipients.Add(email.GetCcAddr(J).ToString());
                                LL = 314;
                            }

                            LL = 315;
                        }

                        LL = 316;
                        var loopTo5 = NumBcc - 1;
                        for (J = 0; J <= loopTo5; J++)
                        {
                            LL = 317;
                            Bcc.Add(email.GetBcc(J).ToString());
                            LL = 318;
                            BccName.Add(email.GetBccName(J).ToString());
                            LL = 319;
                            BccAddr.Add(email.GetBccAddr(J).ToString());
                            LL = 320;
                            if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                            {
                                LL = 321;
                                Recipients.Add(email.GetBccAddr(J).ToString());
                                LL = 322;
                            }

                            LL = 323;
                        }

                        LL = 324;
                        var loopTo6 = NumTo - 1;
                        for (J = 0; J <= loopTo6; J++)
                        {
                            LL = 325;
                            EmailTo.Add(email.GetTo(J).ToString());
                            LL = 326;
                            EmailToAddr.Add(email.GetToAddr(J).ToString());
                            LL = 327;
                            EmailToName.Add(email.GetToName(J).ToString());
                            LL = 328;
                            if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                            {
                                LL = 329;
                                Recipients.Add(email.GetToAddr(J).ToString());
                                LL = 330;
                            }

                            LL = 331;
                        }

                        LL = 332;
                        LL = 333;
                        // Save the email to XML
                        LL = 334;
                        // email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
                        LL = 335;
                        LL = 336;
                        // Save the email to EML
                        LL = 337;
                        // Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                        LL = 338;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyIMapBundle 900.0: " + i.ToString());
                        LL = 339;
                        email.SaveEml(EmailFQN);
                        LL = 340;
                        LL = 341;
                        // **********************************************************
                        LL = 342;
                        // IF CONVERT TO MSG THEN
                        LL = 343;
                        // READ IN THE NEW EML
                        LL = 344;
                        // CONVERT IT TO MSG
                        LL = 345;
                        // WRITE OUT THE MSG
                        LL = 346;
                        // SAVE THE MSG IMAGE INTO THE REPOSITORY.
                        LL = 347;
                        LL = 348;
                        if (bEmlToMSG == true)
                        {
                            LL = 349;
                            LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN '" + EmailFQN + "'");
                            LL = 350;
                            EmailFQN = convertEmlToMsg(EmailFQN);
                            LL = 351;
                        }

                        LL = 352;
                        // **********************************************************
                        LL = 353;
                        LL = 354;
                        LL = 355;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyIMapBundle 900.1: " + i.ToString());
                        LL = 356;
                        var AttachedFiles = new List<string>();
                        LL = 357;
                        getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                        LL = 358;
                        LL = 359;
                        string DB_ID = "ECM.Library";
                        LL = 360;
                        string Server_UserID_StoreID = CurrMailFolder;
                        LL = 361;
                        LL = 362;
                        // ** Now, Load the EMAIL and its metadata into the repository
                        LL = 363;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + i.ToString());
                        LL = 364;
                        LL = 365;
                        bool AttachmentsLoaded = false;
                        LL = 366;
                        LL = 367;
                        ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, Conversions.ToDate(EmailDate), UserLoginID, Conversions.ToDate(LocalDate), Conversions.ToDate(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                        LL = 389;
                        LL = 390;
                        if (AttachmentsLoaded == true)
                        {
                            LL = 391;
                            bool DoThis = false;
                            LL = 392;
                            if (DoThis)
                            {
                                LL = 393;
                                if (AttachmentsLoaded == true)
                                {
                                    LL = 394;
                                    DBARCH.AppendOcrTextEmail(NewGuid);
                                    LL = 395;
                                    AttachmentsLoaded = false;
                                    LL = 396;
                                }

                                LL = 397;
                            }

                            LL = 398;
                        }

                        LL = 400;
                        NextRec:
                        ;
                        LL = 401;
                        if (srv_DetailedLogging)
                            LOG.WriteToArchiveLog("ApplyIMapBundle 1000: " + i.ToString());
                        LL = 402;
                        LL = 403;
                    }

                    LL = 404;
                    // *****************************************************************************
                    LL = 405;
                    if (ExitUponCompletion == true)
                    {
                        LL = 406;
                        break;
                        LL = 407;
                    }

                    LL = 408;
                    if (DownLoadSize > MessagesRemainingToProcess)
                    {
                        LL = 409;
                        DownLoadSize = MessagesRemainingToProcess;
                        LL = 410;
                        // Increment = MessagesRemainingToProcess
                        LL = 411;
                        numToFetch = MessagesRemainingToProcess;
                        LL = 412;
                    }
                    else
                    {
                        LL = 413;
                        numToFetch = DownLoadSize;
                        LL = 414;
                    }

                    LL = 415;
                    startSeqNum = startSeqNum + Increment;
                    LL = 416;
                    LL = 417;
                    LL = 418;
                    if (numToFetch > 0L)
                    {
                        LL = 419;
                        bundle = imap.FetchSequence((int)startSeqNum, (int)numToFetch);
                        LL = 420;
                        if (bundle is null)
                        {
                            LL = 421;
                            LOG.WriteToArchiveLog("Warning - termination - getImapEmailSSL 400: End of process.");
                            LL = 422;
                            break;
                            LL = 423;
                        }

                        LL = 424;
                    }

                    LL = 426;
                }

                LL = 427;
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 100 getImapEmailSSL: LL = " + LL.ToString() + ": " + ex.Message);
                RC = false;
            }

            ENDIT:
            ;
            imap.Expunge();
            LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString());

            // Disconnect from the IMAP server.
            imap.Disconnect();
            messageSet = null;
            imap = null;
            bundle = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: ";
            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
            return RC;
        }

        public bool getIMapEmailV3(string UID, string MailServerAddr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
        {
            bool RC = true;
            int LL = 0;
            var imap = new Chilkat.Imap();
            int RecjectCount = 1;
            int EmailsProcessedThisRun = 0;
            int DownLoadSize = 0;
            string sDownLoadSize = "";
            int Increment = 0;
            long I = 0L;
            imap.ReadTimeout = 360;
            try
            {
                string ServerName = MailServerAddr + ":" + UserLoginID;
                string TempDir = Path.GetTempPath();
                string AttachmentDir = TempDir + @"Email\Attachment";
                string EmailDir = TempDir + "Email";
                string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
                bool Success = false;
                imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
                Success = imap.Connect(MailServerAddr);
                if (!Success)
                {
                    return false;
                    MessageBox.Show(imap.LastErrorText);
                }

                Success = imap.Login(UserLoginID, LoginPassWord);
                if (!Success)
                {
                    MessageBox.Show(imap.LastErrorText);
                    return false;
                }

                if (!Success)
                {
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    LOG.WriteToArchiveLog("FATAL ERROR: IMAP 300.1 Failed to log on to " + MailServerAddr + ", aborting.");
                    return false;
                }
                else
                {
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                }
                // Get the names of all the mailboxes.
                Chilkat.Mailboxes mboxes;
                mboxes = imap.ListMailboxes("", "*");
                for (int iii = 0, loopTo = mboxes.Count - 1; iii <= loopTo; iii++)
                {
                    Console.WriteLine(mboxes.GetName(iii));
                    string mName = mboxes.GetName(iii);
                    My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Mailbox: " + mboxes.GetName(iii);
                    My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                }

                // Once the mailbox is selected, the NumMessages property will contain the number of
                // messages in the mailbox. You may loop from 1 to NumMessages to fetch each message by
                // sequence number.
                bool BB = imap.SelectMailbox("Inbox");
                if (!BB)
                {
                    return false;
                }

                Increment = DownLoadSize;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                System.Windows.Forms.Application.DoEvents();
                Chilkat.EmailBundle bundle;
                bool ExitUponCompletion = false;
                bool fetchUids = true;
                REDO:
                ;
                int NumberOfMessagesInBox = imap.NumMessages;
                int RejectedCount = 0;
                bool bUid;
                bUid = false;
                Chilkat.Email email;
                NumberOfMessagesInBox = imap.NumMessages;
                int MessagesProcessed = 0;
                int MessagesRemainingToProcess = NumberOfMessagesInBox;
                TotalEmailsInArchive = 0;
                TimeSpan ElapsedTime;
                TimeSpan ElapsedTxTime;
                DateInterval ETime;
                DateInterval txTime;
                var StartTime = DateAndTime.Now;
                for (int iCnt = 1, loopTo1 = NumberOfMessagesInBox; iCnt <= loopTo1; iCnt++)
                {

                    // Download the email by sequence number.
                    ElapsedTxTime = DateAndTime.Now.Subtract(StartTime);
                    StartTime = DateAndTime.Now;
                    email = imap.FetchSingle(iCnt, bUid);
                    string EntryID = email.Uidl;
                    ElapsedTime = DateAndTime.Now.Subtract(StartTime);
                    My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr;
                    My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                    My.MyProject.Forms.frmExchangeMonitor.lblSpeed.Text = ElapsedTime.ToString();
                    My.MyProject.Forms.frmExchangeMonitor.txTime.Text = ElapsedTxTime.ToString();
                    My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                    System.Windows.Forms.Application.DoEvents();

                    // *******************************************************************************
                    bool ExitNow = false;
                    TotalEmailsInArchive += 1;
                    EmailsProcessedThisRun += 1;
                    MessagesRemainingToProcess = MessagesRemainingToProcess - 1;
                    My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + NumberOfMessagesInBox.ToString();
                    My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    string NewGuid = Guid.NewGuid().ToString();
                    string Subject = email.Subject;
                    Subject = LOG.PullOutSingleQuotes(Subject);
                    string EmailFrom = email.From;
                    string FromAddress = email.FromAddress;
                    string FromName = email.FromName;
                    string From = email.From;
                    if (strReject.Trim().Length > 0)
                    {
                        var A = strReject.Split(',');
                        for (int II = 0, loopTo2 = Information.UBound(A); II <= loopTo2; II++)
                        {
                            string S1 = A[II].Trim();
                            if (S1.Trim().Length > 0)
                            {
                                if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                {
                                    // LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                    RejectedCount += 1;
                                    goto NextRec;
                                }
                            }
                        }
                    }

                    int NbrDaysOld = email.NumDaysOld;
                    if (NbrDaysOld >= DaysToHold)
                    {
                        Success = imap.SetMailFlag(email, "Deleted", 1);
                        if (Success != true)
                        {
                            string Msg = "Subject: " + Subject + Constants.vbCrLf;
                            Msg += "FromName: " + FromName + Constants.vbCrLf;
                            Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                            LOG.WriteToArchiveLog("ERROR: getIMapEmail: Failed to delete email from server:" + Constants.vbCrLf + Msg);
                        }
                    }

                    int NumAlternatives = email.NumAlternatives;
                    int NumAttachedMessages = email.NumAttachedMessages;
                    int NumAttachments = email.NumAttachments;
                    int NumBcc = email.NumBcc;
                    int NumCC = email.NumCC;
                    int NumTo = email.NumTo;
                    string ReplyTo = email.ReplyTo;
                    string SignedBy = email.SignedBy;
                    int EmailSize = email.Size;
                    string LocalDate = email.LocalDate.ToString();
                    string EmailDate = email.EmailDate.ToString();
                    string Header = email.Header;
                    string EmailBody = email.Body;
                    EmailBody = LOG.PullOutSingleQuotes(EmailBody);
                    var Recipients = new ArrayList();
                    var EmailTo = new ArrayList();
                    var EmailToAddr = new ArrayList();
                    var EmailToName = new ArrayList();
                    var Bcc = new ArrayList();
                    var BccAddr = new ArrayList();
                    var BccName = new ArrayList();
                    var CC = new ArrayList();
                    var CcAddr = new ArrayList();
                    var CcName = new ArrayList();
                    bool bLoadAttachments = false;
                    string tEmailDate = EmailDate.ToString();
                    FixDate(ref tEmailDate);
                    string tSubject = Strings.Mid(Subject, 1, 100);
                    RemoveBadChars(ref tSubject);
                    string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject);
                    string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                    bool bEmailExists = DBARCH.ExchangeEmailExists(EmailIdentifier);
                    if (bEmailExists)
                    {
                        System.Windows.Forms.Application.DoEvents();
                        int DaysOld = email.NumDaysOld;
                        if (DaysOld < 0)
                        {
                            DaysOld = 1;
                        }

                        if (DaysOld > DaysToHold)
                        {
                            Success = imap.SetMailFlag(email, "Deleted", 1);
                            if (Success != true)
                            {
                                string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                Msg += "FromName: " + FromName + Constants.vbCrLf;
                                Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                            }
                        }

                        goto NextRec;
                    }

                    // If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + I.ToString)
                    // Dim B As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier)
                    // If B Then
                    // If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + I.ToString)
                    // GoTo NextRec
                    // End If

                    string EmailFQN = EmailDir + @"\Email~" + NewGuid + "~.EML";
                    if (NumAttachedMessages > 0)
                    {
                        for (int II = 0, loopTo3 = NumAttachedMessages - 1; II <= loopTo3; II++)
                        {
                            // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                            var objEmail = email.GetAttachedMessage(II);
                            ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                            objEmail = null;
                        }
                    }

                    for (int J = 0, loopTo4 = NumCC - 1; J <= loopTo4; J++)
                    {
                        CC.Add(email.GetCC(J).ToString());
                        CcAddr.Add(email.GetCcAddr(J).ToString());
                        CcName.Add(email.GetCcName(J).ToString());
                        if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetCcAddr(J).ToString());
                        }
                    }

                    for (int J = 0, loopTo5 = NumBcc - 1; J <= loopTo5; J++)
                    {
                        Bcc.Add(email.GetBcc(J).ToString());
                        BccName.Add(email.GetBccName(J).ToString());
                        BccAddr.Add(email.GetBccAddr(J).ToString());
                        if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetBccAddr(J).ToString());
                        }
                    }

                    for (int J = 0, loopTo6 = NumTo - 1; J <= loopTo6; J++)
                    {
                        EmailTo.Add(email.GetTo(J).ToString());
                        EmailToAddr.Add(email.GetToAddr(J).ToString());
                        EmailToName.Add(email.GetToName(J).ToString());
                        if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetToAddr(J).ToString());
                        }
                    }

                    email.SaveEml(EmailFQN);
                    if (bEmlToMSG == true)
                    {
                        LOG.WriteToArchiveLog("Notice from getImapEmail 300 : FQN '" + EmailFQN + "'");
                        EmailFQN = convertEmlToMsg(EmailFQN);
                    }

                    var AttachedFiles = new List<string>();
                    getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                    string DB_ID = "ECM.Library";
                    string Server_UserID_StoreID = CurrMailFolder;

                    // ** Now, Load the EMAIL and its metadata into the repository
                    if (srv_DetailedLogging)
                        LOG.WriteToArchiveLog("ApplyIMapBundle 900.2: " + I.ToString());
                    bool AttachmentsLoaded = false;
                    ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, Conversions.ToDate(EmailDate), UserLoginID, Conversions.ToDate(LocalDate), Conversions.ToDate(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                    if (AttachmentsLoaded == true)
                    {
                        bool DoThis = false;
                        if (DoThis)
                        {
                            if (AttachmentsLoaded == true)
                            {
                                DBARCH.AppendOcrTextEmail(NewGuid);
                                AttachmentsLoaded = false;
                            }
                        }
                    }

                    if (NumAttachments > 0)
                    {
                        // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                        for (int II = 0, loopTo7 = NumAttachments - 1; II <= loopTo7; II++)
                            // 'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                            // Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
                            // objEmail.Dispose()
                            LoadEmailAttachments(AttachmentDir, NewGuid);
                    }

                    NextRec:
                    ;
                }
            }
            // ***************************************************************
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: 2699 getIMapEmail: " + ex.Message);
                RC = false;
            }
            finally
            {
                // Disconnect from the IMAP server. This example removes the deleted email on the IMAP server.
                imap.Expunge();
                imap.Disconnect();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }

            ENDIT:
            ;

            // Save the email to an XML file
            // bundle.SaveXml("bundle.xml")
            LOG.WriteToArchiveLog("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString());
            LOG.WriteToArchiveLog("Applying IMAP Bundle PROCESSED Message Count = " + TotalEmailsInArchive.ToString());
            LOG.WriteToArchiveLog("INFO: Emails processed this run  = " + EmailsProcessedThisRun.ToString() + " from " + MailServerAddr);
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Emails Processed: ";
            My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
            System.Windows.Forms.Application.DoEvents();
            return RC;
        }

        public bool getImapEmailSSLV3(string UID, string MailServerAddr, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG, bool UseSSL)
        {
            bool RC = false;
            int LL = 1;
            var imap = new Chilkat.Imap();
            int RejectedCount = 0;
            Chilkat.MessageSet messageSet;
            Chilkat.EmailBundle bundle;
            try
            {
                string ServerName = MailServerAddr + ":" + UserLoginID;
                bool success = false;
                string TempDir = Path.GetTempPath();
                string AttachmentDir = TempDir + @"Email\Attachment";
                string EmailDir = TempDir + "Email";
                string CurrMailFolder = MailServerAddr + ":" + UserLoginID;

                // Anything unlocks the component and begins a fully-functional 30-day trial.
                success = imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
                if (success != true)
                {
                    MessageBox.Show(imap.LastErrorText);
                    return false;
                }

                // To use a secure SSL connection, set SSL and the port:
                imap.Ssl = UseSSL;
                // The typical port for IMAP SSL is 993
                if (PortNbr.Length == 0)
                {
                    imap.Port = 993;
                }
                else
                {
                    imap.Port = (int)Conversion.Val(PortNbr);
                }

                // Connect to an IMAP server.
                success = imap.Connect(MailServerAddr);
                if (success != true)
                {
                    LOG.WriteToArchiveLog("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText);
                    return false;
                }
                else
                {
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                }

                success = imap.Login(UserLoginID, LoginPassWord);
                if (success != true)
                {
                    MessageBox.Show(imap.LastErrorText);
                    LOG.WriteToArchiveLog("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText);
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    return false;
                }
                else
                {
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
                    My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                }
                // Get the names of all the mailboxes.
                Chilkat.Mailboxes mboxes;
                mboxes = imap.ListMailboxes("", "*");
                long ii;
                var loopTo = (long)(mboxes.Count - 1);
                for (ii = 0L; ii <= loopTo; ii++)
                    Console.WriteLine(mboxes.GetName((int)ii));
                success = imap.SelectMailbox("Inbox");
                if (success != true)
                {
                    MessageBox.Show(imap.LastErrorText);
                    LOG.WriteToArchiveLog("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText);
                    return false;
                }

                // After selecting a mailbox, the NumMessages property will be updated to reflect the
                // total number of emails in the mailbox:
                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Download: " + imap.NumMessages.ToString() + " messages.";
                My.MyProject.Forms.frmExchangeMonitor.lblMsg.Refresh();
                System.Windows.Forms.Application.DoEvents();
                int NumberOfMessagesInBox = imap.NumMessages;
                if (NumberOfMessagesInBox > 0)
                {
                    LOG.WriteToArchiveLog("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                }
                else
                {
                    LOG.WriteToArchiveLog("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString());
                    goto ENDIT;
                }

                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email Host: " + MailServerAddr;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Text = "Email ID: " + UserLoginID;
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                My.MyProject.Forms.frmExchangeMonitor.lblServer.Refresh();
                System.Windows.Forms.Application.DoEvents();
                bool bUid;
                bUid = false;
                Chilkat.Email email;
                NumberOfMessagesInBox = imap.NumMessages;
                int MessagesProcessed = 0;
                int MessagesRemainingToProcess = NumberOfMessagesInBox;
                TotalEmailsInArchive = 0;
                for (int iCnt = 1, loopTo1 = NumberOfMessagesInBox; iCnt <= loopTo1; iCnt++)
                {

                    // Download the email by sequence number.
                    email = imap.FetchSingle(iCnt, bUid);
                    string EntryID = email.Uidl;
                    TotalEmailsInArchive += 1;
                    MessagesRemainingToProcess = MessagesRemainingToProcess - 1;
                    My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + imap.NumMessages.ToString();
                    My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    string NewGuid = Guid.NewGuid().ToString();
                    string Subject = email.Subject;
                    Subject = LOG.PullOutSingleQuotes(Subject);
                    string EmailFrom = email.From;
                    string FromAddress = email.FromAddress;
                    string FromName = email.FromName;
                    string From = email.From;
                    if (strReject.Trim().Length > 0)
                    {
                        var A = strReject.Split(',');
                        var loopTo2 = (long)Information.UBound(A);
                        for (ii = 0L; ii <= loopTo2; ii++)
                        {
                            string S1 = A[(int)ii].Trim();
                            if (S1.Trim().Length > 0)
                            {
                                if (Conversions.ToBoolean(Strings.InStr(Subject, S1, CompareMethod.Text)))
                                {
                                    // LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
                                    RejectedCount += 1;
                                    goto NextRec;
                                }
                            }
                        }
                    }

                    int NbrDaysOld = 0;
                    NbrDaysOld = email.NumDaysOld;
                    if (NbrDaysOld >= DaysToHold)
                    {
                        success = imap.SetMailFlag(email, "Deleted", 1);
                        if (success != true)
                        {
                            string Msg = "Subject: " + Subject + Constants.vbCrLf;
                            Msg += "FromName: " + FromName + Constants.vbCrLf;
                            Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                            LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                        }
                    }

                    int NumAlternatives = email.NumAlternatives;
                    int NumAttachedMessages = email.NumAttachedMessages;
                    int NumAttachments = email.NumAttachments;
                    int NumBcc = email.NumBcc;
                    int NumCC = email.NumCC;
                    int NumTo = email.NumTo;
                    string ReplyTo = email.ReplyTo;
                    string SignedBy = email.SignedBy;
                    int EmailSize = email.Size;
                    string LocalDate = email.LocalDate.ToString();
                    string EmailDate = email.EmailDate.ToString();
                    string Header = email.Header;
                    string EmailBody = email.Body;
                    EmailBody = LOG.PullOutSingleQuotes(EmailBody);
                    var Recipients = new ArrayList();
                    var EmailTo = new ArrayList();
                    var EmailToAddr = new ArrayList();
                    var EmailToName = new ArrayList();
                    var Bcc = new ArrayList();
                    var BccAddr = new ArrayList();
                    var BccName = new ArrayList();
                    var CC = new ArrayList();
                    var CcAddr = new ArrayList();
                    var CcName = new ArrayList();
                    bool bLoadAttachments = false;
                    int J = 0;
                    string tEmailDate = EmailDate.ToString();
                    FixDate(ref tEmailDate);
                    string tSubject = Strings.Mid(Subject, 1, 100);
                    RemoveBadChars(ref tSubject);
                    string EmailIdentifier = UTIL.genEmailIdentifier(email.EmailDate, email.From, Subject);
                    string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
                    bool bEmailExists = DBARCH.ExchangeEmailExists(EmailIdentifier);
                    if (bEmailExists)
                    {
                        System.Windows.Forms.Application.DoEvents();
                        int DaysOld = email.NumDaysOld;
                        if (DaysOld > DaysToHold)
                        {
                            success = imap.SetMailFlag(email, "Deleted", 1);
                            if (success != true)
                            {
                                string Msg = "Subject: " + Subject + Constants.vbCrLf;
                                Msg += "FromName: " + FromName + Constants.vbCrLf;
                                Msg += "FromAddress: " + FromAddress + Constants.vbCrLf;
                                LOG.WriteToArchiveLog("ERROR getIMapEmail: Failed to delete email:" + Constants.vbCrLf + Msg);
                            }
                        }

                        goto NextRec;
                    }

                    // Dim B As Boolean = DBARCH.ExchangeEmailExists(EmailIdentifier, EmailHashCode)
                    // If B Then
                    // GoTo NextRec
                    // End If

                    string EmailFQN = EmailDir + @"\Email~" + NewGuid + "~.EML";
                    if (NumAttachments > 0)
                    {
                        // ** Clean out the directory
                        deleteDirectoryFile(AttachmentDir);
                        // Save attachments to the "attachments" directory.
                        email.SaveAllAttachments(AttachmentDir);
                        bLoadAttachments = true;
                    }

                    if (NumAttachedMessages > 0)
                    {
                        // email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
                        var loopTo3 = (long)(NumAttachedMessages - 1);
                        for (ii = 0L; ii <= loopTo3; ii++)
                        {
                            // email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
                            var objEmail = email.GetAttachedMessage((int)ii);
                            ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
                            objEmail = null;
                        }
                    }

                    var loopTo4 = NumCC - 1;
                    for (J = 0; J <= loopTo4; J++)
                    {
                        CC.Add(email.GetCC(J).ToString());
                        CcAddr.Add(email.GetCcAddr(J).ToString());
                        CcName.Add(email.GetCcName(J).ToString());
                        if (!Recipients.Contains(email.GetCcAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetCcAddr(J).ToString());
                        }
                    }

                    var loopTo5 = NumBcc - 1;
                    for (J = 0; J <= loopTo5; J++)
                    {
                        Bcc.Add(email.GetBcc(J).ToString());
                        BccName.Add(email.GetBccName(J).ToString());
                        BccAddr.Add(email.GetBccAddr(J).ToString());
                        if (!Recipients.Contains(email.GetBccAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetBccAddr(J).ToString());
                        }
                    }

                    var loopTo6 = NumTo - 1;
                    for (J = 0; J <= loopTo6; J++)
                    {
                        EmailTo.Add(email.GetTo(J).ToString());
                        EmailToAddr.Add(email.GetToAddr(J).ToString());
                        EmailToName.Add(email.GetToName(J).ToString());
                        if (!Recipients.Contains(email.GetToAddr(J).ToString()))
                        {
                            Recipients.Add(email.GetToAddr(J).ToString());
                        }
                    }

                    // Save the email to XML
                    // email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")

                    // Save the email to EML
                    // Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
                    email.SaveEml(EmailFQN);

                    // **********************************************************
                    // IF CONVERT TO MSG THEN
                    // READ IN THE NEW EML
                    // CONVERT IT TO MSG
                    // WRITE OUT THE MSG
                    // SAVE THE MSG IMAGE INTO THE REPOSITORY.

                    if (bEmlToMSG == true)
                    {
                        LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN '" + EmailFQN + "'");
                        EmailFQN = convertEmlToMsg(EmailFQN);
                    }
                    // **********************************************************

                    var AttachedFiles = new List<string>();
                    getDirectoryFiles(AttachmentDir, ref AttachedFiles);
                    string DB_ID = "ECM.Library";
                    string Server_UserID_StoreID = CurrMailFolder;

                    // ** Now, Load the EMAIL and its metadata into the repository
                    bool AttachmentsLoaded = false;
                    ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, Conversions.ToDate(EmailDate), UserLoginID, Conversions.ToDate(LocalDate), Conversions.ToDate(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
                    if (AttachmentsLoaded == true)
                    {
                        bool DoThis = false;
                        if (DoThis)
                        {
                            if (AttachmentsLoaded == true)
                            {
                                DBARCH.AppendOcrTextEmail(NewGuid);
                                AttachmentsLoaded = false;
                            }
                        }
                    }

                    NextRec:
                    ;
                }
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 100 getImapEmailSSL: LL = " + LL.ToString() + ": " + ex.Message);
                RC = false;
            }

            ENDIT:
            ;
            imap.Expunge();
            LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString());
            // Disconnect from the IMAP server.
            imap.Disconnect();
            messageSet = null;
            imap = null;
            bundle = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Text = "Emails Processed: ";
            My.MyProject.Forms.frmExchangeMonitor.lblCnt.Refresh();
            return RC;
        }

        public void LoadEmailAttachments(string DirectoryFQN, string EmailGuid)
        {
            string RetentionCode = "Retain 10";
            string ispublic = "N";
            string strFileSize = "";
            var di = new DirectoryInfo(DirectoryFQN);
            var aryFi = di.GetFiles("*.*");
            int StackLevel = 0;
            var ListOfFiles = new Dictionary<string, int>();
            foreach (var fi in aryFi)
            {
                string filename = fi.FullName;
                string FileNameOnly = fi.Name;
                string FileExt = fi.Extension;
                if (File.Exists(filename))
                {
                    bool isZipFile = ZF.isZipFile(filename);
                    if (isZipFile == true)
                    {
                        // ** Explode and load
                        string AttachmentName = filename;
                        bool SkipIfAlreadyArchived = false;
                        bool AttachmentsLoaded = false;
                        ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, filename, modGlobals.gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        FileExt = "." + UTIL.getFileSuffix(filename);
                        string AttachmentName = filename;
                        string Sha1Hash = ENC.GenerateSHA512HashFromFile(filename);
                        bool bbx = DBARCH.InsertAttachmentFqn(modGlobals.gCurrUserGuidID, filename, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, DirectoryFQN);
                        if (FileExt.ToUpper().Equals(".PDF"))
                        {
                            TotalOcr += 1;
                            My.MyProject.Forms.frmExchangeMonitor.lblMsg.Text = "Total OCR: " + TotalOcr.ToString();
                            // **WDM DBARCH.PDFXTRACT(EmailGuid, filename , "EMAIL")
                        }
                    }
                }
            }
        }

        private void PurgeDirectory(string DirFqn)
        {
            string[] S;
            S = Directory.GetFiles(DirFqn);
            foreach (var DELFILE in S)
                File.Delete(DELFILE);
        }
    }
}