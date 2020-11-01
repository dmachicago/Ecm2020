<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmFti
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
        Me.lbFtiLogs = New System.Windows.Forms.ListBox()
        Me.btnScanGuids = New System.Windows.Forms.Button()
        Me.txtSourceGuid = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.btnCommonErrs = New System.Windows.Forms.Button()
        Me.btnSelectAll = New System.Windows.Forms.Button()
        Me.lbOutput = New System.Windows.Forms.ListBox()
        Me.btnSave = New System.Windows.Forms.Button()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.SBFqn = New System.Windows.Forms.TextBox()
        Me.lblMsg = New System.Windows.Forms.Label()
        Me.txtDetail = New System.Windows.Forms.TextBox()
        Me.txtKeyGuid = New System.Windows.Forms.TextBox()
        Me.txtDb = New System.Windows.Forms.TextBox()
        Me.btnFindItem = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'lbFtiLogs
        '
        Me.lbFtiLogs.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lbFtiLogs.FormattingEnabled = True
        Me.lbFtiLogs.ItemHeight = 16
        Me.lbFtiLogs.Location = New System.Drawing.Point(12, 44)
        Me.lbFtiLogs.Name = "lbFtiLogs"
        Me.lbFtiLogs.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lbFtiLogs.Size = New System.Drawing.Size(300, 308)
        Me.lbFtiLogs.TabIndex = 0
        '
        'btnScanGuids
        '
        Me.btnScanGuids.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnScanGuids.Location = New System.Drawing.Point(12, 431)
        Me.btnScanGuids.Name = "btnScanGuids"
        Me.btnScanGuids.Size = New System.Drawing.Size(204, 32)
        Me.btnScanGuids.TabIndex = 1
        Me.btnScanGuids.Text = "Search for Text"
        Me.btnScanGuids.UseVisualStyleBackColor = True
        '
        'txtSourceGuid
        '
        Me.txtSourceGuid.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtSourceGuid.Location = New System.Drawing.Point(13, 403)
        Me.txtSourceGuid.Name = "txtSourceGuid"
        Me.txtSourceGuid.Size = New System.Drawing.Size(299, 22)
        Me.txtSourceGuid.TabIndex = 2
        '
        'Label1
        '
        Me.Label1.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 383)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(134, 17)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Text To Search For:"
        '
        'btnCommonErrs
        '
        Me.btnCommonErrs.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnCommonErrs.Location = New System.Drawing.Point(13, 469)
        Me.btnCommonErrs.Name = "btnCommonErrs"
        Me.btnCommonErrs.Size = New System.Drawing.Size(204, 32)
        Me.btnCommonErrs.TabIndex = 4
        Me.btnCommonErrs.Text = "Error Summary"
        Me.btnCommonErrs.UseVisualStyleBackColor = True
        '
        'btnSelectAll
        '
        Me.btnSelectAll.Location = New System.Drawing.Point(12, 5)
        Me.btnSelectAll.Name = "btnSelectAll"
        Me.btnSelectAll.Size = New System.Drawing.Size(300, 33)
        Me.btnSelectAll.TabIndex = 5
        Me.btnSelectAll.Text = "Select All"
        Me.btnSelectAll.UseVisualStyleBackColor = True
        '
        'lbOutput
        '
        Me.lbOutput.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbOutput.FormattingEnabled = True
        Me.lbOutput.ItemHeight = 16
        Me.lbOutput.Location = New System.Drawing.Point(354, 44)
        Me.lbOutput.Name = "lbOutput"
        Me.lbOutput.ScrollAlwaysVisible = True
        Me.lbOutput.Size = New System.Drawing.Size(639, 308)
        Me.lbOutput.TabIndex = 6
        '
        'btnSave
        '
        Me.btnSave.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.System
        Me.btnSave.Location = New System.Drawing.Point(789, 6)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(204, 32)
        Me.btnSave.TabIndex = 7
        Me.btnSave.Text = "Save to File"
        Me.btnSave.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(237, 436)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 23)
        Me.Button1.TabIndex = 8
        Me.Button1.Text = "Button1"
        Me.Button1.UseVisualStyleBackColor = True
        Me.Button1.Visible = False
        '
        'SB
        '
        Me.SB.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.SB.BackColor = System.Drawing.SystemColors.InactiveCaption
        Me.SB.Location = New System.Drawing.Point(12, 529)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(981, 22)
        Me.SB.TabIndex = 9
        '
        'SBFqn
        '
        Me.SBFqn.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.SBFqn.BackColor = System.Drawing.SystemColors.InactiveCaption
        Me.SBFqn.Location = New System.Drawing.Point(12, 507)
        Me.SBFqn.Name = "SBFqn"
        Me.SBFqn.Size = New System.Drawing.Size(981, 22)
        Me.SBFqn.TabIndex = 10
        '
        'lblMsg
        '
        Me.lblMsg.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.lblMsg.AutoSize = True
        Me.lblMsg.Location = New System.Drawing.Point(354, 359)
        Me.lblMsg.Name = "lblMsg"
        Me.lblMsg.Size = New System.Drawing.Size(65, 17)
        Me.lblMsg.TabIndex = 11
        Me.lblMsg.Text = "Message"
        '
        'txtDetail
        '
        Me.txtDetail.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDetail.Location = New System.Drawing.Point(357, 384)
        Me.txtDetail.Multiline = True
        Me.txtDetail.Name = "txtDetail"
        Me.txtDetail.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.txtDetail.Size = New System.Drawing.Size(322, 117)
        Me.txtDetail.TabIndex = 12
        '
        'txtKeyGuid
        '
        Me.txtKeyGuid.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtKeyGuid.Location = New System.Drawing.Point(685, 416)
        Me.txtKeyGuid.Name = "txtKeyGuid"
        Me.txtKeyGuid.ReadOnly = True
        Me.txtKeyGuid.Size = New System.Drawing.Size(299, 22)
        Me.txtKeyGuid.TabIndex = 13
        '
        'txtDb
        '
        Me.txtDb.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDb.Location = New System.Drawing.Point(685, 384)
        Me.txtDb.Name = "txtDb"
        Me.txtDb.ReadOnly = True
        Me.txtDb.Size = New System.Drawing.Size(299, 22)
        Me.txtDb.TabIndex = 14
        '
        'btnFindItem
        '
        Me.btnFindItem.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnFindItem.Location = New System.Drawing.Point(780, 444)
        Me.btnFindItem.Name = "btnFindItem"
        Me.btnFindItem.Size = New System.Drawing.Size(108, 34)
        Me.btnFindItem.TabIndex = 15
        Me.btnFindItem.Text = "Get Name"
        Me.btnFindItem.UseVisualStyleBackColor = True
        '
        'frmFti
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1019, 552)
        Me.Controls.Add(Me.btnFindItem)
        Me.Controls.Add(Me.txtDb)
        Me.Controls.Add(Me.txtKeyGuid)
        Me.Controls.Add(Me.txtDetail)
        Me.Controls.Add(Me.lblMsg)
        Me.Controls.Add(Me.SBFqn)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.btnSave)
        Me.Controls.Add(Me.lbOutput)
        Me.Controls.Add(Me.btnSelectAll)
        Me.Controls.Add(Me.btnCommonErrs)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtSourceGuid)
        Me.Controls.Add(Me.btnScanGuids)
        Me.Controls.Add(Me.lbFtiLogs)
        Me.Name = "frmFti"
        Me.Text = "frmFti"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents lbFtiLogs As ListBox
    Friend WithEvents btnScanGuids As Button
    Friend WithEvents txtSourceGuid As TextBox
    Friend WithEvents Label1 As Label
    Friend WithEvents btnCommonErrs As Button
    Friend WithEvents btnSelectAll As Button
    Friend WithEvents lbOutput As ListBox
    Friend WithEvents btnSave As Button
    Friend WithEvents Button1 As Button
    Friend WithEvents SB As TextBox
    Friend WithEvents SBFqn As TextBox
    Friend WithEvents lblMsg As Label
    Friend WithEvents txtDetail As TextBox
    Friend WithEvents txtKeyGuid As TextBox
    Friend WithEvents txtDb As TextBox
    Friend WithEvents btnFindItem As Button
End Class
