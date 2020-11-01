<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmAppConfigEdit
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmAppConfigEdit))
        Me.SB = New System.Windows.Forms.TextBox()
        Me.ckHive = New System.Windows.Forms.CheckBox()
        Me.btnHiveUpdate = New System.Windows.Forms.Button()
        Me.btnTestHiveConn = New System.Windows.Forms.Button()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.txtDBName = New System.Windows.Forms.TextBox()
        Me.txtServerInstance = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.ckWindowsAuthentication = New System.Windows.Forms.CheckBox()
        Me.txtPw1 = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.txtLoginName = New System.Windows.Forms.TextBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.txtPw2 = New System.Windows.Forms.TextBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.cbSavedDefinitions = New System.Windows.Forms.ComboBox()
        Me.btnTestConnection = New System.Windows.Forms.Button()
        Me.btnSaveConn = New System.Windows.Forms.Button()
        Me.Button7 = New System.Windows.Forms.Button()
        Me.txtGlobalFileDirectory = New System.Windows.Forms.TextBox()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.txtRepositoryName = New System.Windows.Forms.TextBox()
        Me.btnResetGlobalLocationToDefault = New System.Windows.Forms.Button()
        Me.btnLoadCombo = New System.Windows.Forms.Button()
        Me.btnLoadData = New System.Windows.Forms.Button()
        Me.txtConnectionID = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.FolderBrowserDialog1 = New System.Windows.Forms.FolderBrowserDialog()
        Me.mnuLicense = New System.Windows.Forms.MenuStrip()
        Me.UtilityToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.GotoApplicationDirectoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.GotoGlobalDirectoryToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.LicenseToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.rbRepository = New System.Windows.Forms.RadioButton()
        Me.rbThesaurus = New System.Windows.Forms.RadioButton()
        Me.txtMstr = New System.Windows.Forms.TextBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.mnuLicense.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'SB
        '
        Me.SB.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.SB.BackColor = System.Drawing.Color.Black
        Me.SB.Enabled = False
        Me.SB.ForeColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Location = New System.Drawing.Point(10, 105)
        Me.SB.Name = "SB"
        Me.SB.ReadOnly = True
        Me.SB.Size = New System.Drawing.Size(375, 20)
        Me.SB.TabIndex = 12
        '
        'ckHive
        '
        Me.ckHive.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.ckHive.AutoSize = True
        Me.ckHive.BackColor = System.Drawing.Color.Transparent
        Me.ckHive.ForeColor = System.Drawing.Color.White
        Me.ckHive.Location = New System.Drawing.Point(7, 211)
        Me.ckHive.Name = "ckHive"
        Me.ckHive.Size = New System.Drawing.Size(126, 17)
        Me.ckHive.TabIndex = 25
        Me.ckHive.Text = "Attach Client to HIVE"
        Me.ckHive.UseVisualStyleBackColor = False
        Me.ckHive.Visible = False
        '
        'btnHiveUpdate
        '
        Me.btnHiveUpdate.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnHiveUpdate.Location = New System.Drawing.Point(161, 243)
        Me.btnHiveUpdate.Name = "btnHiveUpdate"
        Me.btnHiveUpdate.Size = New System.Drawing.Size(148, 21)
        Me.btnHiveUpdate.TabIndex = 26
        Me.btnHiveUpdate.Text = "Apply HIVE DB"
        Me.btnHiveUpdate.UseVisualStyleBackColor = True
        Me.btnHiveUpdate.Visible = False
        '
        'btnTestHiveConn
        '
        Me.btnTestHiveConn.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnTestHiveConn.Location = New System.Drawing.Point(7, 243)
        Me.btnTestHiveConn.Name = "btnTestHiveConn"
        Me.btnTestHiveConn.Size = New System.Drawing.Size(148, 21)
        Me.btnTestHiveConn.TabIndex = 27
        Me.btnTestHiveConn.Text = "Test HIVE Connection"
        Me.btnTestHiveConn.UseVisualStyleBackColor = True
        Me.btnTestHiveConn.Visible = False
        '
        'Label6
        '
        Me.Label6.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label6.AutoSize = True
        Me.Label6.BackColor = System.Drawing.Color.Transparent
        Me.Label6.ForeColor = System.Drawing.Color.White
        Me.Label6.Location = New System.Drawing.Point(15, 125)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(122, 13)
        Me.Label6.TabIndex = 30
        Me.Label6.Text = "Repository Server Name"
        '
        'txtDBName
        '
        Me.txtDBName.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtDBName.Location = New System.Drawing.Point(15, 141)
        Me.txtDBName.Name = "txtDBName"
        Me.txtDBName.Size = New System.Drawing.Size(375, 20)
        Me.txtDBName.TabIndex = 1
        Me.txtDBName.Text = "ServerName"
        Me.TT.SetToolTip(Me.txtDBName, "The name of the server on which the targeted repository lives.")
        '
        'txtServerInstance
        '
        Me.txtServerInstance.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtServerInstance.Location = New System.Drawing.Point(15, 188)
        Me.txtServerInstance.Name = "txtServerInstance"
        Me.txtServerInstance.Size = New System.Drawing.Size(375, 20)
        Me.txtServerInstance.TabIndex = 2
        Me.txtServerInstance.Text = "SqlServerName\InstanceName"
        Me.TT.SetToolTip(Me.txtServerInstance, "The databse name and instance of the ECM Repository or Thesaurus.")
        '
        'Label7
        '
        Me.Label7.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label7.AutoSize = True
        Me.Label7.BackColor = System.Drawing.Color.Transparent
        Me.Label7.ForeColor = System.Drawing.Color.White
        Me.Label7.Location = New System.Drawing.Point(15, 172)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(130, 13)
        Me.Label7.TabIndex = 32
        Me.Label7.Text = "Database\Instance Name"
        '
        'ckWindowsAuthentication
        '
        Me.ckWindowsAuthentication.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.ckWindowsAuthentication.AutoSize = True
        Me.ckWindowsAuthentication.BackColor = System.Drawing.Color.Transparent
        Me.ckWindowsAuthentication.Checked = True
        Me.ckWindowsAuthentication.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckWindowsAuthentication.ForeColor = System.Drawing.Color.White
        Me.ckWindowsAuthentication.Location = New System.Drawing.Point(15, 252)
        Me.ckWindowsAuthentication.Name = "ckWindowsAuthentication"
        Me.ckWindowsAuthentication.Size = New System.Drawing.Size(141, 17)
        Me.ckWindowsAuthentication.TabIndex = 34
        Me.ckWindowsAuthentication.Text = "Windows Authentication"
        Me.TT.SetToolTip(Me.ckWindowsAuthentication, "When checked, windows authentication will be used to access the repository, other" & _
                "wise the global ECM user name and password will be required.")
        Me.ckWindowsAuthentication.UseVisualStyleBackColor = False
        '
        'txtPw1
        '
        Me.txtPw1.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtPw1.Enabled = False
        Me.txtPw1.Location = New System.Drawing.Point(15, 348)
        Me.txtPw1.Name = "txtPw1"
        Me.txtPw1.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPw1.ReadOnly = True
        Me.txtPw1.Size = New System.Drawing.Size(375, 20)
        Me.txtPw1.TabIndex = 5
        Me.txtPw1.Text = "Junebug1"
        '
        'Label8
        '
        Me.Label8.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label8.AutoSize = True
        Me.Label8.BackColor = System.Drawing.Color.Transparent
        Me.Label8.Enabled = False
        Me.Label8.ForeColor = System.Drawing.Color.White
        Me.Label8.Location = New System.Drawing.Point(15, 332)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(53, 13)
        Me.Label8.TabIndex = 37
        Me.Label8.Text = "Password"
        '
        'txtLoginName
        '
        Me.txtLoginName.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtLoginName.Enabled = False
        Me.txtLoginName.Location = New System.Drawing.Point(15, 301)
        Me.txtLoginName.Name = "txtLoginName"
        Me.txtLoginName.ReadOnly = True
        Me.txtLoginName.Size = New System.Drawing.Size(375, 20)
        Me.txtLoginName.TabIndex = 4
        Me.txtLoginName.Text = "ecmlibrary"
        '
        'Label9
        '
        Me.Label9.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label9.AutoSize = True
        Me.Label9.BackColor = System.Drawing.Color.Transparent
        Me.Label9.Enabled = False
        Me.Label9.ForeColor = System.Drawing.Color.White
        Me.Label9.Location = New System.Drawing.Point(15, 285)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(118, 13)
        Me.Label9.TabIndex = 35
        Me.Label9.Text = "ECM Login User Name "
        '
        'txtPw2
        '
        Me.txtPw2.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtPw2.Enabled = False
        Me.txtPw2.Location = New System.Drawing.Point(15, 397)
        Me.txtPw2.Name = "txtPw2"
        Me.txtPw2.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPw2.ReadOnly = True
        Me.txtPw2.Size = New System.Drawing.Size(375, 20)
        Me.txtPw2.TabIndex = 6
        Me.txtPw2.Text = "Junebug1"
        '
        'Label10
        '
        Me.Label10.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label10.AutoSize = True
        Me.Label10.BackColor = System.Drawing.Color.Transparent
        Me.Label10.Enabled = False
        Me.Label10.ForeColor = System.Drawing.Color.White
        Me.Label10.Location = New System.Drawing.Point(15, 381)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(90, 13)
        Me.Label10.TabIndex = 39
        Me.Label10.Text = "Retype Password"
        '
        'Label11
        '
        Me.Label11.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label11.AutoSize = True
        Me.Label11.BackColor = System.Drawing.Color.Transparent
        Me.Label11.ForeColor = System.Drawing.Color.White
        Me.Label11.Location = New System.Drawing.Point(10, 32)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(102, 13)
        Me.Label11.TabIndex = 41
        Me.Label11.Text = "Save/Reload Name"
        '
        'cbSavedDefinitions
        '
        Me.cbSavedDefinitions.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.cbSavedDefinitions.FormattingEnabled = True
        Me.cbSavedDefinitions.Location = New System.Drawing.Point(10, 51)
        Me.cbSavedDefinitions.Name = "cbSavedDefinitions"
        Me.cbSavedDefinitions.Size = New System.Drawing.Size(375, 21)
        Me.cbSavedDefinitions.TabIndex = 7
        Me.cbSavedDefinitions.Text = "DefaultRepository"
        Me.TT.SetToolTip(Me.cbSavedDefinitions, "No more than 50 cahracters .")
        '
        'btnTestConnection
        '
        Me.btnTestConnection.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnTestConnection.ForeColor = System.Drawing.Color.DarkRed
        Me.btnTestConnection.Location = New System.Drawing.Point(10, 131)
        Me.btnTestConnection.Name = "btnTestConnection"
        Me.btnTestConnection.Size = New System.Drawing.Size(71, 42)
        Me.btnTestConnection.TabIndex = 8
        Me.btnTestConnection.Text = "Test Connection"
        Me.TT.SetToolTip(Me.btnTestConnection, "Press to test the connection defintion")
        Me.btnTestConnection.UseVisualStyleBackColor = True
        '
        'btnSaveConn
        '
        Me.btnSaveConn.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnSaveConn.Enabled = False
        Me.btnSaveConn.ForeColor = System.Drawing.Color.DarkRed
        Me.btnSaveConn.Location = New System.Drawing.Point(86, 131)
        Me.btnSaveConn.Name = "btnSaveConn"
        Me.btnSaveConn.Size = New System.Drawing.Size(71, 42)
        Me.btnSaveConn.TabIndex = 9
        Me.btnSaveConn.Text = "Save Connection"
        Me.TT.SetToolTip(Me.btnSaveConn, "Saves to Master DB and Will activate only after a successful Test Connection")
        Me.btnSaveConn.UseVisualStyleBackColor = True
        '
        'Button7
        '
        Me.Button7.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Button7.Location = New System.Drawing.Point(15, 43)
        Me.Button7.Name = "Button7"
        Me.Button7.Size = New System.Drawing.Size(305, 28)
        Me.Button7.TabIndex = 47
        Me.Button7.Text = "Select Global File Location"
        Me.Button7.UseVisualStyleBackColor = True
        '
        'txtGlobalFileDirectory
        '
        Me.txtGlobalFileDirectory.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtGlobalFileDirectory.Location = New System.Drawing.Point(15, 90)
        Me.txtGlobalFileDirectory.Name = "txtGlobalFileDirectory"
        Me.txtGlobalFileDirectory.Size = New System.Drawing.Size(375, 20)
        Me.txtGlobalFileDirectory.TabIndex = 0
        Me.txtGlobalFileDirectory.Text = "C:\EcmLibrary\Global"
        Me.TT.SetToolTip(Me.txtGlobalFileDirectory, "Specifiy a directory that to which ALL potential users will have access.")
        '
        'Button1
        '
        Me.Button1.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Button1.Enabled = False
        Me.Button1.ForeColor = System.Drawing.Color.DarkRed
        Me.Button1.Location = New System.Drawing.Point(238, 131)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(71, 42)
        Me.Button1.TabIndex = 10
        Me.Button1.Text = "Save Master Setup"
        Me.TT.SetToolTip(Me.Button1, "Will active only after a successful Test Connection")
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Button2.ForeColor = System.Drawing.Color.DarkRed
        Me.Button2.Location = New System.Drawing.Point(314, 131)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(71, 42)
        Me.Button2.TabIndex = 11
        Me.Button2.Text = "Load Master Setup"
        Me.TT.SetToolTip(Me.Button2, "Will active only after a successful Test Connection")
        Me.Button2.UseVisualStyleBackColor = True
        '
        'txtRepositoryName
        '
        Me.txtRepositoryName.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtRepositoryName.Location = New System.Drawing.Point(15, 227)
        Me.txtRepositoryName.Name = "txtRepositoryName"
        Me.txtRepositoryName.Size = New System.Drawing.Size(375, 20)
        Me.txtRepositoryName.TabIndex = 3
        Me.txtRepositoryName.Text = "ECM.Library"
        Me.TT.SetToolTip(Me.txtRepositoryName, "The databse name and instance of the ECM Repository or Thesaurus.")
        '
        'btnResetGlobalLocationToDefault
        '
        Me.btnResetGlobalLocationToDefault.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnResetGlobalLocationToDefault.Location = New System.Drawing.Point(326, 47)
        Me.btnResetGlobalLocationToDefault.Name = "btnResetGlobalLocationToDefault"
        Me.btnResetGlobalLocationToDefault.Size = New System.Drawing.Size(22, 20)
        Me.btnResetGlobalLocationToDefault.TabIndex = 59
        Me.btnResetGlobalLocationToDefault.Text = "@"
        Me.TT.SetToolTip(Me.btnResetGlobalLocationToDefault, "Reset global directory to default.")
        Me.btnResetGlobalLocationToDefault.UseVisualStyleBackColor = True
        '
        'btnLoadCombo
        '
        Me.btnLoadCombo.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnLoadCombo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnLoadCombo.ForeColor = System.Drawing.Color.DarkRed
        Me.btnLoadCombo.Location = New System.Drawing.Point(10, 78)
        Me.btnLoadCombo.Name = "btnLoadCombo"
        Me.btnLoadCombo.Size = New System.Drawing.Size(148, 21)
        Me.btnLoadCombo.TabIndex = 60
        Me.btnLoadCombo.Text = "Refresh Combo"
        Me.TT.SetToolTip(Me.btnLoadCombo, "Reload the combobox from the currently defined reporsitory.")
        Me.btnLoadCombo.UseVisualStyleBackColor = True
        '
        'btnLoadData
        '
        Me.btnLoadData.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.btnLoadData.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnLoadData.ForeColor = System.Drawing.Color.DarkRed
        Me.btnLoadData.Location = New System.Drawing.Point(240, 78)
        Me.btnLoadData.Name = "btnLoadData"
        Me.btnLoadData.Size = New System.Drawing.Size(148, 21)
        Me.btnLoadData.TabIndex = 61
        Me.btnLoadData.Text = "Load Selected Parms"
        Me.TT.SetToolTip(Me.btnLoadData, "Load the stored parameters for the selected definition.")
        Me.btnLoadData.UseVisualStyleBackColor = True
        '
        'txtConnectionID
        '
        Me.txtConnectionID.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtConnectionID.Location = New System.Drawing.Point(15, 448)
        Me.txtConnectionID.Name = "txtConnectionID"
        Me.txtConnectionID.Size = New System.Drawing.Size(375, 20)
        Me.txtConnectionID.TabIndex = 64
        Me.TT.SetToolTip(Me.txtConnectionID, "This only applies to CLOUD installations.")
        '
        'Label1
        '
        Me.Label1.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.ForeColor = System.Drawing.Color.White
        Me.Label1.Location = New System.Drawing.Point(15, 74)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(130, 13)
        Me.Label1.TabIndex = 49
        Me.Label1.Text = "Global Install File Location"
        '
        'mnuLicense
        '
        Me.mnuLicense.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.UtilityToolStripMenuItem, Me.LicenseToolStripMenuItem})
        Me.mnuLicense.Location = New System.Drawing.Point(0, 0)
        Me.mnuLicense.Name = "mnuLicense"
        Me.mnuLicense.Size = New System.Drawing.Size(857, 24)
        Me.mnuLicense.TabIndex = 52
        Me.mnuLicense.Text = "License"
        '
        'UtilityToolStripMenuItem
        '
        Me.UtilityToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.GotoApplicationDirectoryToolStripMenuItem, Me.GotoGlobalDirectoryToolStripMenuItem, Me.LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem})
        Me.UtilityToolStripMenuItem.Name = "UtilityToolStripMenuItem"
        Me.UtilityToolStripMenuItem.Size = New System.Drawing.Size(50, 20)
        Me.UtilityToolStripMenuItem.Text = "Utility"
        '
        'GotoApplicationDirectoryToolStripMenuItem
        '
        Me.GotoApplicationDirectoryToolStripMenuItem.Name = "GotoApplicationDirectoryToolStripMenuItem"
        Me.GotoApplicationDirectoryToolStripMenuItem.Size = New System.Drawing.Size(354, 22)
        Me.GotoApplicationDirectoryToolStripMenuItem.Text = "Goto Application Directory"
        '
        'GotoGlobalDirectoryToolStripMenuItem
        '
        Me.GotoGlobalDirectoryToolStripMenuItem.Name = "GotoGlobalDirectoryToolStripMenuItem"
        Me.GotoGlobalDirectoryToolStripMenuItem.Size = New System.Drawing.Size(354, 22)
        Me.GotoGlobalDirectoryToolStripMenuItem.Text = "Goto Global Directory"
        '
        'LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem
        '
        Me.LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem.Name = "LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem"
        Me.LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem.Size = New System.Drawing.Size(354, 22)
        Me.LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem.Text = "Load Encrypted Connection String into the Clipboard"
        '
        'LicenseToolStripMenuItem
        '
        Me.LicenseToolStripMenuItem.Name = "LicenseToolStripMenuItem"
        Me.LicenseToolStripMenuItem.Size = New System.Drawing.Size(58, 20)
        Me.LicenseToolStripMenuItem.Text = "License"
        Me.LicenseToolStripMenuItem.Visible = False
        '
        'Label2
        '
        Me.Label2.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.ForeColor = System.Drawing.Color.White
        Me.Label2.Location = New System.Drawing.Point(15, 211)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(88, 13)
        Me.Label2.TabIndex = 55
        Me.Label2.Text = "Repository Name"
        '
        'rbRepository
        '
        Me.rbRepository.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.rbRepository.AutoSize = True
        Me.rbRepository.BackColor = System.Drawing.Color.Transparent
        Me.rbRepository.Checked = True
        Me.rbRepository.ForeColor = System.Drawing.Color.White
        Me.rbRepository.Location = New System.Drawing.Point(164, 252)
        Me.rbRepository.Name = "rbRepository"
        Me.rbRepository.Size = New System.Drawing.Size(75, 17)
        Me.rbRepository.TabIndex = 57
        Me.rbRepository.TabStop = True
        Me.rbRepository.Text = "Repository"
        Me.rbRepository.UseVisualStyleBackColor = False
        '
        'rbThesaurus
        '
        Me.rbThesaurus.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.rbThesaurus.AutoSize = True
        Me.rbThesaurus.BackColor = System.Drawing.Color.Transparent
        Me.rbThesaurus.ForeColor = System.Drawing.Color.White
        Me.rbThesaurus.Location = New System.Drawing.Point(245, 252)
        Me.rbThesaurus.Name = "rbThesaurus"
        Me.rbThesaurus.Size = New System.Drawing.Size(75, 17)
        Me.rbThesaurus.TabIndex = 58
        Me.rbThesaurus.Text = "Thesaurus"
        Me.rbThesaurus.UseVisualStyleBackColor = False
        '
        'txtMstr
        '
        Me.txtMstr.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.txtMstr.BackColor = System.Drawing.Color.Black
        Me.txtMstr.Enabled = False
        Me.txtMstr.ForeColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.txtMstr.Location = New System.Drawing.Point(10, 189)
        Me.txtMstr.Name = "txtMstr"
        Me.txtMstr.ReadOnly = True
        Me.txtMstr.Size = New System.Drawing.Size(375, 20)
        Me.txtMstr.TabIndex = 62
        '
        'Panel1
        '
        Me.Panel1.BackColor = System.Drawing.Color.Transparent
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.txtMstr)
        Me.Panel1.Controls.Add(Me.btnLoadData)
        Me.Panel1.Controls.Add(Me.btnLoadCombo)
        Me.Panel1.Controls.Add(Me.Button2)
        Me.Panel1.Controls.Add(Me.Button1)
        Me.Panel1.Controls.Add(Me.btnSaveConn)
        Me.Panel1.Controls.Add(Me.btnTestConnection)
        Me.Panel1.Controls.Add(Me.cbSavedDefinitions)
        Me.Panel1.Controls.Add(Me.Label11)
        Me.Panel1.Controls.Add(Me.btnTestHiveConn)
        Me.Panel1.Controls.Add(Me.btnHiveUpdate)
        Me.Panel1.Controls.Add(Me.ckHive)
        Me.Panel1.Controls.Add(Me.SB)
        Me.Panel1.Location = New System.Drawing.Point(415, 87)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(410, 286)
        Me.Panel1.TabIndex = 63
        '
        'Label3
        '
        Me.Label3.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.ForeColor = System.Drawing.Color.White
        Me.Label3.Location = New System.Drawing.Point(15, 432)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(124, 13)
        Me.Label3.TabIndex = 65
        Me.Label3.Text = "Assigned Connection ID:"
        '
        'frmAppConfigEdit
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.BackgroundImage = Global.WindowsApplication1.My.Resources.Resources.backgroundDarkBlueGradient01
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(857, 480)
        Me.Controls.Add(Me.txtConnectionID)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.btnResetGlobalLocationToDefault)
        Me.Controls.Add(Me.rbThesaurus)
        Me.Controls.Add(Me.rbRepository)
        Me.Controls.Add(Me.txtRepositoryName)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtGlobalFileDirectory)
        Me.Controls.Add(Me.Button7)
        Me.Controls.Add(Me.txtPw2)
        Me.Controls.Add(Me.Label10)
        Me.Controls.Add(Me.txtPw1)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.txtLoginName)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.ckWindowsAuthentication)
        Me.Controls.Add(Me.txtServerInstance)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.txtDBName)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.mnuLicense)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.mnuLicense
        Me.MaximizeBox = False
        Me.Name = "frmAppConfigEdit"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Administrator's Installation Setup"
        Me.mnuLicense.ResumeLayout(False)
        Me.mnuLicense.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents ckHive As System.Windows.Forms.CheckBox
    Friend WithEvents btnHiveUpdate As System.Windows.Forms.Button
    Friend WithEvents btnTestHiveConn As System.Windows.Forms.Button
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents txtDBName As System.Windows.Forms.TextBox
    Friend WithEvents txtServerInstance As System.Windows.Forms.TextBox
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents ckWindowsAuthentication As System.Windows.Forms.CheckBox
    Friend WithEvents txtPw1 As System.Windows.Forms.TextBox
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents txtLoginName As System.Windows.Forms.TextBox
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents txtPw2 As System.Windows.Forms.TextBox
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label11 As System.Windows.Forms.Label
    Friend WithEvents cbSavedDefinitions As System.Windows.Forms.ComboBox
    Friend WithEvents btnTestConnection As System.Windows.Forms.Button
    Friend WithEvents btnSaveConn As System.Windows.Forms.Button
    Friend WithEvents Button7 As System.Windows.Forms.Button
    Friend WithEvents txtGlobalFileDirectory As System.Windows.Forms.TextBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents FolderBrowserDialog1 As System.Windows.Forms.FolderBrowserDialog
    Friend WithEvents mnuLicense As System.Windows.Forms.MenuStrip
    Friend WithEvents UtilityToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents GotoApplicationDirectoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents GotoGlobalDirectoryToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents txtRepositoryName As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents rbRepository As System.Windows.Forms.RadioButton
    Friend WithEvents rbThesaurus As System.Windows.Forms.RadioButton
    Friend WithEvents btnResetGlobalLocationToDefault As System.Windows.Forms.Button
    Friend WithEvents btnLoadCombo As System.Windows.Forms.Button
    Friend WithEvents btnLoadData As System.Windows.Forms.Button
    Friend WithEvents txtMstr As System.Windows.Forms.TextBox
    Friend WithEvents LicenseToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents LoadEncryptedConnectionStringIntoTheClipboardToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents txtConnectionID As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
End Class
