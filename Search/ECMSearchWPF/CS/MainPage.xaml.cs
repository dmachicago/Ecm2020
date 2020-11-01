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

using System.IO;
using System.Windows.Controls.Primitives;
using System.Windows.Automation;
using Microsoft.Win32;
using System.ComponentModel;
using System.Data;


namespace ECMSearchWPF
{
	public partial class MainPage
	{
		
		//Private WithEvents btnPlus As Button
		//Private WithEvents btnMinus As Button
		
		string ClcURL = "";
		string ArchiverURL = "";
		
		bool bQuickSearchRecall = false;
		int nbrExecutedSearches = 0;
		
		clsParms PRM = new clsParms();
		int currSearchCnt = 0;
		bool UseISO = false;
		
		bool DoNotApplyQuickSearch = false;
		string SelectedGrid = "";
		
		int iTotalToProcess = 0;
		int iTotalProcessed = 0;
		
		bool bSpellCheckLoaded = false;
		//Dim proxy As New SVCSearch.Service1Client
		SVCSearch.Service1Client proxy2 = new SVCSearch.Service1Client();
		//Dim clsGVAR As App = App.Current
		
		int PrevListOfContentCnt = 0;
		int PrevListOfEmailCnt = 0;
		
		bool bGhostFetchActive = false;
		int ButtonBounce = 0;
		bool ExecutingSearch = false;
		
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		SaveFileDialog dSave = new SaveFileDialog();
		
		//******** DICTIONARIES: Grid Sort and Display Order ********
		Dictionary<int, string> dictEmailGridColDisplayOrder = new Dictionary<int, string>();
		Dictionary<int, string> dictEmailGridColSortOrder = new Dictionary<int, string>();
		Dictionary<int, string> dictContentGridColDisplayOrder = new Dictionary<int, string>();
		Dictionary<int, string> dictContentGridColSortOrder = new Dictionary<int, string>();
		
		Dictionary<string, string> dictScreenControls = new Dictionary<string, string>();
		Dictionary<string, string> dictGridParmsEmail = new Dictionary<string, string>();
		Dictionary<string, string> dictGridParmsContent = new Dictionary<string, string>();
		
		Dictionary<string, string> dictEmailSearch = new Dictionary<string, string>();
		Dictionary<string, string> dictContentSearch = new Dictionary<string, string>();
		
		List<string> ListOfQuickSearch = new List<string>();
		int MaxQuickSearchEntry = 50;
		
		Dictionary<string, int> DictGuids = new Dictionary<string, int>();
		//******** END OF Grid Sort and Display Order ********
		
		int TopRow = 0;
		int EmailTriggerRow = 0;
		int ContentTriggerRow = 0;
		bool bNewRows = false;
		bool bFirstContentSearchSubmit = false;
		bool bFirstEmailSearchSubmit = false;
		
		int EmailSearchCnt = 0;
		int ContentSearchCnt = 0;
		
		int PrevTopRow = 0;
		bool bStartNewSearch = true;
		string SecureID; // VBConversions Note: Initial value of "SecureID" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		string ParmName = "";
		Guid CurrSessionGuid = null;
		string LoginID = "";
		string CompanyID = "";
		string RepoID = "";
		string EncryptPW = "";
		
		bool bEmailRowHeightSet = false;
		bool bSettingEmailRowHeight = false;
		bool bEmailScrolling = false;
		bool bContentScrolling = false;
		
		string GeneratedSql = "";
		
		int _startRow = 0;
		int _pageSize = 20;
		bool _loading = System.Convert.ToBoolean(null);
		
		string PrevText = "";
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		
		int RID = 0;
		
		string filePreviewName = "";
		
		System.Collections.Generic.List<SVCSearch.DS_SearchTerms> ListOfSearchTerms = new System.Collections.Generic.List<SVCSearch.DS_SearchTerms>();
		List<SVCSearch.DS_USERSEARCHSTATE> SearchHistory;
		
		string CurrAttachmentRowID = "";
		int CurrentDocPage = 1;
		int CurrentEmailPage = 1;
		
		bool bSaveSearchesToDB = false;
		string RepoTableName = "";
		string CurrentGuid = "";
		string ClipBoardSql = "";
		int CurrentSearchIdHigh;
		List<string> ListOfLibraries = new List<string>();
		List<string> ListOfGridCols = new List<string>();
		//Dim ObjListOfGridCols As Object = Nothing
		
		string LibraryOwnerGuid = "";
		
		string returnMsg = "";
		bool RC = false;
		
		int iSearchCnt = 0;
		int iMaxSearchCnt = 0;
		clsGridMgt GM = new clsGridMgt();
		clsCommonFunctions COMMON = new clsCommonFunctions();
		
		bool bWaitToApplyAttachmentWeight = false;
		string Author = "";
		TimeSpan TS = null;
		DateTime qStartTime = DateTime.Now;
		DateTime qEndTime = DateTime.Now;
		
		string getDatasourceParmSourceGuid = "";
		string getDatasourceParmSourceTypeCode = "";
		string getDatasourceParmSourceCreateDate;
		string getDatasourceParmSourceAllrecipiants;
		string getDatasourceParmSourceFQN;
		string getDatasourceParmSourceFileLength;
		string getDatasourceParmSourceWeight;
		
		List<string> lstSearchHistory = new List<string>();
		
		string strAuthor = "";
		string strTitle = "";
		
		bool DoNotGetSearchHistory = false;
		
		bool gettingAuthor = false;
		bool gettingTitle = false;
		
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		clsgetUserParm UPARM = new clsgetUserParm();
		//Dim USERPARMS As New clsUserParms
		clsGLOBALSEACHRESULTS GS = new clsGLOBALSEACHRESULTS();
		
		clsSql SQLGEN = new clsSql();
		
		//Dim PROC As New clsProcess
		//Dim SPELL As New clsSpelling
		//Dim SPARMS As New clsSEARHPARMSHISTORY
		//Dim DB As New clsDatabase
		//Dim DG As New clsDataGrid
		//Dim LM As New clsLicenseMgt
		//Dim APPS As New clsAppParms
		//Dim GRP As New clsUSERGROUP
		//Dim LI As New clsLIBRARYITEMS
		//Dim GS As New clsGLOBALSEACHRESULTS
		//Dim RESTORE As New clsRestore
		//Dim CP As New clsProcess
		//Dim DRHIST As New clsDATASOURCERESTOREHISTORY
		//Dim ARCH As New clsArchiver
		//Dim ASG As New clsACTIVESEARCHGUIDS
		clsSEARCHHISTORY SHIST = new clsSEARCHHISTORY();
		
		string AutoGenSql = "";
		int NbrDocsLoaded = 0;
		string GenEmailSql = "";
		string GenDocSql = "";
		int CurrentlySelectedEmailColumn = -1;
		int CurrentlySelectedContentColumn = -1;
		
		Dictionary<string, int> AttachmentWeights = new Dictionary<string, int>();
		bool gettingGetAttachmentWeights = false;
		
		int MinWeight = 0;
		bool GenSqlOnly = false;
		string CB_SQL = "";
		DateTime qStart = DateTime.Now;
		DateTime qEnd = DateTime.Now;
		
		bool RowChanged = false;
		string xEmailQry = "";
		string xDocQry = "";
		int TotalEmails = 0;
		int TotalDocs = 0;
		
		bool bInitPageDataNeeded = true;
		string bUsePageData = "0";
		int PageRowLimit = 75;
		int PageRowIncrement = 25;
		
		int DocLowerPageNbr = 1;
		int DocUpperPageNbr; // VBConversions Note: Initial value of "75" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		int EmailLowerPageNbr = 1;
		int EmailUpperPageNbr; // VBConversions Note: Initial value of "75" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		bool bNeedRowCount = false;
		bool bEmailSearchRequested = false;
		bool bDocSearchRequested = false;
		bool bNavButtonPushed = false;
		
		int TotalEmailPages = 0;
		int TotalEmailRows = 0;
		int TotalDocPages = 0;
		int TotalDocRows = 0;
		
		bool EmailGridHasFocus = false;
		bool DocGridHasFocus = false;
		
		int PrevEmailRow = -1;
		int PrevContentRow = -1;
		string CurrentlySelectedGrid = "";
		bool UseFastMethod = false;
		
		bool bGridColsRetrieved = false;
		private bool SkipExistingFiles = false;
		private bool OverwriteExistingFiles = false;
		private bool doThisForAllFiles = false;
		private bool VersionFiles = false;
		
		List<string> SearchHistoryList = new List<string>();
		string[] SearchHistoryArrayList;
		bool LoadingHistorySearch = false;
		
		bool FormLoaded = false;
		string DocsSql = "";
		string EmailSql = "";
		string xWC = "";
		bool dDebug = false;
		string CurrUserGuidID; // VBConversions Note: Initial value of """" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		string CurrLoginID; // VBConversions Note: Initial value of """" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		int iCurrRowMin = 0;
		int iCurrRowMax; // VBConversions Note: Initial value of "75" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		string EP1; // VBConversions Note: Initial value of "ISO.SetCLC_State2(CurrLoginID, "IDENTIFIED", "", "")" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		string EP2; // VBConversions Note: Initial value of "ISO.SetSAAS_State(GLOBALS.UserGuid, "ACTIVE", "", "")" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		//Dim MD As SpellDictionary = _c1SpellChecker.MainDictionary
		//Dim UD As UserDictionary = _c1SpellChecker.UserDictionary
		//Dim DictUri As New Uri("./SpellCheck/C1Spell_en-US.dct", UriKind.RelativeOrAbsolute)
		//Dim tPAth As String = Application.Current.Host.Source.LocalPath
		
		//Dim SpellDLG As C1.Silverlight.SpellChecker.ISpellDialog
		//Dim _c1SpellChecker As New C1.Silverlight.SpellChecker.C1SpellChecker
		
		//** System parms MUST b loaded at startup time - we need a "Startup"
		//splash screen that can be used for rebranding and loading all the
		//intialization parameters.
		
		public MainPage()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			SecureID = SecureID;
			DocUpperPageNbr = 75;
			EmailUpperPageNbr = 75;
			CurrUserGuidID = "";
			CurrLoginID = "";
			iCurrRowMax = 75;
			EP1 = ISO.SetCLC_State2(CurrLoginID, "IDENTIFIED", "", "");
			EP2 = ISO.SetSAAS_State(GLOBALS.UserGuid, "ACTIVE", "", "");
			
			InitializeComponent();
			
			setAuthority();
			
			//*** Reset these later
			PB.Visibility = System.Windows.Visibility.Collapsed;
			ckMasterOnly.Visibility = Visibility.Collapsed;
			
			SecureID = SecureID;
			CurrSessionGuid = GLOBALS.SessionGuid;
			
			getStaticVars();
			
			GLOBALS.ProxySearch.SetSAASStateAsync(GLOBALS._SecureID, GLOBALS._UserGuid, "SAAS_STATE", "ACTIVE");
			
			if (this.Resources.Contains("SessionGuid"))
			{
				CurrSessionGuid = this.Resources["SessionGuid"];
			}
			
			if (this.Resources.Contains("CompanyID"))
			{
				CompanyID = (string) (this.Resources["CompanyID"]);
			}
			if (this.Resources.Contains("RepoID"))
			{
				RepoID = (string) (this.Resources["RepoID"]);
			}
			if (this.Resources.Contains("UserID"))
			{
				RepoID = (string) (this.Resources["UserID"]);
			}
			
			nbrDocRows.Text = PageRowLimit.ToString();
			nbrEmailRows.Text = PageRowLimit.ToString();
			
			SetInactiveStateOfForm();
			
			lblIsPublicShow.Visibility = System.Windows.Visibility.Collapsed;
			LblIsWebShow.Visibility = System.Windows.Visibility.Collapsed;
			LblCkIsMasterShow.Visibility = System.Windows.Visibility.Collapsed;
			lblRssPull.Visibility = System.Windows.Visibility.Collapsed;
			
			gridPreview.Visibility = System.Windows.Visibility.Collapsed;
			gridTabs.Visibility = System.Windows.Visibility.Collapsed;
			
			SetFilterVisibility();
			
			LoadSystemParameters();
			getServerInstanceName();
			getServerMachineName();
			getLoggedInUser();
			getAttachedMachineName();
			populateLibraryComboBox();
			
			SetDefaultScreen();
			
			ISO.DeleteDetailSearchParms("EMAIL");
			ISO.DeleteDetailSearchParms("CONTENT");
			
			ISO.PreviewFileInit(CompanyID, RepoID, "NONE SUPPLIED");
			ISO.initFileRestoreData();
			ISO.initFilePreviewData();
			
			dgAttachments.Visibility = System.Windows.Visibility.Collapsed;
			
			Console.WriteLine("EP1: " + EP1);
			
			COMMON.SaveClick(10, GLOBALS.UserGuid);
			
			//AddHandler Application.Current.Exit, AddressOf App_Exit
			
			dgContent.ItemsSource = GLOBALS.gListOfContent;
			dgEmails.ItemsSource = GLOBALS.gListOfEmails;
			//dgEmails.ItemsSource = gEmailDT
			Console.WriteLine("EP2: " + EP2);
			
			getArchiverURL();
			getClcURL();
			
			SearchHistoryReload();
			getSavedContentGridColumnsDisplayOrder();
			getSavedEmailGridColumnsDisplayOrder();
			
			lblUserID.Content = GLOBALS.UserID;
			
			GLOBALS.initDataTableEmail();
			
		}
		
		/// <summary>
		/// Gets the archiver URL.
		/// </summary>
		public void getArchiverURL()
		{
			GLOBALS.ProxySearch.getArchiverURLCompleted += new System.EventHandler(client_ArchiverURL);
			GLOBALS.ProxySearch.getArchiverURLAsync();
		}
		
