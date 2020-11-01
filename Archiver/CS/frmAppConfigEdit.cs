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

using System.Data.Sql;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
//using System.Object;
//using System.Configuration.ConfigurationManager;


namespace EcmArchiveClcSetup
{
	public partial class frmAppConfigEdit
	{
		
		bool FormLoaded = false;
		bool MasterLoaded = false;
		string ConnStr = "";
		string ConnstrThesaurus = "";
		string ConnstrRepository = "";
		bool bRestart = false;
		public bool AutoRestore = false;
		
		bool bLoadingCB = false;
		bool bConnTested = false;
		
		clsEncrypt ENC = new clsEncrypt();
		string MasterConnstr = "";
		
		public frmAppConfigEdit()
		{
			// This call is required by the Windows Form Designer.
			InitializeComponent();
			
			// Add any initialization after the InitializeComponent() call.
			
			Button2_Click(null, null);
			
			txtLoginName.Text = "";
			txtLoginName.Enabled = false;
			txtLoginName.ReadOnly = false;
			
			txtPw1.Text = "";
			txtPw1.Enabled = false;
			txtPw1.ReadOnly = false;
			
			txtPw2.Text = "";
			txtPw2.Enabled = false;
			txtPw2.ReadOnly = false;
			
			if (MasterLoaded)
			{
				btnLoadCombo_Click(null, null);
			}
			
			
			FormLoaded = true;
			
		}
		
		
		public void App_Path()
		{
			string S = System.AppDomain.CurrentDomain.BaseDirectory;
			Clipboard.Clear();
			Clipboard.SetText(S);
		}
		
		public string ReadFile(string fName)
		{
			System.IO.StreamReader SR = new System.IO.StreamReader(fName);
			string FullText = "";
			while (! SR.EndOfStream)
			{
				string S = SR.ReadLine();
				FullText = FullText + S + "\r\n";
			}
			SR.Close();
			return FullText;
		}
		public void WriteFile(string FQN, string sText)
		{
			
			System.IO.StreamWriter SW = new System.IO.StreamWriter(FQN);
			string S = sText.Trim();
			
			if (S.Length > 0)
			{
				SW.WriteLine(S);
			}
			SW.Close();
			SB.Text = "File saved...";
		}
		
		public void btnTestConnection_Click(System.Object sender, System.EventArgs e)
		{
			bool B = false;
			SB.Text = "";
			SB.Text = "Attempting to connect";
			SB.Refresh();
			string CS = BuildConnstr();
			SqlConnection CONN = new SqlConnection(CS);
			try
			{
				CONN.Open();
				SB.Text = (string) ("Connection successful for " + txtRepositoryName.Text);
				ConnstrRepository = ConnStr;
				B = true;
			}
			catch (Exception)
			{
				SB.Text = (string) ("Connection Failed  to " + txtRepositoryName.Text);
			}
			finally
			{
				CONN.Dispose();
				GC.Collect();
			}
			Application.DoEvents();
			
			if (B)
			{
				//If rbRepository.Checked Then
				//    MasterConnstr = CS
				//End If
				btnSaveConn.Enabled = true;
				Button1.Enabled = true;
				bConnTested = true;
				LicenseToolStripMenuItem.Visible = true;
			}
			else
			{
				//MasterConnstr = ""
				btnSaveConn.Enabled = false;
				Button1.Enabled = false;
				bConnTested = false;
			}
			
		}
		
