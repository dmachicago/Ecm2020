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
	public partial class PageLibrary
	{
		//Inherits Page
		
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim GVAR As App = App.Current
		clsUtility UTIL = new clsUtility();
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim proxy2 As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		clsHive HIVE = new clsHive();
		string SecureID = "-1";
		clsLogging LOG = new clsLogging();
		clsLIBRARYUSERS LU = new clsLIBRARYUSERS();
		bool bPopulateLibraries = false;
		string LibraryName = "";
		string isPublic = "";
		System.Collections.ObjectModel.ObservableCollection<string> ListBoxItems = new System.Collections.ObjectModel.ObservableCollection<string>();
		
		string UserID = "";
		bool FormLoaded = false;
		
		public PageLibrary()
		{
			InitializeComponent();
			
			SecureID = GLOBALS._SecureID.ToString();
			//EP.setSearchSvcEndPoint(proxy)
			
			//** Set global variables
			UserID = GLOBALS._UserID;
			//_UserGuid = _UserGuid
			
			PopulateLibraryListBox();
			
			COMMON.SaveClick(5500, UserID);
			
			SB.Text = "";
			
		}
		
		public void btnDelete_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			bPopulateLibraries = true;
			
			int II = dgLibrary.SelectedIndex;
			if (II < 0)
			{
				MessageBox.Show("An item in the list must be selected, returning.");
				return;
			}
			
			var msg = "This will delete the selected Library, user associations, and ALL of the associated content, ARE YOU SURE?";
			MessageBoxResult dlgRes = MessageBox.Show(msg, "Remove Library", MessageBoxButton.OKCancel);
			if (dlgRes == MessageBoxResult.No)
			{
				return;
			}
			
			string tLib = txtLibrary.Text.Trim();
			tLib = tLib.Replace("\'", "\'\'");
			
			string LibName = txtLibrary.Text.Trim();
			LibName = LibName.Replace("\'", "\'\'");
			
			
			if (LibName.Trim().Length == 0)
			{
				MessageBox.Show("User Library name must be supplied, aborting delete.");
				return;
			}
			
			int iRow = dgLibrary.SelectedIndex;
			string SelectedLibraryName = grid.GetCellValueAsString(dgLibrary, "LibraryName");
			LibName = SelectedLibraryName.Replace("\'", "\'\'");
			string SS = "";
			bool BB = false;
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			SS = "delete from GroupLibraryAccess where LibraryName = \'" + LibName + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSqlNewConn1);
			//EP.setSearchSvcEndPoint(proxy)
			string EncString = ENC2.EncryptPhrase(SS, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, EncString, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			SS = "delete from LibraryUsers where LibraryName = \'" + LibName + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed += new System.EventHandler(client_ExecuteSqlNewConn2);
			//EP.setSearchSvcEndPoint(proxy)
			SS = ENC2.EncryptPhrase(SS, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Async(GLOBALS._SecureID, GLOBALS.gRowID, SS, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			SS = "delete from LibraryItems where LibraryName = \'" + LibName + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed += new System.EventHandler(client_ExecuteSqlNewConn3);
			//EP.setSearchSvcEndPoint(proxy)
			SS = ENC2.EncryptPhrase(SS, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Async(GLOBALS._SecureID, GLOBALS.gRowID, SS, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			SS = "delete from Library  where LibraryName = \'" + LibName + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed += new System.EventHandler(client_ExecuteSqlNewConn4);
			//EP.setSearchSvcEndPoint(proxy)
			SS = ENC2.EncryptPhrase(SS, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Async(GLOBALS._SecureID, GLOBALS.gRowID, SS, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			string DelSql = "Delete from Library Where LibraryName = \'" + LibName + "\' and   UserID = \'" + GLOBALS._UserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed += new System.EventHandler(client_ExecuteSqlNewConn5);
			//EP.setSearchSvcEndPoint(proxy)
			DelSql = ENC2.EncryptPhrase(DelSql, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Async(GLOBALS._SecureID, GLOBALS.gRowID, DelSql, GLOBALS._UserID, GLOBALS.ContractID);
			
			cleanUpLibraryItems();
			
			
		}
		
		public void cleanUpLibraryItems()
		{
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			//Dim proxy As New SVCSearch.Service1Client
			
			string S = "";
			S = S + " delete from LibraryItems where " + "\r\n";
			S = S + " SourceGuid not in (select emailguid as TgtGuid from Email" + "\r\n";
			S = S + " union " + "\r\n";
			S = S + " select sourceguid as TgtGuid from DataSource)";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_3_34_42);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSqlNewConn1);
			//EP.setSearchSvcEndPoint(proxy)
			S = "delete FROM LibraryItems where LibraryName not in  (select LibraryName from Library)";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed += new System.EventHandler(client_ExecuteSqlNewConn2);
			//EP.setSearchSvcEndPoint(proxy)
			S = "delete from LibraryUsers where LibraryName not in  (select LibraryName from Library)";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed += new System.EventHandler(client_ExecuteSqlNewConn3);
			//EP.setSearchSvcEndPoint(proxy)
			S = "delete from LibraryUsers where UserID not in  (select userid from users)";
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed += new System.EventHandler(client_ExecuteSqlNewConn4);
			//EP.setSearchSvcEndPoint(proxy)
			S = "delete from GroupUsers where UserID not in (select userid from users) ";
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed += new System.EventHandler(client_ExecuteSqlNewConn5);
			//EP.setSearchSvcEndPoint(proxy)
			S = "delete from GroupUsers where GroupName not in (select GroupName from UserGroup) ";
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Async(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		public void client_ExecuteSqlNewConn_3_34_42(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_3_34_42: " + e.MySql));
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_3_34_42: 3_34_42" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_3_34_42: 3_34_42" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_3_34_42);
		}
		
		public void BtnAdd_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			//_UserGuid = _UserGuid
			
			string UserLibrary = txtLibrary.Text.Trim();
			UserLibrary = UserLibrary.Replace("\'", "\'\'");
			
			if (UserLibrary.Trim().Length == 0)
			{
				MessageBox.Show("User Library name must be supplied, aborting insert.");
				return;
			}
			
			AddLibrary();
			
			
		}
		
		public void AddLibrary()
		{
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			string LibraryName = txtLibrary.Text;
			LibraryName = LibraryName.Replace("\'", "\'\'");
			string S = "Select count(*) from Library where LibraryName = \'" + LibraryName + "\'";
			
			GLOBALS.ProxySearch.iCountCompleted += new System.EventHandler(client_iCountLibrary);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.iCountAsync(GLOBALS._SecureID, S);
			
		}
		
		public void client_iCountLibrary(object sender, SVCSearch.iCountCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				int I = System.Convert.ToInt32(e.Result);
				
				//_UserGuid = _UserGuid
				if (I == 1)
				{
					string YesNo = "";
					if (ckNewLibPublic.IsChecked)
					{
						YesNo = "Y";
					}
					else
					{
						YesNo = "N";
					}
					
					string LibName = txtLibrary.Text.Trim();
					LibName = LibName.Replace("\'", "\'\'");
					
					string s = "";
					s = s + " update Library set ";
					s = s + "isPublic = \'" + YesNo + "\' ";
					s = s + "where UserID = \'" + GLOBALS._UserID + "\' and LIbraryName = \'" + LibName + "\' ";
					
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_58_42_742);
					//EP.setSearchSvcEndPoint(proxy)
					s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
					
				}
				if (I == 0)
				{
					string YesNo = "";
					if (ckNewLibPublic.IsChecked)
					{
						YesNo = "Y";
					}
					else
					{
						YesNo = "N";
					}
					
					string LibName = txtLibrary.Text.Trim();
					LibName = LibName.Replace("\'", "\'\'");
					
					string s = "";
					s = s + " INSERT INTO Library(";
					s = s + "UserID,";
					s = s + "LibraryName,";
					s = s + "isPublic) values (";
					s = s + "\'" + GLOBALS._UserGuid + "\'" + ",";
					s = s + "\'" + LibName + "\'" + ",";
					s = s + "\'" + YesNo + "\'" + ")";
					
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					
					
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_58_42_742);
					//EP.setSearchSvcEndPoint(proxy)
					s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
					
					LU.setDeleteaccess("1");
					LU.setCreateaccess("1");
					LU.setLibraryname(ref LibName);
					LU.setLibraryowneruserid(GLOBALS._UserGuid);
					LU.setReadonly("0");
					LU.setUpdateaccess("1");
					LU.setUserid(GLOBALS._UserGuid);
					LU.Insert(1, 1, System.Convert.ToInt32(null));
					
					UpdateHiveNames();
					
					
				}
				else if (I < 0)
				{
					SB.Text = "Failed insert...";
				}
				else
				{
					SB.Text = "Library already exists, choose a different name.";
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 100: " + e.Error.Message));
			}
			
			GLOBALS.ProxySearch.iCountCompleted -= new System.EventHandler(client_iCountLibrary);
			
		}
		public void client_ExecuteSqlNewConn_58_42_742(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_58_42_742: " + e.MySql));
				}
				else
				{
					PopulateLibraryListBox();
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_58_42_742: 58_42_742" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_58_42_742: 58_42_742" + ErrSql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_58_42_742);
		}
		
		
		public void UpdateHiveNames()
		{
			
			HIVE.updateHiveRepoName("Library");
			HIVE.updateHiveRepoName("LibraryItems");
			HIVE.updateHiveRepoName("LibraryUsers");
			HIVE.updateHiveRepoName("LibEmail");
			HIVE.updateHiveRepoName("LibDirectory");
			
			HIVE.updateHiveServerName("Library");
			HIVE.updateHiveServerName("LibraryItems");
			HIVE.updateHiveServerName("LibraryUsers");
			HIVE.updateHiveServerName("LibEmail");
			HIVE.updateHiveServerName("LibDirectory");
			
		}
		
		
		public void PopulateLibraryListBox()
		{
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			dgLibrary.ItemsSource = null;
			
			string MySql = "Select [LibraryName] FROM [Library] where [UserID] = \'" + GLOBALS._UserGuid + "\' order by LibraryName";
			bool RC = false;
			string RetMsg = "";
			//Dim proxy As New SVCSearch.Service1Client
			
			GLOBALS.ProxySearch.PopulateLibraryGridCompleted += new System.EventHandler(client_PopulateListBox);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateLibraryGridAsync(SecureID, GLOBALS._UserGuid);
			
		}
		public void client_PopulateListBox(object sender, SVCSearch.PopulateLibraryGridCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			bool RC = false;
			string RetMsg = "";
			
			if (e.Error == null)
			{
				dgLibrary.ItemsSource = e.Result;
			}
			else
			{
				MessageBox.Show((string) ("Failed to populate Library Listbox." + e.Error.ToString()));
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 200: " + e.Error.Message));
				dgLibrary.ItemsSource = null;
				modGlobals.gErrorCount++;
			}
			PB.IsIndeterminate = false;
			GLOBALS.ProxySearch.PopulateLibraryGridCompleted -= new System.EventHandler(client_PopulateListBox);
			dgLibrary.IsEnabled = true;
		}
		
		public void hlHome_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			MainPage NextPage = new MainPage();
			this.Content = NextPage;
		}
		
		public void hlLibMgt_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageLibraryMgt NextPage = new PageLibraryMgt();
			this.Content = NextPage;
		}
		
		public void hlLibUsers_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageGrantContentToUsers NextPage = new PageGrantContentToUsers();
			this.Content = NextPage;
		}
		
		public void hlGroups_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageGroup NextPage = new PageGroup();
			this.Content = NextPage;
		}
		
		private void dt_ScrollChanged(object sender, ScrollChangedEventArgs e)
		{
			if (e.VerticalChange != 0)
			{
				FormLoaded = false;
				
				int I = dgLibrary.SelectedIndex;
				txtLibrary.Text = grid.GetCellValueAsString(dgLibrary, I, "LibraryName");
				
				bool bPublic = false;
				string C = grid.GetCellValueAsString(dgLibrary, I, "isPublic");
				if (C.ToUpper().Equals("Y"))
				{
					bPublic = true;
				}
				else
				{
					bPublic = false;
				}
				
				ckIsPublic.IsChecked = bPublic;
				
				FormLoaded = true;
				
			}
		}
		
		public void ckIsPublic_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (! FormLoaded)
			{
				return;
			}
			//_UserGuid = _UserGuid
			string LibName = txtLibrary.Text.Replace("\'", "\'\'");
			int II = dgLibrary.SelectedIndex;
			if (II < 0)
			{
				MessageBox.Show("An item in the list must be selected, returning.");
				return;
			}
			
			string S = "Update Library set isPublic = \'Y\' where Userid = \'" + GLOBALS._UserGuid + "\' and LibraryName = \'" + LibName + "\' ";
			
			//Dim proxy As New SVCSearch.Service1Client
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_1_43_344);
			//EP.setSearchSvcEndPoint(proxy)
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_ExecuteSqlNewConn_1_43_344(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_1_43_344: " + e.MySql));
				}
				else
				{
					PopulateLibraryListBox();
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_1_43_344: 1_43_344" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_1_43_344: 1_43_344" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_1_43_344);
		}
		
		public void ckIsPublic_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! FormLoaded)
			{
				return;
			}
			//_UserGuid = _UserGuid
			string LibName = txtLibrary.Text.Replace("\'", "\'\'");
			int II = dgLibrary.SelectedIndex;
			if (II < 0)
			{
				MessageBox.Show("An item in the list must be selected, returning.");
				return;
			}
			
			string S = "Update Library set isPublic = \'N\' where Userid = \'" + GLOBALS._UserGuid + "\' and LibraryName = \'" + LibName + "\' ";
			
			//Dim proxy As New SVCSearch.Service1Client
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_3_5_577);
			//EP.setSearchSvcEndPoint(proxy)
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
		}
		public void client_ExecuteSqlNewConn_3_5_577(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_3_5_577: " + e.MySql));
				}
				else
				{
					PopulateLibraryListBox();
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_3_5_577: 3_5_577" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_3_5_577: 3_5_577" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_3_5_577);
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
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSqlNewConn1);
			//EP.setSearchSvcEndPoint(proxy)
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
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed += new System.EventHandler(client_ExecuteSqlNewConn2);
			//EP.setSearchSvcEndPoint(proxy)
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
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed += new System.EventHandler(client_ExecuteSqlNewConn3);
			//EP.setSearchSvcEndPoint(proxy)
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
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed += new System.EventHandler(client_ExecuteSqlNewConn4);
			//EP.setSearchSvcEndPoint(proxy)
		}
		public void client_ExecuteSqlNewConn5(object sender, SVCSearch.ExecuteSqlNewConn5CompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					if (bPopulateLibraries)
					{
						PopulateLibraryListBox();
						bPopulateLibraries = false;
					}
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 600: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed += new System.EventHandler(client_ExecuteSqlNewConn5);
			//EP.setSearchSvcEndPoint(proxy)
		}
		~PageLibrary()
		{
			try
			{
				
			}
			finally
			{
				base.Finalize(); //define the destructor
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		public void hlRefreshLibs_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateLibraryListBox();
		}
		
		public void Page_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
		}
		
	}
	
}
