// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.Text.RegularExpressions;
using System.IO;
using Outlook = Microsoft.Office.Interop.Outlook;
using System.Net;
using System.Text;
using System.Runtime.InteropServices;


namespace EcmArchiveClcSetup
{
	sealed class modGlobals
	{
		
		//    Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal longPath As String, ByVal shortPath As String, ByVal shortBufferSize As Long) As Long
		
		[DllImport("kernel32", ExactSpelling=true, CharSet=CharSet.Auto, SetLastError=true)]
		private static extern int GetShortPathName(string longPath, StringBuilder shortPath, int shortBufferSize);
		public static Dictionary<int, string> gDictOfConstr = new Dictionary<int, string>();
		
		public static int gGateWayID = -1;
		public static string gAttachedMachineName = "";
		public static string gLocalMachineIP = "";
		public static string gServerInstanceName = "";
		public static string gServerMachineName = "";
		
		public static string gRepoID = "";
		public static string gCompanyID = "";
		public static string gUserID = "";
		public static Guid gActiveGuid;
		public static Guid gSessionGuid;
		public static string gEncryptPW = "";
		
		public static ArrayList ZipFilesListener = new ArrayList();
		public static ArrayList ZipFilesQuick = new ArrayList();
		public static ArrayList ZipFilesContent = new ArrayList();
		public static ArrayList ZipFilesEmail = new ArrayList();
		public static ArrayList ZipFilesAttachment = new ArrayList();
		public static ArrayList ZipFilesExchange = new ArrayList();
		
		public static string gCurrentConnectionString = "";
		public static SortedList<string, int> gFilesToArchive = new SortedList<string, int>();
		public static double gfile_Length = 0;
		
		public static string gCurrLoginID = "";
		public static string gEncPassword = "";
		public static string gUnEncPassword = "";
		
		public static bool gContentArchiving = false;
		public static bool gOutlookArchiving = false;
		public static bool gExchangeArchiving = false;
		public static bool gContactsArchiving = false;
		
		public static Outlook.MAPIFolder oEcmHistFolder = null;
		public static string oHistoryEntryID = "";
		public static string oHistoryStoreID = "";
		
		public static string gCurrThesaurusCS = "";
		public static string gCurrRepositoryCS = "";
		
		public static bool gRunMinimized = false;
		public static string gDateSeparator = "";
		public static string gTimeSeparator = "";
		public static string gShortDatePattern = "";
		public static string gShortTimePattern = "";
		
		public static List<string> gHiveServersList = new List<string>();
		public static bool gHiveEnabled = false;
		
		public static string gRunMode = "";
		public static bool gClipBoardActive = false;
		
		public static bool gRedemptionDllExists = false;
		
		public static bool gPdfExtended = true;
		public static SortedList<string, bool> gActiveListeners = new SortedList<string, bool>();
		public static DateTime gListenerActivityStart = DateTime.Now;
		
		public static bool gMDIMainLoaded = false;
		public static bool gAllLibrariesSet = false;
		public static bool gLegalAgree = false;
		
		public static bool gPaginateData = false;
		public static int gItemsPerPage = 0;
		
		public static bool gRunUnattended = false;
		public static int gUnattendedErrors = 0;
		
		public static int gNbrOfSeats = 0;
		public static int gNbrOfUsers = 0;
		
		public static bool gPasswordProtectedDoc = false;
		public static int gDaysToKeepTraceLogs = 3;
		public static bool gUserConnectionStringConfirmedGood = false;
		public static string gMaxRecordsToFetch = "";
		public static string gIpAddr = "";
		public static string gNetworkID = "";
		public static string gMachineID = "";
		public static bool gOfficeInstalled = false;
		public static bool gOffice2007Installed = false;
		
		public static double gMaxSize = 0;
		
		public static bool gTerminateImmediately = false;
		public static string gLicenseType = "";
		public static bool gIsClientOnly = false;
		public static bool gIsSDK = false;
		public static int gMaxClients = 0;
		
		public static string gTgtGuid = "";
		
		public static bool gIsServiceManager = false;
		public static int gEmailsBackedUp = 0;
		public static int gEmailsAdded = 0;
		public static bool bIncludeLibraryFilesInSearch = false;
		public static bool bTerminateCrawler = false;
		public static bool bEcmCrawlerAvailable = false;
		public static string SystemSqlTimeout = "";
		public static string gCurrUserGuidID = "";
		public static SortedList slExcludedEmailAddr = new SortedList();
		public static List<string> FilesToDelete = new List<string>();
		public static bool bRunnner = false;
		public static SortedList slLastEmailArchive = new SortedList();
		public static SortedList slProcessDates = new SortedList();
		public static SortedList<string, string> CF = new SortedList<string, string>();
		public static ArrayList globalListOfGuids = new ArrayList();
		public static SortedList<string, string> LicList = new SortedList<string, string>();
		public static int NbrSeats = 0;
		public static int MinRating = 0;
		public static bool isAdmin = false;
		public static bool isGlobalSearcher = false;
		public static string CurrentScreenName = "";
		public static string CurrentWidgetName = "";
		public static string gCurrentArchiveGuid = "";
		public static string ReformattedSearchString = "";
		public static int NbrOfErrors = 0;
		public static string CurrDbName = "";
		public static bool HelpOn = false;
		public static int HelpDuration = 0;
		public static DateTime HelpOnTime = null;
		public static DateTime HelpOffTime = null;
		public static string CurrEmailQry = "";
		public static string CurrSearchCriteria = "";
		public static bool bInitialized = false;
		public static bool bInetAvailable = false;
		//Public gThesaurusSearchText As String = ""
		public static ArrayList gThesauri = new ArrayList();
		public static string gTempDir = "";
		public static bool gVoiceOn = false;
		public static int gNbrSearches = 0;
		public static bool gMyContentOnly = false;
		public static bool gMasterContentOnly = false;
		public static bool gValidated = false;
		
		private static DateTime _DocLastAccessDate;
		private static DateTime _DocCreateDate;
		
		public static DateTime gDocLastAccessDate
		{
			get
			{
				return _DocLastAccessDate;
			}
			set
			{
				_DocLastAccessDate = value;
			}
			
		}
		public static DateTime gDocCreateDate
		{
			get
			{
				return _DocCreateDate;
			}
			set
			{
				_DocCreateDate = value;
			}
			
		}
		
		public static string getShortDirName(string tgtDir)
		{
			//'The path you want to convert to its short representation path.
			//Dim longPathName As String = tgtDir
			//'Get the size of the string to pass to the string buffer.
			//Dim longPathLength As Int32 = longPathName.Length
			//'A string with a buffer to receive the short path from the api call...
			//Dim shortPathName As String = Space(longPathLength)
			//'Will hold the return value of the api call which should be the length.
			//Dim returnValue As Int32
			//'Now call the function to do the conversion...
			//returnValue = GetShortPathName(longPathName, shortPathName, longPathLength)
			try
			{
				StringBuilder shortName = new StringBuilder(260);
				GetShortPathName(tgtDir, shortName, shortName.Capacity);
				Console.WriteLine(shortName);
				string NewName = shortName.ToString();
				return NewName;
			}
			catch (Exception ex)
			{
				clsLogging LOG = new clsLogging();
				LOG.WriteToArchiveLog((string) ("ERROR: Directory name issue - \'" + tgtDir + "\'." + "\r\n" + ex.Message));
				LOG = null;
			}
			return tgtDir;
		}
		
		public static bool isGuid(string sGuid)
		{
			if (sGuid.Length > 0)
			{
				Regex guidRegEx = new Regex("^(\\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\\}{0,1}) ");
				return guidRegEx.IsMatch(sGuid);
			}
			return false;
		}
		
