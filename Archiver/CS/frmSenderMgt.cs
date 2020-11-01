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



namespace EcmArchiveClcSetup
{
	public partial class frmSenderMgt
	{
		public frmSenderMgt()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmSenderMgt defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmSenderMgt Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmSenderMgt();
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
		clsArchiver ARCH = new clsArchiver();
		string UserID = "";
		string MySql = "";
		clsDma DMA = new clsDma();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsDatabase DB = new clsDatabase();
		DataSet ds = new DataSet();
		SqlConnection cn = new SqlConnection();
		clsEXCLUDEFROM EF = new clsEXCLUDEFROM();
		bool bHelpLoaded = false;
		bool Formloaded = false;
		public void frmSenderMgt_Load(System.Object sender, System.EventArgs e)
		{
			Formloaded = false;
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
			
			//'TODO: This line of code loads data into the '_DMA_UDDataSet3.ArchiveFrom' table. You can move, or remove it, as needed.
			//Me.ArchiveFromTableAdapter.Fill(Me._DMA_UDDataSet3.ArchiveFrom)
			//'TODO: This line of code loads data into the '_DMA_UDDataSet.ExcludeFrom' table. You can move, or remove it, as needed.
			//Me.ExcludeFromTableAdapter.Fill(Me._DMA_UDDataSet.ExcludeFrom)
			//MySql  = ""
			//MySql  = MySql  + " SELECT [FromEmailAddr] "
			//MySql  = MySql  + " ,[SenderName] "
			//MySql  = MySql  + " ,[UserID] "
			//MySql  = MySql  + " FROM  [ExcludeFrom] "
			//MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
			//MySql  = MySql  + " order by  "
			//MySql  = MySql  + " FromEmailAddr "
			//MySql  = MySql  + " ,[SenderName] "
			//MySql  = MySql  + " ,[UserID] "
			
			//Dim qConnStr  = DB.getConnStr
			
			//cn.ConnectionString = qConnStr
			//cn.Open()
			
			//Dim dscmd As New SqlDataAdapter(MySql, cn)
			
			//dscmd.Fill(ds, "Senders")
			//dgExcludedSenders.DataSource = ds.DefaultViewManager
			
			ARCH.getOutlookParentFolderNames(this.cbOutlookFOlder);
			
			TT.SetToolTip(btnRemoveExcluded, "Press this button to remove the selected address from the \'exclude list\'.");
			TT.Active = true;
			
			ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders);
			Formloaded = true;
		}
		
