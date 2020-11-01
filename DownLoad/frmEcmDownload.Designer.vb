<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmEcmDownload
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmEcmDownload))
        Me.TPreview = New System.Windows.Forms.Timer(Me.components)
        Me.lblPreviewState = New System.Windows.Forms.Label()
        Me.lblDownloads = New System.Windows.Forms.Label()
        Me.TDownload = New System.Windows.Forms.Timer(Me.components)
        Me.ckDisable = New System.Windows.Forms.CheckBox()
        Me.lblScan = New System.Windows.Forms.Label()
        Me.lblNbrPolls = New System.Windows.Forms.Label()
        Me.lblNbrDownloadsProcessed = New System.Windows.Forms.Label()
        Me.lblMaxFileSize = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.lblDownLoadDir = New System.Windows.Forms.Label()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.FoldersToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ContentRestoreFolderToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EmailRestoreFolderToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.PreviewFolderToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ApplicationFolderToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ViewTodaysLogToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.LogsFolderToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.LogFileToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator2 = New System.Windows.Forms.ToolStripSeparator()
        Me.PurgeRestoreQueueToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.CleanOutOldRestoredFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.PreviewedFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TempRestoredFilesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.TempRestoredEmailsToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SilverlightFoldersToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.PreviewToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.EmailToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.InitCLCFoldersToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ViewCLCRegistrationStatusToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.FindCLCToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.RegisterCLCAsActiveToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ToolStripSeparator1 = New System.Windows.Forms.ToolStripSeparator()
        Me.SetDownLoadDirectoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.PassthruDirectoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ShowServiceVersionNumbersToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.PreviewToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.DownloadToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.PB = New System.Windows.Forms.ProgressBar()
        Me.ckRunMinimized = New System.Windows.Forms.CheckBox()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.txtLoginID = New System.Windows.Forms.TextBox()
        Me.lblUser = New System.Windows.Forms.Label()
        Me.ckRemember = New System.Windows.Forms.CheckBox()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.FolderBrowserDialog1 = New System.Windows.Forms.FolderBrowserDialog()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.MenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'TPreview
        '
        Me.TPreview.Enabled = True
        Me.TPreview.Interval = 15000
        '
        'lblPreviewState
        '
        Me.lblPreviewState.AutoSize = True
        Me.lblPreviewState.BackColor = System.Drawing.Color.Transparent
        Me.lblPreviewState.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPreviewState.ForeColor = System.Drawing.Color.White
        Me.lblPreviewState.Location = New System.Drawing.Point(16, 42)
        Me.lblPreviewState.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblPreviewState.Name = "lblPreviewState"
        Me.lblPreviewState.Size = New System.Drawing.Size(144, 17)
        Me.lblPreviewState.TabIndex = 0
        Me.lblPreviewState.Text = "No active previews"
        '
        'lblDownloads
        '
        Me.lblDownloads.AutoSize = True
        Me.lblDownloads.BackColor = System.Drawing.Color.Transparent
        Me.lblDownloads.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDownloads.ForeColor = System.Drawing.Color.White
        Me.lblDownloads.Location = New System.Drawing.Point(16, 70)
        Me.lblDownloads.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblDownloads.Name = "lblDownloads"
        Me.lblDownloads.Size = New System.Drawing.Size(190, 17)
        Me.lblDownloads.TabIndex = 1
        Me.lblDownloads.Text = "No Completed downloads"
        '
        'TDownload
        '
        Me.TDownload.Enabled = True
        Me.TDownload.Interval = 60000
        '
        'ckDisable
        '
        Me.ckDisable.AutoSize = True
        Me.ckDisable.BackColor = System.Drawing.Color.Transparent
        Me.ckDisable.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckDisable.ForeColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.ckDisable.Location = New System.Drawing.Point(444, 42)
        Me.ckDisable.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.ckDisable.Name = "ckDisable"
        Me.ckDisable.Size = New System.Drawing.Size(86, 22)
        Me.ckDisable.TabIndex = 3
        Me.ckDisable.Text = "Disable"
        Me.TT.SetToolTip(Me.ckDisable, "Check to disable download and preview.")
        Me.ckDisable.UseVisualStyleBackColor = False
        '
        'lblScan
        '
        Me.lblScan.AutoSize = True
        Me.lblScan.BackColor = System.Drawing.Color.Transparent
        Me.lblScan.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblScan.ForeColor = System.Drawing.Color.Yellow
        Me.lblScan.Location = New System.Drawing.Point(572, 46)
        Me.lblScan.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblScan.Name = "lblScan"
        Me.lblScan.Size = New System.Drawing.Size(105, 17)
        Me.lblScan.TabIndex = 6
        Me.lblScan.Text = "Polling active"
        '
        'lblNbrPolls
        '
        Me.lblNbrPolls.AutoSize = True
        Me.lblNbrPolls.BackColor = System.Drawing.Color.Transparent
        Me.lblNbrPolls.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblNbrPolls.ForeColor = System.Drawing.Color.White
        Me.lblNbrPolls.Location = New System.Drawing.Point(16, 100)
        Me.lblNbrPolls.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblNbrPolls.Name = "lblNbrPolls"
        Me.lblNbrPolls.Size = New System.Drawing.Size(48, 17)
        Me.lblNbrPolls.TabIndex = 7
        Me.lblNbrPolls.Text = "Polls:"
        '
        'lblNbrDownloadsProcessed
        '
        Me.lblNbrDownloadsProcessed.AutoSize = True
        Me.lblNbrDownloadsProcessed.BackColor = System.Drawing.Color.Transparent
        Me.lblNbrDownloadsProcessed.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblNbrDownloadsProcessed.ForeColor = System.Drawing.Color.White
        Me.lblNbrDownloadsProcessed.Location = New System.Drawing.Point(219, 70)
        Me.lblNbrDownloadsProcessed.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblNbrDownloadsProcessed.Name = "lblNbrDownloadsProcessed"
        Me.lblNbrDownloadsProcessed.Size = New System.Drawing.Size(17, 17)
        Me.lblNbrDownloadsProcessed.TabIndex = 8
        Me.lblNbrDownloadsProcessed.Text = "0"
        '
        'lblMaxFileSize
        '
        Me.lblMaxFileSize.AutoSize = True
        Me.lblMaxFileSize.BackColor = System.Drawing.Color.Transparent
        Me.lblMaxFileSize.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblMaxFileSize.ForeColor = System.Drawing.Color.Yellow
        Me.lblMaxFileSize.Location = New System.Drawing.Point(16, 218)
        Me.lblMaxFileSize.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblMaxFileSize.Name = "lblMaxFileSize"
        Me.lblMaxFileSize.Size = New System.Drawing.Size(241, 17)
        Me.lblMaxFileSize.TabIndex = 9
        Me.lblMaxFileSize.Text = "Note: For files larger than 20MB"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.Color.Yellow
        Me.Label1.Location = New System.Drawing.Point(39, 234)
        Me.Label1.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(221, 17)
        Me.Label1.TabIndex = 10
        Me.Label1.Text = "use ECM Extended download."
        '
        'lblDownLoadDir
        '
        Me.lblDownLoadDir.AutoSize = True
        Me.lblDownLoadDir.BackColor = System.Drawing.Color.Transparent
        Me.lblDownLoadDir.ForeColor = System.Drawing.Color.Yellow
        Me.lblDownLoadDir.Location = New System.Drawing.Point(16, 138)
        Me.lblDownLoadDir.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblDownLoadDir.Name = "lblDownLoadDir"
        Me.lblDownLoadDir.Size = New System.Drawing.Size(190, 17)
        Me.lblDownLoadDir.TabIndex = 19
        Me.lblDownLoadDir.Text = "Selected Download Directory"
        Me.TT.SetToolTip(Me.lblDownLoadDir, "Selected Download Directory")
        '
        'MenuStrip1
        '
        Me.MenuStrip1.BackColor = System.Drawing.Color.Transparent
        Me.MenuStrip1.Font = New System.Drawing.Font("Segoe UI", 9.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle))
        Me.MenuStrip1.ImageScalingSize = New System.Drawing.Size(20, 20)
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.FoldersToolStripMenuItem, Me.PreviewToolStripMenuItem1, Me.DownloadToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Padding = New System.Windows.Forms.Padding(8, 2, 0, 2)
        Me.MenuStrip1.Size = New System.Drawing.Size(839, 28)
        Me.MenuStrip1.TabIndex = 11
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'FoldersToolStripMenuItem
        '
        Me.FoldersToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ContentRestoreFolderToolStripMenuItem, Me.EmailRestoreFolderToolStripMenuItem, Me.PreviewFolderToolStripMenuItem, Me.ApplicationFolderToolStripMenuItem, Me.ViewTodaysLogToolStripMenuItem, Me.LogsFolderToolStripMenuItem, Me.LogFileToolStripMenuItem, Me.ToolStripSeparator2, Me.PurgeRestoreQueueToolStripMenuItem1, Me.CleanOutOldRestoredFilesToolStripMenuItem, Me.SilverlightFoldersToolStripMenuItem, Me.ViewCLCRegistrationStatusToolStripMenuItem, Me.FindCLCToolStripMenuItem, Me.RegisterCLCAsActiveToolStripMenuItem, Me.ToolStripSeparator1, Me.SetDownLoadDirectoryToolStripMenuItem, Me.PassthruDirectoryToolStripMenuItem, Me.ShowServiceVersionNumbersToolStripMenuItem})
        Me.FoldersToolStripMenuItem.Font = New System.Drawing.Font("Segoe UI Semibold", 9.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FoldersToolStripMenuItem.ForeColor = System.Drawing.Color.Cyan
        Me.FoldersToolStripMenuItem.Name = "FoldersToolStripMenuItem"
        Me.FoldersToolStripMenuItem.Size = New System.Drawing.Size(71, 24)
        Me.FoldersToolStripMenuItem.Text = "Folders"
        '
        'ContentRestoreFolderToolStripMenuItem
        '
        Me.ContentRestoreFolderToolStripMenuItem.Name = "ContentRestoreFolderToolStripMenuItem"
        Me.ContentRestoreFolderToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.ContentRestoreFolderToolStripMenuItem.Text = "Content Restore Folder"
        Me.ContentRestoreFolderToolStripMenuItem.ToolTipText = "Open the folder containing restored CONTENT items."
        '
        'EmailRestoreFolderToolStripMenuItem
        '
        Me.EmailRestoreFolderToolStripMenuItem.Name = "EmailRestoreFolderToolStripMenuItem"
        Me.EmailRestoreFolderToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.EmailRestoreFolderToolStripMenuItem.Text = "Email Restore Folder"
        Me.EmailRestoreFolderToolStripMenuItem.ToolTipText = "Open the folder containing restored EMAILS"
        '
        'PreviewFolderToolStripMenuItem
        '
        Me.PreviewFolderToolStripMenuItem.Name = "PreviewFolderToolStripMenuItem"
        Me.PreviewFolderToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.PreviewFolderToolStripMenuItem.Text = "Preview Folder"
        Me.PreviewFolderToolStripMenuItem.ToolTipText = "Open the folder containing items downloaded for preview."
        '
        'ApplicationFolderToolStripMenuItem
        '
        Me.ApplicationFolderToolStripMenuItem.Name = "ApplicationFolderToolStripMenuItem"
        Me.ApplicationFolderToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.ApplicationFolderToolStripMenuItem.Text = "Application Folder"
        Me.ApplicationFolderToolStripMenuItem.ToolTipText = "Open the folder containing items needed for the appication setup."
        '
        'ViewTodaysLogToolStripMenuItem
        '
        Me.ViewTodaysLogToolStripMenuItem.Name = "ViewTodaysLogToolStripMenuItem"
        Me.ViewTodaysLogToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.ViewTodaysLogToolStripMenuItem.Text = "View Today's Log"
        Me.ViewTodaysLogToolStripMenuItem.ToolTipText = "Open today's execution log."
        '
        'LogsFolderToolStripMenuItem
        '
        Me.LogsFolderToolStripMenuItem.Name = "LogsFolderToolStripMenuItem"
        Me.LogsFolderToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.LogsFolderToolStripMenuItem.Text = "Logs Folder"
        Me.LogsFolderToolStripMenuItem.ToolTipText = "Open the folder containing all LOGS."
        '
        'LogFileToolStripMenuItem
        '
        Me.LogFileToolStripMenuItem.Name = "LogFileToolStripMenuItem"
        Me.LogFileToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.LogFileToolStripMenuItem.Text = "Log File Path"
        '
        'ToolStripSeparator2
        '
        Me.ToolStripSeparator2.Name = "ToolStripSeparator2"
        Me.ToolStripSeparator2.Size = New System.Drawing.Size(294, 6)
        '
        'PurgeRestoreQueueToolStripMenuItem1
        '
        Me.PurgeRestoreQueueToolStripMenuItem1.Name = "PurgeRestoreQueueToolStripMenuItem1"
        Me.PurgeRestoreQueueToolStripMenuItem1.Size = New System.Drawing.Size(297, 26)
        Me.PurgeRestoreQueueToolStripMenuItem1.Text = "Purge Restore Queue"
        '
        'CleanOutOldRestoredFilesToolStripMenuItem
        '
        Me.CleanOutOldRestoredFilesToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.PreviewedFilesToolStripMenuItem, Me.TempRestoredFilesToolStripMenuItem, Me.TempRestoredEmailsToolStripMenuItem})
        Me.CleanOutOldRestoredFilesToolStripMenuItem.Name = "CleanOutOldRestoredFilesToolStripMenuItem"
        Me.CleanOutOldRestoredFilesToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.CleanOutOldRestoredFilesToolStripMenuItem.Text = "Clean Out Old Restored Files"
        '
        'PreviewedFilesToolStripMenuItem
        '
        Me.PreviewedFilesToolStripMenuItem.Name = "PreviewedFilesToolStripMenuItem"
        Me.PreviewedFilesToolStripMenuItem.Size = New System.Drawing.Size(232, 26)
        Me.PreviewedFilesToolStripMenuItem.Text = "Temp Previewed Files"
        '
        'TempRestoredFilesToolStripMenuItem
        '
        Me.TempRestoredFilesToolStripMenuItem.Name = "TempRestoredFilesToolStripMenuItem"
        Me.TempRestoredFilesToolStripMenuItem.Size = New System.Drawing.Size(232, 26)
        Me.TempRestoredFilesToolStripMenuItem.Text = "Temp Restored Files"
        '
        'TempRestoredEmailsToolStripMenuItem
        '
        Me.TempRestoredEmailsToolStripMenuItem.Name = "TempRestoredEmailsToolStripMenuItem"
        Me.TempRestoredEmailsToolStripMenuItem.Size = New System.Drawing.Size(232, 26)
        Me.TempRestoredEmailsToolStripMenuItem.Text = "Temp Restored Emails"
        '
        'SilverlightFoldersToolStripMenuItem
        '
        Me.SilverlightFoldersToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.PreviewToolStripMenuItem, Me.EmailToolStripMenuItem, Me.InitCLCFoldersToolStripMenuItem})
        Me.SilverlightFoldersToolStripMenuItem.Name = "SilverlightFoldersToolStripMenuItem"
        Me.SilverlightFoldersToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.SilverlightFoldersToolStripMenuItem.Text = "Silverlight Temp Folders"
        '
        'PreviewToolStripMenuItem
        '
        Me.PreviewToolStripMenuItem.Name = "PreviewToolStripMenuItem"
        Me.PreviewToolStripMenuItem.Size = New System.Drawing.Size(189, 26)
        Me.PreviewToolStripMenuItem.Text = "Preview"
        '
        'EmailToolStripMenuItem
        '
        Me.EmailToolStripMenuItem.Name = "EmailToolStripMenuItem"
        Me.EmailToolStripMenuItem.Size = New System.Drawing.Size(189, 26)
        Me.EmailToolStripMenuItem.Text = "Downloads"
        '
        'InitCLCFoldersToolStripMenuItem
        '
        Me.InitCLCFoldersToolStripMenuItem.Name = "InitCLCFoldersToolStripMenuItem"
        Me.InitCLCFoldersToolStripMenuItem.Size = New System.Drawing.Size(189, 26)
        Me.InitCLCFoldersToolStripMenuItem.Text = "Init CLC Folders"
        '
        'ViewCLCRegistrationStatusToolStripMenuItem
        '
        Me.ViewCLCRegistrationStatusToolStripMenuItem.Name = "ViewCLCRegistrationStatusToolStripMenuItem"
        Me.ViewCLCRegistrationStatusToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.ViewCLCRegistrationStatusToolStripMenuItem.Text = "View CLC Registration Status"
        '
        'FindCLCToolStripMenuItem
        '
        Me.FindCLCToolStripMenuItem.Name = "FindCLCToolStripMenuItem"
        Me.FindCLCToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.FindCLCToolStripMenuItem.Text = "Find CLC"
        '
        'RegisterCLCAsActiveToolStripMenuItem
        '
        Me.RegisterCLCAsActiveToolStripMenuItem.Name = "RegisterCLCAsActiveToolStripMenuItem"
        Me.RegisterCLCAsActiveToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.RegisterCLCAsActiveToolStripMenuItem.Text = "Register CLC as Active"
        '
        'ToolStripSeparator1
        '
        Me.ToolStripSeparator1.Name = "ToolStripSeparator1"
        Me.ToolStripSeparator1.Size = New System.Drawing.Size(294, 6)
        '
        'SetDownLoadDirectoryToolStripMenuItem
        '
        Me.SetDownLoadDirectoryToolStripMenuItem.Name = "SetDownLoadDirectoryToolStripMenuItem"
        Me.SetDownLoadDirectoryToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.SetDownLoadDirectoryToolStripMenuItem.Text = "Set DownLoad Directory"
        '
        'PassthruDirectoryToolStripMenuItem
        '
        Me.PassthruDirectoryToolStripMenuItem.Name = "PassthruDirectoryToolStripMenuItem"
        Me.PassthruDirectoryToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.PassthruDirectoryToolStripMenuItem.Text = "Passthru Directory"
        '
        'ShowServiceVersionNumbersToolStripMenuItem
        '
        Me.ShowServiceVersionNumbersToolStripMenuItem.Name = "ShowServiceVersionNumbersToolStripMenuItem"
        Me.ShowServiceVersionNumbersToolStripMenuItem.Size = New System.Drawing.Size(297, 26)
        Me.ShowServiceVersionNumbersToolStripMenuItem.Text = "Show Service Version Numbers"
        '
        'PreviewToolStripMenuItem1
        '
        Me.PreviewToolStripMenuItem1.Font = New System.Drawing.Font("Segoe UI Semibold", 9.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.PreviewToolStripMenuItem1.ForeColor = System.Drawing.Color.Cyan
        Me.PreviewToolStripMenuItem1.Name = "PreviewToolStripMenuItem1"
        Me.PreviewToolStripMenuItem1.Size = New System.Drawing.Size(75, 24)
        Me.PreviewToolStripMenuItem1.Text = "Preview"
        Me.PreviewToolStripMenuItem1.ToolTipText = "Click to immediate check for files waiting preview"
        '
        'DownloadToolStripMenuItem
        '
        Me.DownloadToolStripMenuItem.Font = New System.Drawing.Font("Segoe UI Semibold", 9.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Underline), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.DownloadToolStripMenuItem.ForeColor = System.Drawing.Color.Cyan
        Me.DownloadToolStripMenuItem.Name = "DownloadToolStripMenuItem"
        Me.DownloadToolStripMenuItem.Size = New System.Drawing.Size(127, 24)
        Me.DownloadToolStripMenuItem.Text = "Download Now"
        Me.DownloadToolStripMenuItem.ToolTipText = "Click to force an immediate download of any pending files."
        '
        'Label2
        '
        Me.Label2.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Font = New System.Drawing.Font("Engravers MT", 18.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.Color.Aqua
        Me.Label2.Location = New System.Drawing.Point(336, 185)
        Me.Label2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(303, 35)
        Me.Label2.TabIndex = 12
        Me.Label2.Text = "ECM Library"
        '
        'Label3
        '
        Me.Label3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.ForeColor = System.Drawing.SystemColors.GradientActiveCaption
        Me.Label3.Location = New System.Drawing.Point(339, 234)
        Me.Label3.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(178, 17)
        Me.Label3.TabIndex = 13
        Me.Label3.Text = "Cross Layer Communicator"
        '
        'PB
        '
        Me.PB.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.PB.Location = New System.Drawing.Point(16, 288)
        Me.PB.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.PB.Name = "PB"
        Me.PB.Size = New System.Drawing.Size(807, 17)
        Me.PB.TabIndex = 14
        Me.PB.Visible = False
        '
        'ckRunMinimized
        '
        Me.ckRunMinimized.AutoSize = True
        Me.ckRunMinimized.BackColor = System.Drawing.Color.Transparent
        Me.ckRunMinimized.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckRunMinimized.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.ckRunMinimized.Location = New System.Drawing.Point(25, 185)
        Me.ckRunMinimized.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.ckRunMinimized.Name = "ckRunMinimized"
        Me.ckRunMinimized.Size = New System.Drawing.Size(135, 21)
        Me.ckRunMinimized.TabIndex = 15
        Me.ckRunMinimized.Text = "Run Minimized"
        Me.ckRunMinimized.UseVisualStyleBackColor = False
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(741, 222)
        Me.Button3.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(81, 39)
        Me.Button3.TabIndex = 16
        Me.Button3.Text = "TEST"
        Me.Button3.UseVisualStyleBackColor = True
        Me.Button3.Visible = False
        '
        'txtLoginID
        '
        Me.txtLoginID.Location = New System.Drawing.Point(447, 102)
        Me.txtLoginID.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.txtLoginID.Name = "txtLoginID"
        Me.txtLoginID.Size = New System.Drawing.Size(235, 22)
        Me.txtLoginID.TabIndex = 20
        '
        'lblUser
        '
        Me.lblUser.AutoSize = True
        Me.lblUser.BackColor = System.Drawing.Color.Transparent
        Me.lblUser.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblUser.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.lblUser.Location = New System.Drawing.Point(443, 80)
        Me.lblUser.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblUser.Name = "lblUser"
        Me.lblUser.Size = New System.Drawing.Size(150, 18)
        Me.lblUser.TabIndex = 21
        Me.lblUser.Text = "Download/User ID:"
        '
        'ckRemember
        '
        Me.ckRemember.AutoSize = True
        Me.ckRemember.BackColor = System.Drawing.Color.Transparent
        Me.ckRemember.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckRemember.ForeColor = System.Drawing.SystemColors.ButtonHighlight
        Me.ckRemember.Location = New System.Drawing.Point(447, 134)
        Me.ckRemember.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.ckRemember.Name = "ckRemember"
        Me.ckRemember.Size = New System.Drawing.Size(129, 22)
        Me.ckRemember.TabIndex = 22
        Me.ckRemember.Text = "Remember Me"
        Me.ckRemember.UseVisualStyleBackColor = False
        '
        'SB
        '
        Me.SB.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Location = New System.Drawing.Point(16, 314)
        Me.SB.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(805, 22)
        Me.SB.TabIndex = 23
        '
        'Label4
        '
        Me.Label4.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.ForeColor = System.Drawing.SystemColors.GradientActiveCaption
        Me.Label4.Location = New System.Drawing.Point(339, 250)
        Me.Label4.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(48, 17)
        Me.Label4.TabIndex = 24
        Me.Label4.Text = "Status"
        '
        'Label6
        '
        Me.Label6.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label6.AutoSize = True
        Me.Label6.BackColor = System.Drawing.Color.Transparent
        Me.Label6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.Color.LightYellow
        Me.Label6.Location = New System.Drawing.Point(16, 268)
        Me.Label6.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(86, 17)
        Me.Label6.TabIndex = 26
        Me.Label6.Text = "3.1.2.1007"
        '
        'Label5
        '
        Me.Label5.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label5.AutoSize = True
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.Color.LightYellow
        Me.Label5.Location = New System.Drawing.Point(704, 268)
        Me.Label5.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(113, 17)
        Me.Label5.TabIndex = 27
        Me.Label5.Text = "15.10.18.0718"
        '
        'frmEcmDownload
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSize = True
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(839, 342)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.ckRemember)
        Me.Controls.Add(Me.lblUser)
        Me.Controls.Add(Me.txtLoginID)
        Me.Controls.Add(Me.lblDownLoadDir)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.ckRunMinimized)
        Me.Controls.Add(Me.PB)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.lblMaxFileSize)
        Me.Controls.Add(Me.lblNbrDownloadsProcessed)
        Me.Controls.Add(Me.lblNbrPolls)
        Me.Controls.Add(Me.lblScan)
        Me.Controls.Add(Me.ckDisable)
        Me.Controls.Add(Me.lblDownloads)
        Me.Controls.Add(Me.lblPreviewState)
        Me.Controls.Add(Me.MenuStrip1)
        Me.HelpButton = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.MaximizeBox = False
        Me.Name = "frmEcmDownload"
        Me.Text = "ECM Auto Retrieve"
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TPreview As System.Windows.Forms.Timer
    Friend WithEvents lblPreviewState As System.Windows.Forms.Label
    Friend WithEvents lblDownloads As System.Windows.Forms.Label
    Friend WithEvents TDownload As System.Windows.Forms.Timer
    Friend WithEvents ckDisable As System.Windows.Forms.CheckBox
    Friend WithEvents lblScan As System.Windows.Forms.Label
    Friend WithEvents lblNbrPolls As System.Windows.Forms.Label
    Friend WithEvents lblNbrDownloadsProcessed As System.Windows.Forms.Label
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents lblMaxFileSize As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents FoldersToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ContentRestoreFolderToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EmailRestoreFolderToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents PreviewFolderToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ApplicationFolderToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents LogsFolderToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents CleanOutOldRestoredFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents PreviewedFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TempRestoredFilesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents TempRestoredEmailsToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents SilverlightFoldersToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents PreviewToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents EmailToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents PB As System.Windows.Forms.ProgressBar
    Friend WithEvents ckRunMinimized As System.Windows.Forms.CheckBox
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents ViewCLCRegistrationStatusToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents lblDownLoadDir As System.Windows.Forms.Label
    Friend WithEvents FindCLCToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents RegisterCLCAsActiveToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents InitCLCFoldersToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents PreviewToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents DownloadToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents txtLoginID As System.Windows.Forms.TextBox
    Friend WithEvents lblUser As System.Windows.Forms.Label
    Friend WithEvents ckRemember As System.Windows.Forms.CheckBox
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents ToolStripSeparator1 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents SetDownLoadDirectoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents FolderBrowserDialog1 As System.Windows.Forms.FolderBrowserDialog
    Friend WithEvents LogFileToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents PassthruDirectoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ShowServiceVersionNumbersToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ToolStripSeparator2 As System.Windows.Forms.ToolStripSeparator
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents ViewTodaysLogToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents PurgeRestoreQueueToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem

End Class
