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


namespace EcmArchiveClcSetup
{
	public partial class frmLicense
	{
		public frmLicense()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmLicense defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmLicense Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmLicense();
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
		
		bool bFormLoaded = false;
		
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsLicenseMgt LM = new clsLicenseMgt();
		clsRemoteSupport RS = new clsRemoteSupport();
		clsLICENSE LIC = new clsLICENSE();
		
		bool bHelpLoaded = false;
		bool bLicenseLoaded = false;
		bool bApplied = false;
		
		string xCompanyID = "";
		string xMachineID = "";
		string xLicenseID = "";
		string xApplied = "";
		string xLicenseTypeCode = "";
		string xEncryptedLicense = "";
		string CurrServerName = "";
		
		string ExistingVersionNbr = "";
		string ExistingActivationDate = "";
		string ExistingInstallDate = "";
		string ExistingCustomerID = "";
		string ExistingCustomerName = "";
		string ExistingLicenseID = "";
		string ExistingXrtNxr1 = "";
		string ExistingServerIdentifier = "";
		string ExistingSqlInstanceIdentifier = "";
		
		public void btnGetfile_Click(System.Object sender, System.EventArgs e)
		{
			OpenFileDialog1.ShowDialog();
			string FQN = OpenFileDialog1.FileName;
			txtFqn.Text = FQN;
		}
		
		public void btnLoadFile_Click(System.Object sender, System.EventArgs e)
		{
			string CustomerID = txtCompanyID.Text.Trim();
			bApplied = false;
			if (CustomerID.Length == 0)
			{
				MessageBox.Show("Customer ID required: " + "\r\n" + "If you do not know your Customer ID, " + "\r\n" + "please contact ECM Support or your ECM administrator.");
				return;
			}
			string SelectedServer = txtServers.Text.Trim();
			if (SelectedServer.Length == 0)
			{
				MessageBox.Show("Please select the Server to which this license applies." + "\r\n" + "The server name and must match that contained within the license.");
				return;
			}
			string FQN = txtFqn.Text;
			OpenFileDialog1.ShowDialog();
			FQN = OpenFileDialog1.FileName;
			string S = DMA.LoadLicenseFile(FQN);
			if (S.Length == 0)
			{
				SB.Text = "Failed to load license.";
			}
			else
			{
				SB.Text = "Loaded license.";
				txtLicense.Text = S;
				btnPasteLicense_Click(null, null);
			}
		}
		
		public void btnPasteLicense_Click(System.Object sender, System.EventArgs e)
		{
			string CustomerID = txtCompanyID.Text.Trim();
			bApplied = false;
			if (CustomerID.Length == 0)
			{
				MessageBox.Show("Customer ID required: " + "\r\n" + "If you do not know your Customer ID, " + "\r\n" + "please contact ECM Support or your ECM administrator.");
				return;
			}
			string SelectedServer = txtServers.Text.Trim();
			if (SelectedServer.Length == 0)
			{
				MessageBox.Show("Please select the Server to which this license applies." + "\r\n" + "The server name and must match that contained within the license.");
				return;
			}
			var bCustIdGood = RS.ckCompanyID(CustomerID);
			if (bCustIdGood == false)
			{
				MessageBox.Show("Could not connect to the ECM customer database. Continuing without confirmation");
				//Return
			}
			bool B = DB.saveLicenseCutAndPaste(txtLicense.Text, CustomerID, SelectedServer);
			if (! B)
			{
				SB.Text = "Failed to save license.";
			}
			else
			{
				SB.Text = "Saved license.";
				bApplied = true;
			}
		}
		
		public void frmLicense_Load(System.Object sender, System.EventArgs e)
		{
			bFormLoaded = false;
			modGlobals.bInetAvailable = DMA.isConnected();
			//Dim bGetScreenObjects As Boolean = True
			//If bGetScreenObjects Then DMA.getFormWidgets(Me)
			
			if (modGlobals.bInetAvailable == true)
			{
				SB.Text = "Internet available for license download.";
				btnRemote.Enabled = true;
			}
			else
			{
				SB.Text = "Internet NOT available for license download.";
				btnRemote.Enabled = false;
			}
			
			if (modGlobals.HelpOn)
			{
				DB.getFormTooltips(this, TT, true);
				TT.Active = true;
				bHelpLoaded = true;
			}
			else
			{
				TT.Active = false;
			}
			Timer1.Enabled = true;
			Timer1.Interval = 5000;
			
			AddTwoNewFields();
			
			bFormLoaded = true;
		}
		
