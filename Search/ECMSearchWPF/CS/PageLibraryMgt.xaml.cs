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
	public partial class PageLibraryMgt
	{
		//Inherits Page
		
		int DelCounter = 0;
		int DelCount = 0;
		
		clsUtility UTIL = new clsUtility();
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsCommonFunctions COMMON = new clsCommonFunctions();
		clsDATASOURCERESTOREHISTORY DRHIST = new clsDATASOURCERESTOREHISTORY();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		bool bPopulateGroupUsers = false;
		bool bPopulateAssignedUsers = false;
		bool bPopulateLibItems = false;
		bool bDeleteGroupAccess = false;
		string CurrSelectedLibName = "";
		
		int iTotalToProcess = 0;
		int iTotalProcessed = 0;
		
		//Dim GVAR As App = App.Current
		string UserID = "";
		bool isAdmin = false;
		//Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
		string[] ListOfItems = null;
		bool RC = false;
		string RetMsg = "";
		bool FormLoaded = false;
		
		string LibraryName = "";
		
		//Dim proxy As New SVCSearch.Service1Client
		
		public PageLibraryMgt()
		{
			InitializeComponent();
			//EP.setSearchSvcEndPoint(proxy)
			//AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
			//AddHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
			//AddHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
			//AddHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
			//AddHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			
			bool bClcRuning = ISO.isClcActive(GLOBALS._UserGuid);
			if (! bClcRuning)
			{
				SB.Text = "CLC Not running - preview and restore are disabled.";
				//lblClcState.Visibility = Windows.Visibility.Visible
				lblClcState.Content = "CLC Not running";
			}
			else
			{
				lblClcState.Visibility = System.Windows.Visibility.Collapsed;
			}
			
			//** Set global variables
			UserID = GLOBALS._UserID;
			//_UserGuid = _UserGuid
			
			COMMON.SaveClick(5500, UserID);
			
			isAdmin = GLOBALS._isAdmin;
			
			PopulateLibraryComboBox();
			
			PopulateGroupCombo();
			
			SB.Text = "";
			
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
		
		
		
		public void hlLibUsers_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageGrantContentToUsers NextPage = new PageGrantContentToUsers();
			this.Content = NextPage;
		}
		
		public void hlNewGroup_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageGroup NextPage = new PageGroup();
			this.Content = NextPage;
		}
		
		public void PopulateGroupUserLibCombo(string GroupName)
		{
			string S = "";
			
			try
			{
				S = S + " SELECT     Users.UserName, GroupUsers.UserID";
				S = S + " FROM         GroupUsers INNER JOIN";
				S = S + " Users ON GroupUsers.UserID = Users.UserID";
				S = S + " WHERE     (GroupUsers.GroupName = \'" + GroupName + "\') ";
				S = S + " order by Users.UserName";
				
				GLOBALS.ProxySearch.getListOfStrings4Completed += new System.EventHandler(client_PopulateGroupUserLibCombo4);
				//EP.setSearchSvcEndPoint(proxy)
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.getListOfStrings4Async(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
				
			}
			catch (Exception ex)
			{
				SB.Text = (string) ("ERROR 33.44.1 - " + ex.Message + " / " + S);
			}
		}
		public void client_PopulateGroupUserLibCombo4(object sender, SVCSearch.getListOfStrings4CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				foreach (string S in e.ListOfItems)
				{
					cbLibrary.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryCombo 100: " + e.Error.Message));
				SB.Text = "Error loading the drop down box, please review the error log.";
			}
			GLOBALS.ProxySearch.getListOfStrings4Completed -= new System.EventHandler(client_PopulateGroupUserLibCombo4);
		}
		
		public void PopulateLibraryComboBox()
		{
			
			string S = "";
			cbLibrary.Items.Clear();
			if (GLOBALS._isAdmin)
			{
				S = "";
				S = S + "Select [LibraryName] FROM [Library] order by [LibraryName]";
			}
			else
			{
				S = "";
				S = S + "Select distinct LibraryName from GroupLibraryAccess " + "\r\n";
				S = S + " where GroupName in " + "\r\n";
				S = S + " (select distinct GroupName from GroupUsers where UserID = \'" + GLOBALS._UserGuid + "\')" + "\r\n";
				S = S + "             union " + "\r\n";
				S = S + " select distinct LibraryName from LibraryUsers where UserID = \'" + GLOBALS._UserGuid + "\'" + "\r\n";
				S = S + " and LibraryName in (select LibraryName from Library)" + "\r\n";
				S = S + "             union " + "\r\n";
				S = S + " select LibraryName from Library where UserID = \'" + GLOBALS._UserGuid + "\'" + "\r\n";
			}
			
			GLOBALS.ProxySearch.getListOfStrings2Completed += new System.EventHandler(client_PopulateLibraryCombo2);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings2Async(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
		}
		public void client_PopulateLibraryCombo2(object sender, SVCSearch.getListOfStrings2CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				//ListOfItems.Clear()
				ListOfItems = null;
				ListOfItems = e.ListOfItems;
				foreach (string S in ListOfItems)
				{
					cbLibrary.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryCombo 100: " + e.Error.Message));
				SB.Text = "Error loading the drop down box, please review the error log.";
			}
			GLOBALS.ProxySearch.getListOfStrings2Completed -= new System.EventHandler(client_PopulateLibraryCombo2);
			FormLoaded = true;
		}
		public void PopulateGroupCombo()
		{
			
			this.cbGroups.Items.Clear();
			string S = "";
			
			if (GLOBALS._isAdmin)
			{
				S = "Select [GroupName] FROM  [UserGroup]" + "\r\n";
				if (ckMyGroupOnly.IsChecked)
				{
					S += "Where GroupOwnerUserID = \'" + GLOBALS._UserGuid + "\' ";
					SB.Text = "Showing only your groups";
				}
				else
				{
					SB.Text = "Admin is shown all groups in System.";
				}
				S += "order by GroupName ";
				
			}
			else
			{
				S = "WITH GroupsContainingUser (GroupName) AS";
				S = S + " (";
				S = S + "    select GroupName from GroupUsers G1 where userid = \'" + GLOBALS._UserGuid + "\' ";
				S = S + " )";
				S = S + " Select [GroupName]";
				S = S + " FROM  [UserGroup]";
				S = S + " where GroupOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
				S = S + " or GroupName in (select GroupName from GroupsContainingUser)";
				S = S + " order by GroupName";
				SB.Text = "All groups you own or are a member of...";
			}
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.getListOfStrings1Completed += new System.EventHandler(client_PopulateGroupCombo1);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings1Async(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		public void client_PopulateGroupCombo1(object sender, SVCSearch.getListOfStrings1CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				cbGroups.Items.Clear();
				foreach (string S in e.ListOfItems)
				{
					cbGroups.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateGroupCombo 100: " + e.Error.Message));
				SB.Text = "Error loading the drop down box, please review the error log.";
			}
			GLOBALS.ProxySearch.getListOfStrings1Completed -= new System.EventHandler(client_PopulateGroupCombo1);
		}
		
		public void PreviewFile()
		{
			
			double BytesToRestore = 0;
			bool bDoNotOverwriteExistingFile = false;
			bool bOverwriteExistingFile = true;
			bool bRestoreToOriginalDirectory = false;
			bool bRestoreToMyDocuments = true;
			bool bCreateOriginalDirIfMissing = false;
			string RepoTableName = "";
			string CurrentGuid = "";
			clsIsolatedStorage ISO = new clsIsolatedStorage();
			
			List<string> L = new List<string>();
			bool bGoodTableName = true;
			
			string FQN = "NA";
			int iCnt = 0;
			
			iCnt = 0;
			string S = "";
			
			int idx = -1;
			foreach (DataGridRow DR in dgLibItems.SelectedItems)
			{
				idx++;
				CurrentGuid = grid.GetCellValueAsString(dgLibItems, idx, "SourceGuid");
				string ItemType = grid.GetCellValueAsString(dgLibItems, idx, "ItemType");
				ItemType = ItemType.ToUpper();
				if (ItemType.Equals(".MSG"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else if (ItemType.Equals("MSG"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else if (ItemType.Equals(".EML"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else if (ItemType.Equals("EML"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else
				{
					RepoTableName = "DataSource";
					bGoodTableName = true;
				}
				if (RepoTableName.Equals("Email"))
				{
					iCnt++;
					string TypeEmail = grid.GetCellValueAsString(dgLibItems, idx, "ItemType");
					if (TypeEmail.IndexOf(".") + 1 == 0)
					{
						TypeEmail = (string) ("." + TypeEmail);
					}
					string FileLength = grid.GetCellValueAsString(dgLibItems, idx, "fsize");
					BytesToRestore = BytesToRestore + int.Parse(FileLength);
					S = "";
					S += RepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + CurrentGuid);
					S += (string) (Strings.ChrW(254) + TypeEmail);
					S += (string) (Strings.ChrW(254) + "-");
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					L.Add(S);
				}
				if (RepoTableName.Equals("DataSource"))
				{
					iCnt++;
					string FileExt = grid.GetCellValueAsString(dgLibItems, idx, "ItemType");
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					string FileFQN = grid.GetCellValueAsString(dgLibItems, idx, "SourceName");
					string FileLength = grid.GetCellValueAsString(dgLibItems, idx, "fsize");
					BytesToRestore = BytesToRestore + int.Parse(FileLength);
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					S = "";
					S += RepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + CurrentGuid);
					S += (string) (Strings.ChrW(254) + FileExt);
					S += (string) (Strings.ChrW(254) + FileFQN);
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					L.Add(S);
				}
			}
			
			ISO.SaveFilePreviewGuid(GLOBALS._UserGuid, RepoTableName.ToUpper(), CurrentGuid, FQN);
			ISO = null;
			GC.Collect();
			SB.Text = (string) ("Preview Requested " + DateTime.Now.ToString());
			
		}
		
		public void PopulateLibItemsGrid(string LibraryName)
		{
			if (FormLoaded == false)
			{
				return;
			}
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.PopulateLibItemsGridCompleted += new System.EventHandler(client_PopulateLibItemsGrid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateLibItemsGridAsync(GLOBALS._SecureID, LibraryName, GLOBALS._UserGuid);
			
		}
		public void client_PopulateLibItemsGrid(object sender, SVCSearch.PopulateLibItemsGridCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				dgLibItems.ItemsSource = e.Result;
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibItemsGrid 100: " + e.Error.Message));
				MessageBox.Show((string) ("ERROR client_PopulateLibItemsGrid 100: " + e.Error.Message));
				SB.Text = "Error loading the library items, please review the error log.";
			}
			GLOBALS.ProxySearch.PopulateLibItemsGridCompleted -= new System.EventHandler(client_PopulateLibItemsGrid);
		}
		
		public void PopulateLibraryGroupsGrid(string LibraryName)
		{
			if (FormLoaded == false)
			{
				return;
			}
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			PopulateDgAssigned(LibraryName);
		}
		
		public void PopulateGroupUserGrid(string GroupName)
		{
			if (FormLoaded == false)
			{
				return;
			}
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.PopulateGroupUserGridCompleted += new System.EventHandler(client_PopulateGroupUserGrid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateGroupUserGridAsync(GLOBALS._SecureID, GroupName);
		}
		public void client_PopulateGroupUserGrid(object sender, SVCSearch.PopulateGroupUserGridCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				dgGrpUsers.ItemsSource = e.Result;
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateGroupUserGrid 100: " + e.Error.Message));
				MessageBox.Show((string) ("ERROR client_PopulateGroupUserGrid 100: " + e.Error.Message));
				SB.Text = "Error loading group users, please review the error log.";
			}
			PB.IsIndeterminate = false;
		}
		
		public void RemoveSelectedLibraryItems()
		{
			this.Cursor = Cursors.Wait;
			//_UserGuid = _UserGuid
			bool ItemsRemoved = false;
			string LibItemOwner = "";
			
			try
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_49_42_827);
			}
			catch (Exception)
			{
				
			}
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_49_42_827);
			//EP.setSearchSvcEndPoint(proxy)
			
			DelCounter = 0;
			DelCount = dgLibItems.SelectedItems.Count;
			
			
			try
			{
				string S = " ";
				int idx = -1;
				foreach (DataGridRow DR in dgLibItems.SelectedItems)
				{
					idx++;
					DelCounter++;
					iTotalProcessed++;
					var LibraryItemGuid = grid.GetCellValueAsString(dgLibItems, idx, "LibraryItemGuid");
					LibItemOwner = grid.GetCellValueAsString(dgLibItems, idx, "LibraryOwnerUserID");
					if (LibItemOwner.ToUpper().Equals(GLOBALS._UserGuid.ToUpper()))
					{
						S += "Delete from LibraryItems where LibraryItemGuid  = \'" + LibraryItemGuid + "\'" + "\r\n";
						
						
						PB.IsIndeterminate = true;
						PB.Visibility = System.Windows.Visibility.Visible;
						
						S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
						GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
					}
					else
					{
						SB.Text = "It appears you are not the Library owner, some items not removed.";
					}
				}
				
			}
			catch (Exception ex)
			{
				this.Cursor = Cursors.Arrow;
				SB.Text = ex.Message.ToString();
			}
			this.Cursor = Cursors.Arrow;
		}
		public void client_ExecuteSqlNewConn_49_42_827(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
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
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_49_42_827: 49_42_827" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_49_42_827: 49_42_827" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_49_42_827);
			//If iTotalProcessed >= iTotalToProcess Then
			//    RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_49_42_827
			//    LibraryName = Me.cbLibrary.Text.Trim
			//    PopulateLibItemsGrid(LibraryName)
			//End If
			if (DelCounter >= DelCount)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_49_42_827);
				PopulateSelectedLibraryItems();
			}
			
			PB.IsIndeterminate = false;
		}
		
		public void RestoreFiles()
		{
			double BytesToRestore = 0;
			bool bDoNotOverwriteExistingFile = false;
			bool bOverwriteExistingFile = true;
			bool bRestoreToOriginalDirectory = false;
			bool bRestoreToMyDocuments = true;
			bool bCreateOriginalDirIfMissing = false;
			string RepoTableName = "";
			string CurrentGuid = "";
			clsIsolatedStorage ISO = new clsIsolatedStorage();
			
			List<string> L = new List<string>();
			bool bGoodTableName = true;
			
			string FQN = "NA";
			int iCnt = 0;
			
			iCnt = 0;
			string S = "";
			
			string DataSourceOwnerUserID = "";
			int RowIdx = -1;
			foreach (DataGridRow DR in dgLibItems.SelectedItems)
			{
				RowIdx++;
				CurrentGuid = grid.GetCellValueAsString(dgLibItems, RowIdx, "SourceGuid");
				DataSourceOwnerUserID = grid.GetCellValueAsString(dgLibItems, RowIdx, "DataSourceOwnerUserID");
				string ItemType = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemType");
				ItemType = ItemType.ToUpper();
				if (ItemType.Equals(".MSG"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else if (ItemType.Equals("MSG"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else if (ItemType.Equals(".eml"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else if (ItemType.Equals("EML"))
				{
					RepoTableName = "Email";
					bGoodTableName = true;
				}
				else
				{
					RepoTableName = "DataSource";
					bGoodTableName = true;
				}
				if (RepoTableName.Equals("Email"))
				{
					iCnt++;
					string TypeEmail = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemType");
					if (TypeEmail.IndexOf(".") + 1 == 0)
					{
						TypeEmail = (string) ("." + TypeEmail);
					}
					string FileLength = grid.GetCellValueAsString(dgLibItems, RowIdx, "fsize");
					BytesToRestore = BytesToRestore + int.Parse(FileLength);
					S = "";
					S += RepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + CurrentGuid);
					S += (string) (Strings.ChrW(254) + TypeEmail);
					S += (string) (Strings.ChrW(254) + "-");
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					L.Add(S);
					SaveRestoreHistory(ItemType, DataSourceOwnerUserID, CurrentGuid);
				}
				if (RepoTableName.Equals("DataSource"))
				{
					DataSourceOwnerUserID = grid.GetCellValueAsString(dgLibItems, RowIdx, "DataSourceOwnerUserID");
					iCnt++;
					string FileExt = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemType");
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					string FileFQN = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemTitle");
					string FileLength = grid.GetCellValueAsString(dgLibItems, RowIdx, "fsize");
					BytesToRestore = BytesToRestore + int.Parse(FileLength);
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					S = "";
					S += RepoTableName.ToUpper();
					S += (string) (Strings.ChrW(254) + CurrentGuid);
					S += (string) (Strings.ChrW(254) + FileExt);
					S += (string) (Strings.ChrW(254) + FileFQN);
					S += (string) (Strings.ChrW(254) + bDoNotOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bOverwriteExistingFile.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToOriginalDirectory.ToString());
					S += (string) (Strings.ChrW(254) + bRestoreToMyDocuments.ToString());
					S += (string) (Strings.ChrW(254) + bCreateOriginalDirIfMissing.ToString());
					L.Add(S);
					SaveRestoreHistory(ItemType, DataSourceOwnerUserID, CurrentGuid);
				}
			}
			
			ISO.SaveFileRestoreData(GLOBALS._UserGuid, L);
			ISO = null;
			
			GC.Collect();
			
			
			MessageBox.Show((string) ("Restore request posted for " + iCnt.ToString() + " files / Total Bytes: " + BytesToRestore.ToString()));
		}
		public void SaveRestoreHistory(string setTypecontentcode, string OwnerID, string SourceGuid)
		{
			
			DRHIST.setRestoreuserid(GLOBALS._UserID);
			DRHIST.setRestoreusername(GLOBALS._UserID);
			DRHIST.setRestoredtomachine(DMA.GetCurrMachineName());
			DRHIST.setRestoreuserdomain(System.Environment.OSVersion.ToString());
			DRHIST.setTypecontentcode(ref setTypecontentcode);
			DRHIST.setSourceguid(ref SourceGuid);
			DRHIST.setDatasourceowneruserid(ref OwnerID);
			bool BBB = DRHIST.Insert();
			
			setDataSourceRestoreHistoryParms();
			
		}
		
		
		public void btnRemoveItem_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			RemoveSelectedLibraryItems();
		}
		
		public void btnRestore_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			RestoreFiles();
		}
		
		
		public void dgAssigned_SelectionChanged(System.Object sender, SelectionChangedEventArgs e)
		{
			
			string GroupName = grid.GetCellValueAsString(dgAssigned, dgAssigned.SelectedIndex, "GroupName");
			
			cbGroups.Text = GroupName;
			PopulateGroupUserGrid(GroupName);
			
		}
		
		
		public void client_ExecuteSqlNewConn_54_28_857(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					Console.WriteLine("Success: client_ExecuteSqlNewConn_54_28_857");
					SB.Text = "Removed item";
					GLOBALS.ProxySearch.AddLibraryGroupUserCompleted += new System.EventHandler(client_AddLibraryGroupUser);
					//EP.setSearchSvcEndPoint(proxy)
					GLOBALS.ProxySearch.AddLibraryGroupUserAsync(GLOBALS._SecureID, cbGroups.Text, RC, RC, GLOBALS._UserID, GLOBALS.ContractID);
					
					PopulateDgAssigned((string) cbLibrary.SelectedItem);
					
				}
				else
				{
					SB.Text = "Failed to remove item";
					string XSql = (string) e.MySql;
					XSql = XSql.Replace("\'", "`");
					Console.WriteLine("ERROR: client_ExecuteSqlNewConn_54_28_857 - " + XSql);
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_54_28_857: 54_28_857" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_54_28_857: 54_28_857" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_54_28_857);
		}
		public void client_AddLibraryGroupUser(object sender, SVCSearch.AddLibraryGroupUserCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.RC);
				if (B)
				{
					Console.WriteLine("Success: client_AddLibraryGroupUser");
					
					PopulateDgAssigned(cbLibrary.Text);
					PopulateGroupUserGrid(cbGroups.Text);
					
				}
				else
				{
					LOG.WriteToSqlLog("ERROR client_AddLibraryGroupUser: 10: FAILED TO EXECUTE.");
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_AddLibraryGroupUser: 100" + e.Error.Message));
			}
			GLOBALS.ProxySearch.AddLibraryGroupUserCompleted -= new System.EventHandler(client_AddLibraryGroupUser);
		}
		
		public void PopulateDgAssigned(string LibraryName)
		{
			//_UserGuid = _UserGuid
			
			cbLibrary.IsEnabled = false;
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.PopulateDgAssignedCompleted += new System.EventHandler(client_PopulateDgAssigned);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateDgAssignedAsync(GLOBALS._SecureID, LibraryName, GLOBALS._UserGuid);
			
		}
		public void client_PopulateDgAssigned(object sender, SVCSearch.PopulateDgAssignedCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int TrackingNbr = 0;
			if (e.Error == null)
			{
				dgAssigned.ItemsSource = e.Result;
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR: client_PopulateDgAssigned 101 - " + e.Error.Message));
				MessageBox.Show((string) ("ERROR: client_PopulateDgAssigned 101 - " + e.Error.Message));
			}
			GLOBALS.ProxySearch.PopulateDgAssignedCompleted -= new System.EventHandler(client_PopulateDgAssigned);
			cbLibrary.IsEnabled = true;
			PB.IsIndeterminate = false;
		}
		
		public void setDataSourceRestoreHistoryParms()
		{
			
			string S = "";
			bool B = false;
			//_UserGuid = _UserGuid
			var EncString = "";
			S = S + " update DataSourceRestoreHistory  ";
			S = S + " set  DocumentName = (select SourceName from DataSource ";
			S = S + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) ";
			S = S + " where VerifiedData = \'N\' ";
			S = S + " and TypeContentCode <> \'.msg\' ";
			S = S + " and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSqlNewConn1);
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = " update DataSourceRestoreHistory  ";
			S = S + " set  FQN = (select FQN from DataSource ";
			S = S + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) ";
			S = S + " where VerifiedData = \'N\' ";
			S = S + " and TypeContentCode <> \'.msg\' ";
			S = S + " and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed += new System.EventHandler(client_ExecuteSqlNewConn2);
			//EP.setSearchSvcEndPoint(proxy)
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = " update DataSourceRestoreHistory ";
			S = S + " set  DocumentName = (select ShortSubj from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
			S = S + " where VerifiedData = \'N\' and TypeContentCode = \'.msg\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed += new System.EventHandler(client_ExecuteSqlNewConn3);
			//EP.setSearchSvcEndPoint(proxy)
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = "update DataSourceRestoreHistory ";
			S = S + " set  FQN = (select \'EMAIL\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
			S = S + " where VerifiedData = \'N\' and TypeContentCode = \'.msg\'  and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed += new System.EventHandler(client_ExecuteSqlNewConn4);
			//EP.setSearchSvcEndPoint(proxy)
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = "update DataSourceRestoreHistory ";
			S = S + " set  FQN = (select \'EMAIL\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
			S = S + " where VerifiedData = \'N\' and TypeContentCode = \'.eml\'  and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed += new System.EventHandler(client_ExecuteSqlNewConn5);
			//EP.setSearchSvcEndPoint(proxy)
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = " update DataSourceRestoreHistory ";
			S = S + " set  VerifiedData = (select \'Y\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
			S = S + " where VerifiedData = \'N\'  and TypeContentCode = \'.msg\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn2_9_10_816);
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, S, EncString, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = " update DataSourceRestoreHistory ";
			S = S + " set  VerifiedData = (select \'Y\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
			S = S + " where VerifiedData = \'N\'  and TypeContentCode = \'.eml\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_11_10_753);
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, S, EncString, GLOBALS._UserID, GLOBALS.ContractID);
			
			S = " Update DataSourceRestoreHistory ";
			S = S + " set  VerifiedData = (select \'Y\' from DataSource where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid)";
			S = S + " where VerifiedData = \'N\'  and TypeContentCode <> \'.msg\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_11_25_201);
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_ExecuteSqlNewConn_11_25_201(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					Console.WriteLine("Success: client_ExecuteSqlNewConn_54_28_857");
				}
				else
				{
					string XSql = (string) e.MySql;
					XSql = XSql.Replace("\'", "`");
					Console.WriteLine("ERROR: client_ExecuteSqlNewConn_54_28_857 - " + XSql);
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_11_25_201: 11_25_201" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_11_25_201: 11_25_201" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_11_25_201);
		}
		
		public void client_ExecuteSqlNewConn_11_10_753(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					Console.WriteLine("Success: client_ExecuteSqlNewConn_54_28_857");
				}
				else
				{
					string XSql = (string) e.MySql;
					XSql = XSql.Replace("\'", "`");
					Console.WriteLine("ERROR: client_ExecuteSqlNewConn_54_28_857 - " + XSql);
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_11_10_753: 11_10_753" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_11_10_753: 11_10_753" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_11_10_753);
		}
		
		public void client_ExecuteSqlNewConn2_9_10_816(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					Console.WriteLine("Success: client_ExecuteSqlNewConn2_9_10_816");
				}
				else
				{
					string XSql = (string) e.MySql;
					XSql = XSql.Replace("\'", "`");
					Console.WriteLine("ERROR: client_ExecuteSqlNewConn2_9_10_816 - " + XSql);
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn2_9_10_816: 9_10_816" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn2_9_10_816: 9_10_816" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn2_9_10_816);
			//EP.setSearchSvcEndPoint(proxy)
		}
		
		
		public void client_ResetLibraryUsersCount(object sender, SVCSearch.ResetLibraryUsersCountCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int TrackingNbr = 0;
			this.Cursor = Cursors.Arrow;
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.RC);
				if (! B)
				{
					MessageBox.Show("ERROR 166.91: client_ResetLibraryUsersCount 101 - failed to reset library user count.");
					LOG.WriteToSqlLog((string) ("ERROR 166.91: client_DeleteLibraryGroupUser 101 - failed to remove group users - " + e.Error.Message));
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR 166.92: client_ResetLibraryUsersCount 101 - " + e.Error.Message));
				MessageBox.Show((string) ("ERROR 166.92: client_ResetLibraryUsersCount 101 - " + e.Error.Message));
			}
			
		}
		public void client_DeleteLibraryGroupUser(object sender, SVCSearch.DeleteLibraryGroupUserCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int TrackingNbr = 0;
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.RC);
				if (! B)
				{
					MessageBox.Show("ERROR: client_DeleteLibraryGroupUser 101 - failed to remove group users.");
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR: client_DeleteLibraryGroupUser 101 - failed to remove group users - " + e.Error.Message));
				MessageBox.Show((string) ("ERROR: client_DeleteLibraryGroupUser 101 - failed to remove group users - " + e.Error.Message));
			}
		}
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int TrackingNbr = 0;
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					if (bPopulateGroupUsers)
					{
						bPopulateGroupUsers = false;
						PopulateDgAssigned(CurrSelectedLibName);
						GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted += new System.EventHandler(client_ResetLibraryUsersCount);
						//EP.setSearchSvcEndPoint(proxy)
						GLOBALS.ProxySearch.ResetLibraryUsersCountAsync(GLOBALS._SecureID, RC);
					}
					if (bPopulateAssignedUsers)
					{
						bPopulateAssignedUsers = false;
						PopulateDgAssigned(CurrSelectedLibName);
						GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted += new System.EventHandler(client_ResetLibraryUsersCount);
						//EP.setSearchSvcEndPoint(proxy)
						GLOBALS.ProxySearch.ResetLibraryUsersCountAsync(GLOBALS._SecureID, RC);
					}
					if (bDeleteGroupAccess)
					{
						bDeleteGroupAccess = false;
						PopulateDgAssigned(CurrSelectedLibName);
						GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted += new System.EventHandler(client_ResetLibraryUsersCount);
						//EP.setSearchSvcEndPoint(proxy)
						GLOBALS.ProxySearch.ResetLibraryUsersCountAsync(GLOBALS._SecureID, RC);
					}
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
		}
		
		public void client_ExecuteSqlNewConn1(object sender, SVCSearch.ExecuteSqlNewConn1CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 200: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed -= new System.EventHandler(client_ExecuteSqlNewConn1);
		}
		public void client_ExecuteSqlNewConn2(object sender, SVCSearch.ExecuteSqlNewConn2CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 300: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed -= new System.EventHandler(client_ExecuteSqlNewConn2);
		}
		public void client_ExecuteSqlNewConn3(object sender, SVCSearch.ExecuteSqlNewConn3CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 400: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed -= new System.EventHandler(client_ExecuteSqlNewConn3);
		}
		public void client_ExecuteSqlNewConn4(object sender, SVCSearch.ExecuteSqlNewConn4CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 500: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed -= new System.EventHandler(client_ExecuteSqlNewConn4);
		}
		public void client_ExecuteSqlNewConn5(object sender, SVCSearch.ExecuteSqlNewConn5CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 600: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed -= new System.EventHandler(client_ExecuteSqlNewConn5);
		}
		
		
		~PageLibraryMgt()
		{
			try
			{
				
			}
			finally
			{
				base.Finalize(); //define the destructor
				//RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
				//RemoveHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
				//RemoveHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
				//RemoveHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
				//RemoveHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
				//RemoveHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
				
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		public void hlRefreshGRps_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			PopulateDgAssigned(cbLibrary.Text);
			PopulateGroupCombo();
			
		}
		
		public void hlRemoveGroup_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			this.Cursor = Cursors.Wait;
			bool RC = false;
			bPopulateGroupUsers = true;
			bPopulateAssignedUsers = true;
			
			LibraryName = cbLibrary.Text.Trim();
			CurrSelectedLibName = LibraryName;
			bool Proceed = false;
			
			hlRemoveGroup.IsEnabled = false;
			
			var msg = "This will remove this group and all associated users - cannot be undone, ARE YOU SURE?";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			
			if (result == MessageBoxResult.Cancel)
			{
				SB.Text = "Cancelled group delete.";
				hlRemoveGroup.IsEnabled = true;
				return;
			}
			
			string GroupName = grid.GetCellValueAsString(dgAssigned, dgAssigned.SelectedIndex, "GroupName");
			bPopulateGroupUsers = true;
			GLOBALS.ProxySearch.DeleteLibraryGroupUserCompleted += new System.EventHandler(client_DeleteLibraryGroupUser);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.DeleteLibraryGroupUserAsync(GLOBALS._SecureID, GroupName, LibraryName, RC);
			
			string S = " ";
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			GroupName = UTIL.RemoveSingleQuotes(GroupName);
			
			bDeleteGroupAccess = true;
			S = "delete FROM GroupLibraryAccess where GroupName = \'" + GroupName + "\' and LibraryName = \'" + LibraryName + "\'";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_54_28_857);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			hlRemoveGroup.IsEnabled = true;
			
			this.Cursor = Cursors.Arrow;
			
			SB.Text = "Removal complete.";
		}
		
		public void hlAssignGroup_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			//Dim s As String = ""
			//s += " if not exists(SELECT GroupName" + vbCrLf
			//s += "      FROM [dbo].[GroupLibraryAccess] " + vbCrLf
			//s += "      where LibraryName = '@LibraryName' and GroupName = '@GroupName')" + vbCrLf
			//s += " BEGIN " + vbCrLf
			//s += " INSERT INTO [GroupLibraryAccess]" + vbCrLf
			//s += " ([UserID]" + vbCrLf
			//s += " ,[LibraryName]" + vbCrLf
			//s += " ,[GroupOwnerUserID]" + vbCrLf
			//s += " ,[GroupName]" + vbCrLf
			//s += " )" + vbCrLf
			//s += " VALUES " + vbCrLf
			//s += " ('@UID'" + vbCrLf
			//s += " ,'@LibraryName'" + vbCrLf
			//s += " ,'@UID'" + vbCrLf
			//s += " ,'@GroupName')" + vbCrLf
			//s += " End" + vbCrLf
			
			string GroupName = (string) cbGroups.SelectedItem;
			string LibraryName = (string) cbLibrary.SelectedItem;
			
			//GroupName = GroupName.Replace("'", "''")
			//LibraryName = LibraryName.Replace("'", "''")
			
			//s = s.Replace("@GroupName", GroupName)
			//s = s.Replace("@LibraryName", LibraryName)
			//s = s.Replace("@UID", _UserGuid)
			
			GLOBALS.ProxySearch.AddGroupLibraryAccessCompleted += new System.EventHandler(client_AddGroupLibraryAccess);
			//EP.setSearchSvcEndPoint(proxy)
			//s = ENC2.EncryptPhrase(s, ContractID)
			GLOBALS.ProxySearch.AddGroupLibraryAccessAsync(GLOBALS._SecureID, GLOBALS._UserID, LibraryName, GroupName, GLOBALS._UserID, RC, GLOBALS._UserID, GLOBALS.ContractID, "SRCH");
			
		}
		public void client_AddGroupLibraryAccess(object sender, SVCSearch.AddGroupLibraryAccessCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.RC);
				if (B)
				{
					
					PopulateDgAssigned(cbLibrary.Text);
					
					SB.Text = "Added group.";
					
					GLOBALS.ProxySearch.AddLibraryGroupUserCompleted += new System.EventHandler(client_AddLibraryGroupUser);
					//EP.setSearchSvcEndPoint(proxy)
					GLOBALS.ProxySearch.AddLibraryGroupUserAsync(GLOBALS._SecureID, cbGroups.Text, RC, RC, GLOBALS._UserID, GLOBALS.ContractID);
					
				}
				else
				{
					SB.Text = "Failed to add group.";
					Console.WriteLine("ERROR: client_ExecuteSqlNewConn_58_46_516.");
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_58_46_516: 58_46_516" + e.Error.Message));
				SB.Text = "Failed to add group.";
			}
			GLOBALS.ProxySearch.AddGroupLibraryAccessCompleted -= new System.EventHandler(client_AddGroupLibraryAccess);
		}
		
		
		public void PopulateSelectedLibraryItems()
		{
			if (FormLoaded == false)
			{
				return;
			}
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			this.Cursor = Cursors.Wait;
			LibraryName = (string) cbLibrary.SelectedItem;
			
			if (LibraryName.Trim().Length == 0)
			{
				this.Cursor = Cursors.Arrow;
				SB.Text = "Select a library...";
				return;
			}
			
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			
			PopulateLibItemsGrid(LibraryName);
			PopulateDgAssigned(cbLibrary.Text);
			//PopulateLibraryGroupsGrid(LibraryName)
			
			this.Cursor = Cursors.Arrow;
			SB.Text = "Current library: " + LibraryName + ", contains " + this.dgLibItems.Items.Count.ToString() + " items.";
		}
		
		public void dgLibItems_MouseEnter(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			SB.Text = "Current library: " + cbLibrary.Text + ", contains " + this.dgLibItems.Items.Count.ToString() + " items.";
		}
		
		public void hlValidate_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			string S = "";
			S = " delete from LibraryItems" + "\r\n";
			S += " where SourceGuid not in (Select SourceGuid from datasource) " + "\r\n";
			S += " and SourceGuid not in (Select EmailGuid from Email)" + "\r\n";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSqlNewConn10);
			//EP.setSearchSvcEndPoint(proxy)
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			
		}
		public void client_ExecuteSqlNewConn10(object sender, SVCSearch.ExecuteSqlNewConn1CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
				cbLibrary_SelectionChanged(null, null);
				MessageBox.Show("Validation Complete, please reselect library.");
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 200: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed -= new System.EventHandler(client_ExecuteSqlNewConn1);
		}
		
		public void ckMyGroupOnly_Checked(object sender, RoutedEventArgs e)
		{
			
		}
		
		public void dgLibItems_MouseDoubleClick(object sender, MouseButtonEventArgs e)
		{
			string TempDir = System.IO.Path.GetTempPath();
			
			string SourceWorkingDirectory = TempDir;
			string EmailWorkingDirectory = TempDir;
			
			int iSelected = dgLibItems.SelectedItems.Count;
			if (iSelected < 1)
			{
				SB.Text = "One or more rows must be selected for restore, returning.";
				return;
			}
			
			bool bClcRuning = ISO.isClcActive(GLOBALS._UserGuid);
			if (! bClcRuning)
			{
				SB.Text = "CLC Not running - preview and restore are disabled.";
				return;
			}
			PreviewFile();
			
			PB.Value = 0;
		}
		
		public void cbLibrary_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			PopulateSelectedLibraryItems();
		}
		
		public void cbGroups_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			if (FormLoaded == false)
			{
				return;
			}
			
			dgAssigned.Visibility = Visibility.Visible;
			dgGrpUsers.Visibility = Visibility.Visible;
			
			var Groupname = cbGroups.Text;
			Groupname = Groupname.Replace("\'\'", "\'");
			
			if (Groupname.Length == 0)
			{
				SB.Text = "Pick a group please...";
				return;
			}
			var groupowneruserid = GLOBALS._UserGuid;
			PopulateGroupUserGrid(Groupname);
		}
	}
	
}
