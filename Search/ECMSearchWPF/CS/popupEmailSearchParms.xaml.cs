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


//Imports C1
//Imports C1.Silverlight

namespace ECMSearchWPF
{
	public partial class popupEmailSearchParms
	{
		//Inherits ChildWindow
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		
		//Dim GVAR As App = App.Current
		clsCommonFunctions COMMON = new clsCommonFunctions();
		string Userid;
		
		clsUtility UTIL = new clsUtility();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		string CurrentCombo = "";
		string[] ComboItems = null;
		//Dim DICT As New Dictionary(Of String, String)
		bool bMyEmails = false;
		string UserGuidID = "";
		string txtFilter = "";
		bool formLoaded = false;
		string SecureID = "-1";
		
		public popupEmailSearchParms(int iSecureID)
		{
			InitializeComponent();
			
			//EP.setSearchSvcEndPoint(proxy)
			
			Userid = GLOBALS._UserID;
			COMMON.SaveClick(6930, Userid);
			
			SecureID = iSecureID.ToString();
			formLoaded = false;
			
			//DICT = SearchDICT
			
			
			string sVal = "";
			if (GLOBALS.dictMasterSearch != null)
			{
				foreach (string sKey in GLOBALS.dictMasterSearch.Keys)
				{
					sVal = (string) (GLOBALS.dictMasterSearch.Item(sKey));
					if (sKey.Equals("CurrentGuid"))
					{
						UserGuidID = (string) (GLOBALS.dictMasterSearch.Item(sKey));
					}
					else if (sKey.Equals("ckMyContent"))
					{
						if (sVal.Equals("True"))
						{
							bMyEmails = true;
						}
						else
						{
							bMyEmails = false;
						}
					}
					else if (sKey.Equals("email.cbDateSelection"))
					{
						if (sVal != null)
						{
							cbDateSelection.Text = sVal;
						}
					}
					else if (sKey.Equals("email.calStart"))
					{
						if (sVal != null)
						{
							if (sVal.Length > 0)
							{
								calStart.SelectedDate = DateTime.Parse(sVal);
							}
						}
					}
					else if (sKey.Equals("email.calEnd"))
					{
						if (sVal != null)
						{
							if (sVal.Length > 0)
							{
								calEnd.SelectedDate = DateTime.Parse(sVal);
							}
						}
					}
					else if (sKey.Equals("email.dtMailDateStart"))
					{
						dtMailDateStart.Text = sVal;
					}
					else if (sKey.Equals("email.dtMailDateEnd"))
					{
						dtMailDateEnd.Text = sVal;
					}
					else if (sKey.Equals("email.cbFromAddr"))
					{
						if (sVal != null)
						{
							cbFromAddr.Text = sVal;
							txtcbFromAddr.Text = sVal;
						}
					}
					else if (sKey.Equals("email.cbToAddr"))
					{
						if (sVal != null)
						{
							cbToAddr.Text = sVal;
							txtcbToAddr.Text = sVal;
						}
					}
					else if (sKey.Equals("email.cbFromName"))
					{
						if (sVal != null)
						{
							cbFromName.Text = sVal;
							txtcbFromName.Text = sVal;
						}
					}
					else if (sKey.Equals("email.cbToName"))
					{
						if (sVal != null)
						{
							cbToName.Text = sVal;
							txtcbToName.Text = sVal;
						}
					}
					else if (sKey.Equals("email.cbFolderFilter"))
					{
						if (sVal != null)
						{
							cbFolderFilter.Text = sVal;
						}
					}
					else if (sKey.Equals("email.cbCCaddr"))
					{
						if (sVal != null)
						{
							cbCCaddr.Text = sVal;
							txtcbCCaddr.Text = sVal;
						}
					}
					else if (sKey.Equals("email.txtSubject"))
					{
						txtSubject.Text = sVal;
					}
					else if (sKey.Equals("email.txtCCPhrase"))
					{
						txtCCPhrase.Text = sVal;
					}
				}
			}
			formLoaded = true;
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			
			//ISO.SaveDetailSearchParms("EMAIL", dictMasterSearch)
			
			this.DialogResult = true;
			this.Close();
			
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			//ISO.DeleteDetailSearchParms("EMAIL")
			//For Each sKey As String In dictMasterSearch.Keys
			//    If InStr(sKey, "email.", CompareMethod.Text) > 0 Then
			//        dictMasterSearch.Item(sKey) = ""
			//    End If
			//Next
			this.DialogResult = false;
		}
		
