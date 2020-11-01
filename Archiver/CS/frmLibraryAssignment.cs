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
	public partial class frmLibraryAssignment
	{
		public frmLibraryAssignment()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmLibraryAssignment defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmLibraryAssignment Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmLibraryAssignment();
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
		
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		bool isEmail = false;
		string tgtLibName = "";
		string FolderID = "";
		clsLIBEMAIL EmailLib = new clsLIBEMAIL();
		clsLIBDIRECTORY ContentLib = new clsLIBDIRECTORY();
		public string FolderName = "";
		
		bool bHelpLoaded = false;
		bool formloaded = false;
		
		public void frmLibraryAssignment_Load(System.Object sender, System.EventArgs e)
		{
			
			formloaded = false;
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
			//Dim bGetScreenObjects As Boolean = True
			//If bGetScreenObjects Then DMA.getFormWidgets(Me)
			
			PopulateLibraryCombo();
			if (FolderID.Length > 0)
			{
				FolderName = DB.getFolderNameById(FolderID);
			}
			
			PopulateAssignedLibraryCombo();
			
			formloaded = true;
			
		}
		public void setLibraryName(string LibName)
		{
			tgtLibName = LibName;
			this.cbLibrary.Text = tgtLibName;
		}
		public void setFolderID(string MailFolderID)
		{
			FolderID = MailFolderID;
		}
		public void setFolderName(string tFolderName)
		{
			txtFolderName.Text = tFolderName.Trim;
			FolderName = tFolderName.Trim;
		}
		public void PopulateLibraryCombo()
		{
			
			try
			{
				string S = "";
				
				S = S + " SELECT [LibraryName]";
				S = S + " FROM  [Library]";
				S = S + " where userid = \'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " order by [LibraryName]";
				
				DB.PopulateComboBox(this.cbLibrary, "LibraryName", S);
				
			}
			catch (Exception)
			{
				SB.Text = "Failed to load Libraries.";
			}
			
		}
		
		public void PopulateAssignedLibraryCombo()
		{
			string S = "";
			var FolderName = txtFolderName.Text.Trim();
			
			this.cbAssignedLibs.Items.Clear();
			cbAssignedLibs.Text = "";
			
			if (isEmail)
			{
				S = S + " SELECT  [LibraryName]";
				S = S + " FROM  [LibEmail]";
				S = S + " where [FolderName] = \'" + FolderName + "\'";
				DB.PopulateComboBox(this.cbAssignedLibs, "LibraryName", S);
			}
			else
			{
				S = S + " SELECT  [LibraryName]";
				S = S + " FROM  [LibDirectory]";
				S = S + " where [DirectoryName] = \'" + FolderName + "\'";
				DB.PopulateComboBox(this.cbAssignedLibs, "LibraryName", S);
			}
			
		}
		public void SetTypeContent(bool isDocument)
		{
			if (isDocument == true)
			{
				isEmail = false;
			}
			else
			{
				isEmail = true;
			}
		}
		
		public void btnAssign_Click(System.Object sender, System.EventArgs e)
		{
			
			string LibToAdd = this.cbLibrary.Text;
			FolderName = txtFolderName.Text.Trim();
			int RecordsAdded = 0;
			
			if (isEmail)
			{
				string FolderID = DB.getFolderIdByName(FolderName, modGlobals.gCurrUserGuidID);
				if (FolderID.Length == 0)
				{
					MessageBox.Show("Could not find Mailbox " + FolderName + " as an archived folder, skipping.");
					return;
				}
				EmailLib.setEmailfolderentryid(ref FolderID);
				EmailLib.setLibraryname(ref LibToAdd);
				EmailLib.setUserid(ref modGlobals.gCurrUserGuidID);
				EmailLib.setFoldername(ref FolderName);
				//***************************************
				bool b = EmailLib.Insert();
				//***************************************
				if (b)
				{
					PopulateAssignedLibraryCombo();
					DB.AddLibraryEmail(FolderName, LibToAdd, modGlobals.gCurrUserGuidID, RecordsAdded);
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "User \'" + LID + "\' assigned EMAIL Folder \'" + this.txtFolderName.Text.Trim() + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
					MessageBox.Show("Added email folder to library...");
				}
				else
				{
					MessageBox.Show("ERROR: DID NOT Add email folder to library...");
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "ERROR: 3302.1.y - User \'" + LID + "\' failed to assign EMAIL Folder \'" + this.txtFolderName.Text.Trim() + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
				}
			}
			else
			{
				ContentLib.setDirectoryname(this.txtFolderName.Text.Trim());
				ContentLib.setLibraryname(ref LibToAdd);
				ContentLib.setUserid(ref modGlobals.gCurrUserGuidID);
				//*******************************************
				bool b = ContentLib.Insert();
				//*******************************************
				
				bool bProcessSubDirs = DB.isSubDirProcessed(modGlobals.gCurrUserGuidID, this.txtFolderName.Text.Trim());
				
				if (b)
				{
					PopulateAssignedLibraryCombo();
					DB.AddLibraryDirectory(this.txtFolderName.Text.Trim(), LibToAdd, modGlobals.gCurrUserGuidID, ref RecordsAdded, bProcessSubDirs);
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "User \'" + LID + "\' assigned directory \'" + this.txtFolderName.Text.Trim() + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
				}
				else
				{
					MessageBox.Show("ERROR: DID NOT Add content folder to library...");
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "ERROR: 3302.1.x - User \'" + LID + "\' failed to assign directory \'" + this.txtFolderName.Text.Trim() + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
					LOG.WriteToArchiveLog(tMsg);
					DB.AddSysMsg(tMsg);
				}
			}
			
			string LibName = LibToAdd;
			LibName = UTIL.RemoveSingleQuotes(LibName);
			string S = "Select count(*) from LibraryItems where LibraryName like \'" + LibName + "\' ";
			int iCnt = DB.iCount(S);
			
			SB.Text = (string) ("Records in library: " + iCnt.ToString());
		}
		
		public void btnRemove_Click(System.Object sender, System.EventArgs e)
		{
			this.Cursor = Cursors.AppStarting;
			string LibToRemove = this.cbAssignedLibs.Text.Trim();
			
			LibToRemove = UTIL.RemoveSingleQuotes(LibToRemove);
			
			if (isEmail)
			{
				FolderName = UTIL.RemoveSingleQuotes(FolderName);
				//Dim FolderName As String = Me.txtFolderName.Text.Trim
				FolderID = DB.getFolderIdByName(FolderName, modGlobals.gCurrUserGuidID);
				string wc = EmailLib.wc_PK99(FolderName, this.cbAssignedLibs.Text, modGlobals.gCurrUserGuidID);
				bool b = EmailLib.Delete(wc);
				
				int II = EmailLib.cnt_PI01_LibEmail(FolderName, LibToRemove);
				
				//Dim Mysql As String = ""
				//Mysql = "delete from LibEmail where LibraryName = '" + LibToRemove  + "'"
				//b = DB.ExecuteSqlNewConn(Mysql)
				
				//Mysql = "delete from LibraryItems where LibraryName = '" + LibToRemove  + "'"
				//b = DB.ExecuteSqlNewConn(Mysql)
				
				if (b)
				{
					MessageBox.Show("Removed email folder from library... applying changes across the repository, this can take a long while.");
					DB.RemoveLibraryEmails(this.txtFolderName.Text.Trim(), LibToRemove, modGlobals.gCurrUserGuidID);
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "Notice: 3302.2.y - User \'" + LID + "\' removed EMAIL Folder \'" + this.txtFolderName.Text.Trim() + "\' from library \'" + LibToRemove + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
					PopulateAssignedLibraryCombo();
				}
				else
				{
					MessageBox.Show("ERROR: DID NOT Remove email folder to library...");
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "Notice: 3302.2.x - User \'" + LID + "\' FAILED to assign EMAIL Folder \'" + this.txtFolderName.Text.Trim() + "\' to library \'" + LibToRemove + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
				}
			}
			else
			{
				string wc = ContentLib.wc_PK98(this.txtFolderName.Text.Trim(), LibToRemove, modGlobals.gCurrUserGuidID);
				bool b = ContentLib.Delete(wc);
				
				//Dim Mysql As String = ""
				//Mysql = "delete from LibraryItems where LibraryName = '" + LibToRemove  + "'"
				//b = DB.ExecuteSqlNewConn(Mysql)
				
				//Mysql = "delete from LibDirectory where LibraryName = '" + LibToRemove  + "'"
				//b = DB.ExecuteSqlNewConn(Mysql)
				
				if (b)
				{
					MessageBox.Show("Removed content folder from library... applying changes across the repository, this can take a long while.");
					DB.RemoveLibraryDirectories(this.txtFolderName.Text.Trim(), LibToRemove);
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "Notice: 3303.2.y - User \'" + LID + "\' assigned Content Folder \'" + this.txtFolderName.Text.Trim() + "\' from library \'" + LibToRemove + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
					PopulateAssignedLibraryCombo();
				}
				else
				{
					MessageBox.Show("ERROR: DID NOT Remove ontent folder to library...");
					string LID = DB.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
					string tMsg = "Notice: 3303.2.y - User \'" + LID + "\' FAILED to remove Content Folder \'" + this.txtFolderName.Text.Trim() + "\' from library \'" + LibToRemove + "\' on " + DateTime.Now.ToString() + ".";
					DB.AddSysMsg(tMsg);
					LOG.WriteToArchiveLog(tMsg);
				}
			}
			
			DB.cleanUpLibraryItems();
			this.Cursor = Cursors.Default;
			
		}
		
		public void frmLibraryAssignment_Resize(object sender, System.EventArgs e)
		{
			
			if (formloaded == false)
			{
				return;
			}
			modResizeForm.ResizeControls(this);
			
		}
	}
	
}
