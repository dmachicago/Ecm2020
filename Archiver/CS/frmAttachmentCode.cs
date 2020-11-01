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

using System.Data.SqlClient;
using System.IO;



namespace EcmArchiveClcSetup
{
	public partial class frmAttachmentCode : System.Windows.Forms.Form
	{
		
		public string ProcessID = "";
		bool FormLoaded = false;
		public string TBL = "";
		public string S = "";
		public string winTitle = "";
		SqlDataAdapter da;
		SqlCommand SqlCommand1;
		DataSet DS;
		SqlCommandBuilder cb;
		SqlConnection Cn;
		bool ddebug = true;
		clsDma DMA = new clsDma();
		clsDatabase DB = new clsDatabase();
		
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		bool bHelpLoaded = false;
		public frmAttachmentCode()
		{
			//LOG.WriteToArchiveLog("Starting: frmAttachmentCode")
			// This call is required by the Windows Form Designer.
			InitializeComponent();
			
			// Add any initialization after the InitializeComponent() call.
			
		}
		
		public void frmAttachmentCode_Deactivate(object sender, System.EventArgs e)
		{
			if (this.Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
			{
				DB.SetExchangeDefaultRetentionCode();
			}
		}
		
		public void frmAttachmentCode_Disposed(object sender, System.EventArgs e)
		{
			if (this.Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
			{
				DB.SetExchangeDefaultRetentionCode();
			}
		}
		public void frmAttachmentCode_Load(System.Object sender, System.EventArgs e)
		{
			FormLoaded = false;
			
			//Dim bGetScreenObjects As Boolean = True
			//If bGetScreenObjects Then DMA.getFormWidgets(Me)
			
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
			
			//Dim ConnStr  = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
			string ConnStr = DB.getGateWayConnStr(modGlobals.gGateWayID);
			UTIL.setConnectionStringTimeout(ref ConnStr);
			Cn = new SqlConnection(ConnStr);
			
			if (winTitle.Length == 0)
			{
				this.Text = "Administrator Data Maintenance";
			}
			else
			{
				this.Text = winTitle;
			}
			
			// Sql Query
			if (S.Length == 0)
			{
				S = (string) ("Select * FROM " + TBL);
			}
			
			DS = new DataSet();
			// Create a Command
			SqlCommand1 = new SqlCommand(S, Cn);
			
			// Create SqlDataAdapter
			da = new SqlDataAdapter();
			da.SelectCommand = SqlCommand1;
			
			// Create SqlCommandBuildser object
			cb = new SqlCommandBuilder(da);
			
			// Fill Dataset
			da.Fill(DS, TBL);
			
			// Bind the data to the grid at runtime
			dgAttachmentCode.DataSource = DS;
			dgAttachmentCode.DataMember = TBL;
			
			if (this.Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
			{
				btnEncrypt.Visible = true;
				Label1.Visible = true;
				cbRetention.Visible = true;
				btnApplyRetentionRule.Visible = true;
				DB.LoadRetentionCodes(this.cbRetention);
				return;
			}
			else
			{
				btnEncrypt.Visible = false;
				Label1.Visible = false;
				cbRetention.Visible = false;
				btnApplyRetentionRule.Visible = false;
				return;
			}
			if (this.Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
			{
				btnEncrypt.Visible = true;
				Label1.Visible = true;
				cbRetention.Visible = true;
				btnApplyRetentionRule.Visible = true;
				DB.LoadRetentionCodes(this.cbRetention);
				return;
			}
			else
			{
				btnEncrypt.Visible = false;
				Label1.Visible = false;
				cbRetention.Visible = false;
				btnApplyRetentionRule.Visible = false;
				return;
			}
			FormLoaded = true;
			
			this.Text += "          (frmAttachmentCode)";
			
		}
		
		public void btnUpdate_Click(System.Object sender, System.EventArgs e)
		{
			string S = "";
			try
			{
				if (ProcessID.Equals("UserRuntimeParameters"))
				{
					for (int I = 0; I <= dgAttachmentCode.RowCount - 2; I++)
					{
						string Parm = dgAttachmentCode.Rows[I].Cells["Parm"].Value.ToString();
						string UID = dgAttachmentCode.Rows[I].Cells["UserID"].Value.ToString();
						string ParmValue = dgAttachmentCode.Rows[I].Cells["ParmValue"].Value.ToString();
						Parm = UTIL.RemoveSingleQuotes(Parm);
						ParmValue = UTIL.RemoveSingleQuotes(ParmValue);
						
						S = "update RunParms set ParmValue = \'" + ParmValue + "\' where UserID = \'" + UID + "\' and Parm = \'" + Parm + "\' ";
						bool b = DB.ExecuteSqlNewConn(S);
						if (! b)
						{
							LOG.WriteToArchiveLog((string) ("ERROR: 22.11.341 - Could not update user parm." + "\r\n" + S));
							MessageBox.Show("Failed to update user parm.");
						}
					}
					
					return;
				}
				da.Update(DS, TBL);
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message + "\r\n" + S);
			}
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
		
		public void dgAttachmentCode_CellContentClick(System.Object sender, System.Windows.Forms.DataGridViewCellEventArgs e)
		{
			if (this.Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
			{
				btnEncrypt.Visible = true;
				return;
			}
			else
			{
				btnEncrypt.Visible = false;
				return;
			}
			if (this.Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
			{
				btnEncrypt.Visible = true;
				return;
			}
			else
			{
				btnEncrypt.Visible = false;
				return;
			}
		}
		
		public void btnEncrypt_Click(System.Object sender, System.EventArgs e)
		{
			clsEncrypt ENC = new clsEncrypt();
			
			int iCnt = this.dgAttachmentCode.SelectedRows.Count;
			
			if (iCnt != 1)
			{
				MessageBox.Show("Please select one and only one row to update, thank you - returning.");
				return;
			}
			
			var HostNameIp = this.dgAttachmentCode.SelectedRows[0].Cells["HostNameIp"].Value.ToString();
			var UserLoginID = this.dgAttachmentCode.SelectedRows[0].Cells["UserLoginID"].Value.ToString();
			string PW = this.dgAttachmentCode.SelectedRows[0].Cells["LoginPw"].Value.ToString();
			string EncPW = ENC.AES256EncryptString(PW);
			string S = "";
			
			if (this.Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
			{
				this.dgAttachmentCode.SelectedRows[0].Cells["LoginPw"].Value = EncPW;
				
				S = "Update [ExchangeHostPop] set LoginPW = \'" + EncPW + "\' where [HostNameIp] = \'" + HostNameIp + "\' and [UserLoginID] = \'" + UserLoginID + "\'";
				DB.ExecuteSqlNewConn(S);
				
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			if (this.Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
			{
				this.dgAttachmentCode.SelectedRows[0].Cells["LoginPw"].Value = EncPW;
				
				S = "Update [ExchangeHostSmtp] set LoginPW = \'" + EncPW + "\' where [HostNameIp] = \'" + HostNameIp + "\' and [UserLoginID] = \'" + UserLoginID + "\'";
				DB.ExecuteSqlNewConn(S);
				
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			ENC = null;
		}
		
		public void btnApplyRetentionRule_Click(System.Object sender, System.EventArgs e)
		{
			int iCnt = this.dgAttachmentCode.SelectedRows.Count;
			
			if (iCnt != 1)
			{
				MessageBox.Show("Please select one and only one row to update, thank you - returning.");
				return;
			}
			
			string RetentionCode = cbRetention.Text.Trim();
			
			if (RetentionCode.Length == 0)
			{
				MessageBox.Show("Please select a retention rule.");
				return;
			}
			
			var HostNameIp = this.dgAttachmentCode.SelectedRows[0].Cells["HostNameIp"].Value.ToString();
			var UserLoginID = this.dgAttachmentCode.SelectedRows[0].Cells["UserLoginID"].Value.ToString();
			string S = "";
			
			if (this.Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
			{
				this.dgAttachmentCode.SelectedRows[0].Cells["RetentionCode"].Value = RetentionCode;
				
				S = "Update [ExchangeHostPop] set RetentionCode = \'" + RetentionCode + "\' where [HostNameIp] = \'" + HostNameIp + "\' and [UserLoginID] = \'" + UserLoginID + "\'";
				DB.ExecuteSqlNewConn(S);
				
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			if (this.Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
			{
				this.dgAttachmentCode.SelectedRows[0].Cells["RetentionCode"].Value = RetentionCode;
				
				S = "Update [ExchangeHostSmtp] set RetentionCode = \'" + RetentionCode + "\' where [HostNameIp] = \'" + HostNameIp + "\' and [UserLoginID] = \'" + UserLoginID + "\'";
				DB.ExecuteSqlNewConn(S);
				
				GC.Collect();
				GC.WaitForFullGCComplete();
			}
			
		}
		
		public void frmAttachmentCode_Resize(object sender, System.EventArgs e)
		{
			if (FormLoaded == false)
			{
				return;
			}
			modResizeForm.ResizeControls(this);
		}
	}
	
}
