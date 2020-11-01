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

using System.Text.RegularExpressions;
using System.IO;
using System.Runtime.InteropServices;


namespace ECMSearchWPF
{
	sealed class modGlobals
	{
		
		[DllImport("kernel32",EntryPoint="GetShortPathNameA", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern int GetShortPathName(string longPath, string shortPath, int shortBufferSize);
		
		static string tempSql = "";
		
		
		static clsEncryptV2 ENC2 = new clsEncryptV2();
		
		public static bool bExecSqlHAndler = false;
		
		public static bool gPostRestore = false;
		public static bool gDoNotOverwriteExistingFile = true;
		public static bool gOverwriteExistingFile = false;
		public static bool gRestoreToOriginalDirectory = false;
		public static bool gRestoreToMyDocuments = false;
		public static bool gCreateOriginalDirIfMissing = true;
		
		public static string HiveConnectionName = "";
		public static bool HiveActive = false;
		public static string RepoSvrName = "";
		
		public static Dictionary<string, DateTime> gProcessDates = new Dictionary<string, DateTime>();
		public static Dictionary<string, string> gSystemParms = new Dictionary<string, string>();
		public static Dictionary<string, string> gUserParms = new Dictionary<string, string>();
		public static Dictionary<string, string> gLicenseItems = new Dictionary<string, string>();
		
		public static string gServerInstanceName = "";
		public static string gServerMachineName = "";
		public static string gServerVersion = "";
		public static string gLoggedInUser = "";
		public static string gAttachedMachineName = "";
		public static int gNumberOfRegisterdMachines = -1;
		public static int gMachineExist = -1;
		
		public static bool gIsLease = false;
		
		public static int gErrorCount = 0;
		public static string gDateSeparator = "";
		public static string gTimeSeparator = "";
		public static string gShortDatePattern = "";
		public static string gShortTimePattern = "";
		
		public static List<string> gHiveServersList = new List<string>();
		public static bool gHiveEnabled = false;
		
		public static string gRunMode = "";
		public static bool gClipBoardActive = false;
		
		public static bool gRedemptionDllExists = false;
		
		public static bool gPdfExtended = false;
		public static Dictionary<string, bool> gActiveListeners = new Dictionary<string, bool>();
		public static DateTime gListenerActivityStart = DateTime.Now;
		
		public static bool gMDIMainLoaded = false;
		public static bool gAllLibrariesSet = false;
		public static bool gLegalAgree = false;
		
		public static bool gPaginateData = true;
		public static int gItemsPerPage = 0;
		
		public static bool gRunUnattended = false;
		public static int gUnattendedErrors = 0;
		
		public static string gCustomerID;
		public static int gNbrOfSeats = 0;
		public static int gNbrOfUsers = 0;
		public static int gNbrOfRegisteredUsers = 0;
		
		public static bool gPasswordProtectedDoc = false;
		public static int gDaysToKeepTraceLogs = 3;
		public static bool gUserConnectionStringConfirmedGood = false;
		public static string gMaxRecordsToFetch = "60";
		public static string gIpAddr = "";
		public static string gMachineID = "";
		public static string gLocalMachineIP = "";
		public static bool gOfficeInstalled = false;
		public static bool gOffice2007Installed = false;
		
		public static double gMaxSize = 0;
		public static double gCurrDbSize = 0;
		public static DateTime gExpirationDate = null;
		public static DateTime gMaintExpire = null;
		public static string gEncLicense = "";
		public static bool gIsLicenseValid = System.Convert.ToBoolean(null);
		public static string gServerValText = "";
		public static string gInstanceValText = "";
		
		public static bool gTerminateImmediately = false;
		public static string gLicenseType = "";
		public static bool gIsClientOnly = false;
		public static bool gIsSDK = false;
		public static int gMaxClients = 0;
		
		public static string gTgtGuid = "";
		public static string gCurrLoginID = "";
		public static string gCurrDomainLoginID = "";
		public static bool gIsServiceManager = false;
		public static int gEmailsBackedUp = 0;
		public static int gEmailsAdded = 0;
		public static bool bIncludeLibraryFilesInSearch = false;
		public static bool bTerminateCrawler = false;
		public static bool bEcmCrawlerAvailable = false;
		public static string SystemSqlTimeout = "";
		public static string gCurrUserGuidID = "";
		public static Dictionary<string, string> slExcludedEmailAddr = new Dictionary<string, string>();
		public static List<string> FilesToDelete = new List<string>();
		public static bool bRunnner = false;
		public static Dictionary<string, string> slLastEmailArchive = new Dictionary<string, string>();
		public static Dictionary<string, string> slProcessDates = new Dictionary<string, string>();
		public static Dictionary<string, string> CF = new Dictionary<string, string>();
		public static List<string> globalListOfGuids = new List<string>();
		public static Dictionary<string, string> LicList = new Dictionary<string, string>();
		public static int NbrSeats = 0;
		public static int MinRating = 0;
		public static bool gIsAdmin = false;
		public static bool gIsGlobalSearcher = false;
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
		public static List<string> gThesauri = new List<string>();
		public static string gTempDir = "";
		public static bool gVoiceOn = false;
		public static int gNbrSearches = 0;
		public static bool gMyContentOnly = false;
		public static bool gMasterContentOnly = false;
		public static bool gValidated = false;
		
		static int CurrSecureID = -1;
		
		public static string getShortDirName(string tgtDir)
		{
			//The path you want to convert to its short representation path.
			string longPathName = tgtDir;
			//Get the size of the string to pass to the string buffer.
			int longPathLength = longPathName.Length;
			//A string with a buffer to receive the short path from the api call...
			string shortPathName = Strings.Space(longPathLength);
			//Will hold the return value of the api call which should be the length.
			int returnValue;
			//Now call the function to do the conversion...
			returnValue = System.Convert.ToInt32(GetShortPathName(longPathName, shortPathName, longPathLength));
			return returnValue;
		}
		
		public static bool isGuid(string sGuid)
		{
			if (sGuid.Length > 0)
			{
				Regex guidRegEx = new Regex("^(\\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\\}{0,1})$");
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
			if (slExcludedEmailAddr.ContainsKey(email))
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
			if (slExcludedEmailAddr.ContainsKey(EmailAddr))
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
			bool B = false;
			B = slLastEmailArchive.ContainsKey(FolderName);
			if (! B)
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
			bool I = false;
			I = slProcessDates.ContainsKey(FolderName);
			if (! I)
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
			
			bool B = false;
			B = slProcessDates.ContainsKey(FolderName);
			if (! B)
			{
				slProcessDates.Add(FolderName, EmailDate);
			}
		}
		//Public Sub setCurrDbName()
		//    Dim dName$ = ""
		//    Dim bUseConfig As Boolean = True
		//    Dim S as string = ""
		//    S = My.Settings("UserDefaultConnString")
		//    If S.Equals("?") Then
		//        S = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
		//    End If
		//    S = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
		//    'Data Source=SP6000;Initial Catalog=DMA.UD;Integrated Security=True
		//    Dim A$() = Split(S, ";")
		//    For i As Integer = 0 To UBound(A  )
		//        dName = A(i)
		//        If InStr(1, dName, "Initial Catalog", CompareMethod.Text) > 0 Then
		//            Dim b$() = Split(dName, "=")
		//            If UBound(b) >= 1 Then
		//                dName$ = b(1)
		//                Exit For
		//            End If
		//        End If
		//    Next
		//    Debug.Print("Here for db name")
		//    CurrDbName = dName$
		//End Sub
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
		static public void WriteTraceLogX(string msg)
		{
			try
			{
				//Dim cPath As String = getTempEnvironDir()
				//Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				//Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
				var M = DateTime.Now.Month.ToString().Trim();
				var D = DateTime.Now.Day.ToString().Trim();
				var Y = DateTime.Now.Year.ToString().Trim();
				
				var SerialNo = M + "." + D + "." + Y + ".";
				
				var tFQN = gTempDir + "\\ECMLibrary.MstrTrace." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception)
			{
				//
			}
			GC.Collect();
			
		}
		static public void WriteTraceLogBackupX(string msg)
		{
			//** WDMXX
			
			var TempFolder = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
			var M = DateTime.Now.Month.ToString().Trim();
			var D = DateTime.Now.Day.ToString().Trim();
			var Y = DateTime.Now.Year.ToString().Trim();
			
			var SerialNo = M + "." + D + "." + Y + ".";
			
			try
			{
				//Dim cPath As String = GetCurrDir()
				var tFQN = TempFolder + "\\EcmTrace.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				Console.WriteLine("Error 154.324.1d: WriteTraceLogBackup: " + "\r\n" + ex.Message);
			}
			GC.Collect();
			
		}
		//Sub SetToClipBoard(ByVal sTxt as string)
		//    Try
		//        Clipboard.Clear()
		//        Clipboard.SetText(sTxt )
		//    Catch ex As Exception
		//        Console.WriteLine("Failed to clipboard: " + sTxt)
		//    End Try
		//End Sub
		//Sub setMsgHeader(ByVal tMsg )
		//    frmMessageBar.lblmsg.Text = tMsg
		//    frmMessageBar.Refresh()
		//    Application.DoEvents()
		//End Sub
		//Sub ShowMsgHeader(ByVal tMsg )
		
		//    'frmMessageBar.Top = frmMessageBar.
		//    'frmMessageBar.Width = frm.Width
		//    'frmMessageBar.Left = frm.Left
		//    Application.DoEvents()
		//    frmMessageBar.lblmsg.Text = tMsg
		//    frmMessageBar.MdiParent = FrmMDIMain
		//    frmMessageBar.Show()
		//    Application.DoEvents()
		//End Sub
		//Sub CloseMsgHeader()
		//    frmMessageBar.Close()
		//    Application.DoEvents()
		//End Sub
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
		
		public static bool isNumericDma(string value)
		{
			int number;
			bool result = int.TryParse(value, ref number);
			if (result)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		static public string MidX(string tgtString, int I, string ReplaceChar)
		{
			string S1 = "";
			string S2 = "";
			S1 = tgtString.Substring(1, I - 1);
			S2 = tgtString.Substring(I + 1);
			S1 = S1 + ReplaceChar + S2;
			return S1;
		}
		
		static public string getSystemParm(string sysParmName)
		{
			int i = gSystemParms.Count;
			if (i == 0)
			{
				return "";
			}
			string tVal = "";
			
			if (gSystemParms.ContainsKey(sysParmName))
			{
				tVal = gSystemParms[sysParmName];
			}
			else
			{
				tVal = "";
			}
			return tVal;
		}
		
		static public string gElapsedTime(DateTime dStart, DateTime dEnd)
		{
			string timeDiff = "";
			string sDateFrom = dStart;
			string sDateTo = DateTime.Now;
			try
			{
				if (DateTime.TryParse(sDateFrom, ref dStart) && DateTime.TryParse(sDateTo, ref dEnd))
				{
					TimeSpan TS = dEnd - dStart;
					int hour = TS.Hours;
					int mins = TS.Minutes;
					int secs = TS.Seconds;
					int ms = TS.Milliseconds;
					timeDiff = (string) (((hour.ToString("00") + ":") + mins.ToString("00") + ":") + secs.ToString("00") + "." + ms.ToString().Substring(0, 3));
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("ERROR ElapsedTime: " + ex.Message);
			}
			
			return timeDiff;
		}
		
		static public void ExecuteSql(string SecureID, string Mysql)
		{
			CurrSecureID = int.Parse(SecureID);
			tempSql = Mysql;
			//Dim proxy As New SVCSearch.Service1Client
			
			if (! bExecSqlHAndler)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSql);
				setSearchSvcEndPoint(GLOBALS.ProxySearch);
				bExecSqlHAndler = true;
			}
			Mysql = ENC2.EncryptPhrase(Mysql, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, Mysql, GLOBALS._UserID, GLOBALS.ContractID);
		}
		
		static public void client_ExecuteSql(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
			}
			else
			{
				gErrorCount++;
				clsLogging LOG = new clsLogging();
				LOG.WriteToSqlLog((string) ("ERROR 100.99.1 ExecuteSql: " + e.Error.Message + "\r\n" + e.MySql));
				LOG = null;
			}
		}
		
		private static void setSearchSvcEndPoint(SVCSearch.Service1Client proxy)
		{
			
			if (GLOBALS.SearchEndPoint.Length == 0)
			{
				return;
			}
			
			Uri ServiceUri = new Uri(GLOBALS.SearchEndPoint);
			System.ServiceModel.EndpointAddress EPA = new System.ServiceModel.EndpointAddress(ServiceUri, null);
			
			GLOBALS.ProxySearch.Endpoint.Address = EPA;
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
	}
	
	
}
