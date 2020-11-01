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
	public partial class frmExhangeMail
	{
		public frmExhangeMail()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmExhangeMail defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmExhangeMail Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmExhangeMail();
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
		
		bool FormLoaded = false;
		clsEXCHANGEHOSTPOP POP = new clsEXCHANGEHOSTPOP();
		clsDma DMA = new clsDma();
		
		clsEncrypt ENC = new clsEncrypt();
		
		clsDatabase DB = new clsDatabase();
		clsDataGrid DG = new clsDataGrid();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string HostNameIp = "";
		string UserLoginID = "";
		string LoginPw = "";
		string SSL = "";
		string PortNbr = "";
		string DeleteAfterDownload = "";
		string RetentionCode = "";
		string IMap = "";
		string Userid = "";
		string FolderName = "";
		string LibraryName = "";
		int DaysToHold;
		bool RedemptionDllExists = false;
		
		public void frmExhangeMail_Load(System.Object sender, System.EventArgs e)
		{
			FormLoaded = false;
			
			RedemptionDllExists = modDLL.ckDLLAvailable("redemption.dll");
			
			PopulateExchangeGrid();
			DB.LoadRetentionCodes(cbRetention);
			
			PopUserCombo();
			PopulateLibraryCombo();
			
			if (RedemptionDllExists == true)
			{
				ckConvertEmlToMsg.Enabled = true;
				SB.Text = "Note: Available";
			}
			else
			{
				ckConvertEmlToMsg.Enabled = false;
				SB.Text = "Note: Required DLL missing";
			}
			
			ResetScreenWidgets();
			
			FormLoaded = true;
		}
		public void ResetScreenWidgets()
		{
			
			FormLoaded = false;
			
			txtUserLoginID.Text = "";
			txtPw.Text = "";
			cbHostName.Text = "";
			txtPortNumber.Text = "";
			ckSSL.Checked = false;
			ckIMap.Checked = false;
			ckDeleteAfterDownload.Checked = false;
			txtPortNumber.Text = "";
			txtFolderName.Text = "";
			cbRetention.Text = "";
			cbUsers.Text = "";
			cbLibrary.Text = "";
			ckPublic.Checked = false;
			ckConvertEmlToMsg.Checked = false;
			SB.Text = "";
			txtUserID.Text = "";
			
			FormLoaded = true;
		}
		public void PopulateLibraryCombo()
		{
			
			//DB.PopulateLibCombo(cbLibrary)
			this.Cursor = Cursors.WaitCursor;
			DB.PopulateGroupUserLibCombo(this.cbLibrary);
			this.Cursor = Cursors.Default;
			
		}
		public void PopUserCombo()
		{
			string S = "";
			S = S + " SELECT [UserLoginID]";
			S = S + "FROM  [Users]";
			S = S + "order by [UserLoginID]";
			DB.PopulateComboBox(this.cbUsers, "UserLoginID", S);
		}
		public void ShowAll()
		{
			
			if (! modGlobals.isAdmin)
			{
				SB.Text = "You must be an ADMIN to execute this function.";
				return;
			}
			
			string S = "";
			
			S = S + " SELECT [HostNameIp]";
			S = S + " ,[UserLoginID]";
			S = S + " ,[LoginPw]";
			S = S + " ,[SSL]";
			S = S + " ,[PortNbr]";
			S = S + " ,[DeleteAfterDownload]";
			S = S + " ,[RetentionCode]";
			S = S + " ,[IMap]";
			S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG ";
			S = S + " FROM [ExchangeHostPop] ";
			S = S + " order by [HostNameIp]";
			
			
			DG.PopulateGrid("ExchangeHostPop", S, dgExchange);
		}
		public void PopulateExchangeGrid()
		{
			string S = "";
			if (modGlobals.gCurrLoginID.ToUpper().Equals("SERVICEMANAGER"))
			{
				S = S + " SELECT [HostNameIp]";
				S = S + " ,[UserLoginID]";
				S = S + " ,[LoginPw]";
				S = S + " ,[SSL]";
				S = S + " ,[PortNbr]";
				S = S + " ,[DeleteAfterDownload]";
				S = S + " ,[RetentionCode]";
				S = S + " ,[IMap]";
				S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG";
				S = S + " FROM [ExchangeHostPop] ";
				S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " order by [HostNameIp]";
				//ElseIf isAdmin Then
				//    S = S + " SELECT [HostNameIp]"
				//    S = S + " ,[UserLoginID]"
				//    S = S + " ,[LoginPw]"
				//    S = S + " ,[SSL]"
				//    S = S + " ,[PortNbr]"
				//    S = S + " ,[DeleteAfterDownload]"
				//    S = S + " ,[RetentionCode]"
				//    S = S + " ,[IMap]"
				//    S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG "
				//    S = S + " FROM [ExchangeHostPop] "
				//    S = S + " order by [HostNameIp]"
			}
			else
			{
				S = S + " SELECT [HostNameIp]";
				S = S + " ,[UserLoginID]";
				S = S + " ,[LoginPw]";
				S = S + " ,[SSL]";
				S = S + " ,[PortNbr]";
				S = S + " ,[DeleteAfterDownload]";
				S = S + " ,[RetentionCode]";
				S = S + " ,[IMap]";
				S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG";
				S = S + " FROM [ExchangeHostPop] ";
				S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " order by [HostNameIp]";
			}
			
			DG.PopulateGrid("ExchangeHostPop", S, dgExchange);
			
		}
		public void PopulateExchangeComboBox()
		{
			string S = "";
			if (modGlobals.isAdmin)
			{
				S = S + " SELECT distinct [HostNameIp] FROM [ExchangeHostPop]         ";
				S = S + " order by [HostNameIp]";
			}
			else
			{
				S = S + " SELECT distinct [HostNameIp] FROM [ExchangeHostPop]         ";
				S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " order by [HostNameIp]";
			}
			DB.PopulateComboBox(cbHostName, "HostNameIp", S);
		}
		
		public void btnAdd_Click(System.Object sender, System.EventArgs e)
		{
			try
			{
				if (cbHostName.Text.Trim().Length == 0)
				{
					MessageBox.Show("Please supply a Host Name or IP.");
					return;
				}
				if (this.cbRetention.Text.Trim().Length == 0)
				{
					MessageBox.Show("Please supply a Retention Code.");
					return;
				}
				if (txtPw.Text.Trim().Length == 0)
				{
					MessageBox.Show("Please supply a password.");
					return;
				}
				if (this.txtUserLoginID.Text.Trim().Length == 0)
				{
					MessageBox.Show("Please supply a user login ID.");
					return;
				}
				if (txtReject.Text.Trim().Length > 0)
				{
					string sReject = txtReject.Text.Trim();
					sReject = UTIL.RemoveSingleQuotes(sReject);
					
				}
				
				POP.setReject(txtReject.Text.Trim());
				POP.setUserid(ref modGlobals.gCurrUserGuidID);
				if (ckDeleteAfterDownload.Checked == true)
				{
					POP.setDeleteafterdownload("1");
				}
				else
				{
					POP.setDeleteafterdownload("0");
				}
				
				POP.setHostnameip(cbHostName.Text);
				if (ckIMap.Checked == true)
				{
					POP.setImap("1");
				}
				else
				{
					POP.setImap("0");
				}
				
				POP.setLibrary(ckPublic.Checked);
				POP.setLibrary(cbLibrary.Text);
				POP.setLoginpw(txtPw.Text.Trim());
				POP.setPortnbr(txtPortNumber.Text.Trim());
				POP.setRetentioncode(this.cbRetention.Text);
				POP.setDaysToHold((int) nbrDaysToRetain.Value);
				
				if (this.ckSSL.Checked == true)
				{
					POP.setSsl("1");
				}
				else
				{
					POP.setSsl("0");
				}
				
				string tUserID = DB.getUserGuidID(this.cbUsers.Text);
				if (tUserID.Trim.Length == 0)
				{
					tUserID = modGlobals.gCurrUserGuidID;
				}
				POP.setUserid(ref tUserID);
				
				if (this.txtFolderName.Text.Trim().Length == 0)
				{
					this.txtFolderName.Text = "NA";
				}
				
				POP.setFolderName(this.txtFolderName.Text.Trim());
				POP.setUserloginid(this.txtUserLoginID.Text.Trim());
				
				POP.setConvertEmlToMsg(ckConvertEmlToMsg.Checked);
				
				bool b = POP.Insert();
				if (! b)
				{
					SB.Text = "Failed to add new Exchange record.";
				}
				else
				{
					SB.Text = "Added new Exchange record.";
					PopulateExchangeGrid();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR frmExhangeMail:btnAdd_Click - " + ex.Message));
			}
			
		}
		
		public void dgExchange_CellContentClick(System.Object sender, System.Windows.Forms.DataGridViewCellEventArgs e)
		{
			getGridData();
		}
		
		public void dgExchange_MouseDown(object sender, System.Windows.Forms.MouseEventArgs e)
		{
			if (e.Button == MouseButtons.Right)
			{
				if (e.Button == MouseButtons.Right)
				{
					//ContextHandler(Me.dgDoc, e)
					System.Drawing.Point PNT = new System.Drawing.Point();
					PNT.X = e.X;
					PNT.Y = e.Y;
					int X = e.X;
					int Y = e.Y;
					Debug.Print(X.ToString() + "," + Y.ToString());
					//ContextMenuStrip1.Show(Me, PNT)
					//ContextMenuStrip1.Show(Me, 100, 100)
					ContextMenuStrip1.Show(this.dgExchange, X, Y);
				}
			}
		}
		
		public void dgExchange_SelectionChanged(object sender, System.EventArgs e)
		{
			getGridData();
		}
		
		public void btnUpdate_Click(System.Object sender, System.EventArgs e)
		{
			int icnt = dgExchange.SelectedRows.Count;
			if (icnt != 1)
			{
				MessageBox.Show("Please select one and only one item to update.");
				return;
			}
			if (cbHostName.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a Host Name or IP.");
				return;
			}
			if (this.cbRetention.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a Retention Code.");
				return;
			}
			if (txtPw.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a password.");
				return;
			}
			if (this.txtUserLoginID.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a user login ID.");
				return;
			}
			
			POP.setReject(txtReject.Text.Trim());
			POP.setDaysToHold((int) nbrDaysToRetain.Value);
			POP.setUserid(this.txtUserID.Text);
			
			if (ckDeleteAfterDownload.Checked == true)
			{
				POP.setDeleteafterdownload("1");
			}
			else
			{
				POP.setDeleteafterdownload("0");
			}
			
			POP.setHostnameip(cbHostName.Text);
			if (ckIMap.Checked == true)
			{
				POP.setImap("1");
			}
			else
			{
				POP.setImap("0");
			}
			POP.setLoginpw(txtPw.Text.Trim());
			POP.setPortnbr(txtPortNumber.Text.Trim());
			POP.setRetentioncode(this.cbRetention.Text);
			if (this.ckSSL.Checked == true)
			{
				POP.setSsl("1");
			}
			else
			{
				POP.setSsl("0");
			}
			
			string tUserID = DB.getUserGuidID(this.cbUsers.Text);
			if (tUserID.Trim.Length == 0)
			{
				tUserID = modGlobals.gCurrUserGuidID;
			}
			POP.setUserid(ref modGlobals.gCurrUserGuidID);
			
			POP.setUserloginid(this.txtUserLoginID.Text.Trim());
			
			Userid = txtUserID.Text;
			
			POP.setFolderName(this.txtFolderName.Text.Trim());
			POP.setLibrary(ckPublic.Checked);
			POP.setLibrary(cbLibrary.Text);
			
			POP.setConvertEmlToMsg(ckConvertEmlToMsg.Checked);
			
			
			bool b = POP.Update(HostNameIp, Userid, UserLoginID);
			if (! b)
			{
				SB.Text = "Failed to update Exchange record.";
			}
			else
			{
				SB.Text = "Updated Exchange record.";
				PopulateExchangeGrid();
			}
		}
		
		public void btnDelete_Click(System.Object sender, System.EventArgs e)
		{
			int icnt = dgExchange.SelectedRows.Count;
			if (icnt != 1)
			{
				MessageBox.Show("Please select one and only one item to update.");
				return;
			}
			if (cbHostName.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a Host Name or IP.");
				return;
			}
			if (this.cbRetention.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a Retention Code.");
				return;
			}
			if (txtPw.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a password.");
				return;
			}
			if (this.txtUserLoginID.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a user login ID.");
				return;
			}
			POP.setUserid(ref modGlobals.gCurrUserGuidID);
			if (ckDeleteAfterDownload.Checked == true)
			{
				POP.setDeleteafterdownload("1");
			}
			else
			{
				POP.setDeleteafterdownload("0");
			}
			
			POP.setHostnameip(cbHostName.Text);
			if (ckIMap.Checked == true)
			{
				POP.setImap("1");
			}
			else
			{
				POP.setImap("0");
			}
			POP.setLoginpw(txtPw.Text.Trim());
			POP.setPortnbr(txtPortNumber.Text.Trim());
			POP.setRetentioncode(this.cbRetention.Text);
			if (this.ckSSL.Checked == true)
			{
				POP.setSsl("1");
			}
			else
			{
				POP.setSsl("0");
			}
			POP.setUserid(ref modGlobals.gCurrUserGuidID);
			POP.setUserloginid(this.txtUserLoginID.Text.Trim());
			
			string WC = POP.wc_PK_ExchangeHostPop(HostNameIp, Userid, UserLoginID);
			
			bool b = POP.Delete(WC);
			if (! b)
			{
				SB.Text = "Failed to delete record.";
			}
			else
			{
				SB.Text = "Deleted Exchange record.";
				PopulateExchangeGrid();
			}
		}
		public void getGridData()
		{
			
			try
			{
				int iRow = dgExchange.CurrentRow.Index;
				int iCnt = dgExchange.SelectedRows.Count;
				if (iCnt == 0)
				{
					return;
				}
				if (iCnt > 1)
				{
					return;
				}
				
				HostNameIp = dgExchange.SelectedRows[0].Cells["HostNameIp"].Value.ToString();
				UserLoginID = dgExchange.SelectedRows[0].Cells["UserLoginID"].Value.ToString();
				SSL = dgExchange.SelectedRows[0].Cells["SSL"].Value.ToString();
				PortNbr = dgExchange.SelectedRows[0].Cells["PortNbr"].Value.ToString();
				DeleteAfterDownload = dgExchange.SelectedRows[0].Cells["DeleteAfterDownload"].Value.ToString();
				RetentionCode = dgExchange.SelectedRows[0].Cells["RetentionCode"].Value.ToString();
				IMap = dgExchange.SelectedRows[0].Cells["IMap"].Value.ToString();
				Userid = dgExchange.SelectedRows[0].Cells["Userid"].Value.ToString();
				LoginPw = dgExchange.SelectedRows[0].Cells["LoginPw"].Value.ToString();
				FolderName = dgExchange.SelectedRows[0].Cells["FolderName"].Value.ToString();
				LibraryName = dgExchange.SelectedRows[0].Cells["LibraryName"].Value.ToString();
				DaysToHold = int.Parse(val[dgExchange.SelectedRows[0].Cells["DaysToHold"].Value.ToString()]);
				txtReject.Text = dgExchange.SelectedRows[0].Cells["strReject"].Value.ToString();
				
				string tUserLoginID = DB.getUserLoginByUserid(Userid);
				SB.Text = (string) ("Execution ID: " + tUserLoginID);
				//
				string tVal = dgExchange.SelectedRows[0].Cells["ConvertEmlToMSG"].Value.ToString();
				if (tVal.ToUpper().Equals("TRUE"))
				{
					ckConvertEmlToMsg.Checked = true;
				}
				else
				{
					ckConvertEmlToMsg.Checked = false;
				}
				
				if (IMap.ToUpper().Equals("TRUE"))
				{
					ckIMap.Checked = true;
				}
				else
				{
					ckIMap.Checked = false;
				}
				if (SSL.ToUpper().Equals("TRUE"))
				{
					ckSSL.Checked = true;
				}
				else
				{
					ckSSL.Checked = false;
				}
				
				this.cbHostName.Text = HostNameIp;
				this.txtUserLoginID.Text = UserLoginID;
				//Me.ckSSL.Checked = Val(SSL)
				this.txtPortNumber.Text = PortNbr;
				if (DeleteAfterDownload == true)
				{
					this.ckDeleteAfterDownload.Checked = true;
				}
				else
				{
					this.ckDeleteAfterDownload.Checked = false;
				}
				
				this.cbRetention.Text = RetentionCode;
				//Me.ckIMap.Checked = Val(IMap)
				this.cbUsers.Text = DB.getUserLoginByUserid(Userid);
				this.txtPw.Text = LoginPw;
				
				this.txtUserID.Text = Userid;
				this.txtFolderName.Text = FolderName.Trim();
				
				cbLibrary.Text = LibraryName;
				nbrDaysToRetain.Value = DaysToHold;
				
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
			
		}
		
		public void btnEncrypt_Click(System.Object sender, System.EventArgs e)
		{
			if (txtPw.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a password.");
				return;
			}
			string tPw = txtPw.Text.Trim();
			txtPw.Text = ENC.AES256EncryptString(tPw);
			
		}
		
		public void ExchnageJournalingToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			//Exchange2003Journaling.htm
			System.Diagnostics.Process.Start("http://www.ecmlibrary.com/helpfiles/Exchange2003Journaling.htm");
		}
		
		public void Exchange2007Vs2003ToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			//Microsoft Exchange Server 2007 Compliance Tour.htm
			System.Diagnostics.Process.Start("http://www.ecmlibrary.com/helpfiles/Microsoft Exchange Server 2007 Compliance Tour.htm");
		}
		
		public void ECMLibraryExchangeInterfaceToolStripMenuItem1_Click(System.Object sender, System.EventArgs e)
		{
			//ECM Library Exchange Server Journaling Interface.htm
			System.Diagnostics.Process.Start("http://www.ecmlibrary.com/helpfiles/ECM Library Exchange Server Journaling Interface.htm");
		}
		
		public void ckIMap_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckIMap.Checked)
			{
				txtFolderName.Enabled = true;
			}
			else
			{
				txtFolderName.Enabled = false;
			}
		}
		
		public void Button1_Click(System.Object sender, System.EventArgs e)
		{
			if (btnTest.Text.Equals("Show All"))
			{
				ShowAll();
				btnTest.Text = "Show Mine";
			}
			else
			{
				PopulateExchangeGrid();
				btnTest.Text = "Show All";
			}
			
		}
		
		public void btnReset_Click(System.Object sender, System.EventArgs e)
		{
			ResetScreenWidgets();
		}
		
		public void ckExcg2007_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckExcg2007.Checked)
			{
				
				this.ckPlainText.Checked = false;
				this.ckPlainText.Enabled = false;
				
				this.ckRtfFormat.Checked = false;
				this.ckRtfFormat.Enabled = false;
				
				ckEnvelope.Checked = true;
				
			}
			else
			{
				this.ckPlainText.Checked = false;
				this.ckPlainText.Enabled = true;
				
				this.ckRtfFormat.Checked = false;
				this.ckRtfFormat.Enabled = true;
				
				ckEnvelope.Checked = true;
			}
		}
		
		public void ckExcg2003_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckExcg2003.Checked == true)
			{
				this.ckPlainText.Checked = false;
				this.ckPlainText.Enabled = true;
				
				this.ckRtfFormat.Checked = false;
				this.ckRtfFormat.Enabled = true;
				
				ckEnvelope.Checked = true;
			}
		}
		
		public void ckDeleteAfterDownload_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (ckDeleteAfterDownload.Checked)
			{
				//Label9.Visible = False
				nbrDaysToRetain.Enabled = false;
				nbrDaysToRetain.Value = 0;
			}
			else
			{
				Label9.Visible = true;
				nbrDaysToRetain.Visible = true;
				nbrDaysToRetain.Enabled = true;
			}
		}
		
		public void btnShoaAllLib_Click(System.Object sender, System.EventArgs e)
		{
			if (modGlobals.isAdmin)
			{
				DB.PopulateAllUserLibCombo(this.cbLibrary);
			}
			else
			{
				SB.Text = "Admin authority required for this function.";
			}
		}
		
		public void btnTestConnection_Click(System.Object sender, System.EventArgs e)
		{
			
			clsEmailFunctions EM = new clsEmailFunctions();
			string MailServerAddr = cbHostName.Text;
			int Portnbr = int.Parse(val[txtPortNumber.Text]);
			string UserLoginID = txtUserLoginID.Text;
			string LoginPassWord = txtPw.Text;
			string Msg = "";
			bool B = false;
			
			if (ckSSL.Checked == true && ckIMap.Checked == true)
			{
				B = EM.ckImapSSLConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
				if (B)
				{
					Msg = (string) ("Successful login to: " + MailServerAddr);
				}
				else
				{
					Msg = (string) ("FAILED login to: " + MailServerAddr);
				}
			}
			else if (ckSSL.Checked == false && ckIMap.Checked == true)
			{
				B = EM.clIMapConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
				if (B)
				{
					Msg = (string) ("Successful login to: " + MailServerAddr);
				}
				else
				{
					Msg = (string) ("FAILED login to: " + MailServerAddr);
				}
			}
			else if (ckSSL.Checked == true && ckIMap.Checked == false)
			{
				int iCnt = EM.ckPopSSL(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
				if (iCnt >= 0)
				{
					Msg = "Successful login to: " + MailServerAddr + " : " + iCnt.ToString() + " emails on server.";
				}
				else
				{
					Msg = (string) ("FAILED login to: " + MailServerAddr);
				}
			}
			else
			{
				int iCnt = EM.ckPopConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
				if (iCnt >= 0)
				{
					Msg = "Successful login to: " + MailServerAddr + " : " + iCnt.ToString() + " emails on server.";
				}
				else
				{
					Msg = (string) ("FAILED login to: " + MailServerAddr);
				}
			}
			
			EM = null;
			
			
			SB.Text = Msg;
			
			
		}
		
		public void SampleIMAPSSLScreenToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "imap.gmail.com";
			txtUserLoginID.Text = "xxx@gmail.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = true;
			ckIMap.Checked = true;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "465";
			txtFolderName.Text = "xxx@gmail.com";
			
		}
		
		public void SampleIMAPScreenToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "imap.aol.com";
			txtUserLoginID.Text = "xxx@aol.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = false;
			ckIMap.Checked = true;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "143";
			txtFolderName.Text = "xxx@aol.com";
		}
		
		public void SamplePOPMailScreenToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "pop.gmail.com";
			txtUserLoginID.Text = "xxx@gmail.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = false;
			ckIMap.Checked = false;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "995";
			txtFolderName.Text = "xxx@gmail.com";
		}
		
		public void SamplePOPSSLMailScreenToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "pop.gmail.com";
			txtUserLoginID.Text = "xxx@gmail.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = true;
			ckIMap.Checked = false;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "110";
			txtFolderName.Text = "xxx@gmail.com";
		}
		
		public void SampleCorporateEmailScreenToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "pop.secureserver.net";
			txtUserLoginID.Text = "xUser@EcmLibrary.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = false;
			ckIMap.Checked = false;
			nbrDaysToRetain.Value = 2;
			txtPortNumber.Text = "110";
			txtFolderName.Text = "xxx@gmail.com";
		}
		
		public void HelpToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void ComplianceOverviewToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			//Microsoft Exchange Server 2007 Compliance Tour.htm
			System.Diagnostics.Process.Start("http://www.ecmlibrary.com/helpfiles/Microsoft Exchange Server 2007 Compliance Tour.htm");
		}
		
		public void ExchangeJournalingToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			//Exchange2003Journaling.htm
			System.Diagnostics.Process.Start("http://www.ecmlibrary.com/helpfiles/Exchange2003Journaling.htm");
		}
		
		public void POPMailToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "pop.gmail.com";
			txtUserLoginID.Text = "xxx@gmail.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = false;
			ckIMap.Checked = false;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "995";
			txtFolderName.Text = "xxx@gmail.com";
		}
		
		public void IMAPSSLToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "imap.gmail.com";
			txtUserLoginID.Text = "xxx@gmail.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = true;
			ckIMap.Checked = true;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "465";
			txtFolderName.Text = "INBOX";
		}
		
		public void IMAPToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "imap.aol.com";
			txtUserLoginID.Text = "xxx@aol.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = false;
			ckIMap.Checked = true;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "143";
			txtFolderName.Text = "INBOX";
		}
		
		public void POPSSLToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "pop.gmail.com";
			txtUserLoginID.Text = "xxx@gmail.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = true;
			ckIMap.Checked = false;
			nbrDaysToRetain.Value = 5;
			txtPortNumber.Text = "110";
			txtFolderName.Text = "xxx@gmail.com";
		}
		
		public void StandardCoporateToolStripMenuItem_Click(System.Object sender, System.EventArgs e)
		{
			cbHostName.Text = "pop.secureserver.net";
			txtUserLoginID.Text = "xUser@EcmLibrary.com";
			txtPw.Text = "<password>";
			ckSSL.Checked = false;
			ckIMap.Checked = false;
			nbrDaysToRetain.Value = 2;
			txtPortNumber.Text = "110";
			txtFolderName.Text = "xxx@gmail.com";
		}
	}
	
}
