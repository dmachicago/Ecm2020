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
	public partial class popupAlerts
	{
		
		//Dim GVAR As App = App.Current
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		clsSMS SMS = new clsSMS();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim ListOfAlerts As New System.Collections.ObjectModel.ObservableCollection(Of String)
		//Dim ListOfContacts As New System.Collections.ObjectModel.ObservableCollection(Of String)
		
		string[] ListOfAlerts = null;
		string[] ListOfContacts = null;
		
		string CurrentObject = "";
		
		public popupAlerts()
		{
			InitializeComponent();
			
			//EP.setSearchSvcEndPoint(proxy)
			
			populateAlertCombo();
			populateNotificationCombo();
			
			SMS.LoadCarriers(cbCarrier);
			
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = true;
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = false;
		}
		
		public void SaveNotify()
		{
			
			string ContactEmail = txtEmail.Text.Trim();
			string ContactIM = txtSms.Text.Trim();
			string ContactName = txtName.Text.Trim();
			ContactName = UTIL.RemoveSingleQuotes(ContactName);
			ContactEmail = UTIL.RemoveSingleQuotes(ContactEmail);
			
			CurrentObject = ContactName;
			
			string s = "";
			s += " if not exists(select ContactEmail from AlertContact where ContactEmail = \'" + ContactEmail + "\')";
			s += " begin";
			s += " 	insert into [AlertContact] (ContactEmail, ContactIM, ContactName) values (\'" + ContactEmail + "\',\'" + ContactIM + "\', \'" + ContactName + "\')";
			s += " end";
			s += " else";
			s += " begin";
			s += " 	update [AlertContact] set ContactIM = \'" + ContactIM + "\', ContactName = \'" + ContactName + "\'  where ContactEmail = \'" + ContactEmail + "\'";
			s += " end";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSearch);
			//EP.setSearchSvcEndPoint(proxy)
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		public void deleteNotify()
		{
			
			string ContactEmail = txtEmail.Text.Trim();
			string ContactIM = txtSms.Text.Trim();
			string ContactName = txtName.Text.Trim();
			ContactName = UTIL.RemoveSingleQuotes(ContactName);
			ContactEmail = UTIL.RemoveSingleQuotes(ContactEmail);
			
			CurrentObject = ContactName;
			
			string s = "";
			s += " delete from AlertContact where ContactEmail = \'" + ContactEmail + "\' ";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSearch);
			//EP.setSearchSvcEndPoint(proxy)
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		public void SaveAlert()
		{
			
			string AlertWord = txtAlertWord.Text;
			string xDate = dteExpire.SelectedDate.ToString();
			AlertWord = UTIL.RemoveSingleQuotes(AlertWord);
			
			if (AlertWord.Contains(" "))
			{
				MessageBox.Show("Sorry, ALERT words cannot contain blanks. They have to be separate words.");
				return;
			}
			
			CurrentObject = AlertWord;
			
			string s = "";
			s += " if not exists(select AlertWord from AlertWord where AlertWord = \'" + AlertWord + "\')" + "\r\n";
			s += " begin" + "\r\n";
			s += " 	insert into [AlertWord] (AlertWord, ExpirationDate) values (\'" + AlertWord + "\',\'" + xDate + "\')" + "\r\n";
			s += " end" + "\r\n";
			s += " else" + "\r\n";
			s += " begin" + "\r\n";
			s += " 	update [AlertWord] set ExpirationDate = \'" + xDate + "\' where AlertWord = \'" + AlertWord + "\' " + "\r\n";
			s += " end" + "\r\n";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteSearch);
			//EP.setSearchSvcEndPoint(proxy)
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
		}
		
		public void DeleteAlert()
		{
			
			string AlertWord = txtAlertWord.Text;
			AlertWord = UTIL.RemoveSingleQuotes(AlertWord);
			
			CurrentObject = AlertWord;
			
			string s = "";
			s += " delete from AlertWord where AlertWord = \'" + AlertWord + "\'" + "\r\n";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed += new System.EventHandler(client_ExecuteDelete);
			//EP.setSearchSvcEndPoint(proxy)
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Async(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_ExecuteDelete(object sender, SVCSearch.ExecuteSqlNewConn1CompletedEventArgs e)
		{
			int LL = 0;
			
			if (e.Error == null)
			{
				populateAlertCombo();
				populateNotificationCombo();
			}
			else
			{
				MessageBox.Show("Failed Delete \'" + CurrentObject + "\'.");
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed -= new System.EventHandler(client_ExecuteSearch);
		}
		public void client_ExecuteSearch(object sender, SVCSearch.ExecuteSqlNewConn1CompletedEventArgs e)
		{
			int LL = 0;
			
			if (e.Error == null)
			{
				populateAlertCombo();
				populateNotificationCombo();
			}
			else
			{
				MessageBox.Show("Failed operation on alert \'" + CurrentObject + "\'.");
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConn1Completed -= new System.EventHandler(client_ExecuteSearch);
		}
		
		public void populateAlertCombo()
		{
			string S = "";
			bool RC = false;
			string RetMsg = "";
			
			S = S + " SELECT  AlertWord + \' / \' + cast(ExpirationDate as varchar) " + "\r\n";
			S = S + " FROM  [AlertWord]" + "\r\n";
			S = S + " Order by AlertWord " + "\r\n";
			
			GLOBALS.ProxySearch.getListOfStringsCompleted += new System.EventHandler(client_PopulateAlertCombo);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStringsAsync(GLOBALS._SecureID, GLOBALS.gRowID, ListOfAlerts, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_PopulateAlertCombo(object sender, SVCSearch.getListOfStringsCompletedEventArgs e)
		{
			bool RC = false;
			string RetMsg = "";
			
			if (e.Error == null)
			{
				lbAlerts.Items.Clear();
				foreach (string S in e.ListOfItems)
				{
					lbAlerts.Items.Add(S);
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateAlertCombo 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getListOfStringsCompleted -= new System.EventHandler(client_PopulateAlertCombo);
		}
		
		public void populateNotificationCombo()
		{
			string S = "";
			bool RC = false;
			string RetMsg = "";
			
			S = S + " SELECT  ContactName + \' / \' + ContactEmail + \' / \' + ContactIM " + "\r\n";
			S = S + " FROM  [AlertContact]" + "\r\n";
			S = S + " Order by ContactName " + "\r\n";
			
			GLOBALS.ProxySearch.getListOfStrings01Completed += new System.EventHandler(client_PopulateNotificationCombo);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.getListOfStrings01Async(GLOBALS._SecureID, GLOBALS.gRowID, S, RC, RetMsg, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		public void client_PopulateNotificationCombo(object sender, SVCSearch.getListOfStrings01CompletedEventArgs e)
		{
			bool RC = false;
			string RetMsg = "";
			
			
			try
			{
				if (e.Error == null)
				{
					lbAlertContact.Items.Clear();
					foreach (SVCSearch.DS_ListOfStrings01 ListItems in e.Result)
					{
						string sItem = ListItems.strItem;
						lbAlertContact.Items.Add(sItem);
					}
				}
				else
				{
					modGlobals.gErrorCount++;
					LOG.WriteToSqlLog((string) ("ERROR client_PopulateAlertCombo 100: " + e.Error.Message));
					lblPopup.Content = "ERROR 100 - No alerts found:";
				}
			}
			catch (Exception)
			{
				LOG.WriteToSqlLog((string) ("ERROR client_PopulateAlertCombo 101: " + e.Error.Message));
				lblPopup.Content = "ERROR 101 - No alerts found:";
			}
			
			GLOBALS.ProxySearch.getListOfStrings01Completed -= new System.EventHandler(client_PopulateNotificationCombo);
		}
		public void btnSave_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			SaveAlert();
		}
		
		public void btnDelete_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			DeleteAlert();
		}
		
		public void lbAlertContact_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			int I = lbAlertContact.SelectedIndex;
			
			if (I < 0)
			{
				return;
			}
			
			string S = lbAlertContact.Items[I];
			string[] A = S.Split("/".ToCharArray());
			
			txtName.Text = A[0].Trim();
			txtEmail.Text = A[1].Trim();
			txtSms.Text = A[2].Trim();
			
		}
		
		public void lbAlerts_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			int I = lbAlerts.SelectedIndex;
			
			if (I < 0)
			{
				return;
			}
			
			string S = lbAlerts.Items[I];
			string[] A = S.Split("/".ToCharArray());
			
			txtAlertWord.Text = A[0];
			dteExpire.SelectedDate = DateTime.Parse(A[1]);
			
		}
		
		public void Button1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (txtEmail.Text.Trim().Length == 0)
			{
				MessageBox.Show("An EMAIL notification address must be supplied, returning.");
				return;
			}
			if (txtName.Text.Trim().Length == 0)
			{
				MessageBox.Show("An NAME must be supplied, returning.");
				return;
			}
			
			SaveNotify();
		}
		
		public void Button2_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			deleteNotify();
		}
		
		
	}
	
}
