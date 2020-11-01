<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmLicense
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
        Me.txtCurrConnStr = New System.Windows.Forms.TextBox()
        Me.txtLicense = New System.Windows.Forms.TextBox()
        Me.btnApply = New System.Windows.Forms.Button()
        Me.btnClose = New System.Windows.Forms.Button()
        Me.btnShowRules = New System.Windows.Forms.Button()
        Me.txtServer = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.txtCompanyID = New System.Windows.Forms.TextBox()
        Me.txtServerName = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.btnGetCurrLicense = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'txtCurrConnStr
        '
        Me.txtCurrConnStr.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtCurrConnStr.BackColor = System.Drawing.Color.WhiteSmoke
        Me.txtCurrConnStr.Enabled = False
        Me.txtCurrConnStr.Location = New System.Drawing.Point(1, 12)
        Me.txtCurrConnStr.Name = "txtCurrConnStr"
        Me.txtCurrConnStr.Size = New System.Drawing.Size(511, 20)
        Me.txtCurrConnStr.TabIndex = 0
        '
        'txtLicense
        '
        Me.txtLicense.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtLicense.Location = New System.Drawing.Point(1, 149)
        Me.txtLicense.Multiline = True
        Me.txtLicense.Name = "txtLicense"
        Me.txtLicense.Size = New System.Drawing.Size(511, 224)
        Me.txtLicense.TabIndex = 1
        Me.txtLicense.Visible = False
        '
        'btnApply
        '
        Me.btnApply.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnApply.Location = New System.Drawing.Point(305, 379)
        Me.btnApply.Name = "btnApply"
        Me.btnApply.Size = New System.Drawing.Size(88, 50)
        Me.btnApply.TabIndex = 2
        Me.btnApply.Text = "Apply"
        Me.btnApply.UseVisualStyleBackColor = True
        Me.btnApply.Visible = False
        '
        'btnClose
        '
        Me.btnClose.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnClose.Location = New System.Drawing.Point(399, 379)
        Me.btnClose.Name = "btnClose"
        Me.btnClose.Size = New System.Drawing.Size(88, 50)
        Me.btnClose.TabIndex = 3
        Me.btnClose.Text = "Close"
        Me.btnClose.UseVisualStyleBackColor = True
        Me.btnClose.Visible = False
        '
        'btnShowRules
        '
        Me.btnShowRules.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnShowRules.Location = New System.Drawing.Point(115, 379)
        Me.btnShowRules.Name = "btnShowRules"
        Me.btnShowRules.Size = New System.Drawing.Size(88, 50)
        Me.btnShowRules.TabIndex = 4
        Me.btnShowRules.Text = "Show Rules"
        Me.btnShowRules.UseVisualStyleBackColor = True
        Me.btnShowRules.Visible = False
        '
        'txtServer
        '
        Me.txtServer.BackColor = System.Drawing.SystemColors.InactiveBorder
        Me.txtServer.Enabled = False
        Me.txtServer.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtServer.Location = New System.Drawing.Point(150, 72)
        Me.txtServer.Name = "txtServer"
        Me.txtServer.Size = New System.Drawing.Size(293, 20)
        Me.txtServer.TabIndex = 5
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(18, 76)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(111, 13)
        Me.Label1.TabIndex = 6
        Me.Label1.Text = "SQL Server/Instance:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(18, 110)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(68, 13)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "Company ID:"
        '
        'txtCompanyID
        '
        Me.txtCompanyID.Location = New System.Drawing.Point(150, 106)
        Me.txtCompanyID.Name = "txtCompanyID"
        Me.txtCompanyID.Size = New System.Drawing.Size(293, 20)
        Me.txtCompanyID.TabIndex = 8
        '
        'txtServerName
        '
        Me.txtServerName.BackColor = System.Drawing.SystemColors.InactiveBorder
        Me.txtServerName.Enabled = False
        Me.txtServerName.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtServerName.Location = New System.Drawing.Point(150, 38)
        Me.txtServerName.Name = "txtServerName"
        Me.txtServerName.Size = New System.Drawing.Size(293, 20)
        Me.txtServerName.TabIndex = 10
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(18, 42)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(72, 13)
        Me.Label3.TabIndex = 9
        Me.Label3.Text = "Server Name:"
        '
        'SB
        '
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(21, 443)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(466, 20)
        Me.SB.TabIndex = 11
        Me.SB.Text = "Please fill in your Company ID"
        '
        'btnGetCurrLicense
        '
        Me.btnGetCurrLicense.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnGetCurrLicense.Location = New System.Drawing.Point(21, 379)
        Me.btnGetCurrLicense.Name = "btnGetCurrLicense"
        Me.btnGetCurrLicense.Size = New System.Drawing.Size(88, 50)
        Me.btnGetCurrLicense.TabIndex = 12
        Me.btnGetCurrLicense.Text = "Get Current License"
        Me.btnGetCurrLicense.UseVisualStyleBackColor = True
        Me.btnGetCurrLicense.Visible = False
        '
        'frmLicense
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(515, 475)
        Me.Controls.Add(Me.btnGetCurrLicense)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.txtServerName)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.txtCompanyID)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtServer)
        Me.Controls.Add(Me.btnShowRules)
        Me.Controls.Add(Me.btnClose)
        Me.Controls.Add(Me.btnApply)
        Me.Controls.Add(Me.txtLicense)
        Me.Controls.Add(Me.txtCurrConnStr)
        Me.Name = "frmLicense"
        Me.Text = "License Setup       (frmLicense)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtCurrConnStr As System.Windows.Forms.TextBox
    Friend WithEvents txtLicense As System.Windows.Forms.TextBox
    Friend WithEvents btnApply As System.Windows.Forms.Button
    Friend WithEvents btnClose As System.Windows.Forms.Button
    Friend WithEvents btnShowRules As System.Windows.Forms.Button
    Friend WithEvents txtServer As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents txtCompanyID As System.Windows.Forms.TextBox
    Friend WithEvents txtServerName As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents btnGetCurrLicense As System.Windows.Forms.Button
End Class
