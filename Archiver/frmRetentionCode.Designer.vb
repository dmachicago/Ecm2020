<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmRetentionCode
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
        Me.dgRetention = New System.Windows.Forms.DataGridView()
        Me.txtRetentionCode = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtDesc = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.nbrRetentionUnits = New System.Windows.Forms.NumericUpDown()
        Me.cbRetentionPeriod = New System.Windows.Forms.ComboBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.nbrDaysWarning = New System.Windows.Forms.NumericUpDown()
        Me.ckResponseRequired = New System.Windows.Forms.CheckBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.txtManagerID = New System.Windows.Forms.TextBox()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.btnSave = New System.Windows.Forms.Button()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.cbRetentionAction = New System.Windows.Forms.ComboBox()
        CType(Me.dgRetention, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.nbrRetentionUnits, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.nbrDaysWarning, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'dgRetention
        '
        Me.dgRetention.AllowUserToAddRows = False
        Me.dgRetention.AllowUserToDeleteRows = False
        Me.dgRetention.AllowUserToOrderColumns = True
        Me.dgRetention.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgRetention.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgRetention.Location = New System.Drawing.Point(12, 318)
        Me.dgRetention.Name = "dgRetention"
        Me.dgRetention.Size = New System.Drawing.Size(759, 236)
        Me.dgRetention.TabIndex = 99
        '
        'txtRetentionCode
        '
        Me.txtRetentionCode.BackColor = System.Drawing.Color.Gainsboro
        Me.txtRetentionCode.Location = New System.Drawing.Point(12, 42)
        Me.txtRetentionCode.Name = "txtRetentionCode"
        Me.txtRetentionCode.Size = New System.Drawing.Size(246, 20)
        Me.txtRetentionCode.TabIndex = 1
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 24)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(81, 13)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Retention Code"
        '
        'txtDesc
        '
        Me.txtDesc.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDesc.BackColor = System.Drawing.Color.Gainsboro
        Me.txtDesc.Location = New System.Drawing.Point(15, 78)
        Me.txtDesc.Multiline = True
        Me.txtDesc.Name = "txtDesc"
        Me.txtDesc.Size = New System.Drawing.Size(548, 221)
        Me.txtDesc.TabIndex = 3
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 62)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(107, 13)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Retention description"
        '
        'nbrRetentionUnits
        '
        Me.nbrRetentionUnits.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.nbrRetentionUnits.Location = New System.Drawing.Point(591, 86)
        Me.nbrRetentionUnits.Name = "nbrRetentionUnits"
        Me.nbrRetentionUnits.Size = New System.Drawing.Size(94, 20)
        Me.nbrRetentionUnits.TabIndex = 5
        Me.nbrRetentionUnits.Value = New Decimal(New Integer() {10, 0, 0, 0})
        '
        'cbRetentionPeriod
        '
        Me.cbRetentionPeriod.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbRetentionPeriod.FormattingEnabled = True
        Me.cbRetentionPeriod.Items.AddRange(New Object() {"Year", "Month", "Day"})
        Me.cbRetentionPeriod.Location = New System.Drawing.Point(591, 42)
        Me.cbRetentionPeriod.Name = "cbRetentionPeriod"
        Me.cbRetentionPeriod.Size = New System.Drawing.Size(91, 21)
        Me.cbRetentionPeriod.TabIndex = 4
        Me.cbRetentionPeriod.Text = "Year"
        '
        'Label3
        '
        Me.Label3.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(591, 68)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(89, 13)
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "Retention Length"
        '
        'Label4
        '
        Me.Label4.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(591, 24)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(86, 13)
        Me.Label4.TabIndex = 8
        Me.Label4.Text = "Retention Period"
        '
        'Label5
        '
        Me.Label5.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(591, 111)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(74, 13)
        Me.Label5.TabIndex = 10
        Me.Label5.Text = "Days Warning"
        '
        'nbrDaysWarning
        '
        Me.nbrDaysWarning.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.nbrDaysWarning.Location = New System.Drawing.Point(591, 129)
        Me.nbrDaysWarning.Name = "nbrDaysWarning"
        Me.nbrDaysWarning.Size = New System.Drawing.Size(94, 20)
        Me.nbrDaysWarning.TabIndex = 6
        Me.nbrDaysWarning.Value = New Decimal(New Integer() {30, 0, 0, 0})
        '
        'ckResponseRequired
        '
        Me.ckResponseRequired.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckResponseRequired.AutoSize = True
        Me.ckResponseRequired.Location = New System.Drawing.Point(591, 198)
        Me.ckResponseRequired.Name = "ckResponseRequired"
        Me.ckResponseRequired.Size = New System.Drawing.Size(120, 17)
        Me.ckResponseRequired.TabIndex = 7
        Me.ckResponseRequired.Text = "Response Required"
        Me.ckResponseRequired.UseVisualStyleBackColor = True
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(314, 24)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(133, 13)
        Me.Label6.TabIndex = 14
        Me.Label6.Text = "Manager Notification Email"
        '
        'txtManagerID
        '
        Me.txtManagerID.BackColor = System.Drawing.Color.Gainsboro
        Me.txtManagerID.Location = New System.Drawing.Point(314, 42)
        Me.txtManagerID.Name = "txtManagerID"
        Me.txtManagerID.Size = New System.Drawing.Size(246, 20)
        Me.txtManagerID.TabIndex = 2
        '
        'SB
        '
        Me.SB.Location = New System.Drawing.Point(12, 561)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(759, 20)
        Me.SB.TabIndex = 99999
        '
        'btnSave
        '
        Me.btnSave.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnSave.Location = New System.Drawing.Point(591, 248)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(73, 50)
        Me.btnSave.TabIndex = 100001
        Me.btnSave.Text = "Save"
        Me.btnSave.UseVisualStyleBackColor = True
        '
        'btnDelete
        '
        Me.btnDelete.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnDelete.Location = New System.Drawing.Point(698, 248)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(73, 51)
        Me.btnDelete.TabIndex = 100002
        Me.btnDelete.Text = "Delete"
        Me.btnDelete.UseVisualStyleBackColor = True
        '
        'Label7
        '
        Me.Label7.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(591, 154)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(86, 13)
        Me.Label7.TabIndex = 100004
        Me.Label7.Text = "Retention Action"
        '
        'cbRetentionAction
        '
        Me.cbRetentionAction.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbRetentionAction.FormattingEnabled = True
        Me.cbRetentionAction.Items.AddRange(New Object() {"Delete", "Move"})
        Me.cbRetentionAction.Location = New System.Drawing.Point(591, 172)
        Me.cbRetentionAction.Name = "cbRetentionAction"
        Me.cbRetentionAction.Size = New System.Drawing.Size(91, 21)
        Me.cbRetentionAction.TabIndex = 100003
        Me.cbRetentionAction.Text = "Delete"
        '
        'frmRetentionCode
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.LightGray
        Me.ClientSize = New System.Drawing.Size(783, 593)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.cbRetentionAction)
        Me.Controls.Add(Me.btnDelete)
        Me.Controls.Add(Me.btnSave)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.txtManagerID)
        Me.Controls.Add(Me.ckResponseRequired)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.nbrDaysWarning)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.cbRetentionPeriod)
        Me.Controls.Add(Me.nbrRetentionUnits)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.txtDesc)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtRetentionCode)
        Me.Controls.Add(Me.dgRetention)
        Me.Name = "frmRetentionCode"
        Me.Text = "Retention Rules     (frmRetentionCode)"
        CType(Me.dgRetention, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.nbrRetentionUnits, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.nbrDaysWarning, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents dgRetention As System.Windows.Forms.DataGridView
    Friend WithEvents txtRetentionCode As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtDesc As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents nbrRetentionUnits As System.Windows.Forms.NumericUpDown
    Friend WithEvents cbRetentionPeriod As System.Windows.Forms.ComboBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents nbrDaysWarning As System.Windows.Forms.NumericUpDown
    Friend WithEvents ckResponseRequired As System.Windows.Forms.CheckBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents txtManagerID As System.Windows.Forms.TextBox
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents btnSave As System.Windows.Forms.Button
    Friend WithEvents btnDelete As System.Windows.Forms.Button
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents cbRetentionAction As System.Windows.Forms.ComboBox
End Class