		public void btnReset_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			cbDateSelection.SelectedItem = null;
			cbDateSelection.SelectedItem = "OFF";
			dtMailDateStart.Text = "";
			dtMailDateEnd.Text = "";
			calStart.SelectedDate = null;
			calEnd.SelectedDate = null;
			
			txtSubject.Text = "";
			txtCCPhrase.Text = "";
			cbFromAddr.SelectedItem = null;
			cbToAddr.SelectedItem = null;
			cbFromName.SelectedItem = null;
			cbToName.SelectedItem = null;
			cbFolderFilter.SelectedItem = null;
			cbCCaddr.SelectedItem = null;
			
			cbFromAddr.Text = "";
			cbToAddr.Text = "";
			cbFromName.Text = "";
			cbToName.Text = "";
			cbFolderFilter.Text = "";
			cbCCaddr.Text = "";
			
		}
		
		public void UpdateSearchDict(string tKey, string tValue)
		{
			if (! formLoaded)
			{
				return;
			}
			if (GLOBALS.dictMasterSearch.ContainsKey(tKey))
			{
				GLOBALS.dictMasterSearch.Item(tKey) = tValue;
				SB.Text = tKey + " updated";
			}
			else
			{
				GLOBALS.dictMasterSearch.Add(tKey, tValue);
				SB.Text = tKey + " added";
			}
		}
		
		
		
