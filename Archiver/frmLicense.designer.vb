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
        Me.components = New System.ComponentModel.Container()
        Me.btnGetfile = New System.Windows.Forms.Button()
        Me.btnLoadFile = New System.Windows.Forms.Button()
        Me.txtFqn = New System.Windows.Forms.TextBox()
        Me.txtLicense = New System.Windows.Forms.TextBox()
        Me.btnPasteLicense = New System.Windows.Forms.Button()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.btnRemote = New System.Windows.Forms.Button()
        Me.btnApplySelLic = New System.Windows.Forms.Button()
        Me.btnShowCurrentDB = New System.Windows.Forms.Button()
        Me.btnSetEqual = New System.Windows.Forms.Button()
        Me.btnGetCustID = New System.Windows.Forms.Button()
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.btnDisplay = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtCompanyID = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.dgLicense = New System.Windows.Forms.DataGridView()
        Me.f1Help = New System.Windows.Forms.HelpProvider()
        Me.txtSqlServerMachineName = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.txtServers = New System.Windows.Forms.TextBox()
        CType(Me.dgLicense, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'btnGetfile
        '
        Me.btnGetfile.Location = New System.Drawing.Point(685, 239)
        Me.btnGetfile.Name = "btnGetfile"
        Me.btnGetfile.Size = New System.Drawing.Size(147, 33)
        Me.btnGetfile.TabIndex = 0
        Me.btnGetfile.Text = "Find License File"
        Me.TT.SetToolTip(Me.btnGetfile, "Locate the license file in a specified directory and then ""Load License File""")
        Me.btnGetfile.UseVisualStyleBackColor = True
        '
        'btnLoadFile
        '
        Me.btnLoadFile.Location = New System.Drawing.Point(685, 278)
        Me.btnLoadFile.Name = "btnLoadFile"
        Me.btnLoadFile.Size = New System.Drawing.Size(147, 33)
        Me.btnLoadFile.TabIndex = 1
        Me.btnLoadFile.Text = "Load License File"
        Me.TT.SetToolTip(Me.btnLoadFile, "Once you locate the license file in a specified directory, then press ""Load Licen" & _
                "se File""")
        Me.btnLoadFile.UseVisualStyleBackColor = True
        '
        'txtFqn
        '
        Me.txtFqn.Location = New System.Drawing.Point(10, 33)
        Me.txtFqn.Name = "txtFqn"
        Me.txtFqn.Size = New System.Drawing.Size(669, 20)
        Me.txtFqn.TabIndex = 2
        '
        'txtLicense
        '
        Me.txtLicense.Location = New System.Drawing.Point(10, 59)
        Me.txtLicense.Multiline = True
        Me.txtLicense.Name = "txtLicense"
        Me.txtLicense.Size = New System.Drawing.Size(669, 133)
        Me.txtLicense.TabIndex = 3
        Me.TT.SetToolTip(Me.txtLicense, "Paste the encryted license data in this window.")
        '
        'btnPasteLicense
        '
        Me.btnPasteLicense.Location = New System.Drawing.Point(685, 317)
        Me.btnPasteLicense.Name = "btnPasteLicense"
        Me.btnPasteLicense.Size = New System.Drawing.Size(147, 33)
        Me.btnPasteLicense.TabIndex = 4
        Me.btnPasteLicense.Text = "Apply License from Textbox"
        Me.TT.SetToolTip(Me.btnPasteLicense, "Copy the encrypted license into the window to the left and then Press this button" & _
                ".")
        Me.btnPasteLicense.UseVisualStyleBackColor = True
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'SB
        '
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(6, 471)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(669, 20)
        Me.SB.TabIndex = 5
        '
        'btnRemote
        '
        Me.btnRemote.Location = New System.Drawing.Point(685, 419)
        Me.btnRemote.Name = "btnRemote"
        Me.btnRemote.Size = New System.Drawing.Size(147, 70)
        Me.btnRemote.TabIndex = 11
        Me.btnRemote.Text = "Fetch Available Licenses from ECM License Server"
        Me.TT.SetToolTip(Me.btnRemote, "Fetch License from ECM license server.")
        Me.btnRemote.UseVisualStyleBackColor = True
        '
        'btnApplySelLic
        '
        Me.btnApplySelLic.Location = New System.Drawing.Point(685, 59)
        Me.btnApplySelLic.Name = "btnApplySelLic"
        Me.btnApplySelLic.Size = New System.Drawing.Size(147, 70)
        Me.btnApplySelLic.TabIndex = 15
        Me.btnApplySelLic.Text = "Apply Selected License"
        Me.TT.SetToolTip(Me.btnApplySelLic, "Apply the selected license to the appropriate server.")
        Me.btnApplySelLic.UseVisualStyleBackColor = True
        '
        'btnShowCurrentDB
        '
        Me.btnShowCurrentDB.Location = New System.Drawing.Point(12, 6)
        Me.btnShowCurrentDB.Name = "btnShowCurrentDB"
        Me.btnShowCurrentDB.Size = New System.Drawing.Size(24, 21)
        Me.btnShowCurrentDB.TabIndex = 17
        Me.btnShowCurrentDB.Text = "@"
        Me.TT.SetToolTip(Me.btnShowCurrentDB, "Show the current User and DBARCH information")
        Me.btnShowCurrentDB.UseVisualStyleBackColor = True
        Me.btnShowCurrentDB.Visible = False
        '
        'btnSetEqual
        '
        Me.btnSetEqual.Location = New System.Drawing.Point(52, 6)
        Me.btnSetEqual.Name = "btnSetEqual"
        Me.btnSetEqual.Size = New System.Drawing.Size(24, 21)
        Me.btnSetEqual.TabIndex = 18
        Me.btnSetEqual.Text = "+"
        Me.TT.SetToolTip(Me.btnSetEqual, "Press to get your current Customer ID. Will not display anything if a license is " & _
                "not currently installed.")
        Me.btnSetEqual.UseVisualStyleBackColor = True
        Me.btnSetEqual.Visible = False
        '
        'btnGetCustID
        '
        Me.btnGetCustID.Location = New System.Drawing.Point(425, 444)
        Me.btnGetCustID.Name = "btnGetCustID"
        Me.btnGetCustID.Size = New System.Drawing.Size(157, 21)
        Me.btnGetCustID.TabIndex = 19
        Me.btnGetCustID.Text = "Get ID from License"
        Me.TT.SetToolTip(Me.btnGetCustID, "Press to get your current Customer ID. Will not display anything if a license is " & _
                "not currently installed.")
        Me.btnGetCustID.UseVisualStyleBackColor = True
        '
        'Timer1
        '
        Me.Timer1.Enabled = True
        Me.Timer1.Interval = 5000
        '
        'btnDisplay
        '
        Me.btnDisplay.Location = New System.Drawing.Point(685, 135)
        Me.btnDisplay.Name = "btnDisplay"
        Me.btnDisplay.Size = New System.Drawing.Size(147, 35)
        Me.btnDisplay.TabIndex = 6
        Me.btnDisplay.Text = "Show License Rules"
        Me.btnDisplay.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(6, 379)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(150, 13)
        Me.Label1.TabIndex = 8
        Me.Label1.Text = "Enter Repository Server Name"
        '
        'txtCompanyID
        '
        Me.txtCompanyID.Location = New System.Drawing.Point(212, 442)
        Me.txtCompanyID.Name = "txtCompanyID"
        Me.txtCompanyID.Size = New System.Drawing.Size(207, 20)
        Me.txtCompanyID.TabIndex = 12
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(6, 446)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(202, 13)
        Me.Label2.TabIndex = 13
        Me.Label2.Text = "Please Enter Your Assigned Customer ID:"
        '
        'dgLicense
        '
        Me.dgLicense.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgLicense.Location = New System.Drawing.Point(10, 198)
        Me.dgLicense.Name = "dgLicense"
        Me.dgLicense.RowTemplate.Height = 24
        Me.dgLicense.Size = New System.Drawing.Size(669, 178)
        Me.dgLicense.TabIndex = 14
        '
        'f1Help
        '
        Me.f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/License Management Screen.htm"
        '
        'txtSqlServerMachineName
        '
        Me.txtSqlServerMachineName.BackColor = System.Drawing.SystemColors.InactiveBorder
        Me.txtSqlServerMachineName.Enabled = False
        Me.txtSqlServerMachineName.Location = New System.Drawing.Point(135, 419)
        Me.txtSqlServerMachineName.Name = "txtSqlServerMachineName"
        Me.txtSqlServerMachineName.Size = New System.Drawing.Size(284, 20)
        Me.txtSqlServerMachineName.TabIndex = 20
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(6, 422)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(125, 13)
        Me.Label3.TabIndex = 21
        Me.Label3.Text = "SQL Svr Instance Name:"
        '
        'txtServers
        '
        Me.txtServers.Location = New System.Drawing.Point(8, 393)
        Me.txtServers.Name = "txtServers"
        Me.txtServers.Size = New System.Drawing.Size(411, 20)
        Me.txtServers.TabIndex = 22
        '
        'frmLicense
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(844, 501)
        Me.Controls.Add(Me.txtServers)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.txtSqlServerMachineName)
        Me.Controls.Add(Me.btnGetCustID)
        Me.Controls.Add(Me.btnSetEqual)
        Me.Controls.Add(Me.btnShowCurrentDB)
        Me.Controls.Add(Me.btnApplySelLic)
        Me.Controls.Add(Me.dgLicense)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.txtCompanyID)
        Me.Controls.Add(Me.btnRemote)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.btnDisplay)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.btnPasteLicense)
        Me.Controls.Add(Me.txtLicense)
        Me.Controls.Add(Me.txtFqn)
        Me.Controls.Add(Me.btnLoadFile)
        Me.Controls.Add(Me.btnGetfile)
        Me.f1Help.SetHelpString(Me, "http://www.ecmlibrary.com/_helpfiles/License Management Screen.htm")
        Me.Name = "frmLicense"
        Me.f1Help.SetShowHelp(Me, True)
        Me.Text = "frmLicense"
        CType(Me.dgLicense, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnGetfile As System.Windows.Forms.Button
    Friend WithEvents btnLoadFile As System.Windows.Forms.Button
    Friend WithEvents txtFqn As System.Windows.Forms.TextBox
    Friend WithEvents txtLicense As System.Windows.Forms.TextBox
    Friend WithEvents btnPasteLicense As System.Windows.Forms.Button
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents btnDisplay As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents btnRemote As System.Windows.Forms.Button
    Friend WithEvents txtCompanyID As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents dgLicense As System.Windows.Forms.DataGridView
    Friend WithEvents btnApplySelLic As System.Windows.Forms.Button
    Friend WithEvents f1Help As System.Windows.Forms.HelpProvider
    Friend WithEvents btnShowCurrentDB As System.Windows.Forms.Button
    Friend WithEvents btnSetEqual As System.Windows.Forms.Button
    Friend WithEvents btnGetCustID As System.Windows.Forms.Button
    Friend WithEvents txtSqlServerMachineName As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtServers As System.Windows.Forms.TextBox
End Class
