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
	public partial class popupGroupLibraries
	{
		//Inherits ChildWindow
		
		//Dim GVAR As App = App.Current
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim EP As New clsEndPoint
		clsUtility UTIL = new clsUtility();
		//Dim proxy As New SVCSearch.Service1Client
		string Userid;
		clsLogging LOG = new clsLogging();
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		ArrayList ListOfAssignedUsers = new ArrayList();
		object ObjListOfAssignedUsers = null;
		string GroupName = "";
		
		string GroupOwnerUserID = "";
		string LibOwnerUserID = "";
		string CurrLibName = "";
		
		bool bGroupLibraryAccessInsert = false;
		
		public popupGroupLibraries(string _GrpName)
		{
			InitializeComponent();
			//EP.setSearchSvcEndPoint(proxy)
			
			COMMON.SaveClick(6800, Userid);
			
			GroupName = _GrpName;
			Userid = GLOBALS._UserID;
			
			GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameCompleted += new System.EventHandler(client_getGroupOwnerGuidByGroupName);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameAsync(GLOBALS._SecureID, GroupName);
			
			if (GLOBALS._isAdmin)
			{
				ckShowAllLibs.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				ckShowAllLibs.Visibility = System.Windows.Visibility.Collapsed;
			}
			
			lblGroup.Content = "Group \'" + GroupName + "\' assigned libraries.";
			lblCurrGroup.Content = GroupName;
			
			PopulateLibraryListBox();
			PopulateLibraryComboBox();
			
			btnRemoveGroupFromLibrary.Visibility = Visibility.Collapsed;
			
		}
		public void client_getGroupOwnerGuidByGroupName(object sender, SVCSearch.getGroupOwnerGuidByGroupNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				GroupOwnerUserID = (string) e.Result;
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_getGroupOwnerGuidByGroupName 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameCompleted -= new System.EventHandler(client_getGroupOwnerGuidByGroupName);
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = true;
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = false;
		}
		
		public void client_GetLibOwnerByName(object sender, SVCSearch.GetLibOwnerByNameCompletedEventArgs e)
		{
			CurrLibName = cbLibrary.Text;
			if (e.Error == null)
			{
				LibOwnerUserID = (string) e.Result;
				try
				{
					if (GroupOwnerUserID.Length == 0)
					{
						MessageBox.Show("Could not determine owner of Group \'" + GroupName + "\', returning.");
						return;
					}
					if (LibOwnerUserID.Length == 0)
					{
						MessageBox.Show("Could not determine owner of Library \'" + CurrLibName + "\', returning.");
						return;
					}
					
					bGroupLibraryAccessInsert = true;
					GroupLibraryAccessInsert(CurrLibName);
					
				}
				catch (Exception ex)
				{
					MessageBox.Show((string) ("ERROR: client_GetLibOwnerByName 200 - " + ex.Message));
				}
			}
			else
			{
				LibOwnerUserID = "";
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_GetLibOwnerByName 100: " + e.Error.Message));
			}
			
			GLOBALS.ProxySearch.GetLibOwnerByNameCompleted -= new System.EventHandler(client_GetLibOwnerByName);
			
		}
		public void btnAddGroupToLibrary_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			ListOfAssignedUsers.Clear();
			
			CurrLibName = cbLibrary.Text;
			
			if (CurrLibName.Length == 0)
			{
				MessageBox.Show("Both a Group and Library must be selected... returning.");
				return;
			}
			
			GLOBALS.ProxySearch.GetLibOwnerByNameCompleted += new System.EventHandler(client_GetLibOwnerByName);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.GetLibOwnerByNameAsync(GLOBALS._SecureID, CurrLibName);
			
			btnRemoveGroupFromLibrary.Visibility = Visibility.Collapsed;
			
		}
		
		public void GroupLibraryAccessInsert(string LibraryName)
		{
			bGroupLibraryAccessInsert = true;
			string s = "";
			s = s + "if not exists (select GroupName from GroupLibraryAccess where GroupName = \'" + GroupName + "\' and GroupOwnerUserID = \'" + GroupOwnerUserID + "\' and LibraryName = \'" + LibraryName + "\' and UserID = \'" + GLOBALS._UserGuid + "\')";
			s = s + "BEGIN";
			s = s + " INSERT INTO GroupLibraryAccess(";
			s = s + "UserID,";
			s = s + "LibraryName,";
			s = s + "GroupOwnerUserID,";
			s = s + "GroupName) values (";
			s = s + "\'" + GLOBALS._UserGuid + "\'" + ",";
			s = s + "\'" + LibraryName + "\'" + ",";
			s = s + "\'" + GroupOwnerUserID + "\'" + ",";
			s = s + "\'" + GroupName + "\'" + ")";
			s = s + "END";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			bool RC = false;
			string RetMsg = "";
			int SSID = 0;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					if (bGroupLibraryAccessInsert)
					{
						bGroupLibraryAccessInsert = false;
						GLOBALS.ProxySearch.getGroupUsersCompleted += new System.EventHandler(client_getGroupUsers);
						//EP.setSearchSvcEndPoint(proxy)
						GLOBALS.ProxySearch.getGroupUsersAsync(GLOBALS._SecureID, lblCurrGroup.Content, ObjListOfAssignedUsers, RC, RetMsg);
						PopulateLibraryListBox();
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
		
		public void btnRemoveGroupFromLibrary_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			ListOfAssignedUsers.Clear();
			
			bool RC = false;
			string RetMsg = "";
			
			int iCnt = lbAssignedLibs.SelectedItems.Count;
			if (iCnt != 1)
			{
				MessageBox.Show("One and only one LIBRARY must be selected... returning.");
				return;
			}
			
			iCnt = lbAssignedLibs.SelectedIndex;
			string LibName = (string) lbAssignedLibs.SelectedItem;
			
			var msg = "This will remove the selected LIBRARY from the GROUP, are you sure?";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				SB.Text = "delete cancelled.";
				return;
			}
			
			string S = "Delete from GroupLibraryAccess Where GroupName = \'" + GroupName + "\' and   GroupOwnerUserID = \'" + GroupOwnerUserID + "\' and   LibraryName = \'" + LibName + "\' and   UserID = \'" + Userid + "\'";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_DeleteGroupLibraryAccess);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_DeleteGroupLibraryAccess(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			ListOfAssignedUsers.Clear();
			if (e.Error == null)
			{
				bool RC = false;
				string RetMsg = "";
				
				GLOBALS.ProxySearch.getGroupUsersCompleted += new System.EventHandler(client_getGroupUsers);
				//EP.setSearchSvcEndPoint(proxy)
				GLOBALS.ProxySearch.getGroupUsersAsync(GLOBALS._SecureID, GroupName, ObjListOfAssignedUsers, RC, RetMsg);
				
				PopulateLibraryListBox();
				
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_DeleteGroupLibraryAccess 100: failed to delete group: " + e.Error.Message));
				SB.Text = "ERROR client_DeleteGroupLibraryAccess 100: failed to delete group.";
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_DeleteGroupLibraryAccess);
		}
		public void client_getGroupUsers(object sender, SVCSearch.getGroupUsersCompletedEventArgs e)
		{
			ListOfAssignedUsers.Clear();
			bool RC = false;
			string RetMsg = "";
			if (e.Error == null)
			{
				
				GLOBALS.ProxySearch.cleanUpLibraryItemsAsync(GLOBALS._SecureID, GLOBALS._UserGuid);
				
				GLOBALS.ProxySearch.AddLibraryGroupUserCompleted += new System.EventHandler(client_AddLibraryGroupUser);
				//EP.setSearchSvcEndPoint(proxy)
				GLOBALS.ProxySearch.AddLibraryGroupUserAsync(GLOBALS._SecureID, GroupName, RC, RC, GLOBALS._UserID, GLOBALS.ContractID);
				
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_getGroupUsers 200: " + e.Error.Message));
			}
			
			GLOBALS.ProxySearch.getGroupUsersCompleted -= new System.EventHandler(client_getGroupUsers);
			
		}
		public void client_AddLibraryGroupUser(object sender, SVCSearch.AddLibraryGroupUserCompletedEventArgs e)
		{
			bool RC = false;
			string RetMsg = "";
			if (e.Error == null)
			{
				RC = System.Convert.ToBoolean(e.RC);
				GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted += new System.EventHandler(client_ResetLibraryUsersCount);
				//EP.setSearchSvcEndPoint(proxy)
				GLOBALS.ProxySearch.ResetLibraryUsersCountAsync(GLOBALS._SecureID, RC);
				this.Cursor = Cursors.Arrow;
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_AddLibraryGroupUser 200: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.AddLibraryGroupUserCompleted -= new System.EventHandler(client_AddLibraryGroupUser);
		}
		
		public void client_ResetLibraryUsersCount(object sender, SVCSearch.ResetLibraryUsersCountCompletedEventArgs e)
		{
			int SSID = 0;
			bool RC = false;
			string RetMsg = "";
			if (e.Error == null)
			{
				SB.Text = "Reset Library Users Count successful.";
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_AddLibraryGroupUser 200: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted -= new System.EventHandler(client_ResetLibraryUsersCount);
		}
		
		public void PopulateLibraryListBox()
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			System.Collections.ObjectModel.ObservableCollection<string> ListOfItems = new System.Collections.ObjectModel.ObservableCollection<string>();
			string S = "";
			
			string CurrGroup = UTIL.RemoveSingleQuotes((string) lblCurrGroup.Content);
			
			if (CurrGroup.Trim().Length == 0)
			{
				return;
			}
			
			CurrGroup = UTIL.RemoveSingleQuotes(CurrGroup);
			
			S = "select LibraryName from GroupLibraryAccess Where GroupName = \'" + CurrGroup + "\'";
			
			GLOBALS.ProxySearch.getListOfStrings01Completed += new System.EventHandler(client_PopulateLibraryListBox);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings01Async(GLOBALS._SecureID, GLOBALS.gRowID, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			
		}
		public void client_PopulateLibraryListBox(object sender, SVCSearch.getListOfStrings01CompletedEventArgs e)
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			//Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
			//Dim DS As SVCSearch.DS_ListOfStrings01
			
			lbAssignedLibs.Items.Clear();
			if (e.Error == null)
			{
				for (int I = 0; I <= e.Result.Count - 1; I++)
				{
					SVCSearch.DS_ListOfStrings01 VDS = new SVCSearch.DS_ListOfStrings01();
					VDS = e.Result(I);
					lbAssignedLibs.Items.Add(VDS.strItem);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				SB.Text = (string) ("ERROR client_PopulateLibraryComboBox 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryComboBox 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_PopulateLibraryComboBox);
		}
		
		public void PopulateLibraryComboBox()
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			List<string> ListOfItems = new List<string>();
			object ObjListOfItems = null;
			string S = "";
			
			if (ckShowAllLibs.IsChecked)
			{
				S = "SELECT [LibraryName] FROM [Library] order by LibraryName";
			}
			else
			{
				S = "SELECT [LibraryName] FROM [Library] where [UserID] = \'" + GLOBALS._UserGuid + "\' order by LibraryName";
			}
			
			GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_PopulateLibraryComboBox);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ObjListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			
		}
		public void client_PopulateLibraryComboBox(object sender, SVCSearch.getListOfStringsCompletedEventArgs e)
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			System.Collections.ObjectModel.ObservableCollection<string> ListOfItems = new System.Collections.ObjectModel.ObservableCollection<string>();
			
			cbLibrary.Items.Clear();
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
				SB.Text = (string) ("ERROR client_PopulateLibraryComboBox 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryComboBox 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_PopulateLibraryComboBox);
		}
		
		public void lbAssignedLibs_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			
			CurrLibName = (string) lbAssignedLibs.SelectedValue;
			btnRemoveGroupFromLibrary.Visibility = Visibility.Visible;
			
		}
		
		public void btnRefresh_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateLibraryComboBox();
		}
		
		public void popupGroupLibraries_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
		}
		
	}
	
}
