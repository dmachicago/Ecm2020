#define RemoteOcr
#define Redemption
#define UseEmailChunks
// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using Redemption;
using System.Data.SqlClient;
using System.IO;
using System.Xml;
using System.Threading;
using Microsoft.Office.Interop;
using Microsoft.Office.Interop.Outlook;
using Microsoft.VisualBasic.CompilerServices;




namespace EcmArchiveClcSetup
{
	public class clsEmailFunctions : clsArchiver
	{
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsDbLocal DBLocal = new clsDbLocal();
		
		int skippedEmails = 0;
		bool srv_DetailedLogging = false;
		double TotalMemory = 0;
		int TotalOcr = 0;
		int TotalOcrFailed = 0;
		
		int DaysToHold = 365;
		
		clsATTACHMENTTYPE ATYPE = new clsATTACHMENTTYPE();
		clsEMAIL EMAIL = new clsEMAIL();
		clsRECIPIENTS RECIPS = new clsRECIPIENTS();
		clsZipFiles ZF = new clsZipFiles();
		
		clsDatabase DB = new clsDatabase();
		
#if Redemption
		const int PR_ICON_INDEX = 0x10800003;
#endif
		
		int TotalEmailsInArchive = 0;
		bool dDebug_clsEmailFunctions = false;
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		clsEncrypt ENC = new clsEncrypt();
		
		SortedList SL = new SortedList();
		SortedList SL2 = new SortedList();
		
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
			{
				LOG.WriteToTraceLog("Entering LaunchExchangeDownload from clsEmailFunctions");
			}
			LOG.WriteToArchiveLog("Entering LaunchExchangeDownload from clsEmailFunctions");
			LOG.WriteToArchiveLog("GetExchangeFolders LaunchExchangeDownload 100");
			t = new Thread(new System.Threading.ThreadStart(this.ProcessExchangeServers));
			LOG.WriteToArchiveLog("GetExchangeFolders LaunchExchangeDownload 200");
			t.Priority = ThreadPriority.Lowest;
			t.Start();
			LOG.WriteToArchiveLog("Thread executing LaunchExchangeDownload from clsEmailFunctions");
		}
		
		//    Sub xxProcessExchangePopMail()
		
		//        If isArchiveDisabled("EXCHANGE") = True Then
		//            Return
		//        End If
		
		//        frmExchangeMonitor.Show()
		//        frmExchangeMonitor.Location = New Point(25, 50)
		//        frmExchangeMonitor.Refresh()
		//        System.Windows.Forms.Application.DoEvents()
		
		//        LOG.WriteToArchiveLog("Exchange Archive started @ " + Now.ToString)
		
		//        Try
		//            If gCurrentArchiveGuid .Length = 0 Then
		//                gCurrentArchiveGuid  = Guid.NewGuid.ToString
		//            End If
		
		//            If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("Starting ProcessExchangePopMail from clsEmailFunctions")
		//            Dim ArchiveGuid  = System.Guid.NewGuid.ToString()
		
		//            Dim S  = "Select [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL, IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM [ExchangeHostPop] order by [HostNameIp] ,[UserLoginID]"
		//            Dim rsData As SqlDataReader
		
		//            Dim DaysToRetain As Integer = 1000000
		//            Dim HostNameIp  = ""
		//            Dim UserLoginID  = ""
		//            Dim LoginPw  = ""
		//            Dim LeaveOnServer As Boolean = True
		//            Dim DeleteAfterDownload As Boolean = False
		//            Dim PortNbr  = ""
		//            Dim RetentionCode  = ""
		//            Dim retentionYears As Integer = 10
		//            Dim SSL As Boolean = False
		//            Dim IMap As Boolean = False
		//            Dim FolderName  = ""
		//            Dim LibraryName  = ""
		//            Dim isPublic As Boolean = False
		//            Dim strReject  = ""
		//            Dim ConvertEmlToMSG As Boolean = False
		
		//            rsData = SqlQryNewConn(S)
		
		//            If rsData.HasRows Then
		//                Do While rsData.Read()
		//                    System.Windows.Forms.Application.DoEvents()
		//                    '0 [HostNameIp],
		//                    '1 [UserLoginID],
		//                    '2 [LoginPw],
		//                    '3 [PortNbr],
		//                    '4 [DeleteAfterDownload],
		//                    '5 [RetentionCode],
		//                    '6 SSL,
		//                    '7 IMap,
		//                    '8 FolderName,
		//                    '9 LibraryName,
		//                    '10 isPublic
		//                    '11 DaysToHold
		//                    '12 strReject
		//                    '13 ConvertEmlToMSG
		//                    If gTerminateImmediately Then
		//                        Return
		//                    End If
		
		//                    Try
		//                        ConvertEmlToMSG = rsData.GetBoolean(13)
		//                    Catch ex As System.Exception
		//                        ConvertEmlToMSG = False
		//                    End Try
		
		//                    Try
		//                        LibraryName = rsData.GetValue(9).ToString
		//                    Catch ex As System.Exception
		//                        LibraryName = "NA"
		//                    End Try
		
		//                    Try
		//                        isPublic = rsData.GetBoolean(10)
		//                    Catch ex As System.Exception
		//                        isPublic = False
		//                    End Try
		
		//                    Try
		//                        DaysToRetain = rsData.GetInt32(11)
		//                    Catch ex As System.Exception
		//                        DaysToRetain = 1000000
		//                    End Try
		//                    Try
		//                        strReject = rsData.GetValue(12).ToString
		//                    Catch ex As System.Exception
		//                        strReject = ""
		//                    End Try
		
		
		//                    Dim LibraryOwnerUserID  = ""
		//                    If LibraryName.Trim.Length > 0 Then
		//                        LibraryOwnerUserID  = GetLibOwnerByName(LibraryName )
		//                    End If
		
		//                    Try
		//                        HostNameIp  = rsData.GetValue(0).ToString
		//                    Catch ex As System.Exception
		//                        HostNameIp  = ""
		//                    End Try
		
		//                    Try
		//                        UserLoginID = rsData.GetValue(1).ToString
		//                    Catch ex As System.Exception
		//                        UserLoginID = ""
		//                    End Try
		
		//                    'If ConvertEmlToMSG = True And gRedemptionDllExists = False Then
		//                    '    If gRunUnattended = False Then
		//                    '        if gRunUnattended = false then messagebox.show("ERROR ERROR - ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp  + " :" + LibraryName + " : " + UserLoginID + "' will not be processed.")
		//                    '    End If
		//                    '    log.WriteToArchiveLog("ERROR ERROR - ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp  + " :" + LibraryName + " : " + UserLoginID + "' will not be processed.")
		//                    '    GoTo NextBox
		//                    'End If
		
		//                    LoginPw = rsData.GetValue(2).ToString
		//                    LoginPw = ENC.AES256DecryptString(LoginPw)
		
		//                    Try
		//                        PortNbr  = rsData.GetValue(3).ToString
		//                    Catch ex As System.Exception
		//                        PortNbr  = ""
		//                    End Try
		//                    Try
		//                        Dim tDeleteAfterDownload  = rsData.GetValue(4).ToString
		//                        If tDeleteAfterDownload .Equals("False") Then
		//                            DeleteAfterDownload = False
		//                        Else
		//                            DeleteAfterDownload = True
		//                        End If
		//                    Catch ex As System.Exception
		//                        DeleteAfterDownload = False
		//                    End Try
		//                    Try
		//                        RetentionCode = rsData.GetValue(5).ToString
		//                    Catch ex As System.Exception
		//                        RetentionCode = ""
		//                    End Try
		//                    Try
		//                        Dim tSSL  = rsData.GetValue(6).ToString
		//                        If tSSL.Equals("False") Then
		//                            SSL = False
		//                        Else
		//                            SSL = True
		//                        End If
		//                    Catch ex As System.Exception
		//                        SSL = False
		//                    End Try
		//                    Try
		//                        Dim tIMap  = rsData.GetValue(7).ToString
		//                        If tIMap .Equals("False") Then
		//                            IMap = False
		//                        Else
		//                            IMap = True
		//                        End If
		//                    Catch ex As System.Exception
		//                        IMap = False
		//                    End Try
		
		//                    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 500 : " + HostNameIp )
		
		//                    retentionYears = getRetentionPeriod(RetentionCode )
		
		//                    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 500.1 : " + retentionYears.ToString)
		//                    If DeleteAfterDownload = False Then
		//                        LeaveOnServer = True
		//                    Else
		//                        LeaveOnServer = False
		//                    End If
		
		//                    LOG.WriteToArchiveLog("Processing Exchange Box " + HostNameIp  + " emails by " + UserLoginID)
		
		//                    frmExchangeMonitor.lblServer.Text = HostNameIp
		//                    frmExchangeMonitor.lblMessageInfo.Text = UserLoginID
		//                    System.Windows.Forms.Application.DoEvents()
		
		//                    If SSL = True And IMap = False Then
		//                        If PortNbr .Trim.Length = 0 Then
		//                            PortNbr  = "995"
		//                        End If
		//                        If PortNbr .Equals("-1") Then
		//                            PortNbr  = "995"
		//                        End If
		
		//                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 600 PortNbr : " + PortNbr )
		//                        LOG.WriteToArchiveLog("Processing Exchange SSL " + HostNameIp  + " emails by " + UserLoginID)
		//                        ReadEmailUsingSSL(HostNameIp , UserLoginID , LoginPw, _
		//                                          PortNbr , LeaveOnServer, retentionYears, _
		//                                          RetentionCode , LibraryName, isPublic, DaysToRetain, _
		//                                          strReject , ConvertEmlToMSG)
		//                    ElseIf IMap = True And SSL = True Then
		//                        If PortNbr .Trim.Length = 0 Then
		//                            PortNbr  = "993"
		//                        End If
		//                        If PortNbr .Equals("-1") Then
		//                            PortNbr  = "993"
		//                        End If
		//                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 700 PortNbr : " + PortNbr )
		//                        LOG.WriteToArchiveLog("Processing Exchange IMAP " + HostNameIp  + " emails by " + UserLoginID)
		//                        getImapEmailSSL(HostNameIp , _
		//                                           PortNbr , _
		//                                           UserLoginID , LoginPw, LeaveOnServer, _
		//                                           RetentionCode , retentionYears, _
		//                                           LibraryName, isPublic, DaysToRetain, strReject , ConvertEmlToMSG)
		//                    ElseIf IMap = True And SSL = False Then
		//                        If PortNbr .Trim.Length = 0 Then
		//                            PortNbr  = "993"
		//                        End If
		//                        If PortNbr .Equals("-1") Then
		//                            PortNbr  = "993"
		//                        End If
		//                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 800 PortNbr : " + PortNbr )
		//                        LOG.WriteToArchiveLog("Processing Exchange IMAP/SSL " + HostNameIp  + " emails by " + UserLoginID)
		//                        Me.getIMapEmail(HostNameIp , UserLoginID , LoginPw, _
		//                                        LeaveOnServer, RetentionCode , retentionYears, _
		//                                        LibraryName, isPublic, DaysToRetain, strReject , _
		//                                        ConvertEmlToMSG)
		//                    Else
		//                        If PortNbr .Trim.Length = 0 Then
		//                            PortNbr  = "110"
		//                        End If
		//                        If PortNbr .Equals("-1") Then
		//                            PortNbr  = "110"
		//                        End If
		//                        If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ProcessExchangePopMail 900 PortNbr : " + PortNbr )
		//                        LOG.WriteToArchiveLog("Processing Exchange POP " + HostNameIp  + " emails by " + UserLoginID)
		//                        ReadEmailFromServer(HostNameIp , PortNbr , UserLoginID , LoginPw, _
		//                                            LeaveOnServer, RetentionCode, retentionYears, _
		//                                            LibraryName, isPublic, DaysToRetain, strReject , _
		//                                            ConvertEmlToMSG)
		//                    End If
		//NextBox:
		//                Loop
		//            End If
		//            rsData.Close()
		//            rsData = Nothing
		//        Catch ex As System.Exception
		//            log.WriteToArchiveLog("ERROR 641.92.2 ProcessExchangePopMail - " + ex.Message)
		//        End Try
		//        LOG.WriteToArchiveLog("Exchange Archive completed @ " + Now.ToString)
		//        frmExchangeMonitor.Dispose()
		//    End Sub
		
		public string GetMailServerFromEmailAddr(string EmailAddr)
		{
			
			string ServerName = "";
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
			
			string fromAddr;
			fromAddr = EmailAddr;
			
			string mailServer;
			mailServer = (string) (mailman.MxLookup(fromAddr));
			if (mailServer == null)
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
				Chilkat.MailMan mailman = new Chilkat.MailMan();
				
				string EmailFrom = "";
				string EmailSubject = "";
				string EmailBody = "";
				
				//  Any string passed to UnlockComponent automatically begins a 30-day trial.
				bool success;
				success = System.Convert.ToBoolean(mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G"));
				if (success != true)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show((string) mailman.LastErrorText);
					}
					return;
				}
				
				// Set our POP3 hostname, login and password
				mailman.MailHost = "mail.chilkatsoft.com";
				mailman.PopUsername = "login";
				mailman.PopPassword = "password";
				
				// Connecting via SSL is possible by adding these lines:
				//mailman.PopSsl = true;
				// Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
				//mailman.MailPort = 995;
				// Download email from the POP3 server by calling TransferMail
				Chilkat.EmailBundle bundle;
				
				// WARNING - TransferMail() Deletes all transfered mail from the server.
				// bundle = mailman.TransferMail()
				// CopyMail() will leave it on the server
				bundle = mailman.CopyMail();
				
				if (bundle == null)
				{
					MessageBox.Show((string) mailman.LastErrorText);
					return;
				}
				
				int i;
				int n = System.Convert.ToInt32(bundle.MessageCount);
				for (i = 0; i <= n - 1; i++)
				{
					Chilkat.Email email = bundle.GetEmail(i);
					
					EmailFrom = (string) Email.From;
					EmailSubject = EMAIL.SUBJECT;
					EmailBody = EMAIL.Body;
					
				}
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 641.92.1 DownloadExchangeEmail - " + ex.Message));
			}
			
		}
		public void LoadEmGetAttachments(string FQN, string DownLoadDir)
		{
			//Load an EML file containing the MIME source of an email and save the attachments.
			string myEmaileml = FQN;
			Chilkat.Email email = new Chilkat.Email();
			//email.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G")
			Email.LoadEml(myEmaileml);
			Email.SaveAllAttachments(DownLoadDir);
		}
		public void FixDate(ref string tStr)
		{
			
			string S = tStr.Trim();
			string CH = "";
			for (int i = 1; i <= S.Length; i++)
			{
				CH = S.Substring(i - 1, 1);
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
			for (int i = 1; i <= S.Length; i++)
			{
				CH = S.Substring(i - 1, 1);
				if (GoodChars.IndexOf(CH) + 1 > 0)
				{
					GoodChrCnt++;
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
			//ServerName  = "pop.dmachicago.com"
			//read mail from a POP3 server.
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
			
			string CurrMailFolder = ServerName + ":" + UserLoginID;
			int I = 0;
			int J = 0;
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ReadEmailFromServer 100");
			}
			
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string EmailDir = TempDir + "Email";
			
			if (! Directory.Exists(EmailDir))
			{
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ReadEmailFromServer 100.1");
				}
				Directory.CreateDirectory(EmailDir);
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ReadEmailFromServer 100.2");
				}
			}
			if (! Directory.Exists(AttachmentDir))
			{
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ReadEmailFromServer 100.3");
				}
				Directory.CreateDirectory(AttachmentDir);
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ReadEmailFromServer 100.4");
				}
			}
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ReadEmailFromServer 100.5");
			}
			DMA.deleteDirectoryFiles(EmailDir);
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ReadEmailFromServer 100.6");
			}
			DMA.deleteDirectoryFiles(AttachmentDir);
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ReadEmailFromServer 100.7");
			}
			mailman.MailHost = ServerName;
			mailman.PopPassword = LoginPassWord;
			mailman.PopUsername = UserLoginID;
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ReadEmailFromServer 200");
			}
			
			//******************************************************************************************************
			LOG.WriteToArchiveLog((string) ("Applying POP Bundle by " + UserLoginID));
			bool SuccessfulRun = false;
			
			SuccessfulRun = ApplyEmailBundleV2(UID, mailman, ServerName, UserLoginID, LoginPassWord, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
			if (! SuccessfulRun)
			{
				ApplyEmailBundle(UID, mailman, ServerName, UserLoginID, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
			}
			//******************************************************************************************************
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ReadEmailFromServer 300 Ended ");
			}
			
			DMA.deleteDirectoryFiles(EmailDir);
			DMA.deleteDirectoryFiles(AttachmentDir);
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		public void getDirectoryFiles(string DirFQN, List<string> DirFiles)
		{
			
			try
			{
				//DirFiles.Clear()
				string strFileSize = "";
				System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirFQN);
				System.IO.FileInfo[] aryFi = di.GetFiles("*.*");
				
				foreach (System.IO.FileInfo fi in aryFi)
				{
					if (! DirFiles.Contains(fi.FullName))
					{
						DirFiles.Add(fi.FullName);
					}
				}
			}
			catch (System.Exception)
			{
				
			}
			
			
		}
		public void SendHighPriorityEmail(string ServerName, string UserLoginID, string LoginPassWord)
		{
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			
			// Any string passed to UnlockComponent automatically begins a 30-day trial.
			bool success;
			success = System.Convert.ToBoolean(mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G"));
			if (success != true)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) mailman.LastErrorText);
				}
				return;
			}
			
			// Set the SMTP server.
			//mailman.SmtpHost = "smtp.earthlink.net"
			mailman.SmtpHost = ServerName;
			
			// Create a high-priority email.
			Chilkat.Email email = new Chilkat.Email();
			
			// Set the basic email stuff: body, subject, "from", "to"
			EMAIL.Body = "This is the email body";
			EMAIL.SUBJECT = "This is the email subject";
			Email.AddTo("Chilkat Support", "support@chilkatsoft.com");
			Email.From = "Programmer <programmer@chilkatsoft.com>";
			
			//You can add the X-Priority header field and give it the value string "1".
			//For example: email.AddHeaderField "X-Priority","1" This is the most common way of
			// setting the priority of an email. "3" is normal, and "5" is the lowest.
			// "2" and "4" are in-betweens, and frankly I've never seen anything
			// but "1" or "3" used. Microsoft Outlook adds these header fields when
			// setting a message to High priority:
			// X-Priority: 1 (Highest)
			// X-MSMail-Priority: High
			// Importance: High
			// This field alone is enough to make the email high-priority.
			Email.AddHeaderField("X-Priority", "1");
			
			success = System.Convert.ToBoolean(mailman.SendEmail(email));
			if (success)
			{
				LOG.WriteToArchiveLog("NOTICE: Sent high-priority email!");
			}
			else
			{
				LOG.WriteToArchiveLog((string) ("ERROR: " + mailman.LastErrorText));
			}
			
		}
		// Download email from a POP3 server, save and remove attachments,
		// and save the email bundle (without attachments) as XML.
		private void EmailCopyAndSave(string ServerName, string UserLoginID, string LoginPassWord)
		{
			try
			{
				string AttachmentDir = "C:\\temp\\DownloadedEmails\\Attachments";
				string EmailDir = "C:\\temp\\DownloadedEmails";
				
				Chilkat.MailMan mailman = new Chilkat.MailMan();
				mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
				mailman.MailHost = ServerName;
				mailman.PopUsername = UserLoginID;
				mailman.PopPassword = LoginPassWord;
				
				Chilkat.EmailBundle bundle;
				Chilkat.EmailBundle bundle2 = new Chilkat.EmailBundle();
				
				bundle = mailman.CopyMail();
				if (!(bundle == null))
				{
					long i;
					Chilkat.Email email;
					for (i = 0; i <= bundle.MessageCount - 1; i++)
					{
						email = bundle.GetEmail(i);
						Email.SaveAllAttachments(AttachmentDir);
						Email.DropAttachments();
						// Add the email (without attachments) to bundle2.
						bundle2.AddEmail(email);
					}
				}
				// Save the email bundle without attachments.
				bundle2.SaveXml("bundle.xml");
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR- clsEmailFuncitons:EmailCopyAndSave " + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("ERROR- clsEmailFuncitons:EmailCopyAndSave " + "\r\n" + ex.StackTrace));
			}
		}
		
		public void ApplyEmailBundle(string UID, Chilkat.MailMan mailman, string ServerName, string UserLoginID, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
		{
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 100");
			}
			
			int I = 0;
			int J = 0;
			//System.IO.Path.GetTempPath
			string TempDir = UTIL.getTempProcessingDir();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string EmailDir = TempDir + "Email";
			string CurrMailFolder = ServerName + ":" + UserLoginID;
			Chilkat.EmailBundle bundle;
			
			Chilkat.StringArray ArrayOfEntryID;
			
			ArrayOfEntryID = mailman.GetUidls();
			if (ArrayOfEntryID == null)
			{
				LOG.WriteToArchiveLog("Error 100.13.21 could not acquire email UID\'s.");
				return;
			}
			
			long n;
			n = ArrayOfEntryID.Count;
			
			Chilkat.Email email;
			string EntryID;
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 200");
			}
			int iCount = System.Convert.ToInt32(mailman.GetMailboxCount);
			frmMain.Default.SB.Text = (string) ("Waiting for email download." + DateTime.Now.ToString());
			frmExchangeMonitor.Default.Show();
			//********************************************************************
			
			frmExchangeMonitor.Default.lblServer.Text = ServerName + " : " + UserLoginID;
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Downloading emails... standby.";
			frmExchangeMonitor.Default.lblMsg.Text = (string) ("Waiting for email download." + DateTime.Now.ToString());
			frmExchangeMonitor.Default.Refresh();
			System.Windows.Forms.Application.DoEvents();
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 300");
			}
			
			if (LeaveOnServer)
			{
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ApplyEmailBundle 300.1");
				}
				LOG.WriteToArchiveLog((string) ("Applying Bundle Leave On Server Emails Count = " + iCount.ToString()));
				bundle = mailman.CopyMail;
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ApplyEmailBundle 300.2");
				}
			}
			else
			{
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ApplyEmailBundle 300.3");
				}
				LOG.WriteToArchiveLog((string) ("Applying Bundle Remove from Server Emails Count = " + iCount.ToString()));
				bundle = mailman.TransferMail;
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ApplyEmailBundle 300.4");
				}
			}
			
			if (bundle == null)
			{
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog("ApplyEmailBundle 400");
				}
				LOG.WriteToArchiveLog("Applying Bundle from Server NO Emails to process.");
				LOG.WriteToArchiveLog((string) ("NOTICE: Exchange Email Read 100.45.2 - " + ServerName + " : " + UserLoginID));
				LOG.WriteToArchiveLog((string) mailman.LastErrorText);
				if (modGlobals.gClipBoardActive == true)
				{
					Console.WriteLine(mailman.LastErrorText);
				}
				frmExchangeMonitor.Default.Close();
				return;
			}
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 500");
			}
			
			frmMain.Default.SB.Text = (string) ("Download complete." + DateTime.Now.ToString());
			
			LOG.WriteToArchiveLog((string) ("Applying Bundle Message Count = " + bundle.MessageCount.ToString()));
			frmExchangeMonitor.Default.lblMsg.Text = (string) ("Applying Messages: #" + bundle.MessageCount.ToString());
			
			bool bEmailAlreadyExists = false;
			//For I = 0 To bundle.MessageCount - 1
			for (I = 0; I <= n - 1; I++)
			{
				
				EntryID = (string) (ArrayOfEntryID.GetString(I));
				email = mailman.FetchEmail(EntryID);
				if (email == null)
				{
					LOG.WriteToArchiveLog((string) ("Processed Message Count = " + I.ToString()));
					break;
				}
				
				bEmailAlreadyExists = DBLocal.ExchangeExists(EntryID);
				if (bEmailAlreadyExists)
				{
					DBLocal.MarkExchangeFound(EntryID);
					goto NextRec;
				}
				
				frmExchangeMonitor.Default.lblMessageInfo.Text = (string) ("Downloading " + I.ToString());
				frmExchangeMonitor.Default.Refresh();
				System.Windows.Forms.Application.DoEvents();
				//frmReconMain.SB.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString + " of " + bundle.MessageCount.ToString
				
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 600a: bundle.MessageCount " + bundle.MessageCount.ToString()));
				}
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 600b: " + I.ToString()));
				}
				frmExchangeMonitor.Default.lblMessageInfo.Text = UserLoginID + " : Message# " + I.ToString() + " of " + bundle.MessageCount.ToString();
				frmExchangeMonitor.Default.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				string NewGuid = System.Guid.NewGuid().ToString();
				
				//email = bundle.GetEmail(I)
				
				string Subject = EMAIL.SUBJECT;
				string EmailFrom = (string) Email.From;
				string FromAddress = (string) Email.FromAddress;
				string FromName = (string) Email.FromName;
				string From = (string) Email.From;
				DateTime CreateTime = Email.EmailDate;
				
				if (strReject.Trim.Length > 0)
				{
					string[] A = strReject.Split(",".ToCharArray());
					for (int II = 0; II <= (A.Length - 1); II++)
					{
						string S1 = A[II].Trim();
						if (S1.Trim().Length > 0)
						{
							if (Subject.IndexOf(S1) + 1)
							{
								LOG.WriteToArchiveLog((string) ("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject));
								goto NextRec;
							}
						}
					}
				}
				
				int NumDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
				if (NumDaysOld > DaysToHold)
				{
					bool success = System.Convert.ToBoolean(mailman.DeleteEmail(email));
					if (success != true)
					{
						string Msg = "Subject: " + Subject + "\r\n";
						Msg += "FromName: " + FromName + "\r\n";
						Msg += "FromAddress: " + FromAddress + "\r\n";
						LOG.WriteToArchiveLog((string) ("ERROR ApplyEmailBundle: Failed to delete email:" + "\r\n" + Msg));
					}
				}
				
				int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
				int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
				int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
				int NumBcc = System.Convert.ToInt32(Email.NumBcc);
				int NumCC = System.Convert.ToInt32(Email.NumCC);
				int NumTo = System.Convert.ToInt32(Email.NumTo);
				string ReplyTo = (string) Email.ReplyTo;
				string SignedBy = (string) Email.SignedBy;
				int EmailSize = System.Convert.ToInt32(Email.Size);
				string ReceivedDate = (string) (Email.LocalDate.ToString());
				string GMT = (string) (Email.EmailDate.ToString());
				string Header = (string) Email.Header;
				string EmailBody = EMAIL.Body;
				
				ArrayList Recipients = new ArrayList();
				ArrayList EmailTo = new ArrayList();
				ArrayList EmailToAddr = new ArrayList();
				ArrayList EmailToName = new ArrayList();
				ArrayList Bcc = new ArrayList();
				ArrayList BccAddr = new ArrayList();
				ArrayList BccName = new ArrayList();
				ArrayList CC = new ArrayList();
				ArrayList CcAddr = new ArrayList();
				ArrayList CcName = new ArrayList();
				bool bLoadAttachments = false;
				
				string tGMT = GMT.ToString();
				FixDate(ref tGMT);
				string tSubject = Subject.Substring(0, 100);
				RemoveBadChars(ref tSubject);
				
				
				string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.FromAddress, Subject);
				string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
				
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 700: " + I.ToString()));
				}
				//Dim B As Boolean = ExchangeEmailExists(EmailIdentifier, EmailHashCode)
				bool B = ExchangeEmailExists(EmailIdentifier);
				if (B)
				{
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToTraceLog((string) ("INFO: ApplyEmailBundle 700X email already exists in Repository: " + I.ToString()));
					}
					goto NextRec;
				}
				
				string EmailFQN = TempDir + "EMAIL." + NewGuid + ".MSG";
				
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 800: " + I.ToString()));
				}
				if (NumAttachments > 0)
				{
					//** Clean out the directory
					DMA.deleteDirectoryFiles(AttachmentDir);
					// Save attachments to the "attachments" directory.
					Email.SaveAllAttachments(AttachmentDir);
					bLoadAttachments = true;
				}
				
				int iLevel = 1;
				if (NumAttachedMessages > 0)
				{
					//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
					for (int II = 0; II <= NumAttachedMessages - 1; II++)
					{
						//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
						Chilkat.Email objEmail = Email.GetAttachedMessage(II);
						//ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, iLevel)
						ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
						objEmail = null;
					}
				}
				
				for (J = 0; J <= NumCC - 1; J++)
				{
					CC.Add(EMAIL.getCc[J].ToString());
					CcAddr.Add(Email.GetCcAddr(J).ToString());
					CcName.Add(Email.GetCcName(J).ToString());
					if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
					{
						Recipients.Add(Email.GetCcAddr(J).ToString());
					}
				}
				for (J = 0; J <= NumBcc - 1; J++)
				{
					Bcc.Add(EMAIL.getBcc[J].ToString());
					BccName.Add(Email.GetBccName(J).ToString());
					BccAddr.Add(Email.GetBccAddr(J).ToString());
					if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
					{
						Recipients.Add(Email.GetBccAddr(J).ToString());
					}
				}
				for (J = 0; J <= NumTo - 1; J++)
				{
					EmailTo.Add(Email.GetTo(J).ToString());
					EmailToAddr.Add(Email.GetToAddr(J).ToString());
					EmailToName.Add(Email.GetToName(J).ToString());
					if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
					{
						Recipients.Add(Email.GetToAddr(J).ToString());
					}
				}
				
				// Save the email to XML
				//email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
				
				// Save the email to EML
				//Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 900.0: " + I.ToString()));
				}
				Email.SaveEml(EmailFQN);
				
				//log.WriteToArchiveLog("Notice from ApplyEmailBundle 200 : FQN '" + EmailFQN  + "'")
				
				//**********************************************************
				//IF CONVERT TO MSG THEN
				//READ IN THE NEW EML
				//CONVERT IT TO MSG
				//WRITE OUT THE MSG
				//SAVE THE MSG IMAGE INTO THE REPOSITORY.
				if (bEmlToMSG == true)
				{
					EmailFQN = convertEmlToMsg(EmailFQN);
					if (EmailFQN.Trim.Length == 0)
					{
						LOG.WriteToArchiveLog("Unrecoverable Error: 100 ApplyEmailBundle - failed to convert EML to MSG File.");
						LOG.WriteToArchiveLog("NOTE : 100 Most likely the Redemption DLL is not installed properly");
						goto NextRec;
					}
					//log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'")
				}
				
				//**********************************************************
				
				
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 900.1: " + I.ToString()));
				}
				List<string> AttachedFiles = new List<string>();
				getDirectoryFiles(AttachmentDir, AttachedFiles);
				
				string DB_ID = "ECM.Library";
				string Server_UserID_StoreID = CurrMailFolder;
				
				//** Now, Load the EMAIL and its metadata into the repository
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 900.2: " + I.ToString()));
				}
				//log.WriteToArchiveLog("Notice from ApplyEmailBundle 400 : FQN '" + EmailFQN  + "'")
				bool AttachmentsLoaded = false;
				
				ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, DateTime.Parse(ReceivedDate), UserLoginID, DateTime.Now, DateTime.Parse(ReceivedDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
NextRec:
				if (LibraryName.Trim.Length > 0)
				{
					
				}
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 1000: " + I.ToString()));
				}
			}
			
			ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, 99);
			string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + "\\WMCONVERT";
			ApplyPendingEmail(UID, ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode);
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Download complete.";
			frmExchangeMonitor.Default.Close();
		}
		
		public void ApplyIMapBundle(string UID, Chilkat.Imap imap, string ServerName, string UserLoginID, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
		{
			
			int ID = 33333;
			frmExchangeMonitor.Default.Show();
			frmExchangeMonitor.Default.lblServer.Text = ServerName + " : " + UserLoginID;
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Downloading emails... standby.";
			frmExchangeMonitor.Default.Refresh();
			System.Windows.Forms.Application.DoEvents();
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 100");
			}
			Chilkat.MessageSet messageSet;
			//  We can choose to fetch UIDs or sequence numbers.
			bool fetchUids;
			fetchUids = true;
			//  Get the message IDs of all the emails in the mailbox
			messageSet = imap.Search("ALL", fetchUids);
			if (messageSet == null)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) imap.LastErrorText);
				}
				return;
			}
			
			int I = 0;
			int J = 0;
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string EmailDir = TempDir + "Email";
			string CurrMailFolder = ServerName + ":" + UserLoginID;
			
			Chilkat.EmailBundle bundle;
			bundle = imap.FetchBundle(messageSet);
			if (bundle == null)
			{
				
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) imap.LastErrorText);
				}
				return;
			}
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 200");
			}
			int iCount = System.Convert.ToInt32(bundle.MessageCount);
			
			//********************************************************************
			frmExchangeMonitor.Default.Show();
			frmExchangeMonitor.Default.lblServer.Text = ServerName + " : " + UserLoginID;
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Processing emails... standby.";
			frmExchangeMonitor.Default.Refresh();
			System.Windows.Forms.Application.DoEvents();
			
			if (dDebug_clsEmailFunctions)
			{
				LOG.WriteToTraceLog("ApplyEmailBundle 300");
			}
			
			//If LeaveOnServer Then
			//    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.1")
			//    LOG.WriteToArchiveLog("Applying Bundle Leave On Server Emails Count = " + iCount.ToString)
			//    bundle = MailMan.CopyMail
			//    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.2")
			//Else
			//    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.3")
			//    LOG.WriteToArchiveLog("Applying Bundle Remove from Server Emails Count = " + iCount.ToString)
			//    bundle = MailMan.TransferMail
			//    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 300.4")
			//End If
			
			//If bundle Is Nothing Then
			//    If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 400")
			//    LOG.WriteToArchiveLog("Applying Bundle from Server NO Emails to process.")
			//    log.WriteToArchiveLog("NOTICE: Exchange Email Read 100.45.2 - " + ServerName  + " : " + UserLoginID )
			//    log.WriteToArchiveLog(MailMan.LastErrorText)
			//    If gClipBoardActive = True Then Console.WriteLine(MailMan.LastErrorText)
			//    Return
			//End If
			//If dDebug_clsEmailFunctions Then LOG.WriteToTraceLog("ApplyEmailBundle 500")
			
			//Dim DisplayMsg  = "Retrieving " + bundle.MessageCount.ToString + " emails."
			//frmHelp.MsgToDisplay  = DisplayMsg
			//frmHelp.CallingScreenName  = "ECM Exchange"
			//frmHelp.CaptionName  = "Exchange Archive"
			//frmHelp.Timer1.Interval = 10000
			//frmHelp.Show()
			LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle Message Count = " + bundle.MessageCount.ToString()));
			for (I = 0; I <= bundle.MessageCount - 1; I++)
			{
				//frmExchangeMonitor.lblMessageInfo.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString
				//frmReconMain.SB.Text = "Downloading " + UserLoginID  + "... standby: " + I.ToString + " of " + bundle.MessageCount.ToString
				System.Windows.Forms.Application.DoEvents();
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 600a: bundle.MessageCount " + bundle.MessageCount.ToString()));
				}
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 600b: " + I.ToString()));
				}
				frmExchangeMonitor.Default.lblMessageInfo.Text = UserLoginID + " : Message# " + I.ToString() + " of " + bundle.MessageCount.ToString();
				frmExchangeMonitor.Default.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				string NewGuid = System.Guid.NewGuid().ToString();
				
				Chilkat.Email email;
				email = bundle.GetEmail(I);
				
				string EntryID = (string) Email.Uidl;
				
				string Subject = EMAIL.SUBJECT;
				string EmailFrom = (string) Email.From;
				string FromAddress = (string) Email.FromAddress;
				string FromName = (string) Email.FromName;
				string From = (string) Email.From;
				
				if (strReject.Trim.Length > 0)
				{
					string[] A = strReject.Split(",".ToCharArray());
					for (int II = 0; II <= (A.Length - 1); II++)
					{
						string S1 = A[II].Trim();
						if (S1.Trim().Length > 0)
						{
							if (Subject.IndexOf(S1) + 1)
							{
								LOG.WriteToArchiveLog((string) ("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject));
								goto NextRec;
							}
						}
					}
				}
				
				int NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
				if (NbrDaysOld > DaysToHold)
				{
					bool success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
					if (success != true)
					{
						string Msg = "Subject: " + Subject + "\r\n";
						Msg += "FromName: " + FromName + "\r\n";
						Msg += "FromAddress: " + FromAddress + "\r\n";
						LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
					}
				}
				
				int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
				int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
				int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
				int NumBcc = System.Convert.ToInt32(Email.NumBcc);
				int NumCC = System.Convert.ToInt32(Email.NumCC);
				int NumTo = System.Convert.ToInt32(Email.NumTo);
				string ReplyTo = (string) Email.ReplyTo;
				string SignedBy = (string) Email.SignedBy;
				int EmailSize = System.Convert.ToInt32(Email.Size);
				string ReceivedDate = (string) (Email.LocalDate.ToString());
				string GMT = (string) (Email.EmailDate.ToString());
				string Header = (string) Email.Header;
				string EmailBody = EMAIL.Body;
				
				ArrayList Recipients = new ArrayList();
				ArrayList EmailTo = new ArrayList();
				ArrayList EmailToAddr = new ArrayList();
				ArrayList EmailToName = new ArrayList();
				ArrayList Bcc = new ArrayList();
				ArrayList BccAddr = new ArrayList();
				ArrayList BccName = new ArrayList();
				ArrayList CC = new ArrayList();
				ArrayList CcAddr = new ArrayList();
				ArrayList CcName = new ArrayList();
				bool bLoadAttachments = false;
				
				string tGMT = GMT.ToString();
				FixDate(ref tGMT);
				string tSubject = Subject.Substring(0, 100);
				RemoveBadChars(ref tSubject);
				
				//Dim EmailIdentifier as string = EmailSize.ToString + "~" + tGMT  + "~" + FromAddress.Trim + "~" + tSubject  + "~" + gCurrLoginID
				
				string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.FromAddress, Subject);
				string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
				
				bool B = ExchangeEmailExists(EmailIdentifier);
				if (B)
				{
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToTraceLog((string) ("ApplyEmailBundle 700X already exists: " + I.ToString()));
					}
					goto NextRec;
				}
				
				string EmailFQN = TempDir + "EMAIL." + NewGuid + ".MSG";
				
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 800: " + I.ToString()));
				}
				if (NumAttachments > 0)
				{
					//** Clean out the directory
					DMA.deleteDirectoryFiles(AttachmentDir);
					// Save attachments to the "attachments" directory.
					Email.SaveAllAttachments(AttachmentDir);
					bLoadAttachments = true;
				}
				
				int iLevel = 1;
				if (NumAttachedMessages > 0)
				{
					//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
					for (int II = 0; II <= NumAttachedMessages - 1; II++)
					{
						//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
						Chilkat.Email objEmail = Email.GetAttachedMessage(II);
						//ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, iLevel)
						ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
						objEmail = null;
					}
				}
				
				for (J = 0; J <= NumCC - 1; J++)
				{
					CC.Add(EMAIL.getCc[J].ToString());
					CcAddr.Add(Email.GetCcAddr(J).ToString());
					CcName.Add(Email.GetCcName(J).ToString());
					if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
					{
						Recipients.Add(Email.GetCcAddr(J).ToString());
					}
				}
				for (J = 0; J <= NumBcc - 1; J++)
				{
					Bcc.Add(EMAIL.getBcc[J].ToString());
					BccName.Add(Email.GetBccName(J).ToString());
					BccAddr.Add(Email.GetBccAddr(J).ToString());
					if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
					{
						Recipients.Add(Email.GetBccAddr(J).ToString());
					}
				}
				for (J = 0; J <= NumTo - 1; J++)
				{
					EmailTo.Add(Email.GetTo(J).ToString());
					EmailToAddr.Add(Email.GetToAddr(J).ToString());
					EmailToName.Add(Email.GetToName(J).ToString());
					if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
					{
						Recipients.Add(Email.GetToAddr(J).ToString());
					}
				}
				
				// Save the email to XML
				//email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
				
				// Save the email to EML
				//Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 900.0: " + I.ToString()));
				}
				Email.SaveEml(EmailFQN);
				
				//log.WriteToArchiveLog("Notice from ApplyEmailBundle 200 : FQN '" + EmailFQN  + "'")
				
				//**********************************************************
				//IF CONVERT TO MSG THEN
				//READ IN THE NEW EML
				//CONVERT IT TO MSG
				//WRITE OUT THE MSG
				//SAVE THE MSG IMAGE INTO THE REPOSITORY.
				if (bEmlToMSG == true)
				{
					EmailFQN = convertEmlToMsg(EmailFQN);
					if (EmailFQN.Trim.Length == 0)
					{
						LOG.WriteToArchiveLog("Unrecoverable Error: 100 ApplyEmailBundle - failed to convert EML to MSG File.");
						LOG.WriteToArchiveLog("NOTE : 100 Most likely the Redemption DLL is not installed properly");
						goto NextRec;
					}
					//log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'")
				}
				
				//**********************************************************
				
				
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 900.1: " + I.ToString()));
				}
				List<string> AttachedFiles = new List<string>();
				getDirectoryFiles(AttachmentDir, AttachedFiles);
				
				string DB_ID = "ECM.Library";
				string Server_UserID_StoreID = CurrMailFolder;
				
				//** Now, Load the EMAIL and its metadata into the repository
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 900.2: " + I.ToString()));
				}
				//log.WriteToArchiveLog("Notice from ApplyEmailBundle 400 : FQN '" + EmailFQN  + "'")
				bool AttachmentsLoaded = false;
				
				try
				{
					ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, DateTime.Parse(ReceivedDate), UserLoginID, DateTime.Now, DateTime.Parse(ReceivedDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
				}
				catch (System.Exception ex)
				{
					
					imap.Expunge();
					imap.Disconnect();
					
					LOG.WriteToArchiveLog((string) ("ERROR ApplyIMapBundle 100 : " + ex.Message));
				}
				
NextRec:
				if (LibraryName.Trim.Length > 0)
				{
					
				}
				if (dDebug_clsEmailFunctions)
				{
					LOG.WriteToTraceLog((string) ("ApplyEmailBundle 1000: " + I.ToString()));
				}
			}
			
			bundle = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, 99);
			string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + "\\WMCONVERT";
			ApplyPendingEmail(UID, ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode);
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Download complete.";
		}
		
		public bool ReadEmailUsingSSL(string UID, string ServerName, string UserLoginID, string LoginPassWord, int PortNbr, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToRetain, string strReject, bool bEmlToMSG)
		{
			// Create a mailman object for reading email.
			
			bool RC = false;
			LOG.WriteToArchiveLog("ReadEmailUsingSSL 1000");
			
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			string EmailFrom = "";
			string EmailSubject = "";
			string EmailBody = "";
			var EmailFromAddress = "";
			var EmailFromName = "";
			
			// Any string passed to UnlockComponent automatically begins a 30-day trial.
			bool success;
			success = System.Convert.ToBoolean(mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G"));
			if (success != true)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) mailman.LastErrorText);
				}
				return false;
			}
			
			// Set our POP3 hostname, login and password
			mailman.MailHost = ServerName;
			mailman.PopUsername = UserLoginID;
			mailman.PopPassword = LoginPassWord;
			
			// Indicate that the TCP/IP connection with the POP3 server should be SSL.
			// All POP3 communications are secure using SSL.
			mailman.PopSsl = true;
			// Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
			//mailman.MailPort = 995
			mailman.MailPort = PortNbr;
			
			bool SuccessfulRun = false;
			SuccessfulRun = ApplyEmailBundleV2(UID, mailman, ServerName, UserLoginID, LoginPassWord, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
			if (! SuccessfulRun)
			{
				ApplyEmailBundle(UID, mailman, ServerName, UserLoginID, LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, bEmlToMSG);
			}
			
		}
		
		public void DownloadEmailAndForward(string MailHost, string PopUsername, string PopPassword, bool UseSameLogin, string SmtpHost, string SmtpUsername, string SmtpPassword, string ForwardToEmail, string ForwardToEmail2)
		{
			// Read email from a POP3 server and return the complete MIME source of each email.
			// The emails downloaded from the POP3 server are not loaded into Chilkat.Email objects,
			// therefore they are not parsed, unwrapped (for encrypted/signed email), or modified
			// in any way.
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
			
			mailman.MailHost = MailHost;
			mailman.PopUsername = PopUsername;
			mailman.PopPassword = PopPassword;
			
			// We'll need the SMTP hostname and (optionally) the login
			// to send email...
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
			// Download the entire mailbox.
			// Call FetchMultipleMime to leave the email on the server.
			// Call TransferMultipleMime to download and remove from the server.
			mimeArr = mailman.TransferMultipleMime(allEntryIDs);
			//mimeArr = mailman.FetchMultipleMime(allEntryIDs)
			
			// Show how many emails were downloaded.
			MessageBox.Show((string) mimeArr.Count);
			
			// Forward each email to another recipient.
			int i;
			bool success;
			for (i = 0; i <= mimeArr.Count; i++)
			{
				success = System.Convert.ToBoolean(mailman.SendMime(ForwardToEmail, ForwardToEmail2, mimeArr.GetString(i)));
				if (! success)
				{
					MessageBox.Show((string) mailman.LastErrorText);
					// ... do whatever else you want...
				}
			}
		}
		
		public void ReadXmlEmailData(string FQN)
		{
			try
			{
				XmlTextReader reader = new XmlTextReader(FQN);
				
				//message-id
				
				while (reader.Read())
				{
					string AttrName = reader.Name;
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("nbr elements: " + reader.AttributeCount.ToString());
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("reader.GetAttribute: " + reader.GetAttribute("message-id").ToString());
					}
					if (reader.HasValue)
					{
						Console.WriteLine("Name: " + reader.Name);
						Console.WriteLine("LocalName: " + reader.LocalName);
						Console.WriteLine("SchemaAttribute.Name: " + reader.SchemaInfo.SchemaAttribute.Name.ToString());
						Console.WriteLine("ReadAttributeValue : " + reader.ReadAttributeValue().ToString());
						Console.WriteLine("ReadString : " + reader.ReadString());
						Console.WriteLine("Value : " + reader.Value);
						//Console.WriteLine(reader.GetAttribute(AttrName ))
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
			DataSet ds = new DataSet();
			ds.ReadXml(xmlFile);
			
			int K = ds.Tables[0].Rows.Count;
			int i = 0;
			for (i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
			{
				Console.WriteLine(ds.Tables[0].Rows[i][1]);
			}
			
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
				//Load the reader with the XML file.
				reader = new XmlTextReader(FQN);
				
				//Read the ISBN attribute.
				reader.MoveToContent();
				
				string MessageID = reader.GetAttribute("message-id");
				Console.WriteLine("The MessageID value: " + MessageID);
				
			}
			finally
			{
				if (!(reader == null))
				{
					reader.Close();
				}
			}
			
		}
		
		public void deleteFile(string FQN)
		{
			try
			{
				System.IO.File.Delete(FQN);
			}
			catch (System.Exception)
			{
				LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteFile - failed to delete file \'" + FQN + "\'.");
			}
		}
		
		
		public void getImapEmailSSL(string UID, string MailServerAddr, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG, bool UseSSL)
		{
			
			LOG.WriteToArchiveLog("getImapEmailSSL 100");
			int LL = 1;
			Chilkat.Imap imap = new Chilkat.Imap();
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
				string TempDir = System.IO.Path.GetTempPath();
				LL = 7;
				string AttachmentDir = TempDir + "Email\\Attachment";
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
					DownLoadSize = int.Parse(val[sDownLoadSize]);
					LL = 19;
				}
				catch (System.Exception)
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
				//  Anything unlocks the component and begins a fully-functional 30-day trial.
				LL = 29;
				success = System.Convert.ToBoolean(imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G"));
				LL = 30;
				if (success != true)
				{
					LL = 31;
					MessageBox.Show((string) imap.LastErrorText);
					LL = 32;
					return;
//					LL = 33;
				}
				LL = 34;
				
				LL = 35;
				//  To use a secure SSL connection, set SSL and the port:
				LL = 36;
				imap.Ssl = UseSSL;
				LL = 37;
				//  The typical port for IMAP SSL is 993
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
					imap.Port = val[PortNbr];
					LL = 42;
				}
				LL = 43;
				
				LL = 44;
				//  Connect to an IMAP server.
				LL = 45;
				success = System.Convert.ToBoolean(imap.Connect(MailServerAddr));
				LL = 46;
				if (success != true)
				{
					LL = 47;
					LOG.WriteToArchiveLog((string) ("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText));
					LL = 48;
					return;
				}
				else
				{
					LL = 49;
					//'frmExchangeMonitor.txtArchivedFiles.Text = "Login: " + UserLoginID  + " successful."
					//'frmExchangeMonitor.txtArchivedFiles.Refresh()
					System.Windows.Forms.Application.DoEvents();
				}
				LOG.WriteToArchiveLog("getImapEmailSSL 200");
				LL = 53;
				success = System.Convert.ToBoolean(imap.Login(UserLoginID, LoginPassWord));
				LL = 54;
				if (success != true)
				{
					LL = 55;
					LOG.WriteToArchiveLog((string) ("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText));
					//'frmExchangeMonitor.txtArchivedFiles.Text = "FAILED Login: " + UserLoginID  + " successful."
					//'frmExchangeMonitor.txtArchivedFiles.Refresh()
					System.Windows.Forms.Application.DoEvents();
					LL = 56;
					return;
				}
				else
				{
					LL = 57;
					//'frmExchangeMonitor.txtArchivedFiles.Text = "Login: " + UserLoginID  + " successful."
					//'frmExchangeMonitor.txtArchivedFiles.Refresh()
					System.Windows.Forms.Application.DoEvents();
				}
				LL = 58;
				
				LOG.WriteToArchiveLog("getImapEmailSSL 300");
				success = System.Convert.ToBoolean(imap.SelectMailbox("Inbox"));
				LL = 62;
				if (success != true)
				{
					LL = 63;
					LOG.WriteToArchiveLog((string) ("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText));
					LL = 64;
					return;
//					LL = 65;
				}
				System.Windows.Forms.Application.DoEvents();
				int NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
				LL = 75;
				if (NumberOfMessagesInBox > 0)
				{
					LL = 76;
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
					LL = 77;
				}
				else
				{
					LL = 78;
					LOG.WriteToArchiveLog((string) ("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
					LL = 79;
					goto ENDIT;
					LL = 80;
				}
				LL = 81;
				
				long startSeqNum;
				startSeqNum = 1;
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
				bundle = imap.FetchSequence(startSeqNum, numToFetch);
				LL = 128;
				//End If
				LL = 129;
				
				LOG.WriteToArchiveLog("getImapEmailSSL 400");
				if (bundle == null)
				{
					LL = 132;
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400a: " + imap.LastErrorText));
					LL = 133;
					LOG.WriteToArchiveLog((string) ("        getImapEmailSSL 400b: startSeqNum - " + startSeqNum.ToString()));
					LL = 134;
					LOG.WriteToArchiveLog((string) ("        getImapEmailSSL 400c: numToFetch - " + numToFetch.ToString()));
					LL = 135;
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400d: messages in mailbox: " + NumberOfMessagesInBox.ToString()));
					LL = 136;
					NbrOfTries++;
					LL = 137;
					goto REDO;
					LL = 138;
				}
				LL = 139;
				
				
				LOG.WriteToArchiveLog("getImapEmailSSL 500");
				LL = 160;
				LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP/SSL #emails = " + NumberOfMessagesInBox.ToString()));
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
					for (i = 0; i <= bundle.MessageCount - 1; i++)
					{
						
						TotalEmailsInArchive++;
						LL = 180;
						MessagesRemainingToProcess--;
						LL = 183;
						frmExchangeMonitor.Default.lblMessageInfo.Text = (string) ("Msg: " + TotalEmailsInArchive.ToString());
						frmExchangeMonitor.Default.Refresh();
						frmMain.Default.tbExchange.Text = (string) ("Email# " + i.ToString());
						System.Windows.Forms.Application.DoEvents();
						LL = 185;
						
						LL = 186;
						string NewGuid = System.Guid.NewGuid().ToString();
						LL = 188;
						Chilkat.Email email;
						LL = 189;
						email = bundle.GetEmail(i);
						LL = 190;
						string EntryID = (string) Email.Uidl;
						LL = 191;
						string Subject = EMAIL.SUBJECT;
						Subject = UTIL.RemoveSingleQuotes(Subject);
						LL = 192;
						string EmailFrom = (string) Email.From;
						LL = 193;
						string FromAddress = (string) Email.FromAddress;
						LL = 194;
						string FromName = (string) Email.FromName;
						LL = 195;
						string From = (string) Email.From;
						LL = 196;
						
						LL = 197;
						if (strReject.Trim.Length > 0)
						{
							LL = 198;
							string[] A = strReject.Split(",".ToCharArray());
							LL = 199;
							for (int II = 0; II <= (A.Length - 1); II++)
							{
								LL = 200;
								string S1 = A[II].Trim();
								LL = 201;
								if (S1.Trim().Length > 0)
								{
									LL = 202;
									if (Subject.IndexOf(S1) + 1)
									{
										LL = 203;
										//LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
										LL = 204;
										RejectedCount++;
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
						NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
						LL = 212;
						if (NbrDaysOld >= DaysToHold)
						{
							LL = 213;
							success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
							LL = 214;
							if (success != true)
							{
								LL = 215;
								string Msg = "Subject: " + Subject + "\r\n";
								LL = 216;
								Msg += "FromName: " + FromName + "\r\n";
								LL = 217;
								Msg += "FromAddress: " + FromAddress + "\r\n";
								LL = 218;
								LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
								LL = 219;
							}
							LL = 220;
						}
						LL = 221;
						
						LL = 222;
						int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
						LL = 223;
						int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
						LL = 224;
						int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
						LL = 225;
						int NumBcc = System.Convert.ToInt32(Email.NumBcc);
						LL = 226;
						int NumCC = System.Convert.ToInt32(Email.NumCC);
						LL = 227;
						int NumTo = System.Convert.ToInt32(Email.NumTo);
						LL = 228;
						string ReplyTo = (string) Email.ReplyTo;
						LL = 229;
						string SignedBy = (string) Email.SignedBy;
						LL = 230;
						int EmailSize = System.Convert.ToInt32(Email.Size);
						LL = 231;
						string LocalDate = (string) (Email.LocalDate.ToString());
						LL = 232;
						string EmailDate = (string) (Email.EmailDate.ToString());
						LL = 233;
						string Header = (string) Email.Header;
						LL = 234;
						string EmailBody = EMAIL.Body;
						LL = 235;
						EmailBody = UTIL.RemoveSingleQuotes(EmailBody);
						LL = 236;
						
						LL = 237;
						ArrayList Recipients = new ArrayList();
						LL = 238;
						ArrayList EmailTo = new ArrayList();
						LL = 239;
						ArrayList EmailToAddr = new ArrayList();
						LL = 240;
						ArrayList EmailToName = new ArrayList();
						LL = 241;
						ArrayList Bcc = new ArrayList();
						LL = 242;
						ArrayList BccAddr = new ArrayList();
						LL = 243;
						ArrayList BccName = new ArrayList();
						LL = 244;
						ArrayList CC = new ArrayList();
						LL = 245;
						ArrayList CcAddr = new ArrayList();
						LL = 246;
						ArrayList CcName = new ArrayList();
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
						string tSubject = Subject.Substring(0, 100);
						LL = 254;
						RemoveBadChars(ref tSubject);
						LL = 255;
						
						string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.From, Subject);
						string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
						
						bool bEmailExists = ExchangeEmailExists(EmailIdentifier);
						LL = 260;
						if (bEmailExists)
						{
							LL = 261;
							
							LL = 262;
							///frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
							LL = 263;
							///frmExchangeMonitor.lblMessageInfo.Refresh()
							LL = 264;
							System.Windows.Forms.Application.DoEvents();
							LL = 265;
							
							LL = 266;
							int DaysOld = System.Convert.ToInt32(Email.NumDaysOld);
							LL = 267;
							if (DaysOld > DaysToHold)
							{
								LL = 268;
								success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
								LL = 269;
								if (success != true)
								{
									LL = 270;
									string Msg = "Subject: " + Subject + "\r\n";
									LL = 271;
									Msg += "FromName: " + FromName + "\r\n";
									LL = 272;
									Msg += "FromAddress: " + FromAddress + "\r\n";
									LL = 273;
									LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
									LL = 274;
								}
								LL = 275;
							}
							LL = 276;
							
							LL = 277;
							return;
//							LL = 278;
						}
						LL = 279;
						
						LL = 280;
						//Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
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
						string EmailFQN = EmailDir + "\\Email~" + (NewGuid + "~.EML");
						LL = 288;
						
						LL = 289;
						LL = 290;
						if (NumAttachments > 0)
						{
							LL = 291;
							//** Clean out the directory
							LL = 292;
							UTIL.deleteDirectoryFile(AttachmentDir);
							LL = 293;
							// Save attachments to the "attachments" directory.
							LL = 294;
							Email.SaveAllAttachments(AttachmentDir);
							LL = 295;
							bLoadAttachments = true;
							LL = 296;
						}
						LL = 297;
						
						LL = 298;
						if (NumAttachedMessages > 0)
						{
							LL = 299;
							//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
							LL = 300;
							for (int II = 0; II <= NumAttachedMessages - 1; II++)
							{
								LL = 301;
								//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
								LL = 302;
								Chilkat.Email objEmail = Email.GetAttachedMessage(II);
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
						for (J = 0; J <= NumCC - 1; J++)
						{
							LL = 309;
							CC.Add(EMAIL.getCc[J].ToString());
							LL = 310;
							CcAddr.Add(Email.GetCcAddr(J).ToString());
							LL = 311;
							CcName.Add(Email.GetCcName(J).ToString());
							LL = 312;
							if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
							{
								LL = 313;
								Recipients.Add(Email.GetCcAddr(J).ToString());
								LL = 314;
							}
							LL = 315;
						}
						LL = 316;
						for (J = 0; J <= NumBcc - 1; J++)
						{
							LL = 317;
							Bcc.Add(EMAIL.getBcc[J].ToString());
							LL = 318;
							BccName.Add(Email.GetBccName(J).ToString());
							LL = 319;
							BccAddr.Add(Email.GetBccAddr(J).ToString());
							LL = 320;
							if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
							{
								LL = 321;
								Recipients.Add(Email.GetBccAddr(J).ToString());
								LL = 322;
							}
							LL = 323;
						}
						LL = 324;
						for (J = 0; J <= NumTo - 1; J++)
						{
							LL = 325;
							EmailTo.Add(Email.GetTo(J).ToString());
							LL = 326;
							EmailToAddr.Add(Email.GetToAddr(J).ToString());
							LL = 327;
							EmailToName.Add(Email.GetToName(J).ToString());
							LL = 328;
							if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
							{
								LL = 329;
								Recipients.Add(Email.GetToAddr(J).ToString());
								LL = 330;
							}
							LL = 331;
						}
						LL = 332;
						Email.SaveEml(EmailFQN);
						LL = 348;
						if (bEmlToMSG == true)
						{
							LL = 349;
							LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN \'" + EmailFQN + "\'");
							LL = 350;
							EmailFQN = convertEmlToMsg(EmailFQN);
							LL = 351;
						}
						LL = 352;
						//**********************************************************
						List<string> AttachedFiles = new List<string>();
						LL = 357;
						getDirectoryFiles(AttachmentDir, AttachedFiles);
						LL = 358;
						
						LL = 359;
						string DB_ID = "ECM.Library";
						LL = 360;
						string Server_UserID_StoreID = CurrMailFolder;
						LL = 361;
						
						LL = 362;
						//** Now, Load the EMAIL and its metadata into the repository
						LL = 363;
						bool AttachmentsLoaded = false;
						LL = 366;
						
						LOG.WriteToArchiveLog("getImapEmailSSL 800");
						ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, DateTime.Parse(EmailDate), UserLoginID, DateTime.Parse(LocalDate), DateTime.Parse(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
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
						LL = 401;
						
					}
					LL = 404;
					//*****************************************************************************
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
						//Increment = MessagesRemainingToProcess
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
					if (numToFetch > 0)
					{
						LL = 419;
						bundle = imap.FetchSequence(startSeqNum, numToFetch);
						LL = 420;
						if (bundle == null)
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
				LOG.WriteToArchiveLog((string) ("ERROR 100 getImapEmailSSL: LL = " + LL.ToString() + ": " + ex.Message));
			}
			
ENDIT:
			imap.Expunge();
			
			LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString()));
			
			//  Disconnect from the IMAP server.
			imap.Disconnect();
			
			messageSet = null;
			imap = null;
			bundle = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			//LOG.WriteToArchiveLog("getImapEmailSSL 1000")
			
		}
		
		public void getIMapEmail(string UID, string MailServerAddr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToRetain, string strReject, bool bEmlToMSG)
		{
			
			LOG.WriteToArchiveLog("getIMapEmail 100");
			
			// Create an object, connect to the IMAP server, login,
			// and select a mailbox.
			Chilkat.Imap imap = new Chilkat.Imap();
			imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
			imap.Connect(MailServerAddr);
			imap.Login(UserLoginID, LoginPassWord);
			imap.SelectMailbox("Inbox");
			
			int J = 0;
			
			LOG.WriteToArchiveLog("getIMapEmail 200");
			
			// Get a message set containing all the message IDs
			// in the selected mailbox.
			Chilkat.MessageSet msgSet;
			msgSet = imap.Search("ALL", 1);
			
			// Fetch all the mail into a bundle object.
			Chilkat.EmailBundle bundle = new Chilkat.EmailBundle();
			try
			{
				bundle = imap.FetchBundle(msgSet);
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: getIMapEmail 100 - " + ex.Message));
				return;
			}
			
			if (bundle == null)
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
				LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle Message Count = " + bundle.MessageCount.ToString()));
			}
			catch (System.Exception)
			{
				LOG.WriteToArchiveLog("WARNING: Applying IMAP Bundle Message Count = UNKNOWN.");
			}
			frmMain.Default.SB.Text = "Processing Exchange servers: " + bundle.MessageCount;
			LOG.WriteToArchiveLog("getIMapEmail 400");
			for (i = 0; i <= bundle.MessageCount - 1; i++)
			{
				try
				{
					string NewGuid = System.Guid.NewGuid().ToString();
					
					Chilkat.Email email;
					email = bundle.GetEmail(i);
					
					string Subject = EMAIL.SUBJECT;
					
					string EmailFrom = (string) Email.From;
					string FromAddress = (string) Email.FromAddress;
					string FromName = (string) Email.FromName;
					string From = (string) Email.From;
					
					if (strReject.Trim.Length > 0)
					{
						string[] A = strReject.Split(",".ToCharArray());
						for (int II = 0; II <= (A.Length - 1); II++)
						{
							string S1 = A[II].Trim();
							if (S1.Trim().Length > 0)
							{
								if (Subject.IndexOf(S1) + 1)
								{
									RecjectCount++;
									goto NextRec;
								}
							}
						}
					}
					
					int NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
					if (NbrDaysOld > DaysToRetain)
					{
						bool success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
						if (success != true)
						{
							string Msg = "Subject: " + Subject + "\r\n";
							Msg += "FromName: " + FromName + "\r\n";
							Msg += "FromAddress: " + FromAddress + "\r\n";
							LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
						}
					}
					
					int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
					int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
					int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
					int NumBcc = System.Convert.ToInt32(Email.NumBcc);
					int NumCC = System.Convert.ToInt32(Email.NumCC);
					int NumTo = System.Convert.ToInt32(Email.NumTo);
					string ReplyTo = (string) Email.ReplyTo;
					string SignedBy = (string) Email.SignedBy;
					int EmailSize = System.Convert.ToInt32(Email.Size);
					string LocalDate = (string) (Email.LocalDate.ToString());
					string EmailDate = (string) (Email.EmailDate.ToString());
					string Header = (string) Email.Header;
					string EmailBody = EMAIL.Body;
					
					ArrayList Recipients = new ArrayList();
					ArrayList EmailTo = new ArrayList();
					ArrayList EmailToAddr = new ArrayList();
					ArrayList EmailToName = new ArrayList();
					ArrayList Bcc = new ArrayList();
					ArrayList BccAddr = new ArrayList();
					ArrayList BccName = new ArrayList();
					ArrayList CC = new ArrayList();
					ArrayList CcAddr = new ArrayList();
					ArrayList CcName = new ArrayList();
					bool bLoadAttachments = false;
					
					string TempDir = System.IO.Path.GetTempPath();
					string AttachmentDir = TempDir + "Email\\Attachment";
					string EmailDir = TempDir + "Email";
					string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
					
					string tEmailDate = EmailDate.ToString();
					FixDate(ref tEmailDate);
					string tSubject = Subject.Substring(0, 100);
					RemoveBadChars(ref tSubject);
					
					string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.From, Subject);
					string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
					
					bool B = ExchangeEmailExists(EmailIdentifier);
					if (B)
					{
						if (dDebug_clsEmailFunctions)
						{
							LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 700X already exists: " + i.ToString()));
						}
						goto NextRec;
					}
					
					string EmailFQN = TempDir + "EMAIL." + NewGuid + ".MSG";
					
					//Console.WriteLine(Header)
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 800: " + i.ToString()));
					}
					if (NumAttachments > 0)
					{
						//** Clean out the directory
						DMA.deleteDirectoryFiles(AttachmentDir);
						// Save attachments to the "attachments" directory.
						Email.SaveAllAttachments(AttachmentDir);
						bLoadAttachments = true;
					}
					
					for (J = 0; J <= NumCC - 1; J++)
					{
						CC.Add(EMAIL.getCc[J].ToString());
						CcAddr.Add(Email.GetCcAddr(J).ToString());
						CcName.Add(Email.GetCcName(J).ToString());
						if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
						{
							Recipients.Add(Email.GetCcAddr(J).ToString());
						}
					}
					for (J = 0; J <= NumBcc - 1; J++)
					{
						Bcc.Add(EMAIL.getBcc[J].ToString());
						BccName.Add(Email.GetBccName(J).ToString());
						BccAddr.Add(Email.GetBccAddr(J).ToString());
						if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
						{
							Recipients.Add(Email.GetBccAddr(J).ToString());
						}
					}
					for (J = 0; J <= NumTo - 1; J++)
					{
						EmailTo.Add(Email.GetTo(J).ToString());
						EmailToAddr.Add(Email.GetToAddr(J).ToString());
						EmailToName.Add(Email.GetToName(J).ToString());
						if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
						{
							Recipients.Add(Email.GetToAddr(J).ToString());
						}
					}
					
					// Save the email to XML
					//email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
					
					// Save the email to EML
					//Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.0: " + i.ToString()));
					}
					Email.SaveEml(EmailFQN);
					
					//**********************************************************
					//IF CONVERT TO MSG THEN
					//READ IN THE NEW EML
					//CONVERT IT TO MSG
					//WRITE OUT THE MSG
					//SAVE THE MSG IMAGE INTO THE REPOSITORY.
					
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
							LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail 300.20 : " + ex.Message));
						}
						
						if (EmailFQN.Trim.Length == 0)
						{
							LOG.WriteToArchiveLog("Unrecoverable Error: getImapEmail - failed to convert EML to MSG File.");
							LOG.WriteToArchiveLog("NOTE : Most likely the Redemption DLL is not installed properly");
							goto NextRec;
						}
					}
					
					//**********************************************************
					
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.1: " + i.ToString()));
					}
					List<string> AttachedFiles = new List<string>();
					getDirectoryFiles(AttachmentDir, AttachedFiles);
					
					string DB_ID = "ECM.Library";
					string Server_UserID_StoreID = CurrMailFolder;
					
					//** Now, Load the EMAIL and its metadata into the repository
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.2: " + i.ToString()));
					}
					bool AttachmentsLoaded = false;
					ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, DateTime.Parse(EmailDate), UserLoginID, DateTime.Now, DateTime.Parse(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, (string) Email.Uidl, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
NextRec:
					if (dDebug_clsEmailFunctions)
					{
						LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 1000: " + i.ToString()));
					}
				}
				catch (System.Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail 300.21 : " + ex.Message));
				}
				
				
			}
			
			// Save the email to an XML file
			//bundle.SaveXml("bundle.xml")
			
			LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString()));
			
			// Disconnect from the IMAP server.
			// This example leaves the email on the IMAP server.
			imap.Disconnect();
		}
		public void SendImapEmailGmail()
		{
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			
			//  Any string argument automatically begins the 30-day trial.
			bool success;
			success = System.Convert.ToBoolean(mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G"));
			if (success != true)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("Component unlock failed");
				}
				return;
			}
			
			
			//  Use the GMail SMTP server
			mailman.SmtpHost = "smtp.gmail.com";
			mailman.SmtpPort = 587;
			mailman.StartTLS = true;
			
			//  Set the SMTP login/password.
			mailman.SmtpUsername = "wdalemiller";
			mailman.SmtpPassword = "Wdmsdm01";
			
			//  Create a new email object
			Chilkat.Email email = new Chilkat.Email();
			
			EMAIL.SUBJECT = "This is a test";
			EMAIL.Body = "This is a test";
			//email.From = "wdalemiller@gmail.com"
			Email.From = "support@EcmLibrary.com";
			Email.AddTo("W. Dale Miller", "dale@EcmLibrary.com");
			Email.AddTo("Dale Miller", "dale@javamasters.net");
			Email.AddTo("D. Miller", "dm@dmachicago.com");
			
			success = System.Convert.ToBoolean(mailman.SendEmail(email));
			if (success != true)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) mailman.LastErrorText);
				}
				return;
			}
			
			
			if (modGlobals.gRunUnattended == false)
			{
				MessageBox.Show("Mail Sent!");
			}
			
		}
		
		public void readPst(string pstFilePath, string pstName, int StoreIndexNbr)
		{
			
			LinkedList<string> mailItems = new LinkedList<string>();
			Microsoft.Office.Interop.Outlook.Application objOL;
			Microsoft.Office.Interop.Outlook.NameSpace objNS;
			Microsoft.Office.Interop.Outlook.MAPIFolder objFolder;
			
			objOL = Interaction.CreateObject("Outlook.Application", "");
			objNS = objOL.GetNamespace("MAPI");
			
			//** Add PST file (Outlook Data File) to Default Profile
			objNS.AddStore(pstFilePath);
			
			objFolder = objNS.Folders.GetLast();
			objFolder.Name = pstName;
			
			Microsoft.Office.Interop.Outlook.MAPIFolder rootFolder = objNS.Stores(StoreIndexNbr).GetRootFolder;
			//** Traverse through all folders in the PST file
			//** TODO: This is not recursive, refactor
			
			Microsoft.Office.Interop.Outlook.Folders subFolder;
			
			foreach (Microsoft.Office.Interop.Outlook.Folder Folder in rootFolder.Folders)
			{
				Console.WriteLine("rootFolder: " + rootFolder.Name);
				Console.WriteLine("rootFolder: " + rootFolder.EntryID);
				Console.WriteLine("Folder: " + Folder.Name);
				Console.WriteLine("Folder EntryID: " + Folder.EntryID);
				Console.WriteLine("Folder Items.Count: " + Folder.Items.Count);
				
				
				foreach (Microsoft.Office.Interop.Outlook.MailItem item in Folder.Items)
				{
					Console.WriteLine("Subject: " + item.Subject);
				}
			}
		}
		public void SetNewStore(string strFileName, string strDisplayName)
		{
			
			Microsoft.Office.Interop.Outlook.Application objOL;
			Microsoft.Office.Interop.Outlook.NameSpace objNS;
			Microsoft.Office.Interop.Outlook.MAPIFolder objFolder;
			
			objOL = Interaction.CreateObject("Outlook.Application", "");
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
			
			File F;
			
			if (F.Exists(EmlFQN + ".MSG"))
			{
				LOG.WriteToArchiveLog("NOTICE: convertEmlToMsg: \'" + EmlFQN + "\' already processed, skipping.");
				return "";
//				F.Delete(EmlFQN + ".MSG");
			}
			
			F.Copy(EmlFQN, EmlFQN + ".MSG");
			LL = 1;
			F = null;
			LL = 2;
			string EmlToMsgFQN = EmlFQN + ".MSG";
			LL = 3;
			try
			{
				LL = 4;
				Microsoft.Office.Interop.Outlook.PostItem objPost;
				Redemption.SafePostItem objSafePost;
				Microsoft.Office.Interop.Outlook.NameSpace objNS;
				Microsoft.Office.Interop.Outlook.MAPIFolder objJunkMailBox;
				LL = 5;
				Microsoft.Office.Interop.Outlook.Application objOL;
				//Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
				LL = 6;
				objOL = Interaction.CreateObject("Outlook.Application", "");
				objNS = objOL.GetNamespace("MAPI");
				LL = 7;
				objJunkMailBox = objNS.GetDefaultFolder(Microsoft.Office.Interop.Outlook.OlDefaultFolders.olFolderDeletedItems);
				objPost = objJunkMailBox.Items.Add(Microsoft.Office.Interop.Outlook.OlItemType.olPostItem);
				LL = 8;
				objSafePost = Interaction.CreateObject("Redemption.SafePostItem", "");
				LL = 9;
				objPost.Save();
				LL = 10;
				objSafePost.Item = objPost;
				
				int iAttachCnt = System.Convert.ToInt32(objSafePost.Attachments.Count);
				for (int I = 0; I <= iAttachCnt - 1; I++)
				{
					string SS = (string) (objSafePost.Attachments(I).FileName);
					Console.WriteLine(SS);
				}
				
				//For i As Integer = 0 To 100
				//    Console.WriteLine(objSafePost.Fields(0).ToString)
				//Next
				
				LL = 11;
				objSafePost.Import(EmlFQN, Redemption.RedemptionSaveAsType.olRFC822);
				LL = 13;
				objSafePost.MessageClass = "IPM.Note";
				LL = 14;
				// remove IPM.Post icon
				objSafePost.Fields(PR_ICON_INDEX) = "";
				LL = 15;
				objSafePost.SaveAs(EmlToMsgFQN, Microsoft.Office.Interop.Outlook.OlSaveAsType.olMSG);
				LL = 16;
				objSafePost = null;
				objPost = null;
				objJunkMailBox = null;
				objNS = null;
				LL = 17;
			}
			catch (System.Exception ex2)
			{
				LOG.WriteToArchiveLog((string) ("ERROR FATAL:convertEmlToMsg 100: LL = " + LL.ToString() + "\r\n" + ex2.Message + "\r\n" + ":" + EmlFQN + "\r\n" + ":" + EmlToMsgFQN));
				EmlToMsgFQN = "";
			}
			
			LOG.WriteToArchiveLog("NOTICE:convertEmlToMsg 200: LL = " + LL.ToString() + "\r\n" + ":" + EmlFQN + "\r\n" + ":\'" + EmlToMsgFQN + "\'.");
			
			File FF;
			if (FF.Exists(EmlToMsgFQN))
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
			for (int i = ToNAme.Length; i >= 0; i--)
			{
				if (ToNAme.Substring(i - 1, 1).Equals("."))
				{
					StringType.MidStmtStr(ref ToNAme, i, 1, "_");
					break;
				}
			}
			
			int LL = 0;
			
			File F;
			
			if (F.Exists(TnefFQN + ".MSG"))
			{
				F.Delete(TnefFQN + ".MSG");
			}
			
			//F.Copy(TnefFQN, ToNAme + ".MSG")
			LL = 1;
			LL = 2;
			string NtefToMSG = ToNAme + "~" + EmailGuid + ".MSG";
			LL = 3;
			
			if (F.Exists(NtefToMSG))
			{
				F.Delete(NtefToMSG);
			}
			
			//F.Copy(TnefFQN, ToNAme + ".MSG")
			LL = 1;
			F = null;
			
			try
			{
				LL = 4;
				Microsoft.Office.Interop.Outlook.PostItem objPost;
				Redemption.SafePostItem objSafePost;
				Microsoft.Office.Interop.Outlook.NameSpace objNS;
				Microsoft.Office.Interop.Outlook.MAPIFolder objJunkMailBox;
				LL = 5;
				Microsoft.Office.Interop.Outlook.Application objOL;
				//Dim objFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
				LL = 6;
				objOL = Interaction.CreateObject("Outlook.Application", "");
				objNS = objOL.GetNamespace("MAPI");
				LL = 7;
				objJunkMailBox = objNS.GetDefaultFolder(Microsoft.Office.Interop.Outlook.OlDefaultFolders.olFolderDeletedItems);
				objPost = objJunkMailBox.Items.Add(Microsoft.Office.Interop.Outlook.OlItemType.olPostItem);
				LL = 8;
				objSafePost = Interaction.CreateObject("Redemption.SafePostItem", "");
				LL = 9;
				objPost.Save();
				LL = 10;
				objSafePost.Item = objPost;
				LL = 11;
				objSafePost.Import(TnefFQN, Redemption.RedemptionSaveAsType.olTNEF);
				LL = 13;
				objSafePost.MessageClass = "IPM.Note";
				LL = 14;
				// remove IPM.Post icon
				objSafePost.Fields(PR_ICON_INDEX) = "";
				LL = 15;
				objSafePost.SaveAs(NtefToMSG, Microsoft.Office.Interop.Outlook.OlSaveAsType.olMSG);
				LL = 16;
				objSafePost = null;
				objPost = null;
				objJunkMailBox = null;
				objNS = null;
				LL = 17;
			}
			catch (System.Exception ex2)
			{
				LOG.WriteToArchiveLog((string) ("ERROR FATAL:ConvertNTEF 100: LL = " + LL.ToString() + "\r\n" + ex2.Message + "\r\n" + ":" + TnefFQN + "\r\n" + ":" + NtefToMSG));
				NtefToMSG = "";
			}
			
			LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 200: LL = " + LL.ToString() + "\r\n" + ":" + TnefFQN + "\r\n" + ":\'" + NtefToMSG + "\'.");
			
			File FF;
			if (FF.Exists(NtefToMSG))
			{
				LOG.WriteToArchiveLog((string) ("NOTICE:ConvertNTEF 400: EXISTS as " + NtefToMSG));
			}
			else
			{
				LOG.WriteToArchiveLog("NOTICE:ConvertNTEF 400:DOES NOT EXIST.");
				
			}
			
			return NtefToMSG;
			
		}
		
		public bool LoadMsgFile(string UID, string MsgFQN, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode, string DefaultSubject, ref string Body, ref List<string> AttachedFiles, bool bWinMail, string ParentGuid, ref string EmailDescription)
		{
			
			//'* There is a primary assumption that NO .dat files will be processed in this module
			
			string TempDir = UTIL.getTempProcessingDir();
			string AttachmentDir = TempDir + "\\Email\\Attachment";
			AttachmentDir = AttachmentDir.Replace("\\\\", "\\");
			
			string EmailDir = TempDir + "\\Email\\";
			EmailDir = EmailDir.Replace("\\\\", "\\");
			
			if (! Directory.Exists(EmailDir))
			{
				Directory.CreateDirectory(EmailDir);
			}
			if (! Directory.Exists(AttachmentDir))
			{
				Directory.CreateDirectory(AttachmentDir);
			}
			
			bool deleteThisFile = false;
			
			string TempSubject = DefaultSubject;
			string TempBody = Body;
			
			
			string NewGuid = Guid.NewGuid().ToString();
			string Subject = null;
			
			ArrayList lCC = new ArrayList();
			ArrayList lBCC = new ArrayList();
			ArrayList lEmailToAddr = new ArrayList();
			ArrayList lRecipients = new ArrayList();
			
			string CurrMailFolderID_ServerName = null;
			string SenderEmailAddress = null;
			string SenderName = null;
			DateTime SentOn = null;
			string ReceivedByName = null;
			DateTime ReceivedTime = null;
			DateTime CreationTime = null;
			string DB_ID = null;
			string Server_UserID_StoreID = null;
			int RetentionYears = System.Convert.ToInt32(null);
			int EmailSize = System.Convert.ToInt32(null);
			string EmailIdentifier = null;
			string EmailFQN = null;
			
			bool isPublic = System.Convert.ToBoolean(null);
			bool bEmlToMSG = System.Convert.ToBoolean(null);
			
			Microsoft.Office.Interop.Outlook.Application OL;
			Microsoft.Office.Interop.Outlook.MailItem Msg;
			
			int bx = 0;
			int LL = 0;
			
			bool bProcessThisFile = true;
			bool bExists = true;
			
			
			try
			{
				LL = 1;
				OL = new Microsoft.Office.Interop.Outlook.Application();
				LL = 2;
				Msg = OL.CreateItemFromTemplate(MsgFQN, null);
				LL = 3;
				// now use msg to get at the email parts
				Microsoft.Office.Interop.Outlook.Attachments msgAttachments;
				LL = 4;
				msgAttachments = Msg.Attachments;
				LL = 5;
				string EntryID = Msg.EntryID;
				if (Msg.Attachments.Count > 0)
				{
					Microsoft.Office.Interop.Outlook.Attachment Atmt;
					foreach (Microsoft.Office.Interop.Outlook.Attachment tempLoopVar_Atmt in Msg.Attachments)
					{
						Atmt = tempLoopVar_Atmt;
						try
						{
							string filename = AttachmentDir + "\\" + Atmt.FileName;
							filename = filename.Replace("\\\\", "\\");
							
							Atmt.SaveAsFile(filename);
							AttachedFiles.Add(filename);
						}
						catch (System.Exception)
						{
							LOG.WriteToArchiveLog((string) ("WARNING: Attachment not loaded in EMAIL : " + MsgFQN));
						}
						
					}
				}
				
				SenderName = Msg.SenderName;
				LL = 6;
				SenderEmailAddress = Msg.SenderEmailAddress;
				LL = 7;
				
				Microsoft.Office.Interop.Outlook.Recipients ReplyRecipients;
				LL = 8;
				ReplyRecipients = Msg.ReplyRecipients;
				LL = 9;
				
				string AllRecipientNames = "";
				string ReplyRecipientNames = Msg.ReplyRecipientNames;
				LL = 10;
				Microsoft.Office.Interop.Outlook.Recipients Recipients;
				LL = 11;
				Recipients = Msg.Recipients;
				if (Recipients != null)
				{
					int II = 1;
					for (II = 1; II <= Recipients.Count; II++)
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
				
				if (Msg.CC != null)
				{
					string strCC = Msg.CC;
					LL = 19;
					if (strCC.Length > 0)
					{
						LL = 20;
						string[] A = strCC.Split(";".ToCharArray());
						LL = 21;
						for (int i = 0; i <= (A.Length - 1); i++)
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
				
				if (Msg.BCC != null)
				{
					string strBCC = Msg.BCC;
					LL = 27;
					if (strBCC.Length > 0)
					{
						LL = 28;
						string[] A = strBCC.Split(";".ToCharArray());
						LL = 29;
						for (int i = 0; i <= (A.Length - 1); i++)
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
				
				if (Subject == null && DefaultSubject.Length > 0)
				{
					Subject = DefaultSubject;
				}
				else
				{
					Subject += (string) (" :: " + DefaultSubject);
				}
				
				int MsgSize = Msg.Size;
				LL = 37;
				
				if (MsgSize == 0 && Body != null)
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
					catch (System.Exception)
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
				string tSubject = Subject.Substring(0, 100);
				LL = 55;
				RemoveBadChars(ref tSubject);
				LL = 56;
				
				if (EmailSize == 0)
				{
					if (Body != null)
					{
						EmailSize = Body.Length;
					}
					else
					{
						EmailSize = int.Parse(tSubject.Length);
					}
				}
				
				if (SenderEmailAddress == null)
				{
					SenderEmailAddress = CurrMailFolder;
				}
				
				EmailIdentifier = UTIL.genEmailIdentifier(Msg.CreationTime, Msg.SenderEmailAddress, Subject);
				//Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
				
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
				
				getDirectoryFiles(AttachmentDir, AttachedFiles);
				LL = 61;
				
				for (int II = 0; II <= AttachedFiles.Count - 1; II++)
				{
					string sFqn = AttachedFiles(II);
					string fExt = UTIL.getFileSuffix(sFqn);
					if (fExt.ToUpper.Equals("MSG"))
					{
						string tPath = DMA.GetFilePath(sFqn);
						string fName = DMA.getFileName(sFqn);
						string NewDirName = UTIL.getTempProcessingDir() + "\\PendingEmail";
						NewDirName = NewDirName.Replace("\\\\", "\\");
						
						if (! Directory.Exists(NewDirName))
						{
							Directory.CreateDirectory(NewDirName);
						}
						
						string MoveFileName = NewDirName + "\\" + NewGuid.ToString() + "." + fName;
						
						if (File.Exists(MoveFileName))
						{
							File.Delete(MoveFileName);
						}
						File.Move(sFqn, MoveFileName);
						
						AttachedFiles(II) = "";
					}
				}
				
				OL = null;
				LL = 62;
				Msg = null;
				LL = 63;
				
				if (CreationTime > DateTime.Now)
				{
					CreationTime = DateTime.Now;
				}
				
				if (bWinMail == true)
				{
					return true;
				}
				
				bx = DB.iCount("Select count(*) from Email where EmailGuid = \'" + ParentGuid + "\'");
				//bx = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier) : LL = 64
				if (bx == 0)
				{
					ArchiveMsgEmail(UID, NewGuid, Body, Subject, lCC, lBCC, lEmailToAddr, lRecipients, CurrMailFolderID_ServerName, SenderEmailAddress, SenderName, SentOn, ReceivedByName, ReceivedTime, CreationTime, DB_ID, CurrMailFolder, Server_UserID_StoreID, RetentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG);
					
				}
SKIPMSGFILE:
				deleteThisFile = true;
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: LoadMsgFile LL = " + LL.ToString() + "\r\n" + ex.Message));
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
					catch (System.Exception)
					{
						LOG.WriteToArchiveLog((string) ("Error: Could not remove MSG file : " + MsgFQN));
					}
				}
			}
			
			if (bProcessThisFile == true)
			{
				if (NewGuid.Trim.Length > 0)
				{
					Body = UTIL.ReplaceSingleQuotes(Body);
					Subject = UTIL.ReplaceSingleQuotes(Subject);
					SenderName = UTIL.ReplaceSingleQuotes(SenderName);
					SenderEmailAddress = UTIL.ReplaceSingleQuotes(SenderEmailAddress);
					string tMsg = (string) (" " + Strings.Chr(254) + Body + Strings.Chr(254) + Subject + Strings.Chr(254) + SenderName + Strings.Chr(254) + SenderEmailAddress);
					concatEmailBody(tMsg, NewGuid);
				}
			}
			
			
			
			return bx;
		}
		
		public void ArchiveMsgEmail(string UID, string NewGuid, string Body, string Subject, ArrayList CC, ArrayList BCC, ArrayList EmailToAddr, ArrayList Recipients, string CurrMailFolderID_ServerName, string SenderEmailAddress, string SenderName, DateTime SentOn, string ReceivedByName, DateTime ReceivedTime, DateTime CreationTime, string DB_ID, string CurrMailFolder, string Server_UserID_StoreID, int RetentionYears, string RetentionCode, int EmailSize, List<string> AttachedFiles, string EntryID, string EmailIdentifier, string EmailFQN, string LibraryName, bool isPublic, bool bEmlToMSG)
		{
			
			FileInfo FI = new FileInfo(EmailFQN);
			string OriginalName = FI.Name;
			FI = null;
			
			if (CreationTime > DateTime.Now)
			{
				CreationTime = DateTime.Now;
			}
			
			string LastEmailArchRunDate = UserParmRetrive("LastEmailArchRunDate", modGlobals.gCurrUserGuidID);
			if (LastEmailArchRunDate.Trim().Length == 0)
			{
				LastEmailArchRunDate = "1/1/1950";
			}
			DateTime rightNow = DateTime.Now;
			if (RetentionYears == 0)
			{
				RetentionYears = int.Parse(val[getSystemParm("RETENTION YEARS")]);
			}
			
			//** Retain from entry time.
			rightNow = rightNow.AddYears(RetentionYears);
			string RetentionExpirationDate = rightNow.ToString();
			
			int EmailsSkipped = 0;
			bool DeleteMsg = false;
			DateTime CurrDateTime = DateTime.Now;
			int ArchiveAge = 0;
			int RemoveAge = 0;
			int XDaysArchive = 0;
			int XDaysRemove = 0;
			//Dim EmailFQN = ""
			bool bRemoveAfterArchive = false;
			bool bMsgUnopened = false;
			string CurrMailFolderName = "";
			DateTime MinProcessDate = DateTime.Parse("01/1/1910");
			string CurrName = CurrMailFolder;
			string ArchiveMsg = CurrName + ": ";
			
			string DB_ConnectionString = "";
			
			try
			{
				if (xDebug)
				{
					LOG.WriteToTraceLog("ArchiveExchangeEmails 200: ");
				}
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
					
					if (SentOn == null)
					{
						SentOn = DateTime.Parse("1/1/1899");
					}
					
					if (ReceivedTime == null)
					{
						ReceivedTime = DateTime.Parse("1/1/1899");
					}
					
					if (CreationTime == null)
					{
						CreationTime = DateTime.Parse("1/1/1970");
					}
					if (CreationTime < DateTime.Parse("1/1/1960"))
					{
						CreationTime = DateTime.Parse("1/1/1960");
					}
					
					//If frmReconMain.ckUseLastProcessDateAsCutoff.Checked Then
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
					
					DateTime DeferredDeliveryTime = null;
					string DownloadState = "";
					
					string HTMLBody = "";
					string Importance = "";
					bool IsMarkedAsTask = false;
					DateTime LastModificationTime = DateTime.Now;
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
					for (KK = 0; KK <= Recipients.Count - 1; KK++)
					{
						AllRecipients = AllRecipients + "; " + Recipients[KK];
						AddRecipToList(EmailGuid, (string) (Recipients[KK]), "RECIP");
					}
					
					if (AllRecipients.Length > 0)
					{
						string ch = AllRecipients.Substring(0, 1);
						if (ch.Equals(";"))
						{
							StringType.MidStmtStr(ref AllRecipients, 1, 1, " ");
							AllRecipients = AllRecipients.Trim;
						}
					}
					
					bool ReminderSet = false;
					DateTime ReminderTime = null;
					object ReplyRecipientNames = null;
					
					if (ReplyRecipientNames != null)
					{
						//For Each R In ReplyRecipientNames
						if (xDebug)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("ReplyRecipientNames: " + ReplyRecipientNames));
							}
						}
						//Next
					}
					
					string SenderEmailType = "";
					string Sensitivity = "";
					string SentOnBehalfOfName = "";
					
					ArchiveMsg = ArchiveMsg + " : " + Subject;
					
					DateTime TaskCompletedDate = null;
					DateTime TaskDueDate = DateTime.Now;
					string TaskSubject = "";
					
					string VotingOptions = "";
					string VotingResponse = "";
					object UserProperties = null;
					string Accounts = "None Supplied";
					
					string NewTime = ReceivedTime.ToString().Replace("//", ".");
					NewTime = ReceivedTime.ToString().Replace("/:", ".");
					NewTime = ReceivedTime.ToString().Replace(" ", "_");
					string NewSubject = Subject.Substring(0, 200);
					NewSubject = NewSubject.Replace(" ", "_");
					ConvertName(ref NewSubject);
					ConvertName(ref NewTime);
					
					bool bExcluded = modGlobals.isExcludedEmail(SenderEmailAddress);
					if (bExcluded)
					{
						goto LabelSkipThisEmail;
					}
					
					if (SenderEmailAddress.Length == 0 || SenderEmailAddress == null)
					{
						SenderEmailAddress = "Unknown";
					}
					
					if (SentOn == null)
					{
						SentOn = DateTime.Parse("1/1/1900");
					}
					
					if (SenderName.Length == 0 || SenderName == null)
					{
						SenderName = "Unknown";
					}
					
					if (xDebug)
					{
						LOG.WriteToTraceLog("ArchiveExchangeEmails 200: ");
					}
					
					//***** Prepare to use the EMAIL IDENTIFIER HERE at a later time *******
					int IX = DB.iCount("Select count(*) from Email where emailguid = \'" + NewGuid + "\' ");
					//Dim bExists As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
					if (IX > 0)
					{
						goto LabelSkipThisEmail;
					}
					
					AllRecipients += (string) (";" + ReceivedByName);
					
					System.Windows.Forms.Application.DoEvents();
					
					EMAIL.setEmailIdentifier(ref EmailIdentifier);
					EMAIL.setEntryid(ref EntryID);
					EMAIL.setEmailguid(ref EmailGuid);
					
					if (BCC.Count > 0)
					{
						foreach (string sBcc in BCC)
						{
							AllRecipients = AllRecipients + "; " + sBcc;
						}
						
					}
					if (CC.Count > 0)
					{
						foreach (string sBcc in CC)
						{
							AllRecipients = AllRecipients + "; " + sBcc;
						}
					}
					
					string AllBcc = "";
					foreach (string sBcc in BCC)
					{
						AllBcc = AllBcc + "; " + sBcc;
					}
					string AllCC = "";
					foreach (string sBcc in CC)
					{
						AllCC = AllCC + "; " + sBcc;
					}
					
					EMAIL.setAllrecipients(ref AllRecipients);
					EMAIL.setBcc(ref AllBcc);
					EMAIL.setBillinginformation(ref BillingInformation);
					EMAIL.setBody(UTIL.RemoveSingleQuotesV1(EmailBody));
					EMAIL.setCc(ref AllCC);
					EMAIL.setCompanies(ref Companies);
					EMAIL.setCreationtime(ref CreationTime);
					EMAIL.setCurrentuser(ref modGlobals.gCurrUserGuidID);
					EMAIL.setDeferreddeliverytime(ref DeferredDeliveryTime);
					EMAIL.setDeferreddeliverytime(ref DeferredDeliveryTime);
					EMAIL.setEmailguid(ref EmailGuid);
					//EMAIL.setEmailimage()
					
					EMAIL.setExpirytime(ref RetentionExpirationDate);
					EMAIL.setLastmodificationtime(ref LastModificationTime);
					EMAIL.setMsgsize(EmailSize.ToString());
					EMAIL.setReadreceiptrequested(OriginatorDeliveryReportRequested.ToString());
					EMAIL.setReceivedbyname(ref ReceivedByName);
					EMAIL.setReceivedtime(ref ReceivedTime);
					
					SenderEmailAddress = SenderEmailAddress.Substring(0, 79);
					EMAIL.setSenderemailaddress(ref SenderEmailAddress);
					
					SenderName = SenderName.Substring(0, 79);
					EMAIL.setSendername(ref SenderName);
					EMAIL.setSensitivity(ref Sensitivity);
					EMAIL.setSenton(ref SentOn);
					
					EMAIL.setSourcetypecode("MSG");
					
					EMAIL.setOriginalfolder(ref OriginalFolder);
					
					string SentTo = "";
					if (Recipients.Count > 0)
					{
						for (int iI = 0; iI <= Recipients.Count - 1; iI++)
						{
							SentTo += (string) (Recipients[iI] + ";");
						}
					}
					
					EMAIL.setSentto(ref ReceivedByName);
					EMAIL.setSubject(UTIL.RemoveSingleQuotesV1(Subject));
					string ShortSubj = Subject.Substring(0, 240);
					EMAIL.setShortsubj(UTIL.RemoveSingleQuotesV1(ShortSubj));
					bool MailAdded = false;
					
					bool BB = false;
					System.Windows.Forms.Application.DoEvents();
					
					if (xDebug)
					{
						LOG.WriteToTraceLog("ArchiveExchangeEmails 300: ");
					}
					
					//Dim bx As Integer = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier)
					IX = DB.iCount("Select count(*) from Email where emailguid = \'" + NewGuid + "\' ");
					if (IX == 0)
					{
						//*****  ***********************************************
						//Convert to MSG and store the image as a MSG file
						string StrHashTemp = ENC.getSha1HashKey(EmailIdentifier);
						BB = EMAIL.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, StrHashTemp, CurrMailFolder);
						//*****  ***********************************************
						
						if (BB)
						{
							
							//frmReconMain.EmailsBackedUp += 1
							//frmExchangeMonitor.lblCnt.Text = frmReconMain.EmailsBackedUp.ToString
							
							//**********************************************************************************************
							//** Call Filestream service or standard service here
							bool bMail = UpdateEmailMsg(OriginalName, (int) 2222.1, UID, EmailFQN, EmailGuid, RetentionCode, isPublic.ToString(), StrHashTemp);
							//**********************************************************************************************
							if (bMail == false)
							{
								//** It failed to add an MSG - try saving it as an EML
								string fExt = UTIL.getFileSuffix(EmailFQN);
								if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
								{
									string TempFQN = "";
									bool BBX = false;
									if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
									{
										EmailFQN = EmailFQN.Substring(0, EmailFQN.IndexOf(".MSG") + 0);
										//**********************************************************************************************
										//** Call Filestream service or standard service here
										BBX = UpdateEmailMsg(OriginalName, (int) 2222.2, UID, EmailFQN, EmailGuid, RetentionCode, isPublic.ToString(), StrHashTemp);
										//**********************************************************************************************
										if (BBX == true)
										{
											EMAIL.setSourcetypecode("EML");
										}
										else
										{
											//** It failed again, SKIP IT.
											LOG.WriteToArchiveLog((string) ("ERROR 299c: Failed to add email" + EmailFQN));
											goto LabelSkipThisEmail;
										}
									}
								}
							}
							//EmailIdentifier
							//**WDM Removed below 3/11/2010
							
							string sSql = "Update EMAIL set EmailIdentifier = \'" + EmailIdentifier + "\' where EmailGuid = \'" + EmailGuid + "\'";
							bool bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99xx");
							}
							
							//LibraryName , ByVal isPublic As Boolean
							if (LibraryName.Trim().Length > 0)
							{
								string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
								string S = "";
								clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
								int iCnt = LI.cnt_UniqueEntry(LibraryName, EmailGuid);
								if (iCnt == 0)
								{
									LI.setSourceguid(ref EmailGuid);
									LI.setItemtitle(Subject.Substring(0, 200));
									LI.setItemtype(ref SourceTypeCode);
									LI.setLibraryitemguid(Guid.NewGuid().ToString());
									LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
									LI.setLibraryowneruserid(ref LibraryOwnerUserID);
									LI.setLibraryname(ref LibraryName);
									LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
									bool b = LI.Insert();
									if (b == false)
									{
										LOG.WriteToArchiveLog((string) ("ERROR: 198.171.76 - Filed to add Email Library Item: " + LibraryName + " : + " + Subject));
									}
								}
								LI = null;
								GC.Collect();
							}
							if (bEmlToMSG == true)
							{
								sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = \'" + EmailGuid + "\'";
								bbExec = ExecuteSqlNewConn(sSql, false);
								if (! bbExec)
								{
									LOG.WriteToArchiveLog("ERROR: 1234.99zx1");
								}
							}
							if (isPublic == true)
							{
								sSql = "Update EMAIL set isPublic = 1 where EmailGuid = \'" + EmailGuid + "\'";
							}
							else
							{
								sSql = "Update EMAIL set isPublic = 0 where EmailGuid = \'" + EmailGuid + "\'";
							}
							bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99xx2");
							}
							
							sSql = "Update EMAIL set CurrMailFolderID = \'" + CurrMailFolderID_ServerName + "\' where EmailGuid = \'" + EmailGuid + "\'";
							bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99a");
							}
							
							string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
							sSql = "Update EMAIL set CRC = \'" + EmailHashCode + "\' where EmailGuid = \'" + EmailGuid + "\'";
							
							bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99b");
							}
							
							//RetentionExpirationDate
							sSql = "Update EMAIL set RetentionExpirationDate = \'" + RetentionExpirationDate + "\' where EmailGuid = \'" + EmailGuid + "\'";
							bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99c");
							}
							sSql = "Update EMAIL set RetentionCode = \'" + RetentionCode + "\' where EmailGuid = \'" + EmailGuid + "\'";
							bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99c");
							}
							
							setRetentionDate(EmailGuid, RetentionCode, ".EML");
							
							if (xDebug)
							{
								LOG.WriteToTraceLog("ArchiveExchangeEmails 500: ");
							}
							
							MailAdded = true;
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToTraceLog("ArchiveExchangeEmails 600: ");
							}
							//**WDM Removed below 3/11/2010
							
							string sSql = "Update EMAIL set EmailIdentifier = \'" + EmailIdentifier + "\' where EmailGuid = \'" + EmailGuid + "\'";
							bool bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99xx12");
							}
							
							if (bEmlToMSG == true)
							{
								sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = \'" + EmailGuid + "\'";
								bbExec = ExecuteSqlNewConn(sSql, false);
							}
							
							if (LibraryName.Trim().Length > 0)
							{
								string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
								string S = "";
								clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
								int iCnt = LI.cnt_UniqueEntry(LibraryName, EmailGuid);
								if (iCnt == 0)
								{
									LI.setSourceguid(ref EmailGuid);
									LI.setItemtitle(Subject.Substring(0, 200));
									LI.setItemtype(ref SourceTypeCode);
									LI.setLibraryitemguid(Guid.NewGuid().ToString());
									LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
									LI.setLibraryowneruserid(ref LibraryOwnerUserID);
									LI.setLibraryname(ref LibraryName);
									LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
									bool b = LI.Insert();
									if (b == false)
									{
										LOG.WriteToArchiveLog((string) ("ERROR: 198.171.76 - Filed to add Email Library Item: " + LibraryName + " : + " + Subject));
									}
								}
								LI = null;
								GC.Collect();
							}
							
							if (isPublic == true)
							{
								sSql = "Update EMAIL set isPublic = 1 where EmailGuid = \'" + EmailGuid + "\'";
							}
							else
							{
								sSql = "Update EMAIL set isPublic = 0 where EmailGuid = \'" + EmailGuid + "\'";
							}
							bbExec = ExecuteSqlNewConn(sSql, false);
							if (! bbExec)
							{
								LOG.WriteToArchiveLog("ERROR: 1234.99xx6");
							}
							
							frmMain.Default.FilesBackedUp++;
							
							if (xDebug)
							{
								LOG.WriteToArchiveLog("Error 0743.23 - failed to archive email.");
							}
							MailAdded = false;
							if (xDebug)
							{
								LOG.WriteToTraceLog("ArchiveExchangeEmails 700: ");
							}
						}
					}
					else
					{
						if (xDebug)
						{
							LOG.WriteToTraceLog("ArchiveExchangeEmails 800: ");
						}
						BB = true;
						MailAdded = false;
					}
					if (BB)
					{
						//BB = UpdateEmailMsg(EmailFQN, EmailGuid )
						try
						{
							Kill(EmailFQN);
							if (xDebug)
							{
								LOG.WriteToTraceLog("ArchiveExchangeEmails 900: ");
							}
						}
						catch (System.Exception ex)
						{
							Console.WriteLine(ex.Message);
							if (xDebug)
							{
								LOG.WriteToTraceLog("ArchiveExchangeEmails 1000: ");
							}
						}
						
						DeleteMsg = true;
					}
					else
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Error 623.45 - Failed to archive email: " + Subject));
						}
						MailAdded = false;
						if (xDebug)
						{
							LOG.WriteToTraceLog("ArchiveExchangeEmails 2000: ");
						}
						goto LabelSkipThisEmail;
					}
					
					System.Windows.Forms.Application.DoEvents();
					
					if (MailAdded)
					{
						if (xDebug)
						{
							LOG.WriteToTraceLog("ArchiveExchangeEmails 3000: ");
						}
						SL2.Clear();
						if (AllCC != null)
						{
							if (AllCC.Trim().Length > 0)
							{
								string[] A = new string[1];
								if (AllCC.IndexOf(";") + 1 > 0)
								{
									A = AllCC.Split(';');
								}
								else
								{
									A[0] = AllCC;
								}
								for (KK = 0; KK <= (A.Length - 1); KK++)
								{
									string SKEY = A[KK];
									if (SKEY != null)
									{
										bool BXX = SL.ContainsKey(SKEY);
										if (! BXX)
										{
											SL2.Add(SKEY, "CC");
										}
									}
								}
							}
						}
						if (AllBcc != null)
						{
							if (AllBcc.Trim().Length > 0)
							{
								string[] A = new string[1];
								if (AllBcc.IndexOf(";") + 1 > 0)
								{
									A = AllBcc.Split(';');
								}
								else
								{
									A[0] = AllBcc;
								}
								for (KK = 0; KK <= (A.Length - 1); KK++)
								{
									string SKEY = A[KK];
									if (SKEY != null)
									{
										bool BXX = SL.ContainsKey(SKEY);
										if (! BXX)
										{
											SL2.Add(SKEY, "allbcc");
										}
									}
								}
							}
						}
						
						//For KK = 0 To Recipients.Count - 1
						foreach (string tAddr in Recipients)
						{
							//Dim Addr  = Recipients.Item(i)
							string Addr = tAddr;
							RECIPS.setEmailguid(ref EmailGuid);
							RECIPS.setRecipient(ref Addr);
							bool BXX = SL2.ContainsKey(Addr);
							if (! BXX)
							{
								RECIPS.setTyperecp("RECIP");
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
						
						if (AttachedFiles.Count > 0)
						{
							if (xDebug)
							{
								LOG.WriteToTraceLog("ArchiveExchangeEmails 4000: ");
							}
							foreach (string FileName in AttachedFiles)
							{
								//Dim TempDir  = System.IO.Path.GetTempPath
								//FileName  = AttachedFiles.Item(II)
								
								if (FileName.Length == 0)
								{
									goto SkipThisOne;
								}
								
								string FileExt = (string) ("." + UTIL.getFileSuffix(FileName));
								
								string fExt2 = DMA.getFileExtension(FileName);
								if (fExt2.Length == 0 && FileName.IndexOf("UNKNOWN") + 1 > 0)
								{
									//***********************************************************
									LOG.WriteToArchiveLog("ISSUE/WARNING: An email was sent from Outlook as an RTF formatted attachment - could not be converted \'" + FileName + "\'.");
									
									clsEmailFunctions EMX = new clsEmailFunctions();
									
									string FileNameConverted = EMX.ConvertNTEFtoMSG(NewGuid, FileName);
									if (FileNameConverted.Length > 0)
									{
										try
										{
											File FF;
											
											string EmailDescription = "";
											
											if (FF.Exists(FileNameConverted))
											{
												EMX.LoadMsgFile(UID, FileNameConverted, ServerName, CurrMailFolder, LibraryName, RetentionCode, Subject, ref EmailBody, ref AttachedFiles, true, NewGuid, ref EmailDescription);
											}
											FF = null;
											if (EmailDescription.Length > 0)
											{
												EmailDescription = UTIL.RemoveSingleQuotes(EmailDescription);
												concatEmailBody(EmailDescription, EmailGuid);
											}
										}
										catch (System.Exception ex)
										{
											LOG.WriteToArchiveLog((string) ("NOTICE: " + FileNameConverted + " processed - " + ex.Message));
										}
										
										
									}
									
									EMX = null;
									//***********************************************************
								}
								
								int bCnt = ATYPE.cnt_PK29(FileExt);
								bool isZipFile = false;
								
								if (FileName.IndexOf("winmail.dat") + 1 > 0)
								{
									goto SkipThisOne;
								}
								
								if (bCnt == 0)
								{
									bool B1 = ZF.isZipFile(FileName);
									if (B1)
									{
										ATYPE.setIszipformat("1");
										isZipFile = true;
									}
									else
									{
										ATYPE.setIszipformat("0");
										isZipFile = false;
									}
									ATYPE.setAttachmentcode(ref FileExt);
									ATYPE.Insert();
								}
								
								bool BBB = ZF.isZipFile(FileName);
								
								ATYPE.setDescription("Auto added this code.");
								if (BBB)
								{
									ATYPE.setIszipformat("1");
									isZipFile = true;
								}
								else
								{
									ATYPE.setIszipformat("0");
									isZipFile = false;
								}
								if (isZipFile == true)
								{
									//** Explode and load
									string AttachmentName = FileName;
									bool SkipIfAlreadyArchived = false;
									//ZF.ProcessEmailZipFile(gMachineID, EmailGuid, FileName , gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName)
									int StackLevel = 0;
									Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
									ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, FileName, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
									ListOfFiles = null;
									GC.Collect();
								}
								else
								{
									FileExt = (string) ("." + UTIL.getFileSuffix(FileName));
									string AttachmentName = FileName;
									string Sha1Hash = ENC.getSha1HashFromFile(FileName);
									bool bbx = InsertAttachmentFqn(modGlobals.gCurrUserGuidID, FileName, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic.ToString(), CurrMailFolder);
								}
SkipThisOne:
								1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
							}
						}
						//If bWinMail = True Then
						//    For Each sFileToRemove As String In AttachedFiles
						//        If File.Exists(sFileToRemove) Then
						//            ISO.saveIsoFile(" FilesToDelete.dat", sFileToRemove + "|")
						//            'File.Delete(sFileToRemove)
						//        End If
						//    Next
						//    bWinMail = False
						//End If
					}
					
					System.Windows.Forms.Application.DoEvents();
					if (xDebug)
					{
						LOG.WriteToTraceLog("ArchiveExchangeEmails 5000: ");
					}
LabelSkipThisEmail:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
				catch (System.Exception ex)
				{
					EmailsSkipped++;
					LOG.WriteToArchiveLog(ArchiveMsg + " SKIPPED - " + ex.Message);
					LOG.WriteToArchiveLog((string) ("clsArchiver : ArchiveEmailsInFolder: 100 - item#" + i.ToString() + " : " + ex.Message));
				}
				
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			catch (System.Exception ex)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show(ex.Message);
				}
			}
			
		}
		
		//Sub ApplyPendingEmail(ByVal UID As String, ByVal ServerName As String, _
		//                     ByVal CurrMailFolder As String, _
		//                     ByVal LibraryName As String, _
		//                     ByVal RetentionCode )
		
		//    Dim MsgFQN As String = ""
		//    Dim DefaultSubject As String = ""
		//    Dim Body As String = ""
		//    Dim AttachedFiles As New List(Of String)
		//    Dim bWinMail As Boolean = False
		
		//    Dim I As Integer = 0
		//    Dim J As Integer = 0
		//    Dim TempDir  = System.IO.Path.GetTempPath
		//    Dim AttachmentDir  = TempDir  + "Email\Attachment"
		//    Dim PendDir  = TempDir  + "Email\Attachment\PendingEmail"
		//    Dim EmailDir  = TempDir  + "Email"
		
		//    Dim D As Directory
		//    If Not D.Exists(PendDir) Then
		//        D = Nothing
		//        Return
		//    End If
		
		//    Dim storefile As Directory
		//    Dim directory As String
		//    Dim files As String()
		//    Dim File As String
		//    Dim DeleteFiles As Boolean = True
		
		//    Try
		//        files = storefile.GetFiles(PendDir, "*.MSG")
		//        For Each File In files
		//            DMA.deleteDirectoryFiles(AttachmentDir )
		//            Dim FQN  = File
		
		//            Dim ParentGuid As String = ""
		//            If InStr(File, ".") > 0 Then
		//                ParentGuid = Mid(File, 1, InStr(File, ".") - 1)
		//                If isGuid(ParentGuid) = False Then
		//                    ParentGuid = ""
		//                End If
		//            End If
		//            Dim EmailDescription As String = ""
		//            LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, Body, AttachedFiles, bWinMail, ParentGuid, EmailDescription)
		//        Next
		//    Catch ex As System.Exception
		//        log.WriteToArchiveLog("ERROR: ApplyPendingEmail - 100 : " + ex.Message)
		//        DeleteFiles = False
		//    Finally
		//        If DeleteFiles = True Then
		//            For Each File In files
		//                Dim FQN  = PendDir + "\" + File
		
		//            Next
		//        End If
		
		//    End Try
		
		//End Sub
		
		public void ApplyPendingEmail(string UID, string DirectoryName, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode)
		{
			
			string MsgFQN = "";
			string DefaultSubject = "";
			string Body = "";
			List<string> AttachedFiles = new List<string>();
			bool bWinMail = false;
			
			int I = 0;
			int J = 0;
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string PendDir = DirectoryName;
			string EmailDir = TempDir + "Email";
			
			Directory D;
			if (! D.Exists(PendDir))
			{
				D = null;
				return;
			}
			
			Directory storefile;
			string directory;
			string[] files;
			string File;
			bool DeleteFiles = true;
			
			try
			{
				files = storefile.GetFiles(PendDir, "*.MSG");
				foreach (string tempLoopVar_File in files)
				{
					File = tempLoopVar_File;
					DMA.deleteDirectoryFiles(AttachmentDir);
					string FQN = File;
					string ParentGuid = "";
					if (File.IndexOf(".") + 1 > 0)
					{
						ParentGuid = File.Substring(0, File.IndexOf(".") + 0);
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
				LOG.WriteToArchiveLog((string) ("ERROR: ApplyPendingEmail - 100 : " + ex.Message));
				DeleteFiles = false;
			}
			finally
			{
				if (DeleteFiles == true)
				{
					foreach (string tempLoopVar_File in files)
					{
						File = tempLoopVar_File;
						string FQN = PendDir + "\\" + File;
						
					}
				}
				
			}
			
		}
		
		public void ApplyPendingEmail(string UID, List<string> SelectedFiles, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode)
		{
			
			string MsgFQN = "";
			string DefaultSubject = "";
			string Body = "";
			List<string> AttachedFiles = new List<string>();
			bool bWinMail = false;
			
			int I = 0;
			int J = 0;
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			//Dim PendDir  = DirectoryName
			string EmailDir = TempDir + "Email";
			
			//Dim D As Directory
			//If Not D.Exists(PendDir) Then
			//    D = Nothing
			//    Return
			//End If
			
			Directory storefile;
			string directory;
			string[] files;
			
			bool DeleteFiles = true;
			
			try
			{
				
				foreach (string File in SelectedFiles)
				{
					DMA.deleteDirectoryFiles(AttachmentDir);
					string FQN = File;
					string ParentGuid = "";
					if (File.IndexOf(".") + 1 > 0)
					{
						ParentGuid = File.Substring(0, File.IndexOf(".") + 0);
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
				LOG.WriteToArchiveLog((string) ("ERROR: ApplyPendingEmail - 100 : " + ex.Message));
			}
			
		}
		
		public void ArchiveEmbeddedEmailMessage(string UID, Chilkat.Email EM, string LibraryName, string EmailBoxName, string RetentionCode, bool isPublic, bool bEmlToMSG, string ServerName, string ParentGuid, int DaysToHold, string EmailIdentifier, string EntryID)
		{
			//ArchiveEmbeddedEmailMessage(uid, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold)
			
			int LL = 0;
			
			int PauseThreadMS = 0;
			try
			{
				PauseThreadMS = int.Parse(getUserParm("UserEmail_Pause"));
			}
			catch (System.Exception)
			{
				PauseThreadMS = 0;
			}
			
			try
			{
				string TempDir = UTIL.getTempProcessingDir();
				LL = 1;
				TempDir = TempDir.Replace("\\\\", "\\");
				string AttachmentDir = TempDir + "Email\\Attachment";
				LL = 2;
				AttachmentDir = AttachmentDir.Replace("\\\\", "\\");
				
				string EmailDir = TempDir + "Email";
				LL = 3;
				EmailDir = EmailDir.Replace("\\\\", "\\");
				
				List<string> AttachedFiles = new List<string>();
				LL = 4;
				string Body = (string) EM.Body;
				LL = 6;
				string BounceAddress = (string) EM.BounceAddress;
				LL = 7;
				string Charset = (string) EM.Charset;
				LL = 8;
				bool Decrypted = System.Convert.ToBoolean(EM.Decrypted);
				LL = 9;
				DateTime EmailDate = EM.EmailDate;
				LL = 10;
				string EncryptedBy = (string) EM.EncryptedBy;
				LL = 11;
				string FileDistList = (string) EM.FileDistList;
				LL = 12;
				string From = (string) EM.From;
				LL = 13;
				string FromAddress = (string) EM.FromAddress;
				LL = 14;
				string FromName = (string) EM.FromName;
				LL = 15;
				string Header = (string) EM.Header;
				LL = 16;
				string Language = (string) EM.Language;
				LL = 17;
				string LastErrorHtml = (string) EM.LastErrorHtml;
				LL = 18;
				string LastErrorText = (string) EM.LastErrorText;
				LL = 19;
				string LastErrorXml = (string) EM.LastErrorXml;
				LL = 20;
				DateTime LocalDate = EM.LocalDate;
				LL = 21;
				string Mailer = (string) EM.Mailer;
				LL = 22;
				int NumAlternatives = System.Convert.ToInt32(EM.NumAlternatives);
				LL = 23;
				int NumAttachedMessages = System.Convert.ToInt32(EM.NumAttachedMessages);
				LL = 24;
				int NumAttachments = System.Convert.ToInt32(EM.NumAttachments);
				LL = 25;
				int NumBcc = System.Convert.ToInt32(EM.NumBcc);
				LL = 26;
				int NumCC = System.Convert.ToInt32(EM.NumCC);
				LL = 27;
				int NumDaysOld = System.Convert.ToInt32(EM.NumDaysOld);
				LL = 28;
				int NumHeaderFields = System.Convert.ToInt32(EM.NumHeaderFields);
				LL = 29;
				int NumRelatedItems = System.Convert.ToInt32(EM.NumRelatedItems);
				LL = 30;
				int NumReplacePatterns = System.Convert.ToInt32(EM.NumReplacePatterns);
				LL = 31;
				int NumTo = System.Convert.ToInt32(EM.NumTo);
				LL = 32;
				bool OverwriteExisting = System.Convert.ToBoolean(EM.OverwriteExisting);
				LL = 33;
				string PreferredCharset = (string) EM.PreferredCharset;
				LL = 34;
				bool ReceivedEncrypted = System.Convert.ToBoolean(EM.ReceivedEncrypted);
				LL = 35;
				bool ReceivedSigned = System.Convert.ToBoolean(EM.ReceivedSigned);
				LL = 36;
				string ReplyTo = (string) EM.ReplyTo;
				LL = 37;
				bool ReturnReceipt = System.Convert.ToBoolean(EM.ReturnReceipt);
				LL = 38;
				bool SendEncrypted = System.Convert.ToBoolean(EM.SendEncrypted);
				LL = 39;
				bool SendSigned = System.Convert.ToBoolean(EM.SendSigned);
				LL = 40;
				bool SignaturesValid = System.Convert.ToBoolean(EM.SignaturesValid);
				LL = 41;
				string SignedBy = (string) EM.SignedBy;
				LL = 42;
				int Size = System.Convert.ToInt32(EM.Size);
				LL = 43;
				string Subject = (string) EM.Subject;
				LL = 44;
				Subject = UTIL.RemoveSingleQuotes(Subject);
				LL = 45;
				string Uidl = (string) EM.Uidl;
				LL = 46;
				bool VerboseLogging = System.Convert.ToBoolean(EM.VerboseLogging);
				LL = 47;
				
				string tGMT = EmailDate.ToString();
				LL = 49;
				FixDate(ref tGMT);
				LL = 50;
				string tSubject = Subject.Substring(0, 100);
				LL = 51;
				RemoveBadChars(ref tSubject);
				LL = 52;
				
				LL = 53;
				if (NumAttachedMessages > 0)
				{
					LL = 54;
					//** This is a recursive operating on the EMBEDDED message, not the parent message
					for (int II = 0; II <= NumAttachedMessages - 1; II++)
					{
						LL = 55;
						ArchiveEmbeddedEmailMessage(UID, EM, LibraryName, EmailBoxName, RetentionCode, isPublic, bEmlToMSG, ServerName, ParentGuid, DaysToHold, EmailIdentifier, EntryID);
						LL = 56;
					}
					LL = 57;
				}
				LL = 58;
				
				LL = 59;
				
				//Dim EmailIdentifier As String = UTIL.genEmailIdentifier(Body, Size, tGMT, FromAddress.Trim, Subject, NumAttachments)
				//Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
				
				string ToAddr = ParentGuid;
				UTIL.deleteDirectoryFile(AttachmentDir);
				LL = 70;
				
				if (NumAttachments > 0)
				{
					LL = 71;
					//** This is operating on the EMBEDDED message, not the parent message
					//** Clean out the directory :LL =  72
					EM.SaveAllAttachments(AttachmentDir);
					LL = 73;
					getDirectoryFiles(AttachmentDir, AttachedFiles);
					LL = 74;
				}
				LL = 76;
				
				LL = 77;
				string NewGuid = Guid.NewGuid().ToString();
				LL = 78;
				ArrayList CcAddr = new ArrayList();
				LL = 79;
				ArrayList BccAddr = new ArrayList();
				LL = 80;
				ArrayList EmailToAddr = new ArrayList();
				LL = 81;
				ArrayList Recipients = new ArrayList();
				LL = 82;
				DateTime ReceivedTime = DateTime.Now;
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
				string EmailFQN = EmailDir + "\\Email.Embedded~" + (NewGuid + "~.EML");
				LL = 89;
				
				LL = 90;
				int EmailSize = Size;
				LL = 91;
				
				LL = 92;
				int retentionYears = getRetentionPeriod(RetentionCode);
				LL = 93;
				bool BB = System.Convert.ToBoolean(EM.SaveEml(EmailFQN));
				LL = 94;
				if (BB == false)
				{
					LL = 95;
					LOG.WriteToArchiveLog((string) ("ERROR: 001a ArchiveEmbeddedEmailMessage - failed to save EML File." + "\r\n" + EmailFQN));
					LL = 96;
					return;
//					LL = 97;
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
						if (EmailFQN.Trim.Length == 0)
						{
							LL = 102;
							LOG.WriteToArchiveLog("FATAL ERROR: 100 ArchiveEmbeddedEmailMessage - failed to convert EML to MSG File.");
							LL = 103;
							LOG.WriteToArchiveLog("NOTE:        100 ArchiveEmbeddedEmailMessage:  Most likely the Redemption DLL is not installed properly");
							LL = 104;
							return;
//							LL = 105;
						}
						LL = 106;
						//log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'") :LL =  107
					}
				}
				
				bool AttachmentsLoaded = false;
				
				LL = 110;
				ArchiveExchangeEmails(UID, NewGuid, Body, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, ReceivedTime, UserLoginID, DateTime.Now, ReceivedTime, DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
				LL = 138;
				if (PauseThreadMS > 0)
				{
					System.Threading.Thread.Sleep(PauseThreadMS);
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
					string tMsg = (string) (" " + Strings.Chr(254) + Body + Strings.Chr(254) + Subject + Strings.Chr(254) + FromName + Strings.Chr(254) + FromAddress);
					LL = 144;
					concatEmailBody(tMsg, ParentGuid);
					LL = 145;
				}
				LL = 146;
				
				LL = 147;
				ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
				LL = 148;
				string ConversionDir = UTIL.getTempProcessingDir() + "\\WMCONVERT\\";
				LL = 149;
				
				ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
				
				LL = 150;
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: ArchiveEmbeddedEmailMessage 100 - LL = " + LL.ToString() + " : " + ex.Message));
			}
			
			LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#5");
			
SKIPTOHERE:
			1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			
		}
		
		public bool TestEmailConnection(string EmailServer, string UserID, string Password, string Port, bool IMap, bool POP, bool SSL)
		{
			
		}
		public bool ckImapSSLConnection(string MailServerAddr, int PortNbr, string UserLoginID, string LoginPassWord)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
			ENC = null;
			
			Chilkat.Imap imap = new Chilkat.Imap();
			
			bool success;
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string EmailDir = TempDir + "Email";
			string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
			
			//  Anything unlocks the component and begins a fully-functional 30-day trial.
			success = System.Convert.ToBoolean(imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G"));
			if (success != true)
			{
				MessageBox.Show((string) imap.LastErrorText);
				return false;
			}
			
			//  To use a secure SSL connection, set SSL and the port:
			imap.Ssl = true;
			//  The typical port for IMAP SSL is 993
			
			imap.Port = PortNbr;
			
			
			//  Connect to an IMAP server.
			success = System.Convert.ToBoolean(imap.Connect(MailServerAddr));
			if (success != true)
			{
				MessageBox.Show((string) imap.LastErrorText);
				return false;
			}
			
			//  Login
			success = System.Convert.ToBoolean(imap.Login(UserLoginID, LoginPassWord));
			if (success != true)
			{
				MessageBox.Show((string) imap.LastErrorText);
				return false;
			}
			
			//'  Select an IMAP mailbox
			//success = imap.SelectMailbox("Inbox")
			//If (success <> True) Then
			//    messagebox.show(imap.LastErrorText)
			//    Return False
			//End If
			
			imap.Disconnect();
			
			return true;
			
			
		}
		public bool clIMapConnection(string MailServerAddr, int PortNbr, string UserLoginID, string LoginPassWord)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
			ENC = null;
			
			Chilkat.Imap imap = new Chilkat.Imap();
			imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
			
			imap.Port = val[PortNbr];
			
			try
			{
				imap.Connect(MailServerAddr);
			}
			catch (System.Exception)
			{
				MessageBox.Show((string) imap.LastErrorText);
				return false;
			}
			
			try
			{
				imap.Login(UserLoginID, LoginPassWord);
			}
			catch (System.Exception)
			{
				MessageBox.Show((string) imap.LastErrorText);
				return false;
			}
			
			try
			{
				imap.SelectMailbox("Inbox");
			}
			catch (System.Exception)
			{
				MessageBox.Show((string) imap.LastErrorText);
				return false;
			}
			
			
			imap.Disconnect();
			
			return true;
			
		}
		public int ckPopConnection(string ServerName, int PortNbr, string UserLoginID, string LoginPassWord)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
			ENC = null;
			
			//ServerName  = "pop.dmachicago.com"
			//read mail from a POP3 server.
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G");
			
			mailman.MailHost = ServerName;
			mailman.PopPassword = LoginPassWord;
			mailman.PopUsername = UserLoginID;
			int iCnt = -1;
			
			try
			{
				iCnt = System.Convert.ToInt32(mailman.GetMailboxCount);
				return iCnt;
			}
			catch (System.Exception ex)
			{
				MessageBox.Show((string) (mailman.LastErrorText + "\r\n" + "\r\n" + ex.Message));
			}
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		
		public int ckPopSSL(string ServerName, int PortNbr, string UserLoginID, string LoginPassWord)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			LoginPassWord = ENC.AES256DecryptString(LoginPassWord);
			ENC = null;
			
			// Create a mailman object for reading email.
			Chilkat.MailMan mailman = new Chilkat.MailMan();
			string EmailFrom = "";
			string EmailSubject = "";
			string EmailBody = "";
			var EmailFromAddress = "";
			var EmailFromName = "";
			
			// Any string passed to UnlockComponent automatically begins a 30-day trial.
			bool success;
			success = System.Convert.ToBoolean(mailman.UnlockComponent("DMACHIMAILQ_y36ZrqXsoO8G"));
			if (success != true)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) mailman.LastErrorText);
				}
				return 0;
			}
			
			// Set our POP3 hostname, login and password
			mailman.MailHost = ServerName;
			mailman.PopUsername = UserLoginID;
			mailman.PopPassword = LoginPassWord;
			
			// Indicate that the TCP/IP connection with the POP3 server should be SSL.
			// All POP3 communications are secure using SSL.
			mailman.PopSsl = true;
			// Set the POP3 port to 995, the standard MS Exchange Server SSL POP3 port.
			//mailman.MailPort = 995
			mailman.MailPort = PortNbr;
			int iCnt = -1;
			try
			{
				iCnt = System.Convert.ToInt32(mailman.GetMailboxCount);
			}
			catch (System.Exception ex)
			{
				MessageBox.Show((string) (mailman.LastErrorText + "\r\n" + "\r\n" + ex.Message));
			}
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
			return iCnt;
			
		}
		
		public void ProcessExchangeServers(string UID)
		{
			if (UID == null)
			{
				UID = modGlobals.gCurrUserGuidID;
			}
			if (UID.Length == 0 && modGlobals.gCurrUserGuidID.Length > 0)
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
				frmExchangeMonitor.Default.WindowState = FormWindowState.Minimized;
			}
			else
			{
				frmExchangeMonitor.Default.Show();
			}
			
			LOG.WriteToArchiveLog("ProcessExchangeServers 300");
			
			var S = "SELECT [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL, IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM [ExchangeHostPop] where Userid = \'" + modGlobals.gCurrUserGuidID + "\' order by [HostNameIp] ,[UserLoginID]";
			
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
			var LibraryOwnerUserID = "";
			string tSSL = "";
			string DaysToHold = "";
			
			string ConnStr = "";
			
			List<string> ListOfServers = new List<string>();
			
			LOG.WriteToArchiveLog("ProcessExchangeServers 400");
			SqlDataReader rsData = null;
			LOG.WriteToArchiveLog("ProcessExchangeServers 400.1");
			
			try
			{
				rsData = SqlQryNewConn(S);
				LOG.WriteToArchiveLog("ProcessExchangeServers 400.2: ");
				int LL = 0;
				var ArchiveGuid = System.Guid.NewGuid().ToString();
				LOG.WriteToArchiveLog("ProcessExchangeServers 400.3: ");
				LL = 0;
				if (rsData.HasRows)
				{
					while (rsData.Read())
					{
						//LOG.WriteToArchiveLog("ProcessExchangeServers 600")
						if (modGlobals.gTerminateImmediately == true)
						{
							modGlobals.gExchangeArchiving = false;
							return;
						}
						
						
						//0 [HostNameIp],
						//1 [UserLoginID],
						//2 [LoginPw],
						//3 [PortNbr],
						//4 [DeleteAfterDownload],
						//5 [RetentionCode],
						//6 SSL,
						//7 IMap,
						//8 FolderName,
						//9 LibraryName,
						//10 isPublic
						//11 DaysToHold
						//12 strReject
						//13 ConvertEmlToMSG
						
						try
						{
							DaysToHold = rsData.GetValue(11).ToString();
						}
						catch (System.Exception)
						{
							DaysToHold = false.ToString();
						}
						
						try
						{
							ConvertEmlToMSG = rsData.GetBoolean(13);
						}
						catch (System.Exception)
						{
							ConvertEmlToMSG = false;
						}
						
						try
						{
							LibraryName = rsData.GetValue(9).ToString();
						}
						catch (System.Exception)
						{
							LibraryName = "NA";
						}
						
						try
						{
							isPublic = rsData.GetBoolean(10);
						}
						catch (System.Exception)
						{
							isPublic = false;
						}
						
						try
						{
							DaysToRetain = rsData.GetInt32(11);
						}
						catch (System.Exception)
						{
							DaysToRetain = 1000000;
						}
						try
						{
							strReject = rsData.GetValue(12).ToString();
						}
						catch (System.Exception)
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
						catch (System.Exception)
						{
							HostNameIp = "";
						}
						
						try
						{
							UserLoginID = rsData.GetValue(1).ToString();
						}
						catch (System.Exception)
						{
							UserLoginID = "";
						}
						
						//WDM 03/08/2010If ConvertEmlToMSG = True And RedemptionDllExists = False Then
						//If ConvertEmlToMSG = True And RedemptionDllExists = False Then
						//    log.WriteToArchiveLog("ERROR ERROR - ProcessExchangeMail - It appears the Redemption DLL is missing, this folder '" + HostNameIp  + " :" + LibraryName + " : " + UserLoginID + "' will not be processed.")
						//    GoTo NextBox
						//End If
						
						LoginPw = rsData.GetValue(2).ToString();
						LoginPw = ENC.AES256DecryptString(LoginPw);
						
						try
						{
							PortNbr = rsData.GetValue(3).ToString();
						}
						catch (System.Exception)
						{
							PortNbr = "";
						}
						try
						{
							var tDeleteAfterDownload = rsData.GetValue(4).ToString();
							if (tDeleteAfterDownload.Equals("False"))
							{
								DeleteAfterDownload = false;
							}
							else
							{
								DeleteAfterDownload = true;
							}
						}
						catch (System.Exception)
						{
							DeleteAfterDownload = false;
						}
						try
						{
							RetentionCode = rsData.GetValue(5).ToString();
						}
						catch (System.Exception)
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
						catch (System.Exception)
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
						catch (System.Exception)
						{
							IMap = false;
						}
						
						//If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 500 : " + HostNameIp )
						
						retentionYears = getRetentionPeriod(RetentionCode);
						
						//If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 500.1 : " + retentionYears.ToString)
						if (DeleteAfterDownload == false)
						{
							LeaveOnServer = true;
						}
						else
						{
							LeaveOnServer = false;
						}
						
						LOG.WriteToArchiveLog((string) ("Processing Exchange Box " + HostNameIp + " emails by " + UserLoginID + " : " + DateTime.Now.ToString()));
						
						//0 HostNameIp,
						//1 UserLoginID,
						//2 LoginPw,
						//3 PortNbr,
						//4 DeleteAfterDownload,
						//5 RetentionCode,
						//6 SSL,
						//7 IMap,
						//8 FolderName,
						//9 LibraryName,
						//10 isPublic
						//11 DaysToHold
						//12 strReject
						//13 ConvertEmlToMSG
						string ServerString = "";
						ServerString = ServerString + HostNameIp + Strings.Chr(254); //0
						ServerString = ServerString + UserLoginID + Strings.Chr(254); //1
						ServerString = ServerString + LoginPw + Strings.Chr(254); //2
						ServerString = ServerString + PortNbr + Strings.Chr(254); //3
						ServerString = ServerString + DeleteAfterDownload + Strings.Chr(254); //4
						ServerString = ServerString + RetentionCode + Strings.Chr(254); //5
						ServerString = ServerString + SSL + Strings.Chr(254); //6
						ServerString = ServerString + IMap + Strings.Chr(254); //7
						ServerString = ServerString + FolderName + Strings.Chr(254); //8
						ServerString = ServerString + LibraryName + Strings.Chr(254); //9
						ServerString = ServerString + isPublic + Strings.Chr(254); //10
						ServerString = ServerString + DaysToHold + Strings.Chr(254); //11
						ServerString = ServerString + strReject + Strings.Chr(254); //12
						ServerString = ServerString + ConvertEmlToMSG + Strings.Chr(254); //13
						ServerString = ServerString + retentionYears.ToString() + Strings.Chr(254); //14
						ServerString = ServerString + DaysToRetain.ToString(); //15
						
						ListOfServers.Add(ServerString);
						
NextBox:
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
				LOG.WriteToArchiveLog((string) ("ERROR 641.92.2 ProcessExchangeServers - " + ex.Message));
			}
			finally
			{
				LOG.WriteToArchiveLog("ProcessExchangeServers 3000.1");
				if (rsData != null)
				{
					LOG.WriteToArchiveLog("ProcessExchangeServers 3000.2");
					if (! rsData.IsClosed)
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
			
			//frmReconMain.SB.Text = "Processing Exchange servers: " & ListOfServers.Count
			LOG.WriteToArchiveLog("ProcessExchangeServers 10000");
			
			try
			{
				int I = 0;
				string[] A;
				//************************************************************
				//* Process Each Exchange Server
				//************************************************************
				for (I = 0; I <= ListOfServers.Count - 1; I++)
				{
					LOG.WriteToArchiveLog("ProcessExchangeServers 10001");
					S = ListOfServers(I);
					if (modGlobals.gTerminateImmediately == true)
					{
						modGlobals.gExchangeArchiving = false;
						return;
					}
					
					A = S.Split(Strings.Chr(254).ToString().ToCharArray());
					
					HostNameIp = A[0];
					UserLoginID = A[1];
					LoginPw = A[2];
					PortNbr = A[3];
					DeleteAfterDownload = bool.Parse(A[4]);
					RetentionCode = A[5];
					SSL = bool.Parse(A[6]);
					IMap = bool.Parse(A[7]);
					FolderName = A[8];
					LibraryName = A[9];
					isPublic = bool.Parse(A[10]);
					DaysToHold = A[11];
					strReject = A[12];
					ConvertEmlToMSG = bool.Parse(A[13]);
					retentionYears = int.Parse(A[14]);
					DaysToRetain = int.Parse(A[15]);
					
					if (DeleteAfterDownload == false)
					{
						LeaveOnServer = true;
					}
					else
					{
						LeaveOnServer = false;
					}
					
					//LeaveOnServer, retentionYears, DaysToRetain,
					bool dDebug = false;
					try
					{
						if (SSL == true && IMap == false)
						{
							if (PortNbr.Trim().Length == 0)
							{
								PortNbr = "995";
							}
							if (PortNbr.Equals("-1"))
							{
								PortNbr = "995";
							}
							
							//If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 600 PortNbr : " + PortNbr )
							LOG.WriteToArchiveLog((string) ("Processing Exchange SSL " + HostNameIp + " emails by " + UserLoginID));
							frmMain.Default.tbExchange.Text = "Processing Exchange: " + DateTime.Now.ToString();
							if (dDebug)
							{
								LOG.WriteToArchiveLog("ProcessExchangeServers 1000");
								LOG.WriteToArchiveLog((string) ("HostNameIp: " + HostNameIp));
								LOG.WriteToArchiveLog((string) ("UserLoginID: " + UserLoginID));
								LOG.WriteToArchiveLog((string) ("LoginPw: " + LoginPw));
								LOG.WriteToArchiveLog((string) ("PortNbr: " + PortNbr));
								LOG.WriteToArchiveLog((string) ("LeaveOnServer: " + LeaveOnServer));
								LOG.WriteToArchiveLog((string) ("retentionYears: " + retentionYears));
								LOG.WriteToArchiveLog((string) ("RetentionCode: " + RetentionCode));
								LOG.WriteToArchiveLog((string) ("LibraryName: " + LibraryName));
								LOG.WriteToArchiveLog((string) ("isPublic: " + isPublic));
								LOG.WriteToArchiveLog((string) ("DaysToRetain: " + DaysToRetain));
								LOG.WriteToArchiveLog((string) ("strReject: " + strReject));
								LOG.WriteToArchiveLog((string) ("ConvertEmlToMSG: " + ConvertEmlToMSG));
							}
							
							frmExchangeMonitor.Default.Show();
							ReadEmailUsingSSL(UID, HostNameIp, UserLoginID, LoginPw, int.Parse(PortNbr), LeaveOnServer, retentionYears, RetentionCode, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
							frmMain.Default.tbExchange.Text = "Done";
							frmExchangeMonitor.Default.Close();
						}
						else if (IMap == true && SSL == true)
						{
							if (PortNbr.Trim().Length == 0)
							{
								PortNbr = "993";
							}
							if (PortNbr.Equals("-1"))
							{
								PortNbr = "993";
							}
							//If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 700 PortNbr : " + PortNbr )
							LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP " + HostNameIp + " emails by " + UserLoginID));
							frmMain.Default.tbExchange.Text = "Processing Exchange: " + DateTime.Now.ToString();
							frmExchangeMonitor.Default.Show();
							bool BB;
							BB = this.getImapEmailSSLV3(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG, true);
							if (! BB)
							{
								getImapEmailSSL(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG, true);
							}
							frmExchangeMonitor.Default.Close();
						}
						else if (IMap == true && SSL == false)
						{
							if (PortNbr.Trim().Length == 0)
							{
								PortNbr = "143";
							}
							if (PortNbr.Equals("-1"))
							{
								PortNbr = "143";
							}
							//If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 800 PortNbr : " + PortNbr )
							LOG.WriteToArchiveLog((string) ("INFO: Processing Exchange IMAP/SSL " + HostNameIp + " emails by " + UserLoginID));
							frmMain.Default.SB2.Text = "Processing Exchange: " + DateTime.Now.ToString();
							frmMain.Default.tbExchange.Text = "Processing Exchange: " + DateTime.Now.ToString();
							LOG.WriteToArchiveLog("ProcessExchangeServers 3000.5");
							bool SuccessfulRun = true;
							
							frmExchangeMonitor.Default.Show();
							SuccessfulRun = getIMapEmailV3(UID, HostNameIp, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
							if (! SuccessfulRun)
							{
								getIMapEmail(UID, HostNameIp, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
							}
							LOG.WriteToArchiveLog("ProcessExchangeServers 3001.5");
							frmMain.Default.tbExchange.Text = "..." + DateTime.Now.ToString();
							frmExchangeMonitor.Default.Close();
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
							//If ddebug Then LOG..WriteToArchiveLog("ProcessExchangeServers 900 PortNbr : " + PortNbr )
							LOG.WriteToArchiveLog((string) ("Processing Exchange POP " + HostNameIp + " emails by " + UserLoginID));
							frmMain.Default.tbExchange.Text = "Processing Exchange: " + DateTime.Now.ToString();
							LOG.WriteToArchiveLog("ProcessExchangeServers 4000");
							frmExchangeMonitor.Default.Show();
							ReadEmailFromServer(UID, HostNameIp, PortNbr, UserLoginID, LoginPw, LeaveOnServer, RetentionCode, retentionYears, LibraryName, isPublic, DaysToRetain, strReject, ConvertEmlToMSG);
							frmMain.Default.tbExchange.Text = "..." + DateTime.Now.ToString();
							frmExchangeMonitor.Default.Close();
						}
						LOG.WriteToArchiveLog("ProcessExchangeServers 20000");
					}
					catch (System.Exception ex)
					{
						LOG.WriteToArchiveLog("ProcessExchangeServers 30000");
						LOG.WriteToArchiveLog((string) ("WARNING 641.92.25 ProcessExchangeServers - " + ex.Message));
					}
					LOG.WriteToArchiveLog("ProcessExchangeServers 40000");
				}
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog("ProcessExchangeServers 50000");
				LOG.WriteToArchiveLog((string) ("ERROR 641.92.5 ProcessExchangeServers - " + ex.Message));
			}
			
			LOG.WriteToArchiveLog("ProcessExchangeServers 60000");
			frmMain.Default.SB.Text = "Processing Exchange COMPLETE: " + DateTime.Now.ToString();
			LOG.WriteToArchiveLog((string) ("Exchange Archive completed @ " + DateTime.Now.ToString()));
			frmExchangeMonitor.Default.Close();
			UpdateAttachmentCounts();
			modGlobals.gExchangeArchiving = false;
			
			My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
			My.Settings.Default.Save();
			
		}
		
		public void ApplyPendingEmail(string UID, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode, int DaysToHold)
		{
			
			string MsgFQN = "";
			string DefaultSubject = "";
			string Body = "";
			List<string> AttachedFiles = new List<string>();
			bool bWinMail = false;
			
			int I = 0;
			int J = 0;
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string PendDir = TempDir + "Email\\Attachment\\PendingEmail";
			string EmailDir = TempDir + "Email";
			
			Directory D;
			if (! D.Exists(PendDir))
			{
				D = null;
				return;
			}
			
			Directory storefile;
			string directory;
			string[] files;
			
			bool DeleteFiles = true;
			List<string> FilesToDelete = new List<string>();
			try
			{
				files = storefile.GetFiles(PendDir, "*.MSG");
				int iFiles = 0;
				foreach (string File in files)
				{
					iFiles++;
					//'frmExchangeMonitor.lblMsg.Text = "Applying embedded emails: " + iFiles.ToString + " of " + files.Count.ToString
					//'frmExchangeMonitor.lblMsg.Refresh()
					System.Windows.Forms.Application.DoEvents();
					
					string ParentGuid = "";
					if (File.IndexOf(".") + 1 > 0)
					{
						ParentGuid = File.Substring(0, File.IndexOf(".") + 0);
						if (modGlobals.isGuid(ParentGuid) == false)
						{
							ParentGuid = "";
						}
					}
					
					UTIL.deleteDirectoryFile(AttachmentDir);
					string FQN = File;
					bool bAddedMsg = LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, ref Body, ref AttachedFiles, bWinMail, ParentGuid, ref DaysToHold);
					if (! bAddedMsg)
					{
						LOG.WriteToArchiveLog((string) ("ERROR: ApplyPendingEmail - 500 : Failed to add embedded MSG file: " + "\r\n" + ServerName + "\r\n" + " : " + CurrMailFolder));
					}
					else
					{
						modGlobals.FilesToDelete.Add(FQN);
					}
				}
				//'frmExchangeMonitor.lblMsg.Text = ""
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: ApplyPendingEmail - 100 : " + ex.Message));
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
						iFiles++;
						string FQN = sFile;
						//frmExchangeMonitor.lblMsg.Text = "Cleanup files: " + iFiles.ToString
						//frmExchangeMonitor.lblMsg.Refresh()
						System.Windows.Forms.Application.DoEvents();
						if (F.Exists(FQN))
						{
							F.Delete(FQN);
						}
					}
					F = null;
				}
				
			}
			//frmExchangeMonitor.lblMsg.Text = ""
		}
		
		public void ApplyPendingEmail(string UID, string DirectoryName, string ServerName, string CurrMailFolder, string LibraryName, string RetentionCode, int DaysToHold)
		{
			
			string MsgFQN = "";
			string DefaultSubject = "";
			string Body = "";
			List<string> AttachedFiles = new List<string>();
			bool bWinMail = false;
			
			int I = 0;
			int J = 0;
			string TempDir = System.IO.Path.GetTempPath();
			string AttachmentDir = TempDir + "Email\\Attachment";
			string PendDir = DirectoryName;
			string EmailDir = TempDir + "Email";
			
			Directory D;
			if (! D.Exists(PendDir))
			{
				D = null;
				return;
			}
			
			Directory storefile;
			string directory;
			string[] files;
			string File;
			bool DeleteFiles = true;
			
			try
			{
				files = storefile.GetFiles(PendDir, "*.MSG");
				foreach (string tempLoopVar_File in files)
				{
					File = tempLoopVar_File;
					UTIL.deleteDirectoryFile(AttachmentDir);
					
					string FQN = File;
					
					string ParentGuid = "";
					if (File.IndexOf(".") + 1 > 0)
					{
						ParentGuid = File.Substring(0, File.IndexOf(".") + 0);
						if (modGlobals.isGuid(ParentGuid) == false)
						{
							ParentGuid = "";
						}
					}
					
					LoadMsgFile(UID, FQN, ServerName, CurrMailFolder, LibraryName, RetentionCode, DefaultSubject, ref Body, ref AttachedFiles, bWinMail, ParentGuid, ref DaysToHold);
				}
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: ApplyPendingEmail - 100 : " + ex.Message));
				DeleteFiles = false;
			}
			finally
			{
				if (DeleteFiles == true)
				{
					foreach (string tempLoopVar_File in files)
					{
						File = tempLoopVar_File;
						string FQN = PendDir + "\\" + File;
						
					}
				}
				
			}
			
		}
		
		public bool ApplyEmailBundleV2(string UID, Chilkat.MailMan mailman, string ServerName, string UserLoginID, string PassWord, bool LeaveOnServer, int retentionYears, string RetentionCode, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
		{
			
			bool RC = false;
			int PauseThreadMS = 0;
			SortedList<string, string> L = new SortedList<string, string>();
			Chilkat.EmailBundle bundle;
			
			try
			{
				PauseThreadMS = int.Parse(getUserParm("UserEmail_Pause"));
			}
			catch (System.Exception)
			{
				PauseThreadMS = 0;
			}
			
			//Dim bundle As Chilkat.EmailBundle = Nothing
			Chilkat.Email email = null;
			string CurrMailFolder = ServerName + ":" + UserLoginID;
			int LL = 1;
			
			try
			{
				// Set our POP3 hostname, login and password
				mailman.MailHost = ServerName;
				mailman.PopUsername = UserLoginID;
				mailman.PopPassword = PassWord;
				//mailman.MailPort = 110
				
			}
			catch (System.Exception)
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
					DownLoadSize = int.Parse(val[sDownLoadSize]);
					LL = 6;
				}
				catch (System.Exception)
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
				
				frmExchangeMonitor.Default.lblMessageInfo.Text = "Process Email Bundle V2";
				frmExchangeMonitor.Default.lblMessageInfo.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				if (srv_DetailedLogging)
				{
					LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100 Download Size = " + DownLoadSize.ToString()));
				}
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
				
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + ServerName);
				LL = 24;
				
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
				LL = 25;
				System.Windows.Forms.Application.DoEvents();
				LL = 26;
				
				//Dim I As Integer = 0
				LL = 29;
				int J = 0;
				LL = 30;
				string TempDir = UTIL.getTempProcessingDir() + "\\";
				TempDir = TempDir.Replace("\\\\", "\\");
				if (! Directory.Exists(TempDir))
				{
					Directory.CreateDirectory(TempDir);
				}
				
				string AttachmentDir = TempDir + "\\Email\\Attachment";
				AttachmentDir = AttachmentDir.Replace("\\\\", "\\");
				if (! Directory.Exists(AttachmentDir))
				{
					Directory.CreateDirectory(AttachmentDir);
				}
				
				string EmailDir = TempDir + "\\Email";
				EmailDir = EmailDir.Replace("\\\\", "\\");
				if (! Directory.Exists(EmailDir))
				{
					Directory.CreateDirectory(EmailDir);
				}
				
				if (srv_DetailedLogging)
				{
					LOG.WriteToArchiveLog("ApplyEmailBundleV2 200");
				}
				int iCnt = 0;
				LL = 37;
				try
				{
					iCnt = 1000;
					//iCnt = mailman.GetMailboxCount
				}
				catch (System.Exception)
				{
					LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100as1 : failed to get email count." + DateTime.Now.ToString()));
				}
				//log.WriteToArchiveLog("ApplyEmailBundleV2 100as1.1 : email count = " & iCnt & " : " & Now.ToString)
				
				LL = 41;
				long chunkBeginIdx = 0;
				LL = 42;
				long chunkEndIdx = DownLoadSize;
				LL = 43;
				LL = 44;
				//  First, get the list of UIDLs for all emails in the mailbox.
				LL = 45;
				Chilkat.StringArray sa = new Chilkat.StringArray();
				LL = 46;
				if (sa == null)
				{
					LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100XX : failed to allocate download array: " + DateTime.Now.ToString()));
					goto endOfTry;
				}
				int iCheck = System.Convert.ToInt32(mailman.CheckMail);
				if (iCheck == -1)
				{
					LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100.66 : Appears to be an error in attaching to Exchange server:  " + UserLoginID + " - " + DateTime.Now.ToString() + ", aborting archive - Library: " + LibraryName));
					goto endOfTry;
				}
				
				frmExchangeMonitor.Default.lblMessageInfo.Text = "Fetching group of emails.";
				LL = 82;
				frmExchangeMonitor.Default.lblMessageInfo.Refresh();
				LL = 83;
				System.Windows.Forms.Application.DoEvents();
				LL = 84;
				//****************************************************************************
				sa = mailman.GetUidls();
				//****************************************************************************
				if (dDebug)
				{
					Console.WriteLine(mailman.LastErrorText);
					Console.WriteLine("Total: " + sa.Count.ToString());
				}
				
				LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100as1.1 : email count = " + sa.Count.ToString() + " : " + DateTime.Now.ToString()));
				
				frmExchangeMonitor.Default.lblMessageInfo.Text = (string) ("Processing " + sa.Count.ToString() + " emails from " + UserLoginID);
				frmExchangeMonitor.Default.lblMessageInfo.Refresh();
				LL = 47;
				
				if (sa == null)
				{
					LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100ZZ : No emails found to download: " + DateTime.Now.ToString() + ", aborting archive - Library: " + LibraryName));
					LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 100ZZ.1 : " + mailman.LastErrorText));
					goto endOfTry;
				}
				
				int TotalEmailsToProcess = 0;
				//Dim CurrentlyProcessedEmails As Integer = 0
				int skippedEmails = 0;
				int ProcessedEmails = 1;
				int TotalEmailsProcessed = 0;
				int TotalEmails = System.Convert.ToInt32(sa.Count);
				string uidl = "";
				double lAvailableMemory = 0;
				double PercentAvailableMemory = 0;
				int Warnings = 0;
				
				double MemoryRemaining = 0;
				Microsoft.VisualBasic.Devices.ComputerInfo computer_info = new Microsoft.VisualBasic.Devices.ComputerInfo();
				TotalMemory = computer_info.TotalPhysicalMemory;
				
				
				//LoadExckKeys(L)
				DBLocal.LoadExchangeKeys(L);
				
				DateTime StartTime = DateTime.Now;
				TimeSpan ElapsedTime;
				TimeSpan ElapsedTxTime;
				
				double eAvg = 0;
				double txAvg = 0;
				double eAvgTotal = 0;
				double txAvgTotal = 0;
				
				int ProcessedCnt = 0;
				
				try
				{
					LL = 62;
					for (int iMails = 0; iMails <= TotalEmails - 1; iMails++)
					{
						
						ElapsedTxTime = DateTime.Now.Subtract(StartTime);
						StartTime = DateTime.Now;
						
						uidl = (string) (sa.GetString(iMails));
						
						if (DBLocal.ExchangeExists(uidl))
						{
							goto NEXTBUNDLE;
						}
						
						if (L.IndexOfKey(uidl) >= 0)
						{
							goto NEXTBUNDLE;
						}
						
						ProcessedCnt++;
						
						//**********************************
						email = mailman.FetchEmail(uidl);
						string EntryID = uidl;
						//**********************************
						
						if (frmMain.Default.ckTerminate.Checked)
						{
							frmExchangeMonitor.Default.lblMsg.Text = "Processing HALTED";
							frmExchangeMonitor.Default.lblMsg.Refresh();
							return true;
						}
						if (iMails == TotalEmails - 2)
						{
							Console.WriteLine("Almost done");
						}
						
						DateInterval ETime = null;
						ElapsedTime = DateTime.Now.Subtract(StartTime);
						
						txAvgTotal += ElapsedTxTime.TotalMilliseconds;
						eAvgTotal += ElapsedTime.TotalMilliseconds;
						eAvg = eAvgTotal / ProcessedCnt;
						txAvg = txAvgTotal / ProcessedCnt;
						
						if (iMails % 5 == 0)
						{
							frmExchangeMonitor.Default.lblCnt.Text = (string) ("Processing " + iMails.ToString() + " of " + TotalEmails.ToString());
							frmExchangeMonitor.Default.lblCnt.Refresh();
							lAvailableMemory = UTIL.getUsedMemory();
							//frmExchangeMonitor.lblMsg.Text = "Mem Free: " + lAvailableMemory.ToString + " MB"
							//frmExchangeMonitor.lblMsg.Refresh()
							MemoryRemaining = TotalMemory - lAvailableMemory * 1000000;
							PercentAvailableMemory = lAvailableMemory * 1000000 / TotalMemory;
							PercentAvailableMemory = System.Convert.ToDouble((1 - PercentAvailableMemory) * 100);
							if (PercentAvailableMemory < 20 && PercentAvailableMemory > 0)
							{
								frmExchangeMonitor.Default.lblMsg.BackColor = Drawing.Color.DarkRed;
								frmExchangeMonitor.Default.lblMsg.Text = "Memory watch: " + PercentAvailableMemory.ToString() * 100 + "% free";
								frmExchangeMonitor.Default.lblMsg.Refresh();
								Warnings++;
								if (Warnings > 5)
								{
									Reset();
									DB.CloseConn();
									LOG.WriteToArchiveLog("NOTICE: Restart may be needed to reclaim memory.");
									//System.Windows.Forms.Application.Restart()
									Warnings = 0;
								}
								GC.Collect();
								GC.WaitForPendingFinalizers();
							}
							
							frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + ServerName);
							frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
							frmExchangeMonitor.Default.lblSpeed.Text = ElapsedTime.ToString();
							frmExchangeMonitor.Default.txTime.Text = ElapsedTxTime.ToString();
							
							frmExchangeMonitor.Default.eTimeAvg.Text = eAvg.ToString() + "/ms";
							frmExchangeMonitor.Default.txAvg.Text = txAvg.ToString() + "/ms";
							
							frmExchangeMonitor.Default.Refresh();
							
							
						}
						if (iMails % 100 == 0)
						{
							frmExchangeMonitor.Default.lblMsg.Text = (string) ("Mem Free: " + lAvailableMemory.ToString() + " MB @ " + DateAndTime.TimeOfDay);
							frmExchangeMonitor.Default.lblMsg.Refresh();
							System.Windows.Forms.Application.DoEvents();
							GC.Collect();
							GC.WaitForPendingFinalizers();
						}
						
						
						
						if (PauseThreadMS > 0)
						{
							System.Threading.Thread.Sleep(50);
						}
						
						//LOG.WriteToKeyLog(uidl, True)
						//db.AddExcgKey(uidl)
						
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("TotalEmailsProcessed = " + TotalEmailsProcessed.ToString()));
						}
						
						System.Windows.Forms.Application.DoEvents();
						
						if (email == null)
						{
							goto NEXTBUNDLE;
						}
						
						System.Windows.Forms.Application.DoEvents();
						//  Process the bundle... (processing code)
						//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
						LL = 98;
						string emailKey = "";
						
						string NewGuid = System.Guid.NewGuid().ToString();
						LL = 113;
						
						if (email == null)
						{
							goto NEXTBUNDLE;
						}
						
						LL = 115;
						string Subject = "";
						LL = 116;
						try
						{
							Subject = EMAIL.SUBJECT;
							Subject = LOG.PullOutSingleQuotes(Subject);
						}
						catch (System.Exception)
						{
							Subject = "NA";
						}
						
						LL = 117;
						string EmailFrom = (string) Email.From;
						LL = 118;
						string FromAddress = (string) Email.FromAddress;
						LL = 119;
						string FromName = (string) Email.FromName;
						LL = 120;
						string From = (string) Email.From;
						LL = 121;
						
						LL = 122;
						if (strReject.Trim.Length > 0)
						{
							LL = 123;
							string[] A = strReject.Split(",".ToCharArray());
							LL = 124;
							for (int II = 0; II <= (A.Length - 1); II++)
							{
								LL = 125;
								string S1 = A[II].Trim();
								LL = 126;
								if (S1.Trim().Length > 0)
								{
									LL = 127;
									if (Subject.IndexOf(S1) + 1)
									{
										LL = 128;
										LOG.WriteToArchiveLog((string) ("Notice: email rejected - " + ServerName + " / " + EmailFrom + " / " + Subject + " : Reject = " + strReject));
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
						int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
						LL = 147;
						
						int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
						LL = 148;
						int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
						LL = 149;
						if (NumAttachments > 0 && 0 > 0)
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
						int NumBcc = System.Convert.ToInt32(Email.NumBcc);
						LL = 153;
						int NumCC = System.Convert.ToInt32(Email.NumCC);
						LL = 154;
						int NumTo = System.Convert.ToInt32(Email.NumTo);
						LL = 155;
						string ReplyTo = (string) Email.ReplyTo;
						LL = 156;
						string SignedBy = (string) Email.SignedBy;
						LL = 157;
						int EmailSize = System.Convert.ToInt32(Email.Size);
						LL = 158;
						string ReceivedDate = null;
						ReceivedDate = (string) (Email.LocalDate.ToString());
						LL = 159;
						string GMT = (string) (Email.EmailDate.ToString());
						LL = 160;
						string Header = (string) Email.Header;
						LL = 161;
						string EmailBody = EMAIL.Body;
						EmailBody = LOG.PullOutSingleQuotes(EmailBody);
						LL = 164;
						ArrayList Recipients = new ArrayList();
						LL = 165;
						ArrayList EmailTo = new ArrayList();
						LL = 166;
						ArrayList EmailToAddr = new ArrayList();
						LL = 167;
						ArrayList EmailToName = new ArrayList();
						LL = 168;
						ArrayList Bcc = new ArrayList();
						LL = 169;
						ArrayList BccAddr = new ArrayList();
						LL = 170;
						ArrayList BccName = new ArrayList();
						LL = 171;
						ArrayList CC = new ArrayList();
						LL = 172;
						ArrayList CcAddr = new ArrayList();
						LL = 173;
						ArrayList CcName = new ArrayList();
						LL = 174;
						bool bLoadAttachments = false;
						LL = 175;
						
						LL = 176;
						string EmailDateTimeGMT = GMT;
						LL = 177;
						FixDate(ref EmailDateTimeGMT);
						LL = 178;
						string tSubject = Subject.Substring(0, 100);
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
						catch (System.Exception)
						{
							
						}
						
						//Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
						string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
						bool bEmailExists = DB.ExchangeEmailExists(EmailIdentifier);
						LL = 184;
						if (bEmailExists)
						{
							LL = 185;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 700X already exists: " + iMails.ToString()));
							}
							LL = 186;
							skippedEmails++;
							LL = 187;
							frmExchangeMonitor.Default.lblMessageInfo.Text = (string) ("Updated Emails: " + skippedEmails.ToString());
							LL = 188;
							frmExchangeMonitor.Default.lblMessageInfo.Refresh();
							LL = 189;
							System.Windows.Forms.Application.DoEvents();
							LL = 190;
							int DaysOld = System.Convert.ToInt32(Email.NumDaysOld);
							LL = 191;
							if (DaysOld > DaysToHold)
							{
								LL = 192;
								bool success = System.Convert.ToBoolean(mailman.DeleteEmail(email));
								LL = 193;
								if (! success)
								{
									LL = 194;
									string Msg = "Subject: " + Subject + "\r\n";
									LL = 195;
									Msg += "FromName: " + FromName + "\r\n";
									LL = 196;
									Msg += "FromAddress: " + FromAddress + "\r\n";
									LL = 197;
									LOG.WriteToArchiveLog((string) ("ERROR ApplyEmailBundleV2: Failed to delete email:" + "\r\n" + Msg));
									LL = 198;
								}
								LL = 199;
							}
							LL = 200;
							
							//LOG.WriteToKeyLog(uidl, True)
							DB.AddExcgKey(uidl);
							DBLocal.addExchange(uidl);
							goto NextRec;
							LL = 201;
						}
						
						if (bEmailExists)
						{
							LL = 206;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 700X already exists: " + iMails.ToString()));
							}
							LL = 207;
							skippedEmails++;
							LL = 208;
							frmExchangeMonitor.Default.lblMessageInfo.Text = (string) ("Updated Emails: " + skippedEmails.ToString());
							LL = 209;
							frmExchangeMonitor.Default.lblMessageInfo.Refresh();
							LL = 210;
							System.Windows.Forms.Application.DoEvents();
							LL = 211;
							goto NextRec;
							LL = 212;
						}
						
						bool B = bEmailExists;
						string EmailFQN = EmailDir + "\\" + NewGuid + "~.EML";
						EmailFQN = EmailFQN.Replace("\\\\", "\\");
						if (! Directory.Exists(EmailFQN))
						{
							Directory.CreateDirectory(EmailFQN);
						}
						
						//Dim EmailIdentifier As String = UTIL.genEmailIdentifier(email.Body, email.Size, ReceivedDate, SendEmail, Subject, NumAttachedMessages)
						//Dim EmailHashCode As String = ENC.getSha1HashKey(EmailIdentifier)
						B = ExchangeEmailExists(EmailIdentifier);
						if (B)
						{
							goto NextRec;
						}
						
						if (NumAttachments > 0)
						{
							//** Clean out the directory
							deleteDirectoryFile(AttachmentDir);
							// Save attachments to the "attachments" directory.
							Email.SaveAllAttachments(AttachmentDir);
							bLoadAttachments = true;
						}
						
						if (NumAttachedMessages > 0)
						{
							//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
							for (int II = 0; II <= NumAttachedMessages - 1; II++)
							{
								//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
								Chilkat.Email objEmail = Email.GetAttachedMessage(II);
								ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
								objEmail = null;
							}
						}
						
						LL = 235;
						for (J = 0; J <= NumCC - 1; J++)
						{
							LL = 236;
							CC.Add(EMAIL.getCc[J].ToString());
							LL = 237;
							CcAddr.Add(Email.GetCcAddr(J).ToString());
							LL = 238;
							CcName.Add(Email.GetCcName(J).ToString());
							LL = 239;
							if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
							{
								LL = 240;
								Recipients.Add(Email.GetCcAddr(J).ToString());
								LL = 241;
							}
							LL = 242;
						}
						LL = 243;
						for (J = 0; J <= NumBcc - 1; J++)
						{
							LL = 244;
							Bcc.Add(EMAIL.getBcc[J].ToString());
							LL = 245;
							BccName.Add(Email.GetBccName(J).ToString());
							LL = 246;
							BccAddr.Add(Email.GetBccAddr(J).ToString());
							LL = 247;
							if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
							{
								LL = 248;
								Recipients.Add(Email.GetBccAddr(J).ToString());
								LL = 249;
							}
							LL = 250;
						}
						LL = 251;
						for (J = 0; J <= NumTo - 1; J++)
						{
							LL = 252;
							EmailTo.Add(Email.GetTo(J).ToString());
							LL = 253;
							EmailToAddr.Add(Email.GetToAddr(J).ToString());
							LL = 254;
							EmailToName.Add(Email.GetToName(J).ToString());
							LL = 255;
							if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
							{
								LL = 256;
								Recipients.Add(Email.GetToAddr(J).ToString());
								LL = 257;
							}
							LL = 258;
						}
						LL = 259;
						
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 900.0: " + iMails.ToString()));
						}
						LL = 266;
						bool bFileSaved = System.Convert.ToBoolean(Email.SaveEml(EmailFQN));
						LL = 267;
						
						LL = 268;
						if (bFileSaved)
						{
							LL = 269;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("Notice 101a.1- ApplyEmailBundleV2: - Save Email: " + EmailFQN));
							}
						}
						else
						{
							LL = 270;
							LOG.WriteToArchiveLog((string) ("ERROR: 101a - ApplyEmailBundleV2: - Failed to save Email file: " + EmailFQN));
							LL = 271;
						}
						LL = 281;
						if (bEmlToMSG == true)
						{
							LL = 282;
							EmailFQN = convertEmlToMsg(EmailFQN);
							LL = 283;
							if (EmailFQN.Trim.Length == 0)
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
						{
							LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 900.1: " + iMails.ToString()));
						}
						LL = 294;
						List<string> AttachedFiles = new List<string>();
						LL = 295;
						
						getDirectoryFiles(AttachmentDir, AttachedFiles);
						
						LL = 297;
						string DB_ID = "ECM.Library";
						LL = 298;
						string Server_UserID_StoreID = CurrMailFolder;
						LL = 299;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 900.2: " + iMails.ToString()));
						}
						LL = 303;
						bool AttachmentsLoaded = false;
						LL = 304;
						ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, DateTime.Parse(ReceivedDate), UserLoginID, DateTime.Now, DateTime.Parse(ReceivedDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, (string) Email.Uidl, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
						
						LL = 322;
						
						if (NumAttachments > 0)
						{
							frmExchangeMonitor.Default.lblMessageInfo.Visible = true;
							frmExchangeMonitor.Default.lblMessageInfo.Text = "Processing " + NumAttachments.ToString() + " attachments.";
							frmExchangeMonitor.Default.lblMessageInfo.Refresh();
							System.Windows.Forms.Application.DoEvents();
							LL = 218;
							string dirPath = System.IO.Path.GetTempPath();
							dirPath = dirPath + "TempZip";
							DB.DeleteDirectory(dirPath);
							DB.CreateDir(dirPath);
							
							//** Clean out the directory
							deleteDirectoryFile(AttachmentDir);
							Email.SaveAllAttachments(AttachmentDir);
							bLoadAttachments = true;
							LoadEmailAttachments(AttachmentDir, NewGuid);
							LL = 223;
							frmExchangeMonitor.Default.lblMessageInfo.Visible = false;
						}
						
						PurgeDirectory(AttachmentDir);
						
						EmailsAdded++;
						LL = 323;
						frmExchangeMonitor.Default.lblMsg.Text = (string) ("Emails Added: " + EmailsAdded.ToString());
						LL = 324;
						frmExchangeMonitor.Default.lblMsg.Refresh();
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
									DB.AppendOcrTextEmail(NewGuid);
									LL = 334;
									AttachmentsLoaded = false;
									LL = 335;
								}
								LL = 336;
							}
							LL = 337;
						}
						LL = 338;
						//LOG.WriteToKeyLog(uidl, True)
						DB.AddExcgKey(uidl);
						DBLocal.addExchange(uidl);
NextRec:
						LL = 342;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyEmailBundleV2 1000: " + iMails.ToString()));
						}
						LL = 343;
						
						TimeSpan tsTimeSpan;
						LL = 345;
						int iNumberOfDays;
						LL = 346;
						string strMsgText = "";
						LL = 347;
						//tsTimeSpan = Now.Subtract(CDate(ReceivedDate)
						if (Email.LocalDate == null)
						{
							LL = (int) 347.1;
							ReceivedDate = DateTime.Now;
							LL = (int) 347.2;
						}
						else if (Email.LocalDate.ToString().Length == 0)
						{
							LL = (int) 347.3;
							ReceivedDate = DateTime.Now;
							LL = (int) 347.4;
						}
						else
						{
							LL = (int) 347.5;
							ReceivedDate = (string) Email.LocalDate;
							LL = (int) 347.6;
						}
						tsTimeSpan = DateTime.Now.Subtract(ReceivedDate); //** This represents the received date
						LL = 348;
						iNumberOfDays = tsTimeSpan.Days;
						LL = 349;
						
						//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
NEXTBUNDLE:
						LL = 376;
						if (email != null)
						{
							Email.Dispose();
						}
						ProcessedEmails++;
						
						GC.Collect();
						GC.WaitForPendingFinalizers();
					}
