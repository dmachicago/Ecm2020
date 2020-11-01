#define RemoteOcr
#define EnableSingleSource
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

using System.Deployment.Application;
using System.Reflection;
using System.Web;
using System.Collections.Specialized;
using System.Data.SqlServerCe;
using System.Security.Principal;
using System.IO;
using System.Threading;
using Microsoft.SqlServer;
using System.Security.Permissions;
using Microsoft.Win32;
using Microsoft.VisualBasic.CompilerServices;








namespace EcmArchiveClcSetup
{
	public partial class frmMain
	{
		
#region Default Instance
		
		private static frmMain defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmMain Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmMain();
					defaultInstance.FormClosed += new FormClosedEventHandler(defaultInstance_FormClosed);
				}
				
				return defaultInstance;
			}
		}
		
		static void defaultInstance_FormClosed(object sender, FormClosedEventArgs e)
		{
			defaultInstance = null;
		}
		
#endregion
		
		SVCSearch.Service1Client ProxySearch = new SVCSearch.Service1Client();
		SVCCLCArchive.Service1Client ProxyArchive = new SVCCLCArchive.Service1Client();
		SVCFS.Service1Client ProxyFS = new SVCFS.Service1Client();
		string VerifyEmbeddedZipFiles = "";
		bool SkipPermission = false;
		bool LocalDBBackUpComplete = false;
		
		bool bUseRemoteServer = false;
		string MachineIDcurr = "";
		string UIDcurr = "";
		bool ArgsPassedIn = false;
		int gbEmailWidth = 0;
		
		string[] args = null;
		clsSAVEDITEMS SI = new clsSAVEDITEMS();
		bool LoginAsNewUser = false;
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsDbLocal DBLocal = new clsDbLocal();
		clsRegistry REG = new clsRegistry();
		clsLicenseMgt LM = new clsLicenseMgt();
		List<string> AssignedLibraries = new List<string>();
		bool ArchiveActive = false;
		Thread ActivityThread;
		Thread t2;
		Thread t3;
		Thread t4;
		Thread t5;
		Thread t6;
		Thread t7;
		Thread t8;
		Thread t;
		
		bool UseThreads = true;
		
		public int ThreadCnt = 0;
		bool MiniArchiveRunning = false;
		bool ListenersDefined = false;
		bool ListenForChanges = false;
		bool ListenDirectory = false;
		bool ListenSubDirectory = false;
		string DirGuid = "";
		
		
		string MachineName; // VBConversions Note: Initial value of "Environment.MachineName.ToString()" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		bool FoldersRefreshed = false;
		bool AllEmailFoldersShowing = false;
		bool bApplyingDirParms = false;
		bool bSingleInstanceContent = true;
		bool bAddThisFileAsNewVersion = false;
		
		int NbrFilesInDir = 0;
		
		string ParentFolder = "";
		string FQNFolder = "";
		bool bActiveChange = false;
		bool isOutlookAvail = false;
		
		public int EmailsBackedUp = 0;
		public int EmailsSkipped = 0;
		public int FilesBackedUp = 0;
		public int FilesSkipped = 0;
		
		string CurrentDirectory = "";
		
		double ImageSizeDouble = 0;
		string ImageGuid = "";
		
		clsGlobalEntity GE = new clsGlobalEntity();
		clsListener LISTEN = new clsListener();
		clsProcess PROC = new clsProcess();
		bool DisplayActivity = false;
		bool isAdmin = false;
		clsAutoLibRef ALR = new clsAutoLibRef();
		bool IncludeListHasChanged = false;
		clsRecon RECON = new clsRecon();
		clsArchiver ARCH = new clsArchiver();
		clsExecParms PARMS = new clsExecParms();
		clsARCHIVESTATS STATS = new clsARCHIVESTATS();
		clsAVAILFILETYPESUNDEFINED UNASGND = new clsAVAILFILETYPESUNDEFINED();
		clsAppParms AP = new clsAppParms();
		clsZipFiles ZF = new clsZipFiles();
		clsUSERS USERS = new clsUSERS();
		clsMP3 MP3 = new clsMP3();
		bool MsgNotification = false;
		clsFileInfo FI = new clsFileInfo();
		clsEncrypt ENC = new clsEncrypt();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		//Dim KAT As New clsChilKat
		
		//Dim CMODI As New clsModi
		
		//Public gCurrUserGuidID = ""
		public string CurrIdentity = "";
		bool formloaded = false;
		
		bool bUseAttachData = false;
		string CompanyID = "";
		string RepoID = "";
		
		clsDATASOURCE_V2 DOCS = new clsDATASOURCE_V2();
		clsAVAILFILETYPES AVL = new clsAVAILFILETYPES();
		clsDATABASES DBASES = new clsDATABASES();
		clsEMAILARCHPARMS EMPARMS = new clsEMAILARCHPARMS();
		clsEMAILFOLDER EMF = new clsEMAILFOLDER();
		clsEXCLUDEDFILES EXL = new clsEXCLUDEDFILES();
		clsINCLUDEDFILES INL = new clsINCLUDEDFILES();
		clsReconUSERS RUSER = new clsReconUSERS();
		clsDatabase DB = new clsDatabase();
		clsRUNPARMS RPARM = new clsRUNPARMS();
		clsDIRECTORY DIRS = new clsDIRECTORY();
		clsSUBDIR SUBDIRECTORY = new clsSUBDIR();
		clsDma DMA = new clsDma();
		clsPROCESSFILEAS PFA = new clsPROCESSFILEAS();
		int CompletedPolls = 0;
		clsATTRIBUTES ATTRIB = new clsATTRIBUTES();
		clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
		clsATTACHMENTTYPE ATCH_TYPE = new clsATTACHMENTTYPE();
		public ArrayList SubDirectories = new ArrayList();
		public ArrayList IncludedTypes = new ArrayList();
		public ArrayList ExcludedTypes = new ArrayList();
		public ArrayList AuthorizedFileTypes = new ArrayList();
		public ArrayList UnAuthorizedFileTypes = new ArrayList();
		
		bool ddebug = false;
		bool bHelpLoaded = false;
		public ArrayList ArchivedEmailFolders = new ArrayList();
		
		//Dim Proxy As New SVCCLCArchive.Service1Client
		
		
		//Sub New()
		//    ' This call is required by the Windows Form Designer.
		//    InitializeComponent()
		
		//    ' Add any initialization after the InitializeComponent() call.
		
		
		//End Sub
		
		//Private Sub frmReconMain_Activated(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Activated
		
		//    Dim ClientOnly  = System.Configuration.ConfigurationManager.AppSettings("ClientOnly")
		
		//    Dim iClient As Integer = CInt(ClientOnly)
		//    If iClient = 1 Then
		//        Me.Visible = False
		//        ckDisable.Checked = True
		//        cbInterval.Text = "Disable"
		
		//        saveStartUpParms()
		//        Return
		//    End If
		
		//    GetLocation(Me)
		//    LOG.WriteToArchiveFileTraceLog("", True)
		
		//    Dim S  = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] " ' where ProfileName = 'XX'"
		//    DB.PopulateComboBox(cbProfile, "ProfileName", S)
		
		//End Sub
		
		/// <summary>
		/// Initializes a new instance of the <see cref="frmReconMain" /> class.
		/// </summary>
		public frmMain()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			MachineName = Environment.MachineName.ToString();
			
			
			// This call is required by the designer.
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
			
			// Add any initialization after the InitializeComponent() call.
			
			if (My.Settings.Default["UpgradeSettings"] == true)
			{
				try
				{
					LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 100");
					My.Settings.Default.Upgrade();
					My.Settings.Default.Reload();
					My.Settings.Default["UpgradeSettings"] = false;
					My.Settings.Default.Save();
					LOG.WriteToArchiveLog((string) ("NOTICE: New INSTALL detected 200: " + My.Settings.Default["UserDefaultConnString"]));
					LOG.WriteToArchiveLog((string) ("NOTICE: New INSTALL detected 300: " + My.Settings.Default["UserThesaurusConnString"]));
					
					DBLocal.RestorepDirTbl();
					DBLocal.RestorepFileTbl();
					DBLocal.RestorepInventoryTbl();
					
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: INSTALL 100: " + ex.Message));
				}
			}
			
			string strUseRemoteServer = System.Configuration.ConfigurationManager.AppSettings["UseRemoteServer"];
			if (strUseRemoteServer.Equals("1"))
			{
				bUseRemoteServer = true;
			}
			else
			{
				bUseRemoteServer = false;
			}
			
			ExitToolStripMenuItem.Visible = true;
			
			try
			{
				VerifyEmbeddedZipFiles = System.Configuration.ConfigurationManager.AppSettings["VerifyEmbeddedZipFiles"];
			}
			catch (Exception)
			{
				VerifyEmbeddedZipFiles = "0";
			}
			
			
			modGlobals.gMachineID = LOG.getEnvVarMachineName();
			modGlobals.gNetworkID = LOG.getEnvVarNetworkID();
			
			DBLocal.cleanZipFiles();
			
			UTIL.cleanTempWorkingDir();
			
		}
		
		
		public void frmReconMain_Load(System.Object sender, System.EventArgs e)
		{
			
			bool ContentOnly = false;
			bool OutlookOnly = false;
			bool ExchangeOnly = false;
			bool ArchiveALL = false;
			
			double LL = 0;
			string CurrUserGuidID = "";
			MachineIDcurr = DMA.GetCurrMachineName();
			
			string CurrentLoginID = System.Environment.UserName;
			
			try
			{
				args = Environment.GetCommandLineArgs();
				LL = 64;
				modGlobals.gRunMode = "GUI";
				LL = 65;
				GetQueryStringParameters();
				LL = 69;
				if (args != null)
				{
					LL = 66.1;
					//** The only allowed argument is company id and repo id separated by a semicolon
					//** Or a directory name with or without a file qualifier.
					//** If a directory name is passed in, only that directory will be processed
					//** and its subdirectories if specified as such.
					ArgsPassedIn = true;
					foreach (string Arg in args)
					{
						LL = 67;
						if (Arg.IndexOf(";") + 1)
						{
							string[] AA = Arg.Split(";".ToCharArray());
							CompanyID = AA[0];
							RepoID = AA[1];
							string sCompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
							string sRepoID = REG.ReadEcmRegistrySubKey("RepoID");
							bool bReg = false;
							if (sCompanyID.Length == 0)
							{
								bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID);
								if (! bReg)
								{
									bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID);
								}
							}
							if (sRepoID.Length == 0)
							{
								bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID);
								if (! bReg)
								{
									bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID);
								}
							}
						}
						string xArg = Arg.ToString();
						LL = 68;
						
						LL = 69;
						if (xArg.Substring(0, 1).Equals("U"))
						{
							ArgsPassedIn = true;
							//Execute archive and close app : LL = 71
							LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
							LL = 72;
							modGlobals.gCurrLoginID = Arg.Substring(1);
							LL = 73;
							CurrentLoginID = modGlobals.gCurrLoginID;
							SB2.Text = "Running as : \'" + modGlobals.gCurrLoginID + "\'";
							LL = 74;
							SB.Text = "Running as : \'" + modGlobals.gCurrLoginID + "\'";
							LL = 75;
						}
						LL = 76;
						if (Arg.ToUpper().Equals("U"))
						{
							ArgsPassedIn = true;
							//Execute archive and close app : LL = 78
							LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
							LL = 79;
							modGlobals.gCurrLoginID = Arg.Substring(1);
							LL = 80;
							CurrentLoginID = modGlobals.gCurrLoginID;
							SB2.Text = "Running as : \'" + modGlobals.gCurrLoginID + "\'";
							LL = 81;
							SB.Text = "Running as : \'" + modGlobals.gCurrLoginID + "\'";
							LL = 82;
						}
						LL = 83;
						if (Arg.ToUpper().Equals("P"))
						{
							ArgsPassedIn = true;
							//Execute archive and close app : LL = 85
							LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
							LL = 86;
							modGlobals.gEncPassword = Arg.Substring(1);
							LL = 87;
							modGlobals.gUnEncPassword = ENC.AES256DecryptString(modGlobals.gEncPassword);
							LL = 88;
						}
						LL = 89;
						if (Arg.ToUpper().Equals("RUV"))
						{
							ArgsPassedIn = true;
							LOG.WriteToArchiveLog("Notification: upgrading user settings.");
							LL = 91;
							My.Settings.Default["UpgradeSettings"] = true;
							LL = 92;
							My.Settings.Default.Save();
							LL = 93;
						}
						LL = 94;
						if (Arg.ToUpper().Equals("X"))
						{
							ArgsPassedIn = true;
							//Execute archive and close app : LL = 96
							LOG.WriteToArchiveLog("Notification: Scheduled Execute archive and close app.");
							LL = 97;
							modGlobals.gRunMode = "X";
							LL = 98;
							modGlobals.gRunMinimized = true;
							LL = 99;
							modGlobals.gRunUnattended = true;
							LL = 100;
							this.WindowState = FormWindowState.Minimized;
							LL = 101;
						}
						LL = 102;
						if (Arg.ToUpper().Equals("A"))
						{
							ArgsPassedIn = true;
							//Execute archive and close app : LL = 104
							LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
							LL = 105;
							modGlobals.gRunMode = "X";
							LL = 106;
							modGlobals.gContentArchiving = true;
							LL = 107;
							modGlobals.gContactsArchiving = true;
							modGlobals.gOutlookArchiving = true;
							LL = 108;
							modGlobals.gExchangeArchiving = true;
							LL = 109;
							ArchiveALL = true;
							LL = 110;
							modGlobals.gRunMinimized = true;
							LL = 111;
							modGlobals.gRunUnattended = true;
							LL = 112;
							//ArchiveALLToolStripMenuItem_Click(Nothing, Nothing) : LL = 113
						}
						else
						{
							if (Arg.ToUpper().Equals("C"))
							{
								ArgsPassedIn = true;
								modGlobals.gContentArchiving = false;
								LL = 116;
								modGlobals.gContactsArchiving = false;
								LOG.WriteToArchiveLog("Notification: Scheduled Execute CONTENT archives.");
								LL = 117;
								//Execute archive and close app : LL = 118
								ContentOnly = true;
								LL = 119;
								modGlobals.gRunMinimized = true;
								LL = 120;
								modGlobals.gRunUnattended = true;
								LL = 121;
								modGlobals.gContentArchiving = true;
								LL = 122;
								modGlobals.gContactsArchiving = true;
								modGlobals.gOutlookArchiving = false;
								LL = 123;
								modGlobals.gExchangeArchiving = false;
								LL = 124;
							}
							LL = 125;
							if (Arg.ToUpper().Equals("O"))
							{
								ArgsPassedIn = true;
								LOG.WriteToArchiveLog("Notification: Scheduled Execute OUTLOOK archives.");
								LL = 127;
								//Execute outlook and close app : LL = 128
								modGlobals.gOutlookArchiving = false;
								LL = 129;
								ExchangeOnly = true;
								LL = 130;
								modGlobals.gRunMinimized = true;
								LL = 131;
								modGlobals.gRunUnattended = true;
								LL = 132;
								modGlobals.gContentArchiving = false;
								LL = 133;
								modGlobals.gContactsArchiving = false;
								modGlobals.gOutlookArchiving = true;
								LL = 134;
								modGlobals.gExchangeArchiving = false;
								LL = 135;
							}
							LL = 136;
							if (Arg.ToUpper().Equals("E"))
							{
								ArgsPassedIn = true;
								LOG.WriteToArchiveLog("Notification: Scheduled Execute EXCHANGE archives.");
								LL = 138;
								//Execute Exchange and close app : LL = 139
								modGlobals.gExchangeArchiving = false;
								LL = 140;
								OutlookOnly = true;
								LL = 141;
								modGlobals.gRunMinimized = true;
								LL = 142;
								modGlobals.gRunUnattended = true;
								LL = 143;
								modGlobals.gContentArchiving = false;
								LL = 144;
								modGlobals.gContactsArchiving = false;
								modGlobals.gOutlookArchiving = false;
								LL = 145;
								modGlobals.gExchangeArchiving = true;
								LL = 146;
							}
							LL = 147;
						}
						LL = 148;
						
						LL = 149;
						if (Arg.ToUpper().Equals("?"))
						{
							string MSG = "";
							LL = 151;
							MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + "\r\n" + "\r\n";
							LL = 152;
							MSG = MSG + "CompanyID;RepoID" + "\r\n" + "\r\n";
							LL = 153;
							MSG = MSG + "X = Execute archive and close." + "\r\n" + "\r\n";
							LL = 153;
							MSG = MSG + "C = Archive CONTENT only." + "\r\n" + "\r\n";
							LL = 154;
							MSG = MSG + "O = Archive OUTLOOK only." + "\r\n" + "\r\n";
							LL = 155;
							MSG = MSG + "E = Archive EXCHANGE Servers only." + "\r\n" + "\r\n";
							LL = 156;
							MSG = MSG + "A = Archive ALL." + "\r\n" + "\r\n";
							LL = 157;
							MSG = MSG + "To Execute:" + "\r\n";
							LL = 158;
							MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + "\r\n";
							LL = 159;
							MSG = MSG + "(E.G.) C:\\dev\\ECM\\EcmLibSvc\\EcmLibSvc\\bin\\Debug\\EcmArchiveSetup.exe Q" + "\r\n";
							LL = 160;
							MessageBox.Show(MSG);
							LL = 161;
							ProjectData.EndApp();
							LL = 162;
						}
						LL = 163;
					}
				}
				else
				{
					ArgsPassedIn = false;
				}
				LL = 165.01;
				
				modGlobals.gCurrentConnectionString = "";
				LL = 166.1;
				try
				{
					CompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
					LL = 167.2;
				}
				catch (Exception)
				{
					CompanyID = "";
					LL = 167.21;
				}
				try
				{
					RepoID = REG.ReadEcmRegistrySubKey("RepoID");
					LL = 168.3;
				}
				catch (Exception)
				{
					RepoID = "";
					LL = 168.31;
				}
				
				//gCurrentConnectionString = REG.ReadEcmRegistrySubKey("EncConnectionString")
				if (CompanyID == null)
				{
					LL = 168.31;
					CompanyID = modGlobals.gCompanyID;
					LL = 168.32;
				}
				if (RepoID == null)
				{
					LL = 168.33;
					RepoID = modGlobals.gRepoID;
				}
				
				if (modGlobals.gCompanyID.Trim().Length > 0 && modGlobals.gRepoID.Trim().Length > 0)
				{
					LL = 165.4;
					SVCGateway.Service1Client ProxyAttach = new SVCGateway.Service1Client();
					LL = 165.5;
					string EncCS = "";
					bool RC = false;
					string RetMsg = "";
					LL = 165.6;
					EncCS = (string) (ProxyAttach.getConnection(modGlobals.gCompanyID, modGlobals.gRepoID, RC, RetMsg));
					LL = 165.7;
					if (EncCS.Trim().Length > 0)
					{
						
						LL = 165.7;
						try
						{
							modGlobals.gCurrentConnectionString = ENC.AES256DecryptString(EncCS);
							LL = 165.8;
						}
						catch (Exception)
						{
							modGlobals.gCurrentConnectionString = EncCS;
							LL = 165.8;
						}
						if (modGlobals.gCurrentConnectionString.Length > 0)
						{
							bool bReg = REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS);
							LL = 165.9;
							if (! bReg)
							{
								LL = 165.1;
								bReg = REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS);
								LL = 165.11;
							}
							LL = 165.12;
						}
					}
					else
					{
						
						LL = 165.13;
						modGlobals.gCurrentConnectionString = "";
						
						LL = 165.14;
					}
					
					LL = 165.15;
					ProxyAttach = null;
					bUseAttachData = true;
					
					LL = 165.16;
				}
				else
				{
					LL = 165.17;
					bUseAttachData = false;
					
					LL = 165.18;
				}
				
				LL = 165.19;
				//bUseAttachData = ISO.ReadAttachData(CompanyID, RepoID)
				
				string defaultUserId = (string) My.Settings.Default.DefaultLoginID;
				LL = 165.2;
				if (defaultUserId.Trim().Length > 0)
				{
					LL = 165.3;
					CurrentLoginID = defaultUserId;
					LL = 165.4;
					string EPW = (string) My.Settings.Default.DefaultLoginPW;
					LL = 165.5;
					EPW = ENC.AES256DecryptString(EPW);
					LL = 165.6;
				}
				LL = 165.7;
				
				var bDbConnectionGood = DB.ckDbConnection("frmReconMain 100");
				LL = 200.1;
				
				if (bDbConnectionGood == false)
				{
					LL = 201.2;
					if (modGlobals.gRunUnattended == true)
					{
						LL = 202.1;
						LOG.WriteToArchiveLog("ABORTING frmReconMain_Load run - Failed to connect to the database, closing ECM.");
						LL = 203.1;
						Application.Exit();
					}
					else
					{
						LL = 204.1;
						string ConnStr = DB.getGateWayConnStr(modGlobals.gGateWayID);
						MessageBox.Show((string) ("ABORTING - Failed to connect to the database, contact an administrator - closing ECM." + "\r\n" + ConnStr));
						LL = 205.1;
						Application.Exit();
					}
					tsTunnelConn.Text = "Tunnel:OFF";
				}
				else
				{
					tsTunnelConn.Text = "Tunnel:ON";
				}
				LL = 213.15;
				
				bool bWebDbConn = System.Convert.ToBoolean(ProxyArchive.ckDbConnection(modGlobals.gGateWayID, CurrentLoginID, MachineIDcurr));
				LL = 213.2;
				if (bWebDbConn)
				{
					LL = 213.3;
					tsServiceDBConnState.Text = "SaaS:ON";
				}
				else
				{
					LL = 213.4;
					tsServiceDBConnState.Text = "SaaS:OFF";
					MessageBox.Show("Could not attach - closing the application.");
					Application.Exit();
				}
				LL = 213.5;
				ImpersonateLoginToolStripMenuItem.Visible = false;
				
				int iRunningInstances = 0;
				LL = 213.6;
				iRunningInstances = UTIL.countApplicationInstances("ECMARCHIVESETUP");
				LL = LL == 213.7;
				if (iRunningInstances > 2)
				{
					LL = 213.8;
					frmMsg.Default.txtMsg.Text = "ECM Archiver already running - closing.";
					LL = 213.9;
					frmMsg.Default.Show();
					Thread.Sleep(10000);
					ProjectData.EndApp();
				}
				LL = 213.11;
				string PrevArchiverExecPath = "";
				try
				{
					REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath);
					LL = 7.11;
					PrevArchiverExecPath = REG.ReadEcmRegistrySubKey("EcmArchiverDir");
					LL = 7.12;
				}
				catch (Exception)
				{
					REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath);
					LL = 9.1;
				}
				
				if (PrevArchiverExecPath.Length == 0)
				{
					LL = 8;
					REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath);
					LL = 9.2;
				}
				LL = 10;
				string CurrAppExecPath = Application.ExecutablePath;
				LL = 11;
				string CurrBuildDate = "";
				LL = 13;
				FileInfo fApp = new FileInfo(CurrAppExecPath);
				LL = 14;
				CurrBuildDate = fApp.CreationTime.ToString();
				LL = 15;
				fApp = null;
				LL = 16;
				string CurrBuildID = System.Configuration.ConfigurationManager.AppSettings["ArchiverBuildID"];
				LL = 18;
				string PrevArchiverBuildID = REG.ReadEcmRegistrySubKey("EcmArchiverBuildID");
				LL = 19;
				if (PrevArchiverBuildID == null)
				{
					LL = 20;
					REG.CreateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID);
					LL = 21;
				}
				LL = 22;
				
				LL = 23;
				string PrevArchiverBuildDate = REG.ReadEcmRegistrySubKey("EcmSetupAppCreateDate");
				LL = 24;
				if (PrevArchiverBuildDate.Trim().Length == 0)
				{
					LL = 25;
					REG.CreateEcmRegistrySubKey("EcmSetupAppCreateDate", CurrBuildDate.ToString());
					LL = 26;
				}
				LL = 27;
				
				LL = 28;
				if (! CurrBuildDate.Equals(PrevArchiverBuildDate))
				{
					LL = 29;
					//** Resync all scheduled archive jobs to point to the new path. : LL = 30
					Console.WriteLine("Resync archive jobs.");
					LL = 31;
					frmSchedule.Default.ValidateExecPath();
					LL = 32;
				}
				LL = 33;
				if (! PrevArchiverExecPath.Equals(Application.ExecutablePath))
				{
					LL = 34;
					//** Resync all scheduled archive jobs to point to the new path. : LL = 35
					Console.WriteLine("Resync archive jobs.");
					LL = 36;
					frmSchedule.Default.ValidateExecPath();
					LL = 37;
				}
				LL = 38;
				
				LL = 39;
				if (! CurrBuildID.Equals(PrevArchiverBuildID))
				{
					LL = 40;
					//** Resync all scheduled archive jobs to point to the new path. : LL = 41
					Console.WriteLine("Resync archive jobs.");
					LL = 42;
					frmSchedule.Default.ValidateExecPath();
					LL = 43;
					REG.UpdateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID);
					LL = 44;
				}
				LL = 45;
				
				LL = 46;
				modGlobals.gContentArchiving = false;
				LL = 47;
				modGlobals.gOutlookArchiving = false;
				LL = 48;
				modGlobals.gExchangeArchiving = false;
				LL = 49;
				modGlobals.gContactsArchiving = false;
				
				LL = 50;
				REG.CreateEcmSubKey();
				LL = 51;
				REG.SetEcmSubKey();
				LL = 52;
				Console.WriteLine(REG.ReadEcmSubKey(""));
				LL = 53;
				TimerEndRun.Enabled = false;
				LL = 54;
				//Timer1.Enabled = False : LL = 55
				TimerUploadFiles.Enabled = false;
				LL = 56;
				TimerListeners.Enabled = false;
				LL = 57;
				
				LL = 58;
				bool B = false;
				LL = 59;
				
				if (modGlobals.gRunMode == "X")
				{
					LL = 167;
					this.WindowState = FormWindowState.Minimized;
					LL = 168;
				}
				LL = 169;
				
				try
				{
					LL = 171;
					if (My.Settings.Default["UpgradeSettings"] == true)
					{
						LL = 172;
						try
						{
							LL = 173;
							LOG.WriteToInstallLog("NOTICE frmReconMain: New INSTALL detected 100");
							LL = 174;
							My.Settings.Default.Upgrade();
							LL = 175;
							My.Settings.Default.Reload();
							LL = 176;
							My.Settings.Default["UpgradeSettings"] = false;
							LL = 177;
							My.Settings.Default.Save();
							LL = 178;
							LOG.WriteToInstallLog((string) ("NOTICE: New INSTALL detected 200: " + My.Settings.Default["UserDefaultConnString"]));
							LL = 179;
							LOG.WriteToInstallLog((string) ("NOTICE: New INSTALL detected 300: " + My.Settings.Default["UserThesaurusConnString"]));
							LL = 180;
						}
						catch (Exception ex)
						{
							LL = 181;
							LOG.WriteToInstallLog((string) ("ERROR: INSTALL 100: " + ex.Message));
							LL = 182;
						}
						LL = 183;
					}
					else
					{
						LL = 184;
						LOG.WriteToInstallLog("NOTICE: NO New INSTALL 100-A");
						LL = 185;
					}
					LL = 186;
				}
				catch (Exception ex)
				{
					LL = 187;
					Console.WriteLine("ERROR 1XA1: - " + ex.Message);
					LL = 188;
				}
				LL = 189;
				
				LL = 190;
				My.Settings.Default["UpgradeSettings"] = false;
				LL = 191;
				My.Settings.Default.Save();
				LL = 192;
				string strUseRemoteServer = System.Configuration.ConfigurationManager.AppSettings["UseRemoteServer"];
				LL = 193;
				
				if (strUseRemoteServer.Equals("1"))
				{
					LL = 194;
					modGlobals.gCurrThesaurusCS = DB.getThesaurusConnStr();
					LL = 195;
					modGlobals.gCurrRepositoryCS = DB.getGateWayConnStr(modGlobals.gGateWayID);
					LL = 196;
				}
				else
				{
					modGlobals.gCurrThesaurusCS = REG.ReadEcmCurrentConnectionString("TheasaurusCS");
					LL = 197;
					modGlobals.gCurrRepositoryCS = REG.ReadEcmCurrentConnectionString("RepositoryCS");
					LL = 198;
				}
				
				
				LL = 199;
				B = DB.ckDbConnection("frmReconMain 100");
				LL = 200;
				if (B == false)
				{
					LL = 201;
					if (modGlobals.gRunUnattended == true)
					{
						LL = 202;
						LOG.WriteToArchiveLog("ABORTING - Failed to connect to the database, closing ECM.");
						LL = 203;
						Application.Exit();
					}
					else
					{
						LL = 204;
						MessageBox.Show("ABORTING - Failed to connect to the database, closing ECM.");
						LL = 205;
						Application.Exit();
					}
					LL = 212;
				}
				LL = 213;
				
				LL = 214;
				//************************ : LL = 215
				SetDateFormats();
				LL = 216;
				//************************ : LL = 217
				
				LL = 218;
				bool bLicenseExists = DB.LicenseExists();
				LL = 219;
				if (bLicenseExists == false)
				{
					LL = 220;
					string msg = "ABORTING - A license for the product does not exist - contact an administrator. ";
					MessageBox.Show(msg);
					Application.Exit();
				}
				LL = 223;
				
				LL = 224;
				modGlobals.ShowMsgHeader("Standby please, fetching setup parameters.");
				LL = 225;
				
				LL = 226;
				ListenersDefined = DB.isListeningOn();
				LL = 227;
				
				LL = 228;
				string sDebug = DB.getUserParm("debug_SetupScreen");
				LL = 229;
				
				LL = 230;
				if (sDebug.Equals("0"))
				{
					LL = 231;
					ddebug = false;
					LL = 232;
				}
				else
				{
					LL = 233;
					ddebug = true;
					LL = 234;
					LOG.WriteToArchiveLog("Starting: frmReconMain, Debug configuration is ON");
					LL = 235;
				}
				LL = 236;
				
				LL = 237;
				string ImpersonateID = "";
				bool bImpersonateID = UTIL.isImpersonationSet(ref ImpersonateID);
				if (bImpersonateID)
				{
					modGlobals.gCurrLoginID = ImpersonateID;
					CurrentLoginID = ImpersonateID;
					CurrUserGuidID = DB.getUserGuidByLoginID(ImpersonateID);
					LogIntoSystem(CurrentLoginID);
					LL = 238;
					modGlobals.gCurrLoginID = CurrentLoginID;
				}
				else
				{
					LogIntoSystem(modGlobals.gCurrLoginID);
					LL = 238;
				}
				ckLicense();
				LL = 240;
				
				CurrUserGuidID = DB.getUserGuidID(CurrentLoginID);
				LL = 279;
				modGlobals.gCurrUserGuidID = CurrUserGuidID;
				UIDcurr = CurrUserGuidID;
				if (CurrUserGuidID.Length == 0)
				{
					//** This can be caused by IMPERSONATION using an unidentified user id.
					//** Start by removing impersonation.
					string msg = "The USER ID currently in use, \'" + modGlobals.gCurrUserGuidID + "\', is not identified to the database, please contact an administrator. Exiting the program.";
					MessageBox.Show(msg);
					return;
//					LL = 243;
				}
				LL = 244;
				
				formloaded = true;
				LL = 246;
				modResizeForm.GetLocation(this);
				LL = 247;
				formloaded = false;
				LL = 248;
				isAdmin = DB.isAdmin(CurrUserGuidID);
				LL = 250;
				if (modGlobals.HelpOn)
				{
					LL = 252;
					DB.getFormTooltips(this, TT, true);
					LL = 253;
					TT.Active = true;
					LL = 254;
					bHelpLoaded = true;
					LL = 255;
				}
				else
				{
					LL = 256;
					TT.Active = false;
					LL = 257;
				}
				LL = 258;
				
				LL = 259;
				
				TT.SetToolTip(ckPublic, "Check this item to set all contents of the selected directory to PUBLIC access.");
				LL = 263;
				TT.SetToolTip(btnDeleteEmailEntry, "Press to remove the selected archive mail folder.");
				LL = 264;
				TT.SetToolTip(btnRefreshFolders, "Press to show all of your available mail folders.");
				LL = 265;
				TT.SetToolTip(btnActive, "Press to how only the folders you have selected for archive.");
				LL = 266;
				TT.SetToolTip(ckDisable, "Check to disable automatic archiving.");
				LL = 267;
				TT.SetToolTip(btnAddFiletype, "Add the new file type to those available.");
				LL = 268;
				TT.SetToolTip(ckRemoveFileType, "Remove the selected file type from those available.");
				LL = 269;
				
				if (modGlobals.HelpOn)
				{
					LL = 271;
					TT.Active = true;
					LL = 272;
				}
				else
				{
					LL = 273;
					TT.Active = false;
					LL = 274;
				}
				LL = 275;
				
				if (CurrUserGuidID.Length == 0)
				{
					LL = 277;
					CurrentLoginID = System.Environment.UserName;
					LL = 278;
					CurrUserGuidID = DB.getUserGuidID(CurrentLoginID);
					LL = 279;
				}
				LL = 280;
				
				if (isAdmin == true)
				{
					LL = 282;
					clAdminDir.Enabled = true;
					LL = 283;
					ckSystemFolder.Enabled = true;
					LL = 284;
				}
				else
				{
					LL = 285;
					clAdminDir.Enabled = false;
					LL = 286;
					ckSystemFolder.Enabled = false;
					LL = 287;
				}
				LL = 288;
				clAdminDir.Visible = true;
				LL = 289;
				
				formloaded = false;
				LL = 290;
				string TgtFolder = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
				bool bOutlook = UTIL.isOutLookRunning();
				LL = 291;
				if (bOutlook == true)
				{
					frmOutlookNotice.Default.Show();
				}
				LL = 292;
				modGlobals.setMsgHeader("Fetching outlook folder names.");
				LL = 293;
				ARCH.OutlookFolderNames(TgtFolder);
				LL = 294;
				isOutlookAvail = System.Convert.ToBoolean(ARCH.getCurrentOutlookFolders(TgtFolder, modGlobals.CF));
				LL = 295;
				ARCH.setChildFoldersList(modGlobals.CF);
				LL = 296;
				frmOutlookNotice.Default.Close();
				LL = 297;
				frmOutlookNotice.Default.Hide();
				LL = 298;
				ARCH.HistoryFolderExists();
				LL = 299;
				//** UPDATE THE CURRENT FOLDERS TO CONTAIN THE FOLDERID'S : LL = 331
				
				LL = 332;
				foreach (string SS in modGlobals.CF.Keys)
				{
					LL = 333;
					string CurrName = SS.ToString();
					LL = 334;
					int iKey = modGlobals.CF.IndexOfKey(CurrName);
					LL = 336;
					string CurrKey = (string) (modGlobals.CF[CurrName]);
					LL = 337;
					string MySql = "";
					LL = 339;
					CurrName = UTIL.RemoveSingleQuotes(CurrName);
					LL = 340;
					ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder);
					LL = 341;
					MySql = "update EmailFolder set FolderID = \'" + CurrKey + "\' where FolderName = \'" + CurrName + "\' and ParentFolderName  = \'" + ParentFolder + "\' ";
					LL = 342;
					bool B1 = DB.ExecuteSqlNewConn(MySql, false);
					LL = 343;
					if (! B1)
					{
						LL = 344;
						if (ddebug)
						{
							LOG.WriteToArchiveLog("NOTICE frmReconMain:Load process 5X.1 unsuccessful.");
						}
						LL = 345;
					}
					LL = 346;
				}
				LL = 347;
				//End If : LL = 348
				
				LL = 349;
				CurrIdentity = DB.getUserLoginByUserid(CurrUserGuidID);
				LL = 350;
				if (CurrIdentity.Trim.Length == 0)
				{
					LL = 351;
					return;
//					LL = 352;
				}
				LL = 353;
				//SB.Text = "Current User: " + System.Environment.UserName : LL = 354
				SB.Text = (string) ("Current User: " + CurrIdentity);
				LL = 355;
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 5 successful.");
				}
				LL = 356;
				try
				{
					LL = 357;
					modGlobals.setMsgHeader("Setting process memory, just a moment.");
					LL = 358;
					ARCH.DeleteOutlookMessages(CurrUserGuidID);
					LL = 359;
				}
				catch (Exception)
				{
					LL = 360;
					LOG.WriteToArchiveLog("WARNING 2005.32.22 - call DeleteOutlookMessages failed.");
					LL = 361;
				}
				LL = 362;
				
				LL = 363;
				modGlobals.setMsgHeader("Initializing archive parameters, this could take a few seconds.");
				LL = 364;
				ckInitialData();
				LL = 365;
				
				DB.LoadAvailFileTypes(cbFileTypes);
				LL = 367;
				DB.LoadAvailFileTypes(cbPocessType);
				LL = 368;
				DB.LoadAvailFileTypes(cbAsType);
				LL = 369;
				DB.LoadAvailFileTypes(lbAvailExts);
				LL = 370;
				
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 6 successful.");
				}
				LL = 372;
				
				DB.LoadRetentionCodes(cbRetention);
				LL = 374;
				DB.LoadRetentionCodes(cbRssRetention);
				DB.LoadRetentionCodes(cbWebPageRetention);
				DB.LoadRetentionCodes(cbWebSiteRetention);
				DB.LoadRetentionCodes(cbEmailRetention);
				LL = 375;
				
				int IMax = 0;
				LL = 377;
				ARCH.getOutlookParentFolderNames(this.cbParentFolders);
				LL = 378;
				if (cbParentFolders.Items.Count > 0)
				{
					LL = 379;
					IMax = cbParentFolders.Items.Count - 1;
					LL = 380;
					ParentFolder = cbParentFolders.Items[IMax].ToString();
					LL = 381;
				}
				else
				{
					LL = 382;
					ParentFolder = "Unknown";
					LL = 383;
				}
				
				DB.GetActiveEmailFolders(ParentFolder, lbActiveFolder, CurrUserGuidID, modGlobals.CF, ArchivedEmailFolders);
				LL = 386;
				
				DB.GetActiveDatabases(cbEmailDB);
				LL = 388;
				DB.GetActiveDatabases(cbFileDB);
				LL = 389;
				
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 7 successful.");
				}
				LL = 391;
				
				DB.GetDirectories(lbArchiveDirs, CurrUserGuidID, false);
				LL = 393;
				
				LL = 394;
				GetExecParms();
				LL = 395;
				
				LL = 396;
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 8a successful.");
				}
				LL = 397;
				
				LL = 398;
				DB.GetProcessAsList(cbProcessAsList);
				LL = 399;
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 8b successful.");
				}
				LL = 400;
				DB.getExcludedEmails(CurrUserGuidID);
				LL = 401;
				
				LL = 402;
				string tVal = DB.UserParmRetrive("ckUseLastProcessDateAsCutoff", CurrUserGuidID);
				LL = 403;
				if (tVal.ToUpper().Equals("TRUE"))
				{
					LL = 404;
					ckUseLastProcessDateAsCutoff.Checked = true;
					LL = 405;
				}
				else
				{
					LL = 406;
					ckUseLastProcessDateAsCutoff.Checked = false;
					LL = 407;
				}
				LL = 408;
				tVal = DB.UserParmRetrive("ckArchiveBit", CurrUserGuidID);
				LL = 409;
				if (tVal.ToUpper().Equals("TRUE"))
				{
					LL = 410;
					ckArchiveBit.Checked = true;
					LL = 411;
				}
				else
				{
					LL = 412;
					ckArchiveBit.Checked = false;
					LL = 413;
				}
				LL = 414;
				
				LL = 415;
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 9 successful.");
				}
				LL = 416;
				
				LL = 417;
				string S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "; // where ProfileName = 'XX'" : LL = 418
				DB.PopulateComboBox(cbProfile, "ProfileName", S);
				LL = 419;
				
				LL = 420;
				if (! isOutlookAvail)
				{
					LL = 421;
					ckDisableOutlookEmailArchive.Checked = true;
					LL = 422;
					SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL.";
					LL = 426;
				}
				LL = 424;
				
				Thread T = new Thread(new System.Threading.ThreadStart(GetRidOfOldMessages));
				LL = 429;
				T.IsBackground = true;
				LL = 430;
				T.Priority = ThreadPriority.Lowest;
				LL = 431;
				T.TrySetApartmentState(ApartmentState.STA);
				LL = 432;
				T.Start();
				LL = 433;
				
				LL = 434;
				formloaded = true;
				LL = 435;
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 10 successful.");
				}
				LL = 436;
				
				LL = 437;
				if (cbParentFolders.Items.Count > 0)
				{
					LL = 438;
					cbParentFolders.Text = cbParentFolders.Items[cbParentFolders.Items.Count - 1];
					LL = 439;
					btnActive_Click(null, null);
					LL = 440;
				}
				LL = 441;
				
				if (modGlobals.gIsServiceManager == true)
				{
					LL = 444;
					gbPolling.Enabled = true;
					LL = 445;
					ckUseLastProcessDateAsCutoff.Enabled = true;
					LL = 446;
					btnRefreshFolders.Enabled = true;
					LL = 447;
					btnActive.Enabled = true;
					LL = 448;
					cbParentFolders.Enabled = true;
					LL = 450;
					lbActiveFolder.Enabled = true;
					LL = 451;
					ckArchiveFolder.Enabled = true;
					LL = 452;
					ckArchiveRead.Enabled = true;
					LL = 453;
					ckRemoveAfterXDays.Enabled = true;
					LL = 454;
					NumericUpDown3.Enabled = true;
					LL = 455;
					ckSystemFolder.Enabled = true;
					LL = 456;
					cbEmailRetention.Enabled = true;
					LL = 457;
					btnSaveConditions.Enabled = true;
					LL = 458;
					btnDeleteEmailEntry.Enabled = true;
					LL = 459;
					OutlookEmailsToolStripMenuItem.Enabled = true;
					LL = 460;
					ExchangeEmailsToolStripMenuItem.Enabled = true;
					LL = 461;
					ContentToolStripMenuItem.Enabled = true;
					LL = 462;
					ArchiveALLToolStripMenuItem.Enabled = true;
					LL = 463;
					ckArchiveBit.Enabled = true;
					LL = 464;
					CkMonitor.Enabled = true;
					LL = 465;
					TT.SetToolTip(CkMonitor, "Not an available selection for the Service Manager.");
					LL = 466;
				}
				else
				{
					LL = 467;
					TT.SetToolTip(CkMonitor, "Track changes to this directory instantly.");
					LL = 468;
				}
				LL = 469;
				
				LOG.WriteToTimerLog("MDIMAIN 01", "isOfficeInstalled01", "START");
				LL = 471;
				modGlobals.gOfficeInstalled = UTIL.isOfficeInstalled();
				LL = 472;
				modGlobals.gOffice2007Installed = UTIL.isOffice2007Installed();
				LL = 473;
				LOG.WriteToTimerLog("MDIMAIN 01", "isOfficeInstalled01", "END", DateTime.Now);
				LL = 474;
				
				if (modGlobals.gOfficeInstalled == false)
				{
					LL = 476;
					SB.Text = "MS Office appears not to be installed.";
					LL = 477;
				}
				LL = 478;
				
				if (modGlobals.gOffice2007Installed == false)
				{
					LL = 479;
					//ckOcr.Enabled = False : LL = 480
					TT.SetToolTip(ckOcr, "Only available when Office 2007 is installed.");
					LL = 481;
					TT.SetToolTip(ckMetaData, "Only available when Office 2007 is installed.");
					LL = 483;
					TT.SetToolTip(ckOcrPdf, "Only available when Office 2007 is installed.");
					LL = 483;
					ckMetaData.Enabled = false;
					LL = 482;
					//ckOcr.Enabled = False : LL = 482
					//ckOcrPdf.Enabled = False : LL = 482
				}
				LL = 484;
				
				if (DB.isPublicAllowed() == false)
				{
					LL = 486;
					this.ckPublic.Visible = false;
					LL = 487;
				}
				else
				{
					LL = 488;
					this.ckPublic.Visible = true;
					LL = 489;
				}
				LL = 490;
				btnInclFileType.Visible = false;
				LL = 492;
				btnExclude.Visible = false;
				LL = 493;
				S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
				LL = 495;
				DB.PopulateComboBox(this.cbDirProfile, "ProfileName", S);
				LL = 496;
				lbActiveFolder.Items.Clear();
				LL = 498;
				
				LL = 499;
				if (isAdmin == false)
				{
					LL = 500;
					btnSaveDirProfile.Enabled = false;
					LL = 501;
					btnUpdateDirectoryProfile.Enabled = false;
					LL = 502;
					btnDeleteDirProfile.Enabled = false;
					LL = 503;
					ckArchiveBit.Enabled = false;
					LL = 504;
				}
				LL = 505;
				if (ddebug)
				{
					LOG.WriteToArchiveLog("frmReconMain:Load process 11 successful.");
				}
				LL = 506;
				
				modGlobals.CloseMsgHeader();
				LL = 508;
				SetUnattendedFlag();
				LL = 509;
				SetUnattendedCheckBox();
				LL = 510;
				
				ckPauseListener.Checked = false;
				LL = 512;
				
				int NbrListeners = LISTEN.LoadListeners(MachineName);
				LL = 514;
				
				if (NbrListeners > 0)
				{
					LL = 516;
					TimerUploadFiles.Enabled = true;
					LL = 517;
					TimerListeners.Enabled = true;
					LL = 518;
				}
				else
				{
					LL = 519;
					TimerUploadFiles.Enabled = false;
					LL = 520;
					TimerListeners.Enabled = false;
					LL = 521;
				}
				LL = 522;
				
				if (modGlobals.gRunMinimized)
				{
					LL = 524;
					this.WindowState = FormWindowState.Minimized;
					LL = 525;
				}
				LL = 526;
				
				if (modGlobals.gRunMode == "X")
				{
					LL = 528;
					TimerEndRun.Enabled = false;
					LL = 530;
					TimerUploadFiles.Enabled = false;
					LL = 532;
					TimerListeners.Enabled = false;
					LL = 533;
					
					if (ArchiveALL == true)
					{
						LL = 535;
						ArchiveALLToolStripMenuItem_Click(null, null);
						LL = 536;
					}
					else
					{
						LL = 537;
						if (ContentOnly == true)
						{
							LL = 538;
							ContentToolStripMenuItem_Click(null, null);
							LL = 539;
						}
						LL = 540;
						if (OutlookOnly == true)
						{
							LL = 541;
							OutlookEmailsToolStripMenuItem_Click(null, null);
							LL = 542;
						}
						LL = 543;
						if (ExchangeOnly == true)
						{
							LL = 544;
							ExchangeEmailsToolStripMenuItem_Click(null, null);
							LL = 545;
						}
						LL = 546;
					}
					LL = 547;
				}
				else
				{
					LL = 548;
					TimerEndRun.Enabled = false;
					LL = 549;
					TimerUploadFiles.Enabled = false;
					LL = 551;
					TimerListeners.Enabled = true;
					LL = 552;
				}
				LL = 553;
				
				tssUser.Text = CurrUserGuidID;
				LL = 555;
				tssAuth.Text = DB.getAuthority(CurrUserGuidID);
				LL = 556;
				SetVersionAndServer();
				LL = 557;
				
				if (ArgsPassedIn && (modGlobals.gContactsArchiving || modGlobals.gContentArchiving || modGlobals.gOutlookArchiving || modGlobals.gExchangeArchiving))
				{
					LL = 559;
					string StatusBarMsg = "";
					if (modGlobals.gExchangeArchiving)
					{
						StatusBarMsg += " - Exchange - archiving";
					}
					else
					{
						StatusBarMsg += " - Exchange - complete";
					}
					if (modGlobals.gOutlookArchiving)
					{
						StatusBarMsg += " - Outlook - archiving";
					}
					else
					{
						StatusBarMsg += " - Outlook - complete";
					}
					if (modGlobals.gContentArchiving)
					{
						StatusBarMsg += " - Content - archiving";
					}
					else
					{
						StatusBarMsg += " - Content - complete";
					}
					if (modGlobals.gContactsArchiving)
					{
						StatusBarMsg += " - Contacts - archiving";
					}
					else
					{
						StatusBarMsg += " - Contacts - complete";
					}
					LOG.WriteToArchiveLog((string) ("INFO: Auto-archive timer started - " + DateTime.Now.ToString()));
					LL = 560;
					modGlobals.gRunMinimized = true;
					LL = 561;
					modGlobals.gRunUnattended = true;
					LL = 562;
					this.WindowState = FormWindowState.Minimized;
					LL = 563;
					int II = 0;
					LL = 564;
					while (modGlobals.gContentArchiving || modGlobals.gOutlookArchiving || modGlobals.gExchangeArchiving || modGlobals.gContentArchiving)
					{
						II++;
						LL = 566;
						Application.DoEvents();
						LL = 567;
						Thread.Sleep(1000);
						LL = 568;
						tbExchange.Text = (string) ("Archive running: " + DateTime.Now.ToString() + " / " + II.ToString());
						if (modGlobals.gExchangeArchiving)
						{
							StatusBarMsg += " - Exchange - archiving";
						}
						else
						{
							StatusBarMsg += " - Exchange - complete";
						}
						if (modGlobals.gOutlookArchiving)
						{
							StatusBarMsg += " - Outlook - archiving";
						}
						else
						{
							StatusBarMsg += " - Outlook - complete";
						}
						if (modGlobals.gContentArchiving)
						{
							StatusBarMsg += " - Content - archiving";
						}
						else
						{
							StatusBarMsg += " - Content - complete";
						}
						if (modGlobals.gContactsArchiving)
						{
							StatusBarMsg += " - Contacts - archiving";
						}
						else
						{
							StatusBarMsg += " - Contacts - complete";
						}
						this.Refresh();
						LL = 572;
					}
					LL = 573;
					LOG.WriteToArchiveLog((string) ("INFO: Auto-archive execution ended - " + DateTime.Now.ToString()));
					LL = 574;
					LOG.WriteToArchiveLog("*****************************************************");
					LL = 575;
					//Application.Exit() : LL = 576
					ProjectData.EndApp();
					LL = 577;
				}
				LL = 578;
				
				//If ArgsPassedIn Then
				//    Application.Exit()
				//End If
				
				formloaded = false;
				int iHours = My.Settings.Default["BackupIntervalHours"];
				if (iHours > 0)
				{
					nbrArchiveHours.Value = iHours;
				}
				formloaded = true;
				
				//If isAdmin Then
				//    asyncVerifyRetainDates_DoWork(Nothing, Nothing)
				//End If
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR frmReconMain_Load 01: " + LL.ToString() + "\r\n" + ex.Message));
				Clipboard.Clear();
				Clipboard.SetText(ex.Message);
				MessageBox.Show((string) ("ERROR frmReconMain_Load 01 check the logs: " + LL.ToString() + "\r\n" + ex.Message));
			}
			
			if (DB.isAdmin(CurrUserGuidID))
			{
				ImpersonateLoginToolStripMenuItem.Visible = true;
				ckDeleteAfterArchive.Enabled = true;
			}
			else
			{
				ImpersonateLoginToolStripMenuItem.Visible = false;
				ckDeleteAfterArchive.Enabled = false;
			}
			
			tssUser.Text = CurrUserGuidID;
			LL = 555;
			tssAuth.Text = DB.getAuthority(CurrUserGuidID);
			LL = 556;
			
			SetVersionAndServer();
			
			modGlobals.gCurrUserGuidID = CurrUserGuidID;
			UIDcurr = CurrUserGuidID;
			
			populateCompanyCombo();
			
			tsCurrentRepoID.Text = (string) ("Repo: " + RepoID);
			//** CheckForShortcut()
			
			if (! isAdmin)
			{
				ReOcrALLGraphicFilesToolStripMenuItem1.Visible = false;
			}
			
			//** Add this in 10.05.2011
			if (My.Settings.Default.GatewayConnString.Equals("?"))
			{
				//Dim CSS As String = Proxy.
				//My.Settings.GatewayConnString = CSS
				//My.Settings.Save()
			}
			//** Add this in 10.05.2011
			if (My.Settings.Default.UserDefaultConnString.Equals("?"))
			{
				//Dim CSS As String = Proxy.
				//My.Settings.UserDefaultConnString = CSS
				//My.Settings.Save()
			}
			
			GetRSS(modGlobals.gGateWayID);
			GetWebPage(modGlobals.gGateWayID);
			GetWebSite(modGlobals.gGateWayID);
			
		}
		
		public void GetRidOfOldMessages()
		{
			
			ARCH.CreateEcmHistoryFolder();
			try
			{
				ARCH.DeleteOutlookMessages(modGlobals.gCurrUserGuidID);
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("WARNING 2005.32.21 - call DeleteOutlookMessages failed.");
			}
		}
		
		public void ckInitialData()
		{
			AddInitialDB();
			//wdm()
			//Dim BB As Boolean = DB.ckUserExists(gCurrUserGuidID)
			//'gCurrUserGuidID = gCurrUserGuidID
			//If Not BB Then
			//    RUSER.setUserid(gCurrUserGuidID)
			//    RUSER.Insert()
			//    AddInitialEmailFolder("Inbox")
			//    AddInitialEmailFolder("Sentmail")
			//End If
			
			var BB = DB.ckFileExtExists();
			if (! BB)
			{
				AVL.setExtcode(".ascx");
				AVL.Insert();
				AVL.setExtcode(".asm");
				AVL.Insert();
				AVL.setExtcode(".asp");
				AVL.Insert();
				AVL.setExtcode(".aspx");
				AVL.Insert();
				AVL.setExtcode(".bat");
				AVL.Insert();
				AVL.setExtcode(".c");
				AVL.Insert();
				AVL.setExtcode(".cmd");
				AVL.Insert();
				AVL.setExtcode(".cpp");
				AVL.Insert();
				AVL.setExtcode(".cxx");
				AVL.Insert();
				AVL.setExtcode(".def");
				AVL.Insert();
				AVL.setExtcode(".dic");
				AVL.Insert();
				AVL.setExtcode(".doc");
				AVL.Insert();
				AVL.setExtcode(".docx");
				AVL.Insert();
				AVL.setExtcode(".dot");
				AVL.Insert();
				AVL.setExtcode(".h");
				AVL.Insert();
				AVL.setExtcode(".hhc");
				AVL.Insert();
				AVL.setExtcode(".hpp");
				AVL.Insert();
				AVL.setExtcode(".htm");
				AVL.Insert();
				AVL.setExtcode(".html");
				AVL.Insert();
				AVL.setExtcode(".htw");
				AVL.Insert();
				AVL.setExtcode(".htx");
				AVL.Insert();
				AVL.setExtcode(".hxx");
				AVL.Insert();
				AVL.setExtcode(".ibq");
				AVL.Insert();
				AVL.setExtcode(".idl");
				AVL.Insert();
				AVL.setExtcode(".inc");
				AVL.Insert();
				AVL.setExtcode(".inf");
				AVL.Insert();
				AVL.setExtcode(".ini");
				AVL.Insert();
				AVL.setExtcode(".inx");
				AVL.Insert();
				AVL.setExtcode(".js");
				AVL.Insert();
				AVL.setExtcode(".log");
				AVL.Insert();
				AVL.setExtcode(".m3u");
				AVL.Insert();
				AVL.setExtcode(".mht");
				AVL.Insert();
				AVL.setExtcode(".msg");
				AVL.Insert();
				AVL.setExtcode(".obd");
				AVL.Insert();
				AVL.setExtcode(".obt");
				AVL.Insert();
				AVL.setExtcode(".odc");
				AVL.Insert();
				AVL.setExtcode(".pl");
				AVL.Insert();
				AVL.setExtcode(".pot");
				AVL.Insert();
				AVL.setExtcode(".ppt");
				AVL.Insert();
				AVL.setExtcode(".rc");
				AVL.Insert();
				AVL.setExtcode(".reg");
				AVL.Insert();
				AVL.setExtcode(".rtf");
				AVL.Insert();
				AVL.setExtcode(".stm");
				AVL.Insert();
				AVL.setExtcode(".txt");
				AVL.Insert();
				AVL.setExtcode(".url");
				AVL.Insert();
				AVL.setExtcode(".vbs");
				AVL.Insert();
				AVL.setExtcode(".wtx");
				AVL.Insert();
				AVL.setExtcode(".xlb");
				AVL.Insert();
				AVL.setExtcode(".xlc");
				AVL.Insert();
				AVL.setExtcode(".xls");
				AVL.Insert();
				AVL.setExtcode(".xlt");
				AVL.Insert();
				AVL.setExtcode(".xml");
				AVL.Insert();
				AVL.setExtcode(".pdf");
				AVL.Insert();
				AVL.setExtcode(".msg");
				AVL.Insert();
				
			}
			
			int iCnt = DB.getTableCount("Attributes");
			if (iCnt < 3)
			{
				AddFileAttributes();
			}
			
			iCnt = DB.getTableCount("SourceType");
			if (iCnt == 0)
			{
				DB.AddSecondarySOURCETYPE(".ascx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".asm", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".asp", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".aspx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".bat", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".c", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".cmd", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".cpp", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".cxx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".def", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".dic", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".doc", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".dot", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".h", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".hhc", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".hpp", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".htm", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".html", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".htw", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".htx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".hxx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".ibq", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".idl", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".inc", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".inf", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".ini", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".inx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".js", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".log", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".m3u", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".mht", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".msg", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".obd", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".obt", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".odc", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".pl", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".pot", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".ppt", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".rc", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".reg", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".rtf", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".stm", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".txt", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".url", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".vbs", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".wtx", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".xlb", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".xlc", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".xls", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".xlt", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".xml", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".pdf", "Word Splitter", "0", "1");
				DB.AddSecondarySOURCETYPE(".zip", "Word Splitter", "0", "0");
			}
			iCnt = DB.getTableCount("AttachmentType");
			if (iCnt < 5)
			{
				ATCH_TYPE.setAttachmentcode(".ascx");
				ATCH_TYPE.setIszipformat("0");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".asm");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".asp");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".aspx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".bat");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".c");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".cmd");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".cpp");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".cxx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".def");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".dic");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".doc");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".docx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".dot");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".h");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".hhc");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".hpp");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".htm");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".html");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".htw");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".htx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".hxx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".ibq");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".idl");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".inc");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".inf");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".ini");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".inx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".js");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".log");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".m3u");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".mht");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".msg");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".obd");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".obt");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".odc");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".pl");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".pot");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".ppt");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".rc");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".reg");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".rtf");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".stm");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".txt");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".url");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".vbs");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".wtx");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".xlb");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".xlc");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".xls");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".xlt");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".xml");
				ATCH_TYPE.Insert();
				ATCH_TYPE.setAttachmentcode(".pdf");
				ATCH_TYPE.Insert();
			}
		}
		
		
		public void ckRemoveAfterXDays_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckRemoveAfterXDays.Checked)
			{
				NumericUpDown3.Enabled = true;
			}
			else
			{
				NumericUpDown3.Enabled = false;
			}
		}
		
		public void lbActiveFolder_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if (e.Button == MouseButtons.Right)
			{
				if (e.Button == MouseButtons.Right)
				{
					if (e.Button == MouseButtons.Right)
					{
						System.Drawing.Point PNT = new System.Drawing.Point();
						PNT.X = e.X;
						PNT.Y = e.Y;
						int X = e.X;
						int Y = e.Y;
						if (modGlobals.gClipBoardActive == true)
						{
							Console.WriteLine(X.ToString() + "," + Y.ToString());
						}
						ContextMenuStrip1.Show(this.lbActiveFolder, X, Y);
					}
				}
			}
		}
		
		public void ListBox1_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			int I = lbActiveFolder.SelectedItems.Count;
			if (I == 0)
			{
				SB.Text = "You must select an item from the listbox...";
				return;
			}
			
			if (cbParentFolders.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please select a Parent Folder");
				return;
			}
			
			SB2.Text = lbActiveFolder.SelectedItem.ToString().Trim();
			
			string EmailFolderName = "";
			string RemoveAfterArchive = "";
			string SetAsDefaultFolder = "";
			string ArchiveAfterXDays = "";
			string ArchiveXDays = "";
			string RemoveAfterXDays = "";
			string RemoveXDays = "";
			string DBID = "";
			string ArchiveEmails = "";
			string ArchiveOnlyIfRead = "";
			string SystemFolder = "";
			
			
			string FolderName = lbActiveFolder.SelectedItem.ToString().Trim();
			string KeyFolderName = ParentFolder + "|" + FolderName;
			KeyFolderName = UTIL.RemoveSingleQuotes(KeyFolderName);
			string WhereClause = " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FolderName = \'" + KeyFolderName + "\' ";
			
			string[] aParms = DB.SelectOneEmailParm(WhereClause);
			
			if (aParms[8] == null)
			{
				aParms[8] = FolderName;
				aParms[1] = "";
				aParms[2] = "";
				aParms[3] = "";
				aParms[4] = "";
				aParms[7] = "";
				aParms[5] = "";
				aParms[6] = "";
				aParms[9] = "";
				aParms[10] = "";
				aParms[11] = "";
			}
			
			AddNewDirectory();
			
			ShowSellectedLibs(KeyFolderName, "EMAIL");
			
			
		}
		public void AddNewDirectory()
		{
			string EmailFolderName = "";
			string RemoveAfterArchive = "";
			string SetAsDefaultFolder = "";
			string ArchiveAfterXDays = "";
			string ArchiveXDays = "";
			string RemoveAfterXDays = "";
			string RemoveXDays = "";
			string DBID = "";
			string ArchiveEmails = "";
			string ArchiveOnlyIfRead = "";
			string SystemFolder = "";
			
			
			string FolderName = lbActiveFolder.SelectedItem.ToString().Trim();
			string KeyFolderName = ParentFolder + "|" + FolderName;
			KeyFolderName = UTIL.RemoveSingleQuotes(KeyFolderName);
			string WhereClause = " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FolderName = \'" + KeyFolderName + "\' ";
			
			string[] aParms = DB.SelectOneEmailParm(WhereClause);
			
			if (aParms[8] == null)
			{
				aParms[8] = FolderName;
				aParms[1] = "";
				aParms[2] = "";
				aParms[3] = "";
				aParms[4] = "";
				aParms[7] = "";
				aParms[5] = "";
				aParms[6] = "";
				aParms[9] = "";
				aParms[10] = "";
				aParms[11] = "";
			}
			//UserID = a(0)
			//ArchiveEmails = a(1)
			//RemoveAfterArchive = a(2)
			//SetAsDefaultFolder = a(3)
			//ArchiveAfterXDays = a(4)
			//RemoveAfterXDays = a(5)
			//RemoveXDays = a(6)
			//ArchiveXDays = a(7)
			//FolderName = a(8)
			//DB_ID = a(9)
			string tEmailFolderName = aParms[8];
			
			string[] A = tEmailFolderName.Split("|");
			EmailFolderName = A[(A.Length - 1)];
			
			ArchiveEmails = aParms[1];
			RemoveAfterArchive = aParms[2];
			SetAsDefaultFolder = aParms[3];
			ArchiveAfterXDays = aParms[4];
			ArchiveXDays = aParms[7];
			RemoveAfterXDays = aParms[5];
			RemoveXDays = aParms[6];
			DBID = aParms[9];
			ArchiveOnlyIfRead = aParms[10];
			SystemFolder = aParms[11];
			
			if (SystemFolder.ToUpper.Equals("TRUE"))
			{
				ckSystemFolder.Checked = true;
			}
			else
			{
				ckSystemFolder.Checked = false;
			}
			
			if (ArchiveEmails.Equals("Y"))
			{
				ckArchiveFolder.Checked = true;
			}
			else
			{
				ckArchiveFolder.Checked = false;
			}
			if (ArchiveOnlyIfRead.Equals("Y"))
			{
				this.ckArchiveRead.Checked = true;
			}
			else
			{
				ckArchiveRead.Checked = false;
			}
			
			if (RemoveAfterXDays.Equals("Y"))
			{
				ckRemoveAfterXDays.Checked = true;
				
			}
			else
			{
				ckRemoveAfterXDays.Checked = false;
			}
			if (RemoveAfterXDays.Equals("Y"))
			{
				ckRemoveAfterXDays.Checked = true;
				NumericUpDown3.Value = decimal.Parse(RemoveXDays);
				NumericUpDown3.Enabled = true;
			}
			else
			{
				ckRemoveAfterXDays.Checked = false;
				NumericUpDown3.Value = decimal.Parse("0");
				NumericUpDown3.Enabled = false;
			}
			
			cbEmailRetention.Text = DB.GetEmailRetentionCode(tEmailFolderName, modGlobals.gCurrUserGuidID);
			cbEmailDB.Text = DBID;
		}
		public void RemoveAlreadyArchived(string ParentFolder, bool HideArchived)
		{
			int I = 0;
			int k = 0;
			
			for (I = lbActiveFolder.Items.Count - 1; I >= 0; I--)
			{
				//Console.WriteLine("--------------")
				string S1 = lbActiveFolder.Items[I].ToString();
				//S1 = ParentFolder  + "|" + S1
				for (int j = 0; j <= ArchivedEmailFolders.Count - 1; j++)
				{
					string s2 = ArchivedEmailFolders[j].ToString();
					//WDM Remove this
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(s2 + " : " + S1);
					}
					this.SB.Text = S1;
					this.SB.Refresh();
					Application.DoEvents();
					if (S1.ToUpper().Equals(s2.ToUpper()))
					{
						if (HideArchived == true)
						{
							lbActiveFolder.Items.RemoveAt(I);
						}
						else
						{
							//lbActiveFolder.SetSelected(j, True)
						}
						
						break;
					}
				}
			}
			this.SB.Text = "";
		}
		public void btnRefreshFolders_Click(System.Object sender, System.EventArgs e)
		{
			//btnValidateEntry.Visible = False
			AllEmailFoldersShowing = true;
			//ARCH.RegisterOutlookContainers()
			
			this.Cursor = Cursors.AppStarting;
			
			ParentFolder = cbParentFolders.Text;
			
			if (ParentFolder.Trim().Length == 0)
			{
				MessageBox.Show("Please select an Outlook Folder to process.");
				return;
			}
			
			isOutlookAvail = ARCH.getOutlookFolderNames(ParentFolder, ref lbActiveFolder);
			
			if (isOutlookAvail == false)
			{
				ckDisableOutlookEmailArchive.Checked = true;
				//gbEmail.Enabled = False
			}
			if (isOutlookAvail == false)
			{
				SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL.";
			}
			
			
			RemoveAlreadyArchived(ParentFolder, ckDoNotShowArchived.Checked);
			
			DB.CleanUpEmailFolders();
			
			//btnDeleteEmailEntry.Enabled = False
			this.Cursor = Cursors.Default;
		}
		
		public void btnActive_Click(System.Object sender, System.EventArgs e)
		{
			AllEmailFoldersShowing = false;
			ParentFolder = cbParentFolders.Text;
			
			if (ParentFolder.Trim().Length == 0)
			{
				MessageBox.Show("Please select an Outlook Folder to process.");
				return;
			}
			this.Cursor = Cursors.AppStarting;
			
			DB.GetActiveEmailFolders(ParentFolder, lbActiveFolder, modGlobals.gCurrUserGuidID, modGlobals.CF, ArchivedEmailFolders);
			btnDeleteEmailEntry.Enabled = true;
			
			DB.CleanUpEmailFolders();
			
			this.Cursor = Cursors.Default;
			
		}
		public void VerifyEmailFolderExists(string ContainerName, string FolderName)
		{
			this.Cursor = Cursors.AppStarting;
			int i = EMF.cnt_IDX_FolderName(ContainerName, FolderName, modGlobals.gCurrUserGuidID);
			if (i == 0)
			{
				ARCH.getOutlookFolderNames(ParentFolder);
			}
			this.Cursor = Cursors.Default;
		}
		public void btnSaveConditions_Click(System.Object sender, System.EventArgs e)
		{
			
			string RetentionCode = cbEmailRetention.Text;
			if (RetentionCode.Length == 0)
			{
				cbEmailRetention.Text = DB.getRetentionPeriodMax();
				RetentionCode = cbEmailRetention.Text;
			}
			
			if (cbParentFolders.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please select a Parent Folder");
				return;
			}
			
			if (! ckArchiveFolder.Checked)
			{
				MessageBox.Show("The Archive Email folder was not checked, please take note...");
				//ckArchiveFolder.Checked = True
			}
			
			int RetentionYears = 0;
			RetentionYears = DB.getRetentionPeriod(RetentionCode);
			
			try
			{
				this.Cursor = Cursors.AppStarting;
				string ContainerName = "";
				foreach (string sFolderName in lbActiveFolder.SelectedItems)
				{
					
					string FolderName = sFolderName.ToString();
					FQNFolder = ParentFolder + "|" + FolderName;
					
					ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder);
					FolderName = UTIL.RemoveSingleQuotes(FolderName);
					FQNFolder = UTIL.RemoveSingleQuotes(FQNFolder);
					
					//ContainerName  = cbParentFolders.Text
					ContainerName = ParentFolder;
					
					//Dim EDIR As New clsEMAILFOLDER
					//EDIR.cnt_IDX_FolderName(FolderName , gCurrUserGuidID)
					//EDIR = Nothing
					
					string[] aParms = new string[1];
					
					EMPARMS.setFoldername(ref FQNFolder);
					EMPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					
					if (ckArchiveRead.Checked)
					{
						EMPARMS.setArchiveonlyifread("Y");
					}
					else
					{
						EMPARMS.setArchiveonlyifread("N");
					}
					
					if (ckArchiveFolder.Checked)
					{
						EMPARMS.setArchiveemails("Y");
						DB.SetFolderAsActive(FolderName, "Y");
					}
					else
					{
						EMPARMS.setArchiveemails("N");
						DB.SetFolderAsActive(FolderName.Trim(), "N");
					}
					
					if (ckRemoveAfterXDays.Checked)
					{
						EMPARMS.setRemoveafterxdays("Y");
						EMPARMS.setRemovexdays(NumericUpDown3.Value.ToString());
					}
					else
					{
						EMPARMS.setRemoveafterxdays("N");
						EMPARMS.setRemovexdays("0");
					}
					if (ckSystemFolder.Checked)
					{
						string msg = "This folder will become mandatory for everyone, are you sure?";
						DialogResult dlgRes = MessageBox.Show(msg, "Mandatory Folder", MessageBoxButtons.YesNo);
						if (dlgRes == System.Windows.Forms.DialogResult.No)
						{
							return;
						}
						EMPARMS.setIsSysDefault("1");
					}
					else
					{
						EMPARMS.setIsSysDefault("0");
					}
					
					if (cbEmailDB.Text.Trim() == "")
					{
						cbEmailDB.Text = "ECMREPO";
					}
					EMPARMS.setDb_id(cbEmailDB.Text.Trim());
					
					//xavier
					bool B = DB.ckFolderExists(ContainerName, modGlobals.gCurrUserGuidID, FQNFolder);
					
					//For iCnt As Integer = 0 To CF.Count - 1
					//    Dim SS  = CF.Keys(iCnt).ToString
					//    Console.WriteLine(SS)
					//Next
					if (! B)
					{
						
						int iFolder = EMF.cnt_IDX_FolderName(ContainerName, FQNFolder, modGlobals.gCurrUserGuidID);
						if (iFolder == 0)
						{
							Console.WriteLine("Folder " + FQNFolder + " does not exist.");
						}
						
						EMPARMS.Insert(ContainerName);
						
						string WhereClause = "Where ContainerName = \'" + ContainerName + "\' and [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FolderName] = \'" + FQNFolder + "\' ";
						EMPARMS.Update(WhereClause);
						
						if (isAdmin == true)
						{
							string S = "";
							if (ckSystemFolder.Checked == true)
							{
								S = "update [EmailFolder]";
								S = S + " set isSysDefault = 1";
								S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							}
							else
							{
								S = "update [EmailFolder]";
								S = S + " set isSysDefault = 0";
								S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							}
							
							bool BB = DB.ExecuteSqlNewConn(S, false);
							if (! BB)
							{
								Debug.Print("Failed to update isSysDefault");
							}
						}
						
						if (ckArchiveFolder.Checked)
						{
							string S = "update [EmailFolder]";
							S = S + " set SelectedForArchive = \'Y\' ";
							S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							bool BB = DB.ExecuteSqlNewConn(S, false);
							if (! BB)
							{
								Debug.Print("Failed to update isSysDefault");
							}
						}
						else
						{
							string S = "update [EmailFolder]";
							S = S + " set SelectedForArchive = \'N\' ";
							S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							bool BB = DB.ExecuteSqlNewConn(S, false);
							if (! BB)
							{
								Debug.Print("Failed to update isSysDefault");
							}
						}
						
					}
					else
					{
						string WhereClause = "Where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FolderName] = \'" + FQNFolder + "\'";
						EMPARMS.Update(WhereClause);
						
						if (isAdmin == true)
						{
							string S = "";
							if (ckSystemFolder.Checked == true)
							{
								S = "update [EmailFolder]";
								S = S + " set isSysDefault = 1";
								//S  = S  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
								S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							}
							else
							{
								S = "update [EmailFolder]";
								S = S + " set isSysDefault = 0";
								//S  = S  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
								S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							}
							bool BB = DB.ExecuteSqlNewConn(S, false);
							if (! BB)
							{
								LOG.WriteToArchiveLog("Notice: frmReconMain:btnSaveConditions: 23.441 - 100 Failed to update isSysDefault");
							}
						}
						
						if (ckArchiveFolder.Checked)
						{
							string S = "update [EmailFolder]";
							S = S + " set SelectedForArchive = \'Y\' ";
							S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							bool BB = DB.ExecuteSqlNewConn(S, false);
							if (! BB)
							{
								Debug.Print("Failed to update isSysDefault");
							}
						}
						else
						{
							string S = "update [EmailFolder]";
							S = S + " set SelectedForArchive = \'N\' ";
							S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
							bool BB = DB.ExecuteSqlNewConn(S, false);
							if (! BB)
							{
								Debug.Print("Failed to update isSysDefault");
							}
						}
						
					}
SKIPFOLDER:
					string xSql = "";
					xSql = "update [EmailFolder] ";
					xSql = xSql + " set RetentionCode = \'" + RetentionCode + "\' ";
					//xSql  = xSql  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
					xSql = xSql + " where userid = \'" + modGlobals.gCurrUserGuidID + "\' and foldername = \'" + FQNFolder + "\'";
					bool BB1 = DB.ExecuteSqlNewConn(xSql, false);
					if (! BB1)
					{
						LOG.WriteToArchiveLog("Notice: frmReconMain:btnSaveConditions: 23.441 - 200 Failed to update RetentionCode");
					}
					
					SB.Text = FolderName + " activated.";
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 195-43.2 frmReconMain:btnSaveConditions_Click - " + ex.Message));
			}
			
			DB.CleanUpEmailFolders();
			
			this.Cursor = Cursors.Default;
			
			
		}
		
		public void btnSelDir_Click(System.Object sender, System.EventArgs e)
		{
			
			if (cbRetention.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please select a retention policy to apply to this directory before adding it to the system.");
				return;
			}
			
			string tDir = "";
			
			if (CurrentDirectory.Length > 0)
			{
				FolderBrowserDialog1.SelectedPath = CurrentDirectory;
			}
			
			FolderBrowserDialog1.ShowDialog();
			if (FolderBrowserDialog1.SelectedPath.Length > 0)
			{
				tDir = FolderBrowserDialog1.SelectedPath;
				CurrentDirectory = FolderBrowserDialog1.SelectedPath;
			}
			else
			{
				tDir = "";
			}
			if (tDir.Length == 0)
			{
				SB.Text = "Action cancelled.";
				return;
			}
			
			this.txtDir.Text = tDir;
			
			btnAddDir_Click(null, null);
			
			this.Cursor = System.Windows.Forms.Cursors.Default;
			SB.Text = "Directory added with default archive settings. Change as you wish and update.";
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void GroupBox2_Enter(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void btnAddFiletype_Click(System.Object sender, System.EventArgs e)
		{
			if (! DB.isAdmin(modGlobals.gCurrUserGuidID))
			{
				DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			
			string FileExt = this.cbFileTypes.Text.Trim();
			
			if (FileExt.IndexOf(".") + 1 == 0)
			{
				FileExt = (string) ("." + FileExt);
			}
			
			bool B = DB.ckExtExists(FileExt);
			
			DB.delSecondarySOURCETYPE(FileExt);
			DB.AddSecondarySOURCETYPE(FileExt, "Added by user", "0", "1");
			
			
			if (B)
			{
				SB.Text = "Extension already defined to system.";
			}
			else
			{
				AVL.setExtcode(ref FileExt);
				AVL.Insert();
				DB.LoadAvailFileTypes(cbFileTypes);
				DB.LoadAvailFileTypes(cbPocessType);
				DB.LoadAvailFileTypes(cbAsType);
				DB.LoadAvailFileTypes(lbAvailExts);
			}
			
		}
		
		public void ckRemoveAfterDays_Click(System.Object sender, System.EventArgs e)
		{
			if (! DB.isAdmin(modGlobals.gCurrUserGuidID))
			{
				DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			
			//select count(*) from  [DataSource] where [SourceTypeCode] = 'YYYY' and [DataSourceOwnerUserID] = 'XXX'
			string FileExt = this.cbFileTypes.Text.Trim();
			
			bool B = DB.iCount("DataSource", "where [SourceTypeCode] = \'" + FileExt + "\' and [DataSourceOwnerUserID] = \'" + modGlobals.gCurrUserGuidID + "\'");
			
			if (B)
			{
				MessageBox.Show("Cannot remove filetype " + FileExt + ". There are files of that type in the repository.");
				return;
			}
			
			
			AVL.setExtcode(ref FileExt);
			AVL.Delete("Where ExtCode = \'" + FileExt + "\'");
			
			DB.delSecondarySOURCETYPE(FileExt);
			
			DB.LoadAvailFileTypes(cbFileTypes);
			DB.LoadAvailFileTypes(cbPocessType);
			DB.LoadAvailFileTypes(cbAsType);
			DB.LoadAvailFileTypes(lbAvailExts);
		}
		
		
		
		public void Button1_Click(System.Object sender, System.EventArgs e)
		{
			if (! DB.isAdmin(modGlobals.gCurrUserGuidID))
			{
				DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			string ParentFT = cbPocessType.Text;
			string ChildFT = cbAsType.Text;
			SB.Text = AP.SaveNewAssociations(ParentFT, ChildFT);
			DB.GetProcessAsList(cbProcessAsList);
		}
		
		private void ckIncludeAllTypes_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			int iCnt = lbArchiveDirs.SelectedItems.Count;
			if (iCnt <= 0)
			{
				MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.");
				return;
			}
			//If ckIncludeAllTypes.Checked Then
			//    Me.lbIncludeExts.Items.Clear()
			//    For i As Integer = 0 To lbAvailExts.Items.Count - 1
			//        Dim S  = Me.lbAvailExts.Items(i).ToString
			//        lbIncludeExts.Items.Add(S)
			//    Next
			//End If
		}
		
		public void lbArchiveDirs_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if (e.Button == MouseButtons.Right)
			{
				int iCnt = lbArchiveDirs.SelectedItems.Count;
				if (iCnt == 0)
				{
					MessageBox.Show("You must select a Directory first... aborting");
					return;
				}
				string FolderName = this.lbArchiveDirs.SelectedItem.ToString();
				FolderName = UTIL.RemoveSingleQuotes(FolderName);
				if (e.Button == MouseButtons.Right)
				{
					frmLibraryAssignment.Default.setFolderName(FolderName);
					frmLibraryAssignment.Default.SetTypeContent(true);
					frmLibraryAssignment.Default.ShowDialog();
				}
			}
		}
		
		public void ListBox2_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			
			if (bApplyingDirParms == true)
			{
				return;
			}
			
			int I = lbArchiveDirs.SelectedItems.Count;
			if (I == 0)
			{
				SB.Text = "You must select an item from the listbox...";
				return;
			}
			
			if (I != 1)
			{
				CkMonitor.Visible = false;
			}
			else
			{
				CkMonitor.Visible = true;
			}
			
			
			bActiveChange = true;
			
			string DirName = lbArchiveDirs.SelectedItem.ToString().Trim();
			this.txtDir.Text = DirName;
			//DB.LoadAvailFileTypes(lbAvailExts)
			string DBID = "";
			string IncludeSubDirs = "";
			string VersionFiles = "";
			string FolderDisabled = "";
			string isMetaData = "";
			string isPublic = "";
			string OcrDirectory = "";
			string OcrPdf = "";
			string isSysDefault = "";
			string DeleteOnArchive = "";
			
			DB.GetDirectoryData(modGlobals.gCurrUserGuidID, DirName, ref DBID, ref IncludeSubDirs, ref VersionFiles, ref FolderDisabled, ref isMetaData, ref isPublic, ref OcrDirectory, ref isSysDefault, this.ckArchiveBit.Checked, ListenForChanges, ref ListenDirectory, ref ListenSubDirectory, ref DirGuid, ref OcrPdf, ref DeleteOnArchive);
			
			cbFileDB.Text = DBID;
			ckSubDirs.Checked = cvtTF(IncludeSubDirs);
			this.ckVersionFiles.Checked = cvtTF(VersionFiles);
			this.ckDisableDir.Checked = cvtTF(FolderDisabled);
			
			DB.LoadIncludedFileTypes(lbIncludeExts, modGlobals.gCurrUserGuidID, DirName);
			DB.LoadExcludedFileTypes(this.lbExcludeExts, modGlobals.gCurrUserGuidID, DirName);
			
			if (DeleteOnArchive.Equals("Y"))
			{
				ckDeleteAfterArchive.Checked = true;
			}
			else
			{
				ckDeleteAfterArchive.Checked = false;
			}
			
			if (isSysDefault.ToUpper().Equals("TRUE"))
			{
				this.clAdminDir.Checked = true;
			}
			else
			{
				this.clAdminDir.Checked = false;
			}
			if (isMetaData == "Y")
			{
				this.ckMetaData.Checked = true;
			}
			else
			{
				this.ckMetaData.Checked = false;
			}
			if (IncludeSubDirs.Equals("Y"))
			{
				ckSubDirs.Checked = true;
			}
			else
			{
				ckSubDirs.Checked = false;
			}
			if (isPublic.Equals("Y"))
			{
				ckPublic.Checked = true;
			}
			else
			{
				ckPublic.Checked = false;
			}
			if (OcrDirectory.Equals("Y"))
			{
				this.ckOcr.Checked = true;
			}
			else
			{
				this.ckOcr.Checked = false;
			}
			
			if (OcrPdf.Equals("Y"))
			{
				this.ckOcrPdf.Checked = true;
				modGlobals.gPdfExtended = true;
			}
			else
			{
				this.ckOcrPdf.Checked = false;
				modGlobals.gPdfExtended = false;
			}
			
			bool bDisabled = DB.isDirAdminDisabled(modGlobals.gCurrUserGuidID, DirName);
			if (isAdmin == true && bDisabled == true)
			{
				SB.Text = "Directory disabled by Administrator, you are an ADMIN, do what you like.";
				ckDisableDir.Enabled = true;
			}
			else if (isAdmin == false && bDisabled == true)
			{
				SB.Text = "Directory disabled by Administrator, please contact Admin.";
				ckDisableDir.Checked = true;
				ckDisableDir.Enabled = false;
			}
			else
			{
				ckDisableDir.Enabled = true;
				SB.Text = "";
			}
			
			if (ListenDirectory == true || ListenSubDirectory == true)
			{
				CkMonitor.Checked = true;
			}
			else
			{
				CkMonitor.Checked = false;
			}
			
			ShowSellectedLibs(DirName, "CONTENT");
			
			bActiveChange = false;
			
		}
		public void ShowSellectedLibs(string DirName, string TypeList)
		{
			
			if (ckShowLibs.Checked)
			{
				
				frmLibraryAssgnList.Default.LIbraryName = DirName;
				DB.GetListOfAssignedLibraries(DirName, TypeList, AssignedLibraries);
				frmLibraryAssgnList.Default.lbLibraries.Items.Clear();
				frmLibraryAssgnList.Default.lbLibraries.Refresh();
				frmLibraryAssgnList.Default.Refresh();
				Application.DoEvents();
				for (int iList = 0; iList <= AssignedLibraries.Count - 1; iList++)
				{
					frmLibraryAssgnList.Default.lbLibraries.Items.Add(AssignedLibraries(iList));
				}
				frmLibraryAssgnList.Default.Visible = true;
			}
			else
			{
				frmLibraryAssgnList.Default.Visible = false;
			}
			
		}
		public void lbIncludeExts_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			if (bApplyingDirParms == true)
			{
				return;
			}
			
			try
			{
				string SelectedFileType = lbIncludeExts.SelectedItem.ToString();
				INL.setUserid(modGlobals.gCurrUserGuidID);
				INL.setFqn(this.lbArchiveDirs.SelectedItem.ToString());
				INL.setExtcode(SelectedFileType);
				//INL.Delete("where UserID = '" + gCurrUserGuidID + "' and FQN = '" + Me.lbArchiveDirs.SelectedItem.ToString + "' and Extcode = '" + SelectedFileType  + "' ")
			}
			catch (Exception)
			{
				SB.Text = "Both a directory and the Included File Type must be selected...";
			}
			
		}
		
		public void Button3_Click(System.Object sender, System.EventArgs e)
		{
			SB.Text = "Profile maintenance selected, will not affect directory setup.";
			for (int i = lbIncludeExts.SelectedItems.Count; i >= 0; i--)
			{
				int II = lbIncludeExts.SelectedIndex;
				if (II >= 0)
				{
					lbIncludeExts.Items.RemoveAt(II);
				}
			}
			
			this.SB.Text = "Removed Items";
			
			btnSaveChanges.BackColor = Color.OrangeRed;
			
		}
		private void AddInitialDB()
		{
			
			int II = DB.getTableCount("Databases");
			
			if (II > 0)
			{
				return;
			}
			
			string S = "";
			S = S + " INSERT INTO [Databases]";
			S = S + " ([DB_ID]";
			S = S + " ,[DB_CONN_STR])";
			S = S + " VALUES";
			S = S + " (\'DMA.UD\'";
			S = S + " ,\'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True\')";
			try
			{
				bool b = DB.ExecuteSqlNewConn(S, false);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR 219.23.4: Call Administrator" + "\r\n" + ex.Message));
			}
			
			S = "";
			S = S + " INSERT INTO [Databases]";
			S = S + " ([DB_ID]";
			S = S + " ,[DB_CONN_STR])";
			S = S + " VALUES";
			S = S + " (\'ECMREPO\'";
			S = S + " ,\'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True\')";
			try
			{
				bool b = DB.ExecuteSqlNewConn(S, false);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR 219.23.4: Call Administrator" + "\r\n" + ex.Message));
			}
			
			S = "";
			S = S + " INSERT INTO [Databases]";
			S = S + " ([DB_ID]";
			S = S + " ,[DB_CONN_STR])";
			S = S + " VALUES";
			S = S + " (\'ECMREPO\'";
			S = S + " ,\'Data Source=<your source name here>;Initial Catalog=ECM.Library;Integrated Security=True\')";
			try
			{
				bool b = DB.ExecuteSqlNewConn(S, false);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR 219.23.4: Call Administrator" + "\r\n" + ex.Message));
			}
			
		}
		private void AddInitialEmailFolder(string ContainerName, string FolderName)
		{
			
			AddInitialDB();
			
			this.Cursor = Cursors.AppStarting;
			string[] aParms = new string[1];
			
			//PARMS.EmailFolderName  = FolderName
			EMPARMS.setFoldername(ref FolderName);
			EMPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
			EMPARMS.setArchiveemails("Y");
			EMPARMS.setRemoveafterarchive("Y");
			EMPARMS.setSetasdefaultfolder("N");
			EMPARMS.setArchivexdays("N");
			EMPARMS.setArchivexdays("0");
			EMPARMS.setRemoveafterarchive("N");
			EMPARMS.setRemovexdays("0");
			EMPARMS.setDb_id(ref modGlobals.CurrDbName);
			EMPARMS.Insert(ContainerName);
			
			
			this.Cursor = Cursors.Default;
		}
		
		private void ckRunAtStartup_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (formloaded == false)
			{
				return;
			}
			
			this.saveStartUpParms();
			try
			{
				string aPath = "";
				
				aPath = System.Reflection.Assembly.GetExecutingAssembly().Location;
				
				bool RunAtStart = false;
				//If ckRunAtStartup.Checked Then
				//    RunAtStart = True
				//End If
				
				if (RunAtStart)
				{
					RegistryKey oReg = Registry.CurrentUser;
					//Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
					RegistryKey oKey = oReg.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
					
					string SS = oKey.GetValue("EcmLibrary").ToString();
					
					oKey.CreateSubKey("EcmLibrary");
					oKey.SetValue("EcmLibrary", aPath);
					
					SS = oKey.GetValue("EcmLibrary").ToString();
					
					oKey.Close();
				}
				else
				{
					
					//Registry.CurrentUser.DeleteSubKey("Software\Microsoft\Windows\CurrentVersion\Run\EcmLibrary")
					
					RegistryKey oReg = Registry.CurrentUser;
					RegistryKey oKey = oReg.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
					oKey.CreateSubKey("EcmLibrary");
					oKey.SetValue("EcmLibrary", "X");
					
					string SS = oKey.GetValue("EcmLibrary").ToString();
					oKey.DeleteSubKey("EcmLibrary");
					SS = oKey.GetValue("EcmLibrary").ToString();
					
					oKey.Close();
				}
				
				//messagebox.show("Load at startup set to " + ckRunAtStartup.Checked.ToString)
				
				saveStartUpParms();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Failed to set start up parameter." + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter." + "\r\n" + ex.Message));
			}
			
		}
		
		public void ckDisable_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (formloaded == false)
			{
				return;
			}
			
			//formloaded = False
			//Me.saveStartUpParms()
			//formloaded = True
			saveStartUpParms();
			SB.Text = (string) ("Disabled set to " + ckDisable.Checked.ToString());
		}
		public void GetExecParms()
		{
			
			string ArchiveType = "";
			ArchiveType = DB.getRconParm(modGlobals.gCurrUserGuidID, "ArchiveType");
			//If ArchiveType .Length > 0 Then
			//    cbInterval.Text = ArchiveType
			//Else
			//    cbInterval.Text = ""
			//End If
			
			string C = "";
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "ArchiveInterval");
			//If C.Length > 0 Then
			//    cbTimeUnit.Text = C
			//Else
			//    cbTimeUnit.Text = "5"
			//End If
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "LoadAtStartup");
			//If C.Length > 0 Then
			//    If C.Equals("True") Then
			//        ckRunAtStartup.Checked = True
			//    Else
			//        ckRunAtStartup.Checked = False
			//    End If
			//Else
			//    ckRunAtStartup.Checked = False
			//End If
			
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "Disabled");
			if (C.Length > 0)
			{
				if (C.Equals("True"))
				{
					ckDisable.Checked = true;
				}
				else
				{
					ckDisable.Checked = false;
				}
			}
			else
			{
				ckDisable.Checked = false;
			}
			
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "ContentDisabled");
			if (C.ToUpper().Equals("TRUE"))
			{
				this.ckDisableContentArchive.Checked = true;
			}
			else
			{
				this.ckDisableContentArchive.Checked = false;
			}
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "OutlookDisabled");
			if (C.ToUpper().Equals("TRUE"))
			{
				this.ckDisableOutlookEmailArchive.Checked = true;
			}
			else
			{
				this.ckDisableOutlookEmailArchive.Checked = false;
			}
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "ExchangeDisabled");
			if (C.ToUpper().Equals("TRUE"))
			{
				this.ckDisableExchange.Checked = true;
			}
			else
			{
				this.ckDisableExchange.Checked = false;
			}
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "RssPullDisabled");
			if (C.ToUpper().Equals("TRUE"))
			{
				this.ckRssPullDisabled.Checked = true;
			}
			else
			{
				this.ckRssPullDisabled.Checked = false;
			}
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "WebPageTrackerDisabled");
			if (C.ToUpper().Equals("TRUE"))
			{
				this.ckWebPageTrackerDisabled.Checked = true;
			}
			else
			{
				this.ckWebPageTrackerDisabled.Checked = false;
			}
			C = DB.getRconParm(modGlobals.gCurrUserGuidID, "WebSiteTrackerDisabled");
			if (C.ToUpper().Equals("TRUE"))
			{
				this.ckWebSiteTrackerDisabled.Checked = true;
			}
			else
			{
				this.ckWebSiteTrackerDisabled.Checked = false;
			}
			
		}
		
		private void SenderMgtToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmSenderMgt.Default.Show();
		}
		public void IncludeDirectory(string DirFqn)
		{
			
			ckSubDirs.Checked = true;
			//ckOcr.Checked = True
			ckVersionFiles.Checked = true;
			
			try
			{
				if (cbRetention.Text.Trim().Length == 0)
				{
					MessageBox.Show("Please select a retention policy to apply to this directory before adding it to the system.");
					return;
				}
				
				PBx.Minimum = 0;
				PBx.Maximum = 10;
				
				string RetentionCode = cbRetention.Text.Trim();
				
				try
				{
					this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
					
					
					SB.Text = "Beginning Include";
					
					try
					{
						PBx.Value = 1;
					}
					catch (Exception)
					{
						
					}
					
					string FQN = txtDir.Text.Trim();
					FQN = UTIL.RemoveSingleQuotes(FQN);
					txtDir.Text = FQN;
					
					string DBID = cbFileDB.Text.Trim();
					
					string getMetaData = "N";
					if (ckMetaData.Checked)
					{
						getMetaData = "Y";
					}
					
					string OcrDirectory = "N";
					if (ckOcr.Checked)
					{
						OcrDirectory = "Y";
					}
					else
					{
						OcrDirectory = "N";
					}
					
					lbIncludeExts.Items.Clear();
					lbExcludeExts.Items.Clear();
					AuthorizedFileTypes.Clear();
					UnAuthorizedFileTypes.Clear();
					
					SB.Text = "Adding directory";
					string SUBDIR = cvtCkBox(ckSubDirs);
					string VersionFiles = cvtCkBox(this.ckVersionFiles);
					int I = 0;
					
					SB.Text = "Adding Included File Types";
					
					try
					{
						PBx.Value = 2;
					}
					catch (Exception)
					{
						
					}
					
					AuthorizedFileTypes.Clear();
					if (lbIncludeExts.Items.Count)
					{
						for (I = 0; I <= lbIncludeExts.Items.Count - 1; I++)
						{
							string InclExt = lbIncludeExts.Items[I].ToString();
							AuthorizedFileTypes.Add(InclExt);
						}
					}
					
					//UnAuthorizedFileTypes.Clear()
					//If lbExcludeExts.Items.Count > 0 Then
					//    For I = 0 To Me.lbExcludeExts.Items.Count - 1
					//        Dim InclExt  = Me.lbExcludeExts.Items(I).ToString
					//        UnAuthorizedFileTypes.Add(InclExt )
					//    Next
					//End If
					
					bool BB = DB.ckDirectoryExists(modGlobals.gCurrUserGuidID, FQN);
					if (BB)
					{
						MessageBox.Show("Directory already defined to system, you must SAVE the new setup.");
						SB.Text = "Directory already defined to system, you must SAVE the new setup.";
					}
					else
					{
						IncludeListHasChanged = true;
						DIRS.setDb_id(ref DBID);
						DIRS.setFqn(ref FQN);
						DIRS.setIncludesubdirs(ref SUBDIR);
						DIRS.setVersionfiles(ref VersionFiles);
						DIRS.setUserid(ref modGlobals.gCurrUserGuidID);
						DIRS.setCkmetadata(ref getMetaData);
						DIRS.setQuickRefEntry("0");
						DIRS.setOcrDirectory(ref OcrDirectory);
						
						DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString());
						
						DIRS.Insert();
						
						//**************************************************************************************************************
						//AddSubDirs(FQN , ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory , clAdminDir.Checked, RetentionCode )
						//**************************************************************************************************************
						
						string FileExt = "";
						
						SB.Text = "Adding Included File Types";
						
						try
						{
							PBx.Value = 4;
						}
						catch (Exception)
						{
							
						}
						
						for (I = 0; I <= AuthorizedFileTypes.Count - 1; I++)
						{
							FileExt = AuthorizedFileTypes[I].ToString();
							SB.Text = (string) ("Including File Type: " + FileExt);
							FQN = UTIL.RemoveSingleQuotes(FQN);
							bool b = INL.DeleteExisting(modGlobals.gCurrUserGuidID, FQN);
							b = InclAddList(lbIncludeExts, modGlobals.gCurrUserGuidID, FQN);
							Application.DoEvents();
						}
						
						SB.Text = "Fetching Directories";
						
						try
						{
							PBx.Value = 7;
						}
						catch (Exception)
						{
							
						}
						
						DB.GetDirectories(lbArchiveDirs, modGlobals.gCurrUserGuidID, false);
						
						SB.Text = "Fetching Included Files";
						
						try
						{
							PBx.Value = 9;
						}
						catch (Exception)
						{
							
						}
						
						DB.GetIncludedFiles(lbIncludeExts, modGlobals.gCurrUserGuidID, FQN);
						
						if (isAdmin == true)
						{
							string S = "";
							if (clAdminDir.Checked == true)
							{
								if (ckSubDirs.Checked == true)
								{
									S = "update [Directory] set [isSysDefault] = 1 where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FQN] like \'" + FQN + "%\'";
								}
								else
								{
									S = "update [Directory] set [isSysDefault] = 1 where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FQN] like \'" + FQN + "\'";
								}
							}
							else
							{
								if (ckSubDirs.Checked == true)
								{
									S = "update [Directory] set [isSysDefault] = 0  where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FQN] like \'" + FQN + "%\'";
								}
								else
								{
									S = "update [Directory] set [isSysDefault] = 0  where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FQN] like \'" + FQN + "\'";
								}
							}
							bool BBB = DB.ExecuteSqlNewConn(S, false);
							if (! BBB)
							{
								Debug.Print("Failed to update isSysDefault");
							}
						}
						SB.Text = "Directory added.";
						
						//Dim Msg2  = "Please remember, your next step is to set the archive parameters " + vbCrLf
						//Msg2 += "and press the Save Changes button to activate this directory." + vbCrLf + vbCrLf
						//'Msg2 += "Once content is archived, parameter changes CANNOT be updated from this screen." + vbCrLf
						//'Msg2 += "This includes metadata, OCR this directory and public access."
						//messagebox.show(Msg2, MsgBoxStyle.Exclamation)
						
						this.Cursor = System.Windows.Forms.Cursors.Default;
						IncludeListHasChanged = false;
					}
					this.PBx.Value = 0;
				}
				catch (Exception ex)
				{
					SB.Text = "Error: please review trace log last entry. (Trace Log Icon in main screen)";
					LOG.WriteToArchiveLog((string) ("frmReconMain:btnAddDir_Click: " + ex.Message));
				}
				this.Cursor = System.Windows.Forms.Cursors.Default;
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("ERROR IncludeDirectory 144.23.11: Failed to add directories.");
			}
		}
		public void btnAddDir_Click(System.Object sender, System.EventArgs e)
		{
			
			string DirFQN = txtDir.Text.Trim();
			IncludeDirectory(DirFQN);
			
		}
		public void AddSubDirs(string FQN, bool isPublic, bool isEnabled, string OcrDirectory, bool clAdminDir, string RetentionCode)
		{
			string PublicFlag = "";
			string DirEnabled = "";
			if (isPublic)
			{
				PublicFlag = "Y";
			}
			else
			{
				PublicFlag = "N";
			}
			if (isEnabled)
			{
				DirEnabled = "Y";
			}
			else
			{
				DirEnabled = "N";
			}
			
			if (clAdminDir)
			{
				clAdminDir = true;
			}
			else
			{
				clAdminDir = false;
			}
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			SubDirectories.Clear();
			if (this.ckSubDirs.Checked == true)
			{
				string[] A = new string[1];
				bool SubDirFound = DMA.RecursiveSearch(FQN, ref A);
				if (SubDirFound)
				{
					DB.delSubDirs(modGlobals.gCurrUserGuidID, FQN);
					string tFqn = FQN;
					SUBDIRECTORY.setUserid(ref modGlobals.gCurrUserGuidID);
					SUBDIRECTORY.setFqn(ref FQN);
					SUBDIRECTORY.setSubfqn(ref tFqn);
					SUBDIRECTORY.setCkpublic(ref PublicFlag);
					SUBDIRECTORY.setCkdisabledir(ref DirEnabled);
					SUBDIRECTORY.setOcrDirectory(ref OcrDirectory);
					SUBDIRECTORY.Insert();
					
					SB2.Text = FQN;
					SB2.Refresh();
					Application.DoEvents();
					
					int IntClAdminDir = 0;
					
					if (clAdminDir == true)
					{
						IntClAdminDir = 1;
					}
					
					string S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString() + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + FQN + "\' and [SUBFQN] = \'" + tFqn + "\' ";
					DB.ExecuteSqlNewConn(S, false);
					
					S = "Update SubDir set RetentionCode = \'" + RetentionCode + "\' where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + FQN + "\' and [SUBFQN] = \'" + tFqn + "\' ";
					DB.ExecuteSqlNewConn(S, false);
					
					AuthorizedFileTypes.Add(tFqn);
					UnAuthorizedFileTypes.Add(tFqn);
					int iObj = SubDirectories.Count;
					this.PBx.Value = 0;
					this.PBx.Maximum = iObj + 2;
					iObj = 0;
					foreach (object O in SubDirectories)
					{
						tFqn = O.ToString().Trim();
						SUBDIRECTORY.setUserid(ref modGlobals.gCurrUserGuidID);
						SUBDIRECTORY.setFqn(ref FQN);
						SUBDIRECTORY.setSubfqn(ref tFqn);
						SUBDIRECTORY.setCkpublic(ref PublicFlag);
						SUBDIRECTORY.setOcrDirectory(ref OcrDirectory);
						SUBDIRECTORY.Insert();
						
						S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString() + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + FQN + "\' and [SUBFQN] = \'" + tFqn + "\' ";
						DB.ExecuteSqlNewConn(S, false);
						
						S = "Update SubDir set RetentionCode = \'" + RetentionCode + "\' where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + FQN + "\' and [SUBFQN] = \'" + tFqn + "\' ";
						DB.ExecuteSqlNewConn(S, false);
						
						AuthorizedFileTypes.Add(tFqn);
						UnAuthorizedFileTypes.Add(tFqn);
						iObj++;
						
						SB2.Text = FQN + ":" + iObj.ToString();
						SB2.Refresh();
						Application.DoEvents();
						
						if (iObj <= SubDirectories.Count)
						{
							this.PBx.Value = iObj;
							this.PBx.Refresh();
						}
						
						Application.DoEvents();
					}
					this.PBx.Value = 0;
				}
				else
				{
					int IntClAdminDir = 0;
					
					if (clAdminDir == true)
					{
						IntClAdminDir = 1;
					}
					DB.delSubDirs(modGlobals.gCurrUserGuidID, FQN);
					string tFqn = FQN;
					SUBDIRECTORY.setUserid(ref modGlobals.gCurrUserGuidID);
					SUBDIRECTORY.setFqn(ref FQN);
					SUBDIRECTORY.setSubfqn(ref tFqn);
					SUBDIRECTORY.setCkpublic(ref PublicFlag);
					SUBDIRECTORY.setOcrDirectory(ref OcrDirectory);
					SUBDIRECTORY.Insert();
					
					string S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString() + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + FQN + "\' and [SUBFQN] = \'" + tFqn + "\' ";
					DB.ExecuteSqlNewConn(S, false);
					
					AuthorizedFileTypes.Add(tFqn);
					UnAuthorizedFileTypes.Add(tFqn);
				}
			}
			
			SB.Text = "";
			SB.Refresh();
			Application.DoEvents();
			
		}
		public void addSubDirs(string FQN, List<string> LB)
		{
			LB.Clear();
			FQN = UTIL.RemoveSingleQuotes(FQN);
			LB.Add(FQN);
			
			if (this.ckSubDirs.Checked == true)
			{
				string[] A = new string[1];
				bool SubDirFound = DMA.RecursiveSearch(FQN, ref A);
				if (SubDirFound)
				{
					string tFqn = FQN;
					LB.Add(tFqn);
					for (int i = 0; i <= (A.Length - 1); i++)
					{
						if (A[i] == null)
						{
						}
						else
						{
							tFqn = A[i].ToString();
							LB.Add(tFqn);
						}
					}
				}
				else
				{
					string tFqn = FQN;
					LB.Add(tFqn);
				}
			}
		}
		public void Button6_Click(System.Object sender, System.EventArgs e)
		{
			string FQN = txtDir.Text.Trim();
			
			if (ckArchiveBit.Checked)
			{
				string tMsg = "";
				tMsg = tMsg + "WARNING! Skip if ARCHIVE bit set a HIGH RISK function." + "\r\n";
				tMsg = tMsg + "ECM Library is not responsible for selecting to use it." + "\r\n";
				tMsg = tMsg + "The file archive bit is a complex and ECM Library is not responsible for " + "\r\n";
				tMsg = tMsg + "missed, skipped, or any other content related mishap due to " + "\r\n";
				tMsg = tMsg + "this function being selected. " + "\r\n" + "\r\n";
				tMsg = tMsg + "YOU UNDERSTAND AND FULLY ACCEPT THE RISK IN CHOOSING " + "\r\n";
				tMsg = tMsg + "TO SKIP CONTENT BASED ON THE ARCHIVE BIT. " + "\r\n" + "\r\n";
				tMsg = tMsg + "Selecting the \'Skip If Archive Bit off\' check box exposes the " + "\r\n";
				tMsg = tMsg + "archive to great risk. " + "\r\n";
				tMsg = tMsg + "By agreeing to this disclaimer, you accept fully all the risk " + "\r\n";
				tMsg = tMsg + "associated with skipping content with the archive bit set ";
				tMsg = tMsg + "previously Archived.";
				DialogResult dlgRes = Interaction.MsgBox(tMsg, MsgBoxStyle.YesNo + MsgBoxStyle.Critical, "YOU ACCEPT ALL THE RISK!");
				if (dlgRes == System.Windows.Forms.DialogResult.No)
				{
					return;
				}
				
				tMsg = "Would you like to RESET all files\' archive bit in this directory to NEEDS archive?";
				dlgRes = Interaction.MsgBox(tMsg, MsgBoxStyle.YesNo + MsgBoxStyle.Critical, "THIS CAN TAKE A WHILE");
				if (dlgRes == System.Windows.Forms.DialogResult.No)
				{
					SB.Text = "Files Archive bit will be USED as is.";
				}
				else
				{
					SB.Text = "Standby - initializing all files archive bit to ON.";
					string tCmd = "";
					if (ckSubDirs.Checked)
					{
						tCmd = " " + FQN + "\\*.* +a /s";
						//System.Diagnostics.Process.Start("attrib.exe", tFQN )
						Process p = Process.Start("attrib.exe", tCmd);
						//p.WaitForExit()
					}
					else
					{
						tCmd = "attrib " + FQN + "\\*.* +a";
						Process p = Process.Start("attrib.exe", tCmd);
						//p.WaitForExit()
					}
				}
				
				SB.Text = " ";
			}
			
			btnSaveChanges.BackColor = Color.LightGray;
			
			string RetentionCode = cbRetention.Text;
			if (RetentionCode.Length == 0)
			{
				cbRetention.Text = DB.getRetentionPeriodMax();
				RetentionCode = cbRetention.Text;
			}
			
			int RetentionPeriod = 0;
			if (RetentionCode.Trim().Length == 0)
			{
				RetentionPeriod = 10;
			}
			RetentionPeriod = DB.getRetentionPeriod(RetentionCode);
			
			int iCnt = lbArchiveDirs.SelectedItems.Count;
			if (txtDir.Text.Length > 0)
			{
				SB.Text = (string) ("Updating " + txtDir.Text.Trim());
			}
			else if (iCnt <= 0)
			{
				MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.");
				return;
			}
			this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			txtDir.Text = FQN;
			//Dim DBID = cbFileDB.SelectedItem.ToString
			string DBID = "ECMREPO";
			string SUBDIR = cvtCkBox(ckSubDirs);
			
			string DeleteOnArchive = cvtCkBox(ckDeleteAfterArchive);
			
			string VersionFiles = cvtCkBox(this.ckVersionFiles);
			int I = 0;
			string DisableDir = "N";
			
			if (DBID.Length == 0)
			{
				MessageBox.Show("Please select a repository...");
				this.Cursor = System.Windows.Forms.Cursors.Default;
				return;
			}
			if (lbIncludeExts.Items.Count == 0)
			{
				MessageBox.Show("Please remember to include one or more filetypes in this archive...");
			}
			
			string OcrPdf = "N";
			if (ckOcrPdf.Checked)
			{
				OcrPdf = "Y";
				modGlobals.gPdfExtended = true;
			}
			else
			{
				OcrPdf = "N";
				modGlobals.gPdfExtended = false;
			}
			
			string OcrDirectory = "N";
			if (ckOcr.Checked)
			{
				OcrDirectory = "Y";
			}
			else
			{
				OcrDirectory = "N";
			}
			
			string getMetaData = "N";
			if (ckMetaData.Checked)
			{
				getMetaData = "Y";
			}
			
			string SetToPublic = "N";
			if (this.ckPublic.Checked)
			{
				SetToPublic = "Y";
				DB.AddSysMsg(FQN + " set to PUBLIC access.");
			}
			else
			{
				SetToPublic = "N";
				DB.AddSysMsg(FQN + " set to PRIVATE access.");
			}
			
			if (DB.isPublicAllowed() == false)
			{
				this.ckPublic.Checked = false;
				SetToPublic = "N";
			}
			
			if (ckDisableDir.Checked)
			{
				DisableDir = "Y";
			}
			else
			{
				DisableDir = "N";
			}
			
			bool BB = DB.ckDirectoryExists(modGlobals.gCurrUserGuidID, FQN);
			if (! BB)
			{
				MessageBox.Show("Directory IS NOT defined to system, adding it.");
				btnAddDir_Click(null, null);
			}
			else
			{
				DIRS.setDb_id(ref DBID);
				DIRS.setFqn(ref FQN);
				SUBDIR = UTIL.RemoveSingleQuotes(SUBDIR);
				DIRS.setIncludesubdirs(ref SUBDIR);
				DIRS.setUserid(ref modGlobals.gCurrUserGuidID);
				DIRS.setVersionfiles(ref VersionFiles);
				DIRS.setCkmetadata(ref getMetaData);
				DIRS.setCkpublic(ref SetToPublic);
				DIRS.setCkdisabledir(ref DisableDir);
				DIRS.setQuickRefEntry("0");
				DIRS.setOcrDirectory(ref OcrDirectory);
				DIRS.setSkipIfArchiveBit(ckArchiveBit.Checked.ToString());
				DIRS.setOcrPdf(ref OcrPdf);
				DIRS.setDeleteOnArchive(DeleteOnArchive);
				
				AuthorizedFileTypes.Clear();
				UnAuthorizedFileTypes.Clear();
				
				AuthorizedFileTypes.Add(FQN);
				UnAuthorizedFileTypes.Add(FQN);
				
				string WhereClause = "";
				if (ckOcr.Checked)
				{
					OcrDirectory = "Y";
				}
				else
				{
					OcrDirectory = "N";
				}
				
				if (SUBDIR.Equals("Y"))
				{
					//WhereClause  = "where UserID = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%\' and AdminDisabled <> 1 and ckDisableDir <> 'Y'"
					//DIRS.Update(WhereClause , OcrDirectory)
					
					WhereClause = "where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and [FQN] = \'" + FQN + "\'";
					DIRS.Update(WhereClause, OcrDirectory);
				}
				else
				{
					WhereClause = "where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and [FQN] = \'" + FQN + "\'";
					DIRS.Update(WhereClause, OcrDirectory);
				}
				
				if (clAdminDir.Checked)
				{
					string msg = "This Directory will become mandatory for everyone, are you sure?";
					DialogResult dlgRes = MessageBox.Show(msg, "Mandatory Directory", MessageBoxButtons.YesNo);
					if (dlgRes == System.Windows.Forms.DialogResult.No)
					{
						return;
					}
					string S = (string) ("Update Directory set isSysDefault = 1 " + WhereClause);
					bool bb1 = DB.ExecuteSqlNewConn(S, false);
					if (! bb1)
					{
						Console.WriteLine("Error 1994.23.1 - did not update isSysDefault");
					}
				}
				else
				{
					string S = (string) ("Update Directory set isSysDefault = 0 " + WhereClause);
					bool bb1 = DB.ExecuteSqlNewConn(S, false);
					if (! bb1)
					{
						Console.WriteLine("Error 1994.23.1 - did not update isSysDefault");
					}
				}
				
				string tSql1 = (string) ("Update Directory set RetentionCode = \'" + RetentionCode + "\' " + WhereClause);
				bool BB2 = DB.ExecuteSqlNewConn(tSql1, false);
				if (! BB2)
				{
					Console.WriteLine("Error 1994.23.1x - did not update RetentionCode");
				}
				
				this.SB.Text = "Step 1 of 4 standby...";
				DB.SetDocumentPublicFlagByOwnerDir(FQN, this.ckPublic.Checked, this.ckDisableDir.Checked, OcrDirectory);
				
				this.SB.Text = "Step 2 of 4 standby... ";
				//DB.SetDocumentPublicFlagByOwnerDir(FQN , Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory )
				
				this.SB.Text = "Step 3 of 4 standby...";
				
				string sSql = "delete from [IncludedFiles] where FQN = \'" + FQN + "\'";
				BB = DB.ExecuteSqlNewConn(sSql);
				
				this.PBx.Maximum = AuthorizedFileTypes.Count;
				this.PBx.Value = 0;
				for (I = 0; I <= AuthorizedFileTypes.Count - 1; I++)
				{
					FQN = AuthorizedFileTypes[I].ToString();
					bool b = INL.DeleteExisting(modGlobals.gCurrUserGuidID, FQN);
					b = InclAddList(lbIncludeExts, modGlobals.gCurrUserGuidID, FQN);
					if (! b)
					{
						if (! b)
						{
							DB.xTrace(87925, "FrmReconMain:btnSaveChanges:AddList", (string) ("Failed for: " + FQN + " : " + modGlobals.gCurrUserGuidID));
						}
					}
					
					if (I % 5 == 0)
					{
						this.SB.Text = (string) ("Processing SubDir: " + (I.ToString() + " of " + AuthorizedFileTypes.Count.ToString()));
					}
					this.PBx.Value = I;
					Application.DoEvents();
				}
				
				lbExcludeExts.Visible = false;
				lbIncludeExts.Visible = false;
				lbAvailExts.Visible = false;
				lbArchiveDirs.Enabled = false;
				this.PBx.Maximum = UnAuthorizedFileTypes.Count + 2;
				
				for (I = 0; I <= UnAuthorizedFileTypes.Count - 1; I++)
				{
					PBx.Value = I;
					PBx.Refresh();
					//If IncludeListHasChanged = False Then
					//    Exit For
					//End If
					FQN = UnAuthorizedFileTypes[I].ToString();
					bool b = this.EXL.DeleteExisting(modGlobals.gCurrUserGuidID, FQN);
					b = this.ExcludeAddList(this.lbExcludeExts, modGlobals.gCurrUserGuidID, FQN);
					if (! b)
					{
						if (! b)
						{
							DB.xTrace((int) 87925.22, "FrmReconMain:btnSaveChanges:AddList", (string) ("Failed for: " + FQN + " : " + modGlobals.gCurrUserGuidID));
						}
					}
					//** WDM DB.SetDocumentPublicFlag(gCurrUserGuidID, FQN , Me.ckPublic.Checked, Me.ckDisableDir.Checked)
					if (I % 5 == 0)
					{
						this.SB.Text = (string) ("Adding subdirectories... standby: " + I.ToString());
					}
					Application.DoEvents();
					Application.DoEvents();
					DB.GetDirectories(lbArchiveDirs, modGlobals.gCurrUserGuidID, false);
					DB.GetIncludedFiles(lbIncludeExts, modGlobals.gCurrUserGuidID, FQN);
					Application.DoEvents();
				}
				this.Cursor = Cursors.AppStarting;
				if (this.ckPublic.Checked)
				{
					SetToPublic = "Y";
					string S = "Update [Directory] set ckPublic = \'Y\' ";
					S = S + " where FQN = \'" + FQN + "\' ";
					S = S + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
					DB.ExecuteSqlNewConn(S);
					if (ckPublic.Enabled)
					{
						SB.Text = "Standby, updating the repository, this can take a long time.";
						this.Refresh();
						Application.DoEvents();
						this.Cursor = Cursors.AppStarting;
						S = "update DataSource set isPublic = \'Y\' where FileDirectory = \'" + FQN + "\' and DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						DB.ExecuteSqlNewConn(S);
						this.Cursor = Cursors.Default;
					}
				}
				else
				{
					SetToPublic = "N";
					string S = "Update [Directory] set ckPublic = \'N\' ";
					S = S + " where FQN = \'" + FQN + "\' ";
					S = S + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
					DB.ExecuteSqlNewConn(S);
					if (ckPublic.Enabled)
					{
						SB.Text = "Standby, updating the repository, this can take a long time.";
						this.Refresh();
						Application.DoEvents();
						this.Cursor = Cursors.AppStarting;
						S = "update DataSource set isPublic = \'N\' where FileDirectory = \'" + FQN + "\' and DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						DB.ExecuteSqlNewConn(S);
						this.Cursor = Cursors.Default;
					}
				}
				this.Cursor = Cursors.Default;
				
			}
			
			if (CkMonitor.Checked == true)
			{
				CkMonitor_CheckedChanged(null, null);
			}
			
			PBx.Value = 0;
			lbExcludeExts.Visible = true;
			lbIncludeExts.Visible = true;
			lbAvailExts.Visible = true;
			lbArchiveDirs.Enabled = true;
			
			btnRefresh.Text = "Show Enabled";
			Button5_Click(null, null);
			
			
			IncludeListHasChanged = false;
			this.SB.Text = "Complete...";
			this.PBx.Value = 0;
			this.Cursor = System.Windows.Forms.Cursors.Default;
		}
		
		
		public void btnInclFileType_Click(System.Object sender, System.EventArgs e)
		{
			try
			{
				
				//If ckDirProfileMaint.Checked Then
				
				//End If
				
				//If txtDir.Text.Trim.Length = 0 Then
				//    messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
				//    Return
				//End If
				string S1 = lbAvailExts.SelectedItem.ToString();
				
				foreach (string S in lbAvailExts.SelectedItems)
				{
					bool ItemAlreadyExists = false;
					for (int I = 0; I <= lbIncludeExts.Items.Count - 1; I++)
					{
						string ExistingItem = lbIncludeExts.Items[I];
						if (S.ToUpper().Equals(ExistingItem.ToUpper()))
						{
							ItemAlreadyExists = true;
							break;
						}
					}
					if (ItemAlreadyExists == false)
					{
						lbIncludeExts.Items.Add(S);
						btnSaveChanges.BackColor = Color.OrangeRed;
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR btnInclFileType_Click : " + ex.Message));
				SB.Text = "Error - please refer to error log.";
			}
			
			btnSaveChanges.BackColor = Color.OrangeRed;
			
		}
		
		public void btnRemoveDir_Click(System.Object sender, System.EventArgs e)
		{
			try
			{
				
				if (clAdminDir.Checked)
				{
					MessageBox.Show("Cannot remove a mandatory directory, returning.");
					return;
				}
				
				if (CkMonitor.Checked)
				{
					MessageBox.Show("Cannot remove a directory assigned to a listener, returning.");
					return;
				}
				
				int iCnt = lbArchiveDirs.SelectedItems.Count;
				if (iCnt <= 0)
				{
					MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.");
					return;
				}
				string msg = "This will DELETE the selected directory AND ALL SUB-DIRECTORIES from the archive process, are you sure?";
				DialogResult dlgRes = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo);
				if (dlgRes == System.Windows.Forms.DialogResult.No)
				{
					this.Cursor = System.Windows.Forms.Cursors.Default;
					return;
				}
				
				this.Cursor = System.Windows.Forms.Cursors.WaitCursor;
				string FQN = txtDir.Text.Trim();
				
				string S = "";
				S += "select DirGuid from Directory ";
				S += " where ";
				S += " FQN like \'C:\\dir%\'";
				S += " and UserID = \'4841903f-46ff-4cd1-bcf3-6b6d770ff752\'";
				
				bool B = false;
				if (ckSubDirs.Checked)
				{
					S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like \'" + FQN + "%\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
					S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like \'" + FQN + "%\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
					S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like \'" + FQN + "%\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
					S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like \'" + FQN + "%\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
				}
				else
				{
					S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like \'" + FQN + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
					S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like \'" + FQN + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
					S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like \'" + FQN + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
					S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like \'" + FQN + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\')";
					B = DB.ExecuteSqlNewConn(S);
				}
				
				DB.GetDirectories(lbArchiveDirs, modGlobals.gCurrUserGuidID, false);
				
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("ERROR btnRemoveDir_Click : No file type selected.");
			}
			
			this.Cursor = System.Windows.Forms.Cursors.Default;
		}
		
		public void Button5_Click(System.Object sender, System.EventArgs e)
		{
			if (btnRefresh.Text.Equals("Show Enabled"))
			{
				lbArchiveDirs.Items.Clear();
				DB.GetDirectories(lbArchiveDirs, modGlobals.gCurrUserGuidID, false);
				this.Cursor = System.Windows.Forms.Cursors.Default;
				btnRefresh.Text = "Show Disabled";
			}
			else
			{
				lbArchiveDirs.Items.Clear();
				DB.GetDirectories(lbArchiveDirs, modGlobals.gCurrUserGuidID, true);
				this.Cursor = System.Windows.Forms.Cursors.Default;
				btnRefresh.Text = "Show Enabled";
			}
			
		}
		public string cvtCkBox(CheckBox CB)
		{
			string S = "";
			if (CB.Checked == true)
			{
				S = "Y";
			}
			else
			{
				S = "N";
			}
			return S;
		}
		public bool cvtTF(string tVal)
		{
			tVal = tVal.ToUpper();
			if (tVal == "Y")
			{
				return true;
			}
			else
			{
				return false;
			}
			
		}
		
		public void Button2_Click(System.Object sender, System.EventArgs e)
		{
			if (! DB.isAdmin(modGlobals.gCurrUserGuidID))
			{
				DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			string msg = "This will remove the associated file types, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			string ParentFT = "";
			string ChildFT = "";
			string S = cbProcessAsList.Text;
			if (S.Length == 0)
			{
				MessageBox.Show("Please select an item to process... returning.");
				return;
			}
			
			int I = 0;
			int J = 0;
			I = S.IndexOf("-") + 1;
			ParentFT = S.Substring(0, I - 1).Trim();
			J = S.IndexOf(">") + 1;
			ChildFT = S.Substring(J + 1 - 1).Trim();
			PFA.setExtcode(ref ParentFT);
			PFA.setProcessextcode(ref ChildFT);
			bool B = DB.ckProcessAsExists(ParentFT);
			if (B)
			{
				B = PFA.Delete("where [ExtCode] = \'" + ParentFT + "\' ");
				if (! B)
				{
					MessageBox.Show("Delete failed...");
				}
				else
				{
					S = "update  [DataSource] set [SourceTypeCode] = \'" + ParentFT + "\' where [SourceTypeCode] = \'" + ChildFT + "\' and [DataSourceOwnerUserID] = \'" + modGlobals.gCurrUserGuidID + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					if (B)
					{
						SB.Text = ChildFT + " Reset to process as " + ParentFT;
					}
				}
				DB.GetProcessAsList(cbProcessAsList);
			}
		}
		
		public void ActivateProgressBar(double FileLength)
		{
			
			//Dim ImageSizeDouble As Double = 0
			
			frmPercent.Default.fSize = modGlobals.gfile_Length;
			frmPercent.Default.Show();
			
			frmPercent.Default.Top = this.Top - 10;
			frmPercent.Default.Left = this.Left;
			frmPercent.Default.Width = this.Width;
			//frmPercent.TopLevel = True
			
			int I = 0;
			frmPercent.Default.PB.Value = 0;
			frmPercent.Default.PB.Maximum = 1001;
			while (DisplayActivity == true)
			{
				I++;
				Thread.Sleep(250);
				//If I Mod 15 = 0 Then
				//    Dim D As Double = DB.getDataSourceImageLength(ImageGuid)
				//    Me.SB.Text = (D / ImageSizeDouble * 100).ToString + "% Loaded"
				//End If
				if (I >= 1000)
				{
					I = 1;
				}
				frmPercent.Default.Text = "%";
				frmPercent.Default.PB.Value = I;
				frmPercent.Default.PB.Refresh();
				frmPercent.Default.PB.Visible = true;
				Application.DoEvents();
			}
			frmPercent.Default.Close();
		}
		
		public void ArchiveContent(string CurrUserGuidID)
		{
			
			bool bExplodeZipFile = false;
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			string ERR_FQN = System.Configuration.ConfigurationManager.AppSettings["MoveErrorDir"];
			
			string file_FullName = "";
			string file_name = "";
			
			if (! Directory.Exists(ERR_FQN))
			{
				
				try
				{
					Directory.CreateDirectory(ERR_FQN);
				}
				catch (Exception)
				{
					MessageBox.Show("FATAL ERROR: Could not create the directory " + ERR_FQN + ", aborting archive.");
					return;
				}
				
			}
			
			SortedList<string, string> ListOfFilesToDelete = new SortedList<string, string>();
			string DeleteOnArchive = "";
			
			Dictionary<string, int> ExistingFileTypes = new Dictionary<string, int>();
			DB.LoadFileTypeDictionary(ExistingFileTypes);
			
			
			if (CurrUserGuidID == null)
			{
				CurrUserGuidID = UIDcurr;
			}
			if (CurrUserGuidID.Length == 0)
			{
				CurrUserGuidID = UIDcurr;
			}
			
			modGlobals.gContactsArchiving = true;
			
			if (modGlobals.gRunMinimized == true)
			{
				frmNotify.Default.WindowState = FormWindowState.Minimized;
			}
			else
			{
				frmNotify.Default.Show();
			}
			
			if (modGlobals.gRunMinimized)
			{
				frmNotify.Default.WindowState = FormWindowState.Minimized;
			}
			frmNotify.Default.Text = "Content";
			frmNotify.Default.Label1.Text = "CONTENT";
			frmNotify.Default.Location = new Point(25, 300);
			
			if (modGlobals.gRunMode.Equals("M-END"))
			{
				frmNotify.Default.WindowState = FormWindowState.Minimized;
			}
			
			int iContent = 0;
			int LastVerNbr = 0;
			int NextVersionNbr = 0;
			
			if (DB.isArchiveDisabled("CONTENT") == true)
			{
				modGlobals.gContentArchiving = false;
				My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
				My.Settings.Default.Save();
				return;
			}
			
			string PrevParentDir = "";
			
			
			PROC.getCurrentApplications();
			
			if (ddebug)
			{
				LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8000 : trace log.");
			}
			
			int RetentionYears = int.Parse(val[DB.getSystemParm("RETENTION YEARS")]);
			
			DateTime rightNow = DateTime.Now.AddYears(RetentionYears);
			string RetentionExpirationDate = rightNow.ToString();
			string EmailFQN = "";
			modGlobals.ZipFilesContent.Clear();
			string[] a = new string[1];
			
			CompletedPolls++;
			
			if (UseThreads == false)
			{
				SB5.Text = DateTime.Now + " : Archiving data... standby: " + CompletedPolls.ToString();
			}
			
			//Dim ActiveFolders(0)
			List<string> ActiveFolders = new List<string>();
			string FolderName = "";
			bool DeleteFile = false;
			string OcrDirectory = "";
			string OcrPdf = "";
			List<string> ListOfDisabledDirs = new List<string>();
			List<string> FilesToArchive = new List<string>();
			List<string> LibraryList = new List<string>();
			List<string> DirLibraryList = new List<string>();
			
			bool ThisFileNeedsToBeMoved = false;
			bool ThisFileNeedsToBeDeleted = false;
			
			//********************************************************************
			DB.GetContentArchiveFileFolders(CurrUserGuidID, ActiveFolders, "");
			DB.getDisabledDirectories(ListOfDisabledDirs);
			//********************************************************************
			
			string cFolder = "";
			string pFolder = "XXX";
			string ArchiveMsg = "";
			string RetentionCode = "";
			
			int PauseThreadMS = 0;
			try
			{
				PauseThreadMS = int.Parse(DB.getUserParm("UserEmail_Pause"));
			}
			catch (Exception)
			{
				PauseThreadMS = 0;
			}
			
			
			if (ddebug)
			{
				LOG.WriteToArchiveLog("frmReconMain : ArchiveContent :8001 : trace log.");
			}
			
			FilesBackedUp = 0;
			FilesSkipped = 0;
			
			if (UseThreads == false)
			{
				PBx.Value = 0;
			}
			if (UseThreads == false)
			{
				PBx.Maximum = System.Convert.ToInt32(ActiveFolders.Count + 2);
			}
			
			string isPublic = "";
			
			try
			{
				for (int i = 0; i <= ActiveFolders.Count - 1; i++)
				{
					
					iContent++;
					System.Threading.Thread.Sleep(50);
					try
					{
						frmNotify.Default.Label1.Text = (string) ("CONTENT " + iContent.ToString());
					}
					catch (Exception)
					{
						frmNotify.Default.Close();
						frmNotify.Default.Show();
						if (modGlobals.gRunMode.Equals("M-END"))
						{
							frmNotify.Default.WindowState = FormWindowState.Minimized;
						}
					}
					Application.DoEvents();
					
					if (modGlobals.gTerminateImmediately)
					{
						try
						{
							this.Cursor = Cursors.Default;
						}
						catch (Exception)
						{
							
						}
						
						if (UseThreads == false)
						{
							SB5.Text = "Terminated archive!";
						}
						frmNotify.Default.Close();
						modGlobals.gContentArchiving = false;
						My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
						My.Settings.Default.Save();
						return;
					}
					
					if (UseThreads == false)
					{
						PBx.Value = i;
					}
					if (UseThreads == false)
					{
						PBx.Refresh();
					}
					Application.DoEvents();
					
					if (i >= ActiveFolders.Count)
					{
						break;
					}
					
					string FolderParmStr = (string) (ActiveFolders(i).ToString().Trim);
					string[] FolderParms = FolderParmStr.Split("|".ToCharArray());
					
					string FOLDER_FQN = FolderParms[0];
					
					if (FOLDER_FQN.Trim().Length > 260)
					{
						FOLDER_FQN = modGlobals.getShortDirName(FOLDER_FQN);
					}
					
					bool bDisabled = DB.ckFolderDisabled(CurrUserGuidID, FOLDER_FQN);
					
					if (bDisabled)
					{
						LOG.WriteToArchiveLog("Notice: Folder " + FOLDER_FQN + " disabled.");
						goto NextFolder;
					}
					
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Arciving : " + FOLDER_FQN);
					}
					if (FOLDER_FQN.IndexOf("%userid%") + 1)
					{
						string S1 = "";
						string S2 = "";
						int iLoc = FOLDER_FQN.IndexOf("%userid%") + 1;
						S1 = FOLDER_FQN.Substring(0, iLoc - 1);
						S2 = FOLDER_FQN.Substring(iLoc + "%userid%".Length - 1);
						string UserName = System.Environment.UserName;
						FOLDER_FQN = S1 + UserName + S2;
					}
					
					if (ListOfDisabledDirs.Contains(FOLDER_FQN))
					{
						LOG.WriteToArchiveLog("NOTICE: Folder \'" + FOLDER_FQN + "\' is disabled from archive, skipping.");
						LOG.WriteToArchiveLog("NOTICE: Folder \'" + FOLDER_FQN + "\' is disabled from archive, skipping.");
						goto NextFolder;
					}
					
					if (ddebug)
					{
						LOG.WriteToArchiveLog((string) ("frmReconMain : ArchiveContent :8002 :FOLDER_FQN : " + FOLDER_FQN));
					}
					string ParmMsg = "";
					string FOLDER_IncludeSubDirs = FolderParms[1];
					ParmMsg += "FOLDER_IncludeSubDirs set to " + FOLDER_IncludeSubDirs + " for " + FOLDER_FQN + "\r\n";
					
					string FOLDER_DBID = FolderParms[2];
					ParmMsg += "FOLDER_DBID  set to " + FOLDER_DBID + " for " + FOLDER_FQN + "\r\n";
					
					string FOLDER_VersionFiles = FolderParms[3];
					ParmMsg += "FOLDER_VersionFiles  set to " + FOLDER_VersionFiles + " for " + FOLDER_FQN + "\r\n";
					
					string DisableDir = FolderParms[4];
					ParmMsg += "DisableDir  set to " + DisableDir + " for " + FOLDER_FQN + "\r\n";
					
					OcrDirectory = FolderParms[5];
					ParmMsg += "OcrDirectory  set to " + OcrDirectory + " for " + FOLDER_FQN + "\r\n";
					
					string ParentDir = FolderParms[7];
					ParmMsg += "ParentDir  set to " + ParentDir + " for " + FOLDER_FQN + "\r\n";
					
					string skipArchiveBit = FolderParms[8];
					ParmMsg += "skipArchiveBit  set to " + skipArchiveBit + " for " + FOLDER_FQN + "\r\n";
					
					
					OcrPdf = FolderParms[9];
					if (OcrPdf.Equals("Y"))
					{
						modGlobals.gPdfExtended = true;
					}
					else
					{
						modGlobals.gPdfExtended = false;
					}
					
					DeleteOnArchive = FolderParms[10];
					ParmMsg += "DeleteOnArchive set to " + DeleteOnArchive + " for " + FOLDER_FQN + "\r\n";
					
					isPublic = FolderParms[11];
					ParmMsg += "isPublic set to " + isPublic + " for " + FOLDER_FQN + "\r\n";
					
					//***************************
					//MessageBox.Show(ParmMsg)
					//***************************
					
					bool ckArchiveBit = false;
					
					if (skipArchiveBit.ToUpper().Equals("TRUE"))
					{
						ckArchiveBit = true;
					}
					else
					{
						ckArchiveBit = false;
					}
					
					FOLDER_FQN = UTIL.ReplaceSingleQuotes(FOLDER_FQN);
					
					if (Directory.Exists(FOLDER_FQN))
					{
						if (UseThreads == false)
						{
							SB5.Text = (string) ("Processing Dir: " + FOLDER_FQN);
						}
						if (ddebug)
						{
							LOG.WriteToArchiveLog((string) ("frmReconMain : ArchiveContent :8003 :FOLDER Exists: " + FOLDER_FQN));
						}
						if (ddebug)
						{
							LOG.WriteToArchiveLog((string) ("Archive Folder: " + FOLDER_FQN));
						}
					}
					else
					{
						if (UseThreads == false)
						{
							SB5.Text = FOLDER_FQN + " does not exist, skipping.";
						}
						if (ddebug)
						{
							LOG.WriteToArchiveLog((string) ("frmReconMain : ArchiveContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN));
						}
						if (ddebug)
						{
							LOG.WriteToArchiveLog((string) ("Archive Folder FOUND MISSING: " + FOLDER_FQN));
						}
						goto NextFolder;
					}
					if (DisableDir.Equals("Y"))
					{
						goto NextFolder;
					}
					
					if (ddebug)
					{
						if (FOLDER_FQN.IndexOf("\'") + 1 > 0)
						{
							Console.WriteLine("Single Quote found: " + FOLDER_FQN);
						}
					}
					
					//******************************************************************************
					if (PrevParentDir != ParentDir)
					{
						Console.WriteLine(FOLDER_FQN);
						if (FOLDER_FQN.IndexOf("army") + 1 > 0)
						{
							Console.WriteLine("HERRE 773");
						}
						DB.GetAllIncludedFiletypes(ParentDir, IncludedTypes, FOLDER_IncludeSubDirs);
						DB.GetAllExcludedFiletypes(ParentDir, ExcludedTypes, FOLDER_IncludeSubDirs);
					}
					if (IncludedTypes.Count == 0)
					{
						DB.GetAllIncludedFiletypes(ParentDir, IncludedTypes, FOLDER_IncludeSubDirs);
						DB.GetAllExcludedFiletypes(ParentDir, ExcludedTypes, FOLDER_IncludeSubDirs);
					}
					//******************************************************************************
					PrevParentDir = ParentDir;
					if (ddebug)
					{
						LOG.WriteToArchiveLog((string) ("frmReconMain : ArchiveContent :8005 : Trace: " + FOLDER_FQN));
					}
					bool bChanged = false;
					
					if (FOLDER_FQN != pFolder)
					{
						
						if (ddebug)
						{
							LOG.WriteToArchiveLog("NOTICE ddebug - 200a: Processing Directory: " + FOLDER_FQN + " - defined to " + IncludedTypes.Count.ToString() + " filetype codes.");
						}
						
						//********************************************************************************************************************
						string tFOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN);
						int iCntFolderIsdefinedForArchive = 0;
						string SS = "Select COUNT(*) from Directory where FQN = \'" + tFOLDER_FQN + "\' and UserID = \'" + CurrUserGuidID + "\'";
						iCntFolderIsdefinedForArchive = DB.iCount(SS);
						if (iCntFolderIsdefinedForArchive > 0)
						{
							DB.GetAllIncludedFiletypes(FOLDER_FQN, IncludedTypes, FOLDER_IncludeSubDirs);
							DB.GetAllExcludedFiletypes(FOLDER_FQN, ExcludedTypes, FOLDER_IncludeSubDirs);
							DB.AddIncludedFiletypes(FOLDER_FQN, IncludedTypes, FOLDER_IncludeSubDirs);
							DB.AddExcludedFiletypes(FOLDER_FQN, ExcludedTypes, FOLDER_IncludeSubDirs);
						}
						else
						{
							DB.GetAllIncludedFiletypes(ParentDir, IncludedTypes, FOLDER_IncludeSubDirs);
							DB.GetAllExcludedFiletypes(ParentDir, ExcludedTypes, FOLDER_IncludeSubDirs);
							DB.AddIncludedFiletypes(ParentDir, IncludedTypes, FOLDER_IncludeSubDirs);
							DB.AddExcludedFiletypes(ParentDir, ExcludedTypes, FOLDER_IncludeSubDirs);
						}
						//********************************************************************************************************************
						
#if EnableSingleSource
						Guid tDirGuid = GE.AddItem(FOLDER_FQN, "GlobalDirectory", false);
#endif
						
						string ParentDirForLib = "";
						bool bLikToLib = false;
						bLikToLib = System.Convert.ToBoolean(ARCH.isDirInLibrary(FOLDER_FQN, ParentDirForLib));
						
						if (ddebug)
						{
							LOG.WriteToArchiveLog((string) ("frmReconMain : ArchiveContent :8006 : Folder Changed: " + FOLDER_FQN + ", " + pFolder));
						}
						
						FolderName = FOLDER_FQN;
						
						if (bLikToLib)
						{
							ARCH.GetDirectoryLibraries(ParentDirForLib, LibraryList);
						}
						else
						{
							ARCH.GetDirectoryLibraries(FOLDER_FQN, LibraryList);
						}
						
						Application.DoEvents();
						//** Verify that the DIR still exists
						if (Directory.Exists(FolderName))
						{
							if (UseThreads == false)
							{
								SB5.Text = (string) ("Processing Dir: " + FolderName);
							}
						}
						else
						{
							if (UseThreads == false)
							{
								SB5.Text = FolderName + " does not exist, skipping.";
							}
							if (ddebug)
							{
								LOG.WriteToArchiveLog((string) ("frmReconMain : ArchiveContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN));
							}
							goto NextFolder;
						}
						
						RetentionCode = DB.GetDirRetentionCode(ParentDir, CurrUserGuidID);
						if (RetentionCode.Length > 0)
						{
							RetentionYears = DB.getRetentionPeriod(RetentionCode);
						}
						else
						{
							RetentionYears = int.Parse(val[DB.getSystemParm("RETENTION YEARS")]);
						}
						
						DB.getDirectoryParms(ref a, ParentDir, CurrUserGuidID);
						
						string IncludeSubDirs = a[0];
						string VersionFiles = a[1];
						string ckMetaData = a[2];
						OcrDirectory = a[3];
						RetentionCode = a[4];
						OcrPdf = a[5];
						isPublic = a[6];
						//a(0) = IncludeSubDirs
						//a(1) = VersionFiles
						//a(2) = ckMetaData
						//a(3) = OcrDirectory
						//a(4) = RetentionCode
						//a(5) = OcrPdf
						//a(6) = ckPublic
						
						//*****************************************************************************
						//** Get all of the files in this folder
						//*****************************************************************************
						DateTime StepTimer = DateTime.Now;
						bool bSubDirFlg = false;
						try
						{
							if (ddebug)
							{
								LOG.WriteToArchiveLog("Starting File capture");
							}
							FilesToArchive.Clear();
							if (ddebug)
							{
								LOG.WriteToArchiveLog("Starting File capture: Init FilesToArchive");
							}
							
							//**************************************************************************
							if (UseThreads == false)
							{
								SB5.Text = FOLDER_FQN;
							}
							Application.DoEvents();
							LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "START");
							//NbrFilesInDir = DMA.getFilesInDir(FOLDER_FQN , FilesToArchive, IncludedTypes, ExcludedTypes, ckArchiveBit)
							
							string MSG = "";
							string strFileSize = "";
							List<string> FilterList = new List<string>();
							//Dim ArchiveAttr As Boolean = False
							string sTemp = "";
							
							for (int XX = 0; XX <= IncludedTypes.Count - 1; XX++)
							{
								sTemp = IncludedTypes[XX];
								if ((IncludedTypes[XX]).ToString().IndexOf(".") + 1 == 0)
								{
									sTemp = (string) ("." + sTemp);
								}
								if ((IncludedTypes[XX]).ToString().IndexOf("*") + 1 == 0)
								{
									sTemp = (string) ("*" + sTemp);
								}
								FilterList.Add(sTemp);
							}
							
							if (FOLDER_IncludeSubDirs.ToUpper().Equals("Y"))
							{
								bSubDirFlg = true;
							}
							frmNotify.Default.lblFileSpec.Text = "Standby, directory inventory.";
							frmNotify.Default.Refresh();
							int iInventory = 0;
							UTIL.GetFilesToArchive(ref iInventory, ckArchiveBit, bSubDirFlg, FOLDER_FQN, FilterList, FilesToArchive);
							frmNotify.Default.lblFileSpec.Text = "Directory inventory complete";
							frmNotify.Default.Refresh();
							NbrFilesInDir = System.Convert.ToInt32(FilesToArchive.Count);
							Console.WriteLine("Start: " + DateTime.Now.ToString());
							
							LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "STOP", StepTimer);
							//**************************************************************************
							if (ddebug)
							{
								LOG.WriteToArchiveLog("Starting File capture: Loaded files");
							}
							if (NbrFilesInDir == 0)
							{
								LOG.WriteToArchiveLog((string) ("Archive Folder HAD NO FILES: " + FOLDER_FQN));
								//GoTo NextFolder
							}
							if (ddebug)
							{
								LOG.WriteToArchiveLog("Starting File capture: start ckFilesNeedUpdate");
							}
							//*******************************
							StepTimer = DateTime.Now;
							LOG.WriteToTimerLog("ArchiveContent-01", "ckFilesNeedUpdate", "START");
							if (! DeleteOnArchive.Equals("Y"))
							{
								DB.ckFilesNeedUpdate(ref FilesToArchive, ckArchiveBit);
							}
							
							LOG.WriteToTimerLog("ArchiveContent-01", "ckFilesNeedUpdate", "STOP", StepTimer);
							//*******************************
							if (ddebug)
							{
								LOG.WriteToArchiveLog("Starting File capture: end ckFilesNeedUpdate");
							}
						}
						catch (Exception)
						{
							LOG.WriteToArchiveLog((string) ("ERROR Archive Folder Acquisition Failure : " + FOLDER_FQN));
							goto NextFolder;
						}
						string ArchIndicator = "";
						//** Process all of the files
						int iTotal = System.Convert.ToInt32(FilesToArchive.Count);
						iContent++;
						string InventoryFQN = "";
						for (int K = 0; K <= FilesToArchive.Count - 1; K++)
						{
							
							bExplodeZipFile = true;
							ThisFileNeedsToBeMoved = false;
							ThisFileNeedsToBeDeleted = false;
							
							iContent++;
							
							if (K % 2 == 0)
							{
								if (UseThreads == false)
								{
									SB5.Text = System.Convert.ToString(K.ToString() + " of " + iTotal.ToString());
								}
								Application.DoEvents();
							}
							
							ArchIndicator = "";
							if (FilesToArchive(K) == null)
							{
								goto DoneWithIt;
							}
							
							if (FilesToArchive(K).Length > 5)
							{
								ArchIndicator = Strings.Mid(FilesToArchive(K), 1, 5).ToUpper();
								if (ArchIndicator.Equals("FALSE") && ckArchiveBit == true)
								{
									goto NextFile;
								}
							}
							
							
							
							if (PauseThreadMS > 0)
							{
								System.Threading.Thread.Sleep(50);
							}
							
							//************************************************************************
							string[] FileAttributes = FilesToArchive(K).Split("|");
							string file_ArchiveBit = FileAttributes[0].ToUpper();
							
							file_name = FileAttributes[1];
							string file_Extension = FileAttributes[2];
							string file_DirectoryName = FileAttributes[3];
							
							if (K > FilesToArchive.Count)
							{
								goto NextFolder;
							}
							if (FilesToArchive(K) == null)
							{
								goto NextFile;
							}
							//ArchiveAttr & "|" & fi.Name & "|" & fi.Extension & "|" & fi.DirectoryName & "|" & fi.Length & "|" & fi.CreationTime & "|" & fi.LastWriteTime & "|" & fi.LastAccessTime
							if (ckArchiveBit == true && file_ArchiveBit.Equals("FALSE"))
							{
								goto NextFile;
							}
							
							//************************************************************************
							
							InventoryFQN = file_DirectoryName + "\\" + file_name;
							
							DateTime UpdateTimerMain = DateTime.Now;
							
							if ((FilesToArchive(K)).ToString().IndexOf(".pdf") + 1 > 0)
							{
								Console.WriteLine("Here XXX: " + FilesToArchive(K));
							}
							
							frmNotify.Default.Label1.Text = (string) ("CONTENT " + K.ToString() + " - " + iTotal.ToString());
							frmNotify.Default.BackColor = Color.AntiqueWhite;
							frmNotify.Default.Refresh();
							Application.DoEvents();
							
							if (modGlobals.gTerminateImmediately)
							{
								try
								{
									this.Cursor = Cursors.Default;
								}
								catch (Exception)
								{
									
								}
								if (UseThreads == false)
								{
									SB5.Text = "Terminated archive!";
								}
								frmNotify.Default.Close();
								modGlobals.gContentArchiving = false;
								My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
								My.Settings.Default.Save();
								return;
							}
							
							if (UseThreads == false)
							{
								SB5.Text = (string) ("Directory Files processed: " + K.ToString() + " OF " + FilesToArchive.Count);
							}
							Application.DoEvents();
							
							if (ListOfDisabledDirs.Contains(file_DirectoryName))
							{
								goto NextFile;
							}
							int file_Length = int.Parse(val[FileAttributes[4]]);
							if (file_Length == 0)
							{
								goto NextFile;
							}
							DateTime file_CreationTime = DateTime.Parse(FileAttributes[5]);
							DateTime file_LastWriteTime = DateTime.Parse(FileAttributes[6]);
							DateTime file_LastAccessTime = DateTime.Parse(FileAttributes[7]);
							
							file_FullName = file_DirectoryName + "\\" + file_name;
							
							
							//*******************************************************************
							//*******************************************************************
							string ContentSha1Hash = ENC.getSha1HashFromFile(file_FullName);
							int iDatasourceCnt = DB.getCountDataSourceFiles(file_name, ContentSha1Hash);
							if (iDatasourceCnt > 0)
							{
								frmNotify.Default.BackColor = Color.LightSalmon;
								string ExistingSourceGuid = DB.getContentGuid(file_name, ContentSha1Hash);
								DB.saveContentOwner(ExistingSourceGuid, CurrUserGuidID, "C", FOLDER_FQN, modGlobals.gMachineID, modGlobals.gNetworkID);
								frmNotify.Default.BackColor = Color.LightGoldenrodYellow;
								goto NextFile;
							}
							frmNotify.Default.BackColor = Color.LightGoldenrodYellow;
							//*******************************************************************
							//*******************************************************************
							if (DeleteOnArchive.Equals("Y"))
							{
								if (! ListOfFilesToDelete.ContainsKey(file_FullName))
								{
									ListOfFilesToDelete.Add(file_FullName, "UKN");
								}
							}
							//*******************************************************************
							//*******************************************************************
							string SourceGuid = DB.getGuid();
							
							//LOG.WriteToFileProcessLog(file_FullName)
							LOG.WriteToTimerLog("ArchiveContent-01", (string) ("Archive File:" + file_FullName), "START");
							
							if (file_FullName.IndexOf("\\ECM\\ErrorFile\\") + 1 > 0)
							{
								Console.WriteLine("Skipping: " + file_FullName);
								goto DoneWithIt;
							}
							
							if (modGlobals.gMaxSize > 0)
							{
								if (val[file_Length] > modGlobals.gMaxSize)
								{
									LOG.WriteToArchiveLog("Notice: file \'" + file_FullName + "\' exceed the allowed file upload size, skipped.");
									goto NextFile;
								}
							}
							
							file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
							file_name = UTIL.RemoveSingleQuotes(file_name);
							
							if (file_Extension.Equals(".msg"))
							{
								LOG.WriteToArchiveLog("NOTICE: Content Archive File : " + file_FullName + " was found to be a message file, moved file.");
								if (MsgNotification == false || modGlobals.gRunUnattended == true)
								{
									string DisplayMsg = "A message file was encounted in a backup directory." + "\r\n";
									DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + "\r\n";
									DisplayMsg = DisplayMsg + "To archive a MSG file, it should be imported into outlook." + "\r\n";
									DisplayMsg = DisplayMsg + "This file has ALSO been added to the CONTENT repository." + "\r\n";
									frmHelp.Default.MsgToDisplay = DisplayMsg;
									frmHelp.Default.CallingScreenName = "ECM Archive";
									frmHelp.Default.CaptionName = "MSG File Encounted in Content Archive";
									frmHelp.Default.Timer1.Interval = 10000;
									frmHelp.Default.Show();
									MsgNotification = true;
									if (modGlobals.gRunUnattended == true)
									{
										LOG.WriteToArchiveLog((string) ("WARNING: ArchiveContent 100: " + "\r\n" + DisplayMsg));
									}
								}
								
								string EmailWorkingDirectory = DB.getWorkingDirectory(CurrUserGuidID, "EMAIL WORKING DIRECTORY");
								
								EmailWorkingDirectory = UTIL.RemoveSingleQuotes(EmailWorkingDirectory);
								file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
								EmailFQN = EmailWorkingDirectory + "\\" + file_FullName.Trim();
								
								file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
								
								if (File.Exists(EmailFQN))
								{
									string tMsg = (string) ("Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN);
									LOG.WriteToArchiveLog(tMsg);
									DB.xTrace(965, "ArchiveContent", tMsg);
									//FilesSkipped += 1
								}
								else
								{
									File.Copy(file_FullName, EmailFQN);
									string tMsg = (string) ("Email File Encountered, moved to EMAIL WORKING DIRECTORY and entered into repository: " + EmailFQN);
									DB.xTrace(966, "ArchiveContent", tMsg);
									//FilesSkipped += 1
								}
								//GoTo NextFile
							}
							
							ARCH.ckSourceTypeCode(file_Extension);
							
							if (file_Extension.ToLower().Equals(".pdf"))
							{
								Debug.Print(file_FullName);
							}
							if (file_Extension.ToLower().Equals(".zip"))
							{
								Debug.Print(file_FullName);
							}
							if (file_Extension.ToLower().Equals(".png"))
							{
								Debug.Print(file_FullName);
							}
							if (file_Extension.ToLower().Equals(".jpg"))
							{
								Debug.Print(file_FullName);
							}
							if (file_Extension.ToLower().Equals(".iso"))
							{
								Debug.Print(file_FullName);
							}
							
							
							bool isZipFile = ZF.isZipFile(file_FullName);
							
							Application.DoEvents();
							
							if (! isZipFile)
							{
								bool bExt = DMA.isExtExcluded(file_Extension, ExcludedTypes);
								if (bExt)
								{
									FilesSkipped++;
									goto NextFile;
								}
								//** See if the STAR is in the INCLUDE list, if so, all files are included
								bExt = DMA.isExtIncluded(file_Extension, ExcludedTypes);
								if (bExt)
								{
									FilesSkipped++;
									goto NextFile;
								}
							}
							else
							{
								Console.WriteLine("Zipfile Found.");
							}
							
							//** This NEEDS to be in a keyed array
							int bcnt = 0;
							if (ExistingFileTypes.ContainsKey(file_Extension))
							{
								bcnt = 1;
							}
							//Dim bcnt As Integer = DB.iGetRowCount("SourceType", "where SourceTypeCode = '" + file_Extension + "'")
							
							if (bcnt == 0)
							{
								string SubstituteFileType = DB.getProcessFileAsExt(file_Extension);
								if (SubstituteFileType == null)
								{
									string MSG = "The file type \'" + file_Extension + "\' is undefined." + "\r\n" + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + "\r\n" + "This will allow content to be archived, but not searched.";
									//Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)
									
									if (ddebug)
									{
										LOG.WriteToArchiveLog(MSG);
									}
									
									UNASGND.setApplied("0");
									UNASGND.setFiletype(ref file_Extension);
									int xCnt = UNASGND.cnt_PK_AFTU(file_Extension);
									if (xCnt == 0)
									{
										UNASGND.Insert();
									}
									
									clsSOURCETYPE ST = new clsSOURCETYPE();
									ST.setSourcetypecode(ref file_Extension);
									ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm");
									ST.setIndexable("0");
									ST.setStoreexternal(0);
									ST.Insert();
									
								}
								else
								{
									file_Extension = SubstituteFileType;
								}
								
							}
							
							EmailFQN = UTIL.RemoveSingleQuotes(EmailFQN);
							file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
							
							string ssFile = "";
							ssFile = DMA.getFileName(file_FullName);
							frmNotify.Default.lblFileSpec.Text = (string) ("FILE: " + ssFile + " : " + file_Length.ToString());
							frmNotify.Default.Refresh();
							
							string StoredExternally = "N";
							
							//iDatasourceCnt = DB.getCountDataSourceFiles(file_Name, ContentSha1Hash)
							//If (iDatasourceCnt = 0) Then
							//    DB.saveContentOwner(SourceGuid, CurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)
							//End If
							
							
							Application.DoEvents();
							//***********************************************************************'
							//** New file
							//***********************************************************************'
							bool BB = false;
							string AttachmentCode = "C";
							
							if (iDatasourceCnt == 0)
							{
								
								TimeSpan TS;
								DateTime sTime = DateTime.Now;
								string sMin = "";
								string sSec = "";
								if (ddebug)
								{
									LOG.WriteToArchiveLog("INFO: File - " + file_FullName + " was found to be NEW and not in the repository.");
								}
								//Me.if UseThreads = false then SB5.Text = "Loading: " + file_Name
								Application.DoEvents();
								LastVerNbr = 0;
								
								frmNotify.Default.lblFileSpec.ForeColor = Color.Black;
								frmNotify.Default.lblFileSpec.BackColor = Color.White;
								double BytesLoading = file_Length;
								string Units = "";
								if (BytesLoading > 1000)
								{
									BytesLoading = BytesLoading / 1000;
									Units = "KB";
									Math.Round(BytesLoading - 0.005, 2);
								}
								if (BytesLoading > 100000)
								{
									BytesLoading = BytesLoading / 1000;
									Units = "KB";
									Math.Round(BytesLoading - 0.005, 2);
									frmNotify.Default.lblFileSpec.BackColor = Color.WhiteSmoke;
									frmNotify.Default.lblFileSpec.ForeColor = Color.Black;
								}
								if (BytesLoading > 1000000)
								{
									BytesLoading = BytesLoading / 1000000;
									Units = "MB";
									Math.Round(BytesLoading - 0.005, 2);
									frmNotify.Default.lblFileSpec.ForeColor = Color.Red;
								}
								if (BytesLoading > 1000000000)
								{
									BytesLoading = BytesLoading / 1000000000;
									Units = "GB";
									Math.Round(BytesLoading - 0.005, 2);
									frmNotify.Default.lblFileSpec.BackColor = Color.Red;
									frmNotify.Default.lblFileSpec.ForeColor = Color.White;
								}
								
								Application.DoEvents();
								
								if (val[file_Length] > 1000000000)
								{
									frmNotify.Default.lblFileSpec.Text = (string) ("Huge File:" + BytesLoading.ToString() + Units);
									Application.DoEvents();
									DisplayActivity = true;
									if (ActivityThread == null)
									{
										frmPercent.Default.TopLevel = true;
										ActivityThread = new Thread(new System.Threading.ThreadStart(ActivateProgressBar));
										ActivityThread.Priority = ThreadPriority.Lowest;
										ActivityThread.IsBackground = true;
										ActivityThread.Start();
									}
									modGlobals.gfile_Length = double.Parse(val[file_Length]);
								}
								else if (val[file_Length] > 3000000)
								{
									modGlobals.gfile_Length = double.Parse(val[file_Length]);
									frmNotify.Default.lblFileSpec.Text = (string) ("Large File:" + BytesLoading.ToString() + Units);
									Application.DoEvents();
									DisplayActivity = true;
									if (ActivityThread == null)
									{
										frmPercent.Default.TopLevel = true;
										ActivityThread = new Thread(new System.Threading.ThreadStart(ActivateProgressBar));
										ActivityThread.Priority = ThreadPriority.Lowest;
										ActivityThread.IsBackground = true;
										ActivityThread.Start();
									}
								}
								
								StepTimer = DateTime.Now;
								LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content", "START");
								//file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
								//file_Name = UTIL.RemoveSingleQuotes(file_Name)
								
								DOCS.setSourceguid(ref SourceGuid);
								DOCS.setFqn(ref file_FullName);
								DOCS.setSourcename(ref file_name);
								DOCS.setSourcetypecode(ref file_Extension);
								DOCS.setLastaccessdate(ref file_LastAccessTime);
								DOCS.setCreatedate(ref file_CreationTime);
								DOCS.setCreationdate(ref file_CreationTime);
								DOCS.setLastwritetime(ref file_LastWriteTime);
								DOCS.setDatasourceowneruserid(ref CurrUserGuidID);
								DOCS.setVersionnbr("0");
								BB = DOCS.Insert(ContentSha1Hash);
								LOG.WriteToTimerLog("ArchiveContent-01", (string) ("Insert Content: " + file_FullName), "STOP", StepTimer);
								if (BB)
								{
									
									if (! DeleteOnArchive.Equals("Y"))
									{
										DBLocal.addInventoryForce(file_FullName, ckArchiveBit);
									}
									else
									{
										DBLocal.delFile(file_FullName);
									}
									
									DateTime UpdateTimer = DateTime.Now;
									
									//*************************************************
									UpdateTimer = DateTime.Now;
									LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage", "START");
									string OriginalFileName = DMA.getFileName(file_FullName);
									BB = DB.UpdateSourceImage(OriginalFileName, UIDcurr, MachineIDcurr, SourceGuid, file_LastAccessTime, file_CreationTime, file_LastWriteTime, LastVerNbr, file_FullName, RetentionCode, isPublic, ContentSha1Hash);
									
									DB.saveContentOwner(SourceGuid, CurrUserGuidID, "C", FOLDER_FQN, modGlobals.gMachineID, modGlobals.gNetworkID);
									
									//DB.addContentHashKey(SourceGuid, 0, file_CreationTime, file_FullName, file_Extension, file_Length, CRC, MachineIDcurr)
									LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage", "STOP", UpdateTimer);
									//****************************************************************************************************************************
									if (! BB)
									{
										//Dim isIncludedAsSubDir As Boolean = DB.isSubDirIncluded(FOLDER_FQN )
										string MySql = "Delete from DataSource where SourceGuid = \'" + SourceGuid + "\'";
										DB.ExecuteSqlNewConn(MySql);
										LOG.WriteToErrorLog("Unrecoverable LOAD Error - removed file \'" + file_FullName + "\' from the repository.");
										if (UseThreads == false)
										{
											SB5.BackColor = Color.Red;
										}
										if (UseThreads == false)
										{
											SB5.ForeColor = Color.Yellow;
										}
										
										string DisplayMsg = "A source file failed to load. Review ERROR log.";
										frmHelp.Default.MsgToDisplay = DisplayMsg;
										frmHelp.Default.CallingScreenName = "ECM Archive";
										frmHelp.Default.CaptionName = "Fatal Load Error";
										frmHelp.Default.Timer1.Interval = 10000;
										frmHelp.Default.Show();
									}
									else
									{
										if (LibraryList.Count > 0)
										{
											for (int II = 0; II <= LibraryList.Count - 1; II++)
											{
												string LibraryName = LibraryList(II);
												ARCH.AddLibraryItem(SourceGuid, file_name, file_Extension, LibraryName);
											}
										}
									}
								}
								else
								{
									LOG.WriteToArchiveLog((string) ("Error 22.345.23a - Failed to add source:" + file_FullName));
								}
								
								file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
								file_name = UTIL.RemoveSingleQuotes(file_name);
								
								if (BB)
								{
									FilesBackedUp++;
									
									file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
									file_name = UTIL.RemoveSingleQuotes(file_name);
									
									if (DeleteOnArchive.Equals("Y"))
									{
										if (ListOfFilesToDelete.ContainsKey(file_FullName))
										{
											//Dim iKey As Integer = ListOfFilesToDelete.IndexOfKey(file_FullName)
											try
											{
												ListOfFilesToDelete[file_FullName] = "DELETE";
											}
											catch (Exception ex)
											{
												Console.WriteLine(ex.Message);
											}
										}
										else if (! ListOfFilesToDelete.ContainsKey(file_FullName))
										{
											ListOfFilesToDelete.Add(file_FullName, "DELETE");
										}
									}
									
									//If CRC .Length = 0 Then
									//    CRC  = ENC.getSha1HashFromFile(file_FullName )
									//End If
									//ARCH.UpdateDocCrc(SourceGuid, CRC )
									
									DB.UpdateCurrArchiveStats(file_FullName, file_Extension);
									
								}
								else
								{
									FilesSkipped++;
									if (ddebug)
									{
										LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
									}
									if (ddebug)
									{
										LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
									}
									Debug.Print((string) ("FAILED TO LOAD: " + file_FullName));
									if (ddebug)
									{
										LOG.WriteToArchiveLog((string) ("frmReconMain : InsertSourcefile :FAILED TO LOAD: 8013a: " + file_FullName));
									}
								}
								
								
								if (val[file_Length] > 1000000)
								{
									if (UseThreads == false)
									{
										SB5.Text = "Large file Load completed...";
									}
									DisplayActivity = false;
									if (ActivityThread != null)
									{
										ActivityThread.Abort();
										ActivityThread = null;
									}
									this.PBx.Value = 0;
									Application.DoEvents();
								}
								if (BB)
								{
									DateTime UpdateTimer2 = DateTime.Now;
									LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "START");
									
									Application.DoEvents();
									DB.UpdateDocFqn(SourceGuid, file_FullName);
									DB.UpdateDocSize(SourceGuid, file_Length.ToString());
									DB.UpdateDocDir(SourceGuid, file_FullName);
									DB.UpdateDocOriginalFileType(SourceGuid, file_Extension);
									DB.UpdateZipFileIndicator(SourceGuid, isZipFile);
									Application.DoEvents();
									if (ddebug)
									{
										LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8015");
									}
									if (! isZipFile)
									{
										//Dim TheFileIsArchived As Boolean = True
										//DMA.setFileArchiveAttributeSet(file_FullName, TheFileIsArchived)
										DMA.setArchiveBitOff(file_FullName);
									}
									
									//DB.delFileParms(SourceGuid)
									//If CRC .Length = 0 Then
									//    CRC  = ENC.getSha1HashFromFile(file_FullName )
									//End If
									//ARCH.UpdateDocCrc(SourceGuid, CRC )
									
									//** Removed Attribution Classification by WDM 9/10/2009
									//UpdateSrcAttrib(SourceGuid, "CRC", CRC , file_Extension)
									UpdateSrcAttrib(SourceGuid, "FILENAME", file_name, file_Extension);
									UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreationTime, file_Extension);
									UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length.ToString(), file_Extension);
									UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessTime, file_Extension);
									UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, file_Extension);
									
									//DB.AddMachineSource(file_FullName, SourceGuid)
									
									if (val[file_Length] > 1000000000)
									{
										//FrmMDIMain.SB4.Text = "Extreme File: " + file_Length + " bytes - standby"
									}
									else if (val[file_Length] > 2000000)
									{
										//FrmMDIMain.SB4.Text = "Large File: " + file_Length + " bytes"
									}
									if (file_Extension.ToLower().Equals(".mp3") || file_Extension.ToLower().Equals(".wma") || file_Extension.ToLower().Equals("wma"))
									{
										MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension);
										Application.DoEvents();
									}
									else if (file_Extension.ToLower().Equals(".tiff") || file_Extension.ToLower().Equals(".jpg"))
									{
										//** This functionality will be added at a later time
										//KAT.getXMPdata(file_FullName)
										Application.DoEvents();
									}
									else if (file_Extension.ToLower().Equals(".png") || file_Extension.ToLower().Equals(".gif"))
									{
										//** This functionality will be added at a later time
										//KAT.getXMPdata(file_FullName)
										Application.DoEvents();
										//ElseIf LCase(file_Extension).Equals(".wav") Then
										//    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)
									}
									else if (file_Extension.ToLower().Equals(".wma"))
									{
										MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension);
									}
									else if (file_Extension.ToLower().Equals(".tif"))
									{
										//** This functionality will be added at a later time
										//KAT.getXMPdata(file_FullName)
										Application.DoEvents();
									}
									Application.DoEvents();
									if ((file_Extension.ToLower().Equals(".doc") || file_Extension.ToLower().Equals(".docx")) && ckMetaData.Equals("Y"))
									{
										GetWordDocMetadata(file_FullName, SourceGuid, file_Extension);
										GC.Collect();
									}
									if ((file_Extension.Equals(".xls") || file_Extension.Equals(".xlsx") || file_Extension.Equals(".xlsm")) && ckMetaData.Equals("Y"))
									{
										GetExcelMetaData(file_FullName, SourceGuid, file_Extension);
										GC.Collect();
									}
									LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "STOP", UpdateTimer2);
								}
								
								TS = DateTime.Now.Subtract(sTime);
								sMin = TS.Minutes.ToString();
								sSec = TS.Seconds.ToString();
								frmNotify.Default.lblFileSpec.Text = (string) ("Size: " + BytesLoading.ToString() + Units + " / " + TS.Hours.ToString() + ":" + sMin + ":" + sSec);
								frmNotify.Default.Refresh();
								Application.DoEvents();
								
								isZipFile = ZF.isZipFile(file_FullName);
								if (isZipFile == true)
								{
									string ExistingParentZipGuid = DB.GetGuidByFqn(file_FullName, "0");
									bExplodeZipFile = false;
									StackLevel = 0;
									ListOfFiles.Clear();
									if (ExistingParentZipGuid.Length > 0)
									{
										DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, false);
										ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
										//ZipFilesContent.Add(file_FullName.Trim + "|" + ExistingParentZipGuid)
									}
									else
									{
										DBLocal.addZipFile(file_FullName, SourceGuid, false);
										ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
										//ZipFilesContent.Add(file_FullName.Trim + "|" + SourceGuid)
									}
								}
								
							}
NextFile:
							if (UseThreads == false)
							{
								SB5.Text = (string) ("Processing Dir: " + FolderName + " # " + K.ToString());
							}
							if (ddebug)
							{
								LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8032");
							}
							Application.DoEvents();
							
							if (modGlobals.gTerminateImmediately)
							{
								if (UseThreads == false)
								{
									SB5.Text = "Terminated archive!";
								}
								frmNotify.Default.Close();
								modGlobals.gContentArchiving = false;
								My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
								My.Settings.Default.Save();
								return;
							}
							
							if (ckArchiveBit == true && file_name != null)
							{
								DMA.setArchiveBitOff(file_FullName);
							}
DoneWithIt:
							//******************************************************
							if (DeleteOnArchive.Equals("Y") && ThisFileNeedsToBeDeleted && file_FullName != null)
							{
								LOG.WriteToTimerLog("ArchiveContent-01", (string) ("Archive File:" + file_FullName), "DELETED", UpdateTimerMain);
								try
								{
									ListOfFilesToDelete[file_FullName] = "DELETE";
									//ISO.saveIsoFile(" FilesToDelete.dat", file_FullName + "|")
									//File.Delete(file_FullName)
								}
								catch (Exception)
								{
									LOG.WriteToArchiveLog((string) ("ERROR Failed to DELETE: " + file_FullName));
								}
							}
							else if (DeleteOnArchive.Equals("Y") && ThisFileNeedsToBeMoved && file_FullName != null)
							{
								LOG.WriteToTimerLog("ArchiveContent-01", (string) ("Archive File:" + file_FullName), "MOVED", UpdateTimerMain);
								try
								{
									FileInfo FI = new FileInfo(file_FullName);
									string fNameOnly = FI.Name;
									string fDirName = FI.DirectoryName;
									string NewName = ERR_FQN + "\\" + fNameOnly;
									FI = null;
									File.Move(file_FullName, NewName);
								}
								catch (Exception)
								{
									LOG.WriteToArchiveLog((string) ("ERROR Failed to MOVE: " + file_FullName));
								}
							}
							//******************************************************
							if (file_FullName != null)
							{
								LOG.WriteToTimerLog("ArchiveContent-01", (string) ("Archive File:" + file_FullName), "STOP", UpdateTimerMain);
							}
						}
					}
					else
					{
						if (ddebug)
						{
							Debug.Print((string) ("Duplicate Folder: " + FolderName));
						}
						if (ddebug)
						{
							LOG.WriteToArchiveLog("frmReconMain : InsertSourcefile :Success: 8034");
						}
					}
NextFolder:
					pFolder = FolderName;
					if (modGlobals.gTerminateImmediately)
					{
						this.Cursor = Cursors.Default;
						if (UseThreads == false)
						{
							SB5.Text = "Terminated archive!";
						}
						frmNotify.Default.Close();
						modGlobals.gContentArchiving = false;
						My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
						My.Settings.Default.Save();
						return;
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("FATAL ERROR: ArchiveContent " + ex.Message));
			}
			finally
			{
				if (DeleteOnArchive.Equals("Y"))
				{
					foreach (string FQN in ListOfFilesToDelete.Keys)
					{
						int IDX = ListOfFilesToDelete.IndexOfKey(FQN);
						string tAction = ListOfFilesToDelete.Values(IDX);
						try
						{
							if (tAction.Equals("DELETE"))
							{
								if (File.Exists(FQN))
								{
									ISO.saveIsoFile(" FilesToDelete.dat", FQN + "|");
									File.Delete(FQN);
								}
							}
							else if (tAction.Equals("MOVE"))
							{
								if (File.Exists(FQN))
								{
									FileInfo FI = new FileInfo(FQN);
									string fNameOnly = FI.Name;
									string fDirName = FI.DirectoryName;
									string NewName = ERR_FQN + "\\" + fNameOnly;
									FI = null;
									File.Move(FQN, NewName);
								}
							}
							else
							{
								LOG.WriteToArchiveLog("ERROR/Advisory Notice - File " + FQN + " had no known disposition, it was moved to the error directory.");
								if (File.Exists(FQN))
								{
									FileInfo FI = new FileInfo(FQN);
									string fNameOnly = FI.Name;
									string fDirName = FI.DirectoryName;
									string NewName = ERR_FQN + "\\" + fNameOnly;
									FI = null;
									File.Move(FQN, NewName);
								}
							}
						}
						catch (Exception ex)
						{
							if (! modGlobals.gRunUnattended)
							{
								MessageBox.Show((string) ("Could not remove the file " + FQN + "." + "\r\n" + ex.Message));
							}
							else
							{
								LOG.WriteToArchiveLog((string) ("Could not remove the file " + FQN + ". - " + ex.Message));
							}
						}
					}
				}
			}
			
			
			if (UseThreads == false)
			{
				SB5.Text = "Files Completed";
			}
			PBx.Value = 0;
			
			//Timer1.Enabled = True
			if (ddebug)
			{
				LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with Content Archive.");
			}
			
			PROC.getProcessesToKill();
			PROC.KillOrphanProcesses();
			//FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
			
			
			StackLevel = 0;
			ListOfFiles.Clear();
			
			for (int i = 0; i <= modGlobals.ZipFilesContent.Count - 1; i++)
			{
				bExplodeZipFile = false;
				//FrmMDIMain.SB.Text = "Processing Quickref"
				//If i >= 24 Then
				//    Debug.Print("here")
				//End If
				string cData = modGlobals.ZipFilesContent[i].ToString();
				string ParentGuid = "";
				string FQN = "";
				int K = cData.IndexOf("|") + 1;
				FQN = cData.Substring(0, K - 1);
				ParentGuid = cData.Substring(K + 1 - 1);
				ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
			}
			
			ListOfFiles = null;
			GC.Collect();
			
			frmNotify.Default.Close();
			modGlobals.gContactsArchiving = false;
			modGlobals.gContentArchiving = false;
			
			My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
			My.Settings.Default.Save();
			
			
			frmNotify.Default.lblFileSpec.Text = "Content archive complete.";
			frmNotify.Default.Refresh();
			
		}
		
		public void ArchiveData(string UID, string ContainerName, string TopFolder, SortedList SL)
		{
			
			CompletedPolls++;
			SB.Text = DateTime.Now + " : Archiving data... standby: " + CompletedPolls.ToString();
			
			string[] ActiveFolders = new string[1];
			string FolderName = "";
			bool DeleteFile = false;
			
			string ArchiveEmails = "";
			string RemoveAfterArchive = "";
			string SetAsDefaultFolder = "";
			string ArchiveAfterXDays = "";
			string RemoveAfterXDays = "";
			string RemoveXDays = "";
			string ArchiveXDays = "";
			string DB_ID = "";
			string ArchiveOnlyIfRead = "";
			
			string[] EmailFolders = new string[1];
			
			DB.GetEmailFolders(modGlobals.gCurrUserGuidID, ref EmailFolders);
			
			for (int i = 0; i <= (EmailFolders.Length - 1); i++)
			{
				FolderName = EmailFolders[i].ToString().Trim();
				bool BB = DB.GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, FolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
				if (BB)
				{
					
					//ARCH.getSubFolderEmails(FolderName , bDeleteMsg)
					ARCH.getSubFolderEmailsSenders(UID, TopFolder, FolderName, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, ContainerName);
					//ARCH.GetEmails(FolderName , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , DB_ID )
				}
			}
			
		}
		
		//    Public Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
		//        If ckDisable.Checked Then
		//            SB.Text = "DISABLE ALL is checked - no archive allowed."
		//            Return
		//        End If
		//        Dim frm As Form
		//        Try
		//            For Each frm In My.Application.OpenForms
		//                Application.DoEvents()
		//                If frm Is My.Forms.frmNotify Then
		//                    Return
		//                End If
		//                If frm Is My.Forms.frmNotify2 Then
		//                    Return
		//                End If
		//                If frm Is My.Forms.frmExchangeMonitor Then
		//                    Return
		//                End If
		//            Next
		//        Catch ex As Exception
		//            Console.WriteLine("Timer1_Tick forms")
		//        End Try
		//        frm = Nothing
		
		//        If Not t2 Is Nothing Then
		//            If t2.IsAlive Then
		//                Return
		//            End If
		//        End If
		//        If Not t3 Is Nothing Then
		//            If t3.IsAlive Then
		//                Return
		//            End If
		//        End If
		//        If Not t4 Is Nothing Then
		//            If t4.IsAlive Then
		//                Return
		//            End If
		//        End If
		//        If Not t5 Is Nothing Then
		//            If t5.IsAlive Then
		//                Return
		//            End If
		//        End If
		
		//        Timer1.Enabled = False
		
		//        Dim LastYearArchive As Integer = 0
		//        Dim LastMonthArchive As Integer = 0
		//        Dim LastDayArchive As Integer = 0
		//        Dim LastMinuteArchive As Integer = 0
		
		//        Dim TodayYear As Integer = Now.Year
		//        Dim TodayDay As Integer = Now.Day
		//        Dim TodayMonth As Integer = Now.Month
		//        Dim TodayMinute As Integer = Now.Minute
		//        Dim TodayHour As Integer = Now.Hour
		
		//        Dim TS As TimeSpan = Nothing
		
		//        Dim Days As Integer = 0
		//        Dim Hours As Integer = 0
		
		//        '** Now, we determine if we archive or not
		
		//        Application.DoEvents()
		//        Dim isDisabled As Boolean = False
		
		//        If ckDisable.Checked = True Then
		//            SB.Text = "ALL Archive disabled - " + Now.ToString
		//            'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString
		//            Timer1.Enabled = True
		
		//            If DB.isArchiveDisabled("ALL") = True Then
		//                isDisabled = True
		//                SB.Text = "ALL Archive disabled - " + Now.ToString
		//                'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString
		//            Else
		//                isDisabled = True
		//                SB.Text = "Archive disabled - " + Now.ToString
		//                'FrmMDIMain.SB.Text = "Archive disabled " + Now.ToString
		//            End If
		
		//            ArchiveALLToolStripMenuItem.Enabled = True
		//            ContentToolStripMenuItem.Enabled = True
		//            ExchangeEmailsToolStripMenuItem.Enabled = True
		//            OutlookEmailsToolStripMenuItem.Enabled = True
		
		//            'LOG.WriteToArchiveLog("ALL Archive disabled.")
		
		//            Return
		//        Else
		//            SB.Text = "Archive enabled - " + Now.ToString
		//            'FrmMDIMain.SB.Text = "Archive enabled " + Now.ToString
		//            Timer1.Enabled = True
		//            ArchiveALLToolStripMenuItem.Enabled = True
		//            ContentToolStripMenuItem.Enabled = True
		//            ExchangeEmailsToolStripMenuItem.Enabled = True
		//            OutlookEmailsToolStripMenuItem.Enabled = True
		//            If gIsServiceManager = True Then
		//                LOG.WriteToArchiveLog("ServiceManager Archive.")
		//                gbPolling.Enabled = False
		//                ckUseLastProcessDateAsCutoff.Enabled = False
		//                btnRefreshFolders.Enabled = False
		//                btnActive.Enabled = False
		//                cbParentFolders.Enabled = False
		//                lbActiveFolder.Enabled = False
		//                ckArchiveFolder.Enabled = False
		//                ckArchiveRead.Enabled = False
		//                ckRemove.Enabled = False
		//                ckArchAfterDays.Enabled = False
		//                NumericUpDown2.Enabled = False
		//                ckRemoveAfterXDays.Enabled = False
		//                NumericUpDown3.Enabled = False
		//                ckSystemFolder.Enabled = False
		//                cbEmailRetention.Enabled = False
		//                btnSaveConditions.Enabled = False
		//                btnDeleteEmailEntry.Enabled = False
		//                OutlookEmailsToolStripMenuItem.Enabled = False
		//                ExchangeEmailsToolStripMenuItem.Enabled = False
		//                ContentToolStripMenuItem.Enabled = False
		//                ArchiveALLToolStripMenuItem.Enabled = False
		//                ckArchiveBit.Enabled = True
		//            End If
		//        End If
		
		//        Dim RetentionCode  = cbEmailRetention.Text
		//        Dim RetentionYears As Integer = 0
		//        RetentionYears = DB.getRetentionPeriod(RetentionCode )
		
		//        If gCurrentArchiveGuid.Length = 0 Then
		//            gCurrentArchiveGuid  = Guid.NewGuid.ToString
		//        End If
		
		//        Dim UnitValue  = ""
		//        Dim ArchiveType  = ""
		//        ArchiveType  = DB.getRconParm(gCurrUserGuidID, "ArchiveType")
		//        UnitValue  = DB.getRconParm(gCurrUserGuidID, "ArchiveInterval")
		
		//        Dim CurrStatus  = "Running"
		//        Dim WC  = STATS.wc_PI02_ArchiveStats(CurrStatus , gCurrUserGuidID)
		
		//        ArchiveALLToolStripMenuItem.Enabled = False
		//        ContentToolStripMenuItem.Enabled = False
		//        ExchangeEmailsToolStripMenuItem.Enabled = False
		//        OutlookEmailsToolStripMenuItem.Enabled = False
		
		//        Dim LastSuccessFullArchiveDate As Date = Now
		//        Dim BackupNow As Boolean = False
		
		//        '***********************************************************************************************
		//        LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
		//        '***********************************************************************************************
		
		//        If LastSuccessFullArchiveDate = Nothing Then
		//            LOG.WriteToArchiveLog("Last Archivesuccessful - ready for archive to execute.")
		//            BackupNow = True
		//        Else
		//            LastYearArchive = LastSuccessFullArchiveDate.Year
		//            LastMonthArchive = LastSuccessFullArchiveDate.Month
		//            LastDayArchive = LastSuccessFullArchiveDate.Day
		//            LastMinuteArchive = LastSuccessFullArchiveDate.Minute
		//            LOG.WriteToArchiveLog("Last Archivesuccessful RESET.")
		//        End If
		//        SB.Text = "AUTO Archive running"
		//        SB2.Text = "AUTO Archive running"
		//        If ArchiveType .Equals("Disable") Then
		//            LOG.WriteToArchiveLog("Archive Type is DISABLED.")
		//            Timer1.Enabled = True
		//            ArchiveALLToolStripMenuItem.Enabled = True
		//            ContentToolStripMenuItem.Enabled = True
		//            ExchangeEmailsToolStripMenuItem.Enabled = True
		//            OutlookEmailsToolStripMenuItem.Enabled = True
		//            Return
		//        ElseIf ArchiveType .Equals("Monthly") Then
		//            'lblUnit.Text = "day of the month"
		//            SB.Text = "Backup every month on day " + UnitValue
		//            LOG.WriteToArchiveLog("Backup every month on day " + UnitValue )
		//            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
		
		//            LastYearArchive = 0
		//            LastMonthArchive = 0
		//            LastDayArchive = 0
		//            LastMinuteArchive = 0
		
		//            TS = Now.Subtract(LastSuccessFullArchiveDate)
		//            Days = TS.Days
		
		//            If LastMonthArchive = 12 And LastSuccessFullArchiveDate.Month = 1 Then
		//                LastMonthArchive = 0
		//            End If
		//            If Now.Month >= LastSuccessFullArchiveDate.Month Then
		//                BackupNow = True
		//            End If
		//            LOG.WriteToArchiveLog("Backup every month Backup Now is " + BackupNow.ToString)
		//            If BackupNow = True And Now.Month = LastSuccessFullArchiveDate.Month Then
		//                If CInt(UnitValue ) < TodayDay Then
		//                    LOG.WriteToArchiveLog("Backup every month Backup Now is NOT due.")
		//                    ArchiveALLToolStripMenuItem.Enabled = True
		//                    ContentToolStripMenuItem.Enabled = True
		//                    ExchangeEmailsToolStripMenuItem.Enabled = True
		//                    OutlookEmailsToolStripMenuItem.Enabled = True
		//                    Return
		//                Else
		//                    BackupNow = True
		//                    LOG.WriteToArchiveLog("Backup every month Backup Now is DUE.")
		//                    GoTo DoItNow
		//                End If
		//            End If
		//            If Now.Month > LastSuccessFullArchiveDate.Month Then
		//                BackupNow = True
		//            Else
		//                Return
		//            End If
		//        ElseIf ArchiveType .Equals("Daily") Then
		//            'lblUnit.Text = "time of day (24 hr) clock"
		//            SB.Text = "Backup daily immediately after " + UnitValue  + " hours."
		//            LOG.WriteToArchiveLog("Backup daily immediately after " + UnitValue )
		//            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
		//            If LastSuccessFullArchiveDate = Nothing Then
		//                LOG.WriteToArchiveLog("Backup daily immediately BackupNow =  " + BackupNow.ToString)
		//                BackupNow = True
		//            Else
		
		//                LastYearArchive = LastSuccessFullArchiveDate.Year
		//                LastMonthArchive = LastSuccessFullArchiveDate.Month
		//                LastDayArchive = LastSuccessFullArchiveDate.Day
		//                LastMinuteArchive = LastSuccessFullArchiveDate.Minute
		
		//                'Dim DayOfWeek  = LastSuccessFullArchiveDate.DayOfWeek.ToString
		
		//                'If DayOfWeek .ToUpper.Equals("SUNDAY") Then
		
		//                'End If
		
		//                Dim BackupHour As Integer = CInt(UnitValue ) / 100
		
		//                TS = Now.Subtract(LastSuccessFullArchiveDate)
		//                Hours = TS.Hours
		
		//                If Hours >= 24 And Val(UnitValue ) >= Now.Hour Then
		//                    LOG.WriteToArchiveLog("Backup daily immediately BackupNow is TRUE")
		//                    BackupNow = True
		//                Else
		//                    LOG.WriteToArchiveLog("Backup daily immediately BackupNow is False")
		//                    BackupNow = False
		//                    Return
		//                End If
		//            End If
		//        ElseIf ArchiveType .Equals("Hourly") Then
		//            'lblUnit.Text = "minutes past the hour"
		//            SB.Text = "Backup hourly immediately " + UnitValue  + " minutes after the hour."
		//            LOG.WriteToArchiveLog("Backup hourly immediately " + UnitValue  + " minutes after the hour.")
		//            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
		
		//            LastYearArchive = LastSuccessFullArchiveDate.Year
		//            LastMonthArchive = LastSuccessFullArchiveDate.Month
		//            LastDayArchive = LastSuccessFullArchiveDate.Day
		//            LastMinuteArchive = LastSuccessFullArchiveDate.Minute
		
		//            TS = Now.Subtract(LastSuccessFullArchiveDate)
		//            Hours = TS.Hours
		
		//            If Hours >= 1 Then
		//                LOG.WriteToArchiveLog("Backup hourly is TRUE - 1.")
		//                BackupNow = True
		//            Else
		//                ArchiveALLToolStripMenuItem.Enabled = True
		//                ContentToolStripMenuItem.Enabled = True
		//                ExchangeEmailsToolStripMenuItem.Enabled = True
		//                OutlookEmailsToolStripMenuItem.Enabled = True
		//                LOG.WriteToArchiveLog("Backup hourly is NOT TRUE - 2.")
		//                Return
		//            End If
		//        ElseIf ArchiveType .Equals("Minutes") Then
		//            'lblUnit.Text = "minutes"
		//            SB.Text = "Backup every " + UnitValue  + " minutes."
		//            LOG.WriteToArchiveLog("Backup every " + UnitValue  + " minutes.")
		//            LastSuccessFullArchiveDate = DB.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
		
		//            LastYearArchive = LastSuccessFullArchiveDate.Year
		//            LastMonthArchive = LastSuccessFullArchiveDate.Month
		//            LastDayArchive = LastSuccessFullArchiveDate.Day
		//            LastMinuteArchive = LastSuccessFullArchiveDate.Minute
		
		//            TS = Now.Subtract(LastSuccessFullArchiveDate)
		//            Dim Minutes As Integer = TS.Minutes
		
		//            If Minutes >= Val(UnitValue ) Then
		//                BackupNow = True
		//            Else
		//                BackupNow = False
		//            End If
		
		//        Else
		//            Timer1.Enabled = True
		//            ArchiveALLToolStripMenuItem.Enabled = True
		//            ContentToolStripMenuItem.Enabled = True
		//            ExchangeEmailsToolStripMenuItem.Enabled = True
		//            OutlookEmailsToolStripMenuItem.Enabled = True
		//            LOG.WriteToArchiveLog("Backup NOW NOT TRUE : 1 ")
		//            Return
		//        End If
		//DoItNow:
		
		//        LOG.WriteToArchiveLog("Scheduled Archive stared @ " + Now.ToString)
		
		//        '******************************
		//        SetUnattendedFlag()
		//        '******************************
		
		//        If BackupNow Then
		
		//            STATS.setArchivestartdate(Now.ToString)
		//            STATS.setArchiveenddate(Now.ToString)
		//            STATS.setArchivetype(ArchiveType )
		//            STATS.setStatguid(gCurrentArchiveGuid)
		//            STATS.setStatus("Running")
		//            STATS.setSuccessful("N")
		//            STATS.setUserid(gCurrUserGuidID)
		//            STATS.setTotalcontentinrepository("0")
		//            STATS.setTotalemailsinrepository("0")
		
		//            Me.SB.Text = "Scheduled Archive Starting."
		//            SB.Refresh()
		//            Application.DoEvents()
		
		//            gbEmail.Enabled = False
		//            gbContentMgt.Enabled = False
		
		//            '*****************************************************
		//            ArchiveALLToolStripMenuItem_Click(Nothing, Nothing)
		//            '*****************************************************
		
		//            gbEmail.Enabled = True
		//            gbContentMgt.Enabled = True
		
		//            Cursor = Cursors.Default
		
		//            ALR.ProcessAutoReferences()
		
		//            Cursor = Cursors.Default
		
		//            '*********************************************
		//            '** WDM DB.UpdateAttachmentCounts()
		//            '*********************************************
		
		//            TimerEndRun.Enabled = True
		
		//            Cursor = Cursors.Default
		//        End If
		
		//        ArchiveALLToolStripMenuItem.Enabled = True
		//        ContentToolStripMenuItem.Enabled = True
		//        ExchangeEmailsToolStripMenuItem.Enabled = True
		//        OutlookEmailsToolStripMenuItem.Enabled = True
		
		//        LOG.WriteToArchiveLog("Scheduled Archive ended @ " + Now.ToString)
		//        Timer1.Enabled = True
		
		//        SB.Text = "AUTO Archive complete"
		//        SB2.Text = "AUTO Archive complete"
		
		//    End Sub
		
		public void btnDeleteEmailEntry_Click(System.Object sender, System.EventArgs e)
		{
			ParentFolder = cbParentFolders.Text;
			
			if (ParentFolder.Trim().Length == 0)
			{
				MessageBox.Show("Please select a Parent Folder to process.");
				return;
			}
			
			string msg = "This will remove the selected mail folder from the archive process, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Remove Email Folder", MessageBoxButtons.YesNo);
			
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			this.Cursor = Cursors.AppStarting;
			
			foreach (string S in lbActiveFolder.SelectedItems)
			{
				try
				{
					string FolderName = ParentFolder + "|" + S.ToString();
					Debug.Print(FolderName);
					string[] aParms = new string[1];
					
					//PARMS.EmailFolderName  = FolderName
					EMPARMS.setFoldername(ref FolderName);
					EMPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					
					//** Remove it from the parameter table.
					string WhereClause = "Where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and [FolderName] = \'" + FolderName + "\'";
					EMPARMS.Delete(WhereClause);
					
					//** Reset the archive flag.
					string WC = "where FolderName = \'" + FolderName + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
					//DB.UpdateArchiveFlag(ParentFolder, gCurrUserGuidID, "N", S.ToString)
					DB.DeleteEmailArchiveFolder(ParentFolder, modGlobals.gCurrUserGuidID, "N", FolderName);
					
				}
				catch (Exception ex)
				{
					Console.WriteLine(ex.Message);
				}
			}
			
			DB.GetActiveEmailFolders(ParentFolder, lbActiveFolder, modGlobals.gCurrUserGuidID, modGlobals.CF, ArchivedEmailFolders);
			
			DB.setActiveEmailFolders(ParentFolder, modGlobals.gCurrUserGuidID);
			
			DB.CleanUpEmailFolders();
			
			this.Cursor = Cursors.Default;
		}
		
		
		public void AddFileAttributes()
		{
			
			InsertAttrib("FILESIZE", "Byte length of a file", "INT");
			InsertAttrib("FILENAME", "The name of a file", "varchar");
			InsertAttrib("FQN", "The fully qualified name of a file", "varchar");
			InsertAttrib("ChangeDate", "The last date the file was updated", "datetime");
			InsertAttrib("CreateDate", "The CREATION date the file was updated", "datetime");
			InsertAttrib("WriteDate", "The last time the file was written to", "datetime");
			
		}
		public void InsertAttrib(string aName, string aDesc, string aType)
		{
			ATTRIB.setAttributename(ref aName);
			ATTRIB.setAttributedesc(ref aDesc);
			ATTRIB.setAttributedatatype(ref aType);
			ATTRIB.Insert();
		}
		
		public void InsertSrcAttrib(string SGUID, string aName, string aVal, string OriginalFileType)
		{
			SRCATTR.setSourceguid(ref SGUID);
			SRCATTR.setAttributename(ref aName);
			SRCATTR.setAttributevalue(ref aVal);
			SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
			SRCATTR.setSourcetypecode(ref OriginalFileType);
			SRCATTR.Insert();
		}
		
		public void UpdateSrcAttrib(string SGUID, string aName, string aVal, string SourceType)
		{
			int iCnt = SRCATTR.cnt_PK35(aName, modGlobals.gCurrUserGuidID, SGUID);
			if (iCnt == 0)
			{
				SRCATTR.setSourceguid(ref SGUID);
				SRCATTR.setAttributename(ref aName);
				SRCATTR.setAttributevalue(ref aVal);
				SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
				SRCATTR.setSourcetypecode(ref SourceType);
				SRCATTR.Insert();
			}
			else
			{
				string WC = SRCATTR.wc_PK35(aName, modGlobals.gCurrUserGuidID, SGUID);
				SRCATTR.setSourceguid(ref SGUID);
				SRCATTR.setAttributename(ref aName);
				SRCATTR.setAttributevalue(ref aVal);
				SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
				SRCATTR.setSourcetypecode(ref SourceType);
				SRCATTR.Update(WC);
			}
			
		}
		
		public void GetWordDocMetadata(string FQN, string SourceGUID, string OriginalFileType)
		{
			try
			{
				string TempDir = System.IO.Path.GetTempPath();
				string fName = DMA.getFileName(FQN);
				string NewFqn = TempDir + fName;
				
				File.Copy(FQN, NewFqn, true);
				
				clsMsWord WDOC = new clsMsWord();
				WDOC.initWordDocMetaData(NewFqn, SourceGUID, OriginalFileType);
				
				ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|");
				//File.Delete(NewFqn )
			}
			catch (Exception ex)
			{
				DB.xTrace(3655, "Failed to process word metadata", "GetWordDocMetadata", ex);
				LOG.WriteToArchiveLog((string) ("Failed to process word metadata: GetWordDocMetadata" + ex.Message));
			}
			
		}
		public void GetExcelMetaData(string FQN, string SourceGUID, string OriginalFileType)
		{
			
			string TempDir = System.IO.Path.GetTempPath();
			string fName = DMA.getFileName(FQN);
			string NewFqn = TempDir + fName;
			
			try
			{
				try
				{
					File.Copy(FQN, NewFqn, true);
					clsMsWord WDOC = new clsMsWord();
					WDOC.initExcelMetaData(NewFqn, SourceGUID, OriginalFileType);
					WDOC = null;
				}
				catch (Exception ex)
				{
					DB.xTrace(340123, "Failed to open XL work book.", FQN, ex);
					LOG.WriteToArchiveLog((string) ("Failed to open XL work book: GetExcelMetaData" + ex.Message));
				}
				finally
				{
					ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|");
					//File.Delete(NewFqn )
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: GetExcelMetaData" + ex.Message));
			}
			
			
			
		}
		public bool InclAddList(ListBox LB, string UserGuid, string PassedFQN)
		{
			
			for (int i = 0; i <= LB.Items.Count - 1; i++)
			{
				INL.setExtcode(LB.Items[i].ToString());
				INL.setFqn(PassedFQN);
				INL.setUserid(UserGuid);
				INL.Insert();
			}
			return true;
		}
		public bool ExcludeAddList(ListBox LB, string UserGuid, string PassedFQN)
		{
			
			for (int i = 0; i <= LB.Items.Count - 1; i++)
			{
				this.EXL.setExtcode(LB.Items[i].ToString());
				EXL.setFqn(PassedFQN);
				EXL.setUserid(UserGuid);
				Debug.Print((string) (LB.Items[i].ToString() + " : " + PassedFQN));
				EXL.Insert();
			}
			return true;
		}
		public bool ExlAddList(ListBox LB, string PassedFQN, string typeCode, bool InclSubDirs)
		{
			
			//For i As Integer = 0 To LB.Items.Count - 1
			//    EXL.setExtcode(LB.Items(i).ToString)
			//    EXL.setFqn(PassedFQN)
			//    EXL.setUserid(gCurrUserGuidID)
			//    EXL.Insert()
			//Next
			
			List<string> lDirs = new List<string>();
			bool B = false;
			
			lDirs.Clear();
			lDirs.Add(PassedFQN);
			
			if (InclSubDirs)
			{
				addSubDirs(PassedFQN, lDirs);
			}
			
			//UserID = gCurrUserGuidID
			//FQN = PassedFQN
			//FQN = UTIL.RemoveSingleQuotes(FQN)
			//ExtCode = typeCode
			
			for (int i = 0; i <= lDirs.Count - 1; i++)
			{
				PassedFQN = lDirs.Item(i).ToString();
				PassedFQN = UTIL.RemoveSingleQuotes(PassedFQN);
				EXL.setExtcode(typeCode);
				EXL.setFqn(PassedFQN);
				EXL.setUserid(modGlobals.gCurrUserGuidID);
				string WC = "where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + PassedFQN + "\' and Extcode = \'" + typeCode + "\' ";
				int II = DB.iGetRowCount("ExcludedFiles", WC);
				if (II == 0)
				{
					B = EXL.Insert();
				}
				this.SB.Text = (string) ("Processing subdir #" + i.ToString() + " : " + PassedFQN);
				Application.DoEvents();
			}
			//LB.Items.Add(typeCode)
			return B;
			
//			return true;
		}
		public void GetAllSubDirs(List<string> lDirs, string PassedFQN)
		{
			lDirs.Clear();
			lDirs.Add(PassedFQN);
			addSubDirs(PassedFQN, lDirs);
		}
		public bool AddList(ListBox LB, string PassedFQN, string typeCode, bool InclSubDirs)
		{
			
			List<string> lDirs = new List<string>();
			bool B = false;
			
			lDirs.Clear();
			lDirs.Add(PassedFQN);
			
			if (InclSubDirs)
			{
				addSubDirs(PassedFQN, lDirs);
			}
			
			//UserID = gCurrUserGuidID
			//FQN = PassedFQN
			//FQN = UTIL.RemoveSingleQuotes(FQN)
			//ExtCode = typeCode
			
			for (int i = 0; i <= lDirs.Count - 1; i++)
			{
				PassedFQN = lDirs.Item(i).ToString();
				PassedFQN = UTIL.RemoveSingleQuotes(PassedFQN);
				INL.setExtcode(typeCode);
				INL.setFqn(PassedFQN);
				INL.setUserid(modGlobals.gCurrUserGuidID);
				string WC = "where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + PassedFQN + "\' and Extcode = \'" + typeCode + "\' ";
				int II = DB.iGetRowCount("IncludedFiles", WC);
				if (II == 0)
				{
					B = INL.Insert();
				}
				this.SB.Text = (string) ("Processing subdir #" + i.ToString() + " : " + PassedFQN);
				Application.DoEvents();
			}
			//LB.Items.Add(typeCode)
			return B;
			
		}
		//Sub ArchiveEmails()
		//    ARCH.ArchiveAllEmail()
		//    SB2.Text = "Email Complete"
		//End Sub
		public void saveStartUpParms()
		{
			if (! formloaded)
			{
				return;
			}
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				return;
			}
			
			string NewVal = "";
			
			formloaded = false;
			
			bool B = false;
			
			//Dim ArchiveType  = Me.cbInterval.Text
			//RPARM.setUserid(gCurrUserGuidID)
			//RPARM.setParm("ArchiveType")
			//RPARM.setParmvalue(ArchiveType)
			//B = DB.ckReconParmExists(gCurrUserGuidID, "ArchiveType")
			//If Not B Then
			//    RPARM.Insert()
			//Else
			//    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveType'")
			//End If
			
			
			NewVal = "";
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("ArchiveInterval");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "ArchiveInterval");
			if (! B)
			{
				RPARM.Insert();
				//Else
				//    RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveInterval'")
			}
			
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				return;
			}
			
			NewVal = ckDisable.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("Disabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "Disabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'Disabled\'");
			}
			
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				return;
			}
			
			NewVal = this.ckDisableContentArchive.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("ContentDisabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "ContentDisabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'ContentDisabled\'");
			}
			
			NewVal = this.ckDisableOutlookEmailArchive.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("OutlookDisabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "OutlookDisabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'OutlookDisabled\'");
			}
			
			NewVal = this.ckDisableExchange.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("ExchangeDisabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "ExchangeDisabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'ExchangeDisabled\'");
			}
			
			NewVal = this.ckRssPullDisabled.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("RssPullDisabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "RssPullDisabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'RssPullDisabled\'");
			}
			
			NewVal = this.ckWebPageTrackerDisabled.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("WebPageTrackerDisabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "WebPageTrackerDisabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'WebPageTrackerDisabled\'");
			}
			
			NewVal = this.ckWebSiteTrackerDisabled.Checked.ToString();
			RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
			RPARM.setParm("WebSiteTrackerDisabled");
			RPARM.setParmvalue(ref NewVal);
			
			B = DB.ckReconParmExists(modGlobals.gCurrUserGuidID, "WebSiteTrackerDisabled");
			if (! B)
			{
				RPARM.Insert();
			}
			else
			{
				RPARM.Update("where userid = \'" + modGlobals.gCurrUserGuidID + "\' and Parm = \'WebSiteTrackerDisabled\'");
			}
			
			formloaded = true;
			
			SB.Text = "Startup parms saved...";
			
		}
		public void btnSaveSchedule_Click(System.Object sender, System.EventArgs e)
		{
			
			saveStartUpParms();
			
		}
		
		//Private Sub cbInterval_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
		//    Dim Interval  = cbInterval.Text
		//    cbTimeUnit.Items.Clear()
		
		//    If Interval.Equals("Monthly") Then
		//        lblUnit.Text = "day of the month"
		//        For ii As Integer = 1 To 31
		//            cbTimeUnit.Items.Add(ii)
		//        Next
		//        cbTimeUnit.Text = "1"
		//    End If
		//    If Interval.Equals("Daily") Then
		//        lblUnit.Text = "time of day (24 hr) clock"
		//        For ii As Integer = 1 To 24
		//            Dim C  = ii.ToString
		//            If C.Trim.Length = 1 Then
		//                C = "0" + C + "00"
		//            End If
		//            If C.Trim.Length = 2 Then
		//                C = C + "00"
		//            End If
		//            cbTimeUnit.Items.Add(C)
		//            'For III As Integer = 1 To 3
		//            '    If III = 1 Then
		//            '        C = Mid(C, 1, 2) + "15"
		//            '    End If
		//            '    If III = 2 Then
		//            '        C = Mid(C, 1, 2) + "30"
		//            '    End If
		//            '    If III = 2 Then
		//            '        C = Mid(C, 1, 2) + "45"
		//            '    End If
		//            '    cbTimeUnit.Items.Add(C)
		//            '    If ii = 1 Then
		//            '        cbTimeUnit.Text = "0030"
		//            '    End If
		//            'Next
		//        Next
		//    End If
		//    If Interval.Equals("Hourly") Then
		//        lblUnit.Text = "minutes past the hour"
		//        For ii As Integer = 0 To 59
		//            cbTimeUnit.Items.Add(ii)
		//        Next
		//        cbTimeUnit.Text = "15"
		//    End If
		//    If Interval.Equals("Minutes") Then
		//        lblUnit.Text = "minutes"
		//        For ii As Integer = 1 To 45
		//            cbTimeUnit.Items.Add(ii)
		//        Next
		//        cbTimeUnit.Text = "30"
		//    End If
		//End Sub
		
		private void cbTimeUnit_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void gbPolling_MouseHover(object sender, System.EventArgs e)
		{
			SB.Text = "Use these parameters to set up the archive execution.";
		}
		
		public void ckSubDirs_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void ckPublic_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void btnExclude_Click(System.Object sender, System.EventArgs e)
		{
			
			try
			{
				//If txtDir.Text.Trim.Length = 0 Then
				//    messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
				//    Return
				//End If
				string S1 = lbAvailExts.SelectedItem.ToString();
				
				foreach (string S in lbAvailExts.SelectedItems)
				{
					bool ItemAlreadyExists = false;
					for (int I = 0; I <= lbExcludeExts.Items.Count - 1; I++)
					{
						string ExistingItem = lbExcludeExts.Items[I];
						if (S.ToUpper().Equals(ExistingItem.ToUpper))
						{
							ItemAlreadyExists = true;
							break;
						}
					}
					if (ItemAlreadyExists == false)
					{
						lbExcludeExts.Items.Add(S);
						btnSaveChanges.BackColor = Color.OrangeRed;
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR btnInclFileType_Click : " + ex.Message));
				SB.Text = "Error - please refer to error log.";
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void btnRemoveExclude_Click(System.Object sender, System.EventArgs e)
		{
			
			SB.Text = "Profile maintenance selected, will not affect directory setup.";
			for (int i = lbExcludeExts.SelectedItems.Count; i >= 0; i--)
			{
				int II = lbExcludeExts.SelectedIndex;
				if (II >= 0)
				{
					lbExcludeExts.Items.RemoveAt(II);
				}
			}
			
			
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		public bool FolderExists(string FolderName)
		{
			
			string TgtFolder = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
			
			bool B = false;
			var OlApp = Interaction.CreateObject("Outlook.Application", "");
			var NmSpace = OlApp.GetNamespace("MAPI");
			var Mailbox = NmSpace.Folders("Mailbox - eBay Bidder"); // Set mailbox to eBay Bidder
			var Inbox = Mailbox.Folders("Inbox"); //olFolderInbox
			var MySubFolder = Inbox.Folders("eBay"); // Note Case Sensitive!
			var MySubFolder2 = MySubFolder.Folders("Auctions");
			var MySubFolder3 = MySubFolder2.Folders("Auctions WON");
			
			for (int I = 1; I <= MySubFolder3.Folders.Count; I++)
			{
				if (MySubFolder3.Folders(I) == FolderName)
				{
					B = true;
					break;
				}
				else
				{
					B = false;
				}
			}
			return B;
		}
		
		public void lbExcludeExts_TextChanged(object sender, System.EventArgs e)
		{
			string S1 = "";
			SortedList<string, string> SA = new SortedList<string, string>();
			
			for (int K = 0; K <= lbIncludeExts.Items.Count - 1; K++)
			{
				S1 = lbIncludeExts.SelectedItem.ToString().ToLower();
				if (SA.IndexOfKey(S1) < 0)
				{
					SA.Add(S1, S1);
				}
			}
			S1 = lbIncludeExts.SelectedItem.ToString();
			DMA.FixFileExtension(ref S1);
			bool B = true;
			for (int i = lbExcludeExts.Items.Count - 1; i >= 0; i--)
			{
				S1 = lbExcludeExts.Items[i].ToString();
				if (SA.IndexOfKey(S1) > 0)
				{
					lbExcludeExts.Items.RemoveAt(i);
				}
			}
		}
		
		public void txtDir_TextChanged(System.Object sender, System.EventArgs e)
		{
			if (txtDir.Text.IndexOf("%userid%") + 1 > 0)
			{
				clAdminDir.Checked = true;
			}
		}
		
		public void ckUseLastProcessDateAsCutoff_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			DB.UserParmInsertUpdate("ckUseLastProcessDateAsCutoff", modGlobals.gCurrUserGuidID, ckUseLastProcessDateAsCutoff.Checked.ToString());
		}
		
		public void frmReconMain_Resize(object sender, System.EventArgs e)
		{
			
			if (formloaded == false)
			{
				return;
			}
			modResizeForm.ResizeControls(this);
			
		}
		public void resetBadDates()
		{
			
			string S = "Update Email set CreationDate = getdate() where CreationDate is NULL ;";
			bool B = DB.ExecuteSqlNewConn(S);
			
			S = "update Email set SentOn = CreationDate where SentOn > \'1/1/4500\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			B = DB.ExecuteSqlNewConn(S);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning : Check email senton dates as some were found to be invalid in the emails.");
			}
		}
		
		public void GetExchangeFolders(bool bNewThread)
		{
			
			if (DB.isArchiveDisabled("EXCHANGE") == true)
			{
				return;
			}
			
			clsEmailFunctions EM = new clsEmailFunctions();
			if (modGlobals.gCurrentArchiveGuid.Length == 0)
			{
				modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
			}
			
			LOG.WriteToArchiveLog("GetExchangeFolders 100");
			//FrmMDIMain.SB.Text = "Archiving Exchange Folders - you can continue to work."
			
			if (bNewThread)
			{
				//SB.Text = "Launching Exchange Archive - it will run in background."
				if (ddebug)
				{
					LOG.WriteToTraceLog("Entering LaunchExchangeDownload from frmReconMain");
				}
				EM.LaunchExchangeDownload();
			}
			else
			{
				//SB.Text = "Launching Exchange Archive"
				if (ddebug)
				{
					LOG.WriteToTraceLog("Entering ProcessExchangePopMail from frmReconMain");
				}
				//FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
				modGlobals.gCurrUserGuidID = UIDcurr;
				EM.ProcessExchangeServers(UIDcurr);
				//FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
				//SB.Text = "Exchange archive complete."
			}
			if (modGlobals.gTerminateImmediately)
			{
				//Me.Cursor = Cursors.Default
				SB.Text = "Terminated archive!";
				return;
			}
			EM = null;
			GC.Collect();
			GC.WaitForFullGCComplete();
		}
		
		public void btnInclProfile_Click(System.Object sender, System.EventArgs e)
		{
			string pName = cbProfile.Text;
			if (pName.Trim.Length == 0)
			{
				MessageBox.Show("Please select a profile.");
				return;
			}
			pName = UTIL.RemoveSingleQuotes(pName);
			string S = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = \'" + pName + "\' order by SourceTypeCode";
			DB.PopulateListBoxMerge(this.lbIncludeExts, "SourceTypeCode", S);
			DB.PopulateListBoxRemove(this.lbExcludeExts, "SourceTypeCode", S);
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void btnExclProfile_Click(System.Object sender, System.EventArgs e)
		{
			string pName = cbProfile.Text;
			if (pName.Trim.Length == 0)
			{
				MessageBox.Show("Please select a profile.");
				return;
			}
			pName = UTIL.RemoveSingleQuotes(pName);
			string S = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = \'" + pName + "\' order by SourceTypeCode";
			DB.PopulateListBoxMerge(this.lbExcludeExts, "SourceTypeCode", S);
			DB.PopulateListBoxRemove(this.lbIncludeExts, "SourceTypeCode", S);
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void SetArchiveEndStats(string ArchiveType)
		{
			STATS.setArchiveenddate(DateTime.Now.ToString());
			STATS.setArchivetype(ref ArchiveType);
			STATS.setStatus("Successful");
			STATS.setSuccessful("Y");
			STATS.setUserid(ref modGlobals.gCurrUserGuidID);
			
			int iCnt = 0;
			iCnt = DB.iGetRowCount("DataSource", "where DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'");
			LOG.WriteToArchiveLog((string) ("Archive Count: Source Files - " + iCnt.ToString()));
			STATS.setTotalcontentinrepository(iCnt.ToString());
			iCnt = DB.iGetRowCount("Email", "where UserID = \'" + modGlobals.gCurrUserGuidID + "\'");
			LOG.WriteToArchiveLog((string) ("Archive Count: Emails - " + iCnt.ToString()));
			STATS.setTotalemailsinrepository(iCnt.ToString());
			
			iCnt = STATS.cnt_PK_ArchiveStats(modGlobals.gCurrentArchiveGuid);
			if (iCnt == 0)
			{
				bool BB = STATS.Insert();
				if (! BB)
				{
					LOG.WriteToArchiveLog("error 2345.01.1 - DID NOT INSERT STATS.");
				}
			}
			if (iCnt > 0)
			{
				string WC = STATS.wc_PK_ArchiveStats(modGlobals.gCurrentArchiveGuid);
				bool b = STATS.Update(WC);
				if (! b)
				{
					LOG.WriteToArchiveLog((string) ("Failed to update archive statistics: " + DateTime.Now.ToString()));
				}
			}
		}
		public void SetArchiveBeginStats(string ArchiveType, string NewGuid)
		{
			STATS.setArchivestartdate(DateTime.Now.ToString());
			STATS.setArchiveenddate(DateTime.Now.ToString());
			STATS.setArchivetype(ref ArchiveType);
			STATS.setStatguid(ref NewGuid);
			STATS.setStatus("Running");
			STATS.setSuccessful("N");
			STATS.setUserid(ref modGlobals.gCurrUserGuidID);
			STATS.setTotalcontentinrepository("0");
			STATS.setTotalemailsinrepository("0");
			
			int iCnt = 0;
			iCnt = DB.iGetRowCount("DataSource", "where DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'");
			STATS.setTotalcontentinrepository(iCnt.ToString());
			iCnt = DB.iGetRowCount("Email", "where UserID = \'" + modGlobals.gCurrUserGuidID + "\'");
			STATS.setTotalemailsinrepository(iCnt.ToString());
			
			iCnt = STATS.cnt_PK_ArchiveStats(NewGuid);
			if (iCnt == 0)
			{
				bool BB = STATS.Insert();
				if (! BB)
				{
					SB.Text = "error 2345.01.1a - DID NOT INSERT STATS.";
					LOG.WriteToArchiveLog("error 2345.01.1a - DID NOT INSERT STATS.");
				}
			}
			if (iCnt > 0)
			{
				string WC = STATS.wc_PK_ArchiveStats(NewGuid);
				bool b = STATS.Update(WC);
				if (! b)
				{
					SB.Text = "error 2345.01.1b - DID NOT INSERT STATS.";
					LOG.WriteToArchiveLog("error 2345.01.1b - DID NOT INSERT STATS.");
				}
			}
		}
		
		public void cbParentFolders_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			//If formloaded Then
			//    If cbParentFolders.Text.Trim.Length > 0 Then
			//        btnRefreshFolders_Click(Nothing, Nothing)
			//    End If
			//End If
			ParentFolder = cbParentFolders.Text.Trim();
		}
		
		public void ResetSelectedMailBoxesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string msg = "This will remove all of your mailbox selections" + "\r\n" + "it will not remove any archives. Are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Reset Email Folders", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			string S = "";
			S = "DELETE FROM [EmailArchParms] ";
			S = S + " WHERE UseriD = \'" + modGlobals.gCurrUserGuidID + "\'";
			
			bool B = DB.ExecuteSqlNewConn(S, false);
			if (B)
			{
				S = "DELETE FROM [EmailFolder] ";
				S = S + " WHERE UseriD = \'" + modGlobals.gCurrUserGuidID + "\'";
				
				B = DB.ExecuteSqlNewConn(S, false);
				
				if (B)
				{
					SB.Text = "Mailboxes successfully reset";
				}
				else
				{
					SB.Text = "Mailboxes DID NOT reset";
				}
				
			}
			else
			{
				SB.Text = "Mailboxes DID NOT reset";
			}
			
			if (DateTime.Now < DateTime.Parse("10/5/2009"))
			{
				string TgtFolder = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
				string SS = "update Email set originalfolder = \'" + TgtFolder + "\' + \'|\' + originalfolder where originalfolder not like \'%|%\' ";
				DB.ExecuteSqlNewConn(SS);
			}
			
		}
		
		public void ContextMenuStrip1_Opening(System.Object sender, System.ComponentModel.CancelEventArgs e)
		{
			
		}
		
		public void EmailLibraryReassignmentToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			//Me.lbArchiveDirs.SelectedItem.ToString
			string FolderName = this.lbActiveFolder.SelectedItem.ToString();
			FolderName = cbParentFolders.Text.Trim() + "|" + FolderName;
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			
			//frmLibraryAssignment.MdiParent = 'FrmMDIMain
			frmLibraryAssignment.Default.setFolderName(FolderName);
			frmLibraryAssignment.Default.SetTypeContent(false);
			frmLibraryAssignment.Default.Show();
			
		}
		
		public void cbFileDB_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void Label8_Click(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void lbAvailExts_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			if (lbAvailExts.SelectedItems.Count > 0)
			{
				btnInclFileType.Visible = true;
				btnExclude.Visible = true;
			}
			else
			{
				btnInclFileType.Visible = false;
				btnExclude.Visible = false;
			}
		}
		
		public void ckTerminate_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckTerminate.Checked == true)
			{
				modGlobals.gTerminateImmediately = true;
			}
			else
			{
				modGlobals.gTerminateImmediately = false;
			}
		}
		
		public void btnSaveDirProfile_Click(System.Object sender, System.EventArgs e)
		{
			
			string DirProfileName = cbDirProfile.Text.Trim();
			if (DirProfileName.Length == 0)
			{
				MessageBox.Show("A directory profile name must be supplied, returning.");
				return;
			}
			
			DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName);
			string Parms = buildDirProfileParms();
			string S = "Select count(*) from DirProfiles where ProfileName = \'" + DirProfileName + "\'";
			
			int iCnt = DB.iCount(S);
			
			if (iCnt == 0)
			{
				
				S = "";
				S = S + " INSERT INTO [DirProfiles]";
				S = S + " ([ProfileName]";
				S = S + " ,[Parms])";
				S = S + "  VALUES ";
				S = S + " (\'" + DirProfileName + "\'";
				S = S + " ,\'" + Parms + "\')";
				
				bool B = DB.ExecuteSqlNewConn(S);
				if (B)
				{
					SB.Text = (string) ("Added the new directory profile, " + DirProfileName);
					S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
					DB.PopulateComboBox(this.cbDirProfile, "ProfileName", S);
					cbDirProfile.Text = DirProfileName;
				}
				else
				{
					SB.Text = "Failed to add the directory profile, " + DirProfileName + " Please check the error logs.";
				}
			}
			else
			{
				MessageBox.Show("The profile named \'" + DirProfileName + "\' already exists in the repository, returning.");
				SB.Text = "The profile named \'" + DirProfileName + "\' already exists in the repository, returning.";
				return;
			}
			
		}
		
		public void btnApplyDirProfile_Click(System.Object sender, System.EventArgs e)
		{
			string DirProfileName = cbDirProfile.Text.Trim();
			if (DirProfileName.Length == 0)
			{
				MessageBox.Show("A directory profile name must be supplied, returning.");
				return;
			}
			
			bApplyingDirParms = true;
			
			string Parms = DB.getDirProfile(DirProfileName);
			applyDirProfileParms(Parms);
			
			bApplyingDirParms = false;
			btnSaveChanges.BackColor = Color.OrangeRed;
			
		}
		
		public void btnUpdateDirectoryProfile_Click(System.Object sender, System.EventArgs e)
		{
			
			string DirProfileName = cbDirProfile.Text.Trim();
			if (DirProfileName.Length == 0)
			{
				MessageBox.Show("A directory profile name must be supplied, returning.");
				return;
			}
			
			string Parms = buildDirProfileParms();
			
			DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName);
			string S = "Update DirProfiles set Parms = \'" + Parms + "\' where ProfileName = \'" + DirProfileName + "\'";
			bool B = DB.ExecuteSqlNewConn(S);
			if (B)
			{
				SB.Text = "Directory Profile: " + DirProfileName + " updated.";
			}
			else
			{
				SB.Text = "Directory Profile: " + DirProfileName + " failed to update.";
			}
			
		}
		
		public void btnDeleteDirProfile_Click(System.Object sender, System.EventArgs e)
		{
			string DirProfileName = cbDirProfile.Text.Trim();
			if (DirProfileName.Length == 0)
			{
				MessageBox.Show("A directory profile name must be supplied, returning.");
				return;
			}
			
			DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName);
			string S = "delete from DirProfiles where ProfileName = \'" + DirProfileName + "\'";
			bool B = DB.ExecuteSqlNewConn(S);
			if (B)
			{
				S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
				DB.PopulateComboBox(this.cbDirProfile, "ProfileName", S);
				SB.Text = DirProfileName + " deleted.";
			}
			else
			{
				SB.Text = DirProfileName + " failed to delete.";
			}
			
		}
		
		public string buildDirProfileParms()
		{
			
			string Parms = "";
			Parms += (string) ("cbRetention" + Strings.Chr(253) + cbRetention.Text + Strings.Chr(254));
			
			Parms += (string) ("ckSubDirs" + Strings.Chr(253) + ckSubDirs.Checked.ToString() + Strings.Chr(254));
			Parms += (string) ("ckOcr" + Strings.Chr(253) + ckOcr.Checked.ToString() + Strings.Chr(254));
			Parms += (string) ("ckVersionFiles" + Strings.Chr(253) + ckVersionFiles.Checked.ToString() + Strings.Chr(254));
			Parms += (string) ("ckMetaData" + Strings.Chr(253) + ckMetaData.Checked.ToString() + Strings.Chr(254));
			Parms += (string) ("ckPublic" + Strings.Chr(253) + ckPublic.Checked.ToString() + Strings.Chr(254));
			Parms += (string) ("clAdminDir" + Strings.Chr(253) + clAdminDir.Checked.ToString() + Strings.Chr(254));
			
			string xFiles = (string) ("InclExt" + Strings.Chr(253));
			
			for (int I = 0; I <= lbIncludeExts.Items.Count - 1; I++)
			{
				try
				{
					xFiles += (string) (lbIncludeExts.Items[I].ToString() + Strings.Chr(252));
				}
				catch (Exception)
				{
					
				}
			}
			xFiles += Strings.Chr(254);
			Parms += xFiles;
			
			xFiles = (string) ("ExclExt" + Strings.Chr(253));
			for (int I = 0; I <= lbExcludeExts.Items.Count - 1; I++)
			{
				try
				{
					xFiles += (string) (this.lbExcludeExts.Items[I].ToString() + Strings.Chr(252));
				}
				catch (Exception)
				{
					
				}
				
			}
			xFiles += Strings.Chr(254);
			Parms += xFiles;
			
			Parms = UTIL.RemoveSingleQuotes(Parms);
			
			return Parms;
			
		}
		
		public void applyDirProfileParms(string Parms)
		{
			
			string[] ParmArray = Parms.Split(Strings.Chr(254).ToString().ToCharArray());
			string Parm = "";
			string ParmValue = "";
			
			for (int i = 0; i <= (ParmArray.Length - 1); i++)
			{
				string tParm = ParmArray[i];
				string[] A = tParm.Split(Strings.Chr(253).ToString().ToCharArray());
				
				if ((A.Length - 1) == 1)
				{
					Parm = A[0];
					ParmValue = A[1];
				}
				else
				{
					goto NextRec;
				}
				if (Parm.Equals("cbRetention"))
				{
					cbRetention.Text = ParmValue;
				}
				if (Parm.Equals("ckSubDirs"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						ckSubDirs.Checked = true;
					}
					else
					{
						ckSubDirs.Checked = false;
					}
				}
				if (Parm.Equals("ckOcr"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						ckOcr.Checked = true;
					}
					else
					{
						ckOcr.Checked = false;
					}
				}
				if (Parm.Equals("ckOcrPdf"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						ckOcrPdf.Checked = true;
					}
					else
					{
						ckOcr.Checked = false;
					}
				}
				if (Parm.Equals("ckVersionFiles"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						ckVersionFiles.Checked = true;
					}
					else
					{
						ckVersionFiles.Checked = false;
					}
				}
				if (Parm.Equals("ckMetaData"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						ckMetaData.Checked = true;
					}
					else
					{
						ckMetaData.Checked = false;
					}
				}
				if (Parm.Equals("ckPublic"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						ckPublic.Checked = true;
					}
					else
					{
						ckPublic.Checked = false;
					}
				}
				if (Parm.Equals("clAdminDir"))
				{
					if (ParmValue.ToUpper().Equals("TRUE"))
					{
						clAdminDir.Checked = true;
					}
					else
					{
						clAdminDir.Checked = false;
					}
				}
				if (Parm.Equals("InclExt"))
				{
					lbIncludeExts.Items.Clear();
					string[] aExt = ParmValue.Split(Strings.Chr(252).ToString().ToCharArray());
					for (int ii = 0; ii <= (aExt.Length - 1); ii++)
					{
						if (aExt[ii].Trim().Length > 0)
						{
							lbIncludeExts.Items.Add(aExt[ii]);
						}
					}
				}
				if (Parm.Equals("ExclExt"))
				{
					lbExcludeExts.Items.Clear();
					string[] aExt = ParmValue.Split(Strings.Chr(252).ToString().ToCharArray());
					for (int ii = 0; ii <= (aExt.Length - 1); ii++)
					{
						if (aExt[ii].Trim().Length > 0)
						{
							lbExcludeExts.Items.Add(aExt[ii]);
						}
					}
				}
NextRec:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
		}
		
		public void lbExcludeExts_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			if (bApplyingDirParms == true)
			{
				return;
			}
			
		}
		
		public void ckArchiveBit_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			string S = "";
			S = "Whenever a file is created or changed, the operating system activates the Archive Bit or modified bit. Unless you select to use backup methods that depend on a date and time stamp, ECM Library uses the archive bit to determine whether a file has been backed up, which is an important element of your backup strategy. It is dangerous if other archive methods, processes or tools access an identified directory." + "\r\n";
			S = S + "Selecting the following backup methods can affect the archive bit: " + "\r\n";
			S = S + "  ï¿½  Full - Back up files - Using archive bit (reset archive bit) + vbcrlf";
			S = S + "  ï¿½  Differential - Back up changed files since last full - Using archive bit (does not reset archive bit) + vbcrlf";
			S = S + "  ï¿½  Incremental - Back up changed files since last full or incremental - Using archive bit (reset archive bit) + vbcrlf";
			S = S + "Whenever a file has been backed up using either the Full - Back up files - Using archive bit (reset archive bit) or Incremental - Changed Files - Reset Archive Bit backup method, Backup Exec turns the archive bit off, indicating to the system that the file has been backed up. If the file is changed again prior to the next full or incremental backup, the bit is turned on again, and Backup Exec will back up the file in the next full or incremental backup. Backups using the Differential - Changed Files backup method include only files that were created or modified since the last full backup. When this type of differential backup is performed, the archive bit is left intact. + vbcrlf + vbcrlf";
			S = S + "This is dangerous in many ways and you agree to accept all the risk of skipping files with the ARCHIVE bit set!";
			
			modGlobals.gLegalAgree = false;
			frmAgreement.Default.txtAgreement.Text = S;
			frmAgreement.Default.ShowDialog();
			if (modGlobals.gLegalAgree == false)
			{
				SB.Text = "Terms refused, SKIP if Archive is not enabled.";
				return;
			}
			
			if (ckArchiveBit.Checked)
			{
				ckArchiveBit.Checked = true;
			}
			else
			{
				ckArchiveBit.Checked = false;
			}
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void ckDisableDir_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			if (! ckDisable.Checked)
			{
				CkMonitor.Checked = false;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void ckOcr_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void ckVersionFiles_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void ckMetaData_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void clAdminDir_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void CkMonitor_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			
			if (formloaded == false)
			{
				return;
			}
			
			if (lbArchiveDirs.SelectedItems.Count != 1)
			{
				return;
			}
			
			//Dim LISTEN As New clsListener
			
			if (CkMonitor.Checked == true)
			{
				LISTEN.AddDirListener(DirGuid, ckDisableDir.Checked, false, true, false, true, ckSubDirs.Checked, MachineName);
				LISTEN.setDirListernerON(DirGuid);
				LISTEN.PauseDirListener(DirGuid, false);
				
				LISTEN.LoadListeners(MachineName);
				
				SB.Text = "Listener Added.";
				
			}
			else
			{
				LISTEN.deleteDirListener(DirGuid);
				LISTEN.setDirListernerOFF(DirGuid);
				LISTEN.PauseDirListener(DirGuid, true);
				if (ckRunUnattended.Checked == true)
				{
					LISTEN.LoadListeners(MachineName);
					SB.Text = "Listener disabled - restart of ECM required to remove it.";
				}
				else
				{
					MessageBox.Show("Listener disabled - restart of ECM required to completely remove it.", "LISTENER", System.Windows.Forms.MessageBoxButtons.OK);
				}
				
			}
			
			//LISTEN = Nothing
			
			//btnSaveChanges.BackColor = Color.OrangeRed
		}
		
		public void ckRunUnattended_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			
			if (formloaded == false)
			{
				return;
			}
			
			string S = "";
			bool B = false;
			
			if (ckRunUnattended.Checked)
			{
				frmAgreement.Default.txtAgreement.Text = "Running in unattended mode will cause all warnings and errors that HALT the system to be written to a log and NOT shown or displayed. By selecting this option, you agree to accept full responsibility to review this log for errors. ECM Library accepts no responsibility to notify you of errors outside of the log when running in unattended mode.";
				frmAgreement.Default.ShowDialog();
				B = modGlobals.gLegalAgree;
				if (B == false)
				{
					S = "UPDATE [RunParms] SET [ParmValue] = \'0\' WHERE [Parm] = \'user_RunUnattended\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
					B = DB.ExecuteSqlNewConn(S);
					if (B)
					{
						modGlobals.gRunUnattended = false;
						SB.Text = "Unattended mode disabled.";
					}
					else
					{
						SB.Text = "FAILED to enable Unattended mode.";
					}
					SB.Text = "Terms refused, RUN UNATTENDED is not enabled.";
					formloaded = false;
					ckRunUnattended.Checked = false;
					formloaded = true;
					return;
				}
			}
			
			string ckVal = DB.getUserParm("user_RunUnattended");
			if (ckVal.Trim().Length == 0)
			{
				
				S = "";
				S = S + " INSERT INTO [RunParms]";
				S = S + " ([Parm]";
				S = S + " ,[ParmValue]";
				S = S + " ,[UserID]";
				S = S + " ,[ParmDesc])";
				S = S + " VALUES ";
				S = S + " (\'user_RunUnattended\'";
				S = S + " ,\'0\'";
				S = S + " ,\'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " ,\'A zero turns OFF Unattended Mode, a 1 turns it ON.\')";
				
				B = DB.ExecuteSqlNewConn(S, false);
			}
			
			if (ckRunUnattended.Checked)
			{
				S = "UPDATE [RunParms] SET [ParmValue] = \'1\' WHERE [Parm] = \'user_RunUnattended\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
				B = DB.ExecuteSqlNewConn(S);
				if (B)
				{
					modGlobals.gRunUnattended = true;
					SB.Text = "System set to run in unattended mode.";
					//FrmMDIMain.SB4.BackColor = Color.Red
					//FrmMDIMain.SB4.Text = "Unattended ON"
				}
				else
				{
					modGlobals.gRunUnattended = false;
				}
			}
			else
			{
				S = "UPDATE [RunParms] SET [ParmValue] = \'0\' WHERE [Parm] = \'user_RunUnattended\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
				B = DB.ExecuteSqlNewConn(S);
				if (B)
				{
					modGlobals.gRunUnattended = false;
					SB.Text = "Unattended mode disabled.";
					
					//FrmMDIMain.SB4.Text = "Unattended OFF"
					//FrmMDIMain.SB4.BackColor = Color.Silver
					
				}
				else
				{
					SB.Text = "FAILED to enable Unattended mode.";
				}
				ckRunUnattended.Checked = false;
			}
			
			
			
		}
		
		public void SetUnattendedFlag()
		{
			
			string S = "";
			bool B = DB.SysParmExists("srv_RunUnattended");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_RunUnattended\',\'This allows the archive functions to run unattended.\',\'N\',\'Y\')";
				B = DB.ExecuteSqlNewConn(S);
				if (B)
				{
					modGlobals.gRunUnattended = false;
					SB.Text = "Unattended mode turned off.";
				}
				else
				{
					SB.Text = "Failed to turned off RUN UNATTENDED mode - no change to current state.";
				}
			}
			
			string ckVal = DB.getUserParm("user_RunUnattended");
			if (ckVal.Equals("1"))
			{
				modGlobals.gRunUnattended = true;
			}
			else if (ckVal.Equals("0"))
			{
				modGlobals.gRunUnattended = false;
			}
			else if (ckVal.ToUpper.Equals("Y"))
			{
				modGlobals.gRunUnattended = true;
			}
			else if (ckVal.ToUpper.Equals("N"))
			{
				modGlobals.gRunUnattended = false;
			}
			else
			{
				modGlobals.gRunUnattended = false;
			}
		}
		public void SetUnattendedCheckBox()
		{
			formloaded = false;
			
			string ckVal = DB.getUserParm("user_RunUnattended");
			
			if (ckVal.Equals("1"))
			{
				modGlobals.gRunUnattended = true;
				this.ckRunUnattended.Checked = modGlobals.gRunUnattended;
			}
			else if (ckVal.Equals("0"))
			{
				modGlobals.gRunUnattended = false;
				this.ckRunUnattended.Checked = modGlobals.gRunUnattended;
			}
			else if (ckVal.ToUpper.Equals("Y"))
			{
				modGlobals.gRunUnattended = true;
				this.ckRunUnattended.Checked = modGlobals.gRunUnattended;
			}
			else if (ckVal.ToUpper.Equals("N"))
			{
				modGlobals.gRunUnattended = false;
				this.ckRunUnattended.Checked = modGlobals.gRunUnattended;
			}
			else
			{
				modGlobals.gRunUnattended = false;
				this.ckRunUnattended.Checked = modGlobals.gRunUnattended;
			}
			formloaded = true;
		}
		
		public void ValidateEntry()
		{
			
			if (FoldersRefreshed == true)
			{
				return;
			}
			
			this.Cursor = Cursors.AppStarting;
			
			for (int I = 0; I <= cbParentFolders.Items.Count - 1; I++)
			{
				string Container = cbParentFolders.Items[I].ToString();
				cbParentFolders.Text = Container;
				//***************************************************
				btnRefreshFolders_Click(null, null);
				//***************************************************
			}
			FoldersRefreshed = true;
			this.Cursor = Cursors.Default;
		}
		
		public void TimerListeners_Tick(System.Object sender, System.EventArgs e)
		{
			
			if (ListenersDefined == false)
			{
				return;
			}
			bool bDoNotRun = false;
			Form frm;
			try
			{
				foreach (Form tempLoopVar_frm in (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).OpenForms)
				{
					frm = tempLoopVar_frm;
					Application.DoEvents();
					if (frm == frmNotify.Default)
					{
						bDoNotRun = true;
						break;
					}
					if (frm == frmNotify2.Default)
					{
						bDoNotRun = true;
						break;
					}
					if (frm == frmExchangeMonitor.Default)
					{
						bDoNotRun = true;
					}
					if (frm == frmNotifyListener.Default)
					{
						bDoNotRun = true;
						break;
					}
				}
			}
			catch (Exception)
			{
				Console.WriteLine("Collection processed.");
			}
			SortedList<string, int> TempList = new SortedList<string, int>();
			TempList = modGlobals.gFilesToArchive;
			if (modGlobals.gFilesToArchive.Count == 0)
			{
				return;
			}
			
			try
			{
				foreach (string sKey in TempList.Keys)
				{
					if (sKey.Substring(0, 1).Equals("~"))
					{
						Console.WriteLine("Skipping: " + sKey);
					}
					else
					{
						DBLocal.addListener(sKey);
					}
				}
			}
			catch (Exception ex)
			{
				TempList = null;
				LOG.WriteToArchiveLog((string) ("WARNING: TICK - 001: " + ex.Message));
				return;
			}
			
			TempList = null;
			
			frm = null;
			if (bDoNotRun == true)
			{
				return;
			}
			
			if (ThreadCnt > 0)
			{
				this.Text = "ECM Library Archive System         {Threads: " + ThreadCnt.ToString() + "}";
			}
			else
			{
				this.Text = "ECM Library Archive System         (no active archives)";
			}
			
			if (ThreadCnt > 50)
			{
				this.Text = "ECM Library Archive System         {Threads: " + ThreadCnt.ToString() + "}  (MAX Threads)";
				return;
			}
			
			if (BackgroundDirListener.IsBusy)
			{
				return;
			}
			
			//TimerListeners.Enabled = False
			try
			{
				BackgroundDirListener.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
			
			//TimerListeners.Enabled = True
		}
		
		
		// VBConversions Note: Former VB local static variables moved to class level.
		static bool ckPauseListener_CheckedChanged_ListenersLoaded = false;
		
		public void ckPauseListener_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			//Dim LISTEN As New clsListener
			if (formloaded == false)
			{
				return;
			}
			// static bool ListenersLoaded = false; VBConversions Note: Static variable moved to class level and renamed ckPauseListener_CheckedChanged_ListenersLoaded. Local static variables are not supported in C#.
			if (ckPauseListener.Checked == true)
			{
				LISTEN.PauseListeners(MachineName, true);
				TimerListeners.Enabled = false;
			}
			else
			{
				if (ckPauseListener_CheckedChanged_ListenersLoaded == false)
				{
					ckPauseListener_CheckedChanged_ListenersLoaded = true;
					LISTEN.LoadListeners(MachineName);
				}
				
				LISTEN.PauseListeners(MachineName, false);
				TimerListeners.Enabled = true;
			}
			//LISTEN = Nothing
		}
		
		//'** process table DirectoryListenerFiles
		public void ProcessListenerFiles(bool UseThreads)
		{
			
			SortedList<string, int> L = new SortedList<string, int>();
			//**********************************************
			//DB.GetListenerFiles(L)
			DBLocal.getListenerFiles(L);
			//**********************************************
			
			LOG.WriteToListenLog((string) ("Listener files found = " + L.Count.ToString()));
			
			if (L.Count == 0)
			{
				return;
			}
			
			//If UseThreads = False Then FrmMDIMain.ListenerStatus.Text = "Listener Active"
			
			frmNotifyListener.Default.Show();
			
			string DirName = "";
			
			string DirGuid = "";
			bool Successful = false;
			string fName = "";
			
			int iFiles = 0;
			int iSkip = 1;
			
			foreach (string FQN in L.Keys)
			{
				
				if (modGlobals.gFilesToArchive.ContainsKey(FQN))
				{
					modGlobals.gFilesToArchive.Remove(FQN);
				}
				
				if (! File.Exists(FQN))
				{
					goto SKIPTHISREC;
				}
				
				iSkip = System.Convert.ToInt32(L[FQN]);
				if (iSkip < 0)
				{
					goto SKIPTHISREC;
				}
				
				FileInfo FI = new FileInfo(FQN);
				DirName = FI.DirectoryName;
				fName = FI.Name;
				FI = null;
				
				GC.Collect();
				
				iFiles++;
				
				frmNotifyListener.Default.Text = (string) ("F:" + iFiles.ToString());
				frmNotifyListener.Default.Label1.Text = (string) ("Listener Files: " + iFiles.ToString());
				frmNotifyListener.Default.Refresh();
				Application.DoEvents();
				
				int IDX = L.IndexOfKey(FQN);
				
				DirGuid = DB.getDirGuid(DirName, MachineName);
				DirName = DB.getDirListenerNameByGuid(DirGuid);
				//DirGuid  = DB.getDirGuid(DirName, MachineIDcurr)
				
				DirGuid = DirGuid.Trim();
				
				Successful = false;
				LOG.WriteToListenLog("ArchiveSingleFile: archiving " + FQN + " From machine " + MachineName + ".");
				
				string fExt = DMA.getFileExtension(FQN);
				if (File.Exists(FQN))
				{
					ARCH.ArchiveSingleFile(UIDcurr, MachineName, DirName, FQN, DirGuid, Successful);
					if (Successful)
					{
						DBLocal.MarkListenersProcessed(FQN);
					}
				}
				else
				{
					DBLocal.MarkListenersProcessed(FQN);
					//Dim SX As String = "delete FROM [DirectoryListenerFiles] where SourceFile = '" + FQN + "'  and DirGuid   = '" + DirGuid  + "'"
					//DB.ExecuteSqlNewConn(SX)
				}
SKIPTHISREC:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			DBLocal.DelListenersProcessed();
			
			TimerListeners.Enabled = true;
			//If UseThreads = False Then FrmMDIMain.ListenerStatus.Text = "."
			ThreadCnt--;
			frmNotifyListener.Default.Close();
			frmNotifyListener.Default.Dispose();
			L = null;
		}
		
		public void TimerUploadFiles_Tick(System.Object sender, System.EventArgs e)
		{
			
			Form frm;
			try
			{
				foreach (Form tempLoopVar_frm in (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).OpenForms)
				{
					frm = tempLoopVar_frm;
					Application.DoEvents();
					if (frm == frmNotify.Default)
					{
						return;
					}
					if (frm == frmNotify2.Default)
					{
						return;
					}
					if (frm == frmExchangeMonitor.Default)
					{
						return;
					}
					if (frm == frmNotifyListener.Default)
					{
						return;
					}
				}
			}
			catch (Exception)
			{
				Console.WriteLine("TimerUploadFiles forms");
			}
			frm = null;
			
			if (t2 != null)
			{
				if (t2.IsAlive)
				{
					return;
				}
			}
			if (t3 != null)
			{
				if (t3.IsAlive)
				{
					return;
				}
			}
			if (t4 != null)
			{
				if (t4.IsAlive)
				{
					return;
				}
			}
			if (t5 != null)
			{
				if (t5.IsAlive)
				{
					return;
				}
			}
			
			int ElapsedSecs = modGlobals.ElapsedTimeSec(modGlobals.gListenerActivityStart, DateTime.Now);
			if (ElapsedSecs > 60)
			{
				
				string cPath = LOG.getTempEnvironDir();
				string tFQN = cPath + "\\ListenerFilesLog.ECM";
				string NewFile = tFQN + ".rdy";
				
				if (! File.Exists(tFQN))
				{
					modGlobals.gListenerActivityStart = DateTime.Now;
					//TimerUploadFiles.Enabled = False
					return;
				}
				else
				{
					modGlobals.gListenerActivityStart = DateTime.Now;
				}
				
				LOG.WriteToInstallLog("ACTIVATED the TimerUploadFiles !");
				
				TimerUploadFiles.Enabled = false;
				
				//**********************************************
				DB.getModifiedFiles();
				//**********************************************
				TimerUploadFiles.Enabled = true;
				TimerListeners.Enabled = true;
				
				if (! File.Exists(NewFile))
				{
					ISO.saveIsoFile(" FilesToDelete.dat", NewFile + "|");
					//File.Delete(NewFile)
				}
				
			}
			
		}
		
		public void TimerEndRun_Tick(System.Object sender, System.EventArgs e)
		{
			
			Form frm;
			try
			{
				foreach (Form tempLoopVar_frm in (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).OpenForms)
				{
					frm = tempLoopVar_frm;
					Application.DoEvents();
					if (frm == frmNotify.Default)
					{
						return;
					}
					if (frm == frmNotify2.Default)
					{
						return;
					}
					if (frm == frmExchangeMonitor.Default)
					{
						return;
					}
				}
			}
			catch (Exception)
			{
				Console.WriteLine("TimerEndRun_Tick forms");
			}
			frm = null;
			
			if (t2 != null)
			{
				if (t2.IsAlive)
				{
					return;
				}
			}
			if (t3 != null)
			{
				if (t3.IsAlive)
				{
					return;
				}
			}
			if (t4 != null)
			{
				if (t4.IsAlive)
				{
					return;
				}
			}
			if (t5 != null)
			{
				if (t5.IsAlive)
				{
					return;
				}
			}
			
			
			string ArchiveType = "";
			ArchiveType = DB.getRconParm(modGlobals.gCurrUserGuidID, "ArchiveType");
			STATS.setArchiveenddate(DateTime.Now.ToString());
			STATS.setArchivetype(ref ArchiveType);
			STATS.setStatus("Successful");
			STATS.setSuccessful("Y");
			STATS.setUserid(ref modGlobals.gCurrUserGuidID);
			
			int iCnt = 0;
			iCnt = DB.iGetRowCount("DataSource", "where DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'");
			STATS.setTotalcontentinrepository(iCnt.ToString());
			iCnt = DB.iGetRowCount("Email", "where UserID = \'" + modGlobals.gCurrUserGuidID + "\'");
			STATS.setTotalemailsinrepository(iCnt.ToString());
			
			bool BB = STATS.Insert();
			if (! BB)
			{
				LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.");
				LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.");
			}
			
			this.SetArchiveEndStats(ArchiveType);
			
			TimerEndRun.Enabled = false;
			
			if (UseThreads == false)
			{
				DB.UpdateAttachmentCounts();
			}
			else
			{
				ThreadCnt++;
				t6 = new Thread(new System.Threading.ThreadStart(DB.UpdateAttachmentCounts));
				t6.Priority = ThreadPriority.Lowest;
				//*******************************************************************
				t6.Start();
			}
			
			if (UseThreads == false)
			{
				//*******************************************************************
				resetBadDates();
				//*******************************************************************
			}
			else
			{
				ThreadCnt++;
				t7 = new Thread(new System.Threading.ThreadStart(resetBadDates));
				t7.Priority = ThreadPriority.Lowest;
				//*******************************************************************
				t7.Start();
				//*******************************************************************
			}
			
			SB.Text = "Archive Completed.";
			SB2.Text = "Archive Quiet";
			
			modGlobals.gCurrentArchiveGuid = "";
			
		}
		
		public void btnRefreshRetent_Click(System.Object sender, System.EventArgs e)
		{
			DB.LoadRetentionCodes(cbRetention);
			DB.LoadRetentionCodes(cbEmailRetention);
		}
		
		public void ckShowLibs_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckShowLibs.Checked)
			{
				frmLibraryAssgnList.Default.Show();
			}
			else
			{
				frmLibraryAssgnList.Default.Close();
			}
		}
		
		public void ckOcrPdf_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (bActiveChange == true)
			{
				return;
			}
			btnSaveChanges.BackColor = Color.OrangeRed;
		}
		
		public void SetDateFormats()
		{
			
			string dateString;
			string format;
			DateTime result;
			
			System.Globalization.DateTimeFormatInfo Info;
			Info = System.Globalization.CultureInfo.CurrentUICulture.DateTimeFormat;
			
			string S = "";
			modGlobals.gDateSeparator = Info.DateSeparator;
			modGlobals.gTimeSeparator = Info.TimeSeparator;
			modGlobals.gShortDatePattern = Info.ShortDatePattern;
			modGlobals.gShortTimePattern = Info.ShortTimePattern;
			
			Console.WriteLine(DateTime.Now);
			
		}
		
		public bool ckLicense()
		{
			
			string LT = null;
			bool bLicenseExists = DB.LicenseExists();
			if (! bLicenseExists)
			{
				MessageBox.Show("There does not appear to be an active license for this installation, please contact an administrator - or install a valid license.");
			}
			else
			{
				//** Check the expiration date and the service expiration date
				string MachineName = DMA.GetCurrMachineName();
				
				DB.RegisterMachineToDB(MachineName);
				
				if (ddebug)
				{
					LOG.WriteToTraceLog("FrmMDIMain 12");
				}
				
				LT = DB.GetXrt();
				bool isLease = LM.isLease();
				modGlobals.gMaxClients = LM.getMaxClients();
				
				if (modGlobals.gMaxClients > 0)
				{
					string SS = "Select count(*) from LoginClient";
					int EcmClientsDefinedToSystem = DB.iCount(SS);
					if (EcmClientsDefinedToSystem > modGlobals.gMaxClients)
					{
						string MSG = "It appears all ECM Client licenses have been used." + "\r\n";
						MSG += "Please logon from a licensed machine," + "\r\n" + "\r\n";
						MSG += "or contact ECM Library for additional client licenses." + "\r\n" + "\r\n";
						MSG += "Thank you, closing down." + "\r\n";
						MessageBox.Show(MSG);
						ProjectData.EndApp();
					}
				}
				
				DB.RegisterEcmClient(MachineName);
				
				modGlobals.gNbrOfSeats = int.Parse(val[LM.ParseLic(LT, "txtNbrSeats")]);
				modGlobals.gLicenseType = LM.LicenseType();
				modGlobals.gIsSDK = LM.SdkLicenseExists();
				
				tssUser.Text = (string) ("Seats:" + modGlobals.gNbrOfSeats.ToString());
				modGlobals.gNbrOfUsers = int.Parse(val[LM.ParseLic(LT, "txtNbrSimlSeats")]);
				tssServer.Text = "Server: ?";
				
				//**********************************************************
				int CurrNbrOfUsers = DB.GetNbrUsers();
				int CurrNbrOfMachine = DB.GetNbrMachine();
				//**********************************************************
				
				if (ddebug)
				{
					LOG.WriteToTraceLog("FrmMDIMain 13");
				}
				
				if (CurrNbrOfUsers >= modGlobals.gNbrOfUsers)
				{
					string Msg = "";
					Msg = Msg + "FrmMDIMain : MachineName : 1103 : " + "\r\n";
					Msg = Msg + "     Number of licenses warning : \'" + MachineName + "\'" + "\r\n";
					Msg = Msg + "     We are very sorry, but the maximum number of USERS has been exceeded." + "\r\n";
					Msg = Msg + "     ECM found " + CurrNbrOfUsers.ToString() + " users currently registered in the system." + "\r\n";
					Msg = Msg + "     Your license awards " + modGlobals.gNbrOfUsers.ToString() + " users." + "\r\n";
					Msg = Msg + "You will have to login with an existing User ID and Password." + "\r\n" + "Please contact admin for support.";
					LOG.WriteToArchiveLog(Msg);
					MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK);
					this.LoginAsDifferenctUserToolStripMenuItem_Click(null, null);
				}
				
				if (CurrNbrOfMachine >= modGlobals.gNbrOfSeats)
				{
					if (ddebug)
					{
						LOG.WriteToTraceLog("FrmMDIMain 14");
					}
					string IP = DMA.getIpAddr();
					modGlobals.gIpAddr = IP;
					MachineIDcurr = MachineName;
					DB.updateIp(MachineIDcurr, modGlobals.gIpAddr, 0);
					DB.updateIp(MachineIDcurr, modGlobals.gIpAddr, 1);
					if (ddebug)
					{
						LOG.WriteToTraceLog("FrmMDIMain 15");
					}
					string Msg = "";
					Msg = Msg + "FrmMDIMain : Current Users : 1103b : " + "\r\n";
					Msg = Msg + "     Number of current SEATS warning : \'" + MachineName + "\'" + "\r\n";
					Msg = Msg + "     We are very sorry, but the maximum number of seats (WorkStations) has been exceeded." + "\r\n";
					Msg = Msg + "     ECM found " + CurrNbrOfMachine.ToString() + " machines registered in the system." + "\r\n";
					Msg = Msg + "     Your license awards " + modGlobals.gNbrOfSeats.ToString() + " seats." + "\r\n";
					Msg = Msg + "You will have to login from a WorkStation already defined to ECM." + "\r\n" + "Please contact admin for support.";
					LOG.WriteToArchiveLog(Msg);
					MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK);
					if (isAdmin)
					{
						Msg = "";
						Msg = Msg + "You are an administrator for ECM Library." + "\r\n";
						Msg = Msg + "If you have a new license, would you like " + "\r\n";
						Msg = Msg + "to open the license management screen and apply a new license.";
						MessageBox.Show(Msg, "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK);
						DialogResult dlgRes = MessageBox.Show(Msg, "License Update", MessageBoxButtons.YesNo);
						if (dlgRes == System.Windows.Forms.DialogResult.Yes)
						{
							frmLicense.Default.ShowDialog();
							MessageBox.Show("Restarting the application.");
							Application.Restart();
						}
					}
				}
				else
				{
					if (ddebug)
					{
						LOG.WriteToTraceLog("FrmMDIMain 16");
					}
					int iExists = DB.GetNbrMachine(MachineName);
					if (iExists == 0)
					{
						string MySql = "insert into Machine (MachineName) values (\'" + MachineName + "\')";
						bool B = DB.ExecuteSqlNewConn(MySql, false);
						if (! B)
						{
							LOG.WriteToArchiveLog("FrmMDIMain : MachineName : 921 : Failed to register machine : \'" + MachineName + "\'");
						}
					}
					string IP = DMA.getIpAddr();
					
					modGlobals.gIpAddr = IP;
					MachineIDcurr = MachineName;
					
					if (ddebug)
					{
						LOG.WriteToTraceLog("FrmMDIMain 17");
					}
					
					DB.updateIp(MachineIDcurr, modGlobals.gIpAddr, 0);
					DB.updateIp(MachineIDcurr, modGlobals.gIpAddr, 2);
					
					if (ddebug)
					{
						LOG.WriteToTraceLog("FrmMDIMain 18");
					}
					
				}
				
				if (ddebug)
				{
					LOG.WriteToTraceLog("FrmMDIMain 19");
				}
				
				if (isLease == true)
				{
					
					DateTime ExpirationDate = DateTime.Parse(LM.ParseLic(LT, "dtExpire"));
					
					DateTime dtStartDate = "1/1/2007";
					TimeSpan tsTimeSpan;
					int iNumberOfDays;
					string strMsgText;
					tsTimeSpan = ExpirationDate.Subtract(DateTime.Now);
					iNumberOfDays = tsTimeSpan.Days;
					
					if (DateTime.Now > ExpirationDate.AddDays(30))
					{
						MessageBox.Show("The ECM run license has expired." + "\r\n" + "\r\n" + "Please contact ECM Library support.", "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK);
						ProjectData.EndApp();
					}
					
					if (iNumberOfDays <= 7)
					{
						infoDaysToExpire.Text = (string) ("License! " + iNumberOfDays.ToString());
						infoDaysToExpire.BackColor = Color.Red;
					}
					else if (iNumberOfDays <= 14)
					{
						infoDaysToExpire.BackColor = Color.LightSalmon;
						infoDaysToExpire.Text = (string) ("License! " + iNumberOfDays.ToString());
					}
					else if (iNumberOfDays <= 30)
					{
						infoDaysToExpire.BackColor = Color.Yellow;
						infoDaysToExpire.Text = (string) ("License@ " + iNumberOfDays.ToString());
					}
					else if (iNumberOfDays <= 60)
					{
						infoDaysToExpire.BackColor = Color.LightSeaGreen;
						infoDaysToExpire.Text = (string) ("License? " + iNumberOfDays.ToString());
					}
					else if (iNumberOfDays < 90)
					{
						infoDaysToExpire.BackColor = Color.Green;
						infoDaysToExpire.Text = (string) ("License* " + iNumberOfDays.ToString());
					}
					else
					{
						infoDaysToExpire.Text = " #" + iNumberOfDays.ToString() + " days";
					}
					
					
					if (DateTime.Now > ExpirationDate)
					{
						LOG.WriteToArchiveLog("FrmMDIMain : 1001 We are very sorry, but your software LEASE has expired. Please contact ECM Library support.");
						MessageBox.Show("We are very sorry, but your software license has expired." + "\r\n" + "\r\n" + "Please contact ECM Library support.", "CRITICAL Notice", System.Windows.Forms.MessageBoxButtons.OK);
						frmLicense.Default.ShowDialog();
						MessageBox.Show("The application will now end, please restart with the new license.");
					}
				}
				
				if (ddebug)
				{
					LOG.WriteToTraceLog("FrmMDIMain 21");
				}
				DateTime MaintExpire = DateTime.Parse(LM.ParseLic(LT, "dtMaintExpire"));
				if (DateTime.Now > MaintExpire)
				{
					frmNotifyMessage.Default.MsgToDisplay = "We are very sorry to inform you, but your maintenance agreement has expired." + "\r\n" + "\r\n" + "Please contact ECM Library support.";
					frmNotifyMessage.Default.Show();
					LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.");
				}
				//If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 22")
				//CustomerID = LM.ParseLic(LT , "txtCustID")
				//If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 23")
			}
		}
		
		public void OutlookEmailsToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				return;
			}
			if (ckDisableOutlookEmailArchive.Checked)
			{
				SB.Text = "DISABLE Outlook is checked - no archive allowed.";
				return;
			}
			
			if (BackgroundWorker1.IsBusy)
			{
				return;
			}
			
			try
			{
				BackgroundWorker1.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
			
		}
		
		public void ExchangeEmailsToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				return;
			}
			if (ckDisableExchange.Checked)
			{
				SB.Text = "DISABLE Exchange Archive is checked - no archive allowed.";
				return;
			}
			
			if (BackgroundWorker2.IsBusy)
			{
				return;
			}
			
			try
			{
				BackgroundWorker2.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
		}
		
		public void ContentToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				return;
			}
			if (ckDisableContentArchive.Checked)
			{
				SB.Text = "DISABLE Content Archive is checked - no archive allowed.";
				return;
			}
			
			if (BackgroundWorker3.IsBusy)
			{
				return;
			}
			
			try
			{
				BackgroundWorker3.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
		}
		
		public void ArchiveALLToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				return;
			}
			
			if (! BackgroundWorker1.IsBusy)
			{
				BackgroundWorker1.RunWorkerAsync();
			}
			if (! BackgroundWorker2.IsBusy)
			{
				BackgroundWorker2.RunWorkerAsync();
			}
			if (! BackgroundWorker3.IsBusy)
			{
				BackgroundWorker3.RunWorkerAsync();
			}
			if (! BackgroundWorkerContacts.IsBusy)
			{
				BackgroundWorkerContacts.RunWorkerAsync();
			}
			if (! asyncRssPull.IsBusy)
			{
				asyncRssPull.RunWorkerAsync();
			}
			if (! asyncSpiderWebSite.IsBusy)
			{
				asyncSpiderWebSite.RunWorkerAsync();
			}
			if (! asyncSpiderWebPage.IsBusy)
			{
				asyncSpiderWebPage.RunWorkerAsync();
			}
			
		}
		
		public void LoginAsDifferenctUserToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			CloseChildWindows();
			LoginAsNewUser = true;
			modGlobals.gCurrLoginID = "";
			this.LogIntoSystem(modGlobals.gCurrLoginID);
			tssUser.Text = modGlobals.gCurrUserGuidID;
			tssAuth.Text = DB.getAuthority(modGlobals.gCurrUserGuidID);
		}
		public void CloseChildWindows()
		{
			System.Windows.Forms.Form form;
			foreach (System.Windows.Forms.Form tempLoopVar_form in this.MdiChildren)
			{
				form = tempLoopVar_form;
				form.Close();
			}
		}
		public void LogIntoSystem(string OverRideLoginID)
		{
			try
			{
				foreach (Form f in this.MdiChildren)
				{
					f.Close();
				}
			}
			catch (Exception)
			{
				
			}
			try
			{
				this.SB.Text = "Loading, standby";
				modGlobals.FilesToDelete.Clear();
				
				this.SB.Text = "Ready";
				string SaveName = "UserStartUpParameters";
				string SaveTypeCode = "StartUpParm";
				string CurrentLoginID = "";
				int iAttempts = 1;
Retry:
				if (iAttempts >= 4)
				{
					MessageBox.Show("Too many failed login attempts, closing down.");
					this.Close();
					this.Dispose();
					ProjectData.EndApp();
				}
				
				string X1 = System.Configuration.ConfigurationManager.AppSettings["LoginByMachineIdAndLoginID"];
				if (X1.Equals("1") && LoginAsNewUser == false)
				{
					string LoggedInUser = LOG.getEnvVarUserID();
					if (OverRideLoginID.Length > 0)
					{
						LoggedInUser = OverRideLoginID;
					}
					if (LoggedInUser.Length == 0)
					{
						LoggedInUser = DMA.GetCurrMachineName();
					}
					
					modGlobals.gCurrUserGuidID = DB.getUserGuidID(LoggedInUser);
					if (modGlobals.gCurrUserGuidID.Length > 0)
					{
						//** Good login
						goto GoodLogin;
					}
					else
					{
						goto BadAutoLogin;
					}
				}
BadAutoLogin:
				LoginForm1.Default.ShowDialog();
				
				if (System.Environment.UserName.ToString().Length == 0)
				{
					modGlobals.gCurrUserGuidID = DMA.GetCurrMachineName();
					LoginForm1.Default.txtLoginID.Text = DMA.GetCurrMachineName();
				}
				else
				{
					LoginForm1.Default.txtLoginID.Text = System.Environment.UserName.ToString();
				}
				
				CurrentLoginID = LoginForm1.Default.UID;
				
				bool BB = LoginForm1.Default.bGoodLogin;
				if (BB && CurrentLoginID.Trim.Length > 0)
				{
					modGlobals.gCurrUserGuidID = DB.getUserGuidID(CurrentLoginID);
				}
				else
				{
					MessageBox.Show("Incorrect login or password supplied, please try again.");
					iAttempts++;
					LoginForm1.Default.Dispose();
					goto Retry;
				}
				LoginForm1.Default.Dispose();
GoodLogin:
				modGlobals.gCurrLoginID = CurrentLoginID.ToUpper;
				
				modGlobals.gCurrUserGuidID = DB.getUserGuidID(modGlobals.gCurrLoginID);
				if (modGlobals.gCurrLoginID.ToUpper().Equals("SERVICEMANAGER"))
				{
					modGlobals.gIsServiceManager = true;
					//QuickArchiveToolStripMenuItem.Visible = False
					CurrentLoginID = modGlobals.gCurrLoginID;
				}
				else
				{
					modGlobals.gIsServiceManager = false;
					//QuickArchiveToolStripMenuItem.Visible = True
				}
				
				if (modGlobals.gCurrUserGuidID.Trim().Length == 0)
				{
					CurrentLoginID = System.Environment.UserName.ToString();
				}
				if (modGlobals.gCurrUserGuidID.Trim().Length == 0)
				{
					modGlobals.gCurrUserGuidID = DB.getUserGuidID(CurrentLoginID);
				}
				string TempDir = System.IO.Path.GetTempPath();
				
				SetDefaults();
				
				//frmQuickSearch.MdiParent = Me
				//frmQuickSearch.Show()
				//frmQuickSearch.WindowState = FormWindowState.Maximized
				
				int b = DB.ckUserStartUpParameter(modGlobals.gCurrUserGuidID, "CONTENT WORKING DIRECTORY");
				if (b == 0)
				{
					SI.setSavename(ref SaveName);
					SI.setSavetypecode(ref SaveTypeCode);
					SI.setUserid(ref modGlobals.gCurrUserGuidID);
					SI.setValname("CONTENT WORKING DIRECTORY");
					SI.setValvalue(ref TempDir);
					SI.Insert();
				}
				b = DB.ckUserStartUpParameter(modGlobals.gCurrUserGuidID, "EMAIL WORKING DIRECTORY");
				if (b == 0)
				{
					SI.setSavename(ref SaveName);
					SI.setSavetypecode(ref SaveTypeCode);
					SI.setUserid(ref modGlobals.gCurrUserGuidID);
					SI.setValname("EMAIL WORKING DIRECTORY");
					SI.setValvalue(ref TempDir);
					SI.Insert();
				}
				SB.Text = (string) ("Logged in as " + CurrentLoginID);
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("FrmMDIMain : ReLogIntoSystem : 100 : " + ex.Message));
				MessageBox.Show("LogIntoSystem: Login failed.");
			}
			
			isAdmin = DB.isAdmin(modGlobals.gCurrUserGuidID);
			modGlobals.isGlobalSearcher = DB.isGlobalSearcher(modGlobals.gCurrUserGuidID);
			
			if (isAdmin)
			{
				SB.Text = (string) ("ADMIN Logged in as: " + DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID));
			}
			else
			{
				SB.Text = (string) ("Logged in as: " + DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID));
			}
			
			if (DB.isSuperAdmin(modGlobals.gCurrUserGuidID))
			{
				ImpersonateLoginToolStripMenuItem.Visible = true;
			}
			else
			{
				ImpersonateLoginToolStripMenuItem.Visible = false;
			}
			
		}
		public void SetDefaults()
		{
			
			DB.LoadProcessDates();
			//bFormLoaded = True
			
			if (ddebug)
			{
				LOG.WriteToTraceLog("FrmMDIMain 25");
			}
			
			isAdmin = DB.isAdmin(modGlobals.gCurrUserGuidID);
			modGlobals.isGlobalSearcher = DB.isGlobalSearcher(modGlobals.gCurrUserGuidID);
			
			DB.UserParmInsertUpdate("CurrSearchCriteria", modGlobals.gCurrUserGuidID, " ");
			//'DB.UserParmInsertUpdate("CurrSearchThesaurus", gCurrUserGuidID, txtThesaurus.Text.Trim)
			DB.UserParmInsertUpdate("ckLimitToExisting", modGlobals.gCurrUserGuidID, "0");
			DB.DeleteMarkedImageCopyFiles();
			modGlobals.TurnHelpOn(0);
			this.Activate();
			modGlobals.bInitialized = true;
			//DfltData.PopulateLookupTables()
			
			if (ddebug)
			{
				LOG.WriteToTraceLog("FrmMDIMain 27");
			}
			
			//DB.UserParmInsert("SoundOn", gCurrUserGuidID, "ON")
			//RMT.getHelpQuiet()
			string SoundOn = DB.UserParmRetrive("SoundOn", modGlobals.gCurrUserGuidID);
			if (SoundOn.ToUpper().Equals("ON"))
			{
				modGlobals.gVoiceOn = true;
			}
			else
			{
				modGlobals.gVoiceOn = false;
			}
			if (modGlobals.gVoiceOn == true)
			{
				string Phrase = "Welcome to E C M Library.";
				SB.Text = Phrase;
				DMA.SayWords(Phrase);
			}
			
			if (ddebug)
			{
				LOG.WriteToTraceLog("FrmMDIMain 28");
			}
			//** Turned Off by WDM 7/13/2009
			//If isAdmin = True Then
			//    RepositoryUtilitiesToolStripMenuItem.Visible = True
			//    AdminToolStripMenuItem.Visible = True
			//    SystemDetailsToolStripMenuItem.Visible = True
			//    UsersToolStripMenuItem.Visible = True
			//    UndefinedFiletypeCodesToolStripMenuItem.Visible = True
			//Else
			//    RepositoryUtilitiesToolStripMenuItem.Visible = False
			//    'AdminToolStripMenuItem.Visible = False
			//    AdminToolStripMenuItem.Visible = True
			//    SystemDetailsToolStripMenuItem.Visible = False
			//    UsersToolStripMenuItem.Visible = False
			//    UndefinedFiletypeCodesToolStripMenuItem.Visible = False
			//End If
			string Msg2 = (string) ("Login: " + DMA.GetCurrUserName());
			Msg2 = Msg2 + ", " + DMA.GetCurrMachineName();
			Msg2 = Msg2 + ", " + DMA.GetCurrOsVersionName();
			//DB.xTrace(99276, Msg2, "frmMdiMain:Load")
			
			modGlobals.SystemSqlTimeout = DB.getSystemParm("SqlServerTimeout");
			//ListControls()
			
			if (ddebug)
			{
				LOG.WriteToTraceLog("FrmMDIMain 29");
			}
			
			if (isAdmin == false)
			{
				//AdminToolStripMenuItem.Visible = False
			}
			else
			{
				//AdminToolStripMenuItem.Visible = True
			}
			
			string sEcmCrawlerAvailable = System.Configuration.ConfigurationManager.AppSettings["EcmCrawlerAvailable"];
			if (isAdmin)
			{
				if (sEcmCrawlerAvailable.Equals("Y"))
				{
					modGlobals.bEcmCrawlerAvailable = true;
					//WebCrawlerSetupToolStripMenuItem.Visible = True
				}
				else
				{
					modGlobals.bEcmCrawlerAvailable = false;
					//WebCrawlerSetupToolStripMenuItem.Visible = False
				}
			}
			else
			{
				modGlobals.bEcmCrawlerAvailable = false;
				//WebCrawlerSetupToolStripMenuItem.Visible = False
			}
			
			MachineIDcurr = DMA.GetCurrMachineName();
			
			DB.ckMissingWorkingDirs();
			string sDebug = DB.getUserParm("user_showContactMenu");
			
			try
			{
				string strDaysToKeepTraceLogs = DB.getUserParm("user_DaysToKeepTraceLogs");
				if (strDaysToKeepTraceLogs.Trim.Length > 0)
				{
					modGlobals.gDaysToKeepTraceLogs = int.Parse(strDaysToKeepTraceLogs);
				}
			}
			catch (Exception)
			{
				modGlobals.gDaysToKeepTraceLogs = 3;
			}
			
			SetVersionAndServer();
			
			isAdmin = DB.isAdmin(modGlobals.gCurrUserGuidID);
			modGlobals.isGlobalSearcher = DB.isGlobalSearcher(modGlobals.gCurrUserGuidID);
			
			if (isAdmin == false)
			{
				//AdminToolStripMenuItem.Visible = False
				SB.Text = "Logged in as a user.";
			}
			else
			{
				//AdminToolStripMenuItem.Visible = True
				SB.Text = "Logged in as an Admin.";
			}
			
			bool bEmbededJPGMetadata = DB.ShowGraphicMetaDataScreen();
			
		}
		
		public void SetVersionAndServer()
		{
			try
			{
				string S = " VER:" + (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.Major + "." + (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.Minor + "." + (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.Build + "." + (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.Revision + " ";
				tssVersion.Text = S;
				var SvrName = DB.getNameOfCurrentServer();
				string CurrCS = DB.getGateWayConnStr(modGlobals.gGateWayID);
				tssServer.Text = SvrName + ":" + getServer(CurrCS);
				if (tssServer.Text.IndexOf("unknown") + 1 > 0)
				{
					tssServer.Text = getServer(System.Configuration.ConfigurationManager.AppSettings["ECMREPO"]);
					LOG.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN.");
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				LOG.WriteToArchiveLog((string) ("Notice 001.z1 : Server UNKNOWN." + ex.Message));
			}
			
		}
		
		public string getServer(string ConnectionString)
		{
			try
			{
				string S = DB.setConnStr();
				int I = 1;
				I = S.IndexOf("Data Source=", I - 1) + 1;
				I = S.IndexOf("=", I + 1 - 1) + 1;
				int J = S.IndexOf(";", I + 1 - 1) + 1;
				if (I > 0)
				{
					return " " + S.Substring(I + 1 - 1, J - I - 1);
				}
				return "Unknown";
			}
			catch (Exception)
			{
				return " UKN";
			}
		}
		
		
		public void ParameterExecutionToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string MSG = "";
			MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + "\r\n" + "\r\n";
			MSG = MSG + "X = Execute archive and close." + "\r\n" + "\r\n";
			MSG = MSG + "C = Archive CONTENT only." + "\r\n" + "\r\n";
			MSG = MSG + "O = Archive OUTLOOK only." + "\r\n" + "\r\n";
			MSG = MSG + "E = Archive EXCHANGE Servers only." + "\r\n" + "\r\n";
			MSG = MSG + "A = Archive ALL." + "\r\n" + "\r\n";
			MSG = MSG + "To Execute:" + "\r\n";
			MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + "\r\n";
			MSG = MSG + "(E.G.) C:\\dev\\ECM\\EcmLibSvc\\EcmLibSvc\\bin\\Debug\\EcmArchiveSetup.exe Q" + "\r\n";
			MessageBox.Show(MSG);
		}
		
		public void HistoryToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmHistory.Default.Show();
		}
		
		public void ckExpand_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			
			if (ckExpand.Checked)
			{
				gbEmail.Width = gbContentMgt.Width;
				gbContentMgt.Visible = false;
				SB2.Visible = false;
				SB.Visible = false;
				gbPolling.Visible = false;
				gbFiletypes.Visible = false;
				gbEmail.Anchor = AnchorStyles.Bottom + AnchorStyles.Left + AnchorStyles.Top + AnchorStyles.Right;
			}
			else
			{
				gbEmail.Width = gbContentMgt.Left - 35;
				gbContentMgt.Visible = true;
				SB2.Visible = true;
				SB.Visible = true;
				gbPolling.Visible = true;
				gbFiletypes.Visible = true;
				gbEmail.Anchor = AnchorStyles.Bottom + AnchorStyles.Left + AnchorStyles.Top;
			}
		}
		
		
		public void ckDisableContentArchive_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			saveStartUpParms();
			SB.Text = (string) ("Content Disabled set to " + ckDisableContentArchive.Checked.ToString());
		}
		
		public void ckDisableOutlookEmailArchive_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			saveStartUpParms();
			SB.Text = (string) ("EMAIL Disabled set to " + ckDisableOutlookEmailArchive.Checked.ToString());
		}
		
		public void ckDisableExchange_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			saveStartUpParms();
			if (ckDisableExchange.Checked)
			{
				SB.Text = "Exchange Disabled";
			}
			else
			{
				SB.Text = "Exchange Enabled";
			}
			
		}
		
		public void ViewLogsToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			string TempFolder = LOG.getEnvVarSpecialFolderApplicationData();
			Interaction.Shell((string) ("explorer.exe " + '\u0022' + TempFolder + '\u0022'), Constants.vbNormalFocus, 0, -1);
			
		}
		
		public void DirectoryInventoryToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			string DirToInventory = "C:\\dev";
			string ListOfFiles = "";
			bool ckArchiveBit = true;
			bool IncludeSubDirs = true;
			List<string> FileExt = new List<string>();
			FileExt.Add(".DOC");
			FileExt.Add(".XLS");
			FileExt.Add(".VB");
			
			Console.WriteLine("Start: " + DateTime.Now.ToString());
			ListOfFiles = UTIL.getFileToArchive(DirToInventory, FileExt, ckArchiveBit, IncludeSubDirs);
			//Shell("Notepad.exe " + Chr(34) + ListOfFiles + Chr(34), vbNormalFocus)
			Console.WriteLine("End: " + DateTime.Now.ToString());
			GC.Collect();
			GC.WaitForFullGCApproach();
		}
		
		public void ListFilesInDirectoryToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			List<string> FilesToArchive = new List<string>();
			string MSG = "";
			string strFileSize = "";
			List<string> FilterList = new List<string>();
			bool ArchiveAttr = false;
			
			FilterList.Add("*.xls");
			FilterList.Add("*.doc");
			FilterList.Add("*.vb");
			
			Console.WriteLine("Start: " + DateTime.Now.ToString());
			
			string DirToInventory = "C:\\dev";
			int iInventory = 0;
			UTIL.GetFilesToArchive(ref iInventory, ArchiveAttr, false, DirToInventory, FilterList, FilesToArchive);
			//For Each S As String In FilesToArchive
			//    Console.WriteLine(S)
			//Next
			Console.WriteLine("End: " + DateTime.Now.ToString());
			GC.Collect();
			GC.WaitForFullGCApproach();
			
		}
		
		public void GetAllSubdirFilesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			List<string> FilesToArchive = new List<string>();
			string MSG = "";
			string strFileSize = "";
			List<string> FilterList = new List<string>();
			bool ArchiveAttr = false;
			
			FilterList.Add("*.doc");
			FilterList.Add("*.xls");
			FilterList.Add("*.vb");
			
			Console.WriteLine("Start: " + DateTime.Now.ToString());
			string DirToInventory = "C:\\dev";
			int iInventory = 0;
			UTIL.GetFilesToArchive(ref iInventory, ArchiveAttr, true, DirToInventory, FilterList, FilesToArchive);
			//For Each S As String In FilesToArchive
			//    Console.WriteLine(S)
			//Next
			Console.WriteLine("End: " + DateTime.Now.ToString());
			GC.Collect();
			GC.WaitForFullGCApproach();
		}
		
		public void ViewOCRErrorFilesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			try
			{
				string DirFQN = UTIL.getTempPdfWorkingErrorDir();
				Interaction.Shell((string) ("explorer.exe " + '\u0022' + DirFQN + '\u0022'), Constants.vbNormalFocus, 0, -1);
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
			
		}
		
		public void ScheduleToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmSchedule.Default.ShowDialog();
		}
		
		public void RunningArchiverToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void AboutToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			AboutBox1.Default.ShowDialog();
		}
		
		public void ManualEditAppConfigToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string aPath = System.AppDomain.CurrentDomain.BaseDirectory;
			string AppName = aPath + "EcmArchiveSetup.exe.config";
			System.Diagnostics.Process.Start("notepad.exe", AppName);
		}
		
		public void NumericUpDown1_ValueChanged(System.Object sender, System.EventArgs e)
		{
			if (! formloaded)
			{
				return;
			}
			if (nbrArchiveHours.Value == 0)
			{
				My.Settings.Default["BackupIntervalHours"] = 0;
				SB2.Text = "Quick archive disabled.";
				//TimerQuickArchive.Enabled = False
			}
			else
			{
				if (nbrArchiveHours.Value < 4)
				{
					nbrArchiveHours.Value = 4;
				}
				if (nbrArchiveHours.Value > 96)
				{
					nbrArchiveHours.Value = 96;
				}
				My.Settings.Default["BackupIntervalHours"] = (int) nbrArchiveHours.Value;
				My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
				My.Settings.Default.Save();
				SB2.Text = nbrArchiveHours.Value.ToString() + " hours from now, an archive will execute and every " + nbrArchiveHours.Value.ToString() + " thereafter.";
				//TimerQuickArchive.Enabled = True
			}
			My.Settings.Default.Save();
		}
		
		public void TimerQuickArchive_Tick(System.Object sender, System.EventArgs e)
		{
			if (ckDisable.Checked)
			{
				return;
			}
			if (modGlobals.gContactsArchiving == true || modGlobals.gContentArchiving == true || modGlobals.gOutlookArchiving == true || modGlobals.gExchangeArchiving == true)
			{
				//** An archive is already running
				return;
			}
			
			tsLastArchive.Text = My.Settings.Default["LastArchiveEndTime"].ToString();
			
			int IntervalHours = 0;
			decimal iElapsedHours = 0;
			try
			{
				IntervalHours = My.Settings.Default["BackupIntervalHours"];
			}
			catch (Exception)
			{
				IntervalHours = 0;
			}
			if (IntervalHours > 0)
			{
				CalcNextArchiveTime();
			}
			
		}
		public decimal ElapsedHours(DateTime tStart)
		{
			TimeSpan elapsed_time;
			elapsed_time = DateTime.Now.Subtract(tStart);
			return elapsed_time.TotalHours;
		}
		
		public void btnArchiveNow_Click(System.Object sender, System.EventArgs e)
		{
			TimerQuickArchive_Tick(null, null);
		}
		/// <summary>
		/// This will create a Application Reference file on the users desktop
		/// if they do not already have one when the program is loaded.
		//    If not debugging in visual studio check for Application Reference
		//    #if (!debug)
		//        CheckForShortcut();
		//    #endif
		/// </summary
		private void CheckForShortcut()
		{
			ApplicationDeployment ad = ApplicationDeployment.CurrentDeployment;
			//If ad.IsFirstRun Then
			Assembly code = Assembly.GetExecutingAssembly();
			string company = string.Empty;
			string description = string.Empty;
			if (Attribute.IsDefined(code, typeof(AssemblyCompanyAttribute)))
			{
				AssemblyCompanyAttribute ascompany = (AssemblyCompanyAttribute) (Attribute.GetCustomAttribute(code, typeof(AssemblyCompanyAttribute)));
				company = ascompany.Company;
			}
			if (Attribute.IsDefined(code, typeof(AssemblyDescriptionAttribute)))
			{
				AssemblyDescriptionAttribute asdescription = (AssemblyDescriptionAttribute) (Attribute.GetCustomAttribute(code, typeof(AssemblyDescriptionAttribute)));
				description = asdescription.Description;
			}
			if (company != string.Empty && description != string.Empty)
			{
				string desktopPath = string.Empty;
				desktopPath = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), "\\", description, ".appref-ms");
				string shortcutName = string.Empty;
				shortcutName = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs), "\\", company, "\\", description, ".appref-ms");
				System.IO.File.Copy(shortcutName, desktopPath, true);
			}
			//End If
			
		}
		
		public void ImpersonateLoginToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmImpersonate.Default.ShowDialog();
		}
		
		public void AddDesktopIconToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			CheckForShortcut();
		}
		
		public void btnRefreshRebuild_Click(System.Object sender, System.EventArgs e)
		{
			
			this.Cursor = Cursors.WaitCursor;
			string S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] ";
			DB.LoadProfiles();
			
			S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] ";
			DB.PopulateComboBox(cbProfile, "ProfileName", S);
			
			S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
			//S = "select distinct ProfileName from LoadProfileItem order by ProfileName"
			DB.PopulateComboBox(this.cbDirProfile, "ProfileName", S);
			this.Cursor = Cursors.Default;
		}
		
		public void AllToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			gbEmail.Visible = true;
			gbContentMgt.Visible = true;
			gbPolling.Visible = true;
			gbFiletypes.Visible = true;
		}
		
		public void EmailToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			gbEmail.Visible = true;
			gbContentMgt.Visible = false;
			gbPolling.Visible = false;
			gbFiletypes.Visible = false;
		}
		
		public void ContentToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			gbEmail.Visible = false;
			gbContentMgt.Visible = true;
			gbPolling.Visible = false;
			gbFiletypes.Visible = false;
		}
		
		public void ExecutionControlToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			gbEmail.Visible = false;
			gbContentMgt.Visible = false;
			gbPolling.Visible = true;
			gbFiletypes.Visible = false;
		}
		
		public void FileTypesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			gbEmail.Visible = false;
			gbContentMgt.Visible = false;
			gbPolling.Visible = false;
			gbFiletypes.Visible = true;
		}
		
		public void EncryptStringToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmEncryptString.Default.ShowDialog();
		}
		
		public void btnRefreshDefaults_Click(System.Object sender, System.EventArgs e)
		{
			string S = "";
			bool B = true;
			
			S = "insert into AvailFileTypes (ExtCode) Values (\'.act\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ada\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.adb\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ads\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ascx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.asm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.asp\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.aspx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.bat\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.bmp\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.c\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.cmd\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.cpp\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.csv\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.cxx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.dct\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.def\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.dic\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.dll\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.doc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.docm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.docx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.dot\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.dotm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.dotx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.exe\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.frm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.GIF\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.gz\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.h\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.hhc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.hpp\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.htm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.html\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.htw\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.htx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.hxx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ibq\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.idl\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.inc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.inf\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ini\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.inx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.java\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.JPG\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.JPX\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.js\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.log\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.m3u\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.mht\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.mp3\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.msg\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.obd\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.obj\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.obt\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.odc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.pdf\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.pfx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.pl\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.PNG\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.pot\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.potm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.potx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ppam\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ppsm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ppsx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.ppt\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.pptm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.pptx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.rc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.reg\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.resx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.rtf\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.sln\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.sql\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.stm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.suo\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.tar\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.tif\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.TIFF\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.TRF\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.txt\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.UKN\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.url\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.vb\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.vbs\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.vbx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.VSD\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.wav\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.wma\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.wtx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.XL * \')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xlam\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xlb\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xlc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xls\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xlsm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xlsx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xlt\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xltm\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xltx\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xml\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xsc\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xsd\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xslt\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.xss\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.z\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'.zip\')";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "insert into AvailFileTypes (ExtCode) Values (\'msg\')";
			B = DB.ExecuteSqlNewConn(S, false);
			
			MessageBox.Show("Missing default extension codes readded.");
			
		}
		
		public void btnDefaultAsso_Click(System.Object sender, System.EventArgs e)
		{
			AP.SaveNewAssociations(".ada", ".txt");
			AP.SaveNewAssociations("adb", ".txt");
			AP.SaveNewAssociations("ads", ".txt");
			AP.SaveNewAssociations("bat", ".txt");
			AP.SaveNewAssociations("css", ".cxx");
			AP.SaveNewAssociations("csv", ".txt");
			AP.SaveNewAssociations("dct", ".txt");
			AP.SaveNewAssociations("def", ".txt");
			AP.SaveNewAssociations("frm", ".vbs");
			AP.SaveNewAssociations("java", ".js");
			AP.SaveNewAssociations("sql", ".txt");
			AP.SaveNewAssociations("url", ".txt");
			AP.SaveNewAssociations("vb", ".vbs");
			MessageBox.Show("Default associations readded.");
		}
		
		public void btnAddDefaults_Click(System.Object sender, System.EventArgs e)
		{
			
			this.Cursor = Cursors.WaitCursor;
			AddSourceTypeDefaults();
			
			string S = "";
			bool B = false;
			
			S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'Known graphic file types.\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'All MS Office content.\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - C#\', N\'Source Code - C#\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'Source Code - VB\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ZIP Files\', N\'Currently Processed ZIP types\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.ZIP\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.RAR\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.GZ\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.ISO\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.TAR\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.ARJ\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.CAB\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.CHM\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.CPIO\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.CramFS\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.DEB\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.DMG\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.FAT\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.HFS\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.LZH\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.LZMA\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.MBR\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.MSI\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.NSIS\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.NTFS\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.RPM\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.SquashFS\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.UDF\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.VHD\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.WIM\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.XAR\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values (\'ZIP Files\', \'.Z\',\'UKN\',0,\'ECMLIB\', getdate(), getdate())";
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.one\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pdf\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.txt\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.csv\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlsx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xls\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pdf\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.html\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.htm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.docx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.doc\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.Tiff\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.tif\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.gif\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.docm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.dotx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.dotm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlsm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xltx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xltm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlsb\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlam\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pptx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pptm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.potx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.potm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.ppam\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.ppsx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.ppsm\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.bmp\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.png\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.vb\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xsd\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xss\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xsc\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.ico\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.rpt\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.rdlc\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.resx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.sql\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xml\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.sln\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.vbx\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.jpg\', NULL, 0, N\'ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] ";
			DB.PopulateComboBox(cbProfile, "ProfileName", S);
			
			this.Cursor = Cursors.Default;
			
			MessageBox.Show("Default profiles ready.");
			
		}
		
		public void AddSourceTypeDefaults()
		{
			
			string S = null;
			bool B = false;
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ZIP\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'RAR\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'GZ\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ISO\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'TAR\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ARJ\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'CAB\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'CHM\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'CPIO\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'CramFS\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'DEB\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'DMG\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'FAT\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'HFS\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'LZH\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'LZMA\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'MBR\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'MSI\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'NSIS\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'NTFS\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'RPM\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'SquashFS\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'UDF\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'VHD\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'WIM\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'XAR\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Z\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'ECMLIB\', GETDATE(), GETDATE())";
			
			B = DB.ExecuteSqlNewConn(S, false);
			
			DB.AddSourceTypeCode(".ZIP", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".RAR", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".GZ", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".ISO", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".TAR", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".ARJ", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".CAB", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".CHM", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".CPIO", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".CramFS", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".DEB", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".DMG", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".FAT", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".HFS", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".LZH", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".LZMA", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".MBR", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".MSI", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".NSIS", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".NTFS", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".RPM", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".SquashFS", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".UDF", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".VHD", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".WIM", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".XAR", 0, "Add by ECM: Compressed File.", 0);
			DB.AddSourceTypeCode(".Z", 0, "Add by ECM: Compressed File.", 0);
			
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\',dct\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.act\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ada\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.adb\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ads\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.application\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.asax\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ascx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ashx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.asm\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.asmmeta\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.asp\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.aspx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.BAK\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.baml\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.bas\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.bat\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.bmp\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.c\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.Cache\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.cd\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.chm\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.cls\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.cmd\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.compiled\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.config\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.cpp\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.crt\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.cs\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.CSproj\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.css\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.csv\', 0, N\'Added by user\', 1, NULL, NULL, NULL, NULL, NULL)";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.cxx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dat\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.data\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.database\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.datasource\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.db\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dct\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.def\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.deploy\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dic\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dll\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.DM1\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dnn\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.doc\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.docm\', 0, N\'Word 2007 XML Macro-Enabled Document\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.docx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dot\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dotm\', 0, N\'Word 2007 XML Macro-Enabled Template\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dotx\', 0, N\'Word 2007 XML Template\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dtproj\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dtsConfig\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.dtsx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.emz\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.exe\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.exe_SyncToyBackup_20090311100439812\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.exe_SyncToyBackup_20090406194350947\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.frm\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.gif\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.grxml\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.gz\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.h\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.hhc\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.hlp\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.hpp\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.htc\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.htm\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.html\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.htw\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.htx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.hxx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ibq\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ico\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.idl\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.inc\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.inf\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ini\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.inx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.jar\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.java\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.jpg\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.js\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.kmz\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ldb\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ldf\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.lng\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.lnk\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.log\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.m3u\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.manifest\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.master\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.mdb\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.mdf\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.MDI\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.mht\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.mp3\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.mrc\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.msg\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.msi\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.myapp\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.obd\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.obj\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.obt\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.odc\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.one\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.opml\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.org\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.p7b\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pcap\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pdb\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pdf\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pfx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.php\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pl\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.png\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pot\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.potm\', 0, N\'PowerPoint 2007 Macro-Enabled XML Template\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.potx\', 0, N\'PowerPoint 2007 XML Template\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ppam\', 0, N\'PowerPoint 2007 Macro-Enabled XML Add-In\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ppsm\', 0, N\'PowerPoint 2007 Macro-Enabled XML Show\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ppsx\', 0, N\'PowerPoint 2007 XML Show\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.ppt\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pptm\', 0, N\'PowerPoint 2007 Macro-Enabled XML Presentation\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pptx\', 0, N\'PowerPoint 2007 XML Presentation\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.psd\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.pub\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rar\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rc\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rdl\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rdlc\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rds\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.reg\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.resources\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.resx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rpt\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rptproj\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.rtf\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.scc\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.settings\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.shs\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.sitemap\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.skin\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.sln\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.sql\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.SqlDataProvider\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.sqlsuo\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, NULL, NULL, NULL, NULL)";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.sqm\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.stm\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.subproj\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.suo\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.tar\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.template\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.Text\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.thmx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.tif\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.Tiff\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.tmp\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.TRF\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.txt\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.UD\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.url\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.user\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vb\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vbp\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vbproj\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vbs\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vbx\', 0, N\'AUTO Defined by System\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vsd\', 0, N\'AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vspscc\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.vstemplate\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.WAV\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.webproj\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.wma\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.wmv\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.wri\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.wtx\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xaml\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlam\', 0, N\'Excel 2007 XML Macro-Enabled Add-In\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlb\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlc\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlk\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xls\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlsb\', 0, N\'Excel 2007 binary workbook (BIFF12)\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlsm\', 0, N\'Excel 2007 XML Macro-Enabled Workbook\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlsx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xlt\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xltm\', 0, N\'Excel 2007 XML Macro-Enabled Template\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xltx\', 0, N\'Excel 2007 XML Template\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xml\', 0, N\'Word Splitter\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xsc\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xsd\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xsl\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xslt\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xss\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.xsx\', 0, N\'NO SEARCH - AUTO ADDED by Pgm\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.z\', 0, N\'Added by user\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'.zip\', 0, N\'Word Splitter\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Added by user\', 0, N\'.dct\', 1, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'docm\', 0, N\'Word 2007 XML Macro-Enabled Document\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'docx\', 0, N\'Word 2007 XML Document\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'dotm\', 0, N\'Word 2007 XML Macro-Enabled Template\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'dotx\', 0, N\'Word 2007 XML Template\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'NO SEARCH - AUTO ADDED by Pgm\', 0, N\'.application\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'potm\', 0, N\'PowerPoint 2007 Macro-Enabled XML Template\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'potx\', 0, N\'PowerPoint 2007 XML Template\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ppam\', 0, N\'PowerPoint 2007 Macro-Enabled XML Add-In\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ppsm\', 0, N\'PowerPoint 2007 Macro-Enabled XML Show\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'ppsx\', 0, N\'PowerPoint 2007 XML Show\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'pptm\', 0, N\'PowerPoint 2007 Macro-Enabled XML Presentation\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'pptx\', 0, N\'PowerPoint 2007 XML Presentation\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'xlam\', 0, N\'Excel 2007 XML Macro-Enabled Add-In\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'xlsb\', 0, N\'Excel 2007 binary workbook (BIFF12)\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'xlsm\', 0, N\'Excel 2007 XML Macro-Enabled Workbook\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'xlsx\', 0, N\'Excel 2007 XML Workbook\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'xltm\', 0, N\'Excel 2007 XML Macro-Enabled Template\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'xltx\', 0, N\'Excel 2007 XML Template\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'XXXX\', 0, N\'AUTO Definition - not found\', 0, NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
			B = DB.ExecuteSqlNewConn(S, false);
			
		}
		
		public void FileHashToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			OpenFileDialog1.ShowDialog();
			
			long Ticks = 0;
			int TotalTicks = 0;
			
			Ticks = DateTime.Now.Ticks;
			string FQN = OpenFileDialog1.FileName;
			string CRC32HASH = "";
			string MD5HASH = "";
			string SHA1HASH = "";
			string SHA1QUICK = "";
			
			Ticks = DateTime.Now.Ticks;
			CRC32HASH = ENC.getSha1HashFromFile(FQN);
			TotalTicks = DateTime.Now.Ticks - Ticks;
			CRC32HASH += (string) (" - Time: " + TotalTicks.ToString());
			
			Ticks = DateTime.Now.Ticks;
			MD5HASH = ENC.hashMd5(FQN);
			TotalTicks = DateTime.Now.Ticks - Ticks;
			MD5HASH += (string) (" - Time: " + TotalTicks.ToString());
			
			Ticks = DateTime.Now.Ticks;
			SHA1HASH = ENC.hashSha1(FQN);
			TotalTicks = DateTime.Now.Ticks - Ticks;
			SHA1HASH += (string) (" - Time: " + TotalTicks.ToString());
			
			Ticks = DateTime.Now.Ticks;
			SHA1QUICK = ENC.hashSha1File(FQN);
			TotalTicks = DateTime.Now.Ticks - Ticks;
			SHA1QUICK += (string) (" - Time: " + TotalTicks.ToString());
			
			string sMsg = "";
			
			sMsg += "CRC32     : " + CRC32HASH + "\r\n";
			sMsg += "MD5       : " + MD5HASH + "\r\n";
			sMsg += "SHA1      : " + SHA1HASH + "\r\n";
			sMsg += "SHA1 Quick: " + SHA1QUICK + "\r\n";
			
			MessageBox.Show(sMsg);
		}
		
		~frmMain()
		{
			base.Finalize();
			
			if (LocalDBBackUpComplete)
			{
				return;
			}
			
			clsDbLocal DBL = new clsDbLocal();
			
			DBL.BackupDirTbl();
			DBL.BackupFileTbl();
			DBL.BackupInventoryTbl();
			DBL.BackupExchangeTbl();
			DBL.BackupOutlookTbl();
			
			DBL = null;
			DBLocal = null;
			
			LocalDBBackUpComplete = true;
			
		} //Finalize
		
		
		public void BackgroundWorker1_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			
			string isPublic = "N";
			string RetentionCode = "Retain 10";
			
			if (ckTerminate.Checked)
			{
				if (! modGlobals.gRunUnattended)
				{
					MessageBox.Show("The TERMINATE immediately box is checked, returning.");
					return;
				}
				else
				{
					LOG.WriteToArchiveLog("BackgroundWorker1_DoWork: The TERMINATE immediately box is checked, returning.");
				}
			}
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				ArchiveALLToolStripMenuItem.Enabled = true;
				ContentToolStripMenuItem.Enabled = true;
				ExchangeEmailsToolStripMenuItem.Enabled = true;
				OutlookEmailsToolStripMenuItem.Enabled = true;
				return;
			}
			
			DB.CleanUpEmailFolders();
			//PictureBox1.Visible = True
			//ckTerminate.Checked = False
			
			modGlobals.gEmailsBackedUp = 0;
			modGlobals.gEmailsAdded = 0;
			//Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
			//SB.Text = "Starting Email archive."
			frmHelp.Default.MsgToDisplay = "This can be a long running process. It can be minimized and you can continue working.";
			frmHelp.Default.CallingScreenName = "ECM Archive";
			frmHelp.Default.CaptionName = "Execution Beginning";
			frmHelp.Default.Show();
			
			//Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
			//ArchiveALLToolStripMenuItem.Enabled = False
			//ContentToolStripMenuItem.Enabled = False
			//ExchangeEmailsToolStripMenuItem.Enabled = False
			//OutlookEmailsToolStripMenuItem.Enabled = False
			//ArchiveALLToolStripMenuItem.Enabled = True
			//ContentToolStripMenuItem.Enabled = True
			//ExchangeEmailsToolStripMenuItem.Enabled = True
			//OutlookEmailsToolStripMenuItem.Enabled = True
			
			EmailsBackedUp = 0;
			EmailsSkipped = 0;
			FilesBackedUp = 0;
			FilesSkipped = 0;
			
			//***************************************************
			SetUnattendedFlag();
			//SB.Text = "Quiet"
			//SB2.Text = "Quiet"
			
			//If UseThreads = False Then
			//*******************************************************************
			bool bUseQuickSearch = false;
			int NbrOfIds = DB.getCountStoreIdByFolder();
			SortedList slStoreId = new SortedList();
			
			if (NbrOfIds <= 5000000)
			{
				bUseQuickSearch = true;
			}
			
			if (bUseQuickSearch)
			{
				//** 002
				DBLocal.getCE_EmailIdentifiers(slStoreId);
			}
			else
			{
				slStoreId.Clear();
			}
			
			//*******************************************************************
			ARCH.ArchiveEmailFolders(UIDcurr);
			//*******************************************************************
			
			if (modGlobals.gTerminateImmediately)
			{
				//Me.Cursor = Cursors.Default
				//SB.Text = "Terminated archive!"
				//ArchiveALLToolStripMenuItem.Enabled = True
				//ContentToolStripMenuItem.Enabled = True
				//ExchangeEmailsToolStripMenuItem.Enabled = True
				//OutlookEmailsToolStripMenuItem.Enabled = True
				//PictureBox1.Visible = False
				
				//SB.Text = "AUTO Archive exit"
				//SB2.Text = "AUTO Archive exit"
				
				return;
			}
			resetBadDates();
			//***************************************************
			
			ALR.ProcessAllRefEmails(false);
			//Me.Cursor = System.Windows.Forms.Cursors.Default
			DB.UpdateAttachmentCounts();
			//Me.Cursor = System.Windows.Forms.Cursors.Default
			//SB.Text = "Completed Email archive."
			if (modGlobals.gEmailsAdded == 0)
			{
				modGlobals.gEmailsAdded = 1;
			}
			//Dim Msg  = "Emails Processed: " + gEmailsBackedUp.ToString + "  /  Updated: " + EmailsSkipped.ToString + " / Added: " + (gEmailsAdded - 1).ToString
			//SB2.Text = Msg
			
			//ArchiveALLToolStripMenuItem.Enabled = False
			//ContentToolStripMenuItem.Enabled = False
			//ExchangeEmailsToolStripMenuItem.Enabled = False
			//OutlookEmailsToolStripMenuItem.Enabled = False
			//ArchiveALLToolStripMenuItem.Enabled = True
			//ContentToolStripMenuItem.Enabled = True
			//ExchangeEmailsToolStripMenuItem.Enabled = True
			//OutlookEmailsToolStripMenuItem.Enabled = True
			
			if (modGlobals.gTerminateImmediately)
			{
				//Me.Cursor = Cursors.Default
				//SB.Text = "Terminated archive!"
				//PictureBox1.Visible = False
				
				//SB.Text = "AUTO Archive exit"
				//SB2.Text = "AUTO Archive exit"
				
				return;
			}
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			
			for (int i = 0; i <= modGlobals.ZipFilesEmail.Count - 1; i++)
			{
				//bExplodeZipFile = False
				string cData = modGlobals.ZipFilesEmail[i].ToString();
				string ParentGuid = "";
				string FQN = "";
				int K = cData.IndexOf("|") + 1;
				FQN = cData.Substring(0, K - 1);
				ParentGuid = cData.Substring(K + 1 - 1);
				//DB.UpdateZipFileIndicator(ParentGuid, True)
				ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, true, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
			}
			
			ListOfFiles = null;
			GC.Collect();
			
		}
		
		public void BackgroundWorker2_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			
			string isPublic = "N";
			string RetentionCode = "Retain 10";
			
			if (ckTerminate.Checked)
			{
				MessageBox.Show("The TERMINATE immediately box is checked, returning.");
				return;
			}
			
			EmailsBackedUp = 0;
			EmailsSkipped = 0;
			FilesBackedUp = 0;
			FilesSkipped = 0;
			
			//SB.Text = "Launching Exchange Archive - it will run in background."
			if (modGlobals.gCurrentArchiveGuid.Length == 0)
			{
				modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
			}
			
			//****************************************************************************
			SetUnattendedFlag();
			//frmExchangeMonitor.Show()
			
			GetExchangeFolders(false);
			//****************************************************************************
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			
			for (int i = 0; i <= modGlobals.ZipFilesExchange.Count - 1; i++)
			{
				string cData = modGlobals.ZipFilesExchange[i].ToString();
				string ParentGuid = "";
				string FQN = "";
				int K = cData.IndexOf("|") + 1;
				FQN = cData.Substring(0, K - 1);
				ParentGuid = cData.Substring(K + 1 - 1);
				ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, true, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
			}
			for (int i = 0; i <= modGlobals.ZipFilesEmail.Count - 1; i++)
			{
				string cData = modGlobals.ZipFilesExchange[i].ToString();
				string ParentGuid = "";
				string FQN = "";
				int K = cData.IndexOf("|") + 1;
				FQN = cData.Substring(0, K - 1);
				ParentGuid = cData.Substring(K + 1 - 1);
				ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, true, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
			}
			
			ListOfFiles = null;
			GC.Collect();
			
		}
		
		public void BackgroundWorker3_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			
			string isPublic = "N";
			
			if (ckTerminate.Checked)
			{
				MessageBox.Show("The TERMINATE immediately box is checked, returning.");
				return;
			}
			
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				return;
			}
			
			//Timer1.Enabled = False
			
			//PictureBox1.Visible = True
			
			ckTerminate.Checked = false;
			
			EmailsBackedUp = 0;
			EmailsSkipped = 0;
			FilesBackedUp = 0;
			FilesSkipped = 0;
			
			//SB.Text = "Starting Content archive."
			
			LOG.WriteToArchiveLog((string) ("Content Archive stared @ " + DateTime.Now.ToString()));
			
			//Me.Cursor = System.Windows.Forms.Cursors.Default
			MsgNotification = false;
			frmHelp.Default.MsgToDisplay = "This can be a long running process. It can be minimized and you can continue working?";
			frmHelp.Default.CallingScreenName = "ECM Archive";
			frmHelp.Default.CaptionName = "Execution Beginning";
			frmHelp.Default.StartPosition = FormStartPosition.CenterScreen;
			frmHelp.Default.Timer1.Interval = 5000;
			frmHelp.Default.Show();
			
			if (ddebug)
			{
				LOG.WriteToArchiveLog("frmReconMain : btnArchiveContent :7000 : starting archive.");
			}
			
			if (modGlobals.gCurrentArchiveGuid.Length == 0)
			{
				modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
			}
			
			//Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
			//FrmMDIMain.SB.Text = "Archiving Content"
			
			//*** Here is the primary Module for archive.
			if (ddebug)
			{
				LOG.WriteToArchiveLog("frmReconMain : btnArchiveContent :7001 : starting archive.");
			}
			
			if (ddebug)
			{
				LOG.WriteToArchiveLog("Starting Archive of Content ********************************");
			}
			
			//***************** ARCHIVE CONTENT **********************'
			
			SetUnattendedFlag();
			//FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
			
			//********************
			modGlobals.gCurrUserGuidID = UIDcurr;
			ArchiveContent(UIDcurr);
			//********************
			
			//FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
			
			//********************************************************'
			if (ddebug)
			{
				LOG.WriteToArchiveLog("frmReconMain : btnArchiveContent :7002 : starting archive.");
			}
			
			ARCH.ArchiveQuickRefItems(UIDcurr, MachineIDcurr, ckArchiveBit.Checked, false, false, false, false, SB, "", "", "", modGlobals.ZipFilesQuick);
			
			string RetentionCode = "Retain 10";
			
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			
			for (int i = 0; i <= modGlobals.ZipFilesQuick.Count - 1; i++)
			{
				//FrmMDIMain.SB.Text = "Processing Quickref"
				//If i >= 24 Then
				//    Debug.Print("here")
				//End If
				string cData = modGlobals.ZipFilesQuick[i].ToString();
				string ParentGuid = "";
				string FQN = "";
				int K = cData.IndexOf("|") + 1;
				FQN = cData.Substring(0, K - 1);
				ParentGuid = cData.Substring(K + 1 - 1);
				//DB.UpdateZipFileIndicator(ParentGuid, True)
				ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
			}
			
			ListOfFiles = null;
			GC.Collect();
			
			ALR.ProcessAllRefDirs(false);
			
			string Msg = (string) ("Files Backed Up: " + FilesBackedUp.ToString() + "  /  Files Updated: " + FilesSkipped.ToString());
			
			LOG.WriteToArchiveLog((string) ("Content Archive completed @ " + DateTime.Now.ToString() + " : " + Msg));
			
		}
		
		public void FileUploadToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			string RetentionCode = "Retain 10";
			string isPublic = "N";
			
			OpenFileDialog1.ShowDialog();
			string FQN = OpenFileDialog1.FileName;
			FileInfo FI = new FileInfo(FQN);
			string OriginalFileName = FI.Name;
			FI = null;
			string FileGuid = Guid.NewGuid().ToString();
			string RepositoryTable = "DataSource";
			string ContentSha1Hash = ENC.getSha1HashFromFile(FQN);
			string AttachmentCode = "C";
			DB.UploadFileImage(OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic, ContentSha1Hash);
		}
		
		public void FileUploadBufferedToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			string isPublic = "N";
			string RetentionCode = "Retain 10";
			
			OpenFileDialog1.ShowDialog();
			string FQN = OpenFileDialog1.FileName;
			FileInfo FI = new FileInfo(FQN);
			string OriginalFileName = FI.Name;
			FI = null;
			string FileGuid = Guid.NewGuid().ToString();
			string RepositoryTable = "DataSource";
			
			byte[] FileBuffer = null;
			
			System.IO.FileInfo oFile;
			oFile = new System.IO.FileInfo(FQN);
			
			System.IO.FileStream oFileStream = oFile.OpenRead();
			long lBytes = oFileStream.Length;
			
			if (lBytes > 0)
			{
				FileBuffer = new byte[lBytes - 1 + 1];
				oFileStream.Read(FileBuffer, 0, lBytes);
				oFileStream.Close();
			}
			string CrcHASH = ENC.getSha1HashFromFile(FQN);
			DB.UploadBuffered(4, FileBuffer, OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic, CrcHASH);
			
		}
		
		public void FileChunkUploadToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			OpenFileDialog1.ShowDialog();
			string FQN = OpenFileDialog1.FileName;
			FileInfo FI = new FileInfo(FQN);
			string OriginalFileName = FI.Name;
			FI = null;
			string FileGuid = Guid.NewGuid().ToString();
			string CrcHASH = ENC.getSha1HashFromFile(FQN);
			DB.ChunkFileUpload(OriginalFileName, FileGuid, FQN, "DataSource", CrcHASH);
		}
		
		public void BackgroundDirListener_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			
			string RetentionCode = "Retain 10";
			string isPublic = "N";
			
			bool bFilesToBeArchived = DBLocal.ActiveListenerFiles();
			//If Not bFilesToBeArchived Then
			//    Return
			//End If
			
			bool bDoNotRun = false;
			
			Form frm;
			try
			{
				foreach (Form tempLoopVar_frm in (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).OpenForms)
				{
					frm = tempLoopVar_frm;
					Application.DoEvents();
					if (frm == frmNotify.Default)
					{
						bDoNotRun = true;
					}
					if (frm == frmNotify2.Default)
					{
						bDoNotRun = true;
					}
					if (frm == frmExchangeMonitor.Default)
					{
						bDoNotRun = true;
					}
					if (frm == frmNotifyListener.Default)
					{
						bDoNotRun = true;
					}
				}
			}
			catch (Exception)
			{
				Console.WriteLine("Collection processed.");
			}
			
			frm = null;
			if (bDoNotRun == true)
			{
				return;
			}
			
			
			SortedList<string, int> L = new SortedList<string, int>();
			//L = gFilesToArchive
			DBLocal.getListenerFiles(L);
			foreach (string sKey in L.Keys)
			{
				if (! File.Exists(sKey))
				{
					DBLocal.removeListenerFile(sKey);
					if (modGlobals.gFilesToArchive.ContainsKey(sKey))
					{
						modGlobals.gFilesToArchive.Remove(sKey);
					}
				}
				
				FileInfo FI = new FileInfo(sKey);
				string fName = FI.Name;
				FI = null;
				
				if (fName.Substring(0, 1).Equals("~"))
				{
					Console.WriteLine("Skipping: " + sKey);
					DBLocal.removeListenerFile(sKey);
					if (modGlobals.gFilesToArchive.ContainsKey(sKey))
					{
						modGlobals.gFilesToArchive.Remove(sKey);
					}
				}
				if (modGlobals.gFilesToArchive.ContainsKey(sKey))
				{
					modGlobals.gFilesToArchive.Remove(sKey);
				}
			}
			
			DBLocal.getListenerFiles(L);
			
			if (L.Count == 0 && ! bFilesToBeArchived)
			{
				return;
			}
			else
			{
				ProcessListenerFiles(false);
			}
			L = null;
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			for (int i = 0; i <= modGlobals.ZipFilesListener.Count - 1; i++)
			{
				string cData = modGlobals.ZipFilesListener[i].ToString();
				string ParentGuid = "";
				string FQN = "";
				int K = cData.IndexOf("|") + 1;
				FQN = cData.Substring(0, K - 1);
				ParentGuid = cData.Substring(K + 1 - 1);
				ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
			}
			
			ListOfFiles = null;
			GC.Collect();
		}
		
		public void populateCompanyCombo()
		{
			
			
			try
			{
				txtCompany.Text = REG.ReadEcmRegistrySubKey("CompanyID");
			}
			catch (Exception)
			{
				string CompanyID = Interaction.InputBox("ERROR - CompanyID is not defined to the system, please enter your Company ID.", "Company ID", "", -1, -1);
				if (CompanyID.Length > 0)
				{
					bool bReg = false;
					bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID);
					if (! bReg)
					{
						bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID);
					}
					txtCompany.Text = CompanyID;
				}
				else
				{
					txtCompany.Text = "";
					return;
				}
				
			}
			
			//Dim RC As Boolean = False
			//Dim RetMsg As String = ""
			//Dim Proxy As New SVCGateway.Service1Client
			
			//Dim SecureLoginCS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
			//Dim DecryptedSecureLoginCS As String = ENC.AES256DecryptString(SecureLoginCS)
			
			//Try
			//    cbCompany.Items.Clear()
			//    'Dim S As String = "Select distinct CompanyID from [Gateway_Attach] order by CompanyID"
			//    Dim Items As String = ""
			//    Dim BlankCS As String = ""
			//    Try
			//        Dim S As String = Proxy.PopulateCombo(BlankCS, CompanyID, RC, RetMsg)
			//        If InStr(S, "|") > 0 Then
			//            Dim A() As String = S.Split("|")
			//            For i As Integer = 0 To A.Count - 1
			//                Dim sItem As String = A(i)
			//                If sItem.Trim.Length > 0 Then
			//                    cbCompany.Items.Add(sItem)
			//                End If
			//            Next
			//        End If
			//    Catch ex As Exception
			//        MessageBox.Show("Error populating the Company Combo: " + ex.Message.ToString)
			//    End Try
			
			//    If Not RC Then
			//        LOG.WriteToArchiveLog("ERROR: Failed to populate Company Combo - " + RetMsg)
			//    Else
			//        Dim A() As String = Items.Split("|")
			//        For I As Integer = 0 To A.Count - 1
			//            If A(I) IsNot Nothing And A(I).Trim.Length > 0 Then
			//                cbCompany.Items.Add(A(I))
			//            End If
			//        Next
			//    End If
			//Catch ex As Exception
			//    LOG.WriteToArchiveLog("ERROR loading Company Combobox:" + ex.Message)
			//Finally
			
			
			//End Try
			if (txtCompany.Text.Length > 0)
			{
				populateRepoCombo();
			}
			
		}
		public void populateRepoCombo()
		{
			
			string TempCS = "";
			cbRepo.Items.Clear();
			string CID = txtCompany.Text.Trim();
			CID = CID.Replace("\'", "\'\'");
			string S = "Select RepoID from [Gateway_Attach] where CompanyID = \'" + CID + "\' order by RepoID";
			string Items = "";
			bool RC = false;
			string RetMsg = "";
			SVCGateway.Service1Client ProxyGateway = new SVCGateway.Service1Client();
			try
			{
				Items = (string) (ProxyGateway.PopulateRepoCombo(TempCS, CID, RC, RetMsg));
				if (Items.Length == 0)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: 100 Failed to populate company ID  combobox - " + RetMsg));
				}
				else
				{
					string[] A = Items.Split("|".ToCharArray());
					for (int I = 0; I <= A.Count - 1; I++)
					{
						cbRepo.Items.Add(A[I]);
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 100 Failed to populate company ID  combobox - " + ex.Message));
			}
			finally
			{
				ProxyGateway = null;
				GC.Collect();
			}
			
		}
		
		public void btnActivate_Click(System.Object sender, System.EventArgs e)
		{
			
			CompanyID = txtCompany.Text;
			RepoID = cbRepo.Text;
			bool bReg = false;
			
			if (CompanyID.Length > 0 && RepoID.Length > 0)
			{
				SVCGateway.Service1Client ProxyAttach = new SVCGateway.Service1Client();
				string EncCS = "";
				bool RC = false;
				string RetMsg = "";
				EncCS = (string) (ProxyAttach.getConnection(CompanyID, RepoID, RC, RetMsg));
				if (EncCS.Trim().Length > 0)
				{
					//gCurrentConnectionString = ENC.AES256DecryptString(EncCS)
					modGlobals.gCurrentConnectionString = EncCS;
					if (modGlobals.gCurrentConnectionString.Length > 0)
					{
						bReg = REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS);
						if (! bReg)
						{
							bReg = REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS);
						}
					}
					try
					{
						modGlobals.gCurrentConnectionString = ENC.AES256DecryptString(EncCS);
					}
					catch (Exception)
					{
						MessageBox.Show("ERROR 121.32.1 : Failed to set new connection.");
						return;
					}
				}
				else
				{
					modGlobals.gCurrentConnectionString = "";
				}
				
				ProxyAttach = null;
				bUseAttachData = true;
				tsCurrentRepoID.Text = RepoID;
				tsCurrentRepoID.Text = (string) ("Repo: " + RepoID);
				
				if (CompanyID.Length > 0)
				{
					bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID);
					if (! bReg)
					{
						bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID);
					}
					
				}
				if (RepoID.Length > 0)
				{
					bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID);
					if (! bReg)
					{
						bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID);
					}
				}
				
			}
			else
			{
				tsCurrentRepoID.Text = "Repo: ??";
				bUseAttachData = false;
			}
		}
		
		private void GetQueryStringParameters() //As NameValueCollection
		{
			LOG.WriteToParmLog("Step 01");
			NameValueCollection NameValueTable = new NameValueCollection();
			LOG.WriteToParmLog("Step 02");
			try
			{
				LOG.WriteToParmLog("Step 03");
				if (ApplicationDeployment.IsNetworkDeployed)
				{
					LOG.WriteToParmLog("Step 04");
					string QueryString = ApplicationDeployment.CurrentDeployment.ActivationUri.Query;
					LOG.WriteToParmLog("Step 05");
					LOG.WriteToParmLog((string) ("QueryString: " + QueryString));
					LOG.WriteToParmLog("Step 06");
					NameValueTable = System.Web.HttpUtility.ParseQueryString(QueryString);
					LOG.WriteToParmLog("Step 07");
				}
				
				LOG.WriteToParmLog("Step 08");
				
				foreach (string Arg in NameValueTable)
				{
					LOG.WriteToParmLog("Step 09");
					LOG.WriteToParmLog((string) ("ARG: " + Arg));
					LOG.WriteToParmLog("Step 10");
					if (Arg.IndexOf(";") + 1)
					{
						LOG.WriteToParmLog("Step 11");
						string[] AA = Arg.Split(";".ToCharArray());
						CompanyID = AA[0];
						RepoID = AA[1];
						LOG.WriteToParmLog("Step 12");
						string sCompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
						string sRepoID = REG.ReadEcmRegistrySubKey("RepoID");
						bool bReg = false;
						LOG.WriteToParmLog("Step 13");
						if (sCompanyID.Length == 0)
						{
							LOG.WriteToParmLog("Step 14");
							bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID);
							LOG.WriteToParmLog("Step 15");
							if (! bReg)
							{
								LOG.WriteToParmLog("Step 16");
								bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID);
								LOG.WriteToParmLog("Step 17");
							}
							LOG.WriteToParmLog("Step 18");
						}
						LOG.WriteToParmLog("Step 19");
						if (sRepoID.Length == 0)
						{
							LOG.WriteToParmLog("Step 20");
							bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID);
							LOG.WriteToParmLog("Step 21");
							if (! bReg)
							{
								LOG.WriteToParmLog("Step 22");
								bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID);
								LOG.WriteToParmLog("Step 23");
							}
							LOG.WriteToParmLog("Step 24");
						}
						LOG.WriteToParmLog("Step 25");
					}
					LOG.WriteToParmLog("Step 26");
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToParmLog("Step 27");
				LOG.WriteToArchiveLog((string) ("ERROR GetQueryStringParameters 100 - " + ex.Message));
				LOG.WriteToParmLog((string) ("ERROR GetQueryStringParameters 100 - " + ex.Message));
			}
			finally
			{
				LOG.WriteToParmLog("Step 28");
				NameValueTable = null;
			}
			LOG.WriteToParmLog("Step 29");
		}
		
		private void cbCompany_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			populateRepoCombo();
		}
		
		public void btnFetch_Click(System.Object sender, System.EventArgs e)
		{
			string CID = txtCompany.Text.Trim().ToUpper();
			string StoredCompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
			StoredCompanyID = StoredCompanyID.ToUpper();
			if (CID.ToUpper().Equals(StoredCompanyID))
			{
				populateRepoCombo();
			}
			else
			{
				bool RC = false;
				string RetTxt = "";
				string TPW = Interaction.InputBox("A password is required to list the repositories within this company, please enter password.", "Password Required", "", -1, -1);
				TPW = ENC.AES256EncryptString(TPW);
				SVCGateway.Service1Client Proxy = new SVCGateway.Service1Client();
				try
				{
					string Items = (string) (Proxy.PopulateRepoSecure("", CID, TPW, RC, RetTxt));
					if (Items.Length > 0)
					{
						cbRepo.Items.Clear();
						string[] A = Items.Split("|".ToCharArray());
						for (int I = 0; I <= A.Length - 1; I++)
						{
							cbRepo.Items.Add(A[I]);
						}
					}
					else
					{
						MessageBox.Show("No repositories found.");
					}
				}
				catch (Exception ex)
				{
					MessageBox.Show((string) ("ERROR - 100.33.1: " + ex.Message));
					LOG.WriteToArchiveLog((string) ("ERROR - 100.33.1: " + ex.Message));
				}
				Proxy = null;
			}
		}
		
		public void ExitToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			Application.Exit();
		}
		
		public void ExitToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			Application.Exit();
		}
		
		private void MirrorCEDatabasesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			DBLocal.CopyDatabases();
		}
		
		private void InstallCLCToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void InstallCLCToolStripMenuItem_Click_1(System.Object sender, System.EventArgs e)
		{
			Process.Start("http://www.EcmLibrary.com/Ecm2012/Cloud/ClcDownloader/publish.htm");
		}
		
		//tsTimeToArchive
		//tsCountDown
		
		
		public void CalcNextArchiveTime()
		{
			
			DateTime LastArchiveDate = null;
			try
			{
				LastArchiveDate = My.Settings.Default["LastArchiveEndTime"];
			}
			catch (Exception)
			{
				LastArchiveDate = DateTime.Now;
			}
			
			int BackupInterval = System.Convert.ToInt32(My.Settings.Default["BackupIntervalHours"]);
			if (BackupInterval == 0)
			{
				tsTimeToArchive.Text = "Inactive";
				return;
			}
			
			DateTime NextArchvieTime = LastArchiveDate.AddHours(BackupInterval);
			tsTimeToArchive.Text = NextArchvieTime.ToString();
			
			if (NextArchvieTime < DateTime.Now)
			{
				My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
				My.Settings.Default.Save();
				ArchiveALLToolStripMenuItem_Click(null, null);
			}
			else
			{
				
				TimeSpan remainingTime = NextArchvieTime.Subtract(DateTime.Now);
				
				tsCountDown.Text = string.Format("{0}:{1:d2}:{2:d2}", remainingTime.Hours, remainingTime.Minutes, remainingTime.Seconds);
			}
		}
		
		public void btnCountFiles_Click(System.Object sender, System.EventArgs e)
		{
			
			int I = lbArchiveDirs.SelectedItems.Count;
			if (I == 0)
			{
				SB.Text = "You must select an item from the listbox...";
				return;
			}
			
			if (I != 1)
			{
				CkMonitor.Visible = false;
			}
			else
			{
				CkMonitor.Visible = true;
			}
			
			this.Cursor = Cursors.WaitCursor;
			
			bActiveChange = true;
			string DirName = lbArchiveDirs.SelectedItem.ToString().Trim();
			
			btnCountFiles.Enabled = false;
			
			if (ckSubDirs.Checked)
			{
				int iCnt = UTIL.GetFileCountSubdir(DirName);
				SB.Text = DirName + " (Subdirs Included) filecount = " + iCnt.ToString();
			}
			else
			{
				int iCnt = UTIL.GetFileCountDir(DirName);
				SB.Text = DirName + " (No Subdirs) filecount = " + iCnt.ToString();
			}
			
			btnCountFiles.Enabled = true;
			this.Cursor = Cursors.Default;
			
		}
		
		
		public void AppConfigVersionToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string S = System.Configuration.ConfigurationManager.AppSettings["AppConfigVerNo"];
			MessageBox.Show((string) ("App Confing Version: " + S));
		}
		
		public void ckDeleteAfterArchive_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			//If ckDeleteAfterArchive.Checked Then
			//    Dim Msg As String = "This will DELETE all files that are successfully archived" + vbCrLf
			//    MessageBox.Show(Msg)
			//End If
		}
		
		public void BackgroundWorkerContacts_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			//frmNotify.Label1.Text = "Contacts: "
			ARCH.ArchiveContacts();
		}
		
		public void ToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				return;
			}
			
			if (ckDisableOutlookEmailArchive.Checked)
			{
				SB.Text = "Contacts disabled - no archive allowed.";
				return;
			}
			
			if (BackgroundWorkerContacts.IsBusy)
			{
				return;
			}
			
			try
			{
				BackgroundWorkerContacts.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
		}
		
		public void ReOcrPendingGraphics()
		{
			
			if (! SkipPermission)
			{
				string msg = "This process can be  time consuming, are you sure?";
				DialogResult dlgRes = MessageBox.Show(msg, "Re-OCR Pending", MessageBoxButtons.YesNo);
				if (dlgRes == System.Windows.Forms.DialogResult.No)
				{
					return;
				}
			}
			
			string tgtSourceGuid = "";
			string RetMsg = "";
			
			System.Collections.Generic.Dictionary<string, int> ListOfGuids = new System.Collections.Generic.Dictionary<string, int>();
			
			ProxyArchive.getGuidsOfPendingGraphicFiles(modGlobals.gGateWayID, 995, ListOfGuids);
			
			frmNotifyBatchOCR.Default.Show();
			int iTot = System.Convert.ToInt32(ListOfGuids.Keys.Count);
			int I = 0;
			foreach (string S in ListOfGuids.Keys)
			{
				I++;
				tgtSourceGuid = S;
				frmNotifyBatchOCR.Default.lblMsg.Text = (string) ("OCR " + I.ToString() + " of " + iTot.ToString());
				frmNotifyBatchOCR.Default.lblMsg.Refresh();
				frmNotifyBatchOCR.Default.Refresh();
				Application.DoEvents();
				ProxyArchive.ProcessSourceOCR(modGlobals.gGateWayID, 996, tgtSourceGuid, RetMsg);
			}
			
			ProxyArchive.getGuidsOfAllEmailGraphicFiles(modGlobals.gGateWayID, 997, false, ListOfGuids);
			
			bool RC = false;
			iTot = System.Convert.ToInt32(ListOfGuids.Keys.Count);
			I = 0;
			foreach (string S in ListOfGuids.Keys)
			{
				I++;
				tgtSourceGuid = S;
				frmNotifyBatchOCR.Default.lblMsg.Text = (string) ("EMAIL OCR " + I.ToString() + " of " + iTot.ToString());
				frmNotifyBatchOCR.Default.lblMsg.Refresh();
				frmNotifyBatchOCR.Default.Refresh();
				Application.DoEvents();
				ProxyArchive.ProcessEmailAttachmentOCR(modGlobals.gGateWayID, 998, tgtSourceGuid, RC, RetMsg);
				if (! RC)
				{
					Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid);
				}
			}
			
			frmNotifyBatchOCR.Default.Close();
			MessageBox.Show((string) ("Complete: " + RetMsg));
		}
		public void ReOcrAllGraphics()
		{
			string msg = "This process can be very time consuming, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Re-OCR ALL", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			string tgtSourceGuid = "";
			string RetMsg = "";
			
			System.Collections.Generic.Dictionary<string, int> ListOfGuids = new System.Collections.Generic.Dictionary<string, int>();
			
			ProxyArchive.getGuidsOfAllGraphicFiles(modGlobals.gGateWayID, 999, ListOfGuids);
			
			frmNotifyBatchOCR.Default.Show();
			int iTot = System.Convert.ToInt32(ListOfGuids.Keys.Count);
			int I = 0;
			foreach (string S in ListOfGuids.Keys)
			{
				I++;
				tgtSourceGuid = S;
				frmNotifyBatchOCR.Default.lblMsg.Text = (string) ("OCR " + I.ToString() + " of " + iTot.ToString());
				frmNotifyBatchOCR.Default.lblMsg.Refresh();
				frmNotifyBatchOCR.Default.Refresh();
				Application.DoEvents();
				ProxyArchive.ProcessSourceOCR(modGlobals.gGateWayID, 99, tgtSourceGuid, RetMsg);
			}
			
			ProxyArchive.getGuidsOfAllEmailGraphicFiles(modGlobals.gGateWayID, 999, true, ListOfGuids);
			
			bool RC = false;
			iTot = System.Convert.ToInt32(ListOfGuids.Keys.Count);
			I = 0;
			foreach (string S in ListOfGuids.Keys)
			{
				I++;
				tgtSourceGuid = S;
				frmNotifyBatchOCR.Default.lblMsg.Text = (string) ("EMAIL OCR " + I.ToString() + " of " + iTot.ToString());
				frmNotifyBatchOCR.Default.lblMsg.Refresh();
				frmNotifyBatchOCR.Default.Refresh();
				Application.DoEvents();
				ProxyArchive.ProcessEmailAttachmentOCR(modGlobals.gGateWayID, 999, tgtSourceGuid, RC, RetMsg);
				if (! RC)
				{
					Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid);
				}
			}
			frmNotifyBatchOCR.Default.Close();
			MessageBox.Show((string) ("Complete: " + RetMsg));
		}
		
		public void asyncBatchOcrALL_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			ReOcrAllGraphics();
		}
		
		public void asyncBatchOcrPending_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			ReOcrPendingGraphics();
		}
		
		public void ReOcrIncompleteGraphicFilesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			if (asyncBatchOcrPending.IsBusy)
			{
				return;
			}
			
			try
			{
				asyncBatchOcrPending.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
		}
		
		public void ReOcrALLGraphicFilesToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			if (asyncBatchOcrALL.IsBusy)
			{
				return;
			}
			
			try
			{
				asyncBatchOcrALL.RunWorkerAsync();
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
		}
		
		public void EstimateNumberOfFilesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string Msg = "";
			int iCnt = 0;
			
			string S = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + "\r\n";
			iCnt = System.Convert.ToInt32(ProxyArchive.iCount(modGlobals.gGateWayID, 9999, modGlobals.gCurrUserGuidID, S));
			Msg += "Total EMAIL Graphics: " + iCnt.ToString() + "\r\n";
			
			S = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + "\r\n";
			S += "and (OcrPending is null or OcrPending = \'Y\')" + "\r\n";
			iCnt = System.Convert.ToInt32(ProxyArchive.iCount(modGlobals.gGateWayID, 9999, modGlobals.gCurrUserGuidID, S));
			Msg += "Total pending EMAIL Graphics: " + iCnt.ToString() + "\r\n" + "\r\n";
			
			S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + "\r\n";
			iCnt = System.Convert.ToInt32(ProxyArchive.iCount(modGlobals.gGateWayID, 9999, modGlobals.gCurrUserGuidID, S));
			Msg += "Total Source Graphics: " + iCnt.ToString() + "\r\n";
			
			S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + "\r\n";
			S += "and (OcrPending is null or OcrPending = \'Y\')" + "\r\n";
			S += "and (OcrPerformed is null or OcrPerformed != \'Y\')" + "\r\n";
			iCnt = System.Convert.ToInt32(ProxyArchive.iCount(modGlobals.gGateWayID, 9999, modGlobals.gCurrUserGuidID, S));
			Msg += "Total Pending Source Graphics: " + iCnt.ToString() + "\r\n";
			
			MessageBox.Show(Msg);
			
		}
		
		public void CEDatabasesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string msg = "This delete the temporary data stores used for performance enhancement, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			DBLocal.truncateDirs();
			DBLocal.truncateFiles();
			DBLocal.truncateInventory();
			DBLocal.truncateOutlook();
			DBLocal.truncateExchange();
			DBLocal.truncateContacts();
			
			MessageBox.Show("Temporary file stores cleaned up and ready.");
		}
		
		public void ZIPFilesArchivesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string msg = "This deletes the pending ZIP files to be processed, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			DBLocal.zeroizeZipFiles();
			
			MessageBox.Show("Temporary zip files cleaned up and ready.");
		}
		
		public void ViewCEDirectoriesToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			string tPath = System.IO.Path.GetTempPath();
			tPath = tPath + "EcmLibrary\\CE";
			
			Interaction.Shell((string) ("explorer.exe " + '\u0022' + tPath + '\u0022'), Constants.vbNormalFocus, 0, -1);
		}
		
		public void InstallCESP2ToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			Process.Start("http://www.microsoft.com/downloads/en/details.aspx?FamilyID=e497988a-c93a-404c-b161-3a0b323dce24");
		}
		
		public void AllToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			CEDatabasesToolStripMenuItem_Click(null, null);
			ZIPFilesArchivesToolStripMenuItem_Click(null, null);
		}
		
		public void RSSPullToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string sUrl = "http://pheedo.msnbc.msn.com/id/8874569/device/rss/";
			ARCH.getRssFeed(sUrl);
		}
		
		public void hlExchange_LinkClicked(System.Object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
		{
			bool B = DB.isAdmin(modGlobals.gCurrUserGuidID);
			if (! B)
			{
				DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			frmExhangeMail.Default.Show();
		}
		
		public void LinkLabel1_LinkClicked(System.Object sender, System.Windows.Forms.LinkLabelLinkClickedEventArgs e)
		{
			frmPstLoader.Default.UID = UIDcurr;
			frmPstLoader.Default.ShowDialog();
		}
		
		public void asyncVerifyRetainDates_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			ProxyArchive.VerifyRetentionDates(modGlobals.gGateWayID);
		}
		
		public void OnlineHelpToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			Process.Start("http://www.EcmLibrary.com/HelpSaaS/Archive.htm");
		}
		
		public void ckRunOnStart_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (formloaded == false)
			{
				return;
			}
			
			bool RunAtStart = false;
			if (ckRunOnStart.Checked == true)
			{
				RunAtStart = true;
			}
			else
			{
				RunAtStart = false;
			}
			
			this.saveStartUpParms();
			try
			{
				string aPath = "";
				
				aPath = System.Reflection.Assembly.GetExecutingAssembly().Location;
				
				if (RunAtStart)
				{
					RegistryKey oReg = Registry.CurrentUser;
					//Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
					RegistryKey oKey = oReg.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
					
					string SS = oKey.GetValue("EcmLibrary").ToString();
					
					oKey.CreateSubKey("EcmLibrary");
					oKey.SetValue("EcmLibrary", aPath);
					
					SS = oKey.GetValue("EcmLibrary").ToString();
					
					oKey.Close();
				}
				else
				{
					
					//Registry.CurrentUser.DeleteSubKey("Software\Microsoft\Windows\CurrentVersion\Run\EcmLibrary")
					
					RegistryKey oReg = Registry.CurrentUser;
					RegistryKey oKey = oReg.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
					oKey.CreateSubKey("EcmLibrary");
					oKey.SetValue("EcmLibrary", "X");
					
					string SS = oKey.GetValue("EcmLibrary").ToString();
					oKey.DeleteSubKey("EcmLibrary");
					SS = oKey.GetValue("EcmLibrary").ToString();
					
					oKey.Close();
				}
				
				//messagebox.show("Load at startup set to " + ckRunAtStartup.Checked.ToString)
				
				saveStartUpParms();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Failed to set startup parameter." + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter." + "\r\n" + ex.Message));
			}
		}
		
		public void ResetEMAILCRCCodesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			DB.setEmailCrcHash(isAdmin);
			GetOutlookEmailIDsToolStripMenuItem_Click(null, null);
		}
		
		public void LoginToSystemToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			LoginForm1.Default.ShowDialog();
		}
		
		public void ChangeUserPasswordToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmPasswordChange.Default.ShowDialog();
		}
		
		public void GetOutlookEmailIDsToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			SortedList SL = new SortedList();
			DB.LoadEntryIdByUserID(SL);
			DBLocal.truncateOutlook();
			int I = 0;
			int K = SL.Count;
			
			PB1.Value = 0;
			PB1.Minimum = 0;
			PB1.Maximum = SL.Keys.Count + 1;
			foreach (string sKey in SL.Keys)
			{
				DBLocal.addOutlook(sKey);
				I++;
				if (I % 10 == 0)
				{
					PB1.Value = I;
					SB.Text = I.ToString() + " of " + K.ToString();
					SB.Refresh();
				}
			}
			
			PB1.Value = 0;
			SB.Text = "Complete.";
			MessageBox.Show("Outlook refresh complete.");
			SL = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void frmReconMain_FormClosing(object sender, System.Windows.Forms.FormClosingEventArgs e)
		{
			
			UTIL.cleanTempWorkingDir();
			
			try
			{
				GC.Collect();
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR Closing: " + ex.Message));
			}
			
			
		}
		
		public void WebSitesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			ARCH.ArchiveWebSites(modGlobals.gCurrUserGuidID);
			
		}
		
		public void WebPagesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			ARCH.ArchiveSingleWebPage(modGlobals.gCurrUserGuidID);
			
			
		}
		
		public void ArchiveRSSPullsToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
			//Dim ChannelItems As New List(Of rssChannelItem)
			//Dim RSS As New clsRSS
			//'ChannelItems = ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)
			//ChannelItems = RSS.ReadRssDataFromSite("http://feeds.reuters.com/reuters/businessNews", True)
			//RSS = Nothing
			//GC.Collect()
			//GC.WaitForPendingFinalizers()
			
			if (! asyncRssPull.IsBusy)
			{
				asyncRssPull.RunWorkerAsync();
			}
			else
			{
				MessageBox.Show("Appears to be running a RSS archive already...");
			}
			
		}
		
		public void GetRSS(int SecureID)
		{
			
			bool RC = true;
			string WC = " where UserID =  \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			BindingSource RssBindingSource = new BindingSource();
			RssBindingSource.DataSource = DB.GET_RssPull(SecureID, WC, RC);
			dgRss.DataSource = RssBindingSource;
			
		}
		public void GetWebPage(int SecureID)
		{
			
			bool RC = true;
			string WC = " where UserID =  \'" + modGlobals.gCurrUserGuidID + "\' ";
			BindingSource RssBindingSource = new BindingSource();
			
			RssBindingSource.DataSource = DB.GET_WebScreenForGRID(SecureID, WC, RC);
			dgWebPage.DataSource = RssBindingSource;
			
		}
		public void GetWebSite(int SecureID)
		{
			
			System.Collections.Generic.List<DS_WebSite> dItems = new System.Collections.Generic.List<DS_WebSite>();
			bool RC = true;
			string WC = " where UserID =  \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			BindingSource RssBindingSource = new BindingSource();
			
			RssBindingSource = DB.GET_WebSite(SecureID, WC, RC);
			dgWebSite.DataSource = RssBindingSource;
			
		}
		
		public void btnAddRssFeed_Click(System.Object sender, System.EventArgs e)
		{
			string tName = txtRssName.Text;
			string tUrl = txtRssURL.Text;
			bool RC = true;
			string RetentionCode = cbRssRetention.Text;
			if (RetentionCode.Trim().Length == 0)
			{
				MessageBox.Show("Please select a reterntion code.");
				return;
			}
			
			DB.Save_RssPull(modGlobals.gGateWayID, tName, tUrl, modGlobals.gCurrUserGuidID, RetentionCode, ref RC);
			
			if (RC)
			{
				GetRSS(modGlobals.gGateWayID);
			}
			else
			{
				MessageBox.Show((string) ("Failed to save RSS Feed: " + tName));
			}
			
		}
		
		public void btnSaveWebPage_Click(System.Object sender, System.EventArgs e)
		{
			string tName = txtWebScreenName.Text;
			string tUrl = txtWebScreenUrl.Text;
			bool RC = true;
			string RetentionCode = cbWebPageRetention.Text;
			
			DB.Save_WebScreenURL(modGlobals.gGateWayID, tName, tUrl, RetentionCode, modGlobals.gCurrUserGuidID, ref RC);
			
			if (RC)
			{
				GetWebPage(modGlobals.gGateWayID);
			}
			else
			{
				MessageBox.Show((string) ("Failed to save WEB Page: " + tName));
			}
		}
		
		public void btnSaveWebSite_Click(System.Object sender, System.EventArgs e)
		{
			string tName = txtWebSiteName.Text;
			string tUrl = txtWebSiteURL.Text;
			int depth = (int) nbrDepth.Value;
			int width = (int) nbrOutboundLinks.Value;
			bool RC = true;
			string RetentionCode = cbWebSiteRetention.Text;
			DB.Save_WebSiteURL(modGlobals.gGateWayID, tName, tUrl, depth, width, RetentionCode, modGlobals.gCurrUserGuidID, ref RC);
			
			if (RC)
			{
				GetWebSite(modGlobals.gGateWayID);
			}
			else
			{
				MessageBox.Show((string) ("Failed to save WEB Page: " + tName));
			}
		}
		
		public void btnRemoveWebSite_Click(System.Object sender, System.EventArgs e)
		{
			int I = dgWebSite.SelectedRows.Count;
			if (I != 1)
			{
				MessageBox.Show("One and only one row must be selected.");
				return;
			}
			
			string tName = txtWebSiteName.Text;
			string tUrl = txtWebSiteURL.Text;
			int depth = (int) nbrDepth.Value;
			int width = (int) nbrOutboundLinks.Value;
			bool RC = true;
			
			string MySql = "delete from WebSite where WebSite = \'" + tName + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			RC = DB.ExecuteSqlNewConn(MySql);
			
			if (RC)
			{
				GetWebSite(modGlobals.gGateWayID);
			}
			else
			{
				MessageBox.Show((string) ("Failed to delete WEB Page: " + tName));
			}
		}
		
		public void btnRemoveWebPage_Click(System.Object sender, System.EventArgs e)
		{
			
			int I = dgWebPage.SelectedRows.Count;
			if (I != 1)
			{
				MessageBox.Show("One and only one row must be selected.");
				return;
			}
			
			string tName = txtWebScreenName.Text;
			string tUrl = txtWebScreenUrl.Text;
			bool RC = true;
			
			string MySql = "delete from WebScreen where WebScreen = \'" + tName + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			RC = DB.ExecuteSqlNewConn(MySql);
			
			if (RC)
			{
				GetWebPage(modGlobals.gGateWayID);
			}
			else
			{
				MessageBox.Show((string) ("Failed to DELETE WEB Page: " + tName));
			}
		}
		
		public void btnRemoveRSSfeed_Click(System.Object sender, System.EventArgs e)
		{
			
			int I = dgRss.SelectedRows.Count;
			if (I != 1)
			{
				MessageBox.Show("One and only one row must be selected.");
				return;
			}
			
			string tName = txtRssName.Text;
			string tUrl = txtRssURL.Text;
			bool RC = true;
			
			string MySql = "delete from rssPull where RssName = \'" + tName + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			RC = DB.ExecuteSqlNewConn(MySql);
			
			if (RC)
			{
				GetRSS(modGlobals.gGateWayID);
			}
			else
			{
				MessageBox.Show((string) ("Failed to DELETE RSS Feed: " + tName));
			}
		}
		
		private void dgRss_MouseClick(System.Object sender, System.Windows.Forms.MouseEventArgs e)
		{
			SB.Text = "RSS Grid has " + dgRss.Rows.Count.ToString() + " rows.";
		}
		
		public void dgRss_SelectionChanged(System.Object sender, System.EventArgs e)
		{
			int I = dgRss.SelectedRows.Count;
			if (I == 1)
			{
				DataGridViewRow DR = dgRss.SelectedRows[0];
				txtRssName.Text = DR.Cells["RssName"].Value.ToString();
				txtRssURL.Text = DR.Cells["RssURL"].Value.ToString();
				cbRssRetention.Text = DR.Cells["RetentionCode"].Value.ToString();
			}
			else
			{
				SB.Text = "Only one row can be selected.";
			}
		}
		
		public void dgWebPage_SelectionChanged(System.Object sender, System.EventArgs e)
		{
			int I = dgWebPage.SelectedRows.Count;
			if (I == 1)
			{
				DataGridViewRow DR = dgWebPage.SelectedRows[0];
				txtWebScreenName.Text = DR.Cells["WebScreen"].Value.ToString();
				txtWebScreenUrl.Text = DR.Cells["WebUrl"].Value.ToString();
				cbWebPageRetention.Text = DR.Cells["RetentionCode"].Value.ToString();
			}
			else
			{
				SB.Text = "Only one row can be selected.";
			}
		}
		
		public void dgWebSite_SelectionChanged(System.Object sender, System.EventArgs e)
		{
			int I = dgWebSite.SelectedRows.Count;
			if (I == 1)
			{
				DataGridViewRow DR = dgWebSite.SelectedRows[0];
				txtWebSiteName.Text = DR.Cells["WebSite"].Value.ToString();
				txtWebSiteURL.Text = DR.Cells["WebUrl"].Value.ToString();
				nbrDepth.Value = System.Convert.ToDecimal(DR.Cells["Depth"].Value);
				nbrOutboundLinks.Value = System.Convert.ToDecimal(DR.Cells["Width"].Value);
				cbWebSiteRetention.Text = DR.Cells["RetentionCode"].Value.ToString();
			}
			else
			{
				SB.Text = "Only one row can be selected.";
			}
		}
		
		public void asyncRssPull_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			string isPublic = "N";
			string RetentionCode = "Retain 10";
			
			if (ckTerminate.Checked)
			{
				if (! modGlobals.gRunUnattended)
				{
					MessageBox.Show("The TERMINATE immediately box is checked, returning.");
					return;
				}
				else
				{
					LOG.WriteToArchiveLog("asyncRssPull_DoWork: The TERMINATE immediately box is checked, returning.");
				}
			}
			if (ckDisable.Checked)
			{
				ArchiveALLToolStripMenuItem.Enabled = true;
				ContentToolStripMenuItem.Enabled = true;
				ExchangeEmailsToolStripMenuItem.Enabled = true;
				OutlookEmailsToolStripMenuItem.Enabled = true;
				return;
			}
			if (ckRssPullDisabled.Checked)
			{
				return;
			}
			
			ARCH.ArchiveRSS(modGlobals.gCurrUserGuidID);
			
		}
		
		public void asyncSpiderWebSite_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			string isPublic = "N";
			string RetentionCode = "Retain 10";
			
			if (ckTerminate.Checked)
			{
				if (! modGlobals.gRunUnattended)
				{
					MessageBox.Show("The TERMINATE immediately box is checked, returning.");
					return;
				}
				else
				{
					LOG.WriteToArchiveLog("asyncSpiderWebSite_DoWork: The TERMINATE immediately box is checked, returning.");
				}
			}
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				ArchiveALLToolStripMenuItem.Enabled = true;
				ContentToolStripMenuItem.Enabled = true;
				ExchangeEmailsToolStripMenuItem.Enabled = true;
				OutlookEmailsToolStripMenuItem.Enabled = true;
				return;
			}
			if (ckWebSiteTrackerDisabled.Checked)
			{
				SB.Text = "DISABLE WEB Site Archive checked - no archive allowed.";
				return;
			}
			ARCH.ArchiveWebSites(modGlobals.gCurrUserGuidID);
		}
		
		public void asyncSpiderWebPage_DoWork(System.Object sender, System.ComponentModel.DoWorkEventArgs e)
		{
			string isPublic = "N";
			string RetentionCode = "Retain 10";
			
			if (ckTerminate.Checked)
			{
				if (! modGlobals.gRunUnattended)
				{
					MessageBox.Show("The TERMINATE immediately box is checked, returning.");
					return;
				}
				else
				{
					LOG.WriteToArchiveLog("asyncSpiderWebPage_DoWork: The TERMINATE immediately box is checked, returning.");
				}
			}
			if (ckDisable.Checked)
			{
				SB.Text = "DISABLE ALL is checked - no archive allowed.";
				ArchiveALLToolStripMenuItem.Enabled = true;
				ContentToolStripMenuItem.Enabled = true;
				ExchangeEmailsToolStripMenuItem.Enabled = true;
				OutlookEmailsToolStripMenuItem.Enabled = true;
				return;
			}
			if (ckWebPageTrackerDisabled.Checked)
			{
				SB.Text = "DISABLE WEB Page Archive checked - no archive allowed.";
				return;
			}
			
			ARCH.ArchiveSingleWebPage(modGlobals.gCurrUserGuidID);
		}
		
		public void RetentionRulesToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmRetentionCode.Default.ShowDialog();
		}
		
		public void RulesExecutionToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			frmRetentionMgt.Default.ShowDialog();
		}
	}
	
	[System.Runtime.Serialization.DataContract()]public class DS_RssPull
	{
		[System.Runtime.Serialization.DataMember()]public string RssName;
		
		[System.Runtime.Serialization.DataMember()]public string RssUrl;
		
		[System.Runtime.Serialization.DataMember()]public string UserID;
	}
	[System.Runtime.Serialization.DataContract()]public class DS_WebSite
	{
		[System.Runtime.Serialization.DataMember()]public string WebSite;
		
		[System.Runtime.Serialization.DataMember()]public string WebUrl;
		
		[System.Runtime.Serialization.DataMember()]public string UserID;
		
		[System.Runtime.Serialization.DataMember()]public int depth;
		
		[System.Runtime.Serialization.DataMember()]public int width;
	}
	[System.Runtime.Serialization.DataContract()]public class DS_WebScreen
	{
		[System.Runtime.Serialization.DataMember()]public string WebScreen;
		
		[System.Runtime.Serialization.DataMember()]public string WebUrl;
		
		[System.Runtime.Serialization.DataMember()]public string UserID;
	}
	
	
}