		public void btnRemoveExcluded_Click(System.Object sender, System.EventArgs e)
		{
			int II = 0;
			for (II = 0; II <= dgExcludedSenders.RowCount - 1; II++)
			{
				
				if (dgExcludedSenders.Rows[II].Selected)
				{
					
					string SenderEmailAddress = dgExcludedSenders[0, II].Value.ToString();
					string SenderName = dgExcludedSenders[1, II].Value.ToString();
					string UID = dgExcludedSenders[2, II].Value.ToString();
					
					SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress);
					SenderName = UTIL.RemoveSingleQuotes(SenderName);
					UID = UTIL.RemoveSingleQuotes(UID);
					
					string S = "Select count(*) ";
					S = S + " FROM  [ExcludeFrom]";
					S = S + " where [FromEmailAddr] = \'" + SenderEmailAddress + "\'";
					S = S + " and [SenderName] = \'" + SenderName + "\'";
					S = S + " and [UserID] = \'" + UID + "\'";
					int K = DB.iDataExist(S);
					if (K == 1)
					{
						S = "delete ";
						S = S + " FROM  [ExcludeFrom]";
						S = S + " where [FromEmailAddr] = \'" + SenderEmailAddress + "\'";
						S = S + " and [SenderName] = \'" + SenderName + "\'";
						S = S + " and [UserID] = \'" + UID + "\'";
						bool BB = DB.ExecuteSqlNewConn(S, false);
						if (! BB)
						{
							MessageBox.Show((string) ("Error 243.1: Delete failed - " + "\r\n" + S));
						}
					}
				}
			}
			ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders);
			DB.getExcludedEmails(modGlobals.gCurrUserGuidID);
		}
		private void btnRemoveIncluded_Click(System.Object sender, System.EventArgs e)
		{
			
		}
		private void btnInclSender_Click(System.Object sender, System.EventArgs e)
		{
			
		}
		public void btnExclSender_Click(System.Object sender, System.EventArgs e)
		{
			int II = 0;
			for (II = 0; II <= dgEmailSenders.RowCount - 1; II++)
			{
				if (dgEmailSenders.Rows[II].Selected)
				{
					
					string SenderEmailAddress = dgEmailSenders[0, II].Value.ToString();
					string SenderName = dgEmailSenders[1, II].Value.ToString();
					string UID = dgEmailSenders[2, II].Value.ToString();
					
					SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress);
					SenderName = UTIL.RemoveSingleQuotes(SenderName);
					UID = UTIL.RemoveSingleQuotes(UID);
					
					string S = "Select count(*)";
					S = S + " FROM  [ExcludeFrom]";
					S = S + " where [FromEmailAddr] = \'" + SenderEmailAddress + "\'";
					S = S + " and [SenderName] = \'" + SenderName + "\'";
					S = S + " and [UserID] = \'" + UID + "\'";
					int K = DB.iDataExist(S);
					if (K == 0)
					{
						EF.setFromemailaddr(ref SenderEmailAddress);
						EF.setSendername(ref SenderName);
						EF.setUserid(ref UID);
						
						bool BB = EF.Insert();
						if (! BB)
						{
							MessageBox.Show((string) ("Error 243.1: Insert failed - " + "\r\n" + S));
						}
					}
				}
			}
			ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders);
			DB.getExcludedEmails(modGlobals.gCurrUserGuidID);
		}
		public void rbArchive_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (rbArchive.Checked == true)
			{
				string S = "";
				S = "Select distinct [SenderEmailAddress]";
				S = S + " ,[SenderName]      ";
				S = S + " FROM [Email]";
				S = S + " order by [SenderEmailAddress]";
				S = S + " ,[SenderName]      ";
				
				ARCH.PopulateContactGrid(dgEmailSenders, S);
				
			}
		}
		
		public void rbContacts_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			if (rbContacts.Checked == true)
			{
				//MySql  = ""
				//MySql  = MySql  + " SELECT [FromEmailAddr] "
				//MySql  = MySql  + " ,[SenderName] "
				//MySql  = MySql  + " ,[UserID] "
				//MySql  = MySql  + " FROM  [ContactFrom] "
				//MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
				//MySql  = MySql  + " order by  "
				//MySql  = MySql  + " FromEmailAddr "
				//MySql  = MySql  + " ,[SenderName] "
				//MySql  = MySql  + " ,[UserID] "
				
				string S = "";
				S = S + " SELECT FromEmailAddr ,[SenderName]   ";
				S = S + " FROM  [ContactFrom]  ";
				S = S + " order by FromEmailAddr ,[SenderName]  ";
				
				ARCH.PopulateContactGrid(dgEmailSenders, S);
			}
		}
		
		private void ExcludeFromBindingSource_CurrentChanged(System.Object sender, System.EventArgs e)
		{
			
		}
		
		public void rbInbox_CheckedChanged(System.Object sender, System.EventArgs e)
		{
			
			if (rbInbox.Checked)
			{
				//MySql  = ""
				//MySql  = MySql  + " SELECT [FromEmailAddr] "
				//MySql  = MySql  + " ,[SenderName] "
				//MySql  = MySql  + " ,[UserID] "
				//MySql  = MySql  + " FROM  [OutlookFrom] "
				//MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
				//MySql  = MySql  + " order by  "
				//MySql  = MySql  + " FromEmailAddr "
				//MySql  = MySql  + " ,[SenderName] "
				//MySql  = MySql  + " ,[UserID] "
				
				string S = "";
				S = "Select FromEmailAddr ,[SenderName]";
				S = S + " FROM  [OutlookFrom]  ";
				S = S + " order by FromEmailAddr ,[SenderName]";
				
				ARCH.PopulateContactGrid(dgEmailSenders, S);
			}
			
		}
		
		public void btnRefresh_Click(System.Object sender, System.EventArgs e)
		{
			
			string ContainerName = cbOutlookFOlder.Text;
			
			if (rbInbox.Checked)
			{
				
				if (cbOutlookFOlder.Text.Trim().Length == 0)
				{
					MessageBox.Show("Please select an OUTLOOK mailbox first.");
					return;
				}
				
				SortedList SL = new SortedList();
				string TopFolder = cbOutlookFOlder.Text;
				
				ListBox LB = new ListBox();
				
				string SenderFrom = "";
				string SenderName = "";
				int k = 0;
				
				MySql = MySql + " Update  [OutlookFrom]";
				MySql = MySql + " set [Verified] = 0 ";
				MySql = MySql + " where ";
				MySql = MySql + " UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				bool bSuccess = DB.ExecuteSqlNewConn(MySql, false);
				if (! bSuccess)
				{
					Debug.Print((string) ("Update failed:" + "\r\n" + MySql));
				}
				ARCH.ProcessOutlookFolderNames(ContainerName, TopFolder, ref LB);
				//ARCH.GetActiveEmailSenders(gCurrUserGuidID, MailboxName )
				//ARCH.PopulateContactGridOutlookFromTbl(dgEmailSenders)
				
			}
			
			if (rbArchive.Checked == true)
			{
				string S = "";
				S = "Select distinct [SenderEmailAddress]";
				S = S + " ,[SenderName]      ";
				S = S + " FROM [Email]";
				S = S + " order by [SenderEmailAddress]";
				S = S + " ,[SenderName]      ";
				
				ARCH.PopulateContactGrid(dgEmailSenders, S);
			}
			
			if (rbContacts.Checked == true)
			{
				MySql = MySql + " Update  [ContactFrom]";
				MySql = MySql + " set [Verified] = 0 ";
				MySql = MySql + " where ";
				MySql = MySql + " UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				bool bSuccess = DB.ExecuteSqlNewConn(MySql, false);
				if (! bSuccess)
				{
					Debug.Print((string) ("Update failed:" + "\r\n" + MySql));
				}
				
				ARCH.RetrieveContactEmailInfo(dgEmailSenders, modGlobals.gCurrUserGuidID);
				ARCH.PopulateContactGridContactFromTbl(dgEmailSenders);
				//ARCH.GetActiveEmailSenders(gCurrUserGuidID, "Personal Folders")
			}
			DB.getExcludedEmails(modGlobals.gCurrUserGuidID);
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
		
		public void frmSenderMgt_Resize(object sender, System.EventArgs e)
		{
			
			if (Formloaded == false)
			{
				return;
			}
			modResizeForm.ResizeControls(this);
			
		}
	}
	
}
