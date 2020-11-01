using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmMain : Form
    {

        // Form overrides dispose to clean up the component list.
        [DebuggerNonUserCode()]
        protected override void Dispose(bool disposing)
        {
            if (disposing && components is object)
            {
                components.Dispose();
            }

            base.Dispose(disposing);
        }

        // Required by the Windows Form Designer
        private System.ComponentModel.IContainer components;

        // NOTE: The following procedure is required by the Windows Form Designer
        // It can be modified using the Windows Form Designer.  
        // Do not modify it using the code editor.
        [DebuggerStepThrough()]
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            var DataGridViewCellStyle1 = new DataGridViewCellStyle();
            var DataGridViewCellStyle2 = new DataGridViewCellStyle();
            var DataGridViewCellStyle3 = new DataGridViewCellStyle();
            var DataGridViewCellStyle4 = new DataGridViewCellStyle();
            var DataGridViewCellStyle5 = new DataGridViewCellStyle();
            var DataGridViewCellStyle6 = new DataGridViewCellStyle();
            var DataGridViewCellStyle7 = new DataGridViewCellStyle();
            gbEmail = new GroupBox();
            _Button4 = new Button();
            _Button4.Click += new EventHandler(Button4_Click);
            Label34 = new Label();
            LinkLabel2 = new LinkLabel();
            _LinkLabel1 = new LinkLabel();
            _LinkLabel1.LinkClicked += new LinkLabelLinkClickedEventHandler(LinkLabel1_LinkClicked);
            _hlExchange = new LinkLabel();
            _hlExchange.LinkClicked += new LinkLabelLinkClickedEventHandler(hlExchange_LinkClicked);
            Label16 = new Label();
            Label3 = new Label();
            Label2 = new Label();
            _ckExpand = new CheckBox();
            _ckExpand.CheckedChanged += new EventHandler(ckExpand_CheckedChanged);
            ckGetSubFolders = new CheckBox();
            ckDoNotShowArchived = new CheckBox();
            _cbParentFolders = new ComboBox();
            _cbParentFolders.SelectedIndexChanged += new EventHandler(cbParentFolders_SelectedIndexChanged);
            btnSMTP = new Button();
            cbEmailRetention = new ComboBox();
            ckSystemFolder = new CheckBox();
            _ckUseLastProcessDateAsCutoff = new CheckBox();
            _ckUseLastProcessDateAsCutoff.CheckedChanged += new EventHandler(ckUseLastProcessDateAsCutoff_CheckedChanged);
            ckArchiveRead = new CheckBox();
            _btnDeleteEmailEntry = new Button();
            _btnDeleteEmailEntry.Click += new EventHandler(btnDeleteEmailEntry_Click);
            _btnActive = new Button();
            _btnActive.Click += new EventHandler(btnActive_Click);
            cbEmailDB = new ComboBox();
            Label4 = new Label();
            NumericUpDown3 = new NumericUpDown();
            _ckRemoveAfterXDays = new CheckBox();
            _ckRemoveAfterXDays.CheckedChanged += new EventHandler(ckRemoveAfterXDays_CheckedChanged);
            _btnRefreshFolders = new Button();
            _btnRefreshFolders.Click += new EventHandler(btnRefreshFolders_Click);
            _btnSaveConditions = new Button();
            _btnSaveConditions.Click += new EventHandler(btnSaveConditions_Click);
            ckArchiveFolder = new CheckBox();
            _lbActiveFolder = new ListBox();
            _lbActiveFolder.MouseDown += new MouseEventHandler(lbActiveFolder_MouseDown);
            _lbActiveFolder.SelectedIndexChanged += new EventHandler(ListBox1_SelectedIndexChanged);
            lblVer = new Label();
            SB = new TextBox();
            gbFiletypes = new GroupBox();
            cbProcessAsList = new ComboBox();
            _Button2 = new Button();
            _Button2.Click += new EventHandler(Button2_Click);
            _Button1 = new Button();
            _Button1.Click += new EventHandler(Button1_Click);
            Label10 = new Label();
            Label9 = new Label();
            cbAsType = new ComboBox();
            cbPocessType = new ComboBox();
            _ckRemoveFileType = new Button();
            _ckRemoveFileType.Click += new EventHandler(ckRemoveAfterDays_Click);
            cbFileTypes = new ComboBox();
            _btnAddFiletype = new Button();
            _btnAddFiletype.Click += new EventHandler(btnAddFiletype_Click);
            _gbPolling = new GroupBox();
            _gbPolling.MouseHover += new EventHandler(gbPolling_MouseHover);
            ckWebSiteTrackerDisabled = new CheckBox();
            ckWebPageTrackerDisabled = new CheckBox();
            ckRssPullDisabled = new CheckBox();
            _ckRunOnStart = new CheckBox();
            _ckRunOnStart.CheckedChanged += new EventHandler(ckRunOnStart_CheckedChanged);
            _btnArchiveNow = new Button();
            _btnArchiveNow.Click += new EventHandler(btnArchiveNow_Click);
            Label1 = new Label();
            _nbrArchiveHours = new NumericUpDown();
            _nbrArchiveHours.ValueChanged += new EventHandler(NumericUpDown1_ValueChanged);
            _ckRunUnattended = new CheckBox();
            _ckRunUnattended.CheckedChanged += new EventHandler(ckRunUnattended_CheckedChanged);
            _ckDisableExchange = new CheckBox();
            _ckDisableExchange.CheckedChanged += new EventHandler(ckDisableExchange_CheckedChanged);
            _ckDisableOutlookEmailArchive = new CheckBox();
            _ckDisableOutlookEmailArchive.CheckedChanged += new EventHandler(ckDisableOutlookEmailArchive_CheckedChanged);
            _ckDisableContentArchive = new CheckBox();
            _ckDisableContentArchive.CheckedChanged += new EventHandler(ckDisableContentArchive_CheckedChanged);
            _btnSaveSchedule = new Button();
            _btnSaveSchedule.Click += new EventHandler(btnSaveSchedule_Click);
            _ckDisable = new CheckBox();
            _ckDisable.CheckedChanged += new EventHandler(ckDisable_CheckedChanged);
            PictureBox2 = new PictureBox();
            _gbContentMgt = new GroupBox();
            _gbContentMgt.Enter += new EventHandler(GroupBox2_Enter);
            _btnCountFiles = new Button();
            _btnCountFiles.Click += new EventHandler(btnCountFiles_Click);
            Panel2 = new Panel();
            _btnArchive1Doc = new Button();
            _btnArchive1Doc.Click += new EventHandler(btnArchive1Doc_Click);
            _ckDeleteAfterArchive = new CheckBox();
            _ckDeleteAfterArchive.CheckedChanged += new EventHandler(ckDeleteAfterArchive_CheckedChanged);
            _ckOcrPdf = new CheckBox();
            _ckOcrPdf.CheckedChanged += new EventHandler(ckOcrPdf_CheckedChanged);
            _ckShowLibs = new CheckBox();
            _ckShowLibs.CheckedChanged += new EventHandler(ckShowLibs_CheckedChanged);
            _btnRefreshRetent = new Button();
            _btnRefreshRetent.Click += new EventHandler(btnRefreshRetent_Click);
            _CkMonitor = new CheckBox();
            _CkMonitor.CheckedChanged += new EventHandler(CkMonitor_CheckedChanged);
            _ckArchiveBit = new CheckBox();
            _ckArchiveBit.CheckedChanged += new EventHandler(ckArchiveBit_CheckedChanged);
            Label13 = new Label();
            cbRetention = new ComboBox();
            _ckOcr = new CheckBox();
            _ckOcr.CheckedChanged += new EventHandler(ckOcr_CheckedChanged);
            _clAdminDir = new CheckBox();
            _clAdminDir.CheckedChanged += new EventHandler(clAdminDir_CheckedChanged);
            _ckDisableDir = new CheckBox();
            _ckDisableDir.CheckedChanged += new EventHandler(ckDisableDir_CheckedChanged);
            _ckPublic = new CheckBox();
            _ckPublic.CheckedChanged += new EventHandler(ckPublic_CheckedChanged);
            _ckMetaData = new CheckBox();
            _ckMetaData.CheckedChanged += new EventHandler(ckMetaData_CheckedChanged);
            _ckVersionFiles = new CheckBox();
            _ckVersionFiles.CheckedChanged += new EventHandler(ckVersionFiles_CheckedChanged);
            _ckSubDirs = new CheckBox();
            _ckSubDirs.CheckedChanged += new EventHandler(ckSubDirs_CheckedChanged);
            _txtDir = new TextBox();
            _txtDir.TextChanged += new EventHandler(txtDir_TextChanged);
            _btnRefresh = new Button();
            _btnRefresh.Click += new EventHandler(Button5_Click);
            _btnSaveChanges = new Button();
            _btnSaveChanges.Click += new EventHandler(Button6_Click);
            _btnRemoveDir = new Button();
            _btnRemoveDir.Click += new EventHandler(btnRemoveDir_Click);
            _btnSelDir = new Button();
            _btnSelDir.Click += new EventHandler(btnSelDir_Click);
            _lbArchiveDirs = new ListBox();
            _lbArchiveDirs.MouseDown += new MouseEventHandler(lbArchiveDirs_MouseDown);
            _lbArchiveDirs.SelectedIndexChanged += new EventHandler(ListBox2_SelectedIndexChanged);
            Panel1 = new Panel();
            Label36 = new Label();
            Label35 = new Label();
            Label7 = new Label();
            _lbExcludeExts = new ListBox();
            _lbExcludeExts.TextChanged += new EventHandler(lbExcludeExts_TextChanged);
            _lbExcludeExts.SelectedIndexChanged += new EventHandler(lbExcludeExts_SelectedIndexChanged);
            Label6 = new Label();
            Label5 = new Label();
            _lbAvailExts = new ListBox();
            _lbAvailExts.SelectedIndexChanged += new EventHandler(lbAvailExts_SelectedIndexChanged);
            _lbIncludeExts = new ListBox();
            _lbIncludeExts.SelectedIndexChanged += new EventHandler(lbIncludeExts_SelectedIndexChanged);
            _Button3 = new Button();
            _Button3.Click += new EventHandler(Button3_Click);
            _btnRemoveExclude = new Button();
            _btnRemoveExclude.Click += new EventHandler(btnRemoveExclude_Click);
            _btnInclFileType = new Button();
            _btnInclFileType.Click += new EventHandler(btnInclFileType_Click);
            _btnExclude = new Button();
            _btnExclude.Click += new EventHandler(btnExclude_Click);
            Panel3 = new Panel();
            _btnAddDefaults = new Button();
            _btnAddDefaults.Click += new EventHandler(btnAddDefaults_Click);
            _btnRefreshRebuild = new Button();
            _btnRefreshRebuild.Click += new EventHandler(btnRefreshRebuild_Click);
            Label12 = new Label();
            _btnDeleteDirProfile = new Button();
            _btnDeleteDirProfile.Click += new EventHandler(btnDeleteDirProfile_Click);
            _btnUpdateDirectoryProfile = new Button();
            _btnUpdateDirectoryProfile.Click += new EventHandler(btnUpdateDirectoryProfile_Click);
            _btnSaveDirProfile = new Button();
            _btnSaveDirProfile.Click += new EventHandler(btnSaveDirProfile_Click);
            _btnApplyDirProfile = new Button();
            _btnApplyDirProfile.Click += new EventHandler(btnApplyDirProfile_Click);
            cbDirProfile = new ComboBox();
            Label11 = new Label();
            _btnExclProfile = new Button();
            _btnExclProfile.Click += new EventHandler(btnExclProfile_Click);
            _btnInclProfile = new Button();
            _btnInclProfile.Click += new EventHandler(btnInclProfile_Click);
            _cbProfile = new ComboBox();
            _cbProfile.SelectedIndexChanged += new EventHandler(cbProfile_SelectedIndexChanged);
            _Label8 = new Label();
            _Label8.Click += new EventHandler(Label8_Click);
            _cbFileDB = new ComboBox();
            _cbFileDB.SelectedIndexChanged += new EventHandler(cbFileDB_SelectedIndexChanged);
            _btnAddDir = new Button();
            _btnAddDir.Click += new EventHandler(btnAddDir_Click);
            PictureBox1 = new PictureBox();
            _ckTerminate = new CheckBox();
            _ckTerminate.CheckedChanged += new EventHandler(ckTerminate_CheckedChanged);
            FolderBrowserDialog1 = new FolderBrowserDialog();
            TT = new ToolTip(components);
            _ckPauseListener = new CheckBox();
            _ckPauseListener.CheckedChanged += new EventHandler(ckPauseListener_CheckedChanged);
            btnFetch = new Button();
            txtRssURL = new TextBox();
            txtRssName = new TextBox();
            txtWebScreenUrl = new TextBox();
            txtWebScreenName = new TextBox();
            f1Help = new HelpProvider();
            SB2 = new TextBox();
            PBx = new ProgressBar();
            _ContextMenuStrip1 = new ContextMenuStrip(components);
            _ContextMenuStrip1.Opening += new System.ComponentModel.CancelEventHandler(ContextMenuStrip1_Opening);
            _ResetSelectedMailBoxesToolStripMenuItem = new ToolStripMenuItem();
            _ResetSelectedMailBoxesToolStripMenuItem.Click += new EventHandler(ResetSelectedMailBoxesToolStripMenuItem_Click);
            _EmailLibraryReassignmentToolStripMenuItem = new ToolStripMenuItem();
            _EmailLibraryReassignmentToolStripMenuItem.Click += new EventHandler(EmailLibraryReassignmentToolStripMenuItem_Click);
            _TimerListeners = new Timer(components);
            _TimerListeners.Tick += new EventHandler(TimerListeners_Tick);
            _TimerUploadFiles = new Timer(components);
            _TimerUploadFiles.Tick += new EventHandler(TimerUploadFiles_Tick);
            _TimerEndRun = new Timer(components);
            _TimerEndRun.Tick += new EventHandler(TimerEndRun_Tick);
            MenuStrip1 = new MenuStrip();
            ArchiveToolStripMenuItem = new ToolStripMenuItem();
            _ArchiveALLToolStripMenuItem = new ToolStripMenuItem();
            _ArchiveALLToolStripMenuItem.Click += new EventHandler(ArchiveALLToolStripMenuItem_Click);
            _OutlookEmailsToolStripMenuItem = new ToolStripMenuItem();
            _OutlookEmailsToolStripMenuItem.Click += new EventHandler(OutlookEmailsToolStripMenuItem_Click);
            _ExchangeEmailsToolStripMenuItem = new ToolStripMenuItem();
            _ExchangeEmailsToolStripMenuItem.Click += new EventHandler(ExchangeEmailsToolStripMenuItem_Click);
            _ContentToolStripMenuItem = new ToolStripMenuItem();
            _ContentToolStripMenuItem.Click += new EventHandler(ContentToolStripMenuItem_Click);
            _ContentReInventoryToolStripMenuItem = new ToolStripMenuItem();
            _ContentReInventoryToolStripMenuItem.Click += new EventHandler(ContentReInventoryToolStripMenuItem_Click);
            _ToolStripMenuItem1 = new ToolStripMenuItem();
            _ToolStripMenuItem1.Click += new EventHandler(ToolStripMenuItem1_Click);
            _ScheduleToolStripMenuItem = new ToolStripMenuItem();
            _ScheduleToolStripMenuItem.Click += new EventHandler(ScheduleToolStripMenuItem_Click);
            SetArchiveIntervalToolStripMenuItem = new ToolStripMenuItem();
            ToolStripSeparator7 = new ToolStripSeparator();
            _SelectedFilesToolStripMenuItem = new ToolStripMenuItem();
            _SelectedFilesToolStripMenuItem.Click += new EventHandler(SelectedFilesToolStripMenuItem_Click);
            ToolStripSeparator6 = new ToolStripSeparator();
            _ArchiveRSSPullsToolStripMenuItem = new ToolStripMenuItem();
            _ArchiveRSSPullsToolStripMenuItem.Click += new EventHandler(ArchiveRSSPullsToolStripMenuItem_Click);
            _WebSitesToolStripMenuItem = new ToolStripMenuItem();
            _WebSitesToolStripMenuItem.Click += new EventHandler(WebSitesToolStripMenuItem_Click);
            _WebPagesToolStripMenuItem = new ToolStripMenuItem();
            _WebPagesToolStripMenuItem.Click += new EventHandler(WebPagesToolStripMenuItem_Click);
            ToolStripSeparator5 = new ToolStripSeparator();
            _ExitToolStripMenuItem1 = new ToolStripMenuItem();
            _ExitToolStripMenuItem1.Click += new EventHandler(ExitToolStripMenuItem1_Click);
            LoginToolStripMenuItem = new ToolStripMenuItem();
            _LoginToSystemToolStripMenuItem = new ToolStripMenuItem();
            _LoginToSystemToolStripMenuItem.Click += new EventHandler(LoginToSystemToolStripMenuItem_Click);
            _ChangeUserPasswordToolStripMenuItem = new ToolStripMenuItem();
            _ChangeUserPasswordToolStripMenuItem.Click += new EventHandler(ChangeUserPasswordToolStripMenuItem_Click);
            TasksToolStripMenuItem = new ToolStripMenuItem();
            _ImpersonateLoginToolStripMenuItem = new ToolStripMenuItem();
            _ImpersonateLoginToolStripMenuItem.Click += new EventHandler(ImpersonateLoginToolStripMenuItem_Click);
            _LoginAsDifferenctUserToolStripMenuItem = new ToolStripMenuItem();
            _LoginAsDifferenctUserToolStripMenuItem.Click += new EventHandler(LoginAsDifferenctUserToolStripMenuItem_Click);
            _ManualEditAppConfigToolStripMenuItem = new ToolStripMenuItem();
            _ManualEditAppConfigToolStripMenuItem.Click += new EventHandler(ManualEditAppConfigToolStripMenuItem_Click);
            _ViewLogsToolStripMenuItem = new ToolStripMenuItem();
            _ViewLogsToolStripMenuItem.Click += new EventHandler(ViewLogsToolStripMenuItem_Click);
            _ViewOCRErrorFilesToolStripMenuItem = new ToolStripMenuItem();
            _ViewOCRErrorFilesToolStripMenuItem.Click += new EventHandler(ViewOCRErrorFilesToolStripMenuItem_Click);
            _AddDesktopIconToolStripMenuItem = new ToolStripMenuItem();
            _AddDesktopIconToolStripMenuItem.Click += new EventHandler(AddDesktopIconToolStripMenuItem_Click);
            UtilityToolStripMenuItem = new ToolStripMenuItem();
            RepositoryUtilitiesToolStripMenuItem = new ToolStripMenuItem();
            CleanupSourceNameToolStripMenuItem = new ToolStripMenuItem();
            _ClearRestoreQueueToolStripMenuItem1 = new ToolStripMenuItem();
            _ClearRestoreQueueToolStripMenuItem1.Click += new EventHandler(ClearRestoreQueueToolStripMenuItem1_Click);
            _CompareDirToRepositoryToolStripMenuItem1 = new ToolStripMenuItem();
            _CompareDirToRepositoryToolStripMenuItem1.Click += new EventHandler(CompareDirToRepositoryToolStripMenuItem1_Click);
            _InventoryDirectoryToolStripMenuItem1 = new ToolStripMenuItem();
            _InventoryDirectoryToolStripMenuItem1.Click += new EventHandler(InventoryDirectoryToolStripMenuItem1_Click);
            _ValidateDirectoryFilesToolStripMenuItem = new ToolStripMenuItem();
            _ValidateDirectoryFilesToolStripMenuItem.Click += new EventHandler(ValidateDirectoryFilesToolStripMenuItem_Click);
            ListenerUtilitiesToolStripMenuItem = new ToolStripMenuItem();
            _LIstWindowsLogsToolStripMenuItem = new ToolStripMenuItem();
            _LIstWindowsLogsToolStripMenuItem.Click += new EventHandler(LIstWindowsLogsToolStripMenuItem_Click);
            _CheckLogsForListenerInfoToolStripMenuItem = new ToolStripMenuItem();
            _CheckLogsForListenerInfoToolStripMenuItem.Click += new EventHandler(CheckLogsForListenerInfoToolStripMenuItem_Click);
            SQLiteUtiltiiesToolStripMenuItem = new ToolStripMenuItem();
            _ResetSQLiteArchivesToolStripMenuItem = new ToolStripMenuItem();
            _ResetSQLiteArchivesToolStripMenuItem.Click += new EventHandler(ResetSQLiteArchivesToolStripMenuItem_Click);
            _GetOutlookEMailIDsToolStripMenuItem1 = new ToolStripMenuItem();
            _GetOutlookEMailIDsToolStripMenuItem1.Click += new EventHandler(GetOutlookEMailIDsToolStripMenuItem1_Click);
            _ResetZIPFilesToolStripMenuItem = new ToolStripMenuItem();
            _ResetZIPFilesToolStripMenuItem.Click += new EventHandler(ResetZIPFilesToolStripMenuItem_Click);
            _ResetEmailIdentifierCodesToolStripMenuItem = new ToolStripMenuItem();
            _ResetEmailIdentifierCodesToolStripMenuItem.Click += new EventHandler(ResetEmailIdentifierCodesToolStripMenuItem_Click);
            _RebuildSQLiteDBToolStripMenuItem1 = new ToolStripMenuItem();
            _RebuildSQLiteDBToolStripMenuItem1.Click += new EventHandler(RebuildSQLiteDBToolStripMenuItem1_Click);
            _BackupSQLiteDBToolStripMenuItem1 = new ToolStripMenuItem();
            _BackupSQLiteDBToolStripMenuItem1.Click += new EventHandler(BackupSQLiteDBToolStripMenuItem1_Click);
            _RestoreSQLiteDBToolStripMenuItem1 = new ToolStripMenuItem();
            _RestoreSQLiteDBToolStripMenuItem1.Click += new EventHandler(RestoreSQLiteDBToolStripMenuItem1_Click);
            _SQToolStripMenuItem = new ToolStripMenuItem();
            _SQToolStripMenuItem.Click += new EventHandler(SQToolStripMenuItem_Click);
            ReOCRToolStripMenuItem = new ToolStripMenuItem();
            _EstimateNumberOfFilesToolStripMenuItem = new ToolStripMenuItem();
            _EstimateNumberOfFilesToolStripMenuItem.Click += new EventHandler(EstimateNumberOfFilesToolStripMenuItem_Click);
            ToolStripSeparator3 = new ToolStripSeparator();
            _ReOcrIncompleteGraphicFilesToolStripMenuItem = new ToolStripMenuItem();
            _ReOcrIncompleteGraphicFilesToolStripMenuItem.Click += new EventHandler(ReOcrIncompleteGraphicFilesToolStripMenuItem_Click);
            _ReOcrALLGraphicFilesToolStripMenuItem1 = new ToolStripMenuItem();
            _ReOcrALLGraphicFilesToolStripMenuItem1.Click += new EventHandler(ReOcrALLGraphicFilesToolStripMenuItem1_Click);
            RetentionManagementToolStripMenuItem = new ToolStripMenuItem();
            _RetentionRulesToolStripMenuItem = new ToolStripMenuItem();
            _RetentionRulesToolStripMenuItem.Click += new EventHandler(RetentionRulesToolStripMenuItem_Click);
            _RulesExecutionToolStripMenuItem = new ToolStripMenuItem();
            _RulesExecutionToolStripMenuItem.Click += new EventHandler(RulesExecutionToolStripMenuItem_Click);
            _EncryptStringToolStripMenuItem = new ToolStripMenuItem();
            _EncryptStringToolStripMenuItem.Click += new EventHandler(EncryptStringToolStripMenuItem_Click);
            _OpenLicenseFormToolStripMenuItem = new ToolStripMenuItem();
            _OpenLicenseFormToolStripMenuItem.Click += new EventHandler(OpenLicenseFormToolStripMenuItem_Click);
            _CheckForUpdatesToolStripMenuItem = new ToolStripMenuItem();
            _CheckForUpdatesToolStripMenuItem.Click += new EventHandler(CheckForUpdatesToolStripMenuItem_Click);
            _ShowSystemVersionToolStripMenuItem = new ToolStripMenuItem();
            _ShowSystemVersionToolStripMenuItem.Click += new EventHandler(ShowSystemVersionToolStripMenuItem_Click);
            SelectionToolStripMenuItem = new ToolStripMenuItem();
            _AllToolStripMenuItem = new ToolStripMenuItem();
            _AllToolStripMenuItem.Click += new EventHandler(AllToolStripMenuItem_Click);
            _EmailToolStripMenuItem = new ToolStripMenuItem();
            _EmailToolStripMenuItem.Click += new EventHandler(EmailToolStripMenuItem_Click);
            _ContentToolStripMenuItem1 = new ToolStripMenuItem();
            _ContentToolStripMenuItem1.Click += new EventHandler(ContentToolStripMenuItem1_Click);
            _ExecutionControlToolStripMenuItem = new ToolStripMenuItem();
            _ExecutionControlToolStripMenuItem.Click += new EventHandler(ExecutionControlToolStripMenuItem_Click);
            _FileTypesToolStripMenuItem = new ToolStripMenuItem();
            _FileTypesToolStripMenuItem.Click += new EventHandler(FileTypesToolStripMenuItem_Click);
            TestToolStripMenuItem = new ToolStripMenuItem();
            _DirectoryInventoryToolStripMenuItem = new ToolStripMenuItem();
            _DirectoryInventoryToolStripMenuItem.Click += new EventHandler(DirectoryInventoryToolStripMenuItem_Click);
            _ListFilesInDirectoryToolStripMenuItem = new ToolStripMenuItem();
            _ListFilesInDirectoryToolStripMenuItem.Click += new EventHandler(ListFilesInDirectoryToolStripMenuItem_Click);
            _GetAllSubdirFilesToolStripMenuItem = new ToolStripMenuItem();
            _GetAllSubdirFilesToolStripMenuItem.Click += new EventHandler(GetAllSubdirFilesToolStripMenuItem_Click);
            OCRToolStripMenuItem = new ToolStripMenuItem();
            _FileHashToolStripMenuItem = new ToolStripMenuItem();
            _FileHashToolStripMenuItem.Click += new EventHandler(FileHashToolStripMenuItem_Click);
            _FileUploadToolStripMenuItem = new ToolStripMenuItem();
            _FileUploadToolStripMenuItem.Click += new EventHandler(FileUploadToolStripMenuItem_Click);
            _FileUploadBufferedToolStripMenuItem = new ToolStripMenuItem();
            _FileUploadBufferedToolStripMenuItem.Click += new EventHandler(FileUploadBufferedToolStripMenuItem_Click);
            _FileChunkUploadToolStripMenuItem = new ToolStripMenuItem();
            _FileChunkUploadToolStripMenuItem.Click += new EventHandler(FileChunkUploadToolStripMenuItem_Click);
            _RSSPullToolStripMenuItem = new ToolStripMenuItem();
            _RSSPullToolStripMenuItem.Click += new EventHandler(RSSPullToolStripMenuItem_Click);
            ShowEndpointsToolStripMenuItem = new ToolStripMenuItem();
            _UnhandledExceptionsToolStripMenuItem = new ToolStripMenuItem();
            _UnhandledExceptionsToolStripMenuItem.Click += new EventHandler(UnhandledExceptionsToolStripMenuItem_Click);
            ListenerFunctionsToolStripMenuItem = new ToolStripMenuItem();
            _GetListenerFilesToolStripMenuItem = new ToolStripMenuItem();
            _GetListenerFilesToolStripMenuItem.Click += new EventHandler(GetListenerFilesToolStripMenuItem_Click);
            _ExitToolStripMenuItem = new ToolStripMenuItem();
            _ExitToolStripMenuItem.Click += new EventHandler(ExitToolStripMenuItem_Click);
            HelpToolStripMenuItem = new ToolStripMenuItem();
            _AboutToolStripMenuItem = new ToolStripMenuItem();
            _AboutToolStripMenuItem.Click += new EventHandler(AboutToolStripMenuItem_Click);
            _OnlineHelpToolStripMenuItem = new ToolStripMenuItem();
            _OnlineHelpToolStripMenuItem.Click += new EventHandler(OnlineHelpToolStripMenuItem_Click);
            ToolStripSeparator4 = new ToolStripSeparator();
            _AppConfigVersionToolStripMenuItem = new ToolStripMenuItem();
            _AppConfigVersionToolStripMenuItem.Click += new EventHandler(AppConfigVersionToolStripMenuItem_Click);
            _RunningArchiverToolStripMenuItem = new ToolStripMenuItem();
            _RunningArchiverToolStripMenuItem.Click += new EventHandler(RunningArchiverToolStripMenuItem_Click);
            _ParameterExecutionToolStripMenuItem = new ToolStripMenuItem();
            _ParameterExecutionToolStripMenuItem.Click += new EventHandler(ParameterExecutionToolStripMenuItem_Click);
            _HistoryToolStripMenuItem = new ToolStripMenuItem();
            _HistoryToolStripMenuItem.Click += new EventHandler(HistoryToolStripMenuItem_Click);
            StatusStrip1 = new StatusStrip();
            infoDaysToExpire = new ToolStripStatusLabel();
            tssServer = new ToolStripStatusLabel();
            tssVersion = new ToolStripStatusLabel();
            tssAuth = new ToolStripStatusLabel();
            tssUser = new ToolStripStatusLabel();
            tbExchange = new ToolStripStatusLabel();
            PB1 = new ToolStripProgressBar();
            tsStatus02 = new ToolStripStatusLabel();
            SB5 = new ToolStripStatusLabel();
            ToolStripStatusLabel1 = new ToolStripStatusLabel();
            tsBytesLoading = new ToolStripStatusLabel();
            tsServiceDBConnState = new ToolStripStatusLabel();
            tsTunnelConn = new ToolStripStatusLabel();
            tsCurrentRepoID = new ToolStripStatusLabel();
            tsLastArchive = new ToolStripStatusLabel();
            tsCountDown = new ToolStripStatusLabel();
            tsTimeToArchive = new ToolStripStatusLabel();
            _TimerQuickArchive = new Timer(components);
            _TimerQuickArchive.Tick += new EventHandler(TimerQuickArchive_Tick);
            TabControl1 = new TabControl();
            TabPage1 = new TabPage();
            TabPage2 = new TabPage();
            TabPage4 = new TabPage();
            cbRssRetention = new ComboBox();
            Label31 = new Label();
            _dgRss = new DataGridView();
            _dgRss.SelectionChanged += new EventHandler(dgRss_SelectionChanged);
            _btnRemoveRSSfeed = new Button();
            _btnRemoveRSSfeed.Click += new EventHandler(btnRemoveRSSfeed_Click);
            _btnAddRssFeed = new Button();
            _btnAddRssFeed.Click += new EventHandler(btnAddRssFeed_Click);
            Label22 = new Label();
            Label21 = new Label();
            Label20 = new Label();
            Label17 = new Label();
            TabPage5 = new TabPage();
            cbWebPageRetention = new ComboBox();
            Label32 = new Label();
            _btnRemoveWebPage = new Button();
            _btnRemoveWebPage.Click += new EventHandler(btnRemoveWebPage_Click);
            _btnSaveWebPage = new Button();
            _btnSaveWebPage.Click += new EventHandler(btnSaveWebPage_Click);
            Label23 = new Label();
            Label24 = new Label();
            _dgWebPage = new DataGridView();
            _dgWebPage.SelectionChanged += new EventHandler(dgWebPage_SelectionChanged);
            Label25 = new Label();
            Label18 = new Label();
            TabPage6 = new TabPage();
            cbWebSiteRetention = new ComboBox();
            Label33 = new Label();
            nbrOutboundLinks = new NumericUpDown();
            nbrDepth = new NumericUpDown();
            Label30 = new Label();
            Label29 = new Label();
            _btnRemoveWebSite = new Button();
            _btnRemoveWebSite.Click += new EventHandler(btnRemoveWebSite_Click);
            _btnSaveWebSite = new Button();
            _btnSaveWebSite.Click += new EventHandler(btnSaveWebSite_Click);
            txtWebSiteURL = new TextBox();
            Label26 = new Label();
            txtWebSiteName = new TextBox();
            Label27 = new Label();
            _dgWebSite = new DataGridView();
            _dgWebSite.SelectionChanged += new EventHandler(dgWebSite_SelectionChanged);
            Label28 = new Label();
            Label19 = new Label();
            TabPage3 = new TabPage();
            GroupBox1 = new GroupBox();
            txtCompany = new TextBox();
            btnActivate = new Button();
            cbRepo = new ComboBox();
            Label15 = new Label();
            Label14 = new Label();
            _btnDefaultAsso = new Button();
            _btnDefaultAsso.Click += new EventHandler(btnDefaultAsso_Click);
            _btnRefreshDefaults = new Button();
            _btnRefreshDefaults.Click += new EventHandler(btnRefreshDefaults_Click);
            OpenFileDialog1 = new OpenFileDialog();
            _BackgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            _BackgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(BackgroundWorker1_DoWork);
            _BackgroundWorker2 = new System.ComponentModel.BackgroundWorker();
            _BackgroundWorker2.DoWork += new System.ComponentModel.DoWorkEventHandler(BackgroundWorker2_DoWork);
            _ContentThread = new System.ComponentModel.BackgroundWorker();
            _ContentThread.DoWork += new System.ComponentModel.DoWorkEventHandler(ContentThread_DoWork);
            _BackgroundDirListener = new System.ComponentModel.BackgroundWorker();
            _BackgroundDirListener.DoWork += new System.ComponentModel.DoWorkEventHandler(BackgroundDirListener_DoWork);
            _BackgroundWorkerContacts = new System.ComponentModel.BackgroundWorker();
            _BackgroundWorkerContacts.DoWork += new System.ComponentModel.DoWorkEventHandler(BackgroundWorkerContacts_DoWork);
            _asyncBatchOcrALL = new System.ComponentModel.BackgroundWorker();
            _asyncBatchOcrALL.DoWork += new System.ComponentModel.DoWorkEventHandler(asyncBatchOcrALL_DoWork);
            _asyncBatchOcrPending = new System.ComponentModel.BackgroundWorker();
            _asyncBatchOcrPending.DoWork += new System.ComponentModel.DoWorkEventHandler(asyncBatchOcrPending_DoWork);
            _asyncVerifyRetainDates = new System.ComponentModel.BackgroundWorker();
            _asyncVerifyRetainDates.DoWork += new System.ComponentModel.DoWorkEventHandler(asyncVerifyRetainDates_DoWork);
            _asyncRssPull = new System.ComponentModel.BackgroundWorker();
            _asyncRssPull.DoWork += new System.ComponentModel.DoWorkEventHandler(AsyncRssPull_DoWork);
            _asyncSpiderWebSite = new System.ComponentModel.BackgroundWorker();
            _asyncSpiderWebSite.DoWork += new System.ComponentModel.DoWorkEventHandler(asyncSpiderWebSite_DoWork);
            _asyncSpiderWebPage = new System.ComponentModel.BackgroundWorker();
            _asyncSpiderWebPage.DoWork += new System.ComponentModel.DoWorkEventHandler(AsyncSpiderWebPage_DoWork);
            Label37 = new Label();
            lblCustomerName = new Label();
            lblCustomerID = new Label();
            Label39 = new Label();
            _TimerAutoExec = new Timer(components);
            _TimerAutoExec.Tick += new EventHandler(TimerAutoExec_Tick);
            lblNotice = new Label();
            _ThreadValidateSourceName = new System.ComponentModel.BackgroundWorker();
            _ThreadValidateSourceName.DoWork += new System.ComponentModel.DoWorkEventHandler(ThreadValidateSourceName_DoWork_1);
            gbEmail.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)NumericUpDown3).BeginInit();
            gbFiletypes.SuspendLayout();
            _gbPolling.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)_nbrArchiveHours).BeginInit();
            ((System.ComponentModel.ISupportInitialize)PictureBox2).BeginInit();
            _gbContentMgt.SuspendLayout();
            Panel2.SuspendLayout();
            Panel1.SuspendLayout();
            Panel3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)PictureBox1).BeginInit();
            _ContextMenuStrip1.SuspendLayout();
            MenuStrip1.SuspendLayout();
            StatusStrip1.SuspendLayout();
            TabControl1.SuspendLayout();
            TabPage1.SuspendLayout();
            TabPage2.SuspendLayout();
            TabPage4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)_dgRss).BeginInit();
            TabPage5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)_dgWebPage).BeginInit();
            TabPage6.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)nbrOutboundLinks).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nbrDepth).BeginInit();
            ((System.ComponentModel.ISupportInitialize)_dgWebSite).BeginInit();
            TabPage3.SuspendLayout();
            GroupBox1.SuspendLayout();
            SuspendLayout();
            // 
            // gbEmail
            // 
            gbEmail.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            gbEmail.BackColor = Color.LightGray;
            gbEmail.Controls.Add(_Button4);
            gbEmail.Controls.Add(Label34);
            gbEmail.Controls.Add(LinkLabel2);
            gbEmail.Controls.Add(_LinkLabel1);
            gbEmail.Controls.Add(_hlExchange);
            gbEmail.Controls.Add(Label16);
            gbEmail.Controls.Add(Label3);
            gbEmail.Controls.Add(Label2);
            gbEmail.Controls.Add(_ckExpand);
            gbEmail.Controls.Add(ckGetSubFolders);
            gbEmail.Controls.Add(ckDoNotShowArchived);
            gbEmail.Controls.Add(_cbParentFolders);
            gbEmail.Controls.Add(btnSMTP);
            gbEmail.Controls.Add(cbEmailRetention);
            gbEmail.Controls.Add(ckSystemFolder);
            gbEmail.Controls.Add(_ckUseLastProcessDateAsCutoff);
            gbEmail.Controls.Add(ckArchiveRead);
            gbEmail.Controls.Add(_btnDeleteEmailEntry);
            gbEmail.Controls.Add(_btnActive);
            gbEmail.Controls.Add(cbEmailDB);
            gbEmail.Controls.Add(Label4);
            gbEmail.Controls.Add(NumericUpDown3);
            gbEmail.Controls.Add(_ckRemoveAfterXDays);
            gbEmail.Controls.Add(_btnRefreshFolders);
            gbEmail.Controls.Add(_btnSaveConditions);
            gbEmail.Controls.Add(ckArchiveFolder);
            gbEmail.Controls.Add(_lbActiveFolder);
            gbEmail.FlatStyle = FlatStyle.Popup;
            gbEmail.Location = new Point(12, 7);
            gbEmail.Margin = new Padding(4);
            gbEmail.Name = "gbEmail";
            gbEmail.Padding = new Padding(4);
            gbEmail.Size = new Size(1196, 587);
            gbEmail.TabIndex = 4;
            gbEmail.TabStop = false;
            gbEmail.Text = "Outlook Email Archive";
            // 
            // Button4
            // 
            _Button4.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _Button4.BackColor = Color.Transparent;
            _Button4.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _Button4.Location = new Point(805, 475);
            _Button4.Margin = new Padding(4);
            _Button4.Name = "_Button4";
            _Button4.Size = new Size(115, 39);
            _Button4.TabIndex = 74;
            _Button4.Text = "Test SQLite";
            _Button4.UseVisualStyleBackColor = false;
            // 
            // Label34
            // 
            Label34.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label34.AutoSize = true;
            Label34.Location = new Point(801, 127);
            Label34.Margin = new Padding(4, 0, 4, 0);
            Label34.Name = "Label34";
            Label34.Size = new Size(213, 17);
            Label34.TabIndex = 73;
            Label34.Text = "Set up your own library to share.";
            TT.SetToolTip(Label34, "Click an item in the grid and right mouse for the library definition menu.");
            // 
            // LinkLabel2
            // 
            LinkLabel2.AutoSize = true;
            LinkLabel2.Location = new Point(547, 31);
            LinkLabel2.Margin = new Padding(4, 0, 4, 0);
            LinkLabel2.Name = "LinkLabel2";
            LinkLabel2.Size = new Size(59, 17);
            LinkLabel2.TabIndex = 72;
            LinkLabel2.TabStop = true;
            LinkLabel2.Text = "Validate";
            TT.SetToolTip(LinkLabel2, "If executing from a machine different than your usual, press this button to valid" + "ate your \"access\" level.");
            // 
            // LinkLabel1
            // 
            _LinkLabel1.AutoSize = true;
            _LinkLabel1.Location = new Point(469, 31);
            _LinkLabel1.Margin = new Padding(4, 0, 4, 0);
            _LinkLabel1.Name = "_LinkLabel1";
            _LinkLabel1.Size = new Size(68, 17);
            _LinkLabel1.TabIndex = 71;
            _LinkLabel1.TabStop = true;
            _LinkLabel1.Text = "PST Files";
            // 
            // hlExchange
            // 
            _hlExchange.AutoSize = true;
            _hlExchange.Location = new Point(351, 31);
            _hlExchange.Margin = new Padding(4, 0, 4, 0);
            _hlExchange.Name = "_hlExchange";
            _hlExchange.Size = new Size(108, 17);
            _hlExchange.TabIndex = 70;
            _hlExchange.TabStop = true;
            _hlExchange.Text = "Exchange Email";
            // 
            // Label16
            // 
            Label16.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label16.AutoSize = true;
            Label16.Location = new Point(801, 111);
            Label16.Margin = new Padding(4, 0, 4, 0);
            Label16.Name = "Label16";
            Label16.Size = new Size(291, 17);
            Label16.TabIndex = 69;
            Label16.Text = "Note: All emails are stored private by default.";
            TT.SetToolTip(Label16, "Click an item in the grid and right mouse for the library definition menu.");
            // 
            // Label3
            // 
            Label3.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label3.AutoSize = true;
            Label3.Location = new Point(801, 150);
            Label3.Margin = new Padding(4, 0, 4, 0);
            Label3.Name = "Label3";
            Label3.Size = new Size(109, 17);
            Label3.TabIndex = 68;
            Label3.Text = "Retention Rules";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.BackColor = Color.Transparent;
            Label2.Location = new Point(8, 59);
            Label2.Margin = new Padding(4, 0, 4, 0);
            Label2.Name = "Label2";
            Label2.Size = new Size(181, 17);
            Label2.TabIndex = 67;
            Label2.Text = "Selected Outlook Container";
            // 
            // ckExpand
            // 
            _ckExpand.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _ckExpand.AutoSize = true;
            _ckExpand.BackColor = Color.Transparent;
            _ckExpand.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckExpand.ForeColor = Color.Black;
            _ckExpand.Location = new Point(711, 54);
            _ckExpand.Margin = new Padding(4);
            _ckExpand.Name = "_ckExpand";
            _ckExpand.Size = new Size(83, 21);
            _ckExpand.TabIndex = 66;
            _ckExpand.Text = "Expand";
            _ckExpand.UseVisualStyleBackColor = false;
            _ckExpand.Visible = false;
            // 
            // ckGetSubFolders
            // 
            ckGetSubFolders.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckGetSubFolders.AutoSize = true;
            ckGetSubFolders.BackColor = Color.Transparent;
            ckGetSubFolders.ForeColor = Color.Black;
            ckGetSubFolders.Location = new Point(806, 316);
            ckGetSubFolders.Margin = new Padding(4);
            ckGetSubFolders.Name = "ckGetSubFolders";
            ckGetSubFolders.Size = new Size(158, 21);
            ckGetSubFolders.TabIndex = 64;
            ckGetSubFolders.Text = "Archive Sub-Folders";
            ckGetSubFolders.UseVisualStyleBackColor = false;
            ckGetSubFolders.Visible = false;
            // 
            // ckDoNotShowArchived
            // 
            ckDoNotShowArchived.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckDoNotShowArchived.AutoSize = true;
            ckDoNotShowArchived.BackColor = Color.Transparent;
            ckDoNotShowArchived.Checked = true;
            ckDoNotShowArchived.CheckState = CheckState.Checked;
            ckDoNotShowArchived.ForeColor = Color.Black;
            ckDoNotShowArchived.Location = new Point(805, 203);
            ckDoNotShowArchived.Margin = new Padding(4);
            ckDoNotShowArchived.Name = "ckDoNotShowArchived";
            ckDoNotShowArchived.Size = new Size(233, 21);
            ckDoNotShowArchived.TabIndex = 62;
            ckDoNotShowArchived.Text = "1. Do not show already archived";
            ckDoNotShowArchived.UseVisualStyleBackColor = false;
            // 
            // cbParentFolders
            // 
            _cbParentFolders.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            _cbParentFolders.FormattingEnabled = true;
            _cbParentFolders.Location = new Point(11, 79);
            _cbParentFolders.Margin = new Padding(4);
            _cbParentFolders.Name = "_cbParentFolders";
            _cbParentFolders.Size = new Size(781, 24);
            _cbParentFolders.TabIndex = 59;
            TT.SetToolTip(_cbParentFolders, "This is the list of Parent Outlook Folders");
            // 
            // btnSMTP
            // 
            btnSMTP.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            btnSMTP.Enabled = false;
            btnSMTP.Location = new Point(827, 9);
            btnSMTP.Margin = new Padding(4);
            btnSMTP.Name = "btnSMTP";
            btnSMTP.Size = new Size(60, 30);
            btnSMTP.TabIndex = 58;
            btnSMTP.Text = "SMTP";
            TT.SetToolTip(btnSMTP, "Set up the SMTP properties");
            btnSMTP.UseVisualStyleBackColor = true;
            btnSMTP.Visible = false;
            // 
            // cbEmailRetention
            // 
            cbEmailRetention.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            cbEmailRetention.FormattingEnabled = true;
            cbEmailRetention.Location = new Point(805, 170);
            cbEmailRetention.Margin = new Padding(4);
            cbEmailRetention.Name = "cbEmailRetention";
            cbEmailRetention.Size = new Size(360, 24);
            cbEmailRetention.Sorted = true;
            cbEmailRetention.TabIndex = 56;
            TT.SetToolTip(cbEmailRetention, "When blank, default retention value will be used.");
            // 
            // ckSystemFolder
            // 
            ckSystemFolder.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckSystemFolder.AutoSize = true;
            ckSystemFolder.BackColor = Color.Transparent;
            ckSystemFolder.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            ckSystemFolder.ForeColor = Color.Black;
            ckSystemFolder.Location = new Point(804, 373);
            ckSystemFolder.Margin = new Padding(4);
            ckSystemFolder.Name = "ckSystemFolder";
            ckSystemFolder.Size = new Size(157, 21);
            ckSystemFolder.TabIndex = 38;
            ckSystemFolder.Text = "Mandatory Folder";
            TT.SetToolTip(ckSystemFolder, "Admins, Check to make this folder a mandatory backup folder, all users will inclu" + "de this folder.");
            ckSystemFolder.UseVisualStyleBackColor = false;
            // 
            // ckUseLastProcessDateAsCutoff
            // 
            _ckUseLastProcessDateAsCutoff.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _ckUseLastProcessDateAsCutoff.AutoSize = true;
            _ckUseLastProcessDateAsCutoff.BackColor = Color.Transparent;
            _ckUseLastProcessDateAsCutoff.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckUseLastProcessDateAsCutoff.ForeColor = Color.Black;
            _ckUseLastProcessDateAsCutoff.Location = new Point(805, 345);
            _ckUseLastProcessDateAsCutoff.Margin = new Padding(4);
            _ckUseLastProcessDateAsCutoff.Name = "_ckUseLastProcessDateAsCutoff";
            _ckUseLastProcessDateAsCutoff.Size = new Size(184, 21);
            _ckUseLastProcessDateAsCutoff.TabIndex = 37;
            _ckUseLastProcessDateAsCutoff.Text = "Use Last Folder Date";
            TT.SetToolTip(_ckUseLastProcessDateAsCutoff, "Chieck this to allow only emails downloaded after the successful archive to be co" + "nsidered.");
            _ckUseLastProcessDateAsCutoff.UseVisualStyleBackColor = false;
            // 
            // ckArchiveRead
            // 
            ckArchiveRead.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckArchiveRead.AutoSize = true;
            ckArchiveRead.BackColor = Color.Transparent;
            ckArchiveRead.ForeColor = Color.Black;
            ckArchiveRead.Location = new Point(806, 260);
            ckArchiveRead.Margin = new Padding(4);
            ckArchiveRead.Name = "ckArchiveRead";
            ckArchiveRead.Size = new Size(224, 21);
            ckArchiveRead.TabIndex = 36;
            ckArchiveRead.Text = "3. Do Not Move Unread Emails";
            ckArchiveRead.UseVisualStyleBackColor = false;
            // 
            // btnDeleteEmailEntry
            // 
            _btnDeleteEmailEntry.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnDeleteEmailEntry.BackColor = Color.Transparent;
            _btnDeleteEmailEntry.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _btnDeleteEmailEntry.ForeColor = Color.Black;
            _btnDeleteEmailEntry.Location = new Point(927, 428);
            _btnDeleteEmailEntry.Margin = new Padding(4);
            _btnDeleteEmailEntry.Name = "_btnDeleteEmailEntry";
            _btnDeleteEmailEntry.Size = new Size(113, 39);
            _btnDeleteEmailEntry.TabIndex = 35;
            _btnDeleteEmailEntry.Text = "Deactivate";
            _btnDeleteEmailEntry.UseVisualStyleBackColor = false;
            // 
            // btnActive
            // 
            _btnActive.Location = new Point(175, 23);
            _btnActive.Margin = new Padding(4);
            _btnActive.Name = "_btnActive";
            _btnActive.Size = new Size(152, 30);
            _btnActive.TabIndex = 27;
            _btnActive.Text = "Archived";
            _btnActive.UseVisualStyleBackColor = true;
            // 
            // cbEmailDB
            // 
            cbEmailDB.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            cbEmailDB.Enabled = false;
            cbEmailDB.FormattingEnabled = true;
            cbEmailDB.Location = new Point(935, 10);
            cbEmailDB.Margin = new Padding(4);
            cbEmailDB.Name = "cbEmailDB";
            cbEmailDB.Size = new Size(227, 24);
            cbEmailDB.Sorted = true;
            cbEmailDB.TabIndex = 26;
            cbEmailDB.Text = "ECMREPO";
            cbEmailDB.Visible = false;
            // 
            // Label4
            // 
            Label4.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label4.AutoSize = true;
            Label4.BackColor = Color.Transparent;
            Label4.ForeColor = Color.Black;
            Label4.Location = new Point(1036, 290);
            Label4.Margin = new Padding(4, 0, 4, 0);
            Label4.Name = "Label4";
            Label4.Size = new Size(42, 17);
            Label4.TabIndex = 17;
            Label4.Text = "days.";
            // 
            // NumericUpDown3
            // 
            NumericUpDown3.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            NumericUpDown3.BackColor = Color.White;
            NumericUpDown3.Enabled = false;
            NumericUpDown3.Location = new Point(964, 287);
            NumericUpDown3.Margin = new Padding(4);
            NumericUpDown3.Name = "NumericUpDown3";
            NumericUpDown3.Size = new Size(64, 22);
            NumericUpDown3.TabIndex = 16;
            NumericUpDown3.Value = new decimal(new int[] { 30, 0, 0, 0 });
            // 
            // ckRemoveAfterXDays
            // 
            _ckRemoveAfterXDays.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _ckRemoveAfterXDays.AutoSize = true;
            _ckRemoveAfterXDays.BackColor = Color.Transparent;
            _ckRemoveAfterXDays.ForeColor = Color.Black;
            _ckRemoveAfterXDays.Location = new Point(805, 288);
            _ckRemoveAfterXDays.Margin = new Padding(4);
            _ckRemoveAfterXDays.Name = "_ckRemoveAfterXDays";
            _ckRemoveAfterXDays.Size = new Size(150, 21);
            _ckRemoveAfterXDays.TabIndex = 15;
            _ckRemoveAfterXDays.Text = "4. Move items after";
            TT.SetToolTip(_ckRemoveAfterXDays, "Moves expired emails to ECM_HISTORY.");
            _ckRemoveAfterXDays.UseVisualStyleBackColor = false;
            // 
            // btnRefreshFolders
            // 
            _btnRefreshFolders.Location = new Point(11, 23);
            _btnRefreshFolders.Margin = new Padding(4);
            _btnRefreshFolders.Name = "_btnRefreshFolders";
            _btnRefreshFolders.Size = new Size(152, 30);
            _btnRefreshFolders.TabIndex = 10;
            _btnRefreshFolders.Text = "Avail For Archive";
            _btnRefreshFolders.UseVisualStyleBackColor = true;
            // 
            // btnSaveConditions
            // 
            _btnSaveConditions.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnSaveConditions.BackColor = Color.Transparent;
            _btnSaveConditions.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _btnSaveConditions.Location = new Point(805, 428);
            _btnSaveConditions.Margin = new Padding(4);
            _btnSaveConditions.Name = "_btnSaveConditions";
            _btnSaveConditions.Size = new Size(115, 39);
            _btnSaveConditions.TabIndex = 8;
            _btnSaveConditions.Text = "Activate";
            _btnSaveConditions.UseVisualStyleBackColor = false;
            // 
            // ckArchiveFolder
            // 
            ckArchiveFolder.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckArchiveFolder.AutoSize = true;
            ckArchiveFolder.BackColor = Color.Transparent;
            ckArchiveFolder.ForeColor = Color.Black;
            ckArchiveFolder.Location = new Point(805, 231);
            ckArchiveFolder.Margin = new Padding(4);
            ckArchiveFolder.Name = "ckArchiveFolder";
            ckArchiveFolder.Size = new Size(197, 21);
            ckArchiveFolder.TabIndex = 7;
            ckArchiveFolder.Text = "2. Archive Emails in Folder";
            ckArchiveFolder.UseVisualStyleBackColor = false;
            // 
            // lbActiveFolder
            // 
            _lbActiveFolder.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _lbActiveFolder.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _lbActiveFolder.FormattingEnabled = true;
            _lbActiveFolder.ItemHeight = 16;
            _lbActiveFolder.Location = new Point(8, 111);
            _lbActiveFolder.Margin = new Padding(4);
            _lbActiveFolder.Name = "_lbActiveFolder";
            _lbActiveFolder.SelectionMode = SelectionMode.MultiExtended;
            _lbActiveFolder.Size = new Size(784, 436);
            _lbActiveFolder.Sorted = true;
            _lbActiveFolder.TabIndex = 6;
            TT.SetToolTip(_lbActiveFolder, "Select and right mouse to set libraries.");
            // 
            // lblVer
            // 
            lblVer.AutoSize = true;
            lblVer.BackColor = Color.Silver;
            lblVer.ForeColor = Color.Black;
            lblVer.Location = new Point(1176, 11);
            lblVer.Margin = new Padding(4, 0, 4, 0);
            lblVer.Name = "lblVer";
            lblVer.Size = new Size(100, 17);
            lblVer.TabIndex = 69;
            lblVer.Text = "15.10.17.1118";
            // 
            // SB
            // 
            SB.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            SB.BackColor = Color.Gainsboro;
            SB.Location = new Point(269, 705);
            SB.Margin = new Padding(4);
            SB.Name = "SB";
            SB.Size = new Size(700, 22);
            SB.TabIndex = 30;
            // 
            // gbFiletypes
            // 
            gbFiletypes.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            gbFiletypes.BackColor = SystemColors.ControlDark;
            gbFiletypes.Controls.Add(cbProcessAsList);
            gbFiletypes.Controls.Add(_Button2);
            gbFiletypes.Controls.Add(_Button1);
            gbFiletypes.Controls.Add(Label10);
            gbFiletypes.Controls.Add(Label9);
            gbFiletypes.Controls.Add(cbAsType);
            gbFiletypes.Controls.Add(cbPocessType);
            gbFiletypes.Controls.Add(_ckRemoveFileType);
            gbFiletypes.Controls.Add(cbFileTypes);
            gbFiletypes.Controls.Add(_btnAddFiletype);
            gbFiletypes.FlatStyle = FlatStyle.Popup;
            gbFiletypes.Location = new Point(797, 256);
            gbFiletypes.Margin = new Padding(4);
            gbFiletypes.Name = "gbFiletypes";
            gbFiletypes.Padding = new Padding(4);
            gbFiletypes.Size = new Size(395, 138);
            gbFiletypes.TabIndex = 29;
            gbFiletypes.TabStop = false;
            gbFiletypes.Text = "File Types";
            // 
            // cbProcessAsList
            // 
            cbProcessAsList.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            cbProcessAsList.FormattingEnabled = true;
            cbProcessAsList.Location = new Point(11, 98);
            cbProcessAsList.Margin = new Padding(4);
            cbProcessAsList.Name = "cbProcessAsList";
            cbProcessAsList.Size = new Size(236, 24);
            cbProcessAsList.TabIndex = 49;
            // 
            // Button2
            // 
            _Button2.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _Button2.Location = new Point(276, 96);
            _Button2.Margin = new Padding(4);
            _Button2.Name = "_Button2";
            _Button2.Size = new Size(96, 30);
            _Button2.TabIndex = 48;
            _Button2.Text = "Remove";
            _Button2.UseVisualStyleBackColor = true;
            // 
            // Button1
            // 
            _Button1.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _Button1.Location = new Point(276, 66);
            _Button1.Margin = new Padding(4);
            _Button1.Name = "_Button1";
            _Button1.Size = new Size(96, 30);
            _Button1.TabIndex = 47;
            _Button1.Text = "Add";
            _Button1.UseVisualStyleBackColor = true;
            // 
            // Label10
            // 
            Label10.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            Label10.AutoSize = true;
            Label10.Location = new Point(176, 49);
            Label10.Margin = new Padding(4, 0, 4, 0);
            Label10.Name = "Label10";
            Label10.Size = new Size(71, 17);
            Label10.TabIndex = 46;
            Label10.Text = "2. As type";
            // 
            // Label9
            // 
            Label9.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            Label9.AutoSize = true;
            Label9.Location = new Point(11, 49);
            Label9.Margin = new Padding(4, 0, 4, 0);
            Label9.Name = "Label9";
            Label9.Size = new Size(106, 17);
            Label9.TabIndex = 45;
            Label9.Text = "1. Process type";
            // 
            // cbAsType
            // 
            cbAsType.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            cbAsType.FormattingEnabled = true;
            cbAsType.Location = new Point(137, 69);
            cbAsType.Margin = new Padding(4);
            cbAsType.Name = "cbAsType";
            cbAsType.Size = new Size(109, 24);
            cbAsType.Sorted = true;
            cbAsType.TabIndex = 44;
            // 
            // cbPocessType
            // 
            cbPocessType.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            cbPocessType.FormattingEnabled = true;
            cbPocessType.Location = new Point(11, 69);
            cbPocessType.Margin = new Padding(4);
            cbPocessType.Name = "cbPocessType";
            cbPocessType.Size = new Size(109, 24);
            cbPocessType.Sorted = true;
            cbPocessType.TabIndex = 43;
            // 
            // ckRemoveFileType
            // 
            _ckRemoveFileType.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _ckRemoveFileType.Location = new Point(319, 17);
            _ckRemoveFileType.Margin = new Padding(4);
            _ckRemoveFileType.Name = "_ckRemoveFileType";
            _ckRemoveFileType.Size = new Size(43, 30);
            _ckRemoveFileType.TabIndex = 3;
            _ckRemoveFileType.Text = "X";
            TT.SetToolTip(_ckRemoveFileType, "Press to Delete EXISTING file type from system.");
            _ckRemoveFileType.UseVisualStyleBackColor = true;
            // 
            // cbFileTypes
            // 
            cbFileTypes.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            cbFileTypes.FormattingEnabled = true;
            cbFileTypes.Location = new Point(11, 20);
            cbFileTypes.Margin = new Padding(4);
            cbFileTypes.Name = "cbFileTypes";
            cbFileTypes.Size = new Size(236, 24);
            cbFileTypes.Sorted = true;
            cbFileTypes.TabIndex = 2;
            // 
            // btnAddFiletype
            // 
            _btnAddFiletype.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnAddFiletype.Location = new Point(276, 17);
            _btnAddFiletype.Margin = new Padding(4);
            _btnAddFiletype.Name = "_btnAddFiletype";
            _btnAddFiletype.Size = new Size(43, 30);
            _btnAddFiletype.TabIndex = 1;
            _btnAddFiletype.Text = "+";
            TT.SetToolTip(_btnAddFiletype, "Press to add NEW file type to system.");
            _btnAddFiletype.UseVisualStyleBackColor = true;
            // 
            // gbPolling
            // 
            _gbPolling.BackColor = Color.DimGray;
            _gbPolling.Controls.Add(ckWebSiteTrackerDisabled);
            _gbPolling.Controls.Add(ckWebPageTrackerDisabled);
            _gbPolling.Controls.Add(ckRssPullDisabled);
            _gbPolling.Controls.Add(_ckRunOnStart);
            _gbPolling.Controls.Add(_btnArchiveNow);
            _gbPolling.Controls.Add(Label1);
            _gbPolling.Controls.Add(_nbrArchiveHours);
            _gbPolling.Controls.Add(_ckRunUnattended);
            _gbPolling.Controls.Add(_ckDisableExchange);
            _gbPolling.Controls.Add(_ckDisableOutlookEmailArchive);
            _gbPolling.Controls.Add(_ckDisableContentArchive);
            _gbPolling.Controls.Add(_btnSaveSchedule);
            _gbPolling.Controls.Add(_ckDisable);
            _gbPolling.FlatStyle = FlatStyle.Popup;
            _gbPolling.ForeColor = SystemColors.ButtonFace;
            _gbPolling.Location = new Point(12, 27);
            _gbPolling.Margin = new Padding(4);
            _gbPolling.Name = "_gbPolling";
            _gbPolling.Padding = new Padding(4);
            _gbPolling.Size = new Size(572, 336);
            _gbPolling.TabIndex = 27;
            _gbPolling.TabStop = false;
            _gbPolling.Text = "Execution Parameters";
            // 
            // ckWebSiteTrackerDisabled
            // 
            ckWebSiteTrackerDisabled.AutoSize = true;
            ckWebSiteTrackerDisabled.Checked = true;
            ckWebSiteTrackerDisabled.CheckState = CheckState.Checked;
            ckWebSiteTrackerDisabled.ForeColor = Color.White;
            ckWebSiteTrackerDisabled.Location = new Point(36, 217);
            ckWebSiteTrackerDisabled.Margin = new Padding(4);
            ckWebSiteTrackerDisabled.Name = "ckWebSiteTrackerDisabled";
            ckWebSiteTrackerDisabled.Size = new Size(201, 21);
            ckWebSiteTrackerDisabled.TabIndex = 36;
            ckWebSiteTrackerDisabled.Text = "6. Disable WEB Site Spider";
            TT.SetToolTip(ckWebSiteTrackerDisabled, "Checking this will disable Exchange archive.");
            ckWebSiteTrackerDisabled.UseVisualStyleBackColor = true;
            // 
            // ckWebPageTrackerDisabled
            // 
            ckWebPageTrackerDisabled.AutoSize = true;
            ckWebPageTrackerDisabled.Checked = true;
            ckWebPageTrackerDisabled.CheckState = CheckState.Checked;
            ckWebPageTrackerDisabled.ForeColor = Color.White;
            ckWebPageTrackerDisabled.Location = new Point(36, 187);
            ckWebPageTrackerDisabled.Margin = new Padding(4);
            ckWebPageTrackerDisabled.Name = "ckWebPageTrackerDisabled";
            ckWebPageTrackerDisabled.Size = new Size(218, 21);
            ckWebPageTrackerDisabled.TabIndex = 35;
            ckWebPageTrackerDisabled.Text = "6. Disable WEB Page Tracker";
            TT.SetToolTip(ckWebPageTrackerDisabled, "Checking this will disable Exchange archive.");
            ckWebPageTrackerDisabled.UseVisualStyleBackColor = true;
            // 
            // ckRssPullDisabled
            // 
            ckRssPullDisabled.AutoSize = true;
            ckRssPullDisabled.Checked = true;
            ckRssPullDisabled.CheckState = CheckState.Checked;
            ckRssPullDisabled.ForeColor = Color.White;
            ckRssPullDisabled.Location = new Point(36, 158);
            ckRssPullDisabled.Margin = new Padding(4);
            ckRssPullDisabled.Name = "ckRssPullDisabled";
            ckRssPullDisabled.Size = new Size(125, 21);
            ckRssPullDisabled.TabIndex = 34;
            ckRssPullDisabled.Text = "5. Disable RSS";
            TT.SetToolTip(ckRssPullDisabled, "Checking this will disable Exchange archive.");
            ckRssPullDisabled.UseVisualStyleBackColor = true;
            // 
            // ckRunOnStart
            // 
            _ckRunOnStart.AutoSize = true;
            _ckRunOnStart.Location = new Point(36, 276);
            _ckRunOnStart.Margin = new Padding(4);
            _ckRunOnStart.Name = "_ckRunOnStart";
            _ckRunOnStart.Size = new Size(136, 21);
            _ckRunOnStart.TabIndex = 33;
            _ckRunOnStart.Text = "6. Run at startup";
            TT.SetToolTip(_ckRunOnStart, "When checked, the ECM Archive module will start when you login to your computer.");
            _ckRunOnStart.UseVisualStyleBackColor = true;
            // 
            // btnArchiveNow
            // 
            _btnArchiveNow.ForeColor = SystemColors.ActiveCaptionText;
            _btnArchiveNow.Location = new Point(441, 127);
            _btnArchiveNow.Margin = new Padding(4);
            _btnArchiveNow.Name = "_btnArchiveNow";
            _btnArchiveNow.Size = new Size(36, 28);
            _btnArchiveNow.TabIndex = 16;
            _btnArchiveNow.Text = "@";
            TT.SetToolTip(_btnArchiveNow, "Press to Archive Immediately");
            _btnArchiveNow.UseVisualStyleBackColor = true;
            _btnArchiveNow.Visible = false;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.ForeColor = Color.White;
            Label1.Location = new Point(375, 164);
            Label1.Margin = new Padding(4, 0, 4, 0);
            Label1.Name = "Label1";
            Label1.Size = new Size(162, 17);
            Label1.TabIndex = 15;
            Label1.Text = "Quick Archive Schedule:";
            // 
            // nbrArchiveHours
            // 
            _nbrArchiveHours.Location = new Point(411, 183);
            _nbrArchiveHours.Margin = new Padding(4);
            _nbrArchiveHours.Maximum = new decimal(new int[] { 96, 0, 0, 0 });
            _nbrArchiveHours.Name = "_nbrArchiveHours";
            _nbrArchiveHours.Size = new Size(99, 22);
            _nbrArchiveHours.TabIndex = 14;
            TT.SetToolTip(_nbrArchiveHours, "Set to ZERO to turn off or any number of hours between 4 and 96.");
            // 
            // ckRunUnattended
            // 
            _ckRunUnattended.AutoSize = true;
            _ckRunUnattended.ForeColor = Color.White;
            _ckRunUnattended.Location = new Point(36, 246);
            _ckRunUnattended.Margin = new Padding(4);
            _ckRunUnattended.Name = "_ckRunUnattended";
            _ckRunUnattended.Size = new Size(150, 21);
            _ckRunUnattended.TabIndex = 13;
            _ckRunUnattended.Text = "5. Run Unattended";
            _ckRunUnattended.UseVisualStyleBackColor = true;
            // 
            // ckDisableExchange
            // 
            _ckDisableExchange.AutoSize = true;
            _ckDisableExchange.Checked = true;
            _ckDisableExchange.CheckState = CheckState.Checked;
            _ckDisableExchange.ForeColor = Color.White;
            _ckDisableExchange.Location = new Point(36, 128);
            _ckDisableExchange.Margin = new Padding(4);
            _ckDisableExchange.Name = "_ckDisableExchange";
            _ckDisableExchange.Size = new Size(159, 21);
            _ckDisableExchange.TabIndex = 11;
            _ckDisableExchange.Text = "4. Disable Exchange";
            TT.SetToolTip(_ckDisableExchange, "Checking this will disable Exchange archive.");
            _ckDisableExchange.UseVisualStyleBackColor = true;
            // 
            // ckDisableOutlookEmailArchive
            // 
            _ckDisableOutlookEmailArchive.AutoSize = true;
            _ckDisableOutlookEmailArchive.Checked = true;
            _ckDisableOutlookEmailArchive.CheckState = CheckState.Checked;
            _ckDisableOutlookEmailArchive.ForeColor = Color.White;
            _ckDisableOutlookEmailArchive.Location = new Point(36, 98);
            _ckDisableOutlookEmailArchive.Margin = new Padding(4);
            _ckDisableOutlookEmailArchive.Name = "_ckDisableOutlookEmailArchive";
            _ckDisableOutlookEmailArchive.Size = new Size(271, 21);
            _ckDisableOutlookEmailArchive.TabIndex = 10;
            _ckDisableOutlookEmailArchive.Text = "3. Disable Outlook Email and Contacts";
            TT.SetToolTip(_ckDisableOutlookEmailArchive, "Checking this will disable EMAIL archive.");
            _ckDisableOutlookEmailArchive.UseVisualStyleBackColor = true;
            // 
            // ckDisableContentArchive
            // 
            _ckDisableContentArchive.AutoSize = true;
            _ckDisableContentArchive.Checked = true;
            _ckDisableContentArchive.CheckState = CheckState.Checked;
            _ckDisableContentArchive.ForeColor = Color.White;
            _ckDisableContentArchive.Location = new Point(36, 69);
            _ckDisableContentArchive.Margin = new Padding(4);
            _ckDisableContentArchive.Name = "_ckDisableContentArchive";
            _ckDisableContentArchive.Size = new Size(146, 21);
            _ckDisableContentArchive.TabIndex = 9;
            _ckDisableContentArchive.Text = "2. Disable Content";
            TT.SetToolTip(_ckDisableContentArchive, "Checking this will disable Content archive");
            _ckDisableContentArchive.UseVisualStyleBackColor = true;
            // 
            // btnSaveSchedule
            // 
            _btnSaveSchedule.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)));
            _btnSaveSchedule.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _btnSaveSchedule.ForeColor = Color.Black;
            _btnSaveSchedule.Location = new Point(411, 266);
            _btnSaveSchedule.Margin = new Padding(4);
            _btnSaveSchedule.Name = "_btnSaveSchedule";
            _btnSaveSchedule.Size = new Size(88, 37);
            _btnSaveSchedule.TabIndex = 6;
            _btnSaveSchedule.Text = "Save";
            _btnSaveSchedule.UseVisualStyleBackColor = false;
            // 
            // ckDisable
            // 
            _ckDisable.AutoSize = true;
            _ckDisable.Checked = true;
            _ckDisable.CheckState = CheckState.Checked;
            _ckDisable.ForeColor = Color.White;
            _ckDisable.Location = new Point(36, 39);
            _ckDisable.Margin = new Padding(4);
            _ckDisable.Name = "_ckDisable";
            _ckDisable.Size = new Size(112, 21);
            _ckDisable.TabIndex = 4;
            _ckDisable.Text = "1. Disable All";
            TT.SetToolTip(_ckDisable, "Checking this will disable EMAIL, Exchange and Content archive.");
            _ckDisable.UseVisualStyleBackColor = true;
            // 
            // PictureBox2
            // 
            PictureBox2.Image = My.Resources.Resources.DMALogo2;
            PictureBox2.Location = new Point(16, 453);
            PictureBox2.Margin = new Padding(4);
            PictureBox2.Name = "PictureBox2";
            PictureBox2.Size = new Size(131, 126);
            PictureBox2.SizeMode = PictureBoxSizeMode.StretchImage;
            PictureBox2.TabIndex = 37;
            PictureBox2.TabStop = false;
            // 
            // gbContentMgt
            // 
            _gbContentMgt.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _gbContentMgt.BackColor = Color.Silver;
            _gbContentMgt.BackgroundImageLayout = ImageLayout.Stretch;
            _gbContentMgt.Controls.Add(_btnCountFiles);
            _gbContentMgt.Controls.Add(Panel2);
            _gbContentMgt.Controls.Add(_lbArchiveDirs);
            _gbContentMgt.Controls.Add(Panel1);
            _gbContentMgt.Controls.Add(Panel3);
            _gbContentMgt.Location = new Point(8, 7);
            _gbContentMgt.Margin = new Padding(4);
            _gbContentMgt.Name = "_gbContentMgt";
            _gbContentMgt.Padding = new Padding(4);
            _gbContentMgt.Size = new Size(1200, 583);
            _gbContentMgt.TabIndex = 33;
            _gbContentMgt.TabStop = false;
            _gbContentMgt.Text = "File Archive";
            // 
            // btnCountFiles
            // 
            _btnCountFiles.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnCountFiles.Location = new Point(720, 319);
            _btnCountFiles.Margin = new Padding(4);
            _btnCountFiles.Name = "_btnCountFiles";
            _btnCountFiles.Size = new Size(29, 23);
            _btnCountFiles.TabIndex = 81;
            _btnCountFiles.Text = "#";
            TT.SetToolTip(_btnCountFiles, "Count the files in the selected directory.");
            _btnCountFiles.UseVisualStyleBackColor = true;
            // 
            // Panel2
            // 
            Panel2.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            Panel2.BackColor = Color.Silver;
            Panel2.BorderStyle = BorderStyle.Fixed3D;
            Panel2.Controls.Add(_btnArchive1Doc);
            Panel2.Controls.Add(_ckDeleteAfterArchive);
            Panel2.Controls.Add(_ckOcrPdf);
            Panel2.Controls.Add(_ckShowLibs);
            Panel2.Controls.Add(_btnRefreshRetent);
            Panel2.Controls.Add(_CkMonitor);
            Panel2.Controls.Add(_ckArchiveBit);
            Panel2.Controls.Add(Label13);
            Panel2.Controls.Add(cbRetention);
            Panel2.Controls.Add(_ckOcr);
            Panel2.Controls.Add(_clAdminDir);
            Panel2.Controls.Add(_ckDisableDir);
            Panel2.Controls.Add(_ckPublic);
            Panel2.Controls.Add(_ckMetaData);
            Panel2.Controls.Add(_ckVersionFiles);
            Panel2.Controls.Add(_ckSubDirs);
            Panel2.Controls.Add(_txtDir);
            Panel2.Controls.Add(_btnRefresh);
            Panel2.Controls.Add(_btnSaveChanges);
            Panel2.Controls.Add(_btnRemoveDir);
            Panel2.Controls.Add(_btnSelDir);
            Panel2.Location = new Point(11, 327);
            Panel2.Margin = new Padding(4);
            Panel2.Name = "Panel2";
            Panel2.Size = new Size(741, 248);
            Panel2.TabIndex = 79;
            // 
            // btnArchive1Doc
            // 
            _btnArchive1Doc.BackColor = Color.Maroon;
            _btnArchive1Doc.FlatStyle = FlatStyle.Popup;
            _btnArchive1Doc.ForeColor = SystemColors.Control;
            _btnArchive1Doc.Location = new Point(484, 119);
            _btnArchive1Doc.Margin = new Padding(3, 2, 3, 2);
            _btnArchive1Doc.Name = "_btnArchive1Doc";
            _btnArchive1Doc.Size = new Size(117, 54);
            _btnArchive1Doc.TabIndex = 79;
            _btnArchive1Doc.Text = "Quick Archive";
            _btnArchive1Doc.UseVisualStyleBackColor = false;
            // 
            // ckDeleteAfterArchive
            // 
            _ckDeleteAfterArchive.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckDeleteAfterArchive.AutoSize = true;
            _ckDeleteAfterArchive.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckDeleteAfterArchive.ForeColor = Color.Black;
            _ckDeleteAfterArchive.Location = new Point(227, 218);
            _ckDeleteAfterArchive.Margin = new Padding(4);
            _ckDeleteAfterArchive.Name = "_ckDeleteAfterArchive";
            _ckDeleteAfterArchive.Size = new Size(215, 21);
            _ckDeleteAfterArchive.TabIndex = 78;
            _ckDeleteAfterArchive.Text = "12. Remove After Archive";
            TT.SetToolTip(_ckDeleteAfterArchive, "Delete the FILE after successful Archive.");
            _ckDeleteAfterArchive.UseVisualStyleBackColor = true;
            // 
            // ckOcrPdf
            // 
            _ckOcrPdf.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckOcrPdf.AutoSize = true;
            _ckOcrPdf.ForeColor = Color.Black;
            _ckOcrPdf.Location = new Point(3, 170);
            _ckOcrPdf.Margin = new Padding(4);
            _ckOcrPdf.Name = "_ckOcrPdf";
            _ckOcrPdf.Size = new Size(168, 21);
            _ckOcrPdf.TabIndex = 77;
            _ckOcrPdf.Text = "4. OCR PDF Graphics";
            TT.SetToolTip(_ckOcrPdf, "When checked, the assumption is made that th OCR is not a searchable PDF.  It wil" + "l be separated into pages and OCR'D. It is time consuming. To override ALL set t" + "he SYS_EcmPDFX system parameter.");
            _ckOcrPdf.UseVisualStyleBackColor = true;
            // 
            // ckShowLibs
            // 
            _ckShowLibs.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckShowLibs.AutoSize = true;
            _ckShowLibs.ForeColor = Color.Black;
            _ckShowLibs.Location = new Point(227, 170);
            _ckShowLibs.Margin = new Padding(4);
            _ckShowLibs.Name = "_ckShowLibs";
            _ckShowLibs.Size = new Size(147, 21);
            _ckShowLibs.TabIndex = 76;
            _ckShowLibs.Text = "10. Show Libraries";
            TT.SetToolTip(_ckShowLibs, "Check to show popup of assigned libraries.");
            _ckShowLibs.UseVisualStyleBackColor = true;
            // 
            // btnRefreshRetent
            // 
            _btnRefreshRetent.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnRefreshRetent.BackColor = Color.Transparent;
            _btnRefreshRetent.BackgroundImageLayout = ImageLayout.Stretch;
            _btnRefreshRetent.ForeColor = Color.White;
            _btnRefreshRetent.Location = new Point(561, 60);
            _btnRefreshRetent.Margin = new Padding(4);
            _btnRefreshRetent.Name = "_btnRefreshRetent";
            _btnRefreshRetent.Size = new Size(33, 22);
            _btnRefreshRetent.TabIndex = 75;
            TT.SetToolTip(_btnRefreshRetent, "Refresh retention rules.");
            _btnRefreshRetent.UseVisualStyleBackColor = false;
            // 
            // CkMonitor
            // 
            _CkMonitor.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _CkMonitor.AutoSize = true;
            _CkMonitor.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            _CkMonitor.ForeColor = Color.Black;
            _CkMonitor.Location = new Point(227, 193);
            _CkMonitor.Margin = new Padding(4);
            _CkMonitor.Name = "_CkMonitor";
            _CkMonitor.Size = new Size(102, 21);
            _CkMonitor.TabIndex = 74;
            _CkMonitor.Text = "11. Listen";
            TT.SetToolTip(_CkMonitor, "Track changes to this directory instantly.");
            _CkMonitor.UseVisualStyleBackColor = true;
            // 
            // ckArchiveBit
            // 
            _ckArchiveBit.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckArchiveBit.AutoSize = true;
            _ckArchiveBit.ForeColor = Color.Black;
            _ckArchiveBit.Location = new Point(3, 192);
            _ckArchiveBit.Margin = new Padding(4);
            _ckArchiveBit.Name = "_ckArchiveBit";
            _ckArchiveBit.Size = new Size(175, 21);
            _ckArchiveBit.TabIndex = 73;
            _ckArchiveBit.Text = "5. Skip If Archive Bit on";
            TT.SetToolTip(_ckArchiveBit, "If a files archive bit is set OOF, it will skipped during archive processing.");
            _ckArchiveBit.UseVisualStyleBackColor = true;
            // 
            // Label13
            // 
            Label13.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label13.AutoSize = true;
            Label13.ForeColor = Color.Black;
            Label13.Location = new Point(35, 60);
            Label13.Margin = new Padding(4, 0, 4, 0);
            Label13.Name = "Label13";
            Label13.Size = new Size(106, 17);
            Label13.TabIndex = 63;
            Label13.Text = "Retention Rule:";
            // 
            // cbRetention
            // 
            cbRetention.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            cbRetention.FormattingEnabled = true;
            cbRetention.Location = new Point(152, 55);
            cbRetention.Margin = new Padding(4);
            cbRetention.Name = "cbRetention";
            cbRetention.Size = new Size(400, 24);
            cbRetention.Sorted = true;
            cbRetention.TabIndex = 55;
            TT.SetToolTip(cbRetention, "When blank, default retention value will be used.");
            // 
            // ckOcr
            // 
            _ckOcr.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckOcr.AutoSize = true;
            _ckOcr.ForeColor = Color.Black;
            _ckOcr.Location = new Point(3, 143);
            _ckOcr.Margin = new Padding(4);
            _ckOcr.Name = "_ckOcr";
            _ckOcr.Size = new Size(168, 21);
            _ckOcr.TabIndex = 54;
            _ckOcr.Text = "3. OCR This Directory";
            _ckOcr.UseVisualStyleBackColor = true;
            // 
            // clAdminDir
            // 
            _clAdminDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _clAdminDir.AutoSize = true;
            _clAdminDir.ForeColor = Color.Black;
            _clAdminDir.Location = new Point(227, 118);
            _clAdminDir.Margin = new Padding(4);
            _clAdminDir.Name = "_clAdminDir";
            _clAdminDir.Size = new Size(135, 21);
            _clAdminDir.TabIndex = 51;
            _clAdminDir.Text = "8. Mandatory Dir";
            TT.SetToolTip(_clAdminDir, "Admins, Check to make this direcyory a mandatory backup folder, all users will in" + "clude this directory.");
            _clAdminDir.UseVisualStyleBackColor = true;
            // 
            // ckDisableDir
            // 
            _ckDisableDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckDisableDir.AutoSize = true;
            _ckDisableDir.ForeColor = Color.Black;
            _ckDisableDir.Location = new Point(3, 118);
            _ckDisableDir.Margin = new Padding(4);
            _ckDisableDir.Name = "_ckDisableDir";
            _ckDisableDir.Size = new Size(166, 21);
            _ckDisableDir.TabIndex = 45;
            _ckDisableDir.Text = "2. Disable Dir Archive";
            TT.SetToolTip(_ckDisableDir, "Disable Archive for selected Directory");
            _ckDisableDir.UseVisualStyleBackColor = true;
            // 
            // ckPublic
            // 
            _ckPublic.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckPublic.AutoSize = true;
            _ckPublic.ForeColor = Color.Black;
            _ckPublic.Location = new Point(227, 143);
            _ckPublic.Margin = new Padding(4);
            _ckPublic.Name = "_ckPublic";
            _ckPublic.Size = new Size(122, 21);
            _ckPublic.TabIndex = 44;
            _ckPublic.Text = "9. Make Public";
            _ckPublic.UseVisualStyleBackColor = true;
            // 
            // ckMetaData
            // 
            _ckMetaData.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckMetaData.AutoSize = true;
            _ckMetaData.ForeColor = Color.Black;
            _ckMetaData.Location = new Point(227, 95);
            _ckMetaData.Margin = new Padding(4);
            _ckMetaData.Name = "_ckMetaData";
            _ckMetaData.Size = new Size(159, 21);
            _ckMetaData.TabIndex = 43;
            _ckMetaData.Text = "7. Capture Metadata";
            TT.SetToolTip(_ckMetaData, "This requires Windows OFFICE be installed locally to function correctly.");
            _ckMetaData.UseVisualStyleBackColor = true;
            // 
            // ckVersionFiles
            // 
            _ckVersionFiles.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckVersionFiles.AutoSize = true;
            _ckVersionFiles.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckVersionFiles.ForeColor = Color.Black;
            _ckVersionFiles.Location = new Point(3, 218);
            _ckVersionFiles.Margin = new Padding(4);
            _ckVersionFiles.Name = "_ckVersionFiles";
            _ckVersionFiles.Size = new Size(143, 21);
            _ckVersionFiles.TabIndex = 40;
            _ckVersionFiles.Text = "6. Version Files";
            _ckVersionFiles.UseVisualStyleBackColor = true;
            // 
            // ckSubDirs
            // 
            _ckSubDirs.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckSubDirs.AutoSize = true;
            _ckSubDirs.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            _ckSubDirs.ForeColor = Color.Black;
            _ckSubDirs.Location = new Point(3, 95);
            _ckSubDirs.Margin = new Padding(4);
            _ckSubDirs.Name = "_ckSubDirs";
            _ckSubDirs.Size = new Size(161, 21);
            _ckSubDirs.TabIndex = 38;
            _ckSubDirs.Text = "1. Include Subdirs";
            _ckSubDirs.UseVisualStyleBackColor = true;
            // 
            // txtDir
            // 
            _txtDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            _txtDir.BackColor = Color.WhiteSmoke;
            _txtDir.Location = new Point(152, 22);
            _txtDir.Margin = new Padding(4);
            _txtDir.Name = "_txtDir";
            _txtDir.Size = new Size(581, 22);
            _txtDir.TabIndex = 37;
            TT.SetToolTip(_txtDir, "Use a %userid% to substitute in the user ID at that position in the directory str" + "ing.");
            // 
            // btnRefresh
            // 
            _btnRefresh.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnRefresh.ForeColor = Color.Black;
            _btnRefresh.Location = new Point(0, 22);
            _btnRefresh.Margin = new Padding(4);
            _btnRefresh.Name = "_btnRefresh";
            _btnRefresh.Size = new Size(144, 28);
            _btnRefresh.TabIndex = 24;
            _btnRefresh.Text = "Show Disabled";
            TT.SetToolTip(_btnRefresh, "This is a dual use button - Click to show enabled or disabled directories");
            _btnRefresh.UseVisualStyleBackColor = true;
            // 
            // btnSaveChanges
            // 
            _btnSaveChanges.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnSaveChanges.BackColor = Color.Turquoise;
            _btnSaveChanges.Location = new Point(617, 183);
            _btnSaveChanges.Margin = new Padding(4);
            _btnSaveChanges.Name = "_btnSaveChanges";
            _btnSaveChanges.Size = new Size(117, 54);
            _btnSaveChanges.TabIndex = 23;
            _btnSaveChanges.Text = "Save Changes to Archive";
            _btnSaveChanges.UseVisualStyleBackColor = false;
            // 
            // btnRemoveDir
            // 
            _btnRemoveDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnRemoveDir.BackColor = Color.Transparent;
            _btnRemoveDir.ForeColor = Color.Black;
            _btnRemoveDir.Location = new Point(617, 119);
            _btnRemoveDir.Margin = new Padding(4);
            _btnRemoveDir.Name = "_btnRemoveDir";
            _btnRemoveDir.Size = new Size(117, 54);
            _btnRemoveDir.TabIndex = 11;
            _btnRemoveDir.Text = "Remove Dir from Archive";
            _btnRemoveDir.UseVisualStyleBackColor = false;
            // 
            // btnSelDir
            // 
            _btnSelDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnSelDir.ForeColor = Color.Black;
            _btnSelDir.Location = new Point(617, 55);
            _btnSelDir.Margin = new Padding(4);
            _btnSelDir.Name = "_btnSelDir";
            _btnSelDir.Size = new Size(117, 54);
            _btnSelDir.TabIndex = 9;
            _btnSelDir.Text = "Select Dir for Archive";
            _btnSelDir.UseVisualStyleBackColor = true;
            // 
            // lbArchiveDirs
            // 
            _lbArchiveDirs.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _lbArchiveDirs.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _lbArchiveDirs.ForeColor = Color.Black;
            _lbArchiveDirs.FormattingEnabled = true;
            _lbArchiveDirs.ItemHeight = 16;
            _lbArchiveDirs.Location = new Point(11, 20);
            _lbArchiveDirs.Margin = new Padding(4);
            _lbArchiveDirs.Name = "_lbArchiveDirs";
            _lbArchiveDirs.Size = new Size(741, 292);
            _lbArchiveDirs.Sorted = true;
            _lbArchiveDirs.TabIndex = 0;
            // 
            // Panel1
            // 
            Panel1.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Right;
            Panel1.BackColor = Color.LightGray;
            Panel1.BorderStyle = BorderStyle.Fixed3D;
            Panel1.Controls.Add(Label36);
            Panel1.Controls.Add(Label35);
            Panel1.Controls.Add(Label7);
            Panel1.Controls.Add(_lbExcludeExts);
            Panel1.Controls.Add(Label6);
            Panel1.Controls.Add(Label5);
            Panel1.Controls.Add(_lbAvailExts);
            Panel1.Controls.Add(_lbIncludeExts);
            Panel1.Controls.Add(_Button3);
            Panel1.Controls.Add(_btnRemoveExclude);
            Panel1.Controls.Add(_btnInclFileType);
            Panel1.Controls.Add(_btnExclude);
            Panel1.Location = new Point(787, 20);
            Panel1.Margin = new Padding(4);
            Panel1.Name = "Panel1";
            Panel1.Size = new Size(387, 322);
            Panel1.TabIndex = 78;
            // 
            // Label36
            // 
            Label36.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label36.AutoSize = true;
            Label36.Location = new Point(53, 300);
            Label36.Margin = new Padding(4, 0, 4, 0);
            Label36.Name = "Label36";
            Label36.Size = new Size(180, 17);
            Label36.TabIndex = 51;
            Label36.Text = "using tab Execution Control";
            // 
            // Label35
            // 
            Label35.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label35.AutoSize = true;
            Label35.Location = new Point(13, 282);
            Label35.Margin = new Padding(4, 0, 4, 0);
            Label35.Name = "Label35";
            Label35.Size = new Size(157, 17);
            Label35.TabIndex = 50;
            Label35.Text = "Note: Add new file type ";
            // 
            // Label7
            // 
            Label7.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label7.AutoSize = true;
            Label7.Location = new Point(148, 0);
            Label7.Margin = new Padding(4, 0, 4, 0);
            Label7.Name = "Label7";
            Label7.Size = new Size(69, 17);
            Label7.TabIndex = 47;
            Label7.Text = "Excluded:";
            // 
            // lbExcludeExts
            // 
            _lbExcludeExts.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Right;
            _lbExcludeExts.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _lbExcludeExts.FormattingEnabled = true;
            _lbExcludeExts.ItemHeight = 16;
            _lbExcludeExts.Location = new Point(135, 20);
            _lbExcludeExts.Margin = new Padding(4);
            _lbExcludeExts.Name = "_lbExcludeExts";
            _lbExcludeExts.SelectionMode = SelectionMode.MultiExtended;
            _lbExcludeExts.Size = new Size(99, 212);
            _lbExcludeExts.Sorted = true;
            _lbExcludeExts.TabIndex = 46;
            // 
            // Label6
            // 
            Label6.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label6.AutoSize = true;
            Label6.Location = new Point(33, 0);
            Label6.Margin = new Padding(4, 0, 4, 0);
            Label6.Name = "Label6";
            Label6.Size = new Size(65, 17);
            Label6.TabIndex = 32;
            Label6.Text = "Included:";
            // 
            // Label5
            // 
            Label5.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label5.AutoSize = true;
            Label5.Location = new Point(268, 0);
            Label5.Margin = new Padding(4, 0, 4, 0);
            Label5.Name = "Label5";
            Label5.Size = new Size(65, 17);
            Label5.TabIndex = 31;
            Label5.Text = "Available";
            // 
            // lbAvailExts
            // 
            _lbAvailExts.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Right;
            _lbAvailExts.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _lbAvailExts.FormattingEnabled = true;
            _lbAvailExts.ItemHeight = 16;
            _lbAvailExts.Location = new Point(252, 20);
            _lbAvailExts.Margin = new Padding(4);
            _lbAvailExts.Name = "_lbAvailExts";
            _lbAvailExts.SelectionMode = SelectionMode.MultiExtended;
            _lbAvailExts.Size = new Size(99, 212);
            _lbAvailExts.Sorted = true;
            _lbAvailExts.TabIndex = 30;
            // 
            // lbIncludeExts
            // 
            _lbIncludeExts.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Right;
            _lbIncludeExts.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _lbIncludeExts.FormattingEnabled = true;
            _lbIncludeExts.ItemHeight = 16;
            _lbIncludeExts.Location = new Point(17, 20);
            _lbIncludeExts.Margin = new Padding(4);
            _lbIncludeExts.Name = "_lbIncludeExts";
            _lbIncludeExts.SelectionMode = SelectionMode.MultiExtended;
            _lbIncludeExts.Size = new Size(99, 212);
            _lbIncludeExts.Sorted = true;
            _lbIncludeExts.TabIndex = 28;
            // 
            // Button3
            // 
            _Button3.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _Button3.BackColor = Color.Transparent;
            _Button3.ForeColor = Color.Black;
            _Button3.Location = new Point(17, 240);
            _Button3.Margin = new Padding(4);
            _Button3.Name = "_Button3";
            _Button3.Size = new Size(101, 30);
            _Button3.TabIndex = 39;
            _Button3.Text = "1. Remove";
            _Button3.UseVisualStyleBackColor = false;
            // 
            // btnRemoveExclude
            // 
            _btnRemoveExclude.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnRemoveExclude.BackColor = Color.Transparent;
            _btnRemoveExclude.ForeColor = Color.Black;
            _btnRemoveExclude.Location = new Point(133, 240);
            _btnRemoveExclude.Margin = new Padding(4);
            _btnRemoveExclude.Name = "_btnRemoveExclude";
            _btnRemoveExclude.Size = new Size(101, 30);
            _btnRemoveExclude.TabIndex = 48;
            _btnRemoveExclude.Text = "2. Remove";
            _btnRemoveExclude.UseVisualStyleBackColor = false;
            // 
            // btnInclFileType
            // 
            _btnInclFileType.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnInclFileType.Location = new Point(251, 240);
            _btnInclFileType.Margin = new Padding(4);
            _btnInclFileType.Name = "_btnInclFileType";
            _btnInclFileType.Size = new Size(101, 30);
            _btnInclFileType.TabIndex = 35;
            _btnInclFileType.Text = "3. Include";
            _btnInclFileType.UseVisualStyleBackColor = true;
            // 
            // btnExclude
            // 
            _btnExclude.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnExclude.Location = new Point(251, 275);
            _btnExclude.Margin = new Padding(4);
            _btnExclude.Name = "_btnExclude";
            _btnExclude.Size = new Size(101, 30);
            _btnExclude.TabIndex = 49;
            _btnExclude.Text = "4. Exclude";
            _btnExclude.UseVisualStyleBackColor = true;
            // 
            // Panel3
            // 
            Panel3.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Panel3.BackColor = Color.LightGray;
            Panel3.BorderStyle = BorderStyle.Fixed3D;
            Panel3.Controls.Add(_btnAddDefaults);
            Panel3.Controls.Add(_btnRefreshRebuild);
            Panel3.Controls.Add(Label12);
            Panel3.Controls.Add(_btnDeleteDirProfile);
            Panel3.Controls.Add(_btnUpdateDirectoryProfile);
            Panel3.Controls.Add(_btnSaveDirProfile);
            Panel3.Controls.Add(_btnApplyDirProfile);
            Panel3.Controls.Add(cbDirProfile);
            Panel3.Controls.Add(Label11);
            Panel3.Controls.Add(_btnExclProfile);
            Panel3.Controls.Add(_btnInclProfile);
            Panel3.Controls.Add(_cbProfile);
            Panel3.Location = new Point(787, 350);
            Panel3.Margin = new Padding(4);
            Panel3.Name = "Panel3";
            Panel3.Size = new Size(387, 194);
            Panel3.TabIndex = 80;
            // 
            // btnAddDefaults
            // 
            _btnAddDefaults.Location = new Point(319, 30);
            _btnAddDefaults.Margin = new Padding(4);
            _btnAddDefaults.Name = "_btnAddDefaults";
            _btnAddDefaults.Size = new Size(32, 28);
            _btnAddDefaults.TabIndex = 74;
            _btnAddDefaults.Text = "!";
            TT.SetToolTip(_btnAddDefaults, "Reset default values.");
            _btnAddDefaults.UseVisualStyleBackColor = true;
            // 
            // btnRefreshRebuild
            // 
            _btnRefreshRebuild.ForeColor = Color.Black;
            _btnRefreshRebuild.Location = new Point(319, 123);
            _btnRefreshRebuild.Margin = new Padding(4);
            _btnRefreshRebuild.Name = "_btnRefreshRebuild";
            _btnRefreshRebuild.Size = new Size(32, 28);
            _btnRefreshRebuild.TabIndex = 73;
            _btnRefreshRebuild.Text = "@";
            TT.SetToolTip(_btnRefreshRebuild, "Refreshes the list of available and existing profiles adding any missing default " + "members.");
            _btnRefreshRebuild.UseVisualStyleBackColor = true;
            // 
            // Label12
            // 
            Label12.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label12.AutoSize = true;
            Label12.Location = new Point(103, 105);
            Label12.Margin = new Padding(4, 0, 4, 0);
            Label12.Name = "Label12";
            Label12.Size = new Size(146, 17);
            Label12.TabIndex = 72;
            Label12.Text = "Select Archive Profile:";
            // 
            // btnDeleteDirProfile
            // 
            _btnDeleteDirProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnDeleteDirProfile.Location = new Point(248, 158);
            _btnDeleteDirProfile.Margin = new Padding(4);
            _btnDeleteDirProfile.Name = "_btnDeleteDirProfile";
            _btnDeleteDirProfile.Size = new Size(59, 26);
            _btnDeleteDirProfile.TabIndex = 71;
            _btnDeleteDirProfile.Text = "Del";
            TT.SetToolTip(_btnDeleteDirProfile, "Delete currently selected directory profile.");
            _btnDeleteDirProfile.UseVisualStyleBackColor = true;
            // 
            // btnUpdateDirectoryProfile
            // 
            _btnUpdateDirectoryProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnUpdateDirectoryProfile.Location = new Point(180, 158);
            _btnUpdateDirectoryProfile.Margin = new Padding(4);
            _btnUpdateDirectoryProfile.Name = "_btnUpdateDirectoryProfile";
            _btnUpdateDirectoryProfile.Size = new Size(59, 26);
            _btnUpdateDirectoryProfile.TabIndex = 70;
            _btnUpdateDirectoryProfile.Text = "Updt";
            TT.SetToolTip(_btnUpdateDirectoryProfile, "Update selected directory profile to current settings");
            _btnUpdateDirectoryProfile.UseVisualStyleBackColor = true;
            // 
            // btnSaveDirProfile
            // 
            _btnSaveDirProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnSaveDirProfile.Location = new Point(112, 158);
            _btnSaveDirProfile.Margin = new Padding(4);
            _btnSaveDirProfile.Name = "_btnSaveDirProfile";
            _btnSaveDirProfile.Size = new Size(59, 26);
            _btnSaveDirProfile.TabIndex = 69;
            _btnSaveDirProfile.Text = "Save";
            TT.SetToolTip(_btnSaveDirProfile, "Save current setup as NEW directory profile");
            _btnSaveDirProfile.UseVisualStyleBackColor = true;
            // 
            // btnApplyDirProfile
            // 
            _btnApplyDirProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnApplyDirProfile.Location = new Point(44, 158);
            _btnApplyDirProfile.Margin = new Padding(4);
            _btnApplyDirProfile.Name = "_btnApplyDirProfile";
            _btnApplyDirProfile.Size = new Size(59, 26);
            _btnApplyDirProfile.TabIndex = 68;
            _btnApplyDirProfile.Text = "Aply";
            TT.SetToolTip(_btnApplyDirProfile, "Apply selected directory profile");
            _btnApplyDirProfile.UseVisualStyleBackColor = true;
            // 
            // cbDirProfile
            // 
            cbDirProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            cbDirProfile.FormattingEnabled = true;
            cbDirProfile.Location = new Point(39, 124);
            cbDirProfile.Margin = new Padding(4);
            cbDirProfile.Name = "cbDirProfile";
            cbDirProfile.Size = new Size(268, 24);
            cbDirProfile.TabIndex = 66;
            TT.SetToolTip(cbDirProfile, "Currently defined directory profiles");
            // 
            // Label11
            // 
            Label11.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label11.AutoSize = true;
            Label11.Location = new Point(103, 9);
            Label11.Margin = new Padding(4, 0, 4, 0);
            Label11.Name = "Label11";
            Label11.Size = new Size(148, 17);
            Label11.TabIndex = 64;
            Label11.Text = "Select Filetype Profile:";
            // 
            // btnExclProfile
            // 
            _btnExclProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnExclProfile.Location = new Point(181, 59);
            _btnExclProfile.Margin = new Padding(4);
            _btnExclProfile.Name = "_btnExclProfile";
            _btnExclProfile.Size = new Size(115, 34);
            _btnExclProfile.TabIndex = 58;
            _btnExclProfile.Text = "E&xclude";
            TT.SetToolTip(_btnExclProfile, "Exclude selected profile.");
            _btnExclProfile.UseVisualStyleBackColor = true;
            // 
            // btnInclProfile
            // 
            _btnInclProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnInclProfile.Location = new Point(56, 59);
            _btnInclProfile.Margin = new Padding(4);
            _btnInclProfile.Name = "_btnInclProfile";
            _btnInclProfile.Size = new Size(115, 34);
            _btnInclProfile.TabIndex = 57;
            _btnInclProfile.Text = "&Apply";
            TT.SetToolTip(_btnInclProfile, "Include selected profile.");
            _btnInclProfile.UseVisualStyleBackColor = true;
            // 
            // cbProfile
            // 
            _cbProfile.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _cbProfile.FormattingEnabled = true;
            _cbProfile.Location = new Point(39, 28);
            _cbProfile.Margin = new Padding(4);
            _cbProfile.Name = "_cbProfile";
            _cbProfile.Size = new Size(256, 24);
            _cbProfile.TabIndex = 56;
            // 
            // Label8
            // 
            _Label8.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _Label8.AutoSize = true;
            _Label8.ForeColor = Color.White;
            _Label8.Location = new Point(23, 719);
            _Label8.Margin = new Padding(4, 0, 4, 0);
            _Label8.Name = "_Label8";
            _Label8.Size = new Size(119, 17);
            _Label8.TabIndex = 34;
            _Label8.Text = "Select Repository";
            _Label8.Visible = false;
            // 
            // cbFileDB
            // 
            _cbFileDB.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _cbFileDB.Enabled = false;
            _cbFileDB.FormattingEnabled = true;
            _cbFileDB.Location = new Point(25, 738);
            _cbFileDB.Margin = new Padding(4);
            _cbFileDB.Name = "_cbFileDB";
            _cbFileDB.Size = new Size(241, 24);
            _cbFileDB.Sorted = true;
            _cbFileDB.TabIndex = 27;
            _cbFileDB.Text = "ECMREPO";
            _cbFileDB.Visible = false;
            // 
            // btnAddDir
            // 
            _btnAddDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnAddDir.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(64)));
            _btnAddDir.Location = new Point(151, 704);
            _btnAddDir.Margin = new Padding(4);
            _btnAddDir.Name = "_btnAddDir";
            _btnAddDir.Size = new Size(117, 28);
            _btnAddDir.TabIndex = 10;
            _btnAddDir.Text = "Include Dir";
            _btnAddDir.UseVisualStyleBackColor = true;
            _btnAddDir.Visible = false;
            // 
            // PictureBox1
            // 
            PictureBox1.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            PictureBox1.Image = (Image)resources.GetObject("PictureBox1.Image");
            PictureBox1.Location = new Point(979, 711);
            PictureBox1.Margin = new Padding(4);
            PictureBox1.Name = "PictureBox1";
            PictureBox1.Size = new Size(49, 53);
            PictureBox1.TabIndex = 75;
            PictureBox1.TabStop = false;
            PictureBox1.Visible = false;
            PictureBox1.WaitOnLoad = true;
            // 
            // ckTerminate
            // 
            _ckTerminate.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _ckTerminate.AutoSize = true;
            _ckTerminate.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _ckTerminate.Location = new Point(1055, 738);
            _ckTerminate.Margin = new Padding(4);
            _ckTerminate.Name = "_ckTerminate";
            _ckTerminate.Size = new Size(188, 21);
            _ckTerminate.TabIndex = 66;
            _ckTerminate.Text = "Teminate current archive";
            TT.SetToolTip(_ckTerminate, "Check to terminate currently running archive.");
            _ckTerminate.UseVisualStyleBackColor = true;
            // 
            // ckPauseListener
            // 
            _ckPauseListener.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _ckPauseListener.AutoSize = true;
            _ckPauseListener.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            _ckPauseListener.Location = new Point(1054, 706);
            _ckPauseListener.Margin = new Padding(4);
            _ckPauseListener.Name = "_ckPauseListener";
            _ckPauseListener.Size = new Size(161, 21);
            _ckPauseListener.TabIndex = 76;
            _ckPauseListener.Text = "Pause ALL Listeners";
            TT.SetToolTip(_ckPauseListener, "Check to pause ALL directory listeners.");
            _ckPauseListener.UseVisualStyleBackColor = true;
            // 
            // btnFetch
            // 
            btnFetch.BackColor = SystemColors.ButtonFace;
            btnFetch.Location = new Point(287, 43);
            btnFetch.Margin = new Padding(4);
            btnFetch.Name = "btnFetch";
            btnFetch.Size = new Size(93, 33);
            btnFetch.TabIndex = 6;
            btnFetch.Text = "Fetch";
            TT.SetToolTip(btnFetch, "Retrieve the associated repositories.");
            btnFetch.UseVisualStyleBackColor = false;
            // 
            // txtRssURL
            // 
            txtRssURL.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtRssURL.Location = new Point(68, 551);
            txtRssURL.Margin = new Padding(4);
            txtRssURL.Name = "txtRssURL";
            txtRssURL.Size = new Size(860, 22);
            txtRssURL.TabIndex = 6;
            TT.SetToolTip(txtRssURL, "Enter the RSS URL on this line.");
            // 
            // txtRssName
            // 
            txtRssName.AcceptsReturn = true;
            txtRssName.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtRssName.Location = new Point(68, 500);
            txtRssName.Margin = new Padding(4);
            txtRssName.Name = "txtRssName";
            txtRssName.Size = new Size(507, 22);
            txtRssName.TabIndex = 4;
            TT.SetToolTip(txtRssName, "The name would you like to identify this RSS feed.");
            // 
            // txtWebScreenUrl
            // 
            txtWebScreenUrl.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtWebScreenUrl.Location = new Point(43, 494);
            txtWebScreenUrl.Margin = new Padding(4);
            txtWebScreenUrl.Name = "txtWebScreenUrl";
            txtWebScreenUrl.Size = new Size(875, 22);
            txtWebScreenUrl.TabIndex = 14;
            TT.SetToolTip(txtWebScreenUrl, "Enter the WEB screen to monitor.");
            // 
            // txtWebScreenName
            // 
            txtWebScreenName.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            txtWebScreenName.Location = new Point(43, 443);
            txtWebScreenName.Margin = new Padding(4);
            txtWebScreenName.Name = "txtWebScreenName";
            txtWebScreenName.Size = new Size(528, 22);
            txtWebScreenName.TabIndex = 12;
            TT.SetToolTip(txtWebScreenName, "The nmae to identify this web site.");
            // 
            // f1Help
            // 
            f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmReconMain.htm";
            // 
            // SB2
            // 
            SB2.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            SB2.BackColor = Color.Gainsboro;
            SB2.Location = new Point(269, 740);
            SB2.Margin = new Padding(4);
            SB2.Name = "SB2";
            SB2.Size = new Size(700, 22);
            SB2.TabIndex = 44;
            // 
            // PBx
            // 
            PBx.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            PBx.Location = new Point(33, 4);
            PBx.Margin = new Padding(4);
            PBx.Name = "PBx";
            PBx.Size = new Size(1295, 22);
            PBx.TabIndex = 45;
            // 
            // ContextMenuStrip1
            // 
            _ContextMenuStrip1.ImageScalingSize = new Size(20, 20);
            _ContextMenuStrip1.Items.AddRange(new ToolStripItem[] { _ResetSelectedMailBoxesToolStripMenuItem, _EmailLibraryReassignmentToolStripMenuItem });
            _ContextMenuStrip1.Name = "_ContextMenuStrip1";
            _ContextMenuStrip1.Size = new Size(252, 52);
            // 
            // ResetSelectedMailBoxesToolStripMenuItem
            // 
            _ResetSelectedMailBoxesToolStripMenuItem.Name = "_ResetSelectedMailBoxesToolStripMenuItem";
            _ResetSelectedMailBoxesToolStripMenuItem.Size = new Size(251, 24);
            _ResetSelectedMailBoxesToolStripMenuItem.Text = "Reset Selected Mail Boxes";
            // 
            // EmailLibraryReassignmentToolStripMenuItem
            // 
            _EmailLibraryReassignmentToolStripMenuItem.Name = "_EmailLibraryReassignmentToolStripMenuItem";
            _EmailLibraryReassignmentToolStripMenuItem.Size = new Size(251, 24);
            _EmailLibraryReassignmentToolStripMenuItem.Text = "Email Library Assignment";
            // 
            // TimerListeners
            // 
            _TimerListeners.Interval = 60000;
            // 
            // TimerUploadFiles
            // 
            _TimerUploadFiles.Interval = 30000;
            // 
            // TimerEndRun
            // 
            _TimerEndRun.Interval = 30000;
            // 
            // MenuStrip1
            // 
            MenuStrip1.BackColor = Color.Silver;
            MenuStrip1.ImageScalingSize = new Size(20, 20);
            MenuStrip1.Items.AddRange(new ToolStripItem[] { ArchiveToolStripMenuItem, LoginToolStripMenuItem, TasksToolStripMenuItem, SelectionToolStripMenuItem, TestToolStripMenuItem, _ExitToolStripMenuItem, HelpToolStripMenuItem });
            MenuStrip1.Location = new Point(0, 0);
            MenuStrip1.Name = "MenuStrip1";
            MenuStrip1.Padding = new Padding(8, 2, 0, 2);
            MenuStrip1.Size = new Size(1283, 28);
            MenuStrip1.TabIndex = 77;
            MenuStrip1.Text = "MenuStrip1";
            // 
            // ArchiveToolStripMenuItem
            // 
            ArchiveToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _ArchiveALLToolStripMenuItem, _OutlookEmailsToolStripMenuItem, _ExchangeEmailsToolStripMenuItem, _ContentToolStripMenuItem, _ContentReInventoryToolStripMenuItem, _ToolStripMenuItem1, _ScheduleToolStripMenuItem, SetArchiveIntervalToolStripMenuItem, ToolStripSeparator7, _SelectedFilesToolStripMenuItem, ToolStripSeparator6, _ArchiveRSSPullsToolStripMenuItem, _WebSitesToolStripMenuItem, _WebPagesToolStripMenuItem, ToolStripSeparator5, _ExitToolStripMenuItem1 });
            ArchiveToolStripMenuItem.Name = "ArchiveToolStripMenuItem";
            ArchiveToolStripMenuItem.Size = new Size(70, 24);
            ArchiveToolStripMenuItem.Text = "Archive";
            // 
            // ArchiveALLToolStripMenuItem
            // 
            _ArchiveALLToolStripMenuItem.Name = "_ArchiveALLToolStripMenuItem";
            _ArchiveALLToolStripMenuItem.Size = new Size(234, 26);
            _ArchiveALLToolStripMenuItem.Text = "Archive ALL";
            // 
            // OutlookEmailsToolStripMenuItem
            // 
            _OutlookEmailsToolStripMenuItem.Name = "_OutlookEmailsToolStripMenuItem";
            _OutlookEmailsToolStripMenuItem.Size = new Size(234, 26);
            _OutlookEmailsToolStripMenuItem.Text = "Outlook Emails";
            // 
            // ExchangeEmailsToolStripMenuItem
            // 
            _ExchangeEmailsToolStripMenuItem.Name = "_ExchangeEmailsToolStripMenuItem";
            _ExchangeEmailsToolStripMenuItem.Size = new Size(234, 26);
            _ExchangeEmailsToolStripMenuItem.Text = "Exchange Emails";
            // 
            // ContentToolStripMenuItem
            // 
            _ContentToolStripMenuItem.Name = "_ContentToolStripMenuItem";
            _ContentToolStripMenuItem.Size = new Size(234, 26);
            _ContentToolStripMenuItem.Text = "Content - Quick";
            _ContentToolStripMenuItem.ToolTipText = "Uses the localized SQLite inventory ";
            // 
            // ContentReInventoryToolStripMenuItem
            // 
            _ContentReInventoryToolStripMenuItem.Name = "_ContentReInventoryToolStripMenuItem";
            _ContentReInventoryToolStripMenuItem.Size = new Size(234, 26);
            _ContentReInventoryToolStripMenuItem.Text = "Content - Re-Inventory";
            _ContentReInventoryToolStripMenuItem.ToolTipText = "DOES NOT Use the localized SQLite inventory , performs a full inventory of all ta" + "rgeted directories.";
            // 
            // ToolStripMenuItem1
            // 
            _ToolStripMenuItem1.Name = "_ToolStripMenuItem1";
            _ToolStripMenuItem1.Size = new Size(234, 26);
            _ToolStripMenuItem1.Text = "Outlook Contacts";
            // 
            // ScheduleToolStripMenuItem
            // 
            _ScheduleToolStripMenuItem.Name = "_ScheduleToolStripMenuItem";
            _ScheduleToolStripMenuItem.Size = new Size(234, 26);
            _ScheduleToolStripMenuItem.Text = "Schedule";
            // 
            // SetArchiveIntervalToolStripMenuItem
            // 
            SetArchiveIntervalToolStripMenuItem.Name = "SetArchiveIntervalToolStripMenuItem";
            SetArchiveIntervalToolStripMenuItem.Size = new Size(234, 26);
            SetArchiveIntervalToolStripMenuItem.Text = "Set Archive Interval";
            // 
            // ToolStripSeparator7
            // 
            ToolStripSeparator7.Name = "ToolStripSeparator7";
            ToolStripSeparator7.Size = new Size(231, 6);
            // 
            // SelectedFilesToolStripMenuItem
            // 
            _SelectedFilesToolStripMenuItem.Name = "_SelectedFilesToolStripMenuItem";
            _SelectedFilesToolStripMenuItem.Size = new Size(234, 26);
            _SelectedFilesToolStripMenuItem.Text = "Selected Files";
            // 
            // ToolStripSeparator6
            // 
            ToolStripSeparator6.Name = "ToolStripSeparator6";
            ToolStripSeparator6.Size = new Size(231, 6);
            // 
            // ArchiveRSSPullsToolStripMenuItem
            // 
            _ArchiveRSSPullsToolStripMenuItem.Name = "_ArchiveRSSPullsToolStripMenuItem";
            _ArchiveRSSPullsToolStripMenuItem.Size = new Size(234, 26);
            _ArchiveRSSPullsToolStripMenuItem.Text = "Archive RSS Pulls";
            // 
            // WebSitesToolStripMenuItem
            // 
            _WebSitesToolStripMenuItem.Name = "_WebSitesToolStripMenuItem";
            _WebSitesToolStripMenuItem.Size = new Size(234, 26);
            _WebSitesToolStripMenuItem.Text = "Archive Web Sites";
            // 
            // WebPagesToolStripMenuItem
            // 
            _WebPagesToolStripMenuItem.Name = "_WebPagesToolStripMenuItem";
            _WebPagesToolStripMenuItem.Size = new Size(234, 26);
            _WebPagesToolStripMenuItem.Text = "Archive Web Pages";
            // 
            // ToolStripSeparator5
            // 
            ToolStripSeparator5.Name = "ToolStripSeparator5";
            ToolStripSeparator5.Size = new Size(231, 6);
            // 
            // ExitToolStripMenuItem1
            // 
            _ExitToolStripMenuItem1.Name = "_ExitToolStripMenuItem1";
            _ExitToolStripMenuItem1.Size = new Size(234, 26);
            _ExitToolStripMenuItem1.Text = "Exit";
            // 
            // LoginToolStripMenuItem
            // 
            LoginToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _LoginToSystemToolStripMenuItem, _ChangeUserPasswordToolStripMenuItem });
            LoginToolStripMenuItem.Name = "LoginToolStripMenuItem";
            LoginToolStripMenuItem.Size = new Size(58, 24);
            LoginToolStripMenuItem.Text = "Login";
            // 
            // LoginToSystemToolStripMenuItem
            // 
            _LoginToSystemToolStripMenuItem.Name = "_LoginToSystemToolStripMenuItem";
            _LoginToSystemToolStripMenuItem.Size = new Size(232, 26);
            _LoginToSystemToolStripMenuItem.Text = "Login To System";
            // 
            // ChangeUserPasswordToolStripMenuItem
            // 
            _ChangeUserPasswordToolStripMenuItem.Name = "_ChangeUserPasswordToolStripMenuItem";
            _ChangeUserPasswordToolStripMenuItem.Size = new Size(232, 26);
            _ChangeUserPasswordToolStripMenuItem.Text = "Change User Password";
            // 
            // TasksToolStripMenuItem
            // 
            TasksToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _ImpersonateLoginToolStripMenuItem, _LoginAsDifferenctUserToolStripMenuItem, _ManualEditAppConfigToolStripMenuItem, _ViewLogsToolStripMenuItem, _ViewOCRErrorFilesToolStripMenuItem, _AddDesktopIconToolStripMenuItem, UtilityToolStripMenuItem, _CheckForUpdatesToolStripMenuItem, _ShowSystemVersionToolStripMenuItem });
            TasksToolStripMenuItem.Name = "TasksToolStripMenuItem";
            TasksToolStripMenuItem.Size = new Size(54, 24);
            TasksToolStripMenuItem.Text = "Tasks";
            // 
            // ImpersonateLoginToolStripMenuItem
            // 
            _ImpersonateLoginToolStripMenuItem.Name = "_ImpersonateLoginToolStripMenuItem";
            _ImpersonateLoginToolStripMenuItem.Size = new Size(253, 26);
            _ImpersonateLoginToolStripMenuItem.Text = "Archiver Login";
            _ImpersonateLoginToolStripMenuItem.ToolTipText = "Set the login here that will be automatically used for archives on this machine.";
            _ImpersonateLoginToolStripMenuItem.Visible = false;
            // 
            // LoginAsDifferenctUserToolStripMenuItem
            // 
            _LoginAsDifferenctUserToolStripMenuItem.Name = "_LoginAsDifferenctUserToolStripMenuItem";
            _LoginAsDifferenctUserToolStripMenuItem.Size = new Size(253, 26);
            _LoginAsDifferenctUserToolStripMenuItem.Text = "Login as different User";
            _LoginAsDifferenctUserToolStripMenuItem.ToolTipText = "Press to login under a different user ID.";
            // 
            // ManualEditAppConfigToolStripMenuItem
            // 
            _ManualEditAppConfigToolStripMenuItem.Name = "_ManualEditAppConfigToolStripMenuItem";
            _ManualEditAppConfigToolStripMenuItem.Size = new Size(253, 26);
            _ManualEditAppConfigToolStripMenuItem.Text = "(Manual Edit) App Config";
            _ManualEditAppConfigToolStripMenuItem.ToolTipText = "Use with great care.";
            // 
            // ViewLogsToolStripMenuItem
            // 
            _ViewLogsToolStripMenuItem.Name = "_ViewLogsToolStripMenuItem";
            _ViewLogsToolStripMenuItem.Size = new Size(253, 26);
            _ViewLogsToolStripMenuItem.Text = "View Logs";
            // 
            // ViewOCRErrorFilesToolStripMenuItem
            // 
            _ViewOCRErrorFilesToolStripMenuItem.Name = "_ViewOCRErrorFilesToolStripMenuItem";
            _ViewOCRErrorFilesToolStripMenuItem.Size = new Size(253, 26);
            _ViewOCRErrorFilesToolStripMenuItem.Text = "View OCR Error Files";
            _ViewOCRErrorFilesToolStripMenuItem.Visible = false;
            // 
            // AddDesktopIconToolStripMenuItem
            // 
            _AddDesktopIconToolStripMenuItem.Name = "_AddDesktopIconToolStripMenuItem";
            _AddDesktopIconToolStripMenuItem.Size = new Size(253, 26);
            _AddDesktopIconToolStripMenuItem.Text = "Add Desktop Icon";
            // 
            // UtilityToolStripMenuItem
            // 
            UtilityToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { RepositoryUtilitiesToolStripMenuItem, ListenerUtilitiesToolStripMenuItem, SQLiteUtiltiiesToolStripMenuItem, ReOCRToolStripMenuItem, RetentionManagementToolStripMenuItem, _EncryptStringToolStripMenuItem, _OpenLicenseFormToolStripMenuItem });
            UtilityToolStripMenuItem.Name = "UtilityToolStripMenuItem";
            UtilityToolStripMenuItem.Size = new Size(253, 26);
            UtilityToolStripMenuItem.Text = "Utility";
            // 
            // RepositoryUtilitiesToolStripMenuItem
            // 
            RepositoryUtilitiesToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { CleanupSourceNameToolStripMenuItem, _ClearRestoreQueueToolStripMenuItem1, _CompareDirToRepositoryToolStripMenuItem1, _InventoryDirectoryToolStripMenuItem1, _ValidateDirectoryFilesToolStripMenuItem });
            RepositoryUtilitiesToolStripMenuItem.Name = "RepositoryUtilitiesToolStripMenuItem";
            RepositoryUtilitiesToolStripMenuItem.Size = new Size(240, 26);
            RepositoryUtilitiesToolStripMenuItem.Text = "Repository Utilities";
            // 
            // CleanupSourceNameToolStripMenuItem
            // 
            CleanupSourceNameToolStripMenuItem.Name = "CleanupSourceNameToolStripMenuItem";
            CleanupSourceNameToolStripMenuItem.Size = new Size(264, 26);
            CleanupSourceNameToolStripMenuItem.Text = "Cleanup SourceName";
            // 
            // ClearRestoreQueueToolStripMenuItem1
            // 
            _ClearRestoreQueueToolStripMenuItem1.Name = "_ClearRestoreQueueToolStripMenuItem1";
            _ClearRestoreQueueToolStripMenuItem1.Size = new Size(264, 26);
            _ClearRestoreQueueToolStripMenuItem1.Text = "Clear Restore Queue";
            // 
            // CompareDirToRepositoryToolStripMenuItem1
            // 
            _CompareDirToRepositoryToolStripMenuItem1.Name = "_CompareDirToRepositoryToolStripMenuItem1";
            _CompareDirToRepositoryToolStripMenuItem1.Size = new Size(264, 26);
            _CompareDirToRepositoryToolStripMenuItem1.Text = "Compare Dir To Repository";
            // 
            // InventoryDirectoryToolStripMenuItem1
            // 
            _InventoryDirectoryToolStripMenuItem1.Name = "_InventoryDirectoryToolStripMenuItem1";
            _InventoryDirectoryToolStripMenuItem1.Size = new Size(264, 26);
            _InventoryDirectoryToolStripMenuItem1.Text = "Inventory Directory";
            // 
            // ValidateDirectoryFilesToolStripMenuItem
            // 
            _ValidateDirectoryFilesToolStripMenuItem.Name = "_ValidateDirectoryFilesToolStripMenuItem";
            _ValidateDirectoryFilesToolStripMenuItem.Size = new Size(264, 26);
            _ValidateDirectoryFilesToolStripMenuItem.Text = "Validate Directory Files";
            // 
            // ListenerUtilitiesToolStripMenuItem
            // 
            ListenerUtilitiesToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _LIstWindowsLogsToolStripMenuItem, _CheckLogsForListenerInfoToolStripMenuItem });
            ListenerUtilitiesToolStripMenuItem.Name = "ListenerUtilitiesToolStripMenuItem";
            ListenerUtilitiesToolStripMenuItem.Size = new Size(240, 26);
            ListenerUtilitiesToolStripMenuItem.Text = "Listener Utilities";
            // 
            // LIstWindowsLogsToolStripMenuItem
            // 
            _LIstWindowsLogsToolStripMenuItem.Name = "_LIstWindowsLogsToolStripMenuItem";
            _LIstWindowsLogsToolStripMenuItem.Size = new Size(266, 26);
            _LIstWindowsLogsToolStripMenuItem.Text = "List Windows Logs";
            // 
            // CheckLogsForListenerInfoToolStripMenuItem
            // 
            _CheckLogsForListenerInfoToolStripMenuItem.Name = "_CheckLogsForListenerInfoToolStripMenuItem";
            _CheckLogsForListenerInfoToolStripMenuItem.Size = new Size(266, 26);
            _CheckLogsForListenerInfoToolStripMenuItem.Text = "Check Logs for Listener Info";
            // 
            // SQLiteUtiltiiesToolStripMenuItem
            // 
            SQLiteUtiltiiesToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _ResetSQLiteArchivesToolStripMenuItem, _GetOutlookEMailIDsToolStripMenuItem1, _ResetZIPFilesToolStripMenuItem, _ResetEmailIdentifierCodesToolStripMenuItem, _RebuildSQLiteDBToolStripMenuItem1, _BackupSQLiteDBToolStripMenuItem1, _RestoreSQLiteDBToolStripMenuItem1, _SQToolStripMenuItem });
            SQLiteUtiltiiesToolStripMenuItem.Name = "SQLiteUtiltiiesToolStripMenuItem";
            SQLiteUtiltiiesToolStripMenuItem.Size = new Size(240, 26);
            SQLiteUtiltiiesToolStripMenuItem.Text = "SQLite Utiltiies";
            // 
            // ResetSQLiteArchivesToolStripMenuItem
            // 
            _ResetSQLiteArchivesToolStripMenuItem.Name = "_ResetSQLiteArchivesToolStripMenuItem";
            _ResetSQLiteArchivesToolStripMenuItem.Size = new Size(270, 26);
            _ResetSQLiteArchivesToolStripMenuItem.Text = "Reset SQLite DB";
            // 
            // GetOutlookEMailIDsToolStripMenuItem1
            // 
            _GetOutlookEMailIDsToolStripMenuItem1.Name = "_GetOutlookEMailIDsToolStripMenuItem1";
            _GetOutlookEMailIDsToolStripMenuItem1.Size = new Size(270, 26);
            _GetOutlookEMailIDsToolStripMenuItem1.Text = "Get Outlook eMail IDs";
            // 
            // ResetZIPFilesToolStripMenuItem
            // 
            _ResetZIPFilesToolStripMenuItem.Name = "_ResetZIPFilesToolStripMenuItem";
            _ResetZIPFilesToolStripMenuItem.Size = new Size(270, 26);
            _ResetZIPFilesToolStripMenuItem.Text = "Reset ZIP Files";
            // 
            // ResetEmailIdentifierCodesToolStripMenuItem
            // 
            _ResetEmailIdentifierCodesToolStripMenuItem.Name = "_ResetEmailIdentifierCodesToolStripMenuItem";
            _ResetEmailIdentifierCodesToolStripMenuItem.Size = new Size(270, 26);
            _ResetEmailIdentifierCodesToolStripMenuItem.Text = "Reset Email Identifier Codes";
            // 
            // RebuildSQLiteDBToolStripMenuItem1
            // 
            _RebuildSQLiteDBToolStripMenuItem1.Name = "_RebuildSQLiteDBToolStripMenuItem1";
            _RebuildSQLiteDBToolStripMenuItem1.Size = new Size(270, 26);
            _RebuildSQLiteDBToolStripMenuItem1.Text = "Rebuild SQLite DB";
            // 
            // BackupSQLiteDBToolStripMenuItem1
            // 
            _BackupSQLiteDBToolStripMenuItem1.Name = "_BackupSQLiteDBToolStripMenuItem1";
            _BackupSQLiteDBToolStripMenuItem1.Size = new Size(270, 26);
            _BackupSQLiteDBToolStripMenuItem1.Text = "Backup SQLite DB";
            // 
            // RestoreSQLiteDBToolStripMenuItem1
            // 
            _RestoreSQLiteDBToolStripMenuItem1.Name = "_RestoreSQLiteDBToolStripMenuItem1";
            _RestoreSQLiteDBToolStripMenuItem1.Size = new Size(270, 26);
            _RestoreSQLiteDBToolStripMenuItem1.Text = "Restore SQLite DB";
            // 
            // SQToolStripMenuItem
            // 
            _SQToolStripMenuItem.Name = "_SQToolStripMenuItem";
            _SQToolStripMenuItem.Size = new Size(270, 26);
            _SQToolStripMenuItem.Text = "SQLite Mgt Screen";
            // 
            // ReOCRToolStripMenuItem
            // 
            ReOCRToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _EstimateNumberOfFilesToolStripMenuItem, ToolStripSeparator3, _ReOcrIncompleteGraphicFilesToolStripMenuItem, _ReOcrALLGraphicFilesToolStripMenuItem1 });
            ReOCRToolStripMenuItem.Name = "ReOCRToolStripMenuItem";
            ReOCRToolStripMenuItem.Size = new Size(240, 26);
            ReOCRToolStripMenuItem.Text = "OCR Utilities";
            ReOCRToolStripMenuItem.Visible = false;
            // 
            // EstimateNumberOfFilesToolStripMenuItem
            // 
            _EstimateNumberOfFilesToolStripMenuItem.Name = "_EstimateNumberOfFilesToolStripMenuItem";
            _EstimateNumberOfFilesToolStripMenuItem.Size = new Size(295, 26);
            _EstimateNumberOfFilesToolStripMenuItem.Text = "Estimate number of Files";
            // 
            // ToolStripSeparator3
            // 
            ToolStripSeparator3.Name = "ToolStripSeparator3";
            ToolStripSeparator3.Size = new Size(292, 6);
            // 
            // ReOcrIncompleteGraphicFilesToolStripMenuItem
            // 
            _ReOcrIncompleteGraphicFilesToolStripMenuItem.Name = "_ReOcrIncompleteGraphicFilesToolStripMenuItem";
            _ReOcrIncompleteGraphicFilesToolStripMenuItem.Size = new Size(295, 26);
            _ReOcrIncompleteGraphicFilesToolStripMenuItem.Text = "Re-Ocr Incomplete Graphic files";
            // 
            // ReOcrALLGraphicFilesToolStripMenuItem1
            // 
            _ReOcrALLGraphicFilesToolStripMenuItem1.Name = "_ReOcrALLGraphicFilesToolStripMenuItem1";
            _ReOcrALLGraphicFilesToolStripMenuItem1.Size = new Size(295, 26);
            _ReOcrALLGraphicFilesToolStripMenuItem1.Text = "Re-Ocr ALL Graphic files";
            // 
            // RetentionManagementToolStripMenuItem
            // 
            RetentionManagementToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _RetentionRulesToolStripMenuItem, _RulesExecutionToolStripMenuItem });
            RetentionManagementToolStripMenuItem.Name = "RetentionManagementToolStripMenuItem";
            RetentionManagementToolStripMenuItem.Size = new Size(240, 26);
            RetentionManagementToolStripMenuItem.Text = "Retention Management";
            // 
            // RetentionRulesToolStripMenuItem
            // 
            _RetentionRulesToolStripMenuItem.Name = "_RetentionRulesToolStripMenuItem";
            _RetentionRulesToolStripMenuItem.Size = new Size(187, 26);
            _RetentionRulesToolStripMenuItem.Text = "Retention Rules";
            // 
            // RulesExecutionToolStripMenuItem
            // 
            _RulesExecutionToolStripMenuItem.Name = "_RulesExecutionToolStripMenuItem";
            _RulesExecutionToolStripMenuItem.Size = new Size(187, 26);
            _RulesExecutionToolStripMenuItem.Text = "Rules Execution";
            // 
            // EncryptStringToolStripMenuItem
            // 
            _EncryptStringToolStripMenuItem.Name = "_EncryptStringToolStripMenuItem";
            _EncryptStringToolStripMenuItem.Size = new Size(240, 26);
            _EncryptStringToolStripMenuItem.Text = "Encrypt String";
            _EncryptStringToolStripMenuItem.ToolTipText = "Use this function to encrypt a string for use in ECM Library.";
            // 
            // OpenLicenseFormToolStripMenuItem
            // 
            _OpenLicenseFormToolStripMenuItem.Name = "_OpenLicenseFormToolStripMenuItem";
            _OpenLicenseFormToolStripMenuItem.Size = new Size(240, 26);
            _OpenLicenseFormToolStripMenuItem.Text = "Open License Form";
            // 
            // CheckForUpdatesToolStripMenuItem
            // 
            _CheckForUpdatesToolStripMenuItem.Name = "_CheckForUpdatesToolStripMenuItem";
            _CheckForUpdatesToolStripMenuItem.Size = new Size(253, 26);
            _CheckForUpdatesToolStripMenuItem.Text = "Check for Updates";
            // 
            // ShowSystemVersionToolStripMenuItem
            // 
            _ShowSystemVersionToolStripMenuItem.Name = "_ShowSystemVersionToolStripMenuItem";
            _ShowSystemVersionToolStripMenuItem.Size = new Size(253, 26);
            _ShowSystemVersionToolStripMenuItem.Text = "Show System Version";
            // 
            // SelectionToolStripMenuItem
            // 
            SelectionToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _AllToolStripMenuItem, _EmailToolStripMenuItem, _ContentToolStripMenuItem1, _ExecutionControlToolStripMenuItem, _FileTypesToolStripMenuItem });
            SelectionToolStripMenuItem.Name = "SelectionToolStripMenuItem";
            SelectionToolStripMenuItem.Size = new Size(82, 24);
            SelectionToolStripMenuItem.Text = "Selection";
            // 
            // AllToolStripMenuItem
            // 
            _AllToolStripMenuItem.Name = "_AllToolStripMenuItem";
            _AllToolStripMenuItem.Size = new Size(201, 26);
            _AllToolStripMenuItem.Text = "All";
            // 
            // EmailToolStripMenuItem
            // 
            _EmailToolStripMenuItem.Name = "_EmailToolStripMenuItem";
            _EmailToolStripMenuItem.Size = new Size(201, 26);
            _EmailToolStripMenuItem.Text = "Email";
            // 
            // ContentToolStripMenuItem1
            // 
            _ContentToolStripMenuItem1.Name = "_ContentToolStripMenuItem1";
            _ContentToolStripMenuItem1.Size = new Size(201, 26);
            _ContentToolStripMenuItem1.Text = "Content";
            // 
            // ExecutionControlToolStripMenuItem
            // 
            _ExecutionControlToolStripMenuItem.Name = "_ExecutionControlToolStripMenuItem";
            _ExecutionControlToolStripMenuItem.Size = new Size(201, 26);
            _ExecutionControlToolStripMenuItem.Text = "Execution Control";
            // 
            // FileTypesToolStripMenuItem
            // 
            _FileTypesToolStripMenuItem.Name = "_FileTypesToolStripMenuItem";
            _FileTypesToolStripMenuItem.Size = new Size(201, 26);
            _FileTypesToolStripMenuItem.Text = "File Types";
            // 
            // TestToolStripMenuItem
            // 
            TestToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _DirectoryInventoryToolStripMenuItem, _ListFilesInDirectoryToolStripMenuItem, _GetAllSubdirFilesToolStripMenuItem, OCRToolStripMenuItem, _FileHashToolStripMenuItem, _FileUploadToolStripMenuItem, _FileUploadBufferedToolStripMenuItem, _FileChunkUploadToolStripMenuItem, _RSSPullToolStripMenuItem, ShowEndpointsToolStripMenuItem, _UnhandledExceptionsToolStripMenuItem, ListenerFunctionsToolStripMenuItem });
            TestToolStripMenuItem.Name = "TestToolStripMenuItem";
            TestToolStripMenuItem.Size = new Size(47, 24);
            TestToolStripMenuItem.Text = "Test";
            // 
            // DirectoryInventoryToolStripMenuItem
            // 
            _DirectoryInventoryToolStripMenuItem.Name = "_DirectoryInventoryToolStripMenuItem";
            _DirectoryInventoryToolStripMenuItem.Size = new Size(241, 26);
            _DirectoryInventoryToolStripMenuItem.Text = "Directory Inventory";
            // 
            // ListFilesInDirectoryToolStripMenuItem
            // 
            _ListFilesInDirectoryToolStripMenuItem.Name = "_ListFilesInDirectoryToolStripMenuItem";
            _ListFilesInDirectoryToolStripMenuItem.Size = new Size(241, 26);
            _ListFilesInDirectoryToolStripMenuItem.Text = "List Files in Directory";
            // 
            // GetAllSubdirFilesToolStripMenuItem
            // 
            _GetAllSubdirFilesToolStripMenuItem.Name = "_GetAllSubdirFilesToolStripMenuItem";
            _GetAllSubdirFilesToolStripMenuItem.Size = new Size(241, 26);
            _GetAllSubdirFilesToolStripMenuItem.Text = "Get All Subdir Files";
            // 
            // OCRToolStripMenuItem
            // 
            OCRToolStripMenuItem.Name = "OCRToolStripMenuItem";
            OCRToolStripMenuItem.Size = new Size(241, 26);
            OCRToolStripMenuItem.Text = "OCR";
            // 
            // FileHashToolStripMenuItem
            // 
            _FileHashToolStripMenuItem.Name = "_FileHashToolStripMenuItem";
            _FileHashToolStripMenuItem.Size = new Size(241, 26);
            _FileHashToolStripMenuItem.Text = "File Hash";
            // 
            // FileUploadToolStripMenuItem
            // 
            _FileUploadToolStripMenuItem.Name = "_FileUploadToolStripMenuItem";
            _FileUploadToolStripMenuItem.Size = new Size(241, 26);
            _FileUploadToolStripMenuItem.Text = "File Upload File";
            // 
            // FileUploadBufferedToolStripMenuItem
            // 
            _FileUploadBufferedToolStripMenuItem.Name = "_FileUploadBufferedToolStripMenuItem";
            _FileUploadBufferedToolStripMenuItem.Size = new Size(241, 26);
            _FileUploadBufferedToolStripMenuItem.Text = "File Upload Buffered";
            // 
            // FileChunkUploadToolStripMenuItem
            // 
            _FileChunkUploadToolStripMenuItem.Name = "_FileChunkUploadToolStripMenuItem";
            _FileChunkUploadToolStripMenuItem.Size = new Size(241, 26);
            _FileChunkUploadToolStripMenuItem.Text = "File Chunk Upload";
            // 
            // RSSPullToolStripMenuItem
            // 
            _RSSPullToolStripMenuItem.Name = "_RSSPullToolStripMenuItem";
            _RSSPullToolStripMenuItem.Size = new Size(241, 26);
            _RSSPullToolStripMenuItem.Text = "RSS Pull";
            // 
            // ShowEndpointsToolStripMenuItem
            // 
            ShowEndpointsToolStripMenuItem.Name = "ShowEndpointsToolStripMenuItem";
            ShowEndpointsToolStripMenuItem.Size = new Size(241, 26);
            ShowEndpointsToolStripMenuItem.Text = "Show Endpoints";
            // 
            // UnhandledExceptionsToolStripMenuItem
            // 
            _UnhandledExceptionsToolStripMenuItem.Name = "_UnhandledExceptionsToolStripMenuItem";
            _UnhandledExceptionsToolStripMenuItem.Size = new Size(241, 26);
            _UnhandledExceptionsToolStripMenuItem.Text = "Unhandled Exception(s)";
            // 
            // ListenerFunctionsToolStripMenuItem
            // 
            ListenerFunctionsToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _GetListenerFilesToolStripMenuItem });
            ListenerFunctionsToolStripMenuItem.Name = "ListenerFunctionsToolStripMenuItem";
            ListenerFunctionsToolStripMenuItem.Size = new Size(241, 26);
            ListenerFunctionsToolStripMenuItem.Text = "Listener Functions";
            // 
            // GetListenerFilesToolStripMenuItem
            // 
            _GetListenerFilesToolStripMenuItem.Name = "_GetListenerFilesToolStripMenuItem";
            _GetListenerFilesToolStripMenuItem.Size = new Size(195, 26);
            _GetListenerFilesToolStripMenuItem.Text = "Get Listener Files";
            // 
            // ExitToolStripMenuItem
            // 
            _ExitToolStripMenuItem.Name = "_ExitToolStripMenuItem";
            _ExitToolStripMenuItem.Size = new Size(45, 24);
            _ExitToolStripMenuItem.Text = "Exit";
            // 
            // HelpToolStripMenuItem
            // 
            HelpToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _AboutToolStripMenuItem, _OnlineHelpToolStripMenuItem, ToolStripSeparator4, _AppConfigVersionToolStripMenuItem, _RunningArchiverToolStripMenuItem, _ParameterExecutionToolStripMenuItem, _HistoryToolStripMenuItem });
            HelpToolStripMenuItem.Name = "HelpToolStripMenuItem";
            HelpToolStripMenuItem.Size = new Size(53, 24);
            HelpToolStripMenuItem.Text = "Help";
            // 
            // AboutToolStripMenuItem
            // 
            _AboutToolStripMenuItem.Name = "_AboutToolStripMenuItem";
            _AboutToolStripMenuItem.Size = new Size(219, 26);
            _AboutToolStripMenuItem.Text = "About";
            // 
            // OnlineHelpToolStripMenuItem
            // 
            _OnlineHelpToolStripMenuItem.Name = "_OnlineHelpToolStripMenuItem";
            _OnlineHelpToolStripMenuItem.Size = new Size(219, 26);
            _OnlineHelpToolStripMenuItem.Text = "On-line Help";
            // 
            // ToolStripSeparator4
            // 
            ToolStripSeparator4.Name = "ToolStripSeparator4";
            ToolStripSeparator4.Size = new Size(216, 6);
            // 
            // AppConfigVersionToolStripMenuItem
            // 
            _AppConfigVersionToolStripMenuItem.Name = "_AppConfigVersionToolStripMenuItem";
            _AppConfigVersionToolStripMenuItem.Size = new Size(219, 26);
            _AppConfigVersionToolStripMenuItem.Text = "App Config Version";
            // 
            // RunningArchiverToolStripMenuItem
            // 
            _RunningArchiverToolStripMenuItem.Name = "_RunningArchiverToolStripMenuItem";
            _RunningArchiverToolStripMenuItem.Size = new Size(219, 26);
            _RunningArchiverToolStripMenuItem.Text = "Running Archiver";
            // 
            // ParameterExecutionToolStripMenuItem
            // 
            _ParameterExecutionToolStripMenuItem.Name = "_ParameterExecutionToolStripMenuItem";
            _ParameterExecutionToolStripMenuItem.Size = new Size(219, 26);
            _ParameterExecutionToolStripMenuItem.Text = "Parameter Execution";
            // 
            // HistoryToolStripMenuItem
            // 
            _HistoryToolStripMenuItem.Name = "_HistoryToolStripMenuItem";
            _HistoryToolStripMenuItem.Size = new Size(219, 26);
            _HistoryToolStripMenuItem.Text = "History";
            // 
            // StatusStrip1
            // 
            StatusStrip1.ImageScalingSize = new Size(20, 20);
            StatusStrip1.Items.AddRange(new ToolStripItem[] { infoDaysToExpire, tssServer, tssVersion, tssAuth, tssUser, tbExchange, PB1, tsStatus02, SB5, ToolStripStatusLabel1, tsBytesLoading, tsServiceDBConnState, tsTunnelConn, tsCurrentRepoID, tsLastArchive, tsCountDown, tsTimeToArchive });
            StatusStrip1.Location = new Point(0, 850);
            StatusStrip1.Name = "StatusStrip1";
            StatusStrip1.Padding = new Padding(1, 0, 19, 0);
            StatusStrip1.Size = new Size(1283, 26);
            StatusStrip1.TabIndex = 78;
            StatusStrip1.Text = "StatusStrip1";
            // 
            // infoDaysToExpire
            // 
            infoDaysToExpire.ForeColor = Color.Yellow;
            infoDaysToExpire.Name = "infoDaysToExpire";
            infoDaysToExpire.Size = new Size(41, 21);
            infoDaysToExpire.Text = "Days";
            // 
            // tssServer
            // 
            tssServer.ForeColor = SystemColors.ButtonHighlight;
            tssServer.Name = "tssServer";
            tssServer.Size = new Size(50, 21);
            tssServer.Text = "Server";
            // 
            // tssVersion
            // 
            tssVersion.ForeColor = SystemColors.ButtonHighlight;
            tssVersion.Name = "tssVersion";
            tssVersion.Size = new Size(57, 21);
            tssVersion.Text = "Version";
            // 
            // tssAuth
            // 
            tssAuth.ForeColor = SystemColors.ButtonHighlight;
            tssAuth.Name = "tssAuth";
            tssAuth.Size = new Size(70, 21);
            tssAuth.Text = "Authority";
            // 
            // tssUser
            // 
            tssUser.ForeColor = SystemColors.ButtonHighlight;
            tssUser.Name = "tssUser";
            tssUser.Size = new Size(38, 21);
            tssUser.Text = "User";
            // 
            // tbExchange
            // 
            tbExchange.ForeColor = SystemColors.ControlLightLight;
            tbExchange.Name = "tbExchange";
            tbExchange.Size = new Size(18, 21);
            tbExchange.Text = "...";
            // 
            // PB1
            // 
            PB1.Name = "PB1";
            PB1.Size = new Size(133, 20);
            // 
            // tsStatus02
            // 
            tsStatus02.ForeColor = SystemColors.ButtonHighlight;
            tsStatus02.Name = "tsStatus02";
            tsStatus02.Size = new Size(49, 21);
            tsStatus02.Text = "Status";
            // 
            // SB5
            // 
            SB5.ForeColor = SystemColors.ButtonFace;
            SB5.Name = "SB5";
            SB5.Size = new Size(50, 21);
            SB5.Text = "Active";
            SB5.ToolTipText = "Status";
            // 
            // ToolStripStatusLabel1
            // 
            ToolStripStatusLabel1.ForeColor = SystemColors.ButtonFace;
            ToolStripStatusLabel1.Name = "ToolStripStatusLabel1";
            ToolStripStatusLabel1.Size = new Size(50, 21);
            ToolStripStatusLabel1.Text = "Active";
            ToolStripStatusLabel1.ToolTipText = "Connection Status";
            // 
            // tsBytesLoading
            // 
            tsBytesLoading.ForeColor = Color.Yellow;
            tsBytesLoading.Name = "tsBytesLoading";
            tsBytesLoading.Size = new Size(71, 21);
            tsBytesLoading.Text = "File Bytes";
            tsBytesLoading.ToolTipText = "The number of bytes loading in the current file.";
            // 
            // tsServiceDBConnState
            // 
            tsServiceDBConnState.ForeColor = Color.White;
            tsServiceDBConnState.Name = "tsServiceDBConnState";
            tsServiceDBConnState.Size = new Size(92, 21);
            tsServiceDBConnState.Text = "Cloud Status";
            tsServiceDBConnState.ToolTipText = "Shows the current status of the Cloud Connection.";
            // 
            // tsTunnelConn
            // 
            tsTunnelConn.ForeColor = Color.White;
            tsTunnelConn.Name = "tsTunnelConn";
            tsTunnelConn.Size = new Size(97, 21);
            tsTunnelConn.Text = "Tunnel Status";
            tsTunnelConn.ToolTipText = "If YES, the tunnel connection is valid.";
            // 
            // tsCurrentRepoID
            // 
            tsCurrentRepoID.ForeColor = SystemColors.ButtonHighlight;
            tsCurrentRepoID.Name = "tsCurrentRepoID";
            tsCurrentRepoID.Size = new Size(59, 21);
            tsCurrentRepoID.Text = "RepoID";
            // 
            // tsLastArchive
            // 
            tsLastArchive.ForeColor = SystemColors.ButtonHighlight;
            tsLastArchive.Name = "tsLastArchive";
            tsLastArchive.Size = new Size(88, 21);
            tsLastArchive.Text = "Last Archive";
            tsLastArchive.ToolTipText = "Last Archive Date";
            // 
            // tsCountDown
            // 
            tsCountDown.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(128)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)));
            tsCountDown.Name = "tsCountDown";
            tsCountDown.Size = new Size(63, 21);
            tsCountDown.Text = "00:00:00";
            // 
            // tsTimeToArchive
            // 
            tsTimeToArchive.ForeColor = Color.White;
            tsTimeToArchive.Name = "tsTimeToArchive";
            tsTimeToArchive.Size = new Size(93, 21);
            tsTimeToArchive.Text = "Next Archive";
            tsTimeToArchive.ToolTipText = "Next Archive Time";
            // 
            // TimerQuickArchive
            // 
            _TimerQuickArchive.Enabled = true;
            _TimerQuickArchive.Interval = 60000;
            // 
            // TabControl1
            // 
            TabControl1.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            TabControl1.Controls.Add(TabPage1);
            TabControl1.Controls.Add(TabPage2);
            TabControl1.Controls.Add(TabPage4);
            TabControl1.Controls.Add(TabPage5);
            TabControl1.Controls.Add(TabPage6);
            TabControl1.Controls.Add(TabPage3);
            TabControl1.HotTrack = true;
            TabControl1.Location = new Point(16, 47);
            TabControl1.Margin = new Padding(4);
            TabControl1.Name = "TabControl1";
            TabControl1.SelectedIndex = 0;
            TabControl1.Size = new Size(1227, 634);
            TabControl1.TabIndex = 79;
            // 
            // TabPage1
            // 
            TabPage1.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)));
            TabPage1.Controls.Add(gbEmail);
            TabPage1.Location = new Point(4, 25);
            TabPage1.Margin = new Padding(4);
            TabPage1.Name = "TabPage1";
            TabPage1.Padding = new Padding(4);
            TabPage1.Size = new Size(1219, 605);
            TabPage1.TabIndex = 0;
            TabPage1.Text = "Email";
            // 
            // TabPage2
            // 
            TabPage2.Controls.Add(_gbContentMgt);
            TabPage2.Location = new Point(4, 25);
            TabPage2.Margin = new Padding(4);
            TabPage2.Name = "TabPage2";
            TabPage2.Padding = new Padding(4);
            TabPage2.Size = new Size(1219, 605);
            TabPage2.TabIndex = 1;
            TabPage2.Text = "Documents";
            TabPage2.UseVisualStyleBackColor = true;
            // 
            // TabPage4
            // 
            TabPage4.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(64)), Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(0)));
            TabPage4.Controls.Add(cbRssRetention);
            TabPage4.Controls.Add(Label31);
            TabPage4.Controls.Add(_dgRss);
            TabPage4.Controls.Add(_btnRemoveRSSfeed);
            TabPage4.Controls.Add(_btnAddRssFeed);
            TabPage4.Controls.Add(txtRssURL);
            TabPage4.Controls.Add(Label22);
            TabPage4.Controls.Add(txtRssName);
            TabPage4.Controls.Add(Label21);
            TabPage4.Controls.Add(Label20);
            TabPage4.Controls.Add(Label17);
            TabPage4.Location = new Point(4, 25);
            TabPage4.Margin = new Padding(4);
            TabPage4.Name = "TabPage4";
            TabPage4.Size = new Size(1219, 605);
            TabPage4.TabIndex = 3;
            TabPage4.Text = "RSS";
            // 
            // cbRssRetention
            // 
            cbRssRetention.FormattingEnabled = true;
            cbRssRetention.Location = new Point(584, 498);
            cbRssRetention.Margin = new Padding(4);
            cbRssRetention.Name = "cbRssRetention";
            cbRssRetention.Size = new Size(340, 24);
            cbRssRetention.TabIndex = 11;
            // 
            // Label31
            // 
            Label31.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label31.AutoSize = true;
            Label31.ForeColor = Color.WhiteSmoke;
            Label31.Location = new Point(580, 480);
            Label31.Margin = new Padding(4, 0, 4, 0);
            Label31.Name = "Label31";
            Label31.Size = new Size(110, 17);
            Label31.TabIndex = 10;
            Label31.Text = "Retention Code:";
            // 
            // dgRss
            // 
            _dgRss.AllowUserToAddRows = false;
            _dgRss.AllowUserToDeleteRows = false;
            _dgRss.AllowUserToOrderColumns = true;
            _dgRss.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgRss.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            _dgRss.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.DisplayedCells;
            _dgRss.BorderStyle = BorderStyle.Fixed3D;
            _dgRss.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgRss.Location = new Point(43, 146);
            _dgRss.Margin = new Padding(4);
            _dgRss.MultiSelect = false;
            _dgRss.Name = "_dgRss";
            _dgRss.Size = new Size(1069, 319);
            _dgRss.TabIndex = 9;
            // 
            // btnRemoveRSSfeed
            // 
            _btnRemoveRSSfeed.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnRemoveRSSfeed.Location = new Point(947, 542);
            _btnRemoveRSSfeed.Margin = new Padding(4);
            _btnRemoveRSSfeed.Name = "_btnRemoveRSSfeed";
            _btnRemoveRSSfeed.Size = new Size(128, 46);
            _btnRemoveRSSfeed.TabIndex = 8;
            _btnRemoveRSSfeed.Text = "Remove";
            _btnRemoveRSSfeed.UseVisualStyleBackColor = true;
            // 
            // btnAddRssFeed
            // 
            _btnAddRssFeed.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnAddRssFeed.Location = new Point(947, 489);
            _btnAddRssFeed.Margin = new Padding(4);
            _btnAddRssFeed.Name = "_btnAddRssFeed";
            _btnAddRssFeed.Size = new Size(128, 46);
            _btnAddRssFeed.TabIndex = 7;
            _btnAddRssFeed.Text = "Save";
            _btnAddRssFeed.UseVisualStyleBackColor = true;
            // 
            // Label22
            // 
            Label22.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label22.AutoSize = true;
            Label22.ForeColor = Color.WhiteSmoke;
            Label22.Location = new Point(64, 532);
            Label22.Margin = new Padding(4, 0, 4, 0);
            Label22.Name = "Label22";
            Label22.Size = new Size(68, 17);
            Label22.TabIndex = 5;
            Label22.Text = "Site URL:";
            // 
            // Label21
            // 
            Label21.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label21.AutoSize = true;
            Label21.ForeColor = Color.WhiteSmoke;
            Label21.Location = new Point(64, 480);
            Label21.Margin = new Padding(4, 0, 4, 0);
            Label21.Name = "Label21";
            Label21.Size = new Size(77, 17);
            Label21.TabIndex = 3;
            Label21.Text = "Site Name:";
            // 
            // Label20
            // 
            Label20.AutoSize = true;
            Label20.BackColor = Color.Transparent;
            Label20.ForeColor = Color.WhiteSmoke;
            Label20.Location = new Point(39, 106);
            Label20.Margin = new Padding(4, 0, 4, 0);
            Label20.Name = "Label20";
            Label20.Size = new Size(92, 17);
            Label20.TabIndex = 1;
            Label20.Text = "Defined Sites";
            // 
            // Label17
            // 
            Label17.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            Label17.AutoSize = true;
            Label17.BackColor = Color.Transparent;
            Label17.Font = new Font("Microsoft Sans Serif", 26.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            Label17.ForeColor = Color.WhiteSmoke;
            Label17.Location = new Point(33, 33);
            Label17.Margin = new Padding(4, 0, 4, 0);
            Label17.Name = "Label17";
            Label17.Size = new Size(653, 52);
            Label17.TabIndex = 0;
            Label17.Text = "RSS Capture Definition Screen";
            // 
            // TabPage5
            // 
            TabPage5.BackColor = Color.Black;
            TabPage5.Controls.Add(cbWebPageRetention);
            TabPage5.Controls.Add(Label32);
            TabPage5.Controls.Add(_btnRemoveWebPage);
            TabPage5.Controls.Add(_btnSaveWebPage);
            TabPage5.Controls.Add(txtWebScreenUrl);
            TabPage5.Controls.Add(Label23);
            TabPage5.Controls.Add(txtWebScreenName);
            TabPage5.Controls.Add(Label24);
            TabPage5.Controls.Add(_dgWebPage);
            TabPage5.Controls.Add(Label25);
            TabPage5.Controls.Add(Label18);
            TabPage5.ForeColor = Color.Transparent;
            TabPage5.Location = new Point(4, 25);
            TabPage5.Margin = new Padding(4);
            TabPage5.Name = "TabPage5";
            TabPage5.Size = new Size(1219, 605);
            TabPage5.TabIndex = 4;
            TabPage5.Text = "Web Screen";
            // 
            // cbWebPageRetention
            // 
            cbWebPageRetention.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            cbWebPageRetention.FormattingEnabled = true;
            cbWebPageRetention.Location = new Point(577, 442);
            cbWebPageRetention.Margin = new Padding(4);
            cbWebPageRetention.Name = "cbWebPageRetention";
            cbWebPageRetention.Size = new Size(340, 24);
            cbWebPageRetention.TabIndex = 18;
            // 
            // Label32
            // 
            Label32.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label32.AutoSize = true;
            Label32.ForeColor = Color.WhiteSmoke;
            Label32.Location = new Point(575, 410);
            Label32.Margin = new Padding(4, 0, 4, 0);
            Label32.Name = "Label32";
            Label32.Size = new Size(110, 17);
            Label32.TabIndex = 17;
            Label32.Text = "Retention Code:";
            // 
            // btnRemoveWebPage
            // 
            _btnRemoveWebPage.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnRemoveWebPage.ForeColor = Color.Black;
            _btnRemoveWebPage.Location = new Point(985, 485);
            _btnRemoveWebPage.Margin = new Padding(4);
            _btnRemoveWebPage.Name = "_btnRemoveWebPage";
            _btnRemoveWebPage.Size = new Size(128, 46);
            _btnRemoveWebPage.TabIndex = 16;
            _btnRemoveWebPage.Text = "Remove";
            _btnRemoveWebPage.UseVisualStyleBackColor = true;
            // 
            // btnSaveWebPage
            // 
            _btnSaveWebPage.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnSaveWebPage.ForeColor = Color.Black;
            _btnSaveWebPage.Location = new Point(985, 432);
            _btnSaveWebPage.Margin = new Padding(4);
            _btnSaveWebPage.Name = "_btnSaveWebPage";
            _btnSaveWebPage.Size = new Size(128, 46);
            _btnSaveWebPage.TabIndex = 15;
            _btnSaveWebPage.Text = "Save";
            _btnSaveWebPage.UseVisualStyleBackColor = true;
            // 
            // Label23
            // 
            Label23.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label23.AutoSize = true;
            Label23.ForeColor = SystemColors.ButtonFace;
            Label23.Location = new Point(39, 474);
            Label23.Margin = new Padding(4, 0, 4, 0);
            Label23.Name = "Label23";
            Label23.Size = new Size(68, 17);
            Label23.TabIndex = 13;
            Label23.Text = "Site URL:";
            // 
            // Label24
            // 
            Label24.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label24.AutoSize = true;
            Label24.ForeColor = SystemColors.ButtonFace;
            Label24.Location = new Point(39, 423);
            Label24.Margin = new Padding(4, 0, 4, 0);
            Label24.Name = "Label24";
            Label24.Size = new Size(77, 17);
            Label24.TabIndex = 11;
            Label24.Text = "Site Name:";
            // 
            // dgWebPage
            // 
            DataGridViewCellStyle1.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            DataGridViewCellStyle1.ForeColor = Color.Black;
            DataGridViewCellStyle1.SelectionBackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(192)));
            DataGridViewCellStyle1.SelectionForeColor = Color.White;
            DataGridViewCellStyle1.WrapMode = DataGridViewTriState.True;
            _dgWebPage.AlternatingRowsDefaultCellStyle = DataGridViewCellStyle1;
            _dgWebPage.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgWebPage.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCellsExceptHeader;
            _dgWebPage.BackgroundColor = Color.DimGray;
            DataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle2.BackColor = SystemColors.Control;
            DataGridViewCellStyle2.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle2.ForeColor = SystemColors.WindowText;
            DataGridViewCellStyle2.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle2.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle2.WrapMode = DataGridViewTriState.True;
            _dgWebPage.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle2;
            _dgWebPage.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            DataGridViewCellStyle3.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle3.BackColor = Color.LightGray;
            DataGridViewCellStyle3.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle3.ForeColor = Color.Transparent;
            DataGridViewCellStyle3.SelectionBackColor = Color.Yellow;
            DataGridViewCellStyle3.SelectionForeColor = Color.Navy;
            DataGridViewCellStyle3.WrapMode = DataGridViewTriState.True;
            _dgWebPage.DefaultCellStyle = DataGridViewCellStyle3;
            _dgWebPage.GridColor = SystemColors.ControlDarkDark;
            _dgWebPage.Location = new Point(43, 110);
            _dgWebPage.Margin = new Padding(4);
            _dgWebPage.MultiSelect = false;
            _dgWebPage.Name = "_dgWebPage";
            DataGridViewCellStyle4.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle4.BackColor = SystemColors.Control;
            DataGridViewCellStyle4.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle4.ForeColor = SystemColors.WindowText;
            DataGridViewCellStyle4.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle4.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle4.WrapMode = DataGridViewTriState.True;
            _dgWebPage.RowHeadersDefaultCellStyle = DataGridViewCellStyle4;
            _dgWebPage.Size = new Size(1071, 297);
            _dgWebPage.TabIndex = 10;
            // 
            // Label25
            // 
            Label25.AutoSize = true;
            Label25.ForeColor = SystemColors.ButtonFace;
            Label25.Location = new Point(39, 90);
            Label25.Margin = new Padding(4, 0, 4, 0);
            Label25.Name = "Label25";
            Label25.Size = new Size(92, 17);
            Label25.TabIndex = 9;
            Label25.Text = "Defined Sites";
            // 
            // Label18
            // 
            Label18.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            Label18.AutoSize = true;
            Label18.BackColor = Color.Transparent;
            Label18.Font = new Font("Microsoft Sans Serif", 26.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            Label18.ForeColor = SystemColors.ButtonFace;
            Label18.Location = new Point(33, 22);
            Label18.Margin = new Padding(4, 0, 4, 0);
            Label18.Name = "Label18";
            Label18.Size = new Size(465, 52);
            Label18.TabIndex = 1;
            Label18.Text = "WEB Screen Tracker ";
            // 
            // TabPage6
            // 
            TabPage6.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(64)));
            TabPage6.Controls.Add(cbWebSiteRetention);
            TabPage6.Controls.Add(Label33);
            TabPage6.Controls.Add(nbrOutboundLinks);
            TabPage6.Controls.Add(nbrDepth);
            TabPage6.Controls.Add(Label30);
            TabPage6.Controls.Add(Label29);
            TabPage6.Controls.Add(_btnRemoveWebSite);
            TabPage6.Controls.Add(_btnSaveWebSite);
            TabPage6.Controls.Add(txtWebSiteURL);
            TabPage6.Controls.Add(Label26);
            TabPage6.Controls.Add(txtWebSiteName);
            TabPage6.Controls.Add(Label27);
            TabPage6.Controls.Add(_dgWebSite);
            TabPage6.Controls.Add(Label28);
            TabPage6.Controls.Add(Label19);
            TabPage6.Location = new Point(4, 25);
            TabPage6.Margin = new Padding(4);
            TabPage6.Name = "TabPage6";
            TabPage6.Size = new Size(1219, 605);
            TabPage6.TabIndex = 5;
            TabPage6.Text = "Web Site";
            // 
            // cbWebSiteRetention
            // 
            cbWebSiteRetention.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            cbWebSiteRetention.FormattingEnabled = true;
            cbWebSiteRetention.Location = new Point(632, 473);
            cbWebSiteRetention.Margin = new Padding(4);
            cbWebSiteRetention.Name = "cbWebSiteRetention";
            cbWebSiteRetention.Size = new Size(340, 24);
            cbWebSiteRetention.TabIndex = 22;
            // 
            // Label33
            // 
            Label33.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label33.AutoSize = true;
            Label33.ForeColor = Color.WhiteSmoke;
            Label33.Location = new Point(631, 453);
            Label33.Margin = new Padding(4, 0, 4, 0);
            Label33.Name = "Label33";
            Label33.Size = new Size(110, 17);
            Label33.TabIndex = 21;
            Label33.Text = "Retention Code:";
            // 
            // nbrOutboundLinks
            // 
            nbrOutboundLinks.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            nbrOutboundLinks.Location = new Point(557, 470);
            nbrOutboundLinks.Margin = new Padding(4);
            nbrOutboundLinks.Name = "nbrOutboundLinks";
            nbrOutboundLinks.Size = new Size(53, 22);
            nbrOutboundLinks.TabIndex = 20;
            nbrOutboundLinks.Value = new decimal(new int[] { 10, 0, 0, 0 });
            // 
            // nbrDepth
            // 
            nbrDepth.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            nbrDepth.Location = new Point(479, 470);
            nbrDepth.Margin = new Padding(4);
            nbrDepth.Name = "nbrDepth";
            nbrDepth.Size = new Size(53, 22);
            nbrDepth.TabIndex = 19;
            nbrDepth.Value = new decimal(new int[] { 1, 0, 0, 0 });
            // 
            // Label30
            // 
            Label30.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label30.AutoSize = true;
            Label30.ForeColor = Color.Gainsboro;
            Label30.Location = new Point(553, 453);
            Label30.Margin = new Padding(4, 0, 4, 0);
            Label30.Name = "Label30";
            Label30.Size = new Size(44, 17);
            Label30.TabIndex = 18;
            Label30.Text = "Width";
            // 
            // Label29
            // 
            Label29.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label29.AutoSize = true;
            Label29.ForeColor = Color.Gainsboro;
            Label29.Location = new Point(475, 453);
            Label29.Margin = new Padding(4, 0, 4, 0);
            Label29.Name = "Label29";
            Label29.Size = new Size(46, 17);
            Label29.TabIndex = 17;
            Label29.Text = "Depth";
            // 
            // btnRemoveWebSite
            // 
            _btnRemoveWebSite.Location = new Point(985, 510);
            _btnRemoveWebSite.Margin = new Padding(4);
            _btnRemoveWebSite.Name = "_btnRemoveWebSite";
            _btnRemoveWebSite.Size = new Size(128, 46);
            _btnRemoveWebSite.TabIndex = 16;
            _btnRemoveWebSite.Text = "Remove";
            _btnRemoveWebSite.UseVisualStyleBackColor = true;
            // 
            // btnSaveWebSite
            // 
            _btnSaveWebSite.Location = new Point(985, 458);
            _btnSaveWebSite.Margin = new Padding(4);
            _btnSaveWebSite.Name = "_btnSaveWebSite";
            _btnSaveWebSite.Size = new Size(128, 46);
            _btnSaveWebSite.TabIndex = 15;
            _btnSaveWebSite.Text = "Save";
            _btnSaveWebSite.UseVisualStyleBackColor = true;
            // 
            // txtWebSiteURL
            // 
            txtWebSiteURL.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtWebSiteURL.Location = new Point(29, 521);
            txtWebSiteURL.Margin = new Padding(4);
            txtWebSiteURL.Name = "txtWebSiteURL";
            txtWebSiteURL.Size = new Size(943, 22);
            txtWebSiteURL.TabIndex = 14;
            // 
            // Label26
            // 
            Label26.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label26.AutoSize = true;
            Label26.ForeColor = Color.Gainsboro;
            Label26.Location = new Point(25, 503);
            Label26.Margin = new Padding(4, 0, 4, 0);
            Label26.Name = "Label26";
            Label26.Size = new Size(68, 17);
            Label26.TabIndex = 13;
            Label26.Text = "Site URL:";
            // 
            // txtWebSiteName
            // 
            txtWebSiteName.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            txtWebSiteName.Location = new Point(29, 473);
            txtWebSiteName.Margin = new Padding(4);
            txtWebSiteName.Name = "txtWebSiteName";
            txtWebSiteName.Size = new Size(432, 22);
            txtWebSiteName.TabIndex = 12;
            // 
            // Label27
            // 
            Label27.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label27.AutoSize = true;
            Label27.ForeColor = Color.Gainsboro;
            Label27.Location = new Point(25, 453);
            Label27.Margin = new Padding(4, 0, 4, 0);
            Label27.Name = "Label27";
            Label27.Size = new Size(77, 17);
            Label27.TabIndex = 11;
            Label27.Text = "Site Name:";
            // 
            // dgWebSite
            // 
            _dgWebSite.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgWebSite.BackgroundColor = SystemColors.ControlLight;
            DataGridViewCellStyle5.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle5.BackColor = SystemColors.Control;
            DataGridViewCellStyle5.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle5.ForeColor = SystemColors.WindowText;
            DataGridViewCellStyle5.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle5.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle5.WrapMode = DataGridViewTriState.True;
            _dgWebSite.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle5;
            _dgWebSite.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            DataGridViewCellStyle6.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle6.BackColor = SystemColors.Window;
            DataGridViewCellStyle6.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle6.ForeColor = SystemColors.ControlText;
            DataGridViewCellStyle6.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle6.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle6.WrapMode = DataGridViewTriState.False;
            _dgWebSite.DefaultCellStyle = DataGridViewCellStyle6;
            _dgWebSite.Location = new Point(43, 108);
            _dgWebSite.Margin = new Padding(4);
            _dgWebSite.Name = "_dgWebSite";
            DataGridViewCellStyle7.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle7.BackColor = SystemColors.Control;
            DataGridViewCellStyle7.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle7.ForeColor = SystemColors.WindowText;
            DataGridViewCellStyle7.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle7.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle7.WrapMode = DataGridViewTriState.True;
            _dgWebSite.RowHeadersDefaultCellStyle = DataGridViewCellStyle7;
            _dgWebSite.Size = new Size(1071, 318);
            _dgWebSite.TabIndex = 10;
            // 
            // Label28
            // 
            Label28.AutoSize = true;
            Label28.ForeColor = Color.Gainsboro;
            Label28.Location = new Point(39, 89);
            Label28.Margin = new Padding(4, 0, 4, 0);
            Label28.Name = "Label28";
            Label28.Size = new Size(92, 17);
            Label28.TabIndex = 9;
            Label28.Text = "Defined Sites";
            // 
            // Label19
            // 
            Label19.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            Label19.AutoSize = true;
            Label19.Font = new Font("Microsoft Sans Serif", 26.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            Label19.ForeColor = Color.Gainsboro;
            Label19.Location = new Point(33, 27);
            Label19.Margin = new Padding(4, 0, 4, 0);
            Label19.Name = "Label19";
            Label19.Size = new Size(387, 52);
            Label19.TabIndex = 1;
            Label19.Text = "WEB Site Tracker";
            // 
            // TabPage3
            // 
            TabPage3.BackColor = SystemColors.ControlDark;
            TabPage3.BackgroundImageLayout = ImageLayout.Stretch;
            TabPage3.Controls.Add(PictureBox2);
            TabPage3.Controls.Add(GroupBox1);
            TabPage3.Controls.Add(_btnDefaultAsso);
            TabPage3.Controls.Add(_btnRefreshDefaults);
            TabPage3.Controls.Add(gbFiletypes);
            TabPage3.Controls.Add(_gbPolling);
            TabPage3.Location = new Point(4, 25);
            TabPage3.Margin = new Padding(4);
            TabPage3.Name = "TabPage3";
            TabPage3.Size = new Size(1219, 605);
            TabPage3.TabIndex = 2;
            TabPage3.Text = "Execution Control";
            // 
            // GroupBox1
            // 
            GroupBox1.Controls.Add(btnFetch);
            GroupBox1.Controls.Add(txtCompany);
            GroupBox1.Controls.Add(btnActivate);
            GroupBox1.Controls.Add(cbRepo);
            GroupBox1.Controls.Add(Label15);
            GroupBox1.Controls.Add(Label14);
            GroupBox1.Location = new Point(797, 36);
            GroupBox1.Margin = new Padding(4);
            GroupBox1.Name = "GroupBox1";
            GroupBox1.Padding = new Padding(4);
            GroupBox1.Size = new Size(395, 201);
            GroupBox1.TabIndex = 32;
            GroupBox1.TabStop = false;
            GroupBox1.Text = "Active Repository";
            // 
            // txtCompany
            // 
            txtCompany.Location = new Point(23, 48);
            txtCompany.Margin = new Padding(4);
            txtCompany.Name = "txtCompany";
            txtCompany.Size = new Size(255, 22);
            txtCompany.TabIndex = 5;
            // 
            // btnActivate
            // 
            btnActivate.Location = new Point(137, 146);
            btnActivate.Margin = new Padding(4);
            btnActivate.Name = "btnActivate";
            btnActivate.Size = new Size(127, 38);
            btnActivate.TabIndex = 4;
            btnActivate.Text = "Activate";
            btnActivate.UseVisualStyleBackColor = true;
            // 
            // cbRepo
            // 
            cbRepo.FormattingEnabled = true;
            cbRepo.Location = new Point(24, 107);
            cbRepo.Margin = new Padding(4);
            cbRepo.Name = "cbRepo";
            cbRepo.Size = new Size(355, 24);
            cbRepo.TabIndex = 3;
            // 
            // Label15
            // 
            Label15.AutoSize = true;
            Label15.Location = new Point(19, 87);
            Label15.Margin = new Padding(4, 0, 4, 0);
            Label15.Name = "Label15";
            Label15.Size = new Size(97, 17);
            Label15.TabIndex = 1;
            Label15.Text = "Repository ID:";
            // 
            // Label14
            // 
            Label14.AutoSize = true;
            Label14.Location = new Point(19, 30);
            Label14.Margin = new Padding(4, 0, 4, 0);
            Label14.Name = "Label14";
            Label14.Size = new Size(88, 17);
            Label14.TabIndex = 0;
            Label14.Text = "Company ID:";
            // 
            // btnDefaultAsso
            // 
            _btnDefaultAsso.Location = new Point(901, 465);
            _btnDefaultAsso.Margin = new Padding(4);
            _btnDefaultAsso.Name = "_btnDefaultAsso";
            _btnDefaultAsso.Size = new Size(203, 31);
            _btnDefaultAsso.TabIndex = 31;
            _btnDefaultAsso.Text = "Reset Default Associations";
            _btnDefaultAsso.UseVisualStyleBackColor = true;
            // 
            // btnRefreshDefaults
            // 
            _btnRefreshDefaults.Location = new Point(904, 416);
            _btnRefreshDefaults.Margin = new Padding(4);
            _btnRefreshDefaults.Name = "_btnRefreshDefaults";
            _btnRefreshDefaults.Size = new Size(200, 30);
            _btnRefreshDefaults.TabIndex = 30;
            _btnRefreshDefaults.Text = "Reset Defaults";
            _btnRefreshDefaults.UseVisualStyleBackColor = true;
            // 
            // OpenFileDialog1
            // 
            OpenFileDialog1.FileName = "OpenFileDialog1";
            // 
            // BackgroundWorker1
            // 
            // 
            // BackgroundWorker2
            // 
            // 
            // ContentThread
            // 
            // 
            // BackgroundDirListener
            // 
            // 
            // BackgroundWorkerContacts
            // 
            // 
            // asyncBatchOcrALL
            // 
            // 
            // asyncBatchOcrPending
            // 
            // 
            // asyncVerifyRetainDates
            // 
            // 
            // asyncRssPull
            // 
            // 
            // asyncSpiderWebSite
            // 
            // 
            // asyncSpiderWebPage
            // 
            // 
            // Label37
            // 
            Label37.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label37.AutoSize = true;
            Label37.ForeColor = Color.White;
            Label37.Location = new Point(269, 775);
            Label37.Margin = new Padding(4, 0, 4, 0);
            Label37.Name = "Label37";
            Label37.Size = new Size(175, 17);
            Label37.TabIndex = 80;
            Label37.Text = "Assigned Customer Name:";
            Label37.Visible = false;
            // 
            // lblCustomerName
            // 
            lblCustomerName.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblCustomerName.AutoSize = true;
            lblCustomerName.ForeColor = Color.Yellow;
            lblCustomerName.Location = new Point(455, 775);
            lblCustomerName.Name = "lblCustomerName";
            lblCustomerName.Size = new Size(105, 17);
            lblCustomerName.TabIndex = 81;
            lblCustomerName.Text = "CustomerName";
            // 
            // lblCustomerID
            // 
            lblCustomerID.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblCustomerID.AutoSize = true;
            lblCustomerID.ForeColor = Color.Yellow;
            lblCustomerID.Location = new Point(829, 775);
            lblCustomerID.Name = "lblCustomerID";
            lblCustomerID.Size = new Size(81, 17);
            lblCustomerID.TabIndex = 83;
            lblCustomerID.Text = "CustomerID";
            // 
            // Label39
            // 
            Label39.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label39.AutoSize = true;
            Label39.ForeColor = Color.White;
            Label39.Location = new Point(644, 775);
            Label39.Margin = new Padding(4, 0, 4, 0);
            Label39.Name = "Label39";
            Label39.Size = new Size(151, 17);
            Label39.TabIndex = 82;
            Label39.Text = "Assigned Customer ID:";
            Label39.Visible = false;
            // 
            // TimerAutoExec
            // 
            _TimerAutoExec.Enabled = true;
            _TimerAutoExec.Interval = 60000;
            // 
            // lblNotice
            // 
            lblNotice.AutoSize = true;
            lblNotice.ForeColor = Color.Aquamarine;
            lblNotice.Location = new Point(23, 822);
            lblNotice.Margin = new Padding(4, 0, 4, 0);
            lblNotice.Name = "lblNotice";
            lblNotice.Size = new Size(52, 17);
            lblNotice.TabIndex = 84;
            lblNotice.Text = "Notice:";
            // 
            // ThreadValidateSourceName
            // 
            // 
            // frmMain
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            AutoScroll = true;
            AutoSize = true;
            AutoSizeMode = AutoSizeMode.GrowAndShrink;
            AutoValidate = AutoValidate.EnableAllowFocusChange;
            BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(0)), Conversions.ToInteger(Conversions.ToByte(64)));
            ClientSize = new Size(1283, 876);
            Controls.Add(lblNotice);
            Controls.Add(lblCustomerID);
            Controls.Add(Label39);
            Controls.Add(lblCustomerName);
            Controls.Add(Label37);
            Controls.Add(lblVer);
            Controls.Add(TabControl1);
            Controls.Add(_Label8);
            Controls.Add(_btnAddDir);
            Controls.Add(_cbFileDB);
            Controls.Add(StatusStrip1);
            Controls.Add(MenuStrip1);
            Controls.Add(_ckPauseListener);
            Controls.Add(PBx);
            Controls.Add(SB2);
            Controls.Add(_ckTerminate);
            Controls.Add(PictureBox1);
            Controls.Add(SB);
            HelpButton = true;
            f1Help.SetHelpString(this, "http://www.ecmlibrary.com/_helpfiles/frmReconMain.htm");
            Icon = (Icon)resources.GetObject("$this.Icon");
            MainMenuStrip = MenuStrip1;
            Margin = new Padding(4);
            Name = "frmMain";
            f1Help.SetShowHelp(this, true);
            StartPosition = FormStartPosition.CenterScreen;
            Text = "ECM Library Archive System - Cloud";
            gbEmail.ResumeLayout(false);
            gbEmail.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)NumericUpDown3).EndInit();
            gbFiletypes.ResumeLayout(false);
            gbFiletypes.PerformLayout();
            _gbPolling.ResumeLayout(false);
            _gbPolling.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)_nbrArchiveHours).EndInit();
            ((System.ComponentModel.ISupportInitialize)PictureBox2).EndInit();
            _gbContentMgt.ResumeLayout(false);
            Panel2.ResumeLayout(false);
            Panel2.PerformLayout();
            Panel1.ResumeLayout(false);
            Panel1.PerformLayout();
            Panel3.ResumeLayout(false);
            Panel3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)PictureBox1).EndInit();
            _ContextMenuStrip1.ResumeLayout(false);
            MenuStrip1.ResumeLayout(false);
            MenuStrip1.PerformLayout();
            StatusStrip1.ResumeLayout(false);
            StatusStrip1.PerformLayout();
            TabControl1.ResumeLayout(false);
            TabPage1.ResumeLayout(false);
            TabPage2.ResumeLayout(false);
            TabPage4.ResumeLayout(false);
            TabPage4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)_dgRss).EndInit();
            TabPage5.ResumeLayout(false);
            TabPage5.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)_dgWebPage).EndInit();
            TabPage6.ResumeLayout(false);
            TabPage6.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)nbrOutboundLinks).EndInit();
            ((System.ComponentModel.ISupportInitialize)nbrDepth).EndInit();
            ((System.ComponentModel.ISupportInitialize)_dgWebSite).EndInit();
            TabPage3.ResumeLayout(false);
            GroupBox1.ResumeLayout(false);
            GroupBox1.PerformLayout();
            Load += new EventHandler(frmReconMain_Load);
            Resize += new EventHandler(frmReconMain_Resize);
            FormClosing += new FormClosingEventHandler(frmReconMain_FormClosing);
            ResumeLayout(false);
            PerformLayout();
        }

        internal GroupBox gbEmail;
        private Button _btnActive;

        internal Button btnActive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnActive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnActive != null)
                {
                    _btnActive.Click -= btnActive_Click;
                }

                _btnActive = value;
                if (_btnActive != null)
                {
                    _btnActive.Click += btnActive_Click;
                }
            }
        }

        internal ComboBox cbEmailDB;
        internal Label Label4;
        internal NumericUpDown NumericUpDown3;
        private CheckBox _ckRemoveAfterXDays;

        internal CheckBox ckRemoveAfterXDays
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckRemoveAfterXDays;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckRemoveAfterXDays != null)
                {
                    _ckRemoveAfterXDays.CheckedChanged -= ckRemoveAfterXDays_CheckedChanged;
                }

                _ckRemoveAfterXDays = value;
                if (_ckRemoveAfterXDays != null)
                {
                    _ckRemoveAfterXDays.CheckedChanged += ckRemoveAfterXDays_CheckedChanged;
                }
            }
        }

        private Button _btnRefreshFolders;

        internal Button btnRefreshFolders
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRefreshFolders;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRefreshFolders != null)
                {
                    _btnRefreshFolders.Click -= btnRefreshFolders_Click;
                }

                _btnRefreshFolders = value;
                if (_btnRefreshFolders != null)
                {
                    _btnRefreshFolders.Click += btnRefreshFolders_Click;
                }
            }
        }

        private Button _btnSaveConditions;

        internal Button btnSaveConditions
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveConditions;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveConditions != null)
                {
                    _btnSaveConditions.Click -= btnSaveConditions_Click;
                }

                _btnSaveConditions = value;
                if (_btnSaveConditions != null)
                {
                    _btnSaveConditions.Click += btnSaveConditions_Click;
                }
            }
        }

        internal CheckBox ckArchiveFolder;
        private ListBox _lbActiveFolder;

        internal ListBox lbActiveFolder
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbActiveFolder;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbActiveFolder != null)
                {
                    _lbActiveFolder.MouseDown -= lbActiveFolder_MouseDown;
                    _lbActiveFolder.SelectedIndexChanged -= ListBox1_SelectedIndexChanged;
                }

                _lbActiveFolder = value;
                if (_lbActiveFolder != null)
                {
                    _lbActiveFolder.MouseDown += lbActiveFolder_MouseDown;
                    _lbActiveFolder.SelectedIndexChanged += ListBox1_SelectedIndexChanged;
                }
            }
        }

        internal TextBox SB;
        internal GroupBox gbFiletypes;
        private Button _ckRemoveFileType;

        internal Button ckRemoveFileType
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckRemoveFileType;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckRemoveFileType != null)
                {
                    _ckRemoveFileType.Click -= ckRemoveAfterDays_Click;
                }

                _ckRemoveFileType = value;
                if (_ckRemoveFileType != null)
                {
                    _ckRemoveFileType.Click += ckRemoveAfterDays_Click;
                }
            }
        }

        internal ComboBox cbFileTypes;
        private Button _btnAddFiletype;

        internal Button btnAddFiletype
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAddFiletype;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAddFiletype != null)
                {
                    _btnAddFiletype.Click -= btnAddFiletype_Click;
                }

                _btnAddFiletype = value;
                if (_btnAddFiletype != null)
                {
                    _btnAddFiletype.Click += btnAddFiletype_Click;
                }
            }
        }

        private GroupBox _gbPolling;

        internal GroupBox gbPolling
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _gbPolling;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_gbPolling != null)
                {
                    _gbPolling.MouseHover -= gbPolling_MouseHover;
                }

                _gbPolling = value;
                if (_gbPolling != null)
                {
                    _gbPolling.MouseHover += gbPolling_MouseHover;
                }
            }
        }

        private CheckBox _ckDisable;

        internal CheckBox ckDisable
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisable;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisable != null)
                {
                    _ckDisable.CheckedChanged -= ckDisable_CheckedChanged;
                }

                _ckDisable = value;
                if (_ckDisable != null)
                {
                    _ckDisable.CheckedChanged += ckDisable_CheckedChanged;
                }
            }
        }

        private GroupBox _gbContentMgt;

        internal GroupBox gbContentMgt
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _gbContentMgt;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_gbContentMgt != null)
                {
                    _gbContentMgt.Enter -= GroupBox2_Enter;
                }

                _gbContentMgt = value;
                if (_gbContentMgt != null)
                {
                    _gbContentMgt.Enter += GroupBox2_Enter;
                }
            }
        }

        private Button _btnInclFileType;

        internal Button btnInclFileType
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnInclFileType;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnInclFileType != null)
                {
                    _btnInclFileType.Click -= btnInclFileType_Click;
                }

                _btnInclFileType = value;
                if (_btnInclFileType != null)
                {
                    _btnInclFileType.Click += btnInclFileType_Click;
                }
            }
        }

        private Label _Label8;

        internal Label Label8
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Label8;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Label8 != null)
                {
                    _Label8.Click -= Label8_Click;
                }

                _Label8 = value;
                if (_Label8 != null)
                {
                    _Label8.Click += Label8_Click;
                }
            }
        }

        internal Label Label6;
        internal Label Label5;
        private ListBox _lbAvailExts;

        internal ListBox lbAvailExts
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbAvailExts;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbAvailExts != null)
                {
                    _lbAvailExts.SelectedIndexChanged -= lbAvailExts_SelectedIndexChanged;
                }

                _lbAvailExts = value;
                if (_lbAvailExts != null)
                {
                    _lbAvailExts.SelectedIndexChanged += lbAvailExts_SelectedIndexChanged;
                }
            }
        }

        private ListBox _lbIncludeExts;

        internal ListBox lbIncludeExts
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbIncludeExts;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbIncludeExts != null)
                {
                    _lbIncludeExts.SelectedIndexChanged -= lbIncludeExts_SelectedIndexChanged;
                }

                _lbIncludeExts = value;
                if (_lbIncludeExts != null)
                {
                    _lbIncludeExts.SelectedIndexChanged += lbIncludeExts_SelectedIndexChanged;
                }
            }
        }

        private ComboBox _cbFileDB;

        internal ComboBox cbFileDB
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _cbFileDB;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_cbFileDB != null)
                {
                    _cbFileDB.SelectedIndexChanged -= cbFileDB_SelectedIndexChanged;
                }

                _cbFileDB = value;
                if (_cbFileDB != null)
                {
                    _cbFileDB.SelectedIndexChanged += cbFileDB_SelectedIndexChanged;
                }
            }
        }

        private Button _btnRefresh;

        internal Button btnRefresh
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRefresh;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRefresh != null)
                {
                    _btnRefresh.Click -= Button5_Click;
                }

                _btnRefresh = value;
                if (_btnRefresh != null)
                {
                    _btnRefresh.Click += Button5_Click;
                }
            }
        }

        private Button _btnSaveChanges;

        internal Button btnSaveChanges
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveChanges;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveChanges != null)
                {
                    _btnSaveChanges.Click -= Button6_Click;
                }

                _btnSaveChanges = value;
                if (_btnSaveChanges != null)
                {
                    _btnSaveChanges.Click += Button6_Click;
                }
            }
        }

        private Button _btnRemoveDir;

        internal Button btnRemoveDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveDir != null)
                {
                    _btnRemoveDir.Click -= btnRemoveDir_Click;
                }

                _btnRemoveDir = value;
                if (_btnRemoveDir != null)
                {
                    _btnRemoveDir.Click += btnRemoveDir_Click;
                }
            }
        }

        private Button _btnAddDir;

        internal Button btnAddDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAddDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAddDir != null)
                {
                    _btnAddDir.Click -= btnAddDir_Click;
                }

                _btnAddDir = value;
                if (_btnAddDir != null)
                {
                    _btnAddDir.Click += btnAddDir_Click;
                }
            }
        }

        private Button _btnSelDir;

        internal Button btnSelDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSelDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSelDir != null)
                {
                    _btnSelDir.Click -= btnSelDir_Click;
                }

                _btnSelDir = value;
                if (_btnSelDir != null)
                {
                    _btnSelDir.Click += btnSelDir_Click;
                }
            }
        }

        private ListBox _lbArchiveDirs;

        internal ListBox lbArchiveDirs
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbArchiveDirs;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbArchiveDirs != null)
                {
                    _lbArchiveDirs.MouseDown -= lbArchiveDirs_MouseDown;
                    _lbArchiveDirs.SelectedIndexChanged -= ListBox2_SelectedIndexChanged;
                }

                _lbArchiveDirs = value;
                if (_lbArchiveDirs != null)
                {
                    _lbArchiveDirs.MouseDown += lbArchiveDirs_MouseDown;
                    _lbArchiveDirs.SelectedIndexChanged += ListBox2_SelectedIndexChanged;
                }
            }
        }

        private TextBox _txtDir;

        internal TextBox txtDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _txtDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_txtDir != null)
                {
                    _txtDir.TextChanged -= txtDir_TextChanged;
                }

                _txtDir = value;
                if (_txtDir != null)
                {
                    _txtDir.TextChanged += txtDir_TextChanged;
                }
            }
        }

        internal FolderBrowserDialog FolderBrowserDialog1;
        private CheckBox _ckSubDirs;

        internal CheckBox ckSubDirs
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckSubDirs;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckSubDirs != null)
                {
                    _ckSubDirs.CheckedChanged -= ckSubDirs_CheckedChanged;
                }

                _ckSubDirs = value;
                if (_ckSubDirs != null)
                {
                    _ckSubDirs.CheckedChanged += ckSubDirs_CheckedChanged;
                }
            }
        }

        private Button _btnDeleteEmailEntry;

        internal Button btnDeleteEmailEntry
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDeleteEmailEntry;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDeleteEmailEntry != null)
                {
                    _btnDeleteEmailEntry.Click -= btnDeleteEmailEntry_Click;
                }

                _btnDeleteEmailEntry = value;
                if (_btnDeleteEmailEntry != null)
                {
                    _btnDeleteEmailEntry.Click += btnDeleteEmailEntry_Click;
                }
            }
        }

        internal Label Label10;
        internal Label Label9;
        internal ComboBox cbAsType;
        internal ComboBox cbPocessType;
        private Button _Button2;

        internal Button Button2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button2 != null)
                {
                    _Button2.Click -= Button2_Click;
                }

                _Button2 = value;
                if (_Button2 != null)
                {
                    _Button2.Click += Button2_Click;
                }
            }
        }

        private Button _Button1;

        internal Button Button1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button1 != null)
                {
                    _Button1.Click -= Button1_Click;
                }

                _Button1 = value;
                if (_Button1 != null)
                {
                    _Button1.Click += Button1_Click;
                }
            }
        }

        private Button _Button3;

        internal Button Button3
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button3;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button3 != null)
                {
                    _Button3.Click -= Button3_Click;
                }

                _Button3 = value;
                if (_Button3 != null)
                {
                    _Button3.Click += Button3_Click;
                }
            }
        }

        internal ComboBox cbProcessAsList;
        private CheckBox _ckVersionFiles;

        internal CheckBox ckVersionFiles
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckVersionFiles;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckVersionFiles != null)
                {
                    _ckVersionFiles.CheckedChanged -= ckVersionFiles_CheckedChanged;
                }

                _ckVersionFiles = value;
                if (_ckVersionFiles != null)
                {
                    _ckVersionFiles.CheckedChanged += ckVersionFiles_CheckedChanged;
                }
            }
        }

        internal CheckBox ckArchiveRead;
        private CheckBox _ckMetaData;

        internal CheckBox ckMetaData
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckMetaData;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckMetaData != null)
                {
                    _ckMetaData.CheckedChanged -= ckMetaData_CheckedChanged;
                }

                _ckMetaData = value;
                if (_ckMetaData != null)
                {
                    _ckMetaData.CheckedChanged += ckMetaData_CheckedChanged;
                }
            }
        }

        private CheckBox _ckPublic;

        internal CheckBox ckPublic
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckPublic;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckPublic != null)
                {
                    _ckPublic.CheckedChanged -= ckPublic_CheckedChanged;
                }

                _ckPublic = value;
                if (_ckPublic != null)
                {
                    _ckPublic.CheckedChanged += ckPublic_CheckedChanged;
                }
            }
        }

        internal ToolTip TT;
        private Button _btnSaveSchedule;

        internal Button btnSaveSchedule
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveSchedule;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveSchedule != null)
                {
                    _btnSaveSchedule.Click -= btnSaveSchedule_Click;
                }

                _btnSaveSchedule = value;
                if (_btnSaveSchedule != null)
                {
                    _btnSaveSchedule.Click += btnSaveSchedule_Click;
                }
            }
        }

        private CheckBox _ckDisableDir;

        internal CheckBox ckDisableDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisableDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisableDir != null)
                {
                    _ckDisableDir.CheckedChanged -= ckDisableDir_CheckedChanged;
                }

                _ckDisableDir = value;
                if (_ckDisableDir != null)
                {
                    _ckDisableDir.CheckedChanged += ckDisableDir_CheckedChanged;
                }
            }
        }

        private Button _btnExclude;

        internal Button btnExclude
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExclude;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExclude != null)
                {
                    _btnExclude.Click -= btnExclude_Click;
                }

                _btnExclude = value;
                if (_btnExclude != null)
                {
                    _btnExclude.Click += btnExclude_Click;
                }
            }
        }

        private Button _btnRemoveExclude;

        internal Button btnRemoveExclude
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveExclude;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveExclude != null)
                {
                    _btnRemoveExclude.Click -= btnRemoveExclude_Click;
                }

                _btnRemoveExclude = value;
                if (_btnRemoveExclude != null)
                {
                    _btnRemoveExclude.Click += btnRemoveExclude_Click;
                }
            }
        }

        internal Label Label7;
        private ListBox _lbExcludeExts;

        internal ListBox lbExcludeExts
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbExcludeExts;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbExcludeExts != null)
                {
                    _lbExcludeExts.TextChanged -= lbExcludeExts_TextChanged;
                    _lbExcludeExts.SelectedIndexChanged -= lbExcludeExts_SelectedIndexChanged;
                }

                _lbExcludeExts = value;
                if (_lbExcludeExts != null)
                {
                    _lbExcludeExts.TextChanged += lbExcludeExts_TextChanged;
                    _lbExcludeExts.SelectedIndexChanged += lbExcludeExts_SelectedIndexChanged;
                }
            }
        }

        private CheckBox _ckUseLastProcessDateAsCutoff;

        internal CheckBox ckUseLastProcessDateAsCutoff
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckUseLastProcessDateAsCutoff;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckUseLastProcessDateAsCutoff != null)
                {
                    _ckUseLastProcessDateAsCutoff.CheckedChanged -= ckUseLastProcessDateAsCutoff_CheckedChanged;
                }

                _ckUseLastProcessDateAsCutoff = value;
                if (_ckUseLastProcessDateAsCutoff != null)
                {
                    _ckUseLastProcessDateAsCutoff.CheckedChanged += ckUseLastProcessDateAsCutoff_CheckedChanged;
                }
            }
        }

        internal CheckBox ckSystemFolder;
        private CheckBox _clAdminDir;

        internal CheckBox clAdminDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _clAdminDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_clAdminDir != null)
                {
                    _clAdminDir.CheckedChanged -= clAdminDir_CheckedChanged;
                }

                _clAdminDir = value;
                if (_clAdminDir != null)
                {
                    _clAdminDir.CheckedChanged += clAdminDir_CheckedChanged;
                }
            }
        }

        private CheckBox _ckOcr;

        internal CheckBox ckOcr
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckOcr;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckOcr != null)
                {
                    _ckOcr.CheckedChanged -= ckOcr_CheckedChanged;
                }

                _ckOcr = value;
                if (_ckOcr != null)
                {
                    _ckOcr.CheckedChanged += ckOcr_CheckedChanged;
                }
            }
        }

        internal HelpProvider f1Help;
        internal TextBox SB2;
        internal ComboBox cbRetention;
        internal ComboBox cbEmailRetention;
        private CheckBox _ckDisableOutlookEmailArchive;

        internal CheckBox ckDisableOutlookEmailArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisableOutlookEmailArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisableOutlookEmailArchive != null)
                {
                    _ckDisableOutlookEmailArchive.CheckedChanged -= ckDisableOutlookEmailArchive_CheckedChanged;
                }

                _ckDisableOutlookEmailArchive = value;
                if (_ckDisableOutlookEmailArchive != null)
                {
                    _ckDisableOutlookEmailArchive.CheckedChanged += ckDisableOutlookEmailArchive_CheckedChanged;
                }
            }
        }

        private CheckBox _ckDisableContentArchive;

        internal CheckBox ckDisableContentArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisableContentArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisableContentArchive != null)
                {
                    _ckDisableContentArchive.CheckedChanged -= ckDisableContentArchive_CheckedChanged;
                }

                _ckDisableContentArchive = value;
                if (_ckDisableContentArchive != null)
                {
                    _ckDisableContentArchive.CheckedChanged += ckDisableContentArchive_CheckedChanged;
                }
            }
        }

        private CheckBox _ckDisableExchange;

        internal CheckBox ckDisableExchange
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisableExchange;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisableExchange != null)
                {
                    _ckDisableExchange.CheckedChanged -= ckDisableExchange_CheckedChanged;
                }

                _ckDisableExchange = value;
                if (_ckDisableExchange != null)
                {
                    _ckDisableExchange.CheckedChanged += ckDisableExchange_CheckedChanged;
                }
            }
        }

        internal Button btnSMTP;
        internal ProgressBar PBx;
        private ComboBox _cbProfile;

        internal ComboBox cbProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _cbProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_cbProfile != null)
                {
                    _cbProfile.SelectedIndexChanged -= cbProfile_SelectedIndexChanged;
                }

                _cbProfile = value;
                if (_cbProfile != null)
                {
                    _cbProfile.SelectedIndexChanged += cbProfile_SelectedIndexChanged;
                }
            }
        }

        private Button _btnExclProfile;

        internal Button btnExclProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExclProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExclProfile != null)
                {
                    _btnExclProfile.Click -= btnExclProfile_Click;
                }

                _btnExclProfile = value;
                if (_btnExclProfile != null)
                {
                    _btnExclProfile.Click += btnExclProfile_Click;
                }
            }
        }

        private Button _btnInclProfile;

        internal Button btnInclProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnInclProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnInclProfile != null)
                {
                    _btnInclProfile.Click -= btnInclProfile_Click;
                }

                _btnInclProfile = value;
                if (_btnInclProfile != null)
                {
                    _btnInclProfile.Click += btnInclProfile_Click;
                }
            }
        }

        private ComboBox _cbParentFolders;

        internal ComboBox cbParentFolders
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _cbParentFolders;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_cbParentFolders != null)
                {
                    _cbParentFolders.SelectedIndexChanged -= cbParentFolders_SelectedIndexChanged;
                }

                _cbParentFolders = value;
                if (_cbParentFolders != null)
                {
                    _cbParentFolders.SelectedIndexChanged += cbParentFolders_SelectedIndexChanged;
                }
            }
        }

        private ContextMenuStrip _ContextMenuStrip1;

        internal ContextMenuStrip ContextMenuStrip1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ContextMenuStrip1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ContextMenuStrip1 != null)
                {
                    _ContextMenuStrip1.Opening -= ContextMenuStrip1_Opening;
                }

                _ContextMenuStrip1 = value;
                if (_ContextMenuStrip1 != null)
                {
                    _ContextMenuStrip1.Opening += ContextMenuStrip1_Opening;
                }
            }
        }

        private ToolStripMenuItem _ResetSelectedMailBoxesToolStripMenuItem;

        internal ToolStripMenuItem ResetSelectedMailBoxesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ResetSelectedMailBoxesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ResetSelectedMailBoxesToolStripMenuItem != null)
                {
                    _ResetSelectedMailBoxesToolStripMenuItem.Click -= ResetSelectedMailBoxesToolStripMenuItem_Click;
                }

                _ResetSelectedMailBoxesToolStripMenuItem = value;
                if (_ResetSelectedMailBoxesToolStripMenuItem != null)
                {
                    _ResetSelectedMailBoxesToolStripMenuItem.Click += ResetSelectedMailBoxesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _EmailLibraryReassignmentToolStripMenuItem;

        internal ToolStripMenuItem EmailLibraryReassignmentToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _EmailLibraryReassignmentToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_EmailLibraryReassignmentToolStripMenuItem != null)
                {
                    _EmailLibraryReassignmentToolStripMenuItem.Click -= EmailLibraryReassignmentToolStripMenuItem_Click;
                }

                _EmailLibraryReassignmentToolStripMenuItem = value;
                if (_EmailLibraryReassignmentToolStripMenuItem != null)
                {
                    _EmailLibraryReassignmentToolStripMenuItem.Click += EmailLibraryReassignmentToolStripMenuItem_Click;
                }
            }
        }

        internal Label Label13;
        internal Label Label11;
        private CheckBox _ckTerminate;

        internal CheckBox ckTerminate
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckTerminate;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckTerminate != null)
                {
                    _ckTerminate.CheckedChanged -= ckTerminate_CheckedChanged;
                }

                _ckTerminate = value;
                if (_ckTerminate != null)
                {
                    _ckTerminate.CheckedChanged += ckTerminate_CheckedChanged;
                }
            }
        }

        private Button _btnDeleteDirProfile;

        internal Button btnDeleteDirProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDeleteDirProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDeleteDirProfile != null)
                {
                    _btnDeleteDirProfile.Click -= btnDeleteDirProfile_Click;
                }

                _btnDeleteDirProfile = value;
                if (_btnDeleteDirProfile != null)
                {
                    _btnDeleteDirProfile.Click += btnDeleteDirProfile_Click;
                }
            }
        }

        private Button _btnUpdateDirectoryProfile;

        internal Button btnUpdateDirectoryProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnUpdateDirectoryProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnUpdateDirectoryProfile != null)
                {
                    _btnUpdateDirectoryProfile.Click -= btnUpdateDirectoryProfile_Click;
                }

                _btnUpdateDirectoryProfile = value;
                if (_btnUpdateDirectoryProfile != null)
                {
                    _btnUpdateDirectoryProfile.Click += btnUpdateDirectoryProfile_Click;
                }
            }
        }

        private Button _btnSaveDirProfile;

        internal Button btnSaveDirProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveDirProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveDirProfile != null)
                {
                    _btnSaveDirProfile.Click -= btnSaveDirProfile_Click;
                }

                _btnSaveDirProfile = value;
                if (_btnSaveDirProfile != null)
                {
                    _btnSaveDirProfile.Click += btnSaveDirProfile_Click;
                }
            }
        }

        private Button _btnApplyDirProfile;

        internal Button btnApplyDirProfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnApplyDirProfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnApplyDirProfile != null)
                {
                    _btnApplyDirProfile.Click -= btnApplyDirProfile_Click;
                }

                _btnApplyDirProfile = value;
                if (_btnApplyDirProfile != null)
                {
                    _btnApplyDirProfile.Click += btnApplyDirProfile_Click;
                }
            }
        }

        internal ComboBox cbDirProfile;
        internal Label Label12;
        private CheckBox _ckArchiveBit;

        internal CheckBox ckArchiveBit
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckArchiveBit;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckArchiveBit != null)
                {
                    _ckArchiveBit.CheckedChanged -= ckArchiveBit_CheckedChanged;
                }

                _ckArchiveBit = value;
                if (_ckArchiveBit != null)
                {
                    _ckArchiveBit.CheckedChanged += ckArchiveBit_CheckedChanged;
                }
            }
        }

        private CheckBox _CkMonitor;

        internal CheckBox CkMonitor
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CkMonitor;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CkMonitor != null)
                {
                    _CkMonitor.CheckedChanged -= CkMonitor_CheckedChanged;
                }

                _CkMonitor = value;
                if (_CkMonitor != null)
                {
                    _CkMonitor.CheckedChanged += CkMonitor_CheckedChanged;
                }
            }
        }

        private CheckBox _ckRunUnattended;

        internal CheckBox ckRunUnattended
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckRunUnattended;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckRunUnattended != null)
                {
                    _ckRunUnattended.CheckedChanged -= ckRunUnattended_CheckedChanged;
                }

                _ckRunUnattended = value;
                if (_ckRunUnattended != null)
                {
                    _ckRunUnattended.CheckedChanged += ckRunUnattended_CheckedChanged;
                }
            }
        }

        internal CheckBox ckDoNotShowArchived;
        internal PictureBox PictureBox1;
        internal CheckBox ckGetSubFolders;
        private Timer _TimerListeners;

        internal Timer TimerListeners
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _TimerListeners;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_TimerListeners != null)
                {
                    _TimerListeners.Tick -= TimerListeners_Tick;
                }

                _TimerListeners = value;
                if (_TimerListeners != null)
                {
                    _TimerListeners.Tick += TimerListeners_Tick;
                }
            }
        }

        private CheckBox _ckPauseListener;

        internal CheckBox ckPauseListener
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckPauseListener;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckPauseListener != null)
                {
                    _ckPauseListener.CheckedChanged -= ckPauseListener_CheckedChanged;
                }

                _ckPauseListener = value;
                if (_ckPauseListener != null)
                {
                    _ckPauseListener.CheckedChanged += ckPauseListener_CheckedChanged;
                }
            }
        }

        private Timer _TimerUploadFiles;

        internal Timer TimerUploadFiles
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _TimerUploadFiles;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_TimerUploadFiles != null)
                {
                    _TimerUploadFiles.Tick -= TimerUploadFiles_Tick;
                }

                _TimerUploadFiles = value;
                if (_TimerUploadFiles != null)
                {
                    _TimerUploadFiles.Tick += TimerUploadFiles_Tick;
                }
            }
        }

        private Timer _TimerEndRun;

        internal Timer TimerEndRun
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _TimerEndRun;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_TimerEndRun != null)
                {
                    _TimerEndRun.Tick -= TimerEndRun_Tick;
                }

                _TimerEndRun = value;
                if (_TimerEndRun != null)
                {
                    _TimerEndRun.Tick += TimerEndRun_Tick;
                }
            }
        }

        private Button _btnRefreshRetent;

        internal Button btnRefreshRetent
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRefreshRetent;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRefreshRetent != null)
                {
                    _btnRefreshRetent.Click -= btnRefreshRetent_Click;
                }

                _btnRefreshRetent = value;
                if (_btnRefreshRetent != null)
                {
                    _btnRefreshRetent.Click += btnRefreshRetent_Click;
                }
            }
        }

        private CheckBox _ckShowLibs;

        internal CheckBox ckShowLibs
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckShowLibs;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckShowLibs != null)
                {
                    _ckShowLibs.CheckedChanged -= ckShowLibs_CheckedChanged;
                }

                _ckShowLibs = value;
                if (_ckShowLibs != null)
                {
                    _ckShowLibs.CheckedChanged += ckShowLibs_CheckedChanged;
                }
            }
        }

        private CheckBox _ckOcrPdf;

        internal CheckBox ckOcrPdf
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckOcrPdf;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckOcrPdf != null)
                {
                    _ckOcrPdf.CheckedChanged -= ckOcrPdf_CheckedChanged;
                }

                _ckOcrPdf = value;
                if (_ckOcrPdf != null)
                {
                    _ckOcrPdf.CheckedChanged += ckOcrPdf_CheckedChanged;
                }
            }
        }

        internal MenuStrip MenuStrip1;
        internal ToolStripMenuItem ArchiveToolStripMenuItem;
        private ToolStripMenuItem _OutlookEmailsToolStripMenuItem;

        internal ToolStripMenuItem OutlookEmailsToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _OutlookEmailsToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_OutlookEmailsToolStripMenuItem != null)
                {
                    _OutlookEmailsToolStripMenuItem.Click -= OutlookEmailsToolStripMenuItem_Click;
                }

                _OutlookEmailsToolStripMenuItem = value;
                if (_OutlookEmailsToolStripMenuItem != null)
                {
                    _OutlookEmailsToolStripMenuItem.Click += OutlookEmailsToolStripMenuItem_Click;
                }
            }
        }

        internal StatusStrip StatusStrip1;
        private ToolStripMenuItem _ExchangeEmailsToolStripMenuItem;

        internal ToolStripMenuItem ExchangeEmailsToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ExchangeEmailsToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ExchangeEmailsToolStripMenuItem != null)
                {
                    _ExchangeEmailsToolStripMenuItem.Click -= ExchangeEmailsToolStripMenuItem_Click;
                }

                _ExchangeEmailsToolStripMenuItem = value;
                if (_ExchangeEmailsToolStripMenuItem != null)
                {
                    _ExchangeEmailsToolStripMenuItem.Click += ExchangeEmailsToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ContentToolStripMenuItem;

        internal ToolStripMenuItem ContentToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ContentToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ContentToolStripMenuItem != null)
                {
                    _ContentToolStripMenuItem.Click -= ContentToolStripMenuItem_Click;
                }

                _ContentToolStripMenuItem = value;
                if (_ContentToolStripMenuItem != null)
                {
                    _ContentToolStripMenuItem.Click += ContentToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ArchiveALLToolStripMenuItem;

        internal ToolStripMenuItem ArchiveALLToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ArchiveALLToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ArchiveALLToolStripMenuItem != null)
                {
                    _ArchiveALLToolStripMenuItem.Click -= ArchiveALLToolStripMenuItem_Click;
                }

                _ArchiveALLToolStripMenuItem = value;
                if (_ArchiveALLToolStripMenuItem != null)
                {
                    _ArchiveALLToolStripMenuItem.Click += ArchiveALLToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripMenuItem TasksToolStripMenuItem;
        private ToolStripMenuItem _LoginAsDifferenctUserToolStripMenuItem;

        internal ToolStripMenuItem LoginAsDifferenctUserToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _LoginAsDifferenctUserToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_LoginAsDifferenctUserToolStripMenuItem != null)
                {
                    _LoginAsDifferenctUserToolStripMenuItem.Click -= LoginAsDifferenctUserToolStripMenuItem_Click;
                }

                _LoginAsDifferenctUserToolStripMenuItem = value;
                if (_LoginAsDifferenctUserToolStripMenuItem != null)
                {
                    _LoginAsDifferenctUserToolStripMenuItem.Click += LoginAsDifferenctUserToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripStatusLabel infoDaysToExpire;
        internal ToolStripStatusLabel tssUser;
        internal ToolStripStatusLabel tssServer;
        internal ToolStripStatusLabel tssVersion;
        internal ToolStripMenuItem HelpToolStripMenuItem;
        private ToolStripMenuItem _RunningArchiverToolStripMenuItem;

        internal ToolStripMenuItem RunningArchiverToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RunningArchiverToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RunningArchiverToolStripMenuItem != null)
                {
                    _RunningArchiverToolStripMenuItem.Click -= RunningArchiverToolStripMenuItem_Click;
                }

                _RunningArchiverToolStripMenuItem = value;
                if (_RunningArchiverToolStripMenuItem != null)
                {
                    _RunningArchiverToolStripMenuItem.Click += RunningArchiverToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ParameterExecutionToolStripMenuItem;

        internal ToolStripMenuItem ParameterExecutionToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ParameterExecutionToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ParameterExecutionToolStripMenuItem != null)
                {
                    _ParameterExecutionToolStripMenuItem.Click -= ParameterExecutionToolStripMenuItem_Click;
                }

                _ParameterExecutionToolStripMenuItem = value;
                if (_ParameterExecutionToolStripMenuItem != null)
                {
                    _ParameterExecutionToolStripMenuItem.Click += ParameterExecutionToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripStatusLabel tssAuth;
        private ToolStripMenuItem _HistoryToolStripMenuItem;

        internal ToolStripMenuItem HistoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _HistoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_HistoryToolStripMenuItem != null)
                {
                    _HistoryToolStripMenuItem.Click -= HistoryToolStripMenuItem_Click;
                }

                _HistoryToolStripMenuItem = value;
                if (_HistoryToolStripMenuItem != null)
                {
                    _HistoryToolStripMenuItem.Click += HistoryToolStripMenuItem_Click;
                }
            }
        }

        private CheckBox _ckExpand;

        internal CheckBox ckExpand
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckExpand;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckExpand != null)
                {
                    _ckExpand.CheckedChanged -= ckExpand_CheckedChanged;
                }

                _ckExpand = value;
                if (_ckExpand != null)
                {
                    _ckExpand.CheckedChanged += ckExpand_CheckedChanged;
                }
            }
        }

        private ToolStripMenuItem _ViewLogsToolStripMenuItem;

        internal ToolStripMenuItem ViewLogsToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ViewLogsToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ViewLogsToolStripMenuItem != null)
                {
                    _ViewLogsToolStripMenuItem.Click -= ViewLogsToolStripMenuItem_Click;
                }

                _ViewLogsToolStripMenuItem = value;
                if (_ViewLogsToolStripMenuItem != null)
                {
                    _ViewLogsToolStripMenuItem.Click += ViewLogsToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripMenuItem TestToolStripMenuItem;
        private ToolStripMenuItem _DirectoryInventoryToolStripMenuItem;

        internal ToolStripMenuItem DirectoryInventoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _DirectoryInventoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_DirectoryInventoryToolStripMenuItem != null)
                {
                    _DirectoryInventoryToolStripMenuItem.Click -= DirectoryInventoryToolStripMenuItem_Click;
                }

                _DirectoryInventoryToolStripMenuItem = value;
                if (_DirectoryInventoryToolStripMenuItem != null)
                {
                    _DirectoryInventoryToolStripMenuItem.Click += DirectoryInventoryToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ListFilesInDirectoryToolStripMenuItem;

        internal ToolStripMenuItem ListFilesInDirectoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ListFilesInDirectoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ListFilesInDirectoryToolStripMenuItem != null)
                {
                    _ListFilesInDirectoryToolStripMenuItem.Click -= ListFilesInDirectoryToolStripMenuItem_Click;
                }

                _ListFilesInDirectoryToolStripMenuItem = value;
                if (_ListFilesInDirectoryToolStripMenuItem != null)
                {
                    _ListFilesInDirectoryToolStripMenuItem.Click += ListFilesInDirectoryToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _GetAllSubdirFilesToolStripMenuItem;

        internal ToolStripMenuItem GetAllSubdirFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _GetAllSubdirFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_GetAllSubdirFilesToolStripMenuItem != null)
                {
                    _GetAllSubdirFilesToolStripMenuItem.Click -= GetAllSubdirFilesToolStripMenuItem_Click;
                }

                _GetAllSubdirFilesToolStripMenuItem = value;
                if (_GetAllSubdirFilesToolStripMenuItem != null)
                {
                    _GetAllSubdirFilesToolStripMenuItem.Click += GetAllSubdirFilesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ViewOCRErrorFilesToolStripMenuItem;

        internal ToolStripMenuItem ViewOCRErrorFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ViewOCRErrorFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ViewOCRErrorFilesToolStripMenuItem != null)
                {
                    _ViewOCRErrorFilesToolStripMenuItem.Click -= ViewOCRErrorFilesToolStripMenuItem_Click;
                }

                _ViewOCRErrorFilesToolStripMenuItem = value;
                if (_ViewOCRErrorFilesToolStripMenuItem != null)
                {
                    _ViewOCRErrorFilesToolStripMenuItem.Click += ViewOCRErrorFilesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ScheduleToolStripMenuItem;

        internal ToolStripMenuItem ScheduleToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ScheduleToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ScheduleToolStripMenuItem != null)
                {
                    _ScheduleToolStripMenuItem.Click -= ScheduleToolStripMenuItem_Click;
                }

                _ScheduleToolStripMenuItem = value;
                if (_ScheduleToolStripMenuItem != null)
                {
                    _ScheduleToolStripMenuItem.Click += ScheduleToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripStatusLabel tbExchange;
        internal ToolStripMenuItem OCRToolStripMenuItem;
        private ToolStripMenuItem _AboutToolStripMenuItem;

        internal ToolStripMenuItem AboutToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _AboutToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_AboutToolStripMenuItem != null)
                {
                    _AboutToolStripMenuItem.Click -= AboutToolStripMenuItem_Click;
                }

                _AboutToolStripMenuItem = value;
                if (_AboutToolStripMenuItem != null)
                {
                    _AboutToolStripMenuItem.Click += AboutToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripProgressBar PB1;
        internal ToolStripStatusLabel tsStatus02;
        private ToolStripMenuItem _ManualEditAppConfigToolStripMenuItem;

        internal ToolStripMenuItem ManualEditAppConfigToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ManualEditAppConfigToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ManualEditAppConfigToolStripMenuItem != null)
                {
                    _ManualEditAppConfigToolStripMenuItem.Click -= ManualEditAppConfigToolStripMenuItem_Click;
                }

                _ManualEditAppConfigToolStripMenuItem = value;
                if (_ManualEditAppConfigToolStripMenuItem != null)
                {
                    _ManualEditAppConfigToolStripMenuItem.Click += ManualEditAppConfigToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripStatusLabel SB5;
        internal Panel Panel2;
        internal Panel Panel1;
        internal Panel Panel3;
        internal ToolStripStatusLabel ToolStripStatusLabel1;
        internal ToolStripMenuItem SetArchiveIntervalToolStripMenuItem;
        internal Label Label1;
        private NumericUpDown _nbrArchiveHours;

        internal NumericUpDown nbrArchiveHours
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _nbrArchiveHours;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_nbrArchiveHours != null)
                {
                    _nbrArchiveHours.ValueChanged -= NumericUpDown1_ValueChanged;
                }

                _nbrArchiveHours = value;
                if (_nbrArchiveHours != null)
                {
                    _nbrArchiveHours.ValueChanged += NumericUpDown1_ValueChanged;
                }
            }
        }

        private Timer _TimerQuickArchive;

        internal Timer TimerQuickArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _TimerQuickArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_TimerQuickArchive != null)
                {
                    _TimerQuickArchive.Tick -= TimerQuickArchive_Tick;
                }

                _TimerQuickArchive = value;
                if (_TimerQuickArchive != null)
                {
                    _TimerQuickArchive.Tick += TimerQuickArchive_Tick;
                }
            }
        }

        private Button _btnArchiveNow;

        internal Button btnArchiveNow
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnArchiveNow;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnArchiveNow != null)
                {
                    _btnArchiveNow.Click -= btnArchiveNow_Click;
                }

                _btnArchiveNow = value;
                if (_btnArchiveNow != null)
                {
                    _btnArchiveNow.Click += btnArchiveNow_Click;
                }
            }
        }

        internal ToolStripStatusLabel tsLastArchive;
        private ToolStripMenuItem _ImpersonateLoginToolStripMenuItem;

        internal ToolStripMenuItem ImpersonateLoginToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ImpersonateLoginToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ImpersonateLoginToolStripMenuItem != null)
                {
                    _ImpersonateLoginToolStripMenuItem.Click -= ImpersonateLoginToolStripMenuItem_Click;
                }

                _ImpersonateLoginToolStripMenuItem = value;
                if (_ImpersonateLoginToolStripMenuItem != null)
                {
                    _ImpersonateLoginToolStripMenuItem.Click += ImpersonateLoginToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _AddDesktopIconToolStripMenuItem;

        internal ToolStripMenuItem AddDesktopIconToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _AddDesktopIconToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_AddDesktopIconToolStripMenuItem != null)
                {
                    _AddDesktopIconToolStripMenuItem.Click -= AddDesktopIconToolStripMenuItem_Click;
                }

                _AddDesktopIconToolStripMenuItem = value;
                if (_AddDesktopIconToolStripMenuItem != null)
                {
                    _AddDesktopIconToolStripMenuItem.Click += AddDesktopIconToolStripMenuItem_Click;
                }
            }
        }

        private Button _btnRefreshRebuild;

        internal Button btnRefreshRebuild
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRefreshRebuild;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRefreshRebuild != null)
                {
                    _btnRefreshRebuild.Click -= btnRefreshRebuild_Click;
                }

                _btnRefreshRebuild = value;
                if (_btnRefreshRebuild != null)
                {
                    _btnRefreshRebuild.Click += btnRefreshRebuild_Click;
                }
            }
        }

        internal ToolStripStatusLabel tsBytesLoading;
        internal ToolStripMenuItem SelectionToolStripMenuItem;
        private ToolStripMenuItem _AllToolStripMenuItem;

        internal ToolStripMenuItem AllToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _AllToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_AllToolStripMenuItem != null)
                {
                    _AllToolStripMenuItem.Click -= AllToolStripMenuItem_Click;
                }

                _AllToolStripMenuItem = value;
                if (_AllToolStripMenuItem != null)
                {
                    _AllToolStripMenuItem.Click += AllToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _EmailToolStripMenuItem;

        internal ToolStripMenuItem EmailToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _EmailToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_EmailToolStripMenuItem != null)
                {
                    _EmailToolStripMenuItem.Click -= EmailToolStripMenuItem_Click;
                }

                _EmailToolStripMenuItem = value;
                if (_EmailToolStripMenuItem != null)
                {
                    _EmailToolStripMenuItem.Click += EmailToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ContentToolStripMenuItem1;

        internal ToolStripMenuItem ContentToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ContentToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ContentToolStripMenuItem1 != null)
                {
                    _ContentToolStripMenuItem1.Click -= ContentToolStripMenuItem1_Click;
                }

                _ContentToolStripMenuItem1 = value;
                if (_ContentToolStripMenuItem1 != null)
                {
                    _ContentToolStripMenuItem1.Click += ContentToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _ExecutionControlToolStripMenuItem;

        internal ToolStripMenuItem ExecutionControlToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ExecutionControlToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ExecutionControlToolStripMenuItem != null)
                {
                    _ExecutionControlToolStripMenuItem.Click -= ExecutionControlToolStripMenuItem_Click;
                }

                _ExecutionControlToolStripMenuItem = value;
                if (_ExecutionControlToolStripMenuItem != null)
                {
                    _ExecutionControlToolStripMenuItem.Click += ExecutionControlToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _FileTypesToolStripMenuItem;

        internal ToolStripMenuItem FileTypesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _FileTypesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_FileTypesToolStripMenuItem != null)
                {
                    _FileTypesToolStripMenuItem.Click -= FileTypesToolStripMenuItem_Click;
                }

                _FileTypesToolStripMenuItem = value;
                if (_FileTypesToolStripMenuItem != null)
                {
                    _FileTypesToolStripMenuItem.Click += FileTypesToolStripMenuItem_Click;
                }
            }
        }

        internal Label Label3;
        internal Label Label2;
        internal TabControl TabControl1;
        internal TabPage TabPage1;
        internal TabPage TabPage2;
        internal TabPage TabPage3;
        internal ToolStripStatusLabel tsServiceDBConnState;
        internal ToolStripStatusLabel tsTunnelConn;
        internal ToolStripMenuItem UtilityToolStripMenuItem;
        private ToolStripMenuItem _EncryptStringToolStripMenuItem;

        internal ToolStripMenuItem EncryptStringToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _EncryptStringToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_EncryptStringToolStripMenuItem != null)
                {
                    _EncryptStringToolStripMenuItem.Click -= EncryptStringToolStripMenuItem_Click;
                }

                _EncryptStringToolStripMenuItem = value;
                if (_EncryptStringToolStripMenuItem != null)
                {
                    _EncryptStringToolStripMenuItem.Click += EncryptStringToolStripMenuItem_Click;
                }
            }
        }

        private Button _btnRefreshDefaults;

        internal Button btnRefreshDefaults
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRefreshDefaults;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRefreshDefaults != null)
                {
                    _btnRefreshDefaults.Click -= btnRefreshDefaults_Click;
                }

                _btnRefreshDefaults = value;
                if (_btnRefreshDefaults != null)
                {
                    _btnRefreshDefaults.Click += btnRefreshDefaults_Click;
                }
            }
        }

        private Button _btnDefaultAsso;

        internal Button btnDefaultAsso
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDefaultAsso;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDefaultAsso != null)
                {
                    _btnDefaultAsso.Click -= btnDefaultAsso_Click;
                }

                _btnDefaultAsso = value;
                if (_btnDefaultAsso != null)
                {
                    _btnDefaultAsso.Click += btnDefaultAsso_Click;
                }
            }
        }

        private Button _btnAddDefaults;

        internal Button btnAddDefaults
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAddDefaults;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAddDefaults != null)
                {
                    _btnAddDefaults.Click -= btnAddDefaults_Click;
                }

                _btnAddDefaults = value;
                if (_btnAddDefaults != null)
                {
                    _btnAddDefaults.Click += btnAddDefaults_Click;
                }
            }
        }

        private ToolStripMenuItem _FileHashToolStripMenuItem;

        internal ToolStripMenuItem FileHashToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _FileHashToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_FileHashToolStripMenuItem != null)
                {
                    _FileHashToolStripMenuItem.Click -= FileHashToolStripMenuItem_Click;
                }

                _FileHashToolStripMenuItem = value;
                if (_FileHashToolStripMenuItem != null)
                {
                    _FileHashToolStripMenuItem.Click += FileHashToolStripMenuItem_Click;
                }
            }
        }

        internal OpenFileDialog OpenFileDialog1;
        private System.ComponentModel.BackgroundWorker _BackgroundWorker1;

        internal System.ComponentModel.BackgroundWorker BackgroundWorker1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _BackgroundWorker1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_BackgroundWorker1 != null)
                {
                    _BackgroundWorker1.DoWork -= BackgroundWorker1_DoWork;
                }

                _BackgroundWorker1 = value;
                if (_BackgroundWorker1 != null)
                {
                    _BackgroundWorker1.DoWork += BackgroundWorker1_DoWork;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _BackgroundWorker2;

        internal System.ComponentModel.BackgroundWorker BackgroundWorker2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _BackgroundWorker2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_BackgroundWorker2 != null)
                {
                    _BackgroundWorker2.DoWork -= BackgroundWorker2_DoWork;
                }

                _BackgroundWorker2 = value;
                if (_BackgroundWorker2 != null)
                {
                    _BackgroundWorker2.DoWork += BackgroundWorker2_DoWork;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _ContentThread;

        internal System.ComponentModel.BackgroundWorker ContentThread
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ContentThread;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ContentThread != null)
                {
                    _ContentThread.DoWork -= ContentThread_DoWork;
                }

                _ContentThread = value;
                if (_ContentThread != null)
                {
                    _ContentThread.DoWork += ContentThread_DoWork;
                }
            }
        }

        private ToolStripMenuItem _FileUploadToolStripMenuItem;

        internal ToolStripMenuItem FileUploadToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _FileUploadToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_FileUploadToolStripMenuItem != null)
                {
                    _FileUploadToolStripMenuItem.Click -= FileUploadToolStripMenuItem_Click;
                }

                _FileUploadToolStripMenuItem = value;
                if (_FileUploadToolStripMenuItem != null)
                {
                    _FileUploadToolStripMenuItem.Click += FileUploadToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _FileUploadBufferedToolStripMenuItem;

        internal ToolStripMenuItem FileUploadBufferedToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _FileUploadBufferedToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_FileUploadBufferedToolStripMenuItem != null)
                {
                    _FileUploadBufferedToolStripMenuItem.Click -= FileUploadBufferedToolStripMenuItem_Click;
                }

                _FileUploadBufferedToolStripMenuItem = value;
                if (_FileUploadBufferedToolStripMenuItem != null)
                {
                    _FileUploadBufferedToolStripMenuItem.Click += FileUploadBufferedToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _FileChunkUploadToolStripMenuItem;

        internal ToolStripMenuItem FileChunkUploadToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _FileChunkUploadToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_FileChunkUploadToolStripMenuItem != null)
                {
                    _FileChunkUploadToolStripMenuItem.Click -= FileChunkUploadToolStripMenuItem_Click;
                }

                _FileChunkUploadToolStripMenuItem = value;
                if (_FileChunkUploadToolStripMenuItem != null)
                {
                    _FileChunkUploadToolStripMenuItem.Click += FileChunkUploadToolStripMenuItem_Click;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _BackgroundDirListener;

        internal System.ComponentModel.BackgroundWorker BackgroundDirListener
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _BackgroundDirListener;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_BackgroundDirListener != null)
                {
                    _BackgroundDirListener.DoWork -= BackgroundDirListener_DoWork;
                }

                _BackgroundDirListener = value;
                if (_BackgroundDirListener != null)
                {
                    _BackgroundDirListener.DoWork += BackgroundDirListener_DoWork;
                }
            }
        }

        internal GroupBox GroupBox1;
        internal Button btnActivate;
        internal ComboBox cbRepo;
        internal Label Label15;
        internal Label Label14;
        internal ToolStripStatusLabel tsCurrentRepoID;
        internal TextBox txtCompany;
        internal Button btnFetch;
        private ToolStripMenuItem _ExitToolStripMenuItem;

        internal ToolStripMenuItem ExitToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ExitToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ExitToolStripMenuItem != null)
                {
                    _ExitToolStripMenuItem.Click -= ExitToolStripMenuItem_Click;
                }

                _ExitToolStripMenuItem = value;
                if (_ExitToolStripMenuItem != null)
                {
                    _ExitToolStripMenuItem.Click += ExitToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ExitToolStripMenuItem1;

        internal ToolStripMenuItem ExitToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ExitToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ExitToolStripMenuItem1 != null)
                {
                    _ExitToolStripMenuItem1.Click -= ExitToolStripMenuItem1_Click;
                }

                _ExitToolStripMenuItem1 = value;
                if (_ExitToolStripMenuItem1 != null)
                {
                    _ExitToolStripMenuItem1.Click += ExitToolStripMenuItem1_Click;
                }
            }
        }

        internal Label lblVer;
        internal ToolStripStatusLabel tsTimeToArchive;
        internal ToolStripStatusLabel tsCountDown;
        private CheckBox _ckDeleteAfterArchive;

        internal CheckBox ckDeleteAfterArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDeleteAfterArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDeleteAfterArchive != null)
                {
                    _ckDeleteAfterArchive.CheckedChanged -= ckDeleteAfterArchive_CheckedChanged;
                }

                _ckDeleteAfterArchive = value;
                if (_ckDeleteAfterArchive != null)
                {
                    _ckDeleteAfterArchive.CheckedChanged += ckDeleteAfterArchive_CheckedChanged;
                }
            }
        }

        private Button _btnCountFiles;

        internal Button btnCountFiles
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnCountFiles;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnCountFiles != null)
                {
                    _btnCountFiles.Click -= btnCountFiles_Click;
                }

                _btnCountFiles = value;
                if (_btnCountFiles != null)
                {
                    _btnCountFiles.Click += btnCountFiles_Click;
                }
            }
        }

        private ToolStripMenuItem _AppConfigVersionToolStripMenuItem;

        internal ToolStripMenuItem AppConfigVersionToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _AppConfigVersionToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_AppConfigVersionToolStripMenuItem != null)
                {
                    _AppConfigVersionToolStripMenuItem.Click -= AppConfigVersionToolStripMenuItem_Click;
                }

                _AppConfigVersionToolStripMenuItem = value;
                if (_AppConfigVersionToolStripMenuItem != null)
                {
                    _AppConfigVersionToolStripMenuItem.Click += AppConfigVersionToolStripMenuItem_Click;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _BackgroundWorkerContacts;

        internal System.ComponentModel.BackgroundWorker BackgroundWorkerContacts
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _BackgroundWorkerContacts;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_BackgroundWorkerContacts != null)
                {
                    _BackgroundWorkerContacts.DoWork -= BackgroundWorkerContacts_DoWork;
                }

                _BackgroundWorkerContacts = value;
                if (_BackgroundWorkerContacts != null)
                {
                    _BackgroundWorkerContacts.DoWork += BackgroundWorkerContacts_DoWork;
                }
            }
        }

        private ToolStripMenuItem _ToolStripMenuItem1;

        internal ToolStripMenuItem ToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ToolStripMenuItem1 != null)
                {
                    _ToolStripMenuItem1.Click -= ToolStripMenuItem1_Click;
                }

                _ToolStripMenuItem1 = value;
                if (_ToolStripMenuItem1 != null)
                {
                    _ToolStripMenuItem1.Click += ToolStripMenuItem1_Click;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _asyncBatchOcrALL;

        internal System.ComponentModel.BackgroundWorker asyncBatchOcrALL
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _asyncBatchOcrALL;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_asyncBatchOcrALL != null)
                {
                    _asyncBatchOcrALL.DoWork -= asyncBatchOcrALL_DoWork;
                }

                _asyncBatchOcrALL = value;
                if (_asyncBatchOcrALL != null)
                {
                    _asyncBatchOcrALL.DoWork += asyncBatchOcrALL_DoWork;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _asyncBatchOcrPending;

        internal System.ComponentModel.BackgroundWorker asyncBatchOcrPending
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _asyncBatchOcrPending;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_asyncBatchOcrPending != null)
                {
                    _asyncBatchOcrPending.DoWork -= asyncBatchOcrPending_DoWork;
                }

                _asyncBatchOcrPending = value;
                if (_asyncBatchOcrPending != null)
                {
                    _asyncBatchOcrPending.DoWork += asyncBatchOcrPending_DoWork;
                }
            }
        }

        internal ToolStripMenuItem ReOCRToolStripMenuItem;
        private ToolStripMenuItem _ReOcrIncompleteGraphicFilesToolStripMenuItem;

        internal ToolStripMenuItem ReOcrIncompleteGraphicFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ReOcrIncompleteGraphicFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ReOcrIncompleteGraphicFilesToolStripMenuItem != null)
                {
                    _ReOcrIncompleteGraphicFilesToolStripMenuItem.Click -= ReOcrIncompleteGraphicFilesToolStripMenuItem_Click;
                }

                _ReOcrIncompleteGraphicFilesToolStripMenuItem = value;
                if (_ReOcrIncompleteGraphicFilesToolStripMenuItem != null)
                {
                    _ReOcrIncompleteGraphicFilesToolStripMenuItem.Click += ReOcrIncompleteGraphicFilesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ReOcrALLGraphicFilesToolStripMenuItem1;

        internal ToolStripMenuItem ReOcrALLGraphicFilesToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ReOcrALLGraphicFilesToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ReOcrALLGraphicFilesToolStripMenuItem1 != null)
                {
                    _ReOcrALLGraphicFilesToolStripMenuItem1.Click -= ReOcrALLGraphicFilesToolStripMenuItem1_Click;
                }

                _ReOcrALLGraphicFilesToolStripMenuItem1 = value;
                if (_ReOcrALLGraphicFilesToolStripMenuItem1 != null)
                {
                    _ReOcrALLGraphicFilesToolStripMenuItem1.Click += ReOcrALLGraphicFilesToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _EstimateNumberOfFilesToolStripMenuItem;

        internal ToolStripMenuItem EstimateNumberOfFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _EstimateNumberOfFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_EstimateNumberOfFilesToolStripMenuItem != null)
                {
                    _EstimateNumberOfFilesToolStripMenuItem.Click -= EstimateNumberOfFilesToolStripMenuItem_Click;
                }

                _EstimateNumberOfFilesToolStripMenuItem = value;
                if (_EstimateNumberOfFilesToolStripMenuItem != null)
                {
                    _EstimateNumberOfFilesToolStripMenuItem.Click += EstimateNumberOfFilesToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripSeparator ToolStripSeparator3;
        internal Label Label16;
        private ToolStripMenuItem _RSSPullToolStripMenuItem;

        internal ToolStripMenuItem RSSPullToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RSSPullToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RSSPullToolStripMenuItem != null)
                {
                    _RSSPullToolStripMenuItem.Click -= RSSPullToolStripMenuItem_Click;
                }

                _RSSPullToolStripMenuItem = value;
                if (_RSSPullToolStripMenuItem != null)
                {
                    _RSSPullToolStripMenuItem.Click += RSSPullToolStripMenuItem_Click;
                }
            }
        }

        internal TabPage TabPage4;
        private Button _btnRemoveRSSfeed;

        internal Button btnRemoveRSSfeed
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveRSSfeed;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveRSSfeed != null)
                {
                    _btnRemoveRSSfeed.Click -= btnRemoveRSSfeed_Click;
                }

                _btnRemoveRSSfeed = value;
                if (_btnRemoveRSSfeed != null)
                {
                    _btnRemoveRSSfeed.Click += btnRemoveRSSfeed_Click;
                }
            }
        }

        private Button _btnAddRssFeed;

        internal Button btnAddRssFeed
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAddRssFeed;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAddRssFeed != null)
                {
                    _btnAddRssFeed.Click -= btnAddRssFeed_Click;
                }

                _btnAddRssFeed = value;
                if (_btnAddRssFeed != null)
                {
                    _btnAddRssFeed.Click += btnAddRssFeed_Click;
                }
            }
        }

        internal TextBox txtRssURL;
        internal Label Label22;
        internal TextBox txtRssName;
        internal Label Label21;
        internal Label Label20;
        internal Label Label17;
        internal TabPage TabPage5;
        private Button _btnRemoveWebPage;

        internal Button btnRemoveWebPage
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveWebPage;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveWebPage != null)
                {
                    _btnRemoveWebPage.Click -= btnRemoveWebPage_Click;
                }

                _btnRemoveWebPage = value;
                if (_btnRemoveWebPage != null)
                {
                    _btnRemoveWebPage.Click += btnRemoveWebPage_Click;
                }
            }
        }

        private Button _btnSaveWebPage;

        internal Button btnSaveWebPage
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveWebPage;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveWebPage != null)
                {
                    _btnSaveWebPage.Click -= btnSaveWebPage_Click;
                }

                _btnSaveWebPage = value;
                if (_btnSaveWebPage != null)
                {
                    _btnSaveWebPage.Click += btnSaveWebPage_Click;
                }
            }
        }

        internal TextBox txtWebScreenUrl;
        internal Label Label23;
        internal TextBox txtWebScreenName;
        internal Label Label24;
        private DataGridView _dgWebPage;

        internal DataGridView dgWebPage
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgWebPage;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgWebPage != null)
                {
                    _dgWebPage.SelectionChanged -= dgWebPage_SelectionChanged;
                }

                _dgWebPage = value;
                if (_dgWebPage != null)
                {
                    _dgWebPage.SelectionChanged += dgWebPage_SelectionChanged;
                }
            }
        }

        internal Label Label25;
        internal Label Label18;
        internal TabPage TabPage6;
        private Button _btnRemoveWebSite;

        internal Button btnRemoveWebSite
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveWebSite;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveWebSite != null)
                {
                    _btnRemoveWebSite.Click -= btnRemoveWebSite_Click;
                }

                _btnRemoveWebSite = value;
                if (_btnRemoveWebSite != null)
                {
                    _btnRemoveWebSite.Click += btnRemoveWebSite_Click;
                }
            }
        }

        private Button _btnSaveWebSite;

        internal Button btnSaveWebSite
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveWebSite;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveWebSite != null)
                {
                    _btnSaveWebSite.Click -= btnSaveWebSite_Click;
                }

                _btnSaveWebSite = value;
                if (_btnSaveWebSite != null)
                {
                    _btnSaveWebSite.Click += btnSaveWebSite_Click;
                }
            }
        }

        internal TextBox txtWebSiteURL;
        internal Label Label26;
        internal TextBox txtWebSiteName;
        internal Label Label27;
        private DataGridView _dgWebSite;

        internal DataGridView dgWebSite
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgWebSite;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgWebSite != null)
                {
                    _dgWebSite.SelectionChanged -= dgWebSite_SelectionChanged;
                }

                _dgWebSite = value;
                if (_dgWebSite != null)
                {
                    _dgWebSite.SelectionChanged += dgWebSite_SelectionChanged;
                }
            }
        }

        internal Label Label28;
        internal Label Label19;
        private LinkLabel _hlExchange;

        internal LinkLabel hlExchange
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _hlExchange;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_hlExchange != null)
                {
                    _hlExchange.LinkClicked -= hlExchange_LinkClicked;
                }

                _hlExchange = value;
                if (_hlExchange != null)
                {
                    _hlExchange.LinkClicked += hlExchange_LinkClicked;
                }
            }
        }

        private LinkLabel _LinkLabel1;

        internal LinkLabel LinkLabel1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _LinkLabel1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_LinkLabel1 != null)
                {
                    _LinkLabel1.LinkClicked -= LinkLabel1_LinkClicked;
                }

                _LinkLabel1 = value;
                if (_LinkLabel1 != null)
                {
                    _LinkLabel1.LinkClicked += LinkLabel1_LinkClicked;
                }
            }
        }

        internal LinkLabel LinkLabel2;
        internal NumericUpDown nbrOutboundLinks;
        internal NumericUpDown nbrDepth;
        internal Label Label30;
        internal Label Label29;
        private System.ComponentModel.BackgroundWorker _asyncVerifyRetainDates;

        internal System.ComponentModel.BackgroundWorker asyncVerifyRetainDates
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _asyncVerifyRetainDates;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_asyncVerifyRetainDates != null)
                {
                    _asyncVerifyRetainDates.DoWork -= asyncVerifyRetainDates_DoWork;
                }

                _asyncVerifyRetainDates = value;
                if (_asyncVerifyRetainDates != null)
                {
                    _asyncVerifyRetainDates.DoWork += asyncVerifyRetainDates_DoWork;
                }
            }
        }

        private ToolStripMenuItem _OnlineHelpToolStripMenuItem;

        internal ToolStripMenuItem OnlineHelpToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _OnlineHelpToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_OnlineHelpToolStripMenuItem != null)
                {
                    _OnlineHelpToolStripMenuItem.Click -= OnlineHelpToolStripMenuItem_Click;
                }

                _OnlineHelpToolStripMenuItem = value;
                if (_OnlineHelpToolStripMenuItem != null)
                {
                    _OnlineHelpToolStripMenuItem.Click += OnlineHelpToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripSeparator ToolStripSeparator4;
        internal CheckBox CheckBox1;
        private CheckBox _ckRunOnStart;

        internal CheckBox ckRunOnStart
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckRunOnStart;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckRunOnStart != null)
                {
                    _ckRunOnStart.CheckedChanged -= ckRunOnStart_CheckedChanged;
                }

                _ckRunOnStart = value;
                if (_ckRunOnStart != null)
                {
                    _ckRunOnStart.CheckedChanged += ckRunOnStart_CheckedChanged;
                }
            }
        }

        internal ToolStripMenuItem LoginToolStripMenuItem;
        private ToolStripMenuItem _LoginToSystemToolStripMenuItem;

        internal ToolStripMenuItem LoginToSystemToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _LoginToSystemToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_LoginToSystemToolStripMenuItem != null)
                {
                    _LoginToSystemToolStripMenuItem.Click -= LoginToSystemToolStripMenuItem_Click;
                }

                _LoginToSystemToolStripMenuItem = value;
                if (_LoginToSystemToolStripMenuItem != null)
                {
                    _LoginToSystemToolStripMenuItem.Click += LoginToSystemToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ChangeUserPasswordToolStripMenuItem;

        internal ToolStripMenuItem ChangeUserPasswordToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ChangeUserPasswordToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ChangeUserPasswordToolStripMenuItem != null)
                {
                    _ChangeUserPasswordToolStripMenuItem.Click -= ChangeUserPasswordToolStripMenuItem_Click;
                }

                _ChangeUserPasswordToolStripMenuItem = value;
                if (_ChangeUserPasswordToolStripMenuItem != null)
                {
                    _ChangeUserPasswordToolStripMenuItem.Click += ChangeUserPasswordToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripSeparator ToolStripSeparator6;
        private ToolStripMenuItem _WebSitesToolStripMenuItem;

        internal ToolStripMenuItem WebSitesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _WebSitesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_WebSitesToolStripMenuItem != null)
                {
                    _WebSitesToolStripMenuItem.Click -= WebSitesToolStripMenuItem_Click;
                }

                _WebSitesToolStripMenuItem = value;
                if (_WebSitesToolStripMenuItem != null)
                {
                    _WebSitesToolStripMenuItem.Click += WebSitesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _WebPagesToolStripMenuItem;

        internal ToolStripMenuItem WebPagesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _WebPagesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_WebPagesToolStripMenuItem != null)
                {
                    _WebPagesToolStripMenuItem.Click -= WebPagesToolStripMenuItem_Click;
                }

                _WebPagesToolStripMenuItem = value;
                if (_WebPagesToolStripMenuItem != null)
                {
                    _WebPagesToolStripMenuItem.Click += WebPagesToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripSeparator ToolStripSeparator5;
        private ToolStripMenuItem _ArchiveRSSPullsToolStripMenuItem;

        internal ToolStripMenuItem ArchiveRSSPullsToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ArchiveRSSPullsToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ArchiveRSSPullsToolStripMenuItem != null)
                {
                    _ArchiveRSSPullsToolStripMenuItem.Click -= ArchiveRSSPullsToolStripMenuItem_Click;
                }

                _ArchiveRSSPullsToolStripMenuItem = value;
                if (_ArchiveRSSPullsToolStripMenuItem != null)
                {
                    _ArchiveRSSPullsToolStripMenuItem.Click += ArchiveRSSPullsToolStripMenuItem_Click;
                }
            }
        }

        internal CheckBox ckWebSiteTrackerDisabled;
        internal CheckBox ckWebPageTrackerDisabled;
        internal CheckBox ckRssPullDisabled;
        internal PictureBox PictureBox2;
        private DataGridView _dgRss;

        internal DataGridView dgRss
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgRss;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgRss != null)
                {
                    _dgRss.SelectionChanged -= dgRss_SelectionChanged;
                }

                _dgRss = value;
                if (_dgRss != null)
                {
                    _dgRss.SelectionChanged += dgRss_SelectionChanged;
                }
            }
        }

        internal ComboBox cbRssRetention;
        internal Label Label31;
        internal ComboBox cbWebPageRetention;
        internal Label Label32;
        internal ComboBox cbWebSiteRetention;
        internal Label Label33;
        private System.ComponentModel.BackgroundWorker _asyncRssPull;

        internal System.ComponentModel.BackgroundWorker asyncRssPull
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _asyncRssPull;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_asyncRssPull != null)
                {
                    _asyncRssPull.DoWork -= AsyncRssPull_DoWork;
                }

                _asyncRssPull = value;
                if (_asyncRssPull != null)
                {
                    _asyncRssPull.DoWork += AsyncRssPull_DoWork;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _asyncSpiderWebSite;

        internal System.ComponentModel.BackgroundWorker asyncSpiderWebSite
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _asyncSpiderWebSite;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_asyncSpiderWebSite != null)
                {
                    _asyncSpiderWebSite.DoWork -= asyncSpiderWebSite_DoWork;
                }

                _asyncSpiderWebSite = value;
                if (_asyncSpiderWebSite != null)
                {
                    _asyncSpiderWebSite.DoWork += asyncSpiderWebSite_DoWork;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _asyncSpiderWebPage;

        internal System.ComponentModel.BackgroundWorker asyncSpiderWebPage
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _asyncSpiderWebPage;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_asyncSpiderWebPage != null)
                {
                    _asyncSpiderWebPage.DoWork -= AsyncSpiderWebPage_DoWork;
                }

                _asyncSpiderWebPage = value;
                if (_asyncSpiderWebPage != null)
                {
                    _asyncSpiderWebPage.DoWork += AsyncSpiderWebPage_DoWork;
                }
            }
        }

        internal ToolStripMenuItem RetentionManagementToolStripMenuItem;
        private ToolStripMenuItem _RetentionRulesToolStripMenuItem;

        internal ToolStripMenuItem RetentionRulesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RetentionRulesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RetentionRulesToolStripMenuItem != null)
                {
                    _RetentionRulesToolStripMenuItem.Click -= RetentionRulesToolStripMenuItem_Click;
                }

                _RetentionRulesToolStripMenuItem = value;
                if (_RetentionRulesToolStripMenuItem != null)
                {
                    _RetentionRulesToolStripMenuItem.Click += RetentionRulesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _RulesExecutionToolStripMenuItem;

        internal ToolStripMenuItem RulesExecutionToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RulesExecutionToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RulesExecutionToolStripMenuItem != null)
                {
                    _RulesExecutionToolStripMenuItem.Click -= RulesExecutionToolStripMenuItem_Click;
                }

                _RulesExecutionToolStripMenuItem = value;
                if (_RulesExecutionToolStripMenuItem != null)
                {
                    _RulesExecutionToolStripMenuItem.Click += RulesExecutionToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _CheckForUpdatesToolStripMenuItem;

        internal ToolStripMenuItem CheckForUpdatesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckForUpdatesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckForUpdatesToolStripMenuItem != null)
                {
                    _CheckForUpdatesToolStripMenuItem.Click -= CheckForUpdatesToolStripMenuItem_Click;
                }

                _CheckForUpdatesToolStripMenuItem = value;
                if (_CheckForUpdatesToolStripMenuItem != null)
                {
                    _CheckForUpdatesToolStripMenuItem.Click += CheckForUpdatesToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripMenuItem ShowEndpointsToolStripMenuItem;
        private ToolStripMenuItem _ShowSystemVersionToolStripMenuItem;

        internal ToolStripMenuItem ShowSystemVersionToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ShowSystemVersionToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ShowSystemVersionToolStripMenuItem != null)
                {
                    _ShowSystemVersionToolStripMenuItem.Click -= ShowSystemVersionToolStripMenuItem_Click;
                }

                _ShowSystemVersionToolStripMenuItem = value;
                if (_ShowSystemVersionToolStripMenuItem != null)
                {
                    _ShowSystemVersionToolStripMenuItem.Click += ShowSystemVersionToolStripMenuItem_Click;
                }
            }
        }

        internal Label Label34;
        internal Label Label36;
        internal Label Label35;
        internal ToolStripSeparator ToolStripSeparator7;
        private ToolStripMenuItem _SelectedFilesToolStripMenuItem;

        internal ToolStripMenuItem SelectedFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SelectedFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SelectedFilesToolStripMenuItem != null)
                {
                    _SelectedFilesToolStripMenuItem.Click -= SelectedFilesToolStripMenuItem_Click;
                }

                _SelectedFilesToolStripMenuItem = value;
                if (_SelectedFilesToolStripMenuItem != null)
                {
                    _SelectedFilesToolStripMenuItem.Click += SelectedFilesToolStripMenuItem_Click;
                }
            }
        }

        internal Label Label37;
        internal Label lblCustomerName;
        internal Label lblCustomerID;
        internal Label Label39;
        private Button _btnArchive1Doc;

        internal Button btnArchive1Doc
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnArchive1Doc;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnArchive1Doc != null)
                {
                    _btnArchive1Doc.Click -= btnArchive1Doc_Click;
                }

                _btnArchive1Doc = value;
                if (_btnArchive1Doc != null)
                {
                    _btnArchive1Doc.Click += btnArchive1Doc_Click;
                }
            }
        }

        private ToolStripMenuItem _OpenLicenseFormToolStripMenuItem;

        internal ToolStripMenuItem OpenLicenseFormToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _OpenLicenseFormToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_OpenLicenseFormToolStripMenuItem != null)
                {
                    _OpenLicenseFormToolStripMenuItem.Click -= OpenLicenseFormToolStripMenuItem_Click;
                }

                _OpenLicenseFormToolStripMenuItem = value;
                if (_OpenLicenseFormToolStripMenuItem != null)
                {
                    _OpenLicenseFormToolStripMenuItem.Click += OpenLicenseFormToolStripMenuItem_Click;
                }
            }
        }

        private Button _Button4;

        internal Button Button4
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button4;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button4 != null)
                {
                    _Button4.Click -= Button4_Click;
                }

                _Button4 = value;
                if (_Button4 != null)
                {
                    _Button4.Click += Button4_Click;
                }
            }
        }

        private Timer _TimerAutoExec;

        internal Timer TimerAutoExec
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _TimerAutoExec;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_TimerAutoExec != null)
                {
                    _TimerAutoExec.Tick -= TimerAutoExec_Tick;
                }

                _TimerAutoExec = value;
                if (_TimerAutoExec != null)
                {
                    _TimerAutoExec.Tick += TimerAutoExec_Tick;
                }
            }
        }

        private ToolStripMenuItem _UnhandledExceptionsToolStripMenuItem;

        internal ToolStripMenuItem UnhandledExceptionsToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _UnhandledExceptionsToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_UnhandledExceptionsToolStripMenuItem != null)
                {
                    _UnhandledExceptionsToolStripMenuItem.Click -= UnhandledExceptionsToolStripMenuItem_Click;
                }

                _UnhandledExceptionsToolStripMenuItem = value;
                if (_UnhandledExceptionsToolStripMenuItem != null)
                {
                    _UnhandledExceptionsToolStripMenuItem.Click += UnhandledExceptionsToolStripMenuItem_Click;
                }
            }
        }

        internal Label lblNotice;
        internal ToolStripMenuItem ListenerFunctionsToolStripMenuItem;
        private ToolStripMenuItem _GetListenerFilesToolStripMenuItem;

        internal ToolStripMenuItem GetListenerFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _GetListenerFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_GetListenerFilesToolStripMenuItem != null)
                {
                    _GetListenerFilesToolStripMenuItem.Click -= GetListenerFilesToolStripMenuItem_Click;
                }

                _GetListenerFilesToolStripMenuItem = value;
                if (_GetListenerFilesToolStripMenuItem != null)
                {
                    _GetListenerFilesToolStripMenuItem.Click += GetListenerFilesToolStripMenuItem_Click;
                }
            }
        }

        private System.ComponentModel.BackgroundWorker _ThreadValidateSourceName;

        internal System.ComponentModel.BackgroundWorker ThreadValidateSourceName
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ThreadValidateSourceName;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ThreadValidateSourceName != null)
                {
                    _ThreadValidateSourceName.DoWork -= ThreadValidateSourceName_DoWork_1;
                }

                _ThreadValidateSourceName = value;
                if (_ThreadValidateSourceName != null)
                {
                    _ThreadValidateSourceName.DoWork += ThreadValidateSourceName_DoWork_1;
                }
            }
        }

        internal ToolStripMenuItem RepositoryUtilitiesToolStripMenuItem;
        internal ToolStripMenuItem CleanupSourceNameToolStripMenuItem;
        internal ToolStripMenuItem ListenerUtilitiesToolStripMenuItem;
        private ToolStripMenuItem _LIstWindowsLogsToolStripMenuItem;

        internal ToolStripMenuItem LIstWindowsLogsToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _LIstWindowsLogsToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_LIstWindowsLogsToolStripMenuItem != null)
                {
                    _LIstWindowsLogsToolStripMenuItem.Click -= LIstWindowsLogsToolStripMenuItem_Click;
                }

                _LIstWindowsLogsToolStripMenuItem = value;
                if (_LIstWindowsLogsToolStripMenuItem != null)
                {
                    _LIstWindowsLogsToolStripMenuItem.Click += LIstWindowsLogsToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _CheckLogsForListenerInfoToolStripMenuItem;

        internal ToolStripMenuItem CheckLogsForListenerInfoToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckLogsForListenerInfoToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckLogsForListenerInfoToolStripMenuItem != null)
                {
                    _CheckLogsForListenerInfoToolStripMenuItem.Click -= CheckLogsForListenerInfoToolStripMenuItem_Click;
                }

                _CheckLogsForListenerInfoToolStripMenuItem = value;
                if (_CheckLogsForListenerInfoToolStripMenuItem != null)
                {
                    _CheckLogsForListenerInfoToolStripMenuItem.Click += CheckLogsForListenerInfoToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripMenuItem SQLiteUtiltiiesToolStripMenuItem;
        private ToolStripMenuItem _ResetSQLiteArchivesToolStripMenuItem;

        internal ToolStripMenuItem ResetSQLiteArchivesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ResetSQLiteArchivesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ResetSQLiteArchivesToolStripMenuItem != null)
                {
                    _ResetSQLiteArchivesToolStripMenuItem.Click -= ResetSQLiteArchivesToolStripMenuItem_Click;
                }

                _ResetSQLiteArchivesToolStripMenuItem = value;
                if (_ResetSQLiteArchivesToolStripMenuItem != null)
                {
                    _ResetSQLiteArchivesToolStripMenuItem.Click += ResetSQLiteArchivesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _GetOutlookEMailIDsToolStripMenuItem1;

        internal ToolStripMenuItem GetOutlookEMailIDsToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _GetOutlookEMailIDsToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_GetOutlookEMailIDsToolStripMenuItem1 != null)
                {
                    _GetOutlookEMailIDsToolStripMenuItem1.Click -= GetOutlookEMailIDsToolStripMenuItem1_Click;
                }

                _GetOutlookEMailIDsToolStripMenuItem1 = value;
                if (_GetOutlookEMailIDsToolStripMenuItem1 != null)
                {
                    _GetOutlookEMailIDsToolStripMenuItem1.Click += GetOutlookEMailIDsToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _ResetZIPFilesToolStripMenuItem;

        internal ToolStripMenuItem ResetZIPFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ResetZIPFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ResetZIPFilesToolStripMenuItem != null)
                {
                    _ResetZIPFilesToolStripMenuItem.Click -= ResetZIPFilesToolStripMenuItem_Click;
                }

                _ResetZIPFilesToolStripMenuItem = value;
                if (_ResetZIPFilesToolStripMenuItem != null)
                {
                    _ResetZIPFilesToolStripMenuItem.Click += ResetZIPFilesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ResetEmailIdentifierCodesToolStripMenuItem;

        internal ToolStripMenuItem ResetEmailIdentifierCodesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ResetEmailIdentifierCodesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ResetEmailIdentifierCodesToolStripMenuItem != null)
                {
                    _ResetEmailIdentifierCodesToolStripMenuItem.Click -= ResetEmailIdentifierCodesToolStripMenuItem_Click;
                }

                _ResetEmailIdentifierCodesToolStripMenuItem = value;
                if (_ResetEmailIdentifierCodesToolStripMenuItem != null)
                {
                    _ResetEmailIdentifierCodesToolStripMenuItem.Click += ResetEmailIdentifierCodesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _RebuildSQLiteDBToolStripMenuItem1;

        internal ToolStripMenuItem RebuildSQLiteDBToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RebuildSQLiteDBToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RebuildSQLiteDBToolStripMenuItem1 != null)
                {
                    _RebuildSQLiteDBToolStripMenuItem1.Click -= RebuildSQLiteDBToolStripMenuItem1_Click;
                }

                _RebuildSQLiteDBToolStripMenuItem1 = value;
                if (_RebuildSQLiteDBToolStripMenuItem1 != null)
                {
                    _RebuildSQLiteDBToolStripMenuItem1.Click += RebuildSQLiteDBToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _BackupSQLiteDBToolStripMenuItem1;

        internal ToolStripMenuItem BackupSQLiteDBToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _BackupSQLiteDBToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_BackupSQLiteDBToolStripMenuItem1 != null)
                {
                    _BackupSQLiteDBToolStripMenuItem1.Click -= BackupSQLiteDBToolStripMenuItem1_Click;
                }

                _BackupSQLiteDBToolStripMenuItem1 = value;
                if (_BackupSQLiteDBToolStripMenuItem1 != null)
                {
                    _BackupSQLiteDBToolStripMenuItem1.Click += BackupSQLiteDBToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _RestoreSQLiteDBToolStripMenuItem1;

        internal ToolStripMenuItem RestoreSQLiteDBToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RestoreSQLiteDBToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RestoreSQLiteDBToolStripMenuItem1 != null)
                {
                    _RestoreSQLiteDBToolStripMenuItem1.Click -= RestoreSQLiteDBToolStripMenuItem1_Click;
                }

                _RestoreSQLiteDBToolStripMenuItem1 = value;
                if (_RestoreSQLiteDBToolStripMenuItem1 != null)
                {
                    _RestoreSQLiteDBToolStripMenuItem1.Click += RestoreSQLiteDBToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _ClearRestoreQueueToolStripMenuItem1;

        internal ToolStripMenuItem ClearRestoreQueueToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ClearRestoreQueueToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ClearRestoreQueueToolStripMenuItem1 != null)
                {
                    _ClearRestoreQueueToolStripMenuItem1.Click -= ClearRestoreQueueToolStripMenuItem1_Click;
                }

                _ClearRestoreQueueToolStripMenuItem1 = value;
                if (_ClearRestoreQueueToolStripMenuItem1 != null)
                {
                    _ClearRestoreQueueToolStripMenuItem1.Click += ClearRestoreQueueToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _SQToolStripMenuItem;

        internal ToolStripMenuItem SQToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SQToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SQToolStripMenuItem != null)
                {
                    _SQToolStripMenuItem.Click -= SQToolStripMenuItem_Click;
                }

                _SQToolStripMenuItem = value;
                if (_SQToolStripMenuItem != null)
                {
                    _SQToolStripMenuItem.Click += SQToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _CompareDirToRepositoryToolStripMenuItem1;

        internal ToolStripMenuItem CompareDirToRepositoryToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CompareDirToRepositoryToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CompareDirToRepositoryToolStripMenuItem1 != null)
                {
                    _CompareDirToRepositoryToolStripMenuItem1.Click -= CompareDirToRepositoryToolStripMenuItem1_Click;
                }

                _CompareDirToRepositoryToolStripMenuItem1 = value;
                if (_CompareDirToRepositoryToolStripMenuItem1 != null)
                {
                    _CompareDirToRepositoryToolStripMenuItem1.Click += CompareDirToRepositoryToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _InventoryDirectoryToolStripMenuItem1;

        internal ToolStripMenuItem InventoryDirectoryToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _InventoryDirectoryToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_InventoryDirectoryToolStripMenuItem1 != null)
                {
                    _InventoryDirectoryToolStripMenuItem1.Click -= InventoryDirectoryToolStripMenuItem1_Click;
                }

                _InventoryDirectoryToolStripMenuItem1 = value;
                if (_InventoryDirectoryToolStripMenuItem1 != null)
                {
                    _InventoryDirectoryToolStripMenuItem1.Click += InventoryDirectoryToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _ValidateDirectoryFilesToolStripMenuItem;

        internal ToolStripMenuItem ValidateDirectoryFilesToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ValidateDirectoryFilesToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ValidateDirectoryFilesToolStripMenuItem != null)
                {
                    _ValidateDirectoryFilesToolStripMenuItem.Click -= ValidateDirectoryFilesToolStripMenuItem_Click;
                }

                _ValidateDirectoryFilesToolStripMenuItem = value;
                if (_ValidateDirectoryFilesToolStripMenuItem != null)
                {
                    _ValidateDirectoryFilesToolStripMenuItem.Click += ValidateDirectoryFilesToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ContentReInventoryToolStripMenuItem;

        internal ToolStripMenuItem ContentReInventoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ContentReInventoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ContentReInventoryToolStripMenuItem != null)
                {
                    _ContentReInventoryToolStripMenuItem.Click -= ContentReInventoryToolStripMenuItem_Click;
                }

                _ContentReInventoryToolStripMenuItem = value;
                if (_ContentReInventoryToolStripMenuItem != null)
                {
                    _ContentReInventoryToolStripMenuItem.Click += ContentReInventoryToolStripMenuItem_Click;
                }
            }
        }
    }
}