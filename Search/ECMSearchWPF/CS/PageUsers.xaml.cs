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
	public partial class PageUsers
	{
		//Inherits Page
		
		//Dim proxy As New SVCSearch.Service1Client
		clsLogging LOG = new clsLogging();
		//Dim EP As New clsEndPoint
		
		string SecureID;
		
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		//Dim GVAR As App = App.Current
		string UserID = "";
		clsCommonFunctions COMMON = new clsCommonFunctions();
		
		string CurrSelectedUserGuid = "";
		string SelectedUserID = "";
		string SelectedUserName = "";
		string SelectedEmailAddress = "";
		string SelectedUserPassword = "";
		string SelectedAdmin = "";
		string SelectedIsActive = "";
		bool Formloaded = false;
		string SelectedCOUserID = "";
		string SelectedCOUserName = "";
		string CoOwnerRowID = "";
		int CurrentlySelectedUserGridRow = 0;
		bool bHelpLoaded = false;
		bool bGridLoaded = false;
		
		public PageUsers()
		{
			InitializeComponent();
			
			//EP.setSearchSvcEndPoint(proxy)
			
			if (GLOBALS._isAdmin)
			{
				btnAdd.Visibility = Visibility.Visible;
			}
			else
			{
				btnAdd.Visibility = Visibility.Collapsed;
				btnDelete.Visibility = Visibility.Collapsed;
				Label7.Visibility = Visibility.Collapsed;
				Label8.Visibility = Visibility.Collapsed;
				Label9.Visibility = Visibility.Collapsed;
				cbCurrentOwner.Visibility = Visibility.Collapsed;
				cbRefactoredOwner.Visibility = Visibility.Collapsed;
				btnRefactor.Visibility = Visibility.Collapsed;
				ckActive.Visibility = Visibility.Collapsed;
				ckClientOnly.Visibility = Visibility.Collapsed;
				cbUserType.IsEnabled = false;
			}
			
			Formloaded = false;
			//** Set global variables
			UserID = GLOBALS._UserID;
			modGlobals.gCurrUserGuidID = GLOBALS._UserGuid;
			
			COMMON.SaveClick(6500, UserID);
			
			//AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
			//AddHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
			//AddHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
			//AddHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
			//AddHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_changeOwnership
			
			PopulateUserGrid();
			PopUserCombo();
			
			Formloaded = true;
			
		}
		
		public void GetSelectedRowData()
		{
			try
			{
				
				//Dim iRows As Integer = dgUsers.SelectedItems.count
				//If iRows <> 1 Then
				//    Return
				//End If
				
				//Dim DR As C1.Silverlight.FlexGrid.Row
				int iRow = dgUsers.SelectedIndex;
				
				//DR = dgUsers.SelectedItems(iRow)
				
				CurrentlySelectedUserGridRow = iRow;
				CurrSelectedUserGuid = grid.GetCellValueAsString(dgUsers, iRow, "UserLoginID");
				SelectedUserID = grid.GetCellValueAsString(dgUsers, iRow, "UserLoginID");
				SelectedUserName = grid.GetCellValueAsString(dgUsers, iRow, "UserName");
				SelectedEmailAddress = grid.GetCellValueAsString(dgUsers, iRow, "EmailAddress");
				//SelectedUserPassword = grid.GetCellValueAsString(dgUsers,  iRow,"UserPassword")
				SelectedUserPassword = "";
				
				var CurrentlySelectedUserGuid = "";
				if (GLOBALS._isAdmin == false)
				{
					if (CurrSelectedUserGuid != modGlobals.gCurrUserGuidID)
					{
						btnAdd.IsEnabled = false;
						btnUpdate.IsEnabled = false;
						btnDelete.IsEnabled = false;
						cbUserType.IsEnabled = false;
						ckActive.IsEnabled = false;
						txtPassword.IsEnabled = false;
						btnMakePublic.IsEnabled = false;
					}
					else
					{
						btnAdd.IsEnabled = false;
						btnUpdate.IsEnabled = true;
						btnDelete.IsEnabled = false;
						cbUserType.IsEnabled = false;
						ckActive.IsEnabled = false;
						txtPassword.IsEnabled = true;
						btnMakePublic.IsEnabled = true;
					}
				}
				else
				{
					btnAdd.IsEnabled = true;
					btnUpdate.IsEnabled = true;
					btnDelete.IsEnabled = true;
					cbUserType.IsEnabled = true;
					ckActive.IsEnabled = true;
					txtPassword.IsEnabled = true;
					btnMakePublic.IsEnabled = true;
				}
				
				//Try
				//    Dim SS$ = ENC2.DecryptPhrase(SelectedUserPassword)
				//    'messagebox.show(SS)
				//    SB.Text = "Decrypted password: " + SS
				//    SelectedUserPassword = SS
				//Catch ex As Exception
				//    SelectedUserPassword = ""
				//End Try
				
				string SelectedAdmin = grid.GetCellValueAsString(dgUsers, "Admin");
				string SelectedIsActive = grid.GetCellValueAsString(dgUsers, "isActive");
				
				this.txtEmail.Text = SelectedEmailAddress;
				this.txtPassword.Password = SelectedUserPassword;
				this.txtUserID.Text = SelectedUserID;
				this.txtUserName.Text = SelectedUserName;
				
				if (SelectedAdmin.Equals("A"))
				{
					this.cbUserType.Text = "Administrator";
				}
				else if (SelectedAdmin.Equals("S"))
				{
					this.cbUserType.Text = "Super Administrator";
				}
				else if (SelectedAdmin.Equals("G"))
				{
					this.cbUserType.Text = "Global Searcher";
				}
				else
				{
					this.cbUserType.Text = "User - Standard";
				}
				
				if (SelectedIsActive.Equals("Y"))
				{
					this.ckActive.IsChecked = true;
				}
				else
				{
					this.ckActive.IsChecked = false;
				}
				
				var sClientOnly = grid.GetCellValueAsString(dgUsers, "ClientOnly");
				if (sClientOnly.Equals("Y"))
				{
					this.ckClientOnly.IsChecked = true;
				}
				else
				{
					this.ckClientOnly.IsChecked = false;
				}
				
				PopulateCoOwnerGrid(CurrSelectedUserGuid);
				
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
		}
		private void setColOrder()
		{
			ReorderDgContentCols("UserLoginID", 0);
			ReorderDgContentCols("UserName", 1);
			ReorderDgContentCols("isActive", 2);
		}
		private void ReorderDgContentCols(string ColName, int ColDisplayOrder)
		{
			
			try
			{
				//Dim I As Integer = grid.getColumnIndexByName(dgUsers, ColName)
				//Dim col As DataGridColumn = dgUsers.Columns(I)
				//dgUsers.Columns.Remove(col)
				//dgUsers.Columns.Insert(ColDisplayOrder, col)
				dgUsers.Columns[0].DisplayIndex = ColDisplayOrder;
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
		}
		public void hlHome_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			MainPage NextPage = new MainPage();
			this.Content = NextPage;
		}
		
		private void dt_ScrollChanged(object sender, ScrollChangedEventArgs e)
		{
			if (e.VerticalChange != 0)
			{
				Formloaded = false;
				GetSelectedRowData();
				Formloaded = true;
			}
		}
		
		public void btnRemoveCoowner_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Formloaded = false;
			if (this.dgCoOwner.SelectedItems.Count == 0)
			{
				MessageBox.Show("You must select a co-owner to delete...");
				return;
			}
			
			var msg = "This will remove the selected Co-Owner , are you sure? ";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			GetSelectedCoOwnerRowData();
			string S = (string) ("delete from CoOwner where Rowid = " + CoOwnerRowID);
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_RemoveCoowner);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_RemoveCoowner(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					MessageBox.Show("Delete failed.");
				}
				else
				{
					PopulateCoOwnerGrid(CurrSelectedUserGuid);
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_InsertCoOwner: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_RemoveCoowner);
		}
		
		public void btnRefactor_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! GLOBALS._isAdmin)
			{
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			
			string PreviousOwner = SelectedUserID;
			string NewOwner = (string) cbRefactoredOwner.SelectedItem;
			DateTime TransferDate = DateTime.Now;
			
			var msg = "This will CHANGE content ownership and CANNOT be reversed. " + "\r\n" + "It is a VERY long running process and will use ALL available server resources." + "\r\n" + "Are you sure? ";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			//*************************
			Refactor();
			SB.Text = "Refactoring in progress - please check the log and correct any errors.";
			//*************************
			
		}
		
		public void client_InsertCoOwner(object sender, SVCSearch.InsertCoOwnerCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				if (e.Result)
				{
					PopulateCoOwnerGrid(CurrSelectedUserGuid);
				}
				else
				{
					MessageBox.Show("ERROR: Failed to add co-owner");
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_InsertCoOwner: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.InsertCoOwnerCompleted -= new System.EventHandler(client_InsertCoOwner);
		}
		public void btnMakePublic_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! GLOBALS._isAdmin)
			{
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			
			int iRow = System.Convert.ToInt32(this.dgUsers.SelectedItems.Count);
			if (iRow != 1)
			{
				MessageBox.Show("Please select ONE USER row...");
				return;
			}
			
			var msg = "This will set ALL of this user\'s content to PUBLIC, are you sure?";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			var iSelected = dgUsers.SelectedIndex;
			dgUsers.Items[iRow].Selected = true;
			CurrSelectedUserGuid = grid.GetCellValueAsString(dgUsers, System.Convert.ToInt32(iSelected), "UserLoginID");
			SelectedUserID = grid.GetCellValueAsString(dgUsers, iSelected, "UserLoginID");
			SelectedUserName = grid.GetCellValueAsString(dgUsers, System.Convert.ToInt32(iSelected), "UserName");
			SelectedEmailAddress = grid.GetCellValueAsString(dgUsers, iSelected, "EmailAddress");
			//SelectedUserPassword = grid.GetCellValueAsString(dgUsers iSelected, "UserPassword")
			
			msg = "This will set all of the selected USER\'s CONTENT and EMAILS to \'PUBLIC\', Are you really sure? ";
			result = MessageBox.Show(msg, "CANNOT BE REVERSED", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			bool RC = false;
			string RetMsg = "";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.ChangeUserContentPublicCompleted += new System.EventHandler(client_ChangeUserContentPublic);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ChangeUserContentPublicAsync(GLOBALS._SecureID, CurrSelectedUserGuid, "Y", RC, RetMsg);
			
			SB.Text = "All Content converted to public.";
		}
		
		public void btnAdd_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (txtPassword.Password.Length == 0)
			{
				var msg = "The PASSWORD field was left blank, the password will be set to \'ecmuser\' - is that OK?";
				MessageBoxResult result = MessageBox.Show(msg, "Default Password Setting", MessageBoxButton.OKCancel);
				if (result == MessageBoxResult.Cancel)
				{
					return;
				}
				txtPassword.Password = "ecmuser";
				txtPassword2.Password = "ecmuser";
			}
			
			Formloaded = false;
			var AdminOn = "";
			var UserTypeChar = "";
			
			if (cbUserType.Text.Trim().Length == 0)
			{
				SB.Text = "Please select a user type.";
				Formloaded = true;
				return;
			}
			else
			{
				UserTypeChar = cbUserType.Text.Trim().Substring(0, 1).ToUpper();
			}
			AdminOn = UserTypeChar;
			
			string PW1 = txtPassword.Password;
			string PW2 = txtPassword2.Password;
			
			if (PW1.Equals(PW2))
			{
			}
			else
			{
				MessageBox.Show("The passwords DO NOT match, please verify - returning.");
				return;
			}
			
			//*****************************************************************************
			var UserGuid = System.Guid.NewGuid().ToString();
			UserGuid = (string) this.txtUserID.Text.ToUpper.Trim;
			//*****************************************************************************
			bool RC = false;
			string UserID = (string) this.txtUserID.Text.Trim;
			string UserName = txtUserName.Text;
			string EmailAddress = (string) this.txtEmail.Text.Trim;
			
			string UserPassword = "";
			if (PW1.Length > 0)
			{
				UserPassword = ENC2.EncryptPhrase(PW1);
			}
			
			string Admin = AdminOn;
			string isActive = "";
			if (ckActive.IsChecked)
			{
				isActive = "Y";
			}
			else
			{
				isActive = "N";
			}
			string UserLoginID = (string) this.txtUserID.Text.Trim;
			bool ClientOnly = false;
			if (ckClientOnly.IsChecked)
			{
				ClientOnly = true;
			}
			string HiveConnectionName = "NA";
			bool HiveActive = false;
			string RepoSvrName = "";
			DateTime RowCreationDate = DateTime.Now;
			DateTime RowLastModDate = DateTime.Now;
			string ActiveGuid = Guid.NewGuid().ToString();
			string RepoName = "NA";
			
			string RetMsg = "";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			Cursor = Cursors.Wait;
			GLOBALS.ProxySearch.SaveUSerCompleted += new System.EventHandler(client_SaveUser);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.SaveUSerAsync(GLOBALS._SecureID, UserID, UserName, EmailAddress,
			UserPassword, Admin, isActive,
			UserLoginID, ClientOnly, HiveConnectionName,
			HiveActive, RepoSvrName, RowCreationDate, RowLastModDate,
			ActiveGuid, RepoName, RC, RetMsg);
			
			
			Formloaded = true;
		}
		
		public void client_SaveUser(object sender, SVCSearch.SaveUSerCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			string RetMsg = "";
			Cursor = Cursors.Arrow;
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					SB.Text = "User added";
					RefreshUserGrid();
					PopUserCombo();
				}
				else
				{
					SB.Text = (string) ("Failed to add user: " + e.RetMsg);
					MessageBox.Show((string) ("Failed to add user: " + e.RetMsg));
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_PopulateUserGrid: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.SaveUSerCompleted -= new System.EventHandler(client_SaveUser);
		}
		public void btnUpdate_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Formloaded = false;
			var AdminOn = "";
			var UserTypeChar = "";
			
			if (cbUserType.Text.Trim().Length == 0)
			{
				SB.Text = "Please select a user type.";
				Formloaded = true;
				return;
			}
			else
			{
				UserTypeChar = cbUserType.Text.Trim().Substring(0, 1).ToUpper();
			}
			AdminOn = UserTypeChar;
			
			string PW1 = txtPassword.Password;
			string PW2 = txtPassword2.Password;
			
			if (PW1.Equals(PW2))
			{
			}
			else
			{
				MessageBox.Show("The passwords DO NOT match, please verify - returning.");
				return;
			}
			
			if (PW1.Length == 0)
			{
				PW1 = "";
				PW2 = "";
			}
			
			//*****************************************************************************
			var UserGuid = System.Guid.NewGuid().ToString();
			UserGuid = (string) this.txtUserID.Text.ToUpper.Trim;
			//*****************************************************************************
			bool RC = false;
			string UserID = (string) this.txtUserID.Text.Trim;
			string UserName = txtUserName.Text;
			string EmailAddress = (string) this.txtEmail.Text.Trim;
			
			string UserPassword = "";
			if (PW1.Length == 0)
			{
				UserPassword = "";
			}
			else
			{
				UserPassword = ENC2.EncryptPhrase(PW1);
			}
			
			string Admin = AdminOn;
			string isActive = "";
			if (ckActive.IsChecked)
			{
				isActive = "Y";
			}
			else
			{
				isActive = "N";
			}
			string UserLoginID = (string) this.txtUserID.Text.Trim;
			bool ClientOnly = false;
			if (ckClientOnly.IsChecked)
			{
				ClientOnly = true;
			}
			string HiveConnectionName = "NA";
			bool HiveActive = false;
			string RepoSvrName = "";
			DateTime RowCreationDate = DateTime.Now;
			DateTime RowLastModDate = DateTime.Now;
			string ActiveGuid = Guid.NewGuid().ToString();
			string RepoName = "NA";
			
			string RetMsg = "";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			Cursor = Cursors.Wait;
			GLOBALS.ProxySearch.SaveUSerCompleted += new System.EventHandler(client_SaveUser);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.SaveUSerAsync(GLOBALS._SecureID, UserID, UserName, EmailAddress,
			UserPassword, Admin, isActive,
			UserLoginID, ClientOnly, HiveConnectionName,
			HiveActive, RepoSvrName, RowCreationDate, RowLastModDate,
			ActiveGuid, RepoName, RC, RetMsg);
			
			
			Formloaded = true;
			
			
		}
		
		public void btnDelete_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Formloaded = false;
			int iRow = System.Convert.ToInt32(this.dgUsers.SelectedItems.Count);
			if (iRow < 0)
			{
				Formloaded = true;
				MessageBox.Show("Please select a USER row...");
				return;
			}
			
			SelectedUserID = grid.GetCellValueAsString(dgUsers, "UserLoginID");
			
			var msg = "This will remove the selected USER , are you sure? If there is associated emails or content, the user cannot be removed. ";
			MessageBoxResult result = MessageBox.Show(msg, "CANNOT BE UNDONE", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			Cursor = Cursors.Wait;
			string RetMsg = "";
			GLOBALS.ProxySearch.DeleteUserCompleted += new System.EventHandler(client_DeleteUser);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.DeleteUserAsync(GLOBALS._SecureID, SelectedUserID, RetMsg);
			
			RefreshUserGrid();
			PopUserCombo();
			
			Formloaded = true;
		}
		public void client_DeleteUser(object sender, SVCSearch.DeleteUserCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			Cursor = Cursors.Arrow;
			if (e.Error == null)
			{
				if (e.RetMsg.Length > 0)
				{
					MessageBox.Show((string) e.RetMsg);
				}
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					SB.Text = "User successfully deleted";
					PopulateUserGrid();
				}
				else
				{
					MessageBox.Show((string) ("User not removed: " + e.RetMsg));
					SB.Text = (string) e.RetMsg;
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_DeleteUser: " + e.Error.Message + " / " + e.RetMsg));
			}
			GLOBALS.ProxySearch.DeleteUserCompleted -= new System.EventHandler(client_DeleteUser);
		}
		
		public void RefreshUserGrid()
		{
			PopulateUserGrid();
		}
		
		public void PopulateUserGrid()
		{
			bGridLoaded = false;
			GLOBALS.ProxySearch.PopulateUserGridCompleted += new System.EventHandler(client_PopulateUserGrid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateUserGridAsync(GLOBALS._SecureID, GLOBALS._UserGuid, GLOBALS._isAdmin);
		}
		public void client_PopulateUserGrid(object sender, SVCSearch.PopulateUserGridCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				dgUsers.ItemsSource = e.Result;
				setColOrder();
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_PopulateUserGrid: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.PopulateUserGridCompleted -= new System.EventHandler(client_PopulateUserGrid);
			bGridLoaded = true;
		}
		public void PopulateCoOwnerGrid(string UID)
		{
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			dgCoOwner.ItemsSource = null;
			GLOBALS.ProxySearch.PopulateCoOwnerGridCompleted += new System.EventHandler(client_PopulateCoOwnerGrid);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateCoOwnerGridAsync(GLOBALS._SecureID, UID, GLOBALS._isAdmin);
		}
		public void client_PopulateCoOwnerGrid(object sender, SVCSearch.PopulateCoOwnerGridCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				dgCoOwner.ItemsSource = e.Result;
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_PopulateCoOwnerGrid: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.PopulateCoOwnerGridCompleted -= new System.EventHandler(client_PopulateCoOwnerGrid);
		}
		
		public void client_changeOwnership(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR 100.1 client_changeOwnership: ID = " + GLOBALS.gRowID.ToString() + " / " + e.Error.Message + "\r\n" + e.MySql));
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100.2 client_changeOwnership: ID =" + GLOBALS.gRowID.ToString() + " / " + e.Error.Message + "\r\n" + e.MySql));
			}
			
		}
		public void GetSelectedCoOwnerRowData()
		{
			try
			{
				int iRow = System.Convert.ToInt32(this.dgCoOwner.SelectedIndex);
				SelectedCOUserID = grid.GetCellValueAsString(dgCoOwner, iRow, "COOwnerID");
				SelectedCOUserName = grid.GetCellValueAsString(dgCoOwner, iRow, "CoOwnerName");
				CoOwnerRowID = grid.GetCellValueAsString(dgCoOwner, iRow, "RowID");
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
		}
		
		public void Refactor()
		{
			int iRow = System.Convert.ToInt32(this.dgUsers.SelectedItems.Count);
			if (iRow < 0)
			{
				MessageBox.Show("Please select ONE USER row...");
				return;
			}
			
			bool B = false;
			
			CurrentlySelectedUserGridRow = iRow;
			int IDX = dgUsers.SelectedIndex;
			
			//SelectedUserID$ = dgUsers(IDX, "UserLoginID").ToString
			//SelectedUserName$ = dgUsers(IDX, "UserName").ToString
			//SelectedEmailAddress$ = dgUsers(IDX, "EmailAddress").ToString
			//SelectedUserPassword$ = dgUsers(IDX, "UserPassword").ToString
			
			var msg = "This will set all of the selected USER\'s CONTENT and EMAILS to the new owner, are you sure? ";
			MessageBoxResult result = MessageBox.Show(msg, "Reassignment of Ownership - Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			string RefactorUserID = cbCurrentOwner.Text;
			
			var NewOwnerID = cbRefactoredOwner.SelectedItem;
			var OldOwnerID = cbCurrentOwner.SelectedItem;
			
			if (NewOwnerID.Trim.Length == 0)
			{
				MessageBox.Show("A new owner must be selected...");
				return;
			}
			
			if (OldOwnerID.Trim.Length == 0)
			{
				MessageBox.Show("A current owner must be selected...");
				return;
			}
			
			bool RC = false;
			string RetMsg = "";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.RefactorCompleted += new System.EventHandler(client_Refactor);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.RefactorAsync(GLOBALS._SecureID, NewOwnerID, OldOwnerID, RC, RetMsg);
			
		}
		public void client_Refactor(object sender, SVCSearch.RefactorCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.RC);
				if (! B)
				{
					MessageBox.Show("ERROR - Failed to refactor owner, as admin to check error table.");
					LOG.WriteToSqlLog((string) ("ERROR : client_Refactor: " + e.RetMsg));
				}
				else
				{
					MessageBox.Show("Refactored owner completed.");
				}
			}
			else
			{
				MessageBox.Show((string) ("ERROR client_Refactor: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_Refactor: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_Refactor: " + e.RetMsg));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_27_20_524);
		}
		
		public void client_ExecuteSqlNewConn_27_20_524(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_27_20_524: " + e.MySql));
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_27_20_524: 27_20_524" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_27_20_524: 27_20_524" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_27_20_524);
		}
		
		public void client_ExecuteSqlNewConn_26_41_946(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_26_41_946: " + e.MySql));
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_26_41_946: 26_41_946" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_26_41_946: 26_41_946" + e.MySql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_26_41_946);
		}
		
		//Function changeOwnership(ByVal TBL As String, ByVal tgtCol As String, ByVal NewOwnerID As String, ByVal OldOwnerID As String) As Boolean
		
		//    Dim iCnt As Integer = DB.iCount("Select count(*) from [" + TBL + "] where " + tgtCol + " = '" + OldOwnerID + "'")
		//    If iCnt = 0 Then
		//        Return True
		//    End If
		//    SB.Text = "Refactoring table : " + TBL + " - Rows: " + iCnt.ToString
		//    SB.Refresh()
		//    System.Windows.Forms.Application.DoEvents()
		
		//    Dim S As String = "update " + TBL + " set " + tgtCol + " = '" + NewOwnerID + "' where " + tgtCol + " = '" + OldOwnerID + "'"
		
		//    ProxySearch.ExecuteSqlNewConnSecureAsync(61663.77, s)
		
		//    Return True
		
		//End Function
		
		public void hlRefreshCoOwner_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateCoOwnerGrid(CurrSelectedUserGuid);
		}
		
		public void hlRefreshUsers_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			RefreshUserGrid();
		}
		
		public void PopUserCombo()
		{
			//Dim ListOfUsers As New System.Collections.ObjectModel.ObservableCollection(Of String)
			string[] ListOfUsers = null;
			bool RC = false;
			string RetMsg = "";
			
			string S = "";
			S = S + " SELECT [UserLoginID]";
			S = S + "FROM  [Users]";
			S = S + "order by [UserLoginID]";
			
			GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_cbNewOwner);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ListOfUsers, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			ListOfUsers = null;
			GC.Collect();
			
		}
		public void client_cbNewOwner(object sender, SVCSearch.getListOfStringsCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			bool RC = false;
			string RetMsg = "";
			
			cbNewOwner.Items.Clear();
			cbCurrentOwner.Items.Clear();
			cbRefactoredOwner.Items.Clear();
			if (e.Error == null)
			{
				foreach (string S in e.ListOfItems)
				{
					cbNewOwner.Items.Add(S);
					cbCurrentOwner.Items.Add(S);
					cbRefactoredOwner.Items.Add(S);
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_cbNewOwner: " + e.Error.Message));
			}
			
			GC.Collect();
			
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
		public void client_ExecuteSqlNewConn6(object sender, SVCSearch.ExecuteSqlNewConn5CompletedEventArgs e)
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
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 700: " + e.Error.Message));
				
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn5Completed -= new System.EventHandler(client_ExecuteSqlNewConn6);
		}
		
		
		~PageUsers()
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
				
				//RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_changeOwnership
				
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		public void btnAddCowner1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			string PreviousOwner = CurrSelectedUserGuid;
			string NewOwner = cbNewOwner.Text.Trim();
			DateTime TransferDate = DateTime.Now;
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			GLOBALS.ProxySearch.InsertCoOwnerCompleted += new System.EventHandler(client_InsertCoOwner);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.InsertCoOwnerAsync(GLOBALS._SecureID, PreviousOwner, NewOwner);
		}
		
		public void btnPrivate_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! GLOBALS._isAdmin)
			{
				MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
				return;
			}
			
			int iRow = System.Convert.ToInt32(this.dgUsers.SelectedItems.Count);
			if (iRow != 1)
			{
				MessageBox.Show("Please select ONE USER row...");
				return;
			}
			
			string msg = "This will set ALL of this user\'s content to PRIVATE, are you sure?";
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			var iSelected = dgUsers.SelectedIndex;
			dgUsers.Items[iRow].Selected = true;
			CurrSelectedUserGuid = grid.GetCellValueAsString(dgUsers, "UserLoginID");
			SelectedUserID = grid.GetCellValueAsString(dgUsers, "UserLoginID");
			SelectedUserName = grid.GetCellValueAsString(dgUsers, "UserName");
			SelectedEmailAddress = grid.GetCellValueAsString(dgUsers, "EmailAddress");
			//SelectedUserPassword = grid.GetCellValueAsString(dgUsers "UserPassword")
			
			msg = "This will set all of the selected USER\'s CONTENT and EMAILS to \'PUBLIC\', Are you really sure? ";
			result = MessageBox.Show(msg, "CANNOT BE REVERSED", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.Cancel)
			{
				return;
			}
			
			bool RC = false;
			string RetMsg = "";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.ChangeUserContentPublicCompleted += new System.EventHandler(client_ChangeUserContentPublic);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ChangeUserContentPublicAsync(GLOBALS._SecureID, CurrSelectedUserGuid, "N", RC, RetMsg);
			
		}
		public void client_ChangeUserContentPublic(object sender, SVCSearch.ChangeUserContentPublicCompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.RC);
				if (! B)
				{
					MessageBox.Show("Content NOT reset.");
				}
				else
				{
					MessageBox.Show("Content reset.");
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_ChangeUserContentPublic: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.ChangeUserContentPublicCompleted -= new System.EventHandler(client_ChangeUserContentPublic);
		}
		
		public void ckClientOnly_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! bGridLoaded)
			{
				return;
			}
			bGridLoaded = false;
			string S = "";
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			S = "UPDATE [dbo].[Users] SET [ClientOnly] = 1 WHERE [UserID] = \'" + CurrSelectedUserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			SB.Text = "Set to Client only";
		}
		
		public void ckClientOnly_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! bGridLoaded)
			{
				return;
			}
			bGridLoaded = false;
			string S = "";
			S = "UPDATE [dbo].[Users] SET [ClientOnly] = 0 WHERE [UserID] = \'" + CurrSelectedUserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			SB.Text = "Set NOT Client only";
		}
		
		public void ckActive_Unchecked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! bGridLoaded)
			{
				return;
			}
			bGridLoaded = false;
			string S = "";
			S = "UPDATE [dbo].[Users] SET [isActive] = \'N\' WHERE [UserID] = \'" + CurrSelectedUserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			SB.Text = "Set to INACTIVE";
		}
		
		public void ckActive_Checked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (! bGridLoaded)
			{
				return;
			}
			bGridLoaded = false;
			string S = "";
			S = "UPDATE [dbo].[Users] SET [isActive] = \'Y\' WHERE [UserID] = \'" + CurrSelectedUserGuid + "\'";
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			SB.Text = "Set to ACTIVE";
		}
		
		public void dt_CoOwnerChanged(object sender, SelectionChangedEventArgs e)
		{
			GetSelectedCoOwnerRowData();
		}
	}
	
}
