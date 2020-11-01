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


//** Xixed the RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_changeOwnership

namespace ECMSearchWPF
{
	public partial class PageLibraryAssignment
	{
		
		
		clsLogging LOG = new clsLogging();
		clsLIBEMAIL EmailLib = new clsLIBEMAIL();
		clsLIBDIRECTORY ContentLib = new clsLIBDIRECTORY();
		clsUtility UTIL = new clsUtility();
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		string CurrLibName = "";
		string CurrAssignLibName = "";
		string CurrUserGuidID = "";
		
		//Dim GVAR As App = App.Current
		string UserID = "";
		//Dim ListOfLibs As System.Collections.ObjectModel.ObservableCollection(Of String)
		string[] ListOfLibs = null;
		//Dim ListOfAssignedLibs As System.Collections.ObjectModel.ObservableCollection(Of String)
		string[] ListOfAssignedLibs = null;
		
		public string FolderName = "";
		string FolderID = "";
		string tgtLibName = "";
		string TypeLibrary = "";
		bool isEmail = false;
		
		bool RC = false;
		string RetMsg = "";
		
		//Dim proxy As New SVCSearch.Service1Client
		
		public PageLibraryAssignment()
		{
			InitializeComponent();
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			//** Set global variables
			UserID = GLOBALS._UserID;
			CurrUserGuidID = GLOBALS._UserGuid;
			COMMON.SaveClick(5500, UserID);
			PB.Value = 0;
			
		}
		
		public void setTypeLibrary(string LibType)
		{
			TypeLibrary = LibType;
			if (TypeLibrary.ToUpper().Equals("EMAIL"))
			{
				txtTypeLibrary.Text = LibType;
				isEmail = true;
			}
			else
			{
				txtTypeLibrary.Text = LibType;
				isEmail = false;
			}
		}
		public void setLibraryName(string LibName)
		{
			tgtLibName = LibName;
			lbLibrary.SelectedItem = tgtLibName;
		}
		public void setFolderID(string MailFolderID)
		{
			FolderID = MailFolderID;
		}
		public void setFolderName(string tFolderName)
		{
			txtFolderName.Text = tFolderName.Trim();
			FolderName = tFolderName.Trim();
		}
		
		public void hlHome_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			MainPage NextPage = new MainPage();
			this.Content = NextPage;
		}
		
