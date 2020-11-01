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
	public partial class PageGroup
	{
		
		//Dim GVAR As App = App.Current
		clsLogging LOG = new clsLogging();
		clsDma DMA = new clsDma();
		clsCommonFunctions COMMON = new clsCommonFunctions();
		clsUtility UTIL = new clsUtility();
		string UserID = "";
		string RetMsg = "";
		bool RC = false;
		
		string CurrentGroupName = "";
		string GroupOwnerGuid = "";
		List<string> AssignedUsers = new List<string>();
		
		//Dim proxy As New SVCSearch.Service1Client
		System.Collections.Generic.Dictionary<int, string> SlqDict = new System.Collections.Generic.Dictionary<int, string>();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		
		public PageGroup()
		{
			
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.Value = 0;
			
			//** Set global variables
			UserID = GLOBALS._UserID;
			modGlobals.gCurrUserGuidID = GLOBALS._UserGuid;
			
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSqlNewConn1);
			GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed += new System.EventHandler(client_ExecuteSqlNewConn2);
			GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed += new System.EventHandler(client_ExecuteSqlNewConn3);
			GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed += new System.EventHandler(client_ExecuteSqlNewConn4);
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed += new System.EventHandler(client_ExecuteSqlNewConn5);
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_InsertGroup
			//AddHandler ProxySearch.iCountCompleted, AddressOf client_GroupIcount
			//AddHandler ProxySearch.iCountCompleted, AddressOf client_UserExistsElsewhereCount
			//AddHandler ProxySearch.PopulateGroupUserGridCompleted, AddressOf client_PopulateGroupUserGrid
			//AddHandler ProxySearch.getGroupOwnerGuidByGroupNameCompleted, AddressOf client_DeleteGroupMembersByOwnerGuid
			//AddHandler ProxySearch.DeleteGroupUsersCompleted, AddressOf client_DeleteGroupUsers
			
			
			if (GLOBALS._isAdmin)
			{
				HyperlinkButton1.Visibility = Visibility.Visible;
			}
			else
			{
				HyperlinkButton1.Visibility = Visibility.Collapsed;
			}
			PopulateGroupListbox();
			
		}
		
		public void hlGroupLibs_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			popupGroupLibraries cw = new popupGroupLibraries(CurrentGroupName);
			cw.Show();
		}
		
		public void hlHome_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//Dim NextPage As New MainPage()
			MainPage NextPage = new MainPage();
			this.Content = NextPage;
		}
		
		public void hlLibMgt_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageLibrary NextPage = new PageLibrary();
			this.Content = NextPage;
		}
		
		public void BtnAdd_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			DMA.ReplaceSingleTick(txtUserGroup.Text);
			string GroupName = txtUserGroup.Text.Trim();
			if (GroupName.Trim().Length == 0)
			{
				MessageBox.Show("The group name appears to be blank, it cannot be blank.");
				return;
			}
			
			CurrentGroupName = GroupName;
			
			string tGroupName = txtUserGroup.Text.Trim();
			GroupName = UTIL.RemoveSingleQuotes(GroupName);
			
			
			string S = "Select count(*) from UserGroup where GroupName = \'" + GroupName + "\'";
			GLOBALS.ProxySearch.iCountCompleted += new System.EventHandler(client_GroupIcount);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.iCountAsync(GLOBALS._SecureID, S);
		}
		public void client_GroupIcount(object sender, SVCSearch.iCountCompletedEventArgs e)
		{
			int RC = 0;
			int SSID = 0;
			string RetMsg = "";
			int I = 0;
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				I = System.Convert.ToInt32(e.Result);
				if (I == 0)
				{
					string s = "";
					s = s + " INSERT INTO UserGroup(";
					s = s + "GroupOwnerUserID,";
					s = s + "GroupName) values (";
					s = s + "\'" + GLOBALS._UserGuid + "\'" + ",";
					s = s + "\'" + CurrentGroupName + "\'" + ")";
					
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecInsertGroup);
					//EP.setSearchSvcEndPoint(proxy)
					s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
					PB.IsIndeterminate = true;
					PB.Visibility = System.Windows.Visibility.Visible;
					
					GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
				}
				else
				{
					MessageBox.Show("The group name \'" + txtUserGroup.Text.Trim() + "\' has already been used. " + "\r\n" + "Names must be unique across the organization. Please pick another.");
					return;
				}
			}
			else
			{
				dgUsers.ItemsSource = null;
				SB.Text = (string) ("ERROR client_GroupIcount 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_GroupIcount 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.iCountCompleted -= new System.EventHandler(client_GroupIcount);
		}
		public void client_InsertGroup(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			int I = 0;
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				SB.Text = "Group created.";
				PopulateGroupListbox();
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_InsertGroup 100: ERRR - " + " : " + e.Error.Message));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecInsertGroup);
		}
		
		public void client_ExecInsertGroup(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int RC = 0;
			int SSID = 0;
			string RetMsg = "";
			int I = 0;
			if (e.Error == null)
			{
				SB.Text = "Successful insert...";
				PopulateGroupListbox();
			}
			else
			{
				SB.Text = "Failed insert...";
			}
		}
		public void btnDelete_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			bool B = false;
			int II = System.Convert.ToInt32(this.lbGroups.SelectedIndex);
			if (II < 0)
			{
				MessageBox.Show("An item in the list must be selected, returning.");
				return;
			}
			
			string UserGroup = (string) lbGroups.SelectedValue;
			string tUserGroup = UserGroup;
			
			if (UserGroup.Trim().Length == 0)
			{
				MessageBox.Show("User group name must be supplied, aborting insert.");
				return;
			}
			
			UserGroup = UTIL.RemoveSingleQuotes(UserGroup);
			
			var msg = "This will delete the selected GROUP, group users and all group library access, are you sure?";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				SB.Text = "delete cancelled.";
				return;
			}
			
			for (int i = 0; i <= dgUsers.Items.Count - 1; i++)
			{
				dgUsers.Items[i].Selected = true;
			}
			DeleteSelectedUsers();
			
			SlqDict.Clear();
			try
			{
				string s = "delete FROM [GroupUsers] where [GroupName] = \'" + UserGroup + "\'";
				SlqDict.Add(0, s);
				
				s = "delete from [GroupLibraryAccess] where GroupName = \'" + UserGroup + "\'";
				SlqDict.Add(1, s);
				
				s = "delete FROM [UserGroup] where [GroupName] = \'" + UserGroup + "\'";
				SlqDict.Add(2, s);
				
				UserGroupDelete(tUserGroup, modGlobals.gCurrUserGuidID);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR Group may be corrupt, please have an ADMIN clean out the group." + "\r\n" + ex.Message));
				return;
			}
			
			
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			try
			{
				this.Cursor = Cursors.Wait;
				//** WDM Removed 5/15/2010
				if (B)
				{
					SB.Text = "Successful delete of group " + UserGroup + ".";
					//    CKAT.NotifyGroupAssigments(tUserGroup$, AssignedUsers, "Remove")
					PopulateGroupListbox();
				}
				else
				{
					SB.Text = "Failed delete...";
				}
			}
			catch (Exception)
			{
				this.Cursor = Cursors.Arrow;
			}
			this.Cursor = Cursors.Arrow;
		}
		
		public void UserGroupDelete(string GroupName, string GroupOwnerUserID)
		{
			bool b = false;
			
			string s = " Delete from UserGroup Where GroupName = \'" + GroupName + "\' and   GroupOwnerUserID = \'" + GroupOwnerUserID + "\'";
			SlqDict.Add(3, s);
			
			GLOBALS.ProxySearch.ExecuteSqlStackCompleted += new System.EventHandler(client_ExecuteSqlStack);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ExecuteSqlStackAsync(GLOBALS._SecureID, SlqDict, GLOBALS._UserID, GLOBALS.ContractID, "SRCH");
			
		}
		public void client_ExecuteSqlStack(object sender, SVCSearch.ExecuteSqlStackCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int RC = 0;
			int SSID = 0;
			string RetMsg = "";
			if (e.Error == null)
			{
				SB.Text = "Group and all associated members removed.";
				PopulateGroupListbox();
			}
			else
			{
				SB.Text = (string) ("ERROR client_ExecuteSqlStack Group not removed 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlStack 100: " + e.Error.Message));
				MessageBox.Show((string) ("ERROR client_ExecuteSqlStack Group not removed 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.AddLibraryGroupUserCompleted -= new System.EventHandler(client_AddLibraryGroupUser);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			PopulateUserGrid((string) lbGroups.SelectedValue);
		}
		public void btnAddToGroup_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			AssignedUsers.Clear();
			if (lbGroups.SelectedItems.Count == 0)
			{
				SB.Text = "You must select a group from the list, returning...";
				return;
			}
			int iAdded = 0;
			int iSkipped = 0;
			
			bool B = false;
			string GroupName = (string) lbGroups.SelectedValue;
			
			if (GroupName.Trim().Length == 0)
			{
				SB.Text = "You must select a group from the list, returning...";
				return;
			}
			
			string UserName = "";
			string UID = "";
			string FullAccess = "";
			string ReadOnlyAccess = "";
			string DeleteAccess = "";
			string Searchable = "";
			
			int I = dgUsers.SelectedItems.Count;
			
			if (I == 0)
			{
				MessageBox.Show("A user must be selected to add... please select a user.");
				return;
			}
			
			
			
			foreach (DataGridRow drow in dgUsers.SelectedItems)
			{
				//I = drow.Index
				UserName = grid.GetCellValueAsString(dgUsers, 1);
				UID = grid.GetCellValueAsString(dgUsers, 0);
				
				FullAccess = true.ToString();
				ReadOnlyAccess = true.ToString();
				DeleteAccess = true.ToString();
				Searchable = true.ToString();
				
				FullAccess = grid.GetCellValueAsString(dgUsers, 2);
				ReadOnlyAccess = grid.GetCellValueAsString(dgUsers, 3);
				DeleteAccess = grid.GetCellValueAsString(dgUsers, 4);
				Searchable = grid.GetCellValueAsString(dgUsers, 5);
				
				InsertGroupUser(GroupName, modGlobals.gCurrUserGuidID, UID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable);
				AssignedUsers.Add(UID);
			}
			
			try
			{
				//CKAT.NotifyGroupAssigments(GroupName$, AssignedUsers, "Assigned")
				SB.Text = iAdded.ToString() + " users added, " + iSkipped.ToString() + " skipped.";
			}
			catch (Exception)
			{
				SB.Text = "ERROR: did not add " + iAdded.ToString() + " users, " + iSkipped.ToString() + " skipped.";
			}
			
			GLOBALS.ProxySearch.AddLibraryGroupUserCompleted += new System.EventHandler(client_AddLibraryGroupUser);
			//EP.setSearchSvcEndPoint(proxy)
			//AddLibraryGroupUser(ByRef SecureID As string, ByVal GroupName As String, ByRef RC As Boolean, CurrUserID As String, SessionID  )
			GLOBALS.ProxySearch.AddLibraryGroupUserAsync(GLOBALS._SecureID, GroupName, RC, GLOBALS._UserID, GLOBALS.ContractID, "SRCH");
			
			//ckBoxShowAllUsers.IsChecked = False
		}
		public void client_AddLibraryGroupUser(object sender, SVCSearch.AddLibraryGroupUserCompletedEventArgs e)
		{
			int RC = 0;
			int SSID = 0;
			string RetMsg = "";
			if (e.Error == null)
			{
				SB.Text = "Library group users added.";
				MessageBox.Show("Library group users added.");
			}
			else
			{
				SB.Text = (string) ("ERROR client_AddLibraryGroupUser 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_AddLibraryGroupUser 100: " + e.Error.Message));
				MessageBox.Show((string) ("ERROR client_AddLibraryGroupUser 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.AddLibraryGroupUserCompleted -= new System.EventHandler(client_AddLibraryGroupUser);
			PopulateUserGrid((string) lbGroups.SelectedValue);
		}
		
		public void InsertGroupUser(string GroupName, string GroupOwnerUserID, string UserID, string FullAccess, string ReadOnlyAccess, string DeleteAccess, string Searchable)
		{
			bool b = false;
			string s = "";
			
			if (Searchable.ToUpper() == "TRUE")
			{
				Searchable = "1";
			}
			else
			{
				Searchable = "0";
			}
			if (DeleteAccess.ToUpper() == "TRUE")
			{
				DeleteAccess = "1";
			}
			else
			{
				DeleteAccess = "0";
			}
			if (ReadOnlyAccess.ToUpper() == "TRUE")
			{
				ReadOnlyAccess = "1";
			}
			else
			{
				ReadOnlyAccess = "0";
			}
			if (FullAccess.ToUpper() == "TRUE")
			{
				FullAccess = "1";
			}
			else
			{
				FullAccess = "0";
			}
			
			//AddGroupUser(SecureID As string, SessionID As String, UserID As String, FullAccess As String, ReadOnlyAccess As String, DeleteAccess As String, Searchable As String, GroupOwnerUserID As String, GroupName  )
			
			string EncString = ENC2.EncryptPhrase(UserID, "ABCD1234");
			
			GLOBALS.ProxySearch.AddGroupUserCompleted += new System.EventHandler(client_AddGroupUser);
			GLOBALS.ProxySearch.AddGroupUserAsync(GLOBALS._SecureID, GLOBALS.ContractID, GLOBALS._UserID, UserID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable, GroupOwnerGuid, GroupName, "SRCH");
			
			
			
		}
		public void client_AddGroupUser(object sender, SVCSearch.AddGroupUserCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				if (e.Result == true)
				{
					SB.Text = "Successfully added.";
				}
				else
				{
					SB.Text = "FAILED to add user(s).";
				}
			}
			else
			{
				MessageBox.Show("FAILED to add user(s).");
			}
			
			GLOBALS.ProxySearch.AddGroupUserCompleted -= new System.EventHandler(client_AddGroupUser);
			
		}
		public void btnRemove_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			AssignedUsers.Clear();
			string GroupName = "";
			//Dim DR As DataRowView
			int iDeleted = 0;
			int iSkipped = 0;
			
			if (lbGroups.SelectedItems.Count == 1)
			{
				GroupName = (string) lbGroups.SelectedValue;
			}
			else
			{
				SB.Text = "ONLY ONE GROUP MUST BE SELECTED, returning.";
				return;
			}
			
			int II = System.Convert.ToInt32(this.dgUsers.SelectedItems.Count);
			
			if (II == 0)
			{
				MessageBox.Show("A user must be selected in order to remove... please select a user.");
				return;
			}
			
			var msg = "This will delete the selected user(s) from the GROUP \'" + GroupName + "\', are you sure?";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				SB.Text = "delete cancelled.";
				return;
			}
			
			DeleteSelectedUsers();
			
			try
			{
				//CKAT.NotifyGroupAssigments(GroupName, AssignedUsers, "Remove")
			}
			catch (Exception)
			{
				SB.Text = "Failed to notify users.";
			}
			
			SB.Text = "User(s) removed from group, " + iSkipped.ToString() + " users skipped.";
			
			GLOBALS.ProxySearch.cleanUpLibraryItemsAsync(GLOBALS._SecureID, GLOBALS._UserGuid);
			
			GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted += new System.EventHandler(client_ResetLibraryUsersCount);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ResetLibraryUsersCountAsync(GLOBALS._SecureID, RC);
			
		}
		
		public void client_ResetLibraryUsersCount(object sender, SVCSearch.ResetLibraryUsersCountCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			int RC = 0;
			int SSID = 0;
			string RetMsg = "";
			if (e.Error == null)
			{
				SB.Text = "Library items Count Reset.";
			}
			else
			{
				SB.Text = (string) ("ERROR client_ResetLibraryUsersCount 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_ResetLibraryUsersCount 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.ResetLibraryUsersCountCompleted -= new System.EventHandler(client_ResetLibraryUsersCount);
		}
		
		public void AddOwnerToGroup(string GroupName)
		{
			
			//Dim GroupName$ = txtUserGroup.Text.Trim
			if (GroupName.Length == 0)
			{
				MessageBox.Show("No group name was suppleid, returning.");
				return;
			}
			
			var UID = GLOBALS._UserGuid;
			var FullAccess = "0";
			var ReadOnlyAccess = "0";
			var DeleteAccess = "0";
			var Searchable = "0";
			
			InsertGroupUser(GroupName, GroupOwnerGuid, modGlobals.gCurrUserGuidID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable);
			AssignedUsers.Add(UID);
			PopulateUserGrid(GroupName);
			
		}
		
		public void PopulateUserGrid(string GroupName)
		{
			
			if (lbGroups.SelectedItems.Count != 1)
			{
				PB.IsIndeterminate = false;
				PB.Visibility = System.Windows.Visibility.Collapsed;
				SB.Text = "One and only one group must be selected.";
				return;
			}
			
			if (GroupName.Length == 0)
			{
				GroupName = "!@#$";
			}
			GroupName = (string) lbGroups.SelectedItem;
			
			string S = "";
			S = S + " SELECT   distinct  Users.UserName, Users.UserID AS UserID, GroupUsers.FullAccess, GroupUsers.ReadOnlyAccess, GroupUsers.DeleteAccess, GroupUsers.Searchable" + "\r\n";
			S = S + " FROM         GroupUsers RIGHT OUTER JOIN" + "\r\n";
			S = S + "           Users ON GroupUsers.UserID = Users.UserID" + "\r\n";
			S = S + " WHERE     (GroupUsers.GroupOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\') AND (GroupUsers.GroupName = \'" + GroupName + "\')" + "\r\n";
			S = S + " order by Users.UserName";
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.PopulateGroupUserGridCompleted += new System.EventHandler(client_PopulateGroupUserGrid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateGroupUserGridAsync(GLOBALS._SecureID, GroupName);
			
		}
		
		public void client_PopulateGroupUserGrid(object sender, SVCSearch.PopulateGroupUserGridCompletedEventArgs e)
		{
			int RC = 0;
			int SSID = 0;
			string RetMsg = "";
			dgUsers.ItemsSource = null;
			
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				dgUsers.ItemsSource = e.Result;
			}
			else
			{
				dgUsers.ItemsSource = null;
				SB.Text = (string) ("ERROR client_PopulateGroupUserGrid 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateGroupUserGrid 100: " + e.Error.Message));
			}
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			GLOBALS.ProxySearch.PopulateGroupUserGridCompleted -= new System.EventHandler(client_PopulateGroupUserGrid);
		}
		
		public void DeleteSelectedUsers()
		{
			
			string GroupName = "";
			int iDeleted = 0;
			int iSkipped = 0;
			//Dim drow As C1.Silverlight.FlexGrid.Row
			
			if (lbGroups.SelectedItems.Count != 1)
			{
				MessageBox.Show("One and only one group must be selected, returning.");
				return;
			}
			else
			{
				int IX = lbGroups.SelectedIndex;
				GroupName = lbGroups.SelectedItems[0];
				CurrentGroupName = GroupName;
			}
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameCompleted += new System.EventHandler(client_DeleteGroupMembersByOwnerGuid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameAsync(GLOBALS._SecureID, GroupName);
			
			
		}
		public void client_DeleteGroupMembersByOwnerGuid(object sender, SVCSearch.getGroupOwnerGuidByGroupNameCompletedEventArgs e)
		{
			
			try
			{
				GLOBALS.ProxySearch.DeleteGroupUsersCompleted -= new System.EventHandler(client_DeleteGroupUsers);
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			string RetMsg = "";
			string SelectedUserIDs = "";
			
			int TrackingNbr = 0;
			if (e.Error == null)
			{
				
				GLOBALS.ProxySearch.DeleteGroupUsersCompleted += new System.EventHandler(client_DeleteGroupUsers);
				//EP.setSearchSvcEndPoint(proxy)
				
				string OwnerGuid = (string) e.Result;
				foreach (var drow in this.dgUsers.SelectedItems)
				{
					
					int UserIdCol = 1;
					int I = System.Convert.ToInt32(drow.Index);
					var UserName = drow(0);
					string UID = System.Convert.ToString(drow(1));
					//Dim FullAccess$ = drow(2)
					//Dim ReadOnlyAccess$ = drow(3)
					//Dim DeleteAccess$ = drow(4)
					//Dim Searchable$ = drow(5)
					
					if (UID.Equals(OwnerGuid))
					{
						goto SKIPIT;
					}
					
					SelectedUserIDs = SelectedUserIDs + UserName + ";";
					
SKIPIT:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_DeleteGroupMembersByOwnerGuid 100: " + e.Error.Message));
			}
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			int iDeleted = 0;
			GLOBALS.ProxySearch.DeleteGroupUsersAsync(GLOBALS._SecureID, CurrentGroupName, GroupOwnerGuid, SelectedUserIDs, iDeleted, RetMsg);
			
			GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameCompleted -= new System.EventHandler(client_DeleteGroupMembersByOwnerGuid);
			
		}
		public void client_DeleteGroupUsers(object sender, SVCSearch.DeleteGroupUsersCompletedEventArgs e)
		{
			int TrackingNbr = 0;
			int RemovedUsers = 0;
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				PopulateUserGrid((string) lbGroups.SelectedValue);
				bool B = System.Convert.ToBoolean(e.Result);
				RemovedUsers = System.Convert.ToInt32(e.iDeleted);
				if (! B)
				{
					MessageBox.Show((string) ("Failed to remove all selected group members: " + e.RetMsg));
				}
				else
				{
					MessageBox.Show("Members removed.");
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_DeleteGroupUsers 100: " + e.Error.Message));
			}
			//RemoveHandler ProxySearch.DeleteGroupUsersCompleted, AddressOf client_DeleteGroupUsers
		}
		
		public void PopulateGroupListbox()
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			//Dim ListOfItems As New System.Collections.Generic.List(Of String)
			string[] ListOfItems = null;
			
			
			string S = "Select [GroupName] FROM [UserGroup] where [GroupOwnerUserID] = \'" + modGlobals.gCurrUserGuidID + "\' order by GroupName";
			
			GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_RepopulateGroupListbox);
			//EP.setSearchSvcEndPoint(proxy)
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			ListOfItems = null;
			GC.Collect();
			
			//** Called by a popup screen
			//PopulateLibCombo()
			
		}
		public void client_RepopulateGroupListbox(object sender, SVCSearch.getListOfStringsCompletedEventArgs e)
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			System.Collections.ObjectModel.ObservableCollection<string> ListOfItems = new System.Collections.ObjectModel.ObservableCollection<string>();
			
			lbGroups.Items.Clear();
			if (e.Error == null)
			{
				foreach (string S in e.ListOfItems)
				{
					lbGroups.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				SB.Text = (string) ("ERROR client_RepopulateGroupListbox 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_RepopulateGroupListbox 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_RepopulateGroupListbox);
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
		}
		
		public void ckUserExistsElsewhere(string TcbLibraryName, string UserID, string UserName)
		{
			string S = "";
			
			TcbLibraryName = UTIL.RemoveSingleQuotes(TcbLibraryName);
			S = S + " select COUNT (*) from libraryusers where UserID = \'" + UserID + "\' ";
			S = S + " and LibraryName = \'" + TcbLibraryName + "\'";
			
			GLOBALS.ProxySearch.iCountCompleted += new System.EventHandler(client_UserExistsElsewhereCount);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.iCountContentAsync(GLOBALS._SecureID, S);
			
		}
		public void client_UserExistsElsewhereCount(object sender, SVCSearch.iCountCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				int iCnt = System.Convert.ToInt32(e.Result);
				if (iCnt > 0)
				{
					MessageBox.Show("Warning - This user still has access to this library through a group entry.");
				}
			}
			else
			{
				SB.Text = (string) ("ERROR client_UserExistsElsewhereCount 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_UserExistsElsewhereCount 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.iCountCompleted -= new System.EventHandler(client_UserExistsElsewhereCount);
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
		}
		public void lbGroups_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			
			if (lbGroups.SelectedItems.Count == 1)
			{
				CurrentGroupName = lbGroups.SelectedValue.ToString();
			}
			
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			PopulateUserGrid(CurrentGroupName);
			
		}
		
		public void HyperlinkButton3_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			string BlankGroupName = "";
			GLOBALS.ProxySearch.PopulateGroupUserGridCompleted += new System.EventHandler(client_PopulateGroupUserGrid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateGroupUserGridAsync(GLOBALS._SecureID, BlankGroupName);
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
		}
		
		public void HyperlinkButton1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			System.Collections.ObjectModel.ObservableCollection<string> ListOfItems = new System.Collections.ObjectModel.ObservableCollection<string>();
			object ObjListOfItems = null;
			
			if (GLOBALS._isAdmin)
			{
				string S = "Select [GroupName] FROM [UserGroup] order by GroupName";
				
				GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_RepopulateGroupListbox);
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ObjListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
				
				ListOfItems = null;
				GC.Collect();
			}
			else
			{
				PopulateGroupListbox();
			}
		}
		
		public void HyperlinkButton2_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateGroupListbox();
		}
		
		public void HyperlinkButton4_Click_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (lbGroups.SelectedItems.Count == 0)
			{
				SB.Text = "One group must be selected!";
				return;
			}
			CurrentGroupName = (string) lbGroups.SelectedItem;
			PopulateUserGrid(CurrentGroupName);
		}
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				int TrackingNbr = int.Parse(GLOBALS.gRowID);
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn 100: " + GLOBALS.gRowID.ToString() + " : " + e.Error.Message + " : " + e.MySql));
			}
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
		}
		
		public void client_ExecuteSqlNewConn1(object sender, SVCSearch.ExecuteSqlNewConn1CompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn1 200: " + e.Error.Message));
			}
			//RemoveHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
		}
		public void client_ExecuteSqlNewConn2(object sender, SVCSearch.ExecuteSqlNewConn2CompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn2 300: " + e.Error.Message));
			}
			//RemoveHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
		}
		public void client_ExecuteSqlNewConn3(object sender, SVCSearch.ExecuteSqlNewConn3CompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn3 400: " + e.Error.Message));
			}
			//RemoveHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
		}
		public void client_ExecuteSqlNewConn4(object sender, SVCSearch.ExecuteSqlNewConn4CompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn4 500: " + e.Error.Message));
			}
			//RemoveHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
		}
		public void client_ExecuteSqlNewConn5(object sender, SVCSearch.ExecuteSqlNewConn5CompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					PopulateGroupListbox();
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn5 600: " + e.Error.Message));
			}
			//RemoveHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
		}
		
		~PageGroup()
		{
			try
			{
			}
			finally
			{
				base.Finalize(); //define the destructor
				
				GLOBALS.ProxySearch.iCountCompleted -= new System.EventHandler(client_GroupIcount);
				GLOBALS.ProxySearch.getGroupOwnerGuidByGroupNameCompleted -= new System.EventHandler(client_DeleteGroupMembersByOwnerGuid);
				GLOBALS.ProxySearch.DeleteGroupUsersCompleted -= new System.EventHandler(client_DeleteGroupUsers);
				GLOBALS.ProxySearch.iCountCompleted -= new System.EventHandler(client_UserExistsElsewhereCount);
				GLOBALS.ProxySearch.PopulateGroupUserGridCompleted -= new System.EventHandler(client_PopulateGroupUserGrid);
				GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_RepopulateGroupListbox);
				
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
				GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed -= new System.EventHandler(client_ExecuteSqlNewConn1);
				GLOBALS.ProxySearch.ExecuteSqlNewConn2Completed -= new System.EventHandler(client_ExecuteSqlNewConn2);
				GLOBALS.ProxySearch.ExecuteSqlNewConn3Completed -= new System.EventHandler(client_ExecuteSqlNewConn3);
				GLOBALS.ProxySearch.ExecuteSqlNewConn4Completed -= new System.EventHandler(client_ExecuteSqlNewConn4);
				GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed -= new System.EventHandler(client_ExecuteSqlNewConn5);
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
	}
	
}