ENDITALL:
					LL = 383;
				}
				catch (System.Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR 100 ApplyEmailBundleV2: LL = " + LL.ToString() + ", EX: " + ex.Message));
					LOG.WriteToArchiveLog((string) ("FATAL ERROR: ApplyEmailBundleV2 - 10b: " + mailman.LastErrorText));
				}
				finally
				{
					LOG.WriteToArchiveLog((string) ("NOTICE 500 ApplyEmailBundleV2: last line to execute LL = " + LL.ToString()));
					LL = 385;
					sa.Dispose();
					sa = null;
					//bundle.Dispose()
					if (email != null)
					{
						Email.Dispose();
					}
					GC.Collect();
					GC.WaitForPendingFinalizers();
					
				}
				
				frmExchangeMonitor.Default.lblCnt.Text = "Emails Processed: ";
				frmExchangeMonitor.Default.lblCnt.Refresh();
				
				frmExchangeMonitor.Default.lblMessageInfo.Text = "";
				frmExchangeMonitor.Default.lblMsg.Text = "";
				frmExchangeMonitor.Default.lblServer.Text = "";
				frmExchangeMonitor.Default.Refresh();
				RC = true;
				
				
				DB.UpdateAttachmentCounts();
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 200 ApplyEmailBundleV2: LL = " + LL.ToString() + ", EX: " + ex.Message));
				RC = false;
			}