		public void Timer1_Tick(System.Object sender, System.EventArgs e)
		{
			
			if (modGlobals.HelpOn)
			{
				if (bHelpLoaded)
				{
					TT.Active = true;
				}
				else
				{
					DB.getFormTooltips(this, TT, true);
					TT.Active = true;
					bHelpLoaded = true;
				}
			}
			else
			{
				TT.Active = false;
			}
			Application.DoEvents();
		}
		
		public void btnDisplay_Click(System.Object sender, System.EventArgs e)
		{
			string LT = DB.GetXrt();
			LM.ParseLic(LT, true);
		}
		
		
		public void btnRemote_Click(System.Object sender, System.EventArgs e)
		{
			bFormLoaded = false;
			string repoServer = txtServers.Text.Trim();
			string CompanyID = txtCompanyID.Text.Trim();
			
			string SqlServerInstanceNameX = txtServers.Text;
			string SqlServerMachineName = txtSqlServerMachineName.Text;
			
			if (CompanyID.Length == 0)
			{
				MessageBox.Show("You must supply your Company ID to access the server, returning.");
				return;
			}
			
			try
			{
				if (repoServer.Length == 0)
				{
					MessageBox.Show("You must select a Repository Server, returning.");
					return;
				}
				//**
				bool bFetch = RS.getClientLicenses(CompanyID, this.dgLicense);
				if (bFetch)
				{
					SB.Text = "Successfully retrieved license.";
					bLicenseLoaded = true;
				}
				else
				{
					bLicenseLoaded = false;
					SB.Text = "Failed to retrieve license.";
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Trace 23.11.24: License failed to download for: " + DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID) + " : " + ex.Message));
				LOG.WriteToTraceLog((string) ("Trace 23.11.24: License failed to download for: " + DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID) + " : " + ex.Message));
			}
			bFormLoaded = true;
		}
		
		public void dgLicense_CellContentClick(System.Object sender, System.Windows.Forms.DataGridViewCellEventArgs e)
		{
			GetGridData();
		}
		public void GetGridData()
		{
			if (bFormLoaded == false)
			{
				return;
			}
			btnApplySelLic.Enabled = false;
			int I = this.dgLicense.SelectedRows.Count;
			
			if (I > 1 || I == 0)
			{
				MessageBox.Show("Please select one and only one license please.");
				return;
			}
			
			int LL = 1;
			try
			{
				int iCells = System.Convert.ToInt32(this.dgLicense.SelectedRows[0].Cells.Count - 1);
				LL = 2;
				xCompanyID = this.dgLicense.SelectedRows[0].Cells["CompanyID"].Value.ToString();
				LL = 3;
				xMachineID = this.dgLicense.SelectedRows[0].Cells["MachineID"].Value.ToString();
				LL = 4;
				xLicenseID = this.dgLicense.SelectedRows[0].Cells["LicenseID"].Value.ToString();
				LL = 5;
				xApplied = this.dgLicense.SelectedRows[0].Cells["Applied"].Value.ToString();
				LL = 6;
				xLicenseTypeCode = this.dgLicense.SelectedRows[0].Cells["LicenseTypeCode"].Value.ToString();
				LL = 7;
				//xEncryptedLicense  = Me.dgLicense.SelectedRows(0).Cells("EncryptedLicense").Value.ToString
				xEncryptedLicense = this.dgLicense.SelectedRows[0].Cells[iCells].Value.ToString();
				LL = 8;
				//txtLicense.Text = xEncryptedLicense
				
				btnApplySelLic.Enabled = true;
				LL = 9;
				SB.Text = "License data ready to apply.";
				LL = 10;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: frmLicense:GetGridData 100 - LL = " + LL.ToString() + "\r\n" + ex.Message));
			}
			
		}
		
		public void dgLicense_SelectionChanged(object sender, System.EventArgs e)
		{
			GetGridData();
		}
		
		public void btnApplySelLic_Click(System.Object sender, System.EventArgs e)
		{
			
			
			string ServerName = this.dgLicense.SelectedRows[0].Cells["ServerName"].Value.ToString();
			string SqlInstanceName = this.dgLicense.SelectedRows[0].Cells["SqlInstanceName"].Value.ToString();
			string xEncryptedLicense = this.dgLicense.SelectedRows[0].Cells["EncryptedLicense"].Value.ToString();
			
			bLicenseLoaded = false;
			
			CurrServerName = DB.getServerMachineName();
			string CurrInstanceName = DB.getServerInstanceName();
			
			//** Now, I have the license data - what do I do with it
			
			//** Check to see if the Applied Bit is set to true
			if (xApplied.Equals("1"))
			{
				//** If so, display a message box and return
				MessageBox.Show("This license has already been applied and can be reapplied ONLY to the assigned server.");
			}
			string CustomerID = txtCompanyID.Text.Trim();
			if (CustomerID.Length == 0)
			{
				MessageBox.Show("Customer ID required: " + "\r\n" + "If you do not know your Customer ID, " + "\r\n" + "please contact ECM Support or your ECM administrator.");
				return;
			}
			string SelectedServer = txtServers.Text.Trim();
			if (SelectedServer.Length == 0)
			{
				MessageBox.Show("Please select the Server to which this license applies." + "\r\n" + "The server name and must match that contained within the license.");
				return;
			}
			var bCustIdGood = RS.ckCompanyID(CustomerID);
			if (bCustIdGood == false)
			{
				MessageBox.Show("Could not find the supplied Customer ID in the ECM database. Please verify... returning");
				return;
			}
			
			bool BBB = RS.getLicenseServerName(CustomerID, ref ServerName, ref SqlInstanceName);
			
			if (xMachineID.Equals("ECMNEWXX"))
			{
				string msg = "This is a new license and can be applied to the currently attached repository." + "\r\n";
				msg = msg + " Do you wish to apply the license to server \'" + CurrServerName + "\' ?" + "\r\n";
				DialogResult dlgRes = MessageBox.Show(msg, "License Installation", MessageBoxButtons.YesNo);
				if (dlgRes == System.Windows.Forms.DialogResult.No)
				{
					return;
				}
				//** Apply the license to the server, Update the ECM License DB, and show a message
				if (xLicenseID.Trim().Length == 0)
				{
					xLicenseID = "1";
				}
				int iCnt = LIC.cnt_PK_License(xLicenseID);
				if (iCnt == 0)
				{
					
					LIC.setActivationdate(DateTime.Now.ToString());
					LIC.setAgreement(ref xEncryptedLicense);
					LIC.setCustomerid(ref xCompanyID);
					LIC.setCustomername("NA");
					LIC.setInstalldate(DateTime.Now.ToString());
					LIC.setVersionnbr(ref xLicenseID);
					LIC.setServeridentifier(ref SelectedServer);
					LIC.setSqlinstanceidentifier(ref SelectedServer);
					
					bApplied = false;
					
					bool BB = true;
					bool bApplyNewWay = true;
					if (bApplyNewWay)
					{
						bApplied = false;
						txtLicense.Text = xEncryptedLicense;
						btnPasteLicense_Click(null, null);
						txtLicense.Text = "";
						//** bApplied is set within CALL to btnPasteLicense_Click
						BB = bApplied;
					}
					else
					{
						BB = LIC.Insert();
						bApplied = BB;
					}
					
					if (! BB)
					{
						MessageBox.Show("ERROR: 12.12.3 - Failed to insert license.");
						LOG.WriteToTraceLog("ERROR: 12.12.3 - Failed to insert license.");
						bLicenseLoaded = false;
					}
					else
					{
						DB.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
						this.dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
						SB.Text = DateTime.Now.ToString() + " : License successfully applied.";
						bLicenseLoaded = true;
						txtLicense.Text = xEncryptedLicense;
						btnPasteLicense_Click(null, null);
						txtLicense.Text = "";
					}
				}
				else
				{
					LIC.setActivationdate(DateTime.Now.ToString());
					LIC.setAgreement(ref xEncryptedLicense);
					LIC.setCustomerid(ref xCompanyID);
					LIC.setCustomername("NA");
					LIC.setInstalldate(DateTime.Now.ToString());
					LIC.setVersionnbr(ref xLicenseID);
					LIC.setServeridentifier(ref SelectedServer);
					LIC.setSqlinstanceidentifier(ref SelectedServer);
					string WC = LIC.wc_PK_License(xLicenseID);
					bool BB = LIC.Update(WC);
					if (! BB)
					{
						MessageBox.Show("ERROR: 12.12.3a - Failed to update license.");
						LOG.WriteToTraceLog("ERROR: 12.12.3a - Failed to update license.");
						bLicenseLoaded = false;
					}
					else
					{
						DB.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
						this.dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
						SB.Text = DateTime.Now.ToString() + " : License updated.";
						bLicenseLoaded = true;
						txtLicense.Text = xEncryptedLicense;
						btnPasteLicense_Click(null, null);
						txtLicense.Text = "";
					}
				}
			}
			else
			{
				if (CurrServerName.Equals(ServerName) && CurrInstanceName.Equals(SqlInstanceName))
				{
					//** See if the current server has an existing license
					//** If not, add this one and transmit back the Server Name to the ECM server
					//** If So, update the existing license.
					bool bLicenseExists = DB.LicenseExists();
					if (bLicenseExists == true)
					{
						string S = "Truncate Table License";
						BBB = DB.ExecuteSqlNewConn(S);
						if (BBB)
						{
							bLicenseExists = false;
						}
					}
					if (bLicenseExists == false)
					{
						string VersionNbr = xLicenseID;
						bool bVersion = DB.LicenseVersionExist(VersionNbr);
						if (bVersion == false)
						{
							//** Add the new version
							LIC.setActivationdate(DateTime.Now.ToString());
							LIC.setAgreement(ref xEncryptedLicense);
							LIC.setCustomerid(ref xCompanyID);
							LIC.setInstalldate(DateTime.Now.ToString());
							LIC.setCustomername(ref xCompanyID);
							LIC.setVersionnbr(ref xLicenseID);
							//LIC.setXrtnxr1()
							bool B = LIC.Insert();
							if (B == false)
							{
								MessageBox.Show("ERROR: Failed to insert license.");
								SB.Text = "ERROR: Failed to insert license.";
								bLicenseLoaded = false;
							}
							else
							{
								DB.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
								this.dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
								SB.Text = DateTime.Now.ToString() + " : License added.";
								bLicenseLoaded = true;
								txtLicense.Text = xEncryptedLicense;
								btnPasteLicense_Click(null, null);
								txtLicense.Text = "";
								SB.Text = "License APPLIED.";
								btnDisplay_Click(null, null);
							}
						}
						else
						{
							//** Update the current license
							// Damn - what here ??
							LIC.setActivationdate(DateTime.Now.ToString());
							LIC.setAgreement(ref xEncryptedLicense);
							LIC.setCustomerid(ref xCompanyID);
							LIC.setInstalldate(DateTime.Now.ToString());
							LIC.setCustomername(ref xCompanyID);
							LIC.setVersionnbr(ref xLicenseID);
							//LIC.setXrtnxr1()
							string WC = LIC.wc_PK_License(xLicenseID);
							bool B = LIC.Update(WC);
							if (B == false)
							{
								MessageBox.Show("ERROR: Failed to update existing license.");
							}
							else
							{
								DB.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
								this.dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
								SB.Text = DateTime.Now.ToString() + " : Failed to update existing license.";
								bLicenseLoaded = true;
								txtLicense.Text = xEncryptedLicense;
								btnPasteLicense_Click(null, null);
								txtLicense.Text = "";
								SB.Text = "License UPDATED.";
								btnDisplay_Click(null, null);
							}
						}
					}
					else
					{
						MessageBox.Show("002 - This license does not belong to the current Server \'" + CurrServerName + "\'. It cannot be applied.");
						return;
					}
				}
				else
				{
					MessageBox.Show("001 - This license does not belong to the current Server \'" + CurrServerName + "\'. It cannot be applied.");
					return;
				}
			}
			//** If not,
			//** Check to see if the target server has an existing repository license.
			//**
			
		}
		
