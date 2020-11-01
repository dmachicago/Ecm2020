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

using System.IO;


namespace EcmArchiveClcSetup
{
	public partial class frmPstLoader
	{
		public frmPstLoader()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmPstLoader defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmPstLoader Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmPstLoader();
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
		
		clsLogging LOG = new clsLogging();
		clsPst PST = new clsPst();
		clsDbLocal DBLocal = new clsDbLocal();
		
		bool ArchiveEmails = false;
		
		public string UID = "";
		public static int CurrIdNbr = 1000000;
		public static ProcessFolders[] FoldersToProcess;
		
		//Sub New(ByVal UserGuidID As String)
		//    UID = UserGuidID
		//End Sub
		
		public struct ProcessFolders
		{
			public Microsoft.Office.Interop.Outlook.MAPIFolder oFolder;
			public int iKey;
		}
		
		public void btnSelectFile_Click(System.Object sender, System.EventArgs e)
		{
			SB.Visible = false;
			lbMsg.Visible = false;
			btnLoad.Visible = false;
			Label2.Visible = false;
			txtFoldersProcessed.Visible = false;
			Label3.Visible = false;
			txtEmailsProcessed.Visible = false;
			btnArchive.Visible = false;
			Label4.Visible = false;
			cbRetention.Visible = false;
			
			OpenFileDialog1.ShowDialog();
			txtPstFqn.Text = OpenFileDialog1.FileName;
		}
		
		public void btnLoad_Click(System.Object sender, System.EventArgs e)
		{
			try
			{
				lbMsg.Visible = true;
				btnLoad.Visible = true;
				Label2.Visible = false;
				txtFoldersProcessed.Visible = false;
				Label3.Visible = false;
				txtEmailsProcessed.Visible = false;
				btnArchive.Visible = true;
				Label4.Visible = true;
				cbRetention.Visible = true;
				
				ArchiveEmails = false;
				string pName = "Test";
				string PstFQN = txtPstFqn.Text.Trim();
				File F;
				if (! F.Exists(PstFQN))
				{
					MessageBox.Show("Cannot find file \'" + PstFQN + "\', aborting load.");
					return;
				}
				
				PST.PstStats(ref this.lbMsg, PstFQN, pName, ArchiveEmails);
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error: PST Load error - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("Error: PST Load error - " + ex.Message));
			}
			
		}
		
		public void btnArchive_Click(System.Object sender, System.EventArgs e)
		{
			if (cbLibrary.Text.Trim().Length == 0)
			{
				MessageBox.Show("In order to ARCHIVE a PST file, a library must be selected, returning.");
				return;
			}
			if (cbRetention.Text.Trim().Length == 0)
			{
				MessageBox.Show("Please select a retention period, returning.");
				return;
			}
			
			lbMsg.Visible = true;
			btnLoad.Visible = true;
			Label2.Visible = true;
			txtFoldersProcessed.Visible = true;
			Label3.Visible = true;
			txtEmailsProcessed.Visible = true;
			btnArchive.Visible = true;
			
			string PstFQN = this.txtPstFqn.Text.Trim();
			string RetentionCode;
			
			if (lbMsg.SelectedItems.Count == 0)
			{
				MessageBox.Show("Cannot process without FOLDERS being selected, returning.");
				return;
			}
			if (PstFQN.Length == 0)
			{
				MessageBox.Show("Cannot process without a PST file being selected, returning.");
				return;
			}
			
			string rCode = cbRetention.Text.Trim();
			//***************************************************************
			bool bUseQuickSearch = false;
			clsDatabase DB = new clsDatabase();
			int NbrOfIds = DB.getCountStoreIdByFolder();
			SortedList slStoreId = new SortedList();
			if (NbrOfIds <= 5000000)
			{
				bUseQuickSearch = true;
			}
			else
			{
				bUseQuickSearch = false;
			}
			if (bUseQuickSearch)
			{
				DBLocal.getCE_EmailIdentifiers(slStoreId);
			}
			else
			{
				slStoreId.Clear();
			}
			//***************************************************************
			PST.ArchiveSelectedFolders(UID, this.lbMsg, PstFQN, rCode, cbLibrary.Text, slStoreId);
			
			frmMain.Default.SB.Text = "Done";
			SB.Text = "Done";
			
		}
		
		public void frmPstLoader_Deactivate(object sender, System.EventArgs e)
		{
			//PST.RemoveStores()
		}
		
		public void frmPstLoader_Disposed(object sender, System.EventArgs e)
		{
			PST.RemoveStores();
		}
		
		public void frmPstLoader_Load(System.Object sender, System.EventArgs e)
		{
			lbMsg.Visible = false;
			btnLoad.Visible = false;
			Label2.Visible = false;
			txtFoldersProcessed.Visible = false;
			Label3.Visible = false;
			txtEmailsProcessed.Visible = false;
			btnArchive.Visible = false;
			Label4.Visible = false;
			cbRetention.Visible = false;
			
			clsArchiver ARCH = new clsArchiver();
			ARCH.LoadRetentionCodes(cbRetention);
			ARCH = null;
			
			if (cbRetention.Items.Count > 0)
			{
				cbRetention.Text = cbRetention.Items[0];
			}
			PopulateLibrary();
		}
		
		public void txtPstFqn_TextChanged(System.Object sender, System.EventArgs e)
		{
			lbMsg.Visible = false;
			btnLoad.Visible = true;
			Label2.Visible = false;
			txtFoldersProcessed.Visible = false;
			Label3.Visible = false;
			txtEmailsProcessed.Visible = false;
			btnArchive.Visible = false;
			SB.Visible = true;
		}
		public void PopulateLibrary()
		{
			clsDatabase DB = new clsDatabase();
			this.Cursor = Cursors.WaitCursor;
			DB.PopulateGroupUserLibCombo(this.cbLibrary);
			this.Cursor = Cursors.Default;
			DB = null;
		}
		
		public void btnRemove_Click(System.Object sender, System.EventArgs e)
		{
			PST.RemoveStores();
		}
	}
	
}
