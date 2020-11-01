// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.IO.IsolatedStorage;
using System.Threading;
using System.Windows.Threading;
using System.Web;
//using System.ServiceModel.EndpointAddress;




namespace ECMSearchWPF
{
	public partial class Page1
	{
		
		//Dim EP As New clsEndPoint
		clsDatabase DB = new clsDatabase();
		
		bool bPopulateComboBusy = false;
		string CurrProxySearchEndpoint = "";
		
		string currGateway = "";
		
		clsEncryptV2 ENC = new clsEncryptV2();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		string ParmName = "";
		Guid CurrSessionGuid; // VBConversions Note: Initial value of "Guid.NewGuid()" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		string LoginID = "";
		string CompanyID = "";
		string RepoID = "";
		string EncryptPW = "";
		
		string SVCFS_Endpoint = "";
		string SVCGateway_Endpoint = "";
		string SVCCLCArchive_Endpoint = "";
		string SVCSearch_Endpoint = "";
		string SVCclcDownload_Endpoint = "";
		
		bool bAttached = false;
		string sSecureCS = "";
		
		SVCSearch.Service1Client ProxySearch = new SVCSearch.Service1Client();
		//Dim ProxyGateway As New SVCGateway.Service1Client
		
		clsGlobals GV = new clsGlobals();
		clsCommonFunctions COMMON = new clsCommonFunctions();
		
		int iAttempts = 1;
		//Dim UTIL As New clsUtility
		//Dim LOG As New clsLogging
		//Dim DMA As New clsDma
		
		int CurrNbrOfUsers = 0;
		int CurrNbrOfMachine = 0;
		
		int iExists = -1;
		bool bLicenseExists = false;
		string IP = "";
		DateTime MaintExpire;
		string SecureID = "-1";
		
		List<string> ListOfRepoIS = new List<string>();
		
		bool LocalDebugON = false;
		
		public Page1()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			CurrSessionGuid = Guid.NewGuid();
			
			InitializeComponent();
			
			//AddHandler ProxySearch.GetXrtCompleted, AddressOf Step0GetLicense
			GLOBALS.ProxySearch.validateLoginCompleted += new System.EventHandler(client_validateLogin);
			GLOBALS.ProxySearch.getCustomerLogoTitleCompleted += new System.EventHandler(client_getCustomerLogoTitle);
			
			GLOBALS.LocalDebug = LocalDebugON;
			
			if (LocalDebugON == true)
			{
				lblCustom.Content = "DEBUG ON";
			}
			
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			getPersitData();
			
			//EP.setSearchSvcEndPoint(proxy)
			
			if (txtLoginID.Text.Trim().Length > 0 && txtCompanyID.Text.Trim().Length > 0 && cbRepoID.Text.Trim().Length > 0 && pwEncryptPW.Password.Trim().Length > 0)
			{
				SaveStaticVars();
				SetSearcureParms();
				VerifySecureDbConnection();
				bool RC = false;
				string RetMsg = "";
			}
			
			//imageMain_MouseEnter(Nothing, Nothing)
			//imageMain.Opacity = 1
			lblEndpoint.Content = GLOBALS.ProxySearch.Endpoint.Address.ToString();
		}
		
		public void getServerInstanceName()
		{
			if (! bAttached)
			{
				return;
			}
			
			GLOBALS.ProxySearch.getServerInstanceNameCompleted += new System.EventHandler(client_getServerInstanceName);
			//EP.setSearchSvcEndPoint(proxy)
			Thread.Sleep(GLOBALS.AffinityDelay);
			GLOBALS.ProxySearch.getServerInstanceNameAsync(SecureID, modGlobals.gSystemParms);
		}
		
