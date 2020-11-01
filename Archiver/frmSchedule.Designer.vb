<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmSchedule
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
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Me.dgSchedule = New System.Windows.Forms.DataGridView()
        Me.btnDisplaySchedules = New System.Windows.Forms.Button()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.lblScheduleType = New System.Windows.Forms.Label()
        Me.cbScheduleUnits = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.btnUpdate = New System.Windows.Forms.Button()
        Me.btnAdd = New System.Windows.Forms.Button()
        Me.StatusBar = New System.Windows.Forms.StatusStrip()
        Me.SB = New System.Windows.Forms.ToolStripStatusLabel()
        Me.SB2 = New System.Windows.Forms.ToolStripStatusLabel()
        Me.SelectedTaskName = New System.Windows.Forms.ToolStripStatusLabel()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.ToolsToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.WindowsSchedulerToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ApplicationExecutionPathToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.cbDayToRun = New System.Windows.Forms.ComboBox()
        Me.dtStart = New System.Windows.Forms.DateTimePicker()
        Me.btnDisableArchive = New System.Windows.Forms.Button()
        Me.btnEnableArchive = New System.Windows.Forms.Button()
        Me.ckAll = New System.Windows.Forms.CheckBox()
        Me.ckFiles = New System.Windows.Forms.CheckBox()
        Me.ckOutlook = New System.Windows.Forms.CheckBox()
        Me.ckExchange = New System.Windows.Forms.CheckBox()
        Me.cbTod = New System.Windows.Forms.ComboBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.txtUser = New System.Windows.Forms.TextBox()
        Me.btnValidate = New System.Windows.Forms.Button()
        Me.ckShowAll = New System.Windows.Forms.CheckBox()
        Me.ckClipboardCommad = New System.Windows.Forms.CheckBox()
        Me.CommandExecutionDirectoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        CType(Me.dgSchedule, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.StatusBar.SuspendLayout()
        Me.MenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'dgSchedule
        '
        Me.dgSchedule.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.dgSchedule.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        Me.dgSchedule.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.dgSchedule.DefaultCellStyle = DataGridViewCellStyle2
        Me.dgSchedule.Location = New System.Drawing.Point(12, 30)
        Me.dgSchedule.Name = "dgSchedule"
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.dgSchedule.RowHeadersDefaultCellStyle = DataGridViewCellStyle3
        Me.dgSchedule.Size = New System.Drawing.Size(818, 338)
        Me.dgSchedule.TabIndex = 0
        '
        'btnDisplaySchedules
        '
        Me.btnDisplaySchedules.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnDisplaySchedules.Location = New System.Drawing.Point(146, 461)
        Me.btnDisplaySchedules.Name = "btnDisplaySchedules"
        Me.btnDisplaySchedules.Size = New System.Drawing.Size(85, 60)
        Me.btnDisplaySchedules.TabIndex = 1
        Me.btnDisplaySchedules.Text = "Display Scheduled Items"
        Me.btnDisplaySchedules.UseVisualStyleBackColor = True
        '
        'btnDelete
        '
        Me.btnDelete.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnDelete.Location = New System.Drawing.Point(344, 461)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(85, 60)
        Me.btnDelete.TabIndex = 2
        Me.btnDelete.Text = "Delete Selected Task"
        Me.btnDelete.UseVisualStyleBackColor = True
        '
        'lblScheduleType
        '
        Me.lblScheduleType.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblScheduleType.AutoSize = True
        Me.lblScheduleType.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblScheduleType.Location = New System.Drawing.Point(6, 410)
        Me.lblScheduleType.Name = "lblScheduleType"
        Me.lblScheduleType.Size = New System.Drawing.Size(139, 13)
        Me.lblScheduleType.TabIndex = 4
        Me.lblScheduleType.Text = "Select what to archive:"
        '
        'cbScheduleUnits
        '
        Me.cbScheduleUnits.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.cbScheduleUnits.FormattingEnabled = True
        Me.cbScheduleUnits.Items.AddRange(New Object() {"HOURLY", "DAILY", "WEEKLY", "MONTHLY"})
        Me.cbScheduleUnits.Location = New System.Drawing.Point(143, 387)
        Me.cbScheduleUnits.Name = "cbScheduleUnits"
        Me.cbScheduleUnits.Size = New System.Drawing.Size(169, 21)
        Me.cbScheduleUnits.TabIndex = 5
        '
        'Label1
        '
        Me.Label1.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(143, 371)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(133, 13)
        Me.Label1.TabIndex = 6
        Me.Label1.Text = "Choose When To Archive:"
        '
        'Label2
        '
        Me.Label2.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(674, 371)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(58, 13)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "Start Time:"
        '
        'btnUpdate
        '
        Me.btnUpdate.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnUpdate.Location = New System.Drawing.Point(629, 461)
        Me.btnUpdate.Name = "btnUpdate"
        Me.btnUpdate.Size = New System.Drawing.Size(85, 60)
        Me.btnUpdate.TabIndex = 10
        Me.btnUpdate.Text = "Update Selected Task"
        Me.btnUpdate.UseVisualStyleBackColor = True
        '
        'btnAdd
        '
        Me.btnAdd.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnAdd.Location = New System.Drawing.Point(744, 461)
        Me.btnAdd.Name = "btnAdd"
        Me.btnAdd.Size = New System.Drawing.Size(85, 60)
        Me.btnAdd.TabIndex = 11
        Me.btnAdd.Text = "Add New Selected Task"
        Me.btnAdd.UseVisualStyleBackColor = True
        '
        'StatusBar
        '
        Me.StatusBar.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.SB, Me.SB2, Me.SelectedTaskName})
        Me.StatusBar.Location = New System.Drawing.Point(0, 534)
        Me.StatusBar.Name = "StatusBar"
        Me.StatusBar.Size = New System.Drawing.Size(842, 22)
        Me.StatusBar.TabIndex = 12
        '
        'SB
        '
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(105, 17)
        Me.SB.Text = "Archiver Messages"
        '
        'SB2
        '
        Me.SB2.Name = "SB2"
        Me.SB2.Size = New System.Drawing.Size(61, 17)
        Me.SB2.Text = "Statement"
        '
        'SelectedTaskName
        '
        Me.SelectedTaskName.Name = "SelectedTaskName"
        Me.SelectedTaskName.Size = New System.Drawing.Size(66, 17)
        Me.SelectedTaskName.Text = "Task Name"
        '
        'MenuStrip1
        '
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ToolsToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(842, 24)
        Me.MenuStrip1.TabIndex = 13
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'ToolsToolStripMenuItem
        '
        Me.ToolsToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.WindowsSchedulerToolStripMenuItem, Me.ApplicationExecutionPathToolStripMenuItem, Me.CommandExecutionDirectoryToolStripMenuItem})
        Me.ToolsToolStripMenuItem.Name = "ToolsToolStripMenuItem"
        Me.ToolsToolStripMenuItem.Size = New System.Drawing.Size(48, 20)
        Me.ToolsToolStripMenuItem.Text = "Tools"
        '
        'WindowsSchedulerToolStripMenuItem
        '
        Me.WindowsSchedulerToolStripMenuItem.Name = "WindowsSchedulerToolStripMenuItem"
        Me.WindowsSchedulerToolStripMenuItem.Size = New System.Drawing.Size(236, 22)
        Me.WindowsSchedulerToolStripMenuItem.Text = "Windows Scheduler"
        '
        'ApplicationExecutionPathToolStripMenuItem
        '
        Me.ApplicationExecutionPathToolStripMenuItem.Name = "ApplicationExecutionPathToolStripMenuItem"
        Me.ApplicationExecutionPathToolStripMenuItem.Size = New System.Drawing.Size(236, 22)
        Me.ApplicationExecutionPathToolStripMenuItem.Text = "Application Execution path"
        '
        'Label3
        '
        Me.Label3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(325, 371)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(64, 13)
        Me.Label3.TabIndex = 15
        Me.Label3.Text = "Day to Run:"
        '
        'cbDayToRun
        '
        Me.cbDayToRun.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.cbDayToRun.FormattingEnabled = True
        Me.cbDayToRun.Items.AddRange(New Object() {"HOURLY", "DAILY", "WEEKLY, ", "MONTHLY", "ONCE"})
        Me.cbDayToRun.Location = New System.Drawing.Point(325, 387)
        Me.cbDayToRun.Name = "cbDayToRun"
        Me.cbDayToRun.Size = New System.Drawing.Size(144, 21)
        Me.cbDayToRun.TabIndex = 14
        '
        'dtStart
        '
        Me.dtStart.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.dtStart.Location = New System.Drawing.Point(546, 387)
        Me.dtStart.Name = "dtStart"
        Me.dtStart.Size = New System.Drawing.Size(186, 20)
        Me.dtStart.TabIndex = 16
        '
        'btnDisableArchive
        '
        Me.btnDisableArchive.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnDisableArchive.Location = New System.Drawing.Point(538, 461)
        Me.btnDisableArchive.Name = "btnDisableArchive"
        Me.btnDisableArchive.Size = New System.Drawing.Size(85, 60)
        Me.btnDisableArchive.TabIndex = 17
        Me.btnDisableArchive.Text = "Disable Archive"
        Me.btnDisableArchive.UseVisualStyleBackColor = True
        '
        'btnEnableArchive
        '
        Me.btnEnableArchive.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnEnableArchive.Location = New System.Drawing.Point(435, 461)
        Me.btnEnableArchive.Name = "btnEnableArchive"
        Me.btnEnableArchive.Size = New System.Drawing.Size(85, 60)
        Me.btnEnableArchive.TabIndex = 18
        Me.btnEnableArchive.Text = "Enable Archive"
        Me.btnEnableArchive.UseVisualStyleBackColor = True
        '
        'ckAll
        '
        Me.ckAll.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckAll.AutoSize = True
        Me.ckAll.Location = New System.Drawing.Point(9, 426)
        Me.ckAll.Name = "ckAll"
        Me.ckAll.Size = New System.Drawing.Size(84, 17)
        Me.ckAll.TabIndex = 19
        Me.ckAll.Text = "Archive ALL"
        Me.ckAll.UseVisualStyleBackColor = True
        '
        'ckFiles
        '
        Me.ckFiles.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckFiles.AutoSize = True
        Me.ckFiles.Location = New System.Drawing.Point(9, 449)
        Me.ckFiles.Name = "ckFiles"
        Me.ckFiles.Size = New System.Drawing.Size(79, 17)
        Me.ckFiles.TabIndex = 20
        Me.ckFiles.Text = "File Folders"
        Me.ckFiles.UseVisualStyleBackColor = True
        '
        'ckOutlook
        '
        Me.ckOutlook.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckOutlook.AutoSize = True
        Me.ckOutlook.Location = New System.Drawing.Point(9, 472)
        Me.ckOutlook.Name = "ckOutlook"
        Me.ckOutlook.Size = New System.Drawing.Size(100, 17)
        Me.ckOutlook.TabIndex = 21
        Me.ckOutlook.Text = "Outlook Folders"
        Me.ckOutlook.UseVisualStyleBackColor = True
        '
        'ckExchange
        '
        Me.ckExchange.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckExchange.AutoSize = True
        Me.ckExchange.Location = New System.Drawing.Point(9, 495)
        Me.ckExchange.Name = "ckExchange"
        Me.ckExchange.Size = New System.Drawing.Size(113, 17)
        Me.ckExchange.TabIndex = 22
        Me.ckExchange.Text = "Exchange Servers"
        Me.ckExchange.UseVisualStyleBackColor = True
        '
        'cbTod
        '
        Me.cbTod.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.cbTod.FormattingEnabled = True
        Me.cbTod.Items.AddRange(New Object() {"HOURLY", "DAILY", "WEEKLY, ", "MONTHLY", "ONCE"})
        Me.cbTod.Location = New System.Drawing.Point(475, 386)
        Me.cbTod.Name = "cbTod"
        Me.cbTod.Size = New System.Drawing.Size(65, 21)
        Me.cbTod.TabIndex = 23
        '
        'Label4
        '
        Me.Label4.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(472, 371)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(68, 13)
        Me.Label4.TabIndex = 24
        Me.Label4.Text = "Time to Run:"
        '
        'Label5
        '
        Me.Label5.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(143, 426)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(126, 13)
        Me.Label5.TabIndex = 25
        Me.Label5.Text = "Run as USER (Login ID):"
        '
        'txtUser
        '
        Me.txtUser.Location = New System.Drawing.Point(274, 424)
        Me.txtUser.Name = "txtUser"
        Me.txtUser.Size = New System.Drawing.Size(266, 20)
        Me.txtUser.TabIndex = 26
        '
        'btnValidate
        '
        Me.btnValidate.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnValidate.Location = New System.Drawing.Point(237, 461)
        Me.btnValidate.Name = "btnValidate"
        Me.btnValidate.Size = New System.Drawing.Size(85, 60)
        Me.btnValidate.TabIndex = 27
        Me.btnValidate.Text = "Validate All ECM Schedules"
        Me.btnValidate.UseVisualStyleBackColor = True
        '
        'ckShowAll
        '
        Me.ckShowAll.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckShowAll.AutoSize = True
        Me.ckShowAll.Location = New System.Drawing.Point(12, 371)
        Me.ckShowAll.Name = "ckShowAll"
        Me.ckShowAll.Size = New System.Drawing.Size(120, 17)
        Me.ckShowAll.TabIndex = 28
        Me.ckShowAll.Text = "Show All Schedules"
        Me.ckShowAll.UseVisualStyleBackColor = True
        '
        'ckClipboardCommad
        '
        Me.ckClipboardCommad.AutoSize = True
        Me.ckClipboardCommad.Location = New System.Drawing.Point(564, 427)
        Me.ckClipboardCommad.Name = "ckClipboardCommad"
        Me.ckClipboardCommad.Size = New System.Drawing.Size(160, 17)
        Me.ckClipboardCommad.TabIndex = 29
        Me.ckClipboardCommad.Text = "Save Command to Clipboard"
        Me.ckClipboardCommad.UseVisualStyleBackColor = True
        '
        'CommandExecutionDirectoryToolStripMenuItem
        '
        Me.CommandExecutionDirectoryToolStripMenuItem.Name = "CommandExecutionDirectoryToolStripMenuItem"
        Me.CommandExecutionDirectoryToolStripMenuItem.Size = New System.Drawing.Size(236, 22)
        Me.CommandExecutionDirectoryToolStripMenuItem.Text = "Command Execution Directory"
        '
        'frmSchedule
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(842, 556)
        Me.Controls.Add(Me.ckClipboardCommad)
        Me.Controls.Add(Me.ckShowAll)
        Me.Controls.Add(Me.btnValidate)
        Me.Controls.Add(Me.txtUser)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.cbTod)
        Me.Controls.Add(Me.ckExchange)
        Me.Controls.Add(Me.ckOutlook)
        Me.Controls.Add(Me.ckFiles)
        Me.Controls.Add(Me.ckAll)
        Me.Controls.Add(Me.btnEnableArchive)
        Me.Controls.Add(Me.btnDisableArchive)
        Me.Controls.Add(Me.dtStart)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.cbDayToRun)
        Me.Controls.Add(Me.StatusBar)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Controls.Add(Me.btnAdd)
        Me.Controls.Add(Me.btnUpdate)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.cbScheduleUnits)
        Me.Controls.Add(Me.lblScheduleType)
        Me.Controls.Add(Me.btnDelete)
        Me.Controls.Add(Me.btnDisplaySchedules)
        Me.Controls.Add(Me.dgSchedule)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "frmSchedule"
        Me.Text = "ECM Archive Scheduler           (frmSchedule)"
        CType(Me.dgSchedule, System.ComponentModel.ISupportInitialize).EndInit()
        Me.StatusBar.ResumeLayout(False)
        Me.StatusBar.PerformLayout()
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents dgSchedule As System.Windows.Forms.DataGridView
    Friend WithEvents btnDisplaySchedules As System.Windows.Forms.Button
    Friend WithEvents btnDelete As System.Windows.Forms.Button
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents lblScheduleType As System.Windows.Forms.Label
    Friend WithEvents cbScheduleUnits As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents btnUpdate As System.Windows.Forms.Button
    Friend WithEvents btnAdd As System.Windows.Forms.Button
    Friend WithEvents StatusBar As System.Windows.Forms.StatusStrip
    Friend WithEvents SB As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents ToolsToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents WindowsSchedulerToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ApplicationExecutionPathToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents cbDayToRun As System.Windows.Forms.ComboBox
    Friend WithEvents SB2 As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents dtStart As System.Windows.Forms.DateTimePicker
    Friend WithEvents btnDisableArchive As System.Windows.Forms.Button
    Friend WithEvents btnEnableArchive As System.Windows.Forms.Button
    Friend WithEvents ckAll As System.Windows.Forms.CheckBox
    Friend WithEvents ckFiles As System.Windows.Forms.CheckBox
    Friend WithEvents ckOutlook As System.Windows.Forms.CheckBox
    Friend WithEvents ckExchange As System.Windows.Forms.CheckBox
    Friend WithEvents SelectedTaskName As System.Windows.Forms.ToolStripStatusLabel
    Friend WithEvents cbTod As System.Windows.Forms.ComboBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents txtUser As System.Windows.Forms.TextBox
    Friend WithEvents btnValidate As System.Windows.Forms.Button
    Friend WithEvents ckShowAll As System.Windows.Forms.CheckBox
    Friend WithEvents ckClipboardCommad As System.Windows.Forms.CheckBox
    Friend WithEvents CommandExecutionDirectoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
End Class
