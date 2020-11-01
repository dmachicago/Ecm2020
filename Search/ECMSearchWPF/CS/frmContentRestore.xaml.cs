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


namespace ECMSearchWPF
{
	public partial class frmContentRestore
	{
		
		bool UseISO = false;
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim GVAR As App = App.Current
		string UserID = "";
		
		public bool bDoNotOverwriteExistingFile = true;
		public bool bOverwriteExistingFile = false;
		public bool bRestoreToOriginalDirectory = false;
		public bool bRestoreToMyDocuments = true;
		public bool bCreateOriginalDirIfMissing = true;
		
		string pRepoTableName = "";
		DataGrid dgEmails;
		DataGrid dgEmailAttachment;
		DataGrid dgContent;
		
		public frmContentRestore(string RepoTableName, DataGrid gEmails, DataGrid gEmailAttachment, DataGrid gContent)
		{
			//InitializeComponent()
			
			//EP.setSearchSvcEndPoint(proxy)
			
			UserID = GLOBALS._UserID;
			modGlobals.gCurrUserGuidID = GLOBALS._UserGuid;
			COMMON.SaveClick(3300, UserID);
			
			pRepoTableName = RepoTableName;
			dgEmails = gEmails;
			dgEmailAttachment = gEmailAttachment;
			dgContent = gContent;
			
			getRestoreStats();
			
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = true;
			SaveRestoreFiles();
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = false;
			
		}
		
		private void rbToOriginalDir_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bRestoreToOriginalDirectory = true;
			bRestoreToMyDocuments = false;
		}
		
		public void rbToSelDir_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bRestoreToOriginalDirectory = false;
			bRestoreToMyDocuments = true;
			ckCreateMissing.IsChecked = false;
		}
		
		private void rbToSelDir_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bRestoreToOriginalDirectory = true;
			bRestoreToMyDocuments = false;
		}
		
		private void rbToOriginalDir_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bRestoreToOriginalDirectory = false;
			bRestoreToMyDocuments = true;
		}
		
		public void rbToSelDir_Unchecked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bRestoreToOriginalDirectory = false;
			bRestoreToMyDocuments = true;
		}
		
		public void ckOverWrite_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bDoNotOverwriteExistingFile = false;
		}
		
		public void ckOverWrite_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bDoNotOverwriteExistingFile = true;
		}
		public void SaveRestoreFiles()
		{
			
			string CurrentGuid = "";
			clsIsolatedStorage ISO = new clsIsolatedStorage();
			
			List<string> L = new List<string>();
			
			
			string FQN = "NA";
			int iCnt = 0;
			if (pRepoTableName.ToUpper().Equals("EMAILATTACHMENT"))
			{
				iCnt = dgEmailAttachment.SelectedItems.Count;
				//For Each O As Object In dgEmails.SelectedItems
				//    iCnt += 1
				//Next
			}
			if (pRepoTableName.ToUpper().Equals("EMAIL"))
			{
				iCnt = dgEmails.SelectedItems.Count;
				//For Each O As Object In dgEmails.SelectedItems
				//    iCnt += 1
				//Next
			}
			if (pRepoTableName.ToUpper().Equals("DATASOURCE"))
			{
				iCnt = dgContent.SelectedItems.Count;
				//For Each O As Object In dgContent.SelectedItems
				//    iCnt += 1
				//Next
			}
			if (iCnt == 0)
			{
				MessageBox.Show("To perform a restore, one or more rows must be selected, returning.");
				return;
			}
			iCnt = 0;
			string S = "";
			if (pRepoTableName.Equals("Email"))
			{
				
				foreach (DataGridRow R in dgEmails.SelectedItems)
				{
					iCnt++;
					//CurrentGuid = R("EmailGuid")
					CurrentGuid = grid.GetCell(dgEmails, R, "EmailGuid").ToString();
					//Dim TypeEmail As String = R("SourceTypeCode")
					string TypeEmail = grid.GetCell(dgEmails, R, "SourceTypeCode").ToString();
					S = "";
					S += pRepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + CurrentGuid);
					S += (string) (Strings.ChrW(254) + TypeEmail);
					S += (string) (Strings.ChrW(254) + "-");
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					L.Add(S);
					if (! UseISO)
					{
						GLOBALS.ProxySearch.scheduleFileDownLoadAsync(GLOBALS._SecureID, CurrentGuid, GLOBALS._UserID, "EMAIL", 0, 1);
					}
				}
			}
			if (pRepoTableName.Equals("DataSource"))
			{
				
				foreach (DataGridRow R in dgContent.SelectedItems)
				{
					iCnt++;
					CurrentGuid = (string) (grid.GetCell(dgEmails, R, "SourceGuid").ToString());
					string FileExt = (string) (grid.GetCell(dgEmails, R, "OriginalFileType").ToString());
					string FileFQN = (string) (grid.GetCell(dgEmails, R, "FQN").ToString());
					string FileLength = (string) (grid.GetCell(dgEmails, R, "FileLength").ToString());
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					S = "";
					S += pRepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + CurrentGuid);
					S += (string) (Strings.ChrW(254) + FileExt);
					S += (string) (Strings.ChrW(254) + FileFQN);
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					L.Add(S);
					if (! UseISO)
					{
						GLOBALS.ProxySearch.scheduleFileDownLoadAsync(GLOBALS._SecureID, CurrentGuid, GLOBALS._UserID, "CONTENT", 0, 1);
					}
				}
			}
			if (pRepoTableName.Equals("EmailAttachment"))
			{
				
				string Rowid;
				foreach (DataGridRow R in dgContent.SelectedItems)
				{
					iCnt++;
					Rowid = (string) (grid.GetCell(dgContent, R, "RowID").ToString());
					string FileExt = (string) (grid.GetCell(dgContent, R, "OriginalFileType").ToString());
					string FileFQN = (string) (grid.GetCell(dgContent, R, "FQN").ToString());
					string FileLength = (string) (grid.GetCell(dgContent, R, "FileLength").ToString());
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					S = "";
					S += pRepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + Rowid);
					S += (string) (Strings.ChrW(254) + FileExt);
					S += (string) (Strings.ChrW(254) + FileFQN);
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					if (! UseISO)
					{
						GLOBALS.ProxySearch.scheduleFileDownLoadAsync(GLOBALS._SecureID, Rowid, GLOBALS._UserID, "EMAILATTACHMENT", 0, 1);
					}
				}
			}
			
			if (UseISO)
			{
				ISO.SaveFileRestoreData(modGlobals.gCurrUserGuidID, L);
			}
			
			MessageBox.Show("Restore request posted for " + iCnt.ToString() + " files.");
			
			ISO = null;
		}
		
		public string getRestoreStats()
		{
			
			string CurrentGuid = "";
			clsIsolatedStorage ISO = new clsIsolatedStorage();
			
			List<string> L = new List<string>();
			
			
			string FQN = "NA";
			int iCnt = 0;
			if (pRepoTableName.Equals("EmailAttachment"))
			{
				iCnt = dgEmailAttachment.SelectedItems.Count;
			}
			if (pRepoTableName.Equals("Email"))
			{
				iCnt = dgEmails.SelectedItems.Count;
			}
			if (pRepoTableName.Equals("DataSource"))
			{
				iCnt = dgContent.SelectedItems.Count;
			}
			if (iCnt == 0)
			{
				MessageBox.Show("To perform a restore, one or more rows must be selected, returning.");
				return false;
			}
			decimal iSize = 0;
			string S = "";
			string Unit = "";
			string Msg = "";
			if (pRepoTableName.Equals("Email"))
			{
				
				int idx = dgEmails.SelectedIndex;
				foreach (DataGridRow R in dgEmails.SelectedItems)
				{
					string sMsgSize = grid.GetCellValueAsString(dgEmails, idx, "MsgSize");
					string TypeEmail = grid.GetCellValueAsString(dgEmails, idx, "SourceTypeCode");
					iSize += int.Parse(sMsgSize);
					idx++;
				}
				
				setUnits(ref iSize, ref Unit);
				Msg = (string) ("Emails: " + iCnt.ToString() + " - Size: " + iSize.ToString() + " " + Unit);
				SB.Content = Msg;
			}
			if (pRepoTableName.Equals("DataSource"))
			{
				
				int idx = dgContent.SelectedIndex;
				foreach (DataGridRow R in dgContent.SelectedItems)
				{
					string FileLength = grid.GetCellValueAsString(dgContent, idx, "FileLength");
					iSize += int.Parse(FileLength);
					idx++;
				}
				setUnits(ref iSize, ref Unit);
				Msg = (string) ("Files: " + iCnt.ToString() + " - Size: " + iSize.ToString() + " " + Unit);
				SB.Content = Msg;
			}
			if (pRepoTableName.Equals("EmailAttachment"))
			{
				
				int idx = dgContent.SelectedIndex;
				foreach (DataGridRow R in dgContent.SelectedItems)
				{
					iCnt++;
					string FileLength = grid.GetCellValueAsString(dgContent, idx, "FileLength");
					iSize += int.Parse(FileLength);
					idx++;
				}
				setUnits(ref iSize, ref Unit);
				Msg = (string) ("Files: " + iCnt.ToString() + " - Size: " + iSize.ToString() + " " + Unit);
				SB.Content = Msg;
			}
			
			ISO.SaveFileRestoreData(modGlobals.gCurrUserGuidID, L);
			ISO = null;
			
			return Msg;
			
		}
		public void setUnits(ref decimal iSize, ref string Unit)
		{
			if (iSize > 100000000000)
			{
				Unit = "TB";
				iSize = iSize / 1000000000;
				iSize = decimal.Parse(iSize.ToString("#0.00"));
				return;
			}
			if (iSize > 1000000000 && iSize < 100000000000)
			{
				Unit = "GB";
				iSize = iSize / 1000000000;
				iSize = decimal.Parse(iSize.ToString("#0.00"));
				return;
			}
			if (iSize > 1000000 && iSize < 1000000000)
			{
				Unit = "MB";
				iSize = iSize / 1000000;
				iSize = decimal.Parse(iSize.ToString("#0.00"));
				return;
			}
			if (iSize < 1000000)
			{
				Unit = "KB";
				iSize = iSize / 1000;
				iSize = decimal.Parse(iSize.ToString("#0.00"));
				return;
			}
			if (iSize < 9999)
			{
				Unit = "Bytes";
			}
			
		}
		public void ckCreateMissing_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bCreateOriginalDirIfMissing = true;
		}
		
		public void ckCreateMissing_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bCreateOriginalDirIfMissing = false;
		}
		
		public void rbToOriginalDir_Unchecked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			ckCreateMissing.Visibility = Visibility.Collapsed;
			bRestoreToOriginalDirectory = false;
			ckCreateMissing.IsChecked = false;
		}
		
		public void rbToOriginalDir_Checked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bRestoreToOriginalDirectory = true;
			ckCreateMissing.Visibility = Visibility.Visible;
			bRestoreToMyDocuments = false;
		}
	}
	
}