		public void client_getServerInstanceName(object sender, SVCSearch.getServerInstanceNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerInstanceName = (string) e.Result;
				lblServerInstanceName.Content = e.Result;
			}
			else
			{
				modGlobals.gServerInstanceName = "Unknown";
			}
			getServerMachineName();
		}
		public void getServerMachineName()
		{
			if (! bAttached)
			{
				return;
			}
			
			GLOBALS.ProxySearch.getServerMachineNameCompleted += new System.EventHandler(client_getServerMachineName);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getServerMachineNameAsync(SecureID, modGlobals.gSystemParms);
		}
		public void client_getServerMachineName(object sender, SVCSearch.getServerMachineNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerMachineName = (string) e.Result;
				lblServerMachineName.Content = e.Result;
			}
			else
			{
				modGlobals.gServerMachineName = "Unknown";
				lblServerMachineName.Content = "Unknown";
			}
			getUserGuidID();
		}
		
		public void getUserGuidID()
		{
			if (! bAttached)
			{
				return;
			}
			if (modGlobals.gCurrLoginID.Length == 0)
			{
				modGlobals.gCurrUserGuidID = (string) ("Unknown:" + DateTime.Now.ToString());
			}
			//'Dim proxy As New SVCSearch.Service1Client
			GLOBALS.ProxySearch.getUserGuidIDCompleted += new System.EventHandler(client_getUserGuidID);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getUserGuidIDAsync(SecureID, modGlobals.gCurrLoginID);
		}
		public void client_getUserGuidID(object sender, SVCSearch.getUserGuidIDCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gCurrUserGuidID = (string) e.Result;
				lblCurrUserGuidID.Content = e.Result;
			}
			else
			{
				modGlobals.gCurrUserGuidID = (string) ("Unknown:" + DateTime.Now.ToString());
				lblCurrUserGuidID.Content = "Unknown:" + DateTime.Now.ToString();
			}
			GV.getAttachedMachineName();
			
			GLOBALS.ProxySearch.getServerInstanceNameCompleted -= new System.EventHandler(client_getServerInstanceName);
			GLOBALS.ProxySearch.getServerMachineNameCompleted -= new System.EventHandler(client_getServerMachineName);
			GLOBALS.ProxySearch.getUserGuidIDCompleted -= new System.EventHandler(client_getUserGuidID);
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void LoadSystemRunTimeParameters()
		{
			if (! bAttached)
			{
				return;
			}
			GLOBALS.ProxySearch.getSystemParmCompleted += new System.EventHandler(client_LoadSystemParameters);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getSystemParmAsync(SecureID, modGlobals.gSystemParms);
		}
		public void client_LoadSystemParameters(object sender, SVCSearch.getSystemParmCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				//MessageBox.Show("Step-D 0001 GOOD")
				
				string tVAl = "";
				int II = System.Convert.ToInt32(e.SystemParms.Count);
				foreach (string tKey in e.SystemParms.Keys)
				{
					tVAl = (string) (e.SystemParms.Item(tKey));
					if (! modGlobals.gSystemParms.ContainsKey(tKey))
					{
						modGlobals.gSystemParms.Add(tKey, tVAl);
					}
				}
				MSGS.Content = "System Parms Loaded: " + modGlobals.gSystemParms.Count + " and DB Connection good.";
				Console.WriteLine(e.SystemParms.Count);
				
				//MessageBox.Show("Step-D 0002 GOOD")
				
				LoadLicenseParameters();
				//MessageBox.Show("Step-D 0003 GOOD")
			}
			else
			{
				//MessageBox.Show("Step-D 0004 BAD")
				MSGS.Content = "System Parms field to Load / DB Failed to attach.";
			}
			
			GLOBALS.ProxySearch.getSystemParmCompleted -= new System.EventHandler(client_LoadSystemParameters);
			
		}
		public void SetPagination()
		{
			if (! bAttached)
			{
				return;
			}
			//'Dim proxy As New SVCSearch.Service1Client
			GLOBALS.ProxySearch.getUserParmCompleted += new System.EventHandler(client_SetPagination);
			//EP.setSearchSvcEndPoint(proxy)
			Thread.Sleep(GLOBALS.AffinityDelay);
			GLOBALS.ProxySearch.getUserParmAsync(SecureID, modGlobals.gMaxRecordsToFetch, "user_MaxRecordsToFetch");
		}
		public void client_SetPagination(object sender, SVCSearch.getUserParmCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gMaxRecordsToFetch = (string) e.sVariable;
			}
			else
			{
				modGlobals.gMaxRecordsToFetch = "75";
			}
			GLOBALS.ProxySearch.getUserParmCompleted -= new System.EventHandler(client_SetPagination);
		}
		
		public void btnSubmit_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//getSessionID()
			if (lblAttached.Content.Equals("Not Atached"))
			{
				VerifySecureDbConnection();
				//MessageBox.Show("The Gateway has not been initiated, please attach to the Secure Gateway.")
				return;
			}
			
			if (PasswordBox1.Password.ToUpper().Equals("PASSWORD"))
			{
				if (txtLoginID.Text.Length == 0)
				{
					MessageBox.Show("Please enter your USERID into the Login ID field.");
					return;
				}
				popUserPassword cw = new popUserPassword();
				cw.Show();
				return;
			}
			
			if (txtLoginID.Text.Length == 0)
			{
				MessageBox.Show("You user Login ID is required.");
				return;
			}
			if (PasswordBox1.Password.Length == 0)
			{
				MessageBox.Show("You user Login Password is required.");
				return;
			}
			if (txtCompanyID.Text.Length == 0)
			{
				MessageBox.Show("You user Company ID is required.");
				return;
			}
			if (cbRepoID.Text.Length == 0)
			{
				MessageBox.Show("Please select a repository.");
				return;
			}
			if (pwEncryptPW.Password.Length == 0)
			{
				MessageBox.Show("A Gateway password is required.");
				return;
			}
			
			if (GLOBALS._SecureID < 0)
			{
				VerifySecureDbConnection();
				//MessageBox.Show("The Gateway has not been initiated, please attach to the Secure Gateway.")
				return;
			}
			
			lblAttachedMachineName.Content = modGlobals.gAttachedMachineName;
			lblCurrUserGuidID.Content = txtLoginID.Text;
			lblLocalIP.Content = modGlobals.gLocalMachineIP;
			lblServerInstanceName.Content = modGlobals.gServerInstanceName;
			lblServerMachineName.Content = modGlobals.gServerMachineName;
			
			lblCurrUserGuidID.Content = txtLoginID.Text;
			modGlobals.gCurrUserGuidID = txtLoginID.Text;
			
			if (modGlobals.gEncLicense == null)
			{
				MessageBox.Show("A license has not been confirmed, please contact an administrator.");
				return;
			}
			
			if (modGlobals.gAttachedMachineName.Length == 0)
			{
				MSGS.Content = "Local workstation name missing.";
				modGlobals.gAttachedMachineName = (string) ("UNKNOWN:" + modGlobals.gIpAddr);
				//Return
			}
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				MSGS.Content = "User ID missing, cannot login.";
				return;
			}
			if (modGlobals.gIpAddr.Length == 0)
			{
				MSGS.Content = "Local IP missing, cannot login.";
			}
			
			//*************************
			SaveStaticVars();
			DB.getGatewayCs();
			DB.getRepoCs(int.Parse(GLOBALS.gRowID));
			//*************************
			
			MSGS.Content = "Logging in, standby.";
			
			string CompanyID = txtCompanyID.Text;
			string RepoID = cbRepoID.Text;
			bool RC = true;
			string RetMsg = "";
			
			SaveActiveParm("CurrSessionGuid", CurrSessionGuid.ToString());
			SaveActiveParm("CompanyID", CompanyID);
			SaveActiveParm("RepoID", RepoID);
			SaveActiveParm("LoginID", txtLoginID.Text);
			SaveActiveParm("EncryptPW", ENC.EncryptPhrase(pwEncryptPW.Password));
			
			SavePersist();
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			COMMON.SaveClick(100, modGlobals.gCurrUserGuidID);
			string EPW = PasswordBox1.Password.ToString();
			EPW = ENC.EncryptPhrase(EPW);
			
			Thread.Sleep(GLOBALS.AffinityDelay);
			
			GLOBALS.gRowID = SecureID;
			GLOBALS.ProxySearch.validateLoginAsync(SecureID, txtLoginID.Text.Trim(), EPW, modGlobals.gCurrUserGuidID);
			//EP.setSearchSvcEndPoint(proxy)
			if (bLicenseExists == false)
			{
				GLOBALS.ProxySearch.GetXrtAsync(SecureID, RC, RetMsg);
			}
			
		}
		
		public void client_getCustomerLogoTitle(object sender, SVCSearch.getCustomerLogoTitleCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				string S = (string) e.Result;
				if (S.Length == 0)
				{
					lblCustom.Content = "ECM Library";
					lblCustom.FontSize = 48;
				}
				else if (S.Length > 25)
				{
					lblCustom.FontSize = 26;
				}
				else if (S.Length > 20)
				{
					lblCustom.FontSize = 32;
				}
				else if (S.Length > 15)
				{
					lblCustom.FontSize = 36;
				}
				else if (S.Length > 12)
				{
					lblCustom.FontSize = 40;
				}
				else
				{
					lblCustom.FontSize = 48;
				}
				lblCustom.Content = S;
			}
			else
			{
				lblCustom.Content = "ECM Library";
				lblCustom.FontSize = 48;
			}
			
		}
		
		
		private void MakeSynchronousCallToContractID()
		{
			
			try
			{
				string S = (string) (GLOBALS.ProxySearch.getContractID(SecureID, txtLoginID.Text));
				GLOBALS.ContractID = S;
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			finally
			{
			}
		}
		
		public void client_validateLogin(object sender, SVCSearch.validateLoginCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				
				bool RC = true;
				bool B = System.Convert.ToBoolean(e.Result);
				
				GLOBALS.UserID = txtLoginID.Text;
				
				if (GLOBALS.ContractID == null || GLOBALS.ContractID.Length == 0)
				{
					MakeSynchronousCallToContractID();
					//AddHandler ProxySearch.getContractIDCompleted, AddressOf client_getContractID
					//ProxySearch.getContractIDAsync(SecureID, txtLoginID.Text)
				}
				
				if (B)
				{
					if (! this.Resources.Contains("CompanyID"))
					{
						this.Resources.Add("CompanyID", txtCompanyID.Text);
					}
					
					if (! this.Resources.Contains("RepoID"))
					{
						this.Resources.Add("RepoID", cbRepoID.Text);
					}
					
					if (! this.Resources.Contains("UserID"))
					{
						this.Resources.Add("UserID", txtLoginID.Text);
					}
					
					if (! this.Resources.Contains("SecureID"))
					{
						this.Resources.Add("SecureID", SecureID);
					}
					
					modGlobals.gCurrUserGuidID = (string) e.UserGuidID;
					
					GV.loadUserParms(modGlobals.gCurrUserGuidID);
					
					getServerInstanceName();
					
					SetPagination();
					
					PB.IsIndeterminate = false;
					PB.Visibility = System.Windows.Visibility.Collapsed;
					
					Thread.Sleep(GLOBALS.AffinityDelay);
					GLOBALS.gCurrLogin = txtLoginID.Text;
					
					//Dim NextPage As MainPage = New MainPage
					//NextPage.Show()
					Uri NewPage = new Uri("MainPage.xaml", UriKind.Relative);
					this.NavigationService.Navigate(NewPage);
					
				}
				else
				{
					PB.IsIndeterminate = false;
					PB.Visibility = System.Windows.Visibility.Collapsed;
					MSGS.Content = "LOGIN FAILED, please verify your login ID and password.";
				}
				
			}
			else
			{
				PB.IsIndeterminate = false;
				PB.Visibility = System.Windows.Visibility.Collapsed;
				modGlobals.gServerInstanceName = "Unknown";
				MSGS.Content = "Failure to validate user - " + e.Error.Message;
				MessageBox.Show((string) ("Failure to validate user - " + "\r\n" + e.Error.Message));
			}
			PB.IsIndeterminate = false;
			
		}
		public void client_getContractID(object sender, SVCSearch.getContractIDCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				if (e.Result.Length > 0)
				{
					GLOBALS.ContractID = (string) e.Result;
					MSGS.Content = "Attached to Repository / Contract successful";
				}
				else
				{
					GLOBALS.ContractID = "";
					MessageBox.Show("ERROR: Failed to establish contract handshake, contact administrator or attempt to login again.");
					MSGS.Content = "Attached to Repository / Contract failed";
				}
			}
			else
			{
				MessageBox.Show("ERROR: Failed to establish contract handshake, contact administrator or attempt to login again.");
				MSGS.Content = "Attached to Repository / Contract failed";
			}
			
			GLOBALS.ProxySearch.getContractIDCompleted -= new System.EventHandler(client_getContractID);
			
		}
		private bool InitApplication()
		{
			
			if (! bAttached)
			{
				return false;
			}
			
			clsLogging LOG = new clsLogging();
			
			bool RC = true;
			var LT = "";
			modGlobals.HelpOn = true;
			
			//Dim HIVE As New clsHive
			//gHiveEnabled = HIVE.isHiveEnabled()
			//If gHiveEnabled Then
			//    HivePerformanceToolStripMenuItem.Visible = True
			//Else
			//    HivePerformanceToolStripMenuItem.Visible = False
			//End If
			//HIVE = Nothing
			
			
			if (bLicenseExists == false)
			{
				MessageBox.Show("A license for the product does not exist, please supply the required license.");
				RC = false;
				return RC;
			}
			
ContinueTheExe:
			
			if (! bLicenseExists)
			{
				MessageBox.Show("There does not appear to be an active license for this installation, please contact an administrator - or install a valid license.");
				return false;
			}
			else
			{
				//** Check the expiration date and the service expiration date
				
				GV.isLicenseValid(modGlobals.gServerValText, modGlobals.gInstanceValText);
				var MachineName = lblServerMachineName.Content;
				
				//If gMaxClients > 0 Then
				//    If gNumberOfRegisterdMachines > gMaxClients Then
				//        Dim MSG$ = "It appears all ECM Client licenses have been used." + vbCrLf
				//        MSG += "Please logon from a licensed machine," + vbCrLf + vbCrLf
				//        MSG += "or contact ECM Library for additional client licenses." + vbCrLf + vbCrLf
				//        MSG += "Thank you, closing down." + vbCrLf
				//        MessageBox.Show(MSG)
				//        RC = False
				//        Return RC
				//    End If
				//End If
				
				//**********************************************************
				//* Done in the class NEW sub
				//Dim CurrNbrOfUsers As Integer = DB.GetNbrUsers
				//Dim CurrNbrOfMachine As Integer = DB.GetNbrMachine
				//**********************************************************
				
				if (modGlobals.gNbrOfRegisteredUsers > modGlobals.gNbrOfUsers)
				{
					var Msg = "";
					Msg = Msg + "FrmfrmInit : MachineName : 1103 : " + "\r\n";
					Msg = Msg + "     Number of licenses warning : \'" + MachineName + "\'" + "\r\n";
					Msg = Msg + "     We are very sorry, but the maximum number of USERS has been exceeded." + "\r\n";
					Msg = Msg + "     ECM found " + CurrNbrOfUsers.ToString() + " users currently registered in the system." + "\r\n";
					Msg = Msg + "     Your license awards " + modGlobals.gNbrOfUsers.ToString() + " users." + "\r\n";
					Msg = Msg + "You will have to login with an existing User ID and Password." + "\r\n" + "Please contact admin for support.";
					LOG.WriteToSqlLog(Msg);
					MessageBox.Show(Msg);
					LOG = null;
					RC = false;
					return RC;
				}
				
				if (modGlobals.gNumberOfRegisterdMachines > modGlobals.gNbrOfSeats)
				{
					
					string IP = modGlobals.gLocalMachineIP;
					modGlobals.gIpAddr = modGlobals.gLocalMachineIP;
					modGlobals.gMachineID = (string) lblAttachedMachineName.Content;
					GLOBALS._MachineID = (string) lblAttachedMachineName.Content;
					
					var Msg = "";
					Msg = Msg + "FrmfrmInit : Current Users : 1103b : " + "\r\n";
					Msg = Msg + "     Number of current SEATS warning : \'" + MachineName + "\'" + "\r\n";
					Msg = Msg + "     We are very sorry, but the maximum number of seats (WorkStations) has been exceeded." + "\r\n";
					Msg = Msg + "     ECM found " + CurrNbrOfMachine.ToString() + " machines registered in the system." + "\r\n";
					Msg = Msg + "     Your license awards " + modGlobals.gNbrOfSeats.ToString() + " seats." + "\r\n";
					Msg = Msg + "You will have to login from a WorkStation already defined to ECM." + "\r\n" + "Please contact admin for support.";
					LOG.WriteToSqlLog(Msg);
					MessageBox.Show(Msg);
					RC = false;
					LOG = null;
					return RC;
				}
				else
				{
					//Dim iExists As Integer = DB.GetNbrMachine(MachineName)
					if (modGlobals.gMachineExist == 0)
					{
						var MySql = "insert into Machine (MachineName) values (\'" + MachineName + "\')";
						modGlobals.ExecuteSql(SecureID, MySql);
					}
					string IP = modGlobals.gLocalMachineIP;
					
					modGlobals.gIpAddr = modGlobals.gLocalMachineIP;
					modGlobals.gMachineID = (string) lblAttachedMachineName.Content;
					GLOBALS._MachineID = (string) lblAttachedMachineName.Content;
					
				}
				
				if (modGlobals.gIsLease == true)
				{
					
					//Dim ExpirationDate As Date = CDate(LM.ParseLic(LT$, "dtExpire"))
					DateTime ExpirationDate = modGlobals.gExpirationDate;
					DateTime dtStartDate = "1/1/2007";
					TimeSpan tsTimeSpan;
					int iNumberOfDays;
					//Dim strMsgText As String
					tsTimeSpan = ExpirationDate.Subtract(DateTime.Now);
					iNumberOfDays = tsTimeSpan.Days;
					
					if (DateTime.Now > ExpirationDate.AddDays(30))
					{
						MessageBox.Show("It is dead - your license has totally exppired.");
						RC = false;
						return RC;
					}
					
					if (iNumberOfDays <= 7)
					{
						infoDaysToExpire.Content = "License! " + iNumberOfDays.ToString();
						//infoDaysToExpire.Foreground = "FF141313"
					}
					else if (iNumberOfDays <= 14)
					{
						//infoDaysToExpire.BackColor = Color.LightSalmon
						infoDaysToExpire.Content = "License! " + iNumberOfDays.ToString();
					}
					else if (iNumberOfDays <= 30)
					{
						//infoDaysToExpire.BackColor = Color.Yellow
						infoDaysToExpire.Content = "License@ " + iNumberOfDays.ToString();
					}
					else if (iNumberOfDays <= 60)
					{
						//infoDaysToExpire.BackColor = Color.LightSeaGreen
						infoDaysToExpire.Content = "License? " + iNumberOfDays.ToString();
					}
					else if (iNumberOfDays < 90)
					{
						//infoDaysToExpire.BackColor = Color.Green
						infoDaysToExpire.Content = "License* " + iNumberOfDays.ToString();
					}
					else
					{
						infoDaysToExpire.Content = " #" + iNumberOfDays.ToString() + " days";
					}
					
					
					if (DateTime.Now > ExpirationDate)
					{
						LOG.WriteToSqlLog("FrmfrmInit : 1001 We are very sorry, but your software LEASE has expired. Please contact ECM Library support.");
						MessageBox.Show("We are very sorry, but your software license has expired." + "\r\n" + "\r\n" + "Please contact ECM Library support.");
						MessageBox.Show("The application will now end, please restart with the new license.");
						RC = false;
						LOG = null;
						return RC;
					}
				}
				
				MaintExpire = modGlobals.gMaintExpire;
				if (DateTime.Now > MaintExpire)
				{
					string NoticeMessage = "";
					NoticeMessage = "Crititcal NOTICE Maintenance Expiration : We are very sorry to inform you, but your maintenance agreement has expired. No further support can be supplied and product updates are ended until your maintenance license is renewed." + "\r\n" + "\r\n" + "Please contact ECM Library support.";
					this.Title = "Crititcal NOTICE Maintenance Expired.";
					LOG.WriteToSqlLog(NoticeMessage);
				}
				
			}
			
			this.AllowDrop = false;
			
			//** If here and no license exists, just quit
			if (bLicenseExists == false)
			{
				LOG.WriteToSqlLog("FATAL: Unrecoverable Error: No license exists... aborting.");
				MessageBox.Show("Cannot continue without a license.");
				RC = false;
				LOG = null;
				return RC;
			}
			
			//InitProcessAsFiles()
			//DFLT.setDefaultAttributes()
			
			LogIntoSystem();
			
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				//getUserGuidID()
				modGlobals.gCurrLoginID = txtLoginID.Text;
				Console.WriteLine(modGlobals.gCurrUserGuidID);
			}
			
			//DB.ckRunAtStartUp()
			
			SetDefaults();
			
			//LOG.CleanOutTempDirectory()
			//LOG.CleanOutErrorDirectory()
			
			string SSVersion = modGlobals.gServerVersion;
			if (SSVersion.IndexOf("Express") + 1 > 0)
			{
				double DBSize = 0;
				DBSize = modGlobals.gCurrDbSize;
				if (DBSize > 3250)
				{
					MSGS.Content = "DB Limit Warning @ " + DBSize.ToString() + " MB";
					//sb.BackColor = Color.Yellow
				}
				if (DBSize > 3850)
				{
					MSGS.Content = "DB Limit Warning @ " + DBSize.ToString() + " MB";
					//sb.BackColor = Color.RED
				}
				if (DBSize > 9000)
				{
					MSGS.Content = "DB Limit Warning @ " + DBSize.ToString() + " MB";
					//sb.BackColor = Color.Red
				}
			}
			
			COMMON.resetMissingEmailIds();
			COMMON.RecordGrowth();
			
			//Dim ServerValText, InstanceValText As String
			//gisLicenseValid As Boolean = LM.isLicenseLocatedOnAssignedMachine(ServerValText, InstanceValText)
			
			if (modGlobals.gIsLicenseValid == false)
			{
				MSGS.Content += " @ License mismatch: " + modGlobals.gServerValText;
				MSGS.Content += modGlobals.gInstanceValText;
			}
			
			LOG = null;
			
			return true;
			
		}
		
		public void SetDefaults()
		{
			if (! bAttached)
			{
				return;
			}
			
			//UserParmInsertUpdate("CurrSearchCriteria", gCurrUserGuidID, " ")
			//UserParmInsertUpdate("ckLimitToExisting", gCurrUserGuidID, "0")
			//DeleteMarkedImageCopyFiles()
			modGlobals.TurnHelpOn(0);
			
			modGlobals.bInitialized = true;
			
			modGlobals.SystemSqlTimeout = modGlobals.getSystemParm("SqlServerTimeout");
			
			modGlobals.gMachineID = (string) lblAttachedMachineName.Content;
			GLOBALS._MachineID = (string) lblAttachedMachineName.Content;
			
			//LOG.CleanOutTempDirectory()
			//DFLT.AddUserSelectableParameters(gCurrUserGuidID)
			
			//CheckForDBUpdates(False)
			//Dim S as string = "Select count(*) from Retention"
			//Dim iCnt As Integer = DB.iCount(S)
			//If iCnt = 0 Then
			//    DB.AddDefaultRetentionCode()
			//End If
			clsUtility UTIL = new clsUtility();
			UTIL.SetVersionAndServer();
			UTIL = null;
			
			//Dim bEmbededJPGMetadata As Boolean = DB.ShowGraphicMetaDataScreen
			
			//AddUserDefaults()
			
			//DB.UserParmInsert("SoundOn", gCurrUserGuidID, "ON")
			var Msg2 = "Login: " + modGlobals.gCurrLoginID;
			Msg2 = Msg2 + ", " + modGlobals.gMachineID;
			clsLogging LOG = new clsLogging();
			LOG.WriteToSqlLog(Msg2);
			LOG = null;
			
		}
		
		public void LogIntoSystem()
		{
			if (! bAttached)
			{
				return;
			}
			
			try
			{
				modGlobals.FilesToDelete.Clear();
				
				var SaveName = "UserStartUpParameters";
				var SaveTypeCode = "StartUpParm";
				var CurrentLoginID = "";
				
Retry:
				if (iAttempts >= 4)
				{
					MessageBox.Show("Too many failed login attempts, closing down.");
					return;
				}
				
BadAutoLogin:
				CurrentLoginID = txtLoginID.Text.Trim();
				modGlobals.gCurrLoginID = txtLoginID.Text.Trim();
				//getUserGuidID()
GoodLogin:
				GV.getUserGuidID(modGlobals.gCurrLoginID);
				SetDefaults();
				
				MSGS.Content += " : Logged in as " + CurrentLoginID;
			}
			catch (Exception ex)
			{
				clsLogging LOG = new clsLogging();
				LOG.WriteToSqlLog((string) ("FrmfrmInit : ReLogIntoSystem : 100 : " + ex.Message));
				LOG = null;
				MessageBox.Show("LogIntoSystem: Login failed.");
			}
			
		}
		
		public void instantiateGlobalVars()
		{
			if (! bAttached)
			{
				return;
			}
			
			GV.getGlobalVariables();
			GV.getSqlServerVersion();
			
			InitApplication();
			
			//Dim SS$ = "Select count(*) from LoginClient"
			//Dim EcmClientsDefinedToSystem As Integer = DB.iCount(SS as string)
			
			
			//Dim AdminExist As Boolean = DB.adminExist()
			//Dim iExists As Integer = DB.GetNbrMachine(MachineName)
			//Dim IP As String = DMA.getIpAddr
			
			//gNbrOfSeats = Val(LM.ParseLic(LT$, "txtNbrSeats"))
			//gLicenseType = LM.LicenseType
			//gIsSDK = LM.SdkLicenseExists
			//gNbrOfUsers = Val(LM.ParseLic(LT$, "txtNbrSimlSeats"))
			
			//CurrNbrOfUsers = DB.GetNbrUsers
			//CurrNbrOfMachine = DB.GetNbrMachine
			
			//DB.RegisterEcmClient(MachineName as string)
			//DB.RegisterMachineToDB(MachineName as string)
			//gMaxClients = LM.getMaxClients
			//bLicenseExists = DB.LicenseExists
			//LT$ = DB.GetXrt
			
		}
		
		public void InitServerAttach()
		{
			if (! bAttached)
			{
				return;
			}
			
			bool RC = false;
			string RetMsg = "";
			
			if (GLOBALS._SecureID <= 0)
			{
				//MSGS.Content = "NOTICE: The Gateway has not connected - please wait amoment before logging in to the system."
				return;
			}
			
			//EP.setSearchSvcEndPoint(proxy)
			if (bLicenseExists == false)
			{
				GLOBALS.ProxySearch.GetXrtCompleted += new System.EventHandler(Step0GetLicense);
				GLOBALS.ProxySearch.GetXrtAsync(GLOBALS._SecureID, RC, RetMsg);
			}
			
			//AddHandler ProxySearch.GetXrtTestCompleted, AddressOf StepGetXrtTest
			//ProxySearch.GetXrtTestAsync(DateTime.Now)
			
		}
		public void StepGetXrtTest(object sender, SVCSearch.GetXrtTestCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				Console.WriteLine(e.Result);
			}
			else
			{
				MessageBox.Show((string) e.Error.Message);
				Console.WriteLine(e.Result);
			}
			
			GLOBALS.ProxySearch.GetXrtTestCompleted -= new System.EventHandler(StepGetXrtTest);
		}
		public void Step0GetLicense(object sender, SVCSearch.GetXrtCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				if (e.Result == null)
				{
					//MessageBox.Show("Step-B 0003 BAd")
					bLicenseExists = false;
					modGlobals.gEncLicense = "";
					btnSubmit.IsEnabled = false;
					MessageBox.Show("A license for the product does not exist, please supply the required license.");
					return;
				}
				else
				{
					//MessageBox.Show("Step-B 0003 GOOD")
					GLOBALS.LicenseValid = true.ToString();
					bLicenseExists = true;
					btnSubmit.IsEnabled = true;
					modGlobals.gEncLicense = (string) e.Result;
					
					//MessageBox.Show("Step-B 0004 GOOD")
					LoadSystemRunTimeParameters();
					//MessageBox.Show("Step-B 0005 GOOD")
					getServerInstanceName();
					//MessageBox.Show("Step-B 0006 GOOD")
				}
				
				lblNbrUsers.Content = GLOBALS.RegisteredUsers;
				lblSqlVersion.Content = GLOBALS.SqlSvrVersion;
				lblMaintDays.Content = MaintExpire;
				lblNbrSeats.Content = GLOBALS.NbrOfSeats + "/" + GLOBALS.MaxClients;
				lblNbrMachines.Content = GLOBALS.NbrRegisteredMachines;
				
				MSGS.Content = "Attached to Repository";
				
			}
			else
			{
				bLicenseExists = false;
				modGlobals.gEncLicense = "";
				MessageBox.Show((string) ("001X - An error occured while verifying the ECM license, please contact an administrator ask him/her to check the LOGS table: " + "\r\n" + e.Error.ToString()));
				MessageBox.Show((string) ("002X - " + e.Error.InnerException.ToString()));
				return;
			}
			
			GLOBALS.ProxySearch.GetXrtCompleted -= new System.EventHandler(Step0GetLicense);
			
		}
		
		public void LoadLicenseParameters()
		{
			//MessageBox.Show("Step-E  NULL GOOD")
		}
		
		
		public void ckRememberMe_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (txtLoginID.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a login ID first, returning.");
				return;
			}
			
			SavePersist();
			
		}
		
		public void ckRememberMe_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			try
			{
				RemovePersist();
				//System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("LoginID")
				MSGS.Content = "Removed";
			}
			catch (Exception ex)
			{
				MSGS.Content = "Failed to remove - " + ex.Message;
			}
		}
		
		public void PasswordBox1_KeyDown(System.Object sender, System.Windows.Input.KeyEventArgs e)
		{
			if (e.Key == Key.Enter)
			{
				btnSubmit_Click(null, null);
			}
		}
		
		public void txtLoginID_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			lblCurrUserGuidID.Content = txtLoginID.Text;
		}
		
		public void PopulateRepoComboBox()
		{
			
			
			cbRepoID.Visibility = System.Windows.Visibility.Collapsed;
			pwEncryptPW.Visibility = System.Windows.Visibility.Collapsed;
			btnGetRepos.Visibility = System.Windows.Visibility.Collapsed;
			
			//MessageBox.Show("Get REPOS 01")
			
			string CS = "";
			string CompanyID = txtCompanyID.Text;
			bool RC = true;
			string RetMsg = "";
			
			if (CompanyID.Trim().Length == 0)
			{
				MessageBox.Show("Please supply your company ID and password.");
				return;
			}
			
			GLOBALS.ProxySearch.PopulateSecureLoginCBCompleted += new System.EventHandler(client_PopulateSecureLoginCB);
			//EP.setSearchSvcEndPoint(proxy)
			string[] lArray = ListOfRepoIS.ToArray;
			GLOBALS.ProxySearch.PopulateSecureLoginCBAsync(SecureID, lArray, CompanyID, RC, RetMsg);
			
		}
		public void client_PopulateSecureLoginCB(object sender, SVCSearch.PopulateSecureLoginCBCompletedEventArgs e)
		{
			
			if (bPopulateComboBusy)
			{
				return;
			}
			
			bPopulateComboBusy = true;
			
			bool RC = true;
			string RetMsg = "";
			
			cbRepoID.Items.Clear();
			if (e.Error == null)
			{
				if (e.RetMsg.Length > 0)
				{
					currGateway = (string) e.RetMsg;
					lblGateway.Content = e.RetMsg + ":1771";
					//MessageBox.Show(RetMsg)
				}
				if (e.CB.Count == 0)
				{
					MSGS.Content = "No records found.";
					cbRepoID.Items.Clear();
					return;
				}
				foreach (string s in e.CB)
				{
					ListOfRepoIS.Add(s);
				}
				//ListOfRepoIS = e.CB
				for (int i = 0; i <= ListOfRepoIS.Count - 1; i++)
				{
					cbRepoID.Items.Add(ListOfRepoIS.Item(i));
					if (i == 0)
					{
						cbRepoID.Text = (string) (ListOfRepoIS.Item(i));
						cbRepoID.SelectedItem = ListOfRepoIS.Item(i);
					}
					cbRepoID.Visibility = System.Windows.Visibility.Visible;
					pwEncryptPW.Visibility = System.Windows.Visibility.Visible;
					btnGetRepos.Visibility = System.Windows.Visibility.Visible;
				}
			}
			else
			{
				MessageBox.Show("Get REPOS Error: \'" + e.Error.Message + "\'");
				//Dim LOG As New clsLogging
				//LOG.WriteToSqlLog("ERROR:100.x1-client_PopulateSecureLoginCB:" + e.Error.Message)
				//LOG = Nothing
			}
			cbRepoID.Visibility = System.Windows.Visibility.Visible;
			pwEncryptPW.Visibility = System.Windows.Visibility.Visible;
			btnGetRepos.Visibility = System.Windows.Visibility.Visible;
			bPopulateComboBusy = false;
			
			GLOBALS.ProxySearch.PopulateSecureLoginCBCompleted -= new System.EventHandler(client_PopulateSecureLoginCB);
			
		}
		
		public void btnGetRepos_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateRepoComboBox();
			cbRepoID.Visibility = System.Windows.Visibility.Visible;
			pwEncryptPW.Visibility = System.Windows.Visibility.Visible;
			btnGetRepos.Visibility = System.Windows.Visibility.Visible;
			btnAttach.Visibility = System.Windows.Visibility.Visible;
		}
		
		public void client_setSessionCompanyID(object sender, SVCSearch.setSessionCompanyIDCompletedEventArgs e)
		{
			bool RC;
			clsLogging LOG = new clsLogging();
			if (e.Error == null)
			{
				RC = System.Convert.ToBoolean(e.RC);
				if (! RC)
				{
					LOG.WriteToSqlLog("ERROR:100.x1-client_setSessionCompanyID: did not set the session var.");
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR:100.x1-client_setSessionCompanyID:" + e.Error.Message));
			}
			LOG = null;
		}
		
		public void btnAttach_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bool B = VerifySecureDbConnection();
			if (B)
			{
				btnSubmit.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				//btnSubmit.Visibility = Windows.Visibility.Collapsed
			}
		}
		
		public bool VerifySecureDbConnection()
		{
			
			string CompanyID = txtCompanyID.Text;
			string RepoID = cbRepoID.Text;
			bool RC = false;
			string RetMsg = "";
			int iRow = -1;
			
			if (CompanyID.Length == 0)
			{
				MSGS.Content = "CompanyID must be supplied, CANNOT ATTACH.";
				return false;
			}
			if (RepoID.Length == 0)
			{
				MSGS.Content = "A Repository must be selected, CANNOT ATTACH.";
				return false;
			}
			
			string EPW = pwEncryptPW.Password;
			EPW = ENC.EncryptPhrase(EPW);
			
			//AddHandler ProxySearch.GetXrtTestCompleted, AddressOf client_GetXrtTest
			//ProxySearch.GetXrtTestAsync(DateTime.Now)
			
			GLOBALS.ProxySearch.validateAttachSecureLoginCompleted += new System.EventHandler(client_validateAttachSecureLogin);
			
			GLOBALS.ProxySearch.validateAttachSecureLoginAsync(SecureID, CompanyID, RepoID, txtLoginID.Text, EPW, RC, RetMsg, GLOBALS.GatewayEndPoint, GLOBALS.DownloadEndPoint, GLOBALS.NCGWCS);
			
			return true;
			
		}
		public void client_GetXrtTest(object sender, SVCSearch.GetXrtTestCompletedEventArgs e)
		{
			string s = (string) e.Result;
			Console.WriteLine(s);
			GLOBALS.ProxySearch.validateAttachSecureLoginCompleted -= new System.EventHandler(client_validateAttachSecureLogin);
		}
		public void client_validateAttachSecureLogin(object sender, SVCSearch.validateAttachSecureLoginCompletedEventArgs e)
		{
			bool RC = false;
			string RetMsg = "";
			
			if (e.Error == null)
			{
				
				if (e.RC == true)
				{
					
					SecureID = (string) e.SecureID;
					GLOBALS.gRowID = SecureID;
					GLOBALS.GatewayEndPoint = (string) e.GateWayEndPoint;
					GLOBALS.DownloadEndPoint = (string) e.DownloadEndpoint;
					GLOBALS.NCGWCS = (string) e.ENCCS;
					
					Console.WriteLine("EP4: " + GLOBALS.GatewayEndPoint + "\r\n" + GLOBALS.DownloadEndPoint);
					
					lblAttached.Content = "Attached " + e.RetMsg + ": ";
					
					MSGS.Content = "Gateway Connected: " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
					
					//** Now, get and set the ENDPOINT for the services so that they are local
					string companyID = txtCompanyID.Text.Trim();
					string Repoid = cbRepoID.Text.Trim();
					
					//wdmxx
					//AddHandler ProxySearch.GetEndpointsCompleted, AddressOf client_GetEndpoints
					//ProxySearch.GetEndpointsAsync(companyID, Repoid)
					
					btnSubmit.Visibility = Visibility.Visible;
					bAttached = true;
					btnSubmit.Visibility = System.Windows.Visibility.Visible;
					modGlobals.gServerInstanceName = (string) e.RetMsg;
					lblServerInstanceName.Content = e.RetMsg;
					
					//InitServerAttach()
					//GV.getSystemVariables(clsGVAR._SecureID)
					//SetSearcureParms()
					
				}
				else
				{
					lblAttached.Content = "* Not Attached " + e.RetMsg + ": " + DateTime.Now.ToString();
					MSGS.Content = "NOT Connected: " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
					//btnSubmit.Visibility = Visibility.Collapsed
					SecureID = "-1";
					bAttached = false;
					modGlobals.gServerInstanceName = "NA";
					lblServerInstanceName.Content = "NA";
				}
			}
			else
			{
				try
				{
					if (e.RetMsg.Length > 0)
					{
						MessageBox.Show((string) e.RetMsg);
						lblAttached.Content = "** Not Attached " + e.RetMsg + ": ";
					}
					else if (e.RetMsg != null)
					{
						lblAttached.Content = "** Not Attached " + e.RetMsg + ": ";
					}
					else
					{
						lblAttached.Content = "** Not Attached to : " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
					}
				}
				catch (Exception)
				{
					lblAttached.Content = "** Not Attached to : " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
				}
				
				MSGS.Content = "NOT Connected: " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
				SecureID = "-1";
				modGlobals.gServerInstanceName = "Unknown";
			}
			
			GLOBALS.ProxySearch.validateAttachSecureLoginCompleted -= new System.EventHandler(client_validateAttachSecureLogin);
			
			//getServerMachineName()
		}
		
		//Sub client_GetEndpoints(ByVal sender As Object, ByVal e As SVCGateway.GetEndpointsCompletedEventArgs)
		//    Dim RC As Boolean = False
		//    Dim RetMsg As String = ""
		
		//    If e.Error Is Nothing Then
		//        If (e.Result.Length > 0) Then
		//            Dim endPoints As String = e.Result
		//            If (endPoints.Length = 0) Then
		//                Return
		//            End If
		
		//            Dim epoint() As String = endPoints.Split("|")
		
		//            SVCFS_Endpoint = epoint(0)
		//            SVCGateway_Endpoint = epoint(1)
		//            SVCCLCArchive_Endpoint = epoint(2)
		//            SVCSearch_Endpoint = epoint(3)
		//            SVCclcDownload_Endpoint = epoint(4)
		
		//            If (SVCSearch_Endpoint.length > 0) Then
		
		//                clsGVAR.SearchEndPoint = SVCSearch_Endpoint
		
		//                Dim ServiceUri As New Uri(SVCSearch_Endpoint)
		//                Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)
		
		//                ProxySearch.Endpoint.Address = EPA
		//                lblGateway.Content = "DEP:" + SVCSearch_Endpoint
		//            End If
		
		//            InitServerAttach()
		//            GV.getSystemVariables(clsGVAR._SecureID)
		//            SetSearcureParms()
		//            getServerMachineName()
		//            GC.Collect()
		//            GC.WaitForPendingFinalizers()
		//        End If
		//    Else
		//        lblGateway.Content = "EP:" + ProxySearch.Endpoint.Address.ToString
		//    End If
		//    'RemoveHandler ProxyGateway.GetEndpointsCompleted, AddressOf client_GetEndpoints
		//    GC.Collect()
		//    GC.WaitForPendingFinalizers()
		
		//End Sub
		
		public void SetSearcureParms()
		{
			
			if (! bAttached)
			{
				return;
			}
			
			
			string CID = txtCompanyID.Text.Trim();
			string RID = cbRepoID.Text.Trim();
			bool RC = false;
			
			if (CID.Length == 0 || RID.Length == 0)
			{
				return;
			}
			
			SaveActiveParm("CurrSessionGuid", CurrSessionGuid.ToString());
			SaveActiveParm("CompanyID", CID);
			SaveActiveParm("RepoID", RID);
			
			if (CurrSessionGuid.ToString().Length == 0)
			{
				MessageBox.Show("Current Session ID is being established: Communication between network is being validated, please wait a few seconds and then try again.");
				return;
			}
			if (CID.Length == 0)
			{
				MessageBox.Show("Company ID is being verified: Communication between network is being validated, please wait a few seconds and then try again.");
				return;
			}
			if (RID.Length == 0)
			{
				MessageBox.Show("Repository ID is being verified: Communication between network is being validated, please wait a few seconds and then try again.");
				return;
			}
			
			GLOBALS.ProxySearch.setSecureLoginParmsCompleted += new System.EventHandler(client_setSecureLoginParms);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.setSecureLoginParmsAsync(SecureID, CID, RID, RC);
			
		}
		public void client_setSecureLoginParms(object sender, SVCSearch.setSecureLoginParmsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.RC)
				{
					btnSubmit.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					MSGS.Content = "NOTICE: Failed to set CompanyID and RepoID, login not permitted.";
					//btnSubmit.Visibility = Windows.Visibility.Collapsed
				}
			}
			else
			{
				MessageBox.Show((string) ("Error client_setSecureLoginParms: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.setSecureLoginParmsCompleted -= new System.EventHandler(client_setSecureLoginParms);
		}
		
		public void SaveStaticVars()
		{
			if (SecureID >= 0)
			{
				GLOBALS._SecureID = int.Parse(SecureID);
			}
			GLOBALS._RepoID = cbRepoID.Text;
			GLOBALS._CompanyID = txtCompanyID.Text;
			GLOBALS._UserID = txtLoginID.Text;
			GLOBALS._ActiveGuid = CurrSessionGuid;
			GLOBALS._SessionGuid = CurrSessionGuid;
			GLOBALS._EncryptPW = pwEncryptPW.Password;
			
			if (this.Resources.Contains("SecureID"))
			{
				this.Resources.Remove("SecureID");
			}
			this.Resources.Add("SecureID", SecureID.ToString());
			if (this.Resources.Contains("CurrSessionGuid"))
			{
				this.Resources.Remove("CurrSessionGuid");
			}
			this.Resources.Add("CurrSessionGuid", CurrSessionGuid.ToString());
			if (this.Resources.Contains("CompanyID"))
			{
				this.Resources.Remove("CompanyID");
			}
			this.Resources.Add("CompanyID", txtCompanyID.Text);
			if (this.Resources.Contains("RepoID"))
			{
				this.Resources.Remove("RepoID");
			}
			this.Resources.Add("RepoID", cbRepoID.Text);
			if (this.Resources.Contains("LoginID"))
			{
				this.Resources.Remove("LoginID");
			}
			this.Resources.Add("LoginID", txtLoginID.Text);
			
			SavePersist();
			
			//Try
			//    If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("SecureID") Then
			//        System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("SecureID")
			//    End If
			//    System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Add("SecureID", SecureID)
			//Catch ex As Exception
			//    MSGS.Content = "Failed to save your SecureID - " + ex.Message
			//End Try
			
			//Try
			//    If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("LoginID") Then
			//        System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("LoginID")
			//    End If
			//    System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Add("LoginID", txtLoginID.Text.Trim)
			//Catch ex As Exception
			//    MSGS.Content = "Failed to save your login - " + ex.Message
			//End Try
			//Try
			//    If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("CompanyID") Then
			//        System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("CompanyID")
			//    End If
			//    System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Add("CompanyID", txtCompanyID.Text)
			//Catch ex As Exception
			//    MSGS.Content = "Failed to save your CompanyID - " + ex.Message
			//End Try
			//Try
			//    If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("cbRepoID") Then
			//        System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("cbRepoID")
			//    End If
			//    System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Add("cbRepoID", cbRepoID.Text)
			//Catch ex As Exception
			//    MSGS.Content = "Failed to save your RepoID - " + ex.Message
			//End Try
			//Try
			//    If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("pwEncryptPW") Then
			//        System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("pwEncryptPW")
			//    End If
			//    Dim EPW As String = ENC.EncryptPhrase(pwEncryptPW.Password)
			//    System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Add("pwEncryptPW", EPW)
			//Catch ex As Exception
			//    MSGS.Content = "Failed to save your EncryptPW - " + ex.Message
			//End Try
			//Try
			//    If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("CurrSessionGuid") Then
			//        System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Remove("CurrSessionGuid")
			//    End If
			//    System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Add("CurrSessionGuid", CurrSessionGuid.ToString)
			//Catch ex As Exception
			//    MSGS.Content = "Failed to save your CurrSessionGuid - " + ex.Message
			//End Try
		}
		
		//Sub getStaticVars()
		//    Try
		//        If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("SecureID") Then
		//            SecureID = System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Item("SecureID")
		//        End If
		//    Catch ex As Exception
		//        MSGS.Content = "Failed to save your SecureID - " + ex.Message
		//    End Try
		//    Try
		//        If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("LoginID") Then
		//            LoginID = System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Item("LoginID")
		//        End If
		//    Catch ex As Exception
		//        MSGS.Content = "Failed to save your login - " + ex.Message
		//    End Try
		//    Try
		//        If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("CompanyID") Then
		//            CompanyID = System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Item("CompanyID")
		//        End If
		//    Catch ex As Exception
		//        MSGS.Content = "Failed to save your CompanyID - " + ex.Message
		//    End Try
		//    Try
		//        If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("cbRepoID") Then
		//            RepoID = System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Item("cbRepoID")
		//        End If
		//    Catch ex As Exception
		//        MSGS.Content = "Failed to save your RepoID - " + ex.Message
		//    End Try
		//    Try
		//        If System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Contains("pwEncryptPW") Then
		//            EncryptPW = System.IO.IsolatedStorage.IsolatedStorageSettings.ApplicationSettings.Item("pwEncryptPW")
		//        End If
		//        'Dim EPW As String = ENC2.DecryptPhrase(EncryptPW)
		//    Catch ex As Exception
		//        MSGS.Content = "Failed to save your EncryptPW - " + ex.Message
		//    End Try
		//End Sub
		
		public void SaveActiveParm(string ParmName, string ParmVal)
		{
			if (! bAttached)
			{
				return;
			}
			
			GLOBALS.ProxySearch.ActiveSessionCompleted += new System.EventHandler(client_ActiveSession);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ActiveSessionAsync(SecureID, CurrSessionGuid, ParmName, ParmVal);
		}
		public void client_ActiveSession(object sender, SVCSearch.ActiveSessionCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result)
				{
				}
				else
				{
					MSGS.Content = "Failure to save " + ParmName;
				}
			}
			else
			{
				MSGS.Content = "Failure to save " + ParmName + e.Error.Message;
			}
			GLOBALS.ProxySearch.ActiveSessionCompleted -= new System.EventHandler(client_ActiveSession);
		}
		
		public void RemovePersist()
		{
			ISO.PersistDataInit("NA", "NA");
		}
		public void ResetPersist()
		{
			//ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString)
			txtCompanyID.Text = "";
			cbRepoID.Text = "";
			txtLoginID.Text = "";
			pwEncryptPW.Password = "";
			string TPW = "";
			
			ISO.PersistDataSave("CompanyID", txtCompanyID.Text);
			ISO.PersistDataSave("RepoID", cbRepoID.Text);
			ISO.PersistDataSave("LoginID", txtLoginID.Text);
			//Dim TPW As String = pwEncryptPW.Password
			TPW = ENC.EncryptPhrase(TPW);
			ISO.PersistDataSave("EncryptPW", TPW);
			ISO.PersistDataSave("EOD", "***");
		}
		public void SavePersist()
		{
			ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString());
			ISO.PersistDataSave("CompanyID", txtCompanyID.Text);
			ISO.PersistDataSave("RepoID", cbRepoID.Text);
			ISO.PersistDataSave("LoginID", txtLoginID.Text);
			string TPW = pwEncryptPW.Password;
			TPW = ENC.EncryptPhrase(TPW);
			ISO.PersistDataSave("EncryptPW", TPW);
			ISO.PersistDataSave("EOD", "***");
		}
		public void getPersitData()
		{
			string SID = ISO.PersistDataRead("SecureID");
			if (SID.Length > 0)
			{
				SecureID = System.Convert.ToString(int.Parse(SID));
				GLOBALS._SecureID = int.Parse(SecureID);
			}
			
			txtLoginID.Text = ISO.PersistDataRead("LoginID");
			
			txtCompanyID.Text = ISO.PersistDataRead("CompanyID");
			
			cbRepoID.Text = ISO.PersistDataRead("RepoID");
			if (cbRepoID.Text.Length > 0)
			{
				cbRepoID.SelectedItem = cbRepoID.Text;
			}
			
			string EPW = ISO.PersistDataRead("EncryptPW");
			pwEncryptPW.Password = ENC.DecryptPhrase(EPW);
			
			string sCurrSessionGuid = ISO.PersistDataRead("CurrSessionGuid");
			if (sCurrSessionGuid.Length > 0)
			{
				CurrSessionGuid = new Guid(sCurrSessionGuid);
			}
			
			if (this.Resources.Contains("CurrSessionGuid"))
			{
				this.Resources.Remove("CurrSessionGuid");
			}
			this.Resources.Add("CurrSessionGuid", CurrSessionGuid.ToString());
		}
		
		public void hlHelp_Click(object sender, RoutedEventArgs e)
		{
			//Launch Default Braowser to specified URL
			string webAddress = "http://www.ecmlibrary.com/help";
			System.Diagnostics.Process.Start(webAddress);
		}
		
		public void hlLogPath_Click(object sender, RoutedEventArgs e)
		{
			GLOBALS.ProxySearch.GetLogPathCompleted += new System.EventHandler(client_GetLogPath);
			//EP.setSearchSvcEndPoint(proxy)
			string S = "";
			GLOBALS.ProxySearch.GetLogPathAsync(S);
		}
		public void client_GetLogPath(object sender, SVCSearch.GetLogPathCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				string LogPath = (string) e.tPath;
				MessageBox.Show(LogPath);
				try
				{
					Clipboard.SetText(LogPath);
					MessageBox.Show("Path in clipboard.");
				}
				catch (Exception ex)
				{
					Console.WriteLine(ex.Message);
				}
			}
			else
			{
				MessageBox.Show("Failed to get Error Log path from server.");
			}
			GLOBALS.ProxySearch.GetLogPathCompleted -= new System.EventHandler(client_GetLogPath);
		}
		
		public void Page_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			GLOBALS.ProxySearch.validateLoginCompleted -= new System.EventHandler(client_validateLogin);
			GLOBALS.ProxySearch.getCustomerLogoTitleCompleted -= new System.EventHandler(client_getCustomerLogoTitle);
			GLOBALS.ProxySearch.GetXrtCompleted -= new System.EventHandler(Step0GetLicense);
			
			string EP3 = ISO.SetCLC_State2(txtLoginID.Text, "IDENTIFIED", txtCompanyID.Text, cbRepoID.Text);
			Console.WriteLine("EP3: " + EP3);
			
		}
		
		public void btnGetRepos_MouseEnter(object sender, MouseEventArgs e)
		{
			lblGateway.Content = currGateway + ":1661";
			//lblGateway.Refresh()
		}
		
		public void txtLoginID_MouseEnter(object sender, MouseEventArgs e)
		{
			lblEndpoint.Content = GLOBALS.ProxySearch.Endpoint.Address.ToString();
		}
		
		public void btnSubmit_MouseEnter(object sender, MouseEventArgs e)
		{
			MSGS.Content = "ENDPOINT: " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
		}
		
		public void Label1_MouseEnter(object sender, MouseEventArgs e)
		{
			MSGS.Content = "Search: " + GLOBALS.ProxySearch.Endpoint.Address.ToString();
		}
		
		public void btnCkConn_Click(object sender, RoutedEventArgs e)
		{
			VerifySecureDbConnection();
		}
		
		public void btnResetStoredVars_Click(object sender, RoutedEventArgs e)
		{
			var msg = "This will RESET the remembered login data.";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			
			if (result == MessageBoxResult.OK)
			{
				ResetPersist();
			}
			
		}
		
		public void cbRepoID_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			if (! bAttached)
			{
				return;
			}
			SaveActiveParm("SecureID", SecureID.ToString());
			SaveActiveParm("CurrSessionGuid", CurrSessionGuid.ToString());
			SaveActiveParm("CompanyID", txtCompanyID.Text);
			SaveActiveParm("RepoID", cbRepoID.Text);
			SaveActiveParm("LoginID", txtLoginID.Text);
			SaveActiveParm("EncryptPW", ENC.EncryptPhrase(pwEncryptPW.Password));
			lblAttached.Content = "Not Attached";
		}
		
		public void ckShowDetails_Checked(object sender, RoutedEventArgs e)
		{
			spDetails.Visibility = System.Windows.Visibility.Visible;
		}
		
		public void ckShowDetails_Unchecked(object sender, RoutedEventArgs e)
		{
			spDetails.Visibility = System.Windows.Visibility.Collapsed;
		}
		
		public void Label4_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
		{
			string webAddress = "http://www.DmaChicago.com";
			System.Diagnostics.Process.Start(webAddress);
		}
	}
	
}
