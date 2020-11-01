<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmRetentionMgt
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
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.rbEmails = New System.Windows.Forms.RadioButton
        Me.rbContent = New System.Windows.Forms.RadioButton
        Me.Label1 = New System.Windows.Forms.Label
        Me.txtExpireUnit = New System.Windows.Forms.TextBox
        Me.cbExpireUnits = New System.Windows.Forms.ComboBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.btnExecuteExpire = New System.Windows.Forms.Button
        Me.Label3 = New System.Windows.Forms.Label
        Me.btnSelectExpired = New System.Windows.Forms.Button
        Me.btnExecuteAge = New System.Windows.Forms.Button
        Me.cbAgeUnits = New System.Windows.Forms.ComboBox
        Me.txtAgeUnit = New System.Windows.Forms.TextBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.dgItems = New System.Windows.Forms.DataGridView
        Me.SB = New System.Windows.Forms.TextBox
        Me.btnDelete = New System.Windows.Forms.Button
        Me.btnMove = New System.Windows.Forms.Button
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.PB = New System.Windows.Forms.ProgressBar
        Me.dtExtendDate = New System.Windows.Forms.DateTimePicker
        Me.Label4 = New System.Windows.Forms.Label
        Me.btnExtend = New System.Windows.Forms.Button
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.btnRecall = New System.Windows.Forms.Button
        Me.HelpProvider1 = New System.Windows.Forms.HelpProvider
        Me.GroupBox1.SuspendLayout()
        CType(Me.dgItems, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.rbEmails)
        Me.GroupBox1.Controls.Add(Me.rbContent)
        Me.GroupBox1.Location = New System.Drawing.Point(12, 12)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(210, 88)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Select Group To Manage"
        '
        'rbEmails
        '
        Me.rbEmails.AutoSize = True
        Me.rbEmails.Location = New System.Drawing.Point(20, 48)
        Me.rbEmails.Name = "rbEmails"
        Me.rbEmails.Size = New System.Drawing.Size(55, 17)
        Me.rbEmails.TabIndex = 1
        Me.rbEmails.TabStop = True
        Me.rbEmails.Text = "Emails"
        Me.rbEmails.UseVisualStyleBackColor = True
        '
        'rbContent
        '
        Me.rbContent.AutoSize = True
        Me.rbContent.Location = New System.Drawing.Point(20, 25)
        Me.rbContent.Name = "rbContent"
        Me.rbContent.Size = New System.Drawing.Size(127, 17)
        Me.rbContent.TabIndex = 0
        Me.rbContent.TabStop = True
        Me.rbContent.Text = "Content / Documents"
        Me.rbContent.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 121)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(107, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Select all items within"
        '
        'txtExpireUnit
        '
        Me.txtExpireUnit.Location = New System.Drawing.Point(12, 143)
        Me.txtExpireUnit.Name = "txtExpireUnit"
        Me.txtExpireUnit.Size = New System.Drawing.Size(52, 20)
        Me.txtExpireUnit.TabIndex = 2
        '
        'cbExpireUnits
        '
        Me.cbExpireUnits.FormattingEnabled = True
        Me.cbExpireUnits.Items.AddRange(New Object() {"Months", "Days", "Years"})
        Me.cbExpireUnits.Location = New System.Drawing.Point(88, 142)
        Me.cbExpireUnits.Name = "cbExpireUnits"
        Me.cbExpireUnits.Size = New System.Drawing.Size(97, 21)
        Me.cbExpireUnits.TabIndex = 3
        Me.cbExpireUnits.Text = "Months"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(9, 177)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(64, 13)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "of expiration"
        '
        'btnExecuteExpire
        '
        Me.btnExecuteExpire.Location = New System.Drawing.Point(88, 177)
        Me.btnExecuteExpire.Name = "btnExecuteExpire"
        Me.btnExecuteExpire.Size = New System.Drawing.Size(91, 25)
        Me.btnExecuteExpire.TabIndex = 5
        Me.btnExecuteExpire.Text = "Execute"
        Me.btnExecuteExpire.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(19, 330)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(114, 13)
        Me.Label3.TabIndex = 6
        Me.Label3.Text = "Select all expired items"
        '
        'btnSelectExpired
        '
        Me.btnSelectExpired.Location = New System.Drawing.Point(22, 346)
        Me.btnSelectExpired.Name = "btnSelectExpired"
        Me.btnSelectExpired.Size = New System.Drawing.Size(91, 25)
        Me.btnSelectExpired.TabIndex = 7
        Me.btnSelectExpired.Text = "Execute"
        Me.btnSelectExpired.UseVisualStyleBackColor = True
        '
        'btnExecuteAge
        '
        Me.btnExecuteAge.Location = New System.Drawing.Point(94, 280)
        Me.btnExecuteAge.Name = "btnExecuteAge"
        Me.btnExecuteAge.Size = New System.Drawing.Size(91, 25)
        Me.btnExecuteAge.TabIndex = 12
        Me.btnExecuteAge.Text = "Execute"
        Me.btnExecuteAge.UseVisualStyleBackColor = True
        '
        'cbAgeUnits
        '
        Me.cbAgeUnits.FormattingEnabled = True
        Me.cbAgeUnits.Items.AddRange(New Object() {"Months", "Days", "Years"})
        Me.cbAgeUnits.Location = New System.Drawing.Point(88, 251)
        Me.cbAgeUnits.Name = "cbAgeUnits"
        Me.cbAgeUnits.Size = New System.Drawing.Size(97, 21)
        Me.cbAgeUnits.TabIndex = 10
        Me.cbAgeUnits.Text = "Months"
        '
        'txtAgeUnit
        '
        Me.txtAgeUnit.Location = New System.Drawing.Point(12, 252)
        Me.txtAgeUnit.Name = "txtAgeUnit"
        Me.txtAgeUnit.Size = New System.Drawing.Size(52, 20)
        Me.txtAgeUnit.TabIndex = 9
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(12, 230)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(127, 13)
        Me.Label5.TabIndex = 8
        Me.Label5.Text = "Select all items older than"
        '
        'dgItems
        '
        Me.dgItems.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgItems.Location = New System.Drawing.Point(248, 37)
        Me.dgItems.Name = "dgItems"
        Me.dgItems.Size = New System.Drawing.Size(576, 358)
        Me.dgItems.TabIndex = 13
        '
        'SB
        '
        Me.SB.Location = New System.Drawing.Point(15, 462)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(809, 20)
        Me.SB.TabIndex = 14
        '
        'btnDelete
        '
        Me.btnDelete.Location = New System.Drawing.Point(248, 414)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(91, 42)
        Me.btnDelete.TabIndex = 15
        Me.btnDelete.Text = "Delete Selected Items"
        Me.btnDelete.UseVisualStyleBackColor = True
        '
        'btnMove
        '
        Me.btnMove.Enabled = False
        Me.btnMove.Location = New System.Drawing.Point(733, 414)
        Me.btnMove.Name = "btnMove"
        Me.btnMove.Size = New System.Drawing.Size(91, 42)
        Me.btnMove.TabIndex = 16
        Me.btnMove.Text = "Move Selected Items"
        Me.btnMove.UseVisualStyleBackColor = True
        '
        'TT
        '
        '
        'PB
        '
        Me.PB.Location = New System.Drawing.Point(372, 431)
        Me.PB.Name = "PB"
        Me.PB.Size = New System.Drawing.Size(329, 14)
        Me.PB.TabIndex = 17
        '
        'dtExtendDate
        '
        Me.dtExtendDate.Location = New System.Drawing.Point(469, 10)
        Me.dtExtendDate.Name = "dtExtendDate"
        Me.dtExtendDate.Size = New System.Drawing.Size(208, 20)
        Me.dtExtendDate.TabIndex = 18
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(245, 14)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(218, 13)
        Me.Label4.TabIndex = 19
        Me.Label4.Text = "Extend all selected item's retention date until:"
        '
        'btnExtend
        '
        Me.btnExtend.Location = New System.Drawing.Point(733, 8)
        Me.btnExtend.Name = "btnExtend"
        Me.btnExtend.Size = New System.Drawing.Size(91, 25)
        Me.btnExtend.TabIndex = 20
        Me.btnExtend.Text = "Extend"
        Me.btnExtend.UseVisualStyleBackColor = True
        '
        'Timer1
        '
        '
        'btnRecall
        '
        Me.btnRecall.Enabled = False
        Me.btnRecall.Location = New System.Drawing.Point(22, 414)
        Me.btnRecall.Name = "btnRecall"
        Me.btnRecall.Size = New System.Drawing.Size(163, 42)
        Me.btnRecall.TabIndex = 21
        Me.btnRecall.Text = "Load Marked EMAIL Retention Items"
        Me.btnRecall.UseVisualStyleBackColor = True
        '
        'HelpProvider1
        '
        Me.HelpProvider1.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/Retention Management Screen.htm"
        '
        'frmRetentionMgt
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(871, 494)
        Me.Controls.Add(Me.btnRecall)
        Me.Controls.Add(Me.btnExtend)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.dtExtendDate)
        Me.Controls.Add(Me.PB)
        Me.Controls.Add(Me.btnMove)
        Me.Controls.Add(Me.btnDelete)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.dgItems)
        Me.Controls.Add(Me.btnExecuteAge)
        Me.Controls.Add(Me.cbAgeUnits)
        Me.Controls.Add(Me.txtAgeUnit)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.btnSelectExpired)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.btnExecuteExpire)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.cbExpireUnits)
        Me.Controls.Add(Me.txtExpireUnit)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.GroupBox1)
        Me.HelpProvider1.SetHelpString(Me, "http://www.ecmlibrary.com/_helpfiles/Retention Management Screen.htm")
        Me.Name = "frmRetentionMgt"
        Me.HelpProvider1.SetShowHelp(Me, True)
        Me.Text = "Content Retention Management Screen"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.dgItems, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents rbEmails As System.Windows.Forms.RadioButton
    Friend WithEvents rbContent As System.Windows.Forms.RadioButton
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtExpireUnit As System.Windows.Forms.TextBox
    Friend WithEvents cbExpireUnits As System.Windows.Forms.ComboBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents btnExecuteExpire As System.Windows.Forms.Button
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents btnSelectExpired As System.Windows.Forms.Button
    Friend WithEvents btnExecuteAge As System.Windows.Forms.Button
    Friend WithEvents cbAgeUnits As System.Windows.Forms.ComboBox
    Friend WithEvents txtAgeUnit As System.Windows.Forms.TextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents dgItems As System.Windows.Forms.DataGridView
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents btnDelete As System.Windows.Forms.Button
    Friend WithEvents btnMove As System.Windows.Forms.Button
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents PB As System.Windows.Forms.ProgressBar
    Friend WithEvents dtExtendDate As System.Windows.Forms.DateTimePicker
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents btnExtend As System.Windows.Forms.Button
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents btnRecall As System.Windows.Forms.Button
    Friend WithEvents HelpProvider1 As System.Windows.Forms.HelpProvider
End Class
