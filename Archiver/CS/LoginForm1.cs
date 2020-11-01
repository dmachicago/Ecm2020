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

using Microsoft.VisualBasic.CompilerServices;


namespace EcmArchiveClcSetup
{
	public partial class LoginForm1
	{
		public LoginForm1()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			CurrSessionGuid = Guid.NewGuid();
			
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static LoginForm1 defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static LoginForm1 Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new LoginForm1();
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
		
		// TODO: Insert code to perform custom authentication using the provided username and password
		// (See http://go.microsoft.com/fwlink/?LinkId=35339).
		// The custom principal can then be attached to the current thread's principal as follows:
		//     My.User.CurrentPrincipal = CustomPrincipal
		// where CustomPrincipal is the IPrincipal implementation used to perform authentication.
		// Subsequently, My.User will return identity information encapsulated in the CustomPrincipal object
		// such as the username, display name, etc.
		
		int AutoLoginSecs = 10;
		int CurrLoginSecs = 0;
		clsLogging LOG = new clsLogging();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsEncryptV2 ENC2 = new clsEncryptV2();
		clsDatabase DB = new clsDatabase();
		clsEncrypt ENC = new clsEncrypt();
		clsDma DMA = new clsDma();
		bool bHelpLoaded = false;
		bool bAttached = false;
		bool bPopulateComboBusy = false;
		
		public bool bGoodLogin = false;
		public string UID = "";
		
		Guid CurrSessionGuid; // VBConversions Note: Initial value of "Guid.NewGuid()" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		SVCSearch.Service1Client ProxySRCH = new SVCSearch.Service1Client();
		
		int SecureID = -1;
		
		System.Collections.Generic.List<string> ListOfRepoIS = new System.Collections.Generic.List<string>();
		string strRepos = "";
		
		string FQN = "";
		string CurrUserName = "";
		
		public void LoginForm1_Load(System.Object sender, System.EventArgs e)
		{
			
			this.TopMost = true;
			
			//Check to see if an AUTO-LOGIN file exists.
			
			
			CurrUserName = Environment.UserName;
			
			getPersitData();
			
			if (txtCompanyID.Text.Trim().Length > 0 && cbRepoID.Text.Trim().Length > 0 && pwEncryptPW.Text.Trim().Length > 0)
			{
				btnAttach_Click(null, null);
			}
			
			lblAttachedMachineName.Text = LOG.getEnvVarMachineName();
			lblNetworkID.Text = LOG.getEnvVarNetworkID();
			
			if (txtCompanyID.Text.Trim().Length > 0 && cbRepoID.Text.Trim().Length > 0 && pwEncryptPW.Text.Trim().Length > 0 && txtLoginID.Text.Trim().Trim().Length > 0 && PasswordTextBox.Text.Trim().Trim().Length > 0)
			{
				Timer2.Enabled = true;
			}
			else
			{
				Timer2.Enabled = false;
			}
			
			modGlobals.bRunnner = false;
		}
		
