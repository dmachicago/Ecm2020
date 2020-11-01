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
	public partial class PageGrantContentToUsers
	{
		
		
		System.Collections.ObjectModel.ObservableCollection<string> ListOfUsers = new System.Collections.ObjectModel.ObservableCollection<string>();
		//Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
		string[] ListOfItems = null;
		
		clsLogging LOG = new clsLogging();
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		//Dim GVAR As App = App.Current
		string UserID = "\"";
		object CurrUserGuidID;
		//Dim proxy As New SVCSearch.Service1Client
		
		int InsertCnt = 0;
		int CurrCnt = 0;
		
		public PageGrantContentToUsers()
		{
			InitializeComponent();
			//EP.setSearchSvcEndPoint(proxy)
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateLibraryComboBox
			//AddHandler ProxySearch.PopulateLibraryUsersGridCompleted, AddressOf client_PopulateLibraryUsersGrid
			
			//** Set global variables
			UserID = GLOBALS._UserID;
			CurrUserGuidID = GLOBALS._UserGuid;
			
			ckMyLibsOnly.IsEnabled = false;
			if (GLOBALS._isAdmin)
			{
				ckMyLibsOnly.IsEnabled = true;
			}
			if (GLOBALS._isGlobalSearcher)
			{
				ckMyLibsOnly.IsEnabled = true;
			}
			if (GLOBALS._isSuperAdmin)
			{
				ckMyLibsOnly.IsEnabled = true;
			}
			
			COMMON.SaveClick(7450, UserID);
			
			PopulateLibraryComboBox();
			PopulateUserListbox();
			
			
		}
		
		public void hlHome_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			MainPage NextPage = new MainPage();
			this.Content = NextPage;
		}
		
		public void hlLibraryMgt_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageLibraryMgt NextPage = new PageLibraryMgt();
			this.Content = NextPage;
		}
		
		public void hyperlinkButton1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PageLibrary NextPage = new PageLibrary();
			this.Content = NextPage;
		}
		
		public void PopulateLibraryComboBox()
		{
			
			bool RC = false;
			string RetMsg = "";
			
			string S = "";
			if (GLOBALS._isAdmin)
			{
				if (ckMyLibsOnly.IsChecked)
				{
					S = "SELECT [LibraryName] + \' / \' + UserID FROM [dbo].[Library] where UserID = \'" + GLOBALS._UserGuid + "\' order by LibraryName ";
				}
				else
				{
					S = "SELECT [LibraryName]  + \' / \' + UserID FROM [dbo].[Library] order by LibraryName ";
				}
			}
			else
			{
				S = "SELECT [LibraryName]  + \' / \' + UserID  FROM [dbo].[Library] where UserID = \'" + GLOBALS._UserGuid + "\' order by LibraryName ";
			}
			
			PB.IsIndeterminate = true;
			PB.Visibility = System.Windows.Visibility.Visible;
			
			GLOBALS.ProxySearch.getListOfStrings2Completed += new System.EventHandler(client_PopulateLibraryComboBox);
			//EP.setSearchSvcEndPoint(proxy)
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings2Async(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		public void client_PopulateLibraryComboBox(object sender, SVCSearch.getListOfStrings2CompletedEventArgs e)
		{
			
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			bool RC = false;
			string RetMsg = "";
			
			if (e.Error == null)
			{
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
				MessageBox.Show((string) ("ERROR client_PopulateLibraryComboBox 100: " + e.RetMsg + "\r\n" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryComboBox 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStrings2Completed -= new System.EventHandler(client_PopulateLibraryComboBox);
			
		}
		
		public void PopulateUserListbox()
		{
			
			//If cbLibrary.SelectedItem Is Nothing Then
			//    Return
			//End If
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			//Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
			string[] ListOfItems = null;
			
			//Dim tLib As String = cbLibrary.SelectedItem.ToString
			//tLib = tLib.Replace("'", "''")
			
			string S = "";
			S += "SELECT  UserName + \' / \' + UserID As UserID from Users order by UserName " + "\r\n";
			//S += "FROM    LibraryUsers INNER JOIN" + vbCrLf
			//S += "Users ON LibraryUsers.UserID = Users.UserID" + vbCrLf
			//S += "where LibraryUsers.LibraryName = '" + tLib + "'" + vbCrLf
			//S += "ORDER BY LibraryUsers.LibraryName" + vbCrLf
			
			GLOBALS.ProxySearch.getListOfStrings3Completed += new System.EventHandler(client_PopulateUserListbox);
			//EP.setSearchSvcEndPoint(proxy)
			
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings3Async(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			ListOfItems = null;
			GC.Collect();
		}
		public void client_PopulateUserListbox(object sender, SVCSearch.getListOfStrings3CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			System.Collections.ObjectModel.ObservableCollection<string> ListOfItems = new System.Collections.ObjectModel.ObservableCollection<string>();
			
			lbUsers.Items.Clear();
			if (e.Error == null)
			{
				foreach (string S in e.ListOfItems)
				{
					lbUsers.Items.Add(S);
					if (! ListOfUsers.Contains(S))
					{
						ListOfUsers.Add(S);
					}
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				Sb.Text = (string) ("ERROR client_PopulateUserListbox 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateUserListbox 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStrings3Completed -= new System.EventHandler(client_PopulateUserListbox);
			
		}
		public void RepopulateUsersListBox()
		{
			lbUsers.Items.Clear();
			foreach (string S in ListOfUsers)
			{
				if (lbLibUsers.Items.Contains(S))
				{
				}
				else
				{
					lbUsers.Items.Add(S);
				}
				
			}
		}
		public void PopulateLibraryUserListbox()
		{
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			//Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
			string[] ListOfItems = null;
			
			string LibName = cbLibrary.SelectedItem.ToString();
			string[] A1 = LibName.Split("/".ToCharArray());
			LibName = A1[0].Trim();
			string LibraryOwnerUserID = A1[1].Trim();
			
			LibName = LibName.Replace("\'", "\'\'");
			LibraryOwnerUserID = LibraryOwnerUserID.Replace("\'", "\'\'");
			
			string Mysql = "";
			Mysql += "SELECT     Users.UserName + \' / \' + LibraryUsers.UserID as UserID" + "\r\n";
			Mysql += "FROM         LibraryUsers INNER JOIN" + "\r\n";
			Mysql += "Users ON LibraryUsers.UserID = Users.UserID" + "\r\n";
			Mysql += "WHERE     (LibraryUsers.LibraryName = \'" + LibName + "\') AND (LibraryUsers.LibraryOwnerUserID = \'" + LibraryOwnerUserID + "\')" + "\r\n";
			Mysql += "Order by Users.UserName" + "\r\n";
			
			GLOBALS.ProxySearch.getListOfStrings1Completed += new System.EventHandler(client_PopulateLibraryUserListbox);
			//EP.setSearchSvcEndPoint(proxy)
			
			Mysql = ENC2.EncryptPhrase(Mysql, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings1Async(GLOBALS._SecureID, GLOBALS.gRowID, ListOfItems, Mysql, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
			ListOfItems = null;
			GC.Collect();
		}
		public void client_PopulateLibraryUserListbox(object sender, SVCSearch.getListOfStrings1CompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			bool RC = true;
			string RetMsg = "";
			int SSID = 0;
			
			lbLibUsers.Items.Clear();
			if (e.Error == null)
			{
				foreach (string S in e.ListOfItems)
				{
					lbLibUsers.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				Sb.Text = (string) ("ERROR client_PopulateLibraryUserListbox 100: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateLibraryUserListbox 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStrings1Completed -= new System.EventHandler(client_PopulateLibraryUserListbox);
			
			RepopulateUsersListBox();
			
		}
		
		//Sub PopulateLibraryUserListbox()
		//    Dim SLib As String = cbLibrary.SelectedItem
		//    SLib = SLib.Replace("'", "''")
		
		//    AddHandler ProxySearch.PopulateLibraryUsersGridCompleted, AddressOf client_PopulateLibraryUsersGrid
		//    ProxySearch.PopulateLibraryUsersGridAsync(_SecureID, SLib, ckLibUsersOnly.IsChecked)
		//End Sub
		//Sub client_PopulateLibraryUsersGrid(ByVal sender As Object, ByVal e As SVCSearch.PopulateLibraryUsersGridCompletedEventArgs)
		//    If e.Error Is Nothing Then
		//        dgUsers.ItemsSource = e.Result
		//    Else
		//        gErrorCount += 1
		//        LOG.WriteToSqlLog("ERROR client_PopulateLibraryUsersGrid 100: " + e.Error.Message)
		//    End If
		//    RemoveHandler ProxySearch.PopulateLibraryUsersGridCompleted, AddressOf client_PopulateLibraryUsersGrid
		//End Sub
		
		public void btnGrant_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//** Assign All selected users to selected library
			
			//Dim DR As C1.Silverlight.FlexGrid.Row
			
			try
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_15_46_224);
			}
			catch (Exception)
			{
				
			}
			
			string LibName = cbLibrary.SelectedItem.ToString();
			string[] A1 = LibName.Split("/".ToCharArray());
			LibName = A1[0].Trim();
			string LibraryOwnerUserID = A1[1].Trim();
			
			if (LibName.IndexOf("\'\'") + 1 > 0)
			{
			}
			else
			{
				LibName = LibName.Replace("\'", "\'\'");
			}
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_15_46_224);
			//EP.setSearchSvcEndPoint(proxy)
			InsertCnt = lbUsers.SelectedItems.Count;
			CurrCnt = 0;
			
			foreach (string S in lbUsers.SelectedItems)
			{
				string[] A = S.Split("/".ToCharArray());
				
				string UID = A[1].Trim();
				
				CurrCnt++;
				
				COMMON.RemoveSingleQuotes(ref LibName);
				COMMON.RemoveSingleQuotes(ref UID);
				COMMON.RemoveSingleQuotes(ref LibraryOwnerUserID);
				
				S = "";
				S += "if not exists (Select Userid from LibraryUsers where UserID = \'@UserID\' and LibraryOwnerUserID = \'@LibraryOwnerUserID\' and LibraryName = \'@LibraryName\')" + "\r\n";
				S += "BEGIN" + "\r\n";
				S += " INSERT INTO [LibraryUsers]" + "\r\n";
				S += " ([UserID]" + "\r\n";
				S += " ,[LibraryOwnerUserID]" + "\r\n";
				S += " ,[LibraryName]" + "\r\n";
				S += " ,[RowCreationDate]" + "\r\n";
				S += " ,[RowLastModDate]" + "\r\n";
				S += " ,RepoSvrName" + "\r\n";
				S += " ,[RepoName])" + "\r\n";
				S += " VALUES " + "\r\n";
				S += " (\'@UserID\'" + "\r\n";
				S += " ,\'@LibraryOwnerUserID\'" + "\r\n";
				S += " ,\'@LibraryName\'" + "\r\n";
				S += " ,GETDATE()" + "\r\n";
				S += " ,GETDATE()" + "\r\n";
				S += " ,@@SERVERNAME" + "\r\n";
				S += " ,DB_NAME())" + "\r\n";
				S += "END" + "\r\n";
				
				S = S.Replace("@UserID", UID);
				S = S.Replace("@LibraryOwnerUserID", LibraryOwnerUserID);
				S = S.Replace("@LibraryName", LibName);
				
				PB.IsIndeterminate = true;
				PB.Visibility = System.Windows.Visibility.Visible;
				
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
				
			}
		}
		public void client_ExecuteSqlNewConn_15_46_224(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					Console.WriteLine("Success: client_ExecuteSqlNewConn_25_27_432");
				}
				else
				{
					string XSql = (string) e.MySql;
					XSql = XSql.Replace("\'", "`");
					Console.WriteLine("ERROR: client_ExecuteSqlNewConn_25_27_432 - " + XSql);
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_15_46_224: 15_46_224" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_15_46_224: 15_46_224" + e.MySql));
			}
			if (CurrCnt >= InsertCnt)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_15_46_224);
				PopulateLibraryUserListbox();
				CurrCnt = 0;
			}
		}
		
		public void btnRemove_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//** Remove All selected users from selected library
			
			InsertCnt = lbLibUsers.SelectedItems.Count;
			CurrCnt = 0;
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn_7_12_501);
			//EP.setSearchSvcEndPoint(proxy)
			
			foreach (string S in lbLibUsers.SelectedItems)
			{
				CurrCnt++;
				string[] A = S.Split("/".ToCharArray());
				string UID = A[1].Trim();
				
				string LibName = cbLibrary.SelectedItem.ToString();
				string[] A1 = LibName.Split("/".ToCharArray());
				LibName = A1[0].Trim();
				string LibraryOwnerUserID = A1[1].Trim();
				
				COMMON.RemoveSingleQuotes(ref LibName);
				COMMON.RemoveSingleQuotes(ref UID);
				
				string MySql = "Delete from LibraryUsers where LibraryName = \'" + LibName + "\' and UserID = \'" + UID + "\' ";
				PB.IsIndeterminate = true;
				PB.Visibility = System.Windows.Visibility.Visible;
				MySql = ENC2.EncryptPhrase(MySql, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, MySql, GLOBALS._UserID, GLOBALS.ContractID);
			}
			
		}
		public void client_ExecuteSqlNewConn_7_12_501(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					LOG.WriteToSqlLog((string) ("ERROR SQL: client_ExecuteSqlNewConn_7_12_501: " + e.MySql));
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_7_12_501: 7_12_501" + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR client_ExecuteSqlNewConn_7_12_501: 7_12_501" + e.MySql));
			}
			if (CurrCnt >= InsertCnt)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn_7_12_501);
				RepopulateUsersListBox();
				PopulateLibraryUserListbox();
				CurrCnt = 0;
			}
			
		}
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			PB.IsIndeterminate = false;
			PB.Visibility = System.Windows.Visibility.Collapsed;
			
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					Sb.Text = "Success";
				}
				else
				{
					Sb.Text = (string) ("Execution error: " + e.MySql);
					MessageBox.Show((string) ("Execution error: " + "\r\n" + e.MySql));
				}
			}
			else
			{
				string ErrSql = (string) e.MySql;
				modGlobals.gErrorCount++;
				Sb.Text = (string) ("Error: " + e.Error.Message);
				LOG.WriteToSqlLog((string) ("ERROR PageGrantContentToUsers 100: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR PageGrantContentToUsers 100: " + ErrSql));
			}
		}
		~PageGrantContentToUsers()
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
		
		public void hlRefresh_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateLibraryComboBox();
		}
		
		public void ckMyLibsOnly_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateLibraryComboBox();
		}
		
		public void ckMyLibsOnly_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateLibraryComboBox();
		}
		
		public void Page_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
		}
		
		
		
		public void cbLibrary_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			PopulateLibraryUserListbox();
		}
	}
	
}
