<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmReconMain
     Inherits System.Windows.Forms.Form

     'Form overrides dispose to clean up the component list.
     <System.Diagnostics.DebuggerNonUserCode()> _
     Protected Overrides Sub Dispose(ByVal disposing As Boolean)
          If disposing AndAlso components IsNot Nothing Then
               components.Dispose()
          End If
          MyBase.Dispose(disposing)
     End Sub

     'Required by the Windows Form Designer
     Private components As System.ComponentModel.IContainer

     'NOTE: The following procedure is required by the Windows Form Designer
     'It can be modified using the Windows Form Designer.  
     'Do not modify it using the code editor.
     <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmReconMain))
        Me.gbEmail = New System.Windows.Forms.GroupBox()
        Me.LinkLabel2 = New System.Windows.Forms.LinkLabel()
        Me.LinkLabel1 = New System.Windows.Forms.LinkLabel()
        Me.hlExchange = New System.Windows.Forms.LinkLabel()
        Me.Label16 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.ckExpand = New System.Windows.Forms.CheckBox()
        Me.ckGetSubFolders = New System.Windows.Forms.CheckBox()
        Me.ckDoNotShowArchived = New System.Windows.Forms.CheckBox()
        Me.cbParentFolders = New System.Windows.Forms.ComboBox()
        Me.btnSMTP = New System.Windows.Forms.Button()
        Me.cbEmailRetention = New System.Windows.Forms.ComboBox()
        Me.ckSystemFolder = New System.Windows.Forms.CheckBox()
        Me.ckUseLastProcessDateAsCutoff = New System.Windows.Forms.CheckBox()
        Me.ckArchiveRead = New System.Windows.Forms.CheckBox()
        Me.btnDeleteEmailEntry = New System.Windows.Forms.Button()
        Me.btnActive = New System.Windows.Forms.Button()
        Me.cbEmailDB = New System.Windows.Forms.ComboBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.NumericUpDown3 = New System.Windows.Forms.NumericUpDown()
        Me.ckRemoveAfterXDays = New System.Windows.Forms.CheckBox()
        Me.btnRefreshFolders = New System.Windows.Forms.Button()
        Me.btnSaveConditions = New System.Windows.Forms.Button()
        Me.ckArchiveFolder = New System.Windows.Forms.CheckBox()
        Me.lbActiveFolder = New System.Windows.Forms.ListBox()
        Me.lblVer = New System.Windows.Forms.Label()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.gbFiletypes = New System.Windows.Forms.GroupBox()
        Me.cbProcessAsList = New System.Windows.Forms.ComboBox()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.cbAsType = New System.Windows.Forms.ComboBox()
        Me.cbPocessType = New System.Windows.Forms.ComboBox()
        Me.ckRemoveFileType = New System.Windows.Forms.Button()
        Me.cbFileTypes = New System.Windows.Forms.ComboBox()
        Me.btnAddFiletype = New System.Windows.Forms.Button()
        Me.gbPolling = New System.Windows.Forms.GroupBox()
        Me.ckRunOnStart = New System.Windows.Forms.CheckBox()
        Me.btnArchiveNow = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.NumericUpDown1 = New System.Windows.Forms.NumericUpDown()
        Me.ckRunUnattended = New System.Windows.Forms.CheckBox()
        Me.ckDisableExchange = New System.Windows.Forms.CheckBox()
        Me.ckDisableOutlookEmailArchive = New System.Windows.Forms.CheckBox()
        Me.ckDisableContentArchive = New System.Windows.Forms.CheckBox()
        Me.btnSaveSchedule = New System.Windows.Forms.Button()
        Me.ckDisable = New System.Windows.Forms.CheckBox()
        Me.gbContentMgt = New System.Windows.Forms.GroupBox()
        Me.btnCountFiles = New System.Windows.Forms.Button()
        Me.Panel2 = New System.Windows.Forms.Panel()
        Me.ckDeleteAfterArchive = New System.Windows.Forms.CheckBox()
        Me.ckOcrPdf = New System.Windows.Forms.CheckBox()
        Me.ckShowLibs = New System.Windows.Forms.CheckBox()
        Me.btnRefreshRetent = New System.Windows.Forms.Button()
        Me.CkMonitor = New System.Windows.Forms.CheckBox()
        Me.ckArchiveBit = New System.Windows.Forms.CheckBox()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.cbRetention = New System.Windows.Forms.ComboBox()
        Me.ckOcr = New System.Windows.Forms.CheckBox()
        Me.clAdminDir = New System.Windows.Forms.CheckBox()
        Me.ckDisableDir = New System.Windows.Forms.CheckBox()
        Me.ckPublic = New System.Windows.Forms.CheckBox()
        Me.ckMetaData = New System.Windows.Forms.CheckBox()
        Me.ckVersionFiles = New System.Windows.Forms.CheckBox()
        Me.ckSubDirs = New System.Windows.Forms.CheckBox()
        Me.txtDir = New System.Windows.Forms.TextBox()
        Me.btnRefresh = New System.Windows.Forms.Button()
        Me.btnSaveChanges = New System.Windows.Forms.Button()
        Me.btnRemoveDir = New System.Windows.Forms.Button()
        Me.btnSelDir = New System.Windows.Forms.Button()
        Me.lbArchiveDirs = New System.Windows.Forms.ListBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.lbExcludeExts = New System.Windows.Forms.ListBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.lbAvailExts = New System.Windows.Forms.ListBox()
        Me.lbIncludeExts = New System.Windows.Forms.ListBox()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.btnRemoveExclude = New System.Windows.Forms.Button()
        Me.btnInclFileType = New System.Windows.Forms.Button()
        Me.btnExclude = New System.Windows.Forms.Button()
        Me.Panel3 = New System.Windows.Forms.Panel()
        Me.btnAddDefaults = New System.Windows.Forms.Button()
        Me.btnRefreshRebuild = New System.Windows.Forms.Button()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.btnDeleteDirProfile = New System.Windows.Forms.Button()
        Me.btnUpdateDirectoryProfile = New System.Windows.Forms.Button()
        Me.btnSaveDirProfile = New System.Windows.Forms.Button()
        Me.btnApplyDirProfile = New System.Windows.Forms.Button()
        Me.cbDirProfile = New System.Windows.Forms.ComboBox()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.btnExclProfile = New System.Windows.Forms.Button()
        Me.btnInclProfile = New System.Windows.Forms.Button()
        Me.cbProfile = New System.Windows.Forms.ComboBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.cbFileDB = New System.Windows.Forms.ComboBox()
        Me.btnAddDir = New System.Windows.Forms.Button()
        Me.PictureBox1 = New System.Windows.Forms.PictureBox()
        Me.ckTerminate = New System.Windows.Forms.CheckBox()
        Me.FolderBrowserDialog1 = New System.Windows.Forms.FolderBrowserDialog()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.ckPauseListener = New System.Windows.Forms.CheckBox()
        Me.btnFetch = New System.Windows.Forms.Button()
        Me.f1Help = New System.Windows.Forms.HelpProvider()
        Me.SB2 = New System.Windows.Forms.TextBox()
        Me.PBx = New System.Windows.Forms.ProgressBar()
        Me.ContextMenuStrip1 = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.ResetSelectedMailBoxesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EmailLibraryReassignmentToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TimerListeners = New System.Windows.Forms.Timer(Me.components)
        Me.TimerUploadFiles = New System.Windows.Forms.Timer(Me.components)
        Me.TimerEndRun = New System.Windows.Forms.Timer(Me.components)
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.ArchiveToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ArchiveALLToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.OutlookEmailsToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExchangeEmailsToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ContentToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ScheduleToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SetArchiveIntervalToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExitToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.TasksToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ImpersonateLoginToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.LoginAsDifferenctUserToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ManualEditAppConfigToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ViewLogsToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ViewOCRErrorFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.AddDesktopIconToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.UtilityToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EncryptStringToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.InstallCLCToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ResetPerformanceFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.CEDatabasesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ZIPFilesArchivesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator2 = New System.Windows.Forms.ToolStripSeparator()
        Me.AllToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.InstallCESP2ToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripMenuItem2 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ViewCEDirectoriesToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ReOCRToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EstimateNumberOfFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator3 = New System.Windows.Forms.ToolStripSeparator()
        Me.ReOcrIncompleteGraphicFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ReOcrALLGraphicFilesToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.HelpToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.AboutToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.OnlineHelpToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator4 = New System.Windows.Forms.ToolStripSeparator()
        Me.AppConfigVersionToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.RunningArchiverToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ParameterExecutionToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.HistoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SelectionToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.AllToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EmailToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ContentToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExecutionControlToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FileTypesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TestToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DirectoryInventoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ListFilesInDirectoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.GetAllSubdirFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.OCRToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FileHashToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FileUploadToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FileUploadBufferedToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FileChunkUploadToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.RSSPullToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExitToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.StatusStrip1 = New System.Windows.Forms.StatusStrip()
        Me.infoDaysToExpire = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tssServer = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tssVersion = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tssAuth = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tssUser = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tbExchange = New System.Windows.Forms.ToolStripStatusLabel()
        Me.PB1 = New System.Windows.Forms.ToolStripProgressBar()
        Me.tsStatus02 = New System.Windows.Forms.ToolStripStatusLabel()
        Me.SB5 = New System.Windows.Forms.ToolStripStatusLabel()
        Me.ToolStripStatusLabel1 = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsBytesLoading = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsServiceDBConnState = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsTunnelConn = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsCurrentRepoID = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsLastArchive = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsTimeToArchive = New System.Windows.Forms.ToolStripStatusLabel()
        Me.tsCountDown = New System.Windows.Forms.ToolStripStatusLabel()
        Me.TimerQuickArchive = New System.Windows.Forms.Timer(Me.components)
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.TabPage1 = New System.Windows.Forms.TabPage()
        Me.TabPage2 = New System.Windows.Forms.TabPage()
        Me.TabPage4 = New System.Windows.Forms.TabPage()
        Me.Button5 = New System.Windows.Forms.Button()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.TextBox2 = New System.Windows.Forms.TextBox()
        Me.Label22 = New System.Windows.Forms.Label()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Label21 = New System.Windows.Forms.Label()
        Me.dgRss = New System.Windows.Forms.DataGridView()
        Me.Label20 = New System.Windows.Forms.Label()
        Me.Label17 = New System.Windows.Forms.Label()
        Me.TabPage5 = New System.Windows.Forms.TabPage()
        Me.Button6 = New System.Windows.Forms.Button()
        Me.Button7 = New System.Windows.Forms.Button()
        Me.TextBox3 = New System.Windows.Forms.TextBox()
        Me.Label23 = New System.Windows.Forms.Label()
        Me.TextBox4 = New System.Windows.Forms.TextBox()
        Me.Label24 = New System.Windows.Forms.Label()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.Label25 = New System.Windows.Forms.Label()
        Me.Label18 = New System.Windows.Forms.Label()
        Me.TabPage6 = New System.Windows.Forms.TabPage()
        Me.NumericUpDown4 = New System.Windows.Forms.NumericUpDown()
        Me.NumericUpDown2 = New System.Windows.Forms.NumericUpDown()
        Me.Label30 = New System.Windows.Forms.Label()
        Me.Label29 = New System.Windows.Forms.Label()
        Me.Button8 = New System.Windows.Forms.Button()
        Me.Button9 = New System.Windows.Forms.Button()
        Me.TextBox5 = New System.Windows.Forms.TextBox()
        Me.Label26 = New System.Windows.Forms.Label()
        Me.TextBox6 = New System.Windows.Forms.TextBox()
        Me.Label27 = New System.Windows.Forms.Label()
        Me.DataGridView2 = New System.Windows.Forms.DataGridView()
        Me.Label28 = New System.Windows.Forms.Label()
        Me.Label19 = New System.Windows.Forms.Label()
        Me.TabPage3 = New System.Windows.Forms.TabPage()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.txtCompany = New System.Windows.Forms.TextBox()
        Me.btnActivate = New System.Windows.Forms.Button()
        Me.cbRepo = New System.Windows.Forms.ComboBox()
        Me.Label15 = New System.Windows.Forms.Label()
        Me.Label14 = New System.Windows.Forms.Label()
        Me.btnDefaultAsso = New System.Windows.Forms.Button()
        Me.btnRefreshDefaults = New System.Windows.Forms.Button()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.BackgroundWorker1 = New System.ComponentModel.BackgroundWorker()
        Me.BackgroundWorker2 = New System.ComponentModel.BackgroundWorker()
        Me.BackgroundWorker3 = New System.ComponentModel.BackgroundWorker()
        Me.BackgroundDirListener = New System.ComponentModel.BackgroundWorker()
        Me.BackgroundWorkerContacts = New System.ComponentModel.BackgroundWorker()
        Me.asyncBatchOcrALL = New System.ComponentModel.BackgroundWorker()
        Me.asyncBatchOcrPending = New System.ComponentModel.BackgroundWorker()
        Me.asyncVerifyRetainDates = New System.ComponentModel.BackgroundWorker()
        Me.gbEmail.SuspendLayout()
        CType(Me.NumericUpDown3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.gbFiletypes.SuspendLayout()
        Me.gbPolling.SuspendLayout()
        CType(Me.NumericUpDown1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.gbContentMgt.SuspendLayout()
        Me.Panel2.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.Panel3.SuspendLayout()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ContextMenuStrip1.SuspendLayout()
        Me.MenuStrip1.SuspendLayout()
        Me.StatusStrip1.SuspendLayout()
        Me.TabControl1.SuspendLayout()
        Me.TabPage1.SuspendLayout()
        Me.TabPage2.SuspendLayout()
        Me.TabPage4.SuspendLayout()
        CType(Me.dgRss, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TabPage5.SuspendLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TabPage6.SuspendLayout()
        CType(Me.NumericUpDown4, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.NumericUpDown2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TabPage3.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'gbEmail
        '
        Me.gbEmail.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.gbEmail.BackColor = System.Drawing.Color.LightGray
        Me.gbEmail.Controls.Add(Me.LinkLabel2)
        Me.gbEmail.Controls.Add(Me.LinkLabel1)
        Me.gbEmail.Controls.Add(Me.hlExchange)
        Me.gbEmail.Controls.Add(Me.Label16)
        Me.gbEmail.Controls.Add(Me.Label3)
        Me.gbEmail.Controls.Add(Me.Label2)
        Me.gbEmail.Controls.Add(Me.ckExpand)
        Me.gbEmail.Controls.Add(Me.ckGetSubFolders)
        Me.gbEmail.Controls.Add(Me.ckDoNotShowArchived)
        Me.gbEmail.Controls.Add(Me.cbParentFolders)
        Me.gbEmail.Controls.Add(Me.btnSMTP)
        Me.gbEmail.Controls.Add(Me.cbEmailRetention)
        Me.gbEmail.Controls.Add(Me.ckSystemFolder)
        Me.gbEmail.Controls.Add(Me.ckUseLastProcessDateAsCutoff)
        Me.gbEmail.Controls.Add(Me.ckArchiveRead)
        Me.gbEmail.Controls.Add(Me.btnDeleteEmailEntry)
        Me.gbEmail.Controls.Add(Me.btnActive)
        Me.gbEmail.Controls.Add(Me.cbEmailDB)
        Me.gbEmail.Controls.Add(Me.Label4)
        Me.gbEmail.Controls.Add(Me.NumericUpDown3)
        Me.gbEmail.Controls.Add(Me.ckRemoveAfterXDays)
        Me.gbEmail.Controls.Add(Me.btnRefreshFolders)
        Me.gbEmail.Controls.Add(Me.btnSaveConditions)
        Me.gbEmail.Controls.Add(Me.ckArchiveFolder)
        Me.gbEmail.Controls.Add(Me.lbActiveFolder)
        Me.gbEmail.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.gbEmail.Location = New System.Drawing.Point(9, 6)
        Me.gbEmail.Name = "gbEmail"
        Me.gbEmail.Size = New System.Drawing.Size(913, 489)
        Me.gbEmail.TabIndex = 4
        Me.gbEmail.TabStop = False
        Me.gbEmail.Text = "Outlook Email Archive"
        '
        'LinkLabel2
        '
        Me.LinkLabel2.AutoSize = True
        Me.LinkLabel2.Location = New System.Drawing.Point(410, 25)
        Me.LinkLabel2.Name = "LinkLabel2"
        Me.LinkLabel2.Size = New System.Drawing.Size(45, 13)
        Me.LinkLabel2.TabIndex = 72
        Me.LinkLabel2.TabStop = True
        Me.LinkLabel2.Text = "Validate"
        Me.TT.SetToolTip(Me.LinkLabel2, "If executing from a machine different than your usual, press this button to valid" & _
        "ate your ""access"" level.")
        '
        'LinkLabel1
        '
        Me.LinkLabel1.AutoSize = True
        Me.LinkLabel1.Location = New System.Drawing.Point(352, 25)
        Me.LinkLabel1.Name = "LinkLabel1"
        Me.LinkLabel1.Size = New System.Drawing.Size(52, 13)
        Me.LinkLabel1.TabIndex = 71
        Me.LinkLabel1.TabStop = True
        Me.LinkLabel1.Text = "PST Files"
        '
        'hlExchange
        '
        Me.hlExchange.AutoSize = True
        Me.hlExchange.Location = New System.Drawing.Point(263, 25)
        Me.hlExchange.Name = "hlExchange"
        Me.hlExchange.Size = New System.Drawing.Size(83, 13)
        Me.hlExchange.TabIndex = 70
        Me.hlExchange.TabStop = True
        Me.hlExchange.Text = "Exchange Email"
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.Location = New System.Drawing.Point(6, 370)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(370, 13)
        Me.Label16.TabIndex = 69
        Me.Label16.Text = "Note: All emails are stored private by default. Set up your own library to share." & _
    ""
        Me.TT.SetToolTip(Me.Label16, "Click an item in the grid and right mouse for the library definition menu.")
        '
        'Label3
        '
        Me.Label3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(306, 410)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(83, 13)
        Me.Label3.TabIndex = 68
        Me.Label3.Text = "Retention Rules"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Location = New System.Drawing.Point(6, 48)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(92, 13)
        Me.Label2.TabIndex = 67
        Me.Label2.Text = "Outlook Container"
        '
        'ckExpand
        '
        Me.ckExpand.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckExpand.AutoSize = True
        Me.ckExpand.BackColor = System.Drawing.Color.Transparent
        Me.ckExpand.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckExpand.ForeColor = System.Drawing.Color.Black
        Me.ckExpand.Location = New System.Drawing.Point(827, 66)
        Me.ckExpand.Name = "ckExpand"
        Me.ckExpand.Size = New System.Drawing.Size(68, 17)
        Me.ckExpand.TabIndex = 66
        Me.ckExpand.Text = "Expand"
        Me.ckExpand.UseVisualStyleBackColor = False
        Me.ckExpand.Visible = False
        '
        'ckGetSubFolders
        '
        Me.ckGetSubFolders.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckGetSubFolders.AutoSize = True
        Me.ckGetSubFolders.BackColor = System.Drawing.Color.Transparent
        Me.ckGetSubFolders.ForeColor = System.Drawing.Color.Black
        Me.ckGetSubFolders.Location = New System.Drawing.Point(595, 406)
        Me.ckGetSubFolders.Name = "ckGetSubFolders"
        Me.ckGetSubFolders.Size = New System.Drawing.Size(121, 17)
        Me.ckGetSubFolders.TabIndex = 64
        Me.ckGetSubFolders.Text = "Archive Sub-Folders"
        Me.ckGetSubFolders.UseVisualStyleBackColor = False
        Me.ckGetSubFolders.Visible = False
        '
        'ckDoNotShowArchived
        '
        Me.ckDoNotShowArchived.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckDoNotShowArchived.AutoSize = True
        Me.ckDoNotShowArchived.BackColor = System.Drawing.Color.Transparent
        Me.ckDoNotShowArchived.Checked = True
        Me.ckDoNotShowArchived.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckDoNotShowArchived.ForeColor = System.Drawing.Color.Black
        Me.ckDoNotShowArchived.Location = New System.Drawing.Point(6, 433)
        Me.ckDoNotShowArchived.Name = "ckDoNotShowArchived"
        Me.ckDoNotShowArchived.Size = New System.Drawing.Size(179, 17)
        Me.ckDoNotShowArchived.TabIndex = 62
        Me.ckDoNotShowArchived.Text = "1. Do not show already archived"
        Me.ckDoNotShowArchived.UseVisualStyleBackColor = False
        '
        'cbParentFolders
        '
        Me.cbParentFolders.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbParentFolders.FormattingEnabled = True
        Me.cbParentFolders.Location = New System.Drawing.Point(8, 64)
        Me.cbParentFolders.Name = "cbParentFolders"
        Me.cbParentFolders.Size = New System.Drawing.Size(603, 21)
        Me.cbParentFolders.TabIndex = 59
        Me.TT.SetToolTip(Me.cbParentFolders, "This is the list of Parent Outlook Folders")
        '
        'btnSMTP
        '
        Me.btnSMTP.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnSMTP.Enabled = False
        Me.btnSMTP.Location = New System.Drawing.Point(620, 19)
        Me.btnSMTP.Name = "btnSMTP"
        Me.btnSMTP.Size = New System.Drawing.Size(45, 24)
        Me.btnSMTP.TabIndex = 58
        Me.btnSMTP.Text = "SMTP"
        Me.TT.SetToolTip(Me.btnSMTP, "Set up the SMTP properties")
        Me.btnSMTP.UseVisualStyleBackColor = True
        Me.btnSMTP.Visible = False
        '
        'cbEmailRetention
        '
        Me.cbEmailRetention.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.cbEmailRetention.FormattingEnabled = True
        Me.cbEmailRetention.Location = New System.Drawing.Point(6, 406)
        Me.cbEmailRetention.Name = "cbEmailRetention"
        Me.cbEmailRetention.Size = New System.Drawing.Size(294, 21)
        Me.cbEmailRetention.Sorted = True
        Me.cbEmailRetention.TabIndex = 56
        Me.TT.SetToolTip(Me.cbEmailRetention, "When blank, default retention value will be used.")
        '
        'ckSystemFolder
        '
        Me.ckSystemFolder.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckSystemFolder.AutoSize = True
        Me.ckSystemFolder.BackColor = System.Drawing.Color.Transparent
        Me.ckSystemFolder.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckSystemFolder.ForeColor = System.Drawing.Color.Black
        Me.ckSystemFolder.Location = New System.Drawing.Point(595, 454)
        Me.ckSystemFolder.Name = "ckSystemFolder"
        Me.ckSystemFolder.Size = New System.Drawing.Size(124, 17)
        Me.ckSystemFolder.TabIndex = 38
        Me.ckSystemFolder.Text = "Mandatory Folder"
        Me.TT.SetToolTip(Me.ckSystemFolder, "Admins, Check to make this folder a mandatory backup folder, all users will inclu" & _
        "de this folder.")
        Me.ckSystemFolder.UseVisualStyleBackColor = False
        '
        'ckUseLastProcessDateAsCutoff
        '
        Me.ckUseLastProcessDateAsCutoff.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckUseLastProcessDateAsCutoff.AutoSize = True
        Me.ckUseLastProcessDateAsCutoff.BackColor = System.Drawing.Color.Transparent
        Me.ckUseLastProcessDateAsCutoff.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckUseLastProcessDateAsCutoff.ForeColor = System.Drawing.Color.Black
        Me.ckUseLastProcessDateAsCutoff.Location = New System.Drawing.Point(595, 433)
        Me.ckUseLastProcessDateAsCutoff.Name = "ckUseLastProcessDateAsCutoff"
        Me.ckUseLastProcessDateAsCutoff.Size = New System.Drawing.Size(146, 17)
        Me.ckUseLastProcessDateAsCutoff.TabIndex = 37
        Me.ckUseLastProcessDateAsCutoff.Text = "Use Last Folder Date"
        Me.TT.SetToolTip(Me.ckUseLastProcessDateAsCutoff, "Chieck this to allow only emails downloaded after the successful archive to be co" & _
        "nsidered.")
        Me.ckUseLastProcessDateAsCutoff.UseVisualStyleBackColor = False
        '
        'ckArchiveRead
        '
        Me.ckArchiveRead.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckArchiveRead.AutoSize = True
        Me.ckArchiveRead.BackColor = System.Drawing.Color.Transparent
        Me.ckArchiveRead.ForeColor = System.Drawing.Color.Black
        Me.ckArchiveRead.Location = New System.Drawing.Point(6, 460)
        Me.ckArchiveRead.Name = "ckArchiveRead"
        Me.ckArchiveRead.Size = New System.Drawing.Size(173, 17)
        Me.ckArchiveRead.TabIndex = 36
        Me.ckArchiveRead.Text = "3. Do Not Move Unread Emails"
        Me.ckArchiveRead.UseVisualStyleBackColor = False
        '
        'btnDeleteEmailEntry
        '
        Me.btnDeleteEmailEntry.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnDeleteEmailEntry.BackColor = System.Drawing.Color.Transparent
        Me.btnDeleteEmailEntry.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnDeleteEmailEntry.ForeColor = System.Drawing.Color.Black
        Me.btnDeleteEmailEntry.Location = New System.Drawing.Point(822, 445)
        Me.btnDeleteEmailEntry.Name = "btnDeleteEmailEntry"
        Me.btnDeleteEmailEntry.Size = New System.Drawing.Size(85, 32)
        Me.btnDeleteEmailEntry.TabIndex = 35
        Me.btnDeleteEmailEntry.Text = "Deactivate"
        Me.btnDeleteEmailEntry.UseVisualStyleBackColor = False
        '
        'btnActive
        '
        Me.btnActive.Location = New System.Drawing.Point(131, 19)
        Me.btnActive.Name = "btnActive"
        Me.btnActive.Size = New System.Drawing.Size(114, 24)
        Me.btnActive.TabIndex = 27
        Me.btnActive.Text = "Archived"
        Me.btnActive.UseVisualStyleBackColor = True
        '
        'cbEmailDB
        '
        Me.cbEmailDB.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.cbEmailDB.Enabled = False
        Me.cbEmailDB.FormattingEnabled = True
        Me.cbEmailDB.Location = New System.Drawing.Point(726, 22)
        Me.cbEmailDB.Name = "cbEmailDB"
        Me.cbEmailDB.Size = New System.Drawing.Size(171, 21)
        Me.cbEmailDB.Sorted = True
        Me.cbEmailDB.TabIndex = 26
        Me.cbEmailDB.Text = "ECMREPO"
        Me.cbEmailDB.Visible = False
        '
        'Label4
        '
        Me.Label4.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.ForeColor = System.Drawing.Color.Black
        Me.Label4.Location = New System.Drawing.Point(374, 462)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(32, 13)
        Me.Label4.TabIndex = 17
        Me.Label4.Text = "days."
        '
        'NumericUpDown3
        '
        Me.NumericUpDown3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.NumericUpDown3.BackColor = System.Drawing.Color.White
        Me.NumericUpDown3.Enabled = False
        Me.NumericUpDown3.Location = New System.Drawing.Point(320, 458)
        Me.NumericUpDown3.Name = "NumericUpDown3"
        Me.NumericUpDown3.Size = New System.Drawing.Size(48, 20)
        Me.NumericUpDown3.TabIndex = 16
        Me.NumericUpDown3.Value = New Decimal(New Integer() {30, 0, 0, 0})
        '
        'ckRemoveAfterXDays
        '
        Me.ckRemoveAfterXDays.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckRemoveAfterXDays.AutoSize = True
        Me.ckRemoveAfterXDays.BackColor = System.Drawing.Color.Transparent
        Me.ckRemoveAfterXDays.ForeColor = System.Drawing.Color.Black
        Me.ckRemoveAfterXDays.Location = New System.Drawing.Point(203, 461)
        Me.ckRemoveAfterXDays.Name = "ckRemoveAfterXDays"
        Me.ckRemoveAfterXDays.Size = New System.Drawing.Size(116, 17)
        Me.ckRemoveAfterXDays.TabIndex = 15
        Me.ckRemoveAfterXDays.Text = "4. Move items after"
        Me.TT.SetToolTip(Me.ckRemoveAfterXDays, "Moves expired emails to ECM_HISTORY.")
        Me.ckRemoveAfterXDays.UseVisualStyleBackColor = False
        '
        'btnRefreshFolders
        '
        Me.btnRefreshFolders.Location = New System.Drawing.Point(8, 19)
        Me.btnRefreshFolders.Name = "btnRefreshFolders"
        Me.btnRefreshFolders.Size = New System.Drawing.Size(114, 24)
        Me.btnRefreshFolders.TabIndex = 10
        Me.btnRefreshFolders.Text = "Avail For Archive"
        Me.btnRefreshFolders.UseVisualStyleBackColor = True
        '
        'btnSaveConditions
        '
        Me.btnSaveConditions.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSaveConditions.BackColor = System.Drawing.Color.Transparent
        Me.btnSaveConditions.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnSaveConditions.Location = New System.Drawing.Point(821, 399)
        Me.btnSaveConditions.Name = "btnSaveConditions"
        Me.btnSaveConditions.Size = New System.Drawing.Size(86, 32)
        Me.btnSaveConditions.TabIndex = 8
        Me.btnSaveConditions.Text = "Activate"
        Me.btnSaveConditions.UseVisualStyleBackColor = False
        '
        'ckArchiveFolder
        '
        Me.ckArchiveFolder.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckArchiveFolder.AutoSize = True
        Me.ckArchiveFolder.BackColor = System.Drawing.Color.Transparent
        Me.ckArchiveFolder.ForeColor = System.Drawing.Color.Black
        Me.ckArchiveFolder.Location = New System.Drawing.Point(203, 433)
        Me.ckArchiveFolder.Name = "ckArchiveFolder"
        Me.ckArchiveFolder.Size = New System.Drawing.Size(150, 17)
        Me.ckArchiveFolder.TabIndex = 7
        Me.ckArchiveFolder.Text = "2. Archive Emails in Folder"
        Me.ckArchiveFolder.UseVisualStyleBackColor = False
        '
        'lbActiveFolder
        '
        Me.lbActiveFolder.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbActiveFolder.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.lbActiveFolder.FormattingEnabled = True
        Me.lbActiveFolder.Location = New System.Drawing.Point(6, 90)
        Me.lbActiveFolder.Name = "lbActiveFolder"
        Me.lbActiveFolder.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lbActiveFolder.Size = New System.Drawing.Size(889, 277)
        Me.lbActiveFolder.Sorted = True
        Me.lbActiveFolder.TabIndex = 6
        Me.TT.SetToolTip(Me.lbActiveFolder, "Select and right mouse to set libraries.")
        '
        'lblVer
        '
        Me.lblVer.AutoSize = True
        Me.lblVer.BackColor = System.Drawing.Color.Silver
        Me.lblVer.ForeColor = System.Drawing.Color.Black
        Me.lblVer.Location = New System.Drawing.Point(894, 8)
        Me.lblVer.Name = "lblVer"
        Me.lblVer.Size = New System.Drawing.Size(46, 13)
        Me.lblVer.TabIndex = 69
        Me.lblVer.Text = "12.8.8.2"
        '
        'SB
        '
        Me.SB.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SB.BackColor = System.Drawing.Color.Gainsboro
        Me.SB.Location = New System.Drawing.Point(264, 579)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(468, 20)
        Me.SB.TabIndex = 30
        '
        'gbFiletypes
        '
        Me.gbFiletypes.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.gbFiletypes.BackColor = System.Drawing.Color.Silver
        Me.gbFiletypes.Controls.Add(Me.cbProcessAsList)
        Me.gbFiletypes.Controls.Add(Me.Button2)
        Me.gbFiletypes.Controls.Add(Me.Button1)
        Me.gbFiletypes.Controls.Add(Me.Label10)
        Me.gbFiletypes.Controls.Add(Me.Label9)
        Me.gbFiletypes.Controls.Add(Me.cbAsType)
        Me.gbFiletypes.Controls.Add(Me.cbPocessType)
        Me.gbFiletypes.Controls.Add(Me.ckRemoveFileType)
        Me.gbFiletypes.Controls.Add(Me.cbFileTypes)
        Me.gbFiletypes.Controls.Add(Me.btnAddFiletype)
        Me.gbFiletypes.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.gbFiletypes.Location = New System.Drawing.Point(9, 218)
        Me.gbFiletypes.Name = "gbFiletypes"
        Me.gbFiletypes.Size = New System.Drawing.Size(530, 112)
        Me.gbFiletypes.TabIndex = 29
        Me.gbFiletypes.TabStop = False
        Me.gbFiletypes.Text = "File Types"
        '
        'cbProcessAsList
        '
        Me.cbProcessAsList.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbProcessAsList.FormattingEnabled = True
        Me.cbProcessAsList.Location = New System.Drawing.Point(8, 80)
        Me.cbProcessAsList.Name = "cbProcessAsList"
        Me.cbProcessAsList.Size = New System.Drawing.Size(412, 21)
        Me.cbProcessAsList.TabIndex = 49
        '
        'Button2
        '
        Me.Button2.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Button2.Location = New System.Drawing.Point(441, 78)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(72, 24)
        Me.Button2.TabIndex = 48
        Me.Button2.Text = "Remove"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Button1.Location = New System.Drawing.Point(441, 54)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(72, 24)
        Me.Button1.TabIndex = 47
        Me.Button1.Text = "Add"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Label10
        '
        Me.Label10.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(104, 40)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(54, 13)
        Me.Label10.TabIndex = 46
        Me.Label10.Text = "2. As type"
        '
        'Label9
        '
        Me.Label9.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(8, 40)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(80, 13)
        Me.Label9.TabIndex = 45
        Me.Label9.Text = "1. Process type"
        '
        'cbAsType
        '
        Me.cbAsType.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbAsType.FormattingEnabled = True
        Me.cbAsType.Location = New System.Drawing.Point(104, 56)
        Me.cbAsType.Name = "cbAsType"
        Me.cbAsType.Size = New System.Drawing.Size(316, 21)
        Me.cbAsType.Sorted = True
        Me.cbAsType.TabIndex = 44
        '
        'cbPocessType
        '
        Me.cbPocessType.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbPocessType.FormattingEnabled = True
        Me.cbPocessType.Location = New System.Drawing.Point(8, 56)
        Me.cbPocessType.Name = "cbPocessType"
        Me.cbPocessType.Size = New System.Drawing.Size(316, 21)
        Me.cbPocessType.Sorted = True
        Me.cbPocessType.TabIndex = 43
        '
        'ckRemoveFileType
        '
        Me.ckRemoveFileType.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckRemoveFileType.Location = New System.Drawing.Point(473, 14)
        Me.ckRemoveFileType.Name = "ckRemoveFileType"
        Me.ckRemoveFileType.Size = New System.Drawing.Size(32, 24)
        Me.ckRemoveFileType.TabIndex = 3
        Me.ckRemoveFileType.Text = "X"
        Me.ckRemoveFileType.UseVisualStyleBackColor = True
        '
        'cbFileTypes
        '
        Me.cbFileTypes.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbFileTypes.FormattingEnabled = True
        Me.cbFileTypes.Location = New System.Drawing.Point(8, 16)
        Me.cbFileTypes.Name = "cbFileTypes"
        Me.cbFileTypes.Size = New System.Drawing.Size(412, 21)
        Me.cbFileTypes.Sorted = True
        Me.cbFileTypes.TabIndex = 2
        '
        'btnAddFiletype
        '
        Me.btnAddFiletype.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnAddFiletype.Location = New System.Drawing.Point(441, 14)
        Me.btnAddFiletype.Name = "btnAddFiletype"
        Me.btnAddFiletype.Size = New System.Drawing.Size(32, 24)
        Me.btnAddFiletype.TabIndex = 1
        Me.btnAddFiletype.Text = "+"
        Me.btnAddFiletype.UseVisualStyleBackColor = True
        '
        'gbPolling
        '
        Me.gbPolling.BackColor = System.Drawing.Color.DimGray
        Me.gbPolling.Controls.Add(Me.ckRunOnStart)
        Me.gbPolling.Controls.Add(Me.btnArchiveNow)
        Me.gbPolling.Controls.Add(Me.Label1)
        Me.gbPolling.Controls.Add(Me.NumericUpDown1)
        Me.gbPolling.Controls.Add(Me.ckRunUnattended)
        Me.gbPolling.Controls.Add(Me.ckDisableExchange)
        Me.gbPolling.Controls.Add(Me.ckDisableOutlookEmailArchive)
        Me.gbPolling.Controls.Add(Me.ckDisableContentArchive)
        Me.gbPolling.Controls.Add(Me.btnSaveSchedule)
        Me.gbPolling.Controls.Add(Me.ckDisable)
        Me.gbPolling.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.gbPolling.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.gbPolling.Location = New System.Drawing.Point(9, 22)
        Me.gbPolling.Name = "gbPolling"
        Me.gbPolling.Size = New System.Drawing.Size(534, 171)
        Me.gbPolling.TabIndex = 27
        Me.gbPolling.TabStop = False
        Me.gbPolling.Text = "Execution Parameters"
        '
        'ckRunOnStart
        '
        Me.ckRunOnStart.AutoSize = True
        Me.ckRunOnStart.Location = New System.Drawing.Point(117, 147)
        Me.ckRunOnStart.Name = "ckRunOnStart"
        Me.ckRunOnStart.Size = New System.Drawing.Size(105, 17)
        Me.ckRunOnStart.TabIndex = 33
        Me.ckRunOnStart.Text = "6. Run at startup"
        Me.TT.SetToolTip(Me.ckRunOnStart, "When checked, the ECM Archive module will start when you login to your computer.")
        Me.ckRunOnStart.UseVisualStyleBackColor = True
        '
        'btnArchiveNow
        '
        Me.btnArchiveNow.ForeColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.btnArchiveNow.Location = New System.Drawing.Point(289, 42)
        Me.btnArchiveNow.Name = "btnArchiveNow"
        Me.btnArchiveNow.Size = New System.Drawing.Size(27, 23)
        Me.btnArchiveNow.TabIndex = 16
        Me.btnArchiveNow.Text = "@"
        Me.btnArchiveNow.UseVisualStyleBackColor = True
        Me.btnArchiveNow.Visible = False
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.ForeColor = System.Drawing.Color.White
        Me.Label1.Location = New System.Drawing.Point(322, 47)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(77, 13)
        Me.Label1.TabIndex = 15
        Me.Label1.Text = "Quick Archive:"
        '
        'NumericUpDown1
        '
        Me.NumericUpDown1.Location = New System.Drawing.Point(325, 65)
        Me.NumericUpDown1.Maximum = New Decimal(New Integer() {96, 0, 0, 0})
        Me.NumericUpDown1.Name = "NumericUpDown1"
        Me.NumericUpDown1.Size = New System.Drawing.Size(74, 20)
        Me.NumericUpDown1.TabIndex = 14
        Me.TT.SetToolTip(Me.NumericUpDown1, "Set to ZERO to turn off or any number of hours between 4 and 96.")
        '
        'ckRunUnattended
        '
        Me.ckRunUnattended.AutoSize = True
        Me.ckRunUnattended.ForeColor = System.Drawing.Color.White
        Me.ckRunUnattended.Location = New System.Drawing.Point(104, 124)
        Me.ckRunUnattended.Name = "ckRunUnattended"
        Me.ckRunUnattended.Size = New System.Drawing.Size(117, 17)
        Me.ckRunUnattended.TabIndex = 13
        Me.ckRunUnattended.Text = "5. Run Unattended"
        Me.ckRunUnattended.UseVisualStyleBackColor = True
        '
        'ckDisableExchange
        '
        Me.ckDisableExchange.AutoSize = True
        Me.ckDisableExchange.Checked = True
        Me.ckDisableExchange.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckDisableExchange.ForeColor = System.Drawing.Color.White
        Me.ckDisableExchange.Location = New System.Drawing.Point(85, 101)
        Me.ckDisableExchange.Name = "ckDisableExchange"
        Me.ckDisableExchange.Size = New System.Drawing.Size(124, 17)
        Me.ckDisableExchange.TabIndex = 11
        Me.ckDisableExchange.Text = "4. Disable Exchange"
        Me.TT.SetToolTip(Me.ckDisableExchange, "Checking this will disable Exchange archive.")
        Me.ckDisableExchange.UseVisualStyleBackColor = True
        '
        'ckDisableOutlookEmailArchive
        '
        Me.ckDisableOutlookEmailArchive.AutoSize = True
        Me.ckDisableOutlookEmailArchive.Checked = True
        Me.ckDisableOutlookEmailArchive.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckDisableOutlookEmailArchive.ForeColor = System.Drawing.Color.White
        Me.ckDisableOutlookEmailArchive.Location = New System.Drawing.Point(64, 78)
        Me.ckDisableOutlookEmailArchive.Name = "ckDisableOutlookEmailArchive"
        Me.ckDisableOutlookEmailArchive.Size = New System.Drawing.Size(207, 17)
        Me.ckDisableOutlookEmailArchive.TabIndex = 10
        Me.ckDisableOutlookEmailArchive.Text = "3. Disable Outlook Email and Contacts"
        Me.TT.SetToolTip(Me.ckDisableOutlookEmailArchive, "Checking this will disable EMAIL archive.")
        Me.ckDisableOutlookEmailArchive.UseVisualStyleBackColor = True
        '
        'ckDisableContentArchive
        '
        Me.ckDisableContentArchive.AutoSize = True
        Me.ckDisableContentArchive.Checked = True
        Me.ckDisableContentArchive.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckDisableContentArchive.ForeColor = System.Drawing.Color.White
        Me.ckDisableContentArchive.Location = New System.Drawing.Point(52, 55)
        Me.ckDisableContentArchive.Name = "ckDisableContentArchive"
        Me.ckDisableContentArchive.Size = New System.Drawing.Size(113, 17)
        Me.ckDisableContentArchive.TabIndex = 9
        Me.ckDisableContentArchive.Text = "2. Disable Content"
        Me.TT.SetToolTip(Me.ckDisableContentArchive, "Checking this will disable Content archive")
        Me.ckDisableContentArchive.UseVisualStyleBackColor = True
        '
        'btnSaveSchedule
        '
        Me.btnSaveSchedule.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.btnSaveSchedule.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnSaveSchedule.ForeColor = System.Drawing.Color.Black
        Me.btnSaveSchedule.Location = New System.Drawing.Point(325, 116)
        Me.btnSaveSchedule.Name = "btnSaveSchedule"
        Me.btnSaveSchedule.Size = New System.Drawing.Size(66, 30)
        Me.btnSaveSchedule.TabIndex = 6
        Me.btnSaveSchedule.Text = "Save"
        Me.btnSaveSchedule.UseVisualStyleBackColor = False
        '
        'ckDisable
        '
        Me.ckDisable.AutoSize = True
        Me.ckDisable.Checked = True
        Me.ckDisable.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckDisable.ForeColor = System.Drawing.Color.White
        Me.ckDisable.Location = New System.Drawing.Point(27, 32)
        Me.ckDisable.Name = "ckDisable"
        Me.ckDisable.Size = New System.Drawing.Size(87, 17)
        Me.ckDisable.TabIndex = 4
        Me.ckDisable.Text = "1. Disable All"
        Me.TT.SetToolTip(Me.ckDisable, "Checking this will disable EMAIL, Exchange and Content archive.")
        Me.ckDisable.UseVisualStyleBackColor = True
        '
        'gbContentMgt
        '
        Me.gbContentMgt.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.gbContentMgt.BackColor = System.Drawing.Color.Silver
        Me.gbContentMgt.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.gbContentMgt.Controls.Add(Me.btnCountFiles)
        Me.gbContentMgt.Controls.Add(Me.Panel2)
        Me.gbContentMgt.Controls.Add(Me.lbArchiveDirs)
        Me.gbContentMgt.Controls.Add(Me.Panel1)
        Me.gbContentMgt.Controls.Add(Me.Panel3)
        Me.gbContentMgt.FlatStyle = System.Windows.Forms.FlatStyle.Popup
        Me.gbContentMgt.Location = New System.Drawing.Point(6, 6)
        Me.gbContentMgt.Name = "gbContentMgt"
        Me.gbContentMgt.Size = New System.Drawing.Size(916, 606)
        Me.gbContentMgt.TabIndex = 33
        Me.gbContentMgt.TabStop = False
        Me.gbContentMgt.Text = "File Archive"
        '
        'btnCountFiles
        '
        Me.btnCountFiles.Location = New System.Drawing.Point(559, 260)
        Me.btnCountFiles.Name = "btnCountFiles"
        Me.btnCountFiles.Size = New System.Drawing.Size(22, 19)
        Me.btnCountFiles.TabIndex = 81
        Me.btnCountFiles.Text = "#"
        Me.TT.SetToolTip(Me.btnCountFiles, "Count the files in the selected directory.")
        Me.btnCountFiles.UseVisualStyleBackColor = True
        '
        'Panel2
        '
        Me.Panel2.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Panel2.BackColor = System.Drawing.Color.Silver
        Me.Panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel2.Controls.Add(Me.ckDeleteAfterArchive)
        Me.Panel2.Controls.Add(Me.ckOcrPdf)
        Me.Panel2.Controls.Add(Me.ckShowLibs)
        Me.Panel2.Controls.Add(Me.btnRefreshRetent)
        Me.Panel2.Controls.Add(Me.CkMonitor)
        Me.Panel2.Controls.Add(Me.ckArchiveBit)
        Me.Panel2.Controls.Add(Me.Label13)
        Me.Panel2.Controls.Add(Me.cbRetention)
        Me.Panel2.Controls.Add(Me.ckOcr)
        Me.Panel2.Controls.Add(Me.clAdminDir)
        Me.Panel2.Controls.Add(Me.ckDisableDir)
        Me.Panel2.Controls.Add(Me.ckPublic)
        Me.Panel2.Controls.Add(Me.ckMetaData)
        Me.Panel2.Controls.Add(Me.ckVersionFiles)
        Me.Panel2.Controls.Add(Me.ckSubDirs)
        Me.Panel2.Controls.Add(Me.txtDir)
        Me.Panel2.Controls.Add(Me.btnRefresh)
        Me.Panel2.Controls.Add(Me.btnSaveChanges)
        Me.Panel2.Controls.Add(Me.btnRemoveDir)
        Me.Panel2.Controls.Add(Me.btnSelDir)
        Me.Panel2.Location = New System.Drawing.Point(8, 286)
        Me.Panel2.Name = "Panel2"
        Me.Panel2.Size = New System.Drawing.Size(573, 198)
        Me.Panel2.TabIndex = 79
        '
        'ckDeleteAfterArchive
        '
        Me.ckDeleteAfterArchive.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckDeleteAfterArchive.AutoSize = True
        Me.ckDeleteAfterArchive.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckDeleteAfterArchive.ForeColor = System.Drawing.Color.Black
        Me.ckDeleteAfterArchive.Location = New System.Drawing.Point(170, 172)
        Me.ckDeleteAfterArchive.Name = "ckDeleteAfterArchive"
        Me.ckDeleteAfterArchive.Size = New System.Drawing.Size(172, 17)
        Me.ckDeleteAfterArchive.TabIndex = 78
        Me.ckDeleteAfterArchive.Text = "12. Remove After Archive"
        Me.TT.SetToolTip(Me.ckDeleteAfterArchive, "Delete the FILE after successful Archive.")
        Me.ckDeleteAfterArchive.UseVisualStyleBackColor = True
        '
        'ckOcrPdf
        '
        Me.ckOcrPdf.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckOcrPdf.AutoSize = True
        Me.ckOcrPdf.ForeColor = System.Drawing.Color.Black
        Me.ckOcrPdf.Location = New System.Drawing.Point(2, 132)
        Me.ckOcrPdf.Name = "ckOcrPdf"
        Me.ckOcrPdf.Size = New System.Drawing.Size(130, 17)
        Me.ckOcrPdf.TabIndex = 77
        Me.ckOcrPdf.Text = "4. OCR PDF Graphics"
        Me.TT.SetToolTip(Me.ckOcrPdf, "When checked, the assumption is made that th OCR is not a searchable PDF.  It wil" & _
        "l be separated into pages and OCR'D. It is time consuming. To override ALL set t" & _
        "he SYS_EcmPDFX system parameter.")
        Me.ckOcrPdf.UseVisualStyleBackColor = True
        '
        'ckShowLibs
        '
        Me.ckShowLibs.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckShowLibs.AutoSize = True
        Me.ckShowLibs.ForeColor = System.Drawing.Color.Black
        Me.ckShowLibs.Location = New System.Drawing.Point(170, 132)
        Me.ckShowLibs.Name = "ckShowLibs"
        Me.ckShowLibs.Size = New System.Drawing.Size(113, 17)
        Me.ckShowLibs.TabIndex = 76
        Me.ckShowLibs.Text = "10. Show Libraries"
        Me.TT.SetToolTip(Me.ckShowLibs, "Check to show popup of assigned libraries.")
        Me.ckShowLibs.UseVisualStyleBackColor = True
        '
        'btnRefreshRetent
        '
        Me.btnRefreshRetent.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnRefreshRetent.BackColor = System.Drawing.Color.Transparent
        Me.btnRefreshRetent.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.btnRefreshRetent.ForeColor = System.Drawing.Color.White
        Me.btnRefreshRetent.Location = New System.Drawing.Point(437, 45)
        Me.btnRefreshRetent.Name = "btnRefreshRetent"
        Me.btnRefreshRetent.Size = New System.Drawing.Size(25, 18)
        Me.btnRefreshRetent.TabIndex = 75
        Me.TT.SetToolTip(Me.btnRefreshRetent, "Refresh retention rules.")
        Me.btnRefreshRetent.UseVisualStyleBackColor = False
        '
        'CkMonitor
        '
        Me.CkMonitor.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.CkMonitor.AutoSize = True
        Me.CkMonitor.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.CkMonitor.ForeColor = System.Drawing.Color.Black
        Me.CkMonitor.Location = New System.Drawing.Point(170, 153)
        Me.CkMonitor.Name = "CkMonitor"
        Me.CkMonitor.Size = New System.Drawing.Size(82, 17)
        Me.CkMonitor.TabIndex = 74
        Me.CkMonitor.Text = "11. Listen"
        Me.TT.SetToolTip(Me.CkMonitor, "Track changes to this directory instantly.")
        Me.CkMonitor.UseVisualStyleBackColor = True
        '
        'ckArchiveBit
        '
        Me.ckArchiveBit.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckArchiveBit.AutoSize = True
        Me.ckArchiveBit.ForeColor = System.Drawing.Color.Black
        Me.ckArchiveBit.Location = New System.Drawing.Point(2, 152)
        Me.ckArchiveBit.Name = "ckArchiveBit"
        Me.ckArchiveBit.Size = New System.Drawing.Size(137, 17)
        Me.ckArchiveBit.TabIndex = 73
        Me.ckArchiveBit.Text = "5. Skip If Archive Bit on"
        Me.TT.SetToolTip(Me.ckArchiveBit, "If a files archive bit is set OOF, it will skipped during archive processing.")
        Me.ckArchiveBit.UseVisualStyleBackColor = True
        '
        'Label13
        '
        Me.Label13.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label13.AutoSize = True
        Me.Label13.ForeColor = System.Drawing.Color.Black
        Me.Label13.Location = New System.Drawing.Point(26, 45)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(81, 13)
        Me.Label13.TabIndex = 63
        Me.Label13.Text = "Retention Rule:"
        '
        'cbRetention
        '
        Me.cbRetention.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbRetention.FormattingEnabled = True
        Me.cbRetention.Location = New System.Drawing.Point(114, 41)
        Me.cbRetention.Name = "cbRetention"
        Me.cbRetention.Size = New System.Drawing.Size(317, 21)
        Me.cbRetention.Sorted = True
        Me.cbRetention.TabIndex = 55
        Me.TT.SetToolTip(Me.cbRetention, "When blank, default retention value will be used.")
        '
        'ckOcr
        '
        Me.ckOcr.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckOcr.AutoSize = True
        Me.ckOcr.ForeColor = System.Drawing.Color.Black
        Me.ckOcr.Location = New System.Drawing.Point(2, 112)
        Me.ckOcr.Name = "ckOcr"
        Me.ckOcr.Size = New System.Drawing.Size(129, 17)
        Me.ckOcr.TabIndex = 54
        Me.ckOcr.Text = "3. OCR This Directory"
        Me.ckOcr.UseVisualStyleBackColor = True
        '
        'clAdminDir
        '
        Me.clAdminDir.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.clAdminDir.AutoSize = True
        Me.clAdminDir.ForeColor = System.Drawing.Color.Black
        Me.clAdminDir.Location = New System.Drawing.Point(170, 92)
        Me.clAdminDir.Name = "clAdminDir"
        Me.clAdminDir.Size = New System.Drawing.Size(104, 17)
        Me.clAdminDir.TabIndex = 51
        Me.clAdminDir.Text = "8. Mandatory Dir"
        Me.TT.SetToolTip(Me.clAdminDir, "Admins, Check to make this direcyory a mandatory backup folder, all users will in" & _
        "clude this directory.")
        Me.clAdminDir.UseVisualStyleBackColor = True
        '
        'ckDisableDir
        '
        Me.ckDisableDir.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckDisableDir.AutoSize = True
        Me.ckDisableDir.ForeColor = System.Drawing.Color.Black
        Me.ckDisableDir.Location = New System.Drawing.Point(2, 92)
        Me.ckDisableDir.Name = "ckDisableDir"
        Me.ckDisableDir.Size = New System.Drawing.Size(128, 17)
        Me.ckDisableDir.TabIndex = 45
        Me.ckDisableDir.Text = "2. Disable Dir Archive"
        Me.TT.SetToolTip(Me.ckDisableDir, "Disable Archive for selected Directory")
        Me.ckDisableDir.UseVisualStyleBackColor = True
        '
        'ckPublic
        '
        Me.ckPublic.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckPublic.AutoSize = True
        Me.ckPublic.ForeColor = System.Drawing.Color.Black
        Me.ckPublic.Location = New System.Drawing.Point(170, 112)
        Me.ckPublic.Name = "ckPublic"
        Me.ckPublic.Size = New System.Drawing.Size(97, 17)
        Me.ckPublic.TabIndex = 44
        Me.ckPublic.Text = "9. Make Public"
        Me.ckPublic.UseVisualStyleBackColor = True
        '
        'ckMetaData
        '
        Me.ckMetaData.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckMetaData.AutoSize = True
        Me.ckMetaData.ForeColor = System.Drawing.Color.Black
        Me.ckMetaData.Location = New System.Drawing.Point(170, 72)
        Me.ckMetaData.Name = "ckMetaData"
        Me.ckMetaData.Size = New System.Drawing.Size(123, 17)
        Me.ckMetaData.TabIndex = 43
        Me.ckMetaData.Text = "7. Capture Metadata"
        Me.TT.SetToolTip(Me.ckMetaData, "This requires Windows OFFICE be installed locally to function correctly.")
        Me.ckMetaData.UseVisualStyleBackColor = True
        '
        'ckVersionFiles
        '
        Me.ckVersionFiles.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckVersionFiles.AutoSize = True
        Me.ckVersionFiles.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckVersionFiles.ForeColor = System.Drawing.Color.Black
        Me.ckVersionFiles.Location = New System.Drawing.Point(2, 172)
        Me.ckVersionFiles.Name = "ckVersionFiles"
        Me.ckVersionFiles.Size = New System.Drawing.Size(113, 17)
        Me.ckVersionFiles.TabIndex = 40
        Me.ckVersionFiles.Text = "6. Version Files"
        Me.ckVersionFiles.UseVisualStyleBackColor = True
        '
        'ckSubDirs
        '
        Me.ckSubDirs.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckSubDirs.AutoSize = True
        Me.ckSubDirs.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckSubDirs.ForeColor = System.Drawing.Color.Black
        Me.ckSubDirs.Location = New System.Drawing.Point(2, 72)
        Me.ckSubDirs.Name = "ckSubDirs"
        Me.ckSubDirs.Size = New System.Drawing.Size(129, 17)
        Me.ckSubDirs.TabIndex = 38
        Me.ckSubDirs.Text = "1. Include Subdirs"
        Me.ckSubDirs.UseVisualStyleBackColor = True
        '
        'txtDir
        '
        Me.txtDir.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDir.BackColor = System.Drawing.Color.WhiteSmoke
        Me.txtDir.Location = New System.Drawing.Point(114, 14)
        Me.txtDir.Name = "txtDir"
        Me.txtDir.Size = New System.Drawing.Size(453, 20)
        Me.txtDir.TabIndex = 37
        Me.TT.SetToolTip(Me.txtDir, "Use a %userid% to substitute in the user ID at that position in the directory str" & _
        "ing.")
        '
        'btnRefresh
        '
        Me.btnRefresh.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnRefresh.ForeColor = System.Drawing.Color.Black
        Me.btnRefresh.Location = New System.Drawing.Point(0, 14)
        Me.btnRefresh.Name = "btnRefresh"
        Me.btnRefresh.Size = New System.Drawing.Size(108, 23)
        Me.btnRefresh.TabIndex = 24
        Me.btnRefresh.Text = "Show Disabled"
        Me.TT.SetToolTip(Me.btnRefresh, "This is a dual use button - Click to show enabled or disabled directories")
        Me.btnRefresh.UseVisualStyleBackColor = True
        '
        'btnSaveChanges
        '
        Me.btnSaveChanges.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSaveChanges.BackColor = System.Drawing.Color.Turquoise
        Me.btnSaveChanges.Location = New System.Drawing.Point(479, 145)
        Me.btnSaveChanges.Name = "btnSaveChanges"
        Me.btnSaveChanges.Size = New System.Drawing.Size(88, 44)
        Me.btnSaveChanges.TabIndex = 23
        Me.btnSaveChanges.Text = "Save Changes to Archive"
        Me.btnSaveChanges.UseVisualStyleBackColor = False
        '
        'btnRemoveDir
        '
        Me.btnRemoveDir.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnRemoveDir.BackColor = System.Drawing.Color.Transparent
        Me.btnRemoveDir.ForeColor = System.Drawing.Color.Black
        Me.btnRemoveDir.Location = New System.Drawing.Point(479, 93)
        Me.btnRemoveDir.Name = "btnRemoveDir"
        Me.btnRemoveDir.Size = New System.Drawing.Size(88, 44)
        Me.btnRemoveDir.TabIndex = 11
        Me.btnRemoveDir.Text = "Remove Dir from Archive"
        Me.btnRemoveDir.UseVisualStyleBackColor = False
        '
        'btnSelDir
        '
        Me.btnSelDir.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSelDir.ForeColor = System.Drawing.Color.Black
        Me.btnSelDir.Location = New System.Drawing.Point(479, 41)
        Me.btnSelDir.Name = "btnSelDir"
        Me.btnSelDir.Size = New System.Drawing.Size(88, 44)
        Me.btnSelDir.TabIndex = 9
        Me.btnSelDir.Text = "Select Dir for Archive"
        Me.btnSelDir.UseVisualStyleBackColor = True
        '
        'lbArchiveDirs
        '
        Me.lbArchiveDirs.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbArchiveDirs.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.lbArchiveDirs.ForeColor = System.Drawing.Color.Black
        Me.lbArchiveDirs.FormattingEnabled = True
        Me.lbArchiveDirs.Location = New System.Drawing.Point(8, 16)
        Me.lbArchiveDirs.Name = "lbArchiveDirs"
        Me.lbArchiveDirs.Size = New System.Drawing.Size(573, 238)
        Me.lbArchiveDirs.Sorted = True
        Me.lbArchiveDirs.TabIndex = 0
        '
        'Panel1
        '
        Me.Panel1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Panel1.BackColor = System.Drawing.Color.LightGray
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.Label7)
        Me.Panel1.Controls.Add(Me.lbExcludeExts)
        Me.Panel1.Controls.Add(Me.Label6)
        Me.Panel1.Controls.Add(Me.Label5)
        Me.Panel1.Controls.Add(Me.lbAvailExts)
        Me.Panel1.Controls.Add(Me.lbIncludeExts)
        Me.Panel1.Controls.Add(Me.Button3)
        Me.Panel1.Controls.Add(Me.btnRemoveExclude)
        Me.Panel1.Controls.Add(Me.btnInclFileType)
        Me.Panel1.Controls.Add(Me.btnExclude)
        Me.Panel1.Location = New System.Drawing.Point(606, 16)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(291, 238)
        Me.Panel1.TabIndex = 78
        '
        'Label7
        '
        Me.Label7.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(111, 0)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(54, 13)
        Me.Label7.TabIndex = 47
        Me.Label7.Text = "Excluded:"
        '
        'lbExcludeExts
        '
        Me.lbExcludeExts.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbExcludeExts.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.lbExcludeExts.FormattingEnabled = True
        Me.lbExcludeExts.Location = New System.Drawing.Point(101, 16)
        Me.lbExcludeExts.Name = "lbExcludeExts"
        Me.lbExcludeExts.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lbExcludeExts.Size = New System.Drawing.Size(75, 147)
        Me.lbExcludeExts.Sorted = True
        Me.lbExcludeExts.TabIndex = 46
        '
        'Label6
        '
        Me.Label6.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(25, 0)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(51, 13)
        Me.Label6.TabIndex = 32
        Me.Label6.Text = "Included:"
        '
        'Label5
        '
        Me.Label5.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(201, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(50, 13)
        Me.Label5.TabIndex = 31
        Me.Label5.Text = "Available"
        '
        'lbAvailExts
        '
        Me.lbAvailExts.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbAvailExts.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.lbAvailExts.FormattingEnabled = True
        Me.lbAvailExts.Location = New System.Drawing.Point(189, 16)
        Me.lbAvailExts.Name = "lbAvailExts"
        Me.lbAvailExts.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lbAvailExts.Size = New System.Drawing.Size(75, 147)
        Me.lbAvailExts.Sorted = True
        Me.lbAvailExts.TabIndex = 30
        '
        'lbIncludeExts
        '
        Me.lbIncludeExts.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbIncludeExts.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.lbIncludeExts.FormattingEnabled = True
        Me.lbIncludeExts.Location = New System.Drawing.Point(13, 16)
        Me.lbIncludeExts.Name = "lbIncludeExts"
        Me.lbIncludeExts.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lbIncludeExts.Size = New System.Drawing.Size(75, 147)
        Me.lbIncludeExts.Sorted = True
        Me.lbIncludeExts.TabIndex = 28
        '
        'Button3
        '
        Me.Button3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Button3.BackColor = System.Drawing.Color.Transparent
        Me.Button3.ForeColor = System.Drawing.Color.Black
        Me.Button3.Location = New System.Drawing.Point(13, 185)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(82, 24)
        Me.Button3.TabIndex = 39
        Me.Button3.Text = "1. Remove"
        Me.Button3.UseVisualStyleBackColor = False
        '
        'btnRemoveExclude
        '
        Me.btnRemoveExclude.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnRemoveExclude.BackColor = System.Drawing.Color.Transparent
        Me.btnRemoveExclude.ForeColor = System.Drawing.Color.Black
        Me.btnRemoveExclude.Location = New System.Drawing.Point(100, 185)
        Me.btnRemoveExclude.Name = "btnRemoveExclude"
        Me.btnRemoveExclude.Size = New System.Drawing.Size(82, 24)
        Me.btnRemoveExclude.TabIndex = 48
        Me.btnRemoveExclude.Text = "2. Remove"
        Me.btnRemoveExclude.UseVisualStyleBackColor = False
        '
        'btnInclFileType
        '
        Me.btnInclFileType.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnInclFileType.Location = New System.Drawing.Point(188, 185)
        Me.btnInclFileType.Name = "btnInclFileType"
        Me.btnInclFileType.Size = New System.Drawing.Size(82, 24)
        Me.btnInclFileType.TabIndex = 35
        Me.btnInclFileType.Text = "3. Include"
        Me.btnInclFileType.UseVisualStyleBackColor = True
        '
        'btnExclude
        '
        Me.btnExclude.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnExclude.Location = New System.Drawing.Point(188, 207)
        Me.btnExclude.Name = "btnExclude"
        Me.btnExclude.Size = New System.Drawing.Size(82, 24)
        Me.btnExclude.TabIndex = 49
        Me.btnExclude.Text = "4. Exclude"
        Me.btnExclude.UseVisualStyleBackColor = True
        '
        'Panel3
        '
        Me.Panel3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Panel3.BackColor = System.Drawing.Color.Gainsboro
        Me.Panel3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel3.Controls.Add(Me.btnAddDefaults)
        Me.Panel3.Controls.Add(Me.btnRefreshRebuild)
        Me.Panel3.Controls.Add(Me.Label12)
        Me.Panel3.Controls.Add(Me.btnDeleteDirProfile)
        Me.Panel3.Controls.Add(Me.btnUpdateDirectoryProfile)
        Me.Panel3.Controls.Add(Me.btnSaveDirProfile)
        Me.Panel3.Controls.Add(Me.btnApplyDirProfile)
        Me.Panel3.Controls.Add(Me.cbDirProfile)
        Me.Panel3.Controls.Add(Me.Label11)
        Me.Panel3.Controls.Add(Me.btnExclProfile)
        Me.Panel3.Controls.Add(Me.btnInclProfile)
        Me.Panel3.Controls.Add(Me.cbProfile)
        Me.Panel3.Location = New System.Drawing.Point(607, 286)
        Me.Panel3.Name = "Panel3"
        Me.Panel3.Size = New System.Drawing.Size(290, 158)
        Me.Panel3.TabIndex = 80
        '
        'btnAddDefaults
        '
        Me.btnAddDefaults.Location = New System.Drawing.Point(239, 24)
        Me.btnAddDefaults.Name = "btnAddDefaults"
        Me.btnAddDefaults.Size = New System.Drawing.Size(24, 23)
        Me.btnAddDefaults.TabIndex = 74
        Me.btnAddDefaults.Text = "!"
        Me.TT.SetToolTip(Me.btnAddDefaults, "Reset default values.")
        Me.btnAddDefaults.UseVisualStyleBackColor = True
        '
        'btnRefreshRebuild
        '
        Me.btnRefreshRebuild.ForeColor = System.Drawing.Color.Black
        Me.btnRefreshRebuild.Location = New System.Drawing.Point(239, 100)
        Me.btnRefreshRebuild.Name = "btnRefreshRebuild"
        Me.btnRefreshRebuild.Size = New System.Drawing.Size(24, 23)
        Me.btnRefreshRebuild.TabIndex = 73
        Me.btnRefreshRebuild.Text = "@"
        Me.TT.SetToolTip(Me.btnRefreshRebuild, "Refreshes the list of available and existing profiles adding any missing default " & _
        "members.")
        Me.btnRefreshRebuild.UseVisualStyleBackColor = True
        '
        'Label12
        '
        Me.Label12.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(76, 85)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(111, 13)
        Me.Label12.TabIndex = 72
        Me.Label12.Text = "Select Archive Profile:"
        '
        'btnDeleteDirProfile
        '
        Me.btnDeleteDirProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnDeleteDirProfile.Location = New System.Drawing.Point(185, 128)
        Me.btnDeleteDirProfile.Name = "btnDeleteDirProfile"
        Me.btnDeleteDirProfile.Size = New System.Drawing.Size(44, 21)
        Me.btnDeleteDirProfile.TabIndex = 71
        Me.btnDeleteDirProfile.Text = "Del"
        Me.TT.SetToolTip(Me.btnDeleteDirProfile, "Delete currently selected directory profile.")
        Me.btnDeleteDirProfile.UseVisualStyleBackColor = True
        '
        'btnUpdateDirectoryProfile
        '
        Me.btnUpdateDirectoryProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnUpdateDirectoryProfile.Location = New System.Drawing.Point(134, 128)
        Me.btnUpdateDirectoryProfile.Name = "btnUpdateDirectoryProfile"
        Me.btnUpdateDirectoryProfile.Size = New System.Drawing.Size(44, 21)
        Me.btnUpdateDirectoryProfile.TabIndex = 70
        Me.btnUpdateDirectoryProfile.Text = "Updt"
        Me.TT.SetToolTip(Me.btnUpdateDirectoryProfile, "Update selected directory profile to current settings")
        Me.btnUpdateDirectoryProfile.UseVisualStyleBackColor = True
        '
        'btnSaveDirProfile
        '
        Me.btnSaveDirProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSaveDirProfile.Location = New System.Drawing.Point(83, 128)
        Me.btnSaveDirProfile.Name = "btnSaveDirProfile"
        Me.btnSaveDirProfile.Size = New System.Drawing.Size(44, 21)
        Me.btnSaveDirProfile.TabIndex = 69
        Me.btnSaveDirProfile.Text = "Save"
        Me.TT.SetToolTip(Me.btnSaveDirProfile, "Save current setup as NEW directory profile")
        Me.btnSaveDirProfile.UseVisualStyleBackColor = True
        '
        'btnApplyDirProfile
        '
        Me.btnApplyDirProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnApplyDirProfile.Location = New System.Drawing.Point(32, 128)
        Me.btnApplyDirProfile.Name = "btnApplyDirProfile"
        Me.btnApplyDirProfile.Size = New System.Drawing.Size(44, 21)
        Me.btnApplyDirProfile.TabIndex = 68
        Me.btnApplyDirProfile.Text = "Aply"
        Me.TT.SetToolTip(Me.btnApplyDirProfile, "Apply selected directory profile")
        Me.btnApplyDirProfile.UseVisualStyleBackColor = True
        '
        'cbDirProfile
        '
        Me.cbDirProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbDirProfile.FormattingEnabled = True
        Me.cbDirProfile.Location = New System.Drawing.Point(32, 101)
        Me.cbDirProfile.Name = "cbDirProfile"
        Me.cbDirProfile.Size = New System.Drawing.Size(198, 21)
        Me.cbDirProfile.TabIndex = 66
        Me.TT.SetToolTip(Me.cbDirProfile, "Currently defined directory profiles")
        '
        'Label11
        '
        Me.Label11.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label11.AutoSize = True
        Me.Label11.Location = New System.Drawing.Point(76, 7)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(111, 13)
        Me.Label11.TabIndex = 64
        Me.Label11.Text = "Select Filetype Profile:"
        '
        'btnExclProfile
        '
        Me.btnExclProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnExclProfile.Location = New System.Drawing.Point(135, 48)
        Me.btnExclProfile.Name = "btnExclProfile"
        Me.btnExclProfile.Size = New System.Drawing.Size(86, 28)
        Me.btnExclProfile.TabIndex = 58
        Me.btnExclProfile.Text = "E&xclude"
        Me.TT.SetToolTip(Me.btnExclProfile, "Exclude selected profile.")
        Me.btnExclProfile.UseVisualStyleBackColor = True
        '
        'btnInclProfile
        '
        Me.btnInclProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnInclProfile.Location = New System.Drawing.Point(41, 48)
        Me.btnInclProfile.Name = "btnInclProfile"
        Me.btnInclProfile.Size = New System.Drawing.Size(86, 28)
        Me.btnInclProfile.TabIndex = 57
        Me.btnInclProfile.Text = "&Apply"
        Me.TT.SetToolTip(Me.btnInclProfile, "Include selected profile.")
        Me.btnInclProfile.UseVisualStyleBackColor = True
        '
        'cbProfile
        '
        Me.cbProfile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbProfile.FormattingEnabled = True
        Me.cbProfile.Location = New System.Drawing.Point(41, 23)
        Me.cbProfile.Name = "cbProfile"
        Me.cbProfile.Size = New System.Drawing.Size(180, 21)
        Me.cbProfile.TabIndex = 56
        '
        'Label8
        '
        Me.Label8.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label8.AutoSize = True
        Me.Label8.ForeColor = System.Drawing.Color.White
        Me.Label8.Location = New System.Drawing.Point(45, 581)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(90, 13)
        Me.Label8.TabIndex = 34
        Me.Label8.Text = "Select Repository"
        Me.Label8.Visible = False
        '
        'cbFileDB
        '
        Me.cbFileDB.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbFileDB.Enabled = False
        Me.cbFileDB.FormattingEnabled = True
        Me.cbFileDB.Location = New System.Drawing.Point(48, 604)
        Me.cbFileDB.Name = "cbFileDB"
        Me.cbFileDB.Size = New System.Drawing.Size(182, 21)
        Me.cbFileDB.Sorted = True
        Me.cbFileDB.TabIndex = 27
        Me.cbFileDB.Text = "ECMREPO"
        Me.cbFileDB.Visible = False
        '
        'btnAddDir
        '
        Me.btnAddDir.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnAddDir.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(64, Byte), Integer))
        Me.btnAddDir.Location = New System.Drawing.Point(142, 576)
        Me.btnAddDir.Name = "btnAddDir"
        Me.btnAddDir.Size = New System.Drawing.Size(88, 23)
        Me.btnAddDir.TabIndex = 10
        Me.btnAddDir.Text = "Include Dir"
        Me.btnAddDir.UseVisualStyleBackColor = True
        Me.btnAddDir.Visible = False
        '
        'PictureBox1
        '
        Me.PictureBox1.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PictureBox1.Image = CType(resources.GetObject("PictureBox1.Image"), System.Drawing.Image)
        Me.PictureBox1.Location = New System.Drawing.Point(748, 582)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(37, 43)
        Me.PictureBox1.TabIndex = 75
        Me.PictureBox1.TabStop = False
        Me.PictureBox1.Visible = False
        Me.PictureBox1.WaitOnLoad = True
        '
        'ckTerminate
        '
        Me.ckTerminate.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckTerminate.AutoSize = True
        Me.ckTerminate.ForeColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ckTerminate.Location = New System.Drawing.Point(796, 608)
        Me.ckTerminate.Name = "ckTerminate"
        Me.ckTerminate.Size = New System.Drawing.Size(144, 17)
        Me.ckTerminate.TabIndex = 66
        Me.ckTerminate.Text = "Teminate current archive"
        Me.TT.SetToolTip(Me.ckTerminate, "Check to terminate currently running archive.")
        Me.ckTerminate.UseVisualStyleBackColor = True
        '
        'ckPauseListener
        '
        Me.ckPauseListener.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckPauseListener.AutoSize = True
        Me.ckPauseListener.ForeColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.ckPauseListener.Location = New System.Drawing.Point(796, 582)
        Me.ckPauseListener.Name = "ckPauseListener"
        Me.ckPauseListener.Size = New System.Drawing.Size(123, 17)
        Me.ckPauseListener.TabIndex = 76
        Me.ckPauseListener.Text = "Pause ALL Listeners"
        Me.TT.SetToolTip(Me.ckPauseListener, "Check to pause ALL directory listeners.")
        Me.ckPauseListener.UseVisualStyleBackColor = True
        '
        'btnFetch
        '
        Me.btnFetch.BackColor = System.Drawing.SystemColors.ButtonFace
        Me.btnFetch.Location = New System.Drawing.Point(215, 35)
        Me.btnFetch.Name = "btnFetch"
        Me.btnFetch.Size = New System.Drawing.Size(70, 27)
        Me.btnFetch.TabIndex = 6
        Me.btnFetch.Text = "Fetch"
        Me.TT.SetToolTip(Me.btnFetch, "Retrieve the associated repositories.")
        Me.btnFetch.UseVisualStyleBackColor = False
        '
        'f1Help
        '
        Me.f1Help.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/frmReconMain.htm"
        '
        'SB2
        '
        Me.SB2.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SB2.BackColor = System.Drawing.Color.Gainsboro
        Me.SB2.Location = New System.Drawing.Point(264, 605)
        Me.SB2.Name = "SB2"
        Me.SB2.Size = New System.Drawing.Size(468, 20)
        Me.SB2.TabIndex = 44
        '
        'PBx
        '
        Me.PBx.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PBx.Location = New System.Drawing.Point(25, 3)
        Me.PBx.Name = "PBx"
        Me.PBx.Size = New System.Drawing.Size(913, 18)
        Me.PBx.TabIndex = 45
        '
        'ContextMenuStrip1
        '
        Me.ContextMenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ResetSelectedMailBoxesToolStripMenuItem, Me.EmailLibraryReassignmentToolStripMenuItem})
        Me.ContextMenuStrip1.Name = "ContextMenuStrip1"
        Me.ContextMenuStrip1.Size = New System.Drawing.Size(209, 48)
        '
        'ResetSelectedMailBoxesToolStripMenuItem
        '
        Me.ResetSelectedMailBoxesToolStripMenuItem.Name = "ResetSelectedMailBoxesToolStripMenuItem"
        Me.ResetSelectedMailBoxesToolStripMenuItem.Size = New System.Drawing.Size(208, 22)
        Me.ResetSelectedMailBoxesToolStripMenuItem.Text = "Reset Selected Mail Boxes"
        '
        'EmailLibraryReassignmentToolStripMenuItem
        '
        Me.EmailLibraryReassignmentToolStripMenuItem.Name = "EmailLibraryReassignmentToolStripMenuItem"
        Me.EmailLibraryReassignmentToolStripMenuItem.Size = New System.Drawing.Size(208, 22)
        Me.EmailLibraryReassignmentToolStripMenuItem.Text = "Email Library Assignment"
        '
        'TimerListeners
        '
        Me.TimerListeners.Interval = 60000
        '
        'TimerUploadFiles
        '
        Me.TimerUploadFiles.Interval = 30000
        '
        'TimerEndRun
        '
        Me.TimerEndRun.Interval = 30000
        '
        'MenuStrip1
        '
        Me.MenuStrip1.BackColor = System.Drawing.Color.Silver
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ArchiveToolStripMenuItem, Me.TasksToolStripMenuItem, Me.HelpToolStripMenuItem, Me.SelectionToolStripMenuItem, Me.TestToolStripMenuItem, Me.ExitToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(962, 24)
        Me.MenuStrip1.TabIndex = 77
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'ArchiveToolStripMenuItem
        '
        Me.ArchiveToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ArchiveALLToolStripMenuItem, Me.OutlookEmailsToolStripMenuItem, Me.ExchangeEmailsToolStripMenuItem, Me.ContentToolStripMenuItem, Me.ToolStripMenuItem1, Me.ScheduleToolStripMenuItem, Me.SetArchiveIntervalToolStripMenuItem, Me.ExitToolStripMenuItem1})
        Me.ArchiveToolStripMenuItem.Name = "ArchiveToolStripMenuItem"
        Me.ArchiveToolStripMenuItem.Size = New System.Drawing.Size(59, 20)
        Me.ArchiveToolStripMenuItem.Text = "Archive"
        '
        'ArchiveALLToolStripMenuItem
        '
        Me.ArchiveALLToolStripMenuItem.Name = "ArchiveALLToolStripMenuItem"
        Me.ArchiveALLToolStripMenuItem.Size = New System.Drawing.Size(175, 22)
        Me.ArchiveALLToolStripMenuItem.Text = "Archive ALL"
        '
        'OutlookEmailsToolStripMenuItem
        '
        Me.OutlookEmailsToolStripMenuItem.Name = "OutlookEmailsToolStripMenuItem"
        Me.OutlookEmailsToolStripMenuItem.Size = New System.Drawing.Size(175, 22)
        Me.OutlookEmailsToolStripMenuItem.Text = "Outlook Emails"
        '
        'ExchangeEmailsToolStripMenuItem
        '
        Me.ExchangeEmailsToolStripMenuItem.Name = "ExchangeEmailsToolStripMenuItem"
        Me.ExchangeEmailsToolStripMenuItem.Size = New System.Drawing.Size(175, 22)
        Me.ExchangeEmailsToolStripMenuItem.Text = "Exchange Emails"
        '
        'ContentToolStripMenuItem
        '
        Me.ContentToolStripMenuItem.Name = "ContentToolStripMenuItem"
        Me.ContentToolStripMenuItem.Size = New System.Drawing.Size(175, 22)
        Me.ContentToolStripMenuItem.Text = "Content"
        '
        'ToolStripMenuItem1
        '
        Me.ToolStripMenuItem1.Name = "ToolStripMenuItem1"
        Me.ToolStripMenuItem1.Size = New System.Drawing.Size(175, 22)
        Me.ToolStripMenuItem1.Text = "Outlook Contacts"
        '
        'ScheduleToolStripMenuItem
        '
        Me.ScheduleToolStripMenuItem.Name = "ScheduleToolStripMenuItem"
        Me.ScheduleToolStripMenuItem.Size = New System.Drawing.Size(175, 22)
        Me.ScheduleToolStripMenuItem.Text = "Schedule"
        '
        'SetArchiveIntervalToolStripMenuItem
        '
        Me.SetArchiveIntervalToolStripMenuItem.Name = "SetArchiveIntervalToolStripMenuItem"
        Me.SetArchiveIntervalToolStripMenuItem.Size = New System.Drawing.Size(175, 22)
        Me.SetArchiveIntervalToolStripMenuItem.Text = "Set Archive Interval"
        '
        'ExitToolStripMenuItem1
        '
        Me.ExitToolStripMenuItem1.Name = "ExitToolStripMenuItem1"
        Me.ExitToolStripMenuItem1.Size = New System.Drawing.Size(175, 22)
        Me.ExitToolStripMenuItem1.Text = "Exit"
        '
        'TasksToolStripMenuItem
        '
        Me.TasksToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ImpersonateLoginToolStripMenuItem, Me.LoginAsDifferenctUserToolStripMenuItem, Me.ManualEditAppConfigToolStripMenuItem, Me.ViewLogsToolStripMenuItem, Me.ViewOCRErrorFilesToolStripMenuItem, Me.AddDesktopIconToolStripMenuItem, Me.UtilityToolStripMenuItem})
        Me.TasksToolStripMenuItem.Name = "TasksToolStripMenuItem"
        Me.TasksToolStripMenuItem.Size = New System.Drawing.Size(48, 20)
        Me.TasksToolStripMenuItem.Text = "Tasks"
        '
        'ImpersonateLoginToolStripMenuItem
        '
        Me.ImpersonateLoginToolStripMenuItem.Name = "ImpersonateLoginToolStripMenuItem"
        Me.ImpersonateLoginToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.ImpersonateLoginToolStripMenuItem.Text = "Archiver Login"
        Me.ImpersonateLoginToolStripMenuItem.ToolTipText = "Set the login here that will be automatically used for archives on this machine."
        '
        'LoginAsDifferenctUserToolStripMenuItem
        '
        Me.LoginAsDifferenctUserToolStripMenuItem.Name = "LoginAsDifferenctUserToolStripMenuItem"
        Me.LoginAsDifferenctUserToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.LoginAsDifferenctUserToolStripMenuItem.Text = "Login as different User"
        '
        'ManualEditAppConfigToolStripMenuItem
        '
        Me.ManualEditAppConfigToolStripMenuItem.Name = "ManualEditAppConfigToolStripMenuItem"
        Me.ManualEditAppConfigToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.ManualEditAppConfigToolStripMenuItem.Text = "(Manual Edit) App Config"
        '
        'ViewLogsToolStripMenuItem
        '
        Me.ViewLogsToolStripMenuItem.Name = "ViewLogsToolStripMenuItem"
        Me.ViewLogsToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.ViewLogsToolStripMenuItem.Text = "View Logs"
        '
        'ViewOCRErrorFilesToolStripMenuItem
        '
        Me.ViewOCRErrorFilesToolStripMenuItem.Name = "ViewOCRErrorFilesToolStripMenuItem"
        Me.ViewOCRErrorFilesToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.ViewOCRErrorFilesToolStripMenuItem.Text = "View OCR Error Files"
        '
        'AddDesktopIconToolStripMenuItem
        '
        Me.AddDesktopIconToolStripMenuItem.Name = "AddDesktopIconToolStripMenuItem"
        Me.AddDesktopIconToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.AddDesktopIconToolStripMenuItem.Text = "Add Desktop Icon"
        '
        'UtilityToolStripMenuItem
        '
        Me.UtilityToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.EncryptStringToolStripMenuItem, Me.InstallCLCToolStripMenuItem, Me.ResetPerformanceFilesToolStripMenuItem, Me.ReOCRToolStripMenuItem})
        Me.UtilityToolStripMenuItem.Name = "UtilityToolStripMenuItem"
        Me.UtilityToolStripMenuItem.Size = New System.Drawing.Size(209, 22)
        Me.UtilityToolStripMenuItem.Text = "Utility"
        '
        'EncryptStringToolStripMenuItem
        '
        Me.EncryptStringToolStripMenuItem.Name = "EncryptStringToolStripMenuItem"
        Me.EncryptStringToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.EncryptStringToolStripMenuItem.Text = "Encrypt String"
        '
        'InstallCLCToolStripMenuItem
        '
        Me.InstallCLCToolStripMenuItem.Name = "InstallCLCToolStripMenuItem"
        Me.InstallCLCToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.InstallCLCToolStripMenuItem.Text = "Install CLC"
        '
        'ResetPerformanceFilesToolStripMenuItem
        '
        Me.ResetPerformanceFilesToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.CEDatabasesToolStripMenuItem, Me.ZIPFilesArchivesToolStripMenuItem, Me.ToolStripSeparator2, Me.AllToolStripMenuItem1, Me.ToolStripSeparator1, Me.InstallCESP2ToolStripMenuItem1, Me.ToolStripMenuItem2, Me.ViewCEDirectoriesToolStripMenuItem1})
        Me.ResetPerformanceFilesToolStripMenuItem.Name = "ResetPerformanceFilesToolStripMenuItem"
        Me.ResetPerformanceFilesToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.ResetPerformanceFilesToolStripMenuItem.Text = "Performance Files"
        '
        'CEDatabasesToolStripMenuItem
        '
        Me.CEDatabasesToolStripMenuItem.Name = "CEDatabasesToolStripMenuItem"
        Me.CEDatabasesToolStripMenuItem.Size = New System.Drawing.Size(196, 22)
        Me.CEDatabasesToolStripMenuItem.Text = "Reset CE Databases"
        '
        'ZIPFilesArchivesToolStripMenuItem
        '
        Me.ZIPFilesArchivesToolStripMenuItem.Name = "ZIPFilesArchivesToolStripMenuItem"
        Me.ZIPFilesArchivesToolStripMenuItem.Size = New System.Drawing.Size(196, 22)
        Me.ZIPFilesArchivesToolStripMenuItem.Text = "Reset ZIP Files Archives"
        '
        'ToolStripSeparator2
        '
        Me.ToolStripSeparator2.Name = "ToolStripSeparator2"
        Me.ToolStripSeparator2.Size = New System.Drawing.Size(193, 6)
        '
        'AllToolStripMenuItem1
        '
        Me.AllToolStripMenuItem1.Name = "AllToolStripMenuItem1"
        Me.AllToolStripMenuItem1.Size = New System.Drawing.Size(196, 22)
        Me.AllToolStripMenuItem1.Text = "Reset All"
        '
        'ToolStripSeparator1
        '
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(193, 6)
        '
        'InstallCESP2ToolStripMenuItem1
        '
        Me.InstallCESP2ToolStripMenuItem1.Name = "InstallCESP2ToolStripMenuItem1"
        Me.InstallCESP2ToolStripMenuItem1.Size = New System.Drawing.Size(196, 22)
        Me.InstallCESP2ToolStripMenuItem1.Text = "Install CE SP2"
        '
        'ToolStripMenuItem2
        '
        Me.ToolStripMenuItem2.Name = "ToolStripMenuItem2"
        Me.ToolStripMenuItem2.Size = New System.Drawing.Size(196, 22)
        Me.ToolStripMenuItem2.Text = "Mirror CE Databases"
        '
        'ViewCEDirectoriesToolStripMenuItem1
        '
        Me.ViewCEDirectoriesToolStripMenuItem1.Name = "ViewCEDirectoriesToolStripMenuItem1"
        Me.ViewCEDirectoriesToolStripMenuItem1.Size = New System.Drawing.Size(196, 22)
        Me.ViewCEDirectoriesToolStripMenuItem1.Text = "View CE Directories"
        '
        'ReOCRToolStripMenuItem
        '
        Me.ReOCRToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.EstimateNumberOfFilesToolStripMenuItem, Me.ToolStripSeparator3, Me.ReOcrIncompleteGraphicFilesToolStripMenuItem, Me.ReOcrALLGraphicFilesToolStripMenuItem1})
        Me.ReOCRToolStripMenuItem.Name = "ReOCRToolStripMenuItem"
        Me.ReOCRToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.ReOCRToolStripMenuItem.Text = "Re-OCR"
        '
        'EstimateNumberOfFilesToolStripMenuItem
        '
        Me.EstimateNumberOfFilesToolStripMenuItem.Name = "EstimateNumberOfFilesToolStripMenuItem"
        Me.EstimateNumberOfFilesToolStripMenuItem.Size = New System.Drawing.Size(242, 22)
        Me.EstimateNumberOfFilesToolStripMenuItem.Text = "Estimate number of Files"
        '
        'ToolStripSeparator3
        '
        Me.ToolStripSeparator3.Name = "ToolStripSeparator3"
        Me.ToolStripSeparator3.Size = New System.Drawing.Size(239, 6)
        '
        'ReOcrIncompleteGraphicFilesToolStripMenuItem
        '
        Me.ReOcrIncompleteGraphicFilesToolStripMenuItem.Name = "ReOcrIncompleteGraphicFilesToolStripMenuItem"
        Me.ReOcrIncompleteGraphicFilesToolStripMenuItem.Size = New System.Drawing.Size(242, 22)
        Me.ReOcrIncompleteGraphicFilesToolStripMenuItem.Text = "Re-Ocr Incomplete Graphic files"
        '
        'ReOcrALLGraphicFilesToolStripMenuItem1
        '
        Me.ReOcrALLGraphicFilesToolStripMenuItem1.Name = "ReOcrALLGraphicFilesToolStripMenuItem1"
        Me.ReOcrALLGraphicFilesToolStripMenuItem1.Size = New System.Drawing.Size(242, 22)
        Me.ReOcrALLGraphicFilesToolStripMenuItem1.Text = "Re-Ocr ALL Graphic files"
        '
        'HelpToolStripMenuItem
        '
        Me.HelpToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.AboutToolStripMenuItem, Me.OnlineHelpToolStripMenuItem, Me.ToolStripSeparator4, Me.AppConfigVersionToolStripMenuItem, Me.RunningArchiverToolStripMenuItem, Me.ParameterExecutionToolStripMenuItem, Me.HistoryToolStripMenuItem})
        Me.HelpToolStripMenuItem.Name = "HelpToolStripMenuItem"
        Me.HelpToolStripMenuItem.Size = New System.Drawing.Size(44, 20)
        Me.HelpToolStripMenuItem.Text = "Help"
        '
        'AboutToolStripMenuItem
        '
        Me.AboutToolStripMenuItem.Name = "AboutToolStripMenuItem"
        Me.AboutToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.AboutToolStripMenuItem.Text = "About"
        '
        'OnlineHelpToolStripMenuItem
        '
        Me.OnlineHelpToolStripMenuItem.Name = "OnlineHelpToolStripMenuItem"
        Me.OnlineHelpToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.OnlineHelpToolStripMenuItem.Text = "On-line Help"
        '
        'ToolStripSeparator4
        '
        Me.ToolStripSeparator4.Name = "ToolStripSeparator4"
        Me.ToolStripSeparator4.Size = New System.Drawing.Size(179, 6)
        '
        'AppConfigVersionToolStripMenuItem
        '
        Me.AppConfigVersionToolStripMenuItem.Name = "AppConfigVersionToolStripMenuItem"
        Me.AppConfigVersionToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.AppConfigVersionToolStripMenuItem.Text = "App Config Version"
        '
        'RunningArchiverToolStripMenuItem
        '
        Me.RunningArchiverToolStripMenuItem.Name = "RunningArchiverToolStripMenuItem"
        Me.RunningArchiverToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.RunningArchiverToolStripMenuItem.Text = "Running Archiver"
        '
        'ParameterExecutionToolStripMenuItem
        '
        Me.ParameterExecutionToolStripMenuItem.Name = "ParameterExecutionToolStripMenuItem"
        Me.ParameterExecutionToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.ParameterExecutionToolStripMenuItem.Text = "Parameter Execution"
        '
        'HistoryToolStripMenuItem
        '
        Me.HistoryToolStripMenuItem.Name = "HistoryToolStripMenuItem"
        Me.HistoryToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.HistoryToolStripMenuItem.Text = "History"
        '
        'SelectionToolStripMenuItem
        '
        Me.SelectionToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.AllToolStripMenuItem, Me.EmailToolStripMenuItem, Me.ContentToolStripMenuItem1, Me.ExecutionControlToolStripMenuItem, Me.FileTypesToolStripMenuItem})
        Me.SelectionToolStripMenuItem.Name = "SelectionToolStripMenuItem"
        Me.SelectionToolStripMenuItem.Size = New System.Drawing.Size(67, 20)
        Me.SelectionToolStripMenuItem.Text = "Selection"
        '
        'AllToolStripMenuItem
        '
        Me.AllToolStripMenuItem.Name = "AllToolStripMenuItem"
        Me.AllToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.AllToolStripMenuItem.Text = "All"
        '
        'EmailToolStripMenuItem
        '
        Me.EmailToolStripMenuItem.Name = "EmailToolStripMenuItem"
        Me.EmailToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.EmailToolStripMenuItem.Text = "Email"
        '
        'ContentToolStripMenuItem1
        '
        Me.ContentToolStripMenuItem1.Name = "ContentToolStripMenuItem1"
        Me.ContentToolStripMenuItem1.Size = New System.Drawing.Size(168, 22)
        Me.ContentToolStripMenuItem1.Text = "Content"
        '
        'ExecutionControlToolStripMenuItem
        '
        Me.ExecutionControlToolStripMenuItem.Name = "ExecutionControlToolStripMenuItem"
        Me.ExecutionControlToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.ExecutionControlToolStripMenuItem.Text = "Execution Control"
        '
        'FileTypesToolStripMenuItem
        '
        Me.FileTypesToolStripMenuItem.Name = "FileTypesToolStripMenuItem"
        Me.FileTypesToolStripMenuItem.Size = New System.Drawing.Size(168, 22)
        Me.FileTypesToolStripMenuItem.Text = "File Types"
        '
        'TestToolStripMenuItem
        '
        Me.TestToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.DirectoryInventoryToolStripMenuItem, Me.ListFilesInDirectoryToolStripMenuItem, Me.GetAllSubdirFilesToolStripMenuItem, Me.OCRToolStripMenuItem, Me.FileHashToolStripMenuItem, Me.FileUploadToolStripMenuItem, Me.FileUploadBufferedToolStripMenuItem, Me.FileChunkUploadToolStripMenuItem, Me.RSSPullToolStripMenuItem})
        Me.TestToolStripMenuItem.Name = "TestToolStripMenuItem"
        Me.TestToolStripMenuItem.Size = New System.Drawing.Size(41, 20)
        Me.TestToolStripMenuItem.Text = "Test"
        '
        'DirectoryInventoryToolStripMenuItem
        '
        Me.DirectoryInventoryToolStripMenuItem.Name = "DirectoryInventoryToolStripMenuItem"
        Me.DirectoryInventoryToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.DirectoryInventoryToolStripMenuItem.Text = "Directory Inventory"
        '
        'ListFilesInDirectoryToolStripMenuItem
        '
        Me.ListFilesInDirectoryToolStripMenuItem.Name = "ListFilesInDirectoryToolStripMenuItem"
        Me.ListFilesInDirectoryToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.ListFilesInDirectoryToolStripMenuItem.Text = "List Files in Directory"
        '
        'GetAllSubdirFilesToolStripMenuItem
        '
        Me.GetAllSubdirFilesToolStripMenuItem.Name = "GetAllSubdirFilesToolStripMenuItem"
        Me.GetAllSubdirFilesToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.GetAllSubdirFilesToolStripMenuItem.Text = "Get All Subdir Files"
        '
        'OCRToolStripMenuItem
        '
        Me.OCRToolStripMenuItem.Name = "OCRToolStripMenuItem"
        Me.OCRToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.OCRToolStripMenuItem.Text = "OCR"
        '
        'FileHashToolStripMenuItem
        '
        Me.FileHashToolStripMenuItem.Name = "FileHashToolStripMenuItem"
        Me.FileHashToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.FileHashToolStripMenuItem.Text = "File Hash"
        '
        'FileUploadToolStripMenuItem
        '
        Me.FileUploadToolStripMenuItem.Name = "FileUploadToolStripMenuItem"
        Me.FileUploadToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.FileUploadToolStripMenuItem.Text = "File Upload File"
        '
        'FileUploadBufferedToolStripMenuItem
        '
        Me.FileUploadBufferedToolStripMenuItem.Name = "FileUploadBufferedToolStripMenuItem"
        Me.FileUploadBufferedToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.FileUploadBufferedToolStripMenuItem.Text = "File Upload Buffered"
        '
        'FileChunkUploadToolStripMenuItem
        '
        Me.FileChunkUploadToolStripMenuItem.Name = "FileChunkUploadToolStripMenuItem"
        Me.FileChunkUploadToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.FileChunkUploadToolStripMenuItem.Text = "File Chunk Upload"
        '
        'RSSPullToolStripMenuItem
        '
        Me.RSSPullToolStripMenuItem.Name = "RSSPullToolStripMenuItem"
        Me.RSSPullToolStripMenuItem.Size = New System.Drawing.Size(182, 22)
        Me.RSSPullToolStripMenuItem.Text = "RSS Pull"
        '
        'ExitToolStripMenuItem
        '
        Me.ExitToolStripMenuItem.Name = "ExitToolStripMenuItem"
        Me.ExitToolStripMenuItem.Size = New System.Drawing.Size(37, 20)
        Me.ExitToolStripMenuItem.Text = "Exit"
        '
        'StatusStrip1
        '
        Me.StatusStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.infoDaysToExpire, Me.tssServer, Me.tssVersion, Me.tssAuth, Me.tssUser, Me.tbExchange, Me.PB1, Me.tsStatus02, Me.SB5, Me.ToolStripStatusLabel1, Me.tsBytesLoading, Me.tsServiceDBConnState, Me.tsTunnelConn, Me.tsCurrentRepoID, Me.tsLastArchive, Me.tsTimeToArchive, Me.tsCountDown})
        Me.StatusStrip1.Location = New System.Drawing.Point(0, 639)
        Me.StatusStrip1.Name = "StatusStrip1"
        Me.StatusStrip1.Size = New System.Drawing.Size(962, 22)
        Me.StatusStrip1.TabIndex = 78
        Me.StatusStrip1.Text = "StatusStrip1"
        '
        'infoDaysToExpire
        '
        Me.infoDaysToExpire.ForeColor = System.Drawing.Color.Yellow
        Me.infoDaysToExpire.Name = "infoDaysToExpire"
        Me.infoDaysToExpire.Size = New System.Drawing.Size(32, 17)
        Me.infoDaysToExpire.Text = "Days"
        '
        'tssServer
        '
        Me.tssServer.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tssServer.Name = "tssServer"
        Me.tssServer.Size = New System.Drawing.Size(39, 17)
        Me.tssServer.Text = "Server"
        '
        'tssVersion
        '
        Me.tssVersion.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tssVersion.Name = "tssVersion"
        Me.tssVersion.Size = New System.Drawing.Size(46, 17)
        Me.tssVersion.Text = "Version"
        '
        'tssAuth
        '
        Me.tssAuth.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tssAuth.Name = "tssAuth"
        Me.tssAuth.Size = New System.Drawing.Size(57, 17)
        Me.tssAuth.Text = "Authority"
        '
        'tssUser
        '
        Me.tssUser.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tssUser.Name = "tssUser"
        Me.tssUser.Size = New System.Drawing.Size(30, 17)
        Me.tssUser.Text = "User"
        '
        'tbExchange
        '
        Me.tbExchange.ForeColor = System.Drawing.SystemColors.ControlLightLight
        Me.tbExchange.Name = "tbExchange"
        Me.tbExchange.Size = New System.Drawing.Size(16, 17)
        Me.tbExchange.Text = "..."
        '
        'PB1
        '
        Me.PB1.Name = "PB1"
        Me.PB1.Size = New System.Drawing.Size(100, 16)
        '
        'tsStatus02
        '
        Me.tsStatus02.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tsStatus02.Name = "tsStatus02"
        Me.tsStatus02.Size = New System.Drawing.Size(39, 17)
        Me.tsStatus02.Text = "Status"
        '
        'SB5
        '
        Me.SB5.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.SB5.Name = "SB5"
        Me.SB5.Size = New System.Drawing.Size(40, 17)
        Me.SB5.Text = "Active"
        Me.SB5.ToolTipText = "Status"
        '
        'ToolStripStatusLabel1
        '
        Me.ToolStripStatusLabel1.ForeColor = System.Drawing.SystemColors.ButtonFace
        Me.ToolStripStatusLabel1.Name = "ToolStripStatusLabel1"
        Me.ToolStripStatusLabel1.Size = New System.Drawing.Size(40, 17)
        Me.ToolStripStatusLabel1.Text = "Active"
        Me.ToolStripStatusLabel1.ToolTipText = "Connection Status"
        '
        'tsBytesLoading
        '
        Me.tsBytesLoading.ForeColor = System.Drawing.Color.Yellow
        Me.tsBytesLoading.Name = "tsBytesLoading"
        Me.tsBytesLoading.Size = New System.Drawing.Size(56, 17)
        Me.tsBytesLoading.Text = "File Bytes"
        Me.tsBytesLoading.ToolTipText = "The number of bytes loading in the current file."
        '
        'tsServiceDBConnState
        '
        Me.tsServiceDBConnState.ForeColor = System.Drawing.Color.White
        Me.tsServiceDBConnState.Name = "tsServiceDBConnState"
        Me.tsServiceDBConnState.Size = New System.Drawing.Size(74, 17)
        Me.tsServiceDBConnState.Text = "Cloud Status"
        Me.tsServiceDBConnState.ToolTipText = "Shows the current status of the Cloud Connection."
        '
        'tsTunnelConn
        '
        Me.tsTunnelConn.ForeColor = System.Drawing.Color.White
        Me.tsTunnelConn.Name = "tsTunnelConn"
        Me.tsTunnelConn.Size = New System.Drawing.Size(79, 17)
        Me.tsTunnelConn.Text = "Tunnel Status"
        Me.tsTunnelConn.ToolTipText = "If YES, the tunnel connection is valid."
        '
        'tsCurrentRepoID
        '
        Me.tsCurrentRepoID.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tsCurrentRepoID.Name = "tsCurrentRepoID"
        Me.tsCurrentRepoID.Size = New System.Drawing.Size(45, 17)
        Me.tsCurrentRepoID.Text = "RepoID"
        '
        'tsLastArchive
        '
        Me.tsLastArchive.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.tsLastArchive.Name = "tsLastArchive"
        Me.tsLastArchive.Size = New System.Drawing.Size(71, 17)
        Me.tsLastArchive.Text = "Last Archive"
        Me.tsLastArchive.ToolTipText = "Last Archive Date"
        '
        'tsTimeToArchive
        '
        Me.tsTimeToArchive.ForeColor = System.Drawing.Color.White
        Me.tsTimeToArchive.Name = "tsTimeToArchive"
        Me.tsTimeToArchive.Size = New System.Drawing.Size(74, 17)
        Me.tsTimeToArchive.Text = "Next Archive"
        Me.tsTimeToArchive.ToolTipText = "Next Archive Time"
        '
        'tsCountDown
        '
        Me.tsCountDown.ForeColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.tsCountDown.Name = "tsCountDown"
        Me.tsCountDown.Size = New System.Drawing.Size(49, 17)
        Me.tsCountDown.Text = "00:00:00"
        '
        'TimerQuickArchive
        '
        Me.TimerQuickArchive.Enabled = True
        Me.TimerQuickArchive.Interval = 60000
        '
        'TabControl1
        '
        Me.TabControl1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.TabControl1.Controls.Add(Me.TabPage1)
        Me.TabControl1.Controls.Add(Me.TabPage2)
        Me.TabControl1.Controls.Add(Me.TabPage4)
        Me.TabControl1.Controls.Add(Me.TabPage5)
        Me.TabControl1.Controls.Add(Me.TabPage6)
        Me.TabControl1.Controls.Add(Me.TabPage3)
        Me.TabControl1.Location = New System.Drawing.Point(12, 38)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(938, 527)
        Me.TabControl1.TabIndex = 79
        '
        'TabPage1
        '
        Me.TabPage1.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.TabPage1.Controls.Add(Me.gbEmail)
        Me.TabPage1.Location = New System.Drawing.Point(4, 22)
        Me.TabPage1.Name = "TabPage1"
        Me.TabPage1.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage1.Size = New System.Drawing.Size(930, 501)
        Me.TabPage1.TabIndex = 0
        Me.TabPage1.Text = "Email"
        '
        'TabPage2
        '
        Me.TabPage2.Controls.Add(Me.gbContentMgt)
        Me.TabPage2.Location = New System.Drawing.Point(4, 22)
        Me.TabPage2.Name = "TabPage2"
        Me.TabPage2.Padding = New System.Windows.Forms.Padding(3)
        Me.TabPage2.Size = New System.Drawing.Size(930, 501)
        Me.TabPage2.TabIndex = 1
        Me.TabPage2.Text = "Documents"
        Me.TabPage2.UseVisualStyleBackColor = True
        '
        'TabPage4
        '
        Me.TabPage4.BackColor = System.Drawing.Color.PaleTurquoise
        Me.TabPage4.Controls.Add(Me.Button5)
        Me.TabPage4.Controls.Add(Me.Button4)
        Me.TabPage4.Controls.Add(Me.TextBox2)
        Me.TabPage4.Controls.Add(Me.Label22)
        Me.TabPage4.Controls.Add(Me.TextBox1)
        Me.TabPage4.Controls.Add(Me.Label21)
        Me.TabPage4.Controls.Add(Me.dgRss)
        Me.TabPage4.Controls.Add(Me.Label20)
        Me.TabPage4.Controls.Add(Me.Label17)
        Me.TabPage4.Location = New System.Drawing.Point(4, 22)
        Me.TabPage4.Name = "TabPage4"
        Me.TabPage4.Size = New System.Drawing.Size(930, 501)
        Me.TabPage4.TabIndex = 3
        Me.TabPage4.Text = "RSS"
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(807, 451)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(96, 37)
        Me.Button5.TabIndex = 8
        Me.Button5.Text = "Remove"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(807, 408)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(96, 37)
        Me.Button4.TabIndex = 7
        Me.Button4.Text = "Save"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'TextBox2
        '
        Me.TextBox2.Location = New System.Drawing.Point(32, 465)
        Me.TextBox2.Name = "TextBox2"
        Me.TextBox2.Size = New System.Drawing.Size(725, 20)
        Me.TextBox2.TabIndex = 6
        '
        'Label22
        '
        Me.Label22.AutoSize = True
        Me.Label22.Location = New System.Drawing.Point(29, 449)
        Me.Label22.Name = "Label22"
        Me.Label22.Size = New System.Drawing.Size(53, 13)
        Me.Label22.TabIndex = 5
        Me.Label22.Text = "Site URL:"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(32, 424)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(725, 20)
        Me.TextBox1.TabIndex = 4
        '
        'Label21
        '
        Me.Label21.AutoSize = True
        Me.Label21.Location = New System.Drawing.Point(29, 408)
        Me.Label21.Name = "Label21"
        Me.Label21.Size = New System.Drawing.Size(59, 13)
        Me.Label21.TabIndex = 3
        Me.Label21.Text = "Site Name:"
        '
        'dgRss
        '
        Me.dgRss.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgRss.Location = New System.Drawing.Point(32, 102)
        Me.dgRss.Name = "dgRss"
        Me.dgRss.Size = New System.Drawing.Size(871, 278)
        Me.dgRss.TabIndex = 2
        '
        'Label20
        '
        Me.Label20.AutoSize = True
        Me.Label20.Location = New System.Drawing.Point(29, 86)
        Me.Label20.Name = "Label20"
        Me.Label20.Size = New System.Drawing.Size(70, 13)
        Me.Label20.TabIndex = 1
        Me.Label20.Text = "Defined Sites"
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Font = New System.Drawing.Font("Microsoft Sans Serif", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label17.Location = New System.Drawing.Point(204, 31)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(444, 39)
        Me.Label17.TabIndex = 0
        Me.Label17.Text = "Available 1st quarter 2013"
        '
        'TabPage5
        '
        Me.TabPage5.BackColor = System.Drawing.Color.AntiqueWhite
        Me.TabPage5.Controls.Add(Me.Button6)
        Me.TabPage5.Controls.Add(Me.Button7)
        Me.TabPage5.Controls.Add(Me.TextBox3)
        Me.TabPage5.Controls.Add(Me.Label23)
        Me.TabPage5.Controls.Add(Me.TextBox4)
        Me.TabPage5.Controls.Add(Me.Label24)
        Me.TabPage5.Controls.Add(Me.DataGridView1)
        Me.TabPage5.Controls.Add(Me.Label25)
        Me.TabPage5.Controls.Add(Me.Label18)
        Me.TabPage5.Location = New System.Drawing.Point(4, 22)
        Me.TabPage5.Name = "TabPage5"
        Me.TabPage5.Size = New System.Drawing.Size(930, 501)
        Me.TabPage5.TabIndex = 4
        Me.TabPage5.Text = "Web Screen"
        '
        'Button6
        '
        Me.Button6.Location = New System.Drawing.Point(807, 438)
        Me.Button6.Name = "Button6"
        Me.Button6.Size = New System.Drawing.Size(96, 37)
        Me.Button6.TabIndex = 16
        Me.Button6.Text = "Remove"
        Me.Button6.UseVisualStyleBackColor = True
        '
        'Button7
        '
        Me.Button7.Location = New System.Drawing.Point(807, 395)
        Me.Button7.Name = "Button7"
        Me.Button7.Size = New System.Drawing.Size(96, 37)
        Me.Button7.TabIndex = 15
        Me.Button7.Text = "Save"
        Me.Button7.UseVisualStyleBackColor = True
        '
        'TextBox3
        '
        Me.TextBox3.Location = New System.Drawing.Point(32, 452)
        Me.TextBox3.Name = "TextBox3"
        Me.TextBox3.Size = New System.Drawing.Size(725, 20)
        Me.TextBox3.TabIndex = 14
        '
        'Label23
        '
        Me.Label23.AutoSize = True
        Me.Label23.Location = New System.Drawing.Point(29, 436)
        Me.Label23.Name = "Label23"
        Me.Label23.Size = New System.Drawing.Size(53, 13)
        Me.Label23.TabIndex = 13
        Me.Label23.Text = "Site URL:"
        '
        'TextBox4
        '
        Me.TextBox4.Location = New System.Drawing.Point(32, 411)
        Me.TextBox4.Name = "TextBox4"
        Me.TextBox4.Size = New System.Drawing.Size(725, 20)
        Me.TextBox4.TabIndex = 12
        '
        'Label24
        '
        Me.Label24.AutoSize = True
        Me.Label24.Location = New System.Drawing.Point(29, 395)
        Me.Label24.Name = "Label24"
        Me.Label24.Size = New System.Drawing.Size(59, 13)
        Me.Label24.TabIndex = 11
        Me.Label24.Text = "Site Name:"
        '
        'DataGridView1
        '
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Location = New System.Drawing.Point(32, 89)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.Size = New System.Drawing.Size(871, 278)
        Me.DataGridView1.TabIndex = 10
        '
        'Label25
        '
        Me.Label25.AutoSize = True
        Me.Label25.Location = New System.Drawing.Point(29, 73)
        Me.Label25.Name = "Label25"
        Me.Label25.Size = New System.Drawing.Size(70, 13)
        Me.Label25.TabIndex = 9
        Me.Label25.Text = "Defined Sites"
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.Font = New System.Drawing.Font("Microsoft Sans Serif", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label18.Location = New System.Drawing.Point(206, 28)
        Me.Label18.Name = "Label18"
        Me.Label18.Size = New System.Drawing.Size(445, 39)
        Me.Label18.TabIndex = 1
        Me.Label18.Text = "Available 4th quarter 2012"
        '
        'TabPage6
        '
        Me.TabPage6.BackColor = System.Drawing.Color.Gainsboro
        Me.TabPage6.Controls.Add(Me.NumericUpDown4)
        Me.TabPage6.Controls.Add(Me.NumericUpDown2)
        Me.TabPage6.Controls.Add(Me.Label30)
        Me.TabPage6.Controls.Add(Me.Label29)
        Me.TabPage6.Controls.Add(Me.Button8)
        Me.TabPage6.Controls.Add(Me.Button9)
        Me.TabPage6.Controls.Add(Me.TextBox5)
        Me.TabPage6.Controls.Add(Me.Label26)
        Me.TabPage6.Controls.Add(Me.TextBox6)
        Me.TabPage6.Controls.Add(Me.Label27)
        Me.TabPage6.Controls.Add(Me.DataGridView2)
        Me.TabPage6.Controls.Add(Me.Label28)
        Me.TabPage6.Controls.Add(Me.Label19)
        Me.TabPage6.Location = New System.Drawing.Point(4, 22)
        Me.TabPage6.Name = "TabPage6"
        Me.TabPage6.Size = New System.Drawing.Size(930, 501)
        Me.TabPage6.TabIndex = 5
        Me.TabPage6.Text = "Web Site"
        '
        'NumericUpDown4
        '
        Me.NumericUpDown4.Location = New System.Drawing.Point(546, 408)
        Me.NumericUpDown4.Name = "NumericUpDown4"
        Me.NumericUpDown4.Size = New System.Drawing.Size(40, 20)
        Me.NumericUpDown4.TabIndex = 20
        Me.NumericUpDown4.Value = New Decimal(New Integer() {10, 0, 0, 0})
        '
        'NumericUpDown2
        '
        Me.NumericUpDown2.Location = New System.Drawing.Point(487, 408)
        Me.NumericUpDown2.Name = "NumericUpDown2"
        Me.NumericUpDown2.Size = New System.Drawing.Size(40, 20)
        Me.NumericUpDown2.TabIndex = 19
        Me.NumericUpDown2.Value = New Decimal(New Integer() {1, 0, 0, 0})
        '
        'Label30
        '
        Me.Label30.AutoSize = True
        Me.Label30.Location = New System.Drawing.Point(543, 394)
        Me.Label30.Name = "Label30"
        Me.Label30.Size = New System.Drawing.Size(37, 13)
        Me.Label30.TabIndex = 18
        Me.Label30.Text = "Pages"
        '
        'Label29
        '
        Me.Label29.AutoSize = True
        Me.Label29.Location = New System.Drawing.Point(484, 394)
        Me.Label29.Name = "Label29"
        Me.Label29.Size = New System.Drawing.Size(38, 13)
        Me.Label29.TabIndex = 17
        Me.Label29.Text = "Levels"
        '
        'Button8
        '
        Me.Button8.Location = New System.Drawing.Point(807, 437)
        Me.Button8.Name = "Button8"
        Me.Button8.Size = New System.Drawing.Size(96, 37)
        Me.Button8.TabIndex = 16
        Me.Button8.Text = "Remove"
        Me.Button8.UseVisualStyleBackColor = True
        '
        'Button9
        '
        Me.Button9.Location = New System.Drawing.Point(807, 394)
        Me.Button9.Name = "Button9"
        Me.Button9.Size = New System.Drawing.Size(96, 37)
        Me.Button9.TabIndex = 15
        Me.Button9.Text = "Save"
        Me.Button9.UseVisualStyleBackColor = True
        '
        'TextBox5
        '
        Me.TextBox5.Location = New System.Drawing.Point(32, 451)
        Me.TextBox5.Name = "TextBox5"
        Me.TextBox5.Size = New System.Drawing.Size(725, 20)
        Me.TextBox5.TabIndex = 14
        '
        'Label26
        '
        Me.Label26.AutoSize = True
        Me.Label26.Location = New System.Drawing.Point(29, 435)
        Me.Label26.Name = "Label26"
        Me.Label26.Size = New System.Drawing.Size(53, 13)
        Me.Label26.TabIndex = 13
        Me.Label26.Text = "Site URL:"
        '
        'TextBox6
        '
        Me.TextBox6.Location = New System.Drawing.Point(32, 410)
        Me.TextBox6.Name = "TextBox6"
        Me.TextBox6.Size = New System.Drawing.Size(419, 20)
        Me.TextBox6.TabIndex = 12
        '
        'Label27
        '
        Me.Label27.AutoSize = True
        Me.Label27.Location = New System.Drawing.Point(29, 394)
        Me.Label27.Name = "Label27"
        Me.Label27.Size = New System.Drawing.Size(59, 13)
        Me.Label27.TabIndex = 11
        Me.Label27.Text = "Site Name:"
        '
        'DataGridView2
        '
        Me.DataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView2.Location = New System.Drawing.Point(32, 88)
        Me.DataGridView2.Name = "DataGridView2"
        Me.DataGridView2.Size = New System.Drawing.Size(871, 278)
        Me.DataGridView2.TabIndex = 10
        '
        'Label28
        '
        Me.Label28.AutoSize = True
        Me.Label28.Location = New System.Drawing.Point(29, 72)
        Me.Label28.Name = "Label28"
        Me.Label28.Size = New System.Drawing.Size(70, 13)
        Me.Label28.TabIndex = 9
        Me.Label28.Text = "Defined Sites"
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.Font = New System.Drawing.Font("Microsoft Sans Serif", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label19.Location = New System.Drawing.Point(203, 26)
        Me.Label19.Name = "Label19"
        Me.Label19.Size = New System.Drawing.Size(454, 39)
        Me.Label19.TabIndex = 1
        Me.Label19.Text = "Available 2nd quarter 2013"
        '
        'TabPage3
        '
        Me.TabPage3.BackColor = System.Drawing.SystemColors.ControlDark
        Me.TabPage3.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.TabPage3.Controls.Add(Me.GroupBox1)
        Me.TabPage3.Controls.Add(Me.btnDefaultAsso)
        Me.TabPage3.Controls.Add(Me.btnRefreshDefaults)
        Me.TabPage3.Controls.Add(Me.gbFiletypes)
        Me.TabPage3.Controls.Add(Me.gbPolling)
        Me.TabPage3.Location = New System.Drawing.Point(4, 22)
        Me.TabPage3.Name = "TabPage3"
        Me.TabPage3.Size = New System.Drawing.Size(930, 501)
        Me.TabPage3.TabIndex = 2
        Me.TabPage3.Text = "Execution Control"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.btnFetch)
        Me.GroupBox1.Controls.Add(Me.txtCompany)
        Me.GroupBox1.Controls.Add(Me.btnActivate)
        Me.GroupBox1.Controls.Add(Me.cbRepo)
        Me.GroupBox1.Controls.Add(Me.Label15)
        Me.GroupBox1.Controls.Add(Me.Label14)
        Me.GroupBox1.Location = New System.Drawing.Point(598, 29)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(296, 163)
        Me.GroupBox1.TabIndex = 32
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Active Repository"
        '
        'txtCompany
        '
        Me.txtCompany.Location = New System.Drawing.Point(17, 39)
        Me.txtCompany.Name = "txtCompany"
        Me.txtCompany.Size = New System.Drawing.Size(192, 20)
        Me.txtCompany.TabIndex = 5
        '
        'btnActivate
        '
        Me.btnActivate.Location = New System.Drawing.Point(103, 119)
        Me.btnActivate.Name = "btnActivate"
        Me.btnActivate.Size = New System.Drawing.Size(95, 31)
        Me.btnActivate.TabIndex = 4
        Me.btnActivate.Text = "Activate"
        Me.btnActivate.UseVisualStyleBackColor = True
        '
        'cbRepo
        '
        Me.cbRepo.FormattingEnabled = True
        Me.cbRepo.Location = New System.Drawing.Point(18, 87)
        Me.cbRepo.Name = "cbRepo"
        Me.cbRepo.Size = New System.Drawing.Size(267, 21)
        Me.cbRepo.TabIndex = 3
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(14, 71)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(74, 13)
        Me.Label15.TabIndex = 1
        Me.Label15.Text = "Repository ID:"
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(14, 24)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(68, 13)
        Me.Label14.TabIndex = 0
        Me.Label14.Text = "Company ID:"
        '
        'btnDefaultAsso
        '
        Me.btnDefaultAsso.Location = New System.Drawing.Point(390, 380)
        Me.btnDefaultAsso.Name = "btnDefaultAsso"
        Me.btnDefaultAsso.Size = New System.Drawing.Size(152, 25)
        Me.btnDefaultAsso.TabIndex = 31
        Me.btnDefaultAsso.Text = "Reset Default Associations"
        Me.btnDefaultAsso.UseVisualStyleBackColor = True
        '
        'btnRefreshDefaults
        '
        Me.btnRefreshDefaults.Location = New System.Drawing.Point(392, 340)
        Me.btnRefreshDefaults.Name = "btnRefreshDefaults"
        Me.btnRefreshDefaults.Size = New System.Drawing.Size(150, 24)
        Me.btnRefreshDefaults.TabIndex = 30
        Me.btnRefreshDefaults.Text = "Reset Defaults"
        Me.btnRefreshDefaults.UseVisualStyleBackColor = True
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'BackgroundWorker1
        '
        '
        'BackgroundWorker2
        '
        '
        'BackgroundWorker3
        '
        '
        'BackgroundDirListener
        '
        '
        'BackgroundWorkerContacts
        '
        '
        'asyncBatchOcrALL
        '
        '
        'asyncBatchOcrPending
        '
        '
        'asyncVerifyRetainDates
        '
        '
        'frmReconMain
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoScroll = True
        Me.AutoSize = True
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.BackColor = System.Drawing.Color.Navy
        Me.ClientSize = New System.Drawing.Size(962, 661)
        Me.Controls.Add(Me.lblVer)
        Me.Controls.Add(Me.TabControl1)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.btnAddDir)
        Me.Controls.Add(Me.cbFileDB)
        Me.Controls.Add(Me.StatusStrip1)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Controls.Add(Me.ckPauseListener)
        Me.Controls.Add(Me.PBx)
        Me.Controls.Add(Me.SB2)
        Me.Controls.Add(Me.ckTerminate)
        Me.Controls.Add(Me.PictureBox1)
        Me.Controls.Add(Me.SB)
        Me.HelpButton = True
        Me.f1Help.SetHelpString(Me, "http://www.ecmlibrary.com/helpfiles/frmReconMain.htm")
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "frmReconMain"
        Me.f1Help.SetShowHelp(Me, True)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "ECM Library Archive System - Cloud"
        Me.gbEmail.ResumeLayout(False)
        Me.gbEmail.PerformLayout()
        CType(Me.NumericUpDown3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.gbFiletypes.ResumeLayout(False)
        Me.gbFiletypes.PerformLayout()
        Me.gbPolling.ResumeLayout(False)
        Me.gbPolling.PerformLayout()
        CType(Me.NumericUpDown1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.gbContentMgt.ResumeLayout(False)
        Me.Panel2.ResumeLayout(False)
        Me.Panel2.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.Panel3.ResumeLayout(False)
        Me.Panel3.PerformLayout()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ContextMenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.StatusStrip1.ResumeLayout(False)
        Me.StatusStrip1.PerformLayout()
        Me.TabControl1.ResumeLayout(False)
        Me.TabPage1.ResumeLayout(False)
        Me.TabPage2.ResumeLayout(False)
        Me.TabPage4.ResumeLayout(False)
        Me.TabPage4.PerformLayout()
        CType(Me.dgRss, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TabPage5.ResumeLayout(False)
        Me.TabPage5.PerformLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TabPage6.ResumeLayout(False)
        Me.TabPage6.PerformLayout()
        CType(Me.NumericUpDown4, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.NumericUpDown2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TabPage3.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents gbEmail As System.Windows.Forms.GroupBox
    Friend WithEvents btnActive As System.Windows.Forms.Button
    Friend WithEvents cbEmailDB As System.Windows.Forms.ComboBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents NumericUpDown3 As System.Windows.Forms.NumericUpDown
    Friend WithEvents ckRemoveAfterXDays As System.Windows.Forms.CheckBox
    Friend WithEvents btnRefreshFolders As System.Windows.Forms.Button
    Friend WithEvents btnSaveConditions As System.Windows.Forms.Button
    Friend WithEvents ckArchiveFolder As System.Windows.Forms.CheckBox
    Friend WithEvents lbActiveFolder As System.Windows.Forms.ListBox
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents gbFiletypes As System.Windows.Forms.GroupBox
    Friend WithEvents ckRemoveFileType As System.Windows.Forms.Button
    Friend WithEvents cbFileTypes As System.Windows.Forms.ComboBox
    Friend WithEvents btnAddFiletype As System.Windows.Forms.Button
    Friend WithEvents gbPolling As System.Windows.Forms.GroupBox
    Friend WithEvents ckDisable As System.Windows.Forms.CheckBox
    Friend WithEvents gbContentMgt As System.Windows.Forms.GroupBox
    Friend WithEvents btnInclFileType As System.Windows.Forms.Button
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents lbAvailExts As System.Windows.Forms.ListBox
    Friend WithEvents lbIncludeExts As System.Windows.Forms.ListBox
    Friend WithEvents cbFileDB As System.Windows.Forms.ComboBox
    Friend WithEvents btnRefresh As System.Windows.Forms.Button
    Friend WithEvents btnSaveChanges As System.Windows.Forms.Button
    Friend WithEvents btnRemoveDir As System.Windows.Forms.Button
    Friend WithEvents btnAddDir As System.Windows.Forms.Button
    Friend WithEvents btnSelDir As System.Windows.Forms.Button
    Friend WithEvents lbArchiveDirs As System.Windows.Forms.ListBox
    Friend WithEvents txtDir As System.Windows.Forms.TextBox
    Friend WithEvents FolderBrowserDialog1 As System.Windows.Forms.FolderBrowserDialog
    Friend WithEvents ckSubDirs As System.Windows.Forms.CheckBox
    Friend WithEvents btnDeleteEmailEntry As System.Windows.Forms.Button
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents cbAsType As System.Windows.Forms.ComboBox
    Friend WithEvents cbPocessType As System.Windows.Forms.ComboBox
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents cbProcessAsList As System.Windows.Forms.ComboBox
    Friend WithEvents ckVersionFiles As System.Windows.Forms.CheckBox
    Friend WithEvents ckArchiveRead As System.Windows.Forms.CheckBox
    Friend WithEvents ckMetaData As System.Windows.Forms.CheckBox
    Friend WithEvents ckPublic As System.Windows.Forms.CheckBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents btnSaveSchedule As System.Windows.Forms.Button
    Friend WithEvents ckDisableDir As System.Windows.Forms.CheckBox
    Friend WithEvents btnExclude As System.Windows.Forms.Button
    Friend WithEvents btnRemoveExclude As System.Windows.Forms.Button
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents lbExcludeExts As System.Windows.Forms.ListBox
    Friend WithEvents ckUseLastProcessDateAsCutoff As System.Windows.Forms.CheckBox
    Friend WithEvents ckSystemFolder As System.Windows.Forms.CheckBox
    Friend WithEvents clAdminDir As System.Windows.Forms.CheckBox
    Friend WithEvents ckOcr As System.Windows.Forms.CheckBox
    Friend WithEvents f1Help As System.Windows.Forms.HelpProvider
    Friend WithEvents SB2 As System.Windows.Forms.TextBox
    Friend WithEvents cbRetention As System.Windows.Forms.ComboBox
    Friend WithEvents cbEmailRetention As System.Windows.Forms.ComboBox
    Friend WithEvents ckDisableOutlookEmailArchive As System.Windows.Forms.CheckBox
    Friend WithEvents ckDisableContentArchive As System.Windows.Forms.CheckBox
    Friend WithEvents ckDisableExchange As System.Windows.Forms.CheckBox
    Friend WithEvents btnSMTP As System.Windows.Forms.Button
    Friend WithEvents PBx As System.Windows.Forms.ProgressBar
    Friend WithEvents cbProfile As System.Windows.Forms.ComboBox
    Friend WithEvents btnExclProfile As System.Windows.Forms.Button
    Friend WithEvents btnInclProfile As System.Windows.Forms.Button
    Friend WithEvents cbParentFolders As System.Windows.Forms.ComboBox
    Friend WithEvents ContextMenuStrip1 As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents ResetSelectedMailBoxesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EmailLibraryReassignmentToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label13 As System.Windows.Forms.Label
    Friend WithEvents Label11 As System.Windows.Forms.Label
    Friend WithEvents ckTerminate As System.Windows.Forms.CheckBox
    Friend WithEvents btnDeleteDirProfile As System.Windows.Forms.Button
    Friend WithEvents btnUpdateDirectoryProfile As System.Windows.Forms.Button
    Friend WithEvents btnSaveDirProfile As System.Windows.Forms.Button
    Friend WithEvents btnApplyDirProfile As System.Windows.Forms.Button
    Friend WithEvents cbDirProfile As System.Windows.Forms.ComboBox
    Friend WithEvents Label12 As System.Windows.Forms.Label
    Friend WithEvents ckArchiveBit As System.Windows.Forms.CheckBox
    Friend WithEvents CkMonitor As System.Windows.Forms.CheckBox
    Friend WithEvents ckRunUnattended As System.Windows.Forms.CheckBox
    Friend WithEvents ckDoNotShowArchived As System.Windows.Forms.CheckBox
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents ckGetSubFolders As System.Windows.Forms.CheckBox
    Friend WithEvents TimerListeners As System.Windows.Forms.Timer
    Friend WithEvents ckPauseListener As System.Windows.Forms.CheckBox
    Friend WithEvents TimerUploadFiles As System.Windows.Forms.Timer
    Friend WithEvents TimerEndRun As System.Windows.Forms.Timer
    Friend WithEvents btnRefreshRetent As System.Windows.Forms.Button
    Friend WithEvents ckShowLibs As System.Windows.Forms.CheckBox
    Friend WithEvents ckOcrPdf As System.Windows.Forms.CheckBox
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents ArchiveToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents OutlookEmailsToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents StatusStrip1 As System.Windows.Forms.StatusStrip
    Friend WithEvents ExchangeEmailsToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ContentToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ArchiveALLToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TasksToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents LoginAsDifferenctUserToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents infoDaysToExpire As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents tssUser As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents tssServer As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents tssVersion As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents HelpToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents RunningArchiverToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ParameterExecutionToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents tssAuth As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents HistoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ckExpand As System.Windows.Forms.CheckBox
    Friend WithEvents ViewLogsToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TestToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents DirectoryInventoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ListFilesInDirectoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents GetAllSubdirFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ViewOCRErrorFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ScheduleToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents tbExchange As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents OCRToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents AboutToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents PB1 As System.Windows.Forms.ToolStripProgressBar
    Friend WithEvents tsStatus02 As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents ManualEditAppConfigToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SB5 As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents Panel2 As System.Windows.Forms.Panel
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents Panel3 As System.Windows.Forms.Panel
    Friend WithEvents ToolStripStatusLabel1 As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents SetArchiveIntervalToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents NumericUpDown1 As System.Windows.Forms.NumericUpDown
    Friend WithEvents TimerQuickArchive As System.Windows.Forms.Timer
    Friend WithEvents btnArchiveNow As System.Windows.Forms.Button
    Friend WithEvents tsLastArchive As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents ImpersonateLoginToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents AddDesktopIconToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents btnRefreshRebuild As System.Windows.Forms.Button
    Friend WithEvents tsBytesLoading As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents SelectionToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents AllToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EmailToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ContentToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ExecutionControlToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FileTypesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents TabControl1 As System.Windows.Forms.TabControl
    Friend WithEvents TabPage1 As System.Windows.Forms.TabPage
    Friend WithEvents TabPage2 As System.Windows.Forms.TabPage
    Friend WithEvents TabPage3 As System.Windows.Forms.TabPage
    Friend WithEvents tsServiceDBConnState As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents tsTunnelConn As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents UtilityToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EncryptStringToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents btnRefreshDefaults As System.Windows.Forms.Button
    Friend WithEvents btnDefaultAsso As System.Windows.Forms.Button
    Friend WithEvents btnAddDefaults As System.Windows.Forms.Button
    Friend WithEvents FileHashToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents BackgroundWorker1 As System.ComponentModel.BackgroundWorker
    Friend WithEvents BackgroundWorker2 As System.ComponentModel.BackgroundWorker
    Friend WithEvents BackgroundWorker3 As System.ComponentModel.BackgroundWorker
    Friend WithEvents FileUploadToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FileUploadBufferedToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FileChunkUploadToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents BackgroundDirListener As System.ComponentModel.BackgroundWorker
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents btnActivate As System.Windows.Forms.Button
    Friend WithEvents cbRepo As System.Windows.Forms.ComboBox
    Friend WithEvents Label15 As System.Windows.Forms.Label
    Friend WithEvents Label14 As System.Windows.Forms.Label
    Friend WithEvents tsCurrentRepoID As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents txtCompany As System.Windows.Forms.TextBox
    Friend WithEvents btnFetch As System.Windows.Forms.Button
    Friend WithEvents ExitToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ExitToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents lblVer As System.Windows.Forms.Label
    Friend WithEvents InstallCLCToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents tsTimeToArchive As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents tsCountDown As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents ckDeleteAfterArchive As System.Windows.Forms.CheckBox
    Friend WithEvents btnCountFiles As System.Windows.Forms.Button
    Friend WithEvents AppConfigVersionToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents BackgroundWorkerContacts As System.ComponentModel.BackgroundWorker
    Friend WithEvents ToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents asyncBatchOcrALL As System.ComponentModel.BackgroundWorker
    Friend WithEvents asyncBatchOcrPending As System.ComponentModel.BackgroundWorker
    Friend WithEvents ReOCRToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ReOcrIncompleteGraphicFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ReOcrALLGraphicFilesToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EstimateNumberOfFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ResetPerformanceFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents CEDatabasesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ZIPFilesArchivesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents AllToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ViewCEDirectoriesToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator2 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents ToolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents InstallCESP2ToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripMenuItem2 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator3 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents Label16 As System.Windows.Forms.Label
    Friend WithEvents RSSPullToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TabPage4 As System.Windows.Forms.TabPage
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents TextBox2 As System.Windows.Forms.TextBox
    Friend WithEvents Label22 As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents Label21 As System.Windows.Forms.Label
    Friend WithEvents dgRss As System.Windows.Forms.DataGridView
    Friend WithEvents Label20 As System.Windows.Forms.Label
    Friend WithEvents Label17 As System.Windows.Forms.Label
    Friend WithEvents TabPage5 As System.Windows.Forms.TabPage
    Friend WithEvents Button6 As System.Windows.Forms.Button
    Friend WithEvents Button7 As System.Windows.Forms.Button
    Friend WithEvents TextBox3 As System.Windows.Forms.TextBox
    Friend WithEvents Label23 As System.Windows.Forms.Label
    Friend WithEvents TextBox4 As System.Windows.Forms.TextBox
    Friend WithEvents Label24 As System.Windows.Forms.Label
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents Label25 As System.Windows.Forms.Label
    Friend WithEvents Label18 As System.Windows.Forms.Label
    Friend WithEvents TabPage6 As System.Windows.Forms.TabPage
    Friend WithEvents Button8 As System.Windows.Forms.Button
    Friend WithEvents Button9 As System.Windows.Forms.Button
    Friend WithEvents TextBox5 As System.Windows.Forms.TextBox
    Friend WithEvents Label26 As System.Windows.Forms.Label
    Friend WithEvents TextBox6 As System.Windows.Forms.TextBox
    Friend WithEvents Label27 As System.Windows.Forms.Label
    Friend WithEvents DataGridView2 As System.Windows.Forms.DataGridView
    Friend WithEvents Label28 As System.Windows.Forms.Label
    Friend WithEvents Label19 As System.Windows.Forms.Label
    Friend WithEvents hlExchange As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel1 As System.Windows.Forms.LinkLabel
    Friend WithEvents LinkLabel2 As System.Windows.Forms.LinkLabel
    Friend WithEvents NumericUpDown4 As System.Windows.Forms.NumericUpDown
    Friend WithEvents NumericUpDown2 As System.Windows.Forms.NumericUpDown
    Friend WithEvents Label30 As System.Windows.Forms.Label
    Friend WithEvents Label29 As System.Windows.Forms.Label
    Friend WithEvents asyncVerifyRetainDates As System.ComponentModel.BackgroundWorker
    Friend WithEvents OnlineHelpToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator4 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents CheckBox1 As System.Windows.Forms.CheckBox
    Friend WithEvents ckRunOnStart As System.Windows.Forms.CheckBox

End Class