		public void hyperlinkButton1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageLibrary NextPage = new PageLibrary();
			this.Content = NextPage;
		}
		
		public void PopulateLibraryCombo()
		{
			
			GLOBALS._UserID = GLOBALS._UserGuid;
			
			try
			{
				string S = "";
				
				S = S + " SELECT [LibraryName]";
				S = S + " FROM  [Library]";
				S = S + " where userid = \'" + GLOBALS._UserID + "\'";
				S = S + " order by [LibraryName]";
				
				GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_PopulateLibraryCombo);
				//EP.setSearchSvcEndPoint(proxy)
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ListOfLibs, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
				
			}
			catch (Exception)
			{
				SB.Text = "Failed to load Libraries.";
			}
			
		}
		public void client_PopulateLibraryCombo(object sender, SVCSearch.getListOfStringsCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				lbLibrary.Items.Clear();
				ListOfLibs = e.ListOfItems;
				foreach (string S in ListOfLibs)
				{
					lbLibrary.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryCombo 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_PopulateLibraryCombo);
		}
		
		public void PopulateAssignedLibraryCombo()
		{
			string S = "";
			lbAssignedLibs.Items.Clear();
			
			if (isEmail)
			{
				S = S + " SELECT  [LibraryName]";
				S = S + " FROM  [LibEmail]";
				S = S + " where [FolderName] = \'" + FolderName + "\'";
			}
			else
			{
				S = S + " SELECT  [LibraryName]";
				S = S + " FROM  [LibDirectory]";
				S = S + " where [DirectoryName] = \'" + FolderName + "\'";
			}
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_PopulateAssignedLibraryCombo);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ListOfAssignedLibs, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			
		}
		public void client_PopulateAssignedLibraryCombo(object sender, SVCSearch.getListOfStringsCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				lbAssignedLibs.Items.Clear();
				ListOfAssignedLibs = e.ListOfItems;
				foreach (string S in ListOfLibs)
				{
					lbAssignedLibs.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryCombo 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_PopulateAssignedLibraryCombo);
		}
		
		public void client_iCountLibrary(object sender, SVCSearch.iCountCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_iCountLibrary 100: " + e.Error.Message));
			}
		}
		
		public void AssignLibrary()
		{
			
			GLOBALS._UserID = GLOBALS._UserGuid;
			int RecordsAdded = 0;
			string LibToAdd = (string) lbLibrary.SelectedItem;
			FolderName = txtFolderName.Text.Trim();
			
			if (isEmail)
			{
				if (FolderID.Length == 0)
				{
					MessageBox.Show("FolderID MISSING for Mailbox " + FolderName + " , returning.");
					return;
				}
				EmailLib.setEmailfolderentryid(ref FolderID);
				EmailLib.setLibraryname(ref LibToAdd);
				EmailLib.setUserid(GLOBALS._UserID);
				EmailLib.setFoldername(ref FolderName);
				//***************************************
				bool b = EmailLib.Insert();
				//***************************************
				if (b)
				{
					PopulateAssignedLibraryCombo();
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					GLOBALS.ProxySearch.AddLibraryEmailCompleted += new System.EventHandler(client_AddLibraryEmail);
					//EP.setSearchSvcEndPoint(proxy)
					GLOBALS.ProxySearch.AddLibraryEmailAsync(GLOBALS._SecureID, FolderName, CurrLibName, GLOBALS._UserID, RecordsAdded, RC, RetMsg);
					
					var tMsg = "User \'" + GLOBALS._UserID + "\' assigned EMAIL Folder \'" + this.txtFolderName.Text.Trim + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
					GLOBALS.ProxySearch.AddSysMsgAsync(GLOBALS._SecureID, GLOBALS._UserID, tMsg, RC);
					
					LOG.WriteToSqlLog(tMsg);
					SB.Text = "Added email folder to library...";
				}
				else
				{
					MessageBox.Show("ERROR: DID NOT Add email folder to library...");
					var LID = GLOBALS._UserID;
					var tMsg = "ERROR: 3302.1.y - User \'" + LID + "\' failed to assign EMAIL Folder \'" + this.txtFolderName.Text.Trim + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
					GLOBALS.ProxySearch.AddSysMsgAsync(GLOBALS._SecureID, GLOBALS._UserID, tMsg, RC);
					LOG.WriteToSqlLog(tMsg);
				}
			}
			else
			{
				ContentLib.setDirectoryname(this.txtFolderName.Text.Trim);
				ContentLib.setLibraryname(ref LibToAdd);
				ContentLib.setUserid(GLOBALS._UserID);
				//*******************************************
				bool b = ContentLib.Insert();
				//*******************************************
				
				PopulateAssignedLibraryCombo();
				
				PB.IsIndeterminate = true;
				PB.Visibility = System.Windows.Visibility.Visible;
				
				GLOBALS.ProxySearch.AddLibraryDirectoryAsync(GLOBALS._SecureID, this.txtFolderName.Text.Trim, LibToAdd, GLOBALS._UserID, RecordsAdded, RC, RetMsg);
				
				var LID = GLOBALS._UserID;
				var tMsg = "User \'" + LID + "\' assigned directory \'" + this.txtFolderName.Text.Trim + "\' to library \'" + LibToAdd + "\' on " + DateTime.Now.ToString() + ".";
				
				PB.IsIndeterminate = true;
				PB.Visibility = System.Windows.Visibility.Visible;
				
				GLOBALS.ProxySearch.AddSysMsgAsync(GLOBALS._SecureID, GLOBALS._UserID, tMsg, RC);
				
				LOG.WriteToSqlLog(tMsg);
			}
			
			SB.Text = "Library assignment complete.";
		}
		
		public void client_AddLibraryEmail(object sender, SVCSearch.AddLibraryEmailCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int I = 0;
			
			if (e.Error == null)
			{
				I = System.Convert.ToInt32(e.RecordsAdded);
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_AddLibraryEmail 3321: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.AddLibraryEmailCompleted -= new System.EventHandler(client_AddLibraryEmail);
		}
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				string ErrSql = (string) e.MySql;
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 100: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 100: " + ErrSql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
		}
		
		public void RemoveLibrary()
		{
			
			GLOBALS._UserID = GLOBALS._UserGuid;
			
			int iSelected = lbAssignedLibs.SelectedItems.Count;
			if (iSelected == 0)
			{
				return;
			}
			
			string LibToRemove = lbAssignedLibs.Items[iSelected];
			LibToRemove = LibToRemove.Replace("\'", "\'\'");
			
			for (int I = 0; I <= iSelected - 1; I++)
			{
				
				if (isEmail)
				{
					FolderName = UTIL.RemoveSingleQuotes(FolderName);
					
					string Mysql = "";
					Mysql = "delete from LibEmail where LibraryName = \'" + LibToRemove + "\' and EmailFolderEntryID = \'" + FolderID + "\' ";
					
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
					//EP.setSearchSvcEndPoint(proxy)
					Mysql = ENC2.EncryptPhrase(Mysql, GLOBALS.ContractID);
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, Mysql, GLOBALS._UserID, GLOBALS.ContractID);
					
					
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					MessageBox.Show("Removed email folder from library... applying changes across the repository, this can take a long while.");
					GLOBALS.ProxySearch.RemoveLibraryEmailsAsync(GLOBALS._SecureID, FolderName, LibToRemove, GLOBALS._UserID, RC, RetMsg);
					
					var LID = GLOBALS._UserID;
					var tMsg = "Notice: 3302.2.y - User \'" + LID + "\' removed EMAIL Folder \'" + this.txtFolderName.Text.Trim + "\' from library \'" + LibToRemove + "\' on " + DateTime.Now.ToString() + ".";
					GLOBALS.ProxySearch.AddSysMsgAsync(GLOBALS._SecureID, GLOBALS._UserID, tMsg, RC);
					
					PopulateAssignedLibraryCombo();
				}
				else
				{
					string wc = ContentLib.wc_PK98((string) this.txtFolderName.Text.Trim, LibToRemove, GLOBALS._UserID);
					bool b = ContentLib.Delete(wc);
					
					string DirName = txtFolderID.Text.Trim();
					
					MessageBox.Show("Removed content folder from library... applying changes across the repository, this can take a long while.");
					
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					GLOBALS.ProxySearch.RemoveLibraryDirectoriesCompleted += new System.EventHandler(client_RemoveLibraryDirectories);
					//EP.setSearchSvcEndPoint(proxy)
					GLOBALS.ProxySearch.RemoveLibraryDirectoriesAsync(GLOBALS._SecureID, GLOBALS._UserID, DirName, LibToRemove, RC, RetMsg);
					
					
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					var LID = GLOBALS._UserID;
					var tMsg = "Notice: 3303.2.y - User \'" + LID + "\' assigned Content Folder \'" + this.txtFolderName.Text.Trim + "\' from library \'" + LibToRemove + "\' on " + DateTime.Now.ToString() + ".";
					GLOBALS.ProxySearch.AddSysMsgAsync(GLOBALS._SecureID, GLOBALS._UserID, tMsg, RC);
					LOG.WriteToSqlLog(tMsg);
					
					PopulateAssignedLibraryCombo();
					
				}
			}
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.cleanUpLibraryItemsAsync(GLOBALS._SecureID, GLOBALS._UserID);
			
			
		}
		
		public void client_RemoveLibraryDirectories(object sender, SVCSearch.RemoveLibraryDirectoriesCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				if (e.RC)
				{
					SB.Text = "Library removed.";
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryCombo 100: " + e.Error.Message));
				SB.Text = (string) ("Library NOT removed : " + e.Error.ToString());
			}
			GLOBALS.ProxySearch.RemoveLibraryDirectoriesCompleted -= new System.EventHandler(client_RemoveLibraryDirectories);
		}
		
		public void lbLibrary_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			int I = lbLibrary.SelectedIndex;
			CurrLibName = (string) (lbLibrary.SelectedItem(I));
		}
		
		public void btnAssign_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			AssignLibrary();
		}
		
		public void btnRemove_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (lbAssignedLibs.SelectedItems.Count != 1)
			{
				MessageBox.Show("One and only one library can be selected for removal, please select just one.");
				return;
			}
			
			RemoveLibrary();
		}
		
		private void PageLibraryAssignment_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
		}
		
		public void PageLibraryAssignment_Unloaded_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
		}
		
		
	}
	
}