		public void OK_Click(System.Object sender, System.EventArgs e)
		{
			
			if (lblAttached.Text.ToLower().Equals("not attached"))
			{
				VerifySecureDbConnection();
				MessageBox.Show("The Gateway is not Attached, please attach to the Secure Gateway.");
				return;
			}
			
			if (PasswordTextBox.Text.ToUpper().Equals("PASSWORD"))
			{
				if (txtLoginID.Text.Length == 0)
				{
					MessageBox.Show("Please enter your USERID into the Login ID field.");
					return;
				}
				frmPasswordChange.Default.ShowDialog();
				SB.Text = "Please login using your new credentials, thank you.";
				return;
			}
			
			if (txtLoginID.Text.Length == 0)
			{
				MessageBox.Show("You user Login ID is required.");
				return;
			}
			if (PasswordTextBox.Text.Length == 0)
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
			if (pwEncryptPW.Text.Length == 0)
			{
				MessageBox.Show("A Gateway password is required.");
				return;
			}
			
			if (modGlobals.gGateWayID < 0)
			{
				VerifySecureDbConnection();
				//MessageBox.Show("The Gateway has not been initiated, please attach to the Secure Gateway.")
				return;
			}
			
			lblAttachedMachineName.Text = modGlobals.gAttachedMachineName;
			lblCurrUserGuidID.Text = txtLoginID.Text;
			lblLocalIP.Text = modGlobals.gLocalMachineIP;
			lblServerInstanceName.Text = modGlobals.gServerInstanceName;
			lblServerMachineName.Text = modGlobals.gServerMachineName;
			lblCurrUserGuidID.Text = txtLoginID.Text;
			
			modGlobals.gCurrUserGuidID = txtLoginID.Text;
			modGlobals.gRepoID = cbRepoID.Text.Trim();
			
			//*************************
			SaveStaticVars();
			//*************************
			SB.Text = "Logging in, standby.";
			SB.Refresh();
			Application.DoEvents();
			
			string LoginID = txtLoginID.Text.Trim();
			string PW = PasswordTextBox.Text.Trim();
			string DecryptedPassword = "";
			string EncryptedPassword = "";
			
			bool DHX = DB.ckUserLoginExists(LoginID);
			int Tries = 1;
			if (DHX == true)
			{
				string tpw = DB.getBinaryPassword(LoginID);
				if (tpw.Trim().Length > 0)
				{
					if (tpw.ToUpper().Equals("PASSWORD"))
					{
						if (LoginID.ToUpper.Equals("ADMIN"))
						{
							string Msg = "";
							Msg = "It appears that this may be the first time into the system." + "\r\n";
							Msg += "As an ADMIN, you will be required to change your " + "\r\n" + "current password of \'password\' and," + "\r\n";
							Msg += "any users will have to be added to the system if they" + "\r\n" + "are allowed to access ECM Library." + "\r\n" + "\r\n";
							Msg += "Thank you for using ECM Library.";
							MessageBox.Show(Msg);
						}
PWOVER:
						frmPasswordChange.Default.ShowDialog();
						string NewPw = frmPasswordChange.Default.PW1;
						string NewPw2 = frmPasswordChange.Default.PW2;
						NewPw = NewPw.Trim;
						NewPw2 = NewPw2.Trim;
						if (NewPw.Equals(NewPw2))
						{
							string epw = ENC.AES256EncryptString(NewPw2);
							string sEnc = "Update users set UserPassword = \'" + epw + "\' where UserLoginID = \'" + LoginID + "\' ";
							bool BB2 = DB.ExecuteSqlNewConn(sEnc, false);
							if (BB2)
							{
								MessageBox.Show("Your password has been changed, for future logins, please use your new password.");
								PW = NewPw;
							}
							else
							{
								MessageBox.Show("Your password failed to update, please cntact an administrator or try to login again, closing down.");
								ProjectData.EndApp();
							}
						}
						else
						{
							Tries++;
							if (Tries >= 3)
							{
								MessageBox.Show("Too many tries, try logging in again from the start, closing down.");
								ProjectData.EndApp();
							}
							MessageBox.Show("The passwords do not equal each other, please reenter.");
							goto PWOVER;
						}
						
					}
				}
			}
			else
			{
				MessageBox.Show("Your user login ID has not been defined to the system, please contact an administrator, closing down.");
				ProjectData.EndApp();
			}
			
			frmPasswordChange.Default.Dispose();
			
			EncryptedPassword = ENC.AES256EncryptString(PW);
			
			string UPW = DB.getPw(LoginID);
			if (UPW.Equals(EncryptedPassword))
			{
				UID = LoginID;
				bGoodLogin = true;
				this.Hide();
				frmMain.Default.Show();
			}
			else
			{
				UID = "";
				bGoodLogin = false;
				MessageBox.Show("Failed to login, please verify your User ID and password.");
				this.Close();
			}
			
		}
		