		public void btnShowCurrentDB_Click(System.Object sender, System.EventArgs e)
		{
			string tMsg = "";
			tMsg += "User   Conn Str: " + My.Settings.Default["UserDefaultConnString"] + "\r\n";
			tMsg += "Config Conn Str: " + System.Configuration.ConfigurationManager.AppSettings["ECMREPO"] + "\r\n";
			MessageBox.Show(tMsg);
		}
		
		public void btnSetEqual_Click(System.Object sender, System.EventArgs e)
		{
			
			My.Settings.Default["UserDefaultConnString"] = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
			//My.Settings.Reset()
			//My.Settings("UserDefaultConnString") = "?"
			My.Settings.Default.Save();
			SB.Text = (string) ("Settings saved to: " + My.Settings.Default["UserDefaultConnString"]);
		}
		
		public void btnGetCustID_Click(System.Object sender, System.EventArgs e)
		{
			string LT = DB.GetXrt();
			txtCompanyID.Text = LM.ParseLicCustomerID(LT, true);
		}
		
		public void AddTwoNewFields()
		{
			
			bool B = false;
			int ID = 240;
			string S = "";
			
			S = S + " ALter table License Add SqlServerInstanceName nvarchar(254)";
			B = DB.ExecuteSqlNewConn(S, false);
			if (B)
			{
				Console.WriteLine("GOOD");
			}
			else
			{
				Console.WriteLine("BAD");
			}
			
			S = " ALter table License Add SqlServerMachineName nvarchar(254)";
			B = DB.ExecuteSqlNewConn(S, false);
			if (B)
			{
				Console.WriteLine("GOOD");
			}
			else
			{
				Console.WriteLine("BAD");
			}
			
		}
		
	}
	
}