		public void ckWindowsAuthentication_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckWindowsAuthentication.Checked)
			{
				txtLoginName.Text = "";
				txtLoginName.Enabled = false;
				txtLoginName.ReadOnly = false;
				
				txtPw1.Text = "";
				txtPw1.Enabled = false;
				
				txtPw2.Text = "";
				txtPw2.Enabled = false;
			}
			else
			{
				txtLoginName.Text = "";
				txtLoginName.Enabled = true;
				txtLoginName.ReadOnly = false;
				
				txtPw1.Text = "";
				txtPw1.Enabled = true;
				txtPw1.ReadOnly = false;
				
				txtPw2.Text = "";
				txtPw2.Enabled = true;
				txtPw2.ReadOnly = false;
			}
		}
		
		public void Button7_Click(System.Object sender, System.EventArgs e)
		{
			string DirName = "";
			FolderBrowserDialog1.ShowDialog();
			DirName = FolderBrowserDialog1.SelectedPath;
			txtGlobalFileDirectory.Text = DirName;
		}
		
		public string GetScreenParms()
		{
			string S = "";
			S += (string) ("txtGlobalFileDirectory" + "|" + txtGlobalFileDirectory.Text + '\u007F');
			S += (string) ("txtDBName" + "|" + txtDBName.Text + '\u007F');
			S += (string) ("txtRepositoryName" + "|" + txtRepositoryName.Text + '\u007F');
			S += (string) ("txtServerInstance" + "|" + txtServerInstance.Text + '\u007F');
			S += (string) ("ckWindowsAuthentication" + "|" + ckWindowsAuthentication.Checked.ToString() + '\u007F');
			S += (string) ("ckRepository" + "|" + rbRepository.Checked.ToString() + '\u007F');
			S += (string) ("ckThesaurus" + "|" + rbThesaurus.Checked.ToString() + '\u007F');
			S += (string) ("txtLoginName" + "|" + txtLoginName.Text + '\u007F');
			S += (string) ("txtPw1" + "|" + txtPw1.Text + '\u007F');
			S += (string) ("cbSavedDefinitions" + "|" + cbSavedDefinitions.Text + '\u007F');
			S += (string) ("ckHive" + "|" + ckHive.Checked.ToString() + '\u007F');
			return S;
		}
		
		public string ResetScreenParms()
		{
			string S = "";
			
			txtDBName.Text = "";
			txtRepositoryName.Text = "";
			txtServerInstance.Text = "";
			ckWindowsAuthentication.Checked = true;
			//rbRepository.Checked = True
			//rbThesaurus.Checked = False
			txtLoginName.Text = "";
			txtPw1.Text = "";
			txtPw2.Text = "";
			cbSavedDefinitions.Text = "";
			ckHive.Checked = false;
			return S;
		}
		
		public void btnSaveConn_Click(System.Object sender, System.EventArgs e)
		{
			
			if (MasterConnstr.Trim().Length == 0)
			{
				MessageBox.Show("ERROR: the master setup has not been set, returning.");
				return;
			}
			
			if (! bConnTested)
			{
				MessageBox.Show("This connection has not been tested, please test the connection first.");
			}
			
			if (! ckWindowsAuthentication.Checked)
			{
				if (! txtPw1.Text.Equals(txtPw2.Text))
				{
					MessageBox.Show("The passwords do not match, returning.");
					return;
				}
			}
			
			string ProfileName = cbSavedDefinitions.Text;
			string S = GetScreenParms();
			string InsertSql = "";
			
			S = ENC.AES256EncryptString(S);
			ProfileName = ProfileName.Replace("\'", "");
			
			int icnt = iCount("Select count(*) from Repository where ConnectionName = \'" + ProfileName + "\'");
			if (icnt == 0)
			{
				if (rbRepository.Checked)
				{
					string CS = MasterConnstr;
					
					InsertSql = "";
					InsertSql = InsertSql + "INSERT INTO [Repository] ([ConnectionName],[ConnectionData])" + "\r\n";
					InsertSql = InsertSql + "VALUES" + "\r\n";
					InsertSql = InsertSql + "(\'" + ProfileName + "\'" + "\r\n";
					InsertSql = InsertSql + ",\'" + S + "\')" + "\r\n";
				}
				else
				{
					InsertSql = "";
					InsertSql = InsertSql + "INSERT INTO [Repository] ([ConnectionName],[ConnectionDataThesaurus])" + "\r\n";
					InsertSql = InsertSql + "VALUES" + "\r\n";
					InsertSql = InsertSql + "(\'" + ProfileName + "\'" + "\r\n";
					InsertSql = InsertSql + ",\'" + S + "\')" + "\r\n";
				}
				
			}
			else
			{
				if (rbRepository.Checked)
				{
					string CS = MasterConnstr;
					InsertSql = "UPDATE [Repository] SET [ConnectionData] = \'" + S + "\' WHERE [ConnectionName] = \'" + ProfileName + "\'";
				}
				else
				{
					InsertSql = "UPDATE [Repository] SET [ConnectionDataThesaurus] = \'" + S + "\' WHERE [ConnectionName] = \'" + ProfileName + "\'";
				}
				
			}
			
			
			bool B = ExecuteSqlNewConn(InsertSql);
			if (B)
			{
				SB.Text = "Profile \'" + ProfileName + "\' saved to Master Repository";
			}
			else
			{
				SB.Text = "ERROR: Profile \'" + ProfileName + "\' did not save.";
			}
			
			
		}
		
		public void Button1_Click(System.Object sender, System.EventArgs e)
		{
			
			if (! bConnTested)
			{
				MessageBox.Show("This connection has not been tested, please test the connection first.");
			}
			
			if (! ckWindowsAuthentication.Checked)
			{
				if (! txtPw1.Text.Equals(txtPw2.Text))
				{
					MessageBox.Show("The passwords do not match, returning.");
					return;
				}
			}
			
			string GlobalFileDirectory = txtGlobalFileDirectory.Text.Trim();
			string ProfileName = cbSavedDefinitions.Text;
			string S = GetScreenParms();
			
			if (! Directory.Exists(GlobalFileDirectory))
			{
				try
				{
					Directory.CreateDirectory(GlobalFileDirectory);
				}
				catch (Exception ex)
				{
					MessageBox.Show((string) ("ERROR: Failed to create directory, choose another or contact an administrator, aborting setup." + "\r\n" + ex.Message));
					return;
				}
			}
			
			string FQN = GlobalFileDirectory + GetGlobalFileName();
			
			bool BB = SaveGlobalParms(S, FQN);
			if (BB)
			{
				SB.Text = "Global installation parameters saved.";
			}
			else
			{
				SB.Text = "ERROR: Global installation parameters failed to save.";
			}
			
		}
		public string GetGlobalParms(string FQN)
		{
			
			if (! File.Exists(FQN))
			{
				MessageBox.Show("File \'" + FQN + "\', does not exist, aborting.");
				return "";
			}
			
			bool B = true;
			string strContents;
			StreamReader objReader;
			try
			{
				objReader = new StreamReader(FQN);
				strContents = objReader.ReadToEnd();
				objReader.Close();
				return strContents;
			}
			catch (Exception Ex)
			{
				B = false;
				MessageBox.Show((string) ("ERROR: could not read global configuration file:" + "\r\n" + Ex.Message));
			}
			return B;
		}
		
		public bool SaveGlobalParms(string strData, string FQN)
		{
			
			strData = ENC.AES256EncryptString(strData);
			
			bool bAns = false;
			StreamWriter objReader;
			try
			{
				objReader = new StreamWriter(FQN, false);
				objReader.Write(strData);
				objReader.Close();
				bAns = true;
			}
			catch (Exception Ex)
			{
				MessageBox.Show((string) ("ERROR: did not save global configuration file:" + "\r\n" + Ex.Message));
			}
			return bAns;
		}
		
		public void Button2_Click(System.Object sender, System.EventArgs e)
		{
			
			if (! bConnTested)
			{
				if (FormLoaded)
				{
					MessageBox.Show("This connection has not been validated, please test the connection.");
				}
			}
			
			ResetScreenParms();
			
			string GlobalFileDirectory = txtGlobalFileDirectory.Text.Trim();
			string ProfileName = cbSavedDefinitions.Text;
			
			string FQN = txtGlobalFileDirectory.Text.Trim() + GetGlobalFileName();
			FQN = FQN.Replace("\\\\", "\\");
			
			if (! File.Exists(FQN))
			{
				if (FormLoaded)
				{
					MessageBox.Show("ERROR: Cannot find global parameter file \'" + FQN + "\', aborting load.");
				}
				return;
			}
			
			string GlobalParms = GetGlobalParms(FQN);
			
			string DecryptedParms = ENC.AES256DecryptString(GlobalParms);
			
			string[] A = DecryptedParms.Split('\u007F'.ToString().ToCharArray());
			
			foreach (string S in A)
			{
				string[] Parm = S.Split("|".ToCharArray());
				string ParmName = Parm[0];
				
				if (ParmName.Trim().Length > 0)
				{
					string ParmVal = Parm[1];
					if (ParmName.Equals("txtGlobalFileDirectory"))
					{
						txtGlobalFileDirectory.Text = ParmVal;
					}
					else if (ParmName.Equals("txtRepositoryName"))
					{
						txtRepositoryName.Text = ParmVal;
					}
					else if (ParmName.Equals("txtServerInstance"))
					{
						txtServerInstance.Text = ParmVal;
					}
					else if (ParmName.Equals("ckWindowsAuthentication"))
					{
						if (ParmVal.Equals("True"))
						{
							ckWindowsAuthentication.Checked = true;
						}
						else
						{
							ckWindowsAuthentication.Checked = false;
						}
					}
					else if (ParmName.Equals("ckRepository"))
					{
						if (ParmVal.Equals("True"))
						{
							rbRepository.Checked = true;
						}
						else
						{
							rbRepository.Checked = false;
						}
					}
					else if (ParmName.Equals("ckThesaurus"))
					{
						if (ParmVal.Equals("True"))
						{
							rbThesaurus.Checked = true;
						}
						else
						{
							rbThesaurus.Checked = false;
						}
					}
					else if (ParmName.Equals("txtLoginName"))
					{
						txtLoginName.Text = ParmVal;
					}
					else if (ParmName.Equals("txtPw1"))
					{
						txtPw1.Text = ParmVal;
						txtPw2.Text = ParmVal;
					}
					else if (ParmName.Equals("cbSavedDefinitions"))
					{
						cbSavedDefinitions.Text = ParmVal;
					}
					else if (ParmName.Equals("ckHive"))
					{
						if (ParmVal.Equals("True"))
						{
							ckHive.Checked = true;
						}
						else
						{
							ckHive.Checked = false;
						}
					}
					else if (ParmName.Equals("txtDBName"))
					{
						txtDBName.Text = ParmVal;
					}
				}
			}
			MasterLoaded = true;
			SB.Text = "Global setup parms loaded.";
			MasterConnstr = BuildConnstr();
			txtMstr.Text = MasterConnstr;
		}
		
		public string BuildConnstr()
		{
			string S = "";
			
			if (! ckWindowsAuthentication.Checked)
			{
				S = "Data Source=" + txtServerInstance.Text.Trim() + ";Initial Catalog=" + txtRepositoryName.Text.Trim() + ";Persist Security Info=True;User ID=\'" + txtLoginName.Text.Trim() + "\';Password=\'" + txtPw1.Text.Trim() + "\'";
			}
			else
			{
				S = "Data Source=\'" + txtServerInstance.Text.Trim() + "\';Initial Catalog=\'" + txtRepositoryName.Text.Trim() + "\';Integrated Security=True";
			}
			
			return S;
		}
		
		private string getConnStr()
		{
			string CS = BuildConnstr();
			return CS;
		}
		
		public bool ExecuteSqlNewConn(string sql)
		{
			
			if (MasterConnstr.Trim().Length == 0)
			{
				MessageBox.Show("Please, you must define and save the repository first, execution cancelled - returning.");
				return false;
			}
			
			bool rc = false;
			SqlConnection CN = new SqlConnection(MasterConnstr);
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			try
			{
				using (CN)
				{
					dbCmd.Connection = CN;
					try
					{
						dbCmd.CommandText = sql;
						dbCmd.ExecuteNonQuery();
						BB = true;
					}
					catch (Exception ex)
					{
						rc = false;
						MessageBox.Show((string) ("ERROR SQL Execution: " + "\r\n" + "\r\n" + sql + "\r\n" + "\r\n" + ex.Message));
					}
				}
				
			}
			catch (Exception)
			{
			}
			finally
			{
				if (CN.State == ConnectionState.Open)
				{
					CN.Close();
				}
				
				CN = null;
				dbCmd = null;
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			
			return BB;
		}
		
		public int iCount(string S)
		{
			
			if (MasterConnstr.Trim().Length == 0)
			{
				MessageBox.Show("You must define and save the Respoitory before defining the Thesaurus.");
				return -1;
			}
			
			int Cnt = -1;
			SqlDataReader rsData = null;
			bool b = false;
			string CS = MasterConnstr;
			SqlConnection CONN = new SqlConnection(CS);
			
			try
			{
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				Cnt = rsData.GetInt32(0);
				rsData.Close();
				rsData = null;
				return Cnt;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("clsDatabase : iCount : 2054 : " + ex.Message));
				return -1;
			}
			finally
			{
				if (rsData != null)
				{
					if (! rsData.IsClosed)
					{
						rsData.Close();
					}
					rsData = null;
					CONN.Dispose();
				}
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			return Cnt;
		}
		
		public void cbSavedDefinitions_TextChanged(System.Object sender, System.EventArgs e)
		{
			cbSavedDefinitions.Text = cbSavedDefinitions.Text.Replace("\'", "");
		}
		
		public string GetGlobalFileName()
		{
			string FN = "";
			if (rbThesaurus.Checked)
			{
				FN = "\\Thesaurus.EcmAutoInstall.dat";
			}
			else
			{
				FN = "\\Repository.EcmAutoInstall.dat";
			}
			return FN;
		}
		
		public void btnResetGlobalLocationToDefault_Click(System.Object sender, System.EventArgs e)
		{
			txtGlobalFileDirectory.Text = "C:\\EcmLibrary\\Global";
		}
		
		
		public void btnLoadCombo_Click(System.Object sender, System.EventArgs e)
		{
			
			if (MasterConnstr.Trim().Length == 0)
			{
				MessageBox.Show("ERROR: the master setup has not been set, returning.");
				return;
			}
			
			bLoadingCB = true;
			int PID = 0;
			string s = "SELECT [ConnectionName] FROM [Repository] order by [ConnectionName]";
			SqlDataReader rsData = null;
			string CS = MasterConnstr;
			SqlConnection CONN = new SqlConnection(CS);
			
			cbSavedDefinitions.Items.Clear();
			
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					string ConnectionName = rsData.GetValue(0).ToString();
					cbSavedDefinitions.Items.Add(ConnectionName);
				}
			}
			if (rsData != null)
			{
				if (! rsData.IsClosed)
				{
					rsData.Close();
				}
				rsData = null;
			}
			CONN.Dispose();
			GC.Collect();
			bLoadingCB = false;
		}
		
		public void btnLoadData_Click(System.Object sender, System.EventArgs e)
		{
			if (MasterConnstr.Trim().Length == 0)
			{
				MessageBox.Show("ERROR: the master setup has not been set, returning.");
				return;
			}
			
			if (bLoadingCB)
			{
				return;
			}
			//** Get the database data
			
			string tgtName = cbSavedDefinitions.Text.Trim();
			string CS = MasterConnstr;
			string S = "SELECT [ConnectionName] ,[ConnectionData] ,[ConnectionDataThesaurus] FROM [ECM.Library].[dbo].[Repository] where [ConnectionName] = \'" + tgtName + "\'";
			
			string ConnectionName = "";
			string ConnectionData = "";
			string ConnectionDataThesaurus = "";
			
			SqlDataReader rsData = null;
			SqlConnection CONN = new SqlConnection(CS);
			
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					ConnectionName = rsData.GetValue(0).ToString();
					ConnectionData = rsData.GetValue(1).ToString();
					ConnectionDataThesaurus = rsData.GetValue(2).ToString();
				}
			}
			if (rsData != null)
			{
				if (! rsData.IsClosed)
				{
					rsData.Close();
				}
				rsData = null;
			}
			CONN.Dispose();
			GC.Collect();
			
			if (rbRepository.Checked)
			{
				DecryptParmsAndApply(ConnectionData);
			}
			else
			{
				if (ConnectionDataThesaurus.Length == 0)
				{
					MessageBox.Show("The thesaurus has not been established for this profile.");
				}
				else
				{
					DecryptParmsAndApply(ConnectionDataThesaurus);
				}
			}
			
			bLoadingCB = false;
		}
		
		public void DecryptParmsAndApply(string tgtStr)
		{
			string DecryptedParms = ENC.AES256DecryptString(tgtStr);
			
			string[] A = DecryptedParms.Split('\u007F'.ToString().ToCharArray());
			
			foreach (var S in A)
			{
				string[] Parm = S.Split("|");
				string ParmName = Parm[0];
				
				if (ParmName.Trim().Length > 0)
				{
					string ParmVal = Parm[1];
					if (ParmName.Equals("txtGlobalFileDirectory"))
					{
						txtGlobalFileDirectory.Text = ParmVal;
					}
					else if (ParmName.Equals("txtRepositoryName"))
					{
						txtRepositoryName.Text = ParmVal;
					}
					else if (ParmName.Equals("txtServerInstance"))
					{
						txtServerInstance.Text = ParmVal;
					}
					else if (ParmName.Equals("ckWindowsAuthentication"))
					{
						if (ParmVal.Equals("True"))
						{
							ckWindowsAuthentication.Checked = true;
						}
						else
						{
							ckWindowsAuthentication.Checked = false;
						}
					}
					else if (ParmName.Equals("ckRepository"))
					{
						if (ParmVal.Equals("True"))
						{
							rbRepository.Checked = true;
						}
						else
						{
							rbRepository.Checked = false;
						}
					}
					else if (ParmName.Equals("ckThesaurus"))
					{
						if (ParmVal.Equals("True"))
						{
							rbThesaurus.Checked = true;
						}
						else
						{
							rbThesaurus.Checked = false;
						}
					}
					else if (ParmName.Equals("txtLoginName"))
					{
						txtLoginName.Text = ParmVal;
					}
					else if (ParmName.Equals("txtPw1"))
					{
						txtPw1.Text = ParmVal;
						txtPw2.Text = ParmVal;
					}
					else if (ParmName.Equals("cbSavedDefinitions"))
					{
						cbSavedDefinitions.Text = ParmVal;
					}
					else if (ParmName.Equals("ckHive"))
					{
						if (ParmVal.Equals("True"))
						{
							ckHive.Checked = true;
						}
						else
						{
							ckHive.Checked = false;
						}
					}
					else if (ParmName.Equals("txtDBName"))
					{
						txtDBName.Text = ParmVal;
					}
				}
			}
		}
		
		public void GotoGlobalDirectoryToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string AppPath = txtGlobalFileDirectory.Text;
			ProcessStartInfo procstart = new ProcessStartInfo("explorer");
			procstart.Arguments = AppPath;
			Process.Start(procstart);
		}
		
		public void GotoApplicationDirectoryToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			string AppPath = System.AppDomain.CurrentDomain.BaseDirectory;
			ProcessStartInfo procstart = new ProcessStartInfo("explorer");
			string winDir = System.IO.Path.GetDirectoryName(AppPath);
			procstart.Arguments = AppPath;
			Process.Start(procstart);
		}
		
		//Private Sub LicenseToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LicenseToolStripMenuItem.Click
		
		//    frmLicense.txtServerName.Text = txtDBName.Text
		//    frmLicense.txtServer.Text = txtServerInstance.Text.Trim
		//    frmLicense.txtCurrConnStr.Text = BuildConnstr()
		//    frmLicense.Show()
		
		//End Sub
	}
	
}
