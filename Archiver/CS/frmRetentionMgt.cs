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
	public partial class frmRetentionMgt
	{
		public frmRetentionMgt()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmRetentionMgt defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmRetentionMgt Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmRetentionMgt();
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
		//Dim SHIST As New clsSEARCHHISTORY
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsDataGrid DG = new clsDataGrid();
		bool bHelpLoaded = false;
		bool FormLoaded = false;
		
		clsLogging LOG = new clsLogging();
		
		public void ToolTip1_Popup(System.Object sender, System.Windows.Forms.PopupEventArgs e)
		{
			
		}
		
		public void frmRetentionMgt_Load(System.Object sender, System.EventArgs e)
		{
			modResizeForm.GetLocation(this);
			
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
			//Dim bGetScreenObjects As Boolean = True
			//If bGetScreenObjects Then DMA.getFormWidgets(Me)
			
			btnRecall.Enabled = false;
			btnRecall.Text = "Load Marked EMAIL Retention Items";
			
		}
		public void PopulateGrid(string MySql)
		{
			DateTime StartTime = DateTime.Now;
			
			//System.Windows.Forms.DataGridViewCellEventArgs
			try
			{
				SB.Text = "";
				BindingSource BS = new BindingSource();
				
				string CS = DB.setConnStr();
				SqlConnection sqlcn = new SqlConnection(CS);
				SqlDataAdapter sadapt = new SqlDataAdapter(MySql, sqlcn);
				DataSet ds = new DataSet();
				
				//Me.DsDocumentSearch.Reset()
				
				if (sqlcn.State == ConnectionState.Closed)
				{
					sqlcn.Open();
				}
				
				sadapt.Fill(ds, "DataSource");
				SB.Text = "Returned Items: " + ds.Tables["DataSource"].Rows.Count.ToString();
				
				dgItems.DataSource = null;
				dgItems.DataSource = ds.Tables["DataSource"];
				
				//SHIST.setCalledfrom(Me.Name)
				//SHIST.setEndtime(Now.ToString)
				//SHIST.setReturnedrows(Me.dgItems.RowCount)
				//SHIST.setTypesearch("PopulateGrid")
				//SHIST.setStarttime(StartTime.ToString)
				//SHIST.setSearchdate(Now.ToString)
				//SHIST.setSearchsql(MySql )
				//SHIST.setUserid(gCurrUserGuidID)
				//Dim b As Boolean = SHIST.Insert
				//If Not b Then
				//    Debug.Print("Error 1943.23b - Failed to save history of search.")
				//End If
				
			}
			catch (Exception ex)
			{
				MessageBox.Show("Search Error 165.4x: " + ex.Message);
				LOG.WriteToSqlLog((string) ("Search Error 165.4: " + ex.Message + "\r\n" + MySql));
			}
			
			
		}
		
		public void btnExecuteExpire_Click(System.Object sender, System.EventArgs e)
		{
			string S = "";
			int UnitQty = int.Parse(val[txtExpireUnit.Text]);
			string Unit = cbExpireUnits.Text;
			DateTime CurrDate = DateTime.Now;
			DateTime FutureDate;
			
			if (rbEmails.Checked == true)
			{
				S = S + " SELECT ";
				S = S + " [SentOn] " + "\r\n";
				S = S + " ,[ShortSubj]" + "\r\n";
				S = S + " ,[SenderEmailAddress]" + "\r\n";
				S = S + " ,[SenderName]" + "\r\n";
				S = S + " ,[SentTO]" + "\r\n";
				S = S + " ,[Body] " + "\r\n";
				S = S + " ,[CC] " + "\r\n";
				S = S + " ,[Bcc] " + "\r\n";
				S = S + " ,[CreationTime]" + "\r\n";
				S = S + " ,[AllRecipients]" + "\r\n";
				S = S + " ,[ReceivedByName]" + "\r\n";
				S = S + " ,[ReceivedTime] " + "\r\n";
				S = S + " ,[MsgSize]" + "\r\n";
				S = S + " ,[SUBJECT]" + "\r\n";
				S = S + " ,[OriginalFolder] " + "\r\n";
				S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + "\r\n";
				S = S + " FROM EMAIL " + "\r\n";
			}
			else
			{
				S = "";
				S = S + "Select " + "\r\n";
				S += "\t" + "[SourceName] 	" + "\r\n";
				S += "\t" + ",[CreateDate] " + "\r\n";
				S += "\t" + ",[VersionNbr] 	" + "\r\n";
				S += "\t" + ",[LastAccessDate] " + "\r\n";
				S += "\t" + ",[FileLength] " + "\r\n";
				S += "\t" + ",[LastWriteTime] " + "\r\n";
				S += "\t" + ",[OriginalFileType] 		" + "\r\n";
				S += "\t" + ",[isPublic] " + "\r\n";
				S += "\t" + ",[FQN] " + "\r\n";
				S += "\t" + ",[SourceGuid] " + "\r\n";
				S += "\t" + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + "\r\n";
				S += "FROM DataSource " + "\r\n";
			}
			
			if (Unit.Equals("Months"))
			{
				FutureDate = CurrDate.AddMonths(UnitQty);
			}
			else if (Unit.Equals("Days"))
			{
				FutureDate = CurrDate.AddDays(UnitQty);
			}
			else if (Unit.Equals("Years"))
			{
				FutureDate = CurrDate.AddYears(UnitQty);
			}
			else
			{
				return;
			}
			string WC = " where RetentionExpirationDate <= \'" + (DateTime.Parse(FutureDate.ToString())) + "\'";
			S = S + WC;
			this.PopulateGrid(S);
			
		}
		
		public void btnExecuteAge_Click(System.Object sender, System.EventArgs e)
		{
			
			string S = "";
			
			int UnitQty = int.Parse(val[txtExpireUnit.Text]);
			string Unit = cbExpireUnits.Text;
			DateTime CurrDate = DateTime.Now;
			DateTime PastDate;
			
			if (rbEmails.Checked == true)
			{
				S = S + " SELECT ";
				S = S + " [SentOn] " + "\r\n";
				S = S + " ,[ShortSubj]" + "\r\n";
				S = S + " ,[SenderEmailAddress]" + "\r\n";
				S = S + " ,[SenderName]" + "\r\n";
				S = S + " ,[SentTO]" + "\r\n";
				S = S + " ,[Body] " + "\r\n";
				S = S + " ,[CC] " + "\r\n";
				S = S + " ,[Bcc] " + "\r\n";
				S = S + " ,[CreationTime]" + "\r\n";
				S = S + " ,[AllRecipients]" + "\r\n";
				S = S + " ,[ReceivedByName]" + "\r\n";
				S = S + " ,[ReceivedTime] " + "\r\n";
				S = S + " ,[MsgSize]" + "\r\n";
				S = S + " ,[SUBJECT]" + "\r\n";
				S = S + " ,[OriginalFolder] " + "\r\n";
				S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + "\r\n";
				S = S + " FROM EMAIL " + "\r\n";
			}
			else
			{
				S = "";
				S = S + "Select " + "\r\n";
				S += "\t" + "[SourceName] 	" + "\r\n";
				S += "\t" + ",[CreateDate] " + "\r\n";
				S += "\t" + ",[VersionNbr] 	" + "\r\n";
				S += "\t" + ",[LastAccessDate] " + "\r\n";
				S += "\t" + ",[FileLength] " + "\r\n";
				S += "\t" + ",[LastWriteTime] " + "\r\n";
				S += "\t" + ",[OriginalFileType] 		" + "\r\n";
				S += "\t" + ",[isPublic] " + "\r\n";
				S += "\t" + ",[FQN] " + "\r\n";
				S += "\t" + ",[SourceGuid] " + "\r\n";
				S += "\t" + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + "\r\n";
				S += "FROM DataSource " + "\r\n";
			}
			
			if (Unit.Equals("Months"))
			{
				int TotalDays = System.Convert.ToInt32(30 * UnitQty);
				TimeSpan Days = new TimeSpan(TotalDays, 0, 0, 0);
				PastDate = CurrDate.Subtract(Days);
			}
			else if (Unit.Equals("Days"))
			{
				int TotalDays = System.Convert.ToInt32(1 * UnitQty);
				TimeSpan Days = new TimeSpan(TotalDays, 0, 0, 0);
				PastDate = CurrDate.Subtract(Days);
			}
			else if (Unit.Equals("Years"))
			{
				int TotalDays = System.Convert.ToInt32(365.25 * UnitQty);
				TimeSpan Days = new TimeSpan(TotalDays, 0, 0, 0);
				PastDate = CurrDate.Subtract(Days);
			}
			else
			{
				return;
			}
			string WC = " where CreationDate <= \'" + (DateTime.Parse(PastDate.ToString())) + "\'";
			S = S + WC;
			this.PopulateGrid(S);
		}
		
		public void btnSelectExpired_Click(System.Object sender, System.EventArgs e)
		{
			string S = "";
			int UnitQty = int.Parse(val[txtExpireUnit.Text]);
			string Unit = cbExpireUnits.Text;
			DateTime CurrDate = DateTime.Now;
			DateTime FutureDate = DateTime.Now;
			
			if (rbEmails.Checked == true)
			{
				S = S + " SELECT ";
				S = S + " [SentOn] " + "\r\n";
				S = S + " ,[ShortSubj]" + "\r\n";
				S = S + " ,[SenderEmailAddress]" + "\r\n";
				S = S + " ,[SenderName]" + "\r\n";
				S = S + " ,[SentTO]" + "\r\n";
				S = S + " ,[Body] " + "\r\n";
				S = S + " ,[CC] " + "\r\n";
				S = S + " ,[Bcc] " + "\r\n";
				S = S + " ,[CreationTime]" + "\r\n";
				S = S + " ,[AllRecipients]" + "\r\n";
				S = S + " ,[ReceivedByName]" + "\r\n";
				S = S + " ,[ReceivedTime] " + "\r\n";
				S = S + " ,[MsgSize]" + "\r\n";
				S = S + " ,[SUBJECT]" + "\r\n";
				S = S + " ,[OriginalFolder] " + "\r\n";
				S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + "\r\n";
				S = S + " FROM EMAIL " + "\r\n";
			}
			else
			{
				S = "";
				S = S + "Select " + "\r\n";
				S += "\t" + "[SourceName] 	" + "\r\n";
				S += "\t" + ",[CreateDate] " + "\r\n";
				S += "\t" + ",[VersionNbr] 	" + "\r\n";
				S += "\t" + ",[LastAccessDate] " + "\r\n";
				S += "\t" + ",[FileLength] " + "\r\n";
				S += "\t" + ",[LastWriteTime] " + "\r\n";
				S += "\t" + ",[OriginalFileType] 		" + "\r\n";
				S += "\t" + ",[isPublic] " + "\r\n";
				S += "\t" + ",[FQN] " + "\r\n";
				S += "\t" + ",[SourceGuid] " + "\r\n";
				S += "\t" + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + "\r\n";
				S += "FROM DataSource " + "\r\n";
			}
			
			string WC = " where RetentionExpirationDate <= \'" + (DateTime.Parse(DateTime.Now.ToString())) + "\'";
			S = S + WC;
			this.PopulateGrid(S);
		}
		
		public void btnDelete_Click(System.Object sender, System.EventArgs e)
		{
			string msg = "This will delete the selected items, are you sure, really sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "UNDOABLE DELETE of Content", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			PB.Value = 0;
			PB.Maximum = dgItems.SelectedRows.Count + 1;
			int II = 0;
			
			int SuccessfulDelete = 0;
			int FailedDelete = 0;
			
			ArrayList uidList = new ArrayList();
			
			string CurrGuid = "";
			string S = "";
			bool B = false;
			foreach (DataRow DR in dgItems.SelectedRows)
			{
				II++;
				PB.Value = II;
				PB.Refresh();
				System.Windows.Forms.Application.DoEvents();
				if (rbEmails.Checked == true)
				{
					CurrGuid = DR["EmailGuid"].ToString();
					uidList.Add(CurrGuid);
				}
				else
				{
					CurrGuid = DR["SourceGuid"].ToString();
					uidList.Add(CurrGuid);
				}
			}
			
			for (int i = 0; i <= uidList.Count - 1; i++)
			{
				if (rbEmails.Checked == true)
				{
					CurrGuid = uidList[i].ToString();
					S = "delete from emailattachment where EmailGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					
					S = "delete from Recipients where EmailGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					
					S = "delete from email  where EmailGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					if (B)
					{
						SuccessfulDelete++;
					}
					else
					{
						FailedDelete++;
					}
				}
				else
				{
					
					CurrGuid = uidList[i].ToString();
					S = "DELETE from SourceAttribute where SourceGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					
					S = "DELETE from DataSource where SourceGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					if (B)
					{
						SuccessfulDelete++;
					}
					else
					{
						FailedDelete++;
					}
				}
			}
			PB.Value = 0;
			SB.Text = (string) ("Deleted = " + SuccessfulDelete.ToString() + " - Failed to delete = " + FailedDelete.ToString());
		}
		
		public void btnMove_Click(System.Object sender, System.EventArgs e)
		{
			MessageBox.Show("This item is in a future release...");
		}
		
		public void btnExtend_Click(System.Object sender, System.EventArgs e)
		{
			int SuccessfulDelete = 0;
			int FailedDelete = 0;
			
			ArrayList uidList = new ArrayList();
			
			string CurrGuid = "";
			string S = "";
			bool B = false;
			DateTime NewDate = DateTime.Parse(dtExtendDate.Value.ToLongDateString());
			int iSelected = dgItems.SelectedRows.Count;
			if (iSelected == 0)
			{
				MessageBox.Show("One or more items must be selected to extend, returning.");
				return;
			}
			foreach (DataGridViewRow DR in dgItems.SelectedRows)
			{
				if (rbEmails.Checked == true)
				{
					CurrGuid = DR.Cells["EmailGuid"].Value.ToString();
					uidList.Add(CurrGuid);
				}
				else
				{
					CurrGuid = DR.Cells["SourceGuid"].Value.ToString();
					uidList.Add(CurrGuid);
				}
			}
			
			for (int i = 0; i <= uidList.Count - 1; i++)
			{
				if (rbEmails.Checked == true)
				{
					CurrGuid = uidList[i].ToString();
					S = "update email set  RetentionExpirationDate = \'" + NewDate.ToString() + "\' where EmailGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					if (B)
					{
						SuccessfulDelete++;
					}
					else
					{
						FailedDelete++;
					}
				}
				else
				{
					CurrGuid = uidList[i].ToString();
					S = "update DataSource set  RetentionExpirationDate = \'" + NewDate.ToString() + "\' where SourceGuid = \'" + CurrGuid + "\'";
					B = DB.ExecuteSqlNewConn(S, false);
					if (B)
					{
						SuccessfulDelete++;
					}
					else
					{
						FailedDelete++;
					}
				}
			}
			SB.Text = (string) ("Updated = " + SuccessfulDelete.ToString() + " - Failed to update = " + FailedDelete.ToString());
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
			//System.Windows.Forms.Application.DoEvents()
		}
		
		public void btnRecall_Click(System.Object sender, System.EventArgs e)
		{
			string S = "";
			
			int UnitQty = int.Parse(val[txtExpireUnit.Text]);
			string Unit = cbExpireUnits.Text;
			DateTime CurrDate = DateTime.Now;
			DateTime PastDate;
			
			string WC = "";
			
			if (rbEmails.Checked == true)
			{
				S = S + " SELECT ";
				S = S + " [SentOn] " + "\r\n";
				S = S + " ,[ShortSubj]" + "\r\n";
				S = S + " ,[SenderEmailAddress]" + "\r\n";
				S = S + " ,[SenderName]" + "\r\n";
				S = S + " ,[SentTO]" + "\r\n";
				S = S + " ,[Body] " + "\r\n";
				S = S + " ,[CC] " + "\r\n";
				S = S + " ,[Bcc] " + "\r\n";
				S = S + " ,[CreationTime]" + "\r\n";
				S = S + " ,[AllRecipients]" + "\r\n";
				S = S + " ,[ReceivedByName]" + "\r\n";
				S = S + " ,[ReceivedTime] " + "\r\n";
				S = S + " ,[MsgSize]" + "\r\n";
				S = S + " ,[SUBJECT]" + "\r\n";
				S = S + " ,[OriginalFolder] " + "\r\n";
				S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + "\r\n";
				S = S + " FROM EMAIL " + "\r\n";
				
				WC = " where EmailGuid in (select [ContentGuid] from [RetentionTemp] where [TypeContent] = \'EMAIL\' and [UserID] = \'" + modGlobals.gCurrUserGuidID + "\')";
				
			}
			else
			{
				S = "";
				S = S + "Select " + "\r\n";
				S += "\t" + "[SourceName] 	" + "\r\n";
				S += "\t" + ",[CreateDate] " + "\r\n";
				S += "\t" + ",[VersionNbr] 	" + "\r\n";
				S += "\t" + ",[LastAccessDate] " + "\r\n";
				S += "\t" + ",[FileLength] " + "\r\n";
				S += "\t" + ",[LastWriteTime] " + "\r\n";
				S += "\t" + ",[OriginalFileType] 		" + "\r\n";
				S += "\t" + ",[isPublic] " + "\r\n";
				S += "\t" + ",[FQN] " + "\r\n";
				S += "\t" + ",[SourceGuid] " + "\r\n";
				S += "\t" + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + "\r\n";
				S += "FROM DataSource " + "\r\n";
				
				WC = " where SourceGuid in (select [ContentGuid] from [RetentionTemp] where [TypeContent] = \'CONTENT\' and [UserID] = \'" + modGlobals.gCurrUserGuidID + "\')";
				
			}
			
			
			S = S + WC;
			this.PopulateGrid(S);
		}
		
		public void rbContent_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (rbContent.Checked)
			{
				int iCnt = DB.RetentionTempCountType("CONTENT", modGlobals.gCurrUserGuidID);
				if (iCnt > 0)
				{
					btnRecall.Enabled = true;
					//btnRecall.Visible = True
					btnRecall.Text = "Load Marked CONTENT Retention Items";
				}
				else
				{
					btnRecall.Enabled = false;
					//btnRecall.Visible = True
					btnRecall.Text = "Load Marked CONTENT Retention Items";
				}
			}
		}
		
		public void rbEmails_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (rbEmails.Checked)
			{
				int iCnt = DB.RetentionTempCountType("EMAIL", modGlobals.gCurrUserGuidID);
				if (iCnt > 0)
				{
					btnRecall.Enabled = true;
					//btnRecall.Visible = True
					btnRecall.Text = "Load Marked EMAIL Retention Items";
				}
				else
				{
					btnRecall.Enabled = false;
					//btnRecall.Visible = True
					btnRecall.Text = "Load Marked EMAIL Retention Items";
				}
			}
		}
		
		public void frmRetentionMgt_Resize(object sender, System.EventArgs e)
		{
			
			if (FormLoaded == false)
			{
				return;
			}
			modResizeForm.ResizeControls(this);
			
		}
	}
	
}
