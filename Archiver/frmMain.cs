/* TODO ERROR: Skipped DefineDirectiveTrivia */
using System;
using System.Collections;
using System.Collections.Generic;
using global::System.Collections.Specialized;
// Imports Microsoft.Data.Sqlite
using global::System.Data.SQLite;
using global::System.Deployment.Application;
using System.Diagnostics;
using System.Drawing;

/* TODO ERROR: Skipped DefineDirectiveTrivia */
using global::System.IO;
using System.Linq;
using global::System.Reflection;
using global::System.Security.Permissions;
using global::System.Threading;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using global::Microsoft.Win32;
using MODI;

namespace EcmArchiver
{
    public partial class frmMain : IDisposable
    {
        public frmMain()
        {
            InitializeComponent();

            // Define a handler for unhandled exceptions.
            currentDomain.UnhandledException += modGlobals.MYExnHandler;
            // Define a handler for unhandled exceptions for threads behind forms.
            Application.ThreadException += modGlobals.MYThreadHandler;
            bool bFrm = ckFormOpen("frmMessageBar");
            if (!bFrm)
            {
                My.MyProject.Forms.frmMessageBar.Show();
            }

            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9901, "Main", "01");
            // Add any initialization after the InitializeComponent() call.
            updateMessageBar("1 of 6");
            if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(My.MySettingsProperty.Settings["UpgradeSettings"], true, false)))
            {
                try
                {
                    LOG.WriteToArchiveLog("NOTICE: New INSTALL detected 100");
                    My.MySettingsProperty.Settings.Upgrade();
                    My.MySettingsProperty.Settings.Reload();
                    My.MySettingsProperty.Settings["UpgradeSettings"] = false;
                    My.MySettingsProperty.Settings.Save();
                    LOG.WriteToArchiveLog(Conversions.ToString(Operators.AddObject("NOTICE: New INSTALL detected 200: ", My.MySettingsProperty.Settings["UserDefaultConnString"])));
                    LOG.WriteToArchiveLog(Conversions.ToString(Operators.AddObject("NOTICE: New INSTALL detected 300: ", My.MySettingsProperty.Settings["UserThesaurusConnString"])));
                }
                // WDM 10-30-2020 Commewnted out next stmtm
                // DBLocal.RestoreSQLite()
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 01 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: INSTALL 100: " + ex.Message);
                }
            }

            updateMessageBar("2 of 6");
            string strUseRemoteServer = System.Configuration.ConfigurationManager.AppSettings["UseRemoteServer"];
            if (strUseRemoteServer.Equals("1"))
            {
                bUseRemoteServer = true;
            }
            else
            {
                bUseRemoteServer = false;
            }

            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9901, "Main", "10");
            ExitToolStripMenuItem.Visible = true;
            updateMessageBar("3 of 6");
            try
            {
                VerifyEmbeddedZipFiles = System.Configuration.ConfigurationManager.AppSettings["VerifyEmbeddedZipFiles"];
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 02 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                VerifyEmbeddedZipFiles = "0";
            }

            modGlobals.gMachineID = LOG.getEnvVarMachineName();
            modGlobals.gNetworkID = LOG.getEnvVarNetworkID();
            updateMessageBar("4 of 6");
            DBLocal.cleanZipFiles();
            updateMessageBar("5 of 6");
            UTIL.cleanTempWorkingDir();
            updateMessageBar("6 of 6");
            populateZipExtensions();
            updateMessageBar("6 of 6.1");
            populateGraphicExtensions();
            updateMessageBar("6 of 6.2");

            // Me.Show()
            Application.DoEvents();
            bool bopen = ckFormOpen("frmMain");
            if (!bopen)
            {
                try
                {
                    Show();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Notice: frmMain closed... reopening");
                }
            }

            modGlobals.gAllowedExts = DBARCH.getUsersAllowedFileExt(modGlobals.gCurrUserGuidID);
            TabControl1.SelectedIndex = 1;
            _Button4.Name = "Button4";
            _LinkLabel2.Name = "LinkLabel2";
            _LinkLabel1.Name = "LinkLabel1";
            _hlExchange.Name = "hlExchange";
            _ckExpand.Name = "ckExpand";
            _cbParentFolders.Name = "cbParentFolders";
            _ckUseLastProcessDateAsCutoff.Name = "ckUseLastProcessDateAsCutoff";
            _btnDeleteEmailEntry.Name = "btnDeleteEmailEntry";
            _btnActive.Name = "btnActive";
            _ckRemoveAfterXDays.Name = "ckRemoveAfterXDays";
            _btnRefreshFolders.Name = "btnRefreshFolders";
            _btnSaveConditions.Name = "btnSaveConditions";
            _lbActiveFolder.Name = "lbActiveFolder";
            _Button2.Name = "Button2";
            _Button1.Name = "Button1";
            _ckRemoveFileType.Name = "ckRemoveFileType";
            _btnAddFiletype.Name = "btnAddFiletype";
            _gbPolling.Name = "gbPolling";
            _ckRunOnStart.Name = "ckRunOnStart";
            _btnArchiveNow.Name = "btnArchiveNow";
            _nbrArchiveHours.Name = "nbrArchiveHours";
            _ckRunUnattended.Name = "ckRunUnattended";
            _ckDisableExchange.Name = "ckDisableExchange";
            _ckDisableOutlookEmailArchive.Name = "ckDisableOutlookEmailArchive";
            _ckDisableContentArchive.Name = "ckDisableContentArchive";
            _btnSaveSchedule.Name = "btnSaveSchedule";
            _ckDisable.Name = "ckDisable";
            _gbContentMgt.Name = "gbContentMgt";
            _btnCountFiles.Name = "btnCountFiles";
            _btnSetLastArchiveOFF.Name = "btnSetLastArchiveOFF";
            _btnSetLastArchiveON.Name = "btnSetLastArchiveON";
            _CheckBox2.Name = "CheckBox2";
            _btnArchive1Doc.Name = "btnArchive1Doc";
            _ckDeleteAfterArchive.Name = "ckDeleteAfterArchive";
            _ckOcrPdf.Name = "ckOcrPdf";
            _ckShowLibs.Name = "ckShowLibs";
            _btnRefreshRetent.Name = "btnRefreshRetent";
            _CkMonitor.Name = "CkMonitor";
            _ckArchiveBit.Name = "ckArchiveBit";
            _Label13.Name = "Label13";
            _ckOcr.Name = "ckOcr";
            _clAdminDir.Name = "clAdminDir";
            _ckDisableDir.Name = "ckDisableDir";
            _ckPublic.Name = "ckPublic";
            _ckMetaData.Name = "ckMetaData";
            _ckVersionFiles.Name = "ckVersionFiles";
            _ckSubDirs.Name = "ckSubDirs";
            _txtDir.Name = "txtDir";
            _btnRefresh.Name = "btnRefresh";
            _btnSaveChanges.Name = "btnSaveChanges";
            _btnRemoveDir.Name = "btnRemoveDir";
            _btnSelDir.Name = "btnSelDir";
            _lbArchiveDirs.Name = "lbArchiveDirs";
            _lbExcludeExts.Name = "lbExcludeExts";
            _lbAvailExts.Name = "lbAvailExts";
            _lbIncludeExts.Name = "lbIncludeExts";
            _Button3.Name = "Button3";
            _btnRemoveExclude.Name = "btnRemoveExclude";
            _btnInclFileType.Name = "btnInclFileType";
            _btnExclude.Name = "btnExclude";
            _btnAddDefaults.Name = "btnAddDefaults";
            _btnRefreshRebuild.Name = "btnRefreshRebuild";
            _btnDeleteDirProfile.Name = "btnDeleteDirProfile";
            _btnUpdateDirectoryProfile.Name = "btnUpdateDirectoryProfile";
            _btnSaveDirProfile.Name = "btnSaveDirProfile";
            _btnApplyDirProfile.Name = "btnApplyDirProfile";
            _btnExclProfile.Name = "btnExclProfile";
            _btnInclProfile.Name = "btnInclProfile";
            _cbProfile.Name = "cbProfile";
            _Label8.Name = "Label8";
            _cbFileDB.Name = "cbFileDB";
            _btnAddDir.Name = "btnAddDir";
            _ckTerminate.Name = "ckTerminate";
            _ckPauseListener.Name = "ckPauseListener";
            _ContextMenuStrip1.Name = "ContextMenuStrip1";
            _ResetSelectedMailBoxesToolStripMenuItem.Name = "ResetSelectedMailBoxesToolStripMenuItem";
            _EmailLibraryReassignmentToolStripMenuItem.Name = "EmailLibraryReassignmentToolStripMenuItem";
            _ArchiveToolStripMenuItem.Name = "ArchiveToolStripMenuItem";
            _ArchiveALLToolStripMenuItem.Name = "ArchiveALLToolStripMenuItem";
            _OutlookEmailsToolStripMenuItem.Name = "OutlookEmailsToolStripMenuItem";
            _ExchangeEmailsToolStripMenuItem.Name = "ExchangeEmailsToolStripMenuItem";
            _ContentToolStripMenuItem.Name = "ContentToolStripMenuItem";
            _ContentNoLIstenerToolStripMenuItem.Name = "ContentNoLIstenerToolStripMenuItem";
            _ToolStripMenuItem1.Name = "ToolStripMenuItem1";
            _ScheduleToolStripMenuItem.Name = "ScheduleToolStripMenuItem";
            _SelectedFilesToolStripMenuItem.Name = "SelectedFilesToolStripMenuItem";
            _ArchiveRSSPullsToolStripMenuItem.Name = "ArchiveRSSPullsToolStripMenuItem";
            _WebSitesToolStripMenuItem.Name = "WebSitesToolStripMenuItem";
            _WebPagesToolStripMenuItem.Name = "WebPagesToolStripMenuItem";
            _ExitToolStripMenuItem1.Name = "ExitToolStripMenuItem1";
            _LoginToSystemToolStripMenuItem.Name = "LoginToSystemToolStripMenuItem";
            _ChangeUserPasswordToolStripMenuItem.Name = "ChangeUserPasswordToolStripMenuItem";
            _ClearRestoreQueueToolStripMenuItem1.Name = "ClearRestoreQueueToolStripMenuItem1";
            _CompareDirToRepositoryToolStripMenuItem1.Name = "CompareDirToRepositoryToolStripMenuItem1";
            _InventoryDirectoryToolStripMenuItem1.Name = "InventoryDirectoryToolStripMenuItem1";
            _ValidateDirectoryFilesToolStripMenuItem.Name = "ValidateDirectoryFilesToolStripMenuItem";
            _ReapplyALLDBUpdatesToolStripMenuItem.Name = "ReapplyALLDBUpdatesToolStripMenuItem";
            _ValidateRetentionDatesToolStripMenuItem.Name = "ValidateRetentionDatesToolStripMenuItem";
            _TurnONToolStripMenuItem.Name = "TurnONToolStripMenuItem";
            _TurnOFFToolStripMenuItem.Name = "TurnOFFToolStripMenuItem";
            _InitializeToGivenDateToolStripMenuItem.Name = "InitializeToGivenDateToolStripMenuItem";
            _TurnListenerONToolStripMenuItem.Name = "TurnListenerONToolStripMenuItem";
            _TurnListenerOFFToolStripMenuItem.Name = "TurnListenerOFFToolStripMenuItem";
            _ListenerONALLDirsToolStripMenuItem.Name = "ListenerONALLDirsToolStripMenuItem";
            _ListenerOFFALLDirsToolStripMenuItem.Name = "ListenerOFFALLDirsToolStripMenuItem";
            _LIstWindowsLogsToolStripMenuItem.Name = "LIstWindowsLogsToolStripMenuItem";
            _CheckLogsForListenerInfoToolStripMenuItem.Name = "CheckLogsForListenerInfoToolStripMenuItem";
            _ReInventoryAllFilesToolStripMenuItem.Name = "ReInventoryAllFilesToolStripMenuItem";
            _ResetSQLiteArchivesToolStripMenuItem.Name = "ResetSQLiteArchivesToolStripMenuItem";
            _GetOutlookEMailIDsToolStripMenuItem1.Name = "GetOutlookEMailIDsToolStripMenuItem1";
            _ResetZIPFilesToolStripMenuItem.Name = "ResetZIPFilesToolStripMenuItem";
            _ResetEmailIdentifierCodesToolStripMenuItem.Name = "ResetEmailIdentifierCodesToolStripMenuItem";
            _RebuildSQLiteDBToolStripMenuItem1.Name = "RebuildSQLiteDBToolStripMenuItem1";
            _BackupSQLiteDBToolStripMenuItem1.Name = "BackupSQLiteDBToolStripMenuItem1";
            _RestoreSQLiteDBToolStripMenuItem1.Name = "RestoreSQLiteDBToolStripMenuItem1";
            _SQToolStripMenuItem.Name = "SQToolStripMenuItem";
            _EstimateNumberOfFilesToolStripMenuItem.Name = "EstimateNumberOfFilesToolStripMenuItem";
            _ReOcrIncompleteGraphicFilesToolStripMenuItem.Name = "ReOcrIncompleteGraphicFilesToolStripMenuItem";
            _ReOcrALLGraphicFilesToolStripMenuItem1.Name = "ReOcrALLGraphicFilesToolStripMenuItem1";
            _RetentionRulesToolStripMenuItem.Name = "RetentionRulesToolStripMenuItem";
            _RulesExecutionToolStripMenuItem.Name = "RulesExecutionToolStripMenuItem";
            _EncryptStringToolStripMenuItem.Name = "EncryptStringToolStripMenuItem";
            _OpenLicenseFormToolStripMenuItem.Name = "OpenLicenseFormToolStripMenuItem";
            _FileNamesToolStripMenuItem.Name = "FileNamesToolStripMenuItem";
            _CanLongFilenamesBeTurnedOnToolStripMenuItem.Name = "CanLongFilenamesBeTurnedOnToolStripMenuItem";
            _HowToTurnOnLongFilenamesToolStripMenuItem.Name = "HowToTurnOnLongFilenamesToolStripMenuItem";
            _TurnONLongFilenamesAdminNeededToolStripMenuItem.Name = "TurnONLongFilenamesAdminNeededToolStripMenuItem";
            _CheckForViolationsToolStripMenuItem.Name = "CheckForViolationsToolStripMenuItem";
            _ValidateFileHASHCodesToolStripMenuItem.Name = "ValidateFileHASHCodesToolStripMenuItem";
            _ValidateProcessAsFileExtsToolStripMenuItem.Name = "ValidateProcessAsFileExtsToolStripMenuItem";
            _FulltextLogAnalysisToolStripMenuItem.Name = "FulltextLogAnalysisToolStripMenuItem";
            _UpdateAvailableIFiltersToolStripMenuItem.Name = "UpdateAvailableIFiltersToolStripMenuItem";
            _ValidateRepoContentsToolStripMenuItem.Name = "ValidateRepoContentsToolStripMenuItem";
            _ImpersonateLoginToolStripMenuItem.Name = "ImpersonateLoginToolStripMenuItem";
            _LoginAsDifferenctUserToolStripMenuItem.Name = "LoginAsDifferenctUserToolStripMenuItem";
            _ManualEditAppConfigToolStripMenuItem.Name = "ManualEditAppConfigToolStripMenuItem";
            _ManualEditListenerConfigToolStripMenuItem.Name = "ManualEditListenerConfigToolStripMenuItem";
            _ViewLogsToolStripMenuItem.Name = "ViewLogsToolStripMenuItem";
            _ViewOCRErrorFilesToolStripMenuItem.Name = "ViewOCRErrorFilesToolStripMenuItem";
            _AddDesktopIconToolStripMenuItem.Name = "AddDesktopIconToolStripMenuItem";
            _CheckForUpdatesToolStripMenuItem.Name = "CheckForUpdatesToolStripMenuItem";
            _ShowSystemVersionToolStripMenuItem.Name = "ShowSystemVersionToolStripMenuItem";
            _AllToolStripMenuItem.Name = "AllToolStripMenuItem";
            _EmailToolStripMenuItem.Name = "EmailToolStripMenuItem";
            _ContentToolStripMenuItem1.Name = "ContentToolStripMenuItem1";
            _ExecutionControlToolStripMenuItem.Name = "ExecutionControlToolStripMenuItem";
            _FileTypesToolStripMenuItem.Name = "FileTypesToolStripMenuItem";
            _DirectoryInventoryToolStripMenuItem.Name = "DirectoryInventoryToolStripMenuItem";
            _ListFilesInDirectoryToolStripMenuItem.Name = "ListFilesInDirectoryToolStripMenuItem";
            _GetAllSubdirFilesToolStripMenuItem.Name = "GetAllSubdirFilesToolStripMenuItem";
            _FileHashToolStripMenuItem.Name = "FileHashToolStripMenuItem";
            _FileUploadToolStripMenuItem.Name = "FileUploadToolStripMenuItem";
            _FileUploadBufferedToolStripMenuItem.Name = "FileUploadBufferedToolStripMenuItem";
            _FileChunkUploadToolStripMenuItem.Name = "FileChunkUploadToolStripMenuItem";
            _RSSPullToolStripMenuItem.Name = "RSSPullToolStripMenuItem";
            _UnhandledExceptionsToolStripMenuItem.Name = "UnhandledExceptionsToolStripMenuItem";
            _GetListenerFilesToolStripMenuItem.Name = "GetListenerFilesToolStripMenuItem";
            _CreateSQLiteDBToolStripMenuItem.Name = "CreateSQLiteDBToolStripMenuItem";
            _LongFilenameHASHToolStripMenuItem.Name = "LongFilenameHASHToolStripMenuItem";
            _ValidateLongDirectroryNamesToolStripMenuItem.Name = "ValidateLongDirectroryNamesToolStripMenuItem";
            _TextStringHashToolStripMenuItem.Name = "TextStringHashToolStripMenuItem";
            _GetDirFilesByFilterToolStripMenuItem.Name = "GetDirFilesByFilterToolStripMenuItem";
            _GenWhereINDictToolStripMenuItem.Name = "GenWhereINDictToolStripMenuItem";
            _NetworkListenerToolStripMenuItem.Name = "NetworkListenerToolStripMenuItem";
            _SQLiteDBConnectToolStripMenuItem.Name = "SQLiteDBConnectToolStripMenuItem";
            _ExitToolStripMenuItem.Name = "ExitToolStripMenuItem";
            _AboutToolStripMenuItem.Name = "AboutToolStripMenuItem";
            _OnlineHelpToolStripMenuItem.Name = "OnlineHelpToolStripMenuItem";
            _AppConfigVersionToolStripMenuItem.Name = "AppConfigVersionToolStripMenuItem";
            _RunningArchiverToolStripMenuItem.Name = "RunningArchiverToolStripMenuItem";
            _ParameterExecutionToolStripMenuItem.Name = "ParameterExecutionToolStripMenuItem";
            _HistoryToolStripMenuItem.Name = "HistoryToolStripMenuItem";
            _dgRss.Name = "dgRss";
            _btnRemoveRSSfeed.Name = "btnRemoveRSSfeed";
            _btnAddRssFeed.Name = "btnAddRssFeed";
            _btnRemoveWebPage.Name = "btnRemoveWebPage";
            _btnSaveWebPage.Name = "btnSaveWebPage";
            _dgWebPage.Name = "dgWebPage";
            _btnRemoveWebSite.Name = "btnRemoveWebSite";
            _btnSaveWebSite.Name = "btnSaveWebSite";
            _dgWebSite.Name = "dgWebSite";
            _btnDefaultAsso.Name = "btnDefaultAsso";
            _btnRefreshDefaults.Name = "btnRefreshDefaults";
        }

        // Dim ProxySearch As New SVCSearch.Service1Client
        // Dim ProxyArchive As New SVCCLCArchive.Service1Client
        // Dim ProxyFS As New SVCFS.Service1Client

        public List<string> GraphicDict = new List<string>();
        public Dictionary<string, string> ZipDict = new Dictionary<string, string>();
        public string AllowDuplicateFiles = System.Configuration.ConfigurationManager.AppSettings["AllowDuplicateFiles"];
        private string LoggingPath = System.Configuration.ConfigurationManager.AppSettings["LoggingPath"];
        private string TRACEFLOW = System.Configuration.ConfigurationManager.AppSettings["TRACEFLOW"];
        private string VerifyEmbeddedZipFiles = "";
        private bool SkipPermission = false;
        private bool LocalDBBackUpComplete = false;
        private Dictionary<string, string> DirectoryList = new Dictionary<string, string>();
        private bool bUseRemoteServer = false;
        private string MachineIDcurr = "";
        private string UIDcurr = "";
        private bool ArgsPassedIn = false;
        private int gbEmailWidth = 0;
        private string[] args = null;
        private clsSAVEDITEMS SI = new clsSAVEDITEMS();
        private clsIsolatedStorage ISO = new clsIsolatedStorage();
        private clsDbLocal DBLocal = new clsDbLocal();
        private clsRegistry REG = new clsRegistry();
        private clsLicenseMgt LM = new clsLicenseMgt();
        private List<string> AssignedLibraries = new List<string>();
        private bool ArchiveActive = false;
        private Thread ActivityThread;
        private bool LoginAsNewUser = false;
        private Thread t2;
        private Thread t3;
        private Thread t4;
        private Thread t5;
        private Thread t6;
        private Thread t7;
        private Thread t8;
        private Thread t;
        private object UseLocalSettingsOnly = "0";
        private bool UseThreads = true;
        public int AutoExecCheck = 0;
        public int ThreadCnt = 0;
        private bool MiniArchiveRunning = false;
        private bool ListenersDefined = false;
        private bool ListenForChanges = false;
        private bool ListenDirectory = false;
        private bool ListenSubDirectory = false;
        private string DirGuid = "";
        private string MachineName = Environment.MachineName.ToString();
        private bool FoldersRefreshed = false;
        private bool AllEmailFoldersShowing = false;
        private bool bApplyingDirParms = false;
        private bool bSingleInstanceContent = true;
        private bool bAddThisFileAsNewVersion = false;
        private int NbrFilesInDir = 0;
        private string ParentFolder = "";
        private string FQNFolder = "";
        private bool bActiveChange = false;
        private bool isOutlookAvail = false;
        public int EmailsBackedUp = 0;
        public int EmailsSkipped = 0;
        private string CurrentDirectory = "";
        private double ImageSizeDouble = 0d;
        private string ImageGuid = "";
        private clsGlobalEntity GE = new clsGlobalEntity();
        private clsListener LISTEN = new clsListener();
        private clsProcess PROC = new clsProcess();
        private bool DisplayActivity = false;
        private bool isAdmin = false;
        private clsAutoLibRef ALR = new clsAutoLibRef();
        private bool IncludeListHasChanged = false;
        private clsRecon RECON = new clsRecon();
        private clsArchiver ARCH = new clsArchiver();
        private clsExecParms PARMS = new clsExecParms();
        private clsARCHIVESTATS STATS = new clsARCHIVESTATS();
        private clsAVAILFILETYPESUNDEFINED UNASGND = new clsAVAILFILETYPESUNDEFINED();
        private clsAppParms AP = new clsAppParms();
        private clsZipFiles ZF = new clsZipFiles();
        private clsUSERS USERS = new clsUSERS();
        private clsMP3 MP3 = new clsMP3();
        private bool MsgNotification = false;
        private clsFileInfo FI = new clsFileInfo();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();

        // Dim KAT As New clsChilKat

        // Dim CMODI As New clsModi

        // Public gCurrUserGuidID = ""
        public string CurrIdentity = "";
        private bool formloaded = false;
        private bool bUseAttachData = false;
        private string CompanyID = "";
        private string RepoID = "";
        private clsDataSource_V2 DOCS = new clsDataSource_V2();
        private clsAVAILFILETYPES AVL = new clsAVAILFILETYPES();

        // Dim DBASES As New clsDbARCHS
        private clsEMAILARCHPARMS EMPARMS = new clsEMAILARCHPARMS();
        private clsEMAILFOLDER EMF = new clsEMAILFOLDER();
        private clsEXCLUDEDFILES EXL = new clsEXCLUDEDFILES();
        private clsINCLUDEDFILES INL = new clsINCLUDEDFILES();
        private clsReconUSERS RUSER = new clsReconUSERS();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsRUNPARMS RPARM = new clsRUNPARMS();
        private clsDIRECTORY DIRS = new clsDIRECTORY();
        private clsSUBDIR SUBDIRECTORY = new clsSUBDIR();
        private clsDma DMA = new clsDma();
        private clsPROCESSFILEAS PFA = new clsPROCESSFILEAS();
        private int CompletedPolls = 0;
        private clsATTRIBUTES ATTRIB = new clsATTRIBUTES();
        private clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
        private clsATTACHMENTTYPE ATCH_TYPE = new clsATTACHMENTTYPE();
        public ArrayList SubDirectories = new ArrayList();
        public ArrayList IncludedTypes = new ArrayList();
        public ArrayList ExcludedTypes = new ArrayList();
        public ArrayList AuthorizedFileTypes = new ArrayList();
        public ArrayList UnAuthorizedFileTypes = new ArrayList();
        private bool ddebug = false;
        private bool bHelpLoaded = false;
        public ArrayList ArchivedEmailFolders = new ArrayList();
        private AppDomain currentDomain = AppDomain.CurrentDomain;

        public void ApplyDDUpdates()
        {
            My.MyProject.Forms.frmDBUpdates.Show();
            My.MyProject.Forms.frmDBUpdates.Hide();
            var DBU = new clsDBUpdate();
            DBU.CheckForDBUpdates();
            DBU = null;
            My.MyProject.Forms.frmDBUpdates.Close();
        }

        public bool ckFormOpen(string fname)
        {
            bool xb = false;
            foreach (var form in My.MyProject.Application.OpenForms)
            {
                if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(form.name, fname, false)))
                {
                    if (Conversions.ToBoolean(form.Visible))
                    {
                        xb = true;
                    }
                }
            }

            return xb;
        }

        public void setLastArchiveLabel()
        {
            if (modGlobals.gUseLastArchiveDate.Equals("1"))
            {
                lblUseLastArchiveDate.Text = "Last Arch ON: " + modGlobals.gLastArchiveDate.ToString();
                lblUseLastArchiveDate.BackColor = Color.Green;
                lblUseLastArchiveDate.ForeColor = Color.White;
            }
            else
            {
                lblUseLastArchiveDate.Text = "Last Arch OFF";
                lblUseLastArchiveDate.BackColor = Color.Red;
                lblUseLastArchiveDate.ForeColor = Color.Yellow;
            }
        }

        private void frmReconMain_Load(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string OSVer = UTIL.getOsVersion();
            bool isLongFileNamesAvail = UTIL.isLongFileNamesAvail();
            updateMessageBar("Applying any needed updates, standby...");
            ApplyDDUpdates();
            DBLocal.setFirstUseLastArchiveDateActive();
            DBLocal.getUseLastArchiveDateActive();
            setLastArchiveLabel();
            getListeners();

            // INSERT ALL THE REPO ALLOWED EXTENSIONS INTO THE SQLITE DB
            var AllowedExts = DBARCH.getUsedExtension();
            DBLocal.resetExtension();
            DBLocal.addExtension(AllowedExts);
            bool ContentOnly = false;
            bool OutlookOnly = false;
            bool ExchangeOnly = false;
            bool ArchiveALL = false;
            double LL = 0d;
            string CurrUserGuidID = "";
            MachineIDcurr = DMA.GetCurrMachineName();
            lblCustomerName.Text = modGlobals.gCustomerName;
            lblCustomerID.Text = modGlobals.gCustomerID;
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9901, "Main", "30");
            modGlobals.ShowMsgHeader("Standby please, fetching setup parameters.");
            LL = 225d;
            UseLocalSettingsOnly = System.Configuration.ConfigurationManager.AppSettings["UseLocalOnly"];
            if (modGlobals.UseDirectoryListener.Equals(1))
            {
                ContentToolStripMenuItem.Text = "Content (Listener ON)";
            }
            else
            {
                ContentToolStripMenuItem.Text = "Content (Quick)";
            }

            string CurrentLoginID = "";
            // CurrentLoginID = System.Environment.UserName

            CurrentLoginID = My.MyProject.Forms.LoginForm1.txtLoginID.Text;
            modGlobals.gCurrLoginID = CurrentLoginID;
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9901, "Main", "40");
            updateMessageBar("1 of 18");
            try
            {
                args = Environment.GetCommandLineArgs();
                LL = 64d;
                modGlobals.gRunMode = "GUI";
                LL = 65d;
                GetQueryStringParameters();
                LL = 69d;
                if (args is object)
                {
                    LL = 66.1d;
                    // ** The only allowed argument is company id and repo id separated by a semicolon
                    // ** Or a directory name with or without a file qualifier.
                    // ** If a directory name is passed in, only that directory will be processed
                    // ** and its subdirectories if specified as such.
                    ArgsPassedIn = true;
                    foreach (string Arg in args)
                    {
                        LL = 67d;
                        if (Conversions.ToBoolean(Strings.InStr(Arg, ";")))
                        {
                            var AA = Arg.Split(';');
                            CompanyID = AA[0];
                            RepoID = AA[1];
                            string sCompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
                            string sRepoID = REG.ReadEcmRegistrySubKey("RepoID");
                            bool bReg = false;
                            if (sCompanyID.Length == 0)
                            {
                                bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID);
                                if (!bReg)
                                {
                                    bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID);
                                }
                            }

                            if (sRepoID.Length == 0)
                            {
                                bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID);
                                if (!bReg)
                                {
                                    bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID);
                                }
                            }
                        }

                        string xArg = Arg.ToString();
                        LL = 68d;
                        LL = 69d;
                        if (Strings.Mid(xArg, 1, 1).Equals("U"))
                        {
                            ArgsPassedIn = true;
                            // Execute archive and close app : LL = 71
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
                            LL = 72d;
                            modGlobals.gCurrLoginID = Strings.Mid(Arg, 2);
                            LL = 73d;
                            CurrentLoginID = modGlobals.gCurrLoginID;
                            SB2.Text = "Running as : '" + modGlobals.gCurrLoginID + "'";
                            LL = 74d;
                            SB.Text = "Running as : '" + modGlobals.gCurrLoginID + "'";
                            LL = 75d;
                        }

                        LL = 76d;
                        if (Arg.ToUpper().Equals("U"))
                        {
                            ArgsPassedIn = true;
                            // Execute archive and close app : LL = 78
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
                            LL = 79d;
                            modGlobals.gCurrLoginID = Strings.Mid(Arg, 2);
                            LL = 80d;
                            CurrentLoginID = modGlobals.gCurrLoginID;
                            SB2.Text = "Running as : '" + modGlobals.gCurrLoginID + "'";
                            LL = 81d;
                            SB.Text = "Running as : '" + modGlobals.gCurrLoginID + "'";
                            LL = 82d;
                        }

                        LL = 83d;
                        if (Arg.ToUpper().Equals("P"))
                        {
                            ArgsPassedIn = true;
                            // Execute archive and close app : LL = 85
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
                            LL = 86d;
                            modGlobals.gEncPassword = Strings.Mid(Arg, 2);
                            LL = 87d;
                            modGlobals.gUnEncPassword = ENC.AES256DecryptString(modGlobals.gEncPassword);
                            LL = 88d;
                        }

                        LL = 89d;
                        if (Arg.ToUpper().Equals("RUV"))
                        {
                            ArgsPassedIn = true;
                            LOG.WriteToArchiveLog("Notification: upgrading user settings.");
                            LL = 91d;
                            My.MySettingsProperty.Settings["UpgradeSettings"] = true;
                            LL = 92d;
                            My.MySettingsProperty.Settings.Save();
                            LL = 93d;
                        }

                        LL = 94d;
                        if (Arg.ToUpper().Equals("X"))
                        {
                            ArgsPassedIn = true;
                            // Execute archive and close app : LL = 96
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute archive and close app.");
                            LL = 97d;
                            modGlobals.gRunMode = "X";
                            LL = 98d;
                            modGlobals.gRunMinimized = true;
                            LL = 99d;
                            modGlobals.gRunUnattended = true;
                            LL = 100d;
                            WindowState = FormWindowState.Minimized;
                            LL = 101d;
                        }

                        LL = 102d;
                        if (Arg.ToUpper().Equals("A"))
                        {
                            ArgsPassedIn = true;
                            // Execute archive and close app : LL = 104
                            LOG.WriteToArchiveLog("Notification: Scheduled Execute ALL archives.");
                            LL = 105d;
                            modGlobals.gRunMode = "X";
                            LL = 106d;
                            modGlobals.gContentArchiving = true;
                            LL = 107d;
                            modGlobals.gContactsArchiving = true;
                            modGlobals.gOutlookArchiving = true;
                            LL = 108d;
                            modGlobals.gExchangeArchiving = true;
                            LL = 109d;
                            ArchiveALL = true;
                            LL = 110d;
                            modGlobals.gRunMinimized = true;
                            LL = 111d;
                            modGlobals.gRunUnattended = true;
                            LL = 112d;
                        }
                        // ArchiveALLToolStripMenuItem_Click(Nothing, Nothing) : LL = 113
                        else
                        {
                            if (Arg.ToUpper().Equals("C"))
                            {
                                ArgsPassedIn = true;
                                modGlobals.gContentArchiving = false;
                                LL = 116d;
                                modGlobals.gContactsArchiving = false;
                                LOG.WriteToArchiveLog("Notification: Scheduled Execute CONTENT archives.");
                                LL = 117d;
                                // Execute archive and close app : LL = 118
                                ContentOnly = true;
                                LL = 119d;
                                modGlobals.gRunMinimized = true;
                                LL = 120d;
                                modGlobals.gRunUnattended = true;
                                LL = 121d;
                                modGlobals.gContentArchiving = true;
                                LL = 122d;
                                modGlobals.gContactsArchiving = true;
                                modGlobals.gOutlookArchiving = false;
                                LL = 123d;
                                modGlobals.gExchangeArchiving = false;
                                LL = 124d;
                            }

                            LL = 125d;
                            if (Arg.ToUpper().Equals("O"))
                            {
                                ArgsPassedIn = true;
                                LOG.WriteToArchiveLog("Notification: Scheduled Execute OUTLOOK archives.");
                                LL = 127d;
                                // Execute outlook and close app : LL = 128
                                modGlobals.gOutlookArchiving = false;
                                LL = 129d;
                                ExchangeOnly = true;
                                LL = 130d;
                                modGlobals.gRunMinimized = true;
                                LL = 131d;
                                modGlobals.gRunUnattended = true;
                                LL = 132d;
                                modGlobals.gContentArchiving = false;
                                LL = 133d;
                                modGlobals.gContactsArchiving = false;
                                modGlobals.gOutlookArchiving = true;
                                LL = 134d;
                                modGlobals.gExchangeArchiving = false;
                                LL = 135d;
                            }

                            LL = 136d;
                            if (Arg.ToUpper().Equals("E"))
                            {
                                ArgsPassedIn = true;
                                LOG.WriteToArchiveLog("Notification: Scheduled Execute EXCHANGE archives.");
                                LL = 138d;
                                // Execute Exchange and close app : LL = 139
                                modGlobals.gExchangeArchiving = false;
                                LL = 140d;
                                OutlookOnly = true;
                                LL = 141d;
                                modGlobals.gRunMinimized = true;
                                LL = 142d;
                                modGlobals.gRunUnattended = true;
                                LL = 143d;
                                modGlobals.gContentArchiving = false;
                                LL = 144d;
                                modGlobals.gContactsArchiving = false;
                                modGlobals.gOutlookArchiving = false;
                                LL = 145d;
                                modGlobals.gExchangeArchiving = true;
                                LL = 146d;
                            }

                            LL = 147d;
                        }

                        LL = 148d;
                        LL = 149d;
                        if (Arg.ToUpper().Equals("?"))
                        {
                            string MSG = "";
                            LL = 151d;
                            MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 152d;
                            MSG = MSG + "CompanyID;RepoID" + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 153d;
                            MSG = MSG + "X = Execute archive and close." + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 153d;
                            MSG = MSG + "C = Archive CONTENT only." + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 154d;
                            MSG = MSG + "O = Archive OUTLOOK only." + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 155d;
                            MSG = MSG + "E = Archive EXCHANGE Servers only." + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 156d;
                            MSG = MSG + "A = Archive ALL." + Constants.vbCrLf + Constants.vbCrLf;
                            LL = 157d;
                            MSG = MSG + "To Execute:" + Constants.vbCrLf;
                            LL = 158d;
                            MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + Constants.vbCrLf;
                            LL = 159d;
                            MSG = MSG + @"(E.G.) C:\dev\ECM\EcmLibSvc\EcmLibSvc\bin\Debug\EcmArchiveSetup.exe Q" + Constants.vbCrLf;
                            LL = 160d;
                            MessageBox.Show(MSG);
                            LL = 161d;
                            Environment.Exit(0);
                            LL = 162d;
                        }

                        LL = 163d;
                    }
                }
                else
                {
                    ArgsPassedIn = false;
                }

                LL = 165.01d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "50");
                updateMessageBar("2 of 18");
                modGlobals.gCurrentConnectionString = "";
                LL = 166.1d;
                try
                {
                    CompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
                    LL = 167.2d;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 03 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                    CompanyID = "";
                    LL = 167.21d;
                }

                try
                {
                    RepoID = REG.ReadEcmRegistrySubKey("RepoID");
                    LL = 168.3d;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 04 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                    RepoID = "";
                    LL = 168.31d;
                }

                // gCurrentConnectionString = REG.ReadEcmRegistrySubKey("EncConnectionString")
                if (CompanyID is null)
                {
                    LL = 168.31d;
                    CompanyID = modGlobals.gCustomerID;
                    LL = 168.32d;
                }

                if (RepoID is null)
                {
                    LL = 168.33d;
                    RepoID = modGlobals.gRepoID;
                }

                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "60");
                if (modGlobals.gCustomerID.Trim().Length > 0 & modGlobals.gRepoID.Trim().Length > 0)
                {
                    LL = 165.4d;
                    // Dim ProxyGateway As New SVCGateway.Service1Client : LL = 165.5
                    string EncCS = "";
                    bool RC = false;
                    string RetMsg = "";
                    LL = 165.6d;

                    // If (ProxyGateway Is Nothing) Then
                    // ProxyGateway = New SVCGateway.Service1Client
                    // End If
                    EncCS = DBARCH.setConnStr();
                    LL = 165.7d;
                    if (EncCS.Trim().Length > 0)
                    {
                        LL = 165.7d;
                        modGlobals.gCurrentConnectionString = ENC.AES256DecryptString(EncCS);
                        LL = 165.8d;
                        if (modGlobals.gCurrentConnectionString.Length > 0)
                        {
                            bool bReg = REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS);
                            LL = 165.9d;
                            if (!bReg)
                            {
                                LL = 165.1d;
                                bReg = REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS);
                                LL = 165.11d;
                            }

                            LL = 165.12d;
                        }
                    }
                    else
                    {
                        LL = 165.13d;
                        modGlobals.gCurrentConnectionString = "";
                        LL = 165.14d;
                    }

                    LL = 165.15d;
                    // ProxyGateway = Nothing
                    bUseAttachData = true;
                    LL = 165.16d;
                }
                else
                {
                    LL = 165.17d;
                    bUseAttachData = false;
                    LL = 165.18d;
                }

                LL = 165.19d;
                // bUseAttachData = ISO.ReadAttachData(CompanyID, RepoID)
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "70");
                string defaultUserId = My.MySettingsProperty.Settings.DefaultLoginID;
                LL = 165.2d;
                if (defaultUserId.Trim().Length > 0)
                {
                    LL = 165.3d;
                    CurrentLoginID = defaultUserId;
                    LL = 165.4d;
                    string EPW = My.MySettingsProperty.Settings.DefaultLoginPW;
                    LL = 165.5d;
                    EPW = ENC.AES256DecryptString(EPW);
                    LL = 165.6d;
                }

                LL = 165.7d;
                updateMessageBar("3 of 18");
                bool bDbConnectionGood = DBARCH.ckDbConnection("frmMain 100");
                LL = 200.1d;
                if (bDbConnectionGood == false)
                {
                    LL = 201.2d;
                    if (modGlobals.gRunUnattended == true)
                    {
                        LL = 202.1d;
                        LOG.WriteToArchiveLog("ABORTING frmReconMain_Load run - Failed to connect to the database, closing ECM.");
                        LL = 203.1d;
                        Application.Exit();
                    }
                    else
                    {
                        LL = 204.1d;
                        string ConnStr = DBARCH.getRepoConnStr();
                        MessageBox.Show("ABORTING - Failed to connect to the database, contact an administrator - closing ECM." + Constants.vbCrLf + ConnStr);
                        LL = 205.1d;
                        Application.Exit();
                    }

                    tsTunnelConn.Text = "Tunnel:OFF";
                }
                else
                {
                    tsTunnelConn.Text = "Tunnel:ON";
                }

                LL = 213.15d;
                string strGateWayID = modGlobals.gGateWayID.ToString();
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "80");
                updateMessageBar("4 of 18");
                // If (ProxyArchive Is Nothing) Then
                // gResetEndpoints = True
                // Dim retc As Boolean = setGatewayEndpoints() : LL = 213.16
                // End If
                LL = 213.17d;
                if (modGlobals.gLoginValidated == false)
                {
                    modGlobals.gLoginValidated = DBARCH.ckDbConnection("XX001");
                }

                LL = 213.2d;
                if (modGlobals.gLoginValidated)
                {
                    LL = 213.3d;
                    tsServiceDBConnState.Text = "SaaS:ON";
                }
                else
                {
                    LL = 213.4d;
                    tsServiceDBConnState.Text = "SaaS:OFF";
                    MessageBox.Show("Could not attach - closing the application: " + strGateWayID.ToString() + " : " + CurrentLoginID.ToString() + " : " + MachineIDcurr.ToString());
                    Application.Exit();
                }

                LL = 213.5d;
                ImpersonateLoginToolStripMenuItem.Visible = false;
                int iRunningInstances = 0;
                LL = 213.6d;
                iRunningInstances = UTIL.countApplicationInstances("ECMARCHIVESETUP");
                LL = 213.7d;
                if (iRunningInstances > 2)
                {
                    LL = 213.8d;
                    My.MyProject.Forms.frmMsg.txtMsg.Text = "ECM Archiver already running - closing.";
                    LL = 213.9d;
                    My.MyProject.Forms.frmMsg.Show();
                    Thread.Sleep(10000);
                    Environment.Exit(0);
                }

                LL = 213.11d;
                updateMessageBar("5 of 18");
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "90");
                string PrevArchiverExecPath = "";
                try
                {
                    REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath);
                    LL = 7.11d;
                    PrevArchiverExecPath = REG.ReadEcmRegistrySubKey("EcmArchiverDir");
                    LL = 7.12d;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 4 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                    REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath);
                    LL = 9.1d;
                }

                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "100");
                if (PrevArchiverExecPath.Length == 0)
                {
                    LL = 8d;
                    REG.UpdateEcmRegistrySubKey("EcmArchiverDir", Application.ExecutablePath);
                    LL = 9.2d;
                }

                LL = 10d;
                string CurrAppExecPath = Application.ExecutablePath;
                LL = 11d;
                string CurrBuildDate = "";
                LL = 13d;
                var fApp = new FileInfo(CurrAppExecPath);
                LL = 14d;
                CurrBuildDate = fApp.CreationTime.ToString();
                LL = 15d;
                fApp = null;
                LL = 16d;
                string CurrBuildID = System.Configuration.ConfigurationManager.AppSettings["ArchiverBuildID"];
                LL = 18d;
                string PrevArchiverBuildID = REG.ReadEcmRegistrySubKey("EcmArchiverBuildID");
                LL = 19d;
                if (PrevArchiverBuildID == null)
                {
                    LL = 20d;
                    REG.CreateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID);
                    LL = 21d;
                }

                LL = 22d;
                LL = 23d;
                string PrevArchiverBuildDate = REG.ReadEcmRegistrySubKey("EcmSetupAppCreateDate");
                LL = 24d;
                if (PrevArchiverBuildDate.Trim().Length == 0)
                {
                    LL = 25d;
                    REG.CreateEcmRegistrySubKey("EcmSetupAppCreateDate", CurrBuildDate.ToString());
                    LL = 26d;
                }

                LL = 27d;
                LL = 28d;
                if (!CurrBuildDate.Equals(PrevArchiverBuildDate))
                {
                    LL = 29d;
                    // ** Resync all scheduled archive jobs to point to the new path. : LL = 30
                    Console.WriteLine("Resync archive jobs.");
                    LL = 31d;
                    My.MyProject.Forms.frmSchedule.ValidateExecPath();
                    LL = 32d;
                }

                LL = 33d;
                if (!PrevArchiverExecPath.Equals(Application.ExecutablePath))
                {
                    LL = 34d;
                    // ** Resync all scheduled archive jobs to point to the new path. : LL = 35
                    Console.WriteLine("Resync archive jobs.");
                    LL = 36d;
                    My.MyProject.Forms.frmSchedule.ValidateExecPath();
                    LL = 37d;
                }

                LL = 38d;
                LL = 39d;
                if (!CurrBuildID.Equals(PrevArchiverBuildID))
                {
                    LL = 40d;
                    // ** Resync all scheduled archive jobs to point to the new path. : LL = 41
                    Console.WriteLine("Resync archive jobs.");
                    LL = 42d;
                    My.MyProject.Forms.frmSchedule.ValidateExecPath();
                    LL = 43d;
                    REG.UpdateEcmRegistrySubKey("EcmArchiverBuildID", CurrBuildID);
                    LL = 44d;
                }

                LL = 45d;
                LL = 46d;
                modGlobals.gContentArchiving = false;
                LL = 47d;
                modGlobals.gOutlookArchiving = false;
                LL = 48d;
                modGlobals.gExchangeArchiving = false;
                LL = 49d;
                modGlobals.gContactsArchiving = false;
                LL = 50d;
                REG.CreateEcmSubKey();
                LL = 51d;
                REG.SetEcmSubKey();
                LL = 52d;
                Console.WriteLine(REG.ReadEcmSubKey(""));
                LL = 53d;
                TimerEndRun.Enabled = false;
                LL = 54d;
                // Timer1.Enabled = False : LL = 55
                TimerUploadFiles.Enabled = false;
                LL = 56d;
                TimerListeners.Enabled = false;
                LL = 57d;
                LL = 58d;
                bool B = false;
                LL = 59d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "110");
                if (modGlobals.gRunMode == "X")
                {
                    LL = 167d;
                    WindowState = FormWindowState.Minimized;
                    LL = 168d;
                }

                LL = 169d;
                updateMessageBar("6 of 18");
                try
                {
                    LL = 171d;
                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(My.MySettingsProperty.Settings["UpgradeSettings"], true, false)))
                    {
                        LL = 172d;
                        try
                        {
                            LL = 173d;
                            LOG.WriteToArchiveLog("**********************************************");
                            LL = 174d;
                            LOG.WriteToArchiveLog("NOTICE frmMain: New INSTALL detected 100");
                            LL = 174d;
                            My.MySettingsProperty.Settings.Upgrade();
                            LL = 175d;
                            My.MySettingsProperty.Settings.Reload();
                            LL = 176d;
                            My.MySettingsProperty.Settings["UpgradeSettings"] = false;
                            LL = 177d;
                            My.MySettingsProperty.Settings.Save();
                            LL = 178d;
                            LOG.WriteToInstallLog(Conversions.ToString(Operators.AddObject("NOTICE: New INSTALL detected 200: ", My.MySettingsProperty.Settings["UserDefaultConnString"])));
                            LL = 179d;
                            LOG.WriteToInstallLog(Conversions.ToString(Operators.AddObject("NOTICE: New INSTALL detected 300: ", My.MySettingsProperty.Settings["UserThesaurusConnString"])));
                            LL = 180d;
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 5 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (Exception ex)
                        {
                            LL = 181d;
                            var st = new StackTrace(true);
                            st = new StackTrace(ex, true);
                            LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                            LOG.WriteToInstallLog("ERROR: INSTALL 100: " + ex.Message);
                            LL = 182d;
                        }

                        LL = 183d;
                    }
                    else
                    {
                        LL = 184d;
                        LOG.WriteToInstallLog("NOTICE: NO New INSTALL 100-A");
                        LL = 185d;
                    }

                    LL = 186d;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 6 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    LL = 187d;
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                    Console.WriteLine("ERROR 1XA1: - " + ex.Message);
                    LL = 188d;
                }

                LL = 189d;
                LL = 190d;
                My.MySettingsProperty.Settings["UpgradeSettings"] = false;
                LL = 191d;
                My.MySettingsProperty.Settings.Save();
                LL = 192d;
                string strUseRemoteServer = System.Configuration.ConfigurationManager.AppSettings["UseRemoteServer"];
                LL = 193d;
                if (strUseRemoteServer.Equals("1"))
                {
                    LL = 194d;
                    modGlobals.gCurrThesaurusCS = DBARCH.getThesaurusConnStr();
                    LL = 195d;
                    modGlobals.gCurrRepositoryCS = DBARCH.getRepoConnStr();
                    LL = 196d;
                }
                else
                {
                    modGlobals.gCurrThesaurusCS = REG.ReadEcmCurrentConnectionString("TheasaurusCS");
                    LL = 197d;
                    modGlobals.gCurrRepositoryCS = REG.ReadEcmCurrentConnectionString("RepositoryCS");
                    LL = 198d;
                }

                LL = 199d;
                updateMessageBar("7 of 18");
                B = DBARCH.ckDbConnection("frmMain 100");
                LL = 200d;
                if (B == false)
                {
                    LL = 201d;
                    if (modGlobals.gRunUnattended == true)
                    {
                        LL = 202d;
                        LOG.WriteToArchiveLog("ABORTING - Failed to connect to the database, closing ECM.");
                        LL = 203d;
                        Application.Exit();
                    }
                    else
                    {
                        LL = 204d;
                        MessageBox.Show("ABORTING - Failed to connect to the database, closing ECM.");
                        LL = 205d;
                        Application.Exit();
                    }

                    LL = 212d;
                }

                LL = 213d;
                LL = 214d;
                // ************************ : LL = 215
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "120");
                SetDateFormats();
                LL = 216d;
                // ************************ : LL = 217
                LL = 218d;
                bool bLicenseExists = DBARCH.LicenseExists();
                LL = 219d;
                if (bLicenseExists == false)
                {
                    LL = 220d;
                    string msg = "ABORTING - A license for the product does not exist - contact an administrator. ";
                    MessageBox.Show(msg);
                    Application.Exit();
                }

                LL = 223d;
                LL = 224d;
                updateMessageBar("8 of 18");
                LL = 226d;
                ListenersDefined = DBARCH.isListeningOn();
                LL = 227d;
                LL = 228d;
                string sDebug = DBARCH.getUserParm("debug_SetupScreen");
                LL = 229d;
                LL = 237d;
                string ImpersonateID = "";
                bool bImpersonateID = UTIL.isImpersonationSet(ref ImpersonateID);
                if (bImpersonateID)
                {
                    modGlobals.gCurrLoginID = ImpersonateID;
                    CurrentLoginID = ImpersonateID;
                    CurrUserGuidID = DBARCH.getUserGuidByLoginID(ImpersonateID);
                    LogIntoSystem(CurrentLoginID);
                    LL = 238d;
                    modGlobals.gCurrLoginID = CurrentLoginID;
                }
                else
                {
                    LogIntoSystem(modGlobals.gCurrLoginID);
                    LL = 238d;
                }

                ckLicense();
                LL = 240d;
                CurrentLoginID = My.MyProject.Forms.LoginForm1.txtLoginID.Text;
                modGlobals.gCurrLoginID = CurrentLoginID;
                CurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID);
                LL = 279d;
                modGlobals.gCurrUserGuidID = CurrUserGuidID;
                UIDcurr = CurrUserGuidID;
                if (CurrUserGuidID.Length == 0)
                {
                    // ** This can be caused by IMPERSONATION using an unidentified user id.
                    // ** Start by removing impersonation.
                    string msg = "The USER ID currently in use, '" + modGlobals.gCurrUserGuidID + "', is not identified to the database, please contact an administrator. Exiting the program.";
                    MessageBox.Show(msg);
                    return;
                    LL = 243d;
                }

                LL = 244d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "130");
                formloaded = true;
                LL = 246d;
                modResizeForm.GetLocation(this);
                LL = 247d;
                formloaded = false;
                LL = 248d;
                isAdmin = DBARCH.isAdmin(CurrUserGuidID);
                LL = 250d;
                if (modGlobals.HelpOn)
                {
                    LL = 252d;
                    Form argfrm = this;
                    var argTT = TT;
                    DBARCH.getFormTooltips(ref argfrm, ref argTT, true);
                    TT = argTT;
                    LL = 253d;
                    TT.Active = true;
                    LL = 254d;
                    bHelpLoaded = true;
                    LL = 255d;
                }
                else
                {
                    LL = 256d;
                    TT.Active = false;
                    LL = 257d;
                }

                LL = 258d;
                LL = 259d;
                TT.SetToolTip(ckPublic, "Check this item to set all contents of the selected directory to PUBLIC access.");
                LL = 263d;
                TT.SetToolTip(btnDeleteEmailEntry, "Press to remove the selected archive mail folder.");
                LL = 264d;
                TT.SetToolTip(btnRefreshFolders, "Press to show all of your available mail folders.");
                LL = 265d;
                TT.SetToolTip(btnActive, "Press to how only the folders you have selected for archive.");
                LL = 266d;
                TT.SetToolTip(ckDisable, "Check to disable automatic archiving.");
                LL = 267d;
                TT.SetToolTip(btnAddFiletype, "Add the new file type to those available.");
                LL = 268d;
                TT.SetToolTip(ckRemoveFileType, "Remove the selected file type from those available.");
                LL = 269d;
                if (modGlobals.HelpOn)
                {
                    LL = 271d;
                    TT.Active = true;
                    LL = 272d;
                }
                else
                {
                    LL = 273d;
                    TT.Active = false;
                    LL = 274d;
                }

                LL = 275d;
                if (CurrUserGuidID.Length == 0)
                {
                    LL = 277d;
                    CurrentLoginID = Environment.UserName;
                    LL = 278d;
                    CurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID);
                    LL = 279d;
                }

                LL = 280d;
                if (isAdmin == true)
                {
                    LL = 282d;
                    clAdminDir.Enabled = true;
                    LL = 283d;
                    ckSystemFolder.Enabled = true;
                    LL = 284d;
                }
                else
                {
                    LL = 285d;
                    clAdminDir.Enabled = false;
                    LL = 286d;
                    ckSystemFolder.Enabled = false;
                    LL = 287d;
                }

                LL = 288d;
                clAdminDir.Visible = true;
                LL = 289d;
                formloaded = false;
                LL = 290d;
                string TgtFolder = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
                bool bOutlook = UTIL.isOutLookRunning();
                LL = 291d;
                if (bOutlook == true)
                {
                    My.MyProject.Forms.frmOutlookNotice.Show();
                }

                LL = 292d;
                modGlobals.setMsgHeader("Fetching outlook folder names.");
                LL = 293d;
                ARCH.OutlookFolderNames(TgtFolder);
                LL = 294d;
                isOutlookAvail = ARCH.getCurrentOutlookFolders(TgtFolder, ref modGlobals.CF);
                LL = 295d;
                ARCH.setChildFoldersList(modGlobals.CF);
                LL = 296d;
                My.MyProject.Forms.frmOutlookNotice.Close();
                LL = 297d;
                My.MyProject.Forms.frmOutlookNotice.Hide();
                LL = 298d;
                ARCH.HistoryFolderExists();
                LL = 299d;

                // ** UPDATE THE CURRENT FOLDERS TO CONTAIN THE FOLDERID'S : LL = 331
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "140");
                updateMessageBar("9 of 18");
                LL = 332d;
                foreach (var SS in modGlobals.CF.Keys)
                {
                    LL = 333d;
                    string CurrName = SS.ToString();
                    LL = 334d;
                    int iKey = modGlobals.CF.IndexOfKey(CurrName);
                    LL = 336d;
                    string CurrKey = modGlobals.CF[CurrName];
                    LL = 337d;
                    string MySql = "";
                    LL = 339d;
                    CurrName = UTIL.RemoveSingleQuotes(CurrName);
                    LL = 340d;
                    ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder);
                    LL = 341d;
                    MySql = "update EmailFolder set FolderID = '" + CurrKey + "' where FolderName = '" + CurrName + "' and ParentFolderName  = '" + ParentFolder + "' ";
                    LL = 342d;
                    bool B1 = DBARCH.ExecuteSqlNewConn(MySql, false);
                    LL = 343d;
                    if (!B1)
                    {
                        LL = 344d;
                        if (ddebug)
                        {
                            LOG.WriteToArchiveLog("NOTICE frmMain:Load process 5X.1 unsuccessful.");
                            LL = 345d;
                        }
                    }

                    LL = 346d;
                }

                LL = 347d;
                // End If : LL = 348
                LL = 349d;
                CurrIdentity = DBARCH.getUserLoginByUserid(CurrUserGuidID);
                LL = 350d;
                if (CurrIdentity.Trim().Length == 0)
                {
                    LL = 351d;
                    return;
                    LL = 352d;
                }

                LL = 353d;
                // SB.Text = "Current User: " + System.Environment.UserName : LL = 354
                SB.Text = "Current User: " + CurrIdentity;
                LL = 355d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 5 successful.");
                    LL = 356d;
                }

                try
                {
                    LL = 357d;
                    modGlobals.setMsgHeader("Setting process memory, just a moment.");
                    LL = 358d;
                    ARCH.DeleteOutlookMessages(CurrUserGuidID);
                    LL = 359d;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    LL = 360d;
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                    LOG.WriteToArchiveLog("WARNING 2005.32.22 - call DeleteOutlookMessages failed.");
                    LL = 361d;
                }

                LL = 362d;
                LL = 363d;
                modGlobals.setMsgHeader("Initializing archive parameters, this could take a few seconds.");
                LL = 364d;
                ckInitialData();
                LL = 365d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "150");
                var argCB = cbFileTypes;
                DBARCH.LoadAvailFileTypes(ref argCB);
                cbFileTypes = argCB;
                LL = 367d;
                var argCB1 = cbPocessType;
                DBARCH.LoadAvailFileTypes(ref argCB1);
                cbPocessType = argCB1;
                LL = 368d;
                var argCB2 = cbAsType;
                DBARCH.LoadAvailFileTypes(ref argCB2);
                cbAsType = argCB2;
                LL = 369d;
                var argLB = lbAvailExts;
                DBARCH.LoadAvailFileTypes(ref argLB);
                lbAvailExts = argLB;
                LL = 370d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 6 successful.");
                    LL = 372d;
                }

                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "160");
                var argCB3 = cbRetention;
                DBARCH.LoadRetentionCodes(ref argCB3);
                cbRetention = argCB3;
                LL = 374d;
                var argCB4 = cbRssRetention;
                DBARCH.LoadRetentionCodes(ref argCB4);
                cbRssRetention = argCB4;
                var argCB5 = cbWebPageRetention;
                DBARCH.LoadRetentionCodes(ref argCB5);
                cbWebPageRetention = argCB5;
                var argCB6 = cbWebSiteRetention;
                DBARCH.LoadRetentionCodes(ref argCB6);
                cbWebSiteRetention = argCB6;
                var argCB7 = cbEmailRetention;
                DBARCH.LoadRetentionCodes(ref argCB7);
                cbEmailRetention = argCB7;
                LL = 375d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "170");
                int IMax = 0;
                LL = 377d;
                var argCB8 = cbParentFolders;
                ARCH.getOutlookParentFolderNames(ref argCB8);
                cbParentFolders = argCB8;
                LL = 378d;
                if (cbParentFolders.Items.Count > 0)
                {
                    LL = 379d;
                    IMax = cbParentFolders.Items.Count - 1;
                    LL = 380d;
                    ParentFolder = cbParentFolders.Items[IMax].ToString();
                    LL = 381d;
                }
                else
                {
                    LL = 382d;
                    ParentFolder = "Unknown";
                    LL = 383d;
                }

                var argLB1 = lbActiveFolder;
                DBARCH.GetActiveEmailFolders(ParentFolder, ref argLB1, CurrUserGuidID, modGlobals.CF, ArchivedEmailFolders);
                lbActiveFolder = argLB1;
                LL = 386d;
                var argCB9 = cbEmailDB;
                DBARCH.GetActiveDatabases(ref argCB9);
                cbEmailDB = argCB9;
                LL = 388d;
                var argCB10 = cbFileDB;
                DBARCH.GetActiveDatabases(ref argCB10);
                cbFileDB = argCB10;
                LL = 389d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 7 successful.");
                    LL = 391d;
                }

                var argLB2 = lbArchiveDirs;
                DBARCH.GetDirectories(ref argLB2, CurrUserGuidID, false);
                lbArchiveDirs = argLB2;
                LL = 393d;
                LL = 394d;
                updateMessageBar("10 of 18");
                GetExecParms();
                LL = 395d;
                LL = 396d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 8a successful.");
                    LL = 397d;
                }

                LL = 398d;
                var argCB11 = cbProcessAsList;
                DBARCH.GetProcessAsList(ref argCB11);
                cbProcessAsList = argCB11;
                LL = 399d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 8b successful.");
                    LL = 400d;
                }

                DBARCH.getExcludedEmails(CurrUserGuidID);
                LL = 401d;
                LL = 402d;
                string tVal = DBARCH.UserParmRetrive("ckUseLastProcessDateAsCutoff", CurrUserGuidID);
                LL = 403d;
                if (tVal.ToUpper().Equals("TRUE"))
                {
                    LL = 404d;
                    ckUseLastProcessDateAsCutoff.Checked = true;
                    LL = 405d;
                }
                else
                {
                    LL = 406d;
                    ckUseLastProcessDateAsCutoff.Checked = false;
                    LL = 407d;
                }

                LL = 408d;
                tVal = DBARCH.UserParmRetrive("ckArchiveBit", CurrUserGuidID);
                LL = 409d;
                if (tVal.ToUpper().Equals("TRUE"))
                {
                    LL = 410d;
                    ckArchiveBit.Checked = true;
                    LL = 411d;
                }
                else
                {
                    LL = 412d;
                    ckArchiveBit.Checked = false;
                    LL = 413d;
                }

                LL = 414d;
                LL = 415d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 9 successful.");
                    LL = 416d;
                }

                LL = 417d;
                string S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] "; // where ProfileName = 'XX'" : LL = 418
                var argCB12 = cbProfile;
                DBARCH.PopulateComboBox(ref argCB12, "ProfileName", S);
                cbProfile = argCB12;
                LL = 419d;
                LL = 420d;
                if (!isOutlookAvail)
                {
                    LL = 421d;
                    ckDisableOutlookEmailArchive.Checked = true;
                    LL = 422d;
                    SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL.";
                    LL = 426d;
                }

                LL = 424d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "180");
                var T = new Thread(GetRidOfOldMessages);
                LL = 429d;
                T.IsBackground = true;
                LL = 430d;
                T.Priority = ThreadPriority.Lowest;
                LL = 431d;
                T.TrySetApartmentState(ApartmentState.STA);
                LL = 432d;
                T.Start();
                LL = 433d;
                LL = 434d;
                formloaded = true;
                LL = 435d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 10 successful.");
                    LL = 436d;
                }

                LL = 437d;
                if (cbParentFolders.Items.Count > 0)
                {
                    LL = 438d;
                    cbParentFolders.Text = Conversions.ToString(cbParentFolders.Items[cbParentFolders.Items.Count - 1]);
                    LL = 439d;
                    btnActive_Click(null, null);
                    LL = 440d;
                }

                LL = 441d;
                updateMessageBar("11 of 18");
                if (modGlobals.gIsServiceManager == true)
                {
                    LL = 444d;
                    gbPolling.Enabled = true;
                    LL = 445d;
                    ckUseLastProcessDateAsCutoff.Enabled = true;
                    LL = 446d;
                    btnRefreshFolders.Enabled = true;
                    LL = 447d;
                    btnActive.Enabled = true;
                    LL = 448d;
                    cbParentFolders.Enabled = true;
                    LL = 450d;
                    lbActiveFolder.Enabled = true;
                    LL = 451d;
                    ckArchiveFolder.Enabled = true;
                    LL = 452d;
                    ckArchiveRead.Enabled = true;
                    LL = 453d;
                    ckRemoveAfterXDays.Enabled = true;
                    LL = 454d;
                    NumericUpDown3.Enabled = true;
                    LL = 455d;
                    ckSystemFolder.Enabled = true;
                    LL = 456d;
                    cbEmailRetention.Enabled = true;
                    LL = 457d;
                    btnSaveConditions.Enabled = true;
                    LL = 458d;
                    btnDeleteEmailEntry.Enabled = true;
                    LL = 459d;
                    OutlookEmailsToolStripMenuItem.Enabled = true;
                    LL = 460d;
                    ExchangeEmailsToolStripMenuItem.Enabled = true;
                    LL = 461d;
                    ContentToolStripMenuItem.Enabled = true;
                    LL = 462d;
                    ArchiveALLToolStripMenuItem.Enabled = true;
                    LL = 463d;
                    ckArchiveBit.Enabled = true;
                    LL = 464d;
                    CkMonitor.Enabled = true;
                    LL = 465d;
                    TT.SetToolTip(CkMonitor, "Not an available selection for the Service Manager.");
                    LL = 466d;
                }
                else
                {
                    LL = 467d;
                    TT.SetToolTip(CkMonitor, "Track changes to this directory instantly.");
                    LL = 468d;
                }

                LL = 469d;
                LOG.WriteToTimerLog("MDIMAIN 01", "isOfficeInstalled01", "START");
                LL = 471d;
                modGlobals.gOfficeInstalled = UTIL.isOfficeInstalled();
                LL = 472d;
                modGlobals.gOffice2007Installed = UTIL.isOffice2007Installed();
                LL = 473d;
                LOG.WriteToTimerLog("MDIMAIN 01", "isOfficeInstalled01", "END", DateAndTime.Now);
                LL = 474d;
                if (modGlobals.gOfficeInstalled == false)
                {
                    LL = 476d;
                    SB.Text = "MS Office appears not to be installed.";
                    LL = 477d;
                }

                LL = 478d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "190");
                if (modGlobals.gOffice2007Installed == false)
                {
                    LL = 479d;
                    // ckOcr.Enabled = False : LL = 480
                    TT.SetToolTip(ckOcr, "Only available when Office 2007 is installed.");
                    LL = 481d;
                    TT.SetToolTip(ckMetaData, "Only available when Office 2007 is installed.");
                    LL = 483d;
                    TT.SetToolTip(ckOcrPdf, "Only available when Office 2007 is installed.");
                    LL = 483d;
                    ckMetaData.Enabled = false;
                    LL = 482d;
                    // ckOcr.Enabled = False : LL = 482
                    // ckOcrPdf.Enabled = False : LL = 482
                }

                LL = 484d;
                if (DBARCH.isPublicAllowed() == false)
                {
                    LL = 486d;
                    ckPublic.Visible = false;
                    LL = 487d;
                }
                else
                {
                    LL = 488d;
                    ckPublic.Visible = true;
                    LL = 489d;
                }

                LL = 490d;
                btnInclFileType.Visible = false;
                LL = 492d;
                btnExclude.Visible = false;
                LL = 493d;
                S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
                LL = 495d;
                var argCB13 = cbDirProfile;
                DBARCH.PopulateComboBox(ref argCB13, "ProfileName", S);
                cbDirProfile = argCB13;
                LL = 496d;
                lbActiveFolder.Items.Clear();
                LL = 498d;
                LL = 499d;
                if (isAdmin == false)
                {
                    LL = 500d;
                    btnSaveDirProfile.Enabled = false;
                    LL = 501d;
                    btnUpdateDirectoryProfile.Enabled = false;
                    LL = 502d;
                    btnDeleteDirProfile.Enabled = false;
                    LL = 503d;
                    ckArchiveBit.Enabled = false;
                    LL = 504d;
                }

                LL = 505d;
                if (ddebug)
                {
                    LOG.WriteToArchiveLog("frmMain:Load process 11 successful.");
                    LL = 506d;
                }

                modGlobals.CloseMsgHeader();
                LL = 508d;
                SetUnattendedFlag();
                LL = 509d;
                SetUnattendedCheckBox();
                LL = 510d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "200");
                ckPauseListener.Checked = false;
                LL = 512d;
                updateMessageBar("12 of 18");
                int NbrListeners = LISTEN.LoadListeners(MachineName);
                LL = 514d;
                updateMessageBar("13 of 18");
                if (NbrListeners > 0)
                {
                    LL = 516d;
                    TimerUploadFiles.Enabled = true;
                    LL = 517d;
                    TimerListeners.Enabled = true;
                    LL = 518d;
                }
                else
                {
                    LL = 519d;
                    TimerUploadFiles.Enabled = false;
                    LL = 520d;
                    TimerListeners.Enabled = false;
                    LL = 521d;
                }

                LL = 522d;
                if (modGlobals.gRunMinimized)
                {
                    LL = 524d;
                    WindowState = FormWindowState.Minimized;
                    LL = 525d;
                }

                LL = 526d;
                if (modGlobals.gRunMode == "X")
                {
                    LL = 528d;
                    TimerEndRun.Enabled = false;
                    LL = 530d;
                    TimerUploadFiles.Enabled = false;
                    LL = 532d;
                    TimerListeners.Enabled = false;
                    LL = 533d;
                    if (ArchiveALL == true)
                    {
                        LL = 535d;
                        ArchiveALLToolStripMenuItem_Click(null, null);
                        LL = 536d;
                    }
                    else
                    {
                        LL = 537d;
                        if (ContentOnly == true)
                        {
                            LL = 538d;
                            ContentToolStripMenuItem_Click(null, null);
                            LL = 539d;
                        }

                        LL = 540d;
                        if (OutlookOnly == true)
                        {
                            LL = 541d;
                            OutlookEmailsToolStripMenuItem_Click(null, null);
                            LL = 542d;
                        }

                        LL = 543d;
                        if (ExchangeOnly == true)
                        {
                            LL = 544d;
                            ExchangeEmailsToolStripMenuItem_Click(null, null);
                            LL = 545d;
                        }

                        LL = 546d;
                    }

                    LL = 547d;
                }
                else
                {
                    LL = 548d;
                    TimerEndRun.Enabled = false;
                    LL = 549d;
                    TimerUploadFiles.Enabled = false;
                    LL = 551d;
                    TimerListeners.Enabled = true;
                    LL = 552d;
                }

                LL = 553d;
                tssUser.Text = CurrUserGuidID;
                LL = 555d;
                tssAuth.Text = DBARCH.getAuthority(CurrUserGuidID);
                LL = 556d;
                SetVersionAndServer();
                LL = 557d;
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "210");
                if (ArgsPassedIn & (modGlobals.gContactsArchiving | modGlobals.gContentArchiving | modGlobals.gOutlookArchiving | modGlobals.gExchangeArchiving))
                {
                    LL = 559d;
                    string StatusBarMsg = "";
                    if (modGlobals.gExchangeArchiving)
                    {
                        StatusBarMsg += " - Exchange - archiving";
                    }
                    else
                    {
                        StatusBarMsg += " - Exchange - complete";
                    }

                    if (modGlobals.gOutlookArchiving)
                    {
                        StatusBarMsg += " - Outlook - archiving";
                    }
                    else
                    {
                        StatusBarMsg += " - Outlook - complete";
                    }

                    if (modGlobals.gContentArchiving)
                    {
                        StatusBarMsg += " - Content - archiving";
                    }
                    else
                    {
                        StatusBarMsg += " - Content - complete";
                    }

                    if (modGlobals.gContactsArchiving)
                    {
                        StatusBarMsg += " - Contacts - archiving";
                    }
                    else
                    {
                        StatusBarMsg += " - Contacts - complete";
                    }

                    LOG.WriteToArchiveLog("INFO: Auto-archive timer started - " + DateAndTime.Now.ToString());
                    LL = 560d;
                    modGlobals.gRunMinimized = true;
                    LL = 561d;
                    modGlobals.gRunUnattended = true;
                    LL = 562d;
                    WindowState = FormWindowState.Minimized;
                    LL = 563d;
                    int II = 0;
                    LL = 564d;
                    while (modGlobals.gContentArchiving | modGlobals.gOutlookArchiving | modGlobals.gExchangeArchiving | modGlobals.gContentArchiving)
                    {
                        II += 1;
                        LL = 566d;
                        Application.DoEvents();
                        LL = 567d;
                        Thread.Sleep(1000);
                        LL = 568d;
                        tbExchange.Text = "Archive running: " + DateAndTime.Now.ToString() + " / " + II.ToString();
                        if (modGlobals.gExchangeArchiving)
                        {
                            StatusBarMsg += " - Exchange - archiving";
                        }
                        else
                        {
                            StatusBarMsg += " - Exchange - complete";
                        }

                        if (modGlobals.gOutlookArchiving)
                        {
                            StatusBarMsg += " - Outlook - archiving";
                        }
                        else
                        {
                            StatusBarMsg += " - Outlook - complete";
                        }

                        if (modGlobals.gContentArchiving)
                        {
                            StatusBarMsg += " - Content - archiving";
                        }
                        else
                        {
                            StatusBarMsg += " - Content - complete";
                        }

                        if (modGlobals.gContactsArchiving)
                        {
                            StatusBarMsg += " - Contacts - archiving";
                        }
                        else
                        {
                            StatusBarMsg += " - Contacts - complete";
                        }

                        Refresh();
                        LL = 572d;
                    }

                    LL = 573d;
                    LOG.WriteToArchiveLog("INFO: Auto-archive execution ended - " + DateAndTime.Now.ToString());
                    LL = 574d;
                    LOG.WriteToArchiveLog("*****************************************************");
                    LL = 575d;
                    // Application.Exit() : LL = 576
                    Environment.Exit(0);
                    LL = 577d;
                }

                LL = 578d;

                // If ArgsPassedIn Then
                // Application.Exit()
                // End If

                updateMessageBar("14 of 18");
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "220");
                formloaded = false;
                int iHours = Conversions.ToInteger(My.MySettingsProperty.Settings["BackupIntervalHours"]);
                if (iHours > 0)
                {
                    nbrArchiveHours.Value = iHours;
                }

                formloaded = true;

                // If isAdmin Then
                // asyncVerifyRetainDates_DoWork(Nothing, Nothing)
                // End If
                if (Conversions.ToDouble(TRACEFLOW) == 1d)
                    DBARCH.RemoteTrace(9901, "Main", "230");
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                string sMsg = "ERROR frmReconMain_Load 01: " + LL + Constants.vbCrLf + ex.Message;
                LOG.WriteToArchiveLog(sMsg);
                Clipboard.Clear();
                Clipboard.SetText(ex.Message);
                MessageBox.Show("ERROR frmReconMain_Load 01 check the logs: " + LL.ToString() + Constants.vbCrLf + ex.Message);
            }

            if (DBARCH.isAdmin(CurrUserGuidID))
            {
                ImpersonateLoginToolStripMenuItem.Visible = true;
                ckDeleteAfterArchive.Enabled = true;
            }
            else
            {
                ImpersonateLoginToolStripMenuItem.Visible = false;
                ckDeleteAfterArchive.Enabled = false;
            }

            tssUser.Text = CurrUserGuidID;
            LL = 555d;
            tssAuth.Text = DBARCH.getAuthority(CurrUserGuidID);
            LL = 556d;
            SetVersionAndServer();
            modGlobals.gCurrUserGuidID = CurrUserGuidID;
            UIDcurr = CurrUserGuidID;
            tsCurrentRepoID.Text = "Repo: " + RepoID;
            // ** CheckForShortcut()

            if (!isAdmin)
            {
                ReOcrALLGraphicFilesToolStripMenuItem1.Visible = false;
            }

            // ** Add this in 10.05.2011
            if (My.MySettingsProperty.Settings.GatewayConnString.Equals("?"))
            {
                // Dim CSS As String = Proxy.
                // My.Settings.GatewayConnString = CSS
                // My.Settings.Save()
            }
            // ** Add this in 10.05.2011
            if (My.MySettingsProperty.Settings.UserDefaultConnString.Equals("?"))
            {
                // Dim CSS As String = Proxy.
                // My.Settings.UserDefaultConnString = CSS
                // My.Settings.Save()
            }

            updateMessageBar("15 of 18");
            GetRSS(modGlobals.gGateWayID);
            updateMessageBar("16 of 18");
            GetWebPage(modGlobals.gGateWayID);
            updateMessageBar("17 of 18");
            GetWebSite(modGlobals.gGateWayID);
            updateMessageBar("18 of 18");
            My.MyProject.Forms.LoginForm1.Hide();
            Label37.Visible = true;
            Label39.Visible = true;
            TimerAutoExec.Enabled = false;
            if (!ckDisable.Checked & !ckDisableContentArchive.Checked & modGlobals.gAutoExec.Equals(true))
            {
                SB2.Text = "LAUNCHING ContentThread";
                ContentThread.RunWorkerAsync();
                // ContentToolStripMenuItem_Click(Nothing, Nothing)
                TimerAutoExec.Enabled = true;
            }
            else
            {
                modGlobals.gAutoExecContentComplete = true;
            }

            if (ckDisableContentArchive.Checked)
            {
                modGlobals.gAutoExecContentComplete = true;
            }

            if (!ckDisable.Checked & !ckDisableOutlookEmailArchive.Checked & modGlobals.gAutoExec.Equals(true))
            {
                OutlookEmailsToolStripMenuItem_Click(null, null);
                TimerAutoExec.Enabled = true;
            }
            else
            {
                modGlobals.gAutoExecEmailComplete = true;
            }

            if (ckDisableOutlookEmailArchive.Checked)
            {
                modGlobals.gAutoExecEmailComplete = true;
            }

            if (!ckDisable.Checked & !ckDisableExchange.Checked & modGlobals.gAutoExec.Equals(true))
            {
                ExchangeEmailsToolStripMenuItem_Click(null, null);
                TimerAutoExec.Enabled = true;
            }
            else
            {
                modGlobals.gAutoExecExchangeComplete = true;
            }

            if (ckDisableExchange.Checked)
            {
                modGlobals.gAutoExecExchangeComplete = true;
            }

            if (!ckDisable.Checked & !ckRssPullDisabled.Checked & modGlobals.gAutoExec.Equals(true))
            {
                // ignore for now
            }

            if (!ckDisable.Checked & !ckWebPageTrackerDisabled.Checked & modGlobals.gAutoExec.Equals(true))
            {
                // ignore for now
            }

            if (!ckDisable.Checked & !ckWebSiteTrackerDisabled.Checked & modGlobals.gAutoExec.Equals(true))
            {
                // ignore for now
            }
        }

        public void updateMessageBar(string strText)
        {
            bool b = false;
            try
            {
                My.MyProject.Forms.frmMessageBar.lblCnt.Text = strText;
                if (b == true)
                {
                    MessageBox.Show(strText);
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public void GetRidOfOldMessages()
        {
            ARCH.CreateEcmHistoryFolder();
            try
            {
                ARCH.DeleteOutlookMessages(modGlobals.gCurrUserGuidID);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("WARNING 2005.32.21 - call DeleteOutlookMessages failed.");
            }
        }

        public void ckInitialData()
        {
            AddInitialDB();
            // wdm()
            // Dim BB As Boolean = DBARCH.ckUserExists(gCurrUserGuidID)
            // 'gCurrUserGuidID = gCurrUserGuidID
            // If Not BB Then
            // RUSER.setUserid(gCurrUserGuidID)
            // RUSER.Insert()
            // AddInitialEmailFolder("Inbox")
            // AddInitialEmailFolder("Sentmail")
            // End If

            bool BB = DBARCH.ckFileExtExists();
            if (!BB)
            {
                string argval = ".ascx";
                AVL.setExtcode(ref argval);
                AVL.Insert();
                string argval1 = ".asm";
                AVL.setExtcode(ref argval1);
                AVL.Insert();
                string argval2 = ".asp";
                AVL.setExtcode(ref argval2);
                AVL.Insert();
                string argval3 = ".aspx";
                AVL.setExtcode(ref argval3);
                AVL.Insert();
                string argval4 = ".bat";
                AVL.setExtcode(ref argval4);
                AVL.Insert();
                string argval5 = ".c";
                AVL.setExtcode(ref argval5);
                AVL.Insert();
                string argval6 = ".CMD";
                AVL.setExtcode(ref argval6);
                AVL.Insert();
                string argval7 = ".cpp";
                AVL.setExtcode(ref argval7);
                AVL.Insert();
                string argval8 = ".cxx";
                AVL.setExtcode(ref argval8);
                AVL.Insert();
                string argval9 = ".def";
                AVL.setExtcode(ref argval9);
                AVL.Insert();
                string argval10 = ".dic";
                AVL.setExtcode(ref argval10);
                AVL.Insert();
                string argval11 = ".doc";
                AVL.setExtcode(ref argval11);
                AVL.Insert();
                string argval12 = ".docx";
                AVL.setExtcode(ref argval12);
                AVL.Insert();
                string argval13 = ".dot";
                AVL.setExtcode(ref argval13);
                AVL.Insert();
                string argval14 = ".h";
                AVL.setExtcode(ref argval14);
                AVL.Insert();
                string argval15 = ".hhc";
                AVL.setExtcode(ref argval15);
                AVL.Insert();
                string argval16 = ".hpp";
                AVL.setExtcode(ref argval16);
                AVL.Insert();
                string argval17 = ".htm";
                AVL.setExtcode(ref argval17);
                AVL.Insert();
                string argval18 = ".html";
                AVL.setExtcode(ref argval18);
                AVL.Insert();
                string argval19 = ".htw";
                AVL.setExtcode(ref argval19);
                AVL.Insert();
                string argval20 = ".htx";
                AVL.setExtcode(ref argval20);
                AVL.Insert();
                string argval21 = ".hxx";
                AVL.setExtcode(ref argval21);
                AVL.Insert();
                string argval22 = ".ibq";
                AVL.setExtcode(ref argval22);
                AVL.Insert();
                string argval23 = ".idl";
                AVL.setExtcode(ref argval23);
                AVL.Insert();
                string argval24 = ".inc";
                AVL.setExtcode(ref argval24);
                AVL.Insert();
                string argval25 = ".inf";
                AVL.setExtcode(ref argval25);
                AVL.Insert();
                string argval26 = ".ini";
                AVL.setExtcode(ref argval26);
                AVL.Insert();
                string argval27 = ".inx";
                AVL.setExtcode(ref argval27);
                AVL.Insert();
                string argval28 = ".js";
                AVL.setExtcode(ref argval28);
                AVL.Insert();
                string argval29 = ".log";
                AVL.setExtcode(ref argval29);
                AVL.Insert();
                string argval30 = ".m3u";
                AVL.setExtcode(ref argval30);
                AVL.Insert();
                string argval31 = ".mht";
                AVL.setExtcode(ref argval31);
                AVL.Insert();
                string argval32 = ".msg";
                AVL.setExtcode(ref argval32);
                AVL.Insert();
                string argval33 = ".obd";
                AVL.setExtcode(ref argval33);
                AVL.Insert();
                string argval34 = ".obt";
                AVL.setExtcode(ref argval34);
                AVL.Insert();
                string argval35 = ".odc";
                AVL.setExtcode(ref argval35);
                AVL.Insert();
                string argval36 = ".pl";
                AVL.setExtcode(ref argval36);
                AVL.Insert();
                string argval37 = ".pot";
                AVL.setExtcode(ref argval37);
                AVL.Insert();
                string argval38 = ".ppt";
                AVL.setExtcode(ref argval38);
                AVL.Insert();
                string argval39 = ".rc";
                AVL.setExtcode(ref argval39);
                AVL.Insert();
                string argval40 = ".reg";
                AVL.setExtcode(ref argval40);
                AVL.Insert();
                string argval41 = ".rtf";
                AVL.setExtcode(ref argval41);
                AVL.Insert();
                string argval42 = ".stm";
                AVL.setExtcode(ref argval42);
                AVL.Insert();
                string argval43 = ".txt";
                AVL.setExtcode(ref argval43);
                AVL.Insert();
                string argval44 = ".url";
                AVL.setExtcode(ref argval44);
                AVL.Insert();
                string argval45 = ".vbs";
                AVL.setExtcode(ref argval45);
                AVL.Insert();
                string argval46 = ".wtx";
                AVL.setExtcode(ref argval46);
                AVL.Insert();
                string argval47 = ".xlb";
                AVL.setExtcode(ref argval47);
                AVL.Insert();
                string argval48 = ".xlc";
                AVL.setExtcode(ref argval48);
                AVL.Insert();
                string argval49 = ".xls";
                AVL.setExtcode(ref argval49);
                AVL.Insert();
                string argval50 = ".xlt";
                AVL.setExtcode(ref argval50);
                AVL.Insert();
                string argval51 = ".xml";
                AVL.setExtcode(ref argval51);
                AVL.Insert();
                string argval52 = ".pdf";
                AVL.setExtcode(ref argval52);
                AVL.Insert();
                string argval53 = ".msg";
                AVL.setExtcode(ref argval53);
                AVL.Insert();
            }

            int iCnt = DBARCH.getTableCount("Attributes");
            if (iCnt < 3)
            {
                AddFileAttributes();
            }

            iCnt = DBARCH.getTableCount("SourceType");
            if (iCnt == 0)
            {
                DBARCH.AddSecondarySOURCETYPE(".ascx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".asm", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".asp", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".aspx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".bat", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".c", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".CMD", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".cpp", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".cxx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".def", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".dic", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".doc", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".dot", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".h", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".hhc", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".hpp", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".htm", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".html", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".htw", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".htx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".hxx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".ibq", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".idl", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".inc", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".inf", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".ini", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".inx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".js", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".log", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".m3u", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".mht", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".msg", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".obd", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".obt", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".odc", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".pl", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".pot", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".ppt", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".rc", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".reg", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".rtf", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".stm", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".txt", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".url", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".vbs", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".wtx", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".xlb", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".xlc", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".xls", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".xlt", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".xml", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".pdf", "Word Splitter", "0", "1");
                DBARCH.AddSecondarySOURCETYPE(".zip", "Word Splitter", "0", "0");
            }

            iCnt = DBARCH.getTableCount("AttachmentType");
            if (iCnt < 5)
            {
                string argval54 = ".ascx";
                ATCH_TYPE.setAttachmentcode(ref argval54);
                string argval55 = "0";
                ATCH_TYPE.setIszipformat(ref argval55);
                ATCH_TYPE.Insert();
                string argval56 = ".asm";
                ATCH_TYPE.setAttachmentcode(ref argval56);
                ATCH_TYPE.Insert();
                string argval57 = ".asp";
                ATCH_TYPE.setAttachmentcode(ref argval57);
                ATCH_TYPE.Insert();
                string argval58 = ".aspx";
                ATCH_TYPE.setAttachmentcode(ref argval58);
                ATCH_TYPE.Insert();
                string argval59 = ".bat";
                ATCH_TYPE.setAttachmentcode(ref argval59);
                ATCH_TYPE.Insert();
                string argval60 = ".c";
                ATCH_TYPE.setAttachmentcode(ref argval60);
                ATCH_TYPE.Insert();
                string argval61 = ".CMD";
                ATCH_TYPE.setAttachmentcode(ref argval61);
                ATCH_TYPE.Insert();
                string argval62 = ".cpp";
                ATCH_TYPE.setAttachmentcode(ref argval62);
                ATCH_TYPE.Insert();
                string argval63 = ".cxx";
                ATCH_TYPE.setAttachmentcode(ref argval63);
                ATCH_TYPE.Insert();
                string argval64 = ".def";
                ATCH_TYPE.setAttachmentcode(ref argval64);
                ATCH_TYPE.Insert();
                string argval65 = ".dic";
                ATCH_TYPE.setAttachmentcode(ref argval65);
                ATCH_TYPE.Insert();
                string argval66 = ".doc";
                ATCH_TYPE.setAttachmentcode(ref argval66);
                ATCH_TYPE.Insert();
                string argval67 = ".docx";
                ATCH_TYPE.setAttachmentcode(ref argval67);
                ATCH_TYPE.Insert();
                string argval68 = ".dot";
                ATCH_TYPE.setAttachmentcode(ref argval68);
                ATCH_TYPE.Insert();
                string argval69 = ".h";
                ATCH_TYPE.setAttachmentcode(ref argval69);
                ATCH_TYPE.Insert();
                string argval70 = ".hhc";
                ATCH_TYPE.setAttachmentcode(ref argval70);
                ATCH_TYPE.Insert();
                string argval71 = ".hpp";
                ATCH_TYPE.setAttachmentcode(ref argval71);
                ATCH_TYPE.Insert();
                string argval72 = ".htm";
                ATCH_TYPE.setAttachmentcode(ref argval72);
                ATCH_TYPE.Insert();
                string argval73 = ".html";
                ATCH_TYPE.setAttachmentcode(ref argval73);
                ATCH_TYPE.Insert();
                string argval74 = ".htw";
                ATCH_TYPE.setAttachmentcode(ref argval74);
                ATCH_TYPE.Insert();
                string argval75 = ".htx";
                ATCH_TYPE.setAttachmentcode(ref argval75);
                ATCH_TYPE.Insert();
                string argval76 = ".hxx";
                ATCH_TYPE.setAttachmentcode(ref argval76);
                ATCH_TYPE.Insert();
                string argval77 = ".ibq";
                ATCH_TYPE.setAttachmentcode(ref argval77);
                ATCH_TYPE.Insert();
                string argval78 = ".idl";
                ATCH_TYPE.setAttachmentcode(ref argval78);
                ATCH_TYPE.Insert();
                string argval79 = ".inc";
                ATCH_TYPE.setAttachmentcode(ref argval79);
                ATCH_TYPE.Insert();
                string argval80 = ".inf";
                ATCH_TYPE.setAttachmentcode(ref argval80);
                ATCH_TYPE.Insert();
                string argval81 = ".ini";
                ATCH_TYPE.setAttachmentcode(ref argval81);
                ATCH_TYPE.Insert();
                string argval82 = ".inx";
                ATCH_TYPE.setAttachmentcode(ref argval82);
                ATCH_TYPE.Insert();
                string argval83 = ".js";
                ATCH_TYPE.setAttachmentcode(ref argval83);
                ATCH_TYPE.Insert();
                string argval84 = ".log";
                ATCH_TYPE.setAttachmentcode(ref argval84);
                ATCH_TYPE.Insert();
                string argval85 = ".m3u";
                ATCH_TYPE.setAttachmentcode(ref argval85);
                ATCH_TYPE.Insert();
                string argval86 = ".mht";
                ATCH_TYPE.setAttachmentcode(ref argval86);
                ATCH_TYPE.Insert();
                string argval87 = ".msg";
                ATCH_TYPE.setAttachmentcode(ref argval87);
                ATCH_TYPE.Insert();
                string argval88 = ".obd";
                ATCH_TYPE.setAttachmentcode(ref argval88);
                ATCH_TYPE.Insert();
                string argval89 = ".obt";
                ATCH_TYPE.setAttachmentcode(ref argval89);
                ATCH_TYPE.Insert();
                string argval90 = ".odc";
                ATCH_TYPE.setAttachmentcode(ref argval90);
                ATCH_TYPE.Insert();
                string argval91 = ".pl";
                ATCH_TYPE.setAttachmentcode(ref argval91);
                ATCH_TYPE.Insert();
                string argval92 = ".pot";
                ATCH_TYPE.setAttachmentcode(ref argval92);
                ATCH_TYPE.Insert();
                string argval93 = ".ppt";
                ATCH_TYPE.setAttachmentcode(ref argval93);
                ATCH_TYPE.Insert();
                string argval94 = ".rc";
                ATCH_TYPE.setAttachmentcode(ref argval94);
                ATCH_TYPE.Insert();
                string argval95 = ".reg";
                ATCH_TYPE.setAttachmentcode(ref argval95);
                ATCH_TYPE.Insert();
                string argval96 = ".rtf";
                ATCH_TYPE.setAttachmentcode(ref argval96);
                ATCH_TYPE.Insert();
                string argval97 = ".stm";
                ATCH_TYPE.setAttachmentcode(ref argval97);
                ATCH_TYPE.Insert();
                string argval98 = ".txt";
                ATCH_TYPE.setAttachmentcode(ref argval98);
                ATCH_TYPE.Insert();
                string argval99 = ".url";
                ATCH_TYPE.setAttachmentcode(ref argval99);
                ATCH_TYPE.Insert();
                string argval100 = ".vbs";
                ATCH_TYPE.setAttachmentcode(ref argval100);
                ATCH_TYPE.Insert();
                string argval101 = ".wtx";
                ATCH_TYPE.setAttachmentcode(ref argval101);
                ATCH_TYPE.Insert();
                string argval102 = ".xlb";
                ATCH_TYPE.setAttachmentcode(ref argval102);
                ATCH_TYPE.Insert();
                string argval103 = ".xlc";
                ATCH_TYPE.setAttachmentcode(ref argval103);
                ATCH_TYPE.Insert();
                string argval104 = ".xls";
                ATCH_TYPE.setAttachmentcode(ref argval104);
                ATCH_TYPE.Insert();
                string argval105 = ".xlt";
                ATCH_TYPE.setAttachmentcode(ref argval105);
                ATCH_TYPE.Insert();
                string argval106 = ".xml";
                ATCH_TYPE.setAttachmentcode(ref argval106);
                ATCH_TYPE.Insert();
                string argval107 = ".pdf";
                ATCH_TYPE.setAttachmentcode(ref argval107);
                ATCH_TYPE.Insert();
            }
        }

        private void ckRemoveAfterXDays_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckRemoveAfterXDays.Checked)
            {
                NumericUpDown3.Enabled = true;
            }
            else
            {
                NumericUpDown3.Enabled = false;
            }
        }

        private void lbActiveFolder_MouseDown(object sender, MouseEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (e.Button == MouseButtons.Right)
            {
                if (e.Button == MouseButtons.Right)
                {
                    if (e.Button == MouseButtons.Right)
                    {
                        var PNT = new Point();
                        PNT.X = e.X;
                        PNT.Y = e.Y;
                        int X = e.X;
                        int Y = e.Y;
                        if (modGlobals.gClipBoardActive == true)
                            Console.WriteLine(X.ToString() + "," + Y.ToString());
                        ContextMenuStrip1.Show(lbActiveFolder, X, Y);
                    }
                }
            }
        }

        private void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int I = lbActiveFolder.SelectedItems.Count;
            if (I == 0)
            {
                SB.Text = "You must select an item from the listbox...";
                return;
            }

            if (cbParentFolders.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please select a Parent Folder");
                return;
            }

            SB2.Text = lbActiveFolder.SelectedItem.ToString().Trim();
            string EmailFolderName = "";
            string RemoveAfterArchive = "";
            string SetAsDefaultFolder = "";
            string ArchiveAfterXDays = "";
            string ArchiveXDays = "";
            string RemoveAfterXDays = "";
            string RemoveXDays = "";
            string DBID = "";
            string ArchiveEmails = "";
            string ArchiveOnlyIfRead = "";
            string SystemFolder = "";
            string FolderName = lbActiveFolder.SelectedItem.ToString().Trim();
            string KeyFolderName = ParentFolder + "|" + FolderName;
            KeyFolderName = UTIL.RemoveSingleQuotes(KeyFolderName);
            string WhereClause = " where UserID = '" + modGlobals.gCurrUserGuidID + "' and FolderName = '" + KeyFolderName + "' ";
            string[] aParms = (string[])DBARCH.SelectOneEmailParm(WhereClause);
            if (aParms[8] == null)
            {
                aParms[8] = FolderName;
                aParms[1] = "";
                aParms[2] = "";
                aParms[3] = "";
                aParms[4] = "";
                aParms[7] = "";
                aParms[5] = "";
                aParms[6] = "";
                aParms[9] = "";
                aParms[10] = "";
                aParms[11] = "";
            }

            AddNewDirectory();
            ShowSellectedLibs(KeyFolderName, "EMAIL");
        }

        public void AddNewDirectory()
        {
            string EmailFolderName = "";
            string RemoveAfterArchive = "";
            string SetAsDefaultFolder = "";
            string ArchiveAfterXDays = "";
            string ArchiveXDays = "";
            string RemoveAfterXDays = "";
            string RemoveXDays = "";
            string DBID = "";
            string ArchiveEmails = "";
            string ArchiveOnlyIfRead = "";
            string SystemFolder = "";
            string FolderName = lbActiveFolder.SelectedItem.ToString().Trim();
            string KeyFolderName = ParentFolder + "|" + FolderName;
            KeyFolderName = UTIL.RemoveSingleQuotes(KeyFolderName);
            string WhereClause = " where UserID = '" + modGlobals.gCurrUserGuidID + "' and FolderName = '" + KeyFolderName + "' ";
            string[] aParms = (string[])DBARCH.SelectOneEmailParm(WhereClause);
            if (aParms[8] == null)
            {
                aParms[8] = FolderName;
                aParms[1] = "";
                aParms[2] = "";
                aParms[3] = "";
                aParms[4] = "";
                aParms[7] = "";
                aParms[5] = "";
                aParms[6] = "";
                aParms[9] = "";
                aParms[10] = "";
                aParms[11] = "";
            }
            // UserID = a(0)
            // ArchiveEmails = a(1)
            // RemoveAfterArchive = a(2)
            // SetAsDefaultFolder = a(3)
            // ArchiveAfterXDays = a(4)
            // RemoveAfterXDays = a(5)
            // RemoveXDays = a(6)
            // ArchiveXDays = a(7)
            // FolderName = a(8)
            // DB_ID = a(9)
            string tEmailFolderName = aParms[8];
            var A = tEmailFolderName.Split('|');
            EmailFolderName = A[Information.UBound(A)];
            ArchiveEmails = aParms[1];
            RemoveAfterArchive = aParms[2];
            SetAsDefaultFolder = aParms[3];
            ArchiveAfterXDays = aParms[4];
            ArchiveXDays = aParms[7];
            RemoveAfterXDays = aParms[5];
            RemoveXDays = aParms[6];
            DBID = aParms[9];
            ArchiveOnlyIfRead = aParms[10];
            SystemFolder = aParms[11];
            if (SystemFolder.ToUpper().Equals("TRUE"))
            {
                ckSystemFolder.Checked = true;
            }
            else
            {
                ckSystemFolder.Checked = false;
            }

            if (ArchiveEmails.Equals("Y"))
            {
                ckArchiveFolder.Checked = true;
            }
            else
            {
                ckArchiveFolder.Checked = false;
            }

            if (ArchiveOnlyIfRead.Equals("Y"))
            {
                ckArchiveRead.Checked = true;
            }
            else
            {
                ckArchiveRead.Checked = false;
            }

            if (RemoveAfterXDays.Equals("Y"))
            {
                ckRemoveAfterXDays.Checked = true;
            }
            else
            {
                ckRemoveAfterXDays.Checked = false;
            }

            if (RemoveAfterXDays.Equals("Y"))
            {
                ckRemoveAfterXDays.Checked = true;
                NumericUpDown3.Value = Conversions.ToDecimal(RemoveXDays);
                NumericUpDown3.Enabled = true;
            }
            else
            {
                ckRemoveAfterXDays.Checked = false;
                NumericUpDown3.Value = Conversions.ToDecimal("0");
                NumericUpDown3.Enabled = false;
            }

            cbEmailRetention.Text = DBARCH.GetEmailRetentionCode(tEmailFolderName, modGlobals.gCurrUserGuidID);
            cbEmailDB.Text = DBID;
        }

        public void RemoveAlreadyArchived(string ParentFolder, bool HideArchived)
        {
            int I = 0;
            int k = 0;
            for (I = lbActiveFolder.Items.Count - 1; I >= 0; I -= 1)
            {
                string S1 = lbActiveFolder.Items[I].ToString();
                for (int j = 0, loopTo = ArchivedEmailFolders.Count - 1; j <= loopTo; j++)
                {
                    string s2 = ArchivedEmailFolders[j].ToString();
                    // WDM Remove this
                    if (modGlobals.gClipBoardActive == true)
                        Console.WriteLine(s2 + " : " + S1);
                    SB.Text = S1;
                    SB.Refresh();
                    Application.DoEvents();
                    if (Strings.UCase(S1).Equals(Strings.UCase(s2)))
                    {
                        if (HideArchived == true)
                        {
                            lbActiveFolder.Items.RemoveAt(I);
                            // Else
                            // lbActiveFolder.SetSelected(j, True)
                        }

                        break;
                    }
                }
            }

            SB.Text = "";
        }

        private void btnRefreshFolders_Click(object sender, EventArgs e)
        {
            // btnValidateEntry.Visible = False
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (modGlobals.gEmailArchiveDisabled.Equals(false))
            {
                LOG.WriteToArchiveLog("NOTICE: EMAIL Archive is disabled.");
                return;
            }

            AllEmailFoldersShowing = true;
            // ARCH.RegisterOutlookContainers()

            Cursor = Cursors.AppStarting;
            ParentFolder = cbParentFolders.Text;
            if (ParentFolder.Trim().Length == 0)
            {
                MessageBox.Show("Please select an Outlook Folder to process.");
                return;
            }

            var argLB = lbActiveFolder;
            isOutlookAvail = ARCH.getOutlookFolderNames(ParentFolder, ref argLB);
            lbActiveFolder = argLB;
            if (isOutlookAvail == false)
            {
                ckDisableOutlookEmailArchive.Checked = true;
                // gbEmail.Enabled = False
            }

            if (isOutlookAvail == false)
            {
                SB.Text = "OUTLOOK APPEARS TO BE UNAVAILABLE - DISABLED EMAIL.";
            }

            RemoveAlreadyArchived(ParentFolder, ckDoNotShowArchived.Checked);
            DBARCH.CleanUpEmailFolders();

            // btnDeleteEmailEntry.Enabled = False
            Cursor = Cursors.Default;
        }

        private void btnActive_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            AllEmailFoldersShowing = false;
            ParentFolder = cbParentFolders.Text;
            if (ParentFolder.Trim().Length == 0)
            {
                MessageBox.Show("Please select an Outlook Folder to process.");
                return;
            }

            Cursor = Cursors.AppStarting;
            var argLB = lbActiveFolder;
            DBARCH.GetActiveEmailFolders(ParentFolder, ref argLB, modGlobals.gCurrUserGuidID, modGlobals.CF, ArchivedEmailFolders);
            lbActiveFolder = argLB;
            btnDeleteEmailEntry.Enabled = true;
            DBARCH.CleanUpEmailFolders();
            Cursor = Cursors.Default;
        }

        public void VerifyEmailFolderExists(string FileDirectory, string FolderName)
        {
            Cursor = Cursors.AppStarting;
            int i = EMF.cnt_IDX_FolderName(FileDirectory, FolderName, modGlobals.gCurrUserGuidID);
            if (i == 0)
            {
                ARCH.getOutlookFolderNames(ParentFolder);
            }

            Cursor = Cursors.Default;
        }

        private void btnSaveConditions_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string RetentionCode = cbEmailRetention.Text;
            if (RetentionCode.Length == 0)
            {
                cbEmailRetention.Text = DBARCH.getRetentionPeriodMax();
                RetentionCode = cbEmailRetention.Text;
            }

            if (cbParentFolders.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please select a Parent Folder");
                return;
            }

            if (!ckArchiveFolder.Checked)
            {
                MessageBox.Show("The Archive Email folder was not checked, please take note...");
                // ckArchiveFolder.Checked = True
            }

            int RetentionYears = 0;
            RetentionYears = DBARCH.getRetentionPeriod(RetentionCode);
            try
            {
                Cursor = Cursors.AppStarting;
                string FileDirectory = "";
                foreach (string sFolderName in lbActiveFolder.SelectedItems)
                {
                    string FolderName = sFolderName.ToString();
                    FQNFolder = ParentFolder + "|" + FolderName;
                    ParentFolder = UTIL.RemoveSingleQuotes(ParentFolder);
                    FolderName = UTIL.RemoveSingleQuotes(FolderName);
                    FQNFolder = UTIL.RemoveSingleQuotes(FQNFolder);

                    // FileDirectory  = cbParentFolders.Text
                    FileDirectory = ParentFolder;

                    // Dim EDIR As New clsEMAILFOLDER
                    // EDIR.cnt_IDX_FolderName(FolderName , gCurrUserGuidID)
                    // EDIR = Nothing

                    var aParms = new string[1];
                    EMPARMS.setFoldername(ref FQNFolder);
                    EMPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
                    if (ckArchiveRead.Checked)
                    {
                        string argval = "Y";
                        EMPARMS.setArchiveonlyifread(ref argval);
                    }
                    else
                    {
                        string argval1 = "N";
                        EMPARMS.setArchiveonlyifread(ref argval1);
                    }

                    if (ckArchiveFolder.Checked)
                    {
                        string argval2 = "Y";
                        EMPARMS.setArchiveemails(ref argval2);
                        DBARCH.SetFolderAsActive(FolderName, "Y");
                    }
                    else
                    {
                        string argval3 = "N";
                        EMPARMS.setArchiveemails(ref argval3);
                        DBARCH.SetFolderAsActive(FolderName.Trim(), "N");
                    }

                    if (ckRemoveAfterXDays.Checked)
                    {
                        string argval4 = "Y";
                        EMPARMS.setRemoveafterxdays(ref argval4);
                        EMPARMS.setRemovexdays(ref NumericUpDown3.Value.ToString());
                    }
                    else
                    {
                        string argval5 = "N";
                        EMPARMS.setRemoveafterxdays(ref argval5);
                        string argval6 = "0";
                        EMPARMS.setRemovexdays(ref argval6);
                    }

                    if (ckSystemFolder.Checked)
                    {
                        string msg = "This folder will become mandatory for everyone, are you sure?";
                        var dlgRes = MessageBox.Show(msg, "Mandatory Folder", MessageBoxButtons.YesNo);
                        if (dlgRes == DialogResult.No)
                        {
                            return;
                        }

                        EMPARMS.setIsSysDefault("1");
                    }
                    else
                    {
                        EMPARMS.setIsSysDefault("0");
                    }

                    if (string.IsNullOrEmpty(cbEmailDB.Text.Trim()))
                    {
                        cbEmailDB.Text = "ECMREPO";
                    }

                    EMPARMS.setDb_id(ref cbEmailDB.Text.Trim());

                    // xavier
                    bool B = DBARCH.ckFolderExists(FileDirectory, modGlobals.gCurrUserGuidID, FQNFolder);

                    // For iCnt As Integer = 0 To CF.Count - 1
                    // Dim SS  = CF.Keys(iCnt).ToString
                    // Console.WriteLine(SS)
                    // Next
                    if (!B)
                    {
                        int iFolder = EMF.cnt_IDX_FolderName(FileDirectory, FQNFolder, modGlobals.gCurrUserGuidID);
                        if (iFolder == 0)
                        {
                            Console.WriteLine("Folder " + FQNFolder + " does not exist.");
                        }

                        EMPARMS.Insert(FileDirectory);
                        string WhereClause = "Where FileDirectory = '" + FileDirectory + "' and [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FolderName] = '" + FQNFolder + "' ";
                        EMPARMS.Update(WhereClause);
                        if (isAdmin == true)
                        {
                            string S = "";
                            if (ckSystemFolder.Checked == true)
                            {
                                S = "update [EmailFolder]";
                                S = S + " set isSysDefault = 1";
                                S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            }
                            else
                            {
                                S = "update [EmailFolder]";
                                S = S + " set isSysDefault = 0";
                                S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            }

                            bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                Debug.Print("Failed to update isSysDefault");
                            }
                        }

                        if (ckArchiveFolder.Checked)
                        {
                            string S = "update [EmailFolder]";
                            S = S + " set SelectedForArchive = 'Y' ";
                            S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                Debug.Print("Failed to update isSysDefault");
                            }
                        }
                        else
                        {
                            string S = "update [EmailFolder]";
                            S = S + " set SelectedForArchive = 'N' ";
                            S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                Debug.Print("Failed to update isSysDefault");
                            }
                        }
                    }
                    else
                    {
                        string WhereClause = "Where [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FolderName] = '" + FQNFolder + "'";
                        EMPARMS.Update(WhereClause);
                        if (isAdmin == true)
                        {
                            string S = "";
                            if (ckSystemFolder.Checked == true)
                            {
                                S = "update [EmailFolder]";
                                S = S + " set isSysDefault = 1";
                                // S  = S  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
                                S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            }
                            else
                            {
                                S = "update [EmailFolder]";
                                S = S + " set isSysDefault = 0";
                                // S  = S  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
                                S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            }

                            bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                LOG.WriteToArchiveLog("Notice: frmMain:btnSaveConditions: 23.441 - 100 Failed to update isSysDefault");
                            }
                        }

                        if (ckArchiveFolder.Checked)
                        {
                            string S = "update [EmailFolder]";
                            S = S + " set SelectedForArchive = 'Y' ";
                            S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                Debug.Print("Failed to update isSysDefault");
                            }
                        }
                        else
                        {
                            string S = "update [EmailFolder]";
                            S = S + " set SelectedForArchive = 'N' ";
                            S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                            bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BB)
                            {
                                Debug.Print("Failed to update isSysDefault");
                            }
                        }
                    }

                    SKIPFOLDER:
                    ;
                    string xSql = "";
                    xSql = "update [EmailFolder] ";
                    xSql = xSql + " set RetentionCode = '" + RetentionCode + "' ";
                    // xSql  = xSql  + " where userid = '" + gCurrUserGuidID + "' and foldername = '" + FolderName  + "' and ParentFolderName = '" + ParentFolder + "' "
                    xSql = xSql + " where userid = '" + modGlobals.gCurrUserGuidID + "' and foldername = '" + FQNFolder + "'";
                    bool BB1 = DBARCH.ExecuteSqlNewConn(xSql, false);
                    if (!BB1)
                    {
                        LOG.WriteToArchiveLog("Notice: frmMain:btnSaveConditions: 23.441 - 200 Failed to update RetentionCode");
                    }

                    SB.Text = FolderName + " activated.";
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                LOG.WriteToArchiveLog("ERROR 195-43.2 frmMain:btnSaveConditions_Click - ", ex);
            }

            DBARCH.CleanUpEmailFolders();
            Cursor = Cursors.Default;
        }

        private void btnSelDir_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (cbRetention.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please select a retention policy to apply to this directory before adding it to the system.");
                return;
            }

            string tDir = "";
            if (CurrentDirectory.Length > 0)
            {
                FolderBrowserDialog1.SelectedPath = CurrentDirectory;
            }

            FolderBrowserDialog1.ShowDialog();
            if (FolderBrowserDialog1.SelectedPath.Length > 0)
            {
                tDir = FolderBrowserDialog1.SelectedPath;
                CurrentDirectory = FolderBrowserDialog1.SelectedPath;
            }
            else
            {
                tDir = "";
            }

            if (tDir.Length == 0)
            {
                SB.Text = "Action cancelled.";
                return;
            }

            txtDir.Text = tDir;
            btnAddDir_Click(null, null);
            Cursor = Cursors.Default;
            SB.Text = "Directory added with default archive settings. Change as you wish and update.";
            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void GroupBox2_Enter(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void btnAddFiletype_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (!DBARCH.isAdmin(modGlobals.gCurrUserGuidID))
            {
                DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
                MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
                return;
            }

            string FileExt = cbFileTypes.Text.Trim();
            if (Strings.InStr(FileExt, ".") == 0)
            {
                FileExt = "." + FileExt;
            }

            bool B = DBARCH.ckExtExists(FileExt);
            DBARCH.delSecondarySOURCETYPE(FileExt);
            DBARCH.AddSecondarySOURCETYPE(FileExt, "Added by user", "0", "1");
            if (B)
            {
                SB.Text = "Extension already defined to system.";
            }
            else
            {
                AVL.setExtcode(ref FileExt);
                AVL.Insert();
                var argCB = cbFileTypes;
                DBARCH.LoadAvailFileTypes(ref argCB);
                cbFileTypes = argCB;
                var argCB1 = cbPocessType;
                DBARCH.LoadAvailFileTypes(ref argCB1);
                cbPocessType = argCB1;
                var argCB2 = cbAsType;
                DBARCH.LoadAvailFileTypes(ref argCB2);
                cbAsType = argCB2;
                var argLB = lbAvailExts;
                DBARCH.LoadAvailFileTypes(ref argLB);
                lbAvailExts = argLB;
            }
        }

        private void ckRemoveAfterDays_Click(object sender, EventArgs e)
        {
            if (!DBARCH.isAdmin(modGlobals.gCurrUserGuidID))
            {
                DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
                MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // select count(*) from  [DataSource] where [SourceTypeCode] = 'YYYY' and [DataSourceOwnerUserID] = 'XXX'
            string FileExt = cbFileTypes.Text.Trim();
            bool B = DBARCH.iCount("DataSource", "where [SourceTypeCode] = '" + FileExt + "' and [DataSourceOwnerUserID] = '" + modGlobals.gCurrUserGuidID + "'");
            if (B)
            {
                MessageBox.Show("Cannot remove filetype " + FileExt + ". There are files of that type in the repository.");
                return;
            }

            AVL.setExtcode(ref FileExt);
            AVL.Delete("Where ExtCode = '" + FileExt + "'");
            DBARCH.delSecondarySOURCETYPE(FileExt);
            var argCB = cbFileTypes;
            DBARCH.LoadAvailFileTypes(ref argCB);
            cbFileTypes = argCB;
            var argCB1 = cbPocessType;
            DBARCH.LoadAvailFileTypes(ref argCB1);
            cbPocessType = argCB1;
            var argCB2 = cbAsType;
            DBARCH.LoadAvailFileTypes(ref argCB2);
            cbAsType = argCB2;
            var argLB = lbAvailExts;
            DBARCH.LoadAvailFileTypes(ref argLB);
            lbAvailExts = argLB;
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            if (!DBARCH.isAdmin(modGlobals.gCurrUserGuidID))
            {
                DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
                MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string ParentFT = cbPocessType.Text;
            string ChildFT = cbAsType.Text;
            SB.Text = AP.SaveNewAssociations(ParentFT, ChildFT);
            var argCB = cbProcessAsList;
            DBARCH.GetProcessAsList(ref argCB);
            cbProcessAsList = argCB;
        }

        private void ckIncludeAllTypes_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int iCnt = lbArchiveDirs.SelectedItems.Count;
            if (iCnt <= 0)
            {
                MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.");
                return;
            }
            // If ckIncludeAllTypes.Checked Then
            // Me.lbIncludeExts.Items.Clear()
            // For i As Integer = 0 To lbAvailExts.Items.Count - 1
            // Dim S  = Me.lbAvailExts.Items(i).ToString
            // lbIncludeExts.Items.Add(S)
            // Next
            // End If
        }

        private void lbArchiveDirs_MouseDown(object sender, MouseEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (e.Button == MouseButtons.Right)
            {
                int iCnt = lbArchiveDirs.SelectedItems.Count;
                if (iCnt == 0)
                {
                    MessageBox.Show("You must select a Directory first... aborting");
                    return;
                }

                string FolderName = lbArchiveDirs.SelectedItem.ToString();
                FolderName = UTIL.RemoveSingleQuotes(FolderName);
                if (e.Button == MouseButtons.Right)
                {
                    My.MyProject.Forms.frmLibraryAssignment.setFolderName(FolderName);
                    My.MyProject.Forms.frmLibraryAssignment.SetTypeContent(true);
                    My.MyProject.Forms.frmLibraryAssignment.ShowDialog();
                }
            }
        }

        private void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (bApplyingDirParms == true)
            {
                return;
            }

            int I = lbArchiveDirs.SelectedItems.Count;
            if (I == 0)
            {
                SB.Text = "You must select an item from the listbox...";
                return;
            }

            if (I.Equals(1))
            {
                string tgtDir = Conversions.ToString(lbArchiveDirs.SelectedItems[0]);
                if (DirectoryList.ContainsKey(tgtDir))
                {
                    lblListenerState.Text = "Listener ON";
                }
                else
                {
                    lblListenerState.Text = "Listener OFF";
                }
            }

            if (I > 1)
            {
                lblListenerState.Text = "";
            }

            if (I != 1)
            {
                CkMonitor.Visible = false;
                CheckBox2.Visible = false;
            }
            else
            {
                CkMonitor.Visible = true;
                CheckBox2.Visible = true;
            }

            bActiveChange = true;
            string DirName = lbArchiveDirs.SelectedItem.ToString().Trim();
            txtDir.Text = DirName;
            // DBARCH.LoadAvailFileTypes(lbAvailExts)
            string DBID = "";
            string IncludeSubDirs = "";
            string VersionFiles = "";
            string FolderDisabled = "";
            string isMetaData = "";
            string isPublic = "";
            string OcrDirectory = "";
            string OcrPdf = "";
            string isSysDefault = "";
            string DeleteOnArchive = "";
            bool argArchiveSkipBit = ckArchiveBit.Checked;
            DBARCH.GetDirectoryData(modGlobals.gCurrUserGuidID, DirName, ref DBID, ref IncludeSubDirs, ref VersionFiles, ref FolderDisabled, ref isMetaData, ref isPublic, ref OcrDirectory, ref isSysDefault, ref argArchiveSkipBit, ref ListenForChanges, ref ListenDirectory, ref ListenSubDirectory, ref DirGuid, ref OcrPdf, ref DeleteOnArchive);
            ckArchiveBit.Checked = argArchiveSkipBit;
            cbFileDB.Text = DBID;
            ckSubDirs.Checked = cvtTF(IncludeSubDirs);
            ckVersionFiles.Checked = cvtTF(VersionFiles);
            ckDisableDir.Checked = cvtTF(FolderDisabled);
            var argLB = lbIncludeExts;
            DBARCH.LoadIncludedFileTypes(ref argLB, modGlobals.gCurrUserGuidID, DirName);
            lbIncludeExts = argLB;
            var argLB1 = lbExcludeExts;
            DBARCH.LoadExcludedFileTypes(ref argLB1, modGlobals.gCurrUserGuidID, DirName);
            lbExcludeExts = argLB1;
            if (DeleteOnArchive.Equals("Y"))
            {
                ckDeleteAfterArchive.Checked = true;
            }
            else
            {
                ckDeleteAfterArchive.Checked = false;
            }

            if (isSysDefault.ToUpper().Equals("TRUE"))
            {
                clAdminDir.Checked = true;
            }
            else
            {
                clAdminDir.Checked = false;
            }

            if (isMetaData == "Y")
            {
                ckMetaData.Checked = true;
            }
            else
            {
                ckMetaData.Checked = false;
            }

            if (IncludeSubDirs.Equals("Y"))
            {
                ckSubDirs.Checked = true;
            }
            else
            {
                ckSubDirs.Checked = false;
            }

            if (isPublic.Equals("Y"))
            {
                ckPublic.Checked = true;
            }
            else
            {
                ckPublic.Checked = false;
            }

            if (OcrDirectory.Equals("Y"))
            {
                ckOcr.Checked = true;
            }
            else
            {
                ckOcr.Checked = false;
            }

            if (OcrPdf.Equals("Y"))
            {
                ckOcrPdf.Checked = true;
                modGlobals.gPdfExtended = true;
            }
            else
            {
                ckOcrPdf.Checked = false;
                modGlobals.gPdfExtended = false;
            }

            bool bDisabled = DBARCH.isDirAdminDisabled(modGlobals.gCurrUserGuidID, DirName);
            if (isAdmin == true & bDisabled == true)
            {
                SB.Text = "Directory disabled by Administrator, you are an ADMIN, do what you like.";
                ckDisableDir.Enabled = true;
            }
            else if (isAdmin == false & bDisabled == true)
            {
                SB.Text = "Directory disabled by Administrator, please contact Admin.";
                ckDisableDir.Checked = true;
                ckDisableDir.Enabled = false;
            }
            else
            {
                ckDisableDir.Enabled = true;
                SB.Text = "";
            }

            if (ListenDirectory == true | ListenSubDirectory == true)
            {
                CkMonitor.Checked = true;
            }
            else
            {
                CkMonitor.Checked = false;
            }

            ShowSellectedLibs(DirName, "CONTENT");
            bActiveChange = false;
        }

        public void ShowSellectedLibs(string DirName, string TypeList)
        {
            if (ckShowLibs.Checked)
            {
                My.MyProject.Forms.frmLibraryAssgnList.LIbraryName = DirName;
                DBARCH.GetListOfAssignedLibraries(DirName, TypeList, ref AssignedLibraries);
                My.MyProject.Forms.frmLibraryAssgnList.lbLibraries.Items.Clear();
                My.MyProject.Forms.frmLibraryAssgnList.lbLibraries.Refresh();
                My.MyProject.Forms.frmLibraryAssgnList.Refresh();
                Application.DoEvents();
                for (int iList = 0, loopTo = AssignedLibraries.Count - 1; iList <= loopTo; iList++)
                    My.MyProject.Forms.frmLibraryAssgnList.lbLibraries.Items.Add(AssignedLibraries[iList]);
                My.MyProject.Forms.frmLibraryAssgnList.Visible = true;
            }
            else
            {
                My.MyProject.Forms.frmLibraryAssgnList.Visible = false;
            }
        }

        private void lbIncludeExts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (bApplyingDirParms == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string SelectedFileType = lbIncludeExts.SelectedItem.ToString();
                INL.setUserid(modGlobals.gCurrUserGuidID);
                INL.setFqn(lbArchiveDirs.SelectedItem.ToString());
                INL.setExtcode(SelectedFileType);
            }
            // INL.Delete("where UserID = '" + gCurrUserGuidID + "' and FQN = '" + Me.lbArchiveDirs.SelectedItem.ToString + "' and Extcode = '" + SelectedFileType  + "' ")
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = "Both a directory and the Included File Type must be selected...";
            }
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            SB.Text = "Profile maintenance selected, will not affect directory setup.";
            for (int i = lbIncludeExts.SelectedItems.Count; i >= 0; i -= 1)
            {
                int II = lbIncludeExts.SelectedIndex;
                if (II >= 0)
                {
                    lbIncludeExts.Items.RemoveAt(II);
                }
            }

            SB.Text = "Removed Items";
            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void AddInitialDB()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int II = DBARCH.getTableCount("Databases");
            if (II > 0)
            {
                return;
            }

            string S = "";
            S = S + " INSERT INTO [Databases]";
            S = S + " ([DB_ID]";
            S = S + " ,[DB_CONN_STR])";
            S = S + " VALUES";
            S = S + " ('DMA.UD'";
            S = S + " ,'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True')";
            try
            {
                bool b = DBARCH.ExecuteSqlNewConn(S, false);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR 219.23.4: Call Administrator" + Constants.vbCrLf + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }

            S = "";
            S = S + " INSERT INTO [Databases]";
            S = S + " ([DB_ID]";
            S = S + " ,[DB_CONN_STR])";
            S = S + " VALUES";
            S = S + " ('ECMREPO'";
            S = S + " ,'Data Source=<your source name here>;Initial Catalog=DMA.UD;Integrated Security=True')";
            try
            {
                bool b = DBARCH.ExecuteSqlNewConn(S, false);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR 219.23.4: Call Administrator" + Constants.vbCrLf + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }

            S = "";
            S = S + " INSERT INTO [Databases]";
            S = S + " ([DB_ID]";
            S = S + " ,[DB_CONN_STR])";
            S = S + " VALUES";
            S = S + " ('ECMREPO'";
            S = S + " ,'Data Source=<your source name here>;Initial Catalog=ECM.Library;Integrated Security=True')";
            try
            {
                bool b = DBARCH.ExecuteSqlNewConn(S, false);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR 219.23.4: Call Administrator" + Constants.vbCrLf + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void AddInitialEmailFolder(string FileDirectory, string FolderName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            AddInitialDB();
            Cursor = Cursors.AppStarting;
            var aParms = new string[1];

            // PARMS.EmailFolderName  = FolderName
            EMPARMS.setFoldername(ref FolderName);
            EMPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval = "Y";
            EMPARMS.setArchiveemails(ref argval);
            string argval1 = "Y";
            EMPARMS.setRemoveafterarchive(ref argval1);
            string argval2 = "N";
            EMPARMS.setSetasdefaultfolder(ref argval2);
            string argval3 = "N";
            EMPARMS.setArchivexdays(ref argval3);
            string argval4 = "0";
            EMPARMS.setArchivexdays(ref argval4);
            string argval5 = "N";
            EMPARMS.setRemoveafterarchive(ref argval5);
            string argval6 = "0";
            EMPARMS.setRemovexdays(ref argval6);
            EMPARMS.setDb_id(ref modGlobals.CurrDbName);
            EMPARMS.Insert(FileDirectory);
            Cursor = Cursors.Default;
        }

        private void ckRunAtStartup_CheckedChanged(object sender, EventArgs e)
        {
            if (formloaded == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            saveStartUpParms();
            try
            {
                string aPath = "";
                aPath = Assembly.GetExecutingAssembly().Location;
                bool RunAtStart = false;
                // If ckRunAtStartup.Checked Then
                // RunAtStart = True
                // End If

                if (RunAtStart)
                {
                    var oReg = Registry.CurrentUser;
                    // Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
                    var oKey = oReg.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run", true);
                    string SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.CreateSubKey("EcmLibrary");
                    oKey.SetValue("EcmLibrary", aPath);
                    SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.Close();
                }
                else
                {

                    // Registry.CurrentUser.DeleteSubKey("Software\Microsoft\Windows\CurrentVersion\Run\EcmLibrary")

                    var oReg = Registry.CurrentUser;
                    var oKey = oReg.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run", true);
                    oKey.CreateSubKey("EcmLibrary");
                    oKey.SetValue("EcmLibrary", "X");
                    string SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.DeleteSubKey("EcmLibrary");
                    SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.Close();
                }

                // messagebox.show("Load at startup set to " + ckRunAtStartup.Checked.ToString)

                saveStartUpParms();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 10 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to set start up parameter." + Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter.", ex);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void ckDisable_CheckedChanged(object sender, EventArgs e)
        {
            if (formloaded == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // formloaded = False
            // Me.saveStartUpParms()
            // formloaded = True
            saveStartUpParms();
            SB.Text = "Disabled set to " + ckDisable.Checked.ToString();
        }

        public void GetExecParms()
        {
            string ArchiveType = "";
            ArchiveType = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "ArchiveType");
            // If ArchiveType .Length > 0 Then
            // cbInterval.Text = ArchiveType
            // Else
            // cbInterval.Text = ""
            // End If

            string C = "";
            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "ArchiveInterval");
            // If C.Length > 0 Then
            // cbTimeUnit.Text = C
            // Else
            // cbTimeUnit.Text = "5"
            // End If
            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "LoadAtStartup");
            // If C.Length > 0 Then
            // If C.Equals("True") Then
            // ckRunAtStartup.Checked = True
            // Else
            // ckRunAtStartup.Checked = False
            // End If
            // Else
            // ckRunAtStartup.Checked = False
            // End If

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "Disabled");
            if (C.Length > 0)
            {
                if (C.Equals("True"))
                {
                    ckDisable.Checked = true;
                }
                else
                {
                    ckDisable.Checked = false;
                }
            }
            else
            {
                ckDisable.Checked = false;
            }

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "ContentDisabled");
            if (C.ToUpper().Equals("TRUE"))
            {
                ckDisableContentArchive.Checked = true;
            }
            else
            {
                ckDisableContentArchive.Checked = false;
            }

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "OutlookDisabled");
            if (C.ToUpper().Equals("TRUE"))
            {
                modGlobals.gEmailArchiveDisabled = true;
                ckDisableOutlookEmailArchive.Checked = true;
            }
            else
            {
                modGlobals.gEmailArchiveDisabled = false;
                ckDisableOutlookEmailArchive.Checked = false;
            }

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "ExchangeDisabled");
            if (C.ToUpper().Equals("TRUE"))
            {
                ckDisableExchange.Checked = true;
            }
            else
            {
                ckDisableExchange.Checked = false;
            }

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "RssPullDisabled");
            if (C.ToUpper().Equals("TRUE"))
            {
                ckRssPullDisabled.Checked = true;
            }
            else
            {
                ckRssPullDisabled.Checked = false;
            }

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "WebPageTrackerDisabled");
            if (C.ToUpper().Equals("TRUE"))
            {
                ckWebPageTrackerDisabled.Checked = true;
            }
            else
            {
                ckWebPageTrackerDisabled.Checked = false;
            }

            C = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "WebSiteTrackerDisabled");
            if (C.ToUpper().Equals("TRUE"))
            {
                ckWebSiteTrackerDisabled.Checked = true;
            }
            else
            {
                ckWebSiteTrackerDisabled.Checked = false;
            }
        }

        private void SenderMgtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmSenderMgt.Show();
        }

        public void IncludeDirectory(string DirFqn)
        {
            ckSubDirs.Checked = true;
            // ckOcr.Checked = True
            ckVersionFiles.Checked = true;
            try
            {
                if (cbRetention.Text.Trim().Length == 0)
                {
                    MessageBox.Show("Please select a retention policy to apply to this directory before adding it to the system.");
                    return;
                }

                PBx.Minimum = 0;
                PBx.Maximum = 10;
                string RetentionCode = cbRetention.Text.Trim();
                try
                {
                    Cursor = Cursors.WaitCursor;
                    SB.Text = "Beginning Include";
                    try
                    {
                        PBx.Value = 1;
                    }
                    catch (ThreadAbortException ex)
                    {
                        LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.");
                        Thread.ResetAbort();
                    }
                    catch (Exception ex)
                    {
                    }

                    string FQN = txtDir.Text.Trim();
                    FQN = UTIL.RemoveSingleQuotes(FQN);
                    txtDir.Text = FQN;
                    string DBID = cbFileDB.Text.Trim();
                    string getMetaData = "N";
                    if (ckMetaData.Checked)
                    {
                        getMetaData = "Y";
                    }

                    string OcrDirectory = "N";
                    if (ckOcr.Checked)
                    {
                        OcrDirectory = "Y";
                    }
                    else
                    {
                        OcrDirectory = "N";
                    }

                    lbIncludeExts.Items.Clear();
                    lbExcludeExts.Items.Clear();
                    AuthorizedFileTypes.Clear();
                    UnAuthorizedFileTypes.Clear();
                    SB.Text = "Adding directory";
                    string SUBDIR = cvtCkBox(ckSubDirs);
                    string VersionFiles = cvtCkBox(ckVersionFiles);
                    int I = 0;
                    SB.Text = "Adding Included File Types";
                    try
                    {
                        PBx.Value = 2;
                    }
                    catch (ThreadAbortException ex)
                    {
                        LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.");
                        Thread.ResetAbort();
                    }
                    catch (Exception ex)
                    {
                    }

                    AuthorizedFileTypes.Clear();
                    if (Conversions.ToBoolean(lbIncludeExts.Items.Count))
                    {
                        var loopTo = lbIncludeExts.Items.Count - 1;
                        for (I = 0; I <= loopTo; I++)
                        {
                            string InclExt = lbIncludeExts.Items[I].ToString();
                            AuthorizedFileTypes.Add(InclExt);
                        }
                    }

                    // UnAuthorizedFileTypes.Clear()
                    // If lbExcludeExts.Items.Count > 0 Then
                    // For I = 0 To Me.lbExcludeExts.Items.Count - 1
                    // Dim InclExt  = Me.lbExcludeExts.Items(I).ToString
                    // UnAuthorizedFileTypes.Add(InclExt )
                    // Next
                    // End If

                    bool BB = DBARCH.ckDirectoryExists(modGlobals.gCurrUserGuidID, FQN);
                    if (BB)
                    {
                        MessageBox.Show("Directory already defined to system, you must SAVE the new setup.");
                        SB.Text = "Directory already defined to system, you must SAVE the new setup.";
                    }
                    else
                    {
                        IncludeListHasChanged = true;
                        DIRS.setDb_id(ref DBID);
                        DIRS.setFqn(ref FQN);
                        DIRS.setIncludesubdirs(ref SUBDIR);
                        DIRS.setVersionfiles(ref VersionFiles);
                        DIRS.setUserid(ref modGlobals.gCurrUserGuidID);
                        DIRS.setCkmetadata(ref getMetaData);
                        string argval = "0";
                        DIRS.setQuickRefEntry(ref argval);
                        DIRS.setOcrDirectory(ref OcrDirectory);
                        DIRS.setSkipIfArchiveBit(ref ckArchiveBit.Checked.ToString());
                        DIRS.Insert();

                        // **************************************************************************************************************
                        // AddSubDirs(FQN , ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory , clAdminDir.Checked, RetentionCode )
                        // **************************************************************************************************************

                        string FileExt = "";
                        SB.Text = "Adding Included File Types";
                        try
                        {
                            PBx.Value = 4;
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (Exception ex)
                        {
                        }

                        var loopTo1 = AuthorizedFileTypes.Count - 1;
                        for (I = 0; I <= loopTo1; I++)
                        {
                            FileExt = AuthorizedFileTypes[I].ToString();
                            SB.Text = "Including File Type: " + FileExt;
                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            bool b = INL.DeleteExisting(modGlobals.gCurrUserGuidID, FQN);
                            b = InclAddList(lbIncludeExts, modGlobals.gCurrUserGuidID, FQN);
                            Application.DoEvents();
                        }

                        SB.Text = "Fetching Directories";
                        try
                        {
                            PBx.Value = 7;
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (Exception ex)
                        {
                        }

                        var argLB = lbArchiveDirs;
                        DBARCH.GetDirectories(ref argLB, modGlobals.gCurrUserGuidID, false);
                        lbArchiveDirs = argLB;
                        SB.Text = "Fetching Included Files";
                        try
                        {
                            PBx.Value = 9;
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 70 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (Exception ex)
                        {
                        }

                        var argLB1 = lbIncludeExts;
                        DBARCH.GetIncludedFiles(ref argLB1, modGlobals.gCurrUserGuidID, FQN);
                        lbIncludeExts = argLB1;
                        if (isAdmin == true)
                        {
                            string S = "";
                            if (clAdminDir.Checked == true)
                            {
                                if (ckSubDirs.Checked == true)
                                {
                                    S = "update [Directory] set [isSysDefault] = 1 where [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FQN] like '" + FQN + "%'";
                                }
                                else
                                {
                                    S = "update [Directory] set [isSysDefault] = 1 where [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FQN] like '" + FQN + "'";
                                }
                            }
                            else if (ckSubDirs.Checked == true)
                            {
                                S = "update [Directory] set [isSysDefault] = 0  where [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FQN] like '" + FQN + "%'";
                            }
                            else
                            {
                                S = "update [Directory] set [isSysDefault] = 0  where [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FQN] like '" + FQN + "'";
                            }

                            bool BBB = DBARCH.ExecuteSqlNewConn(S, false);
                            if (!BBB)
                            {
                                Debug.Print("Failed to update isSysDefault");
                            }
                        }

                        SB.Text = "Directory added.";

                        // Dim Msg2  = "Please remember, your next step is to set the archive parameters " + vbCrLf
                        // Msg2 += "and press the Save Changes button to activate this directory." + vbCrLf + vbCrLf
                        // 'Msg2 += "Once content is archived, parameter changes CANNOT be updated from this screen." + vbCrLf
                        // 'Msg2 += "This includes metadata, OCR this directory and public access."
                        // messagebox.show(Msg2, MsgBoxStyle.Exclamation)

                        Cursor = Cursors.Default;
                        IncludeListHasChanged = false;
                    }

                    PBx.Value = 0;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 80 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    SB.Text = "Error: please review trace log last entry. (Trace Log Icon in main screen)";
                    LOG.WriteToArchiveLog("frmMain:btnAddDir_Click: " + ex.Message);
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                }

                Cursor = Cursors.Default;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 81 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR IncludeDirectory 144.23.11: Failed to add directories.");
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void btnAddDir_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string DirFQN = txtDir.Text.Trim();
            IncludeDirectory(DirFQN);
        }

        public void AddSubDirs(string FQN, bool isPublic, bool isEnabled, string OcrDirectory, bool clAdminDir, string RetentionCode)
        {
            string PublicFlag = "";
            string DirEnabled = "";
            if (isPublic)
            {
                PublicFlag = "Y";
            }
            else
            {
                PublicFlag = "N";
            }

            if (isEnabled)
            {
                DirEnabled = "Y";
            }
            else
            {
                DirEnabled = "N";
            }

            if (clAdminDir)
            {
                clAdminDir = Conversions.ToBoolean(1);
            }
            else
            {
                clAdminDir = Conversions.ToBoolean(0);
            }

            FQN = UTIL.RemoveSingleQuotes(FQN);
            SubDirectories.Clear();
            if (ckSubDirs.Checked == true)
            {
                var A = new string[1];
                bool SubDirFound = DMA.RecursiveSearch(FQN, ref A);
                if (SubDirFound)
                {
                    DBARCH.delSubDirs(modGlobals.gCurrUserGuidID, FQN);
                    string tFqn = FQN;
                    SUBDIRECTORY.setUserid(ref modGlobals.gCurrUserGuidID);
                    SUBDIRECTORY.setFqn(ref FQN);
                    SUBDIRECTORY.setSubfqn(ref tFqn);
                    SUBDIRECTORY.setCkpublic(ref PublicFlag);
                    SUBDIRECTORY.setCkdisabledir(ref DirEnabled);
                    SUBDIRECTORY.setOcrDirectory(ref OcrDirectory);
                    SUBDIRECTORY.Insert();
                    SB2.Text = FQN;
                    SB2.Refresh();
                    Application.DoEvents();
                    int IntClAdminDir = 0;
                    if (clAdminDir == true)
                    {
                        IntClAdminDir = 1;
                    }

                    string S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString() + " where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' ";
                    DBARCH.ExecuteSqlNewConn(S, false);
                    S = "Update SubDir set RetentionCode = '" + RetentionCode + "' where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' ";
                    DBARCH.ExecuteSqlNewConn(S, false);
                    AuthorizedFileTypes.Add(tFqn);
                    UnAuthorizedFileTypes.Add(tFqn);
                    int iObj = SubDirectories.Count;
                    PBx.Value = 0;
                    PBx.Maximum = iObj + 2;
                    iObj = 0;
                    foreach (object O in SubDirectories)
                    {
                        tFqn = O.ToString().Trim();
                        SUBDIRECTORY.setUserid(ref modGlobals.gCurrUserGuidID);
                        SUBDIRECTORY.setFqn(ref FQN);
                        SUBDIRECTORY.setSubfqn(ref tFqn);
                        SUBDIRECTORY.setCkpublic(ref PublicFlag);
                        SUBDIRECTORY.setOcrDirectory(ref OcrDirectory);
                        SUBDIRECTORY.Insert();
                        S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString() + " where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' ";
                        DBARCH.ExecuteSqlNewConn(S, false);
                        S = "Update SubDir set RetentionCode = '" + RetentionCode + "' where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' ";
                        DBARCH.ExecuteSqlNewConn(S, false);
                        AuthorizedFileTypes.Add(tFqn);
                        UnAuthorizedFileTypes.Add(tFqn);
                        iObj += 1;
                        SB2.Text = FQN + ":" + iObj.ToString();
                        SB2.Refresh();
                        Application.DoEvents();
                        if (iObj <= SubDirectories.Count)
                        {
                            PBx.Value = iObj;
                            PBx.Refresh();
                        }

                        Application.DoEvents();
                    }

                    PBx.Value = 0;
                }
                else
                {
                    int IntClAdminDir = 0;
                    if (clAdminDir == true)
                    {
                        IntClAdminDir = 1;
                    }

                    DBARCH.delSubDirs(modGlobals.gCurrUserGuidID, FQN);
                    string tFqn = FQN;
                    SUBDIRECTORY.setUserid(ref modGlobals.gCurrUserGuidID);
                    SUBDIRECTORY.setFqn(ref FQN);
                    SUBDIRECTORY.setSubfqn(ref tFqn);
                    SUBDIRECTORY.setCkpublic(ref PublicFlag);
                    SUBDIRECTORY.setOcrDirectory(ref OcrDirectory);
                    SUBDIRECTORY.Insert();
                    string S = "Update SubDir set isSysDefault = " + IntClAdminDir.ToString() + " where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + FQN + "' and [SUBFQN] = '" + tFqn + "' ";
                    DBARCH.ExecuteSqlNewConn(S, false);
                    AuthorizedFileTypes.Add(tFqn);
                    UnAuthorizedFileTypes.Add(tFqn);
                }
            }

            SB.Text = "";
            SB.Refresh();
            Application.DoEvents();
        }

        public void addSubDirs(string FQN, ref List<string> LB)
        {
            LB.Clear();
            FQN = UTIL.RemoveSingleQuotes(FQN);
            LB.Add(FQN);
            if (ckSubDirs.Checked == true)
            {
                var A = new string[1];
                bool SubDirFound = DMA.RecursiveSearch(FQN, ref A);
                if (SubDirFound)
                {
                    string tFqn = FQN;
                    LB.Add(tFqn);
                    for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
                    {
                        if (A[i] == null)
                        {
                        }
                        else
                        {
                            tFqn = A[i].ToString();
                            LB.Add(tFqn);
                        }
                    }
                }
                else
                {
                    string tFqn = FQN;
                    LB.Add(tFqn);
                }
            }
        }

        private void Button6_Click(object sender, EventArgs e)
        {
            string FQN = txtDir.Text.Trim();
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckArchiveBit.Checked)
            {
                string tMsg = "";
                tMsg = tMsg + "WARNING! Skip if ARCHIVE bit set a HIGH RISK function." + Constants.vbCrLf;
                tMsg = tMsg + "ECM Library is not responsible for selecting to use it." + Constants.vbCrLf;
                tMsg = tMsg + "The file archive bit is a complex and ECM Library is not responsible for " + Constants.vbCrLf;
                tMsg = tMsg + "missed, skipped, or any other content related mishap due to " + Constants.vbCrLf;
                tMsg = tMsg + "this function being selected. " + Constants.vbCrLf + Constants.vbCrLf;
                tMsg = tMsg + "YOU UNDERSTAND AND FULLY ACCEPT THE RISK IN CHOOSING " + Constants.vbCrLf;
                tMsg = tMsg + "TO SKIP CONTENT BASED ON THE ARCHIVE BIT. " + Constants.vbCrLf + Constants.vbCrLf;
                tMsg = tMsg + "Selecting the 'Skip If Archive Bit off' check box exposes the " + Constants.vbCrLf;
                tMsg = tMsg + "archive to great risk. " + Constants.vbCrLf;
                tMsg = tMsg + "By agreeing to this disclaimer, you accept fully all the risk " + Constants.vbCrLf;
                tMsg = tMsg + "associated with skipping content with the archive bit set ";
                tMsg = tMsg + "previously Archived.";
                DialogResult dlgRes = (DialogResult)Interaction.MsgBox(tMsg, (MsgBoxStyle)((int)MsgBoxStyle.YesNo + (int)MsgBoxStyle.Critical), "YOU ACCEPT ALL THE RISK!");
                if (dlgRes == DialogResult.No)
                {
                    return;
                }

                tMsg = "Would you like to RESET all files' archive bit in this directory to NEEDS archive?";
                dlgRes = (DialogResult)Interaction.MsgBox(tMsg, (MsgBoxStyle)((int)MsgBoxStyle.YesNo + (int)MsgBoxStyle.Critical), "THIS CAN TAKE A WHILE");
                if (dlgRes == DialogResult.No)
                {
                    SB.Text = "Files Archive bit will be USED as is.";
                }
                else
                {
                    SB.Text = "Standby - initializing all files archive bit to ON.";
                    string tCmd = "";
                    if (ckSubDirs.Checked)
                    {
                        tCmd = " " + FQN + @"\*.* +a /s";
                        // System.Diagnostics.Process.Start("attrib.exe", tFQN )
                        var p = Process.Start("attrib.exe", tCmd);
                    }
                    // p.WaitForExit()
                    else
                    {
                        tCmd = "attrib " + FQN + @"\*.* +a";
                        var p = Process.Start("attrib.exe", tCmd);
                        // p.WaitForExit()
                    }
                }

                SB.Text = " ";
            }

            btnSaveChanges.BackColor = Color.LightGray;
            string RetentionCode = cbRetention.Text;
            if (RetentionCode.Length == 0)
            {
                cbRetention.Text = DBARCH.getRetentionPeriodMax();
                RetentionCode = cbRetention.Text;
            }

            int RetentionPeriod = 0;
            if (RetentionCode.Trim().Length == 0)
            {
                RetentionPeriod = 10;
            }

            RetentionPeriod = DBARCH.getRetentionPeriod(RetentionCode);
            int iCnt = lbArchiveDirs.SelectedItems.Count;
            if (txtDir.Text.Length > 0)
            {
                SB.Text = "Updating " + txtDir.Text.Trim();
            }
            else if (iCnt <= 0)
            {
                MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.");
                return;
            }

            Cursor = Cursors.WaitCursor;
            FQN = UTIL.RemoveSingleQuotes(FQN);
            txtDir.Text = FQN;
            // Dim DBID = cbFileDB.SelectedItem.ToString
            string DBID = "ECMREPO";
            string SUBDIR = cvtCkBox(ckSubDirs);
            string DeleteOnArchive = cvtCkBox(ckDeleteAfterArchive);
            string VersionFiles = cvtCkBox(ckVersionFiles);
            int I = 0;
            string DisableDir = "N";
            if (DBID.Length == 0)
            {
                MessageBox.Show("Please select a repository...");
                Cursor = Cursors.Default;
                return;
            }

            if (lbIncludeExts.Items.Count == 0)
            {
                MessageBox.Show("Please remember to include one or more filetypes in this archive...");
            }

            string OcrPdf = "N";
            if (ckOcrPdf.Checked)
            {
                OcrPdf = "Y";
                modGlobals.gPdfExtended = true;
            }
            else
            {
                OcrPdf = "N";
                modGlobals.gPdfExtended = false;
            }

            string OcrDirectory = "N";
            if (ckOcr.Checked)
            {
                OcrDirectory = "Y";
            }
            else
            {
                OcrDirectory = "N";
            }

            string getMetaData = "N";
            if (ckMetaData.Checked)
            {
                getMetaData = "Y";
            }

            string SetToPublic = "N";
            if (ckPublic.Checked)
            {
                SetToPublic = "Y";
                DBARCH.AddSysMsg(FQN + " set to PUBLIC access.");
            }
            else
            {
                SetToPublic = "N";
                DBARCH.AddSysMsg(FQN + " set to PRIVATE access.");
            }

            if (DBARCH.isPublicAllowed() == false)
            {
                ckPublic.Checked = false;
                SetToPublic = "N";
            }

            if (ckDisableDir.Checked)
            {
                DisableDir = "Y";
            }
            else
            {
                DisableDir = "N";
            }

            bool BB = DBARCH.ckDirectoryExists(modGlobals.gCurrUserGuidID, FQN);
            if (!BB)
            {
                MessageBox.Show("Directory IS NOT defined to system, adding it.");
                btnAddDir_Click(null, null);
            }
            else
            {
                DIRS.setDb_id(ref DBID);
                DIRS.setFqn(ref FQN);
                SUBDIR = UTIL.RemoveSingleQuotes(SUBDIR);
                DIRS.setIncludesubdirs(ref SUBDIR);
                DIRS.setUserid(ref modGlobals.gCurrUserGuidID);
                DIRS.setVersionfiles(ref VersionFiles);
                DIRS.setCkmetadata(ref getMetaData);
                DIRS.setCkpublic(ref SetToPublic);
                DIRS.setCkdisabledir(ref DisableDir);
                string argval = "0";
                DIRS.setQuickRefEntry(ref argval);
                DIRS.setOcrDirectory(ref OcrDirectory);
                DIRS.setSkipIfArchiveBit(ref ckArchiveBit.Checked.ToString());
                DIRS.setOcrPdf(ref OcrPdf);
                DIRS.setDeleteOnArchive(ref DeleteOnArchive);
                AuthorizedFileTypes.Clear();
                UnAuthorizedFileTypes.Clear();
                AuthorizedFileTypes.Add(FQN);
                UnAuthorizedFileTypes.Add(FQN);
                string WhereClause = "";
                if (ckOcr.Checked)
                {
                    OcrDirectory = "Y";
                }
                else
                {
                    OcrDirectory = "N";
                }

                if (SUBDIR.Equals("Y"))
                {
                    // WhereClause  = "where UserID = '" + gCurrUserGuidID + "' and [FQN] like '" + FQN + "%\' and AdminDisabled <> 1 and ckDisableDir <> 'Y'"
                    // DIRS.Update(WhereClause , OcrDirectory)

                    WhereClause = "where UserID = '" + modGlobals.gCurrUserGuidID + "' and [FQN] = '" + FQN + "'";
                    DIRS.Update(WhereClause, OcrDirectory);
                }
                else
                {
                    WhereClause = "where UserID = '" + modGlobals.gCurrUserGuidID + "' and [FQN] = '" + FQN + "'";
                    DIRS.Update(WhereClause, OcrDirectory);
                }

                if (clAdminDir.Checked)
                {
                    string msg = "This Directory will become mandatory for everyone, are you sure?";
                    var dlgRes = MessageBox.Show(msg, "Mandatory Directory", MessageBoxButtons.YesNo);
                    if (dlgRes == DialogResult.No)
                    {
                        return;
                    }

                    string S = "Update Directory set isSysDefault = 1 " + WhereClause;
                    bool bb1 = DBARCH.ExecuteSqlNewConn(S, false);
                    if (!bb1)
                    {
                        Console.WriteLine("Error 1994.23.1 - did not update isSysDefault");
                    }
                }
                else
                {
                    string S = "Update Directory set isSysDefault = 0 " + WhereClause;
                    bool bb1 = DBARCH.ExecuteSqlNewConn(S, false);
                    if (!bb1)
                    {
                        Console.WriteLine("Error 1994.23.1 - did not update isSysDefault");
                    }
                }

                string tSql1 = "Update Directory set RetentionCode = '" + RetentionCode + "' " + WhereClause;
                bool BB2 = DBARCH.ExecuteSqlNewConn(tSql1, false);
                if (!BB2)
                {
                    Console.WriteLine("Error 1994.23.1x - did not update RetentionCode");
                }

                SB.Text = "Step 1 of 4 standby...";
                DBARCH.SetDocumentPublicFlagByOwnerDir(FQN, ckPublic.Checked, ckDisableDir.Checked, OcrDirectory);
                SB.Text = "Step 2 of 4 standby... ";
                // DBARCH.SetDocumentPublicFlagByOwnerDir(FQN , Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory )

                SB.Text = "Step 3 of 4 standby...";
                string sSql = "delete from [IncludedFiles] where FQN = '" + FQN + "'";
                BB = DBARCH.ExecuteSqlNewConn(90301, sSql);
                PBx.Maximum = AuthorizedFileTypes.Count;
                PBx.Value = 0;
                var loopTo = AuthorizedFileTypes.Count - 1;
                for (I = 0; I <= loopTo; I++)
                {
                    FQN = AuthorizedFileTypes[I].ToString();
                    bool b = INL.DeleteExisting(modGlobals.gCurrUserGuidID, FQN);
                    b = InclAddList(lbIncludeExts, modGlobals.gCurrUserGuidID, FQN);
                    if (!b)
                    {
                        if (!b)
                        {
                            DBARCH.xTrace(87925, "frmMain:btnSaveChanges:AddList", "Failed for: " + FQN + " : " + modGlobals.gCurrUserGuidID);
                        }
                    }

                    if (I % 5 == 0)
                    {
                        SB.Text = "Processing SubDir: " + I.ToString() + " of " + AuthorizedFileTypes.Count.ToString();
                    }

                    PBx.Value = I;
                    Application.DoEvents();
                }

                lbExcludeExts.Visible = false;
                lbIncludeExts.Visible = false;
                lbAvailExts.Visible = false;
                lbArchiveDirs.Enabled = false;
                PBx.Maximum = UnAuthorizedFileTypes.Count + 2;
                var loopTo1 = UnAuthorizedFileTypes.Count - 1;
                for (I = 0; I <= loopTo1; I++)
                {
                    PBx.Value = I;
                    PBx.Refresh();
                    // If IncludeListHasChanged = False Then
                    // Exit For
                    // End If
                    FQN = UnAuthorizedFileTypes[I].ToString();
                    bool b = EXL.DeleteExisting(modGlobals.gCurrUserGuidID, FQN);
                    b = ExcludeAddList(lbExcludeExts, modGlobals.gCurrUserGuidID, FQN);
                    if (!b)
                    {
                        if (!b)
                        {
                            DBARCH.xTrace(87925.22, "frmMain:btnSaveChanges:AddList", "Failed for: " + FQN + " : " + modGlobals.gCurrUserGuidID);
                        }
                    }
                    // ** WDM DBARCH.SetDocumentPublicFlag(gCurrUserGuidID, FQN , Me.ckPublic.Checked, Me.ckDisableDir.Checked)
                    if (I % 5 == 0)
                    {
                        SB.Text = "Adding subdirectories... standby: " + I.ToString();
                    }

                    Application.DoEvents();
                    Application.DoEvents();
                    var argLB = lbArchiveDirs;
                    DBARCH.GetDirectories(ref argLB, modGlobals.gCurrUserGuidID, false);
                    lbArchiveDirs = argLB;
                    var argLB1 = lbIncludeExts;
                    DBARCH.GetIncludedFiles(ref argLB1, modGlobals.gCurrUserGuidID, FQN);
                    lbIncludeExts = argLB1;
                    Application.DoEvents();
                }

                Cursor = Cursors.AppStarting;
                if (ckPublic.Checked)
                {
                    SetToPublic = "Y";
                    string S = "Update [Directory] set ckPublic = 'Y' ";
                    S = S + " where FQN = '" + FQN + "' ";
                    S = S + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    DBARCH.ExecuteSqlNewConn(90302, S);
                    if (ckPublic.Enabled)
                    {
                        SB.Text = "Standby, updating the repository, this can take a long time.";
                        Refresh();
                        Application.DoEvents();
                        Cursor = Cursors.AppStarting;
                        S = "update DataSource set isPublic = 'Y' where FileDirectory = '" + FQN + "' and DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
                        DBARCH.ExecuteSqlNewConn(90303, S);
                        Cursor = Cursors.Default;
                    }
                }
                else
                {
                    SetToPublic = "N";
                    string S = "Update [Directory] set ckPublic = 'N' ";
                    S = S + " where FQN = '" + FQN + "' ";
                    S = S + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    DBARCH.ExecuteSqlNewConn(90304, S);
                    if (ckPublic.Enabled)
                    {
                        SB.Text = "Standby, updating the repository, this can take a long time.";
                        Refresh();
                        Application.DoEvents();
                        Cursor = Cursors.AppStarting;
                        S = "update DataSource set isPublic = 'N' where FileDirectory = '" + FQN + "' and DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
                        DBARCH.ExecuteSqlNewConn(90305, S);
                        Cursor = Cursors.Default;
                    }
                }

                Cursor = Cursors.Default;
            }

            if (CkMonitor.Checked == true)
            {
                CkMonitor_CheckedChanged(null, null);
            }

            PBx.Value = 0;
            lbExcludeExts.Visible = true;
            lbIncludeExts.Visible = true;
            lbAvailExts.Visible = true;
            lbArchiveDirs.Enabled = true;
            btnRefresh.Text = "Show Enabled";
            Button5_Click(null, null);
            IncludeListHasChanged = false;
            SB.Text = "Complete...";
            PBx.Value = 0;
            Cursor = Cursors.Default;
        }

        private void MirrorDirectory(string DirName)
        {
            lblNotice.Text = "ADDING: " + DirName;
            string RetentionCode = cbRetention.Text;
            if (RetentionCode.Length == 0)
            {
                cbRetention.Text = DBARCH.getRetentionPeriodMax();
                RetentionCode = cbRetention.Text;
            }

            int RetentionPeriod = 0;
            if (RetentionCode.Trim().Length == 0)
            {
                RetentionPeriod = 10;
            }

            RetentionPeriod = DBARCH.getRetentionPeriod(RetentionCode);
            int iCnt = lbArchiveDirs.SelectedItems.Count;
            if (DirName.Length > 0)
            {
                SB.Text = "Updating " + DirName.Trim();
            }
            else if (iCnt <= 0)
            {
                MessageBox.Show("You have failed to select a PARENT DIRECTORY, pick one and only one, returning.");
                return;
            }

            Cursor = Cursors.WaitCursor;
            DirName = UTIL.RemoveSingleQuotes(DirName);
            string DBID = "ECMREPO";
            string SUBDIR = cvtCkBox(ckSubDirs);
            string DeleteOnArchive = cvtCkBox(ckDeleteAfterArchive);
            string VersionFiles = cvtCkBox(ckVersionFiles);
            int I = 0;
            string DisableDir = "N";
            if (DBID.Length == 0)
            {
                MessageBox.Show("Please select a repository...");
                Cursor = Cursors.Default;
                return;
            }

            if (lbIncludeExts.Items.Count == 0)
            {
                MessageBox.Show("Please remember to include one or more filetypes in this archive...");
            }

            string OcrPdf = "N";
            if (ckOcrPdf.Checked)
            {
                OcrPdf = "Y";
                modGlobals.gPdfExtended = true;
            }
            else
            {
                OcrPdf = "N";
                modGlobals.gPdfExtended = false;
            }

            string OcrDirectory = "N";
            if (ckOcr.Checked)
            {
                OcrDirectory = "Y";
            }
            else
            {
                OcrDirectory = "N";
            }

            string getMetaData = "N";
            if (ckMetaData.Checked)
            {
                getMetaData = "Y";
            }

            string SetToPublic = "N";
            if (ckPublic.Checked)
            {
                SetToPublic = "Y";
                DBARCH.AddSysMsg(DirName + " set to PUBLIC access.");
            }
            else
            {
                SetToPublic = "N";
                DBARCH.AddSysMsg(DirName + " set to PRIVATE access.");
            }

            if (DBARCH.isPublicAllowed() == false)
            {
                ckPublic.Checked = false;
                SetToPublic = "N";
            }

            if (ckDisableDir.Checked)
            {
                DisableDir = "Y";
            }
            else
            {
                DisableDir = "N";
            }

            bool BB = DBARCH.ckDirectoryExists(modGlobals.gCurrUserGuidID, DirName);
            if (!BB)
            {
                LOG.WriteToArchiveLog("Directory '" + DirName + "' IS NOT defined to system, adding it.");
                btnAddDir_Click(null, null);
            }
            else
            {
                DIRS.setDb_id(ref DBID);
                DIRS.setFqn(ref DirName);
                SUBDIR = UTIL.RemoveSingleQuotes(SUBDIR);
                DIRS.setIncludesubdirs(ref SUBDIR);
                DIRS.setUserid(ref modGlobals.gCurrUserGuidID);
                DIRS.setVersionfiles(ref VersionFiles);
                DIRS.setCkmetadata(ref getMetaData);
                DIRS.setCkpublic(ref SetToPublic);
                DIRS.setCkdisabledir(ref DisableDir);
                string argval = "0";
                DIRS.setQuickRefEntry(ref argval);
                DIRS.setOcrDirectory(ref OcrDirectory);
                DIRS.setSkipIfArchiveBit(ref ckArchiveBit.Checked.ToString());
                DIRS.setOcrPdf(ref OcrPdf);
                DIRS.setDeleteOnArchive(ref DeleteOnArchive);
                AuthorizedFileTypes.Clear();
                UnAuthorizedFileTypes.Clear();
                AuthorizedFileTypes.Add(DirName);
                UnAuthorizedFileTypes.Add(DirName);
                string WhereClause = "";
                if (ckOcr.Checked)
                {
                    OcrDirectory = "Y";
                }
                else
                {
                    OcrDirectory = "N";
                }

                if (SUBDIR.Equals("Y"))
                {
                    // WhereClause  = "where UserID = '" + gCurrUserGuidID + "' and [DirNAme] like '" + DirNAme + "%\' and AdminDisabled <> 1 and ckDisableDir <> 'Y'"
                    // DIRS.Update(WhereClause , OcrDirectory)

                    WhereClause = "where UserID = '" + modGlobals.gCurrUserGuidID + "' and [DirNAme] = '" + DirName + "'";
                    DIRS.Update(WhereClause, OcrDirectory);
                }
                else
                {
                    WhereClause = "where UserID = '" + modGlobals.gCurrUserGuidID + "' and [DirNAme] = '" + DirName + "'";
                    DIRS.Update(WhereClause, OcrDirectory);
                }

                if (clAdminDir.Checked)
                {
                    string msg = "This Directory will become mandatory for everyone, are you sure?";
                    var dlgRes = MessageBox.Show(msg, "Mandatory Directory", MessageBoxButtons.YesNo);
                    if (dlgRes == DialogResult.No)
                    {
                        return;
                    }

                    string S = "Update Directory set isSysDefault = 1 " + WhereClause;
                    bool bb1 = DBARCH.ExecuteSqlNewConn(S, false);
                    if (!bb1)
                    {
                        Console.WriteLine("Error 1994.23.1 - did not update isSysDefault");
                    }
                }
                else
                {
                    string S = "Update Directory set isSysDefault = 0 " + WhereClause;
                    bool bb1 = DBARCH.ExecuteSqlNewConn(S, false);
                    if (!bb1)
                    {
                        Console.WriteLine("Error 1994.23.1 - did not update isSysDefault");
                    }
                }

                string tSql1 = "Update Directory set RetentionCode = '" + RetentionCode + "' " + WhereClause;
                bool BB2 = DBARCH.ExecuteSqlNewConn(tSql1, false);
                if (!BB2)
                {
                    Console.WriteLine("Error 1994.23.1x - did not update RetentionCode");
                }

                SB.Text = "Step 1 of 4 standby...";
                DBARCH.SetDocumentPublicFlagByOwnerDir(DirName, ckPublic.Checked, ckDisableDir.Checked, OcrDirectory);
                SB.Text = "Step 2 of 4 standby... ";
                // DBARCH.SetDocumentPublicFlagByOwnerDir(DirNAme , Me.ckPublic.Checked, Me.ckDisableDir.Checked, OcrDirectory )

                SB.Text = "Step 3 of 4 standby...";
                string sSql = "delete from [IncludedFiles] where DirNAme = '" + DirName + "'";
                BB = DBARCH.ExecuteSqlNewConn(90301, sSql);
                PBx.Maximum = AuthorizedFileTypes.Count;
                PBx.Value = 0;
                var loopTo = AuthorizedFileTypes.Count - 1;
                for (I = 0; I <= loopTo; I++)
                {
                    DirName = AuthorizedFileTypes[I].ToString();
                    bool b = INL.DeleteExisting(modGlobals.gCurrUserGuidID, DirName);
                    b = InclAddList(lbIncludeExts, modGlobals.gCurrUserGuidID, DirName);
                    if (!b)
                    {
                        if (!b)
                        {
                            DBARCH.xTrace(87925, "frmMain:btnSaveChanges:AddList", "Failed for: " + DirName + " : " + modGlobals.gCurrUserGuidID);
                        }
                    }

                    if (I % 5 == 0)
                    {
                        SB.Text = "Processing SubDir: " + I.ToString() + " of " + AuthorizedFileTypes.Count.ToString();
                    }

                    PBx.Value = I;
                    Application.DoEvents();
                }

                lbExcludeExts.Visible = false;
                lbIncludeExts.Visible = false;
                lbAvailExts.Visible = false;
                lbArchiveDirs.Enabled = false;
                PBx.Maximum = UnAuthorizedFileTypes.Count + 2;
                var loopTo1 = UnAuthorizedFileTypes.Count - 1;
                for (I = 0; I <= loopTo1; I++)
                {
                    PBx.Value = I;
                    PBx.Refresh();
                    // If IncludeListHasChanged = False Then
                    // Exit For
                    // End If
                    DirName = UnAuthorizedFileTypes[I].ToString();
                    bool b = EXL.DeleteExisting(modGlobals.gCurrUserGuidID, DirName);
                    b = ExcludeAddList(lbExcludeExts, modGlobals.gCurrUserGuidID, DirName);
                    if (!b)
                    {
                        if (!b)
                        {
                            DBARCH.xTrace(87925.22, "frmMain:btnSaveChanges:AddList", "Failed for: " + DirName + " : " + modGlobals.gCurrUserGuidID);
                        }
                    }
                    // ** WDM DBARCH.SetDocumentPublicFlag(gCurrUserGuidID, DirNAme , Me.ckPublic.Checked, Me.ckDisableDir.Checked)
                    if (I % 5 == 0)
                    {
                        SB.Text = "Adding subdirectories... standby: " + I.ToString();
                    }

                    Application.DoEvents();
                    Application.DoEvents();
                    var argLB = lbArchiveDirs;
                    DBARCH.GetDirectories(ref argLB, modGlobals.gCurrUserGuidID, false);
                    lbArchiveDirs = argLB;
                    var argLB1 = lbIncludeExts;
                    DBARCH.GetIncludedFiles(ref argLB1, modGlobals.gCurrUserGuidID, DirName);
                    lbIncludeExts = argLB1;
                    Application.DoEvents();
                }

                Cursor = Cursors.AppStarting;
                if (ckPublic.Checked)
                {
                    SetToPublic = "Y";
                    string S = "Update [Directory] set ckPublic = 'Y' ";
                    S = S + " where DirNAme = '" + DirName + "' ";
                    S = S + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    DBARCH.ExecuteSqlNewConn(90302, S);
                    if (ckPublic.Enabled)
                    {
                        SB.Text = "Standby, updating the repository, this can take a long time.";
                        Refresh();
                        Application.DoEvents();
                        Cursor = Cursors.AppStarting;
                        S = "update DataSource set isPublic = 'Y' where FileDirectory = '" + DirName + "' and DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
                        DBARCH.ExecuteSqlNewConn(90303, S);
                        Cursor = Cursors.Default;
                    }
                }
                else
                {
                    SetToPublic = "N";
                    string S = "Update [Directory] set ckPublic = 'N' ";
                    S = S + " where DirNAme = '" + DirName + "' ";
                    S = S + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    DBARCH.ExecuteSqlNewConn(90304, S);
                    if (ckPublic.Enabled)
                    {
                        SB.Text = "Standby, updating the repository, this can take a long time.";
                        Refresh();
                        Application.DoEvents();
                        Cursor = Cursors.AppStarting;
                        S = "update DataSource set isPublic = 'N' where FileDirectory = '" + DirName + "' and DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
                        DBARCH.ExecuteSqlNewConn(90305, S);
                        Cursor = Cursors.Default;
                    }
                }

                Cursor = Cursors.Default;
            }

            if (CkMonitor.Checked == true)
            {
                CkMonitor_CheckedChanged(null, null);
            }

            PBx.Value = 0;
            lbExcludeExts.Visible = true;
            lbIncludeExts.Visible = true;
            lbAvailExts.Visible = true;
            lbArchiveDirs.Enabled = true;
            btnRefresh.Text = "Show Enabled";
            Button5_Click(null, null);
            IncludeListHasChanged = false;
            SB.Text = "Complete...";
            PBx.Value = 0;
            Cursor = Cursors.Default;
        }

        private void btnInclFileType_Click(object sender, EventArgs e)
        {
            try
            {
                if (modGlobals.gTraceFunctionCalls.Equals(1))
                {
                    LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
                }

                // If ckDirProfileMaint.Checked Then

                // End If

                // If txtDir.Text.Trim.Length = 0 Then
                // messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
                // Return
                // End If
                string S1 = lbAvailExts.SelectedItem.ToString();
                foreach (string S in lbAvailExts.SelectedItems)
                {
                    bool ItemAlreadyExists = false;
                    for (int I = 0, loopTo = lbIncludeExts.Items.Count - 1; I <= loopTo; I++)
                    {
                        string ExistingItem = Conversions.ToString(lbIncludeExts.Items[I]);
                        if (S.ToUpper().Equals(ExistingItem.ToUpper()))
                        {
                            ItemAlreadyExists = true;
                            break;
                        }
                    }

                    if (ItemAlreadyExists == false)
                    {
                        lbIncludeExts.Items.Add(S);
                        btnSaveChanges.BackColor = Color.OrangeRed;
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR btnInclFileType_Click : " + ex.Message);
                SB.Text = "Error - please refer to error log.";
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void btnRemoveDir_Click(object sender, EventArgs e)
        {
            try
            {
                if (modGlobals.gTraceFunctionCalls.Equals(1))
                {
                    LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
                }

                if (clAdminDir.Checked)
                {
                    MessageBox.Show("Cannot remove a mandatory directory, returning.");
                    return;
                }

                if (!lbArchiveDirs.SelectedItems.Count.Equals(1))
                {
                    MessageBox.Show("One and only one directory must be selected to remove, returning...");
                    return;
                }

                int iCnt = lbArchiveDirs.SelectedItems.Count;
                if (iCnt <= 0)
                {
                    MessageBox.Show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.");
                    return;
                }

                if (iCnt > 1)
                {
                    MessageBox.Show("Please select one and only one directory to remove, returning.");
                    return;
                }

                string TgtDir = Conversions.ToString(lbArchiveDirs.SelectedItems[0]);
                string msg = "This will DELETE the selected directory AND ALL SUB-DIRECTORIES from the archive process, are you sure?";
                var dlgRes = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo);
                if (dlgRes == DialogResult.No)
                {
                    Cursor = Cursors.Default;
                    return;
                }

                Cursor = Cursors.WaitCursor;
                string FQN = txtDir.Text.Trim();
                FQN = lbArchiveDirs.SelectedItems[0].ToString().Trim();
                string S = "";
                if (FQN.Contains("'"))
                {
                    FQN.Replace("''", "'");
                    FQN.Replace("'", "''");
                }

                bool B = false;
                if (ckSubDirs.Checked)
                {
                    S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90306, S);
                    S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90307, S);
                    S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90308, S);
                    S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "%' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90309, S);
                    ProcessListener(false);
                }
                else
                {
                    S = " delete from DirectoryGuids where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90310, S);
                    S = " delete from DirectoryListener where DirGuid  in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90311, S);
                    S = " delete from DirectoryListenerFiles where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90312, S);
                    S = " delete from Directory where DirGuid in (select DirGuid from Directory where FQN like '" + FQN + "' and UserID = '" + modGlobals.gCurrUserGuidID + "')";
                    B = DBARCH.ExecuteSqlNewConn(90313, S);
                    ProcessListener(false);
                }

                SB.Text = "Directory <" + TgtDir + "> removed.";
                ProcessListener(false);
                var argLB = lbArchiveDirs;
                DBARCH.GetDirectories(ref argLB, modGlobals.gCurrUserGuidID, false);
                lbArchiveDirs = argLB;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR btnRemoveDir_Click : No file type selected.");
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }

            Cursor = Cursors.Default;
        }

        private void Button5_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (btnRefresh.Text.Equals("Show Enabled"))
            {
                lbArchiveDirs.Items.Clear();
                var argLB = lbArchiveDirs;
                DBARCH.GetDirectories(ref argLB, modGlobals.gCurrUserGuidID, false);
                lbArchiveDirs = argLB;
                Cursor = Cursors.Default;
                btnRefresh.Text = "Show Disabled";
            }
            else
            {
                lbArchiveDirs.Items.Clear();
                var argLB1 = lbArchiveDirs;
                DBARCH.GetDirectories(ref argLB1, modGlobals.gCurrUserGuidID, true);
                lbArchiveDirs = argLB1;
                Cursor = Cursors.Default;
                btnRefresh.Text = "Show Enabled";
            }
        }

        public string cvtCkBox(CheckBox CB)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            if (CB.Checked == true)
            {
                S = "Y";
            }
            else
            {
                S = "N";
            }

            return S;
        }

        public bool cvtTF(string tVal)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            tVal = Strings.UCase(tVal);
            if (tVal == "Y")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            if (!DBARCH.isAdmin(modGlobals.gCurrUserGuidID))
            {
                DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
                MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string msg = "This will remove the associated file types, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Remove Directory", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            string ParentFT = "";
            string ChildFT = "";
            string S = cbProcessAsList.Text;
            if (S.Length == 0)
            {
                MessageBox.Show("Please select an item to process... returning.");
                return;
            }

            int I = 0;
            int J = 0;
            I = Strings.InStr(S, "-");
            ParentFT = Strings.Mid(S, 1, I - 1).Trim();
            J = Strings.InStr(S, ">");
            ChildFT = Strings.Mid(S, J + 1).Trim();
            PFA.setExtcode(ref ParentFT);
            PFA.setProcessextcode(ref ChildFT);
            bool B = DBARCH.ckProcessAsExists(ParentFT);
            if (B)
            {
                B = PFA.Delete("where [ExtCode] = '" + ParentFT + "' ");
                if (!B)
                {
                    MessageBox.Show("Delete failed...");
                }
                else
                {
                    S = "update  [DataSource] set [SourceTypeCode] = '" + ParentFT + "' where [SourceTypeCode] = '" + ChildFT + "' and [DataSourceOwnerUserID] = '" + modGlobals.gCurrUserGuidID + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    if (B)
                    {
                        SB.Text = ChildFT + " Reset to process as " + ParentFT;
                    }
                }

                var argCB = cbProcessAsList;
                DBARCH.GetProcessAsList(ref argCB);
                cbProcessAsList = argCB;
            }
        }

        public void ActivateProgressBar(double FileLength)
        {

            // Dim ImageSizeDouble As Double = 0

            My.MyProject.Forms.frmPercent.fSize = modGlobals.gfile_Length;
            My.MyProject.Forms.frmPercent.Show();
            My.MyProject.Forms.frmPercent.Top = Top - 10;
            My.MyProject.Forms.frmPercent.Left = Left;
            My.MyProject.Forms.frmPercent.Width = Width;
            // frmPercent.TopLevel = True

            int I = 0;
            My.MyProject.Forms.frmPercent.PB.Value = 0;
            My.MyProject.Forms.frmPercent.PB.Maximum = 1001;
            while (DisplayActivity == true)
            {
                I += 1;
                Thread.Sleep(250);
                // If I Mod 15 = 0 Then
                // Dim D As Double = DBARCH.getDataSourceImageLength(ImageGuid)
                // Me.SB.Text = (D / ImageSizeDouble * 100).ToString + "% Loaded"
                // End If
                if (I >= 1000)
                {
                    I = 1;
                }

                My.MyProject.Forms.frmPercent.Text = "%";
                My.MyProject.Forms.frmPercent.PB.Value = I;
                My.MyProject.Forms.frmPercent.PB.Refresh();
                My.MyProject.Forms.frmPercent.PB.Visible = true;
                Application.DoEvents();
            }

            My.MyProject.Forms.frmPercent.Close();
        }

        public void ArchiveContent(string MachineID, string CurrUserGuidID)
        {
            modGlobals.FilesBackedUp = 0;
            modGlobals.FilesSkipped = 0;
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int LL = 0;
            string cFolder = "";
            string pFolder = "XXX";
            string ArchiveMsg = "";
            string RetentionCode = "";
            int PauseThreadMS = 0;
            string FOLDER_FQN = "XXX";
            string ParentDir = "XXX";
            LL = 1;
            bool bExplodeZipFile = false;
            LL = 6;
            int StackLevel = 0;
            LL = 11;
            var ListOfFiles = new Dictionary<string, int>();
            LL = 16;
            string ERR_FQN = System.Configuration.ConfigurationManager.AppSettings["MoveErrorDir"];
            LL = 21;
            LL = 26;
            string file_FullName = "";
            LL = 31;
            string file_name = "";
            LL = 36;
            LL = 41;
            if (!Directory.Exists(ERR_FQN))
            {
                LL = 46;
                LL = 51;
                try
                {
                    Directory.CreateDirectory(ERR_FQN);
                    LL = 61;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("FATAL ERROR: Could not create the directory " + ERR_FQN + ", aborting archive.");
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + LL.ToString());
                    return;
                }

                LL = 101;
            }

            LL = 106;
            LL = 111;
            var ListOfFilesToDelete = new SortedList<string, string>();
            LL = 116;
            string DeleteOnArchive = "";
            LL = 121;
            LL = 126;
            var ExistingFileTypes = new Dictionary<string, int>();
            LL = 131;
            DBARCH.LoadFileTypeDictionary(ref ExistingFileTypes);
            LL = 136;
            LL = 141;
            if (CurrUserGuidID is null)
            {
                LL = 146;
                CurrUserGuidID = UIDcurr;
                LL = 151;
            }

            LL = 156;
            if (CurrUserGuidID.Length == 0)
            {
                LL = 161;
                CurrUserGuidID = UIDcurr;
                LL = 166;
            }

            LL = 171;
            LL = 176;
            modGlobals.gContactsArchiving = true;
            LL = 181;
            LL = 186;
            if (modGlobals.gRunMinimized == true)
            {
                LL = 191;
                My.MyProject.Forms.frmNotify.WindowState = FormWindowState.Minimized;
                LL = 196;
            }
            else
            {
                LL = 201;
                My.MyProject.Forms.frmNotify.Show();
                LL = 206;
            }

            LL = 211;
            LL = 216;
            if (modGlobals.gRunMinimized)
            {
                LL = 221;
                My.MyProject.Forms.frmNotify.WindowState = FormWindowState.Minimized;
                LL = 226;
            }

            LL = 231;
            LL = 236;
            My.MyProject.Forms.frmNotify.Text = "CONTENT";
            LL = 241;
            My.MyProject.Forms.frmNotify.Label1.Text = "CONTENT";
            LL = 246;
            // frmNotify.Location = New Point(25, 300) : LL = 251
            LL = 256;
            if (modGlobals.gRunMode.Equals("M-END"))
            {
                LL = 261;
                My.MyProject.Forms.frmNotify.WindowState = FormWindowState.Minimized;
                LL = 266;
            }

            LL = 271;
            LL = 276;
            int iContent = 0;
            LL = 281;
            int LastVerNbr = 0;
            LL = 286;
            int NextVersionNbr = 0;
            LL = 291;
            LL = 296;
            if (DBARCH.isArchiveDisabled("CONTENT") == true)
            {
                LL = 301;
                modGlobals.gContentArchiving = false;
                LL = 306;
                My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                LL = 311;
                My.MySettingsProperty.Settings.Save();
                LL = 316;
                return;
                LL = 321;
            }

            LL = 326;
            LL = 331;
            string PrevParentDir = "";
            LL = 336;
            LL = 341;
            PROC.getCurrentApplications();
            LL = 346;
            LL = 351;
            if (ddebug)
            {
                LOG.WriteToArchiveLog("frmMain : ArchiveContent :8000 : trace log.");
                LL = 356;
            }

            LL = 361;
            int RetentionYears = (int)Conversion.Val(DBARCH.getSystemParm("RETENTION YEARS"));
            LL = 366;
            LL = 371;
            var rightNow = DateAndTime.Now.AddYears(RetentionYears);
            LL = 376;
            string RetentionExpirationDate = rightNow.ToString();
            LL = 381;
            string EmailFQN = "";
            LL = 386;
            modGlobals.ZipFilesContent.Clear();
            LL = 391;
            var a = new string[1];
            LL = 396;
            LL = 401;
            CompletedPolls = CompletedPolls + 1;
            LL = 406;
            LL = 411;
            if (UseThreads == false)
            {
                SB5.Text = DateAndTime.Now + " : Archiving data... standby: " + CompletedPolls;
                LL = 416;
            }

            LL = 421;
            // Dim ActiveFolders(0)	:	LL = 	426
            var ActiveFolders = new List<string>();
            LL = 431;
            string FolderName = "";
            LL = 436;
            bool DeleteFile = false;
            LL = 441;
            string OcrDirectory = "";
            LL = 446;
            string OcrPdf = "";
            LL = 451;
            var ListOfDisabledDirs = new List<string>();
            LL = 456;
            var FilesToArchive = new List<string>();
            LL = 461;
            var FilesToArchiveID = new List<string>();
            LL = 461;
            var LibraryList = new List<string>();
            LL = 466;
            var DirLibraryList = new List<string>();
            LL = 471;
            LL = 476;
            bool ThisFileNeedsToBeMoved = false;
            LL = 481;
            bool ThisFileNeedsToBeDeleted = false;
            LL = 486;
            LL = 491;

            // ********************************************************************	:	LL = 	496
            My.MyProject.Forms.frmNotify.lblPdgPages.Text = "LOCATING FILES";
            if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
            {
                My.MyProject.Forms.frmNotify.lblPdgPages.Text = "";
                ActiveFolders = DBLocal.getListenerfTopDir();
            }
            else
            {
                My.MyProject.Forms.frmNotify.lblPdgPages.Text = "";
                DBARCH.GetContentArchiveFileFolders(CurrUserGuidID, ref ActiveFolders, "");
                LL = 501;
                DBARCH.getDisabledDirectories(ref ListOfDisabledDirs);
                LL = 506;
            }
            // ********************************************************************	:	LL = 	511

            LL = 516;
            try
            {
                LL = 551;
                PauseThreadMS = Conversions.ToInteger(DBARCH.getUserParm("UserEmail_Pause"));
                LL = 556;
            }
            catch (Exception ex)
            {
                PauseThreadMS = 0;
            }

            if (ddebug)
            {
                LOG.WriteToArchiveLog("frmMain : ArchiveContent :8001 : trace log.");
                LL = 581;
            }

            if (UseThreads == false)
            {
                PBx.Value = 0;
                LL = 606;
            }

            if (UseThreads == false)
            {
                PBx.Maximum = ActiveFolders.Count + 2;
                LL = 611;
            }

            string isPublic = "";
            LL = 621;
            LL = 626;
            try
            {
                for (int i = 0, loopTo = ActiveFolders.Count - 1; i <= loopTo; i++)
                {
                    LL = 636;
                    Application.DoEvents();
                    try
                    {
                        LL = 641;
                        iContent += 1;
                        LL = 646;
                        Thread.Sleep(50);
                        LL = 651;
                        try
                        {
                            LL = 656;
                            My.MyProject.Forms.frmNotify.Label1.Text = "CONTENT " + iContent.ToString();
                            LL = 661;
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                            GC.Collect();
                            GC.WaitForPendingFinalizers();
                        }
                        catch (Exception ex)
                        {
                            My.MyProject.Forms.frmNotify.Close();
                            My.MyProject.Forms.frmNotify.Show();
                            if (modGlobals.gRunMode.Equals("M-END"))
                            {
                                My.MyProject.Forms.frmNotify.WindowState = FormWindowState.Minimized;
                            }
                        }

                        Application.DoEvents();
                        LL = 701;
                        LL = 706;
                        if (modGlobals.gTerminateImmediately)
                        {
                            LL = 711;
                            try
                            {
                                LL = 716;
                                Cursor = Cursors.Default;
                                LL = 721;
                            }
                            catch (ThreadAbortException ex)
                            {
                                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                                Thread.ResetAbort();
                            }
                            catch (Exception ex)
                            {
                                LOG.WriteToArchiveLog("ERROR ArchiveContent 22x: LL=" + LL.ToString() + Constants.vbCrLf + ex.Message);
                            }

                            LL = 741;
                            if (UseThreads == false)
                            {
                                SB5.Text = "Terminated archive!";
                                LL = 746;
                            }

                            My.MyProject.Forms.frmNotify.Close();
                            LL = 751;
                            modGlobals.gContentArchiving = false;
                            LL = 756;
                            My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                            LL = 761;
                            My.MySettingsProperty.Settings.Save();
                            LL = 766;
                            return;
                            LL = 771;
                        }

                        LL = 776;
                        LL = 781;
                        if (UseThreads == false)
                        {
                            PBx.Value = i;
                            LL = 786;
                        }

                        if (UseThreads == false)
                        {
                            PBx.Refresh();
                            LL = 791;
                        }

                        Application.DoEvents();
                        LL = 796;
                        LL = 801;
                        if (i >= ActiveFolders.Count)
                        {
                            LL = 806;
                            break;
                            LL = 811;
                        }

                        LL = 816;
                        LL = 821;
                        string FolderParmStr = ActiveFolders[i].ToString().Trim();
                        LL = 826;
                        var FolderParms = FolderParmStr.Split('|');
                        LL = 831;
                        if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                        {
                            FOLDER_FQN = Path.GetDirectoryName(ActiveFolders[i]);
                            ParentDir = Path.GetDirectoryName(ActiveFolders[i]);
                            goto Process01;
                        }

                        LL = 836;
                        FOLDER_FQN = FolderParms[0];
                        LL = 841;
                        LL = 846;
                        if (FOLDER_FQN.Trim().Length > 248)
                        {
                            LL = 851;
                            LOG.WriteToArchiveLog("ERROR: folder name too long: " + FOLDER_FQN);
                            FOLDER_FQN = modGlobals.getShortDirName(FOLDER_FQN);
                            LL = 856;
                            LOG.WriteToArchiveLog("NOTICE: Shortened name: " + FOLDER_FQN);
                            if (FOLDER_FQN.Trim().Length > 248)
                            {
                                LL = 851;
                                LOG.WriteToArchiveLog("ERROR: SHORTENED folder name too long, skipping ENTIRE DIRECTORY");
                                goto NextFolder;
                            }

                            LL = 861;
                        }

                        LL = 861;
                        LL = 866;
                        bool bDisabled = DBARCH.ckFolderDisabled(CurrUserGuidID, FOLDER_FQN);
                        LL = 871;
                        LL = 876;
                        if (bDisabled)
                        {
                            LL = 881;
                            LOG.WriteToArchiveLog("Notice: Folder " + FOLDER_FQN + " disabled.");
                            LL = 886;
                            goto NextFolder;
                            LL = 891;
                        }

                        LL = 896;
                        LL = 901;
                        if (modGlobals.gClipBoardActive == true)
                        {
                            Console.WriteLine("Archiving : " + FOLDER_FQN);
                            LL = 906;
                        }

                        if (Conversions.ToBoolean(Strings.InStr(FOLDER_FQN, "%userid%", CompareMethod.Text)))
                        {
                            LL = 911;
                            string S1 = "";
                            LL = 916;
                            string S2 = "";
                            LL = 921;
                            int iLoc = Strings.InStr(FOLDER_FQN, "%userid%", CompareMethod.Text);
                            LL = 926;
                            S1 = Strings.Mid(FOLDER_FQN, 1, iLoc - 1);
                            LL = 931;
                            S2 = Strings.Mid(FOLDER_FQN, iLoc + Strings.Len("%userid%"));
                            LL = 936;
                            string UserName = Environment.UserName;
                            LL = 941;
                            FOLDER_FQN = S1 + UserName + S2;
                            LL = 946;
                        }

                        LL = 951;
                        LL = 956;
                        if (ListOfDisabledDirs.Contains(FOLDER_FQN))
                        {
                            LL = 961;
                            LOG.WriteToArchiveLog("NOTICE: Folder '" + FOLDER_FQN + "' is disabled from archive, skipping.");
                            LL = 966;
                            goto NextFolder;
                            LL = 976;
                        }

                        LL = 981;
                        LL = 986;
                        if (ddebug)
                        {
                            LOG.WriteToArchiveLog("frmMain : ArchiveContent :8002 :FOLDER_FQN : " + FOLDER_FQN);
                            LL = 991;
                        }

                        string ParmMsg = "";
                        LL = 996;
                        string FOLDER_IncludeSubDirs = FolderParms[1];
                        LL = 1001;
                        ParmMsg += "FOLDER_IncludeSubDirs set to " + FOLDER_IncludeSubDirs + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1006;
                        LL = 1011;
                        string FOLDER_DBID = FolderParms[2];
                        LL = 1016;
                        ParmMsg += "FOLDER_DBID  set to " + FOLDER_DBID + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1021;
                        LL = 1026;
                        string FOLDER_VersionFiles = FolderParms[3];
                        LL = 1031;
                        ParmMsg += "FOLDER_VersionFiles  set to " + FOLDER_VersionFiles + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1036;
                        LL = 1041;
                        string DisableDir = FolderParms[4];
                        LL = 1046;
                        ParmMsg += "DisableDir  set to " + DisableDir + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1051;
                        LL = 1056;
                        OcrDirectory = FolderParms[5];
                        LL = 1061;
                        ParmMsg += "OcrDirectory  set to " + OcrDirectory + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1066;
                        LL = 1071;
                        ParentDir = FolderParms[7];
                        LL = 1076;
                        ParmMsg += "ParentDir  set to " + ParentDir + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1081;
                        LL = 1086;
                        string skipArchiveBit = FolderParms[8];
                        LL = 1091;
                        ParmMsg += "skipArchiveBit  set to " + skipArchiveBit + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1096;
                        LL = 1101;
                        OcrPdf = FolderParms[9];
                        LL = 1106;
                        if (OcrPdf.Equals("Y"))
                        {
                            LL = 1111;
                            modGlobals.gPdfExtended = true;
                            LL = 1116;
                        }
                        else
                        {
                            LL = 1121;
                            modGlobals.gPdfExtended = false;
                            LL = 1126;
                        }

                        LL = 1131;
                        LL = 1136;
                        DeleteOnArchive = FolderParms[10];
                        LL = 1141;
                        ParmMsg += "DeleteOnArchive set to " + DeleteOnArchive + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1146;
                        LL = 1151;
                        isPublic = FolderParms[11];
                        LL = 1156;
                        ParmMsg += "isPublic set to " + isPublic + " for " + FOLDER_FQN + Constants.vbCrLf;
                        LL = 1161;
                        LL = 1166;
                        // ***************************	:	LL = 	1171
                        // MessageBox.Show(ParmMsg)	:	LL = 	1176
                        // ***************************	:	LL = 	1181
                        LL = 1186;
                        bool ckArchiveBit = false;
                        LL = 1191;
                        LL = 1196;
                        if (skipArchiveBit.ToUpper().Equals("TRUE"))
                        {
                            LL = 1201;
                            ckArchiveBit = true;
                            LL = 1206;
                        }
                        else
                        {
                            LL = 1211;
                            ckArchiveBit = false;
                            LL = 1216;
                        }

                        LL = 1221;
                        LL = 1226;
                        FOLDER_FQN = UTIL.ReplaceSingleQuotes(FOLDER_FQN);
                        LL = 1231;
                        LL = 1236;
                        if (Directory.Exists(FOLDER_FQN))
                        {
                            LL = 1241;
                            if (UseThreads == false)
                            {
                                SB5.Text = "Processing Dir: " + FOLDER_FQN;
                                LL = 1246;
                            }

                            if (ddebug)
                            {
                                LOG.WriteToArchiveLog("frmMain : ArchiveContent :8003 :FOLDER Exists: " + FOLDER_FQN);
                                LL = 1251;
                            }

                            if (ddebug)
                            {
                                LOG.WriteToArchiveLog("Archive Folder: " + FOLDER_FQN);
                                LL = 1256;
                            }
                        }
                        else
                        {
                            LL = 1261;
                            if (UseThreads == false)
                            {
                                SB5.Text = FOLDER_FQN + " does not exist, skipping.";
                                LL = 1266;
                            }

                            if (ddebug)
                            {
                                LOG.WriteToArchiveLog("frmMain : ArchiveContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN);
                                LL = 1271;
                            }

                            if (ddebug)
                            {
                                LOG.WriteToArchiveLog("Archive Folder FOUND MISSING: " + FOLDER_FQN);
                                LL = 1276;
                            }

                            goto NextFolder;
                            LL = 1281;
                        }

                        LL = 1286;
                        if (DisableDir.Equals("Y"))
                        {
                            LL = 1291;
                            goto NextFolder;
                            LL = 1296;
                        }

                        LL = 1301;
                        LL = 1306;
                        if (ddebug)
                        {
                            LL = 1311;
                            if (Strings.InStr(FOLDER_FQN, "'") > 0)
                            {
                                LL = 1316;
                                Console.WriteLine("Single Quote found: " + FOLDER_FQN);
                                LL = 1321;
                            }

                            LL = 1326;
                        }

                        LL = 1331;
                        LL = 1336;
                        // ******************************************************************************	:	LL = 	1341
                        Process01:
                        ;
                        if ((PrevParentDir ?? "") != (ParentDir ?? ""))
                        {
                            LL = 1346;
                            Console.WriteLine(FOLDER_FQN);
                            LL = 1351;
                            if (Strings.InStr(FOLDER_FQN, "army", CompareMethod.Text) > 0)
                            {
                                LL = 1356;
                                Console.WriteLine("HERRE 773");
                                LL = 1361;
                            }

                            LL = 1366;
                            IncludedTypes = DBARCH.GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs);
                            LL = 1371;
                            ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs);
                            LL = 1376;
                        }

                        LL = 1381;
                        if (IncludedTypes.Count == 0)
                        {
                            LL = 1386;
                            IncludedTypes = DBARCH.GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs);
                            LL = 1391;
                            ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs);
                            LL = 1396;
                        }

                        LL = 1401;
                        // ******************************************************************************	:	LL = 	1406
                        PrevParentDir = ParentDir;
                        LL = 1411;
                        if (ddebug)
                        {
                            LOG.WriteToArchiveLog("frmMain : ArchiveContent :8005 : Trace: " + FOLDER_FQN);
                            LL = 1416;
                        }

                        bool bChanged = false;
                        LL = 1421;
                        LL = 1426;
                        if ((FOLDER_FQN ?? "") != (pFolder ?? ""))
                        {
                            LL = 1431;
                            LL = 1436;
                            if (ddebug)
                            {
                                LL = 1441;
                                LOG.WriteToUploadLog("NOTICE ddebug - 200a: Processing Directory: " + FOLDER_FQN + " - defined to " + IncludedTypes.Count.ToString() + " filetype codes.");
                                LL = 1446;
                            }

                            LL = 1451;
                            LL = 1456;
                            // ********************************************************************************************************************	:	LL = 	1461
                            string tFOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN);
                            LL = 1466;
                            int iCntFolderIsdefinedForArchive = 0;
                            LL = 1471;
                            string SS = "Select COUNT(*) from Directory where FQN = '" + tFOLDER_FQN + "' and UserID = '" + CurrUserGuidID + "'";
                            LL = 1476;
                            iCntFolderIsdefinedForArchive = DBARCH.iCount(SS);
                            LL = 1481;
                            // If iCntFolderIsdefinedForArchive > 0 Then : LL = 1486
                            // IncludedTypes = DBARCH.GetAllIncludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1491
                            // ExcludedTypes = DBARCH.GetAllExcludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1496
                            // IncludedTypes = DBARCH.AddIncludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1501
                            // ExcludedTypes = DBARCH.AddExcludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs) : LL = 1506
                            // Else : LL = 1511
                            // IncludedTypes = DBARCH.GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1516
                            // ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1521
                            // IncludedTypes = DBARCH.AddIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1526
                            // ExcludedTypes = DBARCH.AddExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs) : LL = 1531
                            // End If : LL = 1536
                            // ********************************************************************************************************************	:	LL = 	1541
                            LL = 1546;
                            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped EndIfDirectiveTrivia */
                            LL = 1566;
                            string ParentDirForLib = "";
                            LL = 1571;
                            bool bLikToLib = false;
                            LL = 1576;
                            bLikToLib = ARCH.isDirInLibrary(FOLDER_FQN, ref ParentDirForLib);
                            LL = 1581;
                            LL = 1586;
                            LOG.WriteToArchiveLog("frmMain : ArchiveContent :8006 : Folder Changed: " + FOLDER_FQN + " : " + pFolder);
                            LL = 1591;
                            if (Directory.Exists(FOLDER_FQN))
                            {
                                // ** CHECK ACCESS TO FOLDER **
                                var f = new FileIOPermission(PermissionState.None);
                                f.AllLocalFiles = FileIOPermissionAccess.Read;
                                try
                                {
                                    f.Demand();
                                }
                                catch (Exception sx)
                                {
                                    LOG.WriteToArchiveLog("ERROR ArchiveContent Permissions: " + Constants.vbCrLf + sx.Message);
                                }

                                f = null;
                            }
                            else
                            {
                                LOG.WriteToArchiveLog("ERROR frmMain : ArchiveContent :8006c : Folder '" + FOLDER_FQN + "' DOES NOT exist, skipping.");
                                goto NextFolder;
                            }

                            LL = 1596;
                            FolderName = FOLDER_FQN;
                            LL = 1601;
                            LL = 1606;
                            if (bLikToLib)
                            {
                                LL = 1611;
                                ARCH.GetDirectoryLibraries(ParentDirForLib, ref LibraryList);
                                LL = 1616;
                            }
                            else
                            {
                                LL = 1621;
                                ARCH.GetDirectoryLibraries(FOLDER_FQN, ref LibraryList);
                                LL = 1626;
                            }

                            LL = 1631;
                            LL = 1636;
                            Application.DoEvents();
                            LL = 1641;
                            // ** Verify that the DIR still exists	:	LL = 	1646
                            if (Directory.Exists(FolderName))
                            {
                                LL = 1651;
                                if (UseThreads == false)
                                {
                                    SB5.Text = "Processing Dir: " + FolderName;
                                    LL = 1656;
                                }
                            }
                            else
                            {
                                LL = 1661;
                                if (UseThreads == false)
                                {
                                    SB5.Text = FolderName + " does not exist, skipping.";
                                    LL = 1666;
                                }

                                if (ddebug)
                                {
                                    LOG.WriteToArchiveLog("frmMain : ArchiveContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN);
                                    LL = 1671;
                                }

                                goto NextFolder;
                                LL = 1676;
                            }

                            LL = 1681;
                            LL = 1686;
                            RetentionCode = DBARCH.GetDirRetentionCode(ParentDir, CurrUserGuidID);
                            LL = 1691;
                            if (RetentionCode.Length > 0)
                            {
                                LL = 1696;
                                RetentionYears = DBARCH.getRetentionPeriod(RetentionCode);
                                LL = 1701;
                            }
                            else
                            {
                                LL = 1706;
                                RetentionYears = (int)Conversion.Val(DBARCH.getSystemParm("RETENTION YEARS"));
                                LL = 1711;
                            }

                            LL = 1716;
                            LL = 1721;
                            DBARCH.getDirectoryParms(ref a, ParentDir, CurrUserGuidID);
                            LL = 1726;
                            LL = 1731;
                            string IncludeSubDirs = a[0];
                            LL = 1736;
                            string VersionFiles = a[1];
                            LL = 1741;
                            string ckMetaData = a[2];
                            LL = 1746;
                            OcrDirectory = a[3];
                            LL = 1751;
                            RetentionCode = a[4];
                            LL = 1756;
                            OcrPdf = a[5];
                            LL = 1761;
                            isPublic = a[6];
                            LL = 1766;
                            // a(0) = IncludeSubDirs	:	LL = 	1771
                            // a(1) = VersionFiles	:	LL = 	1776
                            // a(2) = ckMetaData	:	LL = 	1781
                            // a(3) = OcrDirectory	:	LL = 	1786
                            // a(4) = RetentionCode	:	LL = 	1791
                            // a(5) = OcrPdf	:	LL = 	1796
                            // a(6) = ckPublic	:	LL = 	1801
                            LL = 1806;
                            // *****************************************************************************	:	LL = 	1811
                            // ** Get all of the files in this folder	:	LL = 	1816
                            // *****************************************************************************	:	LL = 	1821
                            var StepTimer = DateAndTime.Now;
                            LL = 1826;
                            bool bSubDirFlg = false;
                            LL = 1831;
                            try
                            {
                                LL = 1836;
                                if (ddebug)
                                {
                                    LOG.WriteToArchiveLog("Starting File capture");
                                    LL = 1841;
                                }

                                FilesToArchive.Clear();
                                LL = 1846;
                                if (ddebug)
                                {
                                    LOG.WriteToArchiveLog("Starting File capture: Init FilesToArchive");
                                    LL = 1851;
                                }

                                LL = 1856;
                                // **************************************************************************	:	LL = 	1861
                                if (UseThreads == false)
                                {
                                    SB5.Text = FOLDER_FQN;
                                    LL = 1866;
                                }

                                Application.DoEvents();
                                LL = 1871;
                                LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "START");
                                LL = 1876;
                                // NbrFilesInDir = DMA.getFilesInDir(FOLDER_FQN , FilesToArchive, IncludedTypes, ExcludedTypes, ckArchiveBit)	:	LL = 	1881
                                LL = 1886;
                                string MSG = "";
                                LL = 1891;
                                string strFileSize = "";
                                LL = 1896;
                                var FilterList = new List<string>();
                                LL = 1901;
                                // Dim ArchiveAttr As Boolean = False	:	LL = 	1906
                                string sTemp = "";
                                LL = 1911;
                                LL = 1916;
                                for (int XX = 0, loopTo1 = IncludedTypes.Count - 1; XX <= loopTo1; XX++)
                                {
                                    LL = 1921;
                                    sTemp = Conversions.ToString(IncludedTypes[XX]);
                                    LL = 1926;
                                    if (Strings.InStr(Conversions.ToString(IncludedTypes[XX]), ".") == 0)
                                    {
                                        LL = 1931;
                                        sTemp = "." + sTemp;
                                        LL = 1936;
                                    }

                                    LL = 1941;
                                    if (Strings.InStr(Conversions.ToString(IncludedTypes[XX]), "*") == 0)
                                    {
                                        LL = 1946;
                                        sTemp = "*" + sTemp;
                                        LL = 1951;
                                    }

                                    LL = 1956;
                                    FilterList.Add(sTemp);
                                    LL = 1961;
                                }

                                LL = 1966;
                                LL = 1971;
                                if (Information.IsNothing(FOLDER_IncludeSubDirs))
                                {
                                    FOLDER_IncludeSubDirs = "Y";
                                }

                                if (FOLDER_IncludeSubDirs.ToUpper().Equals("Y"))
                                {
                                    LL = 1976;
                                    bSubDirFlg = true;
                                    LL = 1981;
                                }

                                LL = 1986;
                                My.MyProject.Forms.frmNotify.lblFileSpec.Text = "Standby, directory inventory.";
                                LL = 1991;
                                My.MyProject.Forms.frmNotify.Refresh();
                                LL = 1996;
                                int iInventory = 0;
                                LL = 2001;
                                // ***********************************************************************************************************************
                                if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                {
                                    FilesToArchive = DBLocal.getListenerfiles();
                                    FilesToArchiveID = DBLocal.getListenerfilesID();
                                }
                                else
                                {
                                    UTIL.GetFilesToArchive(ref iInventory, ckArchiveBit, bSubDirFlg, FOLDER_FQN, FilterList, ref FilesToArchive, IncludedTypes, ExcludedTypes);
                                    LL = 2006;
                                }

                                if (FilesToArchive.Count.Equals(0))
                                {
                                    goto NextFolder;
                                }
                                // ***********************************************************************************************************************
                                My.MyProject.Forms.frmNotify.lblFileSpec.Text = "Directory inventory complete";
                                LL = 2011;
                                My.MyProject.Forms.frmNotify.Refresh();
                                LL = 2016;
                                NbrFilesInDir = FilesToArchive.Count;
                                LL = 2021;
                                Console.WriteLine("Start: " + DateAndTime.Now.ToString());
                                LL = 2026;
                                LL = 2031;
                                LOG.WriteToTimerLog("ArchiveContent-01", "getFilesInDir", "STOP", StepTimer);
                                LL = 2036;
                                // **************************************************************************	:	LL = 	2041
                                if (ddebug)
                                {
                                    LOG.WriteToArchiveLog("Starting File capture: Loaded files");
                                    LL = 2046;
                                }

                                if (NbrFilesInDir == 0)
                                {
                                    LL = 2051;
                                    LOG.WriteToArchiveLog("Archive Folder HAD NO FILES: " + FOLDER_FQN);
                                    LL = 2056;
                                    // GoTo NextFolder	:	LL = 	2061
                                }

                                LL = 2066;
                                if (ddebug)
                                {
                                    LOG.WriteToArchiveLog("Starting File capture: start ckFilesNeedUpdate");
                                    LL = 2071;
                                }
                            }
                            catch (IOException ex)
                            {
                                LOG.WriteToArchiveLog("Thread 88 IO exception: " + ex.Message);
                                // LOG.WriteToArchiveLog("Thread 88 IO InnerException: " & ex.InnerException.ToString)
                                LOG.WriteToArchiveLog("FOLDER_FQN 88: " + FOLDER_FQN + Constants.vbCrLf + "LL = " + LL.ToString());
                                LOG.WriteToArchiveLog(ex.StackTrace);
                                GC.Collect();
                                GC.WaitForPendingFinalizers();
                            }
                            catch (ThreadAbortException ex)
                            {
                                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                                Thread.ResetAbort();
                            }
                            catch (Exception ex)
                            {
                                LOG.WriteToArchiveLog("ERROR Archive Folder Acquisition Failure : " + FOLDER_FQN + Constants.vbCrLf + "LL=" + LL.ToString());
                                var st = new StackTrace(true);
                                st = new StackTrace(ex, true);
                                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                                GC.Collect();
                                GC.WaitForPendingFinalizers();
                                goto NextFolder;
                            }

                            LL = 2156;
                            string ArchIndicator = "";
                            LL = 2161;
                            // ** Process all of the files	:	LL = 	2166
                            int iTotal = FilesToArchive.Count;
                            LL = 2171;
                            iContent += 1;
                            LL = 2176;
                            string InventoryFQN = "";
                            LL = 2181;
                            string ListenerDir = "";
                            int ArchCnt = FilesToArchive.Count;
                            My.MyProject.Forms.frmNotify.Text = "CONTENT: Uploading Files";
                            FilesToArchive.Sort();
                            int CurrFileSize = 0;
                            string CurrFileName = "";
                            string CurrFQN = "";
                            string CurrExt = "";
                            var CurrCreateDate = DateAndTime.Now;
                            var CurrLastUpdate = DateAndTime.Now;
                            for (int K = 0, loopTo2 = FilesToArchive.Count - 1; K <= loopTo2; K++)
                            {
                                LL = 2186;
                                if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                {
                                    ParentDir = Path.GetDirectoryName(FilesToArchive[K]);
                                    ListenerDir = Path.GetDirectoryName(FilesToArchive[K]);
                                }

                                LL = 2191;
                                bExplodeZipFile = true;
                                LL = 2196;
                                ThisFileNeedsToBeMoved = false;
                                LL = 2201;
                                ThisFileNeedsToBeDeleted = false;
                                LL = 2206;
                                LL = 2211;
                                iContent += 1;
                                LL = 2216;
                                LL = 2221;
                                if (K % 2 == 0)
                                {
                                    LL = 2226;
                                    if (UseThreads == false)
                                    {
                                        SB5.Text = K + " Of " + iTotal;
                                        LL = 2231;
                                    }

                                    Application.DoEvents();
                                    LL = 2236;
                                }

                                LL = 2241;
                                LL = 2246;
                                ArchIndicator = "";
                                LL = 2251;
                                if (FilesToArchive[K] == null)
                                {
                                    LL = 2256;
                                    goto DoneWithIt;
                                    LL = 2261;
                                }

                                LL = 2266;
                                LL = 2271;
                                // 'WDM Commentefd out oct-5-2020
                                // If FilesToArchive(K).Length > 5 Then : LL = 2276
                                // ArchIndicator = Mid(FilesToArchive(K), 1, 5).ToUpper : LL = 2281
                                // If ArchIndicator.Equals("False") And ckArchiveBit = True Then : LL = 2286
                                // GoTo NextFile : LL = 2291
                                // End If : LL = 2296
                                // End If : LL = 2301
                                LL = 2306;
                                if (PauseThreadMS > 0)
                                {
                                    LL = 2311;
                                    Thread.Sleep(50);
                                    LL = 2316;
                                }

                                LL = 2321;
                                LL = 2326;

                                // ************************************************************************	:	LL = 	2331
                                var FileAttributes = FilesToArchive[K].Split('|');
                                LL = 2336;
                                string file_ArchiveBit = "";
                                string file_Extension = "";
                                string file_DirectoryName = "";
                                if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                {
                                    // FileAttributes() = FilesToArchive(K).Split("|") : LL = 2336
                                    file_ArchiveBit = "";
                                    file_name = Path.GetFileName(FilesToArchive[K]);
                                    file_Extension = Path.GetExtension(FilesToArchive[K]);
                                    file_DirectoryName = Path.GetDirectoryName(FilesToArchive[K]);
                                    file_FullName = FilesToArchive[K];
                                }
                                // frmNotify.lblPdgPages.Text = "Dir: " + ParentDir
                                // frmNotify.lblFileSpec.Text = (K).ToString + " of " + ArchCnt.ToString + " : " + file_name
                                else
                                {
                                    file_ArchiveBit = FileAttributes[0].ToUpper();
                                    LL = 2341;
                                    file_name = FileAttributes[1];
                                    LL = 2351;
                                    file_Extension = FileAttributes[2];
                                    LL = 2356;
                                    file_DirectoryName = FileAttributes[3];
                                    LL = 2361;
                                    file_FullName = file_DirectoryName + @"\" + file_name;
                                    // frmNotify.lblPdgPages.Text = "Dir: " + file_DirectoryName
                                    // frmNotify.lblFileSpec.Text = (K).ToString + " of " + ArchCnt.ToString + " : " + file_name
                                }

                                My.MyProject.Forms.frmNotify.Refresh();

                                // If File.Exists(file_FullName) Then
                                // Dim Finfo As New FileInfo(file_FullName)
                                // CurrFileSize = Finfo.Length
                                // CurrFileName = Finfo.Name
                                // CurrFQN = Finfo.FullName
                                // CurrExt = Finfo.Extension
                                // CurrCreateDate = Finfo.CreationTime
                                // CurrLastUpdate = Finfo.LastWriteTime
                                // Finfo = Nothing
                                // End If


                                LL = 2366;
                                if (K > FilesToArchive.Count)
                                {
                                    LL = 2371;
                                    goto NextFolder;
                                    LL = 2376;
                                }

                                LL = 2381;
                                if (FilesToArchive[K] == null)
                                {
                                    LL = 2386;
                                    goto NextFile;
                                    LL = 2391;
                                }

                                LL = 2396;
                                // wdm commented out oct-5-2020
                                // If ckArchiveBit = True And file_ArchiveBit.Equals("False") Then : LL = 2406
                                // GoTo NextFile : LL = 2411
                                // End If : LL = 2416
                                LL = 2421;
                                // ************************************************************************	:	LL = 	2426
                                LL = 2431;
                                InventoryFQN = file_DirectoryName + @"\" + file_name;
                                LL = 2436;
                                if (!File.Exists(InventoryFQN))
                                {
                                    if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                    {
                                        bool bUpdt = DBLocal.setListenerfileProcessed(InventoryFQN);
                                    }

                                    goto NextFile;
                                }
                                // WDM Nov-02-2020 Commented out as it is not needed the bay before we rid ourselves of trump
                                // If UseDirectoryListener.Equals(1) And Not TempDisableDirListener Then
                                // Dim bUpdt = DBLocal.setListenerfileProcessed(InventoryFQN)
                                // If bUpdt Then
                                // LOG.WriteToArchiveLog("NOTICE ArchiveContent BX01 skipped file : " + InventoryFQN)
                                // Else
                                // LOG.WriteToArchiveLog("ERROR ArchiveContent BX02 failed to set Processed flag: " + InventoryFQN)
                                // End If
                                // End If
                                LL = 2441;
                                var UpdateTimerMain = DateAndTime.Now;
                                LL = 2446;
                                LL = 2451;
                                Application.DoEvents();
                                LL = 2491;
                                LL = 2496;
                                if (modGlobals.gTerminateImmediately)
                                {
                                    LL = 2501;
                                    try
                                    {
                                        LL = 2506;
                                        Cursor = Cursors.Default;
                                        LL = 2511;
                                    }
                                    catch (ThreadAbortException ex)
                                    {
                                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                                        Thread.ResetAbort();
                                    }
                                    catch (Exception ex)
                                    {
                                        GC.Collect();
                                        GC.WaitForPendingFinalizers();
                                    }

                                    LL = 2526;
                                    if (UseThreads == false)
                                    {
                                        SB5.Text = "Terminated archive!";
                                        LL = 2531;
                                    }

                                    My.MyProject.Forms.frmNotify.Close();
                                    LL = 2536;
                                    modGlobals.gContentArchiving = false;
                                    LL = 2541;
                                    My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                                    LL = 2546;
                                    My.MySettingsProperty.Settings.Save();
                                    LL = 2551;
                                    return;
                                    LL = 2556;
                                }

                                LL = 2561;
                                LL = 2566;
                                if (UseThreads == false)
                                {
                                    SB5.Text = "Directory Files processed: " + K.ToString() + " OF " + FilesToArchive.Count;
                                    LL = 2571;
                                }

                                Application.DoEvents();
                                LL = 2576;
                                LL = 2581;
                                if (ListOfDisabledDirs.Contains(file_DirectoryName))
                                {
                                    LL = 2586;
                                    goto NextFile;
                                    LL = 2591;
                                }

                                LL = 2596;
                                DateTime file_CreationTime = default;
                                DateTime file_LastWriteTime = default;
                                DateTime file_LastAccessTime = default;
                                int file_Length = 0;
                                file_FullName = InventoryFQN;
                                var FI = new FileInfo(InventoryFQN);
                                try
                                {
                                    file_CreationTime = FI.CreationTime;
                                    LL = 2621;
                                    file_LastWriteTime = FI.LastWriteTime;
                                    LL = 2626;
                                    file_LastAccessTime = FI.LastAccessTimeUtc;
                                    LL = 2631;
                                    file_Length = (int)FI.Length;
                                    CurrFileSize = (int)FI.Length;
                                    CurrFileName = FI.Name;
                                    CurrFQN = FI.FullName;
                                    CurrExt = FI.Extension;
                                    CurrCreateDate = FI.CreationTime;
                                    CurrLastUpdate = FI.LastWriteTime;
                                }
                                catch (Exception ex)
                                {
                                    LOG.WriteToArchiveLog("ERROR 22x1 ArchiveContent: " + ex.Message);
                                }

                                FI = null;
                                if (file_Length == 0)
                                {
                                    LL = 2606;
                                    goto NextFile;
                                    LL = 2611;
                                }

                                LL = 2616;
                                LL = 2646;
                                // *******************************************************************	:	LL = 	2651
                                // *******************************************************************	:	LL = 	2656
                                file_FullName = file_FullName.Replace("''", "'");
                                if (!File.Exists(file_FullName))
                                {
                                    goto NextFile;
                                }

                                string FileHash = ENC.GenerateSHA512HashFromFile(file_FullName);
                                LL = 2661;
                                int xlen = FileHash.Length;
                                if (FileHash.Length < 10)
                                {
                                    LOG.WriteToArchiveLog("ERROR HASH: Skipping : " + file_FullName);
                                    goto NextFile;
                                }

                                if (FileHash.Contains("0x0x"))
                                {
                                    LOG.WriteToArchiveLog("ERROR HASH: Skipping : " + file_FullName);
                                    FileHash.Replace("0x0x", "0x");
                                }

                                // Changed the below line to NOT recalculate the same has but just set
                                // ImageHash = to FileHash
                                // Dim ImageHash As String = ENC.GenerateSHA512HashFromFile(file_FullName) : LL = 2666
                                string ImageHash = FileHash;
                                int NbrFilesFoundInRepo = DBARCH.getCountDataSourceFiles(file_FullName, FileHash);
                                LL = 2671;
                                if (FileHash.Length < 10)
                                {
                                    LOG.WriteToArchiveLog("ERROR ArchiveContent HASH failed: " + file_FullName);
                                    if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                    {
                                        bool bUpdt = DBLocal.setListenerfileProcessed(file_FullName);
                                        if (!bUpdt)
                                        {
                                            LOG.WriteToArchiveLog("ERROR 00A1 failed to set Processed flag: " + file_FullName);
                                        }
                                    }

                                    goto NextFile;
                                }

                                if (NbrFilesFoundInRepo > 0)
                                {
                                    LL = 2681;
                                    My.MyProject.Forms.frmNotify.BackColor = Color.LightSalmon;
                                    LL = 2686;
                                    // ************************************************************************************************************************
                                    string ExistingSourceGuid = DBARCH.getContentGuid(file_name, FileHash);
                                    LL = 2691;
                                    DBARCH.saveContentOwner(ExistingSourceGuid, CurrUserGuidID, "C", FOLDER_FQN, modGlobals.gMachineID, modGlobals.gNetworkID);
                                    LL = 2696;
                                    // ************************************************************************************************************************
                                    if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                    {
                                        bool bUpdt = DBLocal.setListenerfileProcessed(file_FullName);
                                        if (!bUpdt)
                                        {
                                            LOG.WriteToArchiveLog("ERROR failed to set Processed flag: " + file_FullName);
                                        }
                                    }

                                    My.MyProject.Forms.frmNotify.BackColor = Color.LightGoldenrodYellow;
                                    LL = 2701;
                                    goto NextFile;
                                    LL = 2706;
                                }

                                LL = 2711;
                                My.MyProject.Forms.frmNotify.BackColor = Color.LightGoldenrodYellow;
                                LL = 2716;
                                // *******************************************************************	:	LL = 	2721
                                // *******************************************************************	:	LL = 	2726
                                if (DeleteOnArchive.Equals("Y"))
                                {
                                    LL = 2731;
                                    if (!ListOfFilesToDelete.ContainsKey(file_FullName))
                                    {
                                        LL = 2736;
                                        ListOfFilesToDelete.Add(file_FullName, "UKN");
                                        LL = 2741;
                                    }

                                    LL = 2746;
                                }

                                LL = 2751;
                                // *******************************************************************	:	LL = 	2756
                                // *******************************************************************	:	LL = 	2761
                                string SourceGuid = DBARCH.getGuid();
                                LL = 2766;
                                LL = 2771;
                                LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "START");
                                LL = 2781;
                                LL = 2786;
                                if (Strings.InStr(file_FullName, @"\ECM\ErrorFile\", CompareMethod.Text) > 0)
                                {
                                    LL = 2791;
                                    Console.WriteLine("Skipping: " + file_FullName);
                                    LL = 2796;
                                    goto DoneWithIt;
                                    LL = 2801;
                                }

                                LL = 2806;
                                LL = 2811;
                                if (modGlobals.gMaxSize > 0d)
                                {
                                    LL = 2816;
                                    if (Conversion.Val(file_Length) > modGlobals.gMaxSize)
                                    {
                                        LL = 2821;
                                        LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.");
                                        LL = 2826;
                                        goto NextFile;
                                        LL = 2831;
                                    }

                                    LL = 2836;
                                }

                                LL = 2841;
                                LL = 2846;
                                // file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 2851
                                // file_name = UTIL.RemoveSingleQuotes(file_name) : LL = 2856
                                LL = 2861;
                                if (file_Extension.Equals(".msg"))
                                {
                                    LL = 2866;
                                    LOG.WriteToArchiveLog("NOTICE: Content Archive File : " + file_FullName + " was found to be a message file, moved file.");
                                    LL = 2871;
                                    if (MsgNotification == false | modGlobals.gRunUnattended == true)
                                    {
                                        LL = 2876;
                                        string DisplayMsg = "A message file was encounted in a backup directory." + Constants.vbCrLf;
                                        LL = 2881;
                                        DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + Constants.vbCrLf;
                                        LL = 2886;
                                        DisplayMsg = DisplayMsg + "To archive a MSG file, it should be imported into outlook." + Constants.vbCrLf;
                                        LL = 2891;
                                        DisplayMsg = DisplayMsg + "This file has ALSO been added to the CONTENT repository." + Constants.vbCrLf;
                                        LL = 2896;
                                        My.MyProject.Forms.frmHelp.MsgToDisplay = DisplayMsg;
                                        LL = 2901;
                                        My.MyProject.Forms.frmHelp.CallingScreenName = "ECM Archive";
                                        LL = 2906;
                                        My.MyProject.Forms.frmHelp.CaptionName = "MSG File Encounted in Content Archive";
                                        LL = 2911;
                                        My.MyProject.Forms.frmHelp.Timer1.Interval = 10000;
                                        LL = 2916;
                                        My.MyProject.Forms.frmHelp.Show();
                                        LL = 2921;
                                        MsgNotification = true;
                                        LL = 2926;
                                        if (modGlobals.gRunUnattended == true)
                                        {
                                            LL = 2931;
                                            LOG.WriteToArchiveLog("WARNING: ArchiveContent 100: " + Constants.vbCrLf + DisplayMsg);
                                            LL = 2936;
                                        }

                                        LL = 2941;
                                    }

                                    LL = 2946;
                                    LL = 2951;
                                    string EmailWorkingDirectory = DBARCH.getWorkingDirectory(CurrUserGuidID, "EMAIL WORKING DIRECTORY");
                                    LL = 2956;
                                    LL = 2961;
                                    EmailWorkingDirectory = UTIL.RemoveSingleQuotes(EmailWorkingDirectory);
                                    LL = 2966;
                                    file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                                    LL = 2971;
                                    EmailFQN = EmailWorkingDirectory + @"\" + file_FullName.Trim();
                                    LL = 2976;
                                    LL = 2981;
                                    file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                                    LL = 2986;
                                    LL = 2991;
                                    if (File.Exists(EmailFQN))
                                    {
                                        LL = 2996;
                                        string tMsg = "Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN;
                                        LL = 3001;
                                        LOG.WriteToArchiveLog(tMsg);
                                        LL = 3006;
                                        DBARCH.xTrace(965, "ArchiveContent", tMsg);
                                        LL = 3011;
                                    }
                                    // FilesSkipped += 1	:	LL = 	3016
                                    else
                                    {
                                        LL = 3021;
                                        File.Copy(file_FullName, EmailFQN);
                                        LL = 3026;
                                        string tMsg = "Email File Encountered, moved to EMAIL WORKING DIRECTORY and entered into repository: " + EmailFQN;
                                        LL = 3031;
                                        DBARCH.xTrace(966, "ArchiveContent", tMsg);
                                        LL = 3036;
                                        // FilesSkipped += 1	:	LL = 	3041
                                    }

                                    LL = 3046;
                                    // GoTo NextFile	:	LL = 	3051
                                }

                                LL = 3056;
                                LL = 3061;
                                ARCH.ckSourceTypeCode(ref file_Extension);
                                LL = 3066;
                                LL = 3071;
                                bool isZipFile = ZF.isZipFile(file_FullName);
                                LL = 3156;
                                LL = 3161;
                                Application.DoEvents();
                                LL = 3166;
                                LL = 3171;
                                if (!isZipFile)
                                {
                                    LL = 3176;
                                    bool bExt = DMA.isExtExcluded(file_Extension, ExcludedTypes);
                                    LL = 3181;
                                    if (bExt)
                                    {
                                        LL = 3186;
                                        modGlobals.FilesSkipped += 1;
                                        LL = 3191;
                                        goto NextFile;
                                        LL = 3196;
                                    }

                                    LL = 3201;
                                    // ** See if the STAR is in the INCLUDE list, if so, all files are included	:	LL = 	3206
                                    bExt = DMA.isExtIncluded(file_Extension, ExcludedTypes);
                                    LL = 3211;
                                    if (bExt)
                                    {
                                        LL = 3216;
                                        modGlobals.FilesSkipped += 1;
                                        LL = 3221;
                                        goto NextFile;
                                        LL = 3226;
                                    }

                                    LL = 3231;
                                }
                                else
                                {
                                    LL = 3236;
                                    Console.WriteLine("Zipfile Found.");
                                    LL = 3241;
                                }

                                LL = 3246;
                                LL = 3251;
                                // ** This NEEDS to be in a keyed array	:	LL = 	3256
                                int bcnt = 0;
                                LL = 3261;
                                if (ExistingFileTypes.ContainsKey(file_Extension.ToLower()))
                                {
                                    LL = 3266;
                                    bcnt = 1;
                                    LL = 3271;
                                }
                                else if (ExistingFileTypes.ContainsKey(file_Extension.ToUpper()))
                                {
                                    LL = 3276;
                                    bcnt = 1;
                                    LL = 3281;
                                }

                                LL = 3286;
                                // Dim bcnt As Integer = DBARCH.iGetRowCount("SourceType", "where SourceTypeCode = '" + file_Extension + "'")	:	LL = 	3291
                                LL = 3296;
                                if (bcnt == 0)
                                {
                                    LL = 3301;
                                    string SubstituteFileType = DBARCH.getProcessFileAsExt(file_Extension);
                                    LL = 3306;
                                    if (SubstituteFileType == null)
                                    {
                                        LL = 3311;
                                        string MSG = "The file type '" + file_Extension + "' is undefined." + Constants.vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + Constants.vbCrLf + "This will allow content to be archived, but not searched.";
                                        LL = 3316;
                                        // Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)	:	LL = 	3321
                                        LL = 3326;
                                        if (ddebug)
                                        {
                                            LOG.WriteToArchiveLog(MSG);
                                            LL = 3331;
                                        }

                                        LL = 3336;
                                        string argval = "0";
                                        UNASGND.setApplied(ref argval);
                                        LL = 3341;
                                        UNASGND.setFiletype(ref file_Extension);
                                        LL = 3346;
                                        int xCnt = UNASGND.cnt_PK_AFTU(file_Extension);
                                        LL = 3351;
                                        if (xCnt == 0)
                                        {
                                            LL = 3356;
                                            UNASGND.Insert();
                                            LL = 3361;
                                        }

                                        LL = 3366;
                                        LL = 3371;
                                        var ST = new clsSOURCETYPE();
                                        LL = 3376;
                                        ST.setSourcetypecode(ref file_Extension);
                                        LL = 3381;
                                        string argval1 = "NO SEARCH - AUTO ADDED by Pgm";
                                        ST.setSourcetypedesc(ref argval1);
                                        LL = 3386;
                                        string argval2 = "0";
                                        ST.setIndexable(ref argval2);
                                        LL = 3391;
                                        string argval3 = 0.ToString();
                                        ST.setStoreexternal(ref argval3);
                                        LL = 3396;
                                        ST.Insert();
                                        LL = 3401;
                                        DBARCH.LoadFileTypeDictionary(ref ExistingFileTypes);
                                        LL = 3406;
                                    }
                                    else
                                    {
                                        LL = 3411;
                                        file_Extension = SubstituteFileType;
                                        LL = 3416;
                                    }

                                    LL = 3421;
                                    LL = 3426;
                                }

                                LL = 3431;
                                LL = 3436;
                                EmailFQN = UTIL.RemoveSingleQuotes(EmailFQN);
                                LL = 3441;
                                file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                                LL = 3446;
                                LL = 3451;
                                string ssFile = "";
                                LL = 3456;
                                ssFile = DMA.getFileName(file_FullName);
                                LL = 3461;
                                string strNbr = UTIL.setFilelenUnits(file_Length);
                                LL = 3466;
                                // wdmxx
                                My.MyProject.Forms.frmNotify.Label1.Text = file_DirectoryName;
                                My.MyProject.Forms.frmNotify.lblPdgPages.Text = "@: " + strNbr + " / " + ssFile;
                                My.MyProject.Forms.frmNotify.lblFileSpec.Text = "fILE: " + K.ToString() + " of " + FilesToArchive.Count.ToString();
                                My.MyProject.Forms.frmNotify.Refresh();
                                LL = 3481;
                                string StoredExternally = "N";
                                LL = 3486;
                                LL = 3491;
                                // NbrFilesFoundInRepo = DBARCH.getCountDataSourceFiles(file_Name, FileHash)	:	LL = 	3496
                                // If (NbrFilesFoundInRepo = 0) Then	:	LL = 	3501
                                // DBARCH.saveContentOwner(SourceGuid, CurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)	:	LL = 	3506
                                // End If	:	LL = 	3511
                                LL = 3516;
                                Application.DoEvents();
                                LL = 3521;
                                // ***********************************************************************'	:	LL = 	3526
                                // ** New file	:	LL = 	3531
                                // ***********************************************************************'	:	LL = 	3536
                                bool bSuccessExecution = false;
                                LL = 3541;
                                string AttachmentCode = "C";
                                LL = 3546;
                                LL = 3551;
                                LOG.WriteToUploadLog("ArchiveContent: 00 File: " + DateAndTime.Now.ToString() + file_FullName);

                                // ** FILE ALREADY EXISTS IN THE REPOSITORY
                                int NbrDUps = DBARCH.ckFileExistInRepo(MachineID, file_FullName);
                                if (NbrDUps > 0)
                                {
                                    // ** Update the HASH and the Source Binary
                                    // * Get the file hash
                                    if (FileHash.Length < 10)
                                    {
                                        goto NextFile;
                                    }

                                    bSuccessExecution = DBARCH.UpdateSouceImage(MachineID, file_FullName, FileHash);
                                    if (!bSuccessExecution)
                                    {
                                        LOG.WriteToArchiveLog("ERROR UpdateSouceImage 0X1: Failed to update ImageHash: " + file_FullName);
                                    }
                                }

                                if (NbrFilesFoundInRepo == 0 & NbrDUps == 0)
                                {
                                    LL = 3556;
                                    LL = 3561;
                                    TimeSpan TS;
                                    LL = 3566;
                                    var sTime = DateAndTime.Now;
                                    LL = 3571;
                                    string sMin = "";
                                    LL = 3576;
                                    string sSec = "";
                                    LL = 3581;
                                    LOG.WriteToUploadLog("INFO: File - " + file_FullName + " was found to be NEW and not in the repository.");
                                    LL = 3586;
                                    // Me.if UseThreads = false then SB5.Text = "Loading: " + file_Name	:	LL = 	3591
                                    Application.DoEvents();
                                    LL = 3596;
                                    LastVerNbr = 0;
                                    LL = 3601;
                                    LL = 3606;
                                    My.MyProject.Forms.frmNotify.lblFileSpec.ForeColor = Color.Black;
                                    LL = 3611;
                                    My.MyProject.Forms.frmNotify.lblFileSpec.BackColor = Color.White;
                                    LL = 3616;
                                    double BytesLoading = file_Length;
                                    LL = 3621;
                                    string Units = "";
                                    LL = 3626;
                                    if (BytesLoading > 1000d)
                                    {
                                        LL = 3631;
                                        BytesLoading = BytesLoading / 1000d;
                                        LL = 3636;
                                        Units = "KB";
                                        LL = 3641;
                                        Math.Round(BytesLoading - 0.005d, 2);
                                        LL = 3646;
                                    }

                                    LL = 3651;
                                    if (BytesLoading > 100000d)
                                    {
                                        LL = 3656;
                                        BytesLoading = BytesLoading / 1000d;
                                        LL = 3661;
                                        Units = "KB";
                                        LL = 3666;
                                        Math.Round(BytesLoading - 0.005d, 2);
                                        LL = 3671;
                                        My.MyProject.Forms.frmNotify.lblFileSpec.BackColor = Color.WhiteSmoke;
                                        LL = 3676;
                                        My.MyProject.Forms.frmNotify.lblFileSpec.ForeColor = Color.Black;
                                        LL = 3681;
                                    }

                                    LL = 3686;
                                    if (BytesLoading > 1000000d)
                                    {
                                        LL = 3691;
                                        BytesLoading = BytesLoading / 1000000d;
                                        LL = 3696;
                                        Units = "MB";
                                        LL = 3701;
                                        Math.Round(BytesLoading - 0.005d, 2);
                                        LL = 3706;
                                        My.MyProject.Forms.frmNotify.lblFileSpec.ForeColor = Color.Red;
                                        LL = 3711;
                                    }

                                    LL = 3716;
                                    if (BytesLoading > 1000000000d)
                                    {
                                        LL = 3721;
                                        BytesLoading = BytesLoading / 1000000000d;
                                        LL = 3726;
                                        Units = "GB";
                                        LL = 3731;
                                        Math.Round(BytesLoading - 0.005d, 2);
                                        LL = 3736;
                                        My.MyProject.Forms.frmNotify.lblFileSpec.BackColor = Color.Red;
                                        LL = 3741;
                                        My.MyProject.Forms.frmNotify.lblFileSpec.ForeColor = Color.White;
                                        LL = 3746;
                                    }

                                    LL = 3751;
                                    LL = 3756;
                                    Application.DoEvents();
                                    LL = 3761;
                                    LL = 3766;
                                    if (Conversion.Val(file_Length) > 1000000000d)
                                    {
                                        LL = 3771;
                                        // frmNotify.lblFileSpec.Text = "Huge File:" + BytesLoading.ToString + Units : LL = 3776
                                        My.MyProject.Forms.frmNotify.lblPdgPages.Text = "Huge File:" + BytesLoading.ToString() + Units;
                                        LL = 3776;
                                        Application.DoEvents();
                                        LL = 3781;
                                        DisplayActivity = true;
                                        LL = 3786;
                                        // WDM Commented out the below Oct 6, 2020
                                        // If ActivityThread Is Nothing Then : LL = 3791
                                        // frmPercent.TopLevel = True : LL = 3796
                                        // ActivityThread = New Thread(AddressOf ActivateProgressBar) : LL = 3801
                                        // ActivityThread.Priority = ThreadPriority.Lowest : LL = 3806
                                        // ActivityThread.IsBackground = True : LL = 3811
                                        // ActivityThread.Start() : LL = 3816
                                        // End If : LL = 3821
                                        modGlobals.gfile_Length = Conversion.Val(file_Length);
                                        LL = 3826;
                                    }
                                    else if (Conversion.Val(file_Length) > 3000000d)
                                    {
                                        LL = 3831;
                                        modGlobals.gfile_Length = Conversion.Val(file_Length);
                                        LL = 3836;
                                        // frmNotify.lblFileSpec.Text = "Large File:" + BytesLoading.ToString + Units : LL = 3841
                                        My.MyProject.Forms.frmNotify.lblPdgPages.Text = "Large File:" + BytesLoading.ToString() + Units;
                                        Application.DoEvents();
                                        LL = 3846;
                                        DisplayActivity = true;
                                        LL = 3851;
                                        // WDM Commented out the below Oct 6, 2020
                                        // If ActivityThread Is Nothing Then : LL = 3856
                                        // frmPercent.TopLevel = True : LL = 3861
                                        // ActivityThread = New Thread(AddressOf ActivateProgressBar) : LL = 3866
                                        // ActivityThread.Priority = ThreadPriority.Lowest : LL = 3871
                                        // ActivityThread.IsBackground = True : LL = 3876
                                        // ActivityThread.Start() : LL = 3881
                                        // End If : LL = 3886
                                    }

                                    LL = 3891;
                                    LL = 3896;
                                    StepTimer = DateAndTime.Now;
                                    LL = 3901;
                                    LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content", "START");
                                    LL = 3906;
                                    // file_FullName = UTIL.RemoveSingleQuotes(file_FullName)	:	LL = 	3911
                                    // file_Name = UTIL.RemoveSingleQuotes(file_Name)	:	LL = 	3916
                                    LL = 3921;
                                    // DOCS.setSourceguid(SourceGuid) : LL = 3926
                                    // DOCS.setFqn(file_FullName) : LL = 3931
                                    // DOCS.setSourcename(file_name) : LL = 3936
                                    // DOCS.setSourcetypecode(file_Extension) : LL = 3941
                                    // DOCS.setLastaccessdate(file_LastAccessTime) : LL = 3946
                                    // DOCS.setCreatedate(file_CreationTime) : LL = 3951
                                    // DOCS.setCreationdate(file_CreationTime) : LL = 3956
                                    // DOCS.setLastwritetime(file_LastWriteTime) : LL = 3961
                                    // DOCS.setDatasourceowneruserid(CurrUserGuidID) : LL = 3966
                                    // DOCS.setVersionnbr("0") : LL = 3971
                                    LL = 3976;
                                    // ******************************* INSERT INTITAL CONTENT DATA **************************************
                                    bSuccessExecution = DOCS.Insert(SourceGuid, FileHash);
                                    LL = 3981;
                                    // **************************************************************************************************
                                    if (!bSuccessExecution)
                                    {
                                        LOG.WriteToArchiveLog("ERROR Completion 12x: " + SourceGuid + " / " + FileHash);
                                    }

                                    LOG.WriteToTimerLog("ArchiveContent-01", "Insert Content: " + file_FullName, "STOP", StepTimer);
                                    LL = 3986;
                                    LL = 3991;
                                    bool bOcrNeeded = DBARCH.ckOcrNeeded(file_Extension);
                                    LL = 3996;
                                    LL = 4001;
                                    if (bOcrNeeded)
                                    {
                                        LL = 4006;
                                        DBARCH.SetOcrProcessingParms(SourceGuid, "C", file_name);
                                        LL = 4011;
                                    }

                                    LL = 4016;
                                    LL = 4021;
                                    if (bSuccessExecution)
                                    {
                                        LL = 4026;
                                        var UpdateTimer = DateAndTime.Now;
                                        LL = 4066;

                                        // *************************************************	:	LL = 	4076
                                        UpdateTimer = DateAndTime.Now;
                                        LL = 4081;
                                        string OriginalFileName = DMA.getFileName(file_FullName);
                                        LL = 4091;
                                        LL = 4096;
                                        // **--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	:	LL = 	4111
                                        // **WDM - this is where the upload magic occurs. Upload content to repository	:	LL = 	4116
                                        LOG.WriteToTimerLog("**** ArchiveContent-01", "UpdateSourceImageInRepo", "START");
                                        // ******************************************************************************************************************************************************************************************************************************	:	LL = 	4101                                   
                                        SB.Text = "UPLOADING NOW";
                                        bSuccessExecution = DBARCH.UpdateSourceImageInRepo(OriginalFileName, UIDcurr, MachineIDcurr, SourceGuid, Conversions.ToString(file_LastAccessTime), Conversions.ToString(file_CreationTime), Conversions.ToString(file_LastWriteTime), LastVerNbr, file_FullName, RetentionCode, isPublic, FileHash);
                                        LL = 4121;
                                        SB.Text = "";
                                        // ******************************************************************************************************************************************************************************************************************************	:	LL = 	4101
                                        if (bSuccessExecution)
                                        {
                                            DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName);
                                            bool bUpdt = DBLocal.setListenerfileProcessed(file_FullName);
                                            if (!bUpdt)
                                            {
                                                LOG.WriteToArchiveLog("ERROR failed to set Processed flag: " + file_FullName);
                                            }
                                        }
                                        else
                                        {
                                            LOG.WriteToArchiveLog("ERROR: ArchiveContent-AA1 Failed load: " + Constants.vbCrLf + file_FullName);
                                        }

                                        LOG.WriteToTimerLog("****ArchiveContent-01", "UpdateSourceImageInRepo", "STOP", UpdateTimer);
                                        UpdateTimer = DateAndTime.Now;
                                        LOG.WriteToTimerLog("**** ArchiveContent-01", "saveContentOwner", "START");
                                        DBARCH.saveContentOwner(SourceGuid, CurrUserGuidID, "C", FOLDER_FQN, modGlobals.gMachineID, modGlobals.gNetworkID);
                                        LL = 4126;
                                        LOG.WriteToTimerLog("****ArchiveContent-01", "saveContentOwner", "STOP", UpdateTimer);
                                        // **--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	:	LL = 	4131
                                        // ******************************************************************************************************************************************************************************************************************************	:	LL = 	4141
                                        LL = 4146;
                                        if (!DeleteOnArchive.Equals("Y"))
                                        {
                                            try
                                            {
                                                DBLocal.addInventoryForce(file_FullName, ckArchiveBit);
                                                LL = 4147;
                                            }
                                            catch (Exception ex)
                                            {
                                                LOG.WriteToArchiveLog("ERROR ArchiveContent 02xx LocalDB Failed to add: " + file_FullName);
                                            }
                                        }
                                        else
                                        {
                                            DBLocal.delFile(file_FullName);
                                            LL = 4148;
                                        }

                                        if (CurrFileName.Length > 0)
                                        {
                                            if (CurrExt.Trim().Length == 0)
                                            {
                                                CurrExt = Path.GetExtension(CurrFileName);
                                            }

                                            string NewSql = "Update DataSource set OriginalFileType = '" + CurrExt + "' , CreateDate = '" + CurrCreateDate.ToString() + "', LastWriteTime = '" + CurrLastUpdate.ToString() + "'  where SourceGuid = '" + SourceGuid + "' ";
                                            DBARCH.ExecuteSqlNewConn(90076, NewSql);
                                        }
                                        // ****************************************************************************************************************************	:	LL = 	4161
                                        if (!bSuccessExecution)
                                        {
                                            // Dim isIncludedAsSubDir As Boolean = DBARCH.isSubDirIncluded(FOLDER_FQN )
                                            string MySql = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'";
                                            DBARCH.ExecuteSqlNewConn(90314, MySql);
                                            LOG.WriteToErrorLog("Unrecoverable LOAD Error - removed file '" + file_FullName + "' from the repository.");
                                            if (UseThreads == false)
                                                SB5.BackColor = Color.Red;
                                            if (UseThreads == false)
                                                SB5.ForeColor = Color.Yellow;
                                            string DisplayMsg = "A source file failed to load. Review ERROR log." + Constants.vbCrLf + file_FullName + "LL: " + LL.ToString();
                                            My.MyProject.Forms.frmHelp.MsgToDisplay = DisplayMsg;
                                            My.MyProject.Forms.frmHelp.CallingScreenName = "ECM Archive";
                                            My.MyProject.Forms.frmHelp.CaptionName = "Fatal Load Error";
                                            My.MyProject.Forms.frmHelp.Timer1.Interval = 10000;
                                            My.MyProject.Forms.frmHelp.Show();
                                        }
                                        else
                                        {
                                            LL = 4236;
                                            if (LibraryList.Count > 0)
                                            {
                                                LL = 4241;
                                                for (int II = 0, loopTo3 = LibraryList.Count - 1; II <= loopTo3; II++)
                                                {
                                                    LL = 4246;
                                                    string LibraryName = LibraryList[II];
                                                    LL = 4251;
                                                    ARCH.AddLibraryItem(SourceGuid, file_name, file_Extension, LibraryName);
                                                    LL = 4256;
                                                }

                                                LL = 4261;
                                            }

                                            LL = 4266;
                                        }

                                        LL = 4271;
                                    }
                                    else
                                    {
                                        LL = 4276;
                                        LOG.WriteToArchiveLog("Error 22.345.23a - Failed to add source:" + file_FullName);
                                        LL = 4281;
                                    }

                                    LL = 4286;
                                    LL = 4291;
                                    // file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 4296
                                    // file_name = UTIL.RemoveSingleQuotes(file_name) : LL = 4301
                                    LL = 4306;
                                    if (bSuccessExecution)
                                    {
                                        LL = 4311;
                                        LL = 4321;
                                        // file_FullName = UTIL.RemoveSingleQuotes(file_FullName) : LL = 4326
                                        // file_name = UTIL.RemoveSingleQuotes(file_name) : LL = 4331
                                        LL = 4336;
                                        if (DeleteOnArchive.Equals("Y"))
                                        {
                                            LL = 4341;
                                            if (ListOfFilesToDelete.ContainsKey(file_FullName))
                                            {
                                                LL = 4346;
                                                try
                                                {
                                                    ListOfFilesToDelete[file_FullName] = "DELETE";
                                                    LL = 4361;
                                                }
                                                catch (ThreadAbortException ex)
                                                {
                                                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                                                    Thread.ResetAbort();
                                                }
                                                catch (Exception ex)
                                                {
                                                    Console.WriteLine(ex.Message + Constants.vbCrLf + "LL=" + LL.ToString());
                                                    var st = new StackTrace(true);
                                                    st = new StackTrace(ex, true);
                                                    LOG.WriteToArchiveLog("LL=" + LL.ToString());
                                                }
                                            }
                                            else if (!ListOfFilesToDelete.ContainsKey(file_FullName))
                                            {
                                                LL = 4396;
                                                ListOfFilesToDelete.Add(file_FullName, "DELETE");
                                                LL = 4401;
                                            }

                                            LL = 4406;
                                        }

                                        LL = 4411;
                                        LL = 4416;
                                        // If CRC .Length = 0 Then	:	LL = 	4421
                                        // CRC  = ENC.getCountDataSourceFiles(file_FullName )	:	LL = 	4426
                                        // End If	:	LL = 	4431
                                        // ARCH.UpdateDocCrc(SourceGuid, CRC )	:	LL = 	4436
                                        LL = 4441;
                                        DBARCH.UpdateCurrArchiveStats(file_FullName, file_Extension);
                                        LL = 4446;
                                    }
                                    else
                                    {
                                        LL = 4451;
                                        modGlobals.FilesSkipped += 1;
                                        LL = 4456;
                                        if (ddebug)
                                        {
                                            LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
                                            LL = 4461;
                                        }

                                        if (ddebug)
                                        {
                                            LOG.WriteToArchiveLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
                                            LL = 4466;
                                        }

                                        Debug.Print("FAILED TO LOAD: " + file_FullName);
                                        LL = 4471;
                                        if (ddebug)
                                        {
                                            LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :FAILED TO LOAD: 8013a: " + file_FullName);
                                            LL = 4476;
                                        }
                                    }

                                    LL = 4481;
                                    LL = 4486;
                                    if (Conversion.Val(file_Length) > 1000000d)
                                    {
                                        LL = 4491;
                                        if (UseThreads == false)
                                        {
                                            SB5.Text = "Large file Load completed...";
                                            LL = 4496;
                                        }

                                        DisplayActivity = false;
                                        LL = 4501;
                                        // WDM Commented out the below Oct 6, 2020
                                        // If Not ActivityThread Is Nothing Then : LL = 4506
                                        // ActivityThread.Abort() : LL = 4511
                                        // ActivityThread = Nothing : LL = 4516
                                        // End If : LL = 4521
                                        PBx.Value = 0;
                                        LL = 4526;
                                        Application.DoEvents();
                                        LL = 4531;
                                    }

                                    LL = 4536;
                                    if (bSuccessExecution)
                                    {
                                        LL = 4541;
                                        var UpdateTimer2 = DateAndTime.Now;
                                        LL = 4546;
                                        LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "START");
                                        LL = 4551;
                                        LL = 4556;
                                        Application.DoEvents();
                                        LL = 4561;
                                        DBARCH.UpdateDocFqn(SourceGuid, file_FullName);
                                        LL = 4566;
                                        DBARCH.UpdateDocSize(SourceGuid, file_Length.ToString());
                                        LL = 4571;
                                        DBARCH.UpdateDocDir(SourceGuid, file_FullName);
                                        LL = 4576;
                                        DBARCH.UpdateDocOriginalFileType(SourceGuid, file_Extension);
                                        LL = 4581;
                                        DBARCH.UpdateZipFileIndicator(SourceGuid, isZipFile);
                                        LL = 4586;
                                        Application.DoEvents();
                                        LL = 4591;
                                        if (ddebug)
                                        {
                                            LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :Success: 8015");
                                            LL = 4596;
                                        }

                                        if (!isZipFile)
                                        {
                                            LL = 4601;
                                            // Dim TheFileIsArchived As Boolean = True	:	LL = 	4606
                                            // DMA.setFileArchiveAttributeSet(file_FullName, TheFileIsArchived)	:	LL = 	4611
                                            DMA.setArchiveBitOff(file_FullName);
                                            LL = 4616;
                                        }

                                        LL = 4621;
                                        LL = 4626;
                                        // DBARCH.delFileParms(SourceGuid)	:	LL = 	4631
                                        // If CRC .Length = 0 Then	:	LL = 	4636
                                        // CRC  = ENC.getCountDataSourceFiles(file_FullName )	:	LL = 	4641
                                        // End If	:	LL = 	4646
                                        // ARCH.UpdateDocCrc(SourceGuid, CRC )	:	LL = 	4651
                                        LL = 4656;
                                        // ** Removed Attribution Classification by WDM 9/10/2009	:	LL = 	4661
                                        // UpdateSrcAttrib(SourceGuid, "CRC", CRC , file_Extension)	:	LL = 	4666
                                        UpdateSrcAttrib(SourceGuid, "FILENAME", file_name, file_Extension);
                                        LL = 4671;
                                        UpdateSrcAttrib(SourceGuid, "CreateDate", Conversions.ToString(file_CreationTime), file_Extension);
                                        LL = 4676;
                                        UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length.ToString(), file_Extension);
                                        LL = 4681;
                                        UpdateSrcAttrib(SourceGuid, "ChangeDate", Conversions.ToString(file_LastAccessTime), file_Extension);
                                        LL = 4686;
                                        UpdateSrcAttrib(SourceGuid, "WriteDate", Conversions.ToString(file_LastWriteTime), file_Extension);
                                        LL = 4691;
                                        LL = 4696;
                                        // DBARCH.AddMachineSource(file_FullName, SourceGuid)	:	LL = 	4701
                                        LL = 4706;
                                        if (Conversion.Val(file_Length) > 1000000000d)
                                        {
                                            LL = 4711;
                                        }
                                        // FrmMDIMain.SB4.Text = "Extreme File: " + file_Length + " bytes - standby"	:	LL = 	4716
                                        else if (Conversion.Val(file_Length) > 2000000d)
                                        {
                                            LL = 4721;
                                            // FrmMDIMain.SB4.Text = "Large File: " + file_Length + " bytes"	:	LL = 	4726
                                        }

                                        LL = 4731;
                                        if (Strings.LCase(file_Extension).Equals(".mp3") | Strings.LCase(file_Extension).Equals(".wma") | Strings.LCase(file_Extension).Equals("wma"))
                                        {
                                            LL = 4736;
                                            MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension);
                                            LL = 4741;
                                            Application.DoEvents();
                                            LL = 4746;
                                        }
                                        else if (Strings.LCase(file_Extension).Equals(".tiff") | Strings.LCase(file_Extension).Equals(".jpg"))
                                        {
                                            LL = 4751;
                                            // ** This functionality will be added at a later time	:	LL = 	4756
                                            // KAT.getXMPdata(file_FullName)	:	LL = 	4761
                                            Application.DoEvents();
                                            LL = 4766;
                                        }
                                        else if (Strings.LCase(file_Extension).Equals(".png") | Strings.LCase(file_Extension).Equals(".gif"))
                                        {
                                            LL = 4771;
                                            // ** This functionality will be added at a later time	:	LL = 	4776
                                            // KAT.getXMPdata(file_FullName)	:	LL = 	4781
                                            Application.DoEvents();
                                            LL = 4786;
                                        }
                                        // ElseIf LCase(file_Extension).Equals(".wav") Then	:	LL = 	4791
                                        // MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension)	:	LL = 	4796
                                        else if (Strings.LCase(file_Extension).Equals(".wma"))
                                        {
                                            LL = 4801;
                                            MP3.getRecordingMetaData(file_FullName, SourceGuid, file_Extension);
                                            LL = 4806;
                                        }
                                        else if (Strings.LCase(file_Extension).Equals(".tif"))
                                        {
                                            LL = 4811;
                                            // ** This functionality will be added at a later time	:	LL = 	4816
                                            // KAT.getXMPdata(file_FullName)	:	LL = 	4821
                                            Application.DoEvents();
                                            LL = 4826;
                                        }

                                        LL = 4831;
                                        Application.DoEvents();
                                        LL = 4836;
                                        if ((Strings.LCase(file_Extension).Equals(".doc") | Strings.LCase(file_Extension).Equals(".docx")) & ckMetaData.Equals("Y"))

                                        {
                                            LL = 4851;
                                            GetWordDocMetadata(file_FullName, SourceGuid, file_Extension);
                                            LL = 4856;
                                            GC.Collect();
                                            LL = 4861;
                                        }

                                        LL = 4866;
                                        if ((file_Extension.Equals(".xls") | file_Extension.Equals(".xlsx") | file_Extension.Equals(".xlsm")) & ckMetaData.Equals("Y"))


                                        {
                                            LL = 4886;
                                            GetExcelMetaData(file_FullName, SourceGuid, file_Extension);
                                            LL = 4891;
                                            GC.Collect();
                                            LL = 4896;
                                        }

                                        LL = 4901;
                                        LOG.WriteToTimerLog("ArchiveContent-01", "UpdateSourceImage2", "STOP", UpdateTimer2);
                                        LL = 4906;
                                    }

                                    LL = 4911;
                                    LL = 4916;
                                    TS = DateAndTime.Now.Subtract(sTime);
                                    LL = 4921;
                                    sMin = TS.Minutes.ToString();
                                    LL = 4926;
                                    sSec = TS.Seconds.ToString();
                                    LL = 4931;

                                    // frmNotify.lblPdgPages.Text = "Size: " + BytesLoading.ToString + Units + " / " + TS.Hours.ToString + ":" + sMin + ":" + sSec
                                    // frmNotify.Refresh()
                                    // frmNotify.lblFileSpec.Text = "Size: " + BytesLoading.ToString + Units + " / " + TS.Hours.ToString + ":" + sMin + ":" + sSec : LL = 4936
                                    // frmNotify.Refresh() : LL = 4941

                                    Application.DoEvents();
                                    LL = 4946;
                                    LL = 4951;
                                    isZipFile = ZF.isZipFile(file_FullName);
                                    LL = 4956;
                                    if (isZipFile == true)
                                    {
                                        LL = 4961;
                                        string ExistingParentZipGuid = DBARCH.GetGuidByFqn(file_FullName, 0.ToString());
                                        LL = 4966;
                                        bExplodeZipFile = false;
                                        LL = 4971;
                                        StackLevel = 0;
                                        LL = 4976;
                                        ListOfFiles.Clear();
                                        LL = 4981;
                                        if (ExistingParentZipGuid.Length > 0)
                                        {
                                            LL = 4986;
                                            DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, false);
                                            LL = 4991;
                                            ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, ExistingParentZipGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                                            LL = 4996;
                                            DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName);
                                        }
                                        else
                                        {
                                            LL = 5006;
                                            DBLocal.addZipFile(file_FullName, SourceGuid, false);
                                            LL = 5011;
                                            ZF.UploadZipFile(UIDcurr, MachineIDcurr, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                                            LL = 5016;
                                            DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName);
                                        }

                                        LL = 5026;
                                    }

                                    LL = 5031;
                                    LL = 5036;
                                }

                                LL = 5041;
                                NextFile:
                                ;
                                LL = 5046;
                                if (UseThreads == false)
                                {
                                    SB5.Text = "Processing Dir: " + FolderName + " # " + K.ToString();
                                    LL = 5051;
                                }

                                if (ddebug)
                                {
                                    LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :Success: 8032");
                                    LL = 5056;
                                }

                                Application.DoEvents();
                                LL = 5061;
                                if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                                {
                                    bool bUpdt = DBLocal.setListenerfileProcessed(file_FullName);
                                    if (!bUpdt)
                                    {
                                        LOG.WriteToArchiveLog("ERROR 12x1 failed to set Processed flag: " + file_FullName);
                                    }
                                }

                                LL = 5066;
                                if (modGlobals.gTerminateImmediately)
                                {
                                    LL = 5071;
                                    if (UseThreads == false)
                                    {
                                        SB5.Text = "Terminated archive!";
                                        LL = 5076;
                                    }

                                    My.MyProject.Forms.frmNotify.Close();
                                    LL = 5081;
                                    modGlobals.gContentArchiving = false;
                                    LL = 5086;
                                    My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                                    LL = 5091;
                                    My.MySettingsProperty.Settings.Save();
                                    LL = 5096;
                                    return;
                                    LL = 5101;
                                }

                                LL = 5106;
                                LL = 5111;
                                if (ckArchiveBit == true & file_name is object)
                                {
                                    LL = 5116;
                                    DMA.setArchiveBitOff(file_FullName);
                                    LL = 5121;
                                }

                                LL = 5126;
                                DoneWithIt:
                                ;
                                LL = 5131;
                                // ******************************************************	:	LL = 	5136
                                if (DeleteOnArchive.ToUpper().Equals("Y") & ThisFileNeedsToBeDeleted & file_FullName is object)
                                {
                                    LL = 5141;
                                    LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "DELETED", UpdateTimerMain);
                                    LL = 5146;
                                    try
                                    {
                                        LL = 5151;
                                        if (ListOfFilesToDelete.ContainsKey(file_FullName))
                                        {
                                            LL = 5156;
                                            ListOfFilesToDelete[file_FullName] = "DELETE";
                                            LL = 5161;
                                        }

                                        LL = 5166;
                                    }
                                    // ISO.saveIsoFile(" FilesToDelete.dat", file_FullName + "|")	:	LL = 	5171
                                    // File.Delete(file_FullName)	:	LL = 	5176
                                    catch (ThreadAbortException ex)
                                    {
                                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                                        Thread.ResetAbort();
                                    }
                                    catch (Exception ex)
                                    {
                                        LOG.WriteToArchiveLog("Warning AF2 Failed to DELETE: " + file_FullName, ex);
                                        var st = new StackTrace(true);
                                        st = new StackTrace(ex, true);
                                        LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                                        LOG.WriteToArchiveLog("LL=" + LL.ToString());
                                    }
                                }
                                else if (DeleteOnArchive.Equals("Y") & ThisFileNeedsToBeMoved & file_FullName is object)
                                {
                                    LL = 5211;
                                    LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "MOVED", UpdateTimerMain);
                                    LL = 5216;
                                    try
                                    {
                                        LL = 5221;
                                        var FI2 = new FileInfo(file_FullName);
                                        LL = 5226;
                                        string fNameOnly = FI2.Name;
                                        LL = 5231;
                                        string fDirName = FI2.DirectoryName;
                                        LL = 5236;
                                        string NewName = ERR_FQN + @"\" + fNameOnly;
                                        LL = 5241;
                                        FI2 = null;
                                        LL = 5246;
                                        File.Move(file_FullName, NewName);
                                        LL = 5251;
                                    }
                                    catch (ThreadAbortException ex)
                                    {
                                        LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                                        Thread.ResetAbort();
                                    }
                                    catch (Exception ex)
                                    {
                                        LOG.WriteToArchiveLog("ERROR Failed to MOVE: " + file_FullName);
                                        var st = new StackTrace(true);
                                        st = new StackTrace(ex, true);
                                        LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                                        LOG.WriteToArchiveLog("LL=" + LL.ToString());
                                    }
                                }

                                LL = 5286;
                                // ******************************************************	:	LL = 	5291
                                if (file_FullName is object)
                                {
                                    LL = 5296;
                                    LOG.WriteToTimerLog("ArchiveContent-01", "Archive File:" + file_FullName, "STOP", UpdateTimerMain);
                                    LL = 5301;
                                }

                                LL = 5306;
                            }

                            LL = 5311;
                        }
                        else
                        {
                            LL = 5316;
                            if (ddebug)
                            {
                                Debug.Print("Duplicate Folder: " + FolderName);
                                LL = 5321;
                            }

                            if (ddebug)
                            {
                                LOG.WriteToArchiveLog("frmMain : AddSourceToRepo :Success: 8034");
                                LL = 5326;
                            }
                        }

                        LL = 5331;
                        NextFolder:
                        ;
                        pFolder = FolderName;
                        LL = 5341;
                        if (modGlobals.gTerminateImmediately)
                        {
                            LL = 5346;
                            Cursor = Cursors.Default;
                            LL = 5351;
                            if (UseThreads == false)
                            {
                                SB5.Text = "Terminated archive!";
                                LL = 5356;
                            }

                            My.MyProject.Forms.frmNotify.Close();
                            LL = 5361;
                            modGlobals.gContentArchiving = false;
                            LL = 5366;
                            My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                            LL = 5371;
                            My.MySettingsProperty.Settings.Save();
                            LL = 5376;
                            return;
                            LL = 5381;
                        }

                        LL = 5386;
                    }
                    catch (Exception ex)
                    {
                        var st = new StackTrace(true);
                        st = new StackTrace(ex, true);
                        LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                        LOG.WriteToArchiveLog("LL=" + LL.ToString());
                        LOG.WriteToArchiveLog("ERROR: Failed to ArchiveContent: " + file_FullName + ", skipping : " + ex.Message);
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                    }
                }

                LL = 5391;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("error ArchiveContent Thread 90 - caught ThreadAbortException - resetting.");
                LOG.WriteToArchiveLog("LL=" + LL.ToString());
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("ERROR: ArchiveContent #22621: " + ex.Message);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                LOG.WriteToArchiveLog("LL=" + LL.ToString());
            }
            finally
            {
                My.MyProject.Forms.frmNotify.Text = "CONTENT:";
                if (DeleteOnArchive.Equals("Y"))
                {
                    LL = 5426;
                    foreach (string FQN in ListOfFilesToDelete.Keys)
                    {
                        LL = 5431;
                        int IDX = ListOfFilesToDelete.IndexOfKey(FQN);
                        LL = 5436;
                        string tAction = ListOfFilesToDelete.Values[IDX];
                        LL = 5441;
                        try
                        {
                            LL = 5446;
                            if (tAction.Equals("DELETE"))
                            {
                                LL = 5451;
                                if (File.Exists(FQN))
                                {
                                    LL = 5456;
                                    ISO.saveIsoFile(" FilesToDelete.dat", FQN + "|");
                                    LL = 5461;
                                    try
                                    {
                                        File.Delete(FQN);
                                        LL = 5466;
                                    }
                                    catch (Exception ex)
                                    {
                                        LOG.WriteToArchiveLog("DELETE FAILURE 00|" + FQN);
                                    }
                                }

                                LL = 5471;
                            }
                            else if (tAction.Equals("MOVE"))
                            {
                                LL = 5476;
                                if (File.Exists(FQN))
                                {
                                    LL = 5481;
                                    var FI = new FileInfo(FQN);
                                    LL = 5486;
                                    string fNameOnly = FI.Name;
                                    LL = 5491;
                                    string fDirName = FI.DirectoryName;
                                    LL = 5496;
                                    string NewName = ERR_FQN + @"\" + fNameOnly;
                                    LL = 5501;
                                    FI = null;
                                    LL = 5506;
                                    File.Move(FQN, NewName);
                                    LL = 5511;
                                }

                                LL = 5516;
                            }
                            else
                            {
                                LOG.WriteToArchiveLog("ERROR/Advisory Notice - File " + FQN + " had no known disposition, it was moved to the error directory.");
                                LL = 5526;
                                if (File.Exists(FQN))
                                {
                                    LL = 5531;
                                    var FI = new FileInfo(FQN);
                                    LL = 5536;
                                    string fNameOnly = FI.Name;
                                    LL = 5541;
                                    string fDirName = FI.DirectoryName;
                                    LL = 5546;
                                    string NewName = ERR_FQN + @"\" + fNameOnly;
                                    LL = 5551;
                                    FI = null;
                                    LL = 5556;
                                    File.Move(FQN, NewName);
                                    LL = 5561;
                                }

                                LL = 5566;
                            }

                            LL = 5571;
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (Exception ex)
                        {
                            if (!modGlobals.gRunUnattended)
                            {
                                MessageBox.Show("Could not remove the file " + FQN + "." + Constants.vbCrLf + ex.Message);
                            }
                            else
                            {
                                LOG.WriteToArchiveLog("Could not remove the file " + FQN + ". - " + ex.Message);
                                var st = new StackTrace(true);
                                st = new StackTrace(ex, true);
                                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                                LOG.WriteToArchiveLog("LL=" + LL.ToString());
                            }
                        }
                    }

                    LL = 5626;
                }

                LL = 5631;
            }

            LL = 5636;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            LL = 5641;
            if (UseThreads == false)
            {
                SB5.Text = "Files Completed";
                LL = 5646;
            }

            PBx.Value = 0;
            LL = 5651;
            LL = 5656;
            // Timer1.Enabled = True	:	LL = 	5661
            if (ddebug)
            {
                LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with Content Archive.");
                LL = 5666;
            }

            LL = 5671;
            PROC.getProcessesToKill();
            LL = 5676;
            PROC.KillOrphanProcesses();
            LL = 5681;
            // FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"	:	LL = 	5686
            LL = 5691;
            StackLevel = 0;
            LL = 5696;
            ListOfFiles.Clear();
            LL = 5701;
            LL = 5706;
            for (int i = 0, loopTo4 = modGlobals.ZipFilesContent.Count - 1; i <= loopTo4; i++)
            {
                LL = 5711;
                bExplodeZipFile = false;
                LL = 5716;
                // FrmMDIMain.SB.Text = "Processing Quickref"	:	LL = 	5721
                // If i >= 24 Then	:	LL = 	5726
                // Debug.Print("here")	:	LL = 	5731
                // End If	:	LL = 	5736
                string cData = modGlobals.ZipFilesContent[i].ToString();
                LL = 5741;
                string ParentGuid = "";
                LL = 5746;
                string FQN = "";
                LL = 5751;
                int K = Strings.InStr(cData, "|");
                LL = 5756;
                FQN = Strings.Mid(cData, 1, K - 1);
                LL = 5761;
                ParentGuid = Strings.Mid(cData, K + 1);
                LL = 5766;
                ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                LL = 5771;
            }

            LL = 5776;
            LL = 5781;
            ListOfFiles = null;
            LL = 5786;
            GC.Collect();
            LL = 5791;
            LL = 5796;
            My.MyProject.Forms.frmNotify.Close();
            LL = 5801;
            modGlobals.gContactsArchiving = false;
            LL = 5806;
            modGlobals.gContentArchiving = false;
            LL = 5811;
            LL = 5816;
            My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
            LL = 5821;
            My.MySettingsProperty.Settings.Save();
            LL = 5826;
            LL = 5831;
            My.MyProject.Forms.frmNotify.lblFileSpec.Text = "Content archive complete.";
            LL = 5836;
            My.MyProject.Forms.frmNotify.Refresh();
            LL = 5841;
            LL = 5846;
            if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
            {
                bUpdated = DBLocal.removeListenerfileProcessed(FilesToArchiveID);
                if (Conversions.ToBoolean(!bUpdated))
                {
                    LOG.WriteToArchiveLog("ERROR 01 failed removeListenerfileProcessed...");
                }
            }

            My.MyProject.Forms.frmNotify.Close();
            GC.Collect();
            GC.WaitForPendingFinalizers();
            GC.WaitForFullGCComplete();
        }

        public void ArchiveData(string UID, string FileDirectory, string TopFolder, ref SortedList SL)
        {
            CompletedPolls = CompletedPolls + 1;
            SB.Text = DateAndTime.Now + " : Archiving data... standby: " + CompletedPolls;
            var ActiveFolders = new string[1];
            string FolderName = "";
            bool DeleteFile = false;
            string ArchiveEmails = "";
            string RemoveAfterArchive = "";
            string SetAsDefaultFolder = "";
            string ArchiveAfterXDays = "";
            string RemoveAfterXDays = "";
            string RemoveXDays = "";
            string ArchiveXDays = "";
            string DB_ID = "";
            string ArchiveOnlyIfRead = "";
            var EmailFolders = new string[1];
            DBARCH.GetEmailFolders(ref modGlobals.gCurrUserGuidID, ref EmailFolders);
            for (int i = 0, loopTo = Information.UBound(EmailFolders); i <= loopTo; i++)
            {
                FolderName = EmailFolders[i].ToString().Trim();
                bool BB = DBARCH.GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, FolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
                if (BB)
                {

                    // ARCH.getSubFolderEmails(FolderName , bDeleteMsg)
                    ARCH.getSubFolderEmailsSenders(UID, TopFolder, FolderName, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, FileDirectory);
                    // ARCH.GetEmails(FolderName , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , DB_ID )
                }
            }
        }

        // Public Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles
        // Timer1.Tick If ckDisable.Checked Then SB.Text = "DISABLE ALL is checked - no archive allowed."
        // Return End If Dim frm As Form Try For Each frm In My.Application.OpenForms
        // Application.DoEvents() If frm Is My.Forms.frmNotify Then Return End If If frm Is
        // My.Forms.frmNotify2 Then Return End If If frm Is My.Forms.frmExchangeMonitor Then Return End If
        // Next Catch ex As Exception Console.WriteLine("Timer1_Tick forms") End Try frm = Nothing

        // If Not t2 Is Nothing Then If t2.IsAlive Then Return End If End If If Not t3 Is Nothing Then If
        // t3.IsAlive Then Return End If End If If Not t4 Is Nothing Then If t4.IsAlive Then Return End If
        // End If If Not t5 Is Nothing Then If t5.IsAlive Then Return End If End If

        // Timer1.Enabled = False

        // Dim LastYearArchive As Integer = 0 Dim LastMonthArchive As Integer = 0 Dim LastDayArchive As
        // Integer = 0 Dim LastMinuteArchive As Integer = 0

        // Dim TodayYear As Integer = Now.Year Dim TodayDay As Integer = Now.Day Dim TodayMonth As Integer
        // = Now.Month Dim TodayMinute As Integer = Now.Minute Dim TodayHour As Integer = Now.Hour

        // Dim TS As TimeSpan = Nothing

        // Dim Days As Integer = 0 Dim Hours As Integer = 0

        // '** Now, we determine if we archive or not

        // Application.DoEvents() Dim isDisabled As Boolean = False

        // If ckDisable.Checked = True Then SB.Text = "ALL Archive disabled - " + Now.ToString
        // 'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString Timer1.Enabled = True

        // If DBARCH.isArchiveDisabled("ALL") = True Then isDisabled = True SB.Text = "ALL Archive
        // disabled - " + Now.ToString 'FrmMDIMain.SB.Text = "ALL Archive disabled " + Now.ToString Else
        // isDisabled = True SB.Text = "Archive disabled - " + Now.ToString 'FrmMDIMain.SB.Text = "Archive
        // disabled " + Now.ToString End If

        // ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
        // ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True

        // 'LOG.WriteToArchiveLog("ALL Archive disabled.")

        // Return Else SB.Text = "Archive enabled - " + Now.ToString 'FrmMDIMain.SB.Text = "Archive
        // enabled " + Now.ToString Timer1.Enabled = True ArchiveALLToolStripMenuItem.Enabled = True
        // ContentToolStripMenuItem.Enabled = True ExchangeEmailsToolStripMenuItem.Enabled = True
        // OutlookEmailsToolStripMenuItem.Enabled = True If gIsServiceManager = True Then
        // LOG.WriteToArchiveLog("ServiceManager Archive.") gbPolling.Enabled = False
        // ckUseLastProcessDateAsCutoff.Enabled = False btnRefreshFolders.Enabled = False
        // btnActive.Enabled = False cbParentFolders.Enabled = False lbActiveFolder.Enabled = False
        // ckArchiveFolder.Enabled = False ckArchiveRead.Enabled = False ckRemove.Enabled = False
        // ckArchAfterDays.Enabled = False NumericUpDown2.Enabled = False ckRemoveAfterXDays.Enabled =
        // False NumericUpDown3.Enabled = False ckSystemFolder.Enabled = False cbEmailRetention.Enabled =
        // False btnSaveConditions.Enabled = False btnDeleteEmailEntry.Enabled = False
        // OutlookEmailsToolStripMenuItem.Enabled = False ExchangeEmailsToolStripMenuItem.Enabled = False
        // ContentToolStripMenuItem.Enabled = False ArchiveALLToolStripMenuItem.Enabled = False
        // ckArchiveBit.Enabled = True End If End If

        // Dim RetentionCode = cbEmailRetention.Text Dim RetentionYears As Integer = 0 RetentionYears =
        // DBARCH.getRetentionPeriod(RetentionCode )

        // If gCurrentArchiveGuid.Length = 0 Then gCurrentArchiveGuid = Guid.NewGuid.ToString End If

        // Dim UnitValue = "" Dim ArchiveType = "" ArchiveType = DBARCH.getRconParm(gCurrUserGuidID,
        // "ArchiveType") UnitValue = DBARCH.getRconParm(gCurrUserGuidID, "ArchiveInterval")

        // Dim CurrStatus = "Running" Dim WC = STATS.wc_PI02_ArchiveStats(CurrStatus , gCurrUserGuidID)

        // ArchiveALLToolStripMenuItem.Enabled = False ContentToolStripMenuItem.Enabled = False
        // ExchangeEmailsToolStripMenuItem.Enabled = False OutlookEmailsToolStripMenuItem.Enabled = False

        // Dim LastSuccessFullArchiveDate As Date = Now Dim BackupNow As Boolean = False

        // '***********************************************************************************************
        // LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID) '***********************************************************************************************

        // If LastSuccessFullArchiveDate = Nothing Then LOG.WriteToArchiveLog("Last Archivesuccessful -
        // ready for archive to execute.") BackupNow = True Else LastYearArchive =
        // LastSuccessFullArchiveDate.Year LastMonthArchive = LastSuccessFullArchiveDate.Month
        // LastDayArchive = LastSuccessFullArchiveDate.Day LastMinuteArchive =
        // LastSuccessFullArchiveDate.Minute LOG.WriteToArchiveLog("Last Archivesuccessful RESET.") End If
        // SB.Text = "AUTO Archive running" SB2.Text = "AUTO Archive running" If ArchiveType
        // .Equals("Disable") Then LOG.WriteToArchiveLog("Archive Type is DISABLED.") Timer1.Enabled =
        // True ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
        // ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True
        // Return ElseIf ArchiveType .Equals("Monthly") Then 'lblUnit.Text = "day of the month" SB.Text =
        // "Backup every month on day " + UnitValue LOG.WriteToArchiveLog("Backup every month on day " +
        // UnitValue ) LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)

        // LastYearArchive = 0 LastMonthArchive = 0 LastDayArchive = 0 LastMinuteArchive = 0

        // TS = Now.Subtract(LastSuccessFullArchiveDate) Days = TS.Days

        // If LastMonthArchive = 12 And LastSuccessFullArchiveDate.Month = 1 Then LastMonthArchive = 0 End
        // If If Now.Month >= LastSuccessFullArchiveDate.Month Then BackupNow = True End If
        // LOG.WriteToArchiveLog("Backup every month Backup Now is " + BackupNow.ToString) If BackupNow =
        // True And Now.Month = LastSuccessFullArchiveDate.Month Then If CInt(UnitValue ) < TodayDay Then
        // LOG.WriteToArchiveLog("Backup every month Backup Now is NOT due.")
        // ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
        // ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True
        // Return Else BackupNow = True LOG.WriteToArchiveLog("Backup every month Backup Now is DUE.")
        // GoTo DoItNow End If End If If Now.Month > LastSuccessFullArchiveDate.Month Then BackupNow =
        // True Else Return End If ElseIf ArchiveType .Equals("Daily") Then 'lblUnit.Text = "time of day
        // (24 hr) clock" SB.Text = "Backup daily immediately after " + UnitValue + " hours."
        // LOG.WriteToArchiveLog("Backup daily immediately after " + UnitValue )
        // LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)
        // If LastSuccessFullArchiveDate = Nothing Then LOG.WriteToArchiveLog("Backup daily immediately
        // BackupNow = " + BackupNow.ToString) BackupNow = True Else

        // LastYearArchive = LastSuccessFullArchiveDate.Year LastMonthArchive =
        // LastSuccessFullArchiveDate.Month LastDayArchive = LastSuccessFullArchiveDate.Day
        // LastMinuteArchive = LastSuccessFullArchiveDate.Minute

        // 'Dim DayOfWeek = LastSuccessFullArchiveDate.DayOfWeek.ToString

        // 'If DayOfWeek .ToUpper.Equals("SUNDAY") Then

        // 'End If

        // Dim BackupHour As Integer = CInt(UnitValue ) / 100

        // TS = Now.Subtract(LastSuccessFullArchiveDate) Hours = TS.Hours

        // If Hours >= 24 And Val(UnitValue ) >= Now.Hour Then LOG.WriteToArchiveLog("Backup daily
        // immediately BackupNow is TRUE") BackupNow = True Else LOG.WriteToArchiveLog("Backup daily
        // immediately BackupNow is False") BackupNow = False Return End If End If ElseIf ArchiveType
        // .Equals("Hourly") Then 'lblUnit.Text = "minutes past the hour" SB.Text = "Backup hourly
        // immediately " + UnitValue + " minutes after the hour." LOG.WriteToArchiveLog("Backup hourly
        // immediately " + UnitValue + " minutes after the hour.") LastSuccessFullArchiveDate =
        // DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)

        // LastYearArchive = LastSuccessFullArchiveDate.Year LastMonthArchive =
        // LastSuccessFullArchiveDate.Month LastDayArchive = LastSuccessFullArchiveDate.Day
        // LastMinuteArchive = LastSuccessFullArchiveDate.Minute

        // TS = Now.Subtract(LastSuccessFullArchiveDate) Hours = TS.Hours

        // If Hours >= 1 Then LOG.WriteToArchiveLog("Backup hourly is TRUE - 1.") BackupNow = True Else
        // ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
        // ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True
        // LOG.WriteToArchiveLog("Backup hourly is NOT TRUE - 2.") Return End If ElseIf ArchiveType
        // .Equals("Minutes") Then 'lblUnit.Text = "minutes" SB.Text = "Backup every " + UnitValue + "
        // minutes." LOG.WriteToArchiveLog("Backup every " + UnitValue + " minutes.")
        // LastSuccessFullArchiveDate = DBARCH.getLastSuccessfulArchiveDate(ArchiveType , gCurrUserGuidID)

        // LastYearArchive = LastSuccessFullArchiveDate.Year LastMonthArchive =
        // LastSuccessFullArchiveDate.Month LastDayArchive = LastSuccessFullArchiveDate.Day
        // LastMinuteArchive = LastSuccessFullArchiveDate.Minute

        // TS = Now.Subtract(LastSuccessFullArchiveDate) Dim Minutes As Integer = TS.Minutes

        // If Minutes >= Val(UnitValue ) Then BackupNow = True Else BackupNow = False End If

        // Else
        // Timer1.Enabled = True
        // ArchiveALLToolStripMenuItem.Enabled = True
        // ContentToolStripMenuItem.Enabled = True
        // ExchangeEmailsToolStripMenuItem.Enabled = True
        // OutlookEmailsToolStripMenuItem.Enabled = True
        // LOG.WriteToArchiveLog("Backup NOW NOT TRUE : 1 ")
        // Return
        // End If
        // DoItNow:

        // LOG.WriteToArchiveLog("Scheduled Archive stared @ " + Now.ToString)

        // '****************************** SetUnattendedFlag() '******************************

        // If BackupNow Then

        // STATS.setArchivestartdate(Now.ToString) STATS.setArchiveenddate(Now.ToString)
        // STATS.setArchivetype(ArchiveType ) STATS.setStatguid(gCurrentArchiveGuid)
        // STATS.setStatus("Running") STATS.setSuccessful("N") STATS.setUserid(gCurrUserGuidID)
        // STATS.setTotalcontentinrepository("0") STATS.setTotalemailsinrepository("0")

        // Me.SB.Text = "Scheduled Archive Starting." SB.Refresh() Application.DoEvents()

        // gbEmail.Enabled = False gbContentMgt.Enabled = False

        // '*****************************************************
        // ArchiveALLToolStripMenuItem_Click(Nothing, Nothing) '*****************************************************

        // gbEmail.Enabled = True gbContentMgt.Enabled = True

        // Cursor = Cursors.Default

        // ALR.ProcessAutoReferences()

        // Cursor = Cursors.Default

        // '********************************************* '** WDM DBARCH.UpdateAttachmentCounts() '*********************************************

        // TimerEndRun.Enabled = True

        // Cursor = Cursors.Default End If

        // ArchiveALLToolStripMenuItem.Enabled = True ContentToolStripMenuItem.Enabled = True
        // ExchangeEmailsToolStripMenuItem.Enabled = True OutlookEmailsToolStripMenuItem.Enabled = True

        // LOG.WriteToArchiveLog("Scheduled Archive ended @ " + Now.ToString) Timer1.Enabled = True

        // SB.Text = "AUTO Archive complete" SB2.Text = "AUTO Archive complete"

        // End Sub

        private void btnDeleteEmailEntry_Click(object sender, EventArgs e)
        {
            ParentFolder = cbParentFolders.Text;
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ParentFolder.Trim().Length == 0)
            {
                MessageBox.Show("Please select a Parent Folder to process.");
                return;
            }

            string msg = "This will remove the selected mail folder from the archive process, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Remove Email Folder", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            Cursor = Cursors.AppStarting;
            foreach (string S in lbActiveFolder.SelectedItems)
            {
                try
                {
                    string FolderName = ParentFolder + "|" + S.ToString();
                    Debug.Print(FolderName);
                    var aParms = new string[1];

                    // PARMS.EmailFolderName  = FolderName
                    EMPARMS.setFoldername(ref FolderName);
                    EMPARMS.setUserid(ref modGlobals.gCurrUserGuidID);

                    // ** Remove it from the parameter table.
                    string WhereClause = "Where [UserID] = '" + modGlobals.gCurrUserGuidID + "' and [FolderName] = '" + FolderName + "'";
                    EMPARMS.Delete(WhereClause);

                    // ** Reset the archive flag.
                    string WC = "where FolderName = '" + FolderName + "' and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    // DBARCH.UpdateArchiveFlag(ParentFolder, gCurrUserGuidID, "N", S.ToString)
                    DBARCH.DeleteEmailArchiveFolder(ParentFolder, modGlobals.gCurrUserGuidID, "N", FolderName);
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                }
            }

            var argLB = lbActiveFolder;
            DBARCH.GetActiveEmailFolders(ParentFolder, ref argLB, modGlobals.gCurrUserGuidID, modGlobals.CF, ArchivedEmailFolders);
            lbActiveFolder = argLB;
            DBARCH.setActiveEmailFolders(ParentFolder, modGlobals.gCurrUserGuidID);
            DBARCH.CleanUpEmailFolders();
            Cursor = Cursors.Default;
        }

        public void AddFileAttributes()
        {
            InsertAttrib("FILESIZE", "Byte length of a file", "INT");
            InsertAttrib("FILENAME", "The name of a file", "varchar");
            InsertAttrib("FQN", "The fully qualified name of a file", "varchar");
            InsertAttrib("ChangeDate", "The last date the file was updated", "datetime");
            InsertAttrib("CreateDate", "The CREATION date the file was updated", "datetime");
            InsertAttrib("WriteDate", "The last time the file was written to", "datetime");
        }

        public void InsertAttrib(string aName, string aDesc, string aType)
        {
            ATTRIB.setAttributename(ref aName);
            ATTRIB.setAttributedesc(ref aDesc);
            ATTRIB.setAttributedatatype(ref aType);
            ATTRIB.Insert();
        }

        public void InsertSrcAttrib(string SGUID, string aName, string aVal, string OriginalFileType)
        {
            SRCATTR.setSourceguid(ref SGUID);
            SRCATTR.setAttributename(ref aName);
            SRCATTR.setAttributevalue(ref aVal);
            SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
            SRCATTR.setSourcetypecode(ref OriginalFileType);
            SRCATTR.Insert();
        }

        public void UpdateSrcAttrib(string SGUID, string aName, string aVal, string SourceType)
        {
            int iCnt = SRCATTR.cnt_PK35(aName, modGlobals.gCurrUserGuidID, SGUID);
            if (iCnt == 0)
            {
                SRCATTR.setSourceguid(ref SGUID);
                SRCATTR.setAttributename(ref aName);
                SRCATTR.setAttributevalue(ref aVal);
                SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                SRCATTR.setSourcetypecode(ref SourceType);
                SRCATTR.Insert();
            }
            else
            {
                string WC = SRCATTR.wc_PK35(aName, modGlobals.gCurrUserGuidID, SGUID);
                SRCATTR.setSourceguid(ref SGUID);
                SRCATTR.setAttributename(ref aName);
                SRCATTR.setAttributevalue(ref aVal);
                SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                SRCATTR.setSourcetypecode(ref SourceType);
                SRCATTR.Update(WC);
            }
        }

        public void GetWordDocMetadata(string FQN, string SourceGUID, string OriginalFileType)
        {
            try
            {
                string TempDir = Path.GetTempPath();
                string fName = DMA.getFileName(FQN);
                string NewFqn = TempDir + fName;
                File.Copy(FQN, NewFqn, true);
                var WDOC = new clsMsWord();
                WDOC.initWordDocMetaData(NewFqn, SourceGUID, OriginalFileType);
                ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|");
            }
            // File.Delete(NewFqn )
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                DBARCH.xTrace(3655, "GetWordDocMetadata", ex.Message.ToString());
                LOG.WriteToArchiveLog("GetWordDocMetadata: Failed to process word metadata: GetWordDocMetadata - " + Constants.vbCrLf + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        public void GetExcelMetaData(string FQN, string SourceGUID, string OriginalFileType)
        {
            string TempDir = Path.GetTempPath();
            string fName = DMA.getFileName(FQN);
            string NewFqn = TempDir + fName;
            try
            {
                try
                {
                    File.Copy(FQN, NewFqn, true);
                    var WDOC = new clsMsWord();
                    WDOC.initExcelMetaData(NewFqn, SourceGUID, OriginalFileType);
                    WDOC = null;
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    DBARCH.xTrace(340123, "GetExcelMetaData", "Failed to open XL work book: " + FQN + " : " + ex.Message.ToString());
                    LOG.WriteToArchiveLog("Failed to open XL work book: GetExcelMetaData" + ex.Message);
                    var st = new StackTrace(true);
                    st = new StackTrace(ex, true);
                    LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                }
                finally
                {
                    ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|");
                    // File.Delete(NewFqn )
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE: GetExcelMetaData" + ex.Message);
            }
        }

        public bool InclAddList(ListBox LB, string UserGuid, string PassedFQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            for (int i = 0, loopTo = LB.Items.Count - 1; i <= loopTo; i++)
            {
                INL.setExtcode(LB.Items[i].ToString());
                INL.setFqn(PassedFQN);
                INL.setUserid(UserGuid);
                INL.Insert();
            }

            return true;
        }

        public bool ExcludeAddList(ListBox LB, string UserGuid, string PassedFQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            for (int i = 0, loopTo = LB.Items.Count - 1; i <= loopTo; i++)
            {
                EXL.setExtcode(LB.Items[i].ToString());
                EXL.setFqn(PassedFQN);
                EXL.setUserid(UserGuid);
                Debug.Print(LB.Items[i].ToString() + " : " + PassedFQN);
                EXL.Insert();
            }

            return true;
        }

        public bool ExlAddList(ListBox LB, string PassedFQN, string typeCode, bool InclSubDirs)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // For i As Integer = 0 To LB.Items.Count - 1
            // EXL.setExtcode(LB.Items(i).ToString)
            // EXL.setFqn(PassedFQN)
            // EXL.setUserid(gCurrUserGuidID)
            // EXL.Insert()
            // Next

            var lDirs = new List<string>();
            bool B = false;
            lDirs.Clear();
            lDirs.Add(PassedFQN);
            if (InclSubDirs)
            {
                addSubDirs(PassedFQN, ref lDirs);
            }

            // UserID = gCurrUserGuidID
            // FQN = PassedFQN
            // FQN = UTIL.RemoveSingleQuotes(FQN)
            // ExtCode = typeCode

            for (int i = 0, loopTo = lDirs.Count - 1; i <= loopTo; i++)
            {
                PassedFQN = lDirs[i].ToString();
                PassedFQN = UTIL.RemoveSingleQuotes(PassedFQN);
                EXL.setExtcode(typeCode);
                EXL.setFqn(PassedFQN);
                EXL.setUserid(modGlobals.gCurrUserGuidID);
                string WC = "where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + PassedFQN + "' and Extcode = '" + typeCode + "' ";
                int II = DBARCH.iGetRowCount("ExcludedFiles", WC);
                if (II == 0)
                {
                    B = EXL.Insert();
                }

                SB.Text = "Processing subdir #" + i.ToString() + " : " + PassedFQN;
                Application.DoEvents();
            }
            // LB.Items.Add(typeCode)
            return B;
            return true;
        }

        public void GetAllSubDirs(List<string> lDirs, string PassedFQN)
        {
            lDirs.Clear();
            lDirs.Add(PassedFQN);
            addSubDirs(PassedFQN, ref lDirs);
        }

        public bool AddList(ListBox LB, string PassedFQN, string typeCode, bool InclSubDirs)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var lDirs = new List<string>();
            bool B = false;
            lDirs.Clear();
            lDirs.Add(PassedFQN);
            if (InclSubDirs)
            {
                addSubDirs(PassedFQN, ref lDirs);
            }

            // UserID = gCurrUserGuidID
            // FQN = PassedFQN
            // FQN = UTIL.RemoveSingleQuotes(FQN)
            // ExtCode = typeCode

            for (int i = 0, loopTo = lDirs.Count - 1; i <= loopTo; i++)
            {
                PassedFQN = lDirs[i].ToString();
                PassedFQN = UTIL.RemoveSingleQuotes(PassedFQN);
                INL.setExtcode(typeCode);
                INL.setFqn(PassedFQN);
                INL.setUserid(modGlobals.gCurrUserGuidID);
                string WC = "where UserID = '" + modGlobals.gCurrUserGuidID + "' and FQN = '" + PassedFQN + "' and Extcode = '" + typeCode + "' ";
                int II = DBARCH.iGetRowCount("IncludedFiles", WC);
                if (II == 0)
                {
                    B = INL.Insert();
                }

                SB.Text = "Processing subdir #" + i.ToString() + " : " + PassedFQN;
                Application.DoEvents();
            }
            // LB.Items.Add(typeCode)
            return B;
        }

        // Sub ArchiveEmails()
        // ARCH.ArchiveAllEmail()
        // SB2.Text = "Email Complete"
        // End Sub
        public void saveStartUpParms()
        {
            if (!formloaded)
            {
                return;
            }

            if (modGlobals.gCurrUserGuidID.Length == 0)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string NewVal = "";
            formloaded = false;
            bool B = false;

            // Dim ArchiveType  = Me.cbInterval.Text
            // RPARM.setUserid(gCurrUserGuidID)
            // RPARM.setParm("ArchiveType")
            // RPARM.setParmvalue(ArchiveType)
            // B = DBARCH.ckReconParmExists(gCurrUserGuidID, "ArchiveType")
            // If Not B Then
            // RPARM.Insert()
            // Else
            // RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveType'")
            // End If

            NewVal = "";
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval = "ArchiveInterval";
            RPARM.setParm(ref argval);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "ArchiveInterval");
            if (!B)
            {
                RPARM.Insert();
                // Else
                // RPARM.Update("where userid = '" + gCurrUserGuidID + "' and Parm = 'ArchiveInterval'")
            }

            if (modGlobals.gCurrUserGuidID.Length == 0)
            {
                return;
            }

            NewVal = ckDisable.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval1 = "Disabled";
            RPARM.setParm(ref argval1);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "Disabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'Disabled'");
            }

            if (modGlobals.gCurrUserGuidID.Length == 0)
            {
                return;
            }

            NewVal = ckDisableContentArchive.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval2 = "ContentDisabled";
            RPARM.setParm(ref argval2);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "ContentDisabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'ContentDisabled'");
            }

            NewVal = ckDisableOutlookEmailArchive.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval3 = "OutlookDisabled";
            RPARM.setParm(ref argval3);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "OutlookDisabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'OutlookDisabled'");
            }

            NewVal = ckDisableExchange.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval4 = "ExchangeDisabled";
            RPARM.setParm(ref argval4);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "ExchangeDisabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'ExchangeDisabled'");
            }

            NewVal = ckRssPullDisabled.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval5 = "RssPullDisabled";
            RPARM.setParm(ref argval5);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "RssPullDisabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'RssPullDisabled'");
            }

            NewVal = ckWebPageTrackerDisabled.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval6 = "WebPageTrackerDisabled";
            RPARM.setParm(ref argval6);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "WebPageTrackerDisabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'WebPageTrackerDisabled'");
            }

            NewVal = ckWebSiteTrackerDisabled.Checked.ToString();
            RPARM.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval7 = "WebSiteTrackerDisabled";
            RPARM.setParm(ref argval7);
            RPARM.setParmvalue(ref NewVal);
            B = DBARCH.ckReconParmExists(modGlobals.gCurrUserGuidID, "WebSiteTrackerDisabled");
            if (!B)
            {
                RPARM.Insert();
            }
            else
            {
                RPARM.Update("where userid = '" + modGlobals.gCurrUserGuidID + "' and Parm = 'WebSiteTrackerDisabled'");
            }

            formloaded = true;
            SB.Text = "Startup parms saved...";
        }

        private void btnSaveSchedule_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            saveStartUpParms();
        }

        // Private Sub cbInterval_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        // Dim Interval  = cbInterval.Text
        // cbTimeUnit.Items.Clear()

        // If Interval.Equals("Monthly") Then
        // lblUnit.Text = "day of the month"
        // For ii As Integer = 1 To 31
        // cbTimeUnit.Items.Add(ii)
        // Next
        // cbTimeUnit.Text = "1"
        // End If
        // If Interval.Equals("Daily") Then
        // lblUnit.Text = "time of day (24 hr) clock"
        // For ii As Integer = 1 To 24
        // Dim C  = ii.ToString
        // If C.Trim.Length = 1 Then
        // C = "0" + C + "00"
        // End If
        // If C.Trim.Length = 2 Then
        // C = C + "00"
        // End If
        // cbTimeUnit.Items.Add(C)
        // 'For III As Integer = 1 To 3
        // '    If III = 1 Then
        // '        C = Mid(C, 1, 2) + "15"
        // '    End If
        // '    If III = 2 Then
        // '        C = Mid(C, 1, 2) + "30"
        // '    End If
        // '    If III = 2 Then
        // '        C = Mid(C, 1, 2) + "45"
        // '    End If
        // '    cbTimeUnit.Items.Add(C)
        // '    If ii = 1 Then
        // '        cbTimeUnit.Text = "0030"
        // '    End If
        // 'Next
        // Next
        // End If
        // If Interval.Equals("Hourly") Then
        // lblUnit.Text = "minutes past the hour"
        // For ii As Integer = 0 To 59
        // cbTimeUnit.Items.Add(ii)
        // Next
        // cbTimeUnit.Text = "15"
        // End If
        // If Interval.Equals("Minutes") Then
        // lblUnit.Text = "minutes"
        // For ii As Integer = 1 To 45
        // cbTimeUnit.Items.Add(ii)
        // Next
        // cbTimeUnit.Text = "30"
        // End If
        // End Sub

        private void cbTimeUnit_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void gbPolling_MouseHover(object sender, EventArgs e)
        {
            SB.Text = "Use these parameters to set up the archive execution.";
        }

        private void ckSubDirs_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void ckPublic_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void btnExclude_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                // If txtDir.Text.Trim.Length = 0 Then
                // messagebox.show("You have failed to select a file ARCHIVE DIRECTORY, pick one and only one, returning.")
                // Return
                // End If
                string S1 = lbAvailExts.SelectedItem.ToString();
                foreach (string S in lbAvailExts.SelectedItems)
                {
                    bool ItemAlreadyExists = false;
                    for (int I = 0, loopTo = lbExcludeExts.Items.Count - 1; I <= loopTo; I++)
                    {
                        string ExistingItem = Conversions.ToString(lbExcludeExts.Items[I]);
                        if (S.ToUpper().Equals(ExistingItem.ToUpper()))
                        {
                            ItemAlreadyExists = true;
                            break;
                        }
                    }

                    if (ItemAlreadyExists == false)
                    {
                        lbExcludeExts.Items.Add(S);
                        btnSaveChanges.BackColor = Color.OrangeRed;
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR btnInclFileType_Click : " + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                SB.Text = "Error - please refer to error log.";
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void btnRemoveExclude_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            SB.Text = "Profile maintenance selected, will not affect directory setup.";
            for (int i = lbExcludeExts.SelectedItems.Count; i >= 0; i -= 1)
            {
                int II = lbExcludeExts.SelectedIndex;
                if (II >= 0)
                {
                    lbExcludeExts.Items.RemoveAt(II);
                }
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        public bool FolderExists(string FolderName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string TgtFolder = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
            bool B = false;
            var OlApp = Interaction.CreateObject("Outlook.Application");
            var NmSpace = OlApp.GetNamespace("MAPI");
            var Mailbox = NmSpace.Folders("Mailbox - eBay Bidder"); // Set mailbox to eBay Bidder
            var Inbox = Mailbox.Folders("Inbox"); // olFolderInbox
            var MySubFolder = Inbox.Folders("eBay"); // Note Case Sensitive!
            var MySubFolder2 = MySubFolder.Folders("Auctions");
            var MySubFolder3 = MySubFolder2.Folders("Auctions WON");
            for (int I = 1, loopTo = Conversions.ToInteger(MySubFolder3.Folders.Count); I <= loopTo; I++)
            {
                if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(MySubFolder3.Folders(I), FolderName, false)))
                {
                    B = true;
                    break;
                }
                else
                {
                    B = false;
                }
            }

            return B;
        }

        private void lbExcludeExts_TextChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S1 = "";
            var SA = new SortedList<string, string>();
            for (int K = 0, loopTo = lbIncludeExts.Items.Count - 1; K <= loopTo; K++)
            {
                S1 = lbIncludeExts.SelectedItem.ToString().ToLower();
                if (SA.IndexOfKey(S1) < 0)
                {
                    SA.Add(S1, S1);
                }
            }

            S1 = lbIncludeExts.SelectedItem.ToString();
            DMA.FixFileExtension(ref S1);
            bool B = true;
            for (int i = lbExcludeExts.Items.Count - 1; i >= 0; i -= 1)
            {
                S1 = lbExcludeExts.Items[i].ToString();
                if (SA.IndexOfKey(S1) > 0)
                {
                    lbExcludeExts.Items.RemoveAt(i);
                }
            }
        }

        private void txtDir_TextChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (Strings.InStr(txtDir.Text, "%userid%", CompareMethod.Text) > 0)
            {
                clAdminDir.Checked = true;
            }
        }

        private void ckUseLastProcessDateAsCutoff_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBARCH.UserParmInsertUpdate("ckUseLastProcessDateAsCutoff", modGlobals.gCurrUserGuidID, Conversions.ToString(ckUseLastProcessDateAsCutoff.Checked));
        }

        private void frmReconMain_Resize(object sender, EventArgs e)
        {
            if (formloaded == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Form argfrm = this;
            modResizeForm.ResizeControls(ref argfrm);
        }

        public void resetBadDates()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "Update Email set CreationDate = getdate() where CreationDate is NULL ;";
            bool B = DBARCH.ExecuteSqlNewConn(90315, S);
            S = "update Email set SentOn = CreationDate where SentOn > '1/1/4500' and UserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = DBARCH.ExecuteSqlNewConn(90316, S);
            if (!B)
            {
                LOG.WriteToArchiveLog("Warning : Check email senton dates as some were found to be invalid in the emails.");
            }
        }

        public void GetExchangeFolders(bool bNewThread)
        {
            if (DBARCH.isArchiveDisabled("EXCHANGE") == true)
            {
                return;
            }

            var EM = new clsEmailFunctions();
            if (modGlobals.gCurrentArchiveGuid.Length == 0)
            {
                modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
            }

            LOG.WriteToArchiveLog("GetExchangeFolders 100");
            // FrmMDIMain.SB.Text = "Archiving Exchange Folders - you can continue to work."

            if (bNewThread)
            {
                // SB.Text = "Launching Exchange Archive - it will run in background."
                if (ddebug)
                {
                    LOG.WriteToTraceLog("Entering LaunchExchangeDownload from frmMain");
                }

                EM.LaunchExchangeDownload();
            }
            else
            {
                // SB.Text = "Launching Exchange Archive"
                if (ddebug)
                {
                    LOG.WriteToTraceLog("Entering ProcessExchangePopMail from frmMain");
                }
                // FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
                modGlobals.gCurrUserGuidID = UIDcurr;
                EM.ProcessExchangeServers(UIDcurr);
                // FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
                // SB.Text = "Exchange archive complete."
            }

            if (modGlobals.gTerminateImmediately)
            {
                // Me.Cursor = Cursors.Default
                SB.Text = "Terminated archive!";
                return;
            }

            EM = null;
            GC.Collect();
            GC.WaitForFullGCComplete();
        }

        private void btnInclProfile_Click(object sender, EventArgs e)
        {
            string pName = cbProfile.Text;
            if (pName.Trim().Length == 0)
            {
                MessageBox.Show("Please select a profile.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            pName = UTIL.RemoveSingleQuotes(pName);
            string S = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = '" + pName + "' order by SourceTypeCode";
            var argLB = lbIncludeExts;
            DBARCH.PopulateListBoxMerge(ref argLB, "SourceTypeCode", S);
            lbIncludeExts = argLB;
            var argLB1 = lbExcludeExts;
            DBARCH.PopulateListBoxRemove(ref argLB1, "SourceTypeCode", S);
            lbExcludeExts = argLB1;
            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void btnExclProfile_Click(object sender, EventArgs e)
        {
            string pName = cbProfile.Text;
            if (pName.Trim().Length == 0)
            {
                MessageBox.Show("Please select a profile.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            pName = UTIL.RemoveSingleQuotes(pName);
            string S = "Select [SourceTypeCode], [ProfileName] FROM [LoadProfileItem] where ProfileName = '" + pName + "' order by SourceTypeCode";
            var argLB = lbExcludeExts;
            DBARCH.PopulateListBoxMerge(ref argLB, "SourceTypeCode", S);
            lbExcludeExts = argLB;
            var argLB1 = lbIncludeExts;
            DBARCH.PopulateListBoxRemove(ref argLB1, "SourceTypeCode", S);
            lbIncludeExts = argLB1;
            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        public void SetArchiveEndStats(string ArchiveType)
        {
            STATS.setArchiveenddate(ref DateAndTime.Now.ToString());
            STATS.setArchivetype(ref ArchiveType);
            string argval = "Successful";
            STATS.setStatus(ref argval);
            string argval1 = "Y";
            STATS.setSuccessful(ref argval1);
            STATS.setUserid(ref modGlobals.gCurrUserGuidID);
            int iCnt = 0;
            iCnt = DBARCH.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'");
            LOG.WriteToArchiveLog("Archive Count: Source Files - " + iCnt.ToString());
            STATS.setTotalcontentinrepository(ref iCnt.ToString());
            iCnt = DBARCH.iGetRowCount("Email", "where UserID = '" + modGlobals.gCurrUserGuidID + "'");
            LOG.WriteToArchiveLog("Archive Count: Emails - " + iCnt.ToString());
            STATS.setTotalemailsinrepository(ref iCnt.ToString());
            iCnt = STATS.cnt_PK_ArchiveStats(modGlobals.gCurrentArchiveGuid);
            if (iCnt == 0)
            {
                bool BB = STATS.Insert();
                if (!BB)
                {
                    LOG.WriteToArchiveLog("error 2345.01.1 - DID NOT INSERT STATS.");
                }
            }

            if (iCnt > 0)
            {
                string WC = STATS.wc_PK_ArchiveStats(modGlobals.gCurrentArchiveGuid);
                bool b = STATS.Update(WC);
                if (!b)
                {
                    LOG.WriteToArchiveLog("Failed to update archive statistics: " + DateAndTime.Now.ToString());
                }
            }
        }

        public void SetArchiveBeginStats(string ArchiveType, string NewGuid)
        {
            STATS.setArchivestartdate(ref DateAndTime.Now.ToString());
            STATS.setArchiveenddate(ref DateAndTime.Now.ToString());
            STATS.setArchivetype(ref ArchiveType);
            STATS.setStatguid(ref NewGuid);
            string argval = "Running";
            STATS.setStatus(ref argval);
            string argval1 = "N";
            STATS.setSuccessful(ref argval1);
            STATS.setUserid(ref modGlobals.gCurrUserGuidID);
            string argval2 = "0";
            STATS.setTotalcontentinrepository(ref argval2);
            string argval3 = "0";
            STATS.setTotalemailsinrepository(ref argval3);
            int iCnt = 0;
            iCnt = DBARCH.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'");
            STATS.setTotalcontentinrepository(ref iCnt.ToString());
            iCnt = DBARCH.iGetRowCount("Email", "where UserID = '" + modGlobals.gCurrUserGuidID + "'");
            STATS.setTotalemailsinrepository(ref iCnt.ToString());
            iCnt = STATS.cnt_PK_ArchiveStats(NewGuid);
            if (iCnt == 0)
            {
                bool BB = STATS.Insert();
                if (!BB)
                {
                    SB.Text = "error 2345.01.1a - DID NOT INSERT STATS.";
                    LOG.WriteToArchiveLog("error 2345.01.1a - DID NOT INSERT STATS.");
                }
            }

            if (iCnt > 0)
            {
                string WC = STATS.wc_PK_ArchiveStats(NewGuid);
                bool b = STATS.Update(WC);
                if (!b)
                {
                    SB.Text = "error 2345.01.1b - DID NOT INSERT STATS.";
                    LOG.WriteToArchiveLog("error 2345.01.1b - DID NOT INSERT STATS.");
                }
            }
        }

        private void cbParentFolders_SelectedIndexChanged(object sender, EventArgs e)
        {
            ParentFolder = cbParentFolders.Text.Trim();
            btnRefreshFolders_Click(null, null);
        }

        private void ResetSelectedMailBoxesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "This will remove all of your mailbox selections" + Constants.vbCrLf + "it will not remove any archives. Are you sure?";
            var dlgRes = MessageBox.Show(msg, "Reset Email Folders", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            S = "DELETE FROM [EmailArchParms] ";
            S = S + " WHERE UseriD = '" + modGlobals.gCurrUserGuidID + "'";
            bool B = DBARCH.ExecuteSqlNewConn(S, false);
            if (B)
            {
                S = "DELETE FROM [EmailFolder] ";
                S = S + " WHERE UseriD = '" + modGlobals.gCurrUserGuidID + "'";
                B = DBARCH.ExecuteSqlNewConn(S, false);
                if (B)
                {
                    SB.Text = "Mailboxes successfully reset";
                }
                else
                {
                    SB.Text = "Mailboxes DID NOT reset";
                }
            }
            else
            {
                SB.Text = "Mailboxes DID NOT reset";
            }

            if (DateAndTime.Now < DateTime.Parse("2009-10-05"))
            {
                string TgtFolder = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
                string SS = "update Email set originalfolder = '" + TgtFolder + "' + '|' + originalfolder where originalfolder not like '%|%' ";
                DBARCH.ExecuteSqlNewConn(90317, SS);
            }
        }

        private void ContextMenuStrip1_Opening(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void EmailLibraryReassignmentToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Me.lbArchiveDirs.SelectedItem.ToString
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FolderName = lbActiveFolder.SelectedItem.ToString();
            FolderName = cbParentFolders.Text.Trim() + "|" + FolderName;
            FolderName = UTIL.RemoveSingleQuotes(FolderName);

            // frmLibraryAssignment.MdiParent = 'FrmMDIMain
            My.MyProject.Forms.frmLibraryAssignment.setFolderName(FolderName);
            My.MyProject.Forms.frmLibraryAssignment.SetTypeContent(false);
            My.MyProject.Forms.frmLibraryAssignment.Show();
        }

        private void cbFileDB_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void Label8_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void lbAvailExts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (lbAvailExts.SelectedItems.Count > 0)
            {
                btnInclFileType.Visible = true;
                btnExclude.Visible = true;
            }
            else
            {
                btnInclFileType.Visible = false;
                btnExclude.Visible = false;
            }
        }

        private void ckTerminate_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckTerminate.Checked == true)
            {
                modGlobals.gTerminateImmediately = true;
            }
            else
            {
                modGlobals.gTerminateImmediately = false;
            }
        }

        private void btnSaveDirProfile_Click(object sender, EventArgs e)
        {
            string DirProfileName = cbDirProfile.Text.Trim();
            if (DirProfileName.Length == 0)
            {
                MessageBox.Show("A directory profile name must be supplied, returning.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName);
            string Parms = buildDirProfileParms();
            string S = "Select count(*) from DirProfiles where ProfileName = '" + DirProfileName + "'";
            int iCnt = DBARCH.iCount(S);
            if (iCnt == 0)
            {
                S = "";
                S = S + " INSERT INTO [DirProfiles]";
                S = S + " ([ProfileName]";
                S = S + " ,[Parms])";
                S = S + "  VALUES ";
                S = S + " ('" + DirProfileName + "'";
                S = S + " ,'" + Parms + "')";
                bool B = DBARCH.ExecuteSqlNewConn(90318, S);
                if (B)
                {
                    SB.Text = "Added the new directory profile, " + DirProfileName;
                    S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
                    var argCB = cbDirProfile;
                    DBARCH.PopulateComboBox(ref argCB, "ProfileName", S);
                    cbDirProfile = argCB;
                    cbDirProfile.Text = DirProfileName;
                }
                else
                {
                    SB.Text = "Failed to add the directory profile, " + DirProfileName + " Please check the error logs.";
                }
            }
            else
            {
                MessageBox.Show("The profile named '" + DirProfileName + "' already exists in the repository, returning.");
                SB.Text = "The profile named '" + DirProfileName + "' already exists in the repository, returning.";
                return;
            }
        }

        private void btnApplyDirProfile_Click(object sender, EventArgs e)
        {
            string DirProfileName = cbDirProfile.Text.Trim();
            if (DirProfileName.Length == 0)
            {
                MessageBox.Show("A directory profile name must be supplied, returning.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bApplyingDirParms = true;
            string Parms = DBARCH.getDirProfile(DirProfileName);
            applyDirProfileParms(Parms);
            bApplyingDirParms = false;
            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void btnUpdateDirectoryProfile_Click(object sender, EventArgs e)
        {
            string DirProfileName = cbDirProfile.Text.Trim();
            if (DirProfileName.Length == 0)
            {
                MessageBox.Show("A directory profile name must be supplied, returning.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string Parms = buildDirProfileParms();
            DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName);
            string S = "Update DirProfiles set Parms = '" + Parms + "' where ProfileName = '" + DirProfileName + "'";
            bool B = DBARCH.ExecuteSqlNewConn(90319, S);
            if (B)
            {
                SB.Text = "Directory Profile: " + DirProfileName + " updated.";
            }
            else
            {
                SB.Text = "Directory Profile: " + DirProfileName + " failed to update.";
            }
        }

        private void btnDeleteDirProfile_Click(object sender, EventArgs e)
        {
            string DirProfileName = cbDirProfile.Text.Trim();
            if (DirProfileName.Length == 0)
            {
                MessageBox.Show("A directory profile name must be supplied, returning.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DirProfileName = UTIL.RemoveSingleQuotes(DirProfileName);
            string S = "delete from DirProfiles where ProfileName = '" + DirProfileName + "'";
            bool B = DBARCH.ExecuteSqlNewConn(90320, S);
            if (B)
            {
                S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
                var argCB = cbDirProfile;
                DBARCH.PopulateComboBox(ref argCB, "ProfileName", S);
                cbDirProfile = argCB;
                SB.Text = DirProfileName + " deleted.";
            }
            else
            {
                SB.Text = DirProfileName + " failed to delete A7.";
            }
        }

        public string buildDirProfileParms()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string Parms = "";
            Parms += "cbRetention" + Conversions.ToString('ý') + cbRetention.Text + Conversions.ToString('þ');
            Parms += "ckSubDirs" + Conversions.ToString('ý') + ckSubDirs.Checked.ToString() + Conversions.ToString('þ');
            Parms += "ckOcr" + Conversions.ToString('ý') + ckOcr.Checked.ToString() + Conversions.ToString('þ');
            Parms += "ckVersionFiles" + Conversions.ToString('ý') + ckVersionFiles.Checked.ToString() + Conversions.ToString('þ');
            Parms += "ckMetaData" + Conversions.ToString('ý') + ckMetaData.Checked.ToString() + Conversions.ToString('þ');
            Parms += "ckPublic" + Conversions.ToString('ý') + ckPublic.Checked.ToString() + Conversions.ToString('þ');
            Parms += "clAdminDir" + Conversions.ToString('ý') + clAdminDir.Checked.ToString() + Conversions.ToString('þ');
            string xFiles = "InclExt" + Conversions.ToString('ý');
            for (int I = 0, loopTo = lbIncludeExts.Items.Count - 1; I <= loopTo; I++)
            {
                try
                {
                    xFiles += lbIncludeExts.Items[I].ToString() + Conversions.ToString('ü');
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("XXX1: " + ex.Message);
                }
            }

            xFiles += Conversions.ToString('þ');
            Parms += xFiles;
            xFiles = "ExclExt" + Conversions.ToString('ý');
            for (int I = 0, loopTo1 = lbExcludeExts.Items.Count - 1; I <= loopTo1; I++)
            {
                try
                {
                    xFiles += lbExcludeExts.Items[I].ToString() + Conversions.ToString('ü');
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                }
            }

            xFiles += Conversions.ToString('þ');
            Parms += xFiles;
            Parms = UTIL.RemoveSingleQuotes(Parms);
            return Parms;
        }

        public void applyDirProfileParms(string Parms)
        {
            var ParmArray = Parms.Split('þ');
            string Parm = "";
            string ParmValue = "";
            for (int i = 0, loopTo = Information.UBound(ParmArray); i <= loopTo; i++)
            {
                string tParm = ParmArray[i];
                var A = tParm.Split('ý');
                if (Information.UBound(A) == 1)
                {
                    Parm = A[0];
                    ParmValue = A[1];
                }
                else
                {
                    goto NextRec;
                }

                if (Parm.Equals("cbRetention"))
                {
                    cbRetention.Text = ParmValue;
                }

                if (Parm.Equals("ckSubDirs"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        ckSubDirs.Checked = true;
                    }
                    else
                    {
                        ckSubDirs.Checked = false;
                    }
                }

                if (Parm.Equals("ckOcr"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        ckOcr.Checked = true;
                    }
                    else
                    {
                        ckOcr.Checked = false;
                    }
                }

                if (Parm.Equals("ckOcrPdf"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        ckOcrPdf.Checked = true;
                    }
                    else
                    {
                        ckOcr.Checked = false;
                    }
                }

                if (Parm.Equals("ckVersionFiles"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        ckVersionFiles.Checked = true;
                    }
                    else
                    {
                        ckVersionFiles.Checked = false;
                    }
                }

                if (Parm.Equals("ckMetaData"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        ckMetaData.Checked = true;
                    }
                    else
                    {
                        ckMetaData.Checked = false;
                    }
                }

                if (Parm.Equals("ckPublic"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        ckPublic.Checked = true;
                    }
                    else
                    {
                        ckPublic.Checked = false;
                    }
                }

                if (Parm.Equals("clAdminDir"))
                {
                    if (ParmValue.ToUpper().Equals("TRUE"))
                    {
                        clAdminDir.Checked = true;
                    }
                    else
                    {
                        clAdminDir.Checked = false;
                    }
                }

                if (Parm.Equals("InclExt"))
                {
                    lbIncludeExts.Items.Clear();
                    var aExt = ParmValue.Split('ü');
                    for (int ii = 0, loopTo1 = Information.UBound(aExt); ii <= loopTo1; ii++)
                    {
                        if (aExt[ii].Trim().Length > 0)
                        {
                            lbIncludeExts.Items.Add(aExt[ii]);
                        }
                    }
                }

                if (Parm.Equals("ExclExt"))
                {
                    lbExcludeExts.Items.Clear();
                    var aExt = ParmValue.Split('ü');
                    for (int ii = 0, loopTo2 = Information.UBound(aExt); ii <= loopTo2; ii++)
                    {
                        if (aExt[ii].Trim().Length > 0)
                        {
                            lbExcludeExts.Items.Add(aExt[ii]);
                        }
                    }
                }

                NextRec:
                ;
            }
        }

        private void lbExcludeExts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (bApplyingDirParms == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void ckArchiveBit_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            S = "Whenever a file is created or changed, the operating system activates the Archive Bit or modified bit. Unless you select to use backup methods that depend on a date and time stamp, ECM Library uses the archive bit to determine whether a file has been backed up, which is an important element of your backup strategy. It is dangerous if other archive methods, processes or tools access an identified directory." + Constants.vbCrLf;
            S = S + "Selecting the following backup methods can affect the archive bit: " + Constants.vbCrLf;
            S = S + "  �  Full - Back up files - Using archive bit (reset archive bit) + vbcrlf";
            S = S + "  �  Differential - Back up changed files since last full - Using archive bit (does not reset archive bit) + vbcrlf";
            S = S + "  �  Incremental - Back up changed files since last full or incremental - Using archive bit (reset archive bit) + vbcrlf";
            S = S + "Whenever a file has been backed up using either the Full - Back up files - Using archive bit (reset archive bit) or Incremental - Changed Files - Reset Archive Bit backup method, Backup Exec turns the archive bit off, indicating to the system that the file has been backed up. If the file is changed again prior to the next full or incremental backup, the bit is turned on again, and Backup Exec will back up the file in the next full or incremental backup. Backups using the Differential - Changed Files backup method include only files that were created or modified since the last full backup. When this type of differential backup is performed, the archive bit is left intact. + vbcrlf + vbcrlf";
            S = S + "This is dangerous in many ways and you agree to accept all the risk of skipping files with the ARCHIVE bit set!";
            modGlobals.gLegalAgree = false;
            My.MyProject.Forms.frmAgreement.txtAgreement.Text = S;
            My.MyProject.Forms.frmAgreement.ShowDialog();
            if (modGlobals.gLegalAgree == false)
            {
                SB.Text = "Terms refused, SKIP if Archive is not enabled.";
                return;
            }

            if (ckArchiveBit.Checked)
            {
                ckArchiveBit.Checked = true;
            }
            else
            {
                ckArchiveBit.Checked = false;
            }

            if (bActiveChange == true)
            {
                return;
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void ckDisableDir_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (!ckDisable.Checked)
            {
                CkMonitor.Checked = false;
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void ckOcr_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void ckVersionFiles_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void ckMetaData_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        private void clAdminDir_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        public void getListeners()
        {
            DirectoryList.Clear();
            string tdir = "";
            string Action = "";
            string DirsToMonitor = System.Configuration.ConfigurationManager.AppSettings["DirsToMonitor"];
            var stream_reader = new StreamReader(DirsToMonitor);
            using (stream_reader)
            {
                line = stream_reader.ReadLine();
                while (line is object)
                {
                    line = line.Trim();
                    if (!line.Substring(0, 1).Equals("#"))
                    {
                        ReadResult = line.Split("|");
                        tdir = Conversions.ToString(ReadResult((object)0).Trim);
                        Action = Conversions.ToString(ReadResult((object)1).Trim.ToUpper);
                        if (!tdir.Substring(1, 1).Equals("#"))
                        {
                            if (!DirectoryList.ContainsKey(tdir))
                            {
                                DirectoryList.Add(tdir, Action);
                            }
                        }
                    }

                    line = stream_reader.ReadLine();
                }

                stream_reader.Close();
                stream_reader.Dispose();
            }
        }

        public void ProcessListener(bool SetAction)
        {
            string DirsToMonitor = System.Configuration.ConfigurationManager.AppSettings["DirsToMonitor"];
            string ProcessSubdirectories = "";
            string TgtDir = "";
            string DirToProcess = "";
            string tdir = "";
            string action = "";
            if (lbArchiveDirs.SelectedItems.Count.Equals(0))
            {
                MessageBox.Show("Please select 1 or more directories before setting a listener, returning...");
                return;
            }

            try
            {
                // Read the file one line at a time.
                getListeners();
                StartOver:
                ;
                ProcessSubdirectories = "";
                for (int i = 0, loopTo = lbArchiveDirs.SelectedItems.Count - 1; i <= loopTo; i++)
                {
                    // ****
                    string DirName = lbArchiveDirs.SelectedItem.ToString().Trim();
                    txtDir.Text = DirName;
                    // DBARCH.LoadAvailFileTypes(lbAvailExts)
                    string DBID = "";
                    string IncludeSubDirs = "";
                    string VersionFiles = "";
                    string FolderDisabled = "";
                    string isMetaData = "";
                    string isPublic = "";
                    string OcrDirectory = "";
                    string OcrPdf = "";
                    string isSysDefault = "";
                    string DeleteOnArchive = "";
                    bool argArchiveSkipBit = ckArchiveBit.Checked;
                    DBARCH.GetDirectoryData(modGlobals.gCurrUserGuidID, DirName, ref DBID, ref IncludeSubDirs, ref VersionFiles, ref FolderDisabled, ref isMetaData, ref isPublic, ref OcrDirectory, ref isSysDefault, ref argArchiveSkipBit, ref ListenForChanges, ref ListenDirectory, ref ListenSubDirectory, ref DirGuid, ref OcrPdf, ref DeleteOnArchive);
                    ckArchiveBit.Checked = argArchiveSkipBit;
                    cbFileDB.Text = DBID;
                    ckSubDirs.Checked = cvtTF(IncludeSubDirs);
                    // ****
                    TgtDir = lbArchiveDirs.SelectedItems[i].ToString().Trim();
                    if (SetAction.Equals(true))
                    {
                        if (ckSubDirs.Checked.Equals(true))
                        {
                            ProcessSubdirectories = "Y";
                        }
                        else
                        {
                            ProcessSubdirectories = "N";
                        }
                        // Add the directory to the list if it does not exist 
                        if (!DirectoryList.ContainsKey(TgtDir))
                        {
                            DirectoryList.Add(TgtDir, ProcessSubdirectories);
                        }
                        else
                        {
                            DirectoryList[TgtDir] = ProcessSubdirectories;
                        }
                    }
                    // DROP THIS FROM THE LIST OF DIRECTORIES TO PROCESS
                    else if (DirectoryList.ContainsKey(TgtDir))
                    {
                        DirectoryList.Remove(TgtDir);
                        goto StartOver;
                    }
                }

                if (File.Exists(DirsToMonitor))
                {
                    File.Delete(DirsToMonitor);
                }

                // Dim stream_reader As New IO.StreamReader(DirsToMonitor)
                using (var xfile = My.MyProject.Computer.FileSystem.OpenTextFileWriter(DirsToMonitor, true))
                {
                    xfile.WriteLine("#DirectoryName | Y or N for include subdirectories or do not include subdirectories");
                    foreach (string dir in DirectoryList.Keys)
                    {
                        DirToProcess = dir + "|" + DirectoryList[dir].ToUpper().Trim();
                        xfile.WriteLine(DirToProcess);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR: Cannot add listener: " + ex.Message);
            }

            getListeners();
            return;
        }

        private void CkMonitor_CheckedChanged(object sender, EventArgs e)
        {
            if (lbArchiveDirs.SelectedItems.Count.Equals(0))
            {
                MessageBox.Show("To use this, one and only one directory must be selected, returning");
                return;
            }

            if (lbArchiveDirs.SelectedItems.Count > 1)
            {
                MessageBox.Show("To use this, one and only one directory must be selected - Please use the Utility Listener item to process multiple listeners, returning");
                return;
            }

            CkMonitor.Checked = false;
            ProcessListener(true);
            MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ");
        }

        private void ckRunUnattended_CheckedChanged(object sender, EventArgs e)
        {
            if (formloaded == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            bool B = false;
            if (ckRunUnattended.Checked)
            {
                My.MyProject.Forms.frmAgreement.txtAgreement.Text = "Running in unattended mode will cause all warnings and errors that HALT the system to be written to a log and NOT shown or displayed. By selecting this option, you agree to accept full responsibility to review this log for errors. ECM Library accepts no responsibility to notify you of errors outside of the log when running in unattended mode.";
                My.MyProject.Forms.frmAgreement.ShowDialog();
                B = modGlobals.gLegalAgree;
                if (B == false)
                {
                    S = "UPDATE [RunParms] SET [ParmValue] = '0' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + modGlobals.gCurrUserGuidID + "' ";
                    B = DBARCH.ExecuteSqlNewConn(90321, S);
                    if (B)
                    {
                        modGlobals.gRunUnattended = false;
                        SB.Text = "Unattended mode disabled.";
                    }
                    else
                    {
                        SB.Text = "FAILED to enable Unattended mode.";
                    }

                    SB.Text = "Terms refused, RUN UNATTENDED is not enabled.";
                    formloaded = false;
                    ckRunUnattended.Checked = false;
                    formloaded = true;
                    return;
                }
            }

            string ckVal = DBARCH.getUserParm("user_RunUnattended");
            if (ckVal.Trim().Length == 0)
            {
                S = "";
                S = S + " INSERT INTO [RunParms]";
                S = S + " ([Parm]";
                S = S + " ,[ParmValue]";
                S = S + " ,[UserID]";
                S = S + " ,[ParmDesc])";
                S = S + " VALUES ";
                S = S + " ('user_RunUnattended'";
                S = S + " ,'0'";
                S = S + " ,'" + modGlobals.gCurrUserGuidID + "'";
                S = S + " ,'A zero turns OFF Unattended Mode, a 1 turns it ON.')";
                B = DBARCH.ExecuteSqlNewConn(S, false);
            }

            if (ckRunUnattended.Checked)
            {
                S = "UPDATE [RunParms] SET [ParmValue] = '1' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + modGlobals.gCurrUserGuidID + "' ";
                B = DBARCH.ExecuteSqlNewConn(90322, S);
                if (B)
                {
                    modGlobals.gRunUnattended = true;
                    SB.Text = "System set to run in unattended mode.";
                }
                // FrmMDIMain.SB4.BackColor = Color.Red
                // FrmMDIMain.SB4.Text = "Unattended ON"
                else
                {
                    modGlobals.gRunUnattended = false;
                }
            }
            else
            {
                S = "UPDATE [RunParms] SET [ParmValue] = '0' WHERE [Parm] = 'user_RunUnattended' and UserID = '" + modGlobals.gCurrUserGuidID + "' ";
                B = DBARCH.ExecuteSqlNewConn(90323, S);
                if (B)
                {
                    modGlobals.gRunUnattended = false;
                    SB.Text = "Unattended mode disabled.";
                }

                // FrmMDIMain.SB4.Text = "Unattended OFF"
                // FrmMDIMain.SB4.BackColor = Color.Silver
                else
                {
                    SB.Text = "FAILED to enable Unattended mode.";
                }

                ckRunUnattended.Checked = false;
            }
        }

        public void SetUnattendedFlag()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            bool B = DBARCH.SysParmExists("srv_RunUnattended");
            if (B == false)
            {
                S = "INSERT INTO SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
                S = S + " values ('srv_RunUnattended','This allows the archive functions to run unattended.','N','Y')";
                B = DBARCH.ExecuteSqlNewConn(90324, S);
                if (B)
                {
                    modGlobals.gRunUnattended = false;
                    SB.Text = "Unattended mode turned off.";
                }
                else
                {
                    SB.Text = "Failed to turned off RUN UNATTENDED mode - no change to current state.";
                }
            }

            string ckVal = DBARCH.getUserParm("user_RunUnattended");
            if (ckVal.Equals("1"))
            {
                modGlobals.gRunUnattended = true;
            }
            else if (ckVal.Equals("0"))
            {
                modGlobals.gRunUnattended = false;
            }
            else if (ckVal.ToUpper().Equals("Y"))
            {
                modGlobals.gRunUnattended = true;
            }
            else if (ckVal.ToUpper().Equals("N"))
            {
                modGlobals.gRunUnattended = false;
            }
            else
            {
                modGlobals.gRunUnattended = false;
            }
        }

        public void SetUnattendedCheckBox()
        {
            formloaded = false;
            string ckVal = DBARCH.getUserParm("user_RunUnattended");
            if (ckVal.Equals("1"))
            {
                modGlobals.gRunUnattended = true;
                ckRunUnattended.Checked = modGlobals.gRunUnattended;
            }
            else if (ckVal.Equals("0"))
            {
                modGlobals.gRunUnattended = false;
                ckRunUnattended.Checked = modGlobals.gRunUnattended;
            }
            else if (ckVal.ToUpper().Equals("Y"))
            {
                modGlobals.gRunUnattended = true;
                ckRunUnattended.Checked = modGlobals.gRunUnattended;
            }
            else if (ckVal.ToUpper().Equals("N"))
            {
                modGlobals.gRunUnattended = false;
                ckRunUnattended.Checked = modGlobals.gRunUnattended;
            }
            else
            {
                modGlobals.gRunUnattended = false;
                ckRunUnattended.Checked = modGlobals.gRunUnattended;
            }

            formloaded = true;
        }

        public void ValidateEntry()
        {
            if (FoldersRefreshed == true)
            {
                return;
            }

            Cursor = Cursors.AppStarting;
            for (int I = 0, loopTo = cbParentFolders.Items.Count - 1; I <= loopTo; I++)
            {
                string Container = cbParentFolders.Items[I].ToString();
                cbParentFolders.Text = Container;
                // ***************************************************
                btnRefreshFolders_Click(null, null);
                // ***************************************************
            }

            FoldersRefreshed = true;
            Cursor = Cursors.Default;
        }

        private void TimerListeners_Tick(object sender, EventArgs e)
        {
            if (ListenersDefined == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool bDoNotRun = false;
            Form frm;
            try
            {
                foreach (Form currentFrm in My.MyProject.Application.OpenForms)
                {
                    frm = currentFrm;
                    Application.DoEvents();
                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify))
                    {
                        bDoNotRun = true;
                        break;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify2))
                    {
                        bDoNotRun = true;
                        break;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmExchangeMonitor))
                    {
                        bDoNotRun = true;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotifyListener))
                    {
                        bDoNotRun = true;
                        break;
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Collection processed.");
            }

            var TempList = new SortedList<string, int>();
            TempList = modGlobals.gFilesToArchive;
            if (modGlobals.gFilesToArchive.Count == 0)
            {
                return;
            }

            try
            {
                foreach (string sKey in TempList.Keys)
                {
                    if (Strings.Mid(sKey, 1, 1).Equals("~"))
                    {
                        Console.WriteLine("Skipping: " + sKey);
                    }
                    else
                    {
                        DBLocal.addListener(sKey);
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                TempList = null;
                LOG.WriteToArchiveLog("WARNING: TICK - 001: " + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                return;
            }

            TempList = null;
            frm = null;
            if (bDoNotRun == true)
            {
                return;
            }

            if (ThreadCnt > 0)
            {
                Text = "ECM Library Archive System         {Threads: " + ThreadCnt.ToString() + "}";
            }
            else
            {
                Text = "ECM Library Archive System         (no active archives)";
            }

            if (ThreadCnt > 50)
            {
                Text = "ECM Library Archive System         {Threads: " + ThreadCnt.ToString() + "}  (MAX Threads)";
                return;
            }

            if (BackgroundDirListener.IsBusy)
            {
                return;
            }

            // TimerListeners.Enabled = False
            try
            {
                BackgroundDirListener.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }

            // TimerListeners.Enabled = True
        }

        private void ckPauseListener_CheckedChanged(object sender, EventArgs e)
        {
            // Dim LISTEN As New clsListener
            if (formloaded == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            };
#error Cannot convert LocalDeclarationStatementSyntax - see comment for details
            /* Cannot convert LocalDeclarationStatementSyntax, System.NotSupportedException: StaticKeyword not supported!
               at ICSharpCode.CodeConverter.CSharp.SyntaxKindExtensions.ConvertToken(SyntaxKind t, TokenContext context)
               at ICSharpCode.CodeConverter.CSharp.CommonConversions.ConvertModifier(SyntaxToken m, TokenContext context)
               at ICSharpCode.CodeConverter.CSharp.CommonConversions.<ConvertModifiersCore>d__43.MoveNext()
               at System.Linq.Enumerable.<ConcatIterator>d__59`1.MoveNext()
               at System.Linq.Enumerable.WhereEnumerableIterator`1.MoveNext()
               at System.Linq.Buffer`1..ctor(IEnumerable`1 source)
               at System.Linq.OrderedEnumerable`1.<GetEnumerator>d__1.MoveNext()
               at Microsoft.CodeAnalysis.SyntaxTokenList.CreateNode(IEnumerable`1 tokens)
               at ICSharpCode.CodeConverter.CSharp.CommonConversions.ConvertModifiers(SyntaxNode node, IReadOnlyCollection`1 modifiers, TokenContext context, Boolean isVariableOrConst, SyntaxKind[] extraCsModifierKinds)
               at ICSharpCode.CodeConverter.CSharp.MethodBodyExecutableStatementVisitor.<VisitLocalDeclarationStatement>d__31.MoveNext()
            --- End of stack trace from previous location where exception was thrown ---
               at ICSharpCode.CodeConverter.CSharp.HoistedNodeStateVisitor.<AddLocalVariablesAsync>d__6.MoveNext()
            --- End of stack trace from previous location where exception was thrown ---
               at ICSharpCode.CodeConverter.CSharp.CommentConvertingMethodBodyVisitor.<DefaultVisitInnerAsync>d__3.MoveNext()

            Input:

                    Static ListenersLoaded As Boolean = False

             */
            if (ckPauseListener.Checked == true)
            {
                LISTEN.PauseListeners(MachineName, true);
                TimerListeners.Enabled = false;
            }
            else
            {
                if (ListenersLoaded == false)
                {
                    ListenersLoaded = true;
                    LISTEN.LoadListeners(MachineName);
                }

                LISTEN.PauseListeners(MachineName, false);
                TimerListeners.Enabled = true;
            }
            // LISTEN = Nothing
        }

        // '** process table DirectoryListenerFiles
        public void ProcessListenerFiles(bool UseThreads)
        {
            var L = new SortedList<string, int>();
            // **********************************************
            // DBARCH.GetListenerFiles(L)
            DBLocal.getListenerFiles(ref L);
            // **********************************************

            LOG.WriteToListenLog("Listener files found = " + L.Count.ToString());
            if (L.Count == 0)
            {
                return;
            }

            // If UseThreads = False Then FrmMDIMain.ListenerStatus.Text = "Listener Active"

            My.MyProject.Forms.frmNotifyListener.Show();
            string DirName = "";
            string DirGuid = "";
            bool Successful = false;
            string fName = "";
            int iFiles = 0;
            int iSkip = 1;
            foreach (var FQN in L.Keys)
            {
                if (modGlobals.gFilesToArchive.ContainsKey(FQN))
                {
                    modGlobals.gFilesToArchive.Remove(FQN);
                }

                if (!File.Exists(FQN))
                {
                    goto SKIPTHISREC;
                }

                iSkip = L[FQN];
                if (iSkip < 0)
                {
                    goto SKIPTHISREC;
                }

                var FI = new FileInfo(FQN);
                DirName = FI.DirectoryName;
                fName = FI.Name;
                FI = null;
                GC.Collect();
                iFiles += 1;
                My.MyProject.Forms.frmNotifyListener.Text = "F:" + iFiles.ToString();
                My.MyProject.Forms.frmNotifyListener.Label1.Text = "Listener Files: " + iFiles.ToString();
                My.MyProject.Forms.frmNotifyListener.Refresh();
                Application.DoEvents();
                int IDX = L.IndexOfKey(FQN);
                DirGuid = DBARCH.getDirGuid(DirName, MachineName);
                DirName = DBARCH.getDirListenerNameByGuid(DirGuid);
                // DirGuid  = DBARCH.getDirGuid(DirName, MachineIDcurr)

                DirGuid = DirGuid.Trim();
                Successful = false;
                LOG.WriteToListenLog("ArchiveSingleFile: archiving " + FQN + " From machine " + MachineName + ".");
                string fExt = DMA.getFileExtension(FQN);
                if (File.Exists(FQN))
                {
                    ARCH.ArchiveSingleFile(UIDcurr, MachineName, DirName, FQN, DirGuid, ref Successful);
                    if (Successful)
                    {
                        DBLocal.MarkListenersProcessed(FQN);
                    }
                }
                else
                {
                    DBLocal.MarkListenersProcessed(FQN);
                    // Dim SX As String = "delete FROM [DirectoryListenerFiles] where SourceFile = '" + FQN + "'  and DirGuid   = '" + DirGuid  + "'"
                    // DBARCH.ExecuteSqlNewConn(SX)
                }

                SKIPTHISREC:
                ;
            }

            DBLocal.DelListenersProcessed();
            TimerListeners.Enabled = true;
            // If UseThreads = False Then FrmMDIMain.ListenerStatus.Text = "."
            ThreadCnt -= 1;
            My.MyProject.Forms.frmNotifyListener.Close();
            My.MyProject.Forms.frmNotifyListener.Dispose();
            L = null;
        }

        private void TimerUploadFiles_Tick(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Form frm;
            try
            {
                foreach (Form currentFrm in My.MyProject.Application.OpenForms)
                {
                    frm = currentFrm;
                    Application.DoEvents();
                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify))
                    {
                        return;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify2))
                    {
                        return;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmExchangeMonitor))
                    {
                        return;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotifyListener))
                    {
                        return;
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine("TimerUploadFiles 11 forms");
            }

            frm = null;
            try
            {
                if (t2 is object)
                {
                    if (t2.IsAlive)
                    {
                        return;
                    }
                }

                if (t3 is object)
                {
                    if (t3.IsAlive)
                    {
                        return;
                    }
                }

                if (t4 is object)
                {
                    if (t4.IsAlive)
                    {
                        return;
                    }
                }

                if (t5 is object)
                {
                    if (t5.IsAlive)
                    {
                        return;
                    }
                }

                int ElapsedSecs = modGlobals.ElapsedTimeSec(modGlobals.gListenerActivityStart, DateAndTime.Now);
                if (ElapsedSecs > 60)
                {
                    string cPath = LOG.getTempEnvironDir();
                    string tFQN = cPath + @"\ListenerFilesLog.ECM";
                    string NewFile = tFQN + ".rdy";
                    if (!File.Exists(tFQN))
                    {
                        modGlobals.gListenerActivityStart = DateAndTime.Now;
                        // TimerUploadFiles.Enabled = False
                        return;
                    }
                    else
                    {
                        modGlobals.gListenerActivityStart = DateAndTime.Now;
                    }

                    LOG.WriteToInstallLog("ACTIVATED the TimerUploadFiles !");
                    TimerUploadFiles.Enabled = false;

                    // **********************************************
                    DBARCH.getModifiedFiles();
                    // **********************************************
                    TimerUploadFiles.Enabled = true;
                    TimerListeners.Enabled = true;
                    if (!File.Exists(NewFile))
                    {
                        ISO.saveIsoFile("FilesToDelete.dat", NewFile + "|");
                        // File.Delete(NewFile)
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90.11 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine("TimerUploadFiles 12 forms");
            }
        }

        private void TimerEndRun_Tick(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Form frm;
            try
            {
                foreach (Form currentFrm in My.MyProject.Application.OpenForms)
                {
                    frm = currentFrm;
                    Application.DoEvents();
                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify))
                    {
                        return;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify2))
                    {
                        return;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmExchangeMonitor))
                    {
                        return;
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine("TimerEndRun_Tick forms");
            }

            frm = null;
            try
            {
                if (t2 is object)
                {
                    if (t2.IsAlive)
                    {
                        return;
                    }
                }

                if (t3 is object)
                {
                    if (t3.IsAlive)
                    {
                        return;
                    }
                }

                if (t4 is object)
                {
                    if (t4.IsAlive)
                    {
                        return;
                    }
                }

                if (t5 is object)
                {
                    if (t5.IsAlive)
                    {
                        return;
                    }
                }

                string ArchiveType = "";
                ArchiveType = DBARCH.getRconParm(modGlobals.gCurrUserGuidID, "ArchiveType");
                STATS.setArchiveenddate(ref DateAndTime.Now.ToString());
                STATS.setArchivetype(ref ArchiveType);
                string argval = "Successful";
                STATS.setStatus(ref argval);
                string argval1 = "Y";
                STATS.setSuccessful(ref argval1);
                STATS.setUserid(ref modGlobals.gCurrUserGuidID);
                int iCnt = 0;
                iCnt = DBARCH.iGetRowCount("DataSource", "where DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'");
                STATS.setTotalcontentinrepository(ref iCnt.ToString());
                iCnt = DBARCH.iGetRowCount("Email", "where UserID = '" + modGlobals.gCurrUserGuidID + "'");
                STATS.setTotalemailsinrepository(ref iCnt.ToString());
                bool BB = STATS.Insert();
                if (!BB)
                {
                    LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.");
                    LOG.WriteToArchiveLog("error TimerEndRun 2345.01.1c - DID NOT INSERT STATS.");
                }

                SetArchiveEndStats(ArchiveType);
                TimerEndRun.Enabled = false;
                if (UseThreads == false)
                {
                    DBARCH.UpdateAttachmentCounts();
                }
                else
                {
                    ThreadCnt += 1;
                    t6 = new Thread(DBARCH.UpdateAttachmentCounts);
                    t6.Priority = ThreadPriority.Lowest;
                    // *******************************************************************
                    t6.Start();
                }

                if (UseThreads == false)
                {
                    // *******************************************************************
                    resetBadDates();
                }
                // *******************************************************************
                else
                {
                    ThreadCnt += 1;
                    t7 = new Thread(resetBadDates);
                    t7.Priority = ThreadPriority.Lowest;
                    // *******************************************************************
                    t7.Start();
                    // *******************************************************************
                }

                SB.Text = "Archive Completed.";
                SB2.Text = "Archive Quiet";
                DBLocal.BackUpSQLite();
                modGlobals.gCurrentArchiveGuid = "";
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 90 - TIMER: " + ex.Message);
                MessageBox.Show("ERROR 90 - TIMER: " + ex.Message);
            }
        }

        private void btnRefreshRetent_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var argCB = cbRetention;
            DBARCH.LoadRetentionCodes(ref argCB);
            cbRetention = argCB;
            var argCB1 = cbEmailRetention;
            DBARCH.LoadRetentionCodes(ref argCB1);
            cbEmailRetention = argCB1;
        }

        private void ckShowLibs_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckShowLibs.Checked)
            {
                My.MyProject.Forms.frmLibraryAssgnList.Show();
            }
            else
            {
                My.MyProject.Forms.frmLibraryAssgnList.Close();
            }
        }

        private void ckOcrPdf_CheckedChanged(object sender, EventArgs e)
        {
            if (bActiveChange == true)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            btnSaveChanges.BackColor = Color.OrangeRed;
        }

        public void SetDateFormats()
        {
            string dateString = "";
            string format = "";
            // Dim result As Date

            System.Globalization.DateTimeFormatInfo Info;
            Info = System.Globalization.CultureInfo.CurrentUICulture.DateTimeFormat;
            string S = "";
            modGlobals.gDateSeparator = Info.DateSeparator;
            modGlobals.gTimeSeparator = Info.TimeSeparator;
            modGlobals.gShortDatePattern = Info.ShortDatePattern;
            modGlobals.gShortTimePattern = Info.ShortTimePattern;
            Console.WriteLine(DateAndTime.Now);
        }

        public bool ckLicense()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            lblCustomerName.Text = modGlobals.gCustomerName;
            lblCustomerID.Text = modGlobals.gCustomerID;
            string LT = null;
            bool bLicenseExists = DBARCH.LicenseExists();
            if (!bLicenseExists)
            {
                MessageBox.Show("There does not appear to be an active license for this installation, please contact an administrator - or install a valid license.");
            }
            else
            {
                // ** Check the expiration date and the service expiration date
                string MachineName = DMA.GetCurrMachineName();
                DBARCH.RegisterMachineToDB(MachineName);
                if (ddebug)
                    LOG.WriteToTraceLog("FrmMDIMain 12");
                LT = DBARCH.GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
                bool isLease = LM.isLease();
                modGlobals.gMaxClients = LM.getMaxClients();
                if (modGlobals.gMaxClients > 0)
                {
                    string SS = "Select count(*) from LoginClient";
                    int EcmClientsDefinedToSystem = DBARCH.iCount(SS);
                    if (EcmClientsDefinedToSystem > modGlobals.gMaxClients)
                    {
                        string MSG = "It appears all ECM Client licenses have been used." + Constants.vbCrLf;
                        MSG += "Please logon from a licensed machine," + Constants.vbCrLf + Constants.vbCrLf;
                        MSG += "or contact ECM Library for additional client licenses." + Constants.vbCrLf + Constants.vbCrLf;
                        MSG += "Thank you, closing down." + Constants.vbCrLf;
                        MessageBox.Show(MSG);
                        Environment.Exit(0);
                    }
                }

                DBARCH.RegisterEcmClient(MachineName);
                modGlobals.gNbrOfSeats = (int)Conversion.Val(LM.ParseLic(LT, "txtNbrSeats"));
                modGlobals.gLicenseType = LM.LicenseType();
                modGlobals.gIsSDK = LM.SdkLicenseExists();
                tssUser.Text = "Seats:" + modGlobals.gNbrOfSeats.ToString();
                modGlobals.gNbrOfUsers = (int)Conversion.Val(LM.ParseLic(LT, "txtNbrSimlSeats"));
                tssServer.Text = "Server: ?";

                // **********************************************************
                int CurrNbrOfUsers = DBARCH.GetNbrUsers();
                int CurrNbrOfMachine = DBARCH.GetNbrMachine();
                // **********************************************************

                if (ddebug)
                    LOG.WriteToTraceLog("FrmMDIMain 13");
                if (CurrNbrOfUsers >= modGlobals.gNbrOfUsers)
                {
                    string Msg = "";
                    Msg = Msg + "FrmMDIMain : MachineName : 1103 : " + Constants.vbCrLf;
                    Msg = Msg + "     Number of licenses warning : '" + MachineName + "'" + Constants.vbCrLf;
                    Msg = Msg + "     We are very sorry, but the maximum number of USERS has been exceeded." + Constants.vbCrLf;
                    Msg = Msg + "     ECM found " + CurrNbrOfUsers.ToString() + " users currently registered in the system." + Constants.vbCrLf;
                    Msg = Msg + "     Your license awards " + modGlobals.gNbrOfUsers.ToString() + " users." + Constants.vbCrLf;
                    Msg = Msg + "You will have to login with an existing User ID and Password." + Constants.vbCrLf + "Please contact admin for support.";
                    LOG.WriteToArchiveLog(Msg);
                    MessageBox.Show(Msg, "CRITICAL Notice", MessageBoxButtons.OK);
                    LoginAsDifferenctUserToolStripMenuItem_Click(null, null);
                }

                if (CurrNbrOfMachine >= modGlobals.gNbrOfSeats)
                {
                    if (ddebug)
                        LOG.WriteToTraceLog("FrmMDIMain 14");
                    string IP = DMA.getIpAddr();
                    modGlobals.gIpAddr = IP;
                    MachineIDcurr = MachineName;
                    DBARCH.updateIp(MachineIDcurr, modGlobals.gIpAddr, 0);
                    DBARCH.updateIp(MachineIDcurr, modGlobals.gIpAddr, 1);
                    if (ddebug)
                        LOG.WriteToTraceLog("FrmMDIMain 15");
                    string Msg = "";
                    Msg = Msg + "FrmMDIMain : Current Users : 1103b : " + Constants.vbCrLf;
                    Msg = Msg + "     Number of current SEATS warning : '" + MachineName + "'" + Constants.vbCrLf;
                    Msg = Msg + "     We are very sorry, but the maximum number of seats (WorkStations) has been exceeded." + Constants.vbCrLf;
                    Msg = Msg + "     ECM found " + CurrNbrOfMachine.ToString() + " machines registered in the system." + Constants.vbCrLf;
                    Msg = Msg + "     Your license awards " + modGlobals.gNbrOfSeats.ToString() + " seats." + Constants.vbCrLf;
                    Msg = Msg + "You will have to login from a WorkStation already defined to ECM." + Constants.vbCrLf + "Please contact admin for support.";
                    LOG.WriteToArchiveLog(Msg);
                    MessageBox.Show(Msg, "CRITICAL Notice", MessageBoxButtons.OK);
                    if (isAdmin)
                    {
                        Msg = "";
                        Msg = Msg + "You are an administrator for ECM Library." + Constants.vbCrLf;
                        Msg = Msg + "If you have a new license, would you like " + Constants.vbCrLf;
                        Msg = Msg + "to open the license management screen and apply a new license.";
                        MessageBox.Show(Msg, "CRITICAL Notice", MessageBoxButtons.OK);
                        var dlgRes = MessageBox.Show(Msg, "License Update", MessageBoxButtons.YesNo);
                        if (dlgRes == DialogResult.Yes)
                        {
                            My.MyProject.Forms.frmLicense.ShowDialog();
                            MessageBox.Show("Restarting the application.");
                            Application.Restart();
                        }
                    }
                }
                else
                {
                    if (ddebug)
                        LOG.WriteToTraceLog("FrmMDIMain 16");
                    int iExists = DBARCH.GetNbrMachine(MachineName);
                    if (iExists == 0)
                    {
                        string MySql = "insert into Machine (MachineName) values ('" + MachineName + "')";
                        bool B = DBARCH.ExecuteSqlNewConn(MySql, false);
                        if (!B)
                        {
                            LOG.WriteToArchiveLog("FrmMDIMain : MachineName : 921 : Failed to register machine : '" + MachineName + "'");
                        }
                    }

                    string IP = DMA.getIpAddr();
                    modGlobals.gIpAddr = IP;
                    MachineIDcurr = MachineName;
                    if (ddebug)
                        LOG.WriteToTraceLog("FrmMDIMain 17");
                    DBARCH.updateIp(MachineIDcurr, modGlobals.gIpAddr, 0);
                    DBARCH.updateIp(MachineIDcurr, modGlobals.gIpAddr, 2);
                    if (ddebug)
                        LOG.WriteToTraceLog("FrmMDIMain 18");
                }

                if (ddebug)
                    LOG.WriteToTraceLog("FrmMDIMain 19");
                if (isLease == true)
                {
                    DateTime ExpirationDate = Conversions.ToDate(LM.ParseLic(LT, "dtExpire"));
                    DateTime dtStartDate = Conversions.ToDate("1/1/2007");
                    TimeSpan tsTimeSpan;
                    int iNumberOfDays;
                    string strMsgText = "";
                    tsTimeSpan = ExpirationDate.Subtract(DateAndTime.Now);
                    iNumberOfDays = tsTimeSpan.Days;
                    if (DateAndTime.Now > ExpirationDate.AddDays(30d))
                    {
                        MessageBox.Show("The ECM run license has expired." + Constants.vbCrLf + Constants.vbCrLf + "Please contact ECM Library support.", "CRITICAL Notice", MessageBoxButtons.OK);
                        Environment.Exit(0);
                    }

                    if (iNumberOfDays <= 7)
                    {
                        infoDaysToExpire.Text = "License! " + iNumberOfDays.ToString();
                        infoDaysToExpire.BackColor = Color.Red;
                    }
                    else if (iNumberOfDays <= 14)
                    {
                        infoDaysToExpire.BackColor = Color.LightSalmon;
                        infoDaysToExpire.Text = "License! " + iNumberOfDays.ToString();
                    }
                    else if (iNumberOfDays <= 30)
                    {
                        infoDaysToExpire.BackColor = Color.Yellow;
                        infoDaysToExpire.Text = "License@ " + iNumberOfDays.ToString();
                    }
                    else if (iNumberOfDays <= 60)
                    {
                        infoDaysToExpire.BackColor = Color.LightSeaGreen;
                        infoDaysToExpire.Text = "License? " + iNumberOfDays.ToString();
                    }
                    else if (iNumberOfDays < 90)
                    {
                        infoDaysToExpire.BackColor = Color.Green;
                        infoDaysToExpire.Text = "License* " + iNumberOfDays.ToString();
                    }
                    else
                    {
                        infoDaysToExpire.Text = " #" + iNumberOfDays.ToString() + " days";
                    }

                    if (DateAndTime.Now > ExpirationDate)
                    {
                        LOG.WriteToArchiveLog("FrmMDIMain : 1001 We are very sorry, but your software LEASE has expired. Please contact ECM Library support.");
                        MessageBox.Show("We are very sorry, but your software license has expired." + Constants.vbCrLf + Constants.vbCrLf + "Please contact ECM Library support.", "CRITICAL Notice", MessageBoxButtons.OK);
                        My.MyProject.Forms.frmLicense.ShowDialog();
                        MessageBox.Show("The application will now end, please restart with the new license.");
                    }
                }

                if (ddebug)
                    LOG.WriteToTraceLog("FrmMDIMain 21");
                DateTime MaintExpire = Conversions.ToDate(LM.ParseLic(LT, "dtMaintExpire"));
                if (DateAndTime.Now > MaintExpire)
                {
                    My.MyProject.Forms.frmNotifyMessage.Show();
                    modGlobals.gNotifyMsg = "We are very sorry to inform you, but your maintenance agreement has expired." + Constants.vbCrLf + Constants.vbCrLf + "Please contact ECM Library support.";
                    LOG.WriteToArchiveLog("FrmMDIMain : 1002 We are very sorry to inform you, but your maintenance agreement has expired.");
                }
                // If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 22")
                // CustomerID = LM.ParseLic(LT , "txtCustID")
                // If ddebug Then LOG.WriteToTraceLog("FrmMDIMain 23")
            }

            return default;
        }

        private void OutlookEmailsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (ckDisable.Checked)
            {
                SB.Text = "DISABLE ALL is checked - no archive allowed.";
                return;
            }

            if (ckDisableOutlookEmailArchive.Checked)
            {
                SB.Text = "DISABLE Outlook is checked - no archive allowed.";
                return;
            }

            if (BackgroundWorker1.IsBusy)
            {
                SB.Text = "Currently archiving, stand by.";
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                BackgroundWorker1.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void ExchangeEmailsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (ckDisable.Checked)
            {
                SB.Text = "DISABLE ALL is checked - no archive allowed.";
                modGlobals.gAutoExecExchangeComplete = true;
                return;
            }

            if (ckDisableExchange.Checked)
            {
                SB.Text = "DISABLE Exchange Archive is checked - no archive allowed.";
                modGlobals.gAutoExecExchangeComplete = true;
                return;
            }

            if (BackgroundWorker2.IsBusy)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                BackgroundWorker2.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void ContentToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var watch = Stopwatch.StartNew();
            bool PerformQUickArchive = true;
            BeginContentArchive(PerformQUickArchive);
            decimal totsecs = 0m;
            totsecs = (decimal)watch.Elapsed.TotalSeconds;
            LOG.WriteToArchiveLog("*** TOTAL TIME FOR QUICK Archive: " + totsecs.ToString() + " Seconds");
        }

        private void ArchiveALLToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckDisable.Checked)
            {
                SB.Text = "DISABLE ALL is checked - no archive allowed.";
                return;
            }

            if (!BackgroundWorker1.IsBusy)
            {
                BackgroundWorker1.RunWorkerAsync();
            }

            if (!BackgroundWorker2.IsBusy)
            {
                BackgroundWorker2.RunWorkerAsync();
            }

            if (!ContentThread.IsBusy)
            {
                ContentThread.RunWorkerAsync();
            }

            if (!BackgroundWorkerContacts.IsBusy)
            {
                BackgroundWorkerContacts.RunWorkerAsync();
            }

            if (!asyncRssPull.IsBusy)
            {
                asyncRssPull.RunWorkerAsync();
            }

            if (!asyncSpiderWebSite.IsBusy)
            {
                asyncSpiderWebSite.RunWorkerAsync();
            }

            if (!asyncSpiderWebPage.IsBusy)
            {
                asyncSpiderWebPage.RunWorkerAsync();
            }
        }

        private void LoginAsDifferenctUserToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            CloseChildWindows();
            LoginAsNewUser = true;
            modGlobals.gCurrLoginID = "";
            LogIntoSystem(modGlobals.gCurrLoginID);
            tssUser.Text = modGlobals.gCurrUserGuidID;
            tssAuth.Text = DBARCH.getAuthority(modGlobals.gCurrUserGuidID);
        }

        public void CloseChildWindows()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            foreach (var form in MdiChildren)
                form.Close();
        }

        public void LogIntoSystem(string OverRideLoginID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int l = 0;
            try
            {
                l = 1;
                foreach (Form f in MdiChildren)
                    f.Close();
                l = 2;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                l = 3;
            }

            l = 4;
            try
            {
                l = 5;
                SB.Text = "Loading, standby";
                l = 6;
                modGlobals.FilesToDelete.Clear();
                l = 7;
                SB.Text = "Ready";
                string SaveName = "UserStartUpParameters";
                string SaveTypeCode = "StartUpParm";
                string CurrentLoginID = "";
                int iAttempts = 1;
                l = 8;
                Retry:
                ;
                if (iAttempts >= 4)
                {
                    MessageBox.Show("Too many failed login attempts, closing down.");
                    Close();
                    Dispose();
                    Environment.Exit(0);
                }

                l = 9;
                string X1 = System.Configuration.ConfigurationManager.AppSettings["LoginByMachineIdAndLoginID"];
                l = 10;
                if (X1.Equals("1") & LoginAsNewUser == false)
                {
                    string LoggedInUser = LOG.getEnvVarUserID();
                    l = 11;
                    if (OverRideLoginID.Length > 0)
                    {
                        LoggedInUser = OverRideLoginID;
                        l = 12;
                    }

                    l = 13;
                    if (LoggedInUser.Length == 0)
                    {
                        LoggedInUser = DMA.GetCurrMachineName();
                        l = 14;
                    }

                    l = 15;
                    modGlobals.gCurrUserGuidID = DBARCH.getUserGuidID(LoggedInUser);
                    l = 16;
                    if (modGlobals.gCurrUserGuidID.Length > 0)
                    {
                        // ** Good login
                        l = 17;
                        goto GoodLogin;
                    }
                    else
                    {
                        l = 18;
                        goto BadAutoLogin;
                    }
                }

                BadAutoLogin:
                ;
                MessageBox.Show("REMOVE THIS: LoginForm1.ShowDialog 1: " + l.ToString());
                My.MyProject.Forms.LoginForm1.ShowDialog();
                if (Environment.UserName.ToString().Length == 0)
                {
                    modGlobals.gCurrUserGuidID = DMA.GetCurrMachineName();
                    My.MyProject.Forms.LoginForm1.txtLoginID.Text = DMA.GetCurrMachineName();
                }
                else
                {
                    My.MyProject.Forms.LoginForm1.txtLoginID.Text = Environment.UserName.ToString();
                }

                CurrentLoginID = My.MyProject.Forms.LoginForm1.UID;
                bool BB = My.MyProject.Forms.LoginForm1.bGoodLogin;
                if (BB & CurrentLoginID.Trim().Length > 0)
                {
                    modGlobals.gCurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID);
                }
                else
                {
                    MessageBox.Show("Incorrect login or password supplied, please try again.");
                    iAttempts += 1;
                    My.MyProject.Forms.LoginForm1.Dispose();
                    goto Retry;
                }

                My.MyProject.Forms.LoginForm1.Dispose();
                GoodLogin:
                ;
                CurrentLoginID = My.MyProject.Forms.LoginForm1.txtLoginID.Text;
                modGlobals.gCurrLoginID = CurrentLoginID;
                modGlobals.gCurrLoginID = CurrentLoginID.ToUpper();
                modGlobals.gCurrUserGuidID = DBARCH.getUserGuidID(modGlobals.gCurrLoginID);
                if (modGlobals.gCurrLoginID.ToUpper().Equals("SERVICEMANAGER"))
                {
                    modGlobals.gIsServiceManager = true;
                    // QuickArchiveToolStripMenuItem.Visible = False
                    CurrentLoginID = modGlobals.gCurrLoginID;
                }
                else
                {
                    modGlobals.gIsServiceManager = false;
                    // QuickArchiveToolStripMenuItem.Visible = True
                }

                if (modGlobals.gCurrUserGuidID.Trim().Length == 0)
                {
                    CurrentLoginID = Environment.UserName.ToString();
                }

                if (modGlobals.gCurrUserGuidID.Trim().Length == 0)
                {
                    modGlobals.gCurrUserGuidID = DBARCH.getUserGuidID(CurrentLoginID);
                }

                string TempDir = Path.GetTempPath();
                SetDefaults();

                // frmQuickSearch.MdiParent = Me
                // frmQuickSearch.Show()
                // frmQuickSearch.WindowState = FormWindowState.Maximized

                int b = DBARCH.ckUserStartUpParameter(modGlobals.gCurrUserGuidID, "CONTENT WORKING DIRECTORY");
                if (b == 0)
                {
                    SI.setSavename(ref SaveName);
                    SI.setSavetypecode(ref SaveTypeCode);
                    SI.setUserid(ref modGlobals.gCurrUserGuidID);
                    string argval = "CONTENT WORKING DIRECTORY";
                    SI.setValname(ref argval);
                    SI.setValvalue(ref TempDir);
                    SI.Insert();
                }

                b = DBARCH.ckUserStartUpParameter(modGlobals.gCurrUserGuidID, "EMAIL WORKING DIRECTORY");
                if (b == 0)
                {
                    SI.setSavename(ref SaveName);
                    SI.setSavetypecode(ref SaveTypeCode);
                    SI.setUserid(ref modGlobals.gCurrUserGuidID);
                    string argval1 = "EMAIL WORKING DIRECTORY";
                    SI.setValname(ref argval1);
                    SI.setValvalue(ref TempDir);
                    SI.Insert();
                }

                SB.Text = "Logged in as " + CurrentLoginID;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("FrmMDIMain : ReLogIntoSystem : 100 : " + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
                MessageBox.Show("LogIntoSystem: Login failed.");
            }

            isAdmin = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
            modGlobals.isGlobalSearcher = DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID);
            if (isAdmin)
            {
                SB.Text = "ADMIN Logged in as: " + DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
            }
            else
            {
                SB.Text = "Logged in as: " + DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
            }

            if (DBARCH.isSuperAdmin(modGlobals.gCurrUserGuidID))
            {
                ImpersonateLoginToolStripMenuItem.Visible = true;
            }
            else
            {
                ImpersonateLoginToolStripMenuItem.Visible = false;
            }
        }

        public void SetDefaults()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBARCH.LoadProcessDates();
            // bFormLoaded = True

            if (ddebug)
                LOG.WriteToTraceLog("FrmMDIMain 25");
            isAdmin = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
            modGlobals.isGlobalSearcher = DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID);
            DBARCH.UserParmInsertUpdate("CurrSearchCriteria", modGlobals.gCurrUserGuidID, " ");
            // 'DBARCH.UserParmInsertUpdate("CurrSearchThesaurus", gCurrUserGuidID, txtThesaurus.Text.Trim)
            DBARCH.UserParmInsertUpdate("ckLimitToExisting", modGlobals.gCurrUserGuidID, "0");
            DBARCH.DeleteMarkedImageCopyFiles();
            modGlobals.TurnHelpOn(0);
            Activate();
            modGlobals.bInitialized = true;
            // DfltData.PopulateLookupTables()

            if (ddebug)
                LOG.WriteToTraceLog("FrmMDIMain 27");

            // DBARCH.UserParmInsert("SoundOn", gCurrUserGuidID, "ON")
            // RMT.getHelpQuiet()
            string SoundOn = DBARCH.UserParmRetrive("SoundOn", modGlobals.gCurrUserGuidID);
            if (Strings.UCase(SoundOn).Equals("ON"))
            {
                modGlobals.gVoiceOn = true;
            }
            else
            {
                modGlobals.gVoiceOn = false;
            }

            if (modGlobals.gVoiceOn == true)
            {
                string Phrase = "Welcome to E C M Library.";
                SB.Text = Phrase;
                DMA.SayWords(Phrase);
            }

            if (ddebug)
                LOG.WriteToTraceLog("FrmMDIMain 28");
            // ** Turned Off by WDM 7/13/2009
            // If isAdmin = True Then
            // RepositoryUtilitiesToolStripMenuItem.Visible = True
            // AdminToolStripMenuItem.Visible = True
            // SystemDetailsToolStripMenuItem.Visible = True
            // UsersToolStripMenuItem.Visible = True
            // UndefinedFiletypeCodesToolStripMenuItem.Visible = True
            // Else
            // RepositoryUtilitiesToolStripMenuItem.Visible = False
            // 'AdminToolStripMenuItem.Visible = False
            // AdminToolStripMenuItem.Visible = True
            // SystemDetailsToolStripMenuItem.Visible = False
            // UsersToolStripMenuItem.Visible = False
            // UndefinedFiletypeCodesToolStripMenuItem.Visible = False
            // End If
            string Msg2 = "Login: " + DMA.GetCurrUserName();
            Msg2 = Msg2 + ", " + DMA.GetCurrMachineName();
            Msg2 = Msg2 + ", " + DMA.GetCurrOsVersionName();
            // DBARCH.xTrace(99276, Msg2, "frmMdiMain:Load")

            modGlobals.SystemSqlTimeout = DBARCH.getSystemParm("SqlServerTimeout");
            // ListControls()

            if (ddebug)
                LOG.WriteToTraceLog("FrmMDIMain 29");
            if (isAdmin == false)
            {
            }
            // AdminToolStripMenuItem.Visible = False
            else
            {
                // AdminToolStripMenuItem.Visible = True
            }

            string sEcmCrawlerAvailable = System.Configuration.ConfigurationManager.AppSettings["EcmCrawlerAvailable"];
            if (isAdmin)
            {
                if (sEcmCrawlerAvailable.Equals("Y"))
                {
                    modGlobals.bEcmCrawlerAvailable = true;
                }
                // WebCrawlerSetupToolStripMenuItem.Visible = True
                else
                {
                    modGlobals.bEcmCrawlerAvailable = false;
                    // WebCrawlerSetupToolStripMenuItem.Visible = False
                }
            }
            else
            {
                modGlobals.bEcmCrawlerAvailable = false;
                // WebCrawlerSetupToolStripMenuItem.Visible = False
            }

            MachineIDcurr = DMA.GetCurrMachineName();
            DBARCH.ckMissingWorkingDirs();
            string sDebug = DBARCH.getUserParm("user_showContactMenu");
            try
            {
                string strDaysToKeepTraceLogs = DBARCH.getUserParm("user_DaysToKeepTraceLogs");
                if (strDaysToKeepTraceLogs.Trim().Length > 0)
                {
                    modGlobals.gDaysToKeepTraceLogs = Conversions.ToInteger(strDaysToKeepTraceLogs);
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                modGlobals.gDaysToKeepTraceLogs = 3;
            }

            SetVersionAndServer();
            isAdmin = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
            modGlobals.isGlobalSearcher = DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID);
            if (isAdmin == false)
            {
                // AdminToolStripMenuItem.Visible = False
                SB.Text = "Logged in as a user.";
            }
            else
            {
                // AdminToolStripMenuItem.Visible = True
                SB.Text = "Logged in as an Admin.";
            }

            bool bEmbededJPGMetadata = DBARCH.ShowGraphicMetaDataScreen();
        }

        public void SetVersionAndServer()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string S = " VER:" + My.MyProject.Application.Info.Version.Major + "." + My.MyProject.Application.Info.Version.Minor + "." + My.MyProject.Application.Info.Version.Build + "." + My.MyProject.Application.Info.Version.Revision + " ";
                tssVersion.Text = S;
                string SvrName = DBARCH.getNameOfCurrentServer();
                string CurrCS = DBARCH.setConnStr();
                tssServer.Text = SvrName + ":" + getServer(CurrCS);
                if (Strings.InStr(tssServer.Text, "unknown", CompareMethod.Text) > 0)
                {
                    tssServer.Text = getServer(System.Configuration.ConfigurationManager.AppSettings["ECMREPO"]);
                    LOG.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN.");
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                LOG.WriteToArchiveLog("Notice 001.z1 : Server UNKNOWN." + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        public string getServer(string ConnectionString)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string SVR = "";
            try
            {
                string S = DBARCH.setConnStr();
                int I = 1;
                I = Strings.InStr(I, S, "Data Source=", CompareMethod.Text);
                I = Strings.InStr(I + 1, S, "=", CompareMethod.Text);
                int J = Strings.InStr(I + 1, S, ";", CompareMethod.Text);
                if (I > 0)
                {
                    SVR = " " + Strings.Mid(S, I + 1, J - I - 1);
                }
                else
                {
                    SVR = "Unknown";
                }
            }
            catch (Exception ex)
            {
                SVR = " UKN";
            }

            return SVR;
        }

        private void ParameterExecutionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string MSG = "";
            MSG = MSG + "RUV = Reset USER application variables to those defiend by the APP CONFIG file." + Constants.vbCrLf + Constants.vbCrLf;
            MSG = MSG + "X = Execute archive and close." + Constants.vbCrLf + Constants.vbCrLf;
            MSG = MSG + "C = Archive CONTENT only." + Constants.vbCrLf + Constants.vbCrLf;
            MSG = MSG + "O = Archive OUTLOOK only." + Constants.vbCrLf + Constants.vbCrLf;
            MSG = MSG + "E = Archive EXCHANGE Servers only." + Constants.vbCrLf + Constants.vbCrLf;
            MSG = MSG + "A = Archive ALL." + Constants.vbCrLf + Constants.vbCrLf;
            MSG = MSG + "To Execute:" + Constants.vbCrLf;
            MSG = MSG + "<full path>EcmArchiveSetup.exe <parm>" + Constants.vbCrLf;
            MSG = MSG + @"(E.G.) C:\dev\ECM\EcmLibSvc\EcmLibSvc\bin\Debug\EcmArchiveSetup.exe Q" + Constants.vbCrLf;
            MessageBox.Show(MSG);
        }

        private void HistoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmHistory.Show();
        }

        private void ckExpand_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckExpand.Checked)
            {
                gbEmail.Width = gbContentMgt.Width;
                gbContentMgt.Visible = false;
                SB2.Visible = false;
                SB.Visible = false;
                gbPolling.Visible = false;
                gbFiletypes.Visible = false;
                gbEmail.Anchor = (AnchorStyles)((int)AnchorStyles.Bottom + (int)AnchorStyles.Left + (int)AnchorStyles.Top + (int)AnchorStyles.Right);
            }
            else
            {
                gbEmail.Width = gbContentMgt.Left - 35;
                gbContentMgt.Visible = true;
                SB2.Visible = true;
                SB.Visible = true;
                gbPolling.Visible = true;
                gbFiletypes.Visible = true;
                gbEmail.Anchor = (AnchorStyles)((int)AnchorStyles.Bottom + (int)AnchorStyles.Left + (int)AnchorStyles.Top);
            }
        }

        private void ckDisableContentArchive_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            saveStartUpParms();
            SB.Text = "Content Disabled set to " + ckDisableContentArchive.Checked.ToString();
        }

        private void ckDisableOutlookEmailArchive_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            saveStartUpParms();
            SB.Text = "EMAIL Disabled set to " + ckDisableOutlookEmailArchive.Checked.ToString();
        }

        private void ckDisableExchange_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            saveStartUpParms();
            if (ckDisableExchange.Checked)
            {
                SB.Text = "Exchange Disabled";
            }
            else
            {
                SB.Text = "Exchange Enabled";
            }
        }

        private void ViewLogsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var openFileDialog1 = new OpenFileDialog();
            openFileDialog1.InitialDirectory = LoggingPath;
            openFileDialog1.Filter = "ECM Logs (ECM*.*)|ECM*.txt| txt files (*.txt)|*.txt|All files (*.*)|*.*";
            openFileDialog1.FilterIndex = 2;
            openFileDialog1.RestoreDirectory = true;
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                string fName = openFileDialog1.FileName;
                Interaction.Shell("notepad.exe " + Conversions.ToString('"') + fName + Conversions.ToString('"'), Constants.vbNormalFocus);
                // Shell("notepad.exe " + Chr(34) + TempFolder + "\" + fName + Chr(34), vbNormalFocus)
            }
        }

        private void DirectoryInventoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string DirToInventory = @"C:\dev";
            string ListOfFiles = "";
            bool ckArchiveBit = true;
            bool IncludeSubDirs = true;
            var FileExt = new List<string>() { ".DOC", ".XLS", ".VB" };
            Console.WriteLine("Start: " + DateAndTime.Now.ToString());
            ListOfFiles = UTIL.getFileToArchive(DirToInventory, FileExt, ckArchiveBit, IncludeSubDirs);
            // Shell("Notepad.exe " + Chr(34) + ListOfFiles + Chr(34), vbNormalFocus)
            Console.WriteLine("End: " + DateAndTime.Now.ToString());
            GC.Collect();
            GC.WaitForFullGCApproach();
        }

        private void ListFilesInDirectoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            modGlobals.FilesBackedUp = 0;
            modGlobals.FilesSkipped = 0;
            var IncludedExts = new ArrayList();
            var ExcludedExts = new ArrayList();
            var FilesToArchive = new List<string>();
            string MSG = "";
            string strFileSize = "";
            var FilterList = new List<string>();
            bool ArchiveAttr = false;
            FilterList.Add("*.xls");
            FilterList.Add("*.doc");
            FilterList.Add("*.vb");
            Console.WriteLine("Start: " + DateAndTime.Now.ToString());
            string DirToInventory = @"C:\dev";
            int iInventory = 0;
            UTIL.GetFilesToArchive(ref iInventory, ArchiveAttr, false, DirToInventory, FilterList, ref FilesToArchive, IncludedExts, ExcludedExts);
            // For Each S As String In FilesToArchive
            // Console.WriteLine(S)
            // Next
            Console.WriteLine("End: " + DateAndTime.Now.ToString());
            GC.Collect();
            GC.WaitForFullGCApproach();
        }

        private void GetAllSubdirFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var IncludedTypes = new ArrayList();
            var ExcludedTypes = new ArrayList();
            var FilesToArchive = new List<string>();
            string MSG = "";
            string strFileSize = "";
            var FilterList = new List<string>();
            bool ArchiveAttr = false;
            FilterList.Add("*.doc");
            FilterList.Add("*.xls");
            FilterList.Add("*.vb");
            modGlobals.FilesBackedUp = 0;
            modGlobals.FilesSkipped = 0;
            Console.WriteLine("Start: " + DateAndTime.Now.ToString());
            string DirToInventory = @"C:\dev";
            int iInventory = 0;
            UTIL.GetFilesToArchive(ref iInventory, ArchiveAttr, true, DirToInventory, FilterList, ref FilesToArchive, IncludedTypes, ExcludedTypes);
            // For Each S As String In FilesToArchive
            // Console.WriteLine(S)
            // Next
            Console.WriteLine("End: " + DateAndTime.Now.ToString());
            GC.Collect();
            GC.WaitForFullGCApproach();
        }

        private void ViewOCRErrorFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string DirFQN = UTIL.getTempPdfWorkingErrorDir();
                Interaction.Shell("explorer.exe " + Conversions.ToString('"') + DirFQN + Conversions.ToString('"'), Constants.vbNormalFocus);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        private void ScheduleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmSchedule.ShowDialog();
        }

        private void RunningArchiverToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void AboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.AboutBox1.ShowDialog();
        }

        private void ManualEditAppConfigToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string aPath = AppDomain.CurrentDomain.BaseDirectory;
            string AppName = aPath + "EcmArchiveSetup.exe.config";
            Process.Start("notepad.exe", AppName);
        }

        private void NumericUpDown1_ValueChanged(object sender, EventArgs e)
        {
            if (!formloaded)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (nbrArchiveHours.Value == 0m)
            {
                My.MySettingsProperty.Settings["BackupIntervalHours"] = 0;
                SB2.Text = "Quick archive disabled.";
            }
            // TimerQuickArchive.Enabled = False
            else
            {
                if (nbrArchiveHours.Value < 4m)
                {
                    nbrArchiveHours.Value = 4m;
                }

                if (nbrArchiveHours.Value > 96m)
                {
                    nbrArchiveHours.Value = 96m;
                }

                My.MySettingsProperty.Settings["BackupIntervalHours"] = (int)nbrArchiveHours.Value;
                My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                My.MySettingsProperty.Settings.Save();
                SB2.Text = nbrArchiveHours.Value.ToString() + " hours from now, an archive will execute and every " + nbrArchiveHours.Value.ToString() + " thereafter.";
                // TimerQuickArchive.Enabled = True
            }

            My.MySettingsProperty.Settings.Save();
        }

        private void TimerQuickArchive_Tick(object sender, EventArgs e)
        {
            if (ckDisable.Checked)
            {
                return;
            }

            if (modGlobals.gContactsArchiving == true | modGlobals.gContentArchiving == true | modGlobals.gOutlookArchiving == true | modGlobals.gExchangeArchiving == true)
            {
                // ** An archive is already running
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            tsLastArchive.Text = My.MySettingsProperty.Settings["LastArchiveEndTime"].ToString();
            int IntervalHours = 0;
            decimal iElapsedHours = 0m;
            try
            {
                IntervalHours = Conversions.ToInteger(My.MySettingsProperty.Settings["BackupIntervalHours"]);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                IntervalHours = 0;
            }

            if (IntervalHours > 0)
            {
                CalcNextArchiveTime();
            }
        }

        public decimal ElapsedHours(DateTime tStart)
        {
            TimeSpan elapsed_time;
            elapsed_time = DateAndTime.Now.Subtract(tStart);
            return (decimal)elapsed_time.TotalHours;
        }

        private void btnArchiveNow_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            TimerQuickArchive_Tick(null, null);
        }

        /// <summary> This will create a Application Reference file on the users desktop if they do not
    /// already have one when the program is loaded.
        // If not debugging in visual studio check for Application Reference #if (!debug)
        // CheckForShortcut(); #endif
        /// </summary
        private void CheckForShortcut()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var ad = ApplicationDeployment.CurrentDeployment;
            // If ad.IsFirstRun Then
            var code = Assembly.GetExecutingAssembly();
            string company = string.Empty;
            string description = string.Empty;
            if (Attribute.IsDefined(code, typeof(AssemblyCompanyAttribute)))
            {
                AssemblyCompanyAttribute ascompany = (AssemblyCompanyAttribute)Attribute.GetCustomAttribute(code, typeof(AssemblyCompanyAttribute));
                company = ascompany.Company;
            }

            if (Attribute.IsDefined(code, typeof(AssemblyDescriptionAttribute)))
            {
                AssemblyDescriptionAttribute asdescription = (AssemblyDescriptionAttribute)Attribute.GetCustomAttribute(code, typeof(AssemblyDescriptionAttribute));
                description = asdescription.Description;
            }

            if ((company ?? "") != (string.Empty ?? "") && (description ?? "") != (string.Empty ?? ""))
            {
                string desktopPath = string.Empty;
                desktopPath = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Desktop), @"\", description, ".appref-ms");
                string shortcutName = string.Empty;
                shortcutName = string.Concat(Environment.GetFolderPath(Environment.SpecialFolder.Programs), @"\", company, @"\", description, ".appref-ms");
                File.Copy(shortcutName, desktopPath, true);
            }
            // End If

        }

        private void ImpersonateLoginToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmImpersonate.ShowDialog();
        }

        private void AddDesktopIconToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            CheckForShortcut();
        }

        private void btnRefreshRebuild_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Cursor = Cursors.WaitCursor;
            string S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] ";
            DBARCH.LoadProfiles();
            S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] ";
            var argCB = cbProfile;
            DBARCH.PopulateComboBox(ref argCB, "ProfileName", S);
            cbProfile = argCB;
            S = "Select [ProfileName] FROM [DirProfiles] order by [ProfileName]";
            // S = "select distinct ProfileName from LoadProfileItem order by ProfileName"
            var argCB1 = cbDirProfile;
            DBARCH.PopulateComboBox(ref argCB1, "ProfileName", S);
            cbDirProfile = argCB1;
            Cursor = Cursors.Default;
        }

        private void AllToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            gbEmail.Visible = true;
            gbContentMgt.Visible = true;
            gbPolling.Visible = true;
            gbFiletypes.Visible = true;
        }

        private void EmailToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            gbEmail.Visible = true;
            gbContentMgt.Visible = false;
            gbPolling.Visible = false;
            gbFiletypes.Visible = false;
        }

        private void ContentToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            gbEmail.Visible = false;
            gbContentMgt.Visible = true;
            gbPolling.Visible = false;
            gbFiletypes.Visible = false;
        }

        private void ExecutionControlToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            gbEmail.Visible = false;
            gbContentMgt.Visible = false;
            gbPolling.Visible = true;
            gbFiletypes.Visible = false;
        }

        private void FileTypesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            gbEmail.Visible = false;
            gbContentMgt.Visible = false;
            gbPolling.Visible = false;
            gbFiletypes.Visible = true;
        }

        private void EncryptStringToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmEncryptString.ShowDialog();
        }

        private void btnRefreshDefaults_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            bool B = true;
            S = "insert into AvailFileTypes (ExtCode) Values ('.act')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ada')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.adb')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ads')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ascx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.asm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.asp')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.aspx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.bat')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.bmp')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.c')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.CMD')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.cpp')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.csv')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.cxx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.dct')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.def')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.dic')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.dll')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.doc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.docm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.docx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.dot')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.dotm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.dotx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.exe')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.frm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.GIF')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.gz')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.h')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.hhc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.hpp')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.htm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.html')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.htw')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.htx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.hxx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ibq')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.idl')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.inc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.inf')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ini')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.inx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.java')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.JPG')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.JPX')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.js')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.log')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.m3u')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.mht')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.mp3')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.msg')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.obd')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.obj')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.obt')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.odc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.pdf')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.pfx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.pl')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.PNG')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.pot')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.potm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.potx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ppam')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ppsm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ppsx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.ppt')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.pptm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.pptx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.rc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.reg')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.resx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.rtf')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.sln')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.sql')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.stm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.suo')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.tar')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.tif')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.TIFF')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.TRF')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.txt')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.UKN')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.url')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.vb')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.vbs')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.vbx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.VSD')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.wav')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.wma')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.wtx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.XL * ')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xlam')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xlb')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xlc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xls')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xlsm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xlsx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xlt')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xltm')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xltx')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xml')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xsc')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xsd')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xslt')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.xss')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.z')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('.zip')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "insert into AvailFileTypes (ExtCode) Values ('msg')";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            MessageBox.Show("Missing default extension codes readded.");
        }

        private void btnDefaultAsso_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            AP.SaveNewAssociations(".ada", ".txt");
            AP.SaveNewAssociations("adb", ".txt");
            AP.SaveNewAssociations("ads", ".txt");
            AP.SaveNewAssociations("bat", ".txt");
            AP.SaveNewAssociations("css", ".cxx");
            AP.SaveNewAssociations("csv", ".txt");
            AP.SaveNewAssociations("dct", ".txt");
            AP.SaveNewAssociations("def", ".txt");
            AP.SaveNewAssociations("frm", ".vbs");
            AP.SaveNewAssociations("java", ".js");
            AP.SaveNewAssociations("sql", ".txt");
            AP.SaveNewAssociations("url", ".txt");
            AP.SaveNewAssociations("vb", ".vbs");
            MessageBox.Show("Default associations readded.");
        }

        private void btnAddDefaults_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Cursor = Cursors.WaitCursor;
            AddSourceTypeDefaults();
            string S = "";
            bool B = false;
            S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'Known graphic file types.', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'All MS Office content.', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - C#', N'Source Code - C#', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'Source Code - VB', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ZIP Files', N'Currently Processed ZIP types', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ZIP','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.RAR','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.GZ','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ISO','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.TAR','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.ARJ','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CAB','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CHM','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CPIO','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.CramFS','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.DEB','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.DMG','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.FAT','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.HFS','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.LZH','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.LZMA','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.MBR','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.MSI','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.NSIS','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.NTFS','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.RPM','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.SquashFS','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.UDF','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.VHD','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.WIM','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.XAR','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Insert LoadProfileItem (ProfileName, SourceTypeCode, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate) values ('ZIP Files', '.Z','UKN',0,'ECMLIB', getdate(), getdate())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.one', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pdf', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.txt', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.csv', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xls', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pdf', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.html', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.htm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.docx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.doc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.Tiff', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.tif', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.gif', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.docm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.dotx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.dotm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xltx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xltm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlsb', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.xlam', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pptx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.pptm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.potx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.potm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppam', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppsx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Office Documents', N'.ppsm', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.bmp', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.png', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.vb', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xsd', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xss', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xsc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.ico', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.rpt', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.rdlc', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.resx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.sql', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.xml', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.sln', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Source Code - VB', N'.vbx', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Graphics Files', N'.jpg', NULL, 0, N'ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "Select [ProfileName] ,[ProfileDesc] FROM [LoadProfile] ";
            var argCB = cbProfile;
            DBARCH.PopulateComboBox(ref argCB, "ProfileName", S);
            cbProfile = argCB;
            Cursor = Cursors.Default;
            MessageBox.Show("Default profiles ready.");
        }

        public void AddSourceTypeDefaults()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = null;
            bool B = false;
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ZIP', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'RAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'GZ', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ISO', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'TAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ARJ', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CAB', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CHM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CPIO', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'CramFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'DEB', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'DMG', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'FAT', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'HFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'LZH', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'LZMA', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'MBR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'MSI', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NSIS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NTFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'RPM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'SquashFS', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'UDF', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'VHD', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'WIM', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'XAR', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Z', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'ECMLIB', GETDATE(), GETDATE())";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            DBARCH.AddSourceTypeCode(".ZIP", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".RAR", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".GZ", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".ISO", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".TAR", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".ARJ", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".CAB", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".CHM", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".CPIO", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".CramFS", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".DEB", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".DMG", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".FAT", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".HFS", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".LZH", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".LZMA", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".MBR", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".MSI", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".NSIS", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".NTFS", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".RPM", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".SquashFS", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".UDF", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".VHD", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".WIM", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".XAR", 0, "Add by ECM: Compressed File.", 0);
            DBARCH.AddSourceTypeCode(".Z", 0, "Add by ECM: Compressed File.", 0);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N',dct', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.act', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ada', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.adb', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ads', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.application', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asax', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ascx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ashx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asmmeta', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.asp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.aspx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.BAK', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.baml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bas', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bat', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.bmp', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.c', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Cache', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.chm', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cls', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.CMD', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.compiled', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.config', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cpp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.crt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cs', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.CSproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.css', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.csv', 0, N'Added by user', 1, NULL, NULL, NULL, NULL, NULL)";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.cxx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dat', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.data', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.database', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.datasource', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.DBARCH', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dct', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.def', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.deploy', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dic', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dll', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.DM1', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dnn', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.doc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.docm', 0, N'Word 2007 XML Macro-Enabled Document', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.docx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dot', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dotm', 0, N'Word 2007 XML Macro-Enabled Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dotx', 0, N'Word 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtsConfig', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.dtsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.emz', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe_SyncToyBackup_20090311100439812', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.exe_SyncToyBackup_20090406194350947', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.frm', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.gif', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.grxml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.gz', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.h', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hhc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hlp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hpp', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.html', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htw', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.htx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.hxx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ibq', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ico', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.idl', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ini', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.inx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.jar', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.java', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.jpg', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.js', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.kmz', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ldb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ldf', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.lng', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.lnk', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.log', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.m3u', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.manifest', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.master', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mdb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mdf', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.MDI', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mht', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mp3', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.mrc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.msg', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.msi', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.myapp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obd', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obj', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.obt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.odc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.one', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.opml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.org', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.p7b', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pcap', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pdb', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pdf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pfx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.php', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pl', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.png', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pot', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.potm', 0, N'PowerPoint 2007 Macro-Enabled XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.potx', 0, N'PowerPoint 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppam', 0, N'PowerPoint 2007 Macro-Enabled XML Add-In', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppsm', 0, N'PowerPoint 2007 Macro-Enabled XML Show', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppsx', 0, N'PowerPoint 2007 XML Show', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.ppt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pptm', 0, N'PowerPoint 2007 Macro-Enabled XML Presentation', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pptx', 0, N'PowerPoint 2007 XML Presentation', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.psd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.pub', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rar', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rdl', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rdlc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rds', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.reg', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.resources', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.resx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rpt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rptproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.rtf', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.scc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.settings', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.shs', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sitemap', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.skin', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sln', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sql', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.SqlDataProvider', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sqlsuo', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, NULL, NULL, NULL, NULL)";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.sqm', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.stm', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.subproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.suo', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tar', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.template', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Text', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.thmx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tif', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.Tiff', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.tmp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.TRF', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.txt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.UD', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.url', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.user', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vb', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbp', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbs', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vbx', 0, N'AUTO Defined by System', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vsd', 0, N'AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vspscc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.vstemplate', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.WAV', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.webproj', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wma', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wmv', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wri', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.wtx', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xaml', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlam', 0, N'Excel 2007 XML Macro-Enabled Add-In', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlb', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlc', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlk', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xls', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsb', 0, N'Excel 2007 binary workbook (BIFF12)', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsm', 0, N'Excel 2007 XML Macro-Enabled Workbook', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xlt', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xltm', 0, N'Excel 2007 XML Macro-Enabled Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xltx', 0, N'Excel 2007 XML Template', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xml', 0, N'Word Splitter', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsc', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsd', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsl', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xslt', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xss', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.xsx', 0, N'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.z', 0, N'Added by user', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'.zip', 0, N'Word Splitter', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'Added by user', 0, N'.dct', 1, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'docm', 0, N'Word 2007 XML Macro-Enabled Document', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'docx', 0, N'Word 2007 XML Document', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'dotm', 0, N'Word 2007 XML Macro-Enabled Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'dotx', 0, N'Word 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'NO SEARCH - AUTO ADDED by Pgm', 0, N'.application', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'potm', 0, N'PowerPoint 2007 Macro-Enabled XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'potx', 0, N'PowerPoint 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppam', 0, N'PowerPoint 2007 Macro-Enabled XML Add-In', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppsm', 0, N'PowerPoint 2007 Macro-Enabled XML Show', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'ppsx', 0, N'PowerPoint 2007 XML Show', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'pptm', 0, N'PowerPoint 2007 Macro-Enabled XML Presentation', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'pptx', 0, N'PowerPoint 2007 XML Presentation', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlam', 0, N'Excel 2007 XML Macro-Enabled Add-In', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsb', 0, N'Excel 2007 binary workbook (BIFF12)', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsm', 0, N'Excel 2007 XML Macro-Enabled Workbook', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xlsx', 0, N'Excel 2007 XML Workbook', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xltm', 0, N'Excel 2007 XML Macro-Enabled Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'xltx', 0, N'Excel 2007 XML Template', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            S = @"INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N'XXXX', 0, N'AUTO Definition - not found', 0, NULL, 0, N'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))";
            B = DBARCH.ExecuteSqlNewConn(S, false);
        }

        private void FileHashToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OpenFileDialog1.ShowDialog();
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            long Ticks = 0L;
            int TotalTicks = 0;
            Ticks = DateAndTime.Now.Ticks;
            string FQN = OpenFileDialog1.FileName;
            string CRC32HASH = "";
            string ImageHash = "";
            string MD5HASH = "";
            string SHA1HASH = "";
            string SHA1QUICK = "";
            Ticks = DateAndTime.Now.Ticks;
            CRC32HASH = ENC.GenerateSHA512HashFromFile(FQN);
            ImageHash = ENC.GenerateSHA512HashFromFile(FQN);
            TotalTicks = (int)(DateAndTime.Now.Ticks - Ticks);
            CRC32HASH += " - Time: " + TotalTicks.ToString();
            Ticks = DateAndTime.Now.Ticks;
            MD5HASH = ENC.hashMd5File(FQN);
            TotalTicks = (int)(DateAndTime.Now.Ticks - Ticks);
            MD5HASH += " - Time: " + TotalTicks.ToString();
            Ticks = DateAndTime.Now.Ticks;
            SHA1HASH = ENC.hashSha1File(FQN);
            TotalTicks = (int)(DateAndTime.Now.Ticks - Ticks);
            SHA1HASH += " - Time: " + TotalTicks.ToString();
            Ticks = DateAndTime.Now.Ticks;
            SHA1QUICK = ENC.hashSha1File(FQN);
            TotalTicks = (int)(DateAndTime.Now.Ticks - Ticks);
            SHA1QUICK += " - Time: " + TotalTicks.ToString();
            string sMsg = "";
            sMsg += "CRC32     : " + CRC32HASH + Constants.vbCrLf;
            sMsg += "MD5       : " + MD5HASH + Constants.vbCrLf;
            sMsg += "SHA1      : " + SHA1HASH + Constants.vbCrLf;
            sMsg += "SHA1 Quick: " + SHA1QUICK + Constants.vbCrLf;
            MessageBox.Show(sMsg);
        }

        ~frmMain()
        {
        } // Finalize

        private void BackgroundWorker1_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Thread.BeginCriticalRegion();
            try
            {
                ThreadUpdateNotice("PROCESSING EMAIL");
                if (ckDisableOutlookEmailArchive.Checked)
                {
                    Thread.EndCriticalRegion();
                    return;
                }

                modGlobals.gAutoExecEmailComplete = false;
                string isPublic = "N";
                string RetentionCode = "Retain 10";
                if (ckTerminate.Checked)
                {
                    if (!modGlobals.gRunUnattended)
                    {
                        MessageBox.Show("The TERMINATE immediately box is checked, returning.");
                        modGlobals.gAutoExecEmailComplete = true;
                        Thread.EndCriticalRegion();
                        return;
                    }
                    else
                    {
                        LOG.WriteToArchiveLog("BackgroundWorker1_DoWork: The TERMINATE immediately box is checked, returning.");
                    }
                }

                if (ckDisable.Checked)
                {
                    SB.Text = "DISABLE ALL is checked - no archive allowed.";
                    ArchiveALLToolStripMenuItem.Enabled = true;
                    ContentToolStripMenuItem.Enabled = true;
                    ExchangeEmailsToolStripMenuItem.Enabled = true;
                    OutlookEmailsToolStripMenuItem.Enabled = true;
                    modGlobals.gAutoExecEmailComplete = true;
                    Thread.EndCriticalRegion();
                    return;
                }

                DBARCH.CleanUpEmailFolders();
                modGlobals.gEmailsBackedUp = 0;
                modGlobals.gEmailsAdded = 0;
                EmailsBackedUp = 0;
                EmailsSkipped = 0;
                modGlobals.FilesBackedUp = 0;
                modGlobals.FilesSkipped = 0;

                // ***************************************************
                SetUnattendedFlag();
                // *******************************************************************
                bool bUseQuickSearch = false;
                int NbrOfIds = DBARCH.getCountStoreIdByFolder();
                var slStoreId = new SortedList();
                if (NbrOfIds <= 5000000)
                {
                    bUseQuickSearch = true;
                }

                if (bUseQuickSearch)
                {
                    // ** 002
                    DBLocal.getCE_EmailIdentifiers(ref slStoreId);
                }
                else
                {
                    slStoreId.Clear();
                }

                // *******************************************************************
                ARCH.ArchiveEmailFolders(UIDcurr);
                // *******************************************************************

                if (modGlobals.gTerminateImmediately)
                {
                    // Me.Cursor = Cursors.Default
                    // SB.Text = "Terminated archive!"
                    // ArchiveALLToolStripMenuItem.Enabled = True
                    // ContentToolStripMenuItem.Enabled = True
                    // ExchangeEmailsToolStripMenuItem.Enabled = True
                    // OutlookEmailsToolStripMenuItem.Enabled = True
                    // PictureBox1.Visible = False

                    // SB.Text = "AUTO Archive exit"
                    // SB2.Text = "AUTO Archive exit"
                    modGlobals.gAutoExecEmailComplete = true;
                    Thread.EndCriticalRegion();
                    return;
                }

                resetBadDates();
                // ***************************************************

                ALR.ProcessAllRefEmails(false);
                // Me.Cursor = System.Windows.Forms.Cursors.Default
                DBARCH.UpdateAttachmentCounts();
                // Me.Cursor = System.Windows.Forms.Cursors.Default
                // SB.Text = "Completed Email archive."
                if (modGlobals.gEmailsAdded == 0)
                {
                    modGlobals.gEmailsAdded = 1;
                }

                if (modGlobals.gTerminateImmediately)
                {
                    modGlobals.gAutoExecEmailComplete = true;
                    Thread.EndCriticalRegion();
                    return;
                }

                int StackLevel = 0;
                var ListOfFiles = new Dictionary<string, int>();
                for (int i = 0, loopTo = modGlobals.ZipFilesEmail.Count - 1; i <= loopTo; i++)
                {
                    // bExplodeZipFile = False
                    string cData = modGlobals.ZipFilesEmail[i].ToString();
                    string ParentGuid = "";
                    string FQN = "";
                    int K = Strings.InStr(cData, "|");
                    FQN = Strings.Mid(cData, 1, K - 1);
                    ParentGuid = Strings.Mid(cData, K + 1);
                    // DBARCH.UpdateZipFileIndicator(ParentGuid, True)
                    ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, true, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                }

                ListOfFiles = null;
                modGlobals.gAutoExecEmailComplete = true;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 1000 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 3012x" + ex.Message);
            }

            Thread.EndCriticalRegion();
            GC.Collect();
            modGlobals.gAutoExecEmailComplete = true;
        }

        private void BackgroundWorker2_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (ckDisableExchange.Checked)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Thread.BeginCriticalRegion();
            modGlobals.gAutoExecExchangeComplete = false;
            string isPublic = "N";
            string RetentionCode = "Retain 10";
            if (ckTerminate.Checked)
            {
                Thread.EndCriticalRegion();
                MessageBox.Show("The TERMINATE immediately box is checked, returning.");
                return;
            }

            EmailsBackedUp = 0;
            EmailsSkipped = 0;
            modGlobals.FilesBackedUp = 0;
            modGlobals.FilesSkipped = 0;

            // SB.Text = "Launching Exchange Archive - it will run in background."
            if (modGlobals.gCurrentArchiveGuid.Length == 0)
            {
                modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
            }

            // ****************************************************************************
            SetUnattendedFlag();
            // frmExchangeMonitor.Show()

            GetExchangeFolders(false);
            // ****************************************************************************

            int StackLevel = 0;
            var ListOfFiles = new Dictionary<string, int>();
            for (int i = 0, loopTo = modGlobals.ZipFilesExchange.Count - 1; i <= loopTo; i++)
            {
                string cData = modGlobals.ZipFilesExchange[i].ToString();
                string ParentGuid = "";
                string FQN = "";
                int K = Strings.InStr(cData, "|");
                FQN = Strings.Mid(cData, 1, K - 1);
                ParentGuid = Strings.Mid(cData, K + 1);
                ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, true, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
            }

            for (int i = 0, loopTo1 = modGlobals.ZipFilesEmail.Count - 1; i <= loopTo1; i++)
            {
                string cData = modGlobals.ZipFilesExchange[i].ToString();
                string ParentGuid = "";
                string FQN = "";
                int K = Strings.InStr(cData, "|");
                FQN = Strings.Mid(cData, 1, K - 1);
                ParentGuid = Strings.Mid(cData, K + 1);
                ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, true, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
            }

            Thread.EndCriticalRegion();
            ListOfFiles = null;
            GC.Collect();
            modGlobals.gAutoExecExchangeComplete = true;
        }

        private void PerformContentArchive()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool bopen = ckFormOpen("frmMain");
            if (!bopen)
            {
                Show();
            }

            bopen = ckFormOpen("frmNotify");
            if (!bopen)
            {
                My.MyProject.Forms.frmNotify.Show();
                My.MyProject.Forms.frmNotify.TopMost = true;
                My.MyProject.Forms.frmNotify.Location = new Point(Screen.PrimaryScreen.WorkingArea.Width - Width, Screen.PrimaryScreen.WorkingArea.Height - Height);
            }

            if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
            {
                My.MyProject.Forms.frmNotify.Text = "Processing Listener";
                My.MyProject.Forms.frmNotify.Refresh();
            }
            else
            {
                My.MyProject.Forms.frmNotify.Text = "Processing CONTENT";
                My.MyProject.Forms.frmNotify.Refresh();
            }

            try
            {
                if (ckDisableContentArchive.Checked)
                {
                    return;
                }

                // Thread.BeginCriticalRegion()

                modGlobals.gAutoExecContentComplete = false;
                string isPublic = "N";
                if (ckTerminate.Checked)
                {
                    // Thread.EndCriticalRegion()
                    MessageBox.Show("The TERMINATE immediately box is checked, returning.");
                    modGlobals.gAutoExecContentComplete = true;
                    return;
                }

                if (ckDisable.Checked)
                {
                    // Thread.EndCriticalRegion()
                    SB.Text = "DISABLE ALL is checked - no archive allowed.";
                    modGlobals.gAutoExecContentComplete = true;
                    return;
                }

                ckTerminate.Checked = false;
                if (modGlobals.gTraceFunctionCalls.Equals(1))
                {
                    LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
                }

                EmailsBackedUp = 0;
                EmailsSkipped = 0;
                modGlobals.FilesBackedUp = 0;
                modGlobals.FilesSkipped = 0;

                // SB.Text = "Starting Content archive."

                LOG.WriteToArchiveLog("Content Archive stared @ " + DateAndTime.Now.ToString());
                MsgNotification = false;
                if (modGlobals.gCurrentArchiveGuid.Length == 0)
                {
                    modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
                }

                // *** Here is the primary Module for archive.
                if (ddebug)
                    LOG.WriteToArchiveLog("frmMain : btnArchiveContent :7001 : starting archive.");
                if (ddebug)
                    LOG.WriteToArchiveLog("Starting Archive of Content ********************************");

                // ***************** ARCHIVE CONTENT **********************'
                SetUnattendedFlag();
                // FrmMDIMain.lblArchiveStatus.Text = "Archive Running"

                var StartTime = DateAndTime.Now;
                modGlobals.gCurrUserGuidID = UIDcurr;
                try
                {
                    // ************************************** ArchiveContent ****************************************************************
                    My.MyProject.Forms.frmNotify.TopMost = false;
                    ArchiveContent(Environment.MachineName, UIDcurr);
                    // **********************************************************************************************************************
                    LOG.WriteToUploadLog("------------------------------------------------------------");
                    LOG.WriteToUploadLog("PerformContentArchive: ArchiveContent: Start" + StartTime.ToString());
                    LOG.WriteToUploadLog("PerformContentArchive: ArchiveContent: END" + DateAndTime.Now.ToString());
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("PerformContentArchive/ArchiveContent 01: " + ex.Message);
                    LOG.WriteToArchiveLog("PerformContentArchive/ArchiveContent 02: " + ex.StackTrace.ToString());
                }

                // ********************************************************'
                if (ddebug)
                    LOG.WriteToArchiveLog("frmMain : btnArchiveContent :7002 : starting archive.");
                StartTime = DateAndTime.Now;
                ARCH.ArchiveQuickRefItems(UIDcurr, MachineIDcurr, ckArchiveBit.Checked, false, false, false, false, SB, "", "", "", ref modGlobals.ZipFilesQuick);
                LOG.WriteToUploadLog("------------------------------------------------------------");
                LOG.WriteToUploadLog("PerformContentArchive: ArchiveQuickRefItems: Start" + StartTime.ToString());
                LOG.WriteToUploadLog("PerformContentArchive: ArchiveQuickRefItems: END" + DateAndTime.Now.ToString());
                string RetentionCode = "Retain 10";
                int StackLevel = 0;
                var ListOfFiles = new Dictionary<string, int>();
                StartTime = DateAndTime.Now;
                for (int i = 0, loopTo = modGlobals.ZipFilesQuick.Count - 1; i <= loopTo; i++)
                {
                    string cData = modGlobals.ZipFilesQuick[i].ToString();
                    string ParentGuid = "";
                    string FQN = "";
                    int K = Strings.InStr(cData, "|");
                    FQN = Strings.Mid(cData, 1, K - 1);
                    ParentGuid = Strings.Mid(cData, K + 1);
                    // DBARCH.UpdateZipFileIndicator(ParentGuid, True)
                    LOG.WriteToUploadLog("PerformContentArchive 0A: File: " + DateAndTime.Now.ToString() + FQN);
                    ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                }

                LOG.WriteToUploadLog("------------------------------------------------------------");
                LOG.WriteToUploadLog("PerformContentArchive: ZipFilesQuick: Start" + StartTime.ToString());
                LOG.WriteToUploadLog("PerformContentArchive: ZipFilesQuick: END" + DateAndTime.Now.ToString());
                ListOfFiles = null;
                GC.Collect();
                StartTime = DateAndTime.Now;
                ALR.ProcessAllRefDirs(false);
                LOG.WriteToUploadLog("------------------------------------------------------------");
                LOG.WriteToUploadLog("PerformContentArchive: ProcessAllRefDirs: Start" + StartTime.ToString());
                LOG.WriteToUploadLog("PerformContentArchive: ProcessAllRefDirs: END" + DateAndTime.Now.ToString());
                string Msg = "Files Backed Up: " + modGlobals.FilesBackedUp.ToString() + "  /  Files Updated: " + modGlobals.FilesSkipped.ToString();
                LOG.WriteToArchiveLog("Content Archive completed @ " + DateAndTime.Now.ToString() + " : " + Msg);
                modGlobals.gAutoExecContentComplete = true;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 1000 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 421z: " + ex.Message);
            }

            // Thread.EndCriticalRegion()
            modGlobals.gAutoExecContentComplete = true;
            if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
            {
                bUpdated = DBLocal.removeListenerfileProcessed();
                if (Conversions.ToBoolean(!bUpdated))
                {
                    LOG.WriteToArchiveLog("ERROR 02 failed removeListenerfileProcessed...");
                }
            }

            My.MyProject.Forms.frmNotify.Hide();
            modGlobals.gAutoExecContentComplete = true;
        }

        private void FileUploadToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string DirName = "NA";
            string RetentionCode = "Retain 10";
            string isPublic = "N";
            OpenFileDialog1.ShowDialog();
            string FQN = OpenFileDialog1.FileName;
            var FI = new FileInfo(FQN);
            string OriginalFileName = FI.Name;
            FI = null;
            string FileGuid = Guid.NewGuid().ToString();
            string RepositoryTable = "DataSource";
            string SourceHash = ENC.GenerateSHA512HashFromFile(FQN);
            string AttachmentCode = "C";
            DBARCH.InsertSourceImage(modGlobals.gCurrUserGuidID, Environment.MachineName, OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic, SourceHash, DirName, false);
        }

        private void FileUploadBufferedToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string isPublic = "N";
            string RetentionCode = "Retain 10";
            OpenFileDialog1.ShowDialog();
            string FQN = OpenFileDialog1.FileName;
            var FI = new FileInfo(FQN);
            string OriginalFileName = FI.Name;
            FI = null;
            string FileGuid = Guid.NewGuid().ToString();
            string RepositoryTable = "DataSource";
            byte[] FileBuffer = null;
            FileInfo oFile;
            oFile = new FileInfo(FQN);
            var oFileStream = oFile.OpenRead();
            long lBytes = oFileStream.Length;
            if (lBytes > 0L)
            {
                FileBuffer = new byte[(int)(lBytes - 1L + 1)];
                oFileStream.Read(FileBuffer, 0, (int)lBytes);
                oFileStream.Close();
            }

            string CrcHASH = ENC.GenerateSHA512HashFromFile(FQN);
            DBARCH.InsertBufferedSource(4, FileBuffer, OriginalFileName, FileGuid, FQN, RepositoryTable, RetentionCode, isPublic, CrcHASH, "NA");
        }

        private void FileChunkUploadToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            OpenFileDialog1.ShowDialog();
            string FQN = OpenFileDialog1.FileName;
            var FI = new FileInfo(FQN);
            string OriginalFileName = FI.Name;
            FI = null;
            string FileGuid = Guid.NewGuid().ToString();
            string CrcHASH = ENC.GenerateSHA512HashFromFile(FQN);
            DBARCH.ChunkFileUpload(OriginalFileName, FileGuid, FQN, "DataSource", CrcHASH);
        }

        private void BackgroundDirListener_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Thread.BeginCriticalRegion();
            string RetentionCode = "Retain 10";
            string isPublic = "N";
            bool bFilesToBeArchived = DBLocal.ActiveListenerFiles();
            // If Not bFilesToBeArchived Then
            // Return
            // End If

            bool bDoNotRun = false;
            Form frm;
            try
            {
                foreach (Form currentFrm in My.MyProject.Application.OpenForms)
                {
                    frm = currentFrm;
                    Application.DoEvents();
                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify))
                    {
                        bDoNotRun = true;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotify2))
                    {
                        bDoNotRun = true;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmExchangeMonitor))
                    {
                        bDoNotRun = true;
                    }

                    if (ReferenceEquals(frm, My.MyProject.Forms.m_frmNotifyListener))
                    {
                        bDoNotRun = true;
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Collection processed.");
            }

            frm = null;
            if (bDoNotRun == true)
            {
                Thread.EndCriticalRegion();
                return;
            }

            try
            {
                var L = new SortedList<string, int>();
                // L = gFilesToArchive
                DBLocal.getListenerFiles(ref L);
                foreach (string sKey in L.Keys)
                {
                    if (!File.Exists(sKey))
                    {
                        DBLocal.removeListenerFile(sKey);
                        if (modGlobals.gFilesToArchive.ContainsKey(sKey))
                        {
                            modGlobals.gFilesToArchive.Remove(sKey);
                        }
                    }

                    var FI = new FileInfo(sKey);
                    string fName = FI.Name;
                    FI = null;
                    if (Strings.Mid(fName, 1, 1).Equals("~"))
                    {
                        Console.WriteLine("Skipping: " + sKey);
                        DBLocal.removeListenerFile(sKey);
                        if (modGlobals.gFilesToArchive.ContainsKey(sKey))
                        {
                            modGlobals.gFilesToArchive.Remove(sKey);
                        }
                    }

                    if (modGlobals.gFilesToArchive.ContainsKey(sKey))
                    {
                        modGlobals.gFilesToArchive.Remove(sKey);
                    }
                }

                DBLocal.getListenerFiles(ref L);
                if (L.Count == 0 & !bFilesToBeArchived)
                {
                    Thread.EndCriticalRegion();
                    return;
                }
                else
                {
                    ProcessListenerFiles(false);
                }

                L = null;
                int StackLevel = 0;
                var ListOfFiles = new Dictionary<string, int>();
                for (int i = 0, loopTo = modGlobals.ZipFilesListener.Count - 1; i <= loopTo; i++)
                {
                    string cData = modGlobals.ZipFilesListener[i].ToString();
                    string ParentGuid = "";
                    string FQN = "";
                    int K = Strings.InStr(cData, "|");
                    FQN = Strings.Mid(cData, 1, K - 1);
                    ParentGuid = Strings.Mid(cData, K + 1);
                    ZF.UploadZipFile(UIDcurr, MachineIDcurr, FQN, ParentGuid, ckArchiveBit.Checked, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                }

                ListOfFiles = null;
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 1000 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 2012X - resetting.");
            }

            Thread.EndCriticalRegion();
            GC.Collect();
        }

        // Private Sub btnActivate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnActivate.Click

        // CompanyID = txtCompany.Text RepoID = cbRepo.Text Dim bReg As Boolean = False

        // If CompanyID.Length > 0 And RepoID.Length > 0 Then If (ProxyGateway Is Nothing) Then
        // ProxyGateway = New SVCGateway.Service1Client 'If (SVCGateway_Endpoint.Length > 0) Then '
        // ProxyGateway.Endpoint.Address = New System.ServiceModel.EndpointAddress(SVCGateway_Endpoint)
        // 'End If End If

        // Dim EncCS As String = "" Dim RC As Boolean = False Dim RetMsg As String = "" EncCS =
        // ProxyGateway.getConnection(CompanyID, RepoID, RC, RetMsg) If EncCS.Trim.Length > 0 Then
        // 'gCurrentConnectionString = ENC.AES256DecryptString(EncCS) gCurrentConnectionString = EncCS If
        // gCurrentConnectionString.Length > 0 Then bReg =
        // REG.CreateEcmRegistrySubKey("EncConnectionString", EncCS) If Not bReg Then bReg =
        // REG.UpdateEcmRegistrySubKey("EncConnectionString", EncCS) End If End If Try
        // gCurrentConnectionString = ENC.AES256DecryptString(EncCS) Catch ex As Exception
        // MessageBox.Show("ERROR 121.32.1 : Failed to set new connection.") Return End Try Else
        // gCurrentConnectionString = "" End If

        // 'ProxyGateway = Nothing bUseAttachData = True tsCurrentRepoID.Text = RepoID
        // tsCurrentRepoID.Text = "Repo: " + RepoID

        // If CompanyID.Length > 0 Then bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID) If Not
        // bReg Then bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID) End If

        // End If
        // If RepoID.Length > 0 Then
        // bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID)
        // If Not bReg Then
        // bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID)
        // End If
        // End If
        // Else
        // tsCurrentRepoID.Text = "Repo: ??"
        // bUseAttachData = False
        // End If
        // End Sub

        private void GetQueryStringParameters() // As NameValueCollection
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var NameValueTable = new NameValueCollection();
            try
            {
                if (ApplicationDeployment.IsNetworkDeployed)
                {
                    string QueryString = ApplicationDeployment.CurrentDeployment.ActivationUri.Query;
                    NameValueTable = System.Web.HttpUtility.ParseQueryString(QueryString);
                }

                foreach (string Arg in NameValueTable)
                {
                    if (Conversions.ToBoolean(Strings.InStr(Arg, ";")))
                    {
                        var AA = Arg.Split(';');
                        CompanyID = AA[0];
                        RepoID = AA[1];
                        string sCompanyID = REG.ReadEcmRegistrySubKey("CompanyID");
                        string sRepoID = REG.ReadEcmRegistrySubKey("RepoID");
                        string RepoCS = REG.ReadEcmRegistrySubKey("RepoCS");
                        bool bReg = false;
                        if (sCompanyID.Length == 0)
                        {
                            bReg = REG.CreateEcmRegistrySubKey("CompanyID", CompanyID);
                            if (!bReg)
                            {
                                bReg = REG.UpdateEcmRegistrySubKey("CompanyID", CompanyID);
                            }
                        }

                        if (sRepoID.Length == 0)
                        {
                            bReg = REG.CreateEcmRegistrySubKey("RepoID", RepoID);
                            if (!bReg)
                            {
                                bReg = REG.UpdateEcmRegistrySubKey("RepoID", RepoID);
                            }
                        }

                        if (RepoCS.Length == 0)
                        {
                            bReg = REG.CreateEcmRegistrySubKey("RepoCS", RepoCS);
                            if (!bReg)
                            {
                                bReg = REG.UpdateEcmRegistrySubKey("RepoCS", RepoCS);
                            }
                        }
                    }
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR GetQueryStringParameters 100 - " + ex.Message);
                LOG.WriteToParmLog("ERROR GetQueryStringParameters 100 - " + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
            finally
            {
                LOG.WriteToParmLog("Step 40");
                NameValueTable = null;
            }

            LOG.WriteToParmLog("Step 45");
        }

        private void ExitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Application.Exit();
        }

        private void ExitToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Application.Exit();
        }

        private void InstallCLCToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void InstallCLCToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
        }

        // tsTimeToArchive
        // tsCountDown

        private void CalcNextArchiveTime()
        {
            DateTime LastArchiveDate = default;
            try
            {
                LastArchiveDate = Conversions.ToDate(My.MySettingsProperty.Settings["LastArchiveEndTime"]);
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LastArchiveDate = DateAndTime.Now;
            }

            int BackupInterval = Conversions.ToInteger(My.MySettingsProperty.Settings["BackupIntervalHours"]);
            if (BackupInterval == 0)
            {
                tsTimeToArchive.Text = "Inactive";
                return;
            }

            var NextArchvieTime = LastArchiveDate.AddHours(BackupInterval);
            tsTimeToArchive.Text = NextArchvieTime.ToString();
            if (NextArchvieTime < DateAndTime.Now)
            {
                My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                My.MySettingsProperty.Settings.Save();
                ArchiveALLToolStripMenuItem_Click(null, null);
            }
            else
            {
                var remainingTime = NextArchvieTime.Subtract(DateAndTime.Now);
                tsCountDown.Text = string.Format("{0}:{1:d2}:{2:d2}", remainingTime.Hours, remainingTime.Minutes, remainingTime.Seconds);
            }
        }

        private void btnCountFiles_Click(object sender, EventArgs e)
        {
            int I = lbArchiveDirs.SelectedItems.Count;
            if (I == 0)
            {
                SB.Text = "You must select an item from the listbox...";
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (I != 1)
            {
                CkMonitor.Visible = false;
            }
            else
            {
                CkMonitor.Visible = true;
            }

            Cursor = Cursors.WaitCursor;
            bActiveChange = true;
            string DirName = lbArchiveDirs.SelectedItem.ToString().Trim();
            btnCountFiles.Enabled = false;
            if (ckSubDirs.Checked)
            {
                int iCnt = UTIL.GetFileCountSubdir(DirName);
                SB.Text = DirName + " (Subdirs Included) filecount = " + iCnt.ToString();
            }
            else
            {
                int iCnt = UTIL.GetFileCountDir(DirName);
                SB.Text = DirName + " (No Subdirs) filecount = " + iCnt.ToString();
            }

            btnCountFiles.Enabled = true;
            Cursor = Cursors.Default;
        }

        private void AppConfigVersionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = System.Configuration.ConfigurationManager.AppSettings["AppConfigVerNo"];
            MessageBox.Show("App Confing Version: " + S);
        }

        private void ckDeleteAfterArchive_CheckedChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
            // If ckDeleteAfterArchive.Checked Then
            // Dim Msg As String = "This will DELETE all files that are successfully archived" + vbCrLf
            // MessageBox.Show(Msg)
            // End If
        }

        private void BackgroundWorkerContacts_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            // frmNotify.Label1.Text = "Contacts: "
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ARCH.ArchiveContacts();
        }

        private void ToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (ckDisable.Checked)
            {
                SB.Text = "DISABLE ALL is checked - no archive allowed.";
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ckDisableOutlookEmailArchive.Checked)
            {
                SB.Text = "Contacts disabled - no archive allowed.";
                return;
            }

            if (BackgroundWorkerContacts.IsBusy)
            {
                return;
            }

            try
            {
                BackgroundWorkerContacts.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        // Sub ReOcrPendingGraphics()

        // If Not SkipPermission Then Dim msg As String = "This process can be time consuming, are you
        // sure?" Dim dlgRes As DialogResult = MessageBox.Show(msg, "Re-OCR Pending",
        // MessageBoxButtons.YesNo) If dlgRes = Windows.Forms.DialogResult.No Then Return End If End If

        // Dim tgtSourceGuid As String = "" Dim RetMsg As String = ""

        // Dim ListOfGuids As New System.Collections.Generic.Dictionary(Of String, Integer)

        // 'If (SVCCLCArchive_Endpoint.Length > 0) Then ' ProxyArchive.Endpoint.Address = New
        // System.ServiceModel.EndpointAddress(SVCCLCArchive_Endpoint) 'End If

        // 'WDM CHECK THIS getGuidsOfPendingGraphicFiles(gGateWayID, 995, ListOfGuids)

        // frmNotifyBatchOCR.Show() Dim iTot As Integer = ListOfGuids.Keys.Count Dim I As Integer = 0 For
        // Each S As String In ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text =
        // "OCR " + I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
        // frmNotifyBatchOCR.Refresh() Application.DoEvents() 'WDM CHECK THIS ProcessSourceOCR(gGateWayID,
        // 996, tgtSourceGuid, RetMsg) Next

        // 'WDM CHECK THIS getGuidsOfAllEmailGraphicFiles(gGateWayID, 997, False, ListOfGuids)

        // Dim RC As Boolean = False iTot = ListOfGuids.Keys.Count I = 0 For Each S As String In
        // ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text = "EMAIL OCR " +
        // I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
        // frmNotifyBatchOCR.Refresh() Application.DoEvents() 'WDM CHECK THIS
        // ProcessEmailAttachmentOCR(gGateWayID, 998, tgtSourceGuid, RC, RetMsg) If Not RC Then
        // Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid) End If Next

        // frmNotifyBatchOCR.Close()
        // MessageBox.Show("Complete: " + RetMsg)
        // End Sub

        // Sub ReOcrAllGraphics()
        // Dim msg As String = "This process can be very time consuming, are you sure?"
        // Dim dlgRes As DialogResult = MessageBox.Show(msg, "Re-OCR ALL", MessageBoxButtons.YesNo)
        // If dlgRes = Windows.Forms.DialogResult.No Then
        // Return
        // End If
        // Dim tgtSourceGuid As String = ""
        // Dim RetMsg As String = ""

        // Dim ListOfGuids As New System.Collections.Generic.Dictionary(Of String, Integer)

        // 'If (SVCCLCArchive_Endpoint.Length > 0) Then ' Endpoint.Address = New
        // System.ServiceModel.EndpointAddress(SVCCLCArchive_Endpoint) 'End If

        // getGuidsOfAllGraphicFiles(gGateWayID, 999, ListOfGuids)

        // frmNotifyBatchOCR.Show() Dim iTot As Integer = ListOfGuids.Keys.Count Dim I As Integer = 0 For
        // Each S As String In ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text =
        // "OCR " + I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
        // frmNotifyBatchOCR.Refresh() Application.DoEvents() 'WDM CHECK THIS ProcessSourceOCR(gGateWayID,
        // 99, tgtSourceGuid, RetMsg) Next

        // 'WDM CHECK THIS getGuidsOfAllEmailGraphicFiles(gGateWayID, 999, True, ListOfGuids)

        // Dim RC As Boolean = False iTot = ListOfGuids.Keys.Count I = 0 For Each S As String In
        // ListOfGuids.Keys I += 1 tgtSourceGuid = S frmNotifyBatchOCR.lblMsg.Text = "EMAIL OCR " +
        // I.ToString + " of " + iTot.ToString frmNotifyBatchOCR.lblMsg.Refresh()
        // frmNotifyBatchOCR.Refresh() Application.DoEvents()

        // 'WDM CHECK THIS
        // ProcessEmailAttachmentOCR(gGateWayID, 999, tgtSourceGuid, RC, RetMsg)
        // If Not RC Then
        // Console.WriteLine("EMAIL OCR failed - " + tgtSourceGuid)
        // End If
        // Next
        // frmNotifyBatchOCR.Close()
        // MessageBox.Show("Complete: " + RetMsg)
        // End Sub

        // Private Sub asyncBatchOcrALL_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrALL.DoWork
        // ReOcrAllGraphics()
        // End Sub

        // Private Sub asyncBatchOcrPending_DoWork(ByVal sender As System.Object, ByVal e As System.ComponentModel.DoWorkEventArgs) Handles asyncBatchOcrPending.DoWork
        // ReOcrPendingGraphics()
        // End Sub

        private void ReOcrIncompleteGraphicFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (asyncBatchOcrPending.IsBusy)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                asyncBatchOcrPending.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        private void ReOcrALLGraphicFilesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (asyncBatchOcrALL.IsBusy)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                asyncBatchOcrALL.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        private void EstimateNumberOfFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string Msg = "";
            int iCnt = 0;
            string S = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + Constants.vbCrLf;
            iCnt = DBARCH.iCount(S);
            Msg += "Total EMAIL Graphics: " + iCnt.ToString() + Constants.vbCrLf;
            S = "select COUNT(*) from EmailAttachment where AttachmentCode in (select ImageTypeCode from ImageTypeCodes) " + Constants.vbCrLf;
            S += "and (OcrPending is null or OcrPending = 'Y')" + Constants.vbCrLf;
            iCnt = DBARCH.iCount(S);
            Msg += "Total pending EMAIL Graphics: " + iCnt.ToString() + Constants.vbCrLf + Constants.vbCrLf;
            S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + Constants.vbCrLf;
            iCnt = DBARCH.iCount(S);
            Msg += "Total Source Graphics: " + iCnt.ToString() + Constants.vbCrLf;
            S = "select COUNT(*) from DataSource where OriginalFileType in (select ImageTypeCode from ImageTypeCodes) " + Constants.vbCrLf;
            S += "and (OcrPending is null or OcrPending = 'Y')" + Constants.vbCrLf;
            S += "and (OcrPerformed is null or OcrPerformed != 'Y')" + Constants.vbCrLf;
            iCnt = DBARCH.iCount(S);
            Msg += "Total Pending Source Graphics: " + iCnt.ToString() + Constants.vbCrLf;
            MessageBox.Show(Msg);
        }

        private void CEDatabasesToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void ZIPFilesArchivesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "This deletes the pending ZIP files to be processed, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBLocal.zeroizeZipFiles();
            MessageBox.Show("Temporary zip files cleaned up and ready.");
        }

        private void ViewCEDirectoriesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            string tPath = Path.GetTempPath();
            tPath = tPath + @"EcmLibrary\CE";
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Interaction.Shell("explorer.exe " + Conversions.ToString('"') + tPath + Conversions.ToString('"'), Constants.vbNormalFocus);
        }

        private void InstallCESP2ToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Process.Start("http://www.microsoft.com/downloads/en/details.aspx?FamilyID=e497988a-c93a-404c-b161-3a0b323dce24");
        }

        private void AllToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            CEDatabasesToolStripMenuItem_Click(null, null);
            ZIPFilesArchivesToolStripMenuItem_Click(null, null);
        }

        private void RSSPullToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string sUrl = "http://pheedo.msnbc.msn.com/id/8874569/device/rss/";
            ARCH.getRssFeed(sUrl);
        }

        private void hlExchange_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            bool B = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
            if (!B)
            {
                DMA.SayWords("Admin authority is required to perform this function, please ask an Admin for assistance.");
                MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmExhangeMail.Show();
        }

        private void LinkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmPstLoader.UID = UIDcurr;
            My.MyProject.Forms.frmPstLoader.ShowDialog();
        }

        private void asyncVerifyRetainDates_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBARCH.VerifyRetentionDates();
        }

        private void OnlineHelpToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Process.Start("http://www.EcmLibrary.com/HelpSaaS/Archive.htm");
        }

        private void ckRunOnStart_CheckedChanged(object sender, EventArgs e)
        {
            if (formloaded == false)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool RunAtStart = false;
            if (ckRunOnStart.Checked == true)
            {
                RunAtStart = true;
            }
            else
            {
                RunAtStart = false;
            }

            saveStartUpParms();
            try
            {
                string aPath = "";
                aPath = Assembly.GetExecutingAssembly().Location;
                if (RunAtStart)
                {
                    var oReg = Registry.CurrentUser;
                    // Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
                    var oKey = oReg.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run", true);
                    string SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.CreateSubKey("EcmLibrary");
                    oKey.SetValue("EcmLibrary", aPath);
                    SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.Close();
                }
                else
                {

                    // Registry.CurrentUser.DeleteSubKey("Software\Microsoft\Windows\CurrentVersion\Run\EcmLibrary")

                    var oReg = Registry.CurrentUser;
                    var oKey = oReg.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run", true);
                    oKey.CreateSubKey("EcmLibrary");
                    oKey.SetValue("EcmLibrary", "X");
                    string SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.DeleteSubKey("EcmLibrary");
                    SS = oKey.GetValue("EcmLibrary").ToString();
                    oKey.Close();
                }

                // messagebox.show("Load at startup set to " + ckRunAtStartup.Checked.ToString)

                saveStartUpParms();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Failed to set startup parameter." + Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("ERROR ckRunAtStartup_CheckedChanged - Failed to set start up parameter.", ex);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void ResetEMAILCRCCodesToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void LoginToSystemToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            MessageBox.Show("REMOVE THIS: LoginForm1.ShowDialog 2");
            My.MyProject.Forms.LoginForm1.ShowDialog();
        }

        private void ChangeUserPasswordToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmPasswordChange.ShowDialog();
        }

        private void GetOutlookEmailIDsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Not currntly implemented...");
        }

        /// <summary>
    /// Handles the FormClosing event of the frmMain control. This is the dispose functionality.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">
    /// The <see cref="System.Windows.Forms.FormClosingEventArgs"/> instance containing the event data.
    /// </param>
        private void frmReconMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            SB.Text = "STANDBY... cleaning temporary directories...";
            Cursor = Cursors.WaitCursor;
            UTIL.cleanTempWorkingDir();
            SB.Text = "STANDBY... Setting retention dates...";
            DBARCH.spUpdateRetention();
            try
            {
                SB.Text = "STANDBY... backing up SQLite database...";
                var AllowedExts = DBARCH.getUsedExtension();
                DBLocal.resetExtension();
                DBLocal.addExtension(AllowedExts);
                DBLocal.BackUpSQLite();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR Closing: " + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }

            Cursor = Cursors.Default;
            SB.Text = "Goodbye....";
            My.MyProject.Forms.LoginForm1.Close();
            try
            {
                Application.Exit();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Could not exist the application, please do a manual shutdown.");
            }
        }

        private void WebSitesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ARCH.ArchiveWebSites(modGlobals.gCurrUserGuidID);
        }

        private void WebPagesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ARCH.ArchiveSingleWebPage(modGlobals.gCurrUserGuidID);
        }

        private void ArchiveRSSPullsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Dim ChannelItems As New List(Of rssChannelItem)
            // Dim RSS As New clsRSS
            // 'ChannelItems = ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)
            // ChannelItems = RSS.ReadRssDataFromSite("http://feeds.reuters.com/reuters/businessNews", True)
            // RSS = Nothing
            // GC.Collect()
            // GC.WaitForPendingFinalizers()

            if (!asyncRssPull.IsBusy)
            {
                asyncRssPull.RunWorkerAsync();
            }
            else
            {
                MessageBox.Show("Appears to be running a RSS archive already...");
            }
        }

        public void GetRSS(int SecureID)
        {
            bool RC = true;
            string WC = " where UserID =  '" + modGlobals.gCurrUserGuidID + "' ";
            var RssBindingSource = new BindingSource();
            RssBindingSource.DataSource = DBARCH.GET_RssPull(SecureID, WC, RC);
            dgRss.DataSource = RssBindingSource;
        }

        public void GetWebPage(int SecureID)
        {
            bool RC = true;
            string WC = " where UserID =  '" + modGlobals.gCurrUserGuidID + "' ";
            var RssBindingSource = new BindingSource();
            RssBindingSource.DataSource = DBARCH.GET_WebScreenForGRID(SecureID, WC, RC);
            dgWebPage.DataSource = RssBindingSource;
        }

        public void GetWebSite(int SecureID)
        {
            var dItems = new List<DS_WebSite>();
            bool RC = true;
            string WC = " where UserID =  '" + modGlobals.gCurrUserGuidID + "' ";
            var RssBindingSource = new BindingSource();
            RssBindingSource = DBARCH.GET_WebSite(SecureID, WC, RC);
            dgWebSite.DataSource = RssBindingSource;
        }

        private void btnAddRssFeed_Click(object sender, EventArgs e)
        {
            string tName = txtRssName.Text;
            string tUrl = txtRssURL.Text;
            bool RC = true;
            string RetentionCode = cbRssRetention.Text;
            if (RetentionCode.Trim().Length == 0)
            {
                MessageBox.Show("Please select a reterntion code.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBARCH.Save_RssPull(modGlobals.gGateWayID, tName, tUrl, modGlobals.gCurrUserGuidID, RetentionCode, ref RC);
            if (RC)
            {
                GetRSS(modGlobals.gGateWayID);
            }
            else
            {
                MessageBox.Show("Failed to save RSS Feed: " + tName);
            }
        }

        private void btnSaveWebPage_Click(object sender, EventArgs e)
        {
            string tName = txtWebScreenName.Text;
            string tUrl = txtWebScreenUrl.Text;
            bool RC = true;
            string RetentionCode = cbWebPageRetention.Text;
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBARCH.Save_WebScreenURL(modGlobals.gGateWayID, tName, tUrl, RetentionCode, modGlobals.gCurrUserGuidID, ref RC);
            if (RC)
            {
                GetWebPage(modGlobals.gGateWayID);
            }
            else
            {
                MessageBox.Show("Failed to save WEB Page: " + tName);
            }
        }

        private void btnSaveWebSite_Click(object sender, EventArgs e)
        {
            string tName = txtWebSiteName.Text;
            string tUrl = txtWebSiteURL.Text;
            int depth = (int)nbrDepth.Value;
            int width = (int)nbrOutboundLinks.Value;
            bool RC = true;
            string RetentionCode = cbWebSiteRetention.Text;
            DBARCH.Save_WebSiteURL(modGlobals.gGateWayID, tName, tUrl, depth, width, RetentionCode, modGlobals.gCurrUserGuidID, ref RC);
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (RC)
            {
                GetWebSite(modGlobals.gGateWayID);
            }
            else
            {
                MessageBox.Show("Failed to save WEB Page: " + tName);
            }
        }

        private void btnRemoveWebSite_Click(object sender, EventArgs e)
        {
            int I = dgWebSite.SelectedRows.Count;
            if (I != 1)
            {
                MessageBox.Show("One and only one row must be selected.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tName = txtWebSiteName.Text;
            string tUrl = txtWebSiteURL.Text;
            int depth = (int)nbrDepth.Value;
            int width = (int)nbrOutboundLinks.Value;
            bool RC = true;
            string MySql = "delete from WebSite where WebSite = '" + tName + "' and UserID = '" + modGlobals.gCurrUserGuidID + "' ";
            RC = DBARCH.ExecuteSqlNewConn(90325, MySql);
            if (RC)
            {
                GetWebSite(modGlobals.gGateWayID);
            }
            else
            {
                MessageBox.Show("Failed to delete WEB Page A8: " + tName);
            }
        }

        private void btnRemoveWebPage_Click(object sender, EventArgs e)
        {
            int I = dgWebPage.SelectedRows.Count;
            if (I != 1)
            {
                MessageBox.Show("One and only one row must be selected.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tName = txtWebScreenName.Text;
            string tUrl = txtWebScreenUrl.Text;
            bool RC = true;
            string MySql = "delete from WebScreen where WebScreen = '" + tName + "' and UserID = '" + modGlobals.gCurrUserGuidID + "' ";
            RC = DBARCH.ExecuteSqlNewConn(90326, MySql);
            if (RC)
            {
                GetWebPage(modGlobals.gGateWayID);
            }
            else
            {
                MessageBox.Show("Failed to DELETE WEB Page A9: " + tName);
            }
        }

        private void btnRemoveRSSfeed_Click(object sender, EventArgs e)
        {
            int I = dgRss.SelectedRows.Count;
            if (I != 1)
            {
                MessageBox.Show("One and only one row must be selected.");
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tName = txtRssName.Text;
            string tUrl = txtRssURL.Text;
            bool RC = true;
            string MySql = "delete from rssPull where RssName = '" + tName + "' and UserID = '" + modGlobals.gCurrUserGuidID + "' ";
            RC = DBARCH.ExecuteSqlNewConn(90327, MySql);
            if (RC)
            {
                GetRSS(modGlobals.gGateWayID);
            }
            else
            {
                MessageBox.Show("Failed to DELETE RSS Feed A10: " + tName);
            }
        }

        private void dgRss_MouseClick(object sender, MouseEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            SB.Text = "RSS Grid has " + dgRss.Rows.Count.ToString() + " rows.";
        }

        private void dgRss_SelectionChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int I = dgRss.SelectedRows.Count;
            if (I == 1)
            {
                var DR = dgRss.SelectedRows[0];
                txtRssName.Text = DR.Cells["RssName"].Value.ToString();
                txtRssURL.Text = DR.Cells["RssURL"].Value.ToString();
                cbRssRetention.Text = DR.Cells["RetentionCode"].Value.ToString();
            }
            else
            {
                SB.Text = "Only one row can be selected.";
            }
        }

        private void dgWebPage_SelectionChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int I = dgWebPage.SelectedRows.Count;
            if (I == 1)
            {
                var DR = dgWebPage.SelectedRows[0];
                txtWebScreenName.Text = DR.Cells["WebScreen"].Value.ToString();
                txtWebScreenUrl.Text = DR.Cells["WebUrl"].Value.ToString();
                cbWebPageRetention.Text = DR.Cells["RetentionCode"].Value.ToString();
            }
            else
            {
                SB.Text = "Only one row can be selected.";
            }
        }

        private void dgWebSite_SelectionChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int I = dgWebSite.SelectedRows.Count;
            if (I == 1)
            {
                var DR = dgWebSite.SelectedRows[0];
                txtWebSiteName.Text = DR.Cells["WebSite"].Value.ToString();
                txtWebSiteURL.Text = DR.Cells["WebUrl"].Value.ToString();
                nbrDepth.Value = Conversions.ToDecimal(DR.Cells["Depth"].Value);
                nbrOutboundLinks.Value = Conversions.ToDecimal(DR.Cells["Width"].Value);
                cbWebSiteRetention.Text = DR.Cells["RetentionCode"].Value.ToString();
            }
            else
            {
                SB.Text = "Only one row can be selected.";
            }
        }

        private void AsyncRssPull_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string isPublic = "N";
            string RetentionCode = "Retain 10";
            if (ckTerminate.Checked)
            {
                if (!modGlobals.gRunUnattended)
                {
                    MessageBox.Show("The TERMINATE immediately box is checked, returning.");
                    return;
                }
                else
                {
                    LOG.WriteToArchiveLog("AsyncRssPull_DoWork: The TERMINATE immediately box is checked, returning.");
                }
            }

            if (ckDisable.Checked)
            {
                ArchiveALLToolStripMenuItem.Enabled = true;
                ContentToolStripMenuItem.Enabled = true;
                ExchangeEmailsToolStripMenuItem.Enabled = true;
                OutlookEmailsToolStripMenuItem.Enabled = true;
                return;
            }

            if (ckRssPullDisabled.Checked)
            {
                return;
            }

            ARCH.ArchiveRSS(modGlobals.gCurrUserGuidID);
        }

        private void asyncSpiderWebSite_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string isPublic = "N";
            string RetentionCode = "Retain 10";
            if (ckTerminate.Checked)
            {
                if (!modGlobals.gRunUnattended)
                {
                    MessageBox.Show("The TERMINATE immediately box is checked, returning.");
                    return;
                }
                else
                {
                    LOG.WriteToArchiveLog("asyncSpiderWebSite_DoWork: The TERMINATE immediately box is checked, returning.");
                }
            }

            if (ckDisable.Checked)
            {
                // SB.Text = "DISABLE ALL is checked - no archive allowed."
                ArchiveALLToolStripMenuItem.Enabled = true;
                ContentToolStripMenuItem.Enabled = true;
                ExchangeEmailsToolStripMenuItem.Enabled = true;
                OutlookEmailsToolStripMenuItem.Enabled = true;
                return;
            }

            if (ckWebSiteTrackerDisabled.Checked)
            {
                // SB.Text = "DISABLE WEB Site Archive checked - no archive allowed."
                return;
            }

            ARCH.ArchiveWebSites(modGlobals.gCurrUserGuidID);
        }

        private void AsyncSpiderWebPage_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string isPublic = "N";
            string RetentionCode = "Retain 10";
            if (ckTerminate.Checked)
            {
                if (!modGlobals.gRunUnattended)
                {
                    MessageBox.Show("The TERMINATE immediately box is checked, returning.");
                    return;
                }
                else
                {
                    LOG.WriteToArchiveLog("AsyncSpiderWebPage_DoWork: The TERMINATE immediately box is checked, returning.");
                }
            }

            if (ckDisable.Checked)
            {
                // SB.Text = "DISABLE ALL is checked - no archive allowed."
                ArchiveALLToolStripMenuItem.Enabled = true;
                ContentToolStripMenuItem.Enabled = true;
                ExchangeEmailsToolStripMenuItem.Enabled = true;
                OutlookEmailsToolStripMenuItem.Enabled = true;
                return;
            }

            if (ckWebPageTrackerDisabled.Checked)
            {
                // SB.Text = "DISABLE WEB Page Archive checked - no archive allowed."
                return;
            }

            ARCH.ArchiveSingleWebPage(modGlobals.gCurrUserGuidID);
        }

        private void RetentionRulesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmRetentionCode.ShowDialog();
        }

        private void RulesExecutionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmRetentionMgt.ShowDialog();
        }

        private void CheckForUpdatesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            UpdateCheckInfo info = null;
            if (ApplicationDeployment.IsNetworkDeployed)
            {
                var AD = ApplicationDeployment.CurrentDeployment;
                try
                {
                    info = AD.CheckForDetailedUpdate();
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (DeploymentDownloadException dde)
                {
                    MessageBox.Show("The new version of the application cannot be downloaded at this time. " + Conversions.ToString(ControlChars.Lf) + ControlChars.Lf + "Please check your network connection, or try again later. Error: " + dde.Message);
                    return;
                }
                catch (InvalidOperationException ioe)
                {
                    MessageBox.Show("This application cannot be updated. It is likely not a ClickOnce application. Error: " + ioe.Message);
                    return;
                }

                if (info.UpdateAvailable)
                {
                    bool doUpdate = true;
                    if (!info.IsUpdateRequired)
                    {
                        var dr = MessageBox.Show("An update is available. Would you like to update the application now?", "Update Available", MessageBoxButtons.OKCancel);
                        if (!(DialogResult.OK == dr))
                        {
                            doUpdate = false;
                        }
                    }
                    else
                    {
                        // Display a message that the app MUST reboot. Display the minimum required version.
                        MessageBox.Show("This application has detected a mandatory update from your current " + "version to version " + info.MinimumRequiredVersion.ToString() + ". The application will now install the update and restart.", "Update Available", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }

                    if (doUpdate)
                    {
                        try
                        {
                            AD.Update();
                            MessageBox.Show("The application has been upgraded, and will now restart.");
                            Application.Restart();
                        }
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (DeploymentDownloadException dde)
                        {
                            MessageBox.Show("Cannot install the latest version of the application. " + ControlChars.Lf + ControlChars.Lf + "Please check your network connection, or try again later.");
                            return;
                        }
                    }
                }
            }
        }

        // Private Sub ShowEndpointsToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ShowEndpointsToolStripMenuItem.Click

        // Dim strProxyFS As String = "" Dim strProxyArchive As String = "" Dim strProxySearch As String =
        // "" Dim strProxyGateway As String = ""

        // strProxyFS = ProxyFS.Endpoint.Address.ToString strProxyArchive =
        // ProxyArchive.Endpoint.Address.ToString strProxySearch = ProxySearch.Endpoint.Address.ToString

        // 'strProxyGateway = ProxyGateway.Endpoint.Address.ToString

        // Dim s As String = "CURRENT END POINTS:" + vbCrLf
        // s += "SVCFS: " + strProxyFS + vbCrLf
        // s += "SVCGateway: " + strProxyGateway + vbCrLf
        // s += "SVCCLCArchive: " + strProxyArchive + vbCrLf
        // s += "SVCSearch: " + strProxySearch + vbCrLf
        // MessageBox.Show(s)
        // End Sub

        private void ShowSystemVersionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string OSVersion = Environment.OSVersion.ToString();
            string OSVersionMajor = Environment.OSVersion.Version.Major.ToString();
            string OSVersionMinor = Environment.OSVersion.Version.Minor.ToString();
            string OSVersionMinorRev = Environment.OSVersion.Version.MinorRevision.ToString();
            MessageBox.Show(OSVersion);
        }

        private void ClearRestoreQueueToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool b = DBARCH.ClearRestoreQueue(modGlobals.gGateWayID, modGlobals.gCurrLoginID);
            if (b == true)
            {
                MessageBox.Show("Cleared queue.");
            }
            else
            {
                MessageBox.Show("Failed to clear queue.");
            }
        }

        private string UnicodeBytesToString(byte[] bytes)
        {
            return System.Text.Encoding.Unicode.GetString(bytes);
        }

        private byte[] UnicodeStringToBytes(string str)
        {
            return System.Text.Encoding.Unicode.GetBytes(str);
        }

        private void SelectedFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OpenFileDialog1.Multiselect = true;
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FilesProcessed = "";
            byte[] AttachmentBinary = null;
            var CF = new clsFile();
            byte[] FileBytes = null;
            var ListOfFiles = new List<DS_Content>();
            var FileDetails = new DS_Content();
            var result = OpenFileDialog1.ShowDialog();
            var tDict = new Dictionary<string, string>();
            string FQN = "";
            if (result == DialogResult.OK)
            {
                string CurrUserGuidID = DBARCH.getUserGuidID(modGlobals.gUserID);
                try
                {
                    for (int I = 0, loopTo = OpenFileDialog1.FileNames.Count() - 1; I <= loopTo; I++)
                    {
                        tDict.Clear();
                        FQN = OpenFileDialog1.FileNames[I];
                        // Dim AttachmentBinary() As Byte = File.ReadAllBytes(FQN)
                        try
                        {
                            AttachmentBinary = File.ReadAllBytes(FQN);
                        }
                        // AttachmentBinary = My.Computer.FileSystem.ReadAllBytes(FQN)
                        catch (ThreadAbortException ex)
                        {
                            LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                            Thread.ResetAbort();
                        }
                        catch (Exception ex)
                        {
                            AttachmentBinary = null;
                            MessageBox.Show("ERROR: " + ex.Message);
                        }

                        if (AttachmentBinary.Length.Equals(0))
                        {
                            MessageBox.Show(FQN + " Has 0 bytes... skipping");
                            goto NEXTONE;
                        }

                        tDict.Add("CRC", ENC.GenerateSHA512HashFromFile(FQN));
                        tDict.Add("ImageHash", ENC.GenerateSHA512HashFromFile(FQN));
                        FileBytes = File.ReadAllBytes(FQN);
                        var myFile = new FileInfo(FQN);
                        long sizeInBytes = myFile.Length;
                        bool bGraphic = ckIsGraphic(myFile.Extension);
                        tDict.Add("RowGuid", Guid.NewGuid().ToString());
                        tDict.Add("SourceGuid", Guid.NewGuid().ToString());
                        tDict.Add("CreateDate", Conversions.ToString(myFile.CreationTime));
                        tDict.Add("SourceName", myFile.Name);
                        tDict.Add("SourceImage", UnicodeBytesToString(FileBytes));
                        tDict.Add("SourceTypeCode", myFile.Extension);
                        tDict.Add("FQN", myFile.FullName);
                        tDict.Add("VersionNbr", "");
                        tDict.Add("LastAccessDate", Conversions.ToString(myFile.LastAccessTime));
                        tDict.Add("FileLength", myFile.Length.ToString());
                        tDict.Add("LastWriteTime", myFile.LastAccessTime.ToString());
                        tDict.Add("UserID", modGlobals.gUserID);
                        tDict.Add("DataSourceOwnerUserID", modGlobals.gUserID);
                        tDict.Add("isPublic", "1");
                        tDict.Add("FileDirectory", myFile.DirectoryName);
                        tDict.Add("OriginalFileType", myFile.Extension);
                        tDict.Add("RetentionExpirationDate", "");
                        tDict.Add("IsPublicPreviousState", "");
                        tDict.Add("isAvailable", "1");
                        tDict.Add("isContainedWithinZipFile", "0");
                        bool bZipfile = ckIsZipFile(myFile.Extension);
                        if (bZipfile)
                        {
                            tDict.Add("IsZipFile", "1");
                        }
                        else
                        {
                            tDict.Add("IsZipFile", "0");
                        }

                        tDict.Add("DataVerified", "");
                        tDict.Add("ZipFileGuid", "");
                        if (bZipfile)
                        {
                            tDict.Add("ZipFileFQN", FQN);
                        }
                        else
                        {
                            tDict.Add("ZipFileFQN", "");
                        }

                        tDict.Add("Description", "");
                        tDict.Add("KeyWords", "");
                        tDict.Add("Notes", "");
                        tDict.Add("isPerm", "1");
                        tDict.Add("isMaster", "");
                        tDict.Add("CreationDate", myFile.CreationTime.ToString());
                        tDict.Add("OcrPerformed", "0");
                        if (bGraphic)
                        {
                            tDict.Add("isGraphic", "1");
                        }
                        else
                        {
                            tDict.Add("isGraphic", "0");
                        }

                        tDict.Add("GraphicContainsText", "");
                        tDict.Add("OcrText", "");
                        tDict.Add("ImageHiddenText", "");
                        tDict.Add("isWebPage", "0");
                        tDict.Add("ParentGuid", "");
                        tDict.Add("RetentionCode", "Retain 10");
                        tDict.Add("MachineID", modGlobals.gMachineID);
                        tDict.Add("SharePoint", "");
                        tDict.Add("SharePointDoc", "");
                        tDict.Add("SharePointList", "");
                        tDict.Add("SharePointListItem", "");
                        tDict.Add("StructuredData", "");
                        tDict.Add("HiveConnectionName", "");
                        tDict.Add("HiveActive", "");
                        tDict.Add("RepoSvrName", modGlobals.gServerInstanceName);
                        tDict.Add("RowCreationDate", DateAndTime.Now.ToString());
                        tDict.Add("RowLastModDate", DateAndTime.Now.ToString());
                        tDict.Add("ContainedWithin", "");
                        tDict.Add("RecLen", "");
                        tDict.Add("RecHash", "");
                        tDict.Add("OriginalSize", sizeInBytes.ToString());
                        tDict.Add("CompressedSize", "");
                        tDict.Add("txStartTime", DateAndTime.Now.ToString());
                        tDict.Add("txEndTime", "");
                        tDict.Add("txTotalTime", "");
                        tDict.Add("TransmitTime", "");
                        tDict.Add("FileAttached", "");
                        tDict.Add("BPS", "");
                        tDict.Add("RepoName", modGlobals.gServerInstanceName);
                        tDict.Add("HashFile", ENC.GenerateSHA512HashFromFile(FQN));
                        tDict.Add("HashName", "Sha1");
                        tDict.Add("OcrSuccessful", "");
                        if (bGraphic)
                        {
                            tDict.Add("OcrPending", "1");
                        }
                        else
                        {
                            tDict.Add("OcrPending", "0");
                        }

                        tDict.Add("PdfIsSearchable", "");
                        tDict.Add("PdfOcrRequired", "");
                        tDict.Add("PdfOcrSuccess", "");
                        tDict.Add("PdfOcrTextExtracted", "");
                        tDict.Add("PdfPages", "");
                        tDict.Add("PdfImages", "");
                        if (bGraphic)
                        {
                            tDict.Add("RequireOcr", "1");
                        }
                        else
                        {
                            tDict.Add("RequireOcr", "0");
                        }

                        tDict.Add("RssLinkFlg", "");
                        tDict.Add("RssLinkGuid", "");
                        tDict.Add("PageURL", "");
                        tDict.Add("RetentionDate", "");
                        tDict.Add("URLHash", "");
                        tDict.Add("WebPagePublishDate", "");
                        tDict.Add("SapData", "");
                        tDict.Add("RowID", "");
                        myFile = null;
                        string RowID = DBARCH.ckContentExists(tDict["SourceName"], tDict["ImageHash"]);
                        if (RowID.Length.Equals(0))
                        {
                            bool b = DBARCH.insertNewContent(tDict, FileBytes, "FILE");
                            if (b)
                            {
                                SB.Text = "Inserted: " + FQN;
                                SB.Refresh();
                                FilesProcessed += tDict["SourceName"] + Constants.vbCrLf;
                            }
                        }
                        else
                        {
                            bool b = DBARCH.updateExistingContent(tDict, RowID, FileBytes);
                            if (b)
                            {
                                SB.Text = "Updated: " + FQN;
                                SB.Refresh();
                                FilesProcessed += tDict["SourceName"] + Constants.vbCrLf;
                            }
                        }

                        NEXTONE:
                        ;
                    }
                }
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    SB.Text = "Error   " + FQN + " @ " + ex.Message.ToString();
                }

                MessageBox.Show("FILES PROCESSED:" + Constants.vbCrLf + FilesProcessed);
                CF = null;
            }
        }

        private void btnArchive1Doc_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            SelectedFilesToolStripMenuItem_Click(null, null);
        }

        public string getContentlDictValue(string tkey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tval = "";
            switch (tkey ?? "")
            {
                case "RowGuid":
                    {
                        tval = modGlobals.DictContent["RowGuid"];
                        break;
                    }

                case "SourceGuid":
                    {
                        tval = modGlobals.DictContent["SourceGuid"];
                        break;
                    }

                case "CreateDate":
                    {
                        tval = modGlobals.DictContent["CreateDate"];
                        break;
                    }

                case "SourceName":
                    {
                        tval = modGlobals.DictContent["SourceName"];
                        break;
                    }

                case "SourceImage":
                    {
                        tval = modGlobals.DictContent["SourceImage"];
                        break;
                    }

                case "SourceTypeCode":
                    {
                        tval = modGlobals.DictContent["SourceTypeCode"];
                        break;
                    }

                case "FQN":
                    {
                        tval = modGlobals.DictContent["FQN"];
                        break;
                    }

                case "VersionNbr":
                    {
                        tval = modGlobals.DictContent["VersionNbr"];
                        break;
                    }

                case "LastAccessDate":
                    {
                        tval = modGlobals.DictContent["LastAccessDate"];
                        break;
                    }

                case "FileLength":
                    {
                        tval = modGlobals.DictContent["FileLength"];
                        break;
                    }

                case "LastWriteTime":
                    {
                        tval = modGlobals.DictContent["LastWriteTime"];
                        break;
                    }

                case "UserID":
                    {
                        tval = modGlobals.DictContent["UserID"];
                        break;
                    }

                case "DataSourceOwnerUserID":
                    {
                        tval = modGlobals.DictContent["DataSourceOwnerUserID"];
                        break;
                    }

                case "isPublic":
                    {
                        tval = modGlobals.DictContent["isPublic"];
                        break;
                    }

                case "FileDirectory":
                    {
                        tval = modGlobals.DictContent["FileDirectory"];
                        break;
                    }

                case "OriginalFileType":
                    {
                        tval = modGlobals.DictContent["OriginalFileType"];
                        break;
                    }

                case "RetentionExpirationDate":
                    {
                        tval = modGlobals.DictContent["RetentionExpirationDate"];
                        break;
                    }

                case "IsPublicPreviousState":
                    {
                        tval = modGlobals.DictContent["IsPublicPreviousState"];
                        break;
                    }

                case "isAvailable":
                    {
                        tval = modGlobals.DictContent["isAvailable"];
                        break;
                    }

                case "isContainedWithinZipFile":
                    {
                        tval = modGlobals.DictContent["isContainedWithinZipFile"];
                        break;
                    }

                case "IsZipFile":
                    {
                        tval = modGlobals.DictContent["IsZipFile"];
                        break;
                    }

                case "DataVerified":
                    {
                        tval = modGlobals.DictContent["DataVerified"];
                        break;
                    }

                case "ZipFileGuid":
                    {
                        tval = modGlobals.DictContent["ZipFileGuid"];
                        break;
                    }

                case "ZipFileFQN":
                    {
                        tval = modGlobals.DictContent["ZipFileFQN"];
                        break;
                    }

                case "Description":
                    {
                        tval = modGlobals.DictContent["Description"];
                        break;
                    }

                case "KeyWords":
                    {
                        tval = modGlobals.DictContent["KeyWords"];
                        break;
                    }

                case "Notes":
                    {
                        tval = modGlobals.DictContent["Notes"];
                        break;
                    }

                case "isPerm":
                    {
                        tval = modGlobals.DictContent["isPerm"];
                        break;
                    }

                case "isMaster":
                    {
                        tval = modGlobals.DictContent["isMaster"];
                        break;
                    }

                case "CreationDate":
                    {
                        tval = modGlobals.DictContent["CreationDate"];
                        break;
                    }

                case "OcrPerformed":
                    {
                        tval = modGlobals.DictContent["OcrPerformed"];
                        break;
                    }

                case "isGraphic":
                    {
                        tval = modGlobals.DictContent["isGraphic"];
                        break;
                    }

                case "GraphicContainsText":
                    {
                        tval = modGlobals.DictContent["GraphicContainsText"];
                        break;
                    }

                case "OcrText":
                    {
                        tval = modGlobals.DictContent["OcrText"];
                        break;
                    }

                case "ImageHiddenText":
                    {
                        tval = modGlobals.DictContent["ImageHiddenText"];
                        break;
                    }

                case "isWebPage":
                    {
                        tval = modGlobals.DictContent["isWebPage"];
                        break;
                    }

                case "ParentGuid":
                    {
                        tval = modGlobals.DictContent["ParentGuid"];
                        break;
                    }

                case "RetentionCode":
                    {
                        tval = modGlobals.DictContent["RetentionCode"];
                        break;
                    }

                case "MachineID":
                    {
                        tval = modGlobals.DictContent["MachineID"];
                        break;
                    }

                case "CRC":
                    {
                        tval = modGlobals.DictContent["CRC"];
                        break;
                    }

                case "ImageHash":
                    {
                        tval = modGlobals.DictContent["ImageHash"];
                        break;
                    }

                case "SharePoint":
                    {
                        tval = modGlobals.DictContent["SharePoint"];
                        break;
                    }

                case "SharePointDoc":
                    {
                        tval = modGlobals.DictContent["SharePointDoc"];
                        break;
                    }

                case "SharePointList":
                    {
                        tval = modGlobals.DictContent["SharePointList"];
                        break;
                    }

                case "SharePointListItem":
                    {
                        tval = modGlobals.DictContent["SharePointListItem"];
                        break;
                    }

                case "StructuredData":
                    {
                        tval = modGlobals.DictContent["StructuredData"];
                        break;
                    }

                case "HiveConnectionName":
                    {
                        tval = modGlobals.DictContent["HiveConnectionName"];
                        break;
                    }

                case "HiveActive":
                    {
                        tval = modGlobals.DictContent["HiveActive"];
                        break;
                    }

                case "RepoSvrName":
                    {
                        tval = modGlobals.DictContent["RepoSvrName"];
                        break;
                    }

                case "RowCreationDate":
                    {
                        tval = modGlobals.DictContent["RowCreationDate"];
                        break;
                    }

                case "RowLastModDate":
                    {
                        tval = modGlobals.DictContent["RowLastModDate"];
                        break;
                    }

                case "ContainedWithin":
                    {
                        tval = modGlobals.DictContent["ContainedWithin"];
                        break;
                    }

                case "RecLen":
                    {
                        tval = modGlobals.DictContent["RecLen"];
                        break;
                    }

                case "RecHash":
                    {
                        tval = modGlobals.DictContent["RecHash"];
                        break;
                    }

                case "OriginalSize":
                    {
                        tval = modGlobals.DictContent["OriginalSize"];
                        break;
                    }

                case "CompressedSize":
                    {
                        tval = modGlobals.DictContent["CompressedSize"];
                        break;
                    }

                case "txStartTime":
                    {
                        tval = modGlobals.DictContent["txStartTime"];
                        break;
                    }

                case "txEndTime":
                    {
                        tval = modGlobals.DictContent["txEndTime"];
                        break;
                    }

                case "txTotalTime":
                    {
                        tval = modGlobals.DictContent["txTotalTime"];
                        break;
                    }

                case "TransmitTime":
                    {
                        tval = modGlobals.DictContent["TransmitTime"];
                        break;
                    }

                case "FileAttached":
                    {
                        tval = modGlobals.DictContent["FileAttached"];
                        break;
                    }

                case "BPS":
                    {
                        tval = modGlobals.DictContent["BPS"];
                        break;
                    }

                case "RepoName":
                    {
                        tval = modGlobals.DictContent["RepoName"];
                        break;
                    }

                case "HashFile":
                    {
                        tval = modGlobals.DictContent["HashFile"];
                        break;
                    }

                case "HashName":
                    {
                        tval = modGlobals.DictContent["HashName"];
                        break;
                    }

                case "OcrSuccessful":
                    {
                        tval = modGlobals.DictContent["OcrSuccessful"];
                        break;
                    }

                case "OcrPending":
                    {
                        tval = modGlobals.DictContent["OcrPending"];
                        break;
                    }

                case "PdfIsSearchable":
                    {
                        tval = modGlobals.DictContent["PdfIsSearchable"];
                        break;
                    }

                case "PdfOcrRequired":
                    {
                        tval = modGlobals.DictContent["PdfOcrRequired"];
                        break;
                    }

                case "PdfOcrSuccess":
                    {
                        tval = modGlobals.DictContent["PdfOcrSuccess"];
                        break;
                    }

                case "PdfOcrTextExtracted":
                    {
                        tval = modGlobals.DictContent["PdfOcrTextExtracted"];
                        break;
                    }

                case "PdfPages":
                    {
                        tval = modGlobals.DictContent["PdfPages"];
                        break;
                    }

                case "PdfImages":
                    {
                        tval = modGlobals.DictContent["PdfImages"];
                        break;
                    }

                case "RequireOcr":
                    {
                        tval = modGlobals.DictContent["RequireOcr"];
                        break;
                    }

                case "RssLinkFlg":
                    {
                        tval = modGlobals.DictContent["RssLinkFlg"];
                        break;
                    }

                case "RssLinkGuid":
                    {
                        tval = modGlobals.DictContent["RssLinkGuid"];
                        break;
                    }

                case "PageURL":
                    {
                        tval = modGlobals.DictContent["PageURL"];
                        break;
                    }

                case "RetentionDate":
                    {
                        tval = modGlobals.DictContent["RetentionDate"];
                        break;
                    }

                case "URLHash":
                    {
                        tval = modGlobals.DictContent["URLHash"];
                        break;
                    }

                case "WebPagePublishDate":
                    {
                        tval = modGlobals.DictContent["WebPagePublishDate"];
                        break;
                    }

                case "SapData":
                    {
                        tval = modGlobals.DictContent["SapData"];
                        break;
                    }

                case "RowID":
                    {
                        tval = modGlobals.DictContent["RowID"];
                        break;
                    }
            }

            return tval;
        }

        public string getEmailDictValue(string tkey)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tval = "";
            switch (tkey ?? "")
            {
                case "EmailGuid":
                    {
                        tval = modGlobals.DictEmails["EmailGuid"];
                        break;
                    }

                case "SUBJECT":
                    {
                        tval = modGlobals.DictEmails["SUBJECT"];
                        break;
                    }

                case "SentTO":
                    {
                        tval = modGlobals.DictEmails["SentTO"];
                        break;
                    }

                case "Body":
                    {
                        tval = modGlobals.DictEmails["Body"];
                        break;
                    }

                case "Bcc":
                    {
                        tval = modGlobals.DictEmails["Bcc"];
                        break;
                    }

                case "BillingInformation":
                    {
                        tval = modGlobals.DictEmails["BillingInformation"];
                        break;
                    }

                case "CC":
                    {
                        tval = modGlobals.DictEmails["CC"];
                        break;
                    }

                case "Companies":
                    {
                        tval = modGlobals.DictEmails["Companies"];
                        break;
                    }

                case "CreationTime":
                    {
                        tval = modGlobals.DictEmails["CreationTime"];
                        break;
                    }

                case "ReadReceiptRequested":
                    {
                        tval = modGlobals.DictEmails["ReadReceiptRequested"];
                        break;
                    }

                case "ReceivedByName":
                    {
                        tval = modGlobals.DictEmails["ReceivedByName"];
                        break;
                    }

                case "ReceivedTime":
                    {
                        tval = modGlobals.DictEmails["ReceivedTime"];
                        break;
                    }

                case "AllRecipients":
                    {
                        tval = modGlobals.DictEmails["AllRecipients"];
                        break;
                    }

                case "UserID":
                    {
                        tval = modGlobals.DictEmails["UserID"];
                        break;
                    }

                case "SenderEmailAddress":
                    {
                        tval = modGlobals.DictEmails["SenderEmailAddress"];
                        break;
                    }

                case "SenderName":
                    {
                        tval = modGlobals.DictEmails["SenderName"];
                        break;
                    }

                case "Sensitivity":
                    {
                        tval = modGlobals.DictEmails["Sensitivity"];
                        break;
                    }

                case "SentOn":
                    {
                        tval = modGlobals.DictEmails["SentOn"];
                        break;
                    }

                case "MsgSize":
                    {
                        tval = modGlobals.DictEmails["MsgSize"];
                        break;
                    }

                case "DeferredDeliveryTime":
                    {
                        tval = modGlobals.DictEmails["DeferredDeliveryTime"];
                        break;
                    }

                case "EntryID":
                    {
                        tval = modGlobals.DictEmails["EntryID"];
                        break;
                    }

                case "ExpiryTime":
                    {
                        tval = modGlobals.DictEmails["ExpiryTime"];
                        break;
                    }

                case "LastModificationTime":
                    {
                        tval = modGlobals.DictEmails["LastModificationTime"];
                        break;
                    }

                case "EmailImage":
                    {
                        tval = modGlobals.DictEmails["EmailImage"];
                        break;
                    }

                case "Accounts":
                    {
                        tval = modGlobals.DictEmails["Accounts"];
                        break;
                    }

                case "ShortSubj":
                    {
                        tval = modGlobals.DictEmails["ShortSubj"];
                        break;
                    }

                case "SourceTypeCode":
                    {
                        tval = modGlobals.DictEmails["SourceTypeCode"];
                        break;
                    }

                case "OriginalFolder":
                    {
                        tval = modGlobals.DictEmails["OriginalFolder"];
                        break;
                    }

                case "StoreID":
                    {
                        tval = modGlobals.DictEmails["StoreID"];
                        break;
                    }

                case "isPublic":
                    {
                        tval = modGlobals.DictEmails["isPublic"];
                        break;
                    }

                case "RetentionExpirationDate":
                    {
                        tval = modGlobals.DictEmails["RetentionExpirationDate"];
                        break;
                    }

                case "IsPublicPreviousState":
                    {
                        tval = modGlobals.DictEmails["IsPublicPreviousState"];
                        break;
                    }

                case "isAvailable":
                    {
                        tval = modGlobals.DictEmails["isAvailable"];
                        break;
                    }

                case "CurrMailFolderID":
                    {
                        tval = modGlobals.DictEmails["CurrMailFolderID"];
                        break;
                    }

                case "isPerm":
                    {
                        tval = modGlobals.DictEmails["isPerm"];
                        break;
                    }

                case "isMaster":
                    {
                        tval = modGlobals.DictEmails["isMaster"];
                        break;
                    }

                case "CreationDate":
                    {
                        tval = modGlobals.DictEmails["CreationDate"];
                        break;
                    }

                case "NbrAttachments":
                    {
                        tval = modGlobals.DictEmails["NbrAttachments"];
                        break;
                    }

                case "CRC":
                    {
                        tval = modGlobals.DictEmails["CRC"];
                        break;
                    }

                case "ImageHash":
                    {
                        tval = modGlobals.DictContent["ImageHash"];
                        break;
                    }

                case "Description":
                    {
                        tval = modGlobals.DictEmails["Description"];
                        break;
                    }

                case "KeyWords":
                    {
                        tval = modGlobals.DictEmails["KeyWords"];
                        break;
                    }

                case "RetentionCode":
                    {
                        tval = modGlobals.DictEmails["RetentionCode"];
                        break;
                    }

                case "EmailIdentifier":
                    {
                        tval = modGlobals.DictEmails["EmailIdentifier"];
                        break;
                    }

                case "ConvertEmlToMSG":
                    {
                        tval = modGlobals.DictEmails["ConvertEmlToMSG"];
                        break;
                    }

                case "HiveConnectionName":
                    {
                        tval = modGlobals.DictEmails["HiveConnectionName"];
                        break;
                    }

                case "HiveActive":
                    {
                        tval = modGlobals.DictEmails["HiveActive"];
                        break;
                    }

                case "RepoSvrName":
                    {
                        tval = modGlobals.DictEmails["RepoSvrName"];
                        break;
                    }

                case "RowCreationDate":
                    {
                        tval = modGlobals.DictEmails["RowCreationDate"];
                        break;
                    }

                case "RowLastModDate":
                    {
                        tval = modGlobals.DictEmails["RowLastModDate"];
                        break;
                    }

                case "UIDL":
                    {
                        tval = modGlobals.DictEmails["UIDL"];
                        break;
                    }

                case "RecLen":
                    {
                        tval = modGlobals.DictEmails["RecLen"];
                        break;
                    }

                case "RecHash":
                    {
                        tval = modGlobals.DictEmails["RecHash"];
                        break;
                    }

                case "OriginalSize":
                    {
                        tval = modGlobals.DictEmails["OriginalSize"];
                        break;
                    }

                case "CompressedSize":
                    {
                        tval = modGlobals.DictEmails["CompressedSize"];
                        break;
                    }

                case "txStartTime":
                    {
                        tval = modGlobals.DictEmails["txStartTime"];
                        break;
                    }

                case "txEndTime":
                    {
                        tval = modGlobals.DictEmails["txEndTime"];
                        break;
                    }

                case "txTotalTime":
                    {
                        tval = modGlobals.DictEmails["txTotalTime"];
                        break;
                    }

                case "TransmitTime":
                    {
                        tval = modGlobals.DictEmails["TransmitTime"];
                        break;
                    }

                case "FileAttached":
                    {
                        tval = modGlobals.DictEmails["FileAttached"];
                        break;
                    }

                case "BPS":
                    {
                        tval = modGlobals.DictEmails["BPS"];
                        break;
                    }

                case "RepoName":
                    {
                        tval = modGlobals.DictEmails["RepoName"];
                        break;
                    }

                case "HashFile":
                    {
                        tval = modGlobals.DictEmails["HashFile"];
                        break;
                    }

                case "HashName":
                    {
                        tval = modGlobals.DictEmails["HashName"];
                        break;
                    }

                case "ContainsAttachment":
                    {
                        tval = modGlobals.DictEmails["ContainsAttachment"];
                        break;
                    }

                case "NbrAttachment":
                    {
                        tval = modGlobals.DictEmails["NbrAttachment"];
                        break;
                    }

                case "NbrZipFiles":
                    {
                        tval = modGlobals.DictEmails["NbrZipFiles"];
                        break;
                    }

                case "NbrZipFilesCnt":
                    {
                        tval = modGlobals.DictEmails["NbrZipFilesCnt"];
                        break;
                    }

                case "PdfIsSearchable":
                    {
                        tval = modGlobals.DictEmails["PdfIsSearchable"];
                        break;
                    }

                case "PdfOcrRequired":
                    {
                        tval = modGlobals.DictEmails["PdfOcrRequired"];
                        break;
                    }

                case "PdfOcrSuccess":
                    {
                        tval = modGlobals.DictEmails["PdfOcrSuccess"];
                        break;
                    }

                case "PdfOcrTextExtracted":
                    {
                        tval = modGlobals.DictEmails["PdfOcrTextExtracted"];
                        break;
                    }

                case "PdfPages":
                    {
                        tval = modGlobals.DictEmails["PdfPages"];
                        break;
                    }

                case "PdfImages":
                    {
                        tval = modGlobals.DictEmails["PdfImages"];
                        break;
                    }

                case "MachineID":
                    {
                        tval = modGlobals.DictEmails["MachineID"];
                        break;
                    }

                case "notes":
                    {
                        tval = modGlobals.DictEmails["notes"];
                        break;
                    }

                case "NbrOccurances":
                    {
                        tval = modGlobals.DictEmails["NbrOccurances"];
                        break;
                    }

                case "RowID":
                    {
                        tval = modGlobals.DictEmails["RowID"];
                        break;
                    }

                case "RowGuid":
                    {
                        tval = modGlobals.DictEmails["RowGuid"];
                        break;
                    }
            }

            return tval;
        }

        public bool fillEmailDict()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string EmailGuid = "";
            string SUBJECT = "";
            string SentTO = "";
            string Body = "";
            string Bcc = "";
            string BillingInformation = "";
            string CC = "";
            string Companies = "";
            string CreationTime = "";
            string ReadReceiptRequested = "";
            string ReceivedByName = "";
            string ReceivedTime = "";
            string AllRecipients = "";
            string UserID = "";
            string SenderEmailAddress = "";
            string SenderName = "";
            string Sensitivity = "";
            string SentOn = "";
            string MsgSize = "";
            string DeferredDeliveryTime = "";
            string EntryID = "";
            string ExpiryTime = "";
            string LastModificationTime = "";
            string EmailImage = "";
            string Accounts = "";
            string ShortSubj = "";
            string SourceTypeCode = "";
            string OriginalFolder = "";
            string StoreID = "";
            string isPublic = "";
            string RetentionExpirationDate = "";
            string IsPublicPreviousState = "";
            string isAvailable = "";
            string CurrMailFolderID = "";
            string isPerm = "";
            string isMaster = "";
            string CreationDate = "";
            string NbrAttachments = "";
            string CRC = "";
            string ImageHash = "";
            string Description = "";
            string KeyWords = "";
            string RetentionCode = "";
            string EmailIdentifier = "";
            string ConvertEmlToMSG = "";
            string HiveConnectionName = "";
            string HiveActive = "";
            string RepoSvrName = "";
            string RowCreationDate = "";
            string RowLastModDate = "";
            string UIDL = "";
            string RecLen = "";
            string RecHash = "";
            string OriginalSize = "";
            string CompressedSize = "";
            string txStartTime = "";
            string txEndTime = "";
            string txTotalTime = "";
            string TransmitTime = "";
            string FileAttached = "";
            string BPS = "";
            string RepoName = "";
            string HashFile = "";
            string HashName = "";
            string ContainsAttachment = "";
            string NbrAttachment = "";
            string NbrZipFiles = "";
            string NbrZipFilesCnt = "";
            string PdfIsSearchable = "";
            string PdfOcrRequired = "";
            string PdfOcrSuccess = "";
            string PdfOcrTextExtracted = "";
            string PdfPages = "";
            string PdfImages = "";
            string MachineID = "";
            string notes = "";
            string NbrOccurances = "";
            string RowID = "";
            string RowGuid = "";
            modGlobals.DictEmails.Add("EmailGuid", EmailGuid);
            modGlobals.DictEmails.Add("SUBJECT", SUBJECT);
            modGlobals.DictEmails.Add("SentTO", SentTO);
            modGlobals.DictEmails.Add("Body", Body);
            modGlobals.DictEmails.Add("Bcc", Bcc);
            modGlobals.DictEmails.Add("BillingInformation", BillingInformation);
            modGlobals.DictEmails.Add("CC", CC);
            modGlobals.DictEmails.Add("Companies", Companies);
            modGlobals.DictEmails.Add("CreationTime", CreationTime);
            modGlobals.DictEmails.Add("ReadReceiptRequested", ReadReceiptRequested);
            modGlobals.DictEmails.Add("ReceivedByName", ReceivedByName);
            modGlobals.DictEmails.Add("ReceivedTime", ReceivedTime);
            modGlobals.DictEmails.Add("AllRecipients", AllRecipients);
            modGlobals.DictEmails.Add("UserID", UserID);
            modGlobals.DictEmails.Add("SenderEmailAddress", SenderEmailAddress);
            modGlobals.DictEmails.Add("SenderName", SenderName);
            modGlobals.DictEmails.Add("Sensitivity", Sensitivity);
            modGlobals.DictEmails.Add("SentOn", SentOn);
            modGlobals.DictEmails.Add("MsgSize", MsgSize);
            modGlobals.DictEmails.Add("DeferredDeliveryTime", DeferredDeliveryTime);
            modGlobals.DictEmails.Add("EntryID", EntryID);
            modGlobals.DictEmails.Add("ExpiryTime", ExpiryTime);
            modGlobals.DictEmails.Add("LastModificationTime", LastModificationTime);
            modGlobals.DictEmails.Add("EmailImage", EmailImage);
            modGlobals.DictEmails.Add("Accounts", Accounts);
            modGlobals.DictEmails.Add("ShortSubj", ShortSubj);
            modGlobals.DictEmails.Add("SourceTypeCode", SourceTypeCode);
            modGlobals.DictEmails.Add("OriginalFolder", OriginalFolder);
            modGlobals.DictEmails.Add("StoreID", StoreID);
            modGlobals.DictEmails.Add("isPublic", isPublic);
            modGlobals.DictEmails.Add("RetentionExpirationDate", RetentionExpirationDate);
            modGlobals.DictEmails.Add("IsPublicPreviousState", IsPublicPreviousState);
            modGlobals.DictEmails.Add("isAvailable", isAvailable);
            modGlobals.DictEmails.Add("CurrMailFolderID", CurrMailFolderID);
            modGlobals.DictEmails.Add("isPerm", isPerm);
            modGlobals.DictEmails.Add("isMaster", isMaster);
            modGlobals.DictEmails.Add("CreationDate", CreationDate);
            modGlobals.DictEmails.Add("NbrAttachments", NbrAttachments);
            modGlobals.DictEmails.Add("CRC", CRC);
            modGlobals.DictEmails.Add("ImageHash", ImageHash);
            modGlobals.DictEmails.Add("Description", Description);
            modGlobals.DictEmails.Add("KeyWords", KeyWords);
            modGlobals.DictEmails.Add("RetentionCode", RetentionCode);
            modGlobals.DictEmails.Add("EmailIdentifier", EmailIdentifier);
            modGlobals.DictEmails.Add("ConvertEmlToMSG", ConvertEmlToMSG);
            modGlobals.DictEmails.Add("HiveConnectionName", HiveConnectionName);
            modGlobals.DictEmails.Add("HiveActive", HiveActive);
            modGlobals.DictEmails.Add("RepoSvrName", RepoSvrName);
            modGlobals.DictEmails.Add("RowCreationDate", RowCreationDate);
            modGlobals.DictEmails.Add("RowLastModDate", RowLastModDate);
            modGlobals.DictEmails.Add("UIDL", UIDL);
            modGlobals.DictEmails.Add("RecLen", RecLen);
            modGlobals.DictEmails.Add("RecHash", RecHash);
            modGlobals.DictEmails.Add("OriginalSize", OriginalSize);
            modGlobals.DictEmails.Add("CompressedSize", CompressedSize);
            modGlobals.DictEmails.Add("txStartTime", txStartTime);
            modGlobals.DictEmails.Add("txEndTime", txEndTime);
            modGlobals.DictEmails.Add("txTotalTime", txTotalTime);
            modGlobals.DictEmails.Add("TransmitTime", TransmitTime);
            modGlobals.DictEmails.Add("FileAttached", FileAttached);
            modGlobals.DictEmails.Add("BPS", BPS);
            modGlobals.DictEmails.Add("RepoName", RepoName);
            modGlobals.DictEmails.Add("HashFile", HashFile);
            modGlobals.DictEmails.Add("HashName", HashName);
            modGlobals.DictEmails.Add("ContainsAttachment", ContainsAttachment);
            modGlobals.DictEmails.Add("NbrAttachment", NbrAttachment);
            modGlobals.DictEmails.Add("NbrZipFiles", NbrZipFiles);
            modGlobals.DictEmails.Add("NbrZipFilesCnt", NbrZipFilesCnt);
            modGlobals.DictEmails.Add("PdfIsSearchable", PdfIsSearchable);
            modGlobals.DictEmails.Add("PdfOcrRequired", PdfOcrRequired);
            modGlobals.DictEmails.Add("PdfOcrSuccess", PdfOcrSuccess);
            modGlobals.DictEmails.Add("PdfOcrTextExtracted", PdfOcrTextExtracted);
            modGlobals.DictEmails.Add("PdfPages", PdfPages);
            modGlobals.DictEmails.Add("PdfImages", PdfImages);
            modGlobals.DictEmails.Add("MachineID", MachineID);
            modGlobals.DictEmails.Add("notes", notes);
            modGlobals.DictEmails.Add("NbrOccurances", NbrOccurances);
            modGlobals.DictEmails.Add("RowID", RowID);
            modGlobals.DictEmails.Add("RowGuid", RowGuid);
            return default;
        }

        public bool fillContentDict()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string RowGuid = "";
            string SourceGuid = "";
            string CreateDate = "";
            string SourceName = "";
            string SourceImage = "";
            string SourceTypeCode = "";
            string FQN = "";
            string VersionNbr = "";
            string LastAccessDate = "";
            string FileLength = "";
            string LastWriteTime = "";
            string UserID = "";
            string DataSourceOwnerUserID = "";
            string isPublic = "";
            string FileDirectory = "";
            string OriginalFileType = "";
            string RetentionExpirationDate = "";
            string IsPublicPreviousState = "";
            string isAvailable = "";
            string isContainedWithinZipFile = "";
            string IsZipFile = "";
            string DataVerified = "";
            string ZipFileGuid = "";
            string ZipFileFQN = "";
            string Description = "";
            string KeyWords = "";
            string Notes = "";
            string isPerm = "";
            string isMaster = "";
            string CreationDate = "";
            string OcrPerformed = "";
            string isGraphic = "";
            string GraphicContainsText = "";
            string OcrText = "";
            string ImageHiddenText = "";
            string isWebPage = "";
            string ParentGuid = "";
            string RetentionCode = "";
            string MachineID = "";
            string CRC = "";
            string ImageHash = "";
            string SharePoint = "";
            string SharePointDoc = "";
            string SharePointList = "";
            string SharePointListItem = "";
            string StructuredData = "";
            string HiveConnectionName = "";
            string HiveActive = "";
            string RepoSvrName = "";
            string RowCreationDate = "";
            string RowLastModDate = "";
            string ContainedWithin = "";
            string RecLen = "";
            string RecHash = "";
            string OriginalSize = "";
            string CompressedSize = "";
            string txStartTime = "";
            string txEndTime = "";
            string txTotalTime = "";
            string TransmitTime = "";
            string FileAttached = "";
            string BPS = "";
            string RepoName = "";
            string HashFile = "";
            string HashName = "";
            string OcrSuccessful = "";
            string OcrPending = "";
            string PdfIsSearchable = "";
            string PdfOcrRequired = "";
            string PdfOcrSuccess = "";
            string PdfOcrTextExtracted = "";
            string PdfPages = "";
            string PdfImages = "";
            string RequireOcr = "";
            string RssLinkFlg = "";
            string RssLinkGuid = "";
            string PageURL = "";
            string RetentionDate = "";
            string URLHash = "";
            string WebPagePublishDate = "";
            string SapData = "";
            string RowID = "";
            modGlobals.DictContent.Add("RowGuid", RowGuid);
            modGlobals.DictContent.Add("SourceGuid", SourceGuid);
            modGlobals.DictContent.Add("CreateDate", CreateDate);
            modGlobals.DictContent.Add("SourceName", SourceName);
            modGlobals.DictContent.Add("SourceImage", SourceImage);
            modGlobals.DictContent.Add("SourceTypeCode", SourceTypeCode);
            modGlobals.DictContent.Add("FQN", FQN);
            modGlobals.DictContent.Add("VersionNbr", VersionNbr);
            modGlobals.DictContent.Add("LastAccessDate", LastAccessDate);
            modGlobals.DictContent.Add("FileLength", FileLength);
            modGlobals.DictContent.Add("LastWriteTime", LastWriteTime);
            modGlobals.DictContent.Add("UserID", UserID);
            modGlobals.DictContent.Add("DataSourceOwnerUserID", DataSourceOwnerUserID);
            modGlobals.DictContent.Add("isPublic", isPublic);
            modGlobals.DictContent.Add("FileDirectory", FileDirectory);
            modGlobals.DictContent.Add("OriginalFileType", OriginalFileType);
            modGlobals.DictContent.Add("RetentionExpirationDate", RetentionExpirationDate);
            modGlobals.DictContent.Add("IsPublicPreviousState", IsPublicPreviousState);
            modGlobals.DictContent.Add("isAvailable", isAvailable);
            modGlobals.DictContent.Add("isContainedWithinZipFile", isContainedWithinZipFile);
            modGlobals.DictContent.Add("IsZipFile", IsZipFile);
            modGlobals.DictContent.Add("DataVerified", DataVerified);
            modGlobals.DictContent.Add("ZipFileGuid", ZipFileGuid);
            modGlobals.DictContent.Add("ZipFileFQN", ZipFileFQN);
            modGlobals.DictContent.Add("Description", Description);
            modGlobals.DictContent.Add("KeyWords", KeyWords);
            modGlobals.DictContent.Add("Notes", Notes);
            modGlobals.DictContent.Add("isPerm", isPerm);
            modGlobals.DictContent.Add("isMaster", isMaster);
            modGlobals.DictContent.Add("CreationDate", CreationDate);
            modGlobals.DictContent.Add("OcrPerformed", OcrPerformed);
            modGlobals.DictContent.Add("isGraphic", isGraphic);
            modGlobals.DictContent.Add("GraphicContainsText", GraphicContainsText);
            modGlobals.DictContent.Add("OcrText", OcrText);
            modGlobals.DictContent.Add("ImageHiddenText", ImageHiddenText);
            modGlobals.DictContent.Add("isWebPage", isWebPage);
            modGlobals.DictContent.Add("ParentGuid", ParentGuid);
            modGlobals.DictContent.Add("RetentionCode", RetentionCode);
            modGlobals.DictContent.Add("MachineID", MachineID);
            modGlobals.DictContent.Add("CRC", CRC);
            modGlobals.DictContent.Add("ImageHash", ImageHash);
            modGlobals.DictContent.Add("SharePoint", SharePoint);
            modGlobals.DictContent.Add("SharePointDoc", SharePointDoc);
            modGlobals.DictContent.Add("SharePointList", SharePointList);
            modGlobals.DictContent.Add("SharePointListItem", SharePointListItem);
            modGlobals.DictContent.Add("StructuredData", StructuredData);
            modGlobals.DictContent.Add("HiveConnectionName", HiveConnectionName);
            modGlobals.DictContent.Add("HiveActive", HiveActive);
            modGlobals.DictContent.Add("RepoSvrName", RepoSvrName);
            modGlobals.DictContent.Add("RowCreationDate", RowCreationDate);
            modGlobals.DictContent.Add("RowLastModDate", RowLastModDate);
            modGlobals.DictContent.Add("ContainedWithin", ContainedWithin);
            modGlobals.DictContent.Add("RecLen", RecLen);
            modGlobals.DictContent.Add("RecHash", RecHash);
            modGlobals.DictContent.Add("OriginalSize", OriginalSize);
            modGlobals.DictContent.Add("CompressedSize", CompressedSize);
            modGlobals.DictContent.Add("txStartTime", txStartTime);
            modGlobals.DictContent.Add("txEndTime", txEndTime);
            modGlobals.DictContent.Add("txTotalTime", txTotalTime);
            modGlobals.DictContent.Add("TransmitTime", TransmitTime);
            modGlobals.DictContent.Add("FileAttached", FileAttached);
            modGlobals.DictContent.Add("BPS", BPS);
            modGlobals.DictContent.Add("RepoName", RepoName);
            modGlobals.DictContent.Add("HashFile", HashFile);
            modGlobals.DictContent.Add("HashName", HashName);
            modGlobals.DictContent.Add("OcrSuccessful", OcrSuccessful);
            modGlobals.DictContent.Add("OcrPending", OcrPending);
            modGlobals.DictContent.Add("PdfIsSearchable", PdfIsSearchable);
            modGlobals.DictContent.Add("PdfOcrRequired", PdfOcrRequired);
            modGlobals.DictContent.Add("PdfOcrSuccess", PdfOcrSuccess);
            modGlobals.DictContent.Add("PdfOcrTextExtracted", PdfOcrTextExtracted);
            modGlobals.DictContent.Add("PdfPages", PdfPages);
            modGlobals.DictContent.Add("PdfImages", PdfImages);
            modGlobals.DictContent.Add("RequireOcr", RequireOcr);
            modGlobals.DictContent.Add("RssLinkFlg", RssLinkFlg);
            modGlobals.DictContent.Add("RssLinkGuid", RssLinkGuid);
            modGlobals.DictContent.Add("PageURL", PageURL);
            modGlobals.DictContent.Add("RetentionDate", RetentionDate);
            modGlobals.DictContent.Add("URLHash", URLHash);
            modGlobals.DictContent.Add("WebPagePublishDate", WebPagePublishDate);
            modGlobals.DictContent.Add("SapData", SapData);
            modGlobals.DictContent.Add("RowID", RowID);
            return default;
        }

        public bool ckIsGraphic(string ext)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ext = ext.ToUpper();
            ext = ext.Replace(".", "");
            if (GraphicDict.Contains(ext))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void populateGraphicExtensions()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            GraphicDict.Add("JPG");
            GraphicDict.Add("PNG");
            GraphicDict.Add("GIF");
            GraphicDict.Add("WEBP");
            GraphicDict.Add("TIFF");
            GraphicDict.Add("PSD");
            GraphicDict.Add("RAW");
            GraphicDict.Add("BMP");
            GraphicDict.Add("HEIF");
            GraphicDict.Add("INDD");
            GraphicDict.Add("JPEG 2000");
            GraphicDict.Add("SVG");
            GraphicDict.Add("AI");
            GraphicDict.Add("EPS");
            // GraphicDict.Add("PDF")
            GraphicDict.Add("JPG");
            GraphicDict.Add("JPEG");
            GraphicDict.Add("JPE");
            GraphicDict.Add("JIF");
            GraphicDict.Add("JFIF");
            GraphicDict.Add("JFI");
        }

        private void populateZipExtensions()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ZipDict.Add("001", "Is an extension that indicates that the archive Is Using the ARJ format For compression. You may also see such files With the extension Of .arj. Used On MS-DOS, although other platforms have tools that will uncompress 001 And ARJ files.");
            ZipDict.Add("7Z", "Is a New format created For use With 7-Zip, an open source Windows-based archiver.");
            ZipDict.Add("ARJ", "files are discussed previously, with 001.");
            ZipDict.Add("BIN", "Is Mac OS-only, & stands For MacBinary. Does very little compression, And creates binary files instead of text files. Leaves Mac-specific data intact & therefore keeping the 'resource fork' together with the 'data fork'. Since both forks are kept together, for example, a decompressed file will still display its actual icon, instead of a generic file icon. Since it's a binary format, you need to transfer .bin files over FTP only after setting your FTP program to 'binary'.");
            ZipDict.Add("BZIP", "and BZIP2 uses the 'Burrows-Wheeler block sorting text compression algorithm' (no, I don't know what that means either). It is used on Linux and other Unix-like systems. Files using this method end in '.bz2.");
            ZipDict.Add("CAB", "is a Microsoft cabinet file, used to distribute software programs.");
            ZipDict.Add("CPIO", "is a Unix command used for copying files into, and out of, archivs. It's not seen very much any more, since it's been pretty much supplanted by TAR and GZIP.");
            ZipDict.Add("DEB", "is used by the Debian distribution of Linux to package software installation files. RPM is a similar tool for different distributions of Linux.");
            ZipDict.Add("EAR", "for Enterprise ARchive, is used with Java 2 Enterprise Edition (J2EE) applications that require multiple JAR and WAR files, discussed afterwards. EAR, like JAR and WAR, uses the same compression method as ZIP.");
            ZipDict.Add("GZ", "is the GNU version of ZIP. It is commonly used on Linux systems.");
            ZipDict.Add("HQX", "is a BinHex file. Converts text and binary files into ASCII text; specifically, the 7 bits that most Unix systems use. Results in larger files than .bin; however, it's safer for traveling around the Internet via email because that fact that it uses ASCII text allows the transfer of binary programs over non-binary transfer protocols like UUCP and sendmail. When using FTP, it doesn't matter if you set your transfer to 'binary' or 'ASCII7'; either way, if you're using .hqx, things will be fine.");
            ZipDict.Add("JAR", "stands for Java ARchive, and is used with archives containing software written in and for the Java programming language. JAR, like EAR and WAR, uses the same compression method as ZIP.");
            ZipDict.Add("LHA", "is a Japanese compression format dating from the 1980s. It proved to be influential, since the source code was made available by Dr. Haruyasu Yoshizaki, its creator. One of the few archivers used on computers running the Amiga operating system.");
            ZipDict.Add("RAR", "is a proprietary format developed by Eugene Roshal. His licensing allows for the free decoding of RAR archives, but encoding is only allowed by his company.");
            ZipDict.Add("RPM", "stands for 'Red Hat Package Manager.') Invented by Red Hat, it is used to build and install individual software packages. Since it is almost entirely used as a tool for Linux software installation, it is extremely rare to find it used to compress normal data files, or to find it on Windows or Mac OS X machines.");
            ZipDict.Add("SEA", "stands for Self-Expanding Archive, and it goes with SIT, discussed next.");
            ZipDict.Add("SIT", "is use with the Mac program StuffIt. Also leaves Mac-specific data intact, like a .bin. This form of compression is proprietary to Alladin Systems, but their 'Expander' program is free for download for both Mac and Windows. Does a pretty good job of compressing files.");
            ZipDict.Add("TAR", "files aren't really compressed; instead, they're conjoined to form one large file. In other words, if you have 100 files, each 3 kb, and you tar them together, you end up with one 300 kb file. At this point, most tar files are compressed using another program, often gzip, resulting in a file with the extension of '.tar.gz' or 'tgz.') Almost never seen on Windows or Mac OS X, and extremely common on Linux computers.");
            ZipDict.Add("WAR", "files are related to JAR archives. WAR, which stands for Web ARchive, brings together all the files that a Java-based Web application needs—Java archives, HTML pages, XML files, and so on—so the application can be run easily on a Web server. Like JAR and EAR, WAR use the same compression method as ZIP.");
            ZipDict.Add("ZIP", "works across a wide variety of computing platforms, including Unix and Linux, VMS, OS/2, MS-DOS, Windows, and Macintosh. The reason for the format's near universality can be attributed to Phil Katz, the developer of the original ZIP compression algorithm, who placed in the public domain the ZIP file format, its compression format, and the .zip filename extension.");
        }

        public bool ckIsZipFile(string ext)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ext = ext.ToUpper();
            ext = ext.Replace(".", "");
            if (ZipDict.ContainsKey(ext))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void cbProfile_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void OpenLicenseFormToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            My.MyProject.Forms.frmLicense.ShowDialog();
        }

        private void Button4_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FQN = @"D:\dev\WhitePapers\How To Set Up an OpenVPN Server on Ubuntu 18.docx";
            FQN = FQN.Replace("''", "'");
            FileHash = ENC.hashSha1File(FQN);
            Console.WriteLine(FQN);
            Console.WriteLine(FileHash);
            try
            {
                DBLocal.GetFileID(FQN, Conversions.ToString(FileHash));
                MessageBox.Show("SQLite Operational");
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                MessageBox.Show("SQLite FAILED");
            }
        }

        private void TimerAutoExec_Tick(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (modGlobals.gAutoExec & modGlobals.gAutoExecContentComplete & modGlobals.gAutoExecEmailComplete & modGlobals.gAutoExecExchangeComplete)
            {
                modGlobals.gAutoExec = false;
                DBLocal.BackUpSQLite();
                try
                {
                    currentDomain.UnhandledException -= modGlobals.MYExnHandler;
                    Application.ThreadException -= modGlobals.MYThreadHandler;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Archiver closed");
                }

                LOG.WriteToArchiveLog("ARCHIVER CLOSING DOWN SUCCESSFULLY.");
                if (modGlobals.UseDirectoryListener.Equals(1) & !modGlobals.TempDisableDirListener)
                {
                    bUpdated = DBLocal.removeListenerfileProcessed();
                    if (Conversions.ToBoolean(!bUpdated))
                    {
                        LOG.WriteToArchiveLog("ERROR 00 failed removeListenerfileProcessed...");
                    }
                }

                My.MyProject.Forms.LoginForm1.Close();
                Close();
            }
            else
            {
                AutoExecCheck += 1;
            }
        }

        private void RebuildSQLiteDBToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBLocal.RebuildDB();
            MessageBox.Show("Database rebuilt");
        }

        private void asyncBatchOcrALL_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void asyncBatchOcrPending_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }
        }

        private void UnhandledExceptionsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // ' Define a handler for unhandled exceptions.
            // AddHandler currentDomain.UnhandledException, AddressOf MYExnHandler
            // ' Define a handler for unhandled exceptions for threads behind forms.
            // AddHandler Application.ThreadException, AddressOf MYThreadHandler

            // This code will throw an exception and will be caught.
            int X = 5;
            X = (int)(X / 0d); // throws exception will be caught by subs below

            // RemoveHandler currentDomain.UnhandledException, AddressOf MYExnHandler
            // RemoveHandler Application.ThreadException, AddressOf MYThreadHandler
        }

        private void BackupSQLiteDBToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // 
            DBLocal.BackUpSQLite();
            MessageBox.Show("Backup Complete...");
        }

        private void RestoreSQLiteDBToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DBLocal.RestoreSQLite();
            MessageBox.Show("Restore Complete...");
        }

        private void BackupSQLiteDBToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            DBLocal.BackUpSQLite();
            MessageBox.Show("Backup Complete...");
        }

        private void SQLiteInterfaceScreenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            My.MyProject.Forms.frmSqlite.Show();
        }

        private void InventoryDirectoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        public void ThreadUpdateNotice(string value)
        {
            if (InvokeRequired)
            {
                Invoke(new Action<string>(ThreadUpdateNotice), new object[] { value });
                return;
            }

            lblNotice.Text = value;
        }

        public void ThreadUpdateSB(string value)
        {
            if (InvokeRequired)
            {
                Invoke(new Action<string>(ThreadUpdateSB), new object[] { value });
                return;
            }

            SB.Text = value;
        }

        public void ThreadUpdateSB2(string value)
        {
            if (InvokeRequired)
            {
                Invoke(new Action<string>(ThreadUpdateSB2), new object[] { value });
                return;
            }

            SB2.Text = value;
        }

        private void ContentThread_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            PerformContentArchive();
            My.MyProject.Forms.frmNotify.Hide();
            modGlobals.gAutoExecContentComplete = true;
        }

        private void GetListenerFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string s = "";
            var LOF = new List<string>();
            LOF = DBLocal.getListenerfiles();
            MessageBox.Show("Retrieved " + LOF.ToString() + " files to process.");
        }

        private void CompareDirToRepositoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "";
            string targetDirectory = "";
            string[] txtFilesArray = null;
            ArrayList ListOfExt = null;
            string dir = "";
            string ext = "";
            string filename = "";
            int found = 0;
            int missing = 0;
            int BadDirCnt = 0;
            int GoodDirCnt = 0;
            int BadFileCnt = 0;
            int GoodFileCnt = 0;
            int MissingFileCnt = 0;
            int SkippedFileCnt = 0;
            int iCurr = 0;
            int TotFiles = 0;
            LOG.WriteToDirAnalysisLog("Directories Name Too Long:", true);
            LOG.WriteToDirAnalysisLog("-------------------------", false);
            if (FolderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                targetDirectory = FolderBrowserDialog1.SelectedPath;
            }

            // Individual components of a filename (i.e. each subdirectory along the path,
            // And the final filename) are limited to 255 characters, And the total path
            // length Is limited To approximately 32, 0 characters. However, on Windows,
            // you can't exceed MAX_PATH value (259 characters for files, 248 for folders)

            var ListOfDir = new List<string>();
            var ListOfDirs = Directory.GetDirectories(targetDirectory);
            ListOfDir.Add(targetDirectory);
            for (int k = 0, loopTo = ListOfDirs.Count() - 1; k <= loopTo; k++)
            {
                dir = ListOfDirs[k];
                if (!ListOfDir.Contains(dir))
                {
                    ListOfDir.Add(dir);
                }
            }

            for (int k = 0, loopTo1 = ListOfDir.Count - 1; k <= loopTo1; k++)
            {
                dir = ListOfDir[k];
                if (dir.Length.Equals(0))
                {
                    ListOfDir[k] = "";
                }
                else if (dir.Length > 255)
                {
                    BadDirCnt += 1;
                    msg = "   -> " + dir;
                    LOG.WriteToDirAnalysisLog(msg, false);
                    ListOfDir[k] = "";
                }
                else
                {
                    GoodDirCnt += 1;
                }
            }

            ListOfDir.Sort();
            ListOfDirs = null;
            ListOfExt = DBARCH.GetIncludedFiletypes(targetDirectory);
            if (ListOfExt.Count.Equals(0))
            {
                ListOfExt = DBARCH.GetIncludedFiletypes("");
            }

            LOG.WriteToDirAnalysisLog(" ", false);
            LOG.WriteToDirAnalysisLog("Directories and Files:", false);
            LOG.WriteToDirAnalysisLog("-------------------------", false);
            Cursor = Cursors.WaitCursor;
            for (int k = 0, loopTo2 = ListOfDir.Count - 1; k <= loopTo2; k++)
            {
                SB2.Text = "Processing Directory #" + (k + 1).ToString() + " of " + ListOfDir.Count.ToString();
                SB2.Refresh();
                dir = ListOfDir[k].Trim();
                if (dir.Length > 0)
                {
                    txtFilesArray = Directory.GetFiles(dir, "*.*", SearchOption.TopDirectoryOnly);
                    msg = "    -->Dir: >" + dir + "< Contains: " + txtFilesArray.Count().ToString() + " files.";
                    LOG.WriteToDirAnalysisLog(msg, false);
                    int icnt = 0;
                    int I = 0;
                    bool bProcess = false;
                    TotFiles += txtFilesArray.Count();
                    foreach (var fqn in txtFilesArray)
                    {
                        iCurr += 1;
                        lblNotice.Text = "File# " + iCurr.ToString() + " of " + txtFilesArray.Length.ToString();
                        lblNotice.Refresh();
                        bProcess = true;
                        if (ListOfExt.Count > 0)
                        {
                            I = fqn.LastIndexOf(".");
                            if (I > 0)
                            {
                                ext = fqn.Substring(I + 1).ToUpper();
                                if (ListOfExt.Contains(ext))
                                {
                                    bProcess = true;
                                }
                                else
                                {
                                    SkippedFileCnt += 1;
                                    bProcess = false;
                                }
                            }
                        }

                        icnt += 1;
                        lblNotice.Text = icnt.ToString("N0") + " of " + txtFilesArray.Count().ToString("N0");
                        lblNotice.Refresh();
                        if (bProcess)
                        {
                            B = DBARCH.ckFQNExists(fqn);
                            if (Conversions.ToBoolean(B))
                            {
                                found += 1;
                            }
                            else
                            {
                                missing += 1;
                                msg = "    .. Missing: " + fqn;
                                LOG.WriteToDirAnalysisLog(msg, false);
                            }

                            SB.Text = "Found: " + found.ToString() + " : Missing: " + missing.ToString();
                        }
                    }
                }
            }

            Cursor = Cursors.Default;
            LOG.WriteToDirAnalysisLog("***********************************", false);
            msg = "Total Directories: " + ListOfDir.Count.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Bad Directories  : " + BadDirCnt.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Total Files      : " + TotFiles.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Skipped Files    : " + SkippedFileCnt.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Not in Repo      : " + missing.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "In Repo          : " + found.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            MessageBox.Show("Inventory complete...");
        }

        private void ThreadValidateSourceName_DoWork_1(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            string MachineName = Environment.MachineName.ToString();
            DBARCH.CleanupSourceName(MachineName);
        }

        private void LIstWindowsLogsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            EventLog[] remoteEventLogs;
            string MachineName = Environment.MachineName;
            remoteEventLogs = EventLog.GetEventLogs(MachineName);
            Console.WriteLine("Number of logs on computer: " + remoteEventLogs.Length);
            foreach (EventLog log in remoteEventLogs)
                Console.WriteLine("Log: " + log.Log);
        }

        private void CheckLogsForListenerInfoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DisplayEventLogProperties();
        }

        private static void DisplayEventLogProperties()
        {
            var eventLogs = EventLog.GetEventLogs();
            foreach (EventLog e in eventLogs)
            {
                long sizeKB = 0L;
                Console.WriteLine();
                Console.WriteLine("{0}:", e.LogDisplayName);
                Console.WriteLine("  Log name = " + Constants.vbTab + Constants.vbTab + " {0}", e.Log);
                Console.WriteLine("  Number of event log entries = {0}", e.Entries.Count.ToString());
                var regEventLog = Registry.LocalMachine.OpenSubKey(@"System\CurrentControlSet\Services\EventLog\" + e.Log);
                if (regEventLog is object)
                {
                    var temp = regEventLog.GetValue("File");
                    if (temp is object)
                    {
                        Console.WriteLine("  Log file path = " + Constants.vbTab + " {0}", temp.ToString());
                        var file = new FileInfo(temp.ToString());
                        if (file.Exists)
                        {
                            sizeKB = (long)(file.Length / 1024d);
                            if (file.Length % 1024L != 0L)
                            {
                                sizeKB += 1L;
                            }

                            Console.WriteLine("  Current size = " + Constants.vbTab + " {0} kilobytes", sizeKB.ToString());
                        }
                    }
                    else
                    {
                        Console.WriteLine("  Log file path = " + Constants.vbTab + " <not set>");
                    }
                }

                sizeKB = e.MaximumKilobytes;
                Console.WriteLine("  Maximum size = " + Constants.vbTab + " {0} kilobytes", sizeKB.ToString());
                Console.WriteLine("  Overflow setting = " + Constants.vbTab + " {0}", e.OverflowAction.ToString());
                switch (e.OverflowAction)
                {
                    case OverflowAction.OverwriteOlder:
                        {
                            Console.WriteLine(Constants.vbTab + " Entries are retained a minimum of {0} days.", e.MinimumRetentionDays);
                            break;
                        }

                    case OverflowAction.DoNotOverwrite:
                        {
                            Console.WriteLine(Constants.vbTab + " Older entries are not overwritten.");
                            break;
                        }

                    case OverflowAction.OverwriteAsNeeded:
                        {
                            Console.WriteLine(Constants.vbTab + " If number of entries equals max size limit, a new event log entry overwrites the oldest entry.");
                            break;
                        }

                    default:
                        {
                            break;
                        }
                }
            }
        }

        public void ResetSqlite()
        {
            DBLocal.truncateDirs();
            DBLocal.truncateFiles();
            DBLocal.truncateInventory();
            DBLocal.truncateOutlook();
            DBLocal.truncateExchange();
            DBLocal.truncateContacts();
            DBLocal.truncateDirFiles();
        }

        private void ResetSQLiteArchivesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "This empties the temporary data store used for performance enhancement, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            ResetSqlite();
            MessageBox.Show("Temporary file stores cleaned up and ready.");
        }

        private void GetOutlookEMailIDsToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var SL = new SortedList();
            DBARCH.LoadEntryIdByUserID(ref SL);
            DBLocal.truncateOutlook();
            int I = 0;
            int K = SL.Count;
            PB1.Value = 0;
            PB1.Minimum = 0;
            PB1.Maximum = SL.Keys.Count + 1;
            foreach (string sKey in SL.Keys)
            {
                DBLocal.addOutlook(sKey);
                I += 1;
                if (I % 10 == 0)
                {
                    PB1.Value = I;
                    SB.Text = I.ToString() + " of " + K.ToString();
                    SB.Refresh();
                }
            }

            PB1.Value = 0;
            SB.Text = "Complete.";
            MessageBox.Show("Outlook refresh complete.");
            SL = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }

        private void ResetZIPFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "This deletes the pending ZIP files to be processed, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Datastore Cleansing", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBLocal.zeroizeZipFiles();
            MessageBox.Show("Temporary zip files cleaned up and ready.");
        }

        private void ResetEmailIdentifierCodesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBARCH.setEmailCrcHash(isAdmin);
            GetOutlookEmailIDsToolStripMenuItem_Click(null, null);
        }

        private void RebuildSQLiteDBToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBLocal.RebuildDB();
            MessageBox.Show("Database rebuilt");
        }

        private void BackupSQLiteDBToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            DBLocal.BackUpSQLite();
            MessageBox.Show("Backup Complete...");
        }

        private void RestoreSQLiteDBToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            DBLocal.RestoreSQLite();
            MessageBox.Show("Restore Complete...");
        }

        private void ClearRestoreQueueToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool b = DBARCH.ClearRestoreQueue(modGlobals.gGateWayID, modGlobals.gCurrLoginID);
            if (b == true)
            {
                MessageBox.Show("Cleared queue.");
            }
            else
            {
                MessageBox.Show("Failed to clear queue.");
            }
        }

        private void SQToolStripMenuItem_Click(object sender, EventArgs e)
        {
            My.MyProject.Forms.frmSqlite.Show();
        }

        private void CompareDirToRepositoryToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            string msg = "";
            string targetDirectory = "";
            string[] txtFilesArray = null;
            ArrayList ListOfExt = null;
            string dir = "";
            string ext = "";
            string filename = "";
            int found = 0;
            int missing = 0;
            int BadDirCnt = 0;
            int GoodDirCnt = 0;
            int BadFileCnt = 0;
            int GoodFileCnt = 0;
            int MissingFileCnt = 0;
            int SkippedFileCnt = 0;
            int iCurr = 0;
            int TotFiles = 0;
            LOG.WriteToDirAnalysisLog("Directories Name Too Long:", true);
            LOG.WriteToDirAnalysisLog("-------------------------", false);
            if (FolderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                targetDirectory = FolderBrowserDialog1.SelectedPath;
            }

            // Individual components of a filename (i.e. each subdirectory along the path,
            // And the final filename) are limited to 255 characters, And the total path
            // length Is limited To approximately 32, 0 characters. However, on Windows,
            // you can't exceed MAX_PATH value (259 characters for files, 248 for folders)

            var ListOfDir = new List<string>();
            var ListOfDirs = Directory.GetDirectories(targetDirectory);
            ListOfDir.Add(targetDirectory);
            for (int k = 0, loopTo = ListOfDirs.Count() - 1; k <= loopTo; k++)
            {
                dir = ListOfDirs[k];
                if (!ListOfDir.Contains(dir))
                {
                    ListOfDir.Add(dir);
                }
            }

            for (int k = 0, loopTo1 = ListOfDir.Count - 1; k <= loopTo1; k++)
            {
                dir = ListOfDir[k];
                if (dir.Length.Equals(0))
                {
                    ListOfDir[k] = "";
                }
                else if (dir.Length > 255)
                {
                    BadDirCnt += 1;
                    msg = "   -> " + dir;
                    LOG.WriteToDirAnalysisLog(msg, false);
                    ListOfDir[k] = "";
                }
                else
                {
                    GoodDirCnt += 1;
                }
            }

            ListOfDir.Sort();
            ListOfDirs = null;
            ListOfExt = DBARCH.GetIncludedFiletypes(targetDirectory);
            if (ListOfExt.Count.Equals(0))
            {
                ListOfExt = DBARCH.GetIncludedFiletypes("");
            }

            LOG.WriteToDirAnalysisLog(" ", false);
            LOG.WriteToDirAnalysisLog("Directories and Files:", false);
            LOG.WriteToDirAnalysisLog("-------------------------", false);
            Cursor = Cursors.WaitCursor;
            for (int k = 0, loopTo2 = ListOfDir.Count - 1; k <= loopTo2; k++)
            {
                SB2.Text = "Processing Directory #" + (k + 1).ToString() + " of " + ListOfDir.Count.ToString();
                SB2.Refresh();
                dir = ListOfDir[k].Trim();
                if (dir.Length > 0)
                {
                    txtFilesArray = Directory.GetFiles(dir, "*.*", SearchOption.TopDirectoryOnly);
                    msg = "    -->Dir: >" + dir + "< Contains: " + txtFilesArray.Count().ToString() + " files.";
                    LOG.WriteToDirAnalysisLog(msg, false);
                    int icnt = 0;
                    int I = 0;
                    bool bProcess = false;
                    TotFiles += txtFilesArray.Count();
                    foreach (var fqn in txtFilesArray)
                    {
                        iCurr += 1;
                        lblNotice.Text = "File# " + iCurr.ToString() + " of " + txtFilesArray.Length.ToString();
                        lblNotice.Refresh();
                        bProcess = true;
                        if (ListOfExt.Count > 0)
                        {
                            I = fqn.LastIndexOf(".");
                            if (I > 0)
                            {
                                ext = fqn.Substring(I + 1).ToUpper();
                                if (ListOfExt.Contains(ext))
                                {
                                    bProcess = true;
                                }
                                else
                                {
                                    SkippedFileCnt += 1;
                                    bProcess = false;
                                }
                            }
                        }

                        icnt += 1;
                        lblNotice.Text = icnt.ToString("N0") + " of " + txtFilesArray.Count().ToString("N0");
                        lblNotice.Refresh();
                        if (bProcess)
                        {
                            B = DBARCH.ckFQNExists(fqn);
                            if (Conversions.ToBoolean(B))
                            {
                                found += 1;
                            }
                            else
                            {
                                missing += 1;
                                msg = "    .. Missing: " + fqn;
                                LOG.WriteToDirAnalysisLog(msg, false);
                            }

                            SB.Text = "Found: " + found.ToString() + " : Missing: " + missing.ToString();
                        }
                    }
                }
            }

            Cursor = Cursors.Default;
            LOG.WriteToDirAnalysisLog("***********************************", false);
            msg = "Total Directories: " + ListOfDir.Count.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Bad Directories  : " + BadDirCnt.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Total Files      : " + TotFiles.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Skipped Files    : " + SkippedFileCnt.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "Not in Repo      : " + missing.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            msg = "In Repo          : " + found.ToString("N0");
            LOG.WriteToDirAnalysisLog(msg, false);
            MessageBox.Show("Inventory complete...");
        }

        private void InventoryDirectoryToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            string targetDirectory = "";
            string[] txtFilesArray = null;
            ArrayList ListOfExt = null;
            string dir = "";
            string ext = "";
            string filename = "";
            int found = 0;
            int missing = 0;
            if (FolderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                targetDirectory = FolderBrowserDialog1.SelectedPath;
            }

            ListOfExt = DBARCH.GetIncludedFiletypes(targetDirectory);
            if (ListOfExt.Count.Equals(0))
            {
                ListOfExt = DBARCH.GetIncludedFiletypes("");
            }

            Cursor = Cursors.WaitCursor;
            txtFilesArray = Directory.GetFiles(targetDirectory, "*.*", SearchOption.AllDirectories);
            Cursor = Cursors.Default;
            Console.WriteLine("txtFilesArray: " + txtFilesArray.Count().ToString());
            int icnt = 0;
            int I = 0;
            bool bProcess = false;
            foreach (var fqn in txtFilesArray)
            {
                bProcess = true;
                if (ListOfExt.Count > 0)
                {
                    I = fqn.LastIndexOf(".");
                    if (I > 0)
                    {
                        ext = fqn.Substring(I + 1).ToUpper();
                        if (ListOfExt.Contains(ext))
                        {
                            bProcess = true;
                        }
                        else
                        {
                            bProcess = false;
                        }
                    }
                }

                icnt += 1;
                if (bProcess)
                {
                    lblNotice.Text = icnt.ToString("N0") + " of " + txtFilesArray.Count().ToString("N0");
                    lblNotice.Refresh();
                    B = DBARCH.ckFQNExists(fqn);
                    LOG.WriteToInventoryLog(Conversions.ToBoolean(B), fqn);
                    if (Conversions.ToBoolean(B))
                    {
                        found += 1;
                    }
                    else
                    {
                        missing += 1;
                    }

                    SB2.Text = "Found: " + found.ToString() + " : Missing: " + missing.ToString();
                }
            }

            MessageBox.Show("Inventory complete...");
        }

        private void ValidateDirectoryFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string Dname = "";
            if (FolderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                Dname = FolderBrowserDialog1.SelectedPath;
            }
            else
            {
                return;
            }

            My.MyProject.Forms.frmNotify.Show();
            string FName = "";
            int iCnt = 0;
            var FilterList = new List<string>();
            var UTIL = new clsUtility();
            List<FileInfo> Files = null;
            string Msg = "Inventory Date: " + DateAndTime.Now.ToString();
            string prevdir = "XXXXXX";
            int iInventoryCnt = 0;
            int iDirCnt = 0;
            int iBadCnt = 0;
            int iSkipCnt = 0;
            int iBadDir = 0;
            Cursor = Cursors.WaitCursor;
            My.MyProject.Forms.frmNotify.Refresh();
            My.MyProject.Forms.frmNotify.lblPdgPages.Text = "Standby, fetching directories and files, this could take a while...";
            My.MyProject.Forms.frmNotify.Refresh();
            var LisOfFiles = Directory.GetFiles(Dname, "*.*", SearchOption.AllDirectories);
            // Files = UTIL.GetFilesRecursive(Dname, FilterList)
            Cursor = Cursors.Default;
            My.MyProject.Forms.frmNotify.Show();
            int iTotal = Conversions.ToInteger(LisOfFiles.Count().ToString());
            My.MyProject.Forms.frmNotify.Text = "";
            foreach (string sfile in LisOfFiles)
            {
                try
                {
                    iInventoryCnt += 1;
                    Msg = iInventoryCnt.ToString("N0") + " of " + iTotal.ToString("N0");
                    try
                    {
                        My.MyProject.Forms.frmNotify.lblFileSpec.Text = Msg;
                        My.MyProject.Forms.frmNotify.Refresh();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }

                    if (!File.Exists(sfile))
                    {
                        goto SkipIT;
                    }

                    var FI = new FileInfo(sfile);
                    Dname = FI.DirectoryName;
                    FName = FI.Name;
                    FQN = FI.FullName;
                    FileLength = FI.Length;
                    EXT = FI.Extension.ToUpper();
                    if (Conversions.ToBoolean(EXT.contains(".")))
                    {
                        EXT = EXT.Substring(1);
                    }

                    FI = null;
                    if ((prevdir ?? "") != (Dname ?? ""))
                    {
                        try
                        {
                            My.MyProject.Forms.frmNotify.lblPdgPages.Text = Dname;
                            My.MyProject.Forms.frmNotify.Refresh();
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(ex.Message);
                        }

                        iDirCnt += 1;
                        LOG.WriteToDirAnalysisLog("-------------------------------------------", false);
                        LOG.WriteToDirAnalysisLog("DIRECTORY: " + Dname, false);
                        LOG.WriteToDirAnalysisLog("-------------------------------------------", false);
                    }

                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectGreaterEqual(FileLength, modGlobals.MaxFileToLoadMB * 1000000L, false)))
                    {
                        LOG.WriteToDirAnalysisLog("     File : " + FName + " EXCEEDS MAXIMUM ALLOWED FILE SIZE, SKIPPING.", false);
                        iBadCnt += 1;
                        goto SkipIT;
                    }

                    if (Dname.Trim().Length > 248)
                    {
                        LOG.WriteToDirAnalysisLog("     Directory name too long: " + Dname, false);
                        iBadDir += 1;
                        Dname = modGlobals.getShortDirName(Dname);
                        LOG.WriteToDirAnalysisLog("     Directory Shortened name: " + Dname, false);
                        if (Dname.Trim().Length > 248)
                        {
                            LOG.WriteToDirAnalysisLog("     SHORTENED directory name too long, skipping ENTIRE DIRECTORY", false);
                            goto SkipIT;
                        }
                    }

                    if (FName.Trim().Length > 260)
                    {
                        LOG.WriteToDirAnalysisLog("     File name too long: " + FName + " - SKIPPING FILE.", false);
                        iBadCnt += 1;
                        goto SkipIT;
                    }

                    Application.DoEvents();
                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectGreater(EXT.length, 0, false)))
                    {
                        if (IncludedTypes.Count > 0)
                        {
                            if (!IncludedTypes.Contains(EXT))
                            {
                                LOG.WriteToDirAnalysisLog("     File EXT NOT in Included list of Ext's: " + FName, false);
                                iSkipCnt += 1;
                                NeedsUpdate = false;
                            }
                        }

                        if (ExcludedTypes.Count > 0)
                        {
                            LOG.WriteToDirAnalysisLog("     File EXT EXCLUDED, skipping: " + FName, false);
                            if (ExcludedTypes.Contains(EXT))
                            {
                                iSkipCnt += 1;
                                NeedsUpdate = false;
                            }
                        }
                    }
                    else
                    {
                        LOG.WriteToDirAnalysisLog("     File has no EXT, skipping: " + FName, false);
                        iSkipCnt += 1;
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToDirAnalysisLog("     ERROR: DirectoryInventory: " + ex.Message + Constants.vbCrLf + "DIRECTORY:" + Dname + Constants.vbCrLf + "File: " + FName, false);
                }

                SkipIT:
                ;
                prevdir = Dname;
            }

            My.MyProject.Forms.frmNotify.Hide();
            Msg = "Inventory Count: " + iInventoryCnt.ToString() + Constants.vbCrLf;
            Msg += "Directory Count: " + iDirCnt.ToString() + Constants.vbCrLf;
            Msg += "Bad Directories: " + iBadDir.ToString() + Constants.vbCrLf;
            Msg += "Bad Files: " + iBadCnt.ToString() + Constants.vbCrLf;
            Msg += "Skipped Files: " + iSkipCnt.ToString() + Constants.vbCrLf + Constants.vbCrLf;
            Msg += "RUN COMPLETE";
            LOG.WriteToDirAnalysisLog("Inventory Count: " + iInventoryCnt.ToString(), false);
            LOG.WriteToDirAnalysisLog("Directory Count: " + iDirCnt.ToString(), false);
            LOG.WriteToDirAnalysisLog("Bad Directories: " + iBadDir.ToString(), false);
            LOG.WriteToDirAnalysisLog("Bad Files: " + iBadCnt.ToString(), false);
            LOG.WriteToDirAnalysisLog("Skipped Files: " + iSkipCnt.ToString(), false);
            MessageBox.Show(Msg);
        }

        public void BeginContentArchive(bool PerformQuickArchive)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            DBLocal.getUseLastArchiveDateActive();
            DBLocal.setUseLastArchiveDateActive();
            setLastArchiveLabel();
            try
            {
                if (ckDisable.Checked)
                {
                    LOG.WriteToArchiveLog("DISABLE ALL is checked - no archive allowed.");
                    SB.Text = "DISABLE ALL is checked - no archive allowed.";
                    return;
                }

                if (ckDisableContentArchive.Checked)
                {
                    LOG.WriteToArchiveLog("DISABLE Content Archive is checked - no archive allowed.");
                    SB.Text = "DISABLE Content Archive is checked - no archive allowed.";
                    return;
                }

                if (ContentThread.IsBusy)
                {
                    return;
                }

                try
                {
                    SB.Text = "Quick CONTENT ARCHIVE LAUNCHED";
                    // ****************** Execute PerformContentArchive() on a separate thread **********************************
                    if (!PerformQuickArchive)
                    {
                        SB.Text = "Full Inventory ARCHIVE LAUNCHED";
                        ResetSqlite();
                    }
                    // **********************************************************************************************************
                    modGlobals.gAutoExecContentComplete = false;
                    PerformContentArchive();
                    modGlobals.gAutoExecContentComplete = true;
                }
                // ContentThread.RunWorkerAsync()
                // **********************************************************************************************************
                catch (ThreadAbortException ex)
                {
                    LOG.WriteToArchiveLog("Thread 885 - caught ThreadAbortException - resetting.");
                    Thread.ResetAbort();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("Thread 888: " + ex.Message);
                    SB.Text = ex.Message;
                }
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 886 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Thread 887: " + ex.Message);
            }
        }

        private void ReapplyALLDBUpdatesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "This will reapply all database updates that might be missing, are you sure?";
            var dlgRes = MessageBox.Show(msg, "DB Updates", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            DBARCH.ZeroizeDBUpdate();
            SB.Text = "Applying any needed updates, standby...";
            ApplyDDUpdates();
            SB.Text = "Updates reapplied...";
            MessageBox.Show("Updates complete...");
        }

        private void CreateSQLiteDBToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string NewDB = @"c:\temp\TestSQLite.db";
            SQLiteConnection sqlite_conn;
            if (!Directory.Exists(@"c:\temp"))
            {
                Directory.CreateDirectory(@"C:\temp");
            }

            if (File.Exists(NewDB))
            {
                File.Delete(NewDB);
            }

            sqlite_conn = new SQLiteConnection("Data Source=" + NewDB);
            sqlite_conn.Open();
            if (File.Exists(NewDB))
            {
                MessageBox.Show("Success: " + NewDB + ", created");
            }
            else
            {
                MessageBox.Show("Failure: " + NewDB + ", failed to create");
            }
        }

        private void CanLongFilenamesBeTurnedOnToolStripMenuItem_Click(object sender, EventArgs e)
        {
            bool isLongFileNamesAvail = UTIL.isLongFileNamesAvail();
            if (isLongFileNamesAvail)
            {
                MessageBox.Show("This operating system can use Long File names");
            }
            else
            {
                MessageBox.Show("This operating system can NOT use Long File names");
            }
        }

        private void TurnONLongFilenamesAdminNeededToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Clipboard.Clear();
            Clipboard.SetText(@"reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /t REG_SZ /v LongPathsEnabled /d 1 /f");
            MessageBox.Show("This Command is in the clipboard." + Constants.vbCrLf + "Execute this command from a command prompt as an Administrator" + Constants.vbCrLf + Constants.vbCrLf + @"reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /t REG_SZ /v LongPathsEnabled /d 1 /f");
        }

        private void HowToTurnOnLongFilenamesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string S = "";
            S += "In the past the maximum supported file length was 260 characters (256 usable after the drive characters And termination character). In Windows 10 long file name support can be enabled which allows file names up to 32,767 characters (although you lose a few characters for mandatory characters that are part of the name). To enable this perform the following:" + Constants.vbCrLf;
            S += Constants.vbCrLf;
            S += "Start the registry editor (regedit.exe)" + Constants.vbCrLf;
            S += @"Navigate to HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" + Constants.vbCrLf;
            S += "Double Click LongPathsEnabled" + Constants.vbCrLf;
            S += "Set to 1 And click OK" + Constants.vbCrLf;
            S += "Reboot" + Constants.vbCrLf + Constants.vbCrLf;
            S += "This can also be enabled via Group Policy via Computer Configuration > Administrative Templates > System > Filesystem > Enable NTFS long paths.";
            S += Constants.vbCrLf;
            S += Constants.vbCrLf;
            S += @"reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem /t REG_SZ /v LongPathsEnabled /d 1 /f";
            S += Constants.vbCrLf;
            S += Constants.vbCrLf;
            S += "This Text has been placed into the clipboard in case you wish to run from the command line as an Administrator";
            Clipboard.Clear();
            Clipboard.SetText(S);
            MessageBox.Show(S);
        }

        private void CheckForViolationsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (ThreadSetNameHash.IsBusy)
            {
                SB.Text = "ABORTING, ALREADY EXECUTING...";
                return;
            }

            try
            {
                ThreadSetNameHash.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void FileNamesToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void LongFilenamesOnOrOFFToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string txt = Conversions.ToString(My.MyProject.Computer.Registry.GetValue(@"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem", "LongPathsEnabled", ""));
            MessageBox.Show("Current Value in Registry: " + txt);
        }

        private void LongFilenameHASHToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string tgtfqn = @"C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\_Eligibility\Documentation\RoleEligibilityTracking-Chad.doc";
            string CALCHASH = "";
            string ENCCHASH = "";
            var dirs = new Dictionary<string, string>();
            // C:\DEV\ECM2020\ARCHIVER\Z7\LICENSE.TXT
            dirs = DBARCH.getDSFQN("10", tgtfqn);
            foreach (string xhash in dirs.Keys)
            {
                tgtfqn = dirs[xhash].ToUpper();
                ENCCHASH = ENC.SHA512SqlServerHash(tgtfqn);
                CALCHASH = DBARCH.getSqlServerHASH(tgtfqn);
                if ((CALCHASH.ToUpper() ?? "") != (xhash.ToUpper() ?? ""))
                {
                    Console.WriteLine(tgtfqn);
                    Console.WriteLine("SQL Server Hash: " + xhash);
                    Console.WriteLine("Local Hash: " + CALCHASH);
                    Console.WriteLine("---");
                }
            }
        }

        private void ValidateLongDirectroryNamesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (ThreadSetNameHash.IsBusy)
            {
                SB.Text = "ABORTING, ALREADY EXECUTING...";
                return;
            }

            try
            {
                ThreadSetNameHash.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 90 - caught ThreadAbortException - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
            // DBARCH.setDSFQN()
        }

        private void TextStringHashToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string DirName = @"C:\dev\Ecm2020";
            string Hash1 = "";
            string Hash2 = "";
            DirName = DirName.ToUpper();
            Hash1 = DBARCH.getSqlServerHASH(DirName);
            Hash2 = ENC.SHA512SqlServerHash(DirName);
            Console.WriteLine(Hash1);
            Console.WriteLine(Hash2);
            Console.WriteLine("DONE...");
        }

        private void ThreadSetNameHash_DoWork(object sender, System.ComponentModel.DoWorkEventArgs e)
        {
            DBARCH.setDSFQN();
            MessageBox.Show("Analysis of long file names complete...");
        }

        private void ValidateLongDirectroryNamesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            if (ThreadSetNameHash.IsBusy)
            {
                SB.Text = "ABORTING, ALREADY EXECUTING...";
                return;
            }

            try
            {
                ThreadSetNameHash.RunWorkerAsync();
            }
            catch (ThreadAbortException ex)
            {
                LOG.WriteToArchiveLog("Thread 100A - caught ThreadSetNameHash - resetting.");
                Thread.ResetAbort();
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
                LOG.WriteToArchiveLog("Line: " + st.GetFrame(0).GetFileLineNumber().ToString());
            }
        }

        private void ValidateFileHASHCodesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DBARCH.validateFileHash();
            MessageBox.Show("File Hash validation complete...");
        }

        private void CheckBox2_CheckedChanged(object sender, EventArgs e)
        {
            if (lbArchiveDirs.SelectedItems.Count.Equals(0))
            {
                MessageBox.Show("To use this, one and only one directory must be selected, returning");
                return;
            }

            if (lbArchiveDirs.SelectedItems.Count > 1)
            {
                MessageBox.Show("To use this, one and only one directory must be selected - Please use the Utility Listener item to process multiple listeners, returning");
                return;
            }

            CheckBox2.Checked = false;
            ProcessListener(false);
            MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ");
        }

        private void ValidateProcessAsFileExtsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DBARCH.RebuildCrossIndexFileTypes();
        }

        private void LinkLabel2_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            MessageBox.Show("NOT Operable at this time...");
        }

        private void ManualEditListenerConfigToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string DirsToMonitor = System.Configuration.ConfigurationManager.AppSettings["DirsToMonitor"];
            Process.Start("notepad.exe", DirsToMonitor);
        }

        private void ContentNoLIstenerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var watch = Stopwatch.StartNew();
            modGlobals.TempDisableDirListener = true;
            bool PerformQUickArchive = false;
            BeginContentArchive(PerformQUickArchive);
            modGlobals.TempDisableDirListener = false;
            watch.Stop();
            decimal totsecs = 0m;
            totsecs = (decimal)watch.Elapsed.TotalSeconds;
            LOG.WriteToArchiveLog("*** TOTAL TIME FOR FULL SCAN Archive: " + totsecs.ToString() + " Seconds");
        }

        private void ValidateRetentionDatesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SB.Text = "Verifying Retention Dates";
            DBARCH.spUpdateRetention();
            SB.Text = "Retention Dates VERIFIED";
            MessageBox.Show("Retention Dates VERIFIED");
        }

        private void FulltextLogAnalysisToolStripMenuItem_Click(object sender, EventArgs e)
        {
            My.MyProject.Forms.frmFti.Show();
        }

        private void UpdateAvailableIFiltersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // spAddAvailExtensions
            DBARCH.ExecSP("spAddAvailExtensions");
            MessageBox.Show("Filters updated...");
        }

        private void ReInventoryAllFilesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DBLocal.ReInventory();
        }

        private void GetDirFilesByFilterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Dim sFiles() As String = Directory.GetFiles("c:\dev\Ecm2020", "*.pdf|*.xlsx|*.xls|*.docx|*.doc|*.txt", SearchOption.AllDirectories)
            int I = 0;
            try
            {
                Console.WriteLine("START: ");
                Console.WriteLine(DateAndTime.Now);
                string FileFilter = ".txt,.doc,.docx,*.pdf,";
                string DirName = @"c:\temp";
                if (!Directory.Exists(@"c:\temp"))
                {
                    MessageBox.Show(@"Directory C:\temp does not exist and this test is designed to run against that one only... returning.");
                    return;
                }

                DI = new DirectoryInfo(DirName);
                foreach (FileInfo FI in (IEnumerable)DI.GetFiles("*.*", SearchOption.AllDirectories))
                {
                    if (FileFilter.Contains(FI.Extension))
                    {
                        I += 1;
                    }
                }

                string msg = "";
                msg = "Number Of Files Found: " + I.ToString() + Environment.NewLine;
                Console.WriteLine("Number Of Files: " + I.ToString());
                Console.WriteLine("END: ");
                Console.WriteLine(DateAndTime.Now);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            MessageBox.Show("Number Of Files: " + I.ToString());
        }

        private void GenWhereINDictToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var tDict = new Dictionary<string, string>();
            tDict = DBARCH.getIncludedFileTypeWhereIn(modGlobals.gCurrLoginID);
            foreach (string str in tDict.Keys)
                Console.WriteLine("DIR:" + str + "  WhereIN: " + tDict[str]);
        }

        private void Label13_Click(object sender, EventArgs e)
        {
        }

        private void btnSetLastArchiveON_Click(object sender, EventArgs e)
        {
            DBLocal.TurnOnUseLastArchiveDateActive();
            if (modGlobals.gUseLastArchiveDate.Equals("1"))
            {
                lblUseLastArchiveDate.Text = "Last Arch ON";
            }
            else
            {
                lblUseLastArchiveDate.Text = "Last Arch OFF";
            }

            DBLocal.getUseLastArchiveDateActive();
            setLastArchiveLabel();
        }

        private void btnSetLastArchiveOFF_Click(object sender, EventArgs e)
        {
            DBLocal.TurnOffUseLastArchiveDateActive();
            if (modGlobals.gUseLastArchiveDate.Equals("1"))
            {
                lblUseLastArchiveDate.Text = "Last Arch ON";
            }
            else
            {
                lblUseLastArchiveDate.Text = "Last Arch OFF";
            }

            DBLocal.getUseLastArchiveDateActive();
            setLastArchiveLabel();
        }

        private void TurnONToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DBLocal.TurnOnUseLastArchiveDateActive();
            if (modGlobals.gUseLastArchiveDate.Equals("1"))
            {
                lblUseLastArchiveDate.Text = "Last Arch ON";
            }
            else
            {
                lblUseLastArchiveDate.Text = "Last Arch OFF";
            }

            DBLocal.getUseLastArchiveDateActive();
            setLastArchiveLabel();
        }

        private void TurnOFFToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DBLocal.TurnOffUseLastArchiveDateActive();
            if (modGlobals.gUseLastArchiveDate.Equals("1"))
            {
                lblUseLastArchiveDate.Text = "Last Arch ON";
            }
            else
            {
                lblUseLastArchiveDate.Text = "Last Arch OFF";
            }

            DBLocal.getUseLastArchiveDateActive();
            setLastArchiveLabel();
        }

        private void TurnListenerONToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ProcessListener(true);
            getListeners();
            MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ");
        }

        private void TurnListenerOFFToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ProcessListener(false);
            getListeners();
            MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ");
        }

        private void InitializeToGivenDateToolStripMenuItem_Click(object sender, EventArgs e)
        {
            object Message, Title, xDefault, MyValue;
            Message = "Enter a Date in the form of MM/DD/YYYY";    // Set prompt.
            Title = "Initialze Last Archive Date";    // Set title.
            string MO = DateAndTime.Now.Month.ToString();
            string DA = DateAndTime.Now.Day.ToString();
            string YR = DateAndTime.Now.Year.ToString();
            if (MO.Length.Equals(1))
            {
                MO = "0" + MO;
            }

            if (DA.Length.Equals(1))
            {
                DA = "0" + DA;
            }

            xDefault = MO + "/" + DA + "/" + YR;
            MyValue = Interaction.InputBox(Conversions.ToString(Message), Conversions.ToString(Title), Conversions.ToString(xDefault));
            if (Information.IsDate(MyValue))
            {
                DBLocal.InitUseLastArchiveDateActive(Conversions.ToString(MyValue));
                MessageBox.Show(Conversions.ToString(Operators.AddObject(Operators.AddObject(MyValue, " Last Archive date set to: "), MyValue)));
            }
            else
            {
                MessageBox.Show(Conversions.ToString(Operators.AddObject(MyValue, " does not appear to be a valid date, returning.")));
            }

            DBLocal.getUseLastArchiveDateActive();
            setLastArchiveLabel();
        }

        private void ValidateRepoContentsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msg = "This process can be very time consuming as few minutes or a few dyas, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Verify ALL Files in Repo", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            var watch = Stopwatch.StartNew();
            SB.Text = "CONTENT ARCHIVE LAUNCHED - Full ReInventory";
            modGlobals.TempDisableDirListener = true;
            // ------------------------------------------------
            int CurrUseDirectoryListener = modGlobals.UseDirectoryListener;
            modGlobals.UseDirectoryListener = 0;
            DBLocal.getUseLastArchiveDateActive();
            string CurrUseLastArchiveDate = modGlobals.gUseLastArchiveDate;
            modGlobals.gUseLastArchiveDate = "N";
            ResetSqlite();
            // ***************************************************************
            BeginContentArchive(true);
            modGlobals.TempDisableDirListener = false;
            // ***************************************************************
            modGlobals.gUseLastArchiveDate = CurrUseLastArchiveDate;
            modGlobals.UseDirectoryListener = CurrUseDirectoryListener;
            // ------------------------------------------------
            modGlobals.TempDisableDirListener = false;
            SB.Text = "CONTENT ARCHIVE COMPLETED";
            watch.Stop();
            decimal totsecs = 0m;
            totsecs = (decimal)watch.Elapsed.TotalSeconds;
            LOG.WriteToArchiveLog("*** TOTAL TIME FOR FULL INVENTORY: " + totsecs.ToString() + " Seconds");
        }

        private void ArchiveToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void ListenerONALLDirsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                int I = 0;
                var loopTo = lbArchiveDirs.Items.Count - 1;
                for (I = 0; I <= loopTo; I++)
                {
                    lbActiveFolder.SetSelected(I, true);
                    ProcessListener(true);
                    lbActiveFolder.SetSelected(I, false);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR: " + ex.Message);
            }

            MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ");
        }

        private void ListenerOFFALLDirsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                int I = 0;
                var loopTo = lbArchiveDirs.Items.Count - 1;
                for (I = 0; I <= loopTo; I++)
                {
                    lbActiveFolder.SetSelected(I, true);
                    ProcessListener(false);
                    lbActiveFolder.SetSelected(I, false);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR: " + ex.Message);
            }

            MessageBox.Show("IMPORTANT: You will have to stop and start the servive now as an ADMIN ");
        }

        private void NetworkListenerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            My.MyProject.Forms.FrmListenerTest.Show();
        }

        private void SQLiteDBConnectToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var dlg = new FolderBrowserDialog();
            string slDatabase = "";
            var SQLiteCONN = new SQLiteConnection();
            var result = OpenFileDialog1.ShowDialog();
            if (result == DialogResult.OK)
            {
                slDatabase = OpenFileDialog1.FileName;
            }

            if (slDatabase.Length.Equals(0))
            {
                MessageBox.Show("Cancelled, returning.");
                return;
            }

            try
            {
                if (!File.Exists(slDatabase))
                {
                    MessageBox.Show("SQLite DB MISSING: " + slDatabase);
                    return;
                }

                cs = "data source=" + slDatabase;
                modGlobals.gLocalDBCS = Conversions.ToString(cs);
                SQLiteCONN.ConnectionString = Conversions.ToString(cs);
                SQLiteCONN.Open();
                MessageBox.Show("SQLite Connected!!");
            }
            catch (Exception ex)
            {
                var LG = new clsLogging();
                MessageBox.Show("ERROR LOCALDB setSLConn: " + ex.Message);
            }
        }
    }

    [System.Runtime.Serialization.DataContract()]
    public class DS_RssPull
    {
        [System.Runtime.Serialization.DataMember()]
        public string RssName;
        [System.Runtime.Serialization.DataMember()]
        public string RssUrl;
        [System.Runtime.Serialization.DataMember()]
        public string UserID;
    }

    [System.Runtime.Serialization.DataContract()]
    public class DS_WebSite
    {
        [System.Runtime.Serialization.DataMember()]
        public string WebSite;
        [System.Runtime.Serialization.DataMember()]
        public string WebUrl;
        [System.Runtime.Serialization.DataMember()]
        public string UserID;
        [System.Runtime.Serialization.DataMember()]
        public int depth;
        [System.Runtime.Serialization.DataMember()]
        public int width;
    }

    [System.Runtime.Serialization.DataContract()]
    public class DS_WebScreen
    {
        [System.Runtime.Serialization.DataMember()]
        public string WebScreen;
        [System.Runtime.Serialization.DataMember()]
        public string WebUrl;
        [System.Runtime.Serialization.DataMember()]
        public string UserID;
    }

    public class DS_Content
    {
        public string RowGuid = "";
        public string SourceGuid = "";
        public string CreateDate = "";
        public string SourceName = "";
        public byte[] SourceImage = null;
        public string SourceTypeCode = "";
        public string FQN = "";
        public string VersionNbr = "";
        public string LastAccessDate = "";
        public string FileLength = "";
        public string LastWriteTime = "";
        public string UserID = "";
        public string DataSourceOwnerUserID = "";
        public string isPublic = "";
        public string FileDirectory = "";
        public string OriginalFileType = "";
        public string RetentionExpirationDate = "";
        public string IsPublicPreviousState = "";
        public string isAvailable = "";
        public string isContainedWithinZipFile = "";
        public string IsZipFile = "";
        public string DataVerified = "";
        public string ZipFileGuid = "";
        public string ZipFileFQN = "";
        public string Description = "";
        public string KeyWords = "";
        public string Notes = "";
        public string isPerm = "";
        public string isMaster = "";
        public string CreationDate = "";
        public string OcrPerformed = "";
        public string isGraphic = "";
        public string GraphicContainsText = "";
        public string OcrText = "";
        public string ImageHiddenText = "";
        public string isWebPage = "";
        public string ParentGuid = "";
        public string RetentionCode = "";
        public string MachineID = "";
        public string CRC = "";
        public string ImageHash = "";
        public string SharePoint = "";
        public string SharePointDoc = "";
        public string SharePointList = "";
        public string SharePointListItem = "";
        public string StructuredData = "";
        public string HiveConnectionName = "";
        public string HiveActive = "";
        public string RepoSvrName = "";
        public string RowCreationDate = "";
        public string RowLastModDate = "";
        public string ContainedWithin = "";
        public string RecLen = "";
        public string RecHash = "";
        public string OriginalSize = "";
        public string CompressedSize = "";
        public string txStartTime = "";
        public string txEndTime = "";
        public string txTotalTime = "";
        public string TransmitTime = "";
        public string FileAttached = "";
        public string BPS = "";
        public string RepoName = "";
        public string HashFile = "";
        public string HashName = "";
        public string OcrSuccessful = "";
        public string OcrPending = "";
        public string PdfIsSearchable = "";
        public string PdfOcrRequired = "";
        public string PdfOcrSuccess = "";
        public string PdfOcrTextExtracted = "";
        public string PdfPages = "";
        public string PdfImages = "";
        public string RequireOcr = "";
        public string RssLinkFlg = "";
        public string RssLinkGuid = "";
        public string PageURL = "";
        public string RetentionDate = "";
        public string URLHash = "";
        public string WebPagePublishDate = "";
        public string SapData = "";
        public string RowID = "";
    }

    public class DS_Email
    {
        public string EmailGuid = "";
        public string SUBJECT = "";
        public string SentTO = "";
        public string Body = "";
        public string Bcc = "";
        public string BillingInformation = "";
        public string CC = "";
        public string Companies = "";
        public string CreationTime = "";
        public string ReadReceiptRequested = "";
        public string ReceivedByName = "";
        public string ReceivedTime = "";
        public string AllRecipients = "";
        public string UserID = "";
        public string SenderEmailAddress = "";
        public string SenderName = "";
        public string Sensitivity = "";
        public string SentOn = "";
        public string MsgSize = "";
        public string DeferredDeliveryTime = "";
        public string EntryID = "";
        public string ExpiryTime = "";
        public string LastModificationTime = "";
        public byte[] EmailImage = null;
        public string Accounts = "";
        public string ShortSubj = "";
        public string SourceTypeCode = "";
        public string OriginalFolder = "";
        public string StoreID = "";
        public string isPublic = "";
        public string RetentionExpirationDate = "";
        public string IsPublicPreviousState = "";
        public string isAvailable = "";
        public string CurrMailFolderID = "";
        public string isPerm = "";
        public string isMaster = "";
        public string CreationDate = "";
        public string NbrAttachments = "";
        public string CRC = "";
        public string ImageHash = "";
        public string Description = "";
        public string KeyWords = "";
        public string RetentionCode = "";
        public string EmailIdentifier = "";
        public string ConvertEmlToMSG = "";
        public string HiveConnectionName = "";
        public string HiveActive = "";
        public string RepoSvrName = "";
        public string RowCreationDate = "";
        public string RowLastModDate = "";
        public string UIDL = "";
        public string RecLen = "";
        public string RecHash = "";
        public string OriginalSize = "";
        public string CompressedSize = "";
        public string txStartTime = "";
        public string txEndTime = "";
        public string txTotalTime = "";
        public string TransmitTime = "";
        public string FileAttached = "";
        public string BPS = "";
        public string RepoName = "";
        public string HashFile = "";
        public string HashName = "";
        public string ContainsAttachment = "";
        public string NbrAttachment = "";
        public string NbrZipFiles = "";
        public string NbrZipFilesCnt = "";
        public string PdfIsSearchable = "";
        public string PdfOcrRequired = "";
        public string PdfOcrSuccess = "";
        public string PdfOcrTextExtracted = "";
        public string PdfPages = "";
        public string PdfImages = "";
        public string MachineID = "";
        public string notes = "";
        public string NbrOccurances = "";
        public string RowID = "";
        public string RowGuid = "";
    }
}