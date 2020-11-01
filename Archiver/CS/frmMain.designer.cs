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


namespace EcmArchiveClcSetup
{
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmMain : System.Windows.Forms.Form
	{
		
		//Form overrides dispose to clean up the component list.
		[System.Diagnostics.DebuggerNonUserCode()]protected override void Dispose(bool disposing)
		{
			if (disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}
		
		//Required by the Windows Form Designer
		private System.ComponentModel.Container components = null;
		
		//NOTE: The following procedure is required by the Windows Form Designer
		//It can be modified using the Windows Form Designer.
		//Do not modify it using the code editor.
		[System.Diagnostics.DebuggerStepThrough()]private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			base.Load += new System.EventHandler(frmReconMain_Load);
			this.Resize += new System.EventHandler(frmReconMain_Resize);
			this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(frmReconMain_FormClosing);
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle7 = new System.Windows.Forms.DataGridViewCellStyle();
			this.gbEmail = new System.Windows.Forms.GroupBox();
			this.LinkLabel2 = new System.Windows.Forms.LinkLabel();
			this.LinkLabel1 = new System.Windows.Forms.LinkLabel();
			this.LinkLabel1.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.LinkLabel1_LinkClicked);
			this.hlExchange = new System.Windows.Forms.LinkLabel();
			this.hlExchange.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.hlExchange_LinkClicked);
			this.Label16 = new System.Windows.Forms.Label();
			this.Label3 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.ckExpand = new System.Windows.Forms.CheckBox();
			this.ckExpand.CheckedChanged += new System.EventHandler(this.ckExpand_CheckedChanged);
			this.ckGetSubFolders = new System.Windows.Forms.CheckBox();
			this.ckDoNotShowArchived = new System.Windows.Forms.CheckBox();
			this.cbParentFolders = new System.Windows.Forms.ComboBox();
			this.cbParentFolders.SelectedIndexChanged += new System.EventHandler(this.cbParentFolders_SelectedIndexChanged);
			this.btnSMTP = new System.Windows.Forms.Button();
			this.cbEmailRetention = new System.Windows.Forms.ComboBox();
			this.ckSystemFolder = new System.Windows.Forms.CheckBox();
			this.ckUseLastProcessDateAsCutoff = new System.Windows.Forms.CheckBox();
			this.ckUseLastProcessDateAsCutoff.CheckedChanged += new System.EventHandler(this.ckUseLastProcessDateAsCutoff_CheckedChanged);
			this.ckArchiveRead = new System.Windows.Forms.CheckBox();
			this.btnDeleteEmailEntry = new System.Windows.Forms.Button();
			this.btnDeleteEmailEntry.Click += new System.EventHandler(this.btnDeleteEmailEntry_Click);
			this.btnActive = new System.Windows.Forms.Button();
			this.btnActive.Click += new System.EventHandler(this.btnActive_Click);
			this.cbEmailDB = new System.Windows.Forms.ComboBox();
			this.Label4 = new System.Windows.Forms.Label();
			this.NumericUpDown3 = new System.Windows.Forms.NumericUpDown();
			this.ckRemoveAfterXDays = new System.Windows.Forms.CheckBox();
			this.ckRemoveAfterXDays.CheckedChanged += new System.EventHandler(this.ckRemoveAfterXDays_CheckedChanged);
			this.btnRefreshFolders = new System.Windows.Forms.Button();
			this.btnRefreshFolders.Click += new System.EventHandler(this.btnRefreshFolders_Click);
			this.btnSaveConditions = new System.Windows.Forms.Button();
			this.btnSaveConditions.Click += new System.EventHandler(this.btnSaveConditions_Click);
			this.ckArchiveFolder = new System.Windows.Forms.CheckBox();
			this.lbActiveFolder = new System.Windows.Forms.ListBox();
			this.lbActiveFolder.MouseDown += new System.Windows.Forms.MouseEventHandler(this.lbActiveFolder_MouseDown);
			this.lbActiveFolder.SelectedIndexChanged += new System.EventHandler(this.ListBox1_SelectedIndexChanged);
			this.lblVer = new System.Windows.Forms.Label();
			this.SB = new System.Windows.Forms.TextBox();
			this.gbFiletypes = new System.Windows.Forms.GroupBox();
			this.cbProcessAsList = new System.Windows.Forms.ComboBox();
			this.Button2 = new System.Windows.Forms.Button();
			this.Button2.Click += new System.EventHandler(this.Button2_Click);
			this.Button1 = new System.Windows.Forms.Button();
			this.Button1.Click += new System.EventHandler(this.Button1_Click);
			this.Label10 = new System.Windows.Forms.Label();
			this.Label9 = new System.Windows.Forms.Label();
			this.cbAsType = new System.Windows.Forms.ComboBox();
			this.cbPocessType = new System.Windows.Forms.ComboBox();
			this.ckRemoveFileType = new System.Windows.Forms.Button();
			this.ckRemoveFileType.Click += new System.EventHandler(this.ckRemoveAfterDays_Click);
			this.cbFileTypes = new System.Windows.Forms.ComboBox();
			this.btnAddFiletype = new System.Windows.Forms.Button();
			this.btnAddFiletype.Click += new System.EventHandler(this.btnAddFiletype_Click);
			this.gbPolling = new System.Windows.Forms.GroupBox();
			this.gbPolling.MouseHover += new System.EventHandler(this.gbPolling_MouseHover);
			this.ckWebSiteTrackerDisabled = new System.Windows.Forms.CheckBox();
			this.ckWebPageTrackerDisabled = new System.Windows.Forms.CheckBox();
			this.ckRssPullDisabled = new System.Windows.Forms.CheckBox();
			this.ckRunOnStart = new System.Windows.Forms.CheckBox();
			this.ckRunOnStart.CheckedChanged += new System.EventHandler(this.ckRunOnStart_CheckedChanged);
			this.btnArchiveNow = new System.Windows.Forms.Button();
			this.btnArchiveNow.Click += new System.EventHandler(this.btnArchiveNow_Click);
			this.Label1 = new System.Windows.Forms.Label();
			this.nbrArchiveHours = new System.Windows.Forms.NumericUpDown();
			this.nbrArchiveHours.ValueChanged += new System.EventHandler(this.NumericUpDown1_ValueChanged);
			this.ckRunUnattended = new System.Windows.Forms.CheckBox();
			this.ckRunUnattended.CheckedChanged += new System.EventHandler(this.ckRunUnattended_CheckedChanged);
			this.ckDisableExchange = new System.Windows.Forms.CheckBox();
			this.ckDisableExchange.CheckedChanged += new System.EventHandler(this.ckDisableExchange_CheckedChanged);
			this.ckDisableOutlookEmailArchive = new System.Windows.Forms.CheckBox();
			this.ckDisableOutlookEmailArchive.CheckedChanged += new System.EventHandler(this.ckDisableOutlookEmailArchive_CheckedChanged);
			this.ckDisableContentArchive = new System.Windows.Forms.CheckBox();
			this.ckDisableContentArchive.CheckedChanged += new System.EventHandler(this.ckDisableContentArchive_CheckedChanged);
			this.btnSaveSchedule = new System.Windows.Forms.Button();
			this.btnSaveSchedule.Click += new System.EventHandler(this.btnSaveSchedule_Click);
			this.ckDisable = new System.Windows.Forms.CheckBox();
			this.ckDisable.CheckedChanged += new System.EventHandler(this.ckDisable_CheckedChanged);
			this.PictureBox2 = new System.Windows.Forms.PictureBox();
			this.gbContentMgt = new System.Windows.Forms.GroupBox();
			this.gbContentMgt.Enter += new System.EventHandler(this.GroupBox2_Enter);
			this.btnCountFiles = new System.Windows.Forms.Button();
			this.btnCountFiles.Click += new System.EventHandler(this.btnCountFiles_Click);
			this.Panel2 = new System.Windows.Forms.Panel();
			this.ckDeleteAfterArchive = new System.Windows.Forms.CheckBox();
			this.ckDeleteAfterArchive.CheckedChanged += new System.EventHandler(this.ckDeleteAfterArchive_CheckedChanged);
			this.ckOcrPdf = new System.Windows.Forms.CheckBox();
			this.ckOcrPdf.CheckedChanged += new System.EventHandler(this.ckOcrPdf_CheckedChanged);
			this.ckShowLibs = new System.Windows.Forms.CheckBox();
			this.ckShowLibs.CheckedChanged += new System.EventHandler(this.ckShowLibs_CheckedChanged);
			this.btnRefreshRetent = new System.Windows.Forms.Button();
			this.btnRefreshRetent.Click += new System.EventHandler(this.btnRefreshRetent_Click);
			this.CkMonitor = new System.Windows.Forms.CheckBox();
			this.CkMonitor.CheckedChanged += new System.EventHandler(this.CkMonitor_CheckedChanged);
			this.ckArchiveBit = new System.Windows.Forms.CheckBox();
			this.ckArchiveBit.CheckedChanged += new System.EventHandler(this.ckArchiveBit_CheckedChanged);
			this.Label13 = new System.Windows.Forms.Label();
			this.cbRetention = new System.Windows.Forms.ComboBox();
			this.ckOcr = new System.Windows.Forms.CheckBox();
			this.ckOcr.CheckedChanged += new System.EventHandler(this.ckOcr_CheckedChanged);
			this.clAdminDir = new System.Windows.Forms.CheckBox();
			this.clAdminDir.CheckedChanged += new System.EventHandler(this.clAdminDir_CheckedChanged);
			this.ckDisableDir = new System.Windows.Forms.CheckBox();
			this.ckDisableDir.CheckedChanged += new System.EventHandler(this.ckDisableDir_CheckedChanged);
			this.ckPublic = new System.Windows.Forms.CheckBox();
			this.ckPublic.CheckedChanged += new System.EventHandler(this.ckPublic_CheckedChanged);
			this.ckMetaData = new System.Windows.Forms.CheckBox();
			this.ckMetaData.CheckedChanged += new System.EventHandler(this.ckMetaData_CheckedChanged);
			this.ckVersionFiles = new System.Windows.Forms.CheckBox();
			this.ckVersionFiles.CheckedChanged += new System.EventHandler(this.ckVersionFiles_CheckedChanged);
			this.ckSubDirs = new System.Windows.Forms.CheckBox();
			this.ckSubDirs.CheckedChanged += new System.EventHandler(this.ckSubDirs_CheckedChanged);
			this.txtDir = new System.Windows.Forms.TextBox();
			this.txtDir.TextChanged += new System.EventHandler(this.txtDir_TextChanged);
			this.btnRefresh = new System.Windows.Forms.Button();
			this.btnRefresh.Click += new System.EventHandler(this.Button5_Click);
			this.btnSaveChanges = new System.Windows.Forms.Button();
			this.btnSaveChanges.Click += new System.EventHandler(this.Button6_Click);
			this.btnRemoveDir = new System.Windows.Forms.Button();
			this.btnRemoveDir.Click += new System.EventHandler(this.btnRemoveDir_Click);
			this.btnSelDir = new System.Windows.Forms.Button();
			this.btnSelDir.Click += new System.EventHandler(this.btnSelDir_Click);
			this.lbArchiveDirs = new System.Windows.Forms.ListBox();
			this.lbArchiveDirs.MouseDown += new System.Windows.Forms.MouseEventHandler(this.lbArchiveDirs_MouseDown);
			this.lbArchiveDirs.SelectedIndexChanged += new System.EventHandler(this.ListBox2_SelectedIndexChanged);
			this.Panel1 = new System.Windows.Forms.Panel();
			this.Label7 = new System.Windows.Forms.Label();
			this.lbExcludeExts = new System.Windows.Forms.ListBox();
			this.lbExcludeExts.TextChanged += new System.EventHandler(this.lbExcludeExts_TextChanged);
			this.lbExcludeExts.SelectedIndexChanged += new System.EventHandler(this.lbExcludeExts_SelectedIndexChanged);
			this.Label6 = new System.Windows.Forms.Label();
			this.Label5 = new System.Windows.Forms.Label();
			this.lbAvailExts = new System.Windows.Forms.ListBox();
			this.lbAvailExts.SelectedIndexChanged += new System.EventHandler(this.lbAvailExts_SelectedIndexChanged);
			this.lbIncludeExts = new System.Windows.Forms.ListBox();
			this.lbIncludeExts.SelectedIndexChanged += new System.EventHandler(this.lbIncludeExts_SelectedIndexChanged);
			this.Button3 = new System.Windows.Forms.Button();
			this.Button3.Click += new System.EventHandler(this.Button3_Click);
			this.btnRemoveExclude = new System.Windows.Forms.Button();
			this.btnRemoveExclude.Click += new System.EventHandler(this.btnRemoveExclude_Click);
			this.btnInclFileType = new System.Windows.Forms.Button();
			this.btnInclFileType.Click += new System.EventHandler(this.btnInclFileType_Click);
			this.btnExclude = new System.Windows.Forms.Button();
			this.btnExclude.Click += new System.EventHandler(this.btnExclude_Click);
			this.Panel3 = new System.Windows.Forms.Panel();
			this.btnAddDefaults = new System.Windows.Forms.Button();
			this.btnAddDefaults.Click += new System.EventHandler(this.btnAddDefaults_Click);
			this.btnRefreshRebuild = new System.Windows.Forms.Button();
			this.btnRefreshRebuild.Click += new System.EventHandler(this.btnRefreshRebuild_Click);
			this.Label12 = new System.Windows.Forms.Label();
			this.btnDeleteDirProfile = new System.Windows.Forms.Button();
			this.btnDeleteDirProfile.Click += new System.EventHandler(this.btnDeleteDirProfile_Click);
			this.btnUpdateDirectoryProfile = new System.Windows.Forms.Button();
			this.btnUpdateDirectoryProfile.Click += new System.EventHandler(this.btnUpdateDirectoryProfile_Click);
			this.btnSaveDirProfile = new System.Windows.Forms.Button();
			this.btnSaveDirProfile.Click += new System.EventHandler(this.btnSaveDirProfile_Click);
			this.btnApplyDirProfile = new System.Windows.Forms.Button();
			this.btnApplyDirProfile.Click += new System.EventHandler(this.btnApplyDirProfile_Click);
			this.cbDirProfile = new System.Windows.Forms.ComboBox();
			this.Label11 = new System.Windows.Forms.Label();
			this.btnExclProfile = new System.Windows.Forms.Button();
			this.btnExclProfile.Click += new System.EventHandler(this.btnExclProfile_Click);
			this.btnInclProfile = new System.Windows.Forms.Button();
			this.btnInclProfile.Click += new System.EventHandler(this.btnInclProfile_Click);
			this.cbProfile = new System.Windows.Forms.ComboBox();
			this.Label8 = new System.Windows.Forms.Label();
			this.Label8.Click += new System.EventHandler(this.Label8_Click);
			this.cbFileDB = new System.Windows.Forms.ComboBox();
			this.cbFileDB.SelectedIndexChanged += new System.EventHandler(this.cbFileDB_SelectedIndexChanged);
			this.btnAddDir = new System.Windows.Forms.Button();
			this.btnAddDir.Click += new System.EventHandler(this.btnAddDir_Click);
			this.PictureBox1 = new System.Windows.Forms.PictureBox();
			this.ckTerminate = new System.Windows.Forms.CheckBox();
			this.ckTerminate.CheckedChanged += new System.EventHandler(this.ckTerminate_CheckedChanged);
			this.FolderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.ckPauseListener = new System.Windows.Forms.CheckBox();
			this.ckPauseListener.CheckedChanged += new System.EventHandler(this.ckPauseListener_CheckedChanged);
			this.btnFetch = new System.Windows.Forms.Button();
			this.btnFetch.Click += new System.EventHandler(this.btnFetch_Click);
			this.txtRssURL = new System.Windows.Forms.TextBox();
			this.txtRssName = new System.Windows.Forms.TextBox();
			this.txtWebScreenUrl = new System.Windows.Forms.TextBox();
			this.txtWebScreenName = new System.Windows.Forms.TextBox();
			this.f1Help = new System.Windows.Forms.HelpProvider();
			this.SB2 = new System.Windows.Forms.TextBox();
			this.PBx = new System.Windows.Forms.ProgressBar();
			this.ContextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
			this.ContextMenuStrip1.Opening += new System.ComponentModel.CancelEventHandler(this.ContextMenuStrip1_Opening);
			this.ResetSelectedMailBoxesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ResetSelectedMailBoxesToolStripMenuItem.Click += new System.EventHandler(this.ResetSelectedMailBoxesToolStripMenuItem_Click);
			this.EmailLibraryReassignmentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.EmailLibraryReassignmentToolStripMenuItem.Click += new System.EventHandler(this.EmailLibraryReassignmentToolStripMenuItem_Click);
			this.TimerListeners = new System.Windows.Forms.Timer(this.components);
			this.TimerListeners.Tick += new System.EventHandler(this.TimerListeners_Tick);
			this.TimerUploadFiles = new System.Windows.Forms.Timer(this.components);
			this.TimerUploadFiles.Tick += new System.EventHandler(this.TimerUploadFiles_Tick);
			this.TimerEndRun = new System.Windows.Forms.Timer(this.components);
			this.TimerEndRun.Tick += new System.EventHandler(this.TimerEndRun_Tick);
			this.MenuStrip1 = new System.Windows.Forms.MenuStrip();
			this.ArchiveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ArchiveALLToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ArchiveALLToolStripMenuItem.Click += new System.EventHandler(this.ArchiveALLToolStripMenuItem_Click);
			this.OutlookEmailsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.OutlookEmailsToolStripMenuItem.Click += new System.EventHandler(this.OutlookEmailsToolStripMenuItem_Click);
			this.ExchangeEmailsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ExchangeEmailsToolStripMenuItem.Click += new System.EventHandler(this.ExchangeEmailsToolStripMenuItem_Click);
			this.ContentToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ContentToolStripMenuItem.Click += new System.EventHandler(this.ContentToolStripMenuItem_Click);
			this.ToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.ToolStripMenuItem1.Click += new System.EventHandler(this.ToolStripMenuItem1_Click);
			this.ScheduleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ScheduleToolStripMenuItem.Click += new System.EventHandler(this.ScheduleToolStripMenuItem_Click);
			this.SetArchiveIntervalToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ToolStripSeparator6 = new System.Windows.Forms.ToolStripSeparator();
			this.ArchiveRSSPullsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ArchiveRSSPullsToolStripMenuItem.Click += new System.EventHandler(this.ArchiveRSSPullsToolStripMenuItem_Click);
			this.WebSitesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.WebSitesToolStripMenuItem.Click += new System.EventHandler(this.WebSitesToolStripMenuItem_Click);
			this.WebPagesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.WebPagesToolStripMenuItem.Click += new System.EventHandler(this.WebPagesToolStripMenuItem_Click);
			this.ToolStripSeparator5 = new System.Windows.Forms.ToolStripSeparator();
			this.ExitToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.ExitToolStripMenuItem1.Click += new System.EventHandler(this.ExitToolStripMenuItem1_Click);
			this.LoginToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.LoginToSystemToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.LoginToSystemToolStripMenuItem.Click += new System.EventHandler(this.LoginToSystemToolStripMenuItem_Click);
			this.ChangeUserPasswordToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ChangeUserPasswordToolStripMenuItem.Click += new System.EventHandler(this.ChangeUserPasswordToolStripMenuItem_Click);
			this.TasksToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ImpersonateLoginToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ImpersonateLoginToolStripMenuItem.Click += new System.EventHandler(this.ImpersonateLoginToolStripMenuItem_Click);
			this.LoginAsDifferenctUserToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.LoginAsDifferenctUserToolStripMenuItem.Click += new System.EventHandler(this.LoginAsDifferenctUserToolStripMenuItem_Click);
			this.ManualEditAppConfigToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ManualEditAppConfigToolStripMenuItem.Click += new System.EventHandler(this.ManualEditAppConfigToolStripMenuItem_Click);
			this.ViewLogsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ViewLogsToolStripMenuItem.Click += new System.EventHandler(this.ViewLogsToolStripMenuItem_Click);
			this.ViewOCRErrorFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ViewOCRErrorFilesToolStripMenuItem.Click += new System.EventHandler(this.ViewOCRErrorFilesToolStripMenuItem_Click);
			this.AddDesktopIconToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.AddDesktopIconToolStripMenuItem.Click += new System.EventHandler(this.AddDesktopIconToolStripMenuItem_Click);
			this.UtilityToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.EncryptStringToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.EncryptStringToolStripMenuItem.Click += new System.EventHandler(this.EncryptStringToolStripMenuItem_Click);
			this.InstallCLCToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.InstallCLCToolStripMenuItem.Click += new System.EventHandler(this.InstallCLCToolStripMenuItem_Click_1);
			this.ResetPerformanceFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.CEDatabasesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.CEDatabasesToolStripMenuItem.Click += new System.EventHandler(this.CEDatabasesToolStripMenuItem_Click);
			this.ZIPFilesArchivesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ZIPFilesArchivesToolStripMenuItem.Click += new System.EventHandler(this.ZIPFilesArchivesToolStripMenuItem_Click);
			this.GetOutlookEmailIDsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.GetOutlookEmailIDsToolStripMenuItem.Click += new System.EventHandler(this.GetOutlookEmailIDsToolStripMenuItem_Click);
			this.ToolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
			this.AllToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.AllToolStripMenuItem1.Click += new System.EventHandler(this.AllToolStripMenuItem1_Click);
			this.ToolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
			this.InstallCESP2ToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.InstallCESP2ToolStripMenuItem1.Click += new System.EventHandler(this.InstallCESP2ToolStripMenuItem1_Click);
			this.ToolStripMenuItem2 = new System.Windows.Forms.ToolStripMenuItem();
			this.ViewCEDirectoriesToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.ViewCEDirectoriesToolStripMenuItem1.Click += new System.EventHandler(this.ViewCEDirectoriesToolStripMenuItem1_Click);
			this.ReOCRToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.EstimateNumberOfFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.EstimateNumberOfFilesToolStripMenuItem.Click += new System.EventHandler(this.EstimateNumberOfFilesToolStripMenuItem_Click);
			this.ToolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
			this.ReOcrIncompleteGraphicFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ReOcrIncompleteGraphicFilesToolStripMenuItem.Click += new System.EventHandler(this.ReOcrIncompleteGraphicFilesToolStripMenuItem_Click);
			this.ReOcrALLGraphicFilesToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.ReOcrALLGraphicFilesToolStripMenuItem1.Click += new System.EventHandler(this.ReOcrALLGraphicFilesToolStripMenuItem1_Click);
			this.ResetEMAILCRCCodesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ResetEMAILCRCCodesToolStripMenuItem.Click += new System.EventHandler(this.ResetEMAILCRCCodesToolStripMenuItem_Click);
			this.RetentionManagementToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.RetentionRulesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.RetentionRulesToolStripMenuItem.Click += new System.EventHandler(this.RetentionRulesToolStripMenuItem_Click);
			this.RulesExecutionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.RulesExecutionToolStripMenuItem.Click += new System.EventHandler(this.RulesExecutionToolStripMenuItem_Click);
			this.HelpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.AboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.AboutToolStripMenuItem.Click += new System.EventHandler(this.AboutToolStripMenuItem_Click);
			this.OnlineHelpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.OnlineHelpToolStripMenuItem.Click += new System.EventHandler(this.OnlineHelpToolStripMenuItem_Click);
			this.ToolStripSeparator4 = new System.Windows.Forms.ToolStripSeparator();
			this.AppConfigVersionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.AppConfigVersionToolStripMenuItem.Click += new System.EventHandler(this.AppConfigVersionToolStripMenuItem_Click);
			this.RunningArchiverToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.RunningArchiverToolStripMenuItem.Click += new System.EventHandler(this.RunningArchiverToolStripMenuItem_Click);
			this.ParameterExecutionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ParameterExecutionToolStripMenuItem.Click += new System.EventHandler(this.ParameterExecutionToolStripMenuItem_Click);
			this.HistoryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.HistoryToolStripMenuItem.Click += new System.EventHandler(this.HistoryToolStripMenuItem_Click);
			this.SelectionToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.AllToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.AllToolStripMenuItem.Click += new System.EventHandler(this.AllToolStripMenuItem_Click);
			this.EmailToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.EmailToolStripMenuItem.Click += new System.EventHandler(this.EmailToolStripMenuItem_Click);
			this.ContentToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.ContentToolStripMenuItem1.Click += new System.EventHandler(this.ContentToolStripMenuItem1_Click);
			this.ExecutionControlToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ExecutionControlToolStripMenuItem.Click += new System.EventHandler(this.ExecutionControlToolStripMenuItem_Click);
			this.FileTypesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.FileTypesToolStripMenuItem.Click += new System.EventHandler(this.FileTypesToolStripMenuItem_Click);
			this.TestToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.DirectoryInventoryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.DirectoryInventoryToolStripMenuItem.Click += new System.EventHandler(this.DirectoryInventoryToolStripMenuItem_Click);
			this.ListFilesInDirectoryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ListFilesInDirectoryToolStripMenuItem.Click += new System.EventHandler(this.ListFilesInDirectoryToolStripMenuItem_Click);
			this.GetAllSubdirFilesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.GetAllSubdirFilesToolStripMenuItem.Click += new System.EventHandler(this.GetAllSubdirFilesToolStripMenuItem_Click);
			this.OCRToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.FileHashToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.FileHashToolStripMenuItem.Click += new System.EventHandler(this.FileHashToolStripMenuItem_Click);
			this.FileUploadToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.FileUploadToolStripMenuItem.Click += new System.EventHandler(this.FileUploadToolStripMenuItem_Click);
			this.FileUploadBufferedToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.FileUploadBufferedToolStripMenuItem.Click += new System.EventHandler(this.FileUploadBufferedToolStripMenuItem_Click);
			this.FileChunkUploadToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.FileChunkUploadToolStripMenuItem.Click += new System.EventHandler(this.FileChunkUploadToolStripMenuItem_Click);
			this.RSSPullToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.RSSPullToolStripMenuItem.Click += new System.EventHandler(this.RSSPullToolStripMenuItem_Click);
			this.ExitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ExitToolStripMenuItem.Click += new System.EventHandler(this.ExitToolStripMenuItem_Click);
			this.StatusStrip1 = new System.Windows.Forms.StatusStrip();
			this.infoDaysToExpire = new System.Windows.Forms.ToolStripStatusLabel();
			this.tssServer = new System.Windows.Forms.ToolStripStatusLabel();
			this.tssVersion = new System.Windows.Forms.ToolStripStatusLabel();
			this.tssAuth = new System.Windows.Forms.ToolStripStatusLabel();
			this.tssUser = new System.Windows.Forms.ToolStripStatusLabel();
			this.tbExchange = new System.Windows.Forms.ToolStripStatusLabel();
			this.PB1 = new System.Windows.Forms.ToolStripProgressBar();
			this.tsStatus02 = new System.Windows.Forms.ToolStripStatusLabel();
			this.SB5 = new System.Windows.Forms.ToolStripStatusLabel();
			this.ToolStripStatusLabel1 = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsBytesLoading = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsServiceDBConnState = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsTunnelConn = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsCurrentRepoID = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsLastArchive = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsTimeToArchive = new System.Windows.Forms.ToolStripStatusLabel();
			this.tsCountDown = new System.Windows.Forms.ToolStripStatusLabel();
			this.TimerQuickArchive = new System.Windows.Forms.Timer(this.components);
			this.TimerQuickArchive.Tick += new System.EventHandler(this.TimerQuickArchive_Tick);
			this.TabControl1 = new System.Windows.Forms.TabControl();
			this.TabPage1 = new System.Windows.Forms.TabPage();
			this.TabPage2 = new System.Windows.Forms.TabPage();
			this.TabPage4 = new System.Windows.Forms.TabPage();
			this.cbRssRetention = new System.Windows.Forms.ComboBox();
			this.Label31 = new System.Windows.Forms.Label();
			this.dgRss = new System.Windows.Forms.DataGridView();
			this.dgRss.SelectionChanged += new System.EventHandler(this.dgRss_SelectionChanged);
			this.btnRemoveRSSfeed = new System.Windows.Forms.Button();
			this.btnRemoveRSSfeed.Click += new System.EventHandler(this.btnRemoveRSSfeed_Click);
			this.btnAddRssFeed = new System.Windows.Forms.Button();
			this.btnAddRssFeed.Click += new System.EventHandler(this.btnAddRssFeed_Click);
			this.Label22 = new System.Windows.Forms.Label();
			this.Label21 = new System.Windows.Forms.Label();
			this.Label20 = new System.Windows.Forms.Label();
			this.Label17 = new System.Windows.Forms.Label();
			this.TabPage5 = new System.Windows.Forms.TabPage();
			this.cbWebPageRetention = new System.Windows.Forms.ComboBox();
			this.Label32 = new System.Windows.Forms.Label();
			this.btnRemoveWebPage = new System.Windows.Forms.Button();
			this.btnRemoveWebPage.Click += new System.EventHandler(this.btnRemoveWebPage_Click);
			this.btnSaveWebPage = new System.Windows.Forms.Button();
			this.btnSaveWebPage.Click += new System.EventHandler(this.btnSaveWebPage_Click);
			this.Label23 = new System.Windows.Forms.Label();
			this.Label24 = new System.Windows.Forms.Label();
			this.dgWebPage = new System.Windows.Forms.DataGridView();
			this.dgWebPage.SelectionChanged += new System.EventHandler(this.dgWebPage_SelectionChanged);
			this.Label25 = new System.Windows.Forms.Label();
			this.Label18 = new System.Windows.Forms.Label();
			this.TabPage6 = new System.Windows.Forms.TabPage();
			this.cbWebSiteRetention = new System.Windows.Forms.ComboBox();
			this.Label33 = new System.Windows.Forms.Label();
			this.nbrOutboundLinks = new System.Windows.Forms.NumericUpDown();
			this.nbrDepth = new System.Windows.Forms.NumericUpDown();
			this.Label30 = new System.Windows.Forms.Label();
			this.Label29 = new System.Windows.Forms.Label();
			this.btnRemoveWebSite = new System.Windows.Forms.Button();
			this.btnRemoveWebSite.Click += new System.EventHandler(this.btnRemoveWebSite_Click);
			this.btnSaveWebSite = new System.Windows.Forms.Button();
			this.btnSaveWebSite.Click += new System.EventHandler(this.btnSaveWebSite_Click);
			this.txtWebSiteURL = new System.Windows.Forms.TextBox();
			this.Label26 = new System.Windows.Forms.Label();
			this.txtWebSiteName = new System.Windows.Forms.TextBox();
			this.Label27 = new System.Windows.Forms.Label();
			this.dgWebSite = new System.Windows.Forms.DataGridView();
			this.dgWebSite.SelectionChanged += new System.EventHandler(this.dgWebSite_SelectionChanged);
			this.Label28 = new System.Windows.Forms.Label();
			this.Label19 = new System.Windows.Forms.Label();
			this.TabPage3 = new System.Windows.Forms.TabPage();
			this.GroupBox1 = new System.Windows.Forms.GroupBox();
			this.txtCompany = new System.Windows.Forms.TextBox();
			this.btnActivate = new System.Windows.Forms.Button();
			this.btnActivate.Click += new System.EventHandler(this.btnActivate_Click);
			this.cbRepo = new System.Windows.Forms.ComboBox();
			this.Label15 = new System.Windows.Forms.Label();
			this.Label14 = new System.Windows.Forms.Label();
			this.btnDefaultAsso = new System.Windows.Forms.Button();
			this.btnDefaultAsso.Click += new System.EventHandler(this.btnDefaultAsso_Click);
			this.btnRefreshDefaults = new System.Windows.Forms.Button();
			this.btnRefreshDefaults.Click += new System.EventHandler(this.btnRefreshDefaults_Click);
			this.OpenFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.BackgroundWorker1 = new System.ComponentModel.BackgroundWorker();
			this.BackgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.BackgroundWorker1_DoWork);
			this.BackgroundWorker2 = new System.ComponentModel.BackgroundWorker();
			this.BackgroundWorker2.DoWork += new System.ComponentModel.DoWorkEventHandler(this.BackgroundWorker2_DoWork);
			this.BackgroundWorker3 = new System.ComponentModel.BackgroundWorker();
			this.BackgroundWorker3.DoWork += new System.ComponentModel.DoWorkEventHandler(this.BackgroundWorker3_DoWork);
			this.BackgroundDirListener = new System.ComponentModel.BackgroundWorker();
			this.BackgroundDirListener.DoWork += new System.ComponentModel.DoWorkEventHandler(this.BackgroundDirListener_DoWork);
			this.BackgroundWorkerContacts = new System.ComponentModel.BackgroundWorker();
			this.BackgroundWorkerContacts.DoWork += new System.ComponentModel.DoWorkEventHandler(this.BackgroundWorkerContacts_DoWork);
			this.asyncBatchOcrALL = new System.ComponentModel.BackgroundWorker();
			this.asyncBatchOcrALL.DoWork += new System.ComponentModel.DoWorkEventHandler(this.asyncBatchOcrALL_DoWork);
			this.asyncBatchOcrPending = new System.ComponentModel.BackgroundWorker();
			this.asyncBatchOcrPending.DoWork += new System.ComponentModel.DoWorkEventHandler(this.asyncBatchOcrPending_DoWork);
			this.asyncVerifyRetainDates = new System.ComponentModel.BackgroundWorker();
			this.asyncVerifyRetainDates.DoWork += new System.ComponentModel.DoWorkEventHandler(this.asyncVerifyRetainDates_DoWork);
			this.asyncRssPull = new System.ComponentModel.BackgroundWorker();
			this.asyncRssPull.DoWork += new System.ComponentModel.DoWorkEventHandler(this.asyncRssPull_DoWork);
			this.asyncSpiderWebSite = new System.ComponentModel.BackgroundWorker();
			this.asyncSpiderWebSite.DoWork += new System.ComponentModel.DoWorkEventHandler(this.asyncSpiderWebSite_DoWork);
			this.asyncSpiderWebPage = new System.ComponentModel.BackgroundWorker();
			this.asyncSpiderWebPage.DoWork += new System.ComponentModel.DoWorkEventHandler(this.asyncSpiderWebPage_DoWork);
			this.gbEmail.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.NumericUpDown3).BeginInit();
			this.gbFiletypes.SuspendLayout();
			this.gbPolling.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.nbrArchiveHours).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.PictureBox2).BeginInit();
			this.gbContentMgt.SuspendLayout();
			this.Panel2.SuspendLayout();
			this.Panel1.SuspendLayout();
			this.Panel3.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.PictureBox1).BeginInit();
			this.ContextMenuStrip1.SuspendLayout();
			this.MenuStrip1.SuspendLayout();
			this.StatusStrip1.SuspendLayout();
			this.TabControl1.SuspendLayout();
			this.TabPage1.SuspendLayout();
			this.TabPage2.SuspendLayout();
			this.TabPage4.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.dgRss).BeginInit();
			this.TabPage5.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.dgWebPage).BeginInit();
			this.TabPage6.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.nbrOutboundLinks).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.nbrDepth).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.dgWebSite).BeginInit();
			this.TabPage3.SuspendLayout();
			this.GroupBox1.SuspendLayout();
			this.SuspendLayout();
			//
			//gbEmail
			//
			this.gbEmail.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.gbEmail.BackColor = System.Drawing.Color.LightGray;
			this.gbEmail.Controls.Add(this.LinkLabel2);
			this.gbEmail.Controls.Add(this.LinkLabel1);
			this.gbEmail.Controls.Add(this.hlExchange);
			this.gbEmail.Controls.Add(this.Label16);
			this.gbEmail.Controls.Add(this.Label3);
			this.gbEmail.Controls.Add(this.Label2);
			this.gbEmail.Controls.Add(this.ckExpand);
			this.gbEmail.Controls.Add(this.ckGetSubFolders);
			this.gbEmail.Controls.Add(this.ckDoNotShowArchived);
			this.gbEmail.Controls.Add(this.cbParentFolders);
			this.gbEmail.Controls.Add(this.btnSMTP);
			this.gbEmail.Controls.Add(this.cbEmailRetention);
			this.gbEmail.Controls.Add(this.ckSystemFolder);
			this.gbEmail.Controls.Add(this.ckUseLastProcessDateAsCutoff);
			this.gbEmail.Controls.Add(this.ckArchiveRead);
			this.gbEmail.Controls.Add(this.btnDeleteEmailEntry);
			this.gbEmail.Controls.Add(this.btnActive);
			this.gbEmail.Controls.Add(this.cbEmailDB);
			this.gbEmail.Controls.Add(this.Label4);
			this.gbEmail.Controls.Add(this.NumericUpDown3);
			this.gbEmail.Controls.Add(this.ckRemoveAfterXDays);
			this.gbEmail.Controls.Add(this.btnRefreshFolders);
			this.gbEmail.Controls.Add(this.btnSaveConditions);
			this.gbEmail.Controls.Add(this.ckArchiveFolder);
			this.gbEmail.Controls.Add(this.lbActiveFolder);
			this.gbEmail.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
			this.gbEmail.Location = new System.Drawing.Point(9, 6);
			this.gbEmail.Name = "gbEmail";
			this.gbEmail.Size = new System.Drawing.Size(913, 489);
			this.gbEmail.TabIndex = 4;
			this.gbEmail.TabStop = false;
			this.gbEmail.Text = "Outlook Email Archive";
			//
			//LinkLabel2
			//
			this.LinkLabel2.AutoSize = true;
			this.LinkLabel2.Location = new System.Drawing.Point(410, 25);
			this.LinkLabel2.Name = "LinkLabel2";
			this.LinkLabel2.Size = new System.Drawing.Size(45, 13);
			this.LinkLabel2.TabIndex = 72;
			this.LinkLabel2.TabStop = true;
			this.LinkLabel2.Text = "Validate";
			this.TT.SetToolTip(this.LinkLabel2, "If executing from a machine different than your usual, press this button to valid" + "ate your \"access\" level.");
			//
			//LinkLabel1
			//
			this.LinkLabel1.AutoSize = true;
			this.LinkLabel1.Location = new System.Drawing.Point(352, 25);
			this.LinkLabel1.Name = "LinkLabel1";
			this.LinkLabel1.Size = new System.Drawing.Size(52, 13);
			this.LinkLabel1.TabIndex = 71;
			this.LinkLabel1.TabStop = true;
			this.LinkLabel1.Text = "PST Files";
			//
			//hlExchange
			//
			this.hlExchange.AutoSize = true;
			this.hlExchange.Location = new System.Drawing.Point(263, 25);
			this.hlExchange.Name = "hlExchange";
			this.hlExchange.Size = new System.Drawing.Size(83, 13);
			this.hlExchange.TabIndex = 70;
			this.hlExchange.TabStop = true;
			this.hlExchange.Text = "Exchange Email";
			//
			//Label16
			//
			this.Label16.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label16.AutoSize = true;
			this.Label16.Location = new System.Drawing.Point(6, 370);
			this.Label16.Name = "Label16";
			this.Label16.Size = new System.Drawing.Size(370, 13);
			this.Label16.TabIndex = 69;
			this.Label16.Text = "Note: All emails are stored private by default. Set up your own library to share." + "";
			this.TT.SetToolTip(this.Label16, "Click an item in the grid and right mouse for the library definition menu.");
			//
			//Label3
			//
			this.Label3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(306, 410);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(83, 13);
			this.Label3.TabIndex = 68;
			this.Label3.Text = "Retention Rules";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.BackColor = System.Drawing.Color.Transparent;
			this.Label2.Location = new System.Drawing.Point(6, 48);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(92, 13);
			this.Label2.TabIndex = 67;
			this.Label2.Text = "Outlook Container";
			//
			//ckExpand
			//
			this.ckExpand.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckExpand.AutoSize = true;
			this.ckExpand.BackColor = System.Drawing.Color.Transparent;
			this.ckExpand.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckExpand.ForeColor = System.Drawing.Color.Black;
			this.ckExpand.Location = new System.Drawing.Point(827, 66);
			this.ckExpand.Name = "ckExpand";
			this.ckExpand.Size = new System.Drawing.Size(68, 17);
			this.ckExpand.TabIndex = 66;
			this.ckExpand.Text = "Expand";
			this.ckExpand.UseVisualStyleBackColor = false;
			this.ckExpand.Visible = false;
			//
			//ckGetSubFolders
			//
			this.ckGetSubFolders.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckGetSubFolders.AutoSize = true;
			this.ckGetSubFolders.BackColor = System.Drawing.Color.Transparent;
			this.ckGetSubFolders.ForeColor = System.Drawing.Color.Black;
			this.ckGetSubFolders.Location = new System.Drawing.Point(487, 410);
			this.ckGetSubFolders.Name = "ckGetSubFolders";
			this.ckGetSubFolders.Size = new System.Drawing.Size(121, 17);
			this.ckGetSubFolders.TabIndex = 64;
			this.ckGetSubFolders.Text = "Archive Sub-Folders";
			this.ckGetSubFolders.UseVisualStyleBackColor = false;
			this.ckGetSubFolders.Visible = false;
			//
			//ckDoNotShowArchived
			//
			this.ckDoNotShowArchived.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckDoNotShowArchived.AutoSize = true;
			this.ckDoNotShowArchived.BackColor = System.Drawing.Color.Transparent;
			this.ckDoNotShowArchived.Checked = true;
			this.ckDoNotShowArchived.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckDoNotShowArchived.ForeColor = System.Drawing.Color.Black;
			this.ckDoNotShowArchived.Location = new System.Drawing.Point(6, 433);
			this.ckDoNotShowArchived.Name = "ckDoNotShowArchived";
			this.ckDoNotShowArchived.Size = new System.Drawing.Size(179, 17);
			this.ckDoNotShowArchived.TabIndex = 62;
			this.ckDoNotShowArchived.Text = "1. Do not show already archived";
			this.ckDoNotShowArchived.UseVisualStyleBackColor = false;
			//
			//cbParentFolders
			//
			this.cbParentFolders.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbParentFolders.FormattingEnabled = true;
			this.cbParentFolders.Location = new System.Drawing.Point(8, 64);
			this.cbParentFolders.Name = "cbParentFolders";
			this.cbParentFolders.Size = new System.Drawing.Size(603, 21);
			this.cbParentFolders.TabIndex = 59;
			this.TT.SetToolTip(this.cbParentFolders, "This is the list of Parent Outlook Folders");
			//
			//btnSMTP
			//
			this.btnSMTP.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnSMTP.Enabled = false;
			this.btnSMTP.Location = new System.Drawing.Point(620, 19);
			this.btnSMTP.Name = "btnSMTP";
			this.btnSMTP.Size = new System.Drawing.Size(45, 24);
			this.btnSMTP.TabIndex = 58;
			this.btnSMTP.Text = "SMTP";
			this.TT.SetToolTip(this.btnSMTP, "Set up the SMTP properties");
			this.btnSMTP.UseVisualStyleBackColor = true;
			this.btnSMTP.Visible = false;
			//
			//cbEmailRetention
			//
			this.cbEmailRetention.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbEmailRetention.FormattingEnabled = true;
			this.cbEmailRetention.Location = new System.Drawing.Point(6, 406);
			this.cbEmailRetention.Name = "cbEmailRetention";
			this.cbEmailRetention.Size = new System.Drawing.Size(294, 21);
			this.cbEmailRetention.Sorted = true;
			this.cbEmailRetention.TabIndex = 56;
			this.TT.SetToolTip(this.cbEmailRetention, "When blank, default retention value will be used.");
			//
			//ckSystemFolder
			//
			this.ckSystemFolder.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckSystemFolder.AutoSize = true;
			this.ckSystemFolder.BackColor = System.Drawing.Color.Transparent;
			this.ckSystemFolder.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckSystemFolder.ForeColor = System.Drawing.Color.Black;
			this.ckSystemFolder.Location = new System.Drawing.Point(487, 460);
			this.ckSystemFolder.Name = "ckSystemFolder";
			this.ckSystemFolder.Size = new System.Drawing.Size(124, 17);
			this.ckSystemFolder.TabIndex = 38;
			this.ckSystemFolder.Text = "Mandatory Folder";
			this.TT.SetToolTip(this.ckSystemFolder, "Admins, Check to make this folder a mandatory backup folder, all users will inclu" + "de this folder.");
			this.ckSystemFolder.UseVisualStyleBackColor = false;
			//
			//ckUseLastProcessDateAsCutoff
			//
			this.ckUseLastProcessDateAsCutoff.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckUseLastProcessDateAsCutoff.AutoSize = true;
			this.ckUseLastProcessDateAsCutoff.BackColor = System.Drawing.Color.Transparent;
			this.ckUseLastProcessDateAsCutoff.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckUseLastProcessDateAsCutoff.ForeColor = System.Drawing.Color.Black;
			this.ckUseLastProcessDateAsCutoff.Location = new System.Drawing.Point(487, 435);
			this.ckUseLastProcessDateAsCutoff.Name = "ckUseLastProcessDateAsCutoff";
			this.ckUseLastProcessDateAsCutoff.Size = new System.Drawing.Size(146, 17);
			this.ckUseLastProcessDateAsCutoff.TabIndex = 37;
			this.ckUseLastProcessDateAsCutoff.Text = "Use Last Folder Date";
			this.TT.SetToolTip(this.ckUseLastProcessDateAsCutoff, "Chieck this to allow only emails downloaded after the successful archive to be co" + "nsidered.");
			this.ckUseLastProcessDateAsCutoff.UseVisualStyleBackColor = false;
			//
			//ckArchiveRead
			//
			this.ckArchiveRead.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckArchiveRead.AutoSize = true;
			this.ckArchiveRead.BackColor = System.Drawing.Color.Transparent;
			this.ckArchiveRead.ForeColor = System.Drawing.Color.Black;
			this.ckArchiveRead.Location = new System.Drawing.Point(6, 460);
			this.ckArchiveRead.Name = "ckArchiveRead";
			this.ckArchiveRead.Size = new System.Drawing.Size(173, 17);
			this.ckArchiveRead.TabIndex = 36;
			this.ckArchiveRead.Text = "3. Do Not Move Unread Emails";
			this.ckArchiveRead.UseVisualStyleBackColor = false;
			//
			//btnDeleteEmailEntry
			//
			this.btnDeleteEmailEntry.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnDeleteEmailEntry.BackColor = System.Drawing.Color.Transparent;
			this.btnDeleteEmailEntry.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.btnDeleteEmailEntry.ForeColor = System.Drawing.Color.Black;
			this.btnDeleteEmailEntry.Location = new System.Drawing.Point(822, 445);
			this.btnDeleteEmailEntry.Name = "btnDeleteEmailEntry";
			this.btnDeleteEmailEntry.Size = new System.Drawing.Size(85, 32);
			this.btnDeleteEmailEntry.TabIndex = 35;
			this.btnDeleteEmailEntry.Text = "Deactivate";
			this.btnDeleteEmailEntry.UseVisualStyleBackColor = false;
			//
			//btnActive
			//
			this.btnActive.Location = new System.Drawing.Point(131, 19);
			this.btnActive.Name = "btnActive";
			this.btnActive.Size = new System.Drawing.Size(114, 24);
			this.btnActive.TabIndex = 27;
			this.btnActive.Text = "Archived";
			this.btnActive.UseVisualStyleBackColor = true;
			//
			//cbEmailDB
			//
			this.cbEmailDB.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbEmailDB.Enabled = false;
			this.cbEmailDB.FormattingEnabled = true;
			this.cbEmailDB.Location = new System.Drawing.Point(726, 22);
			this.cbEmailDB.Name = "cbEmailDB";
			this.cbEmailDB.Size = new System.Drawing.Size(171, 21);
			this.cbEmailDB.Sorted = true;
			this.cbEmailDB.TabIndex = 26;
			this.cbEmailDB.Text = "ECMREPO";
			this.cbEmailDB.Visible = false;
			//
			//Label4
			//
			this.Label4.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label4.AutoSize = true;
			this.Label4.BackColor = System.Drawing.Color.Transparent;
			this.Label4.ForeColor = System.Drawing.Color.Black;
			this.Label4.Location = new System.Drawing.Point(374, 462);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(32, 13);
			this.Label4.TabIndex = 17;
			this.Label4.Text = "days.";
			//
			//NumericUpDown3
			//
			this.NumericUpDown3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.NumericUpDown3.BackColor = System.Drawing.Color.White;
			this.NumericUpDown3.Enabled = false;
			this.NumericUpDown3.Location = new System.Drawing.Point(320, 458);
			this.NumericUpDown3.Name = "NumericUpDown3";
			this.NumericUpDown3.Size = new System.Drawing.Size(48, 20);
			this.NumericUpDown3.TabIndex = 16;
			this.NumericUpDown3.Value = new decimal(new int[] {30, 0, 0, 0});
			//
			//ckRemoveAfterXDays
			//
			this.ckRemoveAfterXDays.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckRemoveAfterXDays.AutoSize = true;
			this.ckRemoveAfterXDays.BackColor = System.Drawing.Color.Transparent;
			this.ckRemoveAfterXDays.ForeColor = System.Drawing.Color.Black;
			this.ckRemoveAfterXDays.Location = new System.Drawing.Point(203, 461);
			this.ckRemoveAfterXDays.Name = "ckRemoveAfterXDays";
			this.ckRemoveAfterXDays.Size = new System.Drawing.Size(116, 17);
			this.ckRemoveAfterXDays.TabIndex = 15;
			this.ckRemoveAfterXDays.Text = "4. Move items after";
			this.TT.SetToolTip(this.ckRemoveAfterXDays, "Moves expired emails to ECM_HISTORY.");
			this.ckRemoveAfterXDays.UseVisualStyleBackColor = false;
			//
			//btnRefreshFolders
			//
			this.btnRefreshFolders.Location = new System.Drawing.Point(8, 19);
			this.btnRefreshFolders.Name = "btnRefreshFolders";
			this.btnRefreshFolders.Size = new System.Drawing.Size(114, 24);
			this.btnRefreshFolders.TabIndex = 10;
			this.btnRefreshFolders.Text = "Avail For Archive";
			this.btnRefreshFolders.UseVisualStyleBackColor = true;
			//
			//btnSaveConditions
			//
			this.btnSaveConditions.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnSaveConditions.BackColor = System.Drawing.Color.Transparent;
			this.btnSaveConditions.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.btnSaveConditions.Location = new System.Drawing.Point(821, 399);
			this.btnSaveConditions.Name = "btnSaveConditions";
			this.btnSaveConditions.Size = new System.Drawing.Size(86, 32);
			this.btnSaveConditions.TabIndex = 8;
			this.btnSaveConditions.Text = "Activate";
			this.btnSaveConditions.UseVisualStyleBackColor = false;
			//
			//ckArchiveFolder
			//
			this.ckArchiveFolder.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckArchiveFolder.AutoSize = true;
			this.ckArchiveFolder.BackColor = System.Drawing.Color.Transparent;
			this.ckArchiveFolder.ForeColor = System.Drawing.Color.Black;
			this.ckArchiveFolder.Location = new System.Drawing.Point(203, 433);
			this.ckArchiveFolder.Name = "ckArchiveFolder";
			this.ckArchiveFolder.Size = new System.Drawing.Size(150, 17);
			this.ckArchiveFolder.TabIndex = 7;
			this.ckArchiveFolder.Text = "2. Archive Emails in Folder";
			this.ckArchiveFolder.UseVisualStyleBackColor = false;
			//
			//lbActiveFolder
			//
			this.lbActiveFolder.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.lbActiveFolder.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.lbActiveFolder.FormattingEnabled = true;
			this.lbActiveFolder.Location = new System.Drawing.Point(6, 90);
			this.lbActiveFolder.Name = "lbActiveFolder";
			this.lbActiveFolder.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lbActiveFolder.Size = new System.Drawing.Size(889, 277);
			this.lbActiveFolder.Sorted = true;
			this.lbActiveFolder.TabIndex = 6;
			this.TT.SetToolTip(this.lbActiveFolder, "Select and right mouse to set libraries.");
			//
			//lblVer
			//
			this.lblVer.AutoSize = true;
			this.lblVer.BackColor = System.Drawing.Color.Silver;
			this.lblVer.ForeColor = System.Drawing.Color.Black;
			this.lblVer.Location = new System.Drawing.Point(894, 8);
			this.lblVer.Name = "lblVer";
			this.lblVer.Size = new System.Drawing.Size(46, 13);
			this.lblVer.TabIndex = 69;
			this.lblVer.Text = "12.8.8.5";
			//
			//SB
			//
			this.SB.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.SB.BackColor = System.Drawing.Color.Gainsboro;
			this.SB.Location = new System.Drawing.Point(264, 579);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(468, 20);
			this.SB.TabIndex = 30;
			//
			//gbFiletypes
			//
			this.gbFiletypes.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.gbFiletypes.BackColor = System.Drawing.SystemColors.ControlDark;
			this.gbFiletypes.Controls.Add(this.cbProcessAsList);
			this.gbFiletypes.Controls.Add(this.Button2);
			this.gbFiletypes.Controls.Add(this.Button1);
			this.gbFiletypes.Controls.Add(this.Label10);
			this.gbFiletypes.Controls.Add(this.Label9);
			this.gbFiletypes.Controls.Add(this.cbAsType);
			this.gbFiletypes.Controls.Add(this.cbPocessType);
			this.gbFiletypes.Controls.Add(this.ckRemoveFileType);
			this.gbFiletypes.Controls.Add(this.cbFileTypes);
			this.gbFiletypes.Controls.Add(this.btnAddFiletype);
			this.gbFiletypes.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
			this.gbFiletypes.Location = new System.Drawing.Point(598, 208);
			this.gbFiletypes.Name = "gbFiletypes";
			this.gbFiletypes.Size = new System.Drawing.Size(296, 112);
			this.gbFiletypes.TabIndex = 29;
			this.gbFiletypes.TabStop = false;
			this.gbFiletypes.Text = "File Types";
			//
			//cbProcessAsList
			//
			this.cbProcessAsList.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbProcessAsList.FormattingEnabled = true;
			this.cbProcessAsList.Location = new System.Drawing.Point(8, 80);
			this.cbProcessAsList.Name = "cbProcessAsList";
			this.cbProcessAsList.Size = new System.Drawing.Size(178, 21);
			this.cbProcessAsList.TabIndex = 49;
			//
			//Button2
			//
			this.Button2.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Button2.Location = new System.Drawing.Point(207, 78);
			this.Button2.Name = "Button2";
			this.Button2.Size = new System.Drawing.Size(72, 24);
			this.Button2.TabIndex = 48;
			this.Button2.Text = "Remove";
			this.Button2.UseVisualStyleBackColor = true;
			//
			//Button1
			//
			this.Button1.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Button1.Location = new System.Drawing.Point(207, 54);
			this.Button1.Name = "Button1";
			this.Button1.Size = new System.Drawing.Size(72, 24);
			this.Button1.TabIndex = 47;
			this.Button1.Text = "Add";
			this.Button1.UseVisualStyleBackColor = true;
			//
			//Label10
			//
			this.Label10.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Label10.AutoSize = true;
			this.Label10.Location = new System.Drawing.Point(104, 40);
			this.Label10.Name = "Label10";
			this.Label10.Size = new System.Drawing.Size(54, 13);
			this.Label10.TabIndex = 46;
			this.Label10.Text = "2. As type";
			//
			//Label9
			//
			this.Label9.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Label9.AutoSize = true;
			this.Label9.Location = new System.Drawing.Point(8, 40);
			this.Label9.Name = "Label9";
			this.Label9.Size = new System.Drawing.Size(80, 13);
			this.Label9.TabIndex = 45;
			this.Label9.Text = "1. Process type";
			//
			//cbAsType
			//
			this.cbAsType.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbAsType.FormattingEnabled = true;
			this.cbAsType.Location = new System.Drawing.Point(104, 56);
			this.cbAsType.Name = "cbAsType";
			this.cbAsType.Size = new System.Drawing.Size(82, 21);
			this.cbAsType.Sorted = true;
			this.cbAsType.TabIndex = 44;
			//
			//cbPocessType
			//
			this.cbPocessType.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbPocessType.FormattingEnabled = true;
			this.cbPocessType.Location = new System.Drawing.Point(8, 56);
			this.cbPocessType.Name = "cbPocessType";
			this.cbPocessType.Size = new System.Drawing.Size(82, 21);
			this.cbPocessType.Sorted = true;
			this.cbPocessType.TabIndex = 43;
			//
			//ckRemoveFileType
			//
			this.ckRemoveFileType.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckRemoveFileType.Location = new System.Drawing.Point(239, 14);
			this.ckRemoveFileType.Name = "ckRemoveFileType";
			this.ckRemoveFileType.Size = new System.Drawing.Size(32, 24);
			this.ckRemoveFileType.TabIndex = 3;
			this.ckRemoveFileType.Text = "X";
			this.TT.SetToolTip(this.ckRemoveFileType, "Press to Delete EXISTING file type from system.");
			this.ckRemoveFileType.UseVisualStyleBackColor = true;
			//
			//cbFileTypes
			//
			this.cbFileTypes.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbFileTypes.FormattingEnabled = true;
			this.cbFileTypes.Location = new System.Drawing.Point(8, 16);
			this.cbFileTypes.Name = "cbFileTypes";
			this.cbFileTypes.Size = new System.Drawing.Size(178, 21);
			this.cbFileTypes.Sorted = true;
			this.cbFileTypes.TabIndex = 2;
			//
			//btnAddFiletype
			//
			this.btnAddFiletype.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.btnAddFiletype.Location = new System.Drawing.Point(207, 14);
			this.btnAddFiletype.Name = "btnAddFiletype";
			this.btnAddFiletype.Size = new System.Drawing.Size(32, 24);
			this.btnAddFiletype.TabIndex = 1;
			this.btnAddFiletype.Text = "+";
			this.TT.SetToolTip(this.btnAddFiletype, "Press to add NEW file type to system.");
			this.btnAddFiletype.UseVisualStyleBackColor = true;
			//
			//gbPolling
			//
			this.gbPolling.BackColor = System.Drawing.Color.DimGray;
			this.gbPolling.Controls.Add(this.ckWebSiteTrackerDisabled);
			this.gbPolling.Controls.Add(this.ckWebPageTrackerDisabled);
			this.gbPolling.Controls.Add(this.ckRssPullDisabled);
			this.gbPolling.Controls.Add(this.ckRunOnStart);
			this.gbPolling.Controls.Add(this.btnArchiveNow);
			this.gbPolling.Controls.Add(this.Label1);
			this.gbPolling.Controls.Add(this.nbrArchiveHours);
			this.gbPolling.Controls.Add(this.ckRunUnattended);
			this.gbPolling.Controls.Add(this.ckDisableExchange);
			this.gbPolling.Controls.Add(this.ckDisableOutlookEmailArchive);
			this.gbPolling.Controls.Add(this.ckDisableContentArchive);
			this.gbPolling.Controls.Add(this.btnSaveSchedule);
			this.gbPolling.Controls.Add(this.ckDisable);
			this.gbPolling.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
			this.gbPolling.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.gbPolling.Location = new System.Drawing.Point(9, 22);
			this.gbPolling.Name = "gbPolling";
			this.gbPolling.Size = new System.Drawing.Size(429, 273);
			this.gbPolling.TabIndex = 27;
			this.gbPolling.TabStop = false;
			this.gbPolling.Text = "Execution Parameters";
			//
			//ckWebSiteTrackerDisabled
			//
			this.ckWebSiteTrackerDisabled.AutoSize = true;
			this.ckWebSiteTrackerDisabled.Checked = true;
			this.ckWebSiteTrackerDisabled.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckWebSiteTrackerDisabled.ForeColor = System.Drawing.Color.White;
			this.ckWebSiteTrackerDisabled.Location = new System.Drawing.Point(27, 176);
			this.ckWebSiteTrackerDisabled.Name = "ckWebSiteTrackerDisabled";
			this.ckWebSiteTrackerDisabled.Size = new System.Drawing.Size(155, 17);
			this.ckWebSiteTrackerDisabled.TabIndex = 36;
			this.ckWebSiteTrackerDisabled.Text = "6. Disable WEB Site Spider";
			this.TT.SetToolTip(this.ckWebSiteTrackerDisabled, "Checking this will disable Exchange archive.");
			this.ckWebSiteTrackerDisabled.UseVisualStyleBackColor = true;
			//
			//ckWebPageTrackerDisabled
			//
			this.ckWebPageTrackerDisabled.AutoSize = true;
			this.ckWebPageTrackerDisabled.Checked = true;
			this.ckWebPageTrackerDisabled.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckWebPageTrackerDisabled.ForeColor = System.Drawing.Color.White;
			this.ckWebPageTrackerDisabled.Location = new System.Drawing.Point(27, 152);
			this.ckWebPageTrackerDisabled.Name = "ckWebPageTrackerDisabled";
			this.ckWebPageTrackerDisabled.Size = new System.Drawing.Size(169, 17);
			this.ckWebPageTrackerDisabled.TabIndex = 35;
			this.ckWebPageTrackerDisabled.Text = "6. Disable WEB Page Tracker";
			this.TT.SetToolTip(this.ckWebPageTrackerDisabled, "Checking this will disable Exchange archive.");
			this.ckWebPageTrackerDisabled.UseVisualStyleBackColor = true;
			//
			//ckRssPullDisabled
			//
			this.ckRssPullDisabled.AutoSize = true;
			this.ckRssPullDisabled.Checked = true;
			this.ckRssPullDisabled.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckRssPullDisabled.ForeColor = System.Drawing.Color.White;
			this.ckRssPullDisabled.Location = new System.Drawing.Point(27, 128);
			this.ckRssPullDisabled.Name = "ckRssPullDisabled";
			this.ckRssPullDisabled.Size = new System.Drawing.Size(98, 17);
			this.ckRssPullDisabled.TabIndex = 34;
			this.ckRssPullDisabled.Text = "5. Disable RSS";
			this.TT.SetToolTip(this.ckRssPullDisabled, "Checking this will disable Exchange archive.");
			this.ckRssPullDisabled.UseVisualStyleBackColor = true;
			//
			//ckRunOnStart
			//
			this.ckRunOnStart.AutoSize = true;
			this.ckRunOnStart.Location = new System.Drawing.Point(27, 224);
			this.ckRunOnStart.Name = "ckRunOnStart";
			this.ckRunOnStart.Size = new System.Drawing.Size(105, 17);
			this.ckRunOnStart.TabIndex = 33;
			this.ckRunOnStart.Text = "6. Run at startup";
			this.TT.SetToolTip(this.ckRunOnStart, "When checked, the ECM Archive module will start when you login to your computer.");
			this.ckRunOnStart.UseVisualStyleBackColor = true;
			//
			//btnArchiveNow
			//
			this.btnArchiveNow.ForeColor = System.Drawing.SystemColors.ActiveCaptionText;
			this.btnArchiveNow.Location = new System.Drawing.Point(331, 103);
			this.btnArchiveNow.Name = "btnArchiveNow";
			this.btnArchiveNow.Size = new System.Drawing.Size(27, 23);
			this.btnArchiveNow.TabIndex = 16;
			this.btnArchiveNow.Text = "@";
			this.TT.SetToolTip(this.btnArchiveNow, "Press to Archive Immediately");
			this.btnArchiveNow.UseVisualStyleBackColor = true;
			this.btnArchiveNow.Visible = false;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.ForeColor = System.Drawing.Color.White;
			this.Label1.Location = new System.Drawing.Point(281, 133);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(125, 13);
			this.Label1.TabIndex = 15;
			this.Label1.Text = "Quick Archive Schedule:";
			//
			//nbrArchiveHours
			//
			this.nbrArchiveHours.Location = new System.Drawing.Point(308, 149);
			this.nbrArchiveHours.Maximum = new decimal(new int[] {96, 0, 0, 0});
			this.nbrArchiveHours.Name = "nbrArchiveHours";
			this.nbrArchiveHours.Size = new System.Drawing.Size(74, 20);
			this.nbrArchiveHours.TabIndex = 14;
			this.TT.SetToolTip(this.nbrArchiveHours, "Set to ZERO to turn off or any number of hours between 4 and 96.");
			//
			//ckRunUnattended
			//
			this.ckRunUnattended.AutoSize = true;
			this.ckRunUnattended.ForeColor = System.Drawing.Color.White;
			this.ckRunUnattended.Location = new System.Drawing.Point(27, 200);
			this.ckRunUnattended.Name = "ckRunUnattended";
			this.ckRunUnattended.Size = new System.Drawing.Size(117, 17);
			this.ckRunUnattended.TabIndex = 13;
			this.ckRunUnattended.Text = "5. Run Unattended";
			this.ckRunUnattended.UseVisualStyleBackColor = true;
			//
			//ckDisableExchange
			//
			this.ckDisableExchange.AutoSize = true;
			this.ckDisableExchange.Checked = true;
			this.ckDisableExchange.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckDisableExchange.ForeColor = System.Drawing.Color.White;
			this.ckDisableExchange.Location = new System.Drawing.Point(27, 104);
			this.ckDisableExchange.Name = "ckDisableExchange";
			this.ckDisableExchange.Size = new System.Drawing.Size(124, 17);
			this.ckDisableExchange.TabIndex = 11;
			this.ckDisableExchange.Text = "4. Disable Exchange";
			this.TT.SetToolTip(this.ckDisableExchange, "Checking this will disable Exchange archive.");
			this.ckDisableExchange.UseVisualStyleBackColor = true;
			//
			//ckDisableOutlookEmailArchive
			//
			this.ckDisableOutlookEmailArchive.AutoSize = true;
			this.ckDisableOutlookEmailArchive.Checked = true;
			this.ckDisableOutlookEmailArchive.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckDisableOutlookEmailArchive.ForeColor = System.Drawing.Color.White;
			this.ckDisableOutlookEmailArchive.Location = new System.Drawing.Point(27, 80);
			this.ckDisableOutlookEmailArchive.Name = "ckDisableOutlookEmailArchive";
			this.ckDisableOutlookEmailArchive.Size = new System.Drawing.Size(207, 17);
			this.ckDisableOutlookEmailArchive.TabIndex = 10;
			this.ckDisableOutlookEmailArchive.Text = "3. Disable Outlook Email and Contacts";
			this.TT.SetToolTip(this.ckDisableOutlookEmailArchive, "Checking this will disable EMAIL archive.");
			this.ckDisableOutlookEmailArchive.UseVisualStyleBackColor = true;
			//
			//ckDisableContentArchive
			//
			this.ckDisableContentArchive.AutoSize = true;
			this.ckDisableContentArchive.Checked = true;
			this.ckDisableContentArchive.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckDisableContentArchive.ForeColor = System.Drawing.Color.White;
			this.ckDisableContentArchive.Location = new System.Drawing.Point(27, 56);
			this.ckDisableContentArchive.Name = "ckDisableContentArchive";
			this.ckDisableContentArchive.Size = new System.Drawing.Size(113, 17);
			this.ckDisableContentArchive.TabIndex = 9;
			this.ckDisableContentArchive.Text = "2. Disable Content";
			this.TT.SetToolTip(this.ckDisableContentArchive, "Checking this will disable Content archive");
			this.ckDisableContentArchive.UseVisualStyleBackColor = true;
			//
			//btnSaveSchedule
			//
			this.btnSaveSchedule.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)));
			this.btnSaveSchedule.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.btnSaveSchedule.ForeColor = System.Drawing.Color.Black;
			this.btnSaveSchedule.Location = new System.Drawing.Point(308, 216);
			this.btnSaveSchedule.Name = "btnSaveSchedule";
			this.btnSaveSchedule.Size = new System.Drawing.Size(66, 30);
			this.btnSaveSchedule.TabIndex = 6;
			this.btnSaveSchedule.Text = "Save";
			this.btnSaveSchedule.UseVisualStyleBackColor = false;
			//
			//ckDisable
			//
			this.ckDisable.AutoSize = true;
			this.ckDisable.Checked = true;
			this.ckDisable.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckDisable.ForeColor = System.Drawing.Color.White;
			this.ckDisable.Location = new System.Drawing.Point(27, 32);
			this.ckDisable.Name = "ckDisable";
			this.ckDisable.Size = new System.Drawing.Size(87, 17);
			this.ckDisable.TabIndex = 4;
			this.ckDisable.Text = "1. Disable All";
			this.TT.SetToolTip(this.ckDisable, "Checking this will disable EMAIL, Exchange and Content archive.");
			this.ckDisable.UseVisualStyleBackColor = true;
			//
			//PictureBox2
			//
			this.PictureBox2.Image = global::My.Resources.Resources.ECM_Logo;
			this.PictureBox2.Location = new System.Drawing.Point(3, 440);
			this.PictureBox2.Name = "PictureBox2";
			this.PictureBox2.Size = new System.Drawing.Size(66, 58);
			this.PictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
			this.PictureBox2.TabIndex = 37;
			this.PictureBox2.TabStop = false;
			//
			//gbContentMgt
			//
			this.gbContentMgt.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.gbContentMgt.BackColor = System.Drawing.Color.Silver;
			this.gbContentMgt.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.gbContentMgt.Controls.Add(this.btnCountFiles);
			this.gbContentMgt.Controls.Add(this.Panel2);
			this.gbContentMgt.Controls.Add(this.lbArchiveDirs);
			this.gbContentMgt.Controls.Add(this.Panel1);
			this.gbContentMgt.Controls.Add(this.Panel3);
			this.gbContentMgt.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
			this.gbContentMgt.Location = new System.Drawing.Point(6, 6);
			this.gbContentMgt.Name = "gbContentMgt";
			this.gbContentMgt.Size = new System.Drawing.Size(916, 606);
			this.gbContentMgt.TabIndex = 33;
			this.gbContentMgt.TabStop = false;
			this.gbContentMgt.Text = "File Archive";
			//
			//btnCountFiles
			//
			this.btnCountFiles.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnCountFiles.Location = new System.Drawing.Point(559, 260);
			this.btnCountFiles.Name = "btnCountFiles";
			this.btnCountFiles.Size = new System.Drawing.Size(22, 19);
			this.btnCountFiles.TabIndex = 81;
			this.btnCountFiles.Text = "#";
			this.TT.SetToolTip(this.btnCountFiles, "Count the files in the selected directory.");
			this.btnCountFiles.UseVisualStyleBackColor = true;
			//
			//Panel2
			//
			this.Panel2.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Panel2.BackColor = System.Drawing.Color.Silver;
			this.Panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.Panel2.Controls.Add(this.ckDeleteAfterArchive);
			this.Panel2.Controls.Add(this.ckOcrPdf);
			this.Panel2.Controls.Add(this.ckShowLibs);
			this.Panel2.Controls.Add(this.btnRefreshRetent);
			this.Panel2.Controls.Add(this.CkMonitor);
			this.Panel2.Controls.Add(this.ckArchiveBit);
			this.Panel2.Controls.Add(this.Label13);
			this.Panel2.Controls.Add(this.cbRetention);
			this.Panel2.Controls.Add(this.ckOcr);
			this.Panel2.Controls.Add(this.clAdminDir);
			this.Panel2.Controls.Add(this.ckDisableDir);
			this.Panel2.Controls.Add(this.ckPublic);
			this.Panel2.Controls.Add(this.ckMetaData);
			this.Panel2.Controls.Add(this.ckVersionFiles);
			this.Panel2.Controls.Add(this.ckSubDirs);
			this.Panel2.Controls.Add(this.txtDir);
			this.Panel2.Controls.Add(this.btnRefresh);
			this.Panel2.Controls.Add(this.btnSaveChanges);
			this.Panel2.Controls.Add(this.btnRemoveDir);
			this.Panel2.Controls.Add(this.btnSelDir);
			this.Panel2.Location = new System.Drawing.Point(8, 286);
			this.Panel2.Name = "Panel2";
			this.Panel2.Size = new System.Drawing.Size(573, 198);
			this.Panel2.TabIndex = 79;
			//
			//ckDeleteAfterArchive
			//
			this.ckDeleteAfterArchive.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckDeleteAfterArchive.AutoSize = true;
			this.ckDeleteAfterArchive.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckDeleteAfterArchive.ForeColor = System.Drawing.Color.Black;
			this.ckDeleteAfterArchive.Location = new System.Drawing.Point(170, 172);
			this.ckDeleteAfterArchive.Name = "ckDeleteAfterArchive";
			this.ckDeleteAfterArchive.Size = new System.Drawing.Size(172, 17);
			this.ckDeleteAfterArchive.TabIndex = 78;
			this.ckDeleteAfterArchive.Text = "12. Remove After Archive";
			this.TT.SetToolTip(this.ckDeleteAfterArchive, "Delete the FILE after successful Archive.");
			this.ckDeleteAfterArchive.UseVisualStyleBackColor = true;
			//
			//ckOcrPdf
			//
			this.ckOcrPdf.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckOcrPdf.AutoSize = true;
			this.ckOcrPdf.ForeColor = System.Drawing.Color.Black;
			this.ckOcrPdf.Location = new System.Drawing.Point(2, 132);
			this.ckOcrPdf.Name = "ckOcrPdf";
			this.ckOcrPdf.Size = new System.Drawing.Size(130, 17);
			this.ckOcrPdf.TabIndex = 77;
			this.ckOcrPdf.Text = "4. OCR PDF Graphics";
			this.TT.SetToolTip(this.ckOcrPdf, "When checked, the assumption is made that th OCR is not a searchable PDF.  It wil" + "l be separated into pages and OCR\'D. It is time consuming. To override ALL set t" + "he SYS_EcmPDFX system parameter.");
			this.ckOcrPdf.UseVisualStyleBackColor = true;
			//
			//ckShowLibs
			//
			this.ckShowLibs.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckShowLibs.AutoSize = true;
			this.ckShowLibs.ForeColor = System.Drawing.Color.Black;
			this.ckShowLibs.Location = new System.Drawing.Point(170, 132);
			this.ckShowLibs.Name = "ckShowLibs";
			this.ckShowLibs.Size = new System.Drawing.Size(113, 17);
			this.ckShowLibs.TabIndex = 76;
			this.ckShowLibs.Text = "10. Show Libraries";
			this.TT.SetToolTip(this.ckShowLibs, "Check to show popup of assigned libraries.");
			this.ckShowLibs.UseVisualStyleBackColor = true;
			//
			//btnRefreshRetent
			//
			this.btnRefreshRetent.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnRefreshRetent.BackColor = System.Drawing.Color.Transparent;
			this.btnRefreshRetent.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.btnRefreshRetent.ForeColor = System.Drawing.Color.White;
			this.btnRefreshRetent.Location = new System.Drawing.Point(437, 45);
			this.btnRefreshRetent.Name = "btnRefreshRetent";
			this.btnRefreshRetent.Size = new System.Drawing.Size(25, 18);
			this.btnRefreshRetent.TabIndex = 75;
			this.TT.SetToolTip(this.btnRefreshRetent, "Refresh retention rules.");
			this.btnRefreshRetent.UseVisualStyleBackColor = false;
			//
			//CkMonitor
			//
			this.CkMonitor.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.CkMonitor.AutoSize = true;
			this.CkMonitor.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.CkMonitor.ForeColor = System.Drawing.Color.Black;
			this.CkMonitor.Location = new System.Drawing.Point(170, 153);
			this.CkMonitor.Name = "CkMonitor";
			this.CkMonitor.Size = new System.Drawing.Size(82, 17);
			this.CkMonitor.TabIndex = 74;
			this.CkMonitor.Text = "11. Listen";
			this.TT.SetToolTip(this.CkMonitor, "Track changes to this directory instantly.");
			this.CkMonitor.UseVisualStyleBackColor = true;
			//
			//ckArchiveBit
			//
			this.ckArchiveBit.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckArchiveBit.AutoSize = true;
			this.ckArchiveBit.ForeColor = System.Drawing.Color.Black;
			this.ckArchiveBit.Location = new System.Drawing.Point(2, 152);
			this.ckArchiveBit.Name = "ckArchiveBit";
			this.ckArchiveBit.Size = new System.Drawing.Size(137, 17);
			this.ckArchiveBit.TabIndex = 73;
			this.ckArchiveBit.Text = "5. Skip If Archive Bit on";
			this.TT.SetToolTip(this.ckArchiveBit, "If a files archive bit is set OOF, it will skipped during archive processing.");
			this.ckArchiveBit.UseVisualStyleBackColor = true;
			//
			//Label13
			//
			this.Label13.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label13.AutoSize = true;
			this.Label13.ForeColor = System.Drawing.Color.Black;
			this.Label13.Location = new System.Drawing.Point(26, 45);
			this.Label13.Name = "Label13";
			this.Label13.Size = new System.Drawing.Size(81, 13);
			this.Label13.TabIndex = 63;
			this.Label13.Text = "Retention Rule:";
			//
			//cbRetention
			//
			this.cbRetention.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbRetention.FormattingEnabled = true;
			this.cbRetention.Location = new System.Drawing.Point(114, 41);
			this.cbRetention.Name = "cbRetention";
			this.cbRetention.Size = new System.Drawing.Size(317, 21);
			this.cbRetention.Sorted = true;
			this.cbRetention.TabIndex = 55;
			this.TT.SetToolTip(this.cbRetention, "When blank, default retention value will be used.");
			//
			//ckOcr
			//
			this.ckOcr.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckOcr.AutoSize = true;
			this.ckOcr.ForeColor = System.Drawing.Color.Black;
			this.ckOcr.Location = new System.Drawing.Point(2, 112);
			this.ckOcr.Name = "ckOcr";
			this.ckOcr.Size = new System.Drawing.Size(129, 17);
			this.ckOcr.TabIndex = 54;
			this.ckOcr.Text = "3. OCR This Directory";
			this.ckOcr.UseVisualStyleBackColor = true;
			//
			//clAdminDir
			//
			this.clAdminDir.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.clAdminDir.AutoSize = true;
			this.clAdminDir.ForeColor = System.Drawing.Color.Black;
			this.clAdminDir.Location = new System.Drawing.Point(170, 92);
			this.clAdminDir.Name = "clAdminDir";
			this.clAdminDir.Size = new System.Drawing.Size(104, 17);
			this.clAdminDir.TabIndex = 51;
			this.clAdminDir.Text = "8. Mandatory Dir";
			this.TT.SetToolTip(this.clAdminDir, "Admins, Check to make this direcyory a mandatory backup folder, all users will in" + "clude this directory.");
			this.clAdminDir.UseVisualStyleBackColor = true;
			//
			//ckDisableDir
			//
			this.ckDisableDir.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckDisableDir.AutoSize = true;
			this.ckDisableDir.ForeColor = System.Drawing.Color.Black;
			this.ckDisableDir.Location = new System.Drawing.Point(2, 92);
			this.ckDisableDir.Name = "ckDisableDir";
			this.ckDisableDir.Size = new System.Drawing.Size(128, 17);
			this.ckDisableDir.TabIndex = 45;
			this.ckDisableDir.Text = "2. Disable Dir Archive";
			this.TT.SetToolTip(this.ckDisableDir, "Disable Archive for selected Directory");
			this.ckDisableDir.UseVisualStyleBackColor = true;
			//
			//ckPublic
			//
			this.ckPublic.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckPublic.AutoSize = true;
			this.ckPublic.ForeColor = System.Drawing.Color.Black;
			this.ckPublic.Location = new System.Drawing.Point(170, 112);
			this.ckPublic.Name = "ckPublic";
			this.ckPublic.Size = new System.Drawing.Size(97, 17);
			this.ckPublic.TabIndex = 44;
			this.ckPublic.Text = "9. Make Public";
			this.ckPublic.UseVisualStyleBackColor = true;
			//
			//ckMetaData
			//
			this.ckMetaData.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckMetaData.AutoSize = true;
			this.ckMetaData.ForeColor = System.Drawing.Color.Black;
			this.ckMetaData.Location = new System.Drawing.Point(170, 72);
			this.ckMetaData.Name = "ckMetaData";
			this.ckMetaData.Size = new System.Drawing.Size(123, 17);
			this.ckMetaData.TabIndex = 43;
			this.ckMetaData.Text = "7. Capture Metadata";
			this.TT.SetToolTip(this.ckMetaData, "This requires Windows OFFICE be installed locally to function correctly.");
			this.ckMetaData.UseVisualStyleBackColor = true;
			//
			//ckVersionFiles
			//
			this.ckVersionFiles.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckVersionFiles.AutoSize = true;
			this.ckVersionFiles.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckVersionFiles.ForeColor = System.Drawing.Color.Black;
			this.ckVersionFiles.Location = new System.Drawing.Point(2, 172);
			this.ckVersionFiles.Name = "ckVersionFiles";
			this.ckVersionFiles.Size = new System.Drawing.Size(113, 17);
			this.ckVersionFiles.TabIndex = 40;
			this.ckVersionFiles.Text = "6. Version Files";
			this.ckVersionFiles.UseVisualStyleBackColor = true;
			//
			//ckSubDirs
			//
			this.ckSubDirs.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckSubDirs.AutoSize = true;
			this.ckSubDirs.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckSubDirs.ForeColor = System.Drawing.Color.Black;
			this.ckSubDirs.Location = new System.Drawing.Point(2, 72);
			this.ckSubDirs.Name = "ckSubDirs";
			this.ckSubDirs.Size = new System.Drawing.Size(129, 17);
			this.ckSubDirs.TabIndex = 38;
			this.ckSubDirs.Text = "1. Include Subdirs";
			this.ckSubDirs.UseVisualStyleBackColor = true;
			//
			//txtDir
			//
			this.txtDir.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtDir.BackColor = System.Drawing.Color.WhiteSmoke;
			this.txtDir.Location = new System.Drawing.Point(114, 14);
			this.txtDir.Name = "txtDir";
			this.txtDir.Size = new System.Drawing.Size(453, 20);
			this.txtDir.TabIndex = 37;
			this.TT.SetToolTip(this.txtDir, "Use a %userid% to substitute in the user ID at that position in the directory str" + "ing.");
			//
			//btnRefresh
			//
			this.btnRefresh.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnRefresh.ForeColor = System.Drawing.Color.Black;
			this.btnRefresh.Location = new System.Drawing.Point(0, 14);
			this.btnRefresh.Name = "btnRefresh";
			this.btnRefresh.Size = new System.Drawing.Size(108, 23);
			this.btnRefresh.TabIndex = 24;
			this.btnRefresh.Text = "Show Disabled";
			this.TT.SetToolTip(this.btnRefresh, "This is a dual use button - Click to show enabled or disabled directories");
			this.btnRefresh.UseVisualStyleBackColor = true;
			//
			//btnSaveChanges
			//
			this.btnSaveChanges.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnSaveChanges.BackColor = System.Drawing.Color.Turquoise;
			this.btnSaveChanges.Location = new System.Drawing.Point(479, 145);
			this.btnSaveChanges.Name = "btnSaveChanges";
			this.btnSaveChanges.Size = new System.Drawing.Size(88, 44);
			this.btnSaveChanges.TabIndex = 23;
			this.btnSaveChanges.Text = "Save Changes to Archive";
			this.btnSaveChanges.UseVisualStyleBackColor = false;
			//
			//btnRemoveDir
			//
			this.btnRemoveDir.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnRemoveDir.BackColor = System.Drawing.Color.Transparent;
			this.btnRemoveDir.ForeColor = System.Drawing.Color.Black;
			this.btnRemoveDir.Location = new System.Drawing.Point(479, 93);
			this.btnRemoveDir.Name = "btnRemoveDir";
			this.btnRemoveDir.Size = new System.Drawing.Size(88, 44);
			this.btnRemoveDir.TabIndex = 11;
			this.btnRemoveDir.Text = "Remove Dir from Archive";
			this.btnRemoveDir.UseVisualStyleBackColor = false;
			//
			//btnSelDir
			//
			this.btnSelDir.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnSelDir.ForeColor = System.Drawing.Color.Black;
			this.btnSelDir.Location = new System.Drawing.Point(479, 41);
			this.btnSelDir.Name = "btnSelDir";
			this.btnSelDir.Size = new System.Drawing.Size(88, 44);
			this.btnSelDir.TabIndex = 9;
			this.btnSelDir.Text = "Select Dir for Archive";
			this.btnSelDir.UseVisualStyleBackColor = true;
			//
			//lbArchiveDirs
			//
			this.lbArchiveDirs.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.lbArchiveDirs.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.lbArchiveDirs.ForeColor = System.Drawing.Color.Black;
			this.lbArchiveDirs.FormattingEnabled = true;
			this.lbArchiveDirs.Location = new System.Drawing.Point(8, 16);
			this.lbArchiveDirs.Name = "lbArchiveDirs";
			this.lbArchiveDirs.Size = new System.Drawing.Size(573, 238);
			this.lbArchiveDirs.Sorted = true;
			this.lbArchiveDirs.TabIndex = 0;
			//
			//Panel1
			//
			this.Panel1.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Right);
			this.Panel1.BackColor = System.Drawing.Color.LightGray;
			this.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.Panel1.Controls.Add(this.Label7);
			this.Panel1.Controls.Add(this.lbExcludeExts);
			this.Panel1.Controls.Add(this.Label6);
			this.Panel1.Controls.Add(this.Label5);
			this.Panel1.Controls.Add(this.lbAvailExts);
			this.Panel1.Controls.Add(this.lbIncludeExts);
			this.Panel1.Controls.Add(this.Button3);
			this.Panel1.Controls.Add(this.btnRemoveExclude);
			this.Panel1.Controls.Add(this.btnInclFileType);
			this.Panel1.Controls.Add(this.btnExclude);
			this.Panel1.Location = new System.Drawing.Point(606, 16);
			this.Panel1.Name = "Panel1";
			this.Panel1.Size = new System.Drawing.Size(291, 238);
			this.Panel1.TabIndex = 78;
			//
			//Label7
			//
			this.Label7.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label7.AutoSize = true;
			this.Label7.Location = new System.Drawing.Point(111, 0);
			this.Label7.Name = "Label7";
			this.Label7.Size = new System.Drawing.Size(54, 13);
			this.Label7.TabIndex = 47;
			this.Label7.Text = "Excluded:";
			//
			//lbExcludeExts
			//
			this.lbExcludeExts.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Right);
			this.lbExcludeExts.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.lbExcludeExts.FormattingEnabled = true;
			this.lbExcludeExts.Location = new System.Drawing.Point(101, 16);
			this.lbExcludeExts.Name = "lbExcludeExts";
			this.lbExcludeExts.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lbExcludeExts.Size = new System.Drawing.Size(75, 147);
			this.lbExcludeExts.Sorted = true;
			this.lbExcludeExts.TabIndex = 46;
			//
			//Label6
			//
			this.Label6.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label6.AutoSize = true;
			this.Label6.Location = new System.Drawing.Point(25, 0);
			this.Label6.Name = "Label6";
			this.Label6.Size = new System.Drawing.Size(51, 13);
			this.Label6.TabIndex = 32;
			this.Label6.Text = "Included:";
			//
			//Label5
			//
			this.Label5.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(201, 0);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(50, 13);
			this.Label5.TabIndex = 31;
			this.Label5.Text = "Available";
			//
			//lbAvailExts
			//
			this.lbAvailExts.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Right);
			this.lbAvailExts.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.lbAvailExts.FormattingEnabled = true;
			this.lbAvailExts.Location = new System.Drawing.Point(189, 16);
			this.lbAvailExts.Name = "lbAvailExts";
			this.lbAvailExts.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lbAvailExts.Size = new System.Drawing.Size(75, 147);
			this.lbAvailExts.Sorted = true;
			this.lbAvailExts.TabIndex = 30;
			//
			//lbIncludeExts
			//
			this.lbIncludeExts.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Right);
			this.lbIncludeExts.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.lbIncludeExts.FormattingEnabled = true;
			this.lbIncludeExts.Location = new System.Drawing.Point(13, 16);
			this.lbIncludeExts.Name = "lbIncludeExts";
			this.lbIncludeExts.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lbIncludeExts.Size = new System.Drawing.Size(75, 147);
			this.lbIncludeExts.Sorted = true;
			this.lbIncludeExts.TabIndex = 28;
			//
			//Button3
			//
			this.Button3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Button3.BackColor = System.Drawing.Color.Transparent;
			this.Button3.ForeColor = System.Drawing.Color.Black;
			this.Button3.Location = new System.Drawing.Point(13, 185);
			this.Button3.Name = "Button3";
			this.Button3.Size = new System.Drawing.Size(82, 24);
			this.Button3.TabIndex = 39;
			this.Button3.Text = "1. Remove";
			this.Button3.UseVisualStyleBackColor = false;
			//
			//btnRemoveExclude
			//
			this.btnRemoveExclude.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnRemoveExclude.BackColor = System.Drawing.Color.Transparent;
			this.btnRemoveExclude.ForeColor = System.Drawing.Color.Black;
			this.btnRemoveExclude.Location = new System.Drawing.Point(100, 185);
			this.btnRemoveExclude.Name = "btnRemoveExclude";
			this.btnRemoveExclude.Size = new System.Drawing.Size(82, 24);
			this.btnRemoveExclude.TabIndex = 48;
			this.btnRemoveExclude.Text = "2. Remove";
			this.btnRemoveExclude.UseVisualStyleBackColor = false;
			//
			//btnInclFileType
			//
			this.btnInclFileType.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnInclFileType.Location = new System.Drawing.Point(188, 185);
			this.btnInclFileType.Name = "btnInclFileType";
			this.btnInclFileType.Size = new System.Drawing.Size(82, 24);
			this.btnInclFileType.TabIndex = 35;
			this.btnInclFileType.Text = "3. Include";
			this.btnInclFileType.UseVisualStyleBackColor = true;
			//
			//btnExclude
			//
			this.btnExclude.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnExclude.Location = new System.Drawing.Point(188, 207);
			this.btnExclude.Name = "btnExclude";
			this.btnExclude.Size = new System.Drawing.Size(82, 24);
			this.btnExclude.TabIndex = 49;
			this.btnExclude.Text = "4. Exclude";
			this.btnExclude.UseVisualStyleBackColor = true;
			//
			//Panel3
			//
			this.Panel3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Panel3.BackColor = System.Drawing.Color.Gainsboro;
			this.Panel3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.Panel3.Controls.Add(this.btnAddDefaults);
			this.Panel3.Controls.Add(this.btnRefreshRebuild);
			this.Panel3.Controls.Add(this.Label12);
			this.Panel3.Controls.Add(this.btnDeleteDirProfile);
			this.Panel3.Controls.Add(this.btnUpdateDirectoryProfile);
			this.Panel3.Controls.Add(this.btnSaveDirProfile);
			this.Panel3.Controls.Add(this.btnApplyDirProfile);
			this.Panel3.Controls.Add(this.cbDirProfile);
			this.Panel3.Controls.Add(this.Label11);
			this.Panel3.Controls.Add(this.btnExclProfile);
			this.Panel3.Controls.Add(this.btnInclProfile);
			this.Panel3.Controls.Add(this.cbProfile);
			this.Panel3.Location = new System.Drawing.Point(607, 286);
			this.Panel3.Name = "Panel3";
			this.Panel3.Size = new System.Drawing.Size(290, 158);
			this.Panel3.TabIndex = 80;
			//
			//btnAddDefaults
			//
			this.btnAddDefaults.Location = new System.Drawing.Point(239, 24);
			this.btnAddDefaults.Name = "btnAddDefaults";
			this.btnAddDefaults.Size = new System.Drawing.Size(24, 23);
			this.btnAddDefaults.TabIndex = 74;
			this.btnAddDefaults.Text = "!";
			this.TT.SetToolTip(this.btnAddDefaults, "Reset default values.");
			this.btnAddDefaults.UseVisualStyleBackColor = true;
			//
			//btnRefreshRebuild
			//
			this.btnRefreshRebuild.ForeColor = System.Drawing.Color.Black;
			this.btnRefreshRebuild.Location = new System.Drawing.Point(239, 100);
			this.btnRefreshRebuild.Name = "btnRefreshRebuild";
			this.btnRefreshRebuild.Size = new System.Drawing.Size(24, 23);
			this.btnRefreshRebuild.TabIndex = 73;
			this.btnRefreshRebuild.Text = "@";
			this.TT.SetToolTip(this.btnRefreshRebuild, "Refreshes the list of available and existing profiles adding any missing default " + "members.");
			this.btnRefreshRebuild.UseVisualStyleBackColor = true;
			//
			//Label12
			//
			this.Label12.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label12.AutoSize = true;
			this.Label12.Location = new System.Drawing.Point(76, 85);
			this.Label12.Name = "Label12";
			this.Label12.Size = new System.Drawing.Size(111, 13);
			this.Label12.TabIndex = 72;
			this.Label12.Text = "Select Archive Profile:";
			//
			//btnDeleteDirProfile
			//
			this.btnDeleteDirProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnDeleteDirProfile.Location = new System.Drawing.Point(185, 128);
			this.btnDeleteDirProfile.Name = "btnDeleteDirProfile";
			this.btnDeleteDirProfile.Size = new System.Drawing.Size(44, 21);
			this.btnDeleteDirProfile.TabIndex = 71;
			this.btnDeleteDirProfile.Text = "Del";
			this.TT.SetToolTip(this.btnDeleteDirProfile, "Delete currently selected directory profile.");
			this.btnDeleteDirProfile.UseVisualStyleBackColor = true;
			//
			//btnUpdateDirectoryProfile
			//
			this.btnUpdateDirectoryProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnUpdateDirectoryProfile.Location = new System.Drawing.Point(134, 128);
			this.btnUpdateDirectoryProfile.Name = "btnUpdateDirectoryProfile";
			this.btnUpdateDirectoryProfile.Size = new System.Drawing.Size(44, 21);
			this.btnUpdateDirectoryProfile.TabIndex = 70;
			this.btnUpdateDirectoryProfile.Text = "Updt";
			this.TT.SetToolTip(this.btnUpdateDirectoryProfile, "Update selected directory profile to current settings");
			this.btnUpdateDirectoryProfile.UseVisualStyleBackColor = true;
			//
			//btnSaveDirProfile
			//
			this.btnSaveDirProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnSaveDirProfile.Location = new System.Drawing.Point(83, 128);
			this.btnSaveDirProfile.Name = "btnSaveDirProfile";
			this.btnSaveDirProfile.Size = new System.Drawing.Size(44, 21);
			this.btnSaveDirProfile.TabIndex = 69;
			this.btnSaveDirProfile.Text = "Save";
			this.TT.SetToolTip(this.btnSaveDirProfile, "Save current setup as NEW directory profile");
			this.btnSaveDirProfile.UseVisualStyleBackColor = true;
			//
			//btnApplyDirProfile
			//
			this.btnApplyDirProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnApplyDirProfile.Location = new System.Drawing.Point(32, 128);
			this.btnApplyDirProfile.Name = "btnApplyDirProfile";
			this.btnApplyDirProfile.Size = new System.Drawing.Size(44, 21);
			this.btnApplyDirProfile.TabIndex = 68;
			this.btnApplyDirProfile.Text = "Aply";
			this.TT.SetToolTip(this.btnApplyDirProfile, "Apply selected directory profile");
			this.btnApplyDirProfile.UseVisualStyleBackColor = true;
			//
			//cbDirProfile
			//
			this.cbDirProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbDirProfile.FormattingEnabled = true;
			this.cbDirProfile.Location = new System.Drawing.Point(32, 101);
			this.cbDirProfile.Name = "cbDirProfile";
			this.cbDirProfile.Size = new System.Drawing.Size(198, 21);
			this.cbDirProfile.TabIndex = 66;
			this.TT.SetToolTip(this.cbDirProfile, "Currently defined directory profiles");
			//
			//Label11
			//
			this.Label11.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label11.AutoSize = true;
			this.Label11.Location = new System.Drawing.Point(76, 7);
			this.Label11.Name = "Label11";
			this.Label11.Size = new System.Drawing.Size(111, 13);
			this.Label11.TabIndex = 64;
			this.Label11.Text = "Select Filetype Profile:";
			//
			//btnExclProfile
			//
			this.btnExclProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnExclProfile.Location = new System.Drawing.Point(135, 48);
			this.btnExclProfile.Name = "btnExclProfile";
			this.btnExclProfile.Size = new System.Drawing.Size(86, 28);
			this.btnExclProfile.TabIndex = 58;
			this.btnExclProfile.Text = "E&xclude";
			this.TT.SetToolTip(this.btnExclProfile, "Exclude selected profile.");
			this.btnExclProfile.UseVisualStyleBackColor = true;
			//
			//btnInclProfile
			//
			this.btnInclProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnInclProfile.Location = new System.Drawing.Point(41, 48);
			this.btnInclProfile.Name = "btnInclProfile";
			this.btnInclProfile.Size = new System.Drawing.Size(86, 28);
			this.btnInclProfile.TabIndex = 57;
			this.btnInclProfile.Text = "&Apply";
			this.TT.SetToolTip(this.btnInclProfile, "Include selected profile.");
			this.btnInclProfile.UseVisualStyleBackColor = true;
			//
			//cbProfile
			//
			this.cbProfile.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbProfile.FormattingEnabled = true;
			this.cbProfile.Location = new System.Drawing.Point(41, 23);
			this.cbProfile.Name = "cbProfile";
			this.cbProfile.Size = new System.Drawing.Size(180, 21);
			this.cbProfile.TabIndex = 56;
			//
			//Label8
			//
			this.Label8.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label8.AutoSize = true;
			this.Label8.ForeColor = System.Drawing.Color.White;
			this.Label8.Location = new System.Drawing.Point(45, 581);
			this.Label8.Name = "Label8";
			this.Label8.Size = new System.Drawing.Size(90, 13);
			this.Label8.TabIndex = 34;
			this.Label8.Text = "Select Repository";
			this.Label8.Visible = false;
			//
			//cbFileDB
			//
			this.cbFileDB.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbFileDB.Enabled = false;
			this.cbFileDB.FormattingEnabled = true;
			this.cbFileDB.Location = new System.Drawing.Point(48, 604);
			this.cbFileDB.Name = "cbFileDB";
			this.cbFileDB.Size = new System.Drawing.Size(182, 21);
			this.cbFileDB.Sorted = true;
			this.cbFileDB.TabIndex = 27;
			this.cbFileDB.Text = "ECMREPO";
			this.cbFileDB.Visible = false;
			//
			//btnAddDir
			//
			this.btnAddDir.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnAddDir.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (64)));
			this.btnAddDir.Location = new System.Drawing.Point(142, 576);
			this.btnAddDir.Name = "btnAddDir";
			this.btnAddDir.Size = new System.Drawing.Size(88, 23);
			this.btnAddDir.TabIndex = 10;
			this.btnAddDir.Text = "Include Dir";
			this.btnAddDir.UseVisualStyleBackColor = true;
			this.btnAddDir.Visible = false;
			//
			//PictureBox1
			//
			this.PictureBox1.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.PictureBox1.Image = (System.Drawing.Image) (resources.GetObject("PictureBox1.Image"));
			this.PictureBox1.Location = new System.Drawing.Point(748, 582);
			this.PictureBox1.Name = "PictureBox1";
			this.PictureBox1.Size = new System.Drawing.Size(37, 43);
			this.PictureBox1.TabIndex = 75;
			this.PictureBox1.TabStop = false;
			this.PictureBox1.Visible = false;
			this.PictureBox1.WaitOnLoad = true;
			//
			//ckTerminate
			//
			this.ckTerminate.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.ckTerminate.AutoSize = true;
			this.ckTerminate.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.ckTerminate.Location = new System.Drawing.Point(796, 608);
			this.ckTerminate.Name = "ckTerminate";
			this.ckTerminate.Size = new System.Drawing.Size(144, 17);
			this.ckTerminate.TabIndex = 66;
			this.ckTerminate.Text = "Teminate current archive";
			this.TT.SetToolTip(this.ckTerminate, "Check to terminate currently running archive.");
			this.ckTerminate.UseVisualStyleBackColor = true;
			//
			//ckPauseListener
			//
			this.ckPauseListener.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.ckPauseListener.AutoSize = true;
			this.ckPauseListener.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.ckPauseListener.Location = new System.Drawing.Point(796, 582);
			this.ckPauseListener.Name = "ckPauseListener";
			this.ckPauseListener.Size = new System.Drawing.Size(123, 17);
			this.ckPauseListener.TabIndex = 76;
			this.ckPauseListener.Text = "Pause ALL Listeners";
			this.TT.SetToolTip(this.ckPauseListener, "Check to pause ALL directory listeners.");
			this.ckPauseListener.UseVisualStyleBackColor = true;
			//
			//btnFetch
			//
			this.btnFetch.BackColor = System.Drawing.SystemColors.ButtonFace;
			this.btnFetch.Location = new System.Drawing.Point(215, 35);
			this.btnFetch.Name = "btnFetch";
			this.btnFetch.Size = new System.Drawing.Size(70, 27);
			this.btnFetch.TabIndex = 6;
			this.btnFetch.Text = "Fetch";
			this.TT.SetToolTip(this.btnFetch, "Retrieve the associated repositories.");
			this.btnFetch.UseVisualStyleBackColor = false;
			//
			//txtRssURL
			//
			this.txtRssURL.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtRssURL.Location = new System.Drawing.Point(32, 465);
			this.txtRssURL.Name = "txtRssURL";
			this.txtRssURL.Size = new System.Drawing.Size(725, 20);
			this.txtRssURL.TabIndex = 6;
			this.TT.SetToolTip(this.txtRssURL, "Enter the RSS URL on this line.");
			//
			//txtRssName
			//
			this.txtRssName.AcceptsReturn = true;
			this.txtRssName.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtRssName.Location = new System.Drawing.Point(32, 424);
			this.txtRssName.Name = "txtRssName";
			this.txtRssName.Size = new System.Drawing.Size(449, 20);
			this.txtRssName.TabIndex = 4;
			this.TT.SetToolTip(this.txtRssName, "The name would you like to identify this RSS feed.");
			//
			//txtWebScreenUrl
			//
			this.txtWebScreenUrl.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtWebScreenUrl.Location = new System.Drawing.Point(32, 452);
			this.txtWebScreenUrl.Name = "txtWebScreenUrl";
			this.txtWebScreenUrl.Size = new System.Drawing.Size(725, 20);
			this.txtWebScreenUrl.TabIndex = 14;
			this.TT.SetToolTip(this.txtWebScreenUrl, "Enter the WEB screen to monitor.");
			//
			//txtWebScreenName
			//
			this.txtWebScreenName.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.txtWebScreenName.Location = new System.Drawing.Point(32, 411);
			this.txtWebScreenName.Name = "txtWebScreenName";
			this.txtWebScreenName.Size = new System.Drawing.Size(397, 20);
			this.txtWebScreenName.TabIndex = 12;
			this.TT.SetToolTip(this.txtWebScreenName, "The nmae to identify this web site.");
			//
			//f1Help
			//
			this.f1Help.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/frmReconMain.htm";
			//
			//SB2
			//
			this.SB2.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.SB2.BackColor = System.Drawing.Color.Gainsboro;
			this.SB2.Location = new System.Drawing.Point(264, 605);
			this.SB2.Name = "SB2";
			this.SB2.Size = new System.Drawing.Size(468, 20);
			this.SB2.TabIndex = 44;
			//
			//PBx
			//
			this.PBx.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.PBx.Location = new System.Drawing.Point(25, 3);
			this.PBx.Name = "PBx";
			this.PBx.Size = new System.Drawing.Size(913, 18);
			this.PBx.TabIndex = 45;
			//
			//ContextMenuStrip1
			//
			this.ContextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ResetSelectedMailBoxesToolStripMenuItem, this.EmailLibraryReassignmentToolStripMenuItem});
			this.ContextMenuStrip1.Name = "ContextMenuStrip1";
			this.ContextMenuStrip1.Size = new System.Drawing.Size(209, 48);
			//
			//ResetSelectedMailBoxesToolStripMenuItem
			//
			this.ResetSelectedMailBoxesToolStripMenuItem.Name = "ResetSelectedMailBoxesToolStripMenuItem";
			this.ResetSelectedMailBoxesToolStripMenuItem.Size = new System.Drawing.Size(208, 22);
			this.ResetSelectedMailBoxesToolStripMenuItem.Text = "Reset Selected Mail Boxes";
			//
			//EmailLibraryReassignmentToolStripMenuItem
			//
			this.EmailLibraryReassignmentToolStripMenuItem.Name = "EmailLibraryReassignmentToolStripMenuItem";
			this.EmailLibraryReassignmentToolStripMenuItem.Size = new System.Drawing.Size(208, 22);
			this.EmailLibraryReassignmentToolStripMenuItem.Text = "Email Library Assignment";
			//
			//TimerListeners
			//
			this.TimerListeners.Interval = 60000;
			//
			//TimerUploadFiles
			//
			this.TimerUploadFiles.Interval = 30000;
			//
			//TimerEndRun
			//
			this.TimerEndRun.Interval = 30000;
			//
			//MenuStrip1
			//
			this.MenuStrip1.BackColor = System.Drawing.Color.Silver;
			this.MenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ArchiveToolStripMenuItem, this.LoginToolStripMenuItem, this.TasksToolStripMenuItem, this.HelpToolStripMenuItem, this.SelectionToolStripMenuItem, this.TestToolStripMenuItem, this.ExitToolStripMenuItem});
			this.MenuStrip1.Location = new System.Drawing.Point(0, 0);
			this.MenuStrip1.Name = "MenuStrip1";
			this.MenuStrip1.Size = new System.Drawing.Size(962, 24);
			this.MenuStrip1.TabIndex = 77;
			this.MenuStrip1.Text = "MenuStrip1";
			//
			//ArchiveToolStripMenuItem
			//
			this.ArchiveToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ArchiveALLToolStripMenuItem, this.OutlookEmailsToolStripMenuItem, this.ExchangeEmailsToolStripMenuItem, this.ContentToolStripMenuItem, this.ToolStripMenuItem1, this.ScheduleToolStripMenuItem, this.SetArchiveIntervalToolStripMenuItem, this.ToolStripSeparator6, this.ArchiveRSSPullsToolStripMenuItem, this.WebSitesToolStripMenuItem, this.WebPagesToolStripMenuItem, this.ToolStripSeparator5, this.ExitToolStripMenuItem1});
			this.ArchiveToolStripMenuItem.Name = "ArchiveToolStripMenuItem";
			this.ArchiveToolStripMenuItem.Size = new System.Drawing.Size(59, 20);
			this.ArchiveToolStripMenuItem.Text = "Archive";
			//
			//ArchiveALLToolStripMenuItem
			//
			this.ArchiveALLToolStripMenuItem.Name = "ArchiveALLToolStripMenuItem";
			this.ArchiveALLToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.ArchiveALLToolStripMenuItem.Text = "Archive ALL";
			//
			//OutlookEmailsToolStripMenuItem
			//
			this.OutlookEmailsToolStripMenuItem.Name = "OutlookEmailsToolStripMenuItem";
			this.OutlookEmailsToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.OutlookEmailsToolStripMenuItem.Text = "Outlook Emails";
			//
			//ExchangeEmailsToolStripMenuItem
			//
			this.ExchangeEmailsToolStripMenuItem.Name = "ExchangeEmailsToolStripMenuItem";
			this.ExchangeEmailsToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.ExchangeEmailsToolStripMenuItem.Text = "Exchange Emails";
			//
			//ContentToolStripMenuItem
			//
			this.ContentToolStripMenuItem.Name = "ContentToolStripMenuItem";
			this.ContentToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.ContentToolStripMenuItem.Text = "Content";
			//
			//ToolStripMenuItem1
			//
			this.ToolStripMenuItem1.Name = "ToolStripMenuItem1";
			this.ToolStripMenuItem1.Size = new System.Drawing.Size(175, 22);
			this.ToolStripMenuItem1.Text = "Outlook Contacts";
			//
			//ScheduleToolStripMenuItem
			//
			this.ScheduleToolStripMenuItem.Name = "ScheduleToolStripMenuItem";
			this.ScheduleToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.ScheduleToolStripMenuItem.Text = "Schedule";
			//
			//SetArchiveIntervalToolStripMenuItem
			//
			this.SetArchiveIntervalToolStripMenuItem.Name = "SetArchiveIntervalToolStripMenuItem";
			this.SetArchiveIntervalToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.SetArchiveIntervalToolStripMenuItem.Text = "Set Archive Interval";
			//
			//ToolStripSeparator6
			//
			this.ToolStripSeparator6.Name = "ToolStripSeparator6";
			this.ToolStripSeparator6.Size = new System.Drawing.Size(172, 6);
			//
			//ArchiveRSSPullsToolStripMenuItem
			//
			this.ArchiveRSSPullsToolStripMenuItem.Name = "ArchiveRSSPullsToolStripMenuItem";
			this.ArchiveRSSPullsToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.ArchiveRSSPullsToolStripMenuItem.Text = "Archive RSS Pulls";
			//
			//WebSitesToolStripMenuItem
			//
			this.WebSitesToolStripMenuItem.Name = "WebSitesToolStripMenuItem";
			this.WebSitesToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.WebSitesToolStripMenuItem.Text = "Archive Web Sites";
			//
			//WebPagesToolStripMenuItem
			//
			this.WebPagesToolStripMenuItem.Name = "WebPagesToolStripMenuItem";
			this.WebPagesToolStripMenuItem.Size = new System.Drawing.Size(175, 22);
			this.WebPagesToolStripMenuItem.Text = "Archive Web Pages";
			//
			//ToolStripSeparator5
			//
			this.ToolStripSeparator5.Name = "ToolStripSeparator5";
			this.ToolStripSeparator5.Size = new System.Drawing.Size(172, 6);
			//
			//ExitToolStripMenuItem1
			//
			this.ExitToolStripMenuItem1.Name = "ExitToolStripMenuItem1";
			this.ExitToolStripMenuItem1.Size = new System.Drawing.Size(175, 22);
			this.ExitToolStripMenuItem1.Text = "Exit";
			//
			//LoginToolStripMenuItem
			//
			this.LoginToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.LoginToSystemToolStripMenuItem, this.ChangeUserPasswordToolStripMenuItem});
			this.LoginToolStripMenuItem.Name = "LoginToolStripMenuItem";
			this.LoginToolStripMenuItem.Size = new System.Drawing.Size(49, 20);
			this.LoginToolStripMenuItem.Text = "Login";
			//
			//LoginToSystemToolStripMenuItem
			//
			this.LoginToSystemToolStripMenuItem.Name = "LoginToSystemToolStripMenuItem";
			this.LoginToSystemToolStripMenuItem.Size = new System.Drawing.Size(194, 22);
			this.LoginToSystemToolStripMenuItem.Text = "Login To System";
			//
			//ChangeUserPasswordToolStripMenuItem
			//
			this.ChangeUserPasswordToolStripMenuItem.Name = "ChangeUserPasswordToolStripMenuItem";
			this.ChangeUserPasswordToolStripMenuItem.Size = new System.Drawing.Size(194, 22);
			this.ChangeUserPasswordToolStripMenuItem.Text = "Change User Password";
			//
			//TasksToolStripMenuItem
			//
			this.TasksToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ImpersonateLoginToolStripMenuItem, this.LoginAsDifferenctUserToolStripMenuItem, this.ManualEditAppConfigToolStripMenuItem, this.ViewLogsToolStripMenuItem, this.ViewOCRErrorFilesToolStripMenuItem, this.AddDesktopIconToolStripMenuItem, this.UtilityToolStripMenuItem});
			this.TasksToolStripMenuItem.Name = "TasksToolStripMenuItem";
			this.TasksToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
			this.TasksToolStripMenuItem.Text = "Tasks";
			//
			//ImpersonateLoginToolStripMenuItem
			//
			this.ImpersonateLoginToolStripMenuItem.Name = "ImpersonateLoginToolStripMenuItem";
			this.ImpersonateLoginToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.ImpersonateLoginToolStripMenuItem.Text = "Archiver Login";
			this.ImpersonateLoginToolStripMenuItem.ToolTipText = "Set the login here that will be automatically used for archives on this machine.";
			this.ImpersonateLoginToolStripMenuItem.Visible = false;
			//
			//LoginAsDifferenctUserToolStripMenuItem
			//
			this.LoginAsDifferenctUserToolStripMenuItem.Name = "LoginAsDifferenctUserToolStripMenuItem";
			this.LoginAsDifferenctUserToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.LoginAsDifferenctUserToolStripMenuItem.Text = "Login as different User";
			this.LoginAsDifferenctUserToolStripMenuItem.ToolTipText = "Press to login under a different user ID.";
			//
			//ManualEditAppConfigToolStripMenuItem
			//
			this.ManualEditAppConfigToolStripMenuItem.Name = "ManualEditAppConfigToolStripMenuItem";
			this.ManualEditAppConfigToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.ManualEditAppConfigToolStripMenuItem.Text = "(Manual Edit) App Config";
			this.ManualEditAppConfigToolStripMenuItem.ToolTipText = "Use with great care.";
			//
			//ViewLogsToolStripMenuItem
			//
			this.ViewLogsToolStripMenuItem.Name = "ViewLogsToolStripMenuItem";
			this.ViewLogsToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.ViewLogsToolStripMenuItem.Text = "View Logs";
			//
			//ViewOCRErrorFilesToolStripMenuItem
			//
			this.ViewOCRErrorFilesToolStripMenuItem.Name = "ViewOCRErrorFilesToolStripMenuItem";
			this.ViewOCRErrorFilesToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.ViewOCRErrorFilesToolStripMenuItem.Text = "View OCR Error Files";
			this.ViewOCRErrorFilesToolStripMenuItem.Visible = false;
			//
			//AddDesktopIconToolStripMenuItem
			//
			this.AddDesktopIconToolStripMenuItem.Name = "AddDesktopIconToolStripMenuItem";
			this.AddDesktopIconToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.AddDesktopIconToolStripMenuItem.Text = "Add Desktop Icon";
			//
			//UtilityToolStripMenuItem
			//
			this.UtilityToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.EncryptStringToolStripMenuItem, this.InstallCLCToolStripMenuItem, this.ResetPerformanceFilesToolStripMenuItem, this.ReOCRToolStripMenuItem, this.ResetEMAILCRCCodesToolStripMenuItem, this.RetentionManagementToolStripMenuItem});
			this.UtilityToolStripMenuItem.Name = "UtilityToolStripMenuItem";
			this.UtilityToolStripMenuItem.Size = new System.Drawing.Size(209, 22);
			this.UtilityToolStripMenuItem.Text = "Utility";
			//
			//EncryptStringToolStripMenuItem
			//
			this.EncryptStringToolStripMenuItem.Name = "EncryptStringToolStripMenuItem";
			this.EncryptStringToolStripMenuItem.Size = new System.Drawing.Size(223, 22);
			this.EncryptStringToolStripMenuItem.Text = "Encrypt String";
			this.EncryptStringToolStripMenuItem.ToolTipText = "Use this function to encrypt a string for use in ECM Library.";
			//
			//InstallCLCToolStripMenuItem
			//
			this.InstallCLCToolStripMenuItem.Name = "InstallCLCToolStripMenuItem";
			this.InstallCLCToolStripMenuItem.Size = new System.Drawing.Size(223, 22);
			this.InstallCLCToolStripMenuItem.Text = "Install CLC";
			this.InstallCLCToolStripMenuItem.Visible = false;
			//
			//ResetPerformanceFilesToolStripMenuItem
			//
			this.ResetPerformanceFilesToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.CEDatabasesToolStripMenuItem, this.ZIPFilesArchivesToolStripMenuItem, this.GetOutlookEmailIDsToolStripMenuItem, this.ToolStripSeparator2, this.AllToolStripMenuItem1, this.ToolStripSeparator1, this.InstallCESP2ToolStripMenuItem1, this.ToolStripMenuItem2, this.ViewCEDirectoriesToolStripMenuItem1});
			this.ResetPerformanceFilesToolStripMenuItem.Name = "ResetPerformanceFilesToolStripMenuItem";
			this.ResetPerformanceFilesToolStripMenuItem.Size = new System.Drawing.Size(223, 22);
			this.ResetPerformanceFilesToolStripMenuItem.Text = "Performance Files";
			//
			//CEDatabasesToolStripMenuItem
			//
			this.CEDatabasesToolStripMenuItem.Name = "CEDatabasesToolStripMenuItem";
			this.CEDatabasesToolStripMenuItem.Size = new System.Drawing.Size(196, 22);
			this.CEDatabasesToolStripMenuItem.Text = "Reset CE Databases";
			this.CEDatabasesToolStripMenuItem.ToolTipText = "Press to force a full inventory and validation of all content next archive.";
			//
			//ZIPFilesArchivesToolStripMenuItem
			//
			this.ZIPFilesArchivesToolStripMenuItem.Name = "ZIPFilesArchivesToolStripMenuItem";
			this.ZIPFilesArchivesToolStripMenuItem.Size = new System.Drawing.Size(196, 22);
			this.ZIPFilesArchivesToolStripMenuItem.Text = "Reset ZIP Files Archives";
			this.ZIPFilesArchivesToolStripMenuItem.ToolTipText = "Press to force all ZIP files to be fully evaluated during the next archive.";
			//
			//GetOutlookEmailIDsToolStripMenuItem
			//
			this.GetOutlookEmailIDsToolStripMenuItem.Name = "GetOutlookEmailIDsToolStripMenuItem";
			this.GetOutlookEmailIDsToolStripMenuItem.Size = new System.Drawing.Size(196, 22);
			this.GetOutlookEmailIDsToolStripMenuItem.Text = "Get Outlook Email IDs";
			this.GetOutlookEmailIDsToolStripMenuItem.ToolTipText = "Fetches all of your outlook email identifiers from the server for validation.";
			//
			//ToolStripSeparator2
			//
			this.ToolStripSeparator2.Name = "ToolStripSeparator2";
			this.ToolStripSeparator2.Size = new System.Drawing.Size(193, 6);
			//
			//AllToolStripMenuItem1
			//
			this.AllToolStripMenuItem1.Name = "AllToolStripMenuItem1";
			this.AllToolStripMenuItem1.Size = new System.Drawing.Size(196, 22);
			this.AllToolStripMenuItem1.Text = "Reset All";
			this.AllToolStripMenuItem1.ToolTipText = "Press to force revalidation of all content and locations during the next archive." + "";
			//
			//ToolStripSeparator1
			//
			this.ToolStripSeparator1.Name = "ToolStripSeparator1";
			this.ToolStripSeparator1.Size = new System.Drawing.Size(193, 6);
			//
			//InstallCESP2ToolStripMenuItem1
			//
			this.InstallCESP2ToolStripMenuItem1.Name = "InstallCESP2ToolStripMenuItem1";
			this.InstallCESP2ToolStripMenuItem1.Size = new System.Drawing.Size(196, 22);
			this.InstallCESP2ToolStripMenuItem1.Text = "Install CE SP2";
			this.InstallCESP2ToolStripMenuItem1.ToolTipText = "Microsoft CE database requires service pack 2. Press to install on your local mac" + "hine.";
			//
			//ToolStripMenuItem2
			//
			this.ToolStripMenuItem2.Name = "ToolStripMenuItem2";
			this.ToolStripMenuItem2.Size = new System.Drawing.Size(196, 22);
			this.ToolStripMenuItem2.Text = "Mirror CE Databases";
			this.ToolStripMenuItem2.ToolTipText = "Backup the local CE databases.";
			//
			//ViewCEDirectoriesToolStripMenuItem1
			//
			this.ViewCEDirectoriesToolStripMenuItem1.Name = "ViewCEDirectoriesToolStripMenuItem1";
			this.ViewCEDirectoriesToolStripMenuItem1.Size = new System.Drawing.Size(196, 22);
			this.ViewCEDirectoriesToolStripMenuItem1.Text = "View CE Directories";
			this.ViewCEDirectoriesToolStripMenuItem1.ToolTipText = "Open the CE Database directory for viewing.";
			//
			//ReOCRToolStripMenuItem
			//
			this.ReOCRToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.EstimateNumberOfFilesToolStripMenuItem, this.ToolStripSeparator3, this.ReOcrIncompleteGraphicFilesToolStripMenuItem, this.ReOcrALLGraphicFilesToolStripMenuItem1});
			this.ReOCRToolStripMenuItem.Name = "ReOCRToolStripMenuItem";
			this.ReOCRToolStripMenuItem.Size = new System.Drawing.Size(223, 22);
			this.ReOCRToolStripMenuItem.Text = "Re-OCR";
			this.ReOCRToolStripMenuItem.Visible = false;
			//
			//EstimateNumberOfFilesToolStripMenuItem
			//
			this.EstimateNumberOfFilesToolStripMenuItem.Name = "EstimateNumberOfFilesToolStripMenuItem";
			this.EstimateNumberOfFilesToolStripMenuItem.Size = new System.Drawing.Size(242, 22);
			this.EstimateNumberOfFilesToolStripMenuItem.Text = "Estimate number of Files";
			//
			//ToolStripSeparator3
			//
			this.ToolStripSeparator3.Name = "ToolStripSeparator3";
			this.ToolStripSeparator3.Size = new System.Drawing.Size(239, 6);
			//
			//ReOcrIncompleteGraphicFilesToolStripMenuItem
			//
			this.ReOcrIncompleteGraphicFilesToolStripMenuItem.Name = "ReOcrIncompleteGraphicFilesToolStripMenuItem";
			this.ReOcrIncompleteGraphicFilesToolStripMenuItem.Size = new System.Drawing.Size(242, 22);
			this.ReOcrIncompleteGraphicFilesToolStripMenuItem.Text = "Re-Ocr Incomplete Graphic files";
			//
			//ReOcrALLGraphicFilesToolStripMenuItem1
			//
			this.ReOcrALLGraphicFilesToolStripMenuItem1.Name = "ReOcrALLGraphicFilesToolStripMenuItem1";
			this.ReOcrALLGraphicFilesToolStripMenuItem1.Size = new System.Drawing.Size(242, 22);
			this.ReOcrALLGraphicFilesToolStripMenuItem1.Text = "Re-Ocr ALL Graphic files";
			//
			//ResetEMAILCRCCodesToolStripMenuItem
			//
			this.ResetEMAILCRCCodesToolStripMenuItem.Name = "ResetEMAILCRCCodesToolStripMenuItem";
			this.ResetEMAILCRCCodesToolStripMenuItem.Size = new System.Drawing.Size(223, 22);
			this.ResetEMAILCRCCodesToolStripMenuItem.Text = "Reset EMAIL Identifier codes";
			this.ResetEMAILCRCCodesToolStripMenuItem.ToolTipText = "Inventory and validate local emails to those already stored in the repository.";
			//
			//RetentionManagementToolStripMenuItem
			//
			this.RetentionManagementToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.RetentionRulesToolStripMenuItem, this.RulesExecutionToolStripMenuItem});
			this.RetentionManagementToolStripMenuItem.Name = "RetentionManagementToolStripMenuItem";
			this.RetentionManagementToolStripMenuItem.Size = new System.Drawing.Size(223, 22);
			this.RetentionManagementToolStripMenuItem.Text = "Retention Management";
			//
			//RetentionRulesToolStripMenuItem
			//
			this.RetentionRulesToolStripMenuItem.Name = "RetentionRulesToolStripMenuItem";
			this.RetentionRulesToolStripMenuItem.Size = new System.Drawing.Size(156, 22);
			this.RetentionRulesToolStripMenuItem.Text = "Retention Rules";
			//
			//RulesExecutionToolStripMenuItem
			//
			this.RulesExecutionToolStripMenuItem.Name = "RulesExecutionToolStripMenuItem";
			this.RulesExecutionToolStripMenuItem.Size = new System.Drawing.Size(156, 22);
			this.RulesExecutionToolStripMenuItem.Text = "Rules Execution";
			//
			//HelpToolStripMenuItem
			//
			this.HelpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.AboutToolStripMenuItem, this.OnlineHelpToolStripMenuItem, this.ToolStripSeparator4, this.AppConfigVersionToolStripMenuItem, this.RunningArchiverToolStripMenuItem, this.ParameterExecutionToolStripMenuItem, this.HistoryToolStripMenuItem});
			this.HelpToolStripMenuItem.Name = "HelpToolStripMenuItem";
			this.HelpToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
			this.HelpToolStripMenuItem.Text = "Help";
			//
			//AboutToolStripMenuItem
			//
			this.AboutToolStripMenuItem.Name = "AboutToolStripMenuItem";
			this.AboutToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.AboutToolStripMenuItem.Text = "About";
			//
			//OnlineHelpToolStripMenuItem
			//
			this.OnlineHelpToolStripMenuItem.Name = "OnlineHelpToolStripMenuItem";
			this.OnlineHelpToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.OnlineHelpToolStripMenuItem.Text = "On-line Help";
			//
			//ToolStripSeparator4
			//
			this.ToolStripSeparator4.Name = "ToolStripSeparator4";
			this.ToolStripSeparator4.Size = new System.Drawing.Size(179, 6);
			//
			//AppConfigVersionToolStripMenuItem
			//
			this.AppConfigVersionToolStripMenuItem.Name = "AppConfigVersionToolStripMenuItem";
			this.AppConfigVersionToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.AppConfigVersionToolStripMenuItem.Text = "App Config Version";
			//
			//RunningArchiverToolStripMenuItem
			//
			this.RunningArchiverToolStripMenuItem.Name = "RunningArchiverToolStripMenuItem";
			this.RunningArchiverToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.RunningArchiverToolStripMenuItem.Text = "Running Archiver";
			//
			//ParameterExecutionToolStripMenuItem
			//
			this.ParameterExecutionToolStripMenuItem.Name = "ParameterExecutionToolStripMenuItem";
			this.ParameterExecutionToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.ParameterExecutionToolStripMenuItem.Text = "Parameter Execution";
			//
			//HistoryToolStripMenuItem
			//
			this.HistoryToolStripMenuItem.Name = "HistoryToolStripMenuItem";
			this.HistoryToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.HistoryToolStripMenuItem.Text = "History";
			//
			//SelectionToolStripMenuItem
			//
			this.SelectionToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.AllToolStripMenuItem, this.EmailToolStripMenuItem, this.ContentToolStripMenuItem1, this.ExecutionControlToolStripMenuItem, this.FileTypesToolStripMenuItem});
			this.SelectionToolStripMenuItem.Name = "SelectionToolStripMenuItem";
			this.SelectionToolStripMenuItem.Size = new System.Drawing.Size(67, 20);
			this.SelectionToolStripMenuItem.Text = "Selection";
			//
			//AllToolStripMenuItem
			//
			this.AllToolStripMenuItem.Name = "AllToolStripMenuItem";
			this.AllToolStripMenuItem.Size = new System.Drawing.Size(168, 22);
			this.AllToolStripMenuItem.Text = "All";
			//
			//EmailToolStripMenuItem
			//
			this.EmailToolStripMenuItem.Name = "EmailToolStripMenuItem";
			this.EmailToolStripMenuItem.Size = new System.Drawing.Size(168, 22);
			this.EmailToolStripMenuItem.Text = "Email";
			//
			//ContentToolStripMenuItem1
			//
			this.ContentToolStripMenuItem1.Name = "ContentToolStripMenuItem1";
			this.ContentToolStripMenuItem1.Size = new System.Drawing.Size(168, 22);
			this.ContentToolStripMenuItem1.Text = "Content";
			//
			//ExecutionControlToolStripMenuItem
			//
			this.ExecutionControlToolStripMenuItem.Name = "ExecutionControlToolStripMenuItem";
			this.ExecutionControlToolStripMenuItem.Size = new System.Drawing.Size(168, 22);
			this.ExecutionControlToolStripMenuItem.Text = "Execution Control";
			//
			//FileTypesToolStripMenuItem
			//
			this.FileTypesToolStripMenuItem.Name = "FileTypesToolStripMenuItem";
			this.FileTypesToolStripMenuItem.Size = new System.Drawing.Size(168, 22);
			this.FileTypesToolStripMenuItem.Text = "File Types";
			//
			//TestToolStripMenuItem
			//
			this.TestToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.DirectoryInventoryToolStripMenuItem, this.ListFilesInDirectoryToolStripMenuItem, this.GetAllSubdirFilesToolStripMenuItem, this.OCRToolStripMenuItem, this.FileHashToolStripMenuItem, this.FileUploadToolStripMenuItem, this.FileUploadBufferedToolStripMenuItem, this.FileChunkUploadToolStripMenuItem, this.RSSPullToolStripMenuItem});
			this.TestToolStripMenuItem.Name = "TestToolStripMenuItem";
			this.TestToolStripMenuItem.Size = new System.Drawing.Size(41, 20);
			this.TestToolStripMenuItem.Text = "Test";
			//
			//DirectoryInventoryToolStripMenuItem
			//
			this.DirectoryInventoryToolStripMenuItem.Name = "DirectoryInventoryToolStripMenuItem";
			this.DirectoryInventoryToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.DirectoryInventoryToolStripMenuItem.Text = "Directory Inventory";
			//
			//ListFilesInDirectoryToolStripMenuItem
			//
			this.ListFilesInDirectoryToolStripMenuItem.Name = "ListFilesInDirectoryToolStripMenuItem";
			this.ListFilesInDirectoryToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.ListFilesInDirectoryToolStripMenuItem.Text = "List Files in Directory";
			//
			//GetAllSubdirFilesToolStripMenuItem
			//
			this.GetAllSubdirFilesToolStripMenuItem.Name = "GetAllSubdirFilesToolStripMenuItem";
			this.GetAllSubdirFilesToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.GetAllSubdirFilesToolStripMenuItem.Text = "Get All Subdir Files";
			//
			//OCRToolStripMenuItem
			//
			this.OCRToolStripMenuItem.Name = "OCRToolStripMenuItem";
			this.OCRToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.OCRToolStripMenuItem.Text = "OCR";
			//
			//FileHashToolStripMenuItem
			//
			this.FileHashToolStripMenuItem.Name = "FileHashToolStripMenuItem";
			this.FileHashToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.FileHashToolStripMenuItem.Text = "File Hash";
			//
			//FileUploadToolStripMenuItem
			//
			this.FileUploadToolStripMenuItem.Name = "FileUploadToolStripMenuItem";
			this.FileUploadToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.FileUploadToolStripMenuItem.Text = "File Upload File";
			//
			//FileUploadBufferedToolStripMenuItem
			//
			this.FileUploadBufferedToolStripMenuItem.Name = "FileUploadBufferedToolStripMenuItem";
			this.FileUploadBufferedToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.FileUploadBufferedToolStripMenuItem.Text = "File Upload Buffered";
			//
			//FileChunkUploadToolStripMenuItem
			//
			this.FileChunkUploadToolStripMenuItem.Name = "FileChunkUploadToolStripMenuItem";
			this.FileChunkUploadToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.FileChunkUploadToolStripMenuItem.Text = "File Chunk Upload";
			//
			//RSSPullToolStripMenuItem
			//
			this.RSSPullToolStripMenuItem.Name = "RSSPullToolStripMenuItem";
			this.RSSPullToolStripMenuItem.Size = new System.Drawing.Size(182, 22);
			this.RSSPullToolStripMenuItem.Text = "RSS Pull";
			//
			//ExitToolStripMenuItem
			//
			this.ExitToolStripMenuItem.Name = "ExitToolStripMenuItem";
			this.ExitToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
			this.ExitToolStripMenuItem.Text = "Exit";
			//
			//StatusStrip1
			//
			this.StatusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.infoDaysToExpire, this.tssServer, this.tssVersion, this.tssAuth, this.tssUser, this.tbExchange, this.PB1, this.tsStatus02, this.SB5, this.ToolStripStatusLabel1, this.tsBytesLoading, this.tsServiceDBConnState, this.tsTunnelConn, this.tsCurrentRepoID, this.tsLastArchive, this.tsTimeToArchive, this.tsCountDown});
			this.StatusStrip1.Location = new System.Drawing.Point(0, 639);
			this.StatusStrip1.Name = "StatusStrip1";
			this.StatusStrip1.Size = new System.Drawing.Size(962, 22);
			this.StatusStrip1.TabIndex = 78;
			this.StatusStrip1.Text = "StatusStrip1";
			//
			//infoDaysToExpire
			//
			this.infoDaysToExpire.ForeColor = System.Drawing.Color.Yellow;
			this.infoDaysToExpire.Name = "infoDaysToExpire";
			this.infoDaysToExpire.Size = new System.Drawing.Size(32, 17);
			this.infoDaysToExpire.Text = "Days";
			//
			//tssServer
			//
			this.tssServer.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tssServer.Name = "tssServer";
			this.tssServer.Size = new System.Drawing.Size(39, 17);
			this.tssServer.Text = "Server";
			//
			//tssVersion
			//
			this.tssVersion.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tssVersion.Name = "tssVersion";
			this.tssVersion.Size = new System.Drawing.Size(46, 17);
			this.tssVersion.Text = "Version";
			//
			//tssAuth
			//
			this.tssAuth.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tssAuth.Name = "tssAuth";
			this.tssAuth.Size = new System.Drawing.Size(57, 17);
			this.tssAuth.Text = "Authority";
			//
			//tssUser
			//
			this.tssUser.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tssUser.Name = "tssUser";
			this.tssUser.Size = new System.Drawing.Size(30, 17);
			this.tssUser.Text = "User";
			//
			//tbExchange
			//
			this.tbExchange.ForeColor = System.Drawing.SystemColors.ControlLightLight;
			this.tbExchange.Name = "tbExchange";
			this.tbExchange.Size = new System.Drawing.Size(16, 17);
			this.tbExchange.Text = "...";
			//
			//PB1
			//
			this.PB1.Name = "PB1";
			this.PB1.Size = new System.Drawing.Size(100, 16);
			//
			//tsStatus02
			//
			this.tsStatus02.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tsStatus02.Name = "tsStatus02";
			this.tsStatus02.Size = new System.Drawing.Size(39, 17);
			this.tsStatus02.Text = "Status";
			//
			//SB5
			//
			this.SB5.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.SB5.Name = "SB5";
			this.SB5.Size = new System.Drawing.Size(40, 17);
			this.SB5.Text = "Active";
			this.SB5.ToolTipText = "Status";
			//
			//ToolStripStatusLabel1
			//
			this.ToolStripStatusLabel1.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.ToolStripStatusLabel1.Name = "ToolStripStatusLabel1";
			this.ToolStripStatusLabel1.Size = new System.Drawing.Size(40, 17);
			this.ToolStripStatusLabel1.Text = "Active";
			this.ToolStripStatusLabel1.ToolTipText = "Connection Status";
			//
			//tsBytesLoading
			//
			this.tsBytesLoading.ForeColor = System.Drawing.Color.Yellow;
			this.tsBytesLoading.Name = "tsBytesLoading";
			this.tsBytesLoading.Size = new System.Drawing.Size(56, 17);
			this.tsBytesLoading.Text = "File Bytes";
			this.tsBytesLoading.ToolTipText = "The number of bytes loading in the current file.";
			//
			//tsServiceDBConnState
			//
			this.tsServiceDBConnState.ForeColor = System.Drawing.Color.White;
			this.tsServiceDBConnState.Name = "tsServiceDBConnState";
			this.tsServiceDBConnState.Size = new System.Drawing.Size(74, 17);
			this.tsServiceDBConnState.Text = "Cloud Status";
			this.tsServiceDBConnState.ToolTipText = "Shows the current status of the Cloud Connection.";
			//
			//tsTunnelConn
			//
			this.tsTunnelConn.ForeColor = System.Drawing.Color.White;
			this.tsTunnelConn.Name = "tsTunnelConn";
			this.tsTunnelConn.Size = new System.Drawing.Size(79, 17);
			this.tsTunnelConn.Text = "Tunnel Status";
			this.tsTunnelConn.ToolTipText = "If YES, the tunnel connection is valid.";
			//
			//tsCurrentRepoID
			//
			this.tsCurrentRepoID.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tsCurrentRepoID.Name = "tsCurrentRepoID";
			this.tsCurrentRepoID.Size = new System.Drawing.Size(45, 17);
			this.tsCurrentRepoID.Text = "RepoID";
			//
			//tsLastArchive
			//
			this.tsLastArchive.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
			this.tsLastArchive.Name = "tsLastArchive";
			this.tsLastArchive.Size = new System.Drawing.Size(71, 17);
			this.tsLastArchive.Text = "Last Archive";
			this.tsLastArchive.ToolTipText = "Last Archive Date";
			//
			//tsTimeToArchive
			//
			this.tsTimeToArchive.ForeColor = System.Drawing.Color.White;
			this.tsTimeToArchive.Name = "tsTimeToArchive";
			this.tsTimeToArchive.Size = new System.Drawing.Size(74, 17);
			this.tsTimeToArchive.Text = "Next Archive";
			this.tsTimeToArchive.ToolTipText = "Next Archive Time";
			//
			//tsCountDown
			//
			this.tsCountDown.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (128)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)));
			this.tsCountDown.Name = "tsCountDown";
			this.tsCountDown.Size = new System.Drawing.Size(49, 17);
			this.tsCountDown.Text = "00:00:00";
			//
			//TimerQuickArchive
			//
			this.TimerQuickArchive.Enabled = true;
			this.TimerQuickArchive.Interval = 60000;
			//
			//TabControl1
			//
			this.TabControl1.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.TabControl1.Controls.Add(this.TabPage1);
			this.TabControl1.Controls.Add(this.TabPage2);
			this.TabControl1.Controls.Add(this.TabPage4);
			this.TabControl1.Controls.Add(this.TabPage5);
			this.TabControl1.Controls.Add(this.TabPage6);
			this.TabControl1.Controls.Add(this.TabPage3);
			this.TabControl1.Location = new System.Drawing.Point(12, 38);
			this.TabControl1.Name = "TabControl1";
			this.TabControl1.SelectedIndex = 0;
			this.TabControl1.Size = new System.Drawing.Size(938, 527);
			this.TabControl1.TabIndex = 79;
			//
			//TabPage1
			//
			this.TabPage1.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)));
			this.TabPage1.Controls.Add(this.gbEmail);
			this.TabPage1.Location = new System.Drawing.Point(4, 22);
			this.TabPage1.Name = "TabPage1";
			this.TabPage1.Padding = new System.Windows.Forms.Padding(3);
			this.TabPage1.Size = new System.Drawing.Size(930, 501);
			this.TabPage1.TabIndex = 0;
			this.TabPage1.Text = "Email";
			//
			//TabPage2
			//
			this.TabPage2.Controls.Add(this.gbContentMgt);
			this.TabPage2.Location = new System.Drawing.Point(4, 22);
			this.TabPage2.Name = "TabPage2";
			this.TabPage2.Padding = new System.Windows.Forms.Padding(3);
			this.TabPage2.Size = new System.Drawing.Size(930, 501);
			this.TabPage2.TabIndex = 1;
			this.TabPage2.Text = "Documents";
			this.TabPage2.UseVisualStyleBackColor = true;
			//
			//TabPage4
			//
			this.TabPage4.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (64)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)));
			this.TabPage4.Controls.Add(this.cbRssRetention);
			this.TabPage4.Controls.Add(this.Label31);
			this.TabPage4.Controls.Add(this.dgRss);
			this.TabPage4.Controls.Add(this.btnRemoveRSSfeed);
			this.TabPage4.Controls.Add(this.btnAddRssFeed);
			this.TabPage4.Controls.Add(this.txtRssURL);
			this.TabPage4.Controls.Add(this.Label22);
			this.TabPage4.Controls.Add(this.txtRssName);
			this.TabPage4.Controls.Add(this.Label21);
			this.TabPage4.Controls.Add(this.Label20);
			this.TabPage4.Controls.Add(this.Label17);
			this.TabPage4.Location = new System.Drawing.Point(4, 22);
			this.TabPage4.Name = "TabPage4";
			this.TabPage4.Size = new System.Drawing.Size(930, 501);
			this.TabPage4.TabIndex = 3;
			this.TabPage4.Text = "RSS";
			//
			//cbRssRetention
			//
			this.cbRssRetention.FormattingEnabled = true;
			this.cbRssRetention.Location = new System.Drawing.Point(501, 424);
			this.cbRssRetention.Name = "cbRssRetention";
			this.cbRssRetention.Size = new System.Drawing.Size(256, 21);
			this.cbRssRetention.TabIndex = 11;
			//
			//Label31
			//
			this.Label31.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label31.AutoSize = true;
			this.Label31.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label31.Location = new System.Drawing.Point(500, 408);
			this.Label31.Name = "Label31";
			this.Label31.Size = new System.Drawing.Size(84, 13);
			this.Label31.TabIndex = 10;
			this.Label31.Text = "Retention Code:";
			//
			//dgRss
			//
			this.dgRss.AllowUserToAddRows = false;
			this.dgRss.AllowUserToDeleteRows = false;
			this.dgRss.AllowUserToOrderColumns = true;
			this.dgRss.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.dgRss.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
			this.dgRss.AutoSizeRowsMode = System.Windows.Forms.DataGridViewAutoSizeRowsMode.DisplayedCells;
			this.dgRss.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.dgRss.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgRss.Location = new System.Drawing.Point(32, 119);
			this.dgRss.MultiSelect = false;
			this.dgRss.Name = "dgRss";
			this.dgRss.Size = new System.Drawing.Size(870, 273);
			this.dgRss.TabIndex = 9;
			//
			//btnRemoveRSSfeed
			//
			this.btnRemoveRSSfeed.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnRemoveRSSfeed.Location = new System.Drawing.Point(807, 451);
			this.btnRemoveRSSfeed.Name = "btnRemoveRSSfeed";
			this.btnRemoveRSSfeed.Size = new System.Drawing.Size(96, 37);
			this.btnRemoveRSSfeed.TabIndex = 8;
			this.btnRemoveRSSfeed.Text = "Remove";
			this.btnRemoveRSSfeed.UseVisualStyleBackColor = true;
			//
			//btnAddRssFeed
			//
			this.btnAddRssFeed.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnAddRssFeed.Location = new System.Drawing.Point(807, 408);
			this.btnAddRssFeed.Name = "btnAddRssFeed";
			this.btnAddRssFeed.Size = new System.Drawing.Size(96, 37);
			this.btnAddRssFeed.TabIndex = 7;
			this.btnAddRssFeed.Text = "Save";
			this.btnAddRssFeed.UseVisualStyleBackColor = true;
			//
			//Label22
			//
			this.Label22.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label22.AutoSize = true;
			this.Label22.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label22.Location = new System.Drawing.Point(29, 449);
			this.Label22.Name = "Label22";
			this.Label22.Size = new System.Drawing.Size(53, 13);
			this.Label22.TabIndex = 5;
			this.Label22.Text = "Site URL:";
			//
			//Label21
			//
			this.Label21.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label21.AutoSize = true;
			this.Label21.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label21.Location = new System.Drawing.Point(29, 408);
			this.Label21.Name = "Label21";
			this.Label21.Size = new System.Drawing.Size(59, 13);
			this.Label21.TabIndex = 3;
			this.Label21.Text = "Site Name:";
			//
			//Label20
			//
			this.Label20.AutoSize = true;
			this.Label20.BackColor = System.Drawing.Color.Transparent;
			this.Label20.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label20.Location = new System.Drawing.Point(29, 86);
			this.Label20.Name = "Label20";
			this.Label20.Size = new System.Drawing.Size(70, 13);
			this.Label20.TabIndex = 1;
			this.Label20.Text = "Defined Sites";
			//
			//Label17
			//
			this.Label17.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Label17.AutoSize = true;
			this.Label17.BackColor = System.Drawing.Color.Transparent;
			this.Label17.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (26.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label17.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label17.Location = new System.Drawing.Point(25, 27);
			this.Label17.Name = "Label17";
			this.Label17.Size = new System.Drawing.Size(522, 39);
			this.Label17.TabIndex = 0;
			this.Label17.Text = "RSS Capture Definition Screen";
			//
			//TabPage5
			//
			this.TabPage5.BackColor = System.Drawing.Color.Black;
			this.TabPage5.Controls.Add(this.cbWebPageRetention);
			this.TabPage5.Controls.Add(this.Label32);
			this.TabPage5.Controls.Add(this.btnRemoveWebPage);
			this.TabPage5.Controls.Add(this.btnSaveWebPage);
			this.TabPage5.Controls.Add(this.txtWebScreenUrl);
			this.TabPage5.Controls.Add(this.Label23);
			this.TabPage5.Controls.Add(this.txtWebScreenName);
			this.TabPage5.Controls.Add(this.Label24);
			this.TabPage5.Controls.Add(this.dgWebPage);
			this.TabPage5.Controls.Add(this.Label25);
			this.TabPage5.Controls.Add(this.Label18);
			this.TabPage5.ForeColor = System.Drawing.Color.Transparent;
			this.TabPage5.Location = new System.Drawing.Point(4, 22);
			this.TabPage5.Name = "TabPage5";
			this.TabPage5.Size = new System.Drawing.Size(930, 501);
			this.TabPage5.TabIndex = 4;
			this.TabPage5.Text = "Web Screen";
			//
			//cbWebPageRetention
			//
			this.cbWebPageRetention.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbWebPageRetention.FormattingEnabled = true;
			this.cbWebPageRetention.Location = new System.Drawing.Point(434, 411);
			this.cbWebPageRetention.Name = "cbWebPageRetention";
			this.cbWebPageRetention.Size = new System.Drawing.Size(256, 21);
			this.cbWebPageRetention.TabIndex = 18;
			//
			//Label32
			//
			this.Label32.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label32.AutoSize = true;
			this.Label32.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label32.Location = new System.Drawing.Point(433, 395);
			this.Label32.Name = "Label32";
			this.Label32.Size = new System.Drawing.Size(84, 13);
			this.Label32.TabIndex = 17;
			this.Label32.Text = "Retention Code:";
			//
			//btnRemoveWebPage
			//
			this.btnRemoveWebPage.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnRemoveWebPage.ForeColor = System.Drawing.Color.Black;
			this.btnRemoveWebPage.Location = new System.Drawing.Point(807, 438);
			this.btnRemoveWebPage.Name = "btnRemoveWebPage";
			this.btnRemoveWebPage.Size = new System.Drawing.Size(96, 37);
			this.btnRemoveWebPage.TabIndex = 16;
			this.btnRemoveWebPage.Text = "Remove";
			this.btnRemoveWebPage.UseVisualStyleBackColor = true;
			//
			//btnSaveWebPage
			//
			this.btnSaveWebPage.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnSaveWebPage.ForeColor = System.Drawing.Color.Black;
			this.btnSaveWebPage.Location = new System.Drawing.Point(807, 395);
			this.btnSaveWebPage.Name = "btnSaveWebPage";
			this.btnSaveWebPage.Size = new System.Drawing.Size(96, 37);
			this.btnSaveWebPage.TabIndex = 15;
			this.btnSaveWebPage.Text = "Save";
			this.btnSaveWebPage.UseVisualStyleBackColor = true;
			//
			//Label23
			//
			this.Label23.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label23.AutoSize = true;
			this.Label23.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.Label23.Location = new System.Drawing.Point(29, 436);
			this.Label23.Name = "Label23";
			this.Label23.Size = new System.Drawing.Size(53, 13);
			this.Label23.TabIndex = 13;
			this.Label23.Text = "Site URL:";
			//
			//Label24
			//
			this.Label24.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label24.AutoSize = true;
			this.Label24.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.Label24.Location = new System.Drawing.Point(29, 395);
			this.Label24.Name = "Label24";
			this.Label24.Size = new System.Drawing.Size(59, 13);
			this.Label24.TabIndex = 11;
			this.Label24.Text = "Site Name:";
			//
			//dgWebPage
			//
			DataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			DataGridViewCellStyle1.ForeColor = System.Drawing.Color.Black;
			DataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (192)));
			DataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.White;
			DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgWebPage.AlternatingRowsDefaultCellStyle = DataGridViewCellStyle1;
			this.dgWebPage.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.dgWebPage.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCellsExceptHeader;
			this.dgWebPage.BackgroundColor = System.Drawing.Color.DimGray;
			DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control;
			DataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
			DataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgWebPage.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle2;
			this.dgWebPage.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle3.BackColor = System.Drawing.Color.LightGray;
			DataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle3.ForeColor = System.Drawing.Color.Transparent;
			DataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.Yellow;
			DataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.Navy;
			DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgWebPage.DefaultCellStyle = DataGridViewCellStyle3;
			this.dgWebPage.GridColor = System.Drawing.SystemColors.ControlDarkDark;
			this.dgWebPage.Location = new System.Drawing.Point(32, 89);
			this.dgWebPage.MultiSelect = false;
			this.dgWebPage.Name = "dgWebPage";
			DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
			DataGridViewCellStyle4.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
			DataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgWebPage.RowHeadersDefaultCellStyle = DataGridViewCellStyle4;
			this.dgWebPage.Size = new System.Drawing.Size(871, 278);
			this.dgWebPage.TabIndex = 10;
			//
			//Label25
			//
			this.Label25.AutoSize = true;
			this.Label25.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.Label25.Location = new System.Drawing.Point(29, 73);
			this.Label25.Name = "Label25";
			this.Label25.Size = new System.Drawing.Size(70, 13);
			this.Label25.TabIndex = 9;
			this.Label25.Text = "Defined Sites";
			//
			//Label18
			//
			this.Label18.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Label18.AutoSize = true;
			this.Label18.BackColor = System.Drawing.Color.Transparent;
			this.Label18.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (26.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label18.ForeColor = System.Drawing.SystemColors.ButtonFace;
			this.Label18.Location = new System.Drawing.Point(25, 18);
			this.Label18.Name = "Label18";
			this.Label18.Size = new System.Drawing.Size(371, 39);
			this.Label18.TabIndex = 1;
			this.Label18.Text = "WEB Screen Tracker ";
			//
			//TabPage6
			//
			this.TabPage6.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (64)));
			this.TabPage6.Controls.Add(this.cbWebSiteRetention);
			this.TabPage6.Controls.Add(this.Label33);
			this.TabPage6.Controls.Add(this.nbrOutboundLinks);
			this.TabPage6.Controls.Add(this.nbrDepth);
			this.TabPage6.Controls.Add(this.Label30);
			this.TabPage6.Controls.Add(this.Label29);
			this.TabPage6.Controls.Add(this.btnRemoveWebSite);
			this.TabPage6.Controls.Add(this.btnSaveWebSite);
			this.TabPage6.Controls.Add(this.txtWebSiteURL);
			this.TabPage6.Controls.Add(this.Label26);
			this.TabPage6.Controls.Add(this.txtWebSiteName);
			this.TabPage6.Controls.Add(this.Label27);
			this.TabPage6.Controls.Add(this.dgWebSite);
			this.TabPage6.Controls.Add(this.Label28);
			this.TabPage6.Controls.Add(this.Label19);
			this.TabPage6.Location = new System.Drawing.Point(4, 22);
			this.TabPage6.Name = "TabPage6";
			this.TabPage6.Size = new System.Drawing.Size(930, 501);
			this.TabPage6.TabIndex = 5;
			this.TabPage6.Text = "Web Site";
			//
			//cbWebSiteRetention
			//
			this.cbWebSiteRetention.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbWebSiteRetention.FormattingEnabled = true;
			this.cbWebSiteRetention.Location = new System.Drawing.Point(481, 410);
			this.cbWebSiteRetention.Name = "cbWebSiteRetention";
			this.cbWebSiteRetention.Size = new System.Drawing.Size(256, 21);
			this.cbWebSiteRetention.TabIndex = 22;
			//
			//Label33
			//
			this.Label33.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label33.AutoSize = true;
			this.Label33.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label33.Location = new System.Drawing.Point(480, 394);
			this.Label33.Name = "Label33";
			this.Label33.Size = new System.Drawing.Size(84, 13);
			this.Label33.TabIndex = 21;
			this.Label33.Text = "Retention Code:";
			//
			//nbrOutboundLinks
			//
			this.nbrOutboundLinks.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.nbrOutboundLinks.Location = new System.Drawing.Point(428, 410);
			this.nbrOutboundLinks.Name = "nbrOutboundLinks";
			this.nbrOutboundLinks.Size = new System.Drawing.Size(40, 20);
			this.nbrOutboundLinks.TabIndex = 20;
			this.nbrOutboundLinks.Value = new decimal(new int[] {10, 0, 0, 0});
			//
			//nbrDepth
			//
			this.nbrDepth.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.nbrDepth.Location = new System.Drawing.Point(369, 410);
			this.nbrDepth.Name = "nbrDepth";
			this.nbrDepth.Size = new System.Drawing.Size(40, 20);
			this.nbrDepth.TabIndex = 19;
			this.nbrDepth.Value = new decimal(new int[] {1, 0, 0, 0});
			//
			//Label30
			//
			this.Label30.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label30.AutoSize = true;
			this.Label30.ForeColor = System.Drawing.Color.Gainsboro;
			this.Label30.Location = new System.Drawing.Point(425, 396);
			this.Label30.Name = "Label30";
			this.Label30.Size = new System.Drawing.Size(35, 13);
			this.Label30.TabIndex = 18;
			this.Label30.Text = "Width";
			//
			//Label29
			//
			this.Label29.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label29.AutoSize = true;
			this.Label29.ForeColor = System.Drawing.Color.Gainsboro;
			this.Label29.Location = new System.Drawing.Point(366, 396);
			this.Label29.Name = "Label29";
			this.Label29.Size = new System.Drawing.Size(36, 13);
			this.Label29.TabIndex = 17;
			this.Label29.Text = "Depth";
			//
			//btnRemoveWebSite
			//
			this.btnRemoveWebSite.Location = new System.Drawing.Point(807, 437);
			this.btnRemoveWebSite.Name = "btnRemoveWebSite";
			this.btnRemoveWebSite.Size = new System.Drawing.Size(96, 37);
			this.btnRemoveWebSite.TabIndex = 16;
			this.btnRemoveWebSite.Text = "Remove";
			this.btnRemoveWebSite.UseVisualStyleBackColor = true;
			//
			//btnSaveWebSite
			//
			this.btnSaveWebSite.Location = new System.Drawing.Point(807, 394);
			this.btnSaveWebSite.Name = "btnSaveWebSite";
			this.btnSaveWebSite.Size = new System.Drawing.Size(96, 37);
			this.btnSaveWebSite.TabIndex = 15;
			this.btnSaveWebSite.Text = "Save";
			this.btnSaveWebSite.UseVisualStyleBackColor = true;
			//
			//txtWebSiteURL
			//
			this.txtWebSiteURL.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtWebSiteURL.Location = new System.Drawing.Point(32, 451);
			this.txtWebSiteURL.Name = "txtWebSiteURL";
			this.txtWebSiteURL.Size = new System.Drawing.Size(725, 20);
			this.txtWebSiteURL.TabIndex = 14;
			//
			//Label26
			//
			this.Label26.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label26.AutoSize = true;
			this.Label26.ForeColor = System.Drawing.Color.Gainsboro;
			this.Label26.Location = new System.Drawing.Point(29, 435);
			this.Label26.Name = "Label26";
			this.Label26.Size = new System.Drawing.Size(53, 13);
			this.Label26.TabIndex = 13;
			this.Label26.Text = "Site URL:";
			//
			//txtWebSiteName
			//
			this.txtWebSiteName.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.txtWebSiteName.Location = new System.Drawing.Point(32, 410);
			this.txtWebSiteName.Name = "txtWebSiteName";
			this.txtWebSiteName.Size = new System.Drawing.Size(325, 20);
			this.txtWebSiteName.TabIndex = 12;
			//
			//Label27
			//
			this.Label27.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label27.AutoSize = true;
			this.Label27.ForeColor = System.Drawing.Color.Gainsboro;
			this.Label27.Location = new System.Drawing.Point(29, 394);
			this.Label27.Name = "Label27";
			this.Label27.Size = new System.Drawing.Size(59, 13);
			this.Label27.TabIndex = 11;
			this.Label27.Text = "Site Name:";
			//
			//dgWebSite
			//
			this.dgWebSite.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.dgWebSite.BackgroundColor = System.Drawing.SystemColors.ControlLight;
			DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle5.BackColor = System.Drawing.SystemColors.Control;
			DataGridViewCellStyle5.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle5.ForeColor = System.Drawing.SystemColors.WindowText;
			DataGridViewCellStyle5.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle5.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgWebSite.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle5;
			this.dgWebSite.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			DataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.Window;
			DataGridViewCellStyle6.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.ControlText;
			DataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
			this.dgWebSite.DefaultCellStyle = DataGridViewCellStyle6;
			this.dgWebSite.Location = new System.Drawing.Point(32, 88);
			this.dgWebSite.Name = "dgWebSite";
			DataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle7.BackColor = System.Drawing.SystemColors.Control;
			DataGridViewCellStyle7.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle7.ForeColor = System.Drawing.SystemColors.WindowText;
			DataGridViewCellStyle7.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle7.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle7.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgWebSite.RowHeadersDefaultCellStyle = DataGridViewCellStyle7;
			this.dgWebSite.Size = new System.Drawing.Size(871, 278);
			this.dgWebSite.TabIndex = 10;
			//
			//Label28
			//
			this.Label28.AutoSize = true;
			this.Label28.ForeColor = System.Drawing.Color.Gainsboro;
			this.Label28.Location = new System.Drawing.Point(29, 72);
			this.Label28.Name = "Label28";
			this.Label28.Size = new System.Drawing.Size(70, 13);
			this.Label28.TabIndex = 9;
			this.Label28.Text = "Defined Sites";
			//
			//Label19
			//
			this.Label19.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Label19.AutoSize = true;
			this.Label19.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (26.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label19.ForeColor = System.Drawing.Color.Gainsboro;
			this.Label19.Location = new System.Drawing.Point(25, 22);
			this.Label19.Name = "Label19";
			this.Label19.Size = new System.Drawing.Size(309, 39);
			this.Label19.TabIndex = 1;
			this.Label19.Text = "WEB Site Tracker";
			//
			//TabPage3
			//
			this.TabPage3.BackColor = System.Drawing.SystemColors.ControlDark;
			this.TabPage3.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.TabPage3.Controls.Add(this.PictureBox2);
			this.TabPage3.Controls.Add(this.GroupBox1);
			this.TabPage3.Controls.Add(this.btnDefaultAsso);
			this.TabPage3.Controls.Add(this.btnRefreshDefaults);
			this.TabPage3.Controls.Add(this.gbFiletypes);
			this.TabPage3.Controls.Add(this.gbPolling);
			this.TabPage3.Location = new System.Drawing.Point(4, 22);
			this.TabPage3.Name = "TabPage3";
			this.TabPage3.Size = new System.Drawing.Size(930, 501);
			this.TabPage3.TabIndex = 2;
			this.TabPage3.Text = "Execution Control";
			//
			//GroupBox1
			//
			this.GroupBox1.Controls.Add(this.btnFetch);
			this.GroupBox1.Controls.Add(this.txtCompany);
			this.GroupBox1.Controls.Add(this.btnActivate);
			this.GroupBox1.Controls.Add(this.cbRepo);
			this.GroupBox1.Controls.Add(this.Label15);
			this.GroupBox1.Controls.Add(this.Label14);
			this.GroupBox1.Location = new System.Drawing.Point(598, 29);
			this.GroupBox1.Name = "GroupBox1";
			this.GroupBox1.Size = new System.Drawing.Size(296, 163);
			this.GroupBox1.TabIndex = 32;
			this.GroupBox1.TabStop = false;
			this.GroupBox1.Text = "Active Repository";
			//
			//txtCompany
			//
			this.txtCompany.Location = new System.Drawing.Point(17, 39);
			this.txtCompany.Name = "txtCompany";
			this.txtCompany.Size = new System.Drawing.Size(192, 20);
			this.txtCompany.TabIndex = 5;
			//
			//btnActivate
			//
			this.btnActivate.Location = new System.Drawing.Point(103, 119);
			this.btnActivate.Name = "btnActivate";
			this.btnActivate.Size = new System.Drawing.Size(95, 31);
			this.btnActivate.TabIndex = 4;
			this.btnActivate.Text = "Activate";
			this.btnActivate.UseVisualStyleBackColor = true;
			//
			//cbRepo
			//
			this.cbRepo.FormattingEnabled = true;
			this.cbRepo.Location = new System.Drawing.Point(18, 87);
			this.cbRepo.Name = "cbRepo";
			this.cbRepo.Size = new System.Drawing.Size(267, 21);
			this.cbRepo.TabIndex = 3;
			//
			//Label15
			//
			this.Label15.AutoSize = true;
			this.Label15.Location = new System.Drawing.Point(14, 71);
			this.Label15.Name = "Label15";
			this.Label15.Size = new System.Drawing.Size(74, 13);
			this.Label15.TabIndex = 1;
			this.Label15.Text = "Repository ID:";
			//
			//Label14
			//
			this.Label14.AutoSize = true;
			this.Label14.Location = new System.Drawing.Point(14, 24);
			this.Label14.Name = "Label14";
			this.Label14.Size = new System.Drawing.Size(68, 13);
			this.Label14.TabIndex = 0;
			this.Label14.Text = "Company ID:";
			//
			//btnDefaultAsso
			//
			this.btnDefaultAsso.Location = new System.Drawing.Point(676, 378);
			this.btnDefaultAsso.Name = "btnDefaultAsso";
			this.btnDefaultAsso.Size = new System.Drawing.Size(152, 25);
			this.btnDefaultAsso.TabIndex = 31;
			this.btnDefaultAsso.Text = "Reset Default Associations";
			this.btnDefaultAsso.UseVisualStyleBackColor = true;
			//
			//btnRefreshDefaults
			//
			this.btnRefreshDefaults.Location = new System.Drawing.Point(678, 338);
			this.btnRefreshDefaults.Name = "btnRefreshDefaults";
			this.btnRefreshDefaults.Size = new System.Drawing.Size(150, 24);
			this.btnRefreshDefaults.TabIndex = 30;
			this.btnRefreshDefaults.Text = "Reset Defaults";
			this.btnRefreshDefaults.UseVisualStyleBackColor = true;
			//
			//OpenFileDialog1
			//
			this.OpenFileDialog1.FileName = "OpenFileDialog1";
			//
			//BackgroundWorker1
			//
			//
			//BackgroundWorker2
			//
			//
			//BackgroundWorker3
			//
			//
			//BackgroundDirListener
			//
			//
			//BackgroundWorkerContacts
			//
			//
			//asyncBatchOcrALL
			//
			//
			//asyncBatchOcrPending
			//
			//
			//asyncVerifyRetainDates
			//
			//
			//asyncRssPull
			//
			//
			//asyncSpiderWebSite
			//
			//
			//asyncSpiderWebPage
			//
			//
			//frmMain
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.AutoScroll = true;
			this.AutoSize = true;
			this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
			this.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (64)));
			this.ClientSize = new System.Drawing.Size(962, 661);
			this.Controls.Add(this.lblVer);
			this.Controls.Add(this.TabControl1);
			this.Controls.Add(this.Label8);
			this.Controls.Add(this.btnAddDir);
			this.Controls.Add(this.cbFileDB);
			this.Controls.Add(this.StatusStrip1);
			this.Controls.Add(this.MenuStrip1);
			this.Controls.Add(this.ckPauseListener);
			this.Controls.Add(this.PBx);
			this.Controls.Add(this.SB2);
			this.Controls.Add(this.ckTerminate);
			this.Controls.Add(this.PictureBox1);
			this.Controls.Add(this.SB);
			this.HelpButton = true;
			this.f1Help.SetHelpString(this, "http://www.ecmlibrary.com/helpfiles/frmReconMain.htm");
			this.Icon = (System.Drawing.Icon) (resources.GetObject("$this.Icon"));
			this.MainMenuStrip = this.MenuStrip1;
			this.Name = "frmMain";
			this.f1Help.SetShowHelp(this, true);
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "ECM Library Archive System - Cloud";
			this.gbEmail.ResumeLayout(false);
			this.gbEmail.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.NumericUpDown3).EndInit();
			this.gbFiletypes.ResumeLayout(false);
			this.gbFiletypes.PerformLayout();
			this.gbPolling.ResumeLayout(false);
			this.gbPolling.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.nbrArchiveHours).EndInit();
			((System.ComponentModel.ISupportInitialize) this.PictureBox2).EndInit();
			this.gbContentMgt.ResumeLayout(false);
			this.Panel2.ResumeLayout(false);
			this.Panel2.PerformLayout();
			this.Panel1.ResumeLayout(false);
			this.Panel1.PerformLayout();
			this.Panel3.ResumeLayout(false);
			this.Panel3.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.PictureBox1).EndInit();
			this.ContextMenuStrip1.ResumeLayout(false);
			this.MenuStrip1.ResumeLayout(false);
			this.MenuStrip1.PerformLayout();
			this.StatusStrip1.ResumeLayout(false);
			this.StatusStrip1.PerformLayout();
			this.TabControl1.ResumeLayout(false);
			this.TabPage1.ResumeLayout(false);
			this.TabPage2.ResumeLayout(false);
			this.TabPage4.ResumeLayout(false);
			this.TabPage4.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.dgRss).EndInit();
			this.TabPage5.ResumeLayout(false);
			this.TabPage5.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.dgWebPage).EndInit();
			this.TabPage6.ResumeLayout(false);
			this.TabPage6.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.nbrOutboundLinks).EndInit();
			((System.ComponentModel.ISupportInitialize) this.nbrDepth).EndInit();
			((System.ComponentModel.ISupportInitialize) this.dgWebSite).EndInit();
			this.TabPage3.ResumeLayout(false);
			this.GroupBox1.ResumeLayout(false);
			this.GroupBox1.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.GroupBox gbEmail;
		internal System.Windows.Forms.Button btnActive;
		internal System.Windows.Forms.ComboBox cbEmailDB;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.NumericUpDown NumericUpDown3;
		internal System.Windows.Forms.CheckBox ckRemoveAfterXDays;
		internal System.Windows.Forms.Button btnRefreshFolders;
		internal System.Windows.Forms.Button btnSaveConditions;
		internal System.Windows.Forms.CheckBox ckArchiveFolder;
		internal System.Windows.Forms.ListBox lbActiveFolder;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.GroupBox gbFiletypes;
		internal System.Windows.Forms.Button ckRemoveFileType;
		internal System.Windows.Forms.ComboBox cbFileTypes;
		internal System.Windows.Forms.Button btnAddFiletype;
		internal System.Windows.Forms.GroupBox gbPolling;
		internal System.Windows.Forms.CheckBox ckDisable;
		internal System.Windows.Forms.GroupBox gbContentMgt;
		internal System.Windows.Forms.Button btnInclFileType;
		internal System.Windows.Forms.Label Label8;
		internal System.Windows.Forms.Label Label6;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.ListBox lbAvailExts;
		internal System.Windows.Forms.ListBox lbIncludeExts;
		internal System.Windows.Forms.ComboBox cbFileDB;
		internal System.Windows.Forms.Button btnRefresh;
		internal System.Windows.Forms.Button btnSaveChanges;
		internal System.Windows.Forms.Button btnRemoveDir;
		internal System.Windows.Forms.Button btnAddDir;
		internal System.Windows.Forms.Button btnSelDir;
		internal System.Windows.Forms.ListBox lbArchiveDirs;
		internal System.Windows.Forms.TextBox txtDir;
		internal System.Windows.Forms.FolderBrowserDialog FolderBrowserDialog1;
		internal System.Windows.Forms.CheckBox ckSubDirs;
		internal System.Windows.Forms.Button btnDeleteEmailEntry;
		internal System.Windows.Forms.Label Label10;
		internal System.Windows.Forms.Label Label9;
		internal System.Windows.Forms.ComboBox cbAsType;
		internal System.Windows.Forms.ComboBox cbPocessType;
		internal System.Windows.Forms.Button Button2;
		internal System.Windows.Forms.Button Button1;
		internal System.Windows.Forms.Button Button3;
		internal System.Windows.Forms.ComboBox cbProcessAsList;
		internal System.Windows.Forms.CheckBox ckVersionFiles;
		internal System.Windows.Forms.CheckBox ckArchiveRead;
		internal System.Windows.Forms.CheckBox ckMetaData;
		internal System.Windows.Forms.CheckBox ckPublic;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Button btnSaveSchedule;
		internal System.Windows.Forms.CheckBox ckDisableDir;
		internal System.Windows.Forms.Button btnExclude;
		internal System.Windows.Forms.Button btnRemoveExclude;
		internal System.Windows.Forms.Label Label7;
		internal System.Windows.Forms.ListBox lbExcludeExts;
		internal System.Windows.Forms.CheckBox ckUseLastProcessDateAsCutoff;
		internal System.Windows.Forms.CheckBox ckSystemFolder;
		internal System.Windows.Forms.CheckBox clAdminDir;
		internal System.Windows.Forms.CheckBox ckOcr;
		internal System.Windows.Forms.HelpProvider f1Help;
		internal System.Windows.Forms.TextBox SB2;
		internal System.Windows.Forms.ComboBox cbRetention;
		internal System.Windows.Forms.ComboBox cbEmailRetention;
		internal System.Windows.Forms.CheckBox ckDisableOutlookEmailArchive;
		internal System.Windows.Forms.CheckBox ckDisableContentArchive;
		internal System.Windows.Forms.CheckBox ckDisableExchange;
		internal System.Windows.Forms.Button btnSMTP;
		internal System.Windows.Forms.ProgressBar PBx;
		internal System.Windows.Forms.ComboBox cbProfile;
		internal System.Windows.Forms.Button btnExclProfile;
		internal System.Windows.Forms.Button btnInclProfile;
		internal System.Windows.Forms.ComboBox cbParentFolders;
		internal System.Windows.Forms.ContextMenuStrip ContextMenuStrip1;
		internal System.Windows.Forms.ToolStripMenuItem ResetSelectedMailBoxesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem EmailLibraryReassignmentToolStripMenuItem;
		internal System.Windows.Forms.Label Label13;
		internal System.Windows.Forms.Label Label11;
		internal System.Windows.Forms.CheckBox ckTerminate;
		internal System.Windows.Forms.Button btnDeleteDirProfile;
		internal System.Windows.Forms.Button btnUpdateDirectoryProfile;
		internal System.Windows.Forms.Button btnSaveDirProfile;
		internal System.Windows.Forms.Button btnApplyDirProfile;
		internal System.Windows.Forms.ComboBox cbDirProfile;
		internal System.Windows.Forms.Label Label12;
		internal System.Windows.Forms.CheckBox ckArchiveBit;
		internal System.Windows.Forms.CheckBox CkMonitor;
		internal System.Windows.Forms.CheckBox ckRunUnattended;
		internal System.Windows.Forms.CheckBox ckDoNotShowArchived;
		internal System.Windows.Forms.PictureBox PictureBox1;
		internal System.Windows.Forms.CheckBox ckGetSubFolders;
		internal System.Windows.Forms.Timer TimerListeners;
		internal System.Windows.Forms.CheckBox ckPauseListener;
		internal System.Windows.Forms.Timer TimerUploadFiles;
		internal System.Windows.Forms.Timer TimerEndRun;
		internal System.Windows.Forms.Button btnRefreshRetent;
		internal System.Windows.Forms.CheckBox ckShowLibs;
		internal System.Windows.Forms.CheckBox ckOcrPdf;
		internal System.Windows.Forms.MenuStrip MenuStrip1;
		internal System.Windows.Forms.ToolStripMenuItem ArchiveToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem OutlookEmailsToolStripMenuItem;
		internal System.Windows.Forms.StatusStrip StatusStrip1;
		internal System.Windows.Forms.ToolStripMenuItem ExchangeEmailsToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ContentToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ArchiveALLToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem TasksToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem LoginAsDifferenctUserToolStripMenuItem;
		internal System.Windows.Forms.ToolStripStatusLabel infoDaysToExpire;
		internal System.Windows.Forms.ToolStripStatusLabel tssUser;
		internal System.Windows.Forms.ToolStripStatusLabel tssServer;
		internal System.Windows.Forms.ToolStripStatusLabel tssVersion;
		internal System.Windows.Forms.ToolStripMenuItem HelpToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem RunningArchiverToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ParameterExecutionToolStripMenuItem;
		internal System.Windows.Forms.ToolStripStatusLabel tssAuth;
		internal System.Windows.Forms.ToolStripMenuItem HistoryToolStripMenuItem;
		internal System.Windows.Forms.CheckBox ckExpand;
		internal System.Windows.Forms.ToolStripMenuItem ViewLogsToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem TestToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem DirectoryInventoryToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ListFilesInDirectoryToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem GetAllSubdirFilesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ViewOCRErrorFilesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ScheduleToolStripMenuItem;
		internal System.Windows.Forms.ToolStripStatusLabel tbExchange;
		internal System.Windows.Forms.ToolStripMenuItem OCRToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem AboutToolStripMenuItem;
		internal System.Windows.Forms.ToolStripProgressBar PB1;
		internal System.Windows.Forms.ToolStripStatusLabel tsStatus02;
		internal System.Windows.Forms.ToolStripMenuItem ManualEditAppConfigToolStripMenuItem;
		internal System.Windows.Forms.ToolStripStatusLabel SB5;
		internal System.Windows.Forms.Panel Panel2;
		internal System.Windows.Forms.Panel Panel1;
		internal System.Windows.Forms.Panel Panel3;
		internal System.Windows.Forms.ToolStripStatusLabel ToolStripStatusLabel1;
		internal System.Windows.Forms.ToolStripMenuItem SetArchiveIntervalToolStripMenuItem;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.NumericUpDown nbrArchiveHours;
		internal System.Windows.Forms.Timer TimerQuickArchive;
		internal System.Windows.Forms.Button btnArchiveNow;
		internal System.Windows.Forms.ToolStripStatusLabel tsLastArchive;
		internal System.Windows.Forms.ToolStripMenuItem ImpersonateLoginToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem AddDesktopIconToolStripMenuItem;
		internal System.Windows.Forms.Button btnRefreshRebuild;
		internal System.Windows.Forms.ToolStripStatusLabel tsBytesLoading;
		internal System.Windows.Forms.ToolStripMenuItem SelectionToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem AllToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem EmailToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ContentToolStripMenuItem1;
		internal System.Windows.Forms.ToolStripMenuItem ExecutionControlToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem FileTypesToolStripMenuItem;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.TabControl TabControl1;
		internal System.Windows.Forms.TabPage TabPage1;
		internal System.Windows.Forms.TabPage TabPage2;
		internal System.Windows.Forms.TabPage TabPage3;
		internal System.Windows.Forms.ToolStripStatusLabel tsServiceDBConnState;
		internal System.Windows.Forms.ToolStripStatusLabel tsTunnelConn;
		internal System.Windows.Forms.ToolStripMenuItem UtilityToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem EncryptStringToolStripMenuItem;
		internal System.Windows.Forms.Button btnRefreshDefaults;
		internal System.Windows.Forms.Button btnDefaultAsso;
		internal System.Windows.Forms.Button btnAddDefaults;
		internal System.Windows.Forms.ToolStripMenuItem FileHashToolStripMenuItem;
		internal System.Windows.Forms.OpenFileDialog OpenFileDialog1;
		internal System.ComponentModel.BackgroundWorker BackgroundWorker1;
		internal System.ComponentModel.BackgroundWorker BackgroundWorker2;
		internal System.ComponentModel.BackgroundWorker BackgroundWorker3;
		internal System.Windows.Forms.ToolStripMenuItem FileUploadToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem FileUploadBufferedToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem FileChunkUploadToolStripMenuItem;
		internal System.ComponentModel.BackgroundWorker BackgroundDirListener;
		internal System.Windows.Forms.GroupBox GroupBox1;
		internal System.Windows.Forms.Button btnActivate;
		internal System.Windows.Forms.ComboBox cbRepo;
		internal System.Windows.Forms.Label Label15;
		internal System.Windows.Forms.Label Label14;
		internal System.Windows.Forms.ToolStripStatusLabel tsCurrentRepoID;
		internal System.Windows.Forms.TextBox txtCompany;
		internal System.Windows.Forms.Button btnFetch;
		internal System.Windows.Forms.ToolStripMenuItem ExitToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ExitToolStripMenuItem1;
		internal System.Windows.Forms.Label lblVer;
		internal System.Windows.Forms.ToolStripMenuItem InstallCLCToolStripMenuItem;
		internal System.Windows.Forms.ToolStripStatusLabel tsTimeToArchive;
		internal System.Windows.Forms.ToolStripStatusLabel tsCountDown;
		internal System.Windows.Forms.CheckBox ckDeleteAfterArchive;
		internal System.Windows.Forms.Button btnCountFiles;
		internal System.Windows.Forms.ToolStripMenuItem AppConfigVersionToolStripMenuItem;
		internal System.ComponentModel.BackgroundWorker BackgroundWorkerContacts;
		internal System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem1;
		internal System.ComponentModel.BackgroundWorker asyncBatchOcrALL;
		internal System.ComponentModel.BackgroundWorker asyncBatchOcrPending;
		internal System.Windows.Forms.ToolStripMenuItem ReOCRToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ReOcrIncompleteGraphicFilesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ReOcrALLGraphicFilesToolStripMenuItem1;
		internal System.Windows.Forms.ToolStripMenuItem EstimateNumberOfFilesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ResetPerformanceFilesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem CEDatabasesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ZIPFilesArchivesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem AllToolStripMenuItem1;
		internal System.Windows.Forms.ToolStripMenuItem ViewCEDirectoriesToolStripMenuItem1;
		internal System.Windows.Forms.ToolStripSeparator ToolStripSeparator2;
		internal System.Windows.Forms.ToolStripSeparator ToolStripSeparator1;
		internal System.Windows.Forms.ToolStripMenuItem InstallCESP2ToolStripMenuItem1;
		internal System.Windows.Forms.ToolStripMenuItem ToolStripMenuItem2;
		internal System.Windows.Forms.ToolStripSeparator ToolStripSeparator3;
		internal System.Windows.Forms.Label Label16;
		internal System.Windows.Forms.ToolStripMenuItem RSSPullToolStripMenuItem;
		internal System.Windows.Forms.TabPage TabPage4;
		internal System.Windows.Forms.Button btnRemoveRSSfeed;
		internal System.Windows.Forms.Button btnAddRssFeed;
		internal System.Windows.Forms.TextBox txtRssURL;
		internal System.Windows.Forms.Label Label22;
		internal System.Windows.Forms.TextBox txtRssName;
		internal System.Windows.Forms.Label Label21;
		internal System.Windows.Forms.Label Label20;
		internal System.Windows.Forms.Label Label17;
		internal System.Windows.Forms.TabPage TabPage5;
		internal System.Windows.Forms.Button btnRemoveWebPage;
		internal System.Windows.Forms.Button btnSaveWebPage;
		internal System.Windows.Forms.TextBox txtWebScreenUrl;
		internal System.Windows.Forms.Label Label23;
		internal System.Windows.Forms.TextBox txtWebScreenName;
		internal System.Windows.Forms.Label Label24;
		internal System.Windows.Forms.DataGridView dgWebPage;
		internal System.Windows.Forms.Label Label25;
		internal System.Windows.Forms.Label Label18;
		internal System.Windows.Forms.TabPage TabPage6;
		internal System.Windows.Forms.Button btnRemoveWebSite;
		internal System.Windows.Forms.Button btnSaveWebSite;
		internal System.Windows.Forms.TextBox txtWebSiteURL;
		internal System.Windows.Forms.Label Label26;
		internal System.Windows.Forms.TextBox txtWebSiteName;
		internal System.Windows.Forms.Label Label27;
		internal System.Windows.Forms.DataGridView dgWebSite;
		internal System.Windows.Forms.Label Label28;
		internal System.Windows.Forms.Label Label19;
		internal System.Windows.Forms.LinkLabel hlExchange;
		internal System.Windows.Forms.LinkLabel LinkLabel1;
		internal System.Windows.Forms.LinkLabel LinkLabel2;
		internal System.Windows.Forms.NumericUpDown nbrOutboundLinks;
		internal System.Windows.Forms.NumericUpDown nbrDepth;
		internal System.Windows.Forms.Label Label30;
		internal System.Windows.Forms.Label Label29;
		internal System.ComponentModel.BackgroundWorker asyncVerifyRetainDates;
		internal System.Windows.Forms.ToolStripMenuItem OnlineHelpToolStripMenuItem;
		internal System.Windows.Forms.ToolStripSeparator ToolStripSeparator4;
		internal System.Windows.Forms.CheckBox CheckBox1;
		internal System.Windows.Forms.CheckBox ckRunOnStart;
		internal System.Windows.Forms.ToolStripMenuItem ResetEMAILCRCCodesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem LoginToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem LoginToSystemToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ChangeUserPasswordToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem GetOutlookEmailIDsToolStripMenuItem;
		internal System.Windows.Forms.ToolStripSeparator ToolStripSeparator6;
		internal System.Windows.Forms.ToolStripMenuItem WebSitesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem WebPagesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripSeparator ToolStripSeparator5;
		internal System.Windows.Forms.ToolStripMenuItem ArchiveRSSPullsToolStripMenuItem;
		internal System.Windows.Forms.CheckBox ckWebSiteTrackerDisabled;
		internal System.Windows.Forms.CheckBox ckWebPageTrackerDisabled;
		internal System.Windows.Forms.CheckBox ckRssPullDisabled;
		internal System.Windows.Forms.PictureBox PictureBox2;
		internal System.Windows.Forms.DataGridView dgRss;
		internal System.Windows.Forms.ComboBox cbRssRetention;
		internal System.Windows.Forms.Label Label31;
		internal System.Windows.Forms.ComboBox cbWebPageRetention;
		internal System.Windows.Forms.Label Label32;
		internal System.Windows.Forms.ComboBox cbWebSiteRetention;
		internal System.Windows.Forms.Label Label33;
		internal System.ComponentModel.BackgroundWorker asyncRssPull;
		internal System.ComponentModel.BackgroundWorker asyncSpiderWebSite;
		internal System.ComponentModel.BackgroundWorker asyncSpiderWebPage;
		internal System.Windows.Forms.ToolStripMenuItem RetentionManagementToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem RetentionRulesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem RulesExecutionToolStripMenuItem;
		
	}
	
}
