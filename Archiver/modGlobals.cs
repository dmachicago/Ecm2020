using global::System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using global::System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using global::System.Text;
using global::System.Text.RegularExpressions;
using System.Windows.Forms;
using global::ECMEncryption;
using global::Microsoft.Data.Sqlite;
using Outlook = Microsoft.Office.Interop.Outlook;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    static class modGlobals
    {
        private static ECMEncrypt ENC = new ECMEncrypt();
        private static clsIsolatedStorage ISO = new clsIsolatedStorage();
        public static bool bSLConn = false;
        public static SqliteConnection SLConn = new SqliteConnection();

        // Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal
        // longPath As String, ByVal shortPath As String, ByVal shortBufferSize As Long) As Long

        public static List<string> gAllowedExts = new List<string>();
        public static int FilesBackedUp = 0;
        public static int FilesSkipped = 0;
        public static int MoreFileToProcess = 0;
        public static int ContentBatchSize = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["ContentBatchSize"]);
        public static int gUseThreading = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["UseThreading"]);
        public static int gTraceFunctionCalls = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["TraceFunctionCALLS"]);
        public static int TrackUploads = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["TrackUploads"]);
        public static int UseDebugSQLite = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["UseDebugSQLite"]);
        public static int MaxFileToLoadMB = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["MaxFileToLoadMB"]);
        public static bool TempDisableDirListener = false;
        public static int UseDirectoryListener = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["UseDirectoryListener"]);
        public static string SQLiteListenerDB = System.Configuration.ConfigurationManager.AppSettings["SQLiteListenerDB"];
        public static string gBatchLogin = "";
        public static string gBatchEncryptedPW = "";
        public static bool gEmailArchiveDisabled = false;
        public static bool gAutoExec = false;
        public static bool gAutoExecContentComplete = true;
        public static bool gAutoExecEmailComplete = true;
        public static bool gAutoExecExchangeComplete = true;
        public static string gCustomerName = System.Configuration.ConfigurationManager.AppSettings["CustomerName"];
        public static string gCustomerID = System.Configuration.ConfigurationManager.AppSettings["CustomerID"];

        [DllImport("kernel32", CharSet = CharSet.Auto)]
        private static extern int GetShortPathName(string longPath, StringBuilder shortPath, int shortBufferSize);

        public static Dictionary<int, string> gDictOfConstr = new Dictionary<int, string>();
        public static Dictionary<string, string> DictEmails = new Dictionary<string, string>();
        public static Dictionary<string, string> DictContent = new Dictionary<string, string>();
        // Public ProxyFS As New SVCFS.Service1Client()
        // 'Public ProxyArchive As New SVCCLCArchive.Service1Client()
        // Public ProxyGateway As New SVCGateway.Service1Client()
        // Public ProxySearch As New SVCSearch.Service1Client()

        public static bool gResetEndpoints = true;
        public static bool gLoginValidated = true;
        public static string SVCFS_Endpoint = "";
        public static string SVCGateway_Endpoint = "";
        public static string SVCCLCArchive_Endpoint = "";
        public static string SVCSearch_Endpoint = "";
        public static string SVCclcDownload_Endpoint = "";
        public static List<string> gSoftware = new List<string>();
        public static int gCurrRepoID = -1;
        public static string gLicense = "";
        public static string gNotifyMsg = "";
        public static int gSecureID = -1;
        public static int gGateWayID = -1;
        public static string gAttachedMachineName = "";
        public static string gLocalMachineIP = "";
        public static string gServerInstanceName = "";
        public static string gServerMachineName = "";
        public static string gRepoID = "";
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
        public static double gfile_Length = 0d;
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
        public static DateTime gListenerActivityStart = DateAndTime.Now;
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
        public static double gMaxSize = 0d;
        public static bool gTerminateImmediately = false;
        public static object gLicenseType = "";
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
        public static object NbrOfErrors = 0;
        public static string CurrDbName = "";
        public static bool HelpOn = false;
        public static int HelpDuration = 0;
        public static DateTime HelpOnTime = default;
        public static DateTime HelpOffTime = default;
        public static string CurrEmailQry = "";
        public static string CurrSearchCriteria = "";
        public static bool bInitialized = false;
        public static bool bInetAvailable = false;

        // Public gThesaurusSearchText As String = ""
        public static ArrayList gThesauri = new ArrayList();
        public static string gTempDir = "";
        public static bool gVoiceOn = false;
        public static int gNbrSearches = 0;
        public static bool gMyContentOnly = false;
        public static bool gMasterContentOnly = false;
        public static bool gValidated = false;
        private static DateTime _DocLastAccessDate;
        private static DateTime _DocCreateDate;

        public static void MYExnHandler(object sender, UnhandledExceptionEventArgs e)
        {
            Exception EX;
            EX = (Exception)e.ExceptionObject;
            var st = new StackTrace(true);
            st = new StackTrace(EX, true);
            var LOG = new clsLogging();
            LOG.WriteToArchiveLog("MYExnHandler Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            LOG.WriteToArchiveLog("EX.Message MYExnHandler: " + EX.Message);
            LOG.WriteToArchiveLog("EX.StackTrace MYExnHandler: " + EX.StackTrace);
            LOG.WriteToArchiveLog("EX.TargetSite MYExnHandler: " + EX.TargetSite.ToString());
            // Log.WriteToArchiveLog("EX.InnerException: " & EX.InnerException.ToString)

            LOG = null;
        }

        public static void MYThreadHandler(object sender, System.Threading.ThreadExceptionEventArgs e)
        {
            Console.WriteLine(e.Exception.StackTrace);
            var st = new StackTrace(true);
            st = new StackTrace(e.Exception, true);
            var LOG = new clsLogging();
            LOG.WriteToArchiveLog("MYThreadHandlerLine: " + st.GetFrame(0).GetFileLineNumber().ToString());
            LOG.WriteToArchiveLog("MYThreadHandler e.Exception.Message: " + e.Exception.Message);
            LOG.WriteToArchiveLog("MYThreadHandler e.Exception.StackTrace: " + e.Exception.StackTrace);
            LOG.WriteToArchiveLog("MYThreadHandler e.Exception.TargetSite: " + e.Exception.TargetSite.ToString());
            // Log.WriteToArchiveLog("MYThreadHandler e.Exception.InnerException: " & e.Exception.InnerException.ToString)

            LOG = null;
        }

        public static bool closeSLConn()
        {
            bool bb = false;
            if (SLConn.State.Equals(ConnectionState.Open))
            {
                try
                {
                    SLConn.Close();
                    bb = true;
                }
                catch (Exception ex)
                {
                    bb = false;
                }
                finally
                {
                    SLConn.Dispose();
                }
            }

            return bb;
        }

        private static void setUseDebugSQLite()
        {
            try
            {
                UseDebugSQLite = Conversions.ToInteger(System.Configuration.ConfigurationManager.AppSettings["UseDebugSQLite"]);
            }
            catch (Exception ex)
            {
                UseDebugSQLite = 0;
            }
        }

        public static string getPublishedSQLiteDBpath()
        {
            string AppPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            string aName = System.Reflection.Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName;
            string aPath = Path.GetDirectoryName(aName);
            var files = Directory.GetFiles(aPath, "EcmArchive.db", SearchOption.AllDirectories);
            string dbfqn = "";
            if (files.Length > 0)
            {
                for (int I = 0, loopTo = files.Length - 1; I <= loopTo; I++)
                {
                    DBName = files[I];
                    if (Conversions.ToBoolean(DBName.ToUpper().Contains("ECMARCHIVE.DB")))
                    {
                        dbfqn = files[I];
                        break;
                    }
                }
            }

            if (!File.Exists(dbfqn))
            {
                MessageBox.Show("SQLite DB missing, please correct this issue...");
            }

            return dbfqn;
        }


        /// <summary>
    /// Sets the sl connection.
    /// </summary>
    /// <returns></returns>
        public static bool setSLConn()
        {
            bool bb = true;
            setUseDebugSQLite();
            if (!SLConn.State.Equals(ConnectionState.Open))
            {
                try
                {
                    string slDatabase = "";
                    string tchar = "";
                    string cs = "";
                    string strPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                    int I = 0;
                    I = strPath.IndexOf(":");
                    I += 2;
                    strPath = strPath.Substring(I);
                    if (UseDebugSQLite.Equals(1))
                    {
                        slDatabase = System.Configuration.ConfigurationManager.AppSettings["SQLiteDir"];
                        tchar = slDatabase.Substring(slDatabase.Length - 1);
                        if (!tchar.Equals(@"\"))
                        {
                            strPath += @"\";
                        }

                        if (!Directory.Exists(slDatabase))
                        {
                            Directory.CreateDirectory(slDatabase);
                        }

                        slDatabase += "EcmArchive.db";
                        if (!File.Exists(slDatabase))
                        {
                            string dbfqn = getPublishedSQLiteDBpath();
                            tchar = strPath.Substring(strPath.Length - 1);
                            if (!tchar.Equals(@"\"))
                                strPath += @"\";
                            My.MyProject.Computer.FileSystem.CopyFile(dbfqn, slDatabase, overwrite: false);
                        }

                        cs = "data source=" + slDatabase;
                    }
                    else
                    {
                        string dbfqn = getPublishedSQLiteDBpath();
                        cs = "data source=" + dbfqn;
                    }

                    SLConn.ConnectionString = cs;
                    SLConn.Open();
                    bb = true;
                    bSLConn = true;
                }
                catch (Exception ex)
                {
                    bb = false;
                    bSLConn = false;
                }
            }

            return bb;
        }

        public static string setThesaurusConnStr()
        {
            string pw = System.Configuration.ConfigurationManager.AppSettings["ENCPW"];
            pw = ENC.AES256DecryptString(pw);
            string CS = System.Configuration.ConfigurationManager.AppSettings["ECMThesaurus"];
            CS = CS.Replace("@@PW@@", pw);
            return CS;
        }

        public static void SaveGlobalData(string vars)
        {
            try
            {
                string filePath;
                filePath = Path.Combine(My.MyProject.Computer.FileSystem.SpecialDirectories.MyDocuments, "gVars.txt");
                My.MyProject.Computer.FileSystem.WriteAllText(filePath, vars, false);
            }
            catch (Exception fileException)
            {
                throw fileException;
            }
        }

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
            try
            {
                var shortName = new StringBuilder(260);
                modGlobals.GetShortPathName(ref tgtDir, shortName, shortName.Capacity);
                Console.WriteLine(shortName);
                string NewName = shortName.ToString();
                return NewName;
            }
            catch (Exception ex)
            {
                var LOG = new clsLogging();
                LOG.WriteToArchiveLog("ERROR: Directory name issue - '" + tgtDir + "'." + Constants.vbCrLf + ex.Message);
                LOG = null;
            }

            return tgtDir;
        }

        public static bool isGuid(string sGuid)
        {
            if (sGuid.Length > 0)
            {
                var guidRegEx = new Regex(@"^(\{{0,1}([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}\}{0,1}) ");
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

        public static void setLastEmailDate(string FolderName, DateTime EmailDate)
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
                DT = Conversions.ToDate(slLastEmailArchive[FolderName]);
                if (DT > DateAndTime.Now)
                {
                    DT = DateAndTime.Now;
                    slLastEmailArchive.Remove(FolderName);
                    // slLastEmailArchive.Add(FolderName, EmailDate)
                }

                if (DT < EmailDate)
                {
                    slLastEmailArchive.Remove(FolderName);
                    slLastEmailArchive.Add(FolderName, EmailDate);
                }
            }
        }

        public static bool compareEmailProcessDate(string FolderName, DateTime EmailDate)
        {
            bool B = false;
            int I = 0;
            I = slProcessDates.IndexOfKey(FolderName);
            if (I < 0)
            {
                slProcessDates.Add(FolderName, DateTime.Parse("1900-01-01"));
            }
            else
            {
                DateTime LastProcessDate;
                LastProcessDate = Conversions.ToDate(slProcessDates[FolderName]);
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

        public static void addEmailProcessDate(string FolderName, DateTime EmailDate)
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
            S = Conversions.ToString(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            if (S.Equals("?"))
            {
                S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
            }

            S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
            // Data Source=SP6000;Initial Catalog=DMA.UD;Integrated Security=True
            var A = Strings.Split(S, ";");
            for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
            {
                dName = A[i];
                if (Strings.InStr(1, dName, "Initial Catalog", CompareMethod.Text) > 0)
                {
                    var b = Strings.Split(dName, "=");
                    if (Information.UBound(b) >= 1)
                    {
                        dName = b[1];
                        break;
                    }
                }
            }

            Debug.Print("Here for DBARCH name");
            CurrDbName = dName;
        }

        public static void TurnHelpOn(int duration)
        {
            HelpOn = true;
            HelpDuration = duration;
            int CurrYear = DateAndTime.Now.Year;
            int Currday = DateAndTime.Now.Day;
            int CurrMonth = DateAndTime.Now.Month;
            int Currhour = DateAndTime.Now.Hour;
            int CurrMin = DateAndTime.Now.Minute;
            if (duration == 0)
            {
                HelpDuration = 0;
            }
            else
            {
                HelpOffTime = DateAndTime.Now.AddMinutes(duration);
            }
        }

        public static void TurnHelpOff()
        {
            // Dim DBARCH As New clsDatabaseARCH
            HelpOn = false;
            HelpDuration = 0;
            // Dim frm As Form
            // Dim TT As ToolTip = Nothing
            // For Each frm In My.Application.OpenForms
            // DBARCH.getFormTooltips(frm, TT, False)
            // Next
            // DBARCH = Nothing
            // GC.Collect()
        }

        public static void HelpExpired()
        {
            if (HelpDuration == 0)
            {
                return;
            }
            else if (HelpOffTime <= DateAndTime.Now)
            {
                TurnHelpOff();
            }
        }

        public static void SetToClipBoard(string sTxt)
        {
            try
            {
                Clipboard.Clear();
                Clipboard.SetText(sTxt);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Failed to clipboard: " + sTxt);
            }
        }

        public static void setMsgHeader(string tMsg)
        {
            My.MyProject.Forms.frmMessageBar.lblmsg.Text = tMsg;
            My.MyProject.Forms.frmMessageBar.Refresh();
            Application.DoEvents();
        }

        public static void ShowMsgHeader(string tMsg)
        {
            Application.DoEvents();
            My.MyProject.Forms.frmMessageBar.lblmsg.Text = tMsg;
            // frmMessageBar.MdiParent = FrmMDIMain
            My.MyProject.Forms.frmMessageBar.Show();
            Application.DoEvents();
        }

        public static void CloseMsgHeader()
        {
            My.MyProject.Forms.frmMessageBar.Close();
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
            return (int)elapsed_time.TotalSeconds;
        }

        public static string FlipDateByRegion(string tdate)
        {
            string tLocation = System.Globalization.RegionInfo.CurrentRegion.NativeName.ToString();
            // Dim tSplitter As String = System.Globalization.Info.DateSeparator

            string NewDate = null;
            string sDay = null;
            string sMonth = null;
            string sYear = null;
            string[] A = null;

            // gDateSeparator = Info.DateSeparator
            // gTimeSeparator = Info.TimeSeparator
            // gShortDatePattern = Info.ShortDatePattern
            // gShortTimePattern = Info.ShortTimePattern

            // M/d/yyyy
            if (gShortDatePattern.ToUpper() == "M/D/YYYY")
            {
                NewDate = tdate;
            }
            else if (gShortDatePattern.ToUpper() == "D/M/YYYY")
            {
                A = tdate.Split(Conversions.ToChar(gDateSeparator));
                sDay = A[0];
                sMonth = A[1];
                sYear = A[2];
                NewDate = sMonth + "/" + sDay + "/" + sYear;
            }
            else
            {
                A = tdate.Split(Conversions.ToChar(gDateSeparator));
                sDay = A[0];
                sMonth = A[1];
                sYear = A[2];
                NewDate = sMonth + "/" + sDay + "/" + sYear;
            }

            return NewDate;
        }
    }
}