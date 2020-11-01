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
	public partial class popupSaveSearch
	{
		
		//Dim proxy As New SVCSearch.Service1Client
		
		clsParms PARMS = new clsParms();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		//Dim GVAR As App = App.Current
		clsParms PRM = new clsParms();
		string SearchParms = "";
		List<string> ListOfQuickSearch = new List<string>();
		
		public popupSaveSearch()
		{
			//InitializeComponent()
			//EP.setSearchSvcEndPoint(proxy)
			
			GLOBALS.ApplyRecalledSearch = false;
			
			foreach (string S in GLOBALS.dictMasterSearch.Keys)
			{
				SearchParms = SearchParms + S + Strings.ChrW(253) + GLOBALS.dictMasterSearch.Item(S) + Strings.ChrW(254);
			}
			
			SearchParms = PARMS.BuildParmString(GLOBALS.dictMasterSearch);
			SearchParms = SearchParms.Replace("\'", "`");
			
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			GLOBALS.ApplyRecalledSearch = false;
		}
		
		public void btnSave_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			string SearchName = txtSearchName.Text;
			if (SearchName.Trim().Length == 0)
			{
				MessageBox.Show("Please supply a Search Name, returning.");
				return;
			}
			
			SearchName = SearchName.Replace("\'", "`");
			SearchSave(SearchName);
			
		}
		
		public void btnDelete_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			string SearchName = cbUserSearch.Text;
			if (SearchName.Trim().Length == 0)
			{
				MessageBox.Show("Please SELECT a Search Name, returning.");
				return;
			}
			
			var msg = "This will REMOVE the selected search - " + SearchName;
			MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
			
			if (result == MessageBoxResult.OK)
			{
			}
			else
			{
				SB.Text = "Delete cancelled.";
				return;
			}
			
			SearchName = SearchName.Replace("\'\'", "\'");
			SearchName = SearchName.Replace("\'", "\'\'");
			string MySql = "Delete  SearchParms from SearchUser where SearchName = \'" + SearchName + "\' and UserID = \'" + GLOBALS._UserID + "\'";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			
			MySql = ENC2.EncryptPhrase(MySql, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, MySql, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				if (e.Result)
				{
					SB.Text = "Successful EXECUTION";
				}
				else
				{
					SB.Text = "Failed EXECUTION";
				}
			}
			else
			{
				MessageBox.Show((string) ("Failed EXECUTION: " + e.Error.Message));
			}
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
			
		}
		
		public void btnRecall_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			string SearchName = cbUserSearch.Text;
			if (SearchName.Trim().Length == 0)
			{
				MessageBox.Show("Please SELECT a Search Name, returning.");
				return;
			}
			
			SearchReload(SearchName);
			
		}
		
		public void ChildWindow_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
			GLOBALS.ProxySearch.SaveUserSearchCompleted -= new System.EventHandler(client_SearchHistorySave);
		}
		
		public void SearchSave(string SearchName)
		{
			
			SearchName = SearchName.Replace("\'", "\'\'");
			string SearchParms = PRM.BuildParmString(GLOBALS.dictMasterSearch);
			
			GLOBALS.ProxySearch.SaveUserSearchCompleted += new System.EventHandler(client_SearchHistorySave);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.SaveUserSearchAsync(GLOBALS._SecureID, SearchName, GLOBALS._UserID, SearchParms);
			
		}
		
		public void client_SearchHistorySave(object sender, SVCSearch.SaveUserSearchCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result)
				{
					SB.Text = "Your search has been saved.";
				}
				else
				{
					SB.Text = "Failed to save your search.";
				}
			}
			GLOBALS.ProxySearch.SaveUserSearchCompleted -= new System.EventHandler(client_SearchHistorySave);
		}
		public void SearchReload(string SearchName)
		{
			SearchName = SearchName.Replace("\'", "\'\'");
			string SearchParms = "";
			
			GLOBALS.ProxySearch.RecallUserSearchCompleted += new System.EventHandler(client_RecallUserSearch);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.RecallUserSearchAsync(GLOBALS._SecureID, SearchName, GLOBALS._UserID, SearchParms);
			
		}
		public void client_RecallUserSearch(object sender, SVCSearch.RecallUserSearchCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result)
				{
					GLOBALS.ApplyRecalledSearch = true;
					GLOBALS.dictMasterSearch.Clear();
					ListOfQuickSearch.Clear();
					string[] SearchParms = null;
					string[] A = null;
					string sKey = null;
					string sVal = null;
					string QuickSearchHistory = (string) e.strSearches;
					SearchParms = QuickSearchHistory.Split(Strings.ChrW(254).ToString().ToCharArray());
					foreach (string S in SearchParms)
					{
						A = S.Split(Strings.ChrW(253).ToString().ToCharArray());
						sKey = A[0];
						sVal = A[1];
						if (! GLOBALS.dictMasterSearch.ContainsKey(sKey))
						{
							GLOBALS.dictMasterSearch.Add(sKey, sVal);
						}
					}
					MessageBox.Show("Search \'" + cbUserSearch.Text + "\' reloaded, press OK to apply or Cancel to just return.");
				}
				else
				{
					SB.Text = "Failed to save your search.";
				}
			}
			GLOBALS.ProxySearch.RecallUserSearchCompleted -= new System.EventHandler(client_RecallUserSearch);
		}
		
	}
	
}