		/// <summary>
		/// Handles the ArchiverURL event of the client control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="SVCSearch.getArchiverURLCompletedEventArgs"/> instance containing the event data.</param>
		public void client_ArchiverURL(object sender, SVCSearch.getArchiverURLCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				ArchiverURL = (string) e.Result;
			}
			else
			{
				ArchiverURL = "http://www.EcmLibrary.com/ECMSaaS/ArchiverCLC/publish.htm";
			}
			GLOBALS.ProxySearch.getArchiverURLCompleted -= new System.EventHandler(client_ArchiverURL);
		}
		
		/// <summary>
		/// Gets the CLC URL.
		/// </summary>
		public void getClcURL()
		{
			GLOBALS.ProxySearch.getClcURLCompleted += new System.EventHandler(client_ClcURL);
			GLOBALS.ProxySearch.getClcURLAsync();
		}
		
		public void client_ClcURL(object sender, SVCSearch.getClcURLCompletedEventArgs e)
		{
			//This is the Downloader install URL
			if (e.Error == null)
			{
				ClcURL = (string) e.Result;
			}
			else
			{
				ClcURL = "http://www.EcmLibrary.com/ECMSaaS/ClcDownloader/publish.htm";
			}
		}
		
		public void getAffinity()
		{
			GLOBALS.ProxySearch.getAffinitydelayCompleted += new System.EventHandler(client_getAffinity);
			GLOBALS.ProxySearch.getAffinitydelayAsync();
		}
		public void client_getAffinity(object sender, SVCSearch.getAffinitydelayCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				GLOBALS.AffinityDelay = System.Convert.ToInt32(e.Result);
			}
			else
			{
				GLOBALS.AffinityDelay = 25;
			}
		}
		
		public void LoadSystemParameters()
		{
			GLOBALS.ProxySearch.getSystemParmCompleted += new System.EventHandler(client_LoadSystemParameters);
			GLOBALS.ProxySearch.getSystemParmAsync(SecureID, modGlobals.gSystemParms);
		}
		
		public void client_LoadSystemParameters(object sender, SVCSearch.getSystemParmCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				
				string tVAl = "";
				int II = System.Convert.ToInt32(e.SystemParms.Count);
				foreach (string tKey in e.SystemParms.Keys)
				{
					tVAl = (string) (e.SystemParms.Item(tKey));
					if (! modGlobals.gSystemParms.ContainsKey(tKey))
					{
						modGlobals.gSystemParms.Add(tKey, tVAl);
					}
				}
				SB.Text = "System Parms Loaded: " + modGlobals.gSystemParms.Count + " and DB Connection good.";
				Console.WriteLine(e.SystemParms.Count);
			}
			else
			{
				SB.Text = "System Parms failed to Load / DB Failed to attach.";
			}
			GLOBALS.ProxySearch.getSystemParmCompleted -= new System.EventHandler(client_LoadSystemParameters);
		}
		
		public bool isKeyWord(string KW)
		{
			bool B = false;
			KW = KW.ToUpper();
			switch (KW)
			{
				case "AND":
					return true;
				case "OR":
					return true;
				case "NOT":
					return true;
				case "NEAR":
					return true;
				case "AND":
					return true;
				case "FORMSOF":
					return true;
			}
			return B;
		}
		
		public bool CkForNearClause(string sText)
		{
			
			int I = 0;
			bool B = false;
			string[] Words;
			Words = sText.Split(" ".ToCharArray());
			string PWord = "";
			
			foreach (string CWord in Words)
			{
				if (CWord.ToUpper().Equals("NEAR"))
				{
					if (isKeyWord(PWord))
					{
						B = true;
						break;
					}
				}
				PWord = CWord;
			}
			
			return B;
		}
		
		public void btnSubmit_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			bool bProb = CkForNearClause(txtSearch.Text.Trim());
			if (bProb)
			{
				MessageBox.Show("The word \'NEAR\' maybe preceeded by a keyword, this may cause this search to fail.");
			}
			
			nbrExecutedSearches++;
			
			currSearchCnt = 0;
			bFirstEmailSearchSubmit = true;
			bFirstContentSearchSubmit = true;
			
			QuickSearchAdd();
			
			ButtonBounce = 0;
			DictGuids.Clear();
			bEmailScrolling = false;
			bContentScrolling = false;
			
			EmailSearchCnt = 0;
			ContentSearchCnt = 0;
			
			PageRowLimit = int.Parse(nbrEmailRows.Text);
			
			PerformSearch(true);
			
		}
		
		public void Handler_frmSearchAsst_closed(object sender, EventArgs e)
		{
			string NewSearchCriteria = "";
			frmSearchAsst lw = (frmSearchAsst) sender;
			if (lw.DialogResult == true)
			{
				NewSearchCriteria = lw.SearchCriteria;
				txtSearch.Text = NewSearchCriteria;
			}
			
			//Dim A() As String = Split(txtSearch.Text, " ")
			
			//UpdateSearchDict("asst.txtAllOfTheseWords", txtAllOfTheseWords.Text.Trim)
			//UpdateSearchDict("asst.ckPhrase", ckPhrase.ToString)
			//UpdateSearchDict("asst.ckNear", ckNear.ToString)
			//UpdateSearchDict("asst.ckNone", ckNone.ToString)
			//UpdateSearchDict("asst.ckInflection", ckPhrase.ToString)
			//UpdateSearchDict("asst.ckClassonomy", ckPhrase.ToString)
			//UpdateSearchDict("asst.txtExactPhrase", txtExactPhrase.Text.Trim)
			//UpdateSearchDict("asst.txtAnyOfThese", txtAnyOfThese.Text.Trim)
			//UpdateSearchDict("asst.txtNear", txtNear.Text.Trim)
			//UpdateSearchDict("asst.txtNoneOfThese", txtNoneOfThese.Text.Trim)
			//UpdateSearchDict("asst.txtInflection", txtInflection.Text.Trim)
			//UpdateSearchDict("asst.txtMsThesuarus", txtMsThesuarus.Text.Trim)
			//UpdateSearchDict("asst.txtEcmThesaurus", txtEcmThesaurus.Text.Trim)
			//UpdateSearchDict("asst.cbAvailThesauri", cbAvailThesauri.Text.Trim)
			//UpdateSearchDict("asst.cbSelectedThesauri", cbSelectedThesauri.Text.Trim)
			
			//UpdateSearchDict("asst.cbDateRange", cbDateRange.Text.Trim)
			//UpdateSearchDict("asst.dtStart", dtStart.SelectedDate.ToString)
			//UpdateSearchDict("asst.dtEnd", dtEnd.SelectedDate.ToString)
		}
		//Private Sub SubMenuContent_Click(ByVal sender As System.Object, ByVal e As RoutedEventArgs) Handles SubMenuContent.Click
		//    SB.Text = "Content SubMenuContent Clicked"
		//    MessageBox.Show("SubMenuContent Pressed")
		//End Sub
		
		//Private Sub SubMenuEmail_Click(ByVal sender As System.Object, ByVal e As RoutedEventArgs) Handles SubMenuEmail.Click
		//    SB.Text = "Content SubMenuEmail Clicked"
		//    MessageBox.Show("SubMenuEmail Pressed")
		//End Sub
		
		public void btnReset_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			txtSearch.Text = "";
			ckShowDetails.IsChecked = false;
			ckMyContent.IsChecked = false;
			ckMasterOnly.IsChecked = false;
			nbrWeightMin.Text = "0";
			rbContent.IsChecked = false;
			rbEmails.IsChecked = false;
			rbAll.IsChecked = false;
			ckLimitToLib.IsChecked = false;
			ckFilters.IsChecked = false;
			//dgEmails.ItemsSource = Nothing
			//dgContent.ItemsSource = Nothing
			PB.Visibility = System.Windows.Visibility.Collapsed;
			SB.Text = "";
		}
		
		private void txtSearch_MouseRightButtonDown(System.Object sender, System.Windows.Input.MouseButtonEventArgs e)
		{
			SB.Text = "Search Assistant";
			frmSearchAsst NextPage = new frmSearchAsst(int.Parse(SecureID));
			NextPage.Show();
		}
		
		public void SetFilterVisibility()
		{
			if (ckFilters.IsChecked)
			{
				ckLimitToLib.Visibility = System.Windows.Visibility.Visible;
				cbLibrary.Visibility = System.Windows.Visibility.Visible;
				rbAll.Visibility = System.Windows.Visibility.Visible;
				rbEmails.Visibility = System.Windows.Visibility.Visible;
				rbContent.Visibility = System.Windows.Visibility.Visible;
				ckMyContent.Visibility = System.Windows.Visibility.Visible;
				ckWeights.Visibility = System.Windows.Visibility.Visible;
				ckMasterOnly.Visibility = System.Windows.Visibility.Visible;
				nbrWeightMin.Visibility = System.Windows.Visibility.Visible;
				btnLibrary.Visibility = System.Windows.Visibility.Visible;
				
				btnReset.Visibility = Visibility.Visible;
				ckShowDetails.Visibility = Visibility.Visible;
				
				if (GLOBALS._isAdmin)
				{
					hlScheduleSearch.Visibility = Visibility.Visible;
					hlAlerts.Visibility = Visibility.Visible;
				}
				else
				{
					hlScheduleSearch.Visibility = Visibility.Collapsed;
					hlAlerts.Visibility = Visibility.Collapsed;
				}
			}
			else
			{
				ckLimitToLib.Visibility = System.Windows.Visibility.Collapsed;
				cbLibrary.Visibility = System.Windows.Visibility.Collapsed;
				rbAll.Visibility = System.Windows.Visibility.Collapsed;
				rbEmails.Visibility = System.Windows.Visibility.Collapsed;
				rbContent.Visibility = System.Windows.Visibility.Collapsed;
				ckMyContent.Visibility = System.Windows.Visibility.Collapsed;
				ckWeights.Visibility = System.Windows.Visibility.Collapsed;
				ckMasterOnly.Visibility = System.Windows.Visibility.Collapsed;
				nbrWeightMin.Visibility = System.Windows.Visibility.Collapsed;
				btnLibrary.Visibility = System.Windows.Visibility.Collapsed;
				
				btnReset.Visibility = Visibility.Collapsed;
				ckShowDetails.Visibility = Visibility.Collapsed;
				hlScheduleSearch.Visibility = Visibility.Collapsed;
				hlAlerts.Visibility = Visibility.Collapsed;
				
				hlScheduleSearch.Visibility = System.Windows.Visibility.Collapsed;
			}
			
		}
		
		public void ckFilters_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			SetFilterVisibility();
			UdpateSearchTerm("ALL", "ckFilters", ckFilters.IsChecked, "B");
		}
		
		public void btnOpenRestoreScreen_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(1000, modGlobals.gCurrUserGuidID);
			if (RepoTableName.Equals("EmailAttachment"))
			{
				MessageBox.Show("Sorry, an attachment is an \'embedded\' component of an email." + "\r\n" + "Therefore, the entire email must be restored - not just the attachment.");
				return;
			}
			bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
			if (! bClcRuning)
			{
				SB.Text = "Downloader Not running - preview and restore are disabled.";
				//lblClcState.Visibility = Windows.Visibility.Visible
				lblClcState.Content = "Downloader Not running";
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
				return;
			}
			else
			{
				lblClcState.Visibility = System.Windows.Visibility.Collapsed;
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
			
			SB.Text = (string) ("Download Requested: " + DateTime.Now.ToString());
			//Dim ISO As New clsIsolatedStorage
			frmContentRestore NextPage = new frmContentRestore(RepoTableName, dgEmails, dgAttachments, dgContent);
			NextPage.Show();
			
		}
		public void ckClcActive()
		{
			bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
			if (! bClcRuning)
			{
				SB.Text = "Downloader Not running - preview and restore are disabled.";
				//lblClcState.Visibility = Windows.Visibility.Visible
				lblClcState.Content = "Downloader Not running";
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
			}
			else
			{
				lblClcState.Visibility = System.Windows.Visibility.Collapsed;
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
		}
		public void GetAttachmentWeights()
		{
			
			gettingGetAttachmentWeights = true;
			//'Dim proxy As New SVCSearch.Service1Client
			//AddHandler ProxySearch.getAttachmentWeightsCompleted, AddressOf client_getAttachmentWeights
			GLOBALS.ProxySearch.getAttachmentWeightsAsync(SecureID, AttachmentWeights, CurrUserGuidID);
			
			gettingGetAttachmentWeights = false;
			
		}
		
		public void client_getAttachmentWeights(object sender, SVCSearch.getAttachmentWeightsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				ApplyAttachmentWeights();
				FormLoaded = true;
			}
			else
			{
				AttachmentWeights = null;
			}
		}
		
		public void ApplyAttachmentWeights()
		{
			
			if (AttachmentWeights == null)
			{
				return;
			}
			
			int iCnt = 0;
			iCnt = dgEmails.Items.Count;
			
			if (iCnt == 0)
			{
				bWaitToApplyAttachmentWeight = true;
				return;
			}
			
			int IX = dgEmails.Columns["emailguid"].DisplayIndex;
			int iRank = System.Convert.ToInt32(dgEmails.Columns("Rank").DisplayIndex);
			
			for (int i = 0; i <= iCnt - 1; i++)
			{
				string emailguid = dgEmails.Items(i).cells(IX).ToString();
				if (AttachmentWeights.Keys.Contains(emailguid))
				{
					try
					{
						int iKey = System.Convert.ToInt32(AttachmentWeights[emailguid]);
						int II = AttachmentWeights.Values(iKey);
						
						int KK = System.Convert.ToInt32(dgEmails.Items(i).cells(iRank));
						if (II > KK)
						{
							dgEmails.Items(i).cells(iRank) = II;
						}
					}
					catch (Exception ex)
					{
						LOG.WriteToSqlLog((string) ("INFO ApplyAttachmentWeights 001-1: " + ex.Message + "\r\n" + " I = " + i.ToString() + " of " + dgEmails.Items.Count.ToString()));
					}
					
				}
			}
			
		}
		
		public int GetAttachmentCount()
		{
			int iCnt = 0;
			try
			{
				int iCol = dgEmails.Columns["FoundInAttachment"].DisplayIndex;
				for (int i = 0; i <= dgEmails.Items.Count - 1; i++)
				{
					string CH = dgEmails.Items[i].Cells(iCol).ToString();
					if (CH.Equals("Y"))
					{
						iCnt++;
					}
				}
			}
			catch (Exception)
			{
				iCnt = 0;
			}
			
			return iCnt;
		}
		
		public void ExecuteSearch(bool bGenSqlOnly, string CallLocation)
		{
			
			dgAttachments.Visibility = System.Windows.Visibility.Collapsed;
			
			ButtonBounce++;
			Console.WriteLine("ButtonBounce 01 = " + ButtonBounce.ToString());
			
			if (ExecutingSearch)
			{
				return;
			}
			
			ExecutingSearch = true;
			if (ckLimitToLib.IsChecked)
			{
				if (cbLibrary.SelectedItem == null)
				{
					MessageBox.Show("You have selected to limit the search to one library and failed to pick which one, returning.");
					return;
				}
			}
			
			Cursor = Cursors.Wait;
			
			qStartTime = DateTime.Now;
			
			btnSubmit.IsEnabled = false;
			
			if (nbrWeightMin.Text.Trim().Length == 0)
			{
				nbrWeightMin.Text = "0";
			}
			
			int iWeightMin = int.Parse(nbrWeightMin.Text);
			int LowerPageNumber = 0;
			int UpperPageNumber = PageRowLimit;
			string AutoSql = "";
			
			string SearchText = txtSearch.Text.Trim();
			
			bool bNeedRowCount = false;
			if (bStartNewSearch)
			{
				UdpateSearchTerm("ALL", "isSuperAdmin", GLOBALS._isSuperAdmin.ToString(), "B");
				UdpateSearchTerm("ALL", "isAdmin", GLOBALS._isAdmin.ToString(), "B");
				UdpateSearchTerm("ALL", "isGlobalSearcher", GLOBALS._isGlobalSearcher.ToString(), "B");
				
				UdpateSearchTerm("ALL", "CalledFromScreen", this.Title, "S");
				UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S");
				
				UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim(), "S");
				UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim(), "S");
				UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim(), "S");
				
				UdpateSearchTerm("ALL", "txtSearch", SearchText.Trim(), "S");
				UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString(), "B");
				UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString(), "B");
				UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString(), "B");
				UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString(), "B");
				UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString(), "B");
				UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString(), "B");
				UdpateSearchTerm("ALL", "cbLibrary", (string) cbLibrary.SelectedItem, "S");
				UdpateSearchTerm("ALL", "MinWeight", iWeightMin.ToString(), "I");
				UdpateSearchTerm("ALL", "LowerPageNbr", LowerPageNumber.ToString(), "I");
				UdpateSearchTerm("ALL", "UpperPageNbr", UpperPageNumber.ToString(), "I");
				UdpateSearchTerm("ALL", "GeneratedSql", AutoSql, "S");
				UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString(), "I");
				UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString(), "I");
				UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I");
				UdpateSearchTerm("ALL", "EndingEmailRow", UpperPageNumber.ToString(), "I");
				UdpateSearchTerm("ALL", "StartingContentRow", "0", "I");
				UdpateSearchTerm("ALL", "EndingContentRow", UpperPageNumber.ToString(), "I");
				
				UpdateState(true, 0, PageRowLimit, 0, PageRowLimit);
				
			}
			else
			{
				
				UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim(), "S");
				UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim(), "S");
				UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim(), "S");
				
				UdpateSearchTerm("ALL", "isSuperAdmin", GLOBALS._isSuperAdmin.ToString(), "B");
				UdpateSearchTerm("ALL", "isAdmin", GLOBALS._isAdmin.ToString(), "B");
				UdpateSearchTerm("ALL", "isGlobalSearcher", GLOBALS._isGlobalSearcher.ToString(), "B");
				
				UdpateSearchTerm("ALL", "txtSearch", SearchText.Trim(), "S");
				UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString(), "B");
				
				LowerPageNumber += PageRowLimit;
				UpperPageNumber += PageRowLimit;
				UdpateSearchTerm("ALL", "LowerPageNbr", LowerPageNumber.ToString(), "I");
				UdpateSearchTerm("ALL", "UpperPageNbr", UpperPageNumber.ToString(), "I");
				
				if (bEmailScrolling)
				{
					UpdateState(true, dgEmails.Items.Count, dgEmails.Items.Count + PageRowLimit, dgContent.Items.Count, dgContent.Items.Count);
					UdpateSearchTerm("ALL", "rbAll", "False", "B");
					UdpateSearchTerm("ALL", "rbEmails", "True", "B");
					UdpateSearchTerm("ALL", "rbContent", "False", "B");
				}
				else if (bContentScrolling)
				{
					UpdateState(true, System.Convert.ToInt32(dgEmails.Items.Count), System.Convert.ToInt32(dgEmails.Items.Count), dgContent.Items.Count, dgContent.Items.Count + PageRowLimit);
					UdpateSearchTerm("ALL", "rbAll", "False", "B");
					UdpateSearchTerm("ALL", "rbEmails", "False", "B");
					UdpateSearchTerm("ALL", "rbContent", "True", "B");
				}
				else
				{
					UpdateState(true, dgEmails.Items.Count, dgEmails.Items.Count + PageRowLimit, dgContent.Items.Count, dgContent.Items.Count + PageRowLimit);
					UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString(), "B");
					UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString(), "B");
					UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString(), "B");
				}
				
				int iEmailStart = dgEmails.Items.Count;
				int iContentStart = dgContent.Items.Count;
				int iEmailEnd = iEmailStart + 50;
				int iContentEnd = iContentStart + 50;
				
				UdpateSearchTerm("ALL", "StartingEmailRow", iEmailStart.ToString(), "I");
				UdpateSearchTerm("ALL", "EndingEmailRow", UpperPageNumber.ToString(), "I");
				UdpateSearchTerm("ALL", "StartingContentRow", iContentStart.ToString(), "I");
				UdpateSearchTerm("ALL", "EndingContentRow", UpperPageNumber.ToString(), "I");
				
			}
			
			//bFirstEmailSearchSubmit = True
			//bFirstContentSearchSubmit = True
			
			string xSql = GeneratedSql;
			
			//dgContent.ItemsSource = Nothing
			//dgEmails.ItemsSource = Nothing
			
			int iMaxRows = 0;
			if (DocUpperPageNbr > EmailUpperPageNbr)
			{
				iMaxRows = DocUpperPageNbr;
			}
			else
			{
				iMaxRows = EmailUpperPageNbr;
			}
			if (iMaxRows == 0)
			{
				iMaxRows = PageRowLimit;
			}
			
			Console.WriteLine("Called From: " + CallLocation);
			GLOBALS.ProxySearch.ExecuteSearchCompleted += new System.EventHandler(client_ExecuteSearch);
			try
			{
				if (GLOBALS.ProxySearch == null)
				{
					//Dim proxy As New SVCSearch.Service1Client
				}
				if (ListOfSearchTerms == null)
				{
					ListOfSearchTerms = new System.Collections.Generic.List<SVCSearch.DS_SearchTerms>();
				}
				if (GLOBALS.gListOfEmailsTemp == null)
				{
					GLOBALS.gListOfEmailsTemp = new System.Collections.Generic.List<SVCSearch.DS_EMAIL>();
				}
				if (GLOBALS.gListOfContentTemp == null)
				{
					GLOBALS.gListOfContentTemp = new System.Collections.Generic.List<SVCSearch.DS_CONTENT>();
				}
				
				GLOBALS.ProxySearch.ExecuteSearchAsync(iMaxRows, SecureID, currSearchCnt,
				bGenSqlOnly,
				GeneratedSql,
				ListOfSearchTerms.ToArray,
				AutoSql,
				GLOBALS.gListOfEmailsTemp.ToArray,
				GLOBALS.gListOfContentTemp.ToArray,
				bFirstEmailSearchSubmit,
				bFirstContentSearchSubmit,
				EmailSearchCnt,
				ContentSearchCnt);
				
			}
			catch (Exception ex)
			{
				string errmsg = ex.Message;
				string stack = ex.StackTrace.ToString();
				Clipboard.Clear();
				Clipboard.SetText(errmsg + "\r\n" + "\r\n" + stack);
			}
			
			btnSubmit.IsEnabled = true;
			modGlobals.bIncludeLibraryFilesInSearch = false;
			GLOBALS.gListOfEmailsTemp = null;
			GLOBALS.gListOfContentTemp = null;
			
		}
		
		public void client_ExecuteSearch(object sender, SVCSearch.ExecuteSearchCompletedEventArgs e)
		{
			decimal LL = 0;
			int iEmails = 0;
			int iAttachments = 0;
			try
			{
				if (e.Error == null)
				{
					LL = 1;
					
					currSearchCnt = System.Convert.ToInt32(e.currSearchCnt);
					bFirstEmailSearchSubmit = System.Convert.ToBoolean(e.bFirstEmailSearchSubmit);
					LL = 2;
					bFirstContentSearchSubmit = System.Convert.ToBoolean(e.bFirstContentSearchSubmit);
					LL = 3;
					
					EmailSearchCnt = System.Convert.ToInt32(e.EmailRowCnt);
					LL = 4;
					ContentSearchCnt = System.Convert.ToInt32(e.ContentRowCnt);
					LL = 5;
					
					//dgEmails.ItemsSource = e.ListOEmailRows
					//dgContent.ItemsSource = e.ListOfContentRows
					//Return
					
					if (! GenSqlOnly)
					{
						LL = 6;
						PB.Maximum = EmailSearchCnt;
						PB.Value = 0;
						
						Console.WriteLine("ButtonBounce 03 = " + ButtonBounce.ToString());
						LL = 7;
						Dictionary<string, string> tDict = new Dictionary<string, string>();
						if (bStartNewSearch)
						{
							LL = 8;
							GLOBALS.gListOfContent.Clear();
							LL = 9;
							GLOBALS.gListOfEmails.Clear();
							LL = 10;
						}
						if (bFirstEmailSearchSubmit && EmailSearchCnt > 0)
						{
							LL = 11;
							if (e.ListOEmailRows == null)
							{
								LL = 11.1M;
								goto NoEmails;
								LL = 11.2M;
							}
							LL = 11.3M;
							for (int I = 0; I <= e.ListOEmailRows.Count - 1; I++)
							{
								LL = 12;
								PB.Value = I;
								tDict.Clear();
								SVCSearch.DS_EMAIL oEmail = new SVCSearch.DS_EMAIL();
								LL = 13;
								oEmail.AllRecipients = (string) (e.ListOEmailRows(I).AllRecipients);
								LL = 14;
								oEmail.Bcc = (string) (e.ListOEmailRows(I).Bcc);
								LL = 15;
								oEmail.Body = (string) (e.ListOEmailRows(I).Body);
								LL = 16;
								oEmail.CC = (string) (e.ListOEmailRows(I).CC);
								LL = 17;
								oEmail.CreationTime = e.ListOEmailRows(I).CreationTime;
								LL = 17;
								oEmail.EmailGuid = (string) (e.ListOEmailRows(I).EmailGuid);
								LL = 18;
								if (DictGuids.ContainsKey(oEmail.EmailGuid))
								{
									LL = 19;
									goto EmailExists;
									LL = 20;
								}
								else
								{
									LL = 21;
									DictGuids.Add(oEmail.EmailGuid, I);
									LL = 22;
								}
								LL = 23;
								oEmail.FoundInAttach = System.Convert.ToBoolean(e.ListOEmailRows(I).FoundInAttach);
								LL = 24;
								if (oEmail.FoundInAttach.Equals("True"))
								{
									LL = 24.1M;
									iAttachments++;
									LL = 24.2M;
								}
								else
								{
									LL = 24.3M;
									iEmails++;
									LL = 24.4M;
								}
								LL = 24.5M;
								oEmail.isPublic = (string) (e.ListOEmailRows(I).isPublic);
								LL = 25;
								oEmail.MsgSize = System.Convert.ToInt32(e.ListOEmailRows(I).MsgSize);
								LL = 26;
								oEmail.NbrAttachments = System.Convert.ToInt32(e.ListOEmailRows(I).NbrAttachments);
								LL = 27;
								oEmail.OriginalFolder = (string) (e.ListOEmailRows(I).OriginalFolder);
								LL = 28;
								oEmail.RANK = System.Convert.ToInt32(e.ListOEmailRows(I).RANK);
								LL = 29;
								oEmail.ReceivedByName = (string) (e.ListOEmailRows(I).ReceivedByName);
								LL = 30;
								oEmail.ReceivedTime = e.ListOEmailRows(I).ReceivedTime;
								LL = 31;
								oEmail.RepoSvrName = (string) (e.ListOEmailRows(I).RepoSvrName);
								LL = 32;
								oEmail.RetentionExpirationDate = e.ListOEmailRows(I).RetentionExpirationDate;
								LL = 33;
								oEmail.RID = (string) (e.ListOEmailRows(I).RID);
								LL = 34;
								oEmail.ROWID = (string) (e.ListOEmailRows(I).ROWID);
								LL = 35;
								oEmail.SenderEmailAddress = (string) (e.ListOEmailRows(I).SenderEmailAddress);
								LL = 36;
								oEmail.SenderName = (string) (e.ListOEmailRows(I).SenderName);
								LL = 37;
								oEmail.SentOn = e.ListOEmailRows(I).SentOn;
								LL = 38;
								oEmail.SentTO = (string) (e.ListOEmailRows(I).SentTO);
								LL = 39;
								oEmail.ShortSubj = (string) (e.ListOEmailRows(I).ShortSubj);
								LL = 40;
								oEmail.SourceTypeCode = (string) (e.ListOEmailRows(I).SourceTypeCode);
								LL = 41;
								oEmail.SUBJECT = (string) (e.ListOEmailRows(I).SUBJECT);
								LL = 42;
								oEmail.UserID = (string) (e.ListOEmailRows(I).UserID);
								LL = 43;
								GLOBALS.gListOfEmails.Add(oEmail);
								LL = 44;
								
								//tDict.Add("AllRecipients", e.ListOEmailRows(I).AllRecipients)
								//tDict.Add("Bcc", e.ListOEmailRows(I).Bcc)
								//tDict.Add("Body", e.ListOEmailRows(I).Body)
								//tDict.Add("CC", e.ListOEmailRows(I).CC)
								//tDict.Add("CreationTime", e.ListOEmailRows(I).CreationTime)
								//tDict.Add("EmailGuid", e.ListOEmailRows(I).EmailGuid)
								//tDict.Add("FoundInAttach", e.ListOEmailRows(I).FoundInAttach)
								//'If e.ListOEmailRows(I).FoundInAttach.Equals("True") Then
								//'    iAttachments += 1)
								//'Else
								//'    iEmails += 1
								//'End If
								//tDict.Add("isPublic", e.ListOEmailRows(I).isPublic)
								//tDict.Add("MsgSize", e.ListOEmailRows(I).MsgSize)
								//tDict.Add("NbrAttachments", e.ListOEmailRows(I).NbrAttachments)
								//tDict.Add("OriginalFolder", e.ListOEmailRows(I).OriginalFolder)
								//tDict.Add("RANK", e.ListOEmailRows(I).RANK)
								//tDict.Add("ReceivedByName", e.ListOEmailRows(I).ReceivedByName)
								//tDict.Add("ReceivedTime", e.ListOEmailRows(I).ReceivedTime)
								//tDict.Add("RepoSvrName", e.ListOEmailRows(I).RepoSvrName)
								//tDict.Add("RetentionExpirationDate", e.ListOEmailRows(I).RetentionExpirationDate)
								//tDict.Add("RID", e.ListOEmailRows(I).RID)
								//tDict.Add("ROWID", e.ListOEmailRows(I).ROWID)
								//tDict.Add("SenderEmailAddress", e.ListOEmailRows(I).SenderEmailAddress)
								//tDict.Add("SenderName", e.ListOEmailRows(I).SenderName)
								//tDict.Add("SentOn", e.ListOEmailRows(I).SentOn)
								//tDict.Add("SentTO", e.ListOEmailRows(I).SentTO)
								//tDict.Add("ShortSubj", e.ListOEmailRows(I).ShortSubj)
								//tDict.Add("SourceTypeCode", e.ListOEmailRows(I).SourceTypeCode)
								//tDict.Add("SUBJECT", e.ListOEmailRows(I).SUBJECT)
								//tDict.Add("UserID", e.ListOEmailRows(I).UserID)
								//addDataTableEmail(tDict)
EmailExists:
								LL = 45;
							}
							//dgEmails.ItemsSource = gListOfEmails
							LL = 46;
							try
							{
								//dgEmails.RowHeight = 15
								for (int ii = 0; ii <= dgEmails.Columns.Count - 1; ii++)
								{
									double iWidth = dgEmails.Columns[ii].Width.DisplayValue;
									if ((int) iWidth > 50)
									{
										dgEmails.Columns[ii].Width = 50;
									}
								}
								int iCol = -1;
								//Dim iCol As Integer = grid.getColumnIndexByName(dgEmails, "SUBJECT")
								//If iCol >= 0 Then dgEmails.Columns(iCol).Width = 50
								iCol = grid.getColumnIndexByName(dgEmails, "Body");
								if (iCol >= 0)
								{
									if (iCol >= 0)
									{
										dgEmails.Columns[iCol].Width = 50;
									}
									dgEmails.Columns(iCol).Visibility = System.Windows.Visibility.Hidden;
								}
								//iCol = grid.getColumnIndexByName(dgEmails, "AllRecipients")
								//If iCol >= 0 Then dgEmails.Columns(iCol).Width = 50
								iCol = grid.getColumnIndexByName(dgEmails, "ExtensionData");
								int index = System.Convert.ToInt32(dgEmails.Columns.Single(c => c.Header.ToString() == "ExtensionData").DisplayIndex);
								if (iCol >= 0)
								{
									int LastColIdx = System.Convert.ToInt32(dgEmails.Columns.Count - 2);
									dgEmails.Columns(iCol).DisplayIndex = LastColIdx;
									iCol = grid.getColumnIndexByName(dgEmails, "ExtensionData");
									dgEmails.Columns[iCol].Visibility = System.Windows.Visibility.Hidden;
								}
							}
							catch (Exception ex)
							{
								Console.WriteLine(ex.Message);
							}
							
						}
						
NoEmails:
						PB.Value = 0;
						LL = 47;
						if (e.ListOfContentRows == null)
						{
							goto NoContent;
						}
						if (bFirstContentSearchSubmit && ContentSearchCnt > 0)
						{
							LL = 48;
							PB.Value = 0;
							PB.Maximum = ContentSearchCnt;
							for (int I = 0; I <= e.ListOfContentRows.Count - 1; I++)
							{
								LL = 49;
								PB.Value = I;
								SVCSearch.DS_CONTENT oContent = new SVCSearch.DS_CONTENT();
								LL = 50;
								oContent.CreateDate = e.ListOfContentRows(I).CreateDate;
								LL = 51;
								oContent.DataSourceOwnerUserID = (string) (e.ListOfContentRows(I).DataSourceOwnerUserID);
								LL = 52;
								oContent.FileDirectory = (string) (e.ListOfContentRows(I).FileDirectory);
								LL = 53;
								oContent.FileLength = System.Convert.ToInt32(e.ListOfContentRows(I).FileLength);
								LL = 54;
								oContent.FQN = (string) (e.ListOfContentRows(I).FQN);
								LL = 55;
								oContent.isMaster = (string) (e.ListOfContentRows(I).isMaster);
								LL = 56;
								oContent.isPublic = (string) (e.ListOfContentRows(I).isPublic);
								LL = 57;
								oContent.LastAccessDate = e.ListOfContentRows(I).LastAccessDate;
								LL = 58;
								oContent.LastWriteTime = e.ListOfContentRows(I).LastWriteTime;
								LL = 59;
								oContent.OriginalFileType = (string) (e.ListOfContentRows(I).OriginalFileType);
								LL = 60;
								oContent.RANK = System.Convert.ToInt32(e.ListOfContentRows(I).RANK);
								LL = 61;
								oContent.RepoSvrName = (string) (e.ListOfContentRows(I).RepoSvrName);
								LL = 62;
								oContent.RetentionExpirationDate = e.ListOfContentRows(I).RetentionExpirationDate;
								LL = 63;
								oContent.ROWID = (string) (e.ListOfContentRows(I).ROWID);
								LL = 64;
								oContent.SourceGuid = (string) (e.ListOfContentRows(I).SourceGuid);
								LL = 65;
								if (DictGuids.ContainsKey(oContent.SourceGuid))
								{
									LL = 66;
									goto DocExists;
									LL = 67;
								}
								else
								{
									LL = 68;
									DictGuids.Add(oContent.SourceGuid, I);
									LL = 69;
								}
								LL = 70;
								
								oContent.SourceName = (string) (e.ListOfContentRows(I).SourceName);
								LL = 71;
								oContent.StructuredData = System.Convert.ToBoolean(e.ListOfContentRows(I).StructuredData);
								LL = 72;
								oContent.VersionNbr = System.Convert.ToInt32(e.ListOfContentRows(I).VersionNbr);
								LL = 73;
								
								oContent.Description = (string) (e.ListOfContentRows(I).Description);
								oContent.RssLinkFlg = System.Convert.ToBoolean(e.ListOfContentRows(I).RssLinkFlg);
								oContent.isWebPage = (string) (e.ListOfContentRows(I).isWebPage);
								
								GLOBALS.gListOfContent.Add(oContent);
								LL = 74;
DocExists:
								
								LL = 75;
							}
							LL = 76;
							dgContent.RowHeight = 15;
							//dgContent.ItemsSource = gListOfContent
						}
						LL = 77;
NoContent:
						PB.Value = 0;
						LL = 78;
						TotalEmailRows = System.Convert.ToInt32(dgEmails.Items.Count);
						LL = 79;
						TotalDocRows = dgContent.Items.Count;
						LL = 80;
						
						ContentTriggerRow = dgContent.Items.Count - 50;
						LL = 81;
						EmailTriggerRow = System.Convert.ToInt32(dgEmails.Items.Count - 50);
						LL = 82;
						
						if (ContentTriggerRow < 0)
						{
							LL = 83;
							ContentTriggerRow = 1000;
							LL = 84;
						}
						LL = 85;
						if (ContentTriggerRow < 50)
						{
							LL = 86;
							ContentTriggerRow = 50;
							LL = 87;
						}
						LL = 88;
						
						if (EmailTriggerRow < 0)
						{
							LL = 88;
							EmailTriggerRow = 1000;
							LL = 89;
						}
						LL = 90;
						if (EmailTriggerRow < 50)
						{
							LL = 91;
							EmailTriggerRow = 50;
							LL = 92;
						}
						LL = 92;
						
					}
					LL = 93;
					
					if (GenSqlOnly)
					{
						LL = 94;
						string EmailSQL = (string) e.EmailGenSql;
						LL = 95;
						string ContentSQL = (string) e.ContentGenSql;
						LL = 96;
						SB.Text = "SQL in clipboard.";
						LL = 97;
						AutoGenSql = EmailSQL + "\r\n" + "/*************************************************/" + "\r\n" + ContentSQL;
						LL = 97;
					}
					LL = 98;
					
				}
				else
				{
					LL = 99;
					TotalEmailRows = -1;
					LL = 100;
					SB.Text = (string) (e.Error.Message.ToString());
					LL = 101;
					MessageBox.Show((string) ("ERROR: Failed search - " + "\r\n" + e.Error.Message));
					LL = 102;
				}
				LL = 103;
				qEndTime = DateTime.Now;
				LL = 104;
				
				UpdateState(true, 1, dgEmails.Items.Count, 1, dgContent.Items.Count);
				LL = 105;
				
				btnSubmit.Visibility = Visibility.Visible;
				LL = 106;
				dgEmails.Opacity = 1;
				LL = 107;
				dgContent.Opacity = 1;
				LL = 108;
				PB.IsIndeterminate = false;
				LL = 109;
				PB.Visibility = Visibility.Collapsed;
				LL = 110;
				
				if (GenSqlOnly)
				{
					LL = 111;
					popSqlStmt CW = new popSqlStmt(AutoGenSql);
					CW.Show();
				}
				LL = 114;
				
				GenSqlOnly = false;
				LL = 115;
				
				//Dim iEmails As Integer = 0 : LL = 118
				//Dim iAttachments As Integer = 0 : LL = 119
				
				//For II As Integer = 0 To dgEmails.Items.Count - 1 : LL = 120
				//    Dim DR As Object = dgEmails.Items(II)
				//    Dim b As String = DR.FoundInAttach.ToString
				//    If b.Equals("True") Then : LL = 121
				//        iAttachments += 1 : LL = 122
				//    Else : LL = 123
				//        iEmails += 1 : LL = 124
				//    End If : LL = 125
				//Next : LL = 126
				
				TS = qEndTime.Subtract(qStartTime);
				int Secs = TS.Seconds;
				
				string emailText = string.Format("Emails {0} to {1} ", 1, iEmails);
				LL = 127;
				string attachText = string.Format("Attachments {0} to {1} of {2} emails.", 1, iAttachments, EmailSearchCnt);
				LL = 128;
				
				SBEmail.Text = emailText + " / " + attachText + " / Secs: " + Secs.ToString();
				//SBEmail.Text = String.Format("Displaying rows {0} to {1}...", 1, TotalEmailRows)
				SBDoc.Text = (string) (string.Format("Displaying rows {0} to {1} of {2} documents.", 1, TotalDocRows, ContentSearchCnt) + " / Secs: " + Secs.ToString());
				//SBDoc.Text = SBDoc.Text + " / Secs: " + Secs.ToString
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR: client_ExecuteSearch 101 - LL = " + LL.ToString() + ex.Message + "\r\n" + ex.StackTrace));
				LOG.WriteToSqlLog((string) ("ERROR: client_ExecuteSearch 101 - LL = " + LL.ToString() + ex.Message + "\r\n" + ex.StackTrace));
			}
			
			if (GLOBALS.gListOfContent.Count > 0)
			{
				if (PrevListOfContentCnt != GLOBALS.gListOfContent.Count)
				{
					//dgContent.ItemsSource = gListOfContent
					dgContent.Items.Refresh();
				}
				PrevListOfContentCnt = System.Convert.ToInt32(GLOBALS.gListOfContent.Count);
			}
			else
			{
				PrevListOfContentCnt = 0;
			}
			if (GLOBALS.gListOfEmails.Count > 0)
			{
				if (PrevListOfEmailCnt != GLOBALS.gListOfEmails.Count)
				{
					//dgEmails.ItemsSource = gListOfEmails
					dgEmails.Items.Refresh();
					//SB.Text = "EMAILS: " + gListOfEmails.Count.ToString + " / Content: " + gListOfContent.Count.ToString
				}
				PrevListOfEmailCnt = System.Convert.ToInt32(GLOBALS.gListOfEmails.Count);
			}
			else
			{
				PrevListOfEmailCnt = 0;
			}
			
			bStartNewSearch = false;
			PB.IsIndeterminate = false;
			ExecutingSearch = false;
			Cursor = Cursors.Arrow;
			bGhostFetchActive = false;
			
			//setEmailGRidRowHeight()
			
			GLOBALS.ProxySearch.ExecuteSearchCompleted -= new System.EventHandler(client_ExecuteSearch);
			
		}
		public void setEmailGRidRowHeight()
		{
			if (bEmailRowHeightSet == true)
			{
				//Return
			}
			bSettingEmailRowHeight = true;
			for (int i = 0; i <= dgEmails.Items.Count - 1; i++)
			{
				DataGridRow DR = grid.GetRow(dgEmails, i);
				DR.Height = 25;
			}
			grid.SelectRowByIndex(dgEmails, TopRow);
			bSettingEmailRowHeight = false;
			bEmailRowHeightSet = true;
		}
		//Sub SearchEmails(ByVal Calledfrom As String, ByVal SearchString As String, ByVal ZeroizeGrid As Boolean, ByVal bIncludeAllLibs As Boolean, ByVal IncludeWeights As Boolean, ByVal IsUserAdmin As Boolean, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String)
		//    Dim BB As Boolean = False
		//    Dim AutoGeneratedSQL As String = ""
		//    Dim StartTime As Date = Now
		
		//    SQLGEN.pTxtSearch = SearchString.Trim
		//    SQLGEN.pCkBusiness = False 'Me.ckBusiness.isChecked
		//    SQLGEN.pGetCountOnly = False     '**Me.ckCountOnly.isChecked
		//    SQLGEN.pUseExistingRecordsOnly = False 'Me.ckLimitToExisting.isChecked
		//    SQLGEN.pCkWeighted = IncludeWeights
		//    SQLGEN.pGeneratedSQL = AutoGeneratedSQL
		//    SQLGEN.pIsAdmin = IsUserAdmin
		//    SQLGEN.pCkBusiness = False 'ckBusiness.isChecked
		
		//    Dim MinWeight As Integer = Val(nbrWeightMin.Text)
		//    Dim bCkLimitToExisting As Boolean = False
		//    Dim bCkBusiness As Boolean = False
		//    Dim GeneratedSQL As String = ""
		
		//    '********************************************************************************************************************************************************************************************************
		//    ZeroizeGrid = False
		//    If ZeroizeGrid = False Then
		//        AutoGeneratedSQL = SQLGEN.GenEmailGeneratedSQL(bCkLimitToExisting, "", "", IncludeWeights, bCkBusiness, SearchString, ckLimitToLib, LibraryName, MinWeight, bIncludeAllLibs, False, False, GeneratedSQL)
		//        xEmailQry = AutoGeneratedSQL
		//    Else
		//        AutoGeneratedSQL = "Select * from DataSource where 1 = 2"
		//    End If
		
		//    '*******************************************************************************************************************************************************************************************************
		
		//    If bIncludeLibraryFilesInSearch = True Then
		//        Dim a$()
		//        a = AutoGeneratedSQL.Split(vbCrLf)
		//        AutoGeneratedSQL = ""
		//        For ii As Integer = 0 To UBound(a)
		//            If a(ii).Trim.Length = 0 Then
		//            Else
		//                AutoGeneratedSQL += a(ii).Trim + vbCrLf
		//            End If
		//        Next
		//    End If
		
		//    'PopulateEmailGrid(AutoGeneratedSQL)
		//    Dim SSX$ = AutoGeneratedSQL
		//    AutoGeneratedSQL = SSX
		//    If gPaginateData = True Then
		//        If bNeedRowCount = True Then
		
		//            'TotalEmailRows = DB.iCountContent(AutoGeneratedSQL)
		//            'Dim proxy As New SVCSearch.Service1Client
		//            AddHandler ProxySearch.iCountContentCompleted, AddressOf client_iCountContent
		//            ProxySearch.iCountContentAsync(AutoGeneratedSQL)
		
		//        End If
		
		//        Dim SQLCls As New clsSql
		//        SQLCls.AddPaging(EmailLowerPageNbr, EmailUpperPageNbr, AutoGeneratedSQL, bIncludeLibraryFilesInSearch)
		//        SQLCls = Nothing
		
		//        '** Now at this point today, there is a rogue ORDER BY clause in the email paging query.
		//        '** Of course, it has to be removed or in this case, commented out
		//        '** I do not want to troubleshoot the generator, I will just do it in a simplistic manner.
		//        AutoGeneratedSQL = AutoGeneratedSQL.Replace("order by [ShortSubj]", "/*order by [ShortSubj]*/")
		//        Console.WriteLine("Replaced Order by here")
		//    End If
		
		//    UTIL.ckSqlQryForDoubleKeyWords(AutoGeneratedSQL)
		
		//    If gHiveEnabled = True Then
		//        If gHiveServersList.Count > 0 Then
		//            UTIL.AddHiveSearch(AutoGeneratedSQL, gHiveServersList)
		//        End If
		//    End If
		
		//    If GenSqlOnly = True Then
		//        CB_SQL$ = CB_SQL$ + AutoGeneratedSQL + vbCrLf + "/****** END OF EMAIL QUERY ******/"
		//        AutoGeneratedSQL += vbCrLf + "/****** END OF EMAIL QUERY ******/"
		//        Clipboard.SetText(AutoGeneratedSQL)
		//        Return
		//    End If
		
		//    '***************************************************
		//    Dim SS As String = AutoGeneratedSQL.Replace(",", "," + vbCrLf)
		//    'Dim SS As String = ""
		//    'Dim AA() As String = AutoGeneratedSQL.Split(",")
		//    'For II As Integer = 0 To UBound(AA) - 1
		//    '    If AA(II).Trim.Length > 0 Then
		//    '        SS += AA(II) + "," + vbCrLf
		//    '    End If
		
		//    'Next
		//    '***************************************************
		//    'AutoGeneratedSQL = SS
		//    Clipboard.SetText(SS)
		
		//    If IncludeWeights Then
		//        BB = PopulateEmailGridWeights(AutoGeneratedSQL)
		//    Else
		//        BB = PopulateEmailGridNoWeights(AutoGeneratedSQL)
		//    End If
		
		//End Sub
		
		public void client_iCountContent(object sender, SVCSearch.iCountContentCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				TotalEmailRows = System.Convert.ToInt32(e.Result);
				TotalEmailPages = System.Convert.ToInt32(Math.Floor(TotalEmailRows / PageRowLimit) + 1);
			}
			else
			{
				TotalEmailRows = -1;
			}
		}
		
		public void client_getDatasourceParmAuthor(object sender, SVCSearch.getDatasourceParmCompletedEventArgs e)
		{
			Author = "";
			if (e.Error == null)
			{
				string Author = (string) e.Result;
				if (Author.Trim().Length == 0)
				{
					Author = CurrLoginID;
				}
			}
			else
			{
				Author = "Unknown";
			}
			
			//Dim proxy2 As New SVCSearch.Service1Client
			//AddHandler proxy2.getDatasourceParmCompleted, AddressOf client_getDatasourceParmTitle
			proxy2.getDatasourceParmAsync(SecureID, "Title", getDatasourceParmSourceGuid);
			
			gettingAuthor = false;
		}
		public void client_getDatasourceParmTitle(object sender, SVCSearch.getDatasourceParmCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				string Title = (string) e.Result;
				if (Title.Length == 0)
				{
					Title = "None Supplied";
				}
			}
			else
			{
				Title = "None Supplied";
			}
			
			GS.setContentauthor(ref strAuthor);
			GS.setContentext(ref getDatasourceParmSourceTypeCode);
			GS.setContentguid(ref getDatasourceParmSourceGuid);
			GS.setContenttitle(Title);
			GS.setContenttype("Content");
			GS.setCreatedate(ref getDatasourceParmSourceCreateDate);
			GS.setUserid(ref CurrUserGuidID);
			//GS.setUserid(DataSourceOwnerUserID as string)
			GS.setAllrecipiants(ref getDatasourceParmSourceAllrecipiants);
			GS.setFilename(ref getDatasourceParmSourceFQN);
			GS.setFilesize(ref getDatasourceParmSourceFileLength);
			GS.setFromemailaddress("");
			GS.setNbrofattachments("0");
			GS.setWeight(ref getDatasourceParmSourceWeight);
			
			bool b = GS.Add();
			if (! b)
			{
				LOG.WriteToSqlLog("frmQuickSearch:LoadDocSearchResultsV2 - Failed to save search results for Content ID \'" + getDatasourceParmSourceGuid + "\'");
			}
			
			gettingTitle = false;
		}
		
		//'** Use the new storage type found in silverlight here clsIsolatedStorage
		public void SortGrid(string GridToSort)
		{
			
			bool bEnable = false;
			
			if (! bEnable)
			{
				return;
			}
			
			string SortCol = "";
			string SortType = "";
			bool RC = false;
			if (GridToSort.ToUpper().Equals("BOTH"))
			{
				//Dim ISO As New clsIsolatedStorage
				try
				{
					ISO.getGridSortCol(this.Title, "dgEmail", ref SortCol, ref SortType, CurrUserGuidID, ref RC);
					SortEmailGrid(SortCol, SortType);
					ISO.getGridSortCol(this.Title, "dgContent", ref SortCol, ref SortType, CurrUserGuidID, ref RC);
					SortContentGrid(SortCol, SortType);
				}
				catch (Exception ex)
				{
					LOG.WriteToSqlLog((string) ("ERROR: frmQuickSearch:SortGrid 100 - " + ex.Message));
				}
				finally
				{
					//'ISO = Nothing
				}
			}
			else if (GridToSort.ToUpper().Equals("EMAIL"))
			{
				//Dim ISO As New clsIsolatedStorage
				try
				{
					ISO.getGridSortCol(this.Title, "dgEmail", ref SortCol, ref SortType, CurrUserGuidID, ref RC);
					SortEmailGrid(SortCol, SortType);
				}
				catch (Exception ex)
				{
					LOG.WriteToSqlLog((string) ("ERROR: frmQuickSearch:SortGrid 100 - " + ex.Message));
				}
				finally
				{
					//'ISO = Nothing
				}
			}
			else
			{
				//Dim ISO As New clsIsolatedStorage
				try
				{
					ISO.getGridSortCol(this.Title, "dgContent", ref SortCol, ref SortType, CurrUserGuidID, ref RC);
					SortContentGrid(SortCol, SortType);
				}
				catch (Exception ex)
				{
					LOG.WriteToSqlLog((string) ("ERROR: frmQuickSearch:SortGrid 200 - " + ex.Message));
				}
				finally
				{
					//'ISO = Nothing
				}
			}
			
		}
		
		public void saveGridSortCol()
		{
			
			if (CurrentlySelectedGrid.Equals("EMAIL"))
			{
				//Dim ISO As New clsIsolatedStorage
				try
				{
					int iRow = dgEmails.SelectedIndex;
					//Dim iCol As Integer = dgEmails.Columns.Selected(0).Index
					int iCol = System.Convert.ToInt32(dgEmails.SelectedCells(0).Column.DisplayIndex);
					bool AscendingOrder = true;
					var ColName = dgEmails.Columns(iCol).Header;
					var msg = "Do you want to sort column " + ColName + " in ascending order?";
					MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
					
					if (result == MessageBoxResult.OK)
					{
						SB.Text = "Save cancelled.";
						AscendingOrder = true;
					}
					else
					{
						AscendingOrder = false;
					}
					ISO.saveGridSortCol(this.Title, "dgEmail", ColName.ToString(), AscendingOrder.ToString(), CurrUserGuidID);
					
				}
				catch (Exception ex)
				{
					LOG.WriteToSqlLog((string) ("ERROR saveGridSortCol 100.1: Search Save Sort Col: " + ex.Message));
					SB.Text = "Failed to save sort column";
				}
				finally
				{
					//'ISO = Nothing
				}
			}
			else
			{
				//Dim ISO As New clsIsolatedStorage
				try
				{
					int iRow = dgContent.SelectedIndex;
					//Dim iCol As Integer = dgContent.Columns.Selected(0).Index
					int iCol = dgContent.SelectedCells[0].Column.DisplayIndex;
					bool AscendingOrder = true;
					string ColName = (string) (dgContent.Columns[iCol].Header);
					var msg = "Do you want to sort column " + ColName + " in ascending order?";
					MessageBoxResult result = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel);
					
					if (result == MessageBoxResult.OK)
					{
						SB.Text = "Save cancelled.";
						AscendingOrder = true;
					}
					else
					{
						AscendingOrder = false;
					}
					ISO.saveGridSortCol(this.Title, "dgContent", ColName, AscendingOrder.ToString(), CurrUserGuidID);
				}
				catch (Exception ex)
				{
					LOG.WriteToSqlLog((string) ("ERROR saveGridSortCol 100.2: Search Save Sort Col: " + ex.Message));
					SB.Text = "Failed to save sort column";
				}
				finally
				{
					//'ISO = Nothing
				}
			}
			
			GC.Collect();
			
		}
		
		public void saveGridColumnOrder()
		{
			string ValName = "";
			string ValValue = "";
			int IndexKey = 0;
			string ScreenName = this.Title;
			string SaveTypeCode = "GridColOrder";
			
			if (CurrentlySelectedGrid.Equals("EMAIL"))
			{
				GM.SaveGridState(CurrUserGuidID, this.Title, dgEmails, dictEmailGridColDisplayOrder);
			}
			else
			{
				GM.SaveGridState(CurrUserGuidID, this.Title, dgContent, dictContentGridColDisplayOrder);
			}
			
			GC.Collect();
			bGridColsRetrieved = false;
		}
		
		public void getSavedEmailGridColumnsDisplayOrder()
		{
			GM.getGridState(this.Title, dgEmails.Name, CurrUserGuidID, ref dictEmailGridColDisplayOrder);
			
			if (dictEmailGridColDisplayOrder.Count == 0)
			{
				GetEmailGridLayout(dictGridParmsEmail, dgEmails);
			}
			
			ReorderEmailGridCols();
		}
		
		public void getSavedContentGridColumnsDisplayOrder()
		{
			GM.getGridState(this.Title, dgContent.Name, CurrUserGuidID, ref dictContentGridColDisplayOrder);
			
			if (dictContentGridColDisplayOrder.Count == 0)
			{
				GetContentGridLayout(dictGridParmsContent, dgContent);
			}
			
			ReorderContentGridCols();
		}
		
		//*********************************************************************************
		
		public void client_LoadUserSearchHistory(object sender, SVCSearch.LoadUserSearchHistoryCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				SearchHistoryArrayList = e.SearchHistoryArrayList;
				DoNotGetSearchHistory = false;
				FormLoaded = true;
			}
			else
			{
				SearchHistoryArrayList = null;
			}
		}
		
		//*********************************************************************************
		
		public void ZeroizeGlobalSearch()
		{
			//'Dim proxy As New SVCSearch.Service1Client
			GLOBALS.ProxySearch.ZeroizeGlobalSearchCompleted += new System.EventHandler(client_ZeroizeGlobalSearch);
			GLOBALS.ProxySearch.ZeroizeGlobalSearchAsync(SecureID);
			
		}
		public void client_ZeroizeGlobalSearch(object sender, SVCSearch.ZeroizeGlobalSearchCompletedEventArgs e)
		{
			if (e.Error != null)
			{
				SB.Text = "NOTICE: Failed to zeroize global search parms.";
				LOG.WriteToSqlLog((string) ("ERROR client_ZeroizeGlobalSearch: " + e.Error.Message));
			}
			else
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					SB.Text = "NOTICE 001: Failed to zeroize global search parms.";
				}
			}
			GLOBALS.ProxySearch.ZeroizeGlobalSearchCompleted -= new System.EventHandler(client_ZeroizeGlobalSearch);
		}
		//*********************************************************************************
		
		public void SaveSearchParmParms(int IndexKey)
		{
			
			if (bSaveSearchesToDB)
			{
				SaveSearchHistory();
			}
			
			dictScreenControls.Clear();
			
			//Dim ISO As New clsIsolatedStorage
			
			var ScreenName = "frmQuickSearch";
			var SaveTypeCode = "QUICKSEARCH";
			string UID = CurrUserGuidID;
			string ValName = "";
			string ValValue = "";
			bool B = true;
			
			string txtSelDir = "??";
			bool ckShowDetails = false;
			bool ckCountOnly = false;
			bool ckLimitToExisting = false;
			bool ckBusiness = false;
			bool rbToDefaultDir = false;
			bool rbToOriginalDir = false;
			bool rbToSelDir = false;
			bool ckOverWrite = false;
			
			ISO.ZeroizeSaveFormData(IndexKey, ScreenName, SaveTypeCode, UID, ValName, ValValue);
			
			SaveTypeCode = "QUICKSEARCH";
			
			ValName = "txtSearch";
			ValValue = txtSearch.Text.Trim();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "txtSelDir";
			//ValValue = txtSelDir
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "cbLibrary";
			ValValue = (string) cbLibrary.SelectedItem;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "nbrWeightMin";
			ValValue = nbrWeightMin.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "rbAll";
			ValValue = rbAll.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "rbContent";
			ValValue = rbContent.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "rbEmails";
			ValValue = rbEmails.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckShowDetails"
			//ValValue = ckShowDetails.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "ckLimitToLib";
			ValValue = ckLimitToLib.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckCountOnly"
			//ValValue = ckCountOnly.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "ckMyContent";
			ValValue = ckMyContent.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "ckMasterOnly";
			ValValue = ckMasterOnly.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckLimitToExisting"
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "ckWeights";
			ValValue = ckWeights.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckBusiness"
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "rbToDefaultDir"
			//ValValue = rbToDefaultDir.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "rbToOriginalDir"
			//ValValue = rbToOriginalDir.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "rbToSelDir"
			//ValValue = rbToSelDir.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "ckOverWrite"
			//ValValue = ckOverWrite.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValValue = (string) lblMain.Content;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "ckFilters";
			ValValue = ckFilters.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "SBEmail";
			ValValue = SBEmail.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "SBDoc";
			ValValue = SBDoc.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "SB";
			ValValue = SB.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//'ISO = Nothing
			
		}
		
		public void PopulateMasterSearchDict()
		{
			
			string AutoSql = "";
			string ValName = "";
			string ValValue = "";
			int LowerPageNumber = 0;
			int UpperPageNumber = PageRowLimit;
			
			GLOBALS.dictMasterSearch.Clear();
			
			ValName = "DocLowerPageNbr";
			ValValue = DocLowerPageNbr.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "DocUpperPageNbr";
			ValValue = DocUpperPageNbr.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "EmailLowerPageNbr";
			ValValue = EmailLowerPageNbr.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "EmailUpperPageNbr";
			ValValue = EmailUpperPageNbr.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "txtSearch";
			ValValue = txtSearch.Text.Trim();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "txtSelDir";
			//ValValue = txtSelDir
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "cbLibrary";
			ValValue = (string) cbLibrary.SelectedItem;
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "nbrWeightMin";
			ValValue = nbrWeightMin.Text;
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "rbAll";
			ValValue = rbAll.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "rbContent";
			ValValue = rbContent.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "rbEmails";
			ValValue = rbEmails.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "ckLimitToLib";
			ValValue = ckLimitToLib.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "ckMyContent";
			ValValue = ckMyContent.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "ckMasterOnly";
			ValValue = ckMasterOnly.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "ckWeights";
			ValValue = ckWeights.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "lblMain";
			ValValue = modGlobals.gNbrSearches.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "ckFilters";
			ValValue = ckFilters.IsChecked.ToString();
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "SBEmail";
			ValValue = SBEmail.Text;
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "SBDoc";
			ValValue = SBDoc.Text;
			AddMasterSearchItem(ValName, ValValue);
			
			ValName = "SB";
			ValValue = SB.Text;
			AddMasterSearchItem(ValName, ValValue);
			
			AddMasterSearchItem("CalledFromScreen", this.Title);
			AddMasterSearchItem("UID", CurrUserGuidID);
			AddMasterSearchItem("CurrUserGuidID", CurrUserGuidID);
			AddMasterSearchItem("bNeedRowCount", bNeedRowCount.ToString());
			AddMasterSearchItem("rbAll", rbAll.IsChecked.ToString());
			AddMasterSearchItem("rbEmails", rbEmails.IsChecked.ToString());
			AddMasterSearchItem("rbContent", rbContent.IsChecked.ToString());
			AddMasterSearchItem("ckWeights", ckWeights.IsChecked.ToString());
			AddMasterSearchItem("ckLimitToLib", ckLimitToLib.IsChecked.ToString());
			AddMasterSearchItem("LowerPageNbr", LowerPageNumber.ToString());
			AddMasterSearchItem("UpperPageNbr", UpperPageNumber.ToString());
			AddMasterSearchItem("GeneratedSql", AutoSql);
			AddMasterSearchItem("CurrentDocPage", CurrentDocPage.ToString());
			AddMasterSearchItem("CurrentEmailPage", CurrentEmailPage.ToString());
			
			foreach (string sKey in dictEmailSearch.Keys)
			{
				string sVal = dictEmailSearch[sKey];
				AddMasterSearchItem(sKey, sVal);
			}
			
			foreach (string sKey in dictContentSearch.Keys)
			{
				string sVal = dictContentSearch[sKey];
				AddMasterSearchItem(sKey, sVal);
			}
			
		}
		
		public void SaveSearch(int IndexKey)
		{
			
			if (bSaveSearchesToDB)
			{
				SaveSearchHistory();
			}
			
			dictScreenControls.Clear();
			
			//Dim ISO As New clsIsolatedStorage
			
			var ScreenName = "frmQuickSearch";
			var SaveTypeCode = "QUICKSEARCH";
			string UID = CurrUserGuidID;
			string ValName = "";
			string ValValue = "";
			bool B = true;
			
			string txtSelDir = "??";
			bool ckShowDetails = false;
			bool ckCountOnly = false;
			bool ckLimitToExisting = false;
			bool ckBusiness = false;
			bool rbToDefaultDir = false;
			bool rbToOriginalDir = false;
			bool rbToSelDir = false;
			bool ckOverWrite = false;
			
			ISO.ZeroizeSaveFormData(IndexKey, ScreenName, SaveTypeCode, UID, ValName, ValValue);
			
			SaveTypeCode = "QUICKSEARCH";
			
			ValName = "txtSearch";
			ValValue = txtSearch.Text.Trim();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "txtSelDir";
			//ValValue = txtSelDir
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "cbLibrary";
			ValValue = (string) cbLibrary.SelectedItem;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "nbrWeightMin";
			ValValue = nbrWeightMin.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "rbAll";
			ValValue = rbAll.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "rbContent";
			ValValue = rbContent.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "rbEmails";
			ValValue = rbEmails.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckShowDetails"
			//ValValue = ckShowDetails.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "ckLimitToLib";
			ValValue = ckLimitToLib.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckCountOnly"
			//ValValue = ckCountOnly.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "ckMyContent";
			ValValue = ckMyContent.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "ckMasterOnly";
			ValValue = ckMasterOnly.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckLimitToExisting"
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "ckWeights";
			ValValue = ckWeights.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//ValName = "ckBusiness"
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "rbToDefaultDir"
			//ValValue = rbToDefaultDir.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "rbToOriginalDir"
			//ValValue = rbToOriginalDir.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "rbToSelDir"
			//ValValue = rbToSelDir.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			//ValName = "ckOverWrite"
			//ValValue = ckOverWrite.IsChecked.ToString
			//ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)
			
			ValName = "lblMain";
			ValValue = (string) lblMain.Content;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "ckFilters";
			ValValue = ckFilters.IsChecked.ToString();
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "SBEmail";
			ValValue = SBEmail.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "SBDoc";
			ValValue = SBDoc.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			ValName = "SB";
			ValValue = SB.Text;
			ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName, ValValue);
			
			//'ISO = Nothing
			
		}
		
		public bool LoadSelectedScreenState(int IndexKey)
		{
			
			bool B = true;
			//Dim ISO As New clsIsolatedStorage
			
			string tgtValue = "";
			string ValName = "";
			string ValValue = "";
			var ScreenName = "frmQuickSearch";
			string SaveTypeCode = "QUICKSEARCH";
			string UID = CurrUserGuidID;
			
			string txtSelDir = "??";
			bool ckShowDetails = false;
			bool ckCountOnly = false;
			bool ckLimitToExisting = false;
			bool ckBusiness = false;
			bool rbToDefaultDir = false;
			bool rbToOriginalDir = false;
			bool rbToSelDir = false;
			bool ckOverWrite = false;
			
			B = ISO.ReadFormData(dictScreenControls, IndexKey, ScreenName, UID);
			if (! B)
			{
				return false;
			}
			
			foreach (string tKey in dictScreenControls.Keys)
			{
				ValValue = dictScreenControls[tKey];
				switch (tKey)
				{
					case "ckFilters":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckFilters.IsChecked = true;
						}
						else
						{
							ckFilters.IsChecked = false;
						}
						break;
					case "txtSearch":
						txtSearch.Text = ValValue;
						break;
					case "txtSelDir":
						txtSelDir = ValValue;
						break;
					case "cbLibrary":
						cbLibrary.SelectedItem = ValValue;
						break;
					case "nbrWeightMin":
						nbrWeightMin.Text = ValValue;
						break;
					case "rbAll":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							rbAll.IsChecked = true;
						}
						else
						{
							rbAll.IsChecked = false;
						}
						break;
					case "rbDocs":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							rbContent.IsChecked = true;
						}
						else
						{
							rbContent.IsChecked = false;
						}
						break;
					case "rbEmails":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							rbEmails.IsChecked = true;
						}
						else
						{
							rbEmails.IsChecked = false;
						}
						break;
					case "ckShowDetails":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckShowDetails = true;
						}
						else
						{
							ckShowDetails = false;
						}
						break;
					case "ckLimitToLib":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckLimitToLib.IsChecked = true;
						}
						else
						{
							ckLimitToLib.IsChecked = false;
						}
						break;
					case "ckCountOnly":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckCountOnly = true;
						}
						else
						{
							ckCountOnly = false;
						}
						break;
					case "ckMyContentOnly":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckMyContent.IsChecked = true;
						}
						else
						{
							ckMyContent.IsChecked = false;
						}
						break;
					case "ckLimitToExisting":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckLimitToExisting = true;
						}
						else
						{
							ckLimitToExisting = false;
						}
						break;
					case "ckWeighted":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckWeights.IsChecked = true;
						}
						else
						{
							ckWeights.IsChecked = false;
						}
						break;
					case "ckBusiness":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckBusiness = true;
						}
						else
						{
							ckBusiness = false;
						}
						break;
					case "rbToDefaultDir":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							rbToDefaultDir = true;
						}
						else
						{
							rbToDefaultDir = false;
						}
						break;
					case "rbToOriginalDir":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							rbToOriginalDir = true;
						}
						else
						{
							rbToOriginalDir = false;
						}
						break;
					case "rbToSelDir":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							rbToSelDir = true;
						}
						else
						{
							rbToSelDir = false;
						}
						break;
						
					case "ckOverWrite":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckOverWrite = true;
						}
						else
						{
							ckOverWrite = false;
						}
						break;
				}
			}
			
			foreach (string tKey in dictScreenControls.Keys)
			{
				ValValue = dictScreenControls[tKey];
				switch (tKey)
				{
					case "ckFilters":
						if (ValValue.ToUpper().Equals("TRUE"))
						{
							ckFilters.IsChecked = true;
						}
						else
						{
							ckFilters.IsChecked = false;
						}
						break;
				}
			}
			
			//'ISO = Nothing
			
			return B;
			
		}
		
		private void SortEmailGrid(string ColName, string SortType)
		{
			
			if (ColName.Trim().Length == 0)
			{
				return;
			}
			//Dim dataView As ICollectionView = System.Windows.Data.CollectionViewSource.GetDefaultView(dgEmails.ItemsSource)
			ICollectionView dataView = dgEmails.ItemsSource;
			dataView.SortDescriptions.Clear();
			SortDescription sd = new SortDescription(ColName, SortType);
			dataView.SortDescriptions.Add(sd);
			dataView.Refresh();
			
		}
		private void SortContentGrid(string ColName, string SortType)
		{
			if (ColName.Trim().Length == 0)
			{
				return;
			}
			ICollectionView dataView = dgContent.ItemsSource;
			dataView.SortDescriptions.Clear();
			SortDescription sd = new SortDescription(ColName, SortType);
			dataView.SortDescriptions.Add(sd);
			dataView.Refresh();
		}
		
		public void getServerInstanceName()
		{
			//'Dim proxy As New SVCSearch.Service1Client
			GLOBALS.ProxySearch.getServerInstanceNameCompleted += new System.EventHandler(client_getServerInstanceName);
			GLOBALS.ProxySearch.getServerInstanceNameAsync(SecureID, modGlobals.gSystemParms);
		}
		public void client_getServerInstanceName(object sender, SVCSearch.getServerInstanceNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerInstanceName = (string) e.Result;
				lblDbInstance.Content = modGlobals.gServerInstanceName;
			}
			else
			{
				modGlobals.gServerInstanceName = "Unknown";
			}
			GLOBALS.ProxySearch.getServerInstanceNameCompleted -= new System.EventHandler(client_getServerInstanceName);
		}
		public void getServerMachineName()
		{
			//'Dim proxy As New SVCSearch.Service1Client
			GLOBALS.ProxySearch.getServerMachineNameCompleted += new System.EventHandler(client_getServerMachineName);
			GLOBALS.ProxySearch.getServerMachineNameAsync(SecureID, modGlobals.gSystemParms);
		}
		public void client_getServerMachineName(object sender, SVCSearch.getServerMachineNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerMachineName = (string) e.Result;
				lblDbInstance.Content = modGlobals.gServerInstanceName + " / " + modGlobals.gServerMachineName;
			}
			else
			{
				modGlobals.gServerMachineName = "Unknown";
			}
			GLOBALS.ProxySearch.getServerMachineNameCompleted -= new System.EventHandler(client_getServerMachineName);
		}
		
		public void dgEmails_MouseEnter(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			
			lblDbInstance.Content = modGlobals.gServerInstanceName + " / " + modGlobals.gServerMachineName;
			SBEmailPage.Text = "Rows:1 thru " + dgEmails.Items.Count;
			SBDocPage.Text = "Rows:1 thru " + dgContent.Items.Count;
			
			SelectedGrid = "dgEmails";
			
		}
		
		public void getLoggedInUser()
		{
			//'Dim proxy As New SVCSearch.Service1Client
			GLOBALS.ProxySearch.getLoggedInUserCompleted += new System.EventHandler(client_getLoggedInUser);
			GLOBALS.ProxySearch.getLoggedInUserAsync(SecureID);
		}
		public void client_getLoggedInUser(object sender, SVCSearch.getLoggedInUserCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				CurrLoginID = (string) e.Result;
				lblDbInstance.Content = CurrLoginID + " / " + modGlobals.gServerMachineName;
				
				bool B = ISO.isClcInstalled();
				if (B)
				{
					lblClcState.Visibility = System.Windows.Visibility.Collapsed;
				}
				else
				{
					//lblClcState.Visibility = Windows.Visibility.Visible
				}
				
			}
			else
			{
				CurrLoginID = "Unknown";
			}
			GLOBALS.ProxySearch.getLoggedInUserCompleted -= new System.EventHandler(client_getLoggedInUser);
		}
		public void getAttachedMachineName()
		{
			if (GLOBALS._SecureID > 0)
			{
				GLOBALS.ProxySearch.getAttachedMachineNameCompleted += new System.EventHandler(client_getAttachedMachineName);
				GLOBALS.ProxySearch.getAttachedMachineNameAsync(GLOBALS._SecureID);
			}
		}
		public void client_getAttachedMachineName(object sender, SVCSearch.getAttachedMachineNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerMachineName = (string) e.Result;
				lblDbInstance.Content = modGlobals.gServerInstanceName + " / " + modGlobals.gServerMachineName;
			}
			else
			{
				modGlobals.gServerMachineName = "Unknown";
			}
			modGlobals.gServerMachineName = "Unknown";
			GLOBALS.ProxySearch.getAttachedMachineNameCompleted -= new System.EventHandler(client_getAttachedMachineName);
		}
		
		private void dpDocuments_PageIndexChanged(System.Object sender, System.EventArgs e)
		{
			DocLowerPageNbr += PageRowLimit;
			DocUpperPageNbr += PageRowLimit;
			btnSubmit_Click(null, null);
		}
		
		private void dpEmails_PageIndexChanged(System.Object sender, System.EventArgs e)
		{
			EmailLowerPageNbr += PageRowLimit;
			EmailUpperPageNbr += PageRowLimit;
			btnSubmit_Click(null, null);
		}
		
		public void client_GetEmailAttachments(object sender, SVCSearch.GetEmailAttachmentsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result != null)
				{
					dgAttachments.ItemsSource = e.Result;
					SB.Text = (string) ("Attachments Count = " + e.Result.Count.ToString());
					
					dgAttachments.Columns["EmailGuid"].Visibility = false;
					//dgAttachments.Columns("RowID").Visible = False
					int W = 600;
					
					dgAttachments.Columns["AttachmentName"].Width = W;
					
				}
				else
				{
					dgAttachments.ItemsSource = e.Result;
					SB.Text = "No attachments";
				}
			}
			else
			{
				MessageBox.Show((string) ("ERROR: Could not fetch messages - " + e.Error.Message));
			}
			dgAttachments.Visibility = System.Windows.Visibility.Visible;
		}
		
		//Private Sub nbrDocRows_ValueChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Double)) Handles nbrDocRows.ValueChanged
		//    PageRowLimit = CInt(nbrDocRows.text)
		//    DocLowerPageNbr = 0
		//    DocUpperPageNbr = PageRowLimit
		//End Sub
		
		public void btnEmailPagePack_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(1030, modGlobals.gCurrUserGuidID);
			CurrentEmailPage--;
			if (CurrentEmailPage < 0)
			{
				CurrentEmailPage = 1;
				SBEmailPage.Text = "Rows:1 thru " + dgEmails.Items.Count;
				SBDocPage.Text = "Rows:1 thru " + dgContent.Items.Count;
			}
			EmailLowerPageNbr -= int.Parse(nbrDocRows.Text);
			EmailUpperPageNbr -= int.Parse(nbrDocRows.Text);
			if (EmailLowerPageNbr <= 0)
			{
				SBEmailPage.Text = "Rows:1 thru " + dgEmails.Items.Count;
				SBDocPage.Text = "Rows:1 thru " + dgContent.Items.Count;
				EmailLowerPageNbr = 0;
			}
			if (EmailUpperPageNbr < PageRowLimit)
			{
				EmailUpperPageNbr = PageRowLimit;
			}
			btnSubmit_Click(null, null);
		}
		
		public void btnEmailPageForward_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(1031, modGlobals.gCurrUserGuidID);
			CurrentEmailPage++;
			EmailLowerPageNbr += int.Parse(nbrDocRows.Text);
			EmailUpperPageNbr += int.Parse(nbrDocRows.Text);
			btnSubmit_Click(null, null);
		}
		
		public void btnDocPagePack_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(1020, modGlobals.gCurrUserGuidID);
			CurrentDocPage--;
			if (CurrentDocPage <= 0)
			{
				CurrentDocPage = 1;
				SBEmailPage.Text = "Rows:1 thru " + dgEmails.Items.Count;
				SBDocPage.Text = "Rows:1 thru " + dgContent.Items.Count;
			}
			DocLowerPageNbr -= int.Parse(nbrDocRows.Text);
			DocUpperPageNbr -= int.Parse(nbrDocRows.Text);
			if (DocLowerPageNbr < 0)
			{
				SBEmailPage.Text = "Rows:1 thru " + dgEmails.Items.Count;
				SBDocPage.Text = "Rows:1 thru " + dgContent.Items.Count;
				DocLowerPageNbr = 0;
			}
			if (DocUpperPageNbr < PageRowLimit)
			{
				SBEmailPage.Text = "Rows:1 thru " + dgEmails.Items.Count;
				SBDocPage.Text = "Rows:1 thru " + dgContent.Items.Count;
				DocUpperPageNbr = PageRowLimit;
			}
			btnSubmit_Click(null, null);
		}
		
		public void btnDocPageForward_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(1021, modGlobals.gCurrUserGuidID);
			CurrentDocPage++;
			DocLowerPageNbr += int.Parse(nbrDocRows.Text);
			DocUpperPageNbr += int.Parse(nbrDocRows.Text);
			btnSubmit_Click(null, null);
		}
		
		public void SBEmailPage_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			
		}
		
		private void SBDocPage_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			
		}
		
		private void dgContent_MouseLeave(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			
		}
		
		public void dgEmails_LoadedRows(System.Object sender, System.EventArgs e)
		{
			if (bWaitToApplyAttachmentWeight == false)
			{
				if (ckWeights.IsChecked)
				{
					ApplyAttachmentWeights();
				}
			}
			//GetEmailGridLayout(dictGridParmsEmail, dgEmails)
			getSavedEmailGridColumnsDisplayOrder();
			
		}
		
		public void dgEmails_GotFocus(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			if (bWaitToApplyAttachmentWeight == false)
			{
				if (ckWeights.IsChecked)
				{
					ApplyAttachmentWeights();
				}
			}
			ckClcActive();
		}
		
		public void Page_Loaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
		}
		
		public void callPreview()
		{
			
			RepoTableName = RepoTableName.ToUpper();
			bool bPreview = true;
			bool bRestore = true;
			
			string RetMsg = "";
			string MachineID = "";
			string FQN = "NA";
			int iCnt = 0;
			
			if (RepoTableName.ToUpper().Equals("EMAILATTACHMENT"))
			{
				foreach (object O in dgAttachments.SelectedItems)
				{
					iCnt++;
				}
			}
			else if (RepoTableName.ToUpper().Equals("EMAIL"))
			{
				foreach (object O in dgEmails.SelectedItems)
				{
					iCnt++;
				}
			}
			else if (RepoTableName.ToUpper().Equals("DATASOURCE"))
			{
				foreach (object O in dgContent.SelectedItems)
				{
					iCnt++;
				}
			}
			else
			{
				SB.Text = "WARNING: No restore table selected 100.";
				return;
			}
			
			if (iCnt == 1)
			{
				if (RepoTableName.Equals("DATASOURCE"))
				{
					int IX = dgContent.SelectedIndex;
					CurrentGuid = grid.GetCellValueAsString(dgContent, IX, "SourceGuid").ToString();
					//CurrentGuid = dgContent(IX, "SourceGuid")
					//FQN = dgContent(IX, "FQN")
					FQN = grid.GetCellValueAsString(dgContent, IX, "FQN ").ToString();
					
					if (UseISO)
					{
						ISO.SaveFilePreviewGuid(CurrUserGuidID, RepoTableName.ToUpper(), CurrentGuid, FQN);
					}
					else
					{
						//AddHandler ProxySearch.scheduleFileDownLoadCompleted, AddressOf client_scheduleFileDownLoad
						//ProxySearch.scheduleFileDownLoadAsync()
						//ProxySearch.saveRestoreFileAsync(_SecureID, "DataSource", CurrentGuid, bPreview, bRestore, _UserGuid, _MachineID, RC, RetMsg)
						GLOBALS.ProxySearch.scheduleFileDownLoadAsync(GLOBALS._SecureID, CurrentGuid, GLOBALS._UserID, "CONTENT", 1, 0);
					}
				}
				else if (RepoTableName.Equals("EMAIL"))
				{
					int IX = System.Convert.ToInt32(dgEmails.SelectedIndex);
					//CurrentGuid = dgEmails(IX, "EmailGuid")
					//FQN = dgEmails(IX, "SourceTypeCode")
					CurrentGuid = grid.GetCellValueAsString(dgContent, IX, "EmailGuid").ToString();
					FQN = grid.GetCellValueAsString(dgContent, IX, "SourceTypeCode ").ToString();
					
					if (UseISO)
					{
						ISO.SaveFilePreviewGuid(CurrUserGuidID, RepoTableName.ToUpper(), CurrentGuid, FQN);
					}
					else
					{
						//ProxySearch.saveRestoreFileAsync(_SecureID, "Email", CurrentGuid, bPreview, bRestore, _UserGuid, _MachineID, RC, RetMsg)
						GLOBALS.ProxySearch.scheduleFileDownLoadAsync(GLOBALS._SecureID, CurrentGuid, GLOBALS._UserID, "EMAIL", 1, 0);
					}
				}
				else if (RepoTableName.Equals("EMAILATTACHMENT"))
				{
					if (SelectedGrid == "dgEmails")
					{
						if (UseISO)
						{
							ISO.SaveFilePreviewGuid(CurrUserGuidID, RepoTableName.ToUpper(), CurrAttachmentRowID, FQN);
						}
						else
						{
							//ProxySearch.saveRestoreFileAsync(_SecureID, "EmailAttachment", CurrentGuid, bPreview, bRestore, _UserGuid, _MachineID, RC, RetMsg)
							GLOBALS.ProxySearch.scheduleFileDownLoadAsync(GLOBALS._SecureID, CurrAttachmentRowID, GLOBALS._UserID, "EMAILATTACHMENT", 1, 0);
						}
					}
					if (SelectedGrid == "dgContent")
					{
						MessageBox.Show("Fix This");
					}
				}
				
			}
			
		}
		
		public void client_GetFilesInZip(object sender, SVCSearch.GetFilesInZipCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result == null)
				{
					GetMetaData(CurrentGuid);
				}
				else
				{
					dgAttachments.ItemsSource = e.Result;
					dgAttachments.Visibility = Visibility.Visible;
				}
			}
			else
			{
				dgAttachments.Visibility = Visibility.Visible;
				SB.Text = (string) ("ERROR: GetFilesInZip 100a - " + e.Error.Message);
			}
		}
		
		public void client_scheduleFileDownLoad(object sender, SVCSearch.scheduleFileDownLoadCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result)
				{
					SB.Text = "Preview Record inserted.";
				}
				else
				{
					MessageBox.Show("ERROR: failed to set content for retrieval.");
				}
			}
			else
			{
				MessageBox.Show((string) ("ERROR: scheduleFileDown 100a - " + e.Error.Message));
			}
			
			//RemoveHandler ProxySearch.saveRestoreFileCompleted, AddressOf client_saveRestoreFile
			
		}
		public void client_saveRestoreFile(object sender, SVCSearch.saveRestoreFileCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.RC)
				{
				}
				else
				{
					MessageBox.Show("ERROR: failed to set content for retrieval.");
				}
			}
			else
			{
				MessageBox.Show("Failed to Restore.");
				SB.Text = "Failed to Restore.";
			}
			
			//RemoveHandler ProxySearch.saveRestoreFileCompleted, AddressOf client_saveRestoreFile
			
		}
		
		public void SaveScreenDictionary(string ControlName, string ControlValue)
		{
			if (dictScreenControls.ContainsKey(ControlName))
			{
				dictScreenControls[ControlName] = ControlValue;
			}
			else
			{
				dictScreenControls.Add(ControlName, ControlValue);
			}
		}
		
		public void ReorderEmailGridCols(string ColName, int ColDisplayOrder)
		{
			
			DataGridColumn col = dgEmails.Columns(ColName);
			dgEmails.Columns.Remove(col);
			dgEmails.Columns.Insert(ColDisplayOrder, col);
			
		}
		
		public void SaveGridColumnOrder(DataGrid DG, ref Dictionary<int, string> DICT)
		{
			GM.SaveGridState(CurrUserGuidID, this.Title, DG, DICT);
		}
		
		/// <summary>
		/// All items stored in dictScreenControls will be added to the database
		/// basd on the assigned SearchID
		/// </summary>
		/// <remarks></remarks>
		public void SaveSearchHistory()
		{
			int SearchID = CurrentSearchIdHigh;
			SaveSearchParmParms(SearchID);
			
			//'Dim proxy As New SVCSearch.Service1Client
			//AddHandler ProxySearch.saveSearchStateCompleted, AddressOf client_saveSearchState
			GLOBALS.ProxySearch.saveSearchStateAsync(SecureID, SearchID, CurrUserGuidID, this.Title, dictScreenControls, returnMsg, RC, modGlobals.HiveConnectionName, modGlobals.HiveActive, modGlobals.RepoSvrName);
		}
		public void client_saveSearchState(object sender, SVCSearch.saveSearchStateCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				RC = System.Convert.ToBoolean(e.RC);
				returnMsg = (string) e.rMsg;
				SB.Text = returnMsg;
			}
			else
			{
				SB.Text = returnMsg;
			}
		}
		
		public void GetSearchHistory(int SearchID)
		{
			
			string SaveTypeCode = "";
			bool B = false;
			B = LoadSelectedScreenState(SearchID);
			
			if (B)
			{
				SB.Text = "Search History found for ID# " + SearchID.ToString() + ".";
				return;
			}
			else
			{
				SB.Text = "End of search history.";
			}
			
			if (bSaveSearchesToDB)
			{
				PB.IsIndeterminate = true;
				//'Dim proxy As New SVCSearch.Service1Client
				//AddHandler ProxySearch.getSearchStateCompleted, AddressOf client_getSearchState
				GLOBALS.ProxySearch.getSearchStateAsync(SecureID, SearchID, CurrUserGuidID, this.Title, dictScreenControls, returnMsg, RC, modGlobals.HiveConnectionName, modGlobals.HiveActive, modGlobals.RepoSvrName);
			}
			
		}
		public void client_getSearchState(object sender, SVCSearch.getSearchStateCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				RC = System.Convert.ToBoolean(e.RC);
				if (! RC)
				{
					PB.IsIndeterminate = false;
					SB.Text = "No DB search history found.";
					return;
				}
				returnMsg = (string) e.rMsg;
				//SearchHistory = e.Result
				SearchHistory = e.Result.ToList;
				//SearchHistory = ObjSearchHistory
				int RowsReturned = System.Convert.ToInt32(SearchHistory.Count);
				object O = SearchHistory.Item(0).ParmName;
				SB.Text = returnMsg;
			}
			else
			{
				SB.Text = returnMsg;
			}
			PB.IsIndeterminate = false;
		}
		
		public void ReorderGrid(DataGrid DG, Dictionary<int, string> DICT)
		{
			
			foreach (int iKey in DICT.Keys)
			{
				string ColName = (string) (DICT.Item(iKey));
				DataGridColumn col = dgEmails.Columns(ColName);
				dgEmails.Columns.Remove(col);
				dgEmails.Columns.Insert(iKey, col);
			}
			
		}
		
		public void SaveGridLayoutToDB(DataGrid DG)
		{
			
			string UserID = CurrUserGuidID;
			string ScreenName = this.Title;
			string GridName = DG.Name;
			string ColName = "";
			int ColOrder = -1;
			int ColWidth = 0;
			bool ColVisible = false;
			bool ColReadOnly = false;
			int ColSortOrder = -1;
			bool ColSortAsc = false;
			string HiveConnectionName = "-*-";
			bool HiveActive = false;
			string RepoSvrName = "-*-";
			DateTime RowCreationDate = DateTime.Now;
			DateTime RowLastModDate = DateTime.Now;
			int RowNbr = 0;
			
			string rMsg = "";
			for (int I = 0; I <= DG.Columns.Count - 1; I++)
			{
				ColName = (string) (DG.Columns[I].Header);
				ColOrder = I;
				if (DG.Columns[I].Width.ToString().Equals("Auto"))
				{
					ColWidth = -1;
				}
				else
				{
					ColWidth = int.Parse(DG.Columns[I].Width.ToString());
				}
				
				ColVisible = DG.Columns[I].Visibility;
				ColReadOnly = DG.Columns[I].IsReadOnly;
				
				GLOBALS.ProxySearch.saveGridLayoutAsync(SecureID, UserID, ScreenName, GridName, ColName, ColOrder, ColWidth, ColVisible, ColReadOnly, ColSortOrder, ColSortAsc, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate, RowNbr, RC, rMsg);
				
			}
		}
		public void client_saveGridLayout(object sender, SVCSearch.saveGridLayoutCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				SB.Text = "System Grid Parms saved.";
			}
			else
			{
				SB.Text = (string) ("System Grid Parms failed to save / DB Failed to attach - " + e.Error.Message);
			}
			
		}
		
		public void GetEmailGridLayout(Dictionary<string, string> DICT, DataGrid DG)
		{
			
			string HiveConnectionName = "";
			bool HiveActive = false;
			string RepoSvrName = "";
			string rMsg = "";
			bool RC = false;
			
			//'Dim proxy As New SVCSearch.Service1Client
			//AddHandler ProxySearch.getGridLayoutCompleted, AddressOf client_getEmailGridLayout
			GLOBALS.ProxySearch.getGridLayoutAsync(SecureID, CurrUserGuidID, this.Title, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName);
			
		}
		
		public void client_getEmailGridLayout(object sender, SVCSearch.getGridLayoutCompletedEventArgs e)
		{
			System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_clsUSERGRIDSTATE> ListOfRows = new System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_clsUSERGRIDSTATE>();
			object ObjListOfRows = null;
			if (e.Error == null)
			{
				dictEmailGridColDisplayOrder.Clear();
				ObjListOfRows = e.Result;
				
				if (ListOfRows == null)
				{
					return;
				}
				
				for (int i = 0; i <= ListOfRows.Count - 1; i++)
				{
					
					GridCols gCols = new GridCols();
					//Dim cCols As New ContentGridCols
					
					string ScreenName = (string) (ObjListOfRows.Item(i).ScreenName);
					string GridName = (string) (ListOfRows[i].GridName);
					string ColName = (string) (ListOfRows[i].ColName);
					int ColOrder = System.Convert.ToInt32(ListOfRows[i].ColOrder);
					if (dictEmailGridColDisplayOrder.ContainsKey(ColOrder))
					{
						dictEmailGridColDisplayOrder[ColOrder] = ColName;
					}
					else
					{
						dictEmailGridColDisplayOrder.Add(ColOrder, ColName);
					}
					bool ColReadOnly = System.Convert.ToBoolean(ListOfRows[i].ColReadOnly);
					bool ColVisible = System.Convert.ToBoolean(ListOfRows[i].ColVisible);
					int W = System.Convert.ToInt32(ListOfRows[i].ColWidth);
					
					gCols.GridName = GridName;
					gCols.Colname = ColName;
					gCols.ColOrd = ColOrder;
					gCols.Visible = ColVisible;
					gCols.bReadOnly = ColReadOnly;
					gCols.Width = W;
					
					DataGridColumn col = dgEmails.Columns[ColName];
					dgEmails.Columns.Remove(col);
					dgEmails.Columns.Insert(i, col);
					if (W < 0)
					{
						col.Width = DataGridLength.Auto;
					}
					else
					{
						object O = W;
						col.Width = (DataGridLength) O;
					}
					col.Visibility = ColVisible;
					col.IsReadOnly = ColReadOnly;
					
				}
				SB.Text = "System Grid Parms Loaded: " + modGlobals.gSystemParms.Count + " and DB Connection good.";
			}
			else
			{
				SB.Text = "System Grid Parms failed to Load / DB Failed to attach.";
			}
		}
		
		public void GetContentGridLayout(Dictionary<string, string> DICT, DataGrid DG)
		{
			
			string HiveConnectionName = "";
			bool HiveActive = false;
			string RepoSvrName = "";
			string rMsg = "";
			bool RC = false;
			
			//'Dim proxy As New SVCSearch.Service1Client
			//AddHandler ProxySearch.getGridLayoutCompleted, AddressOf client_getContentGridLayout
			GLOBALS.ProxySearch.getGridLayoutAsync(SecureID, CurrUserGuidID, this.Title, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName);
			
		}
		public void client_getContentGridLayout(object sender, SVCSearch.getGridLayoutCompletedEventArgs e)
		{
			System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_clsUSERGRIDSTATE> ListOfRows = new System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_clsUSERGRIDSTATE>();
			object ObjListOfRows = null;
			if (e.Error == null)
			{
				dictEmailGridColDisplayOrder.Clear();
				//ListOfRows = e.Result
				ObjListOfRows = e.Result;
				ListOfRows = ObjListOfRows;
				for (int i = 0; i <= ListOfRows.Count - 1; i++)
				{
					
					GridCols gCols = new GridCols();
					//Dim cCols As New ContentGridCols
					
					string ScreenName = (string) (ListOfRows[i].ScreenName);
					string GridName = (string) (ListOfRows[i].GridName);
					string ColName = (string) (ListOfRows[i].ColName);
					int ColOrder = System.Convert.ToInt32(ListOfRows[i].ColOrder);
					if (dictEmailGridColDisplayOrder.ContainsKey(ColOrder))
					{
						dictEmailGridColDisplayOrder[ColOrder] = ColName;
					}
					else
					{
						dictEmailGridColDisplayOrder.Add(ColOrder, ColName);
					}
					bool ColReadOnly = System.Convert.ToBoolean(ListOfRows[i].ColReadOnly);
					bool ColVisible = System.Convert.ToBoolean(ListOfRows[i].ColVisible);
					int W = System.Convert.ToInt32(ListOfRows[i].ColWidth);
					
					gCols.GridName = GridName;
					gCols.Colname = ColName;
					gCols.ColOrd = ColOrder;
					gCols.Visible = ColVisible;
					gCols.bReadOnly = ColReadOnly;
					gCols.Width = W;
					
					DataGridColumn col = dgContent.Columns[ColName];
					dgContent.Columns.Remove(col);
					dgContent.Columns.Insert(i, col);
					if (W < 0)
					{
						col.Width = DataGridLength.Auto;
					}
					else
					{
						object O = W;
						col.Width = (DataGridLength) O;
					}
					col.Visibility = ColVisible;
					col.IsReadOnly = ColReadOnly;
					
				}
				SB.Text = "System Grid Parms Loaded: " + modGlobals.gSystemParms.Count + " and DB Connection good.";
			}
			else
			{
				SB.Text = "System Grid Parms failed to Load / DB Failed to attach.";
			}
		}
		
		public void populateLibraryComboBox()
		{
			
			System.Threading.Thread.Sleep(GLOBALS.AffinityDelay);
			GLOBALS.ProxySearch.PopulateGroupUserLibComboCompleted += new System.EventHandler(client_PopulateGroupUserLibCombo);
			GLOBALS.ProxySearch.PopulateGroupUserLibComboAsync(SecureID, CurrUserGuidID, ListOfLibraries.ToArray);
			
		}
		public void client_PopulateGroupUserLibCombo(object sender, SVCSearch.PopulateGroupUserLibComboCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				cbLibrary.Items.Clear();
				//ListOfLibraries = e.cb
				string[] strLibraries = e.cb;
				if (strLibraries == null)
				{
					SB.Text = "No user Libraries defined at this time.";
				}
				else
				{
					foreach (string S in strLibraries)
					{
						cbLibrary.Items.Add(S);
					}
				}
			}
			else
			{
				//MessageBox.Show("Failed to Load user Libraries." + vbCrLf + e.Error.Message)
				SB.Text = "Failed to Load user Libraries.";
			}
			
			GLOBALS.ProxySearch.PopulateGroupUserLibComboCompleted -= new System.EventHandler(client_PopulateGroupUserLibCombo);
			
		}
		
		public void btnLibrary_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			if (LibraryOwnerGuid.Trim().Length == 0)
			{
				MessageBox.Show("The LIBRARY owner cannot be established, please reselect the library again. Returning.");
				return;
			}
			if (CurrentlySelectedGrid.Equals("EMAIL"))
			{
				AddLibraryItems(dgEmails, CurrUserGuidID, LibraryOwnerGuid);
			}
			else
			{
				AddLibraryItems(dgContent, CurrUserGuidID, LibraryOwnerGuid);
			}
		}
		
		public void AddLibraryItems(DataGrid TDG, string AddedByUserGuidId, string strLibraryOwnerGuid)
		{
			
			COMMON.SaveClick(1002, modGlobals.gCurrUserGuidID);
			
			//Dim I As Integer = 0
			
			//If CurrentlySelectedGrid.Equals("EMAIL") Then
			//    I = dgEmails.SelectedItems.Count
			//Else
			//    I = dgContent.SelectedItems.Count
			//End If
			
			int I = 0;
			
			foreach (object O in TDG.SelectedItems)
			{
				I++;
			}
			
			if (I == 0)
			{
				MessageBox.Show("You have selected NO items to add to the library, " + "\r\n" + "you must select at least one item.");
				return;
			}
			
			string SelectedLib = (string) cbLibrary.SelectedItem;
			if (SelectedLib.Length == 0)
			{
				MessageBox.Show("You must first select a library, returning...");
				return;
			}
			
			var msg = "This will add " + I.ToString() + " items to library, \'" + SelectedLib + "\', are you sure?";
			MessageBoxResult result = MessageBox.Show(msg, "Add to Library", MessageBoxButton.OKCancel);
			if (result == MessageBoxResult.OK)
			{
			}
			else
			{
				SB.Text = "Add to library cancelled.";
				return;
			}
			
			int iAdded = 0;
			int iSkipped = 0;
			
			try
			{
				GLOBALS.ProxySearch.AddLibraryItemsCompleted -= new System.EventHandler(client_AddLibraryItems);
			}
			catch (Exception)
			{
				Console.WriteLine("XXX-1245");
			}
			
			iTotalToProcess = 0;
			
			GLOBALS.ProxySearch.AddLibraryItemsCompleted += new System.EventHandler(client_AddLibraryItems);
			
			int iSelectedCnt = TDG.SelectedItems.Count;
			
			
			try
			{
				foreach (object DR in TDG.SelectedItems)
				{
					iTotalToProcess++;
					string SourceGuid = "";
					DataGridCell cell = null;
					if (CurrentlySelectedGrid.Equals("EMAIL"))
					{
						//cell = grid.GetCell(TDG, DR, "EmailGuid")
						SourceGuid = (string) DR.EmailGuid;
						//SourceGuid$ = DR("EmailGuid").ToString
					}
					else
					{
						//SourceGuid$ = DR("SourceGuid").ToString
						//cell = grid.GetCell(TDG, DR, "SourceGuid")
						SourceGuid = DR.SourceGuid;
					}
					
					string Subject = "";
					if (CurrentlySelectedGrid.Equals("EMAIL"))
					{
						//Subject$ = DR("ShortSubj").ToString
						//cell = grid.GetCell(TDG, DR, "ShortSubj")
						Subject = (string) DR.ShortSubj;
					}
					else
					{
						//Subject$ = DR("SourceName").ToString
						//cell = grid.GetCell(TDG, DR, "SourceName")
						Subject = (string) DR.SourceName;
					}
					
					string UserGuidID = "";
					
					if (CurrentlySelectedGrid.Equals("EMAIL"))
					{
						//UserGuidID$ = DR("UserID").ToString
						//cell = grid.GetCell(TDG, DR, "UserID")
						UserGuidID = (string) DR.UserID;
					}
					else
					{
						//UserGuidID$ = DR("DataSourceOwnerUserID").ToString
						//cell = grid.GetCell(TDG, DR, "DataSourceOwnerUserID")
						UserGuidID = (string) DR.DataSourceOwnerUserID;
					}
					
					Subject = Subject.Substring(0, 80).Trim();
					string ContentExt = "";
					try
					{
						if (CurrentlySelectedGrid.Equals("EMAIL"))
						{
							//ContentExt$ = DR("OriginalFileType").ToString
							//cell = grid.GetCell(TDG, DR, "OriginalFileType")
							ContentExt = (string) DR.OriginalFileType;
						}
						else
						{
							//ContentExt$ = DR("SourceTypeCode").ToString
							//cell = grid.GetCell(TDG, DR, "SourceTypeCode")
							ContentExt = (string) DR.SourceTypeCode;
						}
					}
					catch (Exception)
					{
						
					}
					
					string NewGuid = System.Guid.NewGuid().ToString();
					string rMsg = "";
					
					GLOBALS.ProxySearch.AddLibraryItemsAsync(GLOBALS._SecureID, SourceGuid, Subject, ContentExt, NewGuid, UserGuidID, strLibraryOwnerGuid, SelectedLib, AddedByUserGuidId, RC, rMsg);
					
				}
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ERROR: MainPage/AddLibraryItem: " + ex.Message));
			}
			SB.Text = iAdded.ToString() + " items added, " + iSkipped.ToString() + " items skipped.";
			
		}
		public void client_AddLibraryItems(object sender, SVCSearch.AddLibraryItemsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (! e.RC)
				{
					SB.Text = (string) ("Failed to Load library item: " + e.rMsg);
				}
				else
				{
					SB.Text = iTotalToProcess.ToString() + " items added to library " + cbLibrary.SelectedItem + ".";
				}
			}
			else
			{
				SB.Text = (string) ("Failed to Load library item: " + e.rMsg);
				MessageBox.Show((string) ("Failed to Load library item: " + e.rMsg));
			}
			
		}
		
		public void client_GetLibOwnerByName(object sender, SVCSearch.GetLibOwnerByNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				LibraryOwnerGuid = (string) e.Result;
			}
			else
			{
				LibraryOwnerGuid = "";
				SB.Text = "Failed to Load library owner GUID.";
			}
			GLOBALS.ProxySearch.GetLibOwnerByNameCompleted -= new System.EventHandler(client_GetLibOwnerByName);
		}
		
		private void txtSearch_KeyDown(System.Object sender, System.Windows.Input.KeyEventArgs e)
		{
			if (e.Key == Key.Enter)
			{
				btnSubmit_Click(null, null);
			}
		}
		
		public void dgContent_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			
			CurrentlySelectedGrid = "CONTENT";
			
			txtDescription.Text = "";
			int iCnt = dgContent.SelectedItems.Count;
			if (iCnt > 0)
			{
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
			}
			if (iCnt == 1)
			{
				object DR = dgContent.SelectedItems[0];
				int IX = dgContent.SelectedIndex;
				
				if (DR.isPublic.ToString().ToUpper.Equals("Y"))
				{
					lblIsPublicShow.Visibility = Visibility.Visible;
				}
				else
				{
					lblIsPublicShow.Visibility = Visibility.Collapsed;
				}
				if (DR.RssLinkFlg.ToString().ToUpper.Equals("TRUE"))
				{
					lblRssPull.Visibility = Visibility.Visible;
				}
				else
				{
					lblRssPull.Visibility = Visibility.Collapsed;
				}
				if (DR.StructuredData.ToString().ToUpper.Equals("TRUE"))
				{
					lblStructuredData.Visibility = Visibility.Visible;
				}
				else
				{
					lblStructuredData.Visibility = Visibility.Collapsed;
				}
				if (DR.isWebPage.ToString().ToUpper.Equals("Y"))
				{
					LblIsWebShow.Visibility = Visibility.Visible;
				}
				else
				{
					LblIsWebShow.Visibility = Visibility.Collapsed;
				}
				if (DR.Description.ToString().Trim.Length > 0)
				{
					txtDescription.Text = (string) (DR.Description.ToString());
				}
				else
				{
					txtDescription.Text = "";
				}
				if (DR.isWebPage.ToString().ToUpper.Equals("Y"))
				{
					txtDescription.Text = (string) ("Web Page: " + txtDescription.Text);
				}
				if (DR.RssLinkFlg.ToString().ToUpper.Equals("TRUE"))
				{
					txtDescription.Text = (string) ("RSS Pull: " + txtDescription.Text);
				}
				//If DR.isMaster.ToString.ToUpper.Equals("N") Then
				//    LblCkIsMasterShow.Visibility = Visibility.Collapsed
				//Else
				//    LblCkIsMasterShow.Visibility = Visibility.Visible
				//End If
				//If DR.SharePoint.ToString.ToUpper.Equals("TRUE") Then
				//    lblSharePoint.Visibility = Visibility.Visible
				//Else
				//    lblSharePoint.Visibility = Visibility.Collapsed
				//End If
				//If DR.SapData.ToString.ToUpper.Equals("TRUE") Then
				//    lblSap.Visibility = Visibility.Visible
				//Else
				//    lblSap.Visibility = Visibility.Collapsed
				//End If
				
				CurrentGuid = (string) DR.SourceGuid;
				RepoTableName = "DataSource";
				//** Get any metadata
				if (iCnt == 1)
				{
					int II = dgContent.SelectedIndex;
					//Dim ParentGuid As String = DR.ParentGuid")
					RepoTableName = "DataSource";
					bool FoundInAttachment = false;
					//Dim IsZipFile As String = DR.IsZipFile")
					//Dim IsConatinedWithinZipFile As String = DR.IsConatinedWithinZipFile")
					bool SD;
					bool SP;
					bool SAP;
					bool bMaster;
					bool RSS;
					bool WEB;
					bool PUB;
					GLOBALS.ProxySearch.GetFilesInZipAsync(SecureID, CurrentGuid, RC);
					GLOBALS.ProxySearch.ckContentFlagsAsync(SecureID, CurrentGuid, SD, SP, SAP, bMaster, RSS, WEB, PUB);
					
				}
				else
				{
					GetMetaData(CurrentGuid);
				}
				
			}
			if (contentSearchParmsSet())
			{
				lblContentSearchParms.Visibility = Visibility.Visible;
			}
			else
			{
				lblContentSearchParms.Visibility = Visibility.Collapsed;
			}
		}
		
		public void GetMetaData(string SourceGuid)
		{
			Cursor = Cursors.Wait;
			string S = "Select AttributeName, AttributeValue";
			S = S + " FROM [SourceAttribute]";
			S = S + " where [SourceGuid] = \'" + SourceGuid + "\'";
			S = S + " order by [AttributeName]";
			
			GLOBALS.ProxySearch.GetContentMetaDataCompleted += new System.EventHandler(client_GetContentMetaData);
			GLOBALS.ProxySearch.GetContentMetaDataAsync(GLOBALS._SecureID, SourceGuid);
			
		}
		public void client_GetContentMetaData(object sender, SVCSearch.GetContentMetaDataCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result.Count > 0)
				{
					dgAttachments.ItemsSource = e.Result;
					dgAttachments.Visibility = Visibility.Visible;
				}
				else
				{
					dgAttachments.ItemsSource = null;
					dgAttachments.Visibility = Visibility.Collapsed;
				}
				
				FormLoaded = true;
			}
			else
			{
				dgAttachments.ItemsSource = null;
				dgAttachments.Visibility = Visibility.Visible;
			}
			GLOBALS.ProxySearch.GetContentMetaDataCompleted -= new System.EventHandler(client_GetContentMetaData);
			Cursor = Cursors.Arrow;
		}
		
		public void dgContent_LoadedRows(System.Object sender, System.EventArgs e)
		{
			//GetContentGridLayout(dictGridParmsContent, dgContent)
			getSavedContentGridColumnsDisplayOrder();
		}
		
		public void dgEmails_DoubleClick(System.Object sender, System.Windows.Input.MouseButtonEventArgs e)
		{
			
			bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
			if (! bClcRuning)
			{
				SB.Text = "Downloader Not running - preview and restore are disabled.";
				//lblClcState.Visibility = Windows.Visibility.Visible
				lblClcState.Content = "Downloader Not running";
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
				return;
			}
			else
			{
				lblClcState.Visibility = System.Windows.Visibility.Collapsed;
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
			callPreview();
			SB.Text = (string) ("Preview Requested: " + DateTime.Now.ToString());
			
		}
		
		public void dgContent_DoubleClick(System.Object sender, System.Windows.Input.MouseButtonEventArgs e)
		{
			COMMON.SaveClick(900, modGlobals.gCurrUserGuidID);
			bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
			if (! bClcRuning)
			{
				SB.Text = "Downloader Not running - preview and restore are disabled.";
				//lblClcState.Visibility = Windows.Visibility.Visible
				lblClcState.Content = "Downloader Not running";
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
				return;
			}
			else
			{
				lblClcState.Visibility = System.Windows.Visibility.Collapsed;
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
			
			callPreview();
			
		}
		
		//Sub client_DbWriteToFile(ByVal sender As Object, ByVal e As SVCSearch.DbWriteToFileCompletedEventArgs)
		
		//    If e.Error Is Nothing Then
		//        Dim fName As String = e.FileName
		//        Dim b As Boolean = e.Result
		//        If b Then
		//            System.Windows.Browser.HtmlPage.PopupWindow(New Uri("http://localhost:9854/TempContent/" + fName), "_blank", Nothing)
		//            filePreviewName = fName
		//        Else
		//            MessageBox.Show("Cannot open document.")
		//        End If
		//    Else
		//        SB.Text = "ERROR: Failed to process preview request."
		//    End If
		//End Sub
		
		public void AddSearchTerm(string SearchTypeCode, string Term, string TermVal, string TermDatatype)
		{
			
			AddMasterSearchItem(Term, TermVal);
			
			SVCSearch.DS_SearchTerms sItem = new SVCSearch.DS_SearchTerms();
			sItem.SearchTypeCode = SearchTypeCode;
			sItem.Term = Term;
			sItem.TermVal = TermVal;
			sItem.TermDatatype = TermDatatype;
			
			ListOfSearchTerms.Add(sItem);
			
		}
		public void UdpateSearchTerm(string SearchTypeCode, string Term, string TermVal, string TermDatatype)
		{
			
			bool bTermExists = false;
			string tKey = Term;
			
			AddMasterSearchItem(Term, TermVal);
			for (int I = 0; I <= ListOfSearchTerms.Count - 1; I++)
			{
				if (ListOfSearchTerms.Item(I).Term.Equals(tKey))
				{
					bTermExists = true;
					ListOfSearchTerms.Item(I).TermVal = TermVal;
				}
			}
			if (! bTermExists)
			{
				SVCSearch.DS_SearchTerms sItem = new SVCSearch.DS_SearchTerms();
				sItem.SearchTypeCode = SearchTypeCode;
				sItem.Term = Term;
				sItem.TermVal = TermVal;
				sItem.TermDatatype = TermDatatype;
				ListOfSearchTerms.Add(sItem);
			}
			
		}
		public void ZeroizeSearchTerms()
		{
			ListOfSearchTerms.Clear();
		}
		
		public void rbEmails_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//If bQuickSearchRecall Then
			//    Return
			//End If
			TabContent.Visibility = Visibility.Visible;
		}
		
		public void rbAll_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//If bQuickSearchRecall Then
			//    Return
			//End If
			try
			{
				TabContent.Visibility = System.Windows.Visibility.Visible;
				TabEmail.Visibility = System.Windows.Visibility.Visible;
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			
		}
		
		private void rbContent_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//If bQuickSearchRecall Then
			//    Return
			//End If
			TabEmail.Visibility = Visibility.Collapsed;
		}
		
		private void rbContent_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			TabEmail.Visibility = Visibility.Visible;
			if (bQuickSearchRecall)
			{
				return;
			}
			UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B");
		}
		
		public void SetInactiveStateOfForm()
		{
			
			double iOpacity = 0.25;
			string DOW = DateTime.Now.DayOfWeek.ToString();
			
			//If DOW.Equals("Monday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Monday.jpg", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//ElseIf DOW.Equals("Tuesday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Tuesday.jpg", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//ElseIf DOW.Equals("Wednesday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Wednesday.jpg", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//ElseIf DOW.Equals("Thursday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Thursday.jpg", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//ElseIf DOW.Equals("Friday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Friday.jpg", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//ElseIf DOW.Equals("Saturday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Saturday.jpg", UriKind.RelativeOrAbsolute))
			//    'imageMain.Source = New BitmapImage(New Uri("images/ARDEC-medium2.png", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//ElseIf DOW.Equals("Sunday") Then
			//    imageMain.Source = New BitmapImage(New Uri("images/Sunday.jpg", UriKind.RelativeOrAbsolute))
			//    'imageMain.Source = New BitmapImage(New Uri("images/ARDEC-medium2.png", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//Else
			//    imageMain.Source = New BitmapImage(New Uri("images/CubeAnalysis.jpg", UriKind.RelativeOrAbsolute))
			//    imageMain.Stretch = Stretch.Fill
			//    imageMain.Opacity = iOpacity
			//End If
			
			tabSearch.Visibility = Visibility.Collapsed;
			btnOpenRestoreScreen.Visibility = Visibility.Collapsed;
			btnReset.Visibility = Visibility.Collapsed;
			ckShowDetails.Visibility = Visibility.Collapsed;
			hlScheduleSearch.Visibility = Visibility.Collapsed;
			hlAlerts.Visibility = Visibility.Collapsed;
			
			gridPreview.Visibility = System.Windows.Visibility.Collapsed;
			gridTabs.Visibility = System.Windows.Visibility.Collapsed;
			
			dgAttachments.Visibility = Visibility.Collapsed;
			tabSearch.Visibility = Visibility.Collapsed;
			TabEmail.Visibility = Visibility.Collapsed;
			TabContent.Visibility = Visibility.Collapsed;
			//ckFilters.IsChecked = False
			
			ckFilters.Visibility = Visibility.Visible;
			
		}
		
		public void SetActiveStateOfForm()
		{
			
			//imageMain.Visibility = Visibility.Collapsed
			
			tabSearch.Visibility = Visibility.Visible;
			TabEmail.Visibility = Visibility.Visible;
			TabContent.Visibility = Visibility.Visible;
			ckFilters.Visibility = Visibility.Visible;
			
			gridPreview.Visibility = System.Windows.Visibility.Visible;
			gridTabs.Visibility = System.Windows.Visibility.Visible;
			
		}
		
		//Private Sub LayoutRoot_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs) Handles LayoutRoot.KeyDown
		//    If e.Key = Key.F1 Then
		//        Dim cw As New popupHelp()
		//        cw.Show()
		//    End If
		//End Sub
		
		public void hlScheduleSearch_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			if (! GLOBALS._isAdmin)
			{
				MessageBox.Show("Admin rights required to execute this function, please get an ADMIN to set this up.");
				return;
			}
			
			popupScheduelSearch cw = new popupScheduelSearch();
			cw.Show();
		}
		
		public void dgEmails_KeyDown(System.Object sender, System.Windows.Input.KeyEventArgs e)
		{
			if (e.Key == Key.F9)
			{
				PopulateDictMasterSearch();
				popupEmailSearchParms cw = new popupEmailSearchParms(int.Parse(SecureID));
				cw.Closed += new System.EventHandler(handler_PopulateEmailSearchDetailParms_Closed);
				cw.Show();
			}
		}
		
		private void handler_PopulateEmailSearchDetailParms_Closed(object sender, EventArgs e)
		{
			popupEmailSearchParms dlg = (popupEmailSearchParms) sender;
			System.Nullable<bool> result = dlg.DialogResult;
			if (result == true)
			{
				PopulateEmailSearchDetailParms();
			}
			//RemoveHandler handler_PopulateEmailSearchDetailParms_Closed
		}
		
		private void handler_PopulateDictMasterSearch_Closed(object sender, EventArgs e)
		{
			popupContentSearchParms dlg = (popupContentSearchParms) sender;
			System.Nullable<bool> result = dlg.DialogResult;
			if (result == true)
			{
				PopulateContentSearchDetailParms();
			}
		}
		
		public void txtSearch_KeyDown_1(System.Object sender, System.Windows.Input.KeyEventArgs e)
		{
			if (e.Key == Key.F11)
			{
				GenSqlOnly = true;
				btnSubmit_Click(null, null);
			}
			if (e.Key == Key.F12)
			{
				GenSqlOnly = true;
				btnSubmit_Click(null, null);
			}
			if (e.Key == Key.F9)
			{
				frmSearchAsst cw = new frmSearchAsst(int.Parse(SecureID));
				cw.Show();
				return;
			}
			if (e.Key == Key.Enter)
			{
				btnSubmit_Click(null, null);
			}
		}
		
		public void TabContent_GotFocus(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(600, modGlobals.gCurrUserGuidID);
			dgAttachments.Visibility = System.Windows.Visibility.Collapsed;
		}
		
		public void TabEmail_GotFocus(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			COMMON.SaveClick(700, modGlobals.gCurrUserGuidID);
			dgAttachments.Visibility = System.Windows.Visibility.Visible;
		}
		
		public void dgAttachments_DoubleClick(System.Object sender, System.Windows.Input.MouseButtonEventArgs e)
		{
			if (SelectedGrid == "dgEmails")
			{
				COMMON.SaveClick(800, modGlobals.gCurrUserGuidID);
				if (UseISO)
				{
					bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
					if (! bClcRuning)
					{
						SB.Text = "Downloader Not running - preview and restore are disabled.";
						return;
					}
				}
				
				RepoTableName = "EMAILATTACHMENT";
				
				callPreview();
				
			}
			
			SB.Text = (string) ("Preview Requested: " + DateTime.Now.ToString());
		}
		
		public void dgAttachments_MouseEnter(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			SB.Text = "Found in Attachment ?";
			
			try
			{
				if (SelectedGrid == "dgEmails")
				{
					int I = 0;
					DataTable DT = grid.ConvertDataGridToDataTable(dgAttachments);
					foreach (DataRow DR in DT.Rows)
					{
						//Dim col As DataColumn
						int iRowID = DR["RowID"];
						if (iRowID == RID)
						{
							dgAttachments.SelectedIndex = I;
							dgAttachments.Items[I].Selected = true;
							SB.Text = (string) ("Found in Attachment #" + RID.ToString());
							break;
						}
						I++;
					}
				}
			}
			catch (Exception)
			{
				SB.Text = "Could not determine attachment.";
			}
			
		}
		
		public void dgAttachments_MouseLeave(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			if (SelectedGrid == "dgEmails")
			{
				try
				{
					for (int i = 0; i <= dgAttachments.Items.Count - 1; i++)
					{
						dgAttachments.Items[i].Selected = false;
					}
					for (int i = 0; i <= dgAttachments.Items.Count - 1; i++)
					{
						DataGridRow DR = grid.GetRow(dgAttachments, i);
						int iCol = grid.getColumnIndexByName(dgAttachments, "RowID");
						//Dim iRowID As Integer = dgAttachments.SelectedCells.Item(i, "RowID")
						object iRowID = grid.GetCell(dgAttachments, DR, iCol);
						if (Convert.ToInt32(iRowID) == RID)
						{
							dgAttachments.SelectedIndex = System.Convert.ToInt32(null);
							dgAttachments.Items[i].Selected = false;
							break;
						}
					}
				}
				catch (Exception)
				{
					SB.Text = "Could not set Attachment Grid.";
				}
			}
		}
		
		public void AddMasterSearchItem(string sKey, string sVal)
		{
			if (GLOBALS.dictMasterSearch.ContainsKey(sKey))
			{
				GLOBALS.dictMasterSearch.Item(sKey) = sVal;
			}
			else
			{
				GLOBALS.dictMasterSearch.Add(sKey, sVal);
			}
		}
		
		public void PopulateDictMasterSearch()
		{
			//dictMasterSearch
			var ScreenName = "frmQuickSearch";
			var SaveTypeCode = "QUICKSEARCH";
			string UID = CurrUserGuidID;
			string ValName = "";
			string ValValue = "";
			bool B = true;
			
			string txtSelDir = "??";
			bool ckShowDetails = false;
			bool ckCountOnly = false;
			bool ckLimitToExisting = false;
			bool ckBusiness = false;
			bool rbToDefaultDir = false;
			bool rbToOriginalDir = false;
			bool rbToSelDir = false;
			bool ckOverWrite = false;
			
			PopulateEmailSearchDetailParms();
			PopulateContentSearchDetailParms();
			
			foreach (string tempLoopVar_ValName in dictEmailSearch.Keys)
			{
				ValName = tempLoopVar_ValName;
				ValValue = dictEmailSearch[ValName];
				AddDictMasterSearch(ValName, ValValue);
			}
			foreach (string tempLoopVar_ValName in dictContentSearch.Keys)
			{
				ValName = tempLoopVar_ValName;
				ValValue = dictContentSearch[ValName];
				AddDictMasterSearch(ValName, ValValue);
			}
			
			AddDictMasterSearch("CurrUserGuidID", CurrUserGuidID);
			AddDictMasterSearch("CurrLoginID", CurrLoginID);
			
			ValName = "txtSearch";
			ValValue = txtSearch.Text.Trim();
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "txtSelDir";
			//ValValue = txtSelDir
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "cbLibrary";
			ValValue = (string) cbLibrary.SelectedItem;
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "nbrWeightMin";
			ValValue = nbrWeightMin.Text;
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "rbAll";
			ValValue = rbAll.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "rbContent";
			ValValue = rbContent.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "rbEmails";
			ValValue = rbEmails.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			//ValName = "ckShowDetails"
			//ValValue = ckShowDetails.IsChecked.ToString
			//AddDictMasterSearch(valname, ValValue)
			
			ValName = "ckLimitToLib";
			ValValue = ckLimitToLib.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			//ValName = "ckCountOnly"
			//ValValue = ckCountOnly.IsChecked.ToString
			//AddDictMasterSearch(valname, ValValue)
			
			ValName = "ckMyContent";
			ValValue = ckMyContent.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "ckMasterOnly";
			ValValue = ckMasterOnly.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			//ValName = "ckLimitToExisting"
			//AddDictMasterSearch(valname, ValValue)
			
			ValName = "ckWeights";
			ValValue = ckWeights.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			//ValName = "ckBusiness"
			//AddDictMasterSearch(valname, ValValue)
			
			//ValName = "rbToDefaultDir"
			//ValValue = rbToDefaultDir.IsChecked.ToString
			//AddDictMasterSearch(valname, ValValue)
			
			//ValName = "rbToOriginalDir"
			//ValValue = rbToOriginalDir.IsChecked.ToString
			//AddDictMasterSearch(valname, ValValue)
			
			//ValName = "rbToSelDir"
			//ValValue = rbToSelDir.IsChecked.ToString
			//AddDictMasterSearch(valname, ValValue)
			
			//ValName = "ckOverWrite"
			//ValValue = ckOverWrite.IsChecked.ToString
			//AddDictMasterSearch(valname, ValValue)
			
			ValName = "lblMain";
			ValValue = (string) lblMain.Content;
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "ckFilters";
			ValValue = ckFilters.IsChecked.ToString();
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "SBEmail";
			ValValue = SBEmail.Text;
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "SBDoc";
			ValValue = SBDoc.Text;
			AddDictMasterSearch(ValName, ValValue);
			
			ValName = "SB";
			ValValue = SB.Text;
			AddDictMasterSearch(ValName, ValValue);
		}
		public void AddDictMasterSearch(string tKey, string tVal)
		{
			if (GLOBALS.dictMasterSearch.ContainsKey(tKey))
			{
				GLOBALS.dictMasterSearch.Item(tKey) = tVal;
			}
			else
			{
				GLOBALS.dictMasterSearch.Add(tKey, tVal);
			}
		}
		
		public void PopulateEmailSearchDetailParms()
		{
			//'Dim B As Boolean = ISO.ReadDetailSearchParms("EMAIL", dictEmailSearch)
			//'If Not B Then
			//'    SB.Text = "ERROR PopulateEmailSearchDetailParms: failed to load email detailed search parms"
			//'Else
			//For Each sKey As String In dictMasterSearch.Keys
			//    Dim tKey As String = sKey
			//    Dim tVal As String = ""
			//    'tVal = dictEmailSearch.Item(sKey).ToString
			//    tVal = dictMasterSearch.Item(sKey).ToString
			//    UdpateSearchTerm("EPARM", tKey, tVal, "S")
			//Next
			//'End If
			for (int I = 0; I <= GLOBALS.dictMasterSearch.Count - 1; I++)
			{
				//Dim tKey As String = sKey
				string tKey = (string) (GLOBALS.dictMasterSearch.Keys(I));
				string tVal = (string) (GLOBALS.dictMasterSearch.Item(tKey));
				//tVal = dictMasterSearch.Item(sKey).ToString
				UdpateSearchTerm("EPARM", tKey, tVal, "S");
			}
		}
		
		public void PopulateContentSearchDetailParms()
		{
			//Dim B As Boolean = ISO.ReadDetailSearchParms("CONTENT", dictContentSearch)
			//If Not B Then
			//    SB.Text = "ERROR PopulateContentSearchDetailParms: failed to load content detailed search parms"
			//Else
			//For Each sKey As String In dictMasterSearch.Keys
			for (int I = 0; I <= GLOBALS.dictMasterSearch.Count - 1; I++)
			{
				//Dim tKey As String = sKey
				string tKey = (string) (GLOBALS.dictMasterSearch.Keys(I));
				string tVal = (string) (GLOBALS.dictMasterSearch.Item(tKey));
				//tVal = dictMasterSearch.Item(sKey).ToString
				UdpateSearchTerm("CPARM", tKey, tVal, "S");
			}
			//End If
		}
		
		public void Page_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			//SearchHistorySave()
			
			GLOBALS.ProxySearch.SetSAASStateAsync(GLOBALS._SecureID, GLOBALS._UserGuid, "SAAS_STATE", "INACTIVE");
			
			ISO.PreviewFileZeroize();
			//Dim B As Boolean = ISO.DeleteClcReadyStatus()
			//If B Then
			//    Console.WriteLine("RDY Status removed.")
			//Else
			//    Console.WriteLine("Failed to removed RDY Status .")
			//End If
			COMMON.SaveClick(999991, GLOBALS._UserGuid);
		}
		
		public void Page_GotFocus(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			//ISO.SetCLC_State2(CurrLoginID, "IDENTIFIED")
		}
		
		public void dgContent_GotFocus(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			ckClcActive();
		}
		
		public void App_Exit(object o, EventArgs e)
		{
			//************************************************
			// The application is about to stop running.
			// Perform needed cleanup.
			//************************************************
			bool bDeleteRdyStatus = false;
			if (bDeleteRdyStatus)
			{
				bool B = ISO.DeleteClcReadyStatus();
				if (B)
				{
					Console.WriteLine("RDY Status removed.");
				}
				else
				{
					Console.WriteLine("Failed to removed RDY Status .");
				}
			}
		}
		
		public void imgDbInfo_MouseEnter(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			PrevText = "";
			PrevText = SB.Text;
			SB.Text = (string) lblDbInstance.Content;
			
			GLOBALS.ProxySearch.getServerDatabaseNameCompleted += new System.EventHandler(client_getServerDatabaseName);
			GLOBALS.ProxySearch.getServerDatabaseNameAsync(SecureID);
			
		}
		public void client_getServerDatabaseName(object sender, SVCSearch.getServerDatabaseNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				SB.Text = (string) (e.Result + " / " + GLOBALS._UserGuid);
			}
			else
			{
				SB.Text += (string) (" no db name found / " + GLOBALS._UserGuid);
			}
		}
		
		public void imgDbInfo_MouseLeave(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			SB.Text = PrevText;
		}
		
		public void hlGenSql_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			object ObjListOfSearchTerms = new List<SVCSearch.DS_SearchTerms>();
			popupReviewSearchParms cw = new popupReviewSearchParms(ObjListOfSearchTerms);
			cw.Show();
			
		}
		
		public void ShowContentSearchParms()
		{
			string Msg = "";
			string sVal = "";
			foreach (string S in dictContentSearch.Keys)
			{
				Msg += S + " : " + dictContentSearch[S] + "\r\n";
			}
			MessageBox.Show(Msg, "Content Search Parms", MessageBoxButton.OK);
		}
		
		public void ShowEmailSearchParms()
		{
			string Msg = "";
			string sVal = "";
			foreach (string S in dictEmailSearch.Keys)
			{
				Msg += S + " : " + dictEmailSearch[S] + "\r\n";
			}
			MessageBox.Show(Msg, "Email Search Parms", MessageBoxButton.OK);
		}
		
		public void HyperlinkButton2_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			RunExporter();
		}
		
		public void RunExporter()
		{
			if (CurrentlySelectedGrid.ToUpper().Equals("CONTENT"))
			{
				popupExportSearchGrid cw = new popupExportSearchGrid(dgContent);
				cw.Show();
			}
			else
			{
				popupExportSearchGrid cw = new popupExportSearchGrid(dgEmails);
				cw.Show();
			}
		}
		
		public void hlDownLoadCLC_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			SB.Text = ClcURL;
			//System.Windows.Browser.HtmlPage.PopupWindow(New Uri(ClcURL, UriKind.Absolute), "_blank", Nothing)
			Process.Start(ClcURL);
			
		}
		//Sub client_getClcURL(ByVal sender As Object, ByVal e As SVCSearch.getClcURLCompletedEventArgs)
		//    If e.Error Is Nothing Then
		//        If e.Result.Trim.Length > 0 Then
		//            '"http://www.EcmLibrary.com/ECMSaaS/ClcDownloader/publish.htm"
		//            Dim NewURI As String = e.Result
		//            SB.Text = "Download CLC"
		//            System.Windows.Browser.HtmlPage.PopupWindow(New Uri(NewURI), "_blank", Nothing)
		//            SB.Text = ""
		//        Else
		//            SB.Text = "Failure to save " + ParmName
		//        End If
		//    Else
		//        SB.Text = "Failure to save " + ParmName + e.Error.Message
		//    End If
		//End Sub
		
		public void getStaticVars()
		{
			
			SecureID = GLOBALS._SecureID.ToString();
			CompanyID = GLOBALS._CompanyID;
			RepoID = GLOBALS._RepoID;
			modGlobals.gCurrUserGuidID = GLOBALS._UserID;
			CurrSessionGuid = GLOBALS._ActiveGuid;
			EncryptPW = GLOBALS._EncryptPW;
			
		}
		
		public void SaveActiveParm(string ParmName, string ParmVal)
		{
			GLOBALS.ProxySearch.ActiveSessionCompleted += new System.EventHandler(client_ActiveSession);
			GLOBALS.ProxySearch.ActiveSessionAsync(SecureID, CurrSessionGuid, ParmName, ParmVal);
		}
		public void client_ActiveSession(object sender, SVCSearch.ActiveSessionCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result)
				{
				}
				else
				{
					SB.Text = (string) ("Failure to save " + ParmName);
				}
			}
			else
			{
				SB.Text = (string) ("Failure to save " + ParmName + e.Error.Message);
			}
		}
		
		public void GetGlobalVars()
		{
			getActiveSessionGetVal("CompanyID");
			getActiveSessionGetVal("RepoID");
			getActiveSessionGetVal("LoginID");
			getActiveSessionGetVal("EncryptPW");
		}
		
		public void getActiveSessionGetVal(string ParmName)
		{
			GLOBALS.ProxySearch.ActiveSessionGetValCompleted += new System.EventHandler(client_ActiveSessionGetVal);
			GLOBALS.ProxySearch.ActiveSessionGetValAsync(SecureID, CurrSessionGuid, ParmName);
		}
		public void client_ActiveSessionGetVal(object sender, SVCSearch.ActiveSessionGetValCompletedEventArgs e)
		{
			string pVal = "";
			string pName = "";
			if (e.Error == null)
			{
				pVal = (string) e.Result;
				pName = (string) e.ParmName;
				if (pName.Equals("CompanyID"))
				{
					CompanyID = pVal;
				}
				if (pName.Equals("RepoID"))
				{
					RepoID = pVal;
				}
				if (pName.Equals("LoginID"))
				{
					LoginID = pVal;
				}
				if (pName.Equals("EncryptPW"))
				{
					EncryptPW = pVal;
				}
			}
			else
			{
				SB.Text = (string) e.Error.Message;
			}
		}
		
		public void HyperlinkButton3_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			SB.Text = (string) ("Processing " + ArchiverURL);
			//System.Windows.Browser.HtmlPage.PopupWindow(New Uri(ArchiverURL, UriKind.Absolute), "_blank", Nothing)
			Process.Start(ArchiverURL);
			
		}
		
		private void dgContent_ScrollPositionChanging(System.Object sender, ScrollChangedEventArgs e)
		{
			
			if (bGhostFetchActive)
			{
				return;
			}
			
			//Dim scrollview As ScrollViewer = FindVisualChild < ScrollViewer > (dgContent)
			int nTotalCount = dgContent.Items.Count;
			int nFirstVisibleRow = (int) e.HorizontalChange;
			int nLastVisibleRow = nFirstVisibleRow + nTotalCount - e.ViewportHeight;
			
			if (e.VerticalChange != 0)
			{
				//If dgContent.ViewRange.TopRow < ContentTriggerRow Then
				if (nFirstVisibleRow < ContentTriggerRow)
				{
					return;
				}
				
				bEmailScrolling = false;
				bContentScrolling = true;
				
				EmailLowerPageNbr += int.Parse(nbrDocRows.Text);
				EmailUpperPageNbr += int.Parse(nbrDocRows.Text);
				DocLowerPageNbr += int.Parse(nbrDocRows.Text);
				DocUpperPageNbr += int.Parse(nbrDocRows.Text);
				
				bStartNewSearch = false;
				
				ScrollBar sbar = grid.GetScrollbar(dgContent, "dgContent");
				double CurrPos = grid.getScrollBarCurrentPosition(dgContent, "dgContent");
				
				//Dim TopRow As Integer = dgContent.ViewRange.TopRow
				double VPH = e.ViewportHeight;
				double OS = e.VerticalOffset;
				TopRow = (int) CurrPos;
				int BottomRow = dgContent.Items.Count;
				double CurrRow = OS + VPH;
				
				//Dim PctLocation As Double = (1 - (CurrRow / BottomRow)) * 100
				
				double PctLocation = grid.getScrollBarCurrentPct(dgContent, "dgContent");
				
				SBDocPage.Text = (string) ("Rows " + TopRow.ToString() + " - " + BottomRow.ToString());
				
				int TotalRows = dgContent.Items.Count;
				//If TopRow > TotalRows - (TotalRows - 30) Then
				if (PctLocation > 80)
				{
					SB.Text = "Fetching more documents...";
					ExecuteSearch(false, "ScrollChange");
					bGhostFetchActive = true;
				}
				else
				{
					SB.Text = (string) ("Content: " + CurrRow.ToString() + " : " + PctLocation.ToString());
				}
			}
			
		}
		
		public void hlFindCLC_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
			if (! bClcRuning)
			{
				SB.Text = "Downloader Not running - preview and restore are disabled.";
				//lblClcState.Visibility = Windows.Visibility.Visible
				lblClcState.Content = "Downloader Not running";
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
				return;
			}
			else
			{
				lblClcState.Visibility = System.Windows.Visibility.Collapsed;
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
		}
		
		public void hlUsers_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			COMMON.SaveClick(400, modGlobals.gCurrUserGuidID);
			PageUsers NextPage = new PageUsers();
			this.Content = NextPage;
		}
		
		public void hlGroups_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			COMMON.SaveClick(500, GLOBALS._UserGuid);
			PageGroup NextPage = new PageGroup();
			this.Content = NextPage;
		}
		
		public void PerformSearch(bool bStartNewSearch)
		{
			COMMON.SaveClick(200, GLOBALS._UserGuid);
			
			bStartNewSearch = true;
			
			SetActiveStateOfForm();
			
			GLOBALS.gListOfContent.Clear();
			GLOBALS.gListOfEmails.Clear();
			
			//dgContent.ItemsSource = Nothing
			//dgEmails.ItemsSource = Nothing
			
			dgEmails.Opacity = 0.5;
			
			btnSubmit.Visibility = Visibility.Collapsed;
			PB.Visibility = Visibility.Visible;
			PB.IsIndeterminate = true;
			
			string TempStr = txtSearch.Text;
			
			UTIL.RemoveUnwantedCharacters(txtSearch.Text);
			txtSearch.Text = UTIL.RemoveSingleQuotes(txtSearch.Text, ckWeights.IsChecked);
			
			if (ckLimitToLib.IsChecked && cbLibrary.SelectedValue == "")
			{
				ckLimitToLib.IsChecked = false;
			}
			
			qStart = DateTime.Now;
			
			//If txtSearch.Text.Trim.Length = 0 Then
			//    SB.Text = "Search criteria missing, returning."
			//    Return
			//End If
			
			//Dim MachineName$ = DMA.GetCurrMachineName
			//Dim IP$ = DMA.getIpAddr
			//gIpAddr = IP$
			//gMachineID = MachineName$
			
			modGlobals.bIncludeLibraryFilesInSearch = false;
			//ZeroizeGlobalSearch()
			
			//*************************************************************
			CurrentSearchIdHigh++;
			DoNotGetSearchHistory = true;
			//lblMain.Content = CurrentSearchIdHigh
			if (CurrentSearchIdHigh > PageRowLimit)
			{
				CurrentSearchIdHigh = 1;
				lblMain.Content = "1";
			}
			DoNotGetSearchHistory = false;
			if (CurrentSearchIdHigh > PageRowLimit)
			{
				CurrentSearchIdHigh = 1;
				lblMain.Content = "1";
			}
			
			if (! GenSqlOnly)
			{
				SaveSearchParmParms(CurrentSearchIdHigh);
			}
			
			//*************************************************************
			ExecuteSearch(GenSqlOnly, "PerformSearch");
			//**********************************
			
			bGridColsRetrieved = false;
			
			if (ckWeights.IsChecked)
			{
				GetAttachmentWeights();
			}
			
			int AttachmentCount = GetAttachmentCount();
			
			qEnd = DateTime.Now;
			
			SortGrid(true.ToString());
			
			CB_SQL = "";
			
			SBEmailPage.Text = (string) ("Rows:" + EmailLowerPageNbr.ToString() + " thru " + dgEmails.Items.Count);
			SBDocPage.Text = (string) ("Rows:" + DocLowerPageNbr.ToString() + " thru " + dgContent.Items.Count);
			
			string T = modGlobals.ElapsedTime(qStart, qEnd);
			//txtSearch.Text = TempStr
			
			//SB.Text = SB.Text = +" : " + T + "(sec)"
			//wdmxx
			//If GenSqlOnly Then
			//    Dim cw As New popSqlStmt(ClipBoardSql)
			//    cw.Show()
			//    SB.Text = "SQL in clipboard - ET: " + T
			//End If
			
			//imageMain.Visibility = Windows.Visibility.Collapsed
		}
		
		public void CreateEmailGridColumns()
		{
			if (dgEmails.Columns.Count == 0)
			{
				AddEmailGridColumn("AllRecipients");
				AddEmailGridColumn("Bcc");
				AddEmailGridColumn("Body");
				AddEmailGridColumn("CC");
				AddEmailGridColumn("CreationTime");
				AddEmailGridColumn("EmailGuid");
				AddEmailGridColumn("FoundInAttach");
				AddEmailGridColumn("isPublic");
				AddEmailGridColumn("MsgSize");
				AddEmailGridColumn("NbrAttachments");
				AddEmailGridColumn("OriginalFolder");
				AddEmailGridColumn("RANK");
				AddEmailGridColumn("ReceivedByName");
				AddEmailGridColumn("ReceivedTime");
				AddEmailGridColumn("RepoSvrName");
				AddEmailGridColumn("RetentionExpirationDate");
				AddEmailGridColumn("RID");
				AddEmailGridColumn("ROWID");
				AddEmailGridColumn("SenderEmailAddress");
				AddEmailGridColumn("SenderName");
				AddEmailGridColumn("SentOn");
				AddEmailGridColumn("SentTO");
				AddEmailGridColumn("ShortSubj");
				AddEmailGridColumn("SourceTypeCode");
				AddEmailGridColumn("SUBJECT");
				AddEmailGridColumn("UserID");
			}
		}
		public void AddEmailGridColumn(string ColName)
		{
			DataGridColumn NewCol = null;
			NewCol.Header = ColName;
			dgEmails.Columns.Add(NewCol);
		}
		public void CreateContentGridColumns()
		{
			if (dgContent.Columns.Count == 0)
			{
				AddContentGridColumn("CreateDate");
				AddContentGridColumn("DataSourceOwnerUserID");
				AddContentGridColumn("FileDirectory");
				AddContentGridColumn("FileLength");
				AddContentGridColumn("FQN");
				AddContentGridColumn("isMaster");
				AddContentGridColumn("isPublic");
				AddContentGridColumn("LastAccessDate");
				AddContentGridColumn("LastWriteTime");
				AddContentGridColumn("OriginalFileType");
				AddContentGridColumn("RANK");
				AddContentGridColumn("RepoSvrName");
				AddContentGridColumn("RetentionExpirationDate");
				AddContentGridColumn("ROWID");
				AddContentGridColumn("SourceGuid");
				AddContentGridColumn("SourceName");
				AddContentGridColumn("StructuredData");
				AddContentGridColumn("VersionNbr");
			}
		}
		public void AddContentGridColumn(string ColName)
		{
			DataGridColumn NewCol = null;
			NewCol.Header = ColName;
			dgContent.Columns.Add(NewCol);
		}
		
		private void UpdateState(bool loading, int EmailStartRow, int EmailEndRow, int ContentStartRow, int ContentEndRow)
		{
			if (loading)
			{
				//SBEmail.Text = String.Format("Retrieving rows {0} to {1}...", EmailStartRow, EmailEndRow)
				//SBDoc.Text = String.Format("Retrieving rows {0} to {1}...", ContentStartRow, ContentEndRow)
				
				SBEmail.Text = string.Format("Retrieving rows {0} to {1}...", EmailStartRow, EmailStartRow + 25);
				SBDoc.Text = string.Format("Retrieving rows {0} to {1}...", ContentStartRow, ContentStartRow + 25);
				
				SB.Text = "Fetching data";
				_loading = true;
			}
			else
			{
				_loading = false;
				SBEmail.Text = "Ready";
				SBDoc.Text = "Ready";
				SB.Text = "Ready";
			}
		}
		
		public void dgContent_MouseEnter(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			//SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
			//SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
			SelectedGrid = "dgContent";
		}
		
		public void setAuthority()
		{
			
			GLOBALS.ProxySearch.getUserAuthCompleted += new System.EventHandler(client_getUserAuth);
			GLOBALS.ProxySearch.getUserAuthAsync(SecureID, GLOBALS.UserID);
		}
		public void client_getUserAuth(object sender, SVCSearch.getUserAuthCompletedEventArgs e)
		{
			
			GLOBALS._isAdmin = false;
			GLOBALS._isSuperAdmin = false;
			GLOBALS._isGlobalSearcher = false;
			
			if (e.Error == null)
			{
				string Auth = (string) e.Result.ToUpper;
				if (Auth.Equals("A"))
				{
					GLOBALS._isAdmin = true;
					GLOBALS._isGlobalSearcher = true;
				}
				else
				{
					GLOBALS._isSuperAdmin = false;
					GLOBALS._isAdmin = false;
				}
				if (Auth.Equals("S"))
				{
					GLOBALS._isSuperAdmin = true;
					GLOBALS._isAdmin = true;
					GLOBALS._isGlobalSearcher = true;
				}
				else
				{
					GLOBALS._isSuperAdmin = false;
				}
				if (Auth.Equals("G"))
				{
					GLOBALS._isGlobalSearcher = true;
					GLOBALS._isAdmin = false;
					GLOBALS._isSuperAdmin = false;
				}
			}
			else
			{
				SB.Text = (string) e.Error.Message;
			}
			
			UdpateSearchTerm("ALL", "isSuperAdmin", GLOBALS._isSuperAdmin.ToString(), "B");
			UdpateSearchTerm("ALL", "isAdmin", GLOBALS._isAdmin.ToString(), "B");
			UdpateSearchTerm("ALL", "isGlobalSearcher", GLOBALS._isGlobalSearcher.ToString(), "B");
			
			if (GLOBALS._isAdmin == true)
			{
				linkGenSql.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				linkGenSql.Visibility = System.Windows.Visibility.Collapsed;
			}
			
		}
		
		public void client_SetSAASState(object sender, SVCSearch.SetSAASStateCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				SB.Text = "SAAS State Set.";
			}
			else
			{
				SB.Text = "Failed to set SAAS State.";
			}
		}
		~MainPage()
		{
			//SB.Text = "Standby, securing connection closure."
			//_c1SpellChecker.UserDictionary.SaveToIsolatedStorage("Custom.dct")
			
			base.Finalize(); //define the destructor
			GLOBALS.ProxySearch.getSystemParmCompleted -= new System.EventHandler(client_LoadSystemParameters);
			//RemoveHandler Application.Current.Exit, AddressOf App_Exit
			GLOBALS.ProxySearch.getAttachmentWeightsCompleted -= new System.EventHandler(client_getAttachmentWeights);
			GLOBALS.ProxySearch.ExecuteSearchCompleted -= new System.EventHandler(client_ExecuteSearch);
			proxy2.getDatasourceParmCompleted -= new System.EventHandler(client_getDatasourceParmTitle);
			GLOBALS.ProxySearch.GetEmailAttachmentsCompleted -= new System.EventHandler(client_GetEmailAttachments);
			GLOBALS.ProxySearch.saveSearchStateCompleted -= new System.EventHandler(client_saveSearchState);
			GLOBALS.ProxySearch.getSearchStateCompleted -= new System.EventHandler(client_getSearchState);
			GLOBALS.ProxySearch.saveGridLayoutCompleted -= new System.EventHandler(client_saveGridLayout);
			GLOBALS.ProxySearch.getGridLayoutCompleted -= new System.EventHandler(client_getEmailGridLayout);
			GLOBALS.ProxySearch.getGridLayoutCompleted -= new System.EventHandler(client_getContentGridLayout);
			GLOBALS.ProxySearch.getGridLayoutCompleted -= new System.EventHandler(client_getContentGridLayout);
			GLOBALS.ProxySearch.SetSAASStateCompleted -= new System.EventHandler(client_SetSAASState);
			//RemoveHandler ProxySearch.saveRestoreFileCompleted, AddressOf client_saveRestoreFile
			GLOBALS.ProxySearch.scheduleFileDownLoadCompleted -= new System.EventHandler(client_scheduleFileDownLoad);
			GLOBALS.ProxySearch.GetFilesInZipCompleted -= new System.EventHandler(client_GetFilesInZip);
			GLOBALS.ProxySearch.PopulateGroupUserLibComboCompleted -= new System.EventHandler(client_PopulateGroupUserLibCombo);
			try
			{
				GLOBALS.ProxySearch.AddLibraryItemsCompleted -= new System.EventHandler(client_AddLibraryItems);
			}
			catch (Exception)
			{
				Console.WriteLine("XXX-1245");
			}
			GLOBALS.ProxySearch.SaveUserSearchCompleted -= new System.EventHandler(client_SearchHistorySave);
			GLOBALS.ProxySearch.ckContentFlagsCompleted -= new System.EventHandler(client_ckContentFlagsCompleted);
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		private void click_ContentSearchParms(object sender, RoutedEventArgs e)
		{
			PopulateDictMasterSearch();
			popupContentSearchParms cw = new popupContentSearchParms(int.Parse(SecureID), GLOBALS.dictMasterSearch);
			cw.Closed += new System.EventHandler(handler_PopulateDictMasterSearch_Closed);
			cw.Show();
		}
		private void click_EmailSearchParms(object sender, RoutedEventArgs e)
		{
			PopulateDictMasterSearch();
			popupEmailSearchParms cw = new popupEmailSearchParms(int.Parse(SecureID));
			cw.Closed += new System.EventHandler(handler_PopulateEmailSearchDetailParms_Closed);
			cw.Show();
		}
		private void click_EmailColDisplayOrder(object sender, RoutedEventArgs e)
		{
			
			SaveGridColumnOrder(dgEmails, ref dictEmailGridColDisplayOrder);
			
			SaveGridLayoutToDB(dgEmails);
			SaveGridLayoutToDB(dgContent);
			
		}
		private void click_ContentColDisplayOrder(object sender, RoutedEventArgs e)
		{
			
			SaveGridColumnOrder(dgContent, ref dictContentGridColDisplayOrder);
			
			SaveGridLayoutToDB(dgContent);
			SaveGridLayoutToDB(dgEmails);
			
		}
		
		private void CopyStream(Stream loadStream, Stream saveStream)
		{
			const int bufferSize = 1024 * 1024;
			byte[] buffer = new byte[bufferSize - 1+ 1];
			int count = 0;
			while (count == loadStream.Read(buffer, 0, System.Convert.ToInt32(bufferSize)) > 0)
			{
				saveStream.Write(buffer, 0, count);
			}
		}
		
		private void click_EmailPrint(object sender, RoutedEventArgs e)
		{
			
			RunExporter();
			GC.Collect();
			
		}
		private void click_EmailColSortOrder(object sender, RoutedEventArgs e)
		{
			SaveGridColumnOrder(dgEmails, ref dictEmailGridColDisplayOrder);
			//SaveGridLayoutToDB(dgEmails)
		}
		private void click_ContentColSortOrder(object sender, RoutedEventArgs e)
		{
			SaveGridColumnOrder(dgContent, ref dictContentGridColDisplayOrder);
			//SaveGridLayoutToDB(dgEmails)
		}
		private void click_ExportSearchResults(object sender, RoutedEventArgs e)
		{
			RunExporter();
			GC.Collect();
		}
		private void click_EmailPreview(object sender, RoutedEventArgs e)
		{
			if (UseISO)
			{
				bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
				if (! bClcRuning)
				{
					SB.Text = "Downloader Not running - preview and restore are disabled.";
					//lblClcState.Visibility = Windows.Visibility.Visible
					lblClcState.Content = "Downloader Not running";
					btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
					return;
				}
				else
				{
					lblClcState.Visibility = System.Windows.Visibility.Collapsed;
					btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
				}
			}
			callPreview();
			SB.Text = (string) ("Preview Requested: " + DateTime.Now.ToString());
		}
		private void click_EmailRestore(object sender, RoutedEventArgs e)
		{
			if (UseISO)
			{
				COMMON.SaveClick(10001, modGlobals.gCurrUserGuidID);
				if (RepoTableName.Equals("EmailAttachment"))
				{
					MessageBox.Show("Sorry, an attachment is an \'embedded\' component of an email." + "\r\n" + "Therefore, the entire email must be restored - not just the attachment.");
					return;
				}
				bool bClcRuning = ISO.isClcActive(CurrUserGuidID);
				if (! bClcRuning)
				{
					SB.Text = "Downloader Not running - preview and restore are disabled.";
					//lblClcState.Visibility = Windows.Visibility.Visible
					lblClcState.Content = "Downloader Not running";
					btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
					return;
				}
				else
				{
					lblClcState.Visibility = System.Windows.Visibility.Collapsed;
					btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
				}
			}
			SB.Text = (string) ("Download Requested: " + DateTime.Now.ToString());
			//Dim ISO As New clsIsolatedStorage
			frmContentRestore NextPage = new frmContentRestore(RepoTableName, dgEmails, dgAttachments, dgContent);
			NextPage.Show();
		}
		
		//Private Sub click_DictLoadCompleted(ByVal sender As Object, ByVal e As OpenReadCompletedEventArgs)
		//    If e.Error Is Nothing Then
		//        SB.Text = "Dictionary Loaded: " & _c1SpellChecker.MainDictionary.WordCount & " words."
		//        Console.WriteLine("Dictionary Loaded: " & _c1SpellChecker.MainDictionary.WordCount & " words.")
		//    Else
		//        Console.WriteLine("Failed to load spell check dictionary." + vbCrLf + vbCrLf + e.Error.Message)
		//    End If
		//End Sub
		
		private void click_SearchAsst(object sender, RoutedEventArgs e)
		{
			SB.Text = "Search Assistant";
			frmSearchAsst NextPage = new frmSearchAsst(GLOBALS._SecureID);
			NextPage.Closed += new System.EventHandler(Handler_frmSearchAsst_closed);
			NextPage.Show();
		}
		
		//Private Sub click_SpellCheck(ByVal sender As Object, ByVal e As RoutedEventArgs)
		//    AddHandler _c1SpellChecker.CheckControlCompleted, AddressOf SpellCK_Completed
		//    _c1SpellChecker.CheckControlAsync(txtSearch, False, SpellDLG)
		//End Sub
		
		//********************************************************************************************************
		//********************************************************************************************************
		public void click_GenContentSQL(object sender, RoutedEventArgs e)
		{
			
			UdpateSearchTerm("ALL", "isSuperAdmin", GLOBALS._isSuperAdmin.ToString(), "B");
			UdpateSearchTerm("ALL", "isAdmin", GLOBALS._isAdmin.ToString(), "B");
			UdpateSearchTerm("ALL", "isGlobalSearcher", GLOBALS._isGlobalSearcher.ToString(), "B");
			
			UdpateSearchTerm("ALL", "CalledFromScreen", this.Title, "S");
			UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S");
			
			UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim(), "S");
			UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim(), "S");
			UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim(), "S");
			
			UdpateSearchTerm("ALL", "txtSearch", txtSearch.Text.Trim(), "S");
			UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString(), "B");
			UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "cbLibrary", (string) cbLibrary.SelectedItem, "S");
			UdpateSearchTerm("ALL", "MinWeight", MinWeight.ToString(), "I");
			UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString(), "I");
			UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString(), "I");
			UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I");
			UdpateSearchTerm("ALL", "StartingContentRow", "0", "I");
			
			string SelectedLib = "";
			if (cbLibrary.SelectedIndex > -0)
			{
				SelectedLib = cbLibrary.SelectedValue.ToString();
			}
			
			int iMaxRows = 0;
			if (DocUpperPageNbr > EmailUpperPageNbr)
			{
				iMaxRows = DocUpperPageNbr;
			}
			else
			{
				iMaxRows = EmailUpperPageNbr;
			}
			if (iMaxRows == 0)
			{
				iMaxRows = PageRowLimit;
			}
			
			GLOBALS.ProxySearch.GenContentSearchSQLCompleted += new System.EventHandler(client_GenDocSearchSql);
			GLOBALS.ProxySearch.GenContentSearchSQLAsync(iMaxRows, modGlobals.gCurrUserGuidID, ListOfSearchTerms.ToArray, SecureID, GLOBALS._UserGuid, txtSearch.Text, false, "", "", ckLimitToLib.IsChecked, SelectedLib, ckWeights.IsChecked);
			
		}
		
		public void client_GenDocSearchSql(object sender, SVCSearch.GenContentSearchSQLCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				popSqlStmt cw = new popSqlStmt((string) e.Result);
				cw.Show();
			}
			else
			{
				MessageBox.Show((string) ("Error generating SQL : " + e.Error.Message));
			}
			GLOBALS.ProxySearch.GenContentSearchSQLCompleted -= new System.EventHandler(client_GenDocSearchSql);
		}
		
		//********************************************************************************************************
		public void click_GenEmailSQLStmt(object sender, RoutedEventArgs e)
		{
			
			UdpateSearchTerm("ALL", "isSuperAdmin", GLOBALS._isSuperAdmin.ToString(), "B");
			UdpateSearchTerm("ALL", "isAdmin", GLOBALS._isAdmin.ToString(), "B");
			UdpateSearchTerm("ALL", "isGlobalSearcher", GLOBALS._isGlobalSearcher.ToString(), "B");
			
			UdpateSearchTerm("ALL", "CalledFromScreen", this.Title, "S");
			UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S");
			
			UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim(), "S");
			UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim(), "S");
			UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim(), "S");
			
			UdpateSearchTerm("ALL", "txtSearch", txtSearch.Text.Trim(), "S");
			UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString(), "B");
			UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString(), "B");
			UdpateSearchTerm("ALL", "cbLibrary", (string) cbLibrary.SelectedItem, "S");
			UdpateSearchTerm("ALL", "MinWeight", MinWeight.ToString(), "I");
			UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString(), "I");
			UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString(), "I");
			UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I");
			UdpateSearchTerm("ALL", "StartingContentRow", "0", "I");
			
			string SelectedLib = "";
			if (cbLibrary.SelectedIndex > -0)
			{
				SelectedLib = cbLibrary.SelectedValue.ToString();
			}
			
			int iMaxRows = 0;
			if (DocUpperPageNbr > EmailUpperPageNbr)
			{
				iMaxRows = DocUpperPageNbr;
			}
			else
			{
				iMaxRows = EmailUpperPageNbr;
			}
			if (iMaxRows == 0)
			{
				iMaxRows = PageRowLimit;
			}
			
			GLOBALS.ProxySearch.GenEmailGeneratedSQLCompleted += new System.EventHandler(client_GenEmailGeneratedSQL);
			GLOBALS.ProxySearch.GenEmailGeneratedSQLAsync(iMaxRows, modGlobals.gCurrUserGuidID, ListOfSearchTerms.ToArray, SecureID);
		}
		public void client_GenEmailGeneratedSQL(object sender, SVCSearch.GenEmailGeneratedSQLCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				popSqlStmt cw = new popSqlStmt((string) e.Result);
				cw.Show();
			}
			else
			{
				MessageBox.Show((string) ("Error generating SQL : " + e.Error.Message));
			}
			GLOBALS.ProxySearch.GenEmailGeneratedSQLCompleted -= new System.EventHandler(client_GenEmailGeneratedSQL);
		}
		//********************************************************************************************************
		private void click_GenAttachmentSQL(object sender, RoutedEventArgs e)
		{
			string ContainsClause = "";
			bool isEmail = true;
			GLOBALS.ProxySearch.GenEmailAttachmentsGeneratedSQLCompleted += new System.EventHandler(client_GenEmailAttachmentsGeneratedSQL);
			GLOBALS.ProxySearch.GenEmailAttachmentsGeneratedSQLAsync(GLOBALS._UserGuid, ListOfSearchTerms.ToArray, SecureID, txtSearch.Text, false, ckWeights.IsChecked, isEmail, false, null, "", "", "MainPage");
		}
		public void client_GenEmailAttachmentsGeneratedSQL(object sender, SVCSearch.GenEmailAttachmentsGeneratedSQLCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				popSqlStmt cw = new popSqlStmt((string) e.Result);
				cw.Show();
			}
			else
			{
				MessageBox.Show((string) ("Error generating SQL : " + e.Error.Message));
			}
			GLOBALS.ProxySearch.GenEmailAttachmentsGeneratedSQLCompleted -= new System.EventHandler(client_GenEmailAttachmentsGeneratedSQL);
		}
		//********************************************************************************************************
		private void click_ReviewSearchParms(object sender, RoutedEventArgs e)
		{
			string S = "";
			string tKey = "";
			string tVal = "";
			
			foreach (string sKey in GLOBALS.dictMasterSearch.Keys)
			{
				tKey = sKey;
				if (GLOBALS.dictMasterSearch.ContainsKey(tKey))
				{
					tVal = (string) (GLOBALS.dictMasterSearch.Item(tKey));
				}
				else
				{
					GLOBALS.dictMasterSearch.Add(tKey, tVal);
				}
				
				S += tKey + " / " + tVal + "\r\n";
			}
			
			//For I As Integer = 0 To ListOfSearchTerms.Count - 1
			//    tKey = ListOfSearchTerms.Item(I).Term
			//    tVal = ListOfSearchTerms.Item(I).TermVal
			//    S += tKey + " / " + tVal + vbCrLf
			//Next
			popSqlStmt cw = new popSqlStmt(S);
			cw.Show();
		}
		
		//********************************************************************************************************
		//********************************************************************************************************
		
		//Private Sub SpellCK_Completed(ByVal sender As Object, ByVal e As CheckControlCompletedEventArgs)
		//    Console.WriteLine("Spell check completed: {0} errors found.", e.ErrorCount)
		//    SB.Text = "Spell check completed: " & e.ErrorCount & " errors found - State: " & _c1SpellChecker.MainDictionary.State & "."
		//    Dim xTxt As String = SB.Text
		//    If e.Cancelled Then
		//        SB.Text = "Spell check cancelled."
		//    End If
		//    RemoveHandler _c1SpellChecker.CheckControlCompleted, AddressOf SpellCK_Completed
		//End Sub
		
		public void cbLibrary_SelectionChanged(System.Object sender, System.Windows.Controls.SelectionChangedEventArgs e)
		{
			COMMON.SaveClick(10002, modGlobals.gCurrUserGuidID);
			string LibraryName = (string) cbLibrary.SelectedItem;
			
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "LibraryName", LibraryName, "S");
			
			GLOBALS.ProxySearch.GetLibOwnerByNameCompleted += new System.EventHandler(client_GetLibOwnerByName);
			GLOBALS.ProxySearch.GetLibOwnerByNameAsync(SecureID, LibraryName);
		}
		
		public void ReorderEmailGridCols()
		{
			
			int QuestionNumber = 0;
			string QuestionText = "";
			int QuestionID = 0;
			string TestTitle = "";
			bool MultipleChoice = false;
			int CorrectAnswer = 0;
			DateTime CreateDate = null;
			DateTime LastModifiedDate = null;
			string RowGuid = ""; //** Default
			
			for (int iRows = 0; iRows <= dictEmailGridColDisplayOrder.Count - 1; iRows++)
			{
				if (dictEmailGridColDisplayOrder.ContainsKey(iRows))
				{
					int iDisplayOrder = dictEmailGridColDisplayOrder.Keys(iRows);
					string ColumnName = dictEmailGridColDisplayOrder[iDisplayOrder];
					ReorderDgEmailsCols(ColumnName, iDisplayOrder);
				}
			}
			
		}
		public void ReorderDgEmailsCols(string ColName, int ColDisplayOrder)
		{
			
			try
			{
				DataGridColumn col = dgEmails.Columns(ColName);
				dgEmails.Columns.Remove(col);
				dgEmails.Columns.Insert(ColDisplayOrder, col);
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
		}
		
		public void ReorderContentGridCols()
		{
			
			int QuestionNumber = 0;
			string QuestionText = "";
			int QuestionID = 0;
			string TestTitle = "";
			bool MultipleChoice = false;
			int CorrectAnswer = 0;
			DateTime CreateDate = null;
			DateTime LastModifiedDate = null;
			string RowGuid = ""; //** Default
			
			for (int iRows = 0; iRows <= dictContentGridColDisplayOrder.Count - 1; iRows++)
			{
				if (dictContentGridColDisplayOrder.ContainsKey(iRows))
				{
					int iDisplayOrder = dictContentGridColDisplayOrder.Keys(iRows);
					string ColumnName = dictContentGridColDisplayOrder[iDisplayOrder];
					ReorderDgContentCols(ColumnName, iDisplayOrder);
				}
			}
		}
		
		public void ReorderDgContentCols(string ColName, int ColDisplayOrder)
		{
			
			try
			{
				DataGridColumn col = dgContent.Columns[ColName];
				dgContent.Columns.Remove(col);
				dgContent.Columns.Insert(ColDisplayOrder, col);
			}
			catch (Exception ex)
			{
				SB.Text = ex.Message;
			}
			
		}
		
		public void dgContent_Loaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			getSavedContentGridColumnsDisplayOrder();
		}
		
		public void dgEmails_Loaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			getSavedEmailGridColumnsDisplayOrder();
		}
		
		public void LayoutRoot_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			SaveGridColumnOrder(dgEmails, ref dictEmailGridColDisplayOrder);
			SaveGridColumnOrder(dgContent, ref dictEmailGridColDisplayOrder);
			
			SaveGridLayoutToDB(dgContent);
			SaveGridLayoutToDB(dgEmails);
		}
		
		public void ckMyContent_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckMyContent", ckMyContent.IsChecked, "B");
		}
		
		public void ckMasterOnly_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckMasterOnly", ckMasterOnly.IsChecked, "B");
		}
		
		public void nbrWeightMin_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "nbrWeightMin", nbrWeightMin.Text, "S");
		}
		
		public void ckMasterOnly_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckMasterOnly", ckMasterOnly.IsChecked, "B");
		}
		
		public void ckMyContent_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckMyContent", ckMyContent.IsChecked, "B");
		}
		
		public void rbEmails_Checked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked, "B");
			TabContent.Visibility = Visibility.Collapsed;
		}
		
		public void rbContent_Checked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B");
			TabEmail.Visibility = Visibility.Collapsed;
		}
		
		public void ckWeights_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B");
		}
		
		public void ckLimitToLib_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			ckMyContent.IsChecked = false;
			ckMasterOnly.IsChecked = false;
			ckMyContent.IsEnabled = false;
			ckMasterOnly.IsEnabled = false;
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked, "B");
		}
		
		public void ckFilters_Checked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				SetFilterVisibility();
				return;
			}
			
			UdpateSearchTerm("ALL", "ckFilters", ckFilters.IsChecked, "B");
			COMMON.SaveClick(10003, modGlobals.gCurrUserGuidID);
			SetFilterVisibility();
		}
		
		public void ckSetEmailPublic_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckSetEmailPublic", ckSetEmailPublic.IsChecked, "B");
		}
		
		public void ckSetEmailPublic_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckSetEmailPublic", ckSetEmailPublic.IsChecked, "B");
		}
		
		public void txtSearch_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "txtSearch", txtSearch.Text, "S");
		}
		
		public void ckShowDetails_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckShowDetails", ckShowDetails.IsChecked, "B");
		}
		
		public void ckShowDetails_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckShowDetails", ckShowDetails.IsChecked, "B");
		}
		
		public void SBDoc_TextChanged(System.Object sender, System.Windows.Controls.TextChangedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "SBDoc", SBDoc.Text, "S");
		}
		
		public bool contentSearchParmsSet()
		{
			bool B = false;
			foreach (string sVal in GLOBALS.dictMasterSearch.Values)
			{
				if (sVal.IndexOf("content.") + 1 > 0)
				{
					B = true;
					break;
				}
			}
			return B;
		}
		public bool emailSearchParmsSet()
		{
			bool B = false;
			foreach (string sVal in GLOBALS.dictMasterSearch.Values)
			{
				if (sVal.IndexOf("email.") + 1 > 0)
				{
					B = true;
					break;
				}
			}
			return B;
		}
		
		public void hlAlerts_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			if (! GLOBALS._isAdmin)
			{
				MessageBox.Show("Admin rights required to execute this function, please get an ADMIN to set this up.");
				return;
			}
			
			popupAlerts cw = new popupAlerts();
			cw.Show();
		}
		
		public void setNotificationFlags()
		{
			lblIsPublicShow.Visibility = Visibility.Visible;
			LblIsWebShow.Visibility = Visibility.Visible;
			LblCkIsMasterShow.Visibility = Visibility.Visible;
			lblStructuredData.Visibility = Visibility.Visible;
			lblSharePoint.Visibility = Visibility.Visible;
			lblSap.Visibility = Visibility.Visible;
		}
		
		private void ckWeights_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B");
		}
		
		private void rbContent_Unchecked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B");
		}
		
		public void rbAll_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked, "B");
		}
		
		public void rbContent_Unchecked_2(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B");
		}
		
		private void ckWeights_Unchecked_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B");
		}
		
		public void ckLimitToLib_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			ckMyContent.IsEnabled = true;
			ckMasterOnly.IsEnabled = true;
			if (bQuickSearchRecall)
			{
				return;
			}
			UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked, "B");
		}
		
		public void ckWeights_Unchecked_2(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B");
		}
		
		public void ExportSearchToFileToCsv()
		{
			//Dim path As String = _UserID + ".Export.csv"
			//dgContent.Save(_UserID + ".Export", C1.Silverlight.FlexGrid.FileFormat.Csv)
			string msg = grid.ExportGridToCSV(dgContent, GLOBALS.UserID);
			MessageBox.Show(msg);
		}
		public void ExportSearchToFileToHtml()
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			string msg = grid.ExportGridToHTML(dgContent, GLOBALS.UserID);
			MessageBox.Show(msg);
		}
		public void ExportSearchToFileToText()
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			string msg = grid.ExportGridToTEXT(dgContent, GLOBALS.UserID);
			MessageBox.Show(msg);
		}
		
		public void HyperlinkButton1_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			ISO.RequestMoreIso();
		}
		
		public void hlLibrary_Click_1(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			COMMON.SaveClick(10004, modGlobals.gCurrUserGuidID);
			PageLibrary NextPage = new PageLibrary();
			this.Content = NextPage;
			
		}
		
		public void hlSaveSearch_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			popupSaveSearch cw = new popupSaveSearch();
			this.Content = cw;
			
		}
		
		private void popupSaveSearch_Closed(System.Object sender, EventArgs e)
		{
			popupSaveSearch lw = (popupSaveSearch) sender;
			
			if (GLOBALS.ApplyRecalledSearch == true)
			{
				SB.Text = "Recall of saved search applied.";
				QuickSearchRecall(0, true);
			}
			else
			{
				SB.Text = "Recall of saved search cancelled.";
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void hlHelp_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			string HelpURL = "HTTP://www.EcmLibrary.com/HelpSaas/EcmSaasIndex.htm";
			//HtmlPage.Window.Navigate(New Uri(HelpURL, UriKind.Absolute), "_blank")
			Process.Start(HelpURL);
			
		}
		
		public void QuickSearchAdd()
		{
			
			string SearchParms = PRM.BuildParmString(GLOBALS.dictMasterSearch);
			
			int CurrentQuickSearch = System.Convert.ToInt32(ListOfQuickSearch.Count);
			if (CurrentQuickSearch >= MaxQuickSearchEntry)
			{
				ListOfQuickSearch.RemoveAt(0);
				ListOfQuickSearch.Add(SearchParms);
			}
			else
			{
				ListOfQuickSearch.Add(SearchParms);
			}
			
			DoNotApplyQuickSearch = true;
			
			lblMain.Content = CurrentQuickSearch;
			
			if (nbrExecutedSearches >= 2)
			{
				//SearchHistorySave()
				nbrExecutedSearches = 1;
			}
			
			DoNotApplyQuickSearch = false;
			
		}
		
		public void QuickSearchRecall(int IdNumber, bool bRetrieveSavedSearch)
		{
			
			if (bQuickSearchRecall)
			{
				return;
			}
			
			if (IdNumber >= ListOfQuickSearch.Count)
			{
				SB.Text = "There are no more items in the SEARCH history list.";
				return;
			}
			
			bQuickSearchRecall = true;
			
			string SearchParms = "";
			string sVal = "";
			bool ItemFound = false;
			Dictionary<string, string> TempDict = GLOBALS.dictMasterSearch;
			if (! bRetrieveSavedSearch)
			{
				if (ListOfQuickSearch.Count >= IdNumber)
				{
					SearchParms = ListOfQuickSearch(IdNumber);
				}
				else
				{
					SB.Text = (string) ("No previous search exists for item #:" + IdNumber.ToString());
					lblMain.Content--;
				}
				PRM.ReBuildParmDist(SearchParms, GLOBALS.dictMasterSearch);
			}
			try
			{
				foreach (string sKey in TempDict.Keys)
				{
					try
					{
						sVal = TempDict[sKey];
						ItemFound = true;
					}
					catch (Exception)
					{
						ItemFound = false;
					}
					if (ItemFound)
					{
						
						if (sKey.Equals("DocLowerPageNbr"))
						{
							DocLowerPageNbr = int.Parse(sVal);
						}
						if (sKey.Equals("DocUpperPageNbr"))
						{
							DocUpperPageNbr = int.Parse(sVal);
						}
						if (sKey.Equals("EmailLowerPageNbr"))
						{
							EmailLowerPageNbr = int.Parse(sVal);
						}
						if (sKey.Equals("EmailUpperPageNbr"))
						{
							EmailUpperPageNbr = int.Parse(sVal);
						}
						if (sKey.Equals("txtSearch"))
						{
							txtSearch.Text = sVal;
						}
						//If sKey.Equals("txtSelDir") Then
						//    txtSelDir = sVal
						//End If
						if (sKey.Equals("cbLibrary"))
						{
							try
							{
								cbLibrary.SelectedItem = sVal;
							}
							catch (Exception ex)
							{
								Console.WriteLine("Exception xx1a: " + ex.Message);
							}
						}
						if (sKey.Equals("nbrWeightMin"))
						{
							nbrWeightMin.Text = sVal;
						}
						if (sKey.Equals("rbAll"))
						{
							if (sVal.Equals("True"))
							{
								rbAll.IsChecked = true;
							}
							else
							{
								rbAll.IsChecked = false;
							}
						}
						if (sKey.Equals("rbContent"))
						{
							if (sVal.Equals("True"))
							{
								rbContent.IsChecked = true;
							}
							else
							{
								rbContent.IsChecked = false;
							}
						}
						if (sKey.Equals("rbEmails"))
						{
							if (sVal.Equals("True"))
							{
								rbEmails.IsChecked = true;
							}
							else
							{
								rbEmails.IsChecked = false;
							}
						}
						if (sKey.Equals("ckLimitToLib"))
						{
							if (sVal.Equals("True"))
							{
								ckLimitToLib.IsChecked = true;
							}
							else
							{
								ckLimitToLib.IsChecked = false;
							}
						}
						if (sKey.Equals("ckMyContent"))
						{
							if (sVal.Equals("True"))
							{
								ckMyContent.IsChecked = true;
							}
							else
							{
								ckMyContent.IsChecked = false;
							}
						}
						if (sKey.Equals("ckMasterOnly"))
						{
							if (sVal.Equals("True"))
							{
								ckMasterOnly.IsChecked = true;
							}
							else
							{
								ckMasterOnly.IsChecked = false;
							}
						}
						if (sKey.Equals("ckWeights"))
						{
							if (sVal.Equals("True"))
							{
								ckWeights.IsChecked = true;
							}
							else
							{
								ckWeights.IsChecked = false;
							}
						}
						//If sKey.Equals("ckWeights") Then
						//    If sVal.Equals("True") Then
						//        ckWeights.IsChecked = True
						//    Else
						//        ckWeights.IsChecked = False
						//    End If
						//End If
						//ValName = "lblMain"
						if (sKey.Equals("ckFilters"))
						{
							if (sVal.Equals("True"))
							{
								ckFilters.IsChecked = true;
							}
							else
							{
								ckFilters.IsChecked = false;
							}
						}
						if (sKey.Equals("SBEmail"))
						{
							SBEmail.Text = sVal;
						}
						if (sKey.Equals("SBDoc"))
						{
							SBDoc.Text = sVal;
						}
						if (sKey.Equals("SB"))
						{
							SB.Text = sVal;
						}
					}
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("ERROR XXX1 - " + ex.Message);
			}
			bQuickSearchRecall = false;
		}
		
		public void SearchHistorySave()
		{
			
			string SearchName = GLOBALS._UserID + "-$$QuickSearch";
			string QuickSearchHistory = "";
			
			foreach (string S in ListOfQuickSearch)
			{
				QuickSearchHistory += S + Strings.ChrW(252);
			}
			QuickSearchHistory = QuickSearchHistory.Replace("\'", "\'\'");
			
			GLOBALS.ProxySearch.SaveUserSearchAsync(GLOBALS._SecureID, SearchName, GLOBALS._UserID, QuickSearchHistory);
			
		}
		public void client_ckContentFlagsCompleted(object sender, SVCSearch.ckContentFlagsCompletedEventArgs e)
		{
			bQuickSearchRecall = true;
			
			if (e.Error == null)
			{
				if (e.bMaster)
				{
					LblCkIsMasterShow.Visibility = System.Windows.Visibility.Visible;
					ckMakeMasterDoc.IsChecked = true;
				}
				else
				{
					LblCkIsMasterShow.Visibility = System.Windows.Visibility.Collapsed;
					ckMakeMasterDoc.IsChecked = false;
				}
				if (e.RSS)
				{
					lblRssPull.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					lblRssPull.Visibility = System.Windows.Visibility.Collapsed;
				}
				if (e.SAP)
				{
					lblSap.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					lblSap.Visibility = System.Windows.Visibility.Collapsed;
				}
				if (e.SD)
				{
					lblStructuredData.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					lblStructuredData.Visibility = System.Windows.Visibility.Collapsed;
				}
				if (e.SP)
				{
					lblSharePoint.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					lblSharePoint.Visibility = System.Windows.Visibility.Collapsed;
				}
				if (e.WEB)
				{
					LblIsWebShow.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					LblIsWebShow.Visibility = System.Windows.Visibility.Collapsed;
				}
				if (e.bPublic)
				{
					lblIsPublicShow.Visibility = System.Windows.Visibility.Visible;
					ckMakeIsPublic.IsChecked = true;
				}
				else
				{
					ckMakeIsPublic.IsChecked = false;
					lblIsPublicShow.Visibility = System.Windows.Visibility.Collapsed;
				}
			}
			else
			{
				LblCkIsMasterShow.Visibility = System.Windows.Visibility.Collapsed;
				lblRssPull.Visibility = System.Windows.Visibility.Collapsed;
				lblSap.Visibility = System.Windows.Visibility.Collapsed;
				lblStructuredData.Visibility = System.Windows.Visibility.Collapsed;
				lblSharePoint.Visibility = System.Windows.Visibility.Collapsed;
				LblIsWebShow.Visibility = System.Windows.Visibility.Collapsed;
				lblIsPublicShow.Visibility = System.Windows.Visibility.Collapsed;
				ckMakeIsPublic.IsChecked = false;
				ckMakeMasterDoc.IsChecked = false;
			}
			bQuickSearchRecall = false;
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
				FormLoaded = true;
			}
			else
			{
				AttachmentWeights = null;
			}
			//RemoveHandler ProxySearch.SaveUserSearchCompleted, AddressOf client_SearchHistorySave
		}
		public void SearchHistoryReload()
		{
			
			string SearchName = GLOBALS._UserID + "-$$QuickSearch";
			string SearchParms = "";
			
			GLOBALS.ProxySearch.RecallUserSearchCompleted += new System.EventHandler(client_RecallSearch);
			GLOBALS.ProxySearch.RecallUserSearchAsync(GLOBALS._SecureID, SearchName, GLOBALS._UserID, SearchParms);
			
		}
		public void client_RecallSearch(object sender, SVCSearch.RecallUserSearchCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				if (e.Result)
				{
					if (e.strSearches.Length > 0)
					{
						DoNotApplyQuickSearch = true;
						ListOfQuickSearch.Clear();
						string[] SearchParms = null;
						string QuickSearchHistory = (string) e.strSearches;
						SearchParms = QuickSearchHistory.Split(Strings.ChrW(252).ToString().ToCharArray());
						foreach (string sSearch in SearchParms)
						{
							ListOfQuickSearch.Add(sSearch);
							//Dim sParms() As String = Nothing
							//sParms = sSearch.Split(ChrW(253))
							//Dim SKey As String = sParms(0)
							//If sParms.Length > 1 Then
							//    Dim SVal As String = sParms(1)
							//    If Not dictMasterSearch.ContainsKey(SKey) Then
							//        dictMasterSearch.Add(SKey, SVal)
							//    End If
							//End If
						}
						//QuickSearchRecall(9999, True)
						lblMain.Content = (ListOfQuickSearch.Count - 1).ToString();
					}
					else
					{
						lblMain.Content = 0;
					}
				}
				else
				{
					SB.Text = "Failed to save your search.";
				}
				FormLoaded = true;
			}
			else
			{
				AttachmentWeights = null;
			}
			DoNotApplyQuickSearch = false;
			GLOBALS.ProxySearch.RecallUserSearchCompleted -= new System.EventHandler(client_RecallSearch);
		}
		
		public void ckSetEmailAsDefault_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			string S = "";
			
			S += "if not exists (Select ParmName from UserCurrParm where UserID = \'" + GLOBALS._UserID + "\' and ParmName = \'uDefaultScreen\')" + "\r\n";
			S += "INSERT INTO [UserCurrParm]" + "\r\n";
			S += "           ([UserID]" + "\r\n";
			S += "           ,[ParmName]" + "\r\n";
			S += "           ,[ParmVal]" + "\r\n";
			S += "           )" + "\r\n";
			S += "     VALUES" + "\r\n";
			S += "           (\'" + GLOBALS._UserID + "\'" + "\r\n";
			S += "           ,\'uDefaultScreen\'" + "\r\n";
			S += "           ,\'EMAIL\'" + "\r\n";
			S += "           )" + "\r\n";
			S += "ELSE" + "\r\n";
			S += "UPDATE [UserCurrParm]" + "\r\n";
			S += "   SET " + "\r\n";
			S += "      [ParmVal] = \'EMAIL\'" + "\r\n";
			S += " WHERE [UserID] = \'" + GLOBALS._UserID + "\'" + "\r\n";
			S += "       and [ParmName] = \'uDefaultScreen\'" + "\r\n";
			
			if (GLOBALS.ContractID.Length > 0)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlSelectScreen);
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			}
		}
		
		public void ckSetEmailAsDefault_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			if (bQuickSearchRecall)
			{
				return;
			}
			
			string S = "";
			
			S += "if not exists (Select ParmName from UserCurrParm where UserID = \'" + GLOBALS._UserID + "\' and ParmName = \'uDefaultScreen\')" + "\r\n";
			S += "INSERT INTO [UserCurrParm]" + "\r\n";
			S += "           ([UserID]" + "\r\n";
			S += "           ,[ParmName]" + "\r\n";
			S += "           ,[ParmVal]" + "\r\n";
			S += "           )" + "\r\n";
			S += "     VALUES" + "\r\n";
			S += "           (\'" + GLOBALS._UserID + "\'" + "\r\n";
			S += "           ,\'uDefaultScreen\'" + "\r\n";
			S += "           ,\'CONTENT\'" + "\r\n";
			S += "           )" + "\r\n";
			S += "ELSE" + "\r\n";
			S += "UPDATE [UserCurrParm]" + "\r\n";
			S += "   SET " + "\r\n";
			S += "      [ParmVal] = \'CONTENT\'" + "\r\n";
			S += " WHERE [UserID] = \'" + GLOBALS._UserID + "\'" + "\r\n";
			S += "       and [ParmName] = \'uDefaultScreen\'" + "\r\n";
			
			if (GLOBALS.ContractID.Length > 0)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlSelectScreen);
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			}
		}
		public void client_ExecuteSqlSelectScreen(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				SB.Text = "Successful execution";
				SetDefaultScreen();
			}
			else
			{
				SB.Text = "Unsuccessful execution";
				modGlobals.gErrorCount++;
				clsLogging LOG = new clsLogging();
				LOG.WriteToSqlLog((string) ("ERROR 240.99.1 ExecuteSql: " + e.Error.Message));
				LOG = null;
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlSelectScreen);
		}
		
		public void SetDefaultScreen()
		{
			
			GLOBALS.ProxySearch.getDefaultScreenCompleted += new System.EventHandler(client_getDefaultScreen);
			GLOBALS.ProxySearch.getDefaultScreenAsync(GLOBALS._SecureID, GLOBALS._UserID);
			
		}
		public void client_getDefaultScreen(object sender, SVCSearch.getDefaultScreenCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				string DefaultScreen = (string) e.Result.ToUpper;
				if (DefaultScreen.Equals("EMAIL"))
				{
					TabEmail.IsSelected = true;
				}
				else
				{
					TabContent.IsSelected = true;
				}
			}
			else
			{
				SB.Text = "Could not set the default screen";
				modGlobals.gErrorCount++;
				clsLogging LOG = new clsLogging();
				LOG = null;
			}
			
			GLOBALS.ProxySearch.getDefaultScreenCompleted -= new System.EventHandler(client_getDefaultScreen);
			
		}
		
		public void lblUserID_MouseEnter(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			lblUserID.Content = GLOBALS._UserGuid;
		}
		
		public void lblUserID_MouseLeave_1(System.Object sender, System.Windows.Input.MouseEventArgs e)
		{
			lblUserID.Content = GLOBALS._UserID;
		}
		
		public void ckMakeIsPublic_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (bQuickSearchRecall)
			{
				return;
			}
			
			string S = "Update DataSource set isPublic = \'Y\' where SourceGuid = \'" + CurrentGuid + "\' ";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			UdpateSearchTerm("ALL", "ckMakeIsPublic", ckMakeIsPublic.IsChecked, "B");
		}
		public void ckMakeIsPublic_UnChecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (bQuickSearchRecall)
			{
				return;
			}
			
			string S = "Update DataSource set isPublic = \'N\' where SourceGuid = \'" + CurrentGuid + "\' ";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			UdpateSearchTerm("ALL", "ckMakeIsPublic", ckMakeIsPublic.IsChecked, "B");
		}
		
		public void ckMakeMasterDoc_Checked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (bQuickSearchRecall)
			{
				return;
			}
			
			string S = "Update DataSource set isMaster = \'Y\' where SourceGuid = \'" + CurrentGuid + "\' ";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			UdpateSearchTerm("ALL", "ckMakeMasterDoc", ckMakeMasterDoc.IsChecked, "B");
		}
		public void ckMakeMasterDoc_Unchecked(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			
			if (bQuickSearchRecall)
			{
				return;
			}
			
			string S = "Update DataSource set isMaster = \'N\' where SourceGuid = \'" + CurrentGuid + "\' ";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			UdpateSearchTerm("ALL", "ckMakeMasterDoc", ckMakeMasterDoc.IsChecked, "B");
		}
		
		public void HyperlinkButton3_MouseEnter(object sender, MouseEventArgs e)
		{
			SB.Text = (string) ("Processing " + ArchiverURL);
		}
		
		public void HyperlinkButton3_MouseLeave(object sender, MouseEventArgs e)
		{
			SB.Text = " ";
		}
		
		public void hlDownLoadCLC_MouseEnter(object sender, MouseEventArgs e)
		{
			SB.Text = ClcURL;
		}
		
		public void hlDownLoadCLC_MouseLeave(object sender, MouseEventArgs e)
		{
			SB.Text = " ";
		}
		
		public void linkGenSql_Click(object sender, RoutedEventArgs e)
		{
			GenSqlOnly = true;
			btnSubmit_Click(null, null);
		}
		
		private void Button_Click(object sender, RoutedEventArgs e)
		{
			string ES = ENC2.EncryptPhrase("DALE MILLER", GLOBALS.ContractID);
			string DS = ENC2.DecryptPhrase(ES, GLOBALS.ContractID);
		}
		
		public void hlDownLoadCLC_Copy_Click(object sender, RoutedEventArgs e)
		{
			string fUrl = "http://www.ecmlibrary.com/ECMSaaS/ClcDownloader/EcmDownloader.application";
			SB.Text = fUrl;
			System.Diagnostics.Process.Start(fUrl);
		}
		
		public void dgEmails_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			string eBody = "";
			string eSubj = "";
			int iCnt = System.Convert.ToInt32(dgEmails.SelectedItems.Count);
			
			
			CurrentlySelectedGrid = "EMAIL";
			SelectedGrid = "dgEmails";
			
			if (iCnt == 0)
			{
				return;
			}
			
			if (iCnt > 0)
			{
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
			}
			else
			{
				btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
			}
			RID = -1;
			
			if (iCnt == 1)
			{
				
				object DR = dgEmails.SelectedItems(0);
				
				string EMGuid = (string) DR.EmailGuid;
				string DisplayMsg = "";
				string sBody = (string) DR.Body;
				string sSubj = (string) DR.Subject;
				string sSenderName = (string) DR.SenderName;
				
				if (sSenderName.Length > 0)
				{
					DisplayMsg = "From: " + sSenderName + " - ";
				}
				if (sSubj.Length > 0)
				{
					DisplayMsg += sSubj + "\r\n";
				}
				if (sBody.Length > 0)
				{
					DisplayMsg = DisplayMsg + sBody;
				}
				txtDescription.Text = DisplayMsg.Trim();
				int IX = dgEmails.SelectedIndex;
				CurrentGuid = (string) DR.EmailGuid;
				string isPublic = (string) DR.isPublic;
				if (isPublic.ToUpper().Equals("Y"))
				{
					lblIsPublicShow.Visibility = Visibility.Visible;
				}
				else
				{
					lblIsPublicShow.Visibility = Visibility.Collapsed;
				}
				
				RepoTableName = "Email";
				bool FoundInAttachment = false;
				string StrBB = (string) DR.FoundInAttach;
				if (StrBB.Length == 0)
				{
					FoundInAttachment = false;
				}
				else if (StrBB.ToUpper().Equals("FALSE"))
				{
					FoundInAttachment = false;
				}
				else
				{
					FoundInAttachment = true;
				}
				
				//Dim sRid As String = grid.GetCellValueAsString(dgEmails, dgEmails.SelectedIndex, "RID")
				string sRid = (string) DR.RID;
				sRid = sRid.Trim();
				if (sRid.Length == 0)
				{
					RID = -1;
				}
				else
				{
					RID = int.Parse(sRid);
				}
				
				if (FoundInAttachment)
				{
					dgAttachments.ItemsSource = null;
					dgAttachments.Visibility = System.Windows.Visibility.Collapsed;
					//'Dim proxy As New SVCSearch.Service1Client
					//AddHandler ProxySearch.GetEmailAttachmentsCompleted, AddressOf client_GetEmailAttachments
					GLOBALS.ProxySearch.GetEmailAttachmentsAsync(SecureID, CurrentGuid);
					
				}
				else
				{
					dgAttachments.Visibility = System.Windows.Visibility.Collapsed;
				}
			}
			else
			{
				dgAttachments.Visibility = System.Windows.Visibility.Collapsed;
			}
			if (emailSearchParmsSet())
			{
				lblEmailSearchParms.Visibility = Visibility.Visible;
			}
			else
			{
				lblEmailSearchParms.Visibility = Visibility.Collapsed;
			}
			
		}
		
		public void dgContent_KeyDown(object sender, KeyEventArgs e)
		{
			if (e.Key == Key.F12)
			{
				ContextMenu cm = FindResource("PopupContent");
				cm.IsOpen = true;
				//PopupContent.IsSubmenuOpen = True
			}
		}
		
		public void nbrSearchHist_KeyDown(object sender, KeyEventArgs e)
		{
			
			double CurrSearchId = Convert.ToDouble(lblMain.Content);
			
			if (e.Key == Key.Enter)
			{
				int SearchID = Convert.ToInt32(lblMain.Content);
				
				SetActiveStateOfForm();
				GetSearchHistory(SearchID);
				
				lblMain.Content = CurrSearchId.ToString();
				
				//System.Windows.Browser.HtmlPage.Plugin.Focus()
				btnSubmit.Focus();
				
			}
		}
		
		private void dgEmails_ScrollPositionChanging(System.Object sender, System.Windows.Controls.ScrollChangedEventArgs e)
		{
			
			if (bGhostFetchActive)
			{
				return;
			}
			
			if (bSettingEmailRowHeight)
			{
				return;
			}
			
			
			double pct = grid.getScrollBarCurrentPct(dgEmails, "emailScrollbar");
			double currRow = System.Convert.ToDouble(grid.getScrollBarMaxPosition(dgEmails, "emailScrollbar") * pct);
			
			//If currRow < EmailTriggerRow Then
			if (pct < 0.85)
			{
				return;
			}
			
			bEmailScrolling = true;
			bContentScrolling = false;
			
			//EmailLowerPageNbr += CInt(nbrDocRows.Text)
			//EmailUpperPageNbr += CInt(nbrDocRows.Text)
			//DocLowerPageNbr += CInt(nbrDocRows.Text)
			//DocUpperPageNbr += CInt(nbrDocRows.Text)
			
			bStartNewSearch = false;
			
			//Dim TopRow As Integer = dgEmails.ViewRange.TopRow
			TopRow = (int) (grid.getScrollBarCurrentPosition(dgEmails, "verticalScrollBar"));
			int BottomRow = System.Convert.ToInt32(dgEmails.Items.Count);
			//Dim CurrRow As Double = dgEmails.ViewRange.BottomRow
			currRow = grid.getScrollBarMaxPosition(dgEmails, "verticalScrollBar");
			double PctLocation = grid.getScrollBarCurrentPct(dgEmails, "emailScrollbar");
			int TotalRows = dgEmails.Items.Count;
			
			if (PrevTopRow.Equals(TopRow))
			{
				return;
			}
			PrevTopRow = TopRow;
			SBEmailPage.Text = (string) ("Rows " + TopRow.ToString() + " - " + BottomRow.ToString());
			
			//If BottomRow > TotalRows - (TopRow - 30) Then
			if (PctLocation > 80)
			{
				EmailLowerPageNbr += PageRowLimit;
				EmailUpperPageNbr += PageRowLimit;
				SB.Text = "Fetching more emails";
				ExecuteSearch(false, "dgEmailScroll");
				bGhostFetchActive = true;
			}
			else
			{
				SB.Text = (string) ("EMail: " + currRow.ToString() + " : " + PctLocation.ToString());
			}
			SB.Text = (string) ("EMail: % " + PctLocation.ToString());
		}
		
		public void nbrEmailRows_TextChanged(object sender, TextChangedEventArgs e)
		{
			PageRowLimit = Convert.ToInt32(nbrEmailRows.Text);
			nbrDocRows.Text = nbrEmailRows.Text;
			EmailLowerPageNbr = 0;
			EmailUpperPageNbr = PageRowLimit;
		}
		
		public void nbrDocRows_TextChanged(object sender, TextChangedEventArgs e)
		{
			PageRowLimit = int.Parse(nbrDocRows.Text);
			DocLowerPageNbr = 0;
			DocUpperPageNbr = PageRowLimit;
		}
		
		public void dgAttachments_SelectionChanged(object sender, SelectionChangedEventArgs e)
		{
			
			if (SelectedGrid.Equals("dgEmails"))
			{
				
				int iCnt = dgAttachments.SelectedItems.Count;
				if (! iCnt.Equals(1))
				{
					return;
				}
				
				string EmailGuid = "";
				string AttachmentName = "";
				
				
				if (iCnt > 0)
				{
					btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Visible;
				}
				else
				{
					btnOpenRestoreScreen.Visibility = System.Windows.Visibility.Collapsed;
				}
				
				object DR = dgAttachments.SelectedItems[0];
				
				AttachmentName = (string) DR.AttachmentName;
				EmailGuid = (string) DR.EmailGuid;
				CurrAttachmentRowID = (string) DR.RowID;
				RepoTableName = "EmailAttachment";
				
				if (iCnt == 1)
				{
					CurrentGuid = (string) DR.EmailGuid;
					CurrAttachmentRowID = (string) DR.RowID;
					SB.Text = (string) ("Selected Attachment ID: " + CurrAttachmentRowID);
				}
				else
				{
					CurrentGuid = "";
				}
			}
		}
		
		public void dgEmails_ColumnReordered(object sender, DataGridColumnEventArgs e)
		{
			SaveGridColumnOrder(dgEmails, ref dictEmailGridColDisplayOrder);
		}
		
		public void dgContent_ColumnReordered(object sender, DataGridColumnEventArgs e)
		{
			SaveGridColumnOrder(dgContent, ref dictContentGridColDisplayOrder);
		}
		
		public void btnPlus_Click(object sender, RoutedEventArgs e)
		{
			if (DoNotApplyQuickSearch)
			{
				return;
			}
			QuickSearchRecall(System.Convert.ToInt32(lblMain.Content), false);
		}
		
		public void btnMinus_Click(object sender, RoutedEventArgs e)
		{
			if (DoNotApplyQuickSearch)
			{
				return;
			}
			QuickSearchRecall(System.Convert.ToInt32(lblMain.Content), false);
		}
		
	}
	
	public partial class GridCols
	{
		public int ColOrd;
		public string Colname;
		public int Width;
		public bool bReadOnly;
		public bool Visible;
		public string GridName;
	}
}
