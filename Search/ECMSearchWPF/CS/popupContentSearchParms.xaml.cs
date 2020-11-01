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
	public partial class popupContentSearchParms
	{
		//Inherits ChildWindow
		
		//Dim proxy As New SVCSearch.Service1Client
		
		//Dim EP As New clsEndPoint
		
		bool FormLoaded = false;
		
		//Dim GVAR As App = App.Current
		clsCommonFunctions COMMON = new clsCommonFunctions();
		string Userid;
		
		clsUtility UTIL = new clsUtility();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		string CurrentCombo = "";
		//Dim ComboItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
		string[] ComboItems = null;
		//Dim dictMasterSearch As New Dictionary(Of String, String)
		bool bMyEmails = false;
		string UserGuidID = "";
		string txtFilter = "";
		//Dim formLoaded As Boolean = False
		string SecureID = "-1";
		//dictMasterSearch As New Dictionary(Of String, String)
		
		public popupContentSearchParms(int iSecureID, Dictionary<string, string> SearchDICT)
		{
			InitializeComponent();
			
			//EP.setSearchSvcEndPoint(proxy)
			
			
			Userid = GLOBALS._UserID;
			COMMON.SaveClick(6930, Userid);
			
			SecureID = iSecureID.ToString();
			//dictMasterSearch = SearchDICT
			
			
			string sVal = "";
			if (GLOBALS.dictMasterSearch != null)
			{
				foreach (string sKey in GLOBALS.dictMasterSearch.Keys)
				{
					if (GLOBALS.dictMasterSearch.ContainsKey(sKey))
					{
						
						sVal = (string) (GLOBALS.dictMasterSearch.Item(sKey));
						if (sKey.Equals("content.cbFileTypes"))
						{
							if (sVal != null)
							{
								cbFileTypes.Text = sVal;
								cbFilename.Text = sVal;
							}
						}
						else if (sKey.Equals("content.txtFileName"))
						{
							txtFileName.Text = sVal;
							cbFilename.Text = sVal;
						}
						else if (sKey.Equals("content.txtFileTypes"))
						{
							txtFileTypes.Text = sVal;
							cbFileTypes.Text = sVal;
						}
						else if (sKey.Equals("content.txtDirectory"))
						{
							txtDirectory.Text = sVal;
							cbDirs.Text = sVal;
						}
						else if (sKey.Equals("content.ckDays"))
						{
							if (sVal.Equals("true"))
							{
								ckDays.IsChecked = true;
							}
							else
							{
								ckDays.IsChecked = false;
							}
							txtDirectory.Text = sVal;
						}
						else if (sKey.Equals("content.nbrDays"))
						{
							nbrDays.Text = sVal;
						}
						else if (sKey.Equals("content.cbMeta1"))
						{
							if (sVal != null)
							{
								cbMeta1.Text = sVal;
							}
						}
						else if (sKey.Equals("content.cbMeta2"))
						{
							if (sVal != null)
							{
								cbMeta2.Text = sVal;
							}
						}
						else if (sKey.Equals("content.txtMetaSearch1"))
						{
							txtMetaSearch1.Text = sVal;
						}
						else if (sKey.Equals("content.txtMetaSearch2"))
						{
							txtMetaSearch2.Text = sVal;
						}
						else if (sKey.Equals("content.txtdtCreateDateStart"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									txtdtCreateDateStart.Text = "";
									dtCreateDateStart.SelectedDate = null;
								}
								else
								{
									txtdtCreateDateStart.Text = sVal;
									dtCreateDateStart.SelectedDate = DateTime.Parse(sVal);
								}
							}
						}
						else if (sKey.Equals("content.txtdtCreateDateEnd"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									txtdtCreateDateEnd.Text = "";
									dtCreateDateEnd.SelectedDate = null;
								}
								else
								{
									txtdtCreateDateEnd.Text = sVal;
									dtCreateDateEnd.SelectedDate = DateTime.Parse(sVal);
								}
							}
							
						}
						else if (sKey.Equals("content.cbEvalCreateTime"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									cbEvalCreateTime.Text = "";
								}
								else
								{
									cbEvalCreateTime.Text = sVal;
								}
							}
						}
						else if (sKey.Equals("content.cbEvalWriteTime"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									cbEvalWriteTime.Text = "";
								}
								else
								{
									cbEvalWriteTime.Text = sVal;
								}
							}
						}
						else if (sKey.Equals("content.txtdtLastWriteStart"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									txtdtLastWriteStart.Text = "";
									dtLastWriteStart.SelectedDate = null;
								}
								else
								{
									txtdtLastWriteStart.Text = sVal;
									dtLastWriteStart.SelectedDate = DateTime.Parse(sVal);
								}
							}
						}
						else if (sKey.Equals("content.txtdtLastWriteEnd"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									txtdtLastWriteEnd.Text = "";
									dtLastWriteEnd.SelectedDate = null;
								}
								else
								{
									txtdtLastWriteEnd.Text = sVal;
									dtLastWriteEnd.SelectedDate = DateTime.Parse(sVal);
								}
								
							}
						}
						else if (sKey.Equals("content.dtLastWriteStart"))
						{
							if (sVal != null)
							{
								if (sVal.Length == 0)
								{
									dtLastWriteStart.SelectedDate = null;
								}
								else
								{
									dtLastWriteStart.SelectedDate = DateTime.Parse(sVal);
								}
								
							}
						}
					}
				}
			}
			
			FormLoaded = true;
			
		}
		
		public void PopulateComboBoxMetadata1()
		{
			
			string ComboName = "cbData1";
			string TblColName = "AttributeName";
			string MySql = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]";
			string tVar = cbMeta1.Text;
			tVar = UTIL.RemoveSingleQuotes(tVar);
			
			if (cbMeta1.Text.Equals("*"))
			{
				MySql = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]";
			}
			else
			{
				MySql = "Select distinct [AttributeName] FROM [Attributes] where AttributeName like \'" + tVar + "\' ORDER BY [AttributeName]";
			}
			
			PopulateComboBox1(ComboName, TblColName, MySql);
			
		}
		
		public void PopulateComboBoxMetadata2()
		{
			
			string ComboName = "cbData2";
			string TblColName = "AttributeName";
			string MySql = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]";
			string tVar = cbMeta2.Text;
			tVar = UTIL.RemoveSingleQuotes(tVar);
			
			if (cbMeta1.Text.Equals("*"))
			{
				MySql = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]";
			}
			else
			{
				MySql = "Select distinct [AttributeName] FROM [Attributes] where AttributeName like \'" + tVar + "\' ORDER BY [AttributeName]";
			}
			
			
			PopulateComboBox2(ComboName, TblColName, MySql);
			
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			//ISO.DeleteDetailSearchParms("CONTENT")
			
			foreach (string sKey in GLOBALS.dictMasterSearch.Keys)
			{
				if (sKey.IndexOf("content.") + 1 > 0)
				{
					GLOBALS.dictMasterSearch.Item(sKey) = "";
				}
			}
			
			this.DialogResult = false;
			this.Close();
		}
		
		public void ckDays_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			//RotateXDaysChecked.Begin()
			
			dtLastWriteStart.SelectedDate = null;
			dtLastWriteEnd.SelectedDate = null;
			txtdtLastWriteStart.Text = "";
			txtdtLastWriteEnd.Text = "";
			
			//nbrDays.Opacity = 1
			nbrDays.Opacity = 30;
			
			UpdateSearchDict("content.ckDays", ckDays.IsChecked.ToString());
		}
		
		public void ckDays_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//RotateXDaysUnchecked.Begin()
			nbrDays.Opacity = 0.1;
			UpdateSearchDict("content.ckDays", ckDays.IsChecked.ToString());
		}
		
		public void UpdateSearchDict(string tKey, string tValue)
		{
			if (! FormLoaded)
			{
				return;
			}
			
			if (tKey.IndexOf("content.") + 1 == 0)
			{
				tKey = (string) ("content." + tKey);
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
		
		public void txtFileName_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtFileName", txtFileName.Text.Trim());
			if (txtFileName.Text.Length > 0)
			{
				cbFilename.Opacity = 1;
				btnGetFileNames.Opacity = 1;
			}
			else
			{
				cbFilename.Opacity = 0.1;
				btnGetFileNames.Opacity = 0.1;
			}
		}
		
		public void txtDirectory_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtDirectory", txtDirectory.Text.Trim());
			if (txtFileName.Text.Length > 0)
			{
				cbDirs.Opacity = 1;
				btnLoadFileDirs.Opacity = 1;
			}
			else
			{
				cbDirs.Opacity = 0.1;
				btnLoadFileDirs.Opacity = 0.1;
			}
		}
		
		private void cbFileTypes_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			UpdateSearchDict("content.cbFileTypes", cbFileTypes.SelectedItem.ToString());
		}
		
		private void txtMetaSearch1_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtMetaSearch1", txtMetaSearch1.Text.Trim());
		}
		
		private void txtMetaSearch2_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtMetaSearch2", txtMetaSearch2.Text.Trim());
		}
		
		public void btnSave_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			UpdateSearchDict("content.cbMeta1", cbMeta1.Text);
			UpdateSearchDict("content.cbMeta2", cbMeta2.Text);
			//For Each sKey As String In dictMasterSearch.Keys
			//    If InStr(sKey, "content.", CompareMethod.Text) > 0 Then
			//        dictMasterSearch.Item(sKey) = ""
			//    End If
			//Next
			
			this.DialogResult = true;
			this.Close();
		}
		
		public void PopulateComboBox1(string ComboName, string TblColName, string MySql)
		{
			CurrentCombo = ComboName;
			GLOBALS.ProxySearch.PopulateComboBoxCompleted += new System.EventHandler(client_PopulateComboBox1);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateComboBoxAsync(GLOBALS._SecureID, ComboItems, TblColName, MySql);
		}
		public void client_PopulateComboBox1(object sender, SVCSearch.PopulateComboBoxCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (CurrentCombo.Equals("cbFileTypes"))
				{
					cbFileTypes.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbMeta1"))
				{
					cbMeta1.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbMeta2"))
				{
					cbMeta2.ItemsSource = e.CB;
				}
			}
			GLOBALS.ProxySearch.PopulateComboBoxCompleted -= new System.EventHandler(client_PopulateComboBox1);
		}
		
		public void PopulateComboBox2(string ComboName, string TblColName, string MySql)
		{
			CurrentCombo = ComboName;
			GLOBALS.ProxySearch.PopulateComboBoxCompleted += new System.EventHandler(client_PopulateComboBox2);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateComboBoxAsync(GLOBALS._SecureID, ComboItems, TblColName, MySql);
		}
		public void client_PopulateComboBox2(object sender, SVCSearch.PopulateComboBoxCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (CurrentCombo.Equals("cbFileTypes"))
				{
					cbFileTypes.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbMeta1"))
				{
					cbMeta1.ItemsSource = e.CB;
				}
				if (CurrentCombo.Equals("cbMeta2"))
				{
					cbMeta2.ItemsSource = e.CB;
				}
			}
			GLOBALS.ProxySearch.PopulateComboBoxCompleted -= new System.EventHandler(client_PopulateComboBox2);
		}
		
		
		private void dtLastWriteStart_SelectedDatesChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			string S = dtLastWriteStart.SelectedDate.ToString();
			UpdateSearchDict("content.dtLastWriteStart", S);
			txtdtLastWriteStart.Text = S;
		}
		
		public void dtLastWriteEnd_SelectedDatesChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			string S = dtLastWriteEnd.SelectedDate.ToString();
			UpdateSearchDict("content.dtLastWriteEnd", S);
			txtdtLastWriteEnd.Text = S;
		}
		
		public void dtCreateDateStart_SelectedDatesChanged_1(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			string S = dtCreateDateStart.SelectedDate.ToString();
			UpdateSearchDict("content.dtCreateDateStart", S);
			txtdtCreateDateStart.Text = S;
		}
		
		public void dtCreateDateEnd_SelectedDatesChanged_1(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			string S = dtCreateDateEnd.SelectedDate.ToString();
			UpdateSearchDict("content.dtCreateDateEnd", S);
			txtdtCreateDateEnd.Text = S;
		}
		
		public void dtLastWriteStart_SelectedDatesChanged_1(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			string S = dtLastWriteStart.SelectedDate.ToString();
			UpdateSearchDict("content.dtLastWriteStart", S);
			txtdtLastWriteStart.Text = S;
		}
		
		public void txtdtCreateDateStart_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtdtCreateDateStart", txtdtCreateDateStart.Text);
		}
		
		public void txtdtCreateDateEnd_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtdtCreateDateEnd", txtdtCreateDateEnd.Text);
		}
		
		public void txtdtLastWriteStart_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtdtLastWriteStart", txtdtLastWriteStart.Text);
		}
		
		public void txtdtLastWriteEnd_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtdtLastWriteEnd", txtdtLastWriteEnd.Text);
		}
		
		public void txtMetaSearch1_TextChanged_1(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtMetaSearch1", txtMetaSearch1.Text);
		}
		
		public void txtMetaSearch2_TextChanged_1(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtMetaSearch2", txtMetaSearch2.Text);
		}
		
		public void Button1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			txtFileTypes.Text = "<txtFileTypes>";
			txtFileName.Text = "<txtFileName>";
			txtDirectory.Text = "<txtDirectory>";
			txtDirectory.Text = "<txtDirectory>";
			cbMeta1.Text = "<cbMeta1>";
			txtMetaSearch1.Text = "<txtMetaSearch1>";
			cbMeta2.Text = "<cbMeta2>";
			ckDays.IsChecked = true;
			nbrDays.Text = "360";
			txtMetaSearch2.Text = "<txtMetaSearch2>";
			cbEvalCreateTime.Text = "Between";
			cbEvalWriteTime.Text = "Between";
			
			cbEvalCreateTime.SelectedItem = "Between";
			cbEvalWriteTime.SelectedItem = "Between";
			
			dtCreateDateStart.SelectedDate = DateTime.Parse("8/11/2005");
			dtCreateDateEnd.SelectedDate = DateTime.Parse("8/11/2011");
			dtLastWriteStart.SelectedDate = DateTime.Parse("8/11/2007");
			dtLastWriteEnd.SelectedDate = DateTime.Parse("8/21/2011");
			
		}
		
		public void BtnCbMeta1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateComboBoxMetadata1();
		}
		
		public void BtnCbMeta2_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateComboBoxMetadata2();
		}
		
		public void PopulateCbFilename()
		{
			string MySql = "Select distinct [SourceName] FROM [DataSource] where SourceName like \'" + txtFileName.Text.Trim() + "\' ORDER BY [SourceName]";
			GLOBALS.ProxySearch.PopulateComboBoxCompleted += new System.EventHandler(client_PopulateCbFilename);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateComboBoxAsync(GLOBALS._SecureID, ComboItems, "SourceName", MySql);
		}
		public void client_PopulateCbFilename(object sender, SVCSearch.PopulateComboBoxCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				cbFilename.ItemsSource = e.CB;
			}
			GLOBALS.ProxySearch.PopulateComboBoxCompleted -= new System.EventHandler(client_PopulateComboBox1);
		}
		public void btnGetFileNames_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateCbFilename();
		}
		
		public void PopulateCbDirs()
		{
			string MySql = "Select distinct [FileDirectory] FROM [DataSource] where FileDirectory like \'" + txtDirectory.Text.Trim() + "\' ORDER BY [FileDirectory]";
			GLOBALS.ProxySearch.PopulateComboBoxCompleted += new System.EventHandler(client_PopulateCbDirs);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateComboBoxAsync(GLOBALS._SecureID, ComboItems, "FileDirectory", MySql);
		}
		public void client_PopulateCbDirs(object sender, SVCSearch.PopulateComboBoxCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				cbDirs.ItemsSource = e.CB;
			}
			GLOBALS.ProxySearch.PopulateComboBoxCompleted -= new System.EventHandler(client_PopulateComboBox1);
		}
		public void btnLoadFileDirs_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateCbDirs();
		}
		
		
		public void PopulateCbFileTypes()
		{
			string MySql = "";
			if (cbFileTypes.Text == null)
			{
				cbFileTypes.Text = "*";
			}
			if (cbFileTypes.Text.Trim().Equals("*"))
			{
				MySql = "Select distinct [OriginalFileType] FROM [DataSource] ORDER BY [OriginalFileType]";
			}
			else
			{
				MySql = "Select distinct [OriginalFileType] FROM [DataSource] where OriginalFileType like \'" + txtFileTypes.Text.Trim() + "\' ORDER BY [OriginalFileType]";
			}
			
			GLOBALS.ProxySearch.PopulateComboBoxCompleted += new System.EventHandler(client_PopulateCbFileTypes);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.PopulateComboBoxAsync(GLOBALS._SecureID, ComboItems, "OriginalFileType", MySql);
		}
		public void client_PopulateCbFileTypes(object sender, SVCSearch.PopulateComboBoxCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				cbFileTypes.ItemsSource = e.CB;
			}
			GLOBALS.ProxySearch.PopulateComboBoxCompleted -= new System.EventHandler(client_PopulateComboBox1);
		}
		
		public void btnGetFileTypes_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			PopulateCbFileTypes();
		}
		
		public void btnreset_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			txtFileName.Text = "";
			txtDirectory.Text = "";
			cbFilename.Text = "";
			cbDirs.Text = "";
			txtFileTypes.Text = "";
			cbFileTypes.Text = "";
			ckDays.IsChecked = false;
			nbrDays.Text = "0";
			cbMeta1.Text = "";
			txtMetaSearch1.Text = "";
			cbMeta2.Text = "";
			txtMetaSearch2.Text = "";
			cbEvalCreateTime.Text = "OFF";
			cbEvalWriteTime.Text = "OFF";
			dtCreateDateStart.SelectedDate = null;
			dtCreateDateEnd.SelectedDate = null;
			dtLastWriteStart.SelectedDate = null;
			dtLastWriteEnd.SelectedDate = null;
			
		}
		
		public void txtFileTypes_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			UpdateSearchDict("content.txtFileTypes", txtFileTypes.Text.Trim());
			if (txtFileTypes.Text.Length > 0)
			{
				cbFileTypes.Opacity = 1;
				btnGetFileTypes.Opacity = 1;
			}
			else
			{
				cbFileTypes.Opacity = 0.1;
				btnGetFileTypes.Opacity = 0.1;
			}
		}
		
		
		public void nbrDays_TextChanged(object sender, TextChangedEventArgs e)
		{
			UpdateSearchDict("content.nbrDays", nbrDays.Text);
		}
		
		public void cbFileTypes_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			txtFileTypes.Text = cbFileTypes.Text;
		}
		
		public void cbFilename_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			txtFileName.Text = cbFilename.Text;
		}
		
		public void cbDirs_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			txtDirectory.Text = cbDirs.Text;
		}
		
		public void cbEvalCreateTime_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			UpdateSearchDict("content.cbEvalCreateTime", cbEvalCreateTime.SelectedItem.ToString());
			
			string sDateFilter = cbEvalCreateTime.Text;
			if (sDateFilter != null)
			{
				UpdateSearchDict("content.cbEvalCreateTime", sDateFilter);
			}
			else
			{
				UpdateSearchDict("content.cbEvalCreateTime", "");
			}
			
			ckDays.IsChecked = false;
			nbrDays.Text = "0";
			
			if (sDateFilter.Equals("OFF"))
			{
				dtCreateDateStart.SelectedDate = null;
				dtCreateDateEnd.SelectedDate = null;
				txtdtCreateDateStart.Text = "";
				txtdtCreateDateEnd.Text = "";
				
				dtCreateDateStart.Opacity = 0.1;
				dtCreateDateEnd.Opacity = 0.1;
				txtdtCreateDateStart.Opacity = 0.1;
				txtdtCreateDateEnd.Opacity = 0.1;
			}
			if (sDateFilter.Equals("Between"))
			{
				dtCreateDateStart.Opacity = 1;
				dtCreateDateEnd.Opacity = 1;
				txtdtCreateDateStart.Opacity = 1;
				txtdtCreateDateEnd.Opacity = 1;
				
				dtCreateDateStart.SelectedDate = null;
				dtCreateDateEnd.SelectedDate = null;
				txtdtCreateDateStart.Text = "";
				txtdtCreateDateEnd.Text = "";
				
			}
			if (sDateFilter.Equals("Not Between"))
			{
				dtCreateDateStart.Opacity = 1;
				dtCreateDateEnd.Opacity = 1;
				txtdtCreateDateStart.Opacity = 1;
				txtdtCreateDateEnd.Opacity = 1;
				
				dtCreateDateStart.SelectedDate = null;
				dtCreateDateEnd.SelectedDate = null;
				txtdtCreateDateStart.Text = "";
				txtdtCreateDateEnd.Text = "";
			}
			if (sDateFilter.Equals("Before"))
			{
				dtCreateDateStart.Opacity = 1;
				dtCreateDateEnd.Opacity = 0.1;
				txtdtCreateDateStart.Opacity = 1;
				txtdtCreateDateEnd.Opacity = 0.1;
				
				dtCreateDateStart.SelectedDate = null;
				dtCreateDateEnd.SelectedDate = null;
				txtdtCreateDateStart.Text = "";
				txtdtCreateDateEnd.Text = "";
			}
			if (sDateFilter.Equals("After"))
			{
				dtCreateDateStart.Opacity = 0.1;
				dtCreateDateEnd.Opacity = 1;
				txtdtCreateDateStart.Opacity = 0.1;
				txtdtCreateDateEnd.Opacity = 1;
				
				dtCreateDateStart.SelectedDate = null;
				dtCreateDateEnd.SelectedDate = null;
				txtdtCreateDateStart.Text = "";
				txtdtCreateDateEnd.Text = "";
			}
			if (sDateFilter.Equals("On"))
			{
				dtCreateDateStart.Opacity = 1;
				dtCreateDateEnd.Opacity = 0.1;
				txtdtCreateDateStart.Opacity = 1;
				txtdtCreateDateEnd.Opacity = 0.1;
				
				dtCreateDateStart.SelectedDate = null;
				dtCreateDateEnd.SelectedDate = null;
				txtdtCreateDateStart.Text = "";
				txtdtCreateDateEnd.Text = "";
			}
			
			SB.Text = (string) ("Date Filter changed to : " + sDateFilter);
		}
		
		public void cbEvalWriteTime_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			UpdateSearchDict("content.cbEvalWriteTime", cbEvalWriteTime.SelectedItem.ToString());
			
			string sDateFilter = cbEvalWriteTime.Text;
			if (sDateFilter != null)
			{
				UpdateSearchDict("content.cbEvalWriteTime", sDateFilter);
			}
			else
			{
				UpdateSearchDict("content.cbEvalWriteTime", "");
			}
			
			ckDays.IsChecked = false;
			nbrDays.Text = "0";
			
			dtLastWriteStart.SelectedDate = null;
			dtLastWriteEnd.SelectedDate = null;
			txtdtLastWriteStart.Text = "";
			txtdtLastWriteEnd.Text = "";
			
			if (sDateFilter.Equals("OFF"))
			{
				dtLastWriteStart.Opacity = 0.1;
				dtLastWriteEnd.Opacity = 0.1;
				txtdtLastWriteStart.Opacity = 0.1;
				txtdtLastWriteEnd.Opacity = 0.1;
			}
			if (sDateFilter.Equals("Between"))
			{
				dtLastWriteStart.Opacity = 1;
				dtLastWriteEnd.Opacity = 1;
				txtdtLastWriteStart.Opacity = 1;
				txtdtLastWriteEnd.Opacity = 1;
			}
			if (sDateFilter.Equals("Not Between"))
			{
				dtLastWriteStart.Opacity = 1;
				dtLastWriteEnd.Opacity = 1;
				txtdtLastWriteStart.Opacity = 1;
				txtdtLastWriteEnd.Opacity = 1;
			}
			if (sDateFilter.Equals("Before"))
			{
				dtLastWriteStart.Opacity = 1;
				dtLastWriteEnd.Opacity = 0.1;
				txtdtLastWriteStart.Opacity = 1;
				txtdtLastWriteEnd.Opacity = 0.1;
			}
			if (sDateFilter.Equals("After"))
			{
				dtLastWriteStart.Opacity = 0.1;
				dtLastWriteEnd.Opacity = 1;
				txtdtLastWriteStart.Opacity = 0.1;
				txtdtLastWriteEnd.Opacity = 1;
			}
			if (sDateFilter.Equals("On"))
			{
				dtLastWriteStart.Opacity = 1;
				dtLastWriteEnd.Opacity = 0.1;
				txtdtLastWriteStart.Opacity = 1;
				txtdtLastWriteEnd.Opacity = 0.1;
			}
			SB.Text = (string) ("Date Filter changed to : " + sDateFilter);
		}
		
		public void cbMeta1_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			UpdateSearchDict("content.cbMeta1", cbMeta1.SelectedItem.ToString());
		}
		
		public void cbMeta2_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
		{
			UpdateSearchDict("content.cbMeta2", cbMeta2.SelectedItem.ToString());
		}
	}
	
}