		public static void zeroizeExcludedEmailAddr()
		{
			slExcludedEmailAddr.Clear();
		}
		public static void AddExcludedEmailAddr(string email)
		{
			if (slExcludedEmailAddr.IndexOfKey(email) > 0)
			{
				return;
			}
			else
			{
				slExcludedEmailAddr.Add(email, email);
			}
		}
		public static bool isExcludedEmail(string EmailAddr)
		{
			if (slExcludedEmailAddr.IndexOfKey(EmailAddr) > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		static public void setLastEmailDate(string FolderName, DateTime EmailDate)
		{
			int I = 0;
			I = slLastEmailArchive.IndexOfKey(FolderName);
			if (I < 0)
			{
				slLastEmailArchive.Add(FolderName, EmailDate);
			}
			else
			{
				DateTime DT;
				DT = slLastEmailArchive[FolderName];
				if (DT > DateTime.Now)
				{
					DT = DateTime.Now;
					slLastEmailArchive.Remove(FolderName);
					//slLastEmailArchive.Add(FolderName, EmailDate)
				}
				if (DT < EmailDate)
				{
					slLastEmailArchive.Remove(FolderName);
					slLastEmailArchive.Add(FolderName, EmailDate);
				}
			}
		}
		static public bool compareEmailProcessDate(string FolderName, DateTime EmailDate)
		{
			bool B = false;
			int I = 0;
			I = slProcessDates.IndexOfKey(FolderName);
			if (I < 0)
			{
				slProcessDates.Add(FolderName, DateTime.Parse("1/1/1900"));
			}
			else
			{
				DateTime LastProcessDate;
				LastProcessDate = slProcessDates[FolderName];
				if (LastProcessDate > EmailDate)
				{
					B = true;
				}
				else
				{
					B = false;
				}
			}
			return B;
		}
		static public void addEmailProcessDate(string FolderName, DateTime EmailDate)
		{
			
			int I = 0;
			I = slProcessDates.IndexOfKey(FolderName);
			if (I < 0)
			{
				slProcessDates.Add(FolderName, EmailDate);
			}
		}
		public static void setCurrDbName()
		{
			string dName = "";
			bool bUseConfig = true;
			string S = "";
			S = My.Settings.Default["UserDefaultConnString"];
			if (S.Equals("?"))
			{
				S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
			}
			S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
			//Data Source=SP6000;Initial Catalog=DMA.UD;Integrated Security=True
			string[] A = S.Split(';');
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				dName = A[i];
				if (dName.IndexOf("Initial Catalog") + 1 > 0)
				{
					string[] b = dName.Split('=');
					if ((b.Length - 1) >= 1)
					{
						dName = b[1];
						break;
					}
				}
			}
			Debug.Print("Here for db name");
			CurrDbName = dName;
		}
		public static void TurnHelpOn(int duration)
		{
			
			HelpOn = true;
			HelpDuration = duration;
			
			int CurrYear = DateTime.Now.Year;
			int Currday = DateTime.Now.Day;
			int CurrMonth = DateTime.Now.Month;
			int Currhour = DateTime.Now.Hour;
			int CurrMin = DateTime.Now.Minute;
			
			if (duration == 0)
			{
				HelpDuration = 0;
			}
			else
			{
				HelpOffTime = DateTime.Now.AddMinutes(duration);
			}
			
		}
		public static void TurnHelpOff()
		{
			//Dim DB As New clsDatabase
			HelpOn = false;
			HelpDuration = 0;
			//Dim frm As Form
			//Dim TT As ToolTip = Nothing
			//For Each frm In My.Application.OpenForms
			//    DB.getFormTooltips(frm, TT, False)
			//Next
			//DB = Nothing
			//GC.Collect()
		}
		public static void HelpExpired()
		{
			if (HelpDuration == 0)
			{
				return;
			}
			else
			{
				if (HelpOffTime <= DateTime.Now)
				{
					TurnHelpOff();
				}
			}
		}
		static public void SetToClipBoard(string sTxt)
		{
			try
			{
				Clipboard.Clear();
				Clipboard.SetText(sTxt);
			}
			catch (Exception)
			{
				Console.WriteLine("Failed to clipboard: " + sTxt);
			}
		}
		static public void setMsgHeader(string tMsg)
		{
			frmMessageBar.Default.lblmsg.Text = tMsg;
			frmMessageBar.Default.Refresh();
			Application.DoEvents();
		}
		static public void ShowMsgHeader(string tMsg)
		{
			
			//frmMessageBar.Top = frmMessageBar.
			//frmMessageBar.Width = frm.Width
			//frmMessageBar.Left = frm.Left
			Application.DoEvents();
			frmMessageBar.Default.lblmsg.Text = tMsg;
			//frmMessageBar.MdiParent = FrmMDIMain
			frmMessageBar.Default.Show();
			Application.DoEvents();
		}
		static public void CloseMsgHeader()
		{
			frmMessageBar.Default.Close();
			Application.DoEvents();
		}
		public static string ElapsedTime(DateTime tStart, DateTime tStop)
		{
			TimeSpan elapsed_time;
			elapsed_time = tStop.Subtract(tStart);
			return elapsed_time.TotalSeconds.ToString("00000.000");
		}
		public static int ElapsedTimeSec(DateTime tStart, DateTime tStop)
		{
			TimeSpan elapsed_time;
			elapsed_time = tStop.Subtract(tStart);
			return elapsed_time.TotalSeconds;
		}
		
		public static string FlipDateByRegion(string tdate)
		{
			
			string tLocation = System.Globalization.RegionInfo.CurrentRegion.NativeName.ToString();
			//Dim tSplitter As String = System.Globalization.Info.DateSeparator
			
			string NewDate = null;
			string sDay = null;
			string sMonth = null;
			string sYear = null;
			string[] A = null;
			
			//gDateSeparator = Info.DateSeparator
			//gTimeSeparator = Info.TimeSeparator
			//gShortDatePattern = Info.ShortDatePattern
			//gShortTimePattern = Info.ShortTimePattern
			
			//M/d/yyyy
			if (gShortDatePattern.ToUpper() == "M/D/YYYY")
			{
				NewDate = tdate;
			}
			else if (gShortDatePattern.ToUpper() == "D/M/YYYY")
			{
				A = tdate.Split(gDateSeparator.ToCharArray());
				sDay = A[0];
				sMonth = A[1];
				sYear = A[2];
				NewDate = sMonth + "/" + sDay + "/" + sYear;
			}
			else
			{
				A = tdate.Split(gDateSeparator.ToCharArray());
				sDay = A[0];
				sMonth = A[1];
				sYear = A[2];
				NewDate = sMonth + "/" + sDay + "/" + sYear;
			}
			return NewDate;
			
		}
		
	}
	
}