endOfTry:
			
			mailman.Pop3EndSession();
			
			ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
			
			frmExchangeMonitor.Default.lblCnt.Text = "Emails Processed: ";
			frmExchangeMonitor.Default.lblCnt.Refresh();
			return RC;
			
		}
		
		public void deleteDirectoryFile(string DirFQN)
		{
			string FileName;
			try
			{
				foreach (string tempLoopVar_FileName in System.IO.Directory.GetFiles(DirFQN))
				{
					FileName = tempLoopVar_FileName;
					try
					{
						System.IO.File.Delete(FileName);
					}
					catch (System.Exception)
					{
						LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file \'" + FileName + "\'.");
					}
				}
			}
			catch (System.Exception)
			{
				LOG.WriteToArchiveLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir \'" + DirFQN + "\'.");
			}
		}
		
		public void ArchiveEmbeddedEmailMessageV2(string UID, Chilkat.Email EM, string LibraryName, string EmailBoxName, string RetentionCode, bool isPublic, bool bEmlToMSG, string ServerName, string ParentGuid, int DaysToHold, string EmailIdentifier, string EntryID)
		{
			
			int LL = 0;
			
			int PauseThreadMS = 0;
			try
			{
				PauseThreadMS = int.Parse(getUserParm("UserEmail_Pause"));
			}
			catch (System.Exception)
			{
				PauseThreadMS = 0;
			}
			
			try
			{
				string TempDir = System.IO.Path.GetTempPath();
				LL = 1;
				LL = 1;
				string AttachmentDir = TempDir + "Email\\Attachment";
				LL = 2;
				string EmailDir = TempDir + "Email";
				LL = 3;
				List<string> AttachedFiles = new List<string>();
				LL = 4;
				string Body = (string) EM.Body;
				LL = 6;
				string BounceAddress = (string) EM.BounceAddress;
				LL = 7;
				string Charset = (string) EM.Charset;
				LL = 8;
				bool Decrypted = System.Convert.ToBoolean(EM.Decrypted);
				LL = 9;
				DateTime EmailDate = EM.EmailDate;
				LL = 10;
				string EncryptedBy = (string) EM.EncryptedBy;
				LL = 11;
				string FileDistList = (string) EM.FileDistList;
				LL = 12;
				string From = (string) EM.From;
				LL = 13;
				string FromAddress = (string) EM.FromAddress;
				LL = 14;
				string FromName = (string) EM.FromName;
				LL = 15;
				string Header = (string) EM.Header;
				LL = 16;
				string Language = (string) EM.Language;
				LL = 17;
				string LastErrorHtml = (string) EM.LastErrorHtml;
				LL = 18;
				string LastErrorText = (string) EM.LastErrorText;
				LL = 19;
				string LastErrorXml = (string) EM.LastErrorXml;
				LL = 20;
				DateTime LocalDate = EM.LocalDate;
				LL = 21;
				string Mailer = (string) EM.Mailer;
				LL = 22;
				int NumAlternatives = System.Convert.ToInt32(EM.NumAlternatives);
				LL = 23;
				int NumAttachedMessages = System.Convert.ToInt32(EM.NumAttachedMessages);
				LL = 24;
				int NumAttachments = System.Convert.ToInt32(EM.NumAttachments);
				LL = 25;
				int NumBcc = System.Convert.ToInt32(EM.NumBcc);
				LL = 26;
				int NumCC = System.Convert.ToInt32(EM.NumCC);
				LL = 27;
				int NumDaysOld = System.Convert.ToInt32(EM.NumDaysOld);
				LL = 28;
				int NumHeaderFields = System.Convert.ToInt32(EM.NumHeaderFields);
				LL = 29;
				int NumRelatedItems = System.Convert.ToInt32(EM.NumRelatedItems);
				LL = 30;
				int NumReplacePatterns = System.Convert.ToInt32(EM.NumReplacePatterns);
				LL = 31;
				int NumTo = System.Convert.ToInt32(EM.NumTo);
				LL = 32;
				bool OverwriteExisting = System.Convert.ToBoolean(EM.OverwriteExisting);
				LL = 33;
				string PreferredCharset = (string) EM.PreferredCharset;
				LL = 34;
				bool ReceivedEncrypted = System.Convert.ToBoolean(EM.ReceivedEncrypted);
				LL = 35;
				bool ReceivedSigned = System.Convert.ToBoolean(EM.ReceivedSigned);
				LL = 36;
				string ReplyTo = (string) EM.ReplyTo;
				LL = 37;
				bool ReturnReceipt = System.Convert.ToBoolean(EM.ReturnReceipt);
				LL = 38;
				bool SendEncrypted = System.Convert.ToBoolean(EM.SendEncrypted);
				LL = 39;
				bool SendSigned = System.Convert.ToBoolean(EM.SendSigned);
				LL = 40;
				bool SignaturesValid = System.Convert.ToBoolean(EM.SignaturesValid);
				LL = 41;
				string SignedBy = (string) EM.SignedBy;
				LL = 42;
				int Size = System.Convert.ToInt32(EM.Size);
				LL = 43;
				string Subject = (string) EM.Subject;
				LL = 44;
				Subject = LOG.PullOutSingleQuotes(Subject);
				LL = 45;
				string Uidl = (string) EM.Uidl;
				LL = 46;
				bool VerboseLogging = System.Convert.ToBoolean(EM.VerboseLogging);
				LL = 47;
				string tGMT = EmailDate.ToString();
				LL = 49;
				FixDate(ref tGMT);
				LL = 50;
				string tSubject = Subject.Substring(0, 100);
				LL = 51;
				RemoveBadChars(ref tSubject);
				LL = 52;
				
				LL = 53;
				if (NumAttachedMessages > 0)
				{
					LL = 54;
					for (int II = 0; II <= NumAttachedMessages - 1; II++)
					{
						LL = 55;
						ArchiveEmbeddedEmailMessage(UID, EM, LibraryName, EmailBoxName, RetentionCode, isPublic, bEmlToMSG, ServerName, ParentGuid, DaysToHold, EmailIdentifier, EntryID);
						LL = 56;
					}
					LL = 57;
				}
				LL = 58;
				
				LL = 59;
				
				//Dim EmailIdentifier As String = LOG.genEmailIdentifier(Size.ToString, tGMT, FromAddress.Trim, Subject, gCurrUserGuidID)
				string ToAddr = ParentGuid;
				//Dim EmailIdentifier as string = MailServerAddr  + "." + EmailSize.ToString + "~" + tEmailDate + "~" + FromAddress.Trim + "~" + tSubject  + gCurrUserGuidID :LL =  61
				RemoveBlanks(ref EmailIdentifier);
				LL = 62;
				
				LL = 63;
				//** Not needed here - embedded email :LL =  64
				//Dim bEmailExists As Boolean = DB.ExchangeEmailExists(EmailIdentifier, EmailHashCode) :LL =  65
				//If bEmailExists Then :LL =  66
				//    GoTo SKIPTOHERE :LL =  67
				//End If :LL =  68
				
				LL = 69;
				deleteDirectoryFile(AttachmentDir);
				LL = 70;
				if (NumAttachments > 0)
				{
					LL = 71;
					//** Clean out the directory :LL =  72
					EM.SaveAllAttachments(AttachmentDir);
					LL = 73;
					getDirectoryFiles(AttachmentDir, AttachedFiles);
					LL = 74;
					//            bLoadAttachments = True :LL =  75
				}
				LL = 76;
				
				LL = 77;
				string NewGuid = Guid.NewGuid().ToString();
				LL = 78;
				ArrayList CcAddr = new ArrayList();
				LL = 79;
				ArrayList BccAddr = new ArrayList();
				LL = 80;
				ArrayList EmailToAddr = new ArrayList();
				LL = 81;
				ArrayList Recipients = new ArrayList();
				LL = 82;
				DateTime ReceivedTime = DateTime.Now;
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
				string EmailFQN = EmailDir + "\\Email.Embedded~" + (NewGuid + "~.EML");
				LL = 89;
				
				LL = 90;
				int EmailSize = Size;
				LL = 91;
				
				LL = 92;
				int retentionYears = DB.getRetentionPeriod(RetentionCode);
				LL = 93;
				bool BB = System.Convert.ToBoolean(EM.SaveEml(EmailFQN));
				LL = 94;
				if (BB == false)
				{
					LL = 95;
					LOG.WriteToArchiveLog((string) ("ERROR: 001a ArchiveEmbeddedEmailMessage - failed to save EML File." + "\r\n" + EmailFQN));
					LL = 96;
					return;
//					LL = 97;
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
						if (EmailFQN.Trim.Length == 0)
						{
							LL = 102;
							LOG.WriteToArchiveLog("FATAL ERROR: 100 ArchiveEmbeddedEmailMessage - failed to convert EML to MSG File.");
							LL = 103;
							LOG.WriteToArchiveLog("NOTE:        100 ArchiveEmbeddedEmailMessage:  Most likely the Redemption DLL is not installed properly");
							LL = 104;
							return;
//							LL = 105;
						}
						LL = 106;
						//log.WriteToArchiveLog("Notice from ApplyEmailBundle 300 : FQN '" + EmailFQN  + "'") :LL =  107
					}
				}
				
				bool AttachmentsLoaded = false;
				
				LL = 110;
				ArchiveExchangeEmails(UID, NewGuid, Body, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, ServerName, FromAddress, FromName, ReceivedTime, UserLoginID, DateTime.Now, ReceivedTime, DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID,
				EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
				LL = 138;
				if (PauseThreadMS > 0)
				{
					System.Threading.Thread.Sleep(PauseThreadMS);
				}
				LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#4");
				if (AttachmentsLoaded == true)
				{
					bool DoThis = false;
					if (DoThis)
					{
						if (AttachmentsLoaded == true)
						{
							DB.AppendOcrTextEmail(NewGuid);
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
					string tMsg = (string) (" " + Strings.Chr(254) + Body + Strings.Chr(254) + Subject + Strings.Chr(254) + FromName + Strings.Chr(254) + FromAddress);
					LL = 144;
					DB.concatEmailBody(tMsg, ParentGuid);
					LL = 145;
				}
				LL = 146;
				
				LL = 147;
				ApplyPendingEmail(UID, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
				LL = 148;
				string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + "\\WMCONVERT";
				LL = 149;
				
				ApplyPendingEmail(ConversionDir, ServerName, CurrMailFolder, LibraryName, RetentionCode, DaysToHold);
				
				LL = 150;
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: ArchiveEmbeddedEmailMessage 100 - LL = " + LL.ToString() + " : " + ex.Message));
			}
			
			LOG.WriteToArchiveLog("NOTE: ArchiveEmbeddedEmailMessage S#5");
			
SKIPTOHERE:
			1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			
		}
		
		public void RemoveBlanks(ref string tStr)
		{
			string S = tStr;
			string NewStr = "";
			int BlankCnt = 0;
			string CH = "";
			for (int i = 1; i <= S.Length; i++)
			{
				CH = S.Substring(i - 1, 1);
				if (CH.Equals(" "))
				{
					BlankCnt++;
				}
				else if (CH.Equals('\t'))
				{
					BlankCnt++;
				}
				else if (CH.Equals('\u0022'))
				{
					BlankCnt++;
				}
				else if (CH.Equals("\r\n"))
				{
					BlankCnt++;
				}
				else if (CH.Equals(Constants.vbCr))
				{
					BlankCnt++;
				}
				else if (CH.Equals(Constants.vbLf))
				{
					BlankCnt++;
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
			Chilkat.Imap imap = new Chilkat.Imap();
			int RecjectCount = 1;
			int EmailsProcessedThisRun = 0;
			LL = 1;
			int DownLoadSize = 0;
			string sDownLoadSize = "";
			int Increment = 0;
			long I = 0;
			imap.ReadTimeout = 360;
			
			
			LL = 2;
			try
			{
				LL = 3;
				string ServerName = MailServerAddr + ":" + UserLoginID;
				LL = 4;
				
				LL = 5;
				string TempDir = System.IO.Path.GetTempPath();
				LL = 6;
				string AttachmentDir = TempDir + "Email\\Attachment";
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
				Success = System.Convert.ToBoolean(imap.Connect(MailServerAddr));
				if (! Success)
				{
					return false;
//					MessageBox.Show((string) imap.LastErrorText);
				}
				LL = 17;
				Success = System.Convert.ToBoolean(imap.Login(UserLoginID, LoginPassWord));
				if (! Success)
				{
					MessageBox.Show((string) imap.LastErrorText);
					return false;
				}
				LL = 18;
				if (! Success)
				{
					LL = 19;
					frmExchangeMonitor.Default.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
					LOG.WriteToArchiveLog("FATAL ERROR: IMAP 300.1 Failed to log on to " + MailServerAddr + ", aborting.");
					LL = 20;
					return false;
				}
				else
				{
					frmExchangeMonitor.Default.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
					LL = 21;
				}
				LL = 22;
				
				// Get the names of all the mailboxes.
				Chilkat.Mailboxes mboxes;
				mboxes = imap.ListMailboxes("", "*");
				
				for (int iii = 0; iii <= mboxes.Count - 1; iii++)
				{
					Console.WriteLine(mboxes.GetName(iii));
					string mName = (string) (mboxes.GetName(iii));
					frmExchangeMonitor.Default.lblMsg.Text = (string) ("Mailbox: " + mboxes.GetName(iii));
					frmExchangeMonitor.Default.lblMsg.Refresh();
				}
				
				bool BB = System.Convert.ToBoolean(imap.SelectMailbox("Inbox"));
				if (! BB)
				{
					return false;
				}
				
				LL = 23;
				
				int J = 0;
				Chilkat.MessageSet msgSet;
				LL = 30;
				msgSet = imap.Search("ALL", 1);
				LL = 76;
				
				LL = 81;
				// Loop over the bundle and display the From and Subject.
				LL = 82;
				try
				{
					LL = 85;
					sDownLoadSize = System.Configuration.ConfigurationManager.AppSettings["EmailDownLoadSize"];
					LL = 86;
					DownLoadSize = int.Parse(val[sDownLoadSize]);
					LL = 87;
				}
				catch (System.Exception)
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
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + MailServerAddr);
				LL = 97;
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
				LL = 98;
				frmExchangeMonitor.Default.lblServer.Refresh();
				LL = 99;
				frmExchangeMonitor.Default.lblServer.Refresh();
				LL = 100;
				System.Windows.Forms.Application.DoEvents();
				LL = 101;
				
				LL = 102;
				
				LL = 103;
				Chilkat.EmailBundle bundle;
				LL = 104;
				long startSeqNum;
				LL = 105;
				startSeqNum = 1;
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
				//Dim messageSet As Chilkat.MessageSet
				LL = 112;
				int NbrOfTries = 1;
				LL = 113;
REDO:
				LL = 114;
				
				if (NbrOfTries >= 3)
				{
					LL = 115;
					RC = false;
					goto ENDIT;
					LL = 116;
				}
				
				LL = 118;
				bundle = imap.FetchSequence(startSeqNum, numToFetch);
				LL = 122;
				int NumberOfMessagesInBox = System.Convert.ToInt32(bundle.MessageCount);
				while (NumberOfMessagesInBox > 0)
				{
					NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
					LL = 127;
					
					LL = 128;
					if (bundle == null)
					{
						LL = 129;
						LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmail 401a: " + imap.LastErrorText));
						LL = 130;
						LOG.WriteToArchiveLog((string) ("        getImapEmail 401b: startSeqNum - " + startSeqNum.ToString()));
						LL = 131;
						LOG.WriteToArchiveLog((string) ("        getImapEmail 401c: numToFetch - " + numToFetch.ToString()));
						LL = 132;
						LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmail 401d: messages in mailbox: " + NumberOfMessagesInBox.ToString()));
						LL = 133;
						NbrOfTries++;
						LL = 134;
						goto REDO;
						LL = 135;
					}
					LL = 136;
					
					LL = 137;
					if (NumberOfMessagesInBox > 0)
					{
						LL = 138;
						LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmail 401.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
						LL = 139;
					}
					else
					{
						LL = 140;
						LOG.WriteToArchiveLog((string) ("NOTICE: No messages getImapEmail 401.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
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
					LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP no SSL #emails = " + NumberOfMessagesInBox.ToString()));
					LL = 168;
					int RejectedCount = 0;
					LL = 169;
					//  Loop over the bundle and display the FROM and SUBJECT of each.
					LL = 170;
					
					LL = 171;
					frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + MailServerAddr);
					LL = 172;
					frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
					LL = 173;
					frmExchangeMonitor.Default.lblServer.Refresh();
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
					LOG.WriteToArchiveLog((string) ("INFO - messages to process #" + NumberOfMessagesInBox.ToString() + " in " + MailServerAddr));
					LL = 185;
					//*******************************************************************************
					bool ExitNow = false;
					while (MessagesRemainingToProcess > 0)
					{
						LL = 188;
						if (numToFetch > NumberOfMessagesInBox)
						{
							ExitNow = true;
						}
						for (I = 0; I <= bundle.MessageCount - 1; I++)
						{
							
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("INFO: bundle #" + LoopCnt.ToString() + ", Email#" + I.ToString()));
							}
							LL = 190;
							TotalEmailsInArchive++;
							LL = 191;
							EmailsProcessedThisRun++;
							LL = 192;
							MessagesRemainingToProcess--;
							LL = 193;
							frmExchangeMonitor.Default.lblCnt.Text = (string) ("Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + NumberOfMessagesInBox.ToString());
							LL = 194;
							frmExchangeMonitor.Default.lblCnt.Refresh();
							LL = 196;
							System.Windows.Forms.Application.DoEvents();
							LL = 198;
							string NewGuid = System.Guid.NewGuid().ToString();
							LL = 199;
							
							LL = 200;
							Chilkat.Email email;
							LL = 201;
							email = bundle.GetEmail(I);
							LL = 202;
							string EntryID = (string) Email.Uidl;
							LL = 203;
							string Subject = EMAIL.SUBJECT;
							Subject = LOG.PullOutSingleQuotes(Subject);
							LL = 204;
							string EmailFrom = (string) Email.From;
							LL = 205;
							string FromAddress = (string) Email.FromAddress;
							LL = 206;
							string FromName = (string) Email.FromName;
							LL = 207;
							string From = (string) Email.From;
							LL = 208;
							
							LL = 209;
							if (strReject.Trim.Length > 0)
							{
								LL = 210;
								string[] A = strReject.Split(",".ToCharArray());
								LL = 211;
								for (int II = 0; II <= (A.Length - 1); II++)
								{
									LL = 212;
									string S1 = A[II].Trim();
									LL = 213;
									if (S1.Trim().Length > 0)
									{
										LL = 214;
										if (Subject.IndexOf(S1) + 1)
										{
											LL = 215;
											//LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
											LL = 216;
											RejectedCount++;
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
							int NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
							LL = 224;
							if (NbrDaysOld >= DaysToHold)
							{
								LL = 225;
								Success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
								LL = 226;
								if (Success != true)
								{
									LL = 227;
									string Msg = "Subject: " + Subject + "\r\n";
									LL = 228;
									Msg += "FromName: " + FromName + "\r\n";
									LL = 229;
									Msg += "FromAddress: " + FromAddress + "\r\n";
									LL = 230;
									LOG.WriteToArchiveLog((string) ("ERROR: getIMapEmail: Failed to delete email from server:" + "\r\n" + Msg));
									LL = 231;
								}
								LL = 232;
							}
							LL = 233;
							
							LL = 234;
							int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
							LL = 235;
							int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
							LL = 236;
							int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
							LL = 237;
							int NumBcc = System.Convert.ToInt32(Email.NumBcc);
							LL = 238;
							int NumCC = System.Convert.ToInt32(Email.NumCC);
							LL = 239;
							int NumTo = System.Convert.ToInt32(Email.NumTo);
							LL = 240;
							string ReplyTo = (string) Email.ReplyTo;
							LL = 241;
							string SignedBy = (string) Email.SignedBy;
							LL = 242;
							int EmailSize = System.Convert.ToInt32(Email.Size);
							LL = 243;
							string LocalDate = (string) (Email.LocalDate.ToString());
							LL = 244;
							string EmailDate = (string) (Email.EmailDate.ToString());
							LL = 245;
							string Header = (string) Email.Header;
							LL = 246;
							string EmailBody = EMAIL.Body;
							LL = 247;
							EmailBody = LOG.PullOutSingleQuotes(EmailBody);
							LL = 248;
							
							LL = 249;
							ArrayList Recipients = new ArrayList();
							LL = 250;
							ArrayList EmailTo = new ArrayList();
							LL = 251;
							ArrayList EmailToAddr = new ArrayList();
							LL = 252;
							ArrayList EmailToName = new ArrayList();
							LL = 253;
							ArrayList Bcc = new ArrayList();
							LL = 254;
							ArrayList BccAddr = new ArrayList();
							LL = 255;
							ArrayList BccName = new ArrayList();
							LL = 256;
							ArrayList CC = new ArrayList();
							LL = 257;
							ArrayList CcAddr = new ArrayList();
							LL = 258;
							ArrayList CcName = new ArrayList();
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
							string tSubject = Subject.Substring(0, 100);
							LL = 266;
							RemoveBadChars(ref tSubject);
							LL = 267;
							
							//Dim EmailIdentifier As String = EmailSize.ToString + "~" + tEmailDate.ToString + "~" + FromAddress.Trim + "~" + tSubject  + "~" + EmailToAddr.ToString + "~" + UID
							string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.From, Subject);
							string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
							
							bool bEmailExists = DB.ExchangeEmailExists(EmailIdentifier);
							LL = 272;
							if (bEmailExists)
							{
								LL = 276;
								System.Windows.Forms.Application.DoEvents();
								LL = 277;
								int DaysOld = System.Convert.ToInt32(Email.NumDaysOld);
								LL = 278;
								if (DaysOld < 0)
								{
									DaysOld = 1;
								}
								if (DaysOld > DaysToHold)
								{
									LL = 279;
									Success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
									LL = 280;
									if (Success != true)
									{
										LL = 281;
										string Msg = "Subject: " + Subject + "\r\n";
										LL = 282;
										Msg += "FromName: " + FromName + "\r\n";
										LL = 283;
										Msg += "FromAddress: " + FromAddress + "\r\n";
										LL = 284;
										LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
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
							{
								LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 700: " + I.ToString()));
							}
							LL = 291;
							bool B = DB.ExchangeEmailExists(EmailIdentifier);
							LL = 292;
							if (B)
							{
								LL = 293;
								if (srv_DetailedLogging)
								{
									LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 700X already exists: " + I.ToString()));
								}
								LL = 294;
								goto NextRec;
								LL = 295;
							}
							LL = 296;
							
							LL = 297;
							string EmailFQN = EmailDir + "\\Email~" + (NewGuid + "~.EML");
							LL = 298;
							
							LL = 299;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("ApplyEmailBundle 800.4a: " + I.ToString()));
							}
							LL = 300;
							if (NumAttachments > 0)
							{
								LL = 301;
								//** Clean out the directory
								LL = 302;
								deleteDirectoryFile(AttachmentDir);
								LL = 303;
								// Save attachments to the "attachments" directory.
								LL = 304;
								Email.SaveAllAttachments(AttachmentDir);
								LL = 305;
								bLoadAttachments = true;
								LL = 306;
							}
							LL = 307;
							
							LL = 308;
							if (NumAttachedMessages > 0)
							{
								LL = 309;
								//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
								LL = 310;
								for (int II = 0; II <= NumAttachedMessages - 1; II++)
								{
									LL = 311;
									//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
									LL = 312;
									Chilkat.Email objEmail = Email.GetAttachedMessage(II);
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
							for (J = 0; J <= NumCC - 1; J++)
							{
								LL = 319;
								CC.Add(EMAIL.getCc[J].ToString());
								LL = 320;
								CcAddr.Add(Email.GetCcAddr(J).ToString());
								LL = 321;
								CcName.Add(Email.GetCcName(J).ToString());
								LL = 322;
								if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
								{
									LL = 323;
									Recipients.Add(Email.GetCcAddr(J).ToString());
									LL = 324;
								}
								LL = 325;
							}
							LL = 326;
							for (J = 0; J <= NumBcc - 1; J++)
							{
								LL = 327;
								Bcc.Add(EMAIL.getBcc[J].ToString());
								LL = 328;
								BccName.Add(Email.GetBccName(J).ToString());
								LL = 329;
								BccAddr.Add(Email.GetBccAddr(J).ToString());
								LL = 330;
								if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
								{
									LL = 331;
									Recipients.Add(Email.GetBccAddr(J).ToString());
									LL = 332;
								}
								LL = 333;
							}
							LL = 334;
							for (J = 0; J <= NumTo - 1; J++)
							{
								LL = 335;
								EmailTo.Add(Email.GetTo(J).ToString());
								LL = 336;
								EmailToAddr.Add(Email.GetToAddr(J).ToString());
								LL = 337;
								EmailToName.Add(Email.GetToName(J).ToString());
								LL = 338;
								if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
								{
									LL = 339;
									Recipients.Add(Email.GetToAddr(J).ToString());
									LL = 340;
								}
								LL = 341;
							}
							LL = 342;
							
							Email.SaveEml(EmailFQN);
							LL = 358;
							if (bEmlToMSG == true)
							{
								LL = 359;
								LOG.WriteToArchiveLog("Notice from getImapEmail 300 : FQN \'" + EmailFQN + "\'");
								LL = 360;
								EmailFQN = convertEmlToMsg(EmailFQN);
								LL = 361;
							}
							LL = 362;
							List<string> AttachedFiles = new List<string>();
							LL = 367;
							getDirectoryFiles(AttachmentDir, AttachedFiles);
							LL = 369;
							string DB_ID = "ECM.Library";
							LL = 370;
							string Server_UserID_StoreID = CurrMailFolder;
							LL = 371;
							
							LL = 372;
							//** Now, Load the EMAIL and its metadata into the repository
							LL = 373;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.2: " + I.ToString()));
							}
							LL = 374;
							
							LL = 375;
							bool AttachmentsLoaded = false;
							LL = 376;
							
							LL = 377;
							ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, DateTime.Parse(EmailDate), UserLoginID, DateTime.Parse(LocalDate), DateTime.Parse(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
							
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
										DB.AppendOcrTextEmail(NewGuid);
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
							LL = 410;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 1000: " + I.ToString()));
							}
							LL = 411;
							
							LL = 412;
						}
						LL = 413;
						
						LL = 414;
						//*****************************************************************************
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
							//Increment = MessagesRemainingToProcess
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
						LoopCnt++;
						LL = 433;
						if (numToFetch > 0)
						{
							LL = 434;
							LOG.WriteToArchiveLog((string) ("INFO - downloading bundle #" + LoopCnt.ToString() + " from " + MailServerAddr));
							LL = 435;
							try
							{
								LL = 436;
								bundle = imap.FetchSequence(startSeqNum, numToFetch);
								LL = 443;
								LOG.WriteToArchiveLog("INFO - getIMapEmail successfully getched + " + numToFetch.ToString() + " messages.");
								LL = 445;
							}
							catch (System.Exception ex)
							{
								LOG.WriteToArchiveLog((string) ("ERROR: imap.FetchSequence - " + ex.Message));
								LL = 447;
							}
							LL = 448;
							System.Windows.Forms.Application.DoEvents();
							LL = 455;
							if (bundle == null)
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
					
					startSeqNum = startSeqNum + numToFetch + 1;
					bundle = imap.FetchSequence(startSeqNum, numToFetch);
					LL = 122;
					NumberOfMessagesInBox = System.Convert.ToInt32(bundle.MessageCount);
					
				}
				//***************************************************************
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 2699 getIMapEmail - LL = " + LL.ToString() + " : " + ex.Message));
				RC = false;
			}
			finally
			{
				// Disconnect from the IMAP server.
				// This example removes the deleted email on the IMAP server.
				LL = 465;
				imap.Expunge();
				LL = 466;
				imap.Disconnect();
				LL = 467;
			}
			LL = 468;
			
			
ENDIT:
			// Save the email to an XML file
			//bundle.SaveXml("bundle.xml")
			
			LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString()));
			LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle PROCESSED Message Count = " + TotalEmailsInArchive.ToString()));
			LOG.WriteToArchiveLog((string) ("INFO: Emails processed this run  = " + EmailsProcessedThisRun.ToString() + " from " + MailServerAddr));
			
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Emails Processed: ";
			frmExchangeMonitor.Default.lblMessageInfo.Refresh();
			System.Windows.Forms.Application.DoEvents();
			return RC;
		}
		
		public bool getImapEmailSSLV2(string UID, string MailServerAddr, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG, bool UseSSL)
		{
			
			bool RC = false;
			int LL = 1;
			Chilkat.Imap imap = new Chilkat.Imap();
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
				string TempDir = System.IO.Path.GetTempPath();
				LL = 7;
				string AttachmentDir = TempDir + "Email\\Attachment";
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
					DownLoadSize = int.Parse(val[sDownLoadSize]);
					LL = 19;
				}
				catch (System.Exception)
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
				//  Anything unlocks the component and begins a fully-functional 30-day trial.
				LL = 29;
				success = System.Convert.ToBoolean(imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G"));
				LL = 30;
				if (success != true)
				{
					LL = 31;
					MessageBox.Show((string) imap.LastErrorText);
					LL = 32;
					return false;
//					LL = 33;
				}
				LL = 34;
				
				LL = 35;
				//  To use a secure SSL connection, set SSL and the port:
				LL = 36;
				imap.Ssl = UseSSL;
				LL = 37;
				//  The typical port for IMAP SSL is 993
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
					imap.Port = val[PortNbr];
					LL = 42;
				}
				LL = 43;
				
				LL = 44;
				//  Connect to an IMAP server.
				LL = 45;
				success = System.Convert.ToBoolean(imap.Connect(MailServerAddr));
				LL = 46;
				if (success != true)
				{
					LL = 47;
					LOG.WriteToArchiveLog((string) ("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText));
					LL = 48;
					return false;
				}
				else
				{
					LL = 49;
					frmExchangeMonitor.Default.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
				}
				LL = 50;
				
				success = System.Convert.ToBoolean(imap.Login(UserLoginID, LoginPassWord));
				if (success != true)
				{
					MessageBox.Show((string) imap.LastErrorText);
					LOG.WriteToArchiveLog((string) ("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText));
					frmExchangeMonitor.Default.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
					return false;
				}
				else
				{
					LL = 57;
					frmExchangeMonitor.Default.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
				}
				LL = 58;
				
				// Get the names of all the mailboxes.
				Chilkat.Mailboxes mboxes;
				mboxes = imap.ListMailboxes("", "*");
				
				long ii;
				for (ii = 0; ii <= mboxes.Count - 1; ii++)
				{
					Console.WriteLine(mboxes.GetName(ii));
				}
				
				success = System.Convert.ToBoolean(imap.SelectMailbox("Inbox"));
				LL = 62;
				if (success != true)
				{
					LL = 63;
					MessageBox.Show((string) imap.LastErrorText);
					LOG.WriteToArchiveLog((string) ("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText));
					LL = 64;
					return false;
//					LL = 65;
				}
				LL = 66;
				
				LL = 67;
				//  After selecting a mailbox, the NumMessages property will
				LL = 68;
				//  be updated to reflect the total number of emails in the mailbox:
				LL = 69;
				frmExchangeMonitor.Default.lblMsg.Text = "Download: " + imap.NumMessages.ToString() + " messages.";
				LL = 70;
				frmExchangeMonitor.Default.lblMsg.Refresh();
				LL = 71;
				System.Windows.Forms.Application.DoEvents();
				LL = 72;
				
				LL = 73;
				int NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
				NumberOfMessagesInBox = System.Convert.ToInt32(bundle.MessageCount);
				LL = 74;
				
				LL = 75;
				if (NumberOfMessagesInBox > 0)
				{
					LL = 76;
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
					LL = 77;
				}
				else
				{
					LL = 78;
					LOG.WriteToArchiveLog((string) ("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
					LL = 79;
					goto ENDIT;
					LL = 80;
				}
				LL = 81;
				
				long startSeqNum;
				LL = 93;
				startSeqNum = 1;
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
				bundle = imap.FetchSequence(startSeqNum, numToFetch);
				LL = 128;
				//End If
				LL = 129;
				
				LL = 130;
				
				LL = 131;
				if (bundle == null)
				{
					LL = 132;
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400a: " + imap.LastErrorText));
					LL = 133;
					LOG.WriteToArchiveLog((string) ("        getImapEmailSSL 400b: startSeqNum - " + startSeqNum.ToString()));
					LL = 134;
					LOG.WriteToArchiveLog((string) ("        getImapEmailSSL 400c: numToFetch - " + numToFetch.ToString()));
					LL = 135;
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400d: messages in mailbox: " + NumberOfMessagesInBox.ToString()));
					LL = 136;
					NbrOfTries++;
					LL = 137;
					goto REDO;
					LL = 138;
				}
				LL = 139;
				
				
				LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP/SSL #emails = " + NumberOfMessagesInBox.ToString()));
				LL = 164;
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + MailServerAddr);
				LL = 165;
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
				LL = 166;
				frmExchangeMonitor.Default.lblServer.Refresh();
				LL = 167;
				frmExchangeMonitor.Default.lblServer.Refresh();
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
					for (var i = 0; i <= bundle.MessageCount - 1; i++)
					{
						LL = 179;
						TotalEmailsInArchive++;
						LL = 180;
						MessagesRemainingToProcess--;
						LL = 181;
						frmExchangeMonitor.Default.lblCnt.Text = (string) ("Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + imap.NumMessages.ToString());
						LL = 182;
						frmExchangeMonitor.Default.lblCnt.Refresh();
						LL = 183;
						System.Windows.Forms.Application.DoEvents();
						LL = 186;
						string NewGuid = System.Guid.NewGuid().ToString();
						LL = 188;
						Chilkat.Email email;
						LL = 189;
						email = bundle.GetEmail(i);
						LL = 191;
						string Subject = EMAIL.SUBJECT;
						Subject = LOG.PullOutSingleQuotes(Subject);
						LL = 192;
						string EmailFrom = (string) Email.From;
						LL = 193;
						string FromAddress = (string) Email.FromAddress;
						LL = 194;
						string FromName = (string) Email.FromName;
						LL = 195;
						string From = (string) Email.From;
						LL = 196;
						string EntryID = (string) Email.Uidl;
						LL = 197;
						if (strReject.Trim.Length > 0)
						{
							LL = 198;
							string[] A = strReject.Split(",".ToCharArray());
							LL = 199;
							for (ii = 0; ii <= (A.Length - 1); ii++)
							{
								LL = 200;
								string S1 = A[ii].Trim();
								LL = 201;
								if (S1.Trim().Length > 0)
								{
									LL = 202;
									if (Subject.IndexOf(S1) + 1)
									{
										LL = 203;
										//LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
										LL = 204;
										RejectedCount++;
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
						NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
						LL = 212;
						if (NbrDaysOld >= DaysToHold)
						{
							LL = 213;
							success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
							LL = 214;
							if (success != true)
							{
								LL = 215;
								string Msg = "Subject: " + Subject + "\r\n";
								LL = 216;
								Msg += "FromName: " + FromName + "\r\n";
								LL = 217;
								Msg += "FromAddress: " + FromAddress + "\r\n";
								LL = 218;
								LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
								LL = 219;
							}
							LL = 220;
						}
						LL = 221;
						
						LL = 222;
						int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
						LL = 223;
						int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
						LL = 224;
						int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
						LL = 225;
						int NumBcc = System.Convert.ToInt32(Email.NumBcc);
						LL = 226;
						int NumCC = System.Convert.ToInt32(Email.NumCC);
						LL = 227;
						int NumTo = System.Convert.ToInt32(Email.NumTo);
						LL = 228;
						string ReplyTo = (string) Email.ReplyTo;
						LL = 229;
						string SignedBy = (string) Email.SignedBy;
						LL = 230;
						int EmailSize = System.Convert.ToInt32(Email.Size);
						LL = 231;
						string LocalDate = (string) (Email.LocalDate.ToString());
						LL = 232;
						string EmailDate = (string) (Email.EmailDate.ToString());
						LL = 233;
						string Header = (string) Email.Header;
						LL = 234;
						string EmailBody = EMAIL.Body;
						LL = 235;
						EmailBody = LOG.PullOutSingleQuotes(EmailBody);
						LL = 236;
						
						LL = 237;
						ArrayList Recipients = new ArrayList();
						LL = 238;
						ArrayList EmailTo = new ArrayList();
						LL = 239;
						ArrayList EmailToAddr = new ArrayList();
						LL = 240;
						ArrayList EmailToName = new ArrayList();
						LL = 241;
						ArrayList Bcc = new ArrayList();
						LL = 242;
						ArrayList BccAddr = new ArrayList();
						LL = 243;
						ArrayList BccName = new ArrayList();
						LL = 244;
						ArrayList CC = new ArrayList();
						LL = 245;
						ArrayList CcAddr = new ArrayList();
						LL = 246;
						ArrayList CcName = new ArrayList();
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
						string tSubject = Subject.Substring(0, 100);
						LL = 254;
						RemoveBadChars(ref tSubject);
						LL = 255;
						
						LL = 256;
						string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.From, Subject);
						string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
						
						bool bEmailExists = DB.ExchangeEmailExists(EmailIdentifier);
						LL = 260;
						if (bEmailExists)
						{
							LL = 261;
							
							LL = 262;
							//frmExchangeMonitor.lblMessageInfo.Text = "Updated Emails: " + skippedEmails.ToString
							LL = 263;
							//frmExchangeMonitor.lblMessageInfo.Refresh()
							LL = 264;
							System.Windows.Forms.Application.DoEvents();
							LL = 265;
							
							LL = 266;
							int DaysOld = System.Convert.ToInt32(Email.NumDaysOld);
							LL = 267;
							if (DaysOld > DaysToHold)
							{
								LL = 268;
								success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
								LL = 269;
								if (success != true)
								{
									LL = 270;
									string Msg = "Subject: " + Subject + "\r\n";
									LL = 271;
									Msg += "FromName: " + FromName + "\r\n";
									LL = 272;
									Msg += "FromAddress: " + FromAddress + "\r\n";
									LL = 273;
									LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
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
						{
							LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 700: " + i.ToString()));
						}
						LL = 281;
						bool B = DB.ExchangeEmailExists(EmailIdentifier);
						LL = 282;
						if (B)
						{
							LL = 283;
							if (srv_DetailedLogging)
							{
								LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 700X already exists: " + i.ToString()));
							}
							LL = 284;
							goto NextRec;
							LL = 285;
						}
						LL = 286;
						
						LL = 287;
						string EmailFQN = EmailDir + "\\Email~" + (NewGuid + "~.EML");
						LL = 288;
						
						LL = 289;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyEmailBundle 800.4: " + i.ToString()));
						}
						LL = 290;
						if (NumAttachments > 0)
						{
							LL = 291;
							//** Clean out the directory
							LL = 292;
							deleteDirectoryFile(AttachmentDir);
							LL = 293;
							// Save attachments to the "attachments" directory.
							LL = 294;
							Email.SaveAllAttachments(AttachmentDir);
							LL = 295;
							bLoadAttachments = true;
							LL = 296;
						}
						LL = 297;
						
						LL = 298;
						if (NumAttachedMessages > 0)
						{
							LL = 299;
							//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
							LL = 300;
							for (ii = 0; ii <= NumAttachedMessages - 1; ii++)
							{
								LL = 301;
								//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
								LL = 302;
								Chilkat.Email objEmail = Email.GetAttachedMessage(ii);
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
						for (J = 0; J <= NumCC - 1; J++)
						{
							LL = 309;
							CC.Add(EMAIL.getCc[J].ToString());
							LL = 310;
							CcAddr.Add(Email.GetCcAddr(J).ToString());
							LL = 311;
							CcName.Add(Email.GetCcName(J).ToString());
							LL = 312;
							if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
							{
								LL = 313;
								Recipients.Add(Email.GetCcAddr(J).ToString());
								LL = 314;
							}
							LL = 315;
						}
						LL = 316;
						for (J = 0; J <= NumBcc - 1; J++)
						{
							LL = 317;
							Bcc.Add(EMAIL.getBcc[J].ToString());
							LL = 318;
							BccName.Add(Email.GetBccName(J).ToString());
							LL = 319;
							BccAddr.Add(Email.GetBccAddr(J).ToString());
							LL = 320;
							if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
							{
								LL = 321;
								Recipients.Add(Email.GetBccAddr(J).ToString());
								LL = 322;
							}
							LL = 323;
						}
						LL = 324;
						for (J = 0; J <= NumTo - 1; J++)
						{
							LL = 325;
							EmailTo.Add(Email.GetTo(J).ToString());
							LL = 326;
							EmailToAddr.Add(Email.GetToAddr(J).ToString());
							LL = 327;
							EmailToName.Add(Email.GetToName(J).ToString());
							LL = 328;
							if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
							{
								LL = 329;
								Recipients.Add(Email.GetToAddr(J).ToString());
								LL = 330;
							}
							LL = 331;
						}
						LL = 332;
						
						LL = 333;
						// Save the email to XML
						LL = 334;
						//email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
						LL = 335;
						
						LL = 336;
						// Save the email to EML
						LL = 337;
						//Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
						LL = 338;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.0: " + i.ToString()));
						}
						LL = 339;
						Email.SaveEml(EmailFQN);
						LL = 340;
						
						LL = 341;
						//**********************************************************
						LL = 342;
						//IF CONVERT TO MSG THEN
						LL = 343;
						//READ IN THE NEW EML
						LL = 344;
						//CONVERT IT TO MSG
						LL = 345;
						//WRITE OUT THE MSG
						LL = 346;
						//SAVE THE MSG IMAGE INTO THE REPOSITORY.
						LL = 347;
						
						LL = 348;
						if (bEmlToMSG == true)
						{
							LL = 349;
							LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN \'" + EmailFQN + "\'");
							LL = 350;
							EmailFQN = convertEmlToMsg(EmailFQN);
							LL = 351;
						}
						LL = 352;
						//**********************************************************
						LL = 353;
						
						LL = 354;
						
						LL = 355;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.1: " + i.ToString()));
						}
						LL = 356;
						List<string> AttachedFiles = new List<string>();
						LL = 357;
						getDirectoryFiles(AttachmentDir, AttachedFiles);
						LL = 358;
						
						LL = 359;
						string DB_ID = "ECM.Library";
						LL = 360;
						string Server_UserID_StoreID = CurrMailFolder;
						LL = 361;
						
						LL = 362;
						//** Now, Load the EMAIL and its metadata into the repository
						LL = 363;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.2: " + i.ToString()));
						}
						LL = 364;
						
						LL = 365;
						bool AttachmentsLoaded = false;
						LL = 366;
						
						LL = 367;
						ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, DateTime.Parse(EmailDate), UserLoginID, DateTime.Parse(LocalDate), DateTime.Parse(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
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
									DB.AppendOcrTextEmail(NewGuid);
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
						LL = 401;
						if (srv_DetailedLogging)
						{
							LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 1000: " + i.ToString()));
						}
						LL = 402;
						
						LL = 403;
					}
					LL = 404;
					//*****************************************************************************
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
						//Increment = MessagesRemainingToProcess
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
					if (numToFetch > 0)
					{
						LL = 419;
						bundle = imap.FetchSequence(startSeqNum, numToFetch);
						LL = 420;
						if (bundle == null)
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
				LOG.WriteToArchiveLog((string) ("ERROR 100 getImapEmailSSL: LL = " + LL.ToString() + ": " + ex.Message));
				RC = false;
			}
			
ENDIT:
			imap.Expunge();
			
			LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString()));
			
			//  Disconnect from the IMAP server.
			imap.Disconnect();
			
			messageSet = null;
			imap = null;
			bundle = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			frmExchangeMonitor.Default.lblCnt.Text = "Emails Processed: ";
			frmExchangeMonitor.Default.lblCnt.Refresh();
			
			return RC;
			
		}
		
		public bool getIMapEmailV3(string UID, string MailServerAddr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG)
		{
			bool RC = true;
			int LL = 0;
			Chilkat.Imap imap = new Chilkat.Imap();
			int RecjectCount = 1;
			int EmailsProcessedThisRun = 0;
			int DownLoadSize = 0;
			string sDownLoadSize = "";
			int Increment = 0;
			long I = 0;
			imap.ReadTimeout = 360;
			try
			{
				string ServerName = MailServerAddr + ":" + UserLoginID;
				
				string TempDir = System.IO.Path.GetTempPath();
				string AttachmentDir = TempDir + "Email\\Attachment";
				string EmailDir = TempDir + "Email";
				string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
				
				bool Success = false;
				imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G");
				Success = System.Convert.ToBoolean(imap.Connect(MailServerAddr));
				if (! Success)
				{
					return false;
//					MessageBox.Show((string) imap.LastErrorText);
				}
				Success = System.Convert.ToBoolean(imap.Login(UserLoginID, LoginPassWord));
				if (! Success)
				{
					MessageBox.Show((string) imap.LastErrorText);
					return false;
				}
				if (! Success)
				{
					frmExchangeMonitor.Default.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
					LOG.WriteToArchiveLog("FATAL ERROR: IMAP 300.1 Failed to log on to " + MailServerAddr + ", aborting.");
					return false;
				}
				else
				{
					frmExchangeMonitor.Default.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
				}
				// Get the names of all the mailboxes.
				Chilkat.Mailboxes mboxes;
				mboxes = imap.ListMailboxes("", "*");
				for (int iii = 0; iii <= mboxes.Count - 1; iii++)
				{
					Console.WriteLine(mboxes.GetName(iii));
					string mName = (string) (mboxes.GetName(iii));
					frmExchangeMonitor.Default.lblMsg.Text = (string) ("Mailbox: " + mboxes.GetName(iii));
					frmExchangeMonitor.Default.lblMsg.Refresh();
				}
				
				//  Once the mailbox is selected, the NumMessages property
				//  will contain the number of messages in the mailbox.
				//  You may loop from 1 to NumMessages to
				//  fetch each message by sequence number.
				bool BB = System.Convert.ToBoolean(imap.SelectMailbox("Inbox"));
				if (! BB)
				{
					return false;
				}
				
				Increment = DownLoadSize;
				
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + MailServerAddr);
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
				frmExchangeMonitor.Default.lblServer.Refresh();
				frmExchangeMonitor.Default.lblServer.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				Chilkat.EmailBundle bundle;
				
				bool ExitUponCompletion = false;
				bool fetchUids = true;
REDO:
				int NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
				int RejectedCount = 0;
				bool bUid;
				bUid = false;
				Chilkat.Email email;
				NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
				int MessagesProcessed = 0;
				int MessagesRemainingToProcess = NumberOfMessagesInBox;
				TotalEmailsInArchive = 0;
				
				TimeSpan ElapsedTime;
				TimeSpan ElapsedTxTime;
				DateInterval ETime;
				DateInterval txTime;
				DateTime StartTime = DateTime.Now;
				
				for (var iCnt = 1; iCnt <= NumberOfMessagesInBox; iCnt++)
				{
					
					//  Download the email by sequence number.
					ElapsedTxTime = DateTime.Now.Subtract(StartTime);
					StartTime = DateTime.Now;
					
					email = imap.FetchSingle(iCnt, bUid);
					string EntryID = (string) Email.Uidl;
					
					ElapsedTime = DateTime.Now.Subtract(StartTime);
					frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + MailServerAddr);
					frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
					frmExchangeMonitor.Default.lblSpeed.Text = ElapsedTime.ToString();
					frmExchangeMonitor.Default.txTime.Text = ElapsedTxTime.ToString();
					frmExchangeMonitor.Default.lblServer.Refresh();
					System.Windows.Forms.Application.DoEvents();
					
					//*******************************************************************************
					bool ExitNow = false;
					TotalEmailsInArchive++;
					EmailsProcessedThisRun++;
					MessagesRemainingToProcess--;
					frmExchangeMonitor.Default.lblCnt.Text = (string) ("Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + NumberOfMessagesInBox.ToString());
					frmExchangeMonitor.Default.lblCnt.Refresh();
					System.Windows.Forms.Application.DoEvents();
					string NewGuid = System.Guid.NewGuid().ToString();
					
					string Subject = EMAIL.SUBJECT;
					Subject = LOG.PullOutSingleQuotes(Subject);
					string EmailFrom = (string) Email.From;
					string FromAddress = (string) Email.FromAddress;
					string FromName = (string) Email.FromName;
					string From = (string) Email.From;
					
					if (strReject.Trim.Length > 0)
					{
						string[] A = strReject.Split(",".ToCharArray());
						for (int II = 0; II <= (A.Length - 1); II++)
						{
							string S1 = A[II].Trim();
							if (S1.Trim().Length > 0)
							{
								if (Subject.IndexOf(S1) + 1)
								{
									//LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
									RejectedCount++;
									goto NextRec;
								}
							}
						}
					}
					
					int NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
					if (NbrDaysOld >= DaysToHold)
					{
						Success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
						if (Success != true)
						{
							string Msg = "Subject: " + Subject + "\r\n";
							Msg += "FromName: " + FromName + "\r\n";
							Msg += "FromAddress: " + FromAddress + "\r\n";
							LOG.WriteToArchiveLog((string) ("ERROR: getIMapEmail: Failed to delete email from server:" + "\r\n" + Msg));
						}
					}
					
					int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
					int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
					int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
					int NumBcc = System.Convert.ToInt32(Email.NumBcc);
					int NumCC = System.Convert.ToInt32(Email.NumCC);
					int NumTo = System.Convert.ToInt32(Email.NumTo);
					string ReplyTo = (string) Email.ReplyTo;
					string SignedBy = (string) Email.SignedBy;
					int EmailSize = System.Convert.ToInt32(Email.Size);
					string LocalDate = (string) (Email.LocalDate.ToString());
					string EmailDate = (string) (Email.EmailDate.ToString());
					string Header = (string) Email.Header;
					string EmailBody = EMAIL.Body;
					EmailBody = LOG.PullOutSingleQuotes(EmailBody);
					
					ArrayList Recipients = new ArrayList();
					ArrayList EmailTo = new ArrayList();
					ArrayList EmailToAddr = new ArrayList();
					ArrayList EmailToName = new ArrayList();
					ArrayList Bcc = new ArrayList();
					ArrayList BccAddr = new ArrayList();
					ArrayList BccName = new ArrayList();
					ArrayList CC = new ArrayList();
					ArrayList CcAddr = new ArrayList();
					ArrayList CcName = new ArrayList();
					bool bLoadAttachments = false;
					string tEmailDate = EmailDate.ToString();
					
					FixDate(ref tEmailDate);
					string tSubject = Subject.Substring(0, 100);
					RemoveBadChars(ref tSubject);
					
					string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.From, Subject);
					string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
					
					bool bEmailExists = DB.ExchangeEmailExists(EmailIdentifier);
					
					if (bEmailExists)
					{
						System.Windows.Forms.Application.DoEvents();
						int DaysOld = System.Convert.ToInt32(Email.NumDaysOld);
						if (DaysOld < 0)
						{
							DaysOld = 1;
						}
						if (DaysOld > DaysToHold)
						{
							Success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
							if (Success != true)
							{
								string Msg = "Subject: " + Subject + "\r\n";
								Msg += "FromName: " + FromName + "\r\n";
								Msg += "FromAddress: " + FromAddress + "\r\n";
								LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
							}
						}
						goto NextRec;
					}
					
					//If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700: " + I.ToString)
					//Dim B As Boolean = DB.ExchangeEmailExists(EmailIdentifier)
					//If B Then
					//    If srv_DetailedLogging Then LOG.WriteToArchiveLog("ApplyIMapBundle 700X already exists: " + I.ToString)
					//    GoTo NextRec
					//End If
					
					string EmailFQN = EmailDir + "\\Email~" + (NewGuid + "~.EML");
					
					if (NumAttachedMessages > 0)
					{
						for (int II = 0; II <= NumAttachedMessages - 1; II++)
						{
							//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
							Chilkat.Email objEmail = Email.GetAttachedMessage(II);
							ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
							objEmail = null;
						}
					}
					
					for (var J = 0; J <= NumCC - 1; J++)
					{
						CC.Add(EMAIL.getCc[J].ToString());
						CcAddr.Add(Email.GetCcAddr(J).ToString());
						CcName.Add(Email.GetCcName(J).ToString());
						if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
						{
							Recipients.Add(Email.GetCcAddr(J).ToString());
						}
					}
					for (var J = 0; J <= NumBcc - 1; J++)
					{
						Bcc.Add(EMAIL.getBcc[J].ToString());
						BccName.Add(Email.GetBccName(J).ToString());
						BccAddr.Add(Email.GetBccAddr(J).ToString());
						if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
						{
							Recipients.Add(Email.GetBccAddr(J).ToString());
						}
					}
					for (var J = 0; J <= NumTo - 1; J++)
					{
						EmailTo.Add(Email.GetTo(J).ToString());
						EmailToAddr.Add(Email.GetToAddr(J).ToString());
						EmailToName.Add(Email.GetToName(J).ToString());
						if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
						{
							Recipients.Add(Email.GetToAddr(J).ToString());
						}
					}
					Email.SaveEml(EmailFQN);
					if (bEmlToMSG == true)
					{
						LOG.WriteToArchiveLog("Notice from getImapEmail 300 : FQN \'" + EmailFQN + "\'");
						EmailFQN = convertEmlToMsg(EmailFQN);
					}
					List<string> AttachedFiles = new List<string>();
					getDirectoryFiles(AttachmentDir, AttachedFiles);
					string DB_ID = "ECM.Library";
					string Server_UserID_StoreID = CurrMailFolder;
					
					//** Now, Load the EMAIL and its metadata into the repository
					if (srv_DetailedLogging)
					{
						LOG.WriteToArchiveLog((string) ("ApplyIMapBundle 900.2: " + I.ToString()));
					}
					
					bool AttachmentsLoaded = false;
					
					ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, DateTime.Parse(EmailDate), UserLoginID, DateTime.Parse(LocalDate), DateTime.Parse(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
					
					if (AttachmentsLoaded == true)
					{
						bool DoThis = false;
						if (DoThis)
						{
							if (AttachmentsLoaded == true)
							{
								DB.AppendOcrTextEmail(NewGuid);
								AttachmentsLoaded = false;
							}
						}
					}
					
					if (NumAttachments > 0)
					{
						//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
						for (int II = 0; II <= NumAttachments - 1; II++)
						{
							//'email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
							//Dim objEmail As Chilkat.Email = email.GetAttachedMessage(II)
							LoadEmailAttachments(AttachmentDir, NewGuid);
							//objEmail.Dispose()
						}
					}
					
NextRec:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
				//***************************************************************
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 2699 getIMapEmail: " + ex.Message));
				RC = false;
			}
			finally
			{
				// Disconnect from the IMAP server.
				// This example removes the deleted email on the IMAP server.
				imap.Expunge();
				imap.Disconnect();
				
				GC.Collect();
				GC.WaitForPendingFinalizers();
				
			}
ENDIT:
			// Save the email to an XML file
			//bundle.SaveXml("bundle.xml")
			LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle REJECTED Message Count = " + RecjectCount.ToString()));
			LOG.WriteToArchiveLog((string) ("Applying IMAP Bundle PROCESSED Message Count = " + TotalEmailsInArchive.ToString()));
			LOG.WriteToArchiveLog((string) ("INFO: Emails processed this run  = " + EmailsProcessedThisRun.ToString() + " from " + MailServerAddr));
			frmExchangeMonitor.Default.lblMessageInfo.Text = "Emails Processed: ";
			frmExchangeMonitor.Default.lblMessageInfo.Refresh();
			System.Windows.Forms.Application.DoEvents();
			return RC;
		}
		public bool getImapEmailSSLV3(string UID, string MailServerAddr, string PortNbr, string UserLoginID, string LoginPassWord, bool LeaveOnServer, string RetentionCode, int retentionYears, string LibraryName, bool isPublic, int DaysToHold, string strReject, bool bEmlToMSG, bool UseSSL)
		{
			bool RC = false;
			int LL = 1;
			Chilkat.Imap imap = new Chilkat.Imap();
			int RejectedCount = 0;
			Chilkat.MessageSet messageSet;
			Chilkat.EmailBundle bundle;
			try
			{
				string ServerName = MailServerAddr + ":" + UserLoginID;
				
				bool success = false;
				string TempDir = System.IO.Path.GetTempPath();
				string AttachmentDir = TempDir + "Email\\Attachment";
				string EmailDir = TempDir + "Email";
				string CurrMailFolder = MailServerAddr + ":" + UserLoginID;
				
				//  Anything unlocks the component and begins a fully-functional 30-day trial.
				success = System.Convert.ToBoolean(imap.UnlockComponent("DMACHIIMAPMAILQ_hQDMOhta1O5G"));
				if (success != true)
				{
					MessageBox.Show((string) imap.LastErrorText);
					return false;
				}
				
				//  To use a secure SSL connection, set SSL and the port:
				imap.Ssl = UseSSL;
				//  The typical port for IMAP SSL is 993
				if (PortNbr.Length == 0)
				{
					imap.Port = 993;
				}
				else
				{
					imap.Port = val[PortNbr];
				}
				
				//  Connect to an IMAP server.
				success = System.Convert.ToBoolean(imap.Connect(MailServerAddr));
				if (success != true)
				{
					LOG.WriteToArchiveLog((string) ("FATAL FAILED TO LOGIN ERROR getImapEmailSSL 100: " + imap.LastErrorText));
					return false;
				}
				else
				{
					frmExchangeMonitor.Default.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
				}
				success = System.Convert.ToBoolean(imap.Login(UserLoginID, LoginPassWord));
				if (success != true)
				{
					MessageBox.Show((string) imap.LastErrorText);
					LOG.WriteToArchiveLog((string) ("FATAL ERROR Failed to LOZGIN getImapEmailSSL 200: " + imap.LastErrorText));
					frmExchangeMonitor.Default.lblMessageInfo.Text = "FAILED Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
					return false;
				}
				else
				{
					frmExchangeMonitor.Default.lblMessageInfo.Text = "Login: " + UserLoginID + " successful.";
					frmExchangeMonitor.Default.lblMessageInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
				}
				// Get the names of all the mailboxes.
				Chilkat.Mailboxes mboxes;
				mboxes = imap.ListMailboxes("", "*");
				long ii;
				for (ii = 0; ii <= mboxes.Count - 1; ii++)
				{
					Console.WriteLine(mboxes.GetName(ii));
				}
				success = System.Convert.ToBoolean(imap.SelectMailbox("Inbox"));
				if (success != true)
				{
					MessageBox.Show((string) imap.LastErrorText);
					LOG.WriteToArchiveLog((string) ("FATAL ERROR getImapEmailSSL 300: " + imap.LastErrorText));
					return false;
				}
				
				//  After selecting a mailbox, the NumMessages property will
				//  be updated to reflect the total number of emails in the mailbox:
				frmExchangeMonitor.Default.lblMsg.Text = "Download: " + imap.NumMessages.ToString() + " messages.";
				frmExchangeMonitor.Default.lblMsg.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				int NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
				
				if (NumberOfMessagesInBox > 0)
				{
					LOG.WriteToArchiveLog((string) ("NOTICE: getImapEmailSSL 400.1a: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("NOTICE: No messages getImapEmailSSL 400.1b: messages in mailbox: " + ServerName + " : " + NumberOfMessagesInBox.ToString()));
					goto ENDIT;
				}
				
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email Host: " + MailServerAddr);
				frmExchangeMonitor.Default.lblServer.Text = (string) ("Email ID: " + UserLoginID);
				frmExchangeMonitor.Default.lblServer.Refresh();
				frmExchangeMonitor.Default.lblServer.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				bool bUid;
				bUid = false;
				Chilkat.Email email;
				NumberOfMessagesInBox = System.Convert.ToInt32(imap.NumMessages);
				int MessagesProcessed = 0;
				int MessagesRemainingToProcess = NumberOfMessagesInBox;
				TotalEmailsInArchive = 0;
				for (var iCnt = 1; iCnt <= NumberOfMessagesInBox; iCnt++)
				{
					
					//  Download the email by sequence number.
					email = imap.FetchSingle(iCnt, bUid);
					string EntryID = (string) Email.Uidl;
					
					TotalEmailsInArchive++;
					MessagesRemainingToProcess--;
					frmExchangeMonitor.Default.lblCnt.Text = (string) ("Emails Processed: " + TotalEmailsInArchive.ToString() + " of " + imap.NumMessages.ToString());
					frmExchangeMonitor.Default.lblCnt.Refresh();
					System.Windows.Forms.Application.DoEvents();
					string NewGuid = System.Guid.NewGuid().ToString();
					string Subject = EMAIL.SUBJECT;
					Subject = LOG.PullOutSingleQuotes(Subject);
					string EmailFrom = (string) Email.From;
					string FromAddress = (string) Email.FromAddress;
					string FromName = (string) Email.FromName;
					string From = (string) Email.From;
					
					if (strReject.Trim.Length > 0)
					{
						string[] A = strReject.Split(",".ToCharArray());
						for (ii = 0; ii <= (A.Length - 1); ii++)
						{
							string S1 = A[ii].Trim();
							if (S1.Trim().Length > 0)
							{
								if (Subject.IndexOf(S1) + 1)
								{
									//LOG.WriteToArchiveLog("Notice: email rejected - " + ServerName  + " / " + EmailFrom  + " / " + Subject  + " : Reject = " + strReject )
									RejectedCount++;
									goto NextRec;
								}
							}
						}
					}
					int NbrDaysOld = 0;
					NbrDaysOld = System.Convert.ToInt32(Email.NumDaysOld);
					if (NbrDaysOld >= DaysToHold)
					{
						success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
						if (success != true)
						{
							string Msg = "Subject: " + Subject + "\r\n";
							Msg += "FromName: " + FromName + "\r\n";
							Msg += "FromAddress: " + FromAddress + "\r\n";
							LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
						}
					}
					
					int NumAlternatives = System.Convert.ToInt32(Email.NumAlternatives);
					int NumAttachedMessages = System.Convert.ToInt32(Email.NumAttachedMessages);
					int NumAttachments = System.Convert.ToInt32(Email.NumAttachments);
					int NumBcc = System.Convert.ToInt32(Email.NumBcc);
					int NumCC = System.Convert.ToInt32(Email.NumCC);
					int NumTo = System.Convert.ToInt32(Email.NumTo);
					string ReplyTo = (string) Email.ReplyTo;
					string SignedBy = (string) Email.SignedBy;
					int EmailSize = System.Convert.ToInt32(Email.Size);
					string LocalDate = (string) (Email.LocalDate.ToString());
					string EmailDate = (string) (Email.EmailDate.ToString());
					string Header = (string) Email.Header;
					string EmailBody = EMAIL.Body;
					EmailBody = LOG.PullOutSingleQuotes(EmailBody);
					
					ArrayList Recipients = new ArrayList();
					ArrayList EmailTo = new ArrayList();
					ArrayList EmailToAddr = new ArrayList();
					ArrayList EmailToName = new ArrayList();
					ArrayList Bcc = new ArrayList();
					ArrayList BccAddr = new ArrayList();
					ArrayList BccName = new ArrayList();
					ArrayList CC = new ArrayList();
					ArrayList CcAddr = new ArrayList();
					ArrayList CcName = new ArrayList();
					bool bLoadAttachments = false;
					
					int J = 0;
					
					string tEmailDate = EmailDate.ToString();
					FixDate(ref tEmailDate);
					string tSubject = Subject.Substring(0, 100);
					RemoveBadChars(ref tSubject);
					
					string EmailIdentifier = UTIL.genEmailIdentifier(Email.EmailDate, (string) Email.From, Subject);
					string EmailHashCode = ENC.getSha1HashKey(EmailIdentifier);
					
					bool bEmailExists = DB.ExchangeEmailExists(EmailIdentifier);
					if (bEmailExists)
					{
						System.Windows.Forms.Application.DoEvents();
						int DaysOld = System.Convert.ToInt32(Email.NumDaysOld);
						if (DaysOld > DaysToHold)
						{
							success = System.Convert.ToBoolean(imap.SetMailFlag(email, "Deleted", 1));
							if (success != true)
							{
								string Msg = "Subject: " + Subject + "\r\n";
								Msg += "FromName: " + FromName + "\r\n";
								Msg += "FromAddress: " + FromAddress + "\r\n";
								LOG.WriteToArchiveLog((string) ("ERROR getIMapEmail: Failed to delete email:" + "\r\n" + Msg));
							}
						}
						goto NextRec;
					}
					
					//Dim B As Boolean = DB.ExchangeEmailExists(EmailIdentifier, EmailHashCode)
					//If B Then
					//    GoTo NextRec
					//End If
					
					string EmailFQN = EmailDir + "\\Email~" + (NewGuid + "~.EML");
					
					if (NumAttachments > 0)
					{
						//** Clean out the directory
						deleteDirectoryFile(AttachmentDir);
						// Save attachments to the "attachments" directory.
						Email.SaveAllAttachments(AttachmentDir);
						bLoadAttachments = true;
					}
					
					if (NumAttachedMessages > 0)
					{
						//email.SaveAllAttachments(AttachmentDir  + "\PendingEmail")
						for (ii = 0; ii <= NumAttachedMessages - 1; ii++)
						{
							//email.SaveAttachedFile(II, AttachmentDir  + "\PendingEmail")
							Chilkat.Email objEmail = Email.GetAttachedMessage(ii);
							ArchiveEmbeddedEmailMessage(UID, objEmail, LibraryName, ServerName, RetentionCode, isPublic, bEmlToMSG, ServerName, NewGuid, DaysToHold, EmailIdentifier, EntryID);
							objEmail = null;
						}
					}
					
					for (J = 0; J <= NumCC - 1; J++)
					{
						CC.Add(EMAIL.getCc[J].ToString());
						CcAddr.Add(Email.GetCcAddr(J).ToString());
						CcName.Add(Email.GetCcName(J).ToString());
						if (! Recipients.Contains(Email.GetCcAddr(J).ToString()))
						{
							Recipients.Add(Email.GetCcAddr(J).ToString());
						}
					}
					for (J = 0; J <= NumBcc - 1; J++)
					{
						Bcc.Add(EMAIL.getBcc[J].ToString());
						BccName.Add(Email.GetBccName(J).ToString());
						BccAddr.Add(Email.GetBccAddr(J).ToString());
						if (! Recipients.Contains(Email.GetBccAddr(J).ToString()))
						{
							Recipients.Add(Email.GetBccAddr(J).ToString());
						}
					}
					for (J = 0; J <= NumTo - 1; J++)
					{
						EmailTo.Add(Email.GetTo(J).ToString());
						EmailToAddr.Add(Email.GetToAddr(J).ToString());
						EmailToName.Add(Email.GetToName(J).ToString());
						if (! Recipients.Contains(Email.GetToAddr(J).ToString()))
						{
							Recipients.Add(Email.GetToAddr(J).ToString());
						}
					}
					
					// Save the email to XML
					//email.SaveXml(EmailDir  + "\" + "Email" & Str(I) & ".xml")
					
					// Save the email to EML
					//Dim EmlFileName  = EmailDir  + "\" + NewGuid  + ".eml"
					Email.SaveEml(EmailFQN);
					
					//**********************************************************
					//IF CONVERT TO MSG THEN
					//READ IN THE NEW EML
					//CONVERT IT TO MSG
					//WRITE OUT THE MSG
					//SAVE THE MSG IMAGE INTO THE REPOSITORY.
					
					if (bEmlToMSG == true)
					{
						LOG.WriteToArchiveLog("Notice from getImapEmailSSL 300 : FQN \'" + EmailFQN + "\'");
						EmailFQN = convertEmlToMsg(EmailFQN);
					}
					//**********************************************************
					
					List<string> AttachedFiles = new List<string>();
					getDirectoryFiles(AttachmentDir, AttachedFiles);
					
					string DB_ID = "ECM.Library";
					string Server_UserID_StoreID = CurrMailFolder;
					
					//** Now, Load the EMAIL and its metadata into the repository
					bool AttachmentsLoaded = false;
					
					ArchiveExchangeEmails(UID, NewGuid, EmailBody, Subject, CcAddr, BccAddr, EmailToAddr, Recipients, MailServerAddr, FromAddress, FromName, DateTime.Parse(EmailDate), UserLoginID, DateTime.Parse(LocalDate), DateTime.Parse(EmailDate), DB_ID, CurrMailFolder, Server_UserID_StoreID, retentionYears, RetentionCode, EmailSize, AttachedFiles, EntryID, EmailIdentifier, EmailFQN, LibraryName, isPublic, bEmlToMSG, ref AttachmentsLoaded, DaysToHold);
					
					if (AttachmentsLoaded == true)
					{
						bool DoThis = false;
						if (DoThis)
						{
							if (AttachmentsLoaded == true)
							{
								DB.AppendOcrTextEmail(NewGuid);
								AttachmentsLoaded = false;
							}
						}
					}
NextRec:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 100 getImapEmailSSL: LL = " + LL.ToString() + ": " + ex.Message));
				RC = false;
			}
ENDIT:
			imap.Expunge();
			LOG.WriteToArchiveLog((string) ("Processing Exchange IMAP/SSL rejected #emails = " + RejectedCount.ToString()));
			//  Disconnect from the IMAP server.
			imap.Disconnect();
			messageSet = null;
			imap = null;
			bundle = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			frmExchangeMonitor.Default.lblCnt.Text = "Emails Processed: ";
			frmExchangeMonitor.Default.lblCnt.Refresh();
			return RC;
		}
		
		
		public void LoadEmailAttachments(string DirectoryFQN, string EmailGuid)
		{
			
			string RetentionCode = "Retain 10";
			string ispublic = "N";
			
			string strFileSize = "";
			System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirectoryFQN);
			System.IO.FileInfo[] aryFi = di.GetFiles("*.*");
			
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			
			foreach (System.IO.FileInfo fi in aryFi)
			{
				
				string filename = fi.FullName;
				string FileNameOnly = fi.Name;
				string FileExt = fi.Extension;
				
				if (File.Exists(filename))
				{
					bool isZipFile = ZF.isZipFile(filename);
					if (isZipFile == true)
					{
						//** Explode and load
						string AttachmentName = filename;
						bool SkipIfAlreadyArchived = false;
						bool AttachmentsLoaded = false;
						ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, filename, modGlobals.gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
					}
					else
					{
						FileExt = (string) ("." + UTIL.getFileSuffix(filename));
						string AttachmentName = filename;
						string Sha1Hash = ENC.getSha1HashFromFile(filename);
						bool bbx = DB.InsertAttachmentFqn(modGlobals.gCurrUserGuidID, filename, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, DirectoryFQN);
						
						if (FileExt.ToUpper().Equals(".PDF"))
						{
							TotalOcr++;
							frmExchangeMonitor.Default.lblMsg.Text = (string) ("Total OCR: " + TotalOcr.ToString());
							//**WDM DB.PDFXTRACT(EmailGuid, filename , "EMAIL")
						}
					}
				}
				
			}
		}
		
		private void PurgeDirectory(string DirFqn)
		{
			
			string[] S;
			
			S = Directory.GetFiles(DirFqn);
			
			foreach (string DELFILE in S)
			{
				File.Delete(DELFILE);
			}
		}
		
		
		
	}
	
}