		public void calStart_SelectedDatesChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			if (calStart.SelectedDate != null)
			{
				UpdateSearchDict("email.calStart", calStart.SelectedDate.ToString());
				dtMailDateStart.Text = calStart.SelectedDate.ToString();
			}
			else
			{
				UpdateSearchDict("email.calStart", "");
				dtMailDateStart.Text = "";
			}
			
		}
		
		public void calEnd_SelectedDatesChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			if (calEnd.SelectedDate != null)
			{
				UpdateSearchDict("email.calEnd", calEnd.SelectedDate.ToString());
				dtMailDateEnd.Text = calEnd.SelectedDate.ToString();
			}
			else
			{
				UpdateSearchDict("email.calEnd", "");
				dtMailDateEnd.Text = "";
			}
			
		}
		
		public void txtEnd_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			UpdateSearchDict("email.dtMailDateEnd", dtMailDateEnd.Text.Trim());
		}
		
		public void txtStart_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			UpdateSearchDict("email.dtMailDateStart", dtMailDateStart.Text.Trim());
		}
		
		private void cbFromName_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			UpdateSearchDict("email.cbFromName", cbFromName.SelectedItem.ToString());
		}
		
		public void txtSubject_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			UpdateSearchDict("email.txtSubject", txtSubject.Text.Trim());
		}
		
		public void txtCCPhrase_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			UpdateSearchDict("email.txtCCPhrase", txtCCPhrase.Text.Trim());
		}
		
		public void Pop_cbFromAddr()
		{
			
			txtFilter = txtcbFromAddr.Text.Trim();
			string Filter = UTIL.RemoveSingleQuotes(txtcbFromAddr.Text.Trim());
			
			string S = "";
			if (bMyEmails)
			{
				if (txtFilter.Trim().Length == 0)
				{
					S = "Select distinct [SenderEmailAddress] FROM [Email] where UserID = \'" + UserGuidID + "\' and SenderEmailAddress is not null order by [SenderEmailAddress]";
				}
				else
				{
					S = "Select distinct [SenderEmailAddress] FROM [Email] where UserID = \'" + UserGuidID + "\' and SenderEmailAddress like \'" + UTIL.RemoveSingleQuotes(Filter) + "\' order by [SenderEmailAddress]";
				}
			}
			else
			{
				if (txtFilter.Trim().Length == 0)
				{
					S = "Select distinct [SenderEmailAddress] FROM [Email] where SenderEmailAddress is not null order by [SenderEmailAddress]";
				}
				else
				{
					S = "Select distinct [SenderEmailAddress] FROM [Email] where SenderEmailAddress like \'" + UTIL.RemoveSingleQuotes(Filter) + "\' order by [SenderEmailAddress]";
				}
			}
			
			PopulateComboBox("cbFromAddr", "SenderEmailAddress", S);
			
		}
		
		public void Pop_cbToAddr()
		{
			
			txtFilter = txtcbToAddr.Text.Trim();
			string Filter = UTIL.RemoveSingleQuotes(txtcbToAddr.Text.Trim());
			var Recpt = "";
			
			Recpt = UTIL.RemoveSingleQuotes(Filter);
			
			string S = "";
			if (bMyEmails)
			{
				if (Filter.Trim().Length == 0)
				{
					S = "Select     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where Email.UserID = \'" + UserGuidID + "\'";
					S = S + " and Recipients.Recipient  IS NOT NULL ";
					S = S + " order by Recipients.Recipient";
				}
				else
				{
					S = "Select     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where Email.UserID = \'" + UserGuidID + "\'";
					S = S + " and Recipients.Recipient like \'" + Recpt + "\'";
					S = S + " order by Recipients.Recipient";
				}
				
			}
			else
			{
				if (Filter.Trim().Length == 0)
				{
					S = "Select     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where Recipients.Recipient IS NOT NULL ";
					S = S + " order by Recipients.Recipient";
				}
				else
				{
					S = "Select     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where Recipients.Recipient like \'" + Recpt + "\'";
					S = S + " order by Recipients.Recipient";
				}
				
			}
			PopulateComboBox("cbToAddr", "Recipient", S);
		}
		public void Pop_cbFromName()
		{
			
			txtFilter = txtcbFromName.Text.Trim();
			string Filter = UTIL.RemoveSingleQuotes(txtcbFromName.Text.Trim());
			
			string S = "";
			if (bMyEmails)
			{
				if (Filter.Length == 0)
				{
					S = "Select distinct [SenderName] FROM [Email] where SenderName IS NOT NULL and UserID = \'" + UserGuidID + "\' order by [SenderName]";
				}
				else
				{
					S = "Select distinct [SenderName] FROM [Email] where SenderName like \'" + Filter + "\' and UserID = \'" + UserGuidID + "\' order by [SenderName]";
				}
			}
			else
			{
				if (Filter.Length == 0)
				{
					S = "Select distinct [SenderName] FROM [Email] where SenderName IS NOT NULL order by [SenderName]";
				}
				else
				{
					S = "Select distinct [SenderName] FROM [Email] where SenderName like \'" + Filter + "\' order by [SenderName]";
				}
				
			}
			PopulateComboBox("cbFromName", "SenderName", S);
			
		}
		public void Pop_cbToName()
		{
			
			txtFilter = txtcbToName.Text.Trim();
			string Filter = UTIL.RemoveSingleQuotes(txtcbToName.Text.Trim());
			
			string ReceivedByName = Filter;
			ReceivedByName = UTIL.RemoveSingleQuotes(Filter);
			
			string S = "";
			if (bMyEmails)
			{
				if (Filter.Length == 0)
				{
					S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName IS NOT NULL AND UserID = \'" + UserGuidID + "\' order by [ReceivedByName]";
				}
				else
				{
					S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName like \'" + ReceivedByName + "\' AND UserID = \'" + UserGuidID + "\' order by [ReceivedByName]";
				}
			}
			else
			{
				if (Filter.Length == 0)
				{
					S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName IS NOT NULL order by [ReceivedByName]";
				}
				else
				{
					S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName like \'" + ReceivedByName + "\' order by [ReceivedByName]";
				}
			}
			PopulateComboBox("cbToName", "ReceivedByName", S);
			
		}
		public void Pop_cbFolderFilter()
		{
			
			txtFilter = txtcbFolderFilter.Text.Trim();
			string Filter = UTIL.RemoveSingleQuotes(txtcbFolderFilter.Text.Trim());
			
			string FolderName = Filter;
			
			string S = "";
			if (bMyEmails)
			{
				if (Filter.Trim().Length == 0)
				{
					S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder IS NOT NULL and UserID = \'" + UserGuidID + "\' order by OriginalFolder";
				}
				else
				{
					S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder like \'" + FolderName + "\' and UserID = \'" + UserGuidID + "\' order by OriginalFolder";
				}
				
			}
			else
			{
				if (Filter.Trim().Length == 0)
				{
					S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder IS NOT NULL order by OriginalFolder";
				}
				else
				{
					S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder like \'" + FolderName + "\' order by OriginalFolder";
				}
				
			}
			PopulateComboBox("cbFolderFilter", "OriginalFolder", S);
			
		}
		public void Pop_cbCCaddr()
		{
			
			txtFilter = txtcbCCaddr.Text.Trim();
			string Filter = UTIL.RemoveSingleQuotes(txtcbCCaddr.Text.Trim());
			
			string ReceivedByName = Filter;
			string S = "";
			if (bMyEmails)
			{
				if (Filter.Length == 0)
				{
					S = "";
					S = S + " SELECT     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where Email.UserID = \'" + UserGuidID + "\'";
					S = S + " and TypeRecp = \'CC\'";
					S = S + " and  Recipients.Recipient IS NOT NULL ";
					S = S + " order by Recipients.Recipient";
				}
				else
				{
					S = "";
					S = S + " SELECT     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where Email.UserID = \'" + UserGuidID + "\'";
					S = S + " and TypeRecp = \'CC\'";
					S = S + " and  Recipients.Recipient like \'" + ReceivedByName + "\' ";
					S = S + " order by Recipients.Recipient";
				}
				
			}
			else
			{
				if (Filter.Length == 0)
				{
					S = "";
					S = S + " SELECT     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where TypeRecp = \'CC\'";
					S = S + " and  Recipients.Recipient IS NOT NULL ";
					S = S + " order by Recipients.Recipient";
				}
				else
				{
					S = "";
					S = S + " SELECT     distinct Recipients.Recipient";
					S = S + " FROM         Recipients INNER JOIN";
					S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid";
					S = S + " where TypeRecp = \'CC\'";
					S = S + " and  Recipients.Recipient like \'" + ReceivedByName + "\' ";
					S = S + " order by Recipients.Recipient";
				}
			}
			PopulateComboBox("cbCCaddr", "Recipient", S);
			
		}
		
		public void PopulateComboBox(string ComboName, string TblColName, string MySql)
		{
			
			PB.Visibility = System.Windows.Visibility.Visible;
			PB.IsIndeterminate = true;
			CurrentCombo = ComboName;
			
			GLOBALS.ProxySearch.PopulateComboBoxCompleted += new System.EventHandler(client_PopulateComboBox);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateComboBoxAsync(SecureID, ComboItems, TblColName, MySql);
			
		}
		
		public void client_PopulateComboBox(object sender, SVCSearch.PopulateComboBoxCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				if (CurrentCombo.Equals("cbCCaddr"))
				{
					cbCCaddr.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbFolderFilter"))
				{
					cbFolderFilter.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbFromAddr"))
				{
					cbFromAddr.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbFromName"))
				{
					cbFromName.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbToAddr"))
				{
					cbToAddr.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbToName"))
				{
					cbToName.ItemsSource = e.CB;
				}
				SB.Text = (string) ("Items Found: " + e.CB.Count.ToString());
			}
			else
			{
				MessageBox.Show((string) ("ERROR loading combo: " + e.Error.Message));
			}
			
			OKButton.Visibility = System.Windows.Visibility.Visible;
			CancelButton.Visibility = System.Windows.Visibility.Visible;
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Visible;
			Button1.Visibility = System.Windows.Visibility.Visible;
			Button3.Visibility = System.Windows.Visibility.Visible;
			Button4.Visibility = System.Windows.Visibility.Visible;
			Button5.Visibility = System.Windows.Visibility.Visible;
			Button6.Visibility = System.Windows.Visibility.Visible;
			
			PB.Visibility = System.Windows.Visibility.Collapsed;
			PB.IsIndeterminate = false;
			
			GLOBALS.ProxySearch.PopulateComboBoxCompleted -= new System.EventHandler(client_PopulateComboBox);
			
		}
		
		
		private void cbFromAddr_LostFocus(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			UpdateSearchDict("email.cbFromAddr", cbFromAddr.SelectedItem.ToString());
		}
		
		public void cbFromName_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			txtcbFromName.Text = cbFromName.SelectedItem.ToString();
			UpdateSearchDict("email.cbFromName", cbFromName.SelectedItem.ToString());
		}
		
		
		public void cbToAddr_KeyDown(System.Object sender, System.Windows.Input.KeyEventArgs e)
		{
			if (cbToAddr.SelectedItem != null)
			{
				UpdateSearchDict("email.cbToAddr", cbToAddr.SelectedItem.ToString());
			}
		}
		
		public void btnSearchFrom_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (txtcbFromAddr.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a name, returning.");
				return;
			}
			
			OKButton.Visibility = System.Windows.Visibility.Collapsed;
			CancelButton.Visibility = System.Windows.Visibility.Collapsed;
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			Button1.Visibility = System.Windows.Visibility.Collapsed;
			Button3.Visibility = System.Windows.Visibility.Collapsed;
			Button4.Visibility = System.Windows.Visibility.Collapsed;
			Button5.Visibility = System.Windows.Visibility.Collapsed;
			Button6.Visibility = System.Windows.Visibility.Collapsed;
			
			Pop_cbFromAddr();
			
		}
		
		public void Button1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (txtcbToAddr.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a name, returning.");
				return;
			}
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			Button1.Visibility = System.Windows.Visibility.Collapsed;
			Button3.Visibility = System.Windows.Visibility.Collapsed;
			Button4.Visibility = System.Windows.Visibility.Collapsed;
			Button5.Visibility = System.Windows.Visibility.Collapsed;
			Button6.Visibility = System.Windows.Visibility.Collapsed;
			
			OKButton.Visibility = System.Windows.Visibility.Collapsed;
			CancelButton.Visibility = System.Windows.Visibility.Collapsed;
			
			Pop_cbToAddr();
		}
		
		public void Button3_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (txtcbFromName.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a name, returning.");
				return;
			}
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			Button1.Visibility = System.Windows.Visibility.Collapsed;
			Button3.Visibility = System.Windows.Visibility.Collapsed;
			Button4.Visibility = System.Windows.Visibility.Collapsed;
			Button5.Visibility = System.Windows.Visibility.Collapsed;
			Button6.Visibility = System.Windows.Visibility.Collapsed;
			
			OKButton.Visibility = System.Windows.Visibility.Collapsed;
			CancelButton.Visibility = System.Windows.Visibility.Collapsed;
			
			Pop_cbFromName();
		}
		
		public void Button4_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (txtcbToName.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a name, returning.");
				return;
			}
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			Button1.Visibility = System.Windows.Visibility.Collapsed;
			Button3.Visibility = System.Windows.Visibility.Collapsed;
			Button4.Visibility = System.Windows.Visibility.Collapsed;
			Button5.Visibility = System.Windows.Visibility.Collapsed;
			Button6.Visibility = System.Windows.Visibility.Collapsed;
			
			OKButton.Visibility = System.Windows.Visibility.Collapsed;
			CancelButton.Visibility = System.Windows.Visibility.Collapsed;
			Pop_cbToName();
		}
		
		public void Button5_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (txtcbFolderFilter.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a name, returning.");
				return;
			}
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			Button1.Visibility = System.Windows.Visibility.Collapsed;
			Button3.Visibility = System.Windows.Visibility.Collapsed;
			Button4.Visibility = System.Windows.Visibility.Collapsed;
			Button5.Visibility = System.Windows.Visibility.Collapsed;
			Button6.Visibility = System.Windows.Visibility.Collapsed;
			
			OKButton.Visibility = System.Windows.Visibility.Collapsed;
			CancelButton.Visibility = System.Windows.Visibility.Collapsed;
			Pop_cbFolderFilter();
		}
		
		public void Button6_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (txtcbCCaddr.Text.Trim().Length == 0)
			{
				MessageBox.Show("You must supply a name, returning.");
				return;
			}
			
			btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			Button1.Visibility = System.Windows.Visibility.Collapsed;
			Button3.Visibility = System.Windows.Visibility.Collapsed;
			Button4.Visibility = System.Windows.Visibility.Collapsed;
			Button5.Visibility = System.Windows.Visibility.Collapsed;
			Button6.Visibility = System.Windows.Visibility.Collapsed;
			
			OKButton.Visibility = System.Windows.Visibility.Collapsed;
			CancelButton.Visibility = System.Windows.Visibility.Collapsed;
			Pop_cbCCaddr();
		}
		
		public void txtcbFromAddr_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("email.cbFromAddr", txtcbFromAddr.Text);
			if (txtcbFromAddr.Text.Length > 0)
			{
				cbFromAddr.Visibility = System.Windows.Visibility.Visible;
				btnSearchFrom.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				cbFromAddr.Visibility = System.Windows.Visibility.Collapsed;
				btnSearchFrom.Visibility = System.Windows.Visibility.Collapsed;
			}
		}
		
		public void txtcbToAddr_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("email.cbToAddr", txtcbToAddr.Text);
			if (txtcbToAddr.Text.Length > 0)
			{
				cbToAddr.Visibility = System.Windows.Visibility.Visible;
				Button1.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				cbToAddr.Visibility = System.Windows.Visibility.Collapsed;
				Button1.Visibility = System.Windows.Visibility.Collapsed;
			}
		}
		
		public void txtcbFromName_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("email.cbFromName", txtcbFromName.Text);
			if (txtcbFromName.Text.Length > 0)
			{
				cbFromName.Visibility = System.Windows.Visibility.Visible;
				Button3.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				cbFromName.Visibility = System.Windows.Visibility.Collapsed;
				Button3.Visibility = System.Windows.Visibility.Collapsed;
			}
		}
		
		public void txtcbToName_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("email.cbToName", txtcbToName.Text);
			if (txtcbToName.Text.Length > 0)
			{
				cbToName.Visibility = System.Windows.Visibility.Visible;
				Button4.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				cbToName.Visibility = System.Windows.Visibility.Collapsed;
				Button4.Visibility = System.Windows.Visibility.Collapsed;
			}
		}
		
		public void txtcbFolderFilter_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("email.cbFolderFilter", txtcbFolderFilter.Text);
			if (txtcbFolderFilter.Text.Length > 0)
			{
				cbFolderFilter.Visibility = System.Windows.Visibility.Visible;
				Button5.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				cbFolderFilter.Visibility = System.Windows.Visibility.Collapsed;
				Button5.Visibility = System.Windows.Visibility.Collapsed;
			}
		}
		
		public void txtcbCCaddr_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("email.cbCCaddr", txtcbCCaddr.Text);
			if (txtcbCCaddr.Text.Length > 0)
			{
				cbCCaddr.Visibility = System.Windows.Visibility.Visible;
				Button6.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				cbCCaddr.Visibility = System.Windows.Visibility.Collapsed;
				Button6.Visibility = System.Windows.Visibility.Collapsed;
			}
		}
		
		//Private Sub cbToName_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbToName.SelectedItemChanged
		//    txtcbToName.Text = cbToName.Text
		//End Sub
		
		//Private Sub cbFolderFilter_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbFolderFilter.SelectedItemChanged
		//    txtcbFolderFilter.Text = cbFolderFilter.Text
		//End Sub
		
		//Private Sub cbCCaddr_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbCCaddr.SelectedItemChanged
		//    txtcbCCaddr.Text = cbCCaddr.Text
		//End Sub
		
		//Private Sub cbDateSelection_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbDateSelection.SelectedItemChanged
		//   DateChanged
		//End Sub
		
		public void DateChanged()
		{
			string sDateFilter = cbDateSelection.Text;
			if (sDateFilter != null)
			{
				UpdateSearchDict("email.cbDateSelection", sDateFilter);
			}
			else
			{
				UpdateSearchDict("email.cbDateSelection", "");
			}
			if (sDateFilter.Equals("OFF"))
			{
				//FadeBoth.Begin()
				calStart.Opacity = 0.1;
				calEnd.Opacity = 0.1;
				dtMailDateStart.Opacity = 0.1;
				dtMailDateEnd.Opacity = 0.1;
			}
			if (sDateFilter.Equals("Between"))
			{
				//ShowBoth.Begin()
				calStart.Opacity = 1;
				calEnd.Opacity = 1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 1;
			}
			if (sDateFilter.Equals("Not Between"))
			{
				//ShowBoth.Begin()
				calStart.Opacity = 1;
				calEnd.Opacity = 1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 1;
			}
			if (sDateFilter.Equals("Before"))
			{
				//ShowLeft.Begin()
				//FadeRight.Begin()
				calStart.Opacity = 1;
				calEnd.Opacity = 0.1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 0.1;
			}
			if (sDateFilter.Equals("After"))
			{
				//ShowRight.Begin()
				//FadeLeft.Begin()
				calStart.Opacity = 0.1;
				calEnd.Opacity = 1;
				dtMailDateStart.Opacity = 0.1;
				dtMailDateEnd.Opacity = 1;
			}
			if (sDateFilter.Equals("On"))
			{
				calStart.Opacity = 1;
				calEnd.Opacity = 0.1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 0.1;
			}
			SB.Text = (string) ("Date Filter changed to : " + sDateFilter);
		}
		
		public void cbToAddr_SelectedItemChanged(System.Object sender, SelectionChangedEventArgs e)
		{
			txtcbToAddr.Text = cbToAddr.Text;
		}
		
		public void cbDateSelection_SelectedIndexChanged(System.Object sender, SelectionChangedEventArgs e)
		{
			DateChanged();
		}
		
		public void btnAutoFill_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			cbDateSelection.SelectedItem = "Between";
			cbDateSelection.Text = "Between";
			calStart.SelectedDate = DateTime.Parse("7/26/2000");
			calEnd.SelectedDate = DateTime.Parse("8/20/2011");
			txtcbFromAddr.Text = "txtcbFromAddr <from email>";
			txtcbToAddr.Text = "txtcbToAddr <to email>";
			txtSubject.Text = "txtSubject <Subject>";
			txtCCPhrase.Text = "txtCCPhrase <CC/BCC phrase>";
			txtcbFromName.Text = "txtcbFromName <From Name>";
			txtcbToName.Text = "txtcbToName <email acct>";
			txtcbFolderFilter.Text = "txtcbFolderFilter <dir>";
			txtcbCCaddr.Text = "txtcbCCaddr <CC/BCC>";
			
		}
		
		public void cbFromAddr_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			txtcbFromAddr.Text = cbFromAddr.Text;
			txtcbFromName.Text = cbFromName.SelectedItem.ToString();
			if (! formLoaded)
			{
				return;
			}
			if (cbFromAddr.SelectedItem != null)
			{
				UpdateSearchDict("email.cbFromAddr", cbFromAddr.SelectedItem.ToString());
			}
			else
			{
				UpdateSearchDict("email.cbFromAddr", "");
			}
		}
		
		public void cbToAddr_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			if (cbToAddr.SelectedItem != null)
			{
				UpdateSearchDict("email.cbToAddr", cbToAddr.SelectedItem.ToString());
			}
			else
			{
				UpdateSearchDict("email.cbToAddr", "");
			}
		}
		
		public void cbCCaddr_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			UpdateSearchDict("email.cbCCaddr", cbCCaddr.SelectedItem.ToString());
		}
		
		public void cbFolderFilter_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			if (cbFolderFilter.SelectedItem != null)
			{
				UpdateSearchDict("email.cbFolderFilter", cbFolderFilter.SelectedItem.ToString());
			}
			else
			{
				UpdateSearchDict("email.cbFolderFilter", "");
			}
			
		}
		
		public void cbToName_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			if (cbToName.SelectedItem != null)
			{
				UpdateSearchDict("email.cbToName", cbToName.SelectedItem.ToString());
			}
			else
			{
				UpdateSearchDict("email.cbToName", "");
			}
			
		}
		
		public void cbDateSelection_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			if (! formLoaded)
			{
				return;
			}
			string S = cbDateSelection.SelectedItem.ToString();
			if (cbDateSelection.SelectedValue != null)
			{
				UpdateSearchDict("email.cbDateSelection", cbDateSelection.SelectedValue.ToString());
			}
			else
			{
				UpdateSearchDict("email.cbDateSelection", "");
			}
			if (cbDateSelection.SelectedValue.ToString().Equals("OFF"))
			{
				calStart.Opacity = 0.1;
				calEnd.Opacity = 0.1;
				dtMailDateStart.Opacity = 0.1;
				dtMailDateEnd.Opacity = 0.1;
			}
			if (cbDateSelection.SelectedValue.ToString().Equals("Between"))
			{
				calStart.Opacity = 1;
				calEnd.Opacity = 1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 1;
			}
			if (cbDateSelection.SelectedValue.ToString().Equals("Not Between"))
			{
				calStart.Opacity = 1;
				calEnd.Opacity = 1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 1;
			}
			if (cbDateSelection.SelectedValue.ToString().Equals("Before"))
			{
				calStart.Opacity = 1;
				calEnd.Opacity = 0.1;
				dtMailDateStart.Opacity = 1;
				dtMailDateEnd.Opacity = 0.1;
			}
			if (cbDateSelection.SelectedValue.ToString().Equals("After"))
			{
				calStart.Opacity = 0.1;
				calEnd.Opacity = 1;
				dtMailDateStart.Opacity = 0.1;
				dtMailDateEnd.Opacity = 1;
			}
			SB.Text = (string) ("Date Filter changed to : " + cbDateSelection.SelectedValue.ToString());
		}
	}
	
}
