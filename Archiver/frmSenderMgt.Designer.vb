<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmSenderMgt
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
        Me.components = New System.ComponentModel.Container
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.btnRefresh = New System.Windows.Forms.Button
        Me.rbContacts = New System.Windows.Forms.RadioButton
        Me.btnExclSender = New System.Windows.Forms.Button
        Me.rbInbox = New System.Windows.Forms.RadioButton
        Me.rbArchive = New System.Windows.Forms.RadioButton
        Me.btnRemoveExcluded = New System.Windows.Forms.Button
        Me.dgExcludedSenders = New System.Windows.Forms.DataGridView
        Me.dgEmailSenders = New System.Windows.Forms.DataGridView
        Me.ExcludeFromBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.ArchiveFromBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.DMAUDDataSetBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.DMAUDDataSet2BindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.f1Help = New System.Windows.Forms.HelpProvider
        Me.cbOutlookFOlder = New System.Windows.Forms.ComboBox
        Me.GroupBox1.SuspendLayout()
        CType(Me.dgExcludedSenders, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgEmailSenders, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ExcludeFromBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ArchiveFromBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DMAUDDataSetBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DMAUDDataSet2BindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(8, 8)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(74, 13)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Email Senders"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(454, 9)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(155, 13)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Excluded Senders from Archive"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.cbOutlookFOlder)
        Me.GroupBox1.Controls.Add(Me.btnRefresh)
        Me.GroupBox1.Controls.Add(Me.rbContacts)
        Me.GroupBox1.Controls.Add(Me.btnExclSender)
        Me.GroupBox1.Controls.Add(Me.rbInbox)
        Me.GroupBox1.Controls.Add(Me.rbArchive)
        Me.GroupBox1.Location = New System.Drawing.Point(16, 448)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(430, 121)
        Me.GroupBox1.TabIndex = 6
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Sender List"
        '
        'btnRefresh
        '
        Me.btnRefresh.Location = New System.Drawing.Point(360, 12)
        Me.btnRefresh.Name = "btnRefresh"
        Me.btnRefresh.Size = New System.Drawing.Size(64, 24)
        Me.btnRefresh.TabIndex = 13
        Me.btnRefresh.Text = "&Refresh"
        Me.btnRefresh.UseVisualStyleBackColor = True
        '
        'rbContacts
        '
        Me.rbContacts.AutoSize = True
        Me.rbContacts.Location = New System.Drawing.Point(24, 51)
        Me.rbContacts.Name = "rbContacts"
        Me.rbContacts.Size = New System.Drawing.Size(107, 17)
        Me.rbContacts.TabIndex = 12
        Me.rbContacts.Text = "Outlook Contacts"
        Me.rbContacts.UseVisualStyleBackColor = True
        Me.rbContacts.Visible = False
        '
        'btnExclSender
        '
        Me.btnExclSender.Location = New System.Drawing.Point(360, 44)
        Me.btnExclSender.Name = "btnExclSender"
        Me.btnExclSender.Size = New System.Drawing.Size(64, 24)
        Me.btnExclSender.TabIndex = 11
        Me.btnExclSender.Text = "&Exclude"
        Me.TT.SetToolTip(Me.btnExclSender, "Press to exclude selected senders from the archive process.")
        Me.btnExclSender.UseVisualStyleBackColor = True
        '
        'rbInbox
        '
        Me.rbInbox.AutoSize = True
        Me.rbInbox.Location = New System.Drawing.Point(24, 86)
        Me.rbInbox.Name = "rbInbox"
        Me.rbInbox.Size = New System.Drawing.Size(93, 17)
        Me.rbInbox.TabIndex = 9
        Me.rbInbox.Text = "Inbox Senders"
        Me.rbInbox.UseVisualStyleBackColor = True
        '
        'rbArchive
        '
        Me.rbArchive.AutoSize = True
        Me.rbArchive.Checked = True
        Me.rbArchive.Location = New System.Drawing.Point(24, 16)
        Me.rbArchive.Name = "rbArchive"
        Me.rbArchive.Size = New System.Drawing.Size(109, 17)
        Me.rbArchive.TabIndex = 8
        Me.rbArchive.TabStop = True
        Me.rbArchive.Text = "Archived Senders"
        Me.rbArchive.UseVisualStyleBackColor = True
        '
        'btnRemoveExcluded
        '
        Me.btnRemoveExcluded.Location = New System.Drawing.Point(826, 457)
        Me.btnRemoveExcluded.Name = "btnRemoveExcluded"
        Me.btnRemoveExcluded.Size = New System.Drawing.Size(64, 24)
        Me.btnRemoveExcluded.TabIndex = 11
        Me.btnRemoveExcluded.Text = "&Deselect"
        Me.btnRemoveExcluded.UseVisualStyleBackColor = True
        '
        'dgExcludedSenders
        '
        Me.dgExcludedSenders.AllowUserToAddRows = False
        Me.dgExcludedSenders.AllowUserToDeleteRows = False
        Me.dgExcludedSenders.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgExcludedSenders.Location = New System.Drawing.Point(457, 24)
        Me.dgExcludedSenders.Name = "dgExcludedSenders"
        Me.dgExcludedSenders.ReadOnly = True
        Me.dgExcludedSenders.Size = New System.Drawing.Size(435, 417)
        Me.dgExcludedSenders.TabIndex = 14
        '
        'dgEmailSenders
        '
        Me.dgEmailSenders.AllowUserToAddRows = False
        Me.dgEmailSenders.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgEmailSenders.Location = New System.Drawing.Point(11, 25)
        Me.dgEmailSenders.Name = "dgEmailSenders"
        Me.dgEmailSenders.ReadOnly = True
        Me.dgEmailSenders.Size = New System.Drawing.Size(435, 417)
        Me.dgEmailSenders.TabIndex = 19
        '
        'ExcludeFromBindingSource
        '
        Me.ExcludeFromBindingSource.DataMember = "ExcludeFrom"
        '
        'ArchiveFromBindingSource
        '
        '
        'ExcludeFromTableAdapter
        '
        '
        'DMAUDDataSetBindingSource
        '
        Me.DMAUDDataSetBindingSource.Position = 0
        '
        '_DMA_UDDataSet2
        '
        '
        'DMAUDDataSet2BindingSource
        '
        '
        'ArchiveFromTableAdapter
        '
        '
        'Timer1
        '
        '
        'f1Help
        '
        Me.f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmSenderMgt.htm"
        '
        'cbOutlookFOlder
        '
        Me.cbOutlookFOlder.FormattingEnabled = True
        Me.cbOutlookFOlder.Location = New System.Drawing.Point(123, 84)
        Me.cbOutlookFOlder.Name = "cbOutlookFOlder"
        Me.cbOutlookFOlder.Size = New System.Drawing.Size(301, 21)
        Me.cbOutlookFOlder.TabIndex = 14
        '
        'frmSenderMgt
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(902, 581)
        Me.Controls.Add(Me.dgEmailSenders)
        Me.Controls.Add(Me.dgExcludedSenders)
        Me.Controls.Add(Me.btnRemoveExcluded)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.f1Help.SetHelpString(Me, "http://www.ecmlibrary.com/_helpfiles/frmSenderMgt.htm")
        Me.Name = "frmSenderMgt"
        Me.f1Help.SetShowHelp(Me, True)
        Me.Text = "Rejected Senders Management Screen"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.dgExcludedSenders, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgEmailSenders, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ExcludeFromBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ArchiveFromBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DMAUDDataSetBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DMAUDDataSet2BindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents btnExclSender As System.Windows.Forms.Button
    Friend WithEvents rbInbox As System.Windows.Forms.RadioButton
    Friend WithEvents rbArchive As System.Windows.Forms.RadioButton
    Friend WithEvents btnRemoveExcluded As System.Windows.Forms.Button
    Friend WithEvents rbContacts As System.Windows.Forms.RadioButton
    Friend WithEvents dgExcludedSenders As System.Windows.Forms.DataGridView
    Friend WithEvents ExcludeFromBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents btnRefresh As System.Windows.Forms.Button
    Friend WithEvents DMAUDDataSetBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents DMAUDDataSet2BindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents dgEmailSenders As System.Windows.Forms.DataGridView
    Friend WithEvents ArchiveFromBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents f1Help As System.Windows.Forms.HelpProvider
    Friend WithEvents cbOutlookFOlder As System.Windows.Forms.ComboBox
End Class
