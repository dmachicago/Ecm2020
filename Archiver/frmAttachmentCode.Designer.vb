<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmAttachmentCode
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
        Me.components = New System.ComponentModel.Container
        Me.dgAttachmentCode = New System.Windows.Forms.DataGridView
        Me.btnUpdate = New System.Windows.Forms.Button
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.btnApplyRetentionRule = New System.Windows.Forms.Button
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider
        Me.btnEncrypt = New System.Windows.Forms.Button
        Me.Label1 = New System.Windows.Forms.Label
        Me.cbRetention = New System.Windows.Forms.ComboBox
        CType(Me.dgAttachmentCode, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'dgAttachmentCode
        '
        Me.dgAttachmentCode.AllowUserToOrderColumns = True
        Me.dgAttachmentCode.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgAttachmentCode.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgAttachmentCode.Location = New System.Drawing.Point(12, 12)
        Me.dgAttachmentCode.Name = "dgAttachmentCode"
        Me.dgAttachmentCode.Size = New System.Drawing.Size(463, 331)
        Me.dgAttachmentCode.TabIndex = 0
        '
        'btnUpdate
        '
        Me.btnUpdate.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnUpdate.Location = New System.Drawing.Point(327, 354)
        Me.btnUpdate.Name = "btnUpdate"
        Me.btnUpdate.Size = New System.Drawing.Size(147, 32)
        Me.btnUpdate.TabIndex = 1
        Me.btnUpdate.Text = "&Update"
        Me.btnUpdate.UseVisualStyleBackColor = True
        '
        'btnApplyRetentionRule
        '
        Me.btnApplyRetentionRule.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnApplyRetentionRule.Location = New System.Drawing.Point(444, 395)
        Me.btnApplyRetentionRule.Name = "btnApplyRetentionRule"
        Me.btnApplyRetentionRule.Size = New System.Drawing.Size(29, 21)
        Me.btnApplyRetentionRule.TabIndex = 5
        Me.btnApplyRetentionRule.Text = "@"
        Me.TT.SetToolTip(Me.btnApplyRetentionRule, "Press to apply selected retention rule to selected item.")
        Me.btnApplyRetentionRule.UseVisualStyleBackColor = True
        '
        'Timer1
        '
        Me.Timer1.Enabled = True
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmAttachmentCodes.htm"
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnEncrypt.Location = New System.Drawing.Point(12, 354)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(147, 32)
        Me.btnEncrypt.TabIndex = 2
        Me.btnEncrypt.Text = "Encrypt Password"
        Me.btnEncrypt.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 399)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(158, 13)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Please Select a Retention Rule:"
        '
        'cbRetention
        '
        Me.cbRetention.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbRetention.FormattingEnabled = True
        Me.cbRetention.Location = New System.Drawing.Point(191, 396)
        Me.cbRetention.Name = "cbRetention"
        Me.cbRetention.Size = New System.Drawing.Size(245, 21)
        Me.cbRetention.TabIndex = 4
        '
        'frmAttachmentCode
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(490, 421)
        Me.Controls.Add(Me.btnApplyRetentionRule)
        Me.Controls.Add(Me.cbRetention)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.btnEncrypt)
        Me.Controls.Add(Me.btnUpdate)
        Me.Controls.Add(Me.dgAttachmentCode)
        Me.HelpProvider1.SetHelpString(Me, "http://www.ecmlibrary.com/_helpfiles/frmAttachmentCodes.htm")
        Me.Name = "frmAttachmentCode"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.Text = "Attachment Codes"
        CType(Me.dgAttachmentCode, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents dgAttachmentCode As System.Windows.Forms.DataGridView
    Friend WithEvents btnUpdate As System.Windows.Forms.Button
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
    Friend WithEvents btnEncrypt As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents cbRetention As System.Windows.Forms.ComboBox
    Friend WithEvents btnApplyRetentionRule As System.Windows.Forms.Button
End Class