		public void Cancel_Click(System.Object sender, System.EventArgs e)
		{
			modGlobals.bRunnner = false;
			this.Close();
		}
		
		
		public void Timer1_Tick(System.Object sender, System.EventArgs e)
		{
			//If HelpOn Then
			//    If bHelpLoaded Then
			//        TT.Active = True
			//    Else
			//        DB.getFormTooltips(Me, TT, True)
			//        TT.Active = True
			//        bHelpLoaded = True
			//    End If
			//Else
			//    TT.Active = False
			//End If
			//Application.DoEvents()
		}
		
		public void ckSaveAsDefaultLogin_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckSaveAsDefaultLogin.Checked)
			{
				//Write the info (encrypted) out to a file for use during the next login.
				SavePersist();
			}
			else
			{
				//Remove the login file if it exists.
			}
		}
		
		public void PopulateRepoComboBox()
		{
			
			
			cbRepoID.Visible = false;
			pwEncryptPW.Visible = false;
			btnGetRepos.Visible = false;
			
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
			
			ProxySRCH.PopulateSecureLoginCB_V2(SecureID, strRepos, CompanyID, RC, RetMsg);
			
			string[] TempArray = strRepos.Split(Strings.Chr(254).ToString().ToCharArray());
			foreach (string s in TempArray)
			{
				if (s.Trim().Length > 0)
				{
					ListOfRepoIS.Add(s);
				}
			}
			
			cbRepoID.DataSource = ListOfRepoIS;
			
		}
		
		public void btnAttach_Click(System.Object sender, System.EventArgs e)
		{
			bool B = VerifySecureDbConnection();
			if (B)
			{
				OK.Visible = true;
				lblAttached.Text = "Attached";
			}
			else
			{
				OK.Visible = false;
				lblAttached.Text = "NOT Attached";
			}
			
		}
		
		public bool VerifySecureDbConnection()
		{
			
			string CompanyID = txtCompanyID.Text;
			string RepoID = cbRepoID.Text;
			bool RC = false;
			string RetMsg = "";
			
			
			if (CompanyID.Length == 0)
			{
				MessageBox.Show("CompanyID must be supplied, CANNOT ATTACH.");
				return false;
			}
			if (RepoID.Length == 0)
			{
				MessageBox.Show("A Repository must be selected, CANNOT ATTACH.");
				return false;
			}
			
			string EPW = pwEncryptPW.Text;
			EPW = ENC2.EncryptPhrase(EPW);
			
			ProxySRCH.validateAttachSecureLogin(SecureID, CompanyID, RepoID, txtLoginID.Text, EPW, RC, RetMsg);
			modGlobals.gCurrentConnectionString = (string) (ProxySRCH.getGatewayCS(SecureID, CompanyID, RepoID, EPW, RetMsg, RC));
			modGlobals.gCurrentConnectionString = ENC.AES256DecryptString(modGlobals.gCurrentConnectionString);
			modGlobals.gGateWayID = SecureID;
			
			return RC;
			
		}
		
		public void btnGetRepos_Click(System.Object sender, System.EventArgs e)
		{
			PopulateRepoComboBox();
			cbRepoID.Visible = true;
			pwEncryptPW.Visible = true;
			btnGetRepos.Visible = true;
			btnAttach.Visible = true;
		}
		
		public void SaveStaticVars()
		{
			
			if (SecureID >= 0)
			{
				modGlobals.gGateWayID = SecureID;
			}
			modGlobals.gRepoID = cbRepoID.Text;
			modGlobals.gCompanyID = txtCompanyID.Text;
			modGlobals.gUserID = txtLoginID.Text;
			modGlobals.gActiveGuid = CurrSessionGuid;
			modGlobals.gSessionGuid = CurrSessionGuid;
			modGlobals.gEncryptPW = pwEncryptPW.Text;
			
			//If Me.Resources.Contains("SecureID") Then
			//    Me.Resources.Remove("SecureID")
			//End If
			//Me.Resources.Add("SecureID", SecureID.ToString)
			//If Me.Resources.Contains("CurrSessionGuid") Then
			//    Me.Resources.Remove("CurrSessionGuid")
			//End If
			//Me.Resources.Add("CurrSessionGuid", CurrSessionGuid.ToString)
			//If Me.Resources.Contains("CompanyID") Then
			//    Me.Resources.Remove("CompanyID")
			//End If
			//Me.Resources.Add("CompanyID", txtCompanyID.Text)
			//If Me.Resources.Contains("RepoID") Then
			//    Me.Resources.Remove("RepoID")
			//End If
			//Me.Resources.Add("RepoID", cbRepoID.Text)
			//If Me.Resources.Contains("LoginID") Then
			//    Me.Resources.Remove("LoginID")
			//End If
			//Me.Resources.Add("LoginID", txtLoginID.Text)
			
			SavePersist();
			
			
		}
		
		public void SaveActiveParm(string ParmName, string ParmVal)
		{
			if (! bAttached)
			{
				return;
			}
			
			ProxySRCH.ActiveSession(SecureID, CurrSessionGuid, ParmName, ParmVal);
			
		}
		public void RemovePersist()
		{
			ISO.PersistDataInit("NA", "NA");
		}
		public void SavePersist()
		{
			ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString());
			ISO.PersistDataSave("CompanyID", txtCompanyID.Text);
			ISO.PersistDataSave("RepoID", cbRepoID.Text);
			ISO.PersistDataSave("LoginID", txtLoginID.Text);
			string TPW = pwEncryptPW.Text;
			TPW = ENC2.EncryptPhrase(TPW);
			ISO.PersistDataSave("EncryptPW", TPW);
			
			string UPW = PasswordTextBox.Text.Trim();
			UPW = ENC2.EncryptPhrase(UPW);
			ISO.PersistDataSave("UPW", UPW);
			
			ISO.PersistDataSave("EOD", "***");
		}
		
		public void getPersitData()
		{
			
			string SID = ISO.PersistDataRead("SecureID");
			if (SID.Length > 0)
			{
				SecureID = int.Parse(SID);
				modGlobals.gGateWayID = SecureID;
			}
			
			txtLoginID.Text = ISO.PersistDataRead("LoginID");
			
			txtCompanyID.Text = ISO.PersistDataRead("CompanyID");
			
			cbRepoID.Text = ISO.PersistDataRead("RepoID");
			if (cbRepoID.Text.Length > 0)
			{
				cbRepoID.SelectedItem = cbRepoID.Text;
			}
			
			string EPW = ISO.PersistDataRead("EncryptPW");
			pwEncryptPW.Text = ENC2.DecryptPhrase(EPW);
			
			string UPW = ISO.PersistDataRead("UPW");
			PasswordTextBox.Text = ENC2.DecryptPhrase(UPW);
			
			string sCurrSessionGuid = ISO.PersistDataRead("CurrSessionGuid");
			if (sCurrSessionGuid.Length > 0)
			{
				CurrSessionGuid = new Guid(sCurrSessionGuid);
			}
			else
			{
				CurrSessionGuid = new Guid();
			}
			
		}
		
		public void Timer2_Tick(System.Object sender, System.EventArgs e)
		{
			if (ckCancelAutoLogin.Checked == true)
			{
				Timer2.Enabled = false;
				
			}
			CurrLoginSecs++;
			int i = AutoLoginSecs - CurrLoginSecs;
			if (CurrLoginSecs == AutoLoginSecs)
			{
				lblMsg.Text = "Logging in...\"";
				OK_Click(null, null);
			}
			else
			{
				lblMsg.Text = (string) ("SECS to Login: " + i.ToString());
			}
			
		}
	}
	
}
