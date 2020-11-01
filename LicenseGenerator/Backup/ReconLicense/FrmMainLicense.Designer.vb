<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmMainLicense
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmMainLicense))
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label5 = New System.Windows.Forms.Label
        Me.Label6 = New System.Windows.Forms.Label
        Me.Label7 = New System.Windows.Forms.Label
        Me.Label8 = New System.Windows.Forms.Label
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.rb180 = New System.Windows.Forms.RadioButton
        Me.rbDemoLicense = New System.Windows.Forms.RadioButton
        Me.rbStdLicense = New System.Windows.Forms.RadioButton
        Me.rbEnterpriseLicense = New System.Windows.Forms.RadioButton
        Me.txtCustName = New System.Windows.Forms.TextBox
        Me.txtCustID = New System.Windows.Forms.TextBox
        Me.txtNbrSeats = New System.Windows.Forms.TextBox
        Me.txtNbrSimlSeats = New System.Windows.Forms.TextBox
        Me.txtCompanyResetID = New System.Windows.Forms.TextBox
        Me.txtMstrPw = New System.Windows.Forms.TextBox
        Me.txtLicenGenDate = New System.Windows.Forms.TextBox
        Me.GroupBox2 = New System.Windows.Forms.GroupBox
        Me.Button2 = New System.Windows.Forms.Button
        Me.txtContactEmail = New System.Windows.Forms.TextBox
        Me.txtContactPhone = New System.Windows.Forms.TextBox
        Me.txtContactName = New System.Windows.Forms.TextBox
        Me.Label11 = New System.Windows.Forms.Label
        Me.Label10 = New System.Windows.Forms.Label
        Me.Label9 = New System.Windows.Forms.Label
        Me.txtCustAddr = New System.Windows.Forms.TextBox
        Me.Label12 = New System.Windows.Forms.Label
        Me.Label13 = New System.Windows.Forms.Label
        Me.Label14 = New System.Windows.Forms.Label
        Me.cbState = New System.Windows.Forms.ComboBox
        Me.txtZip = New System.Windows.Forms.TextBox
        Me.txtCustCountry = New System.Windows.Forms.TextBox
        Me.btnWriteToFile = New System.Windows.Forms.Button
        Me.btnGenerateLicense = New System.Windows.Forms.Button
        Me.txtLicense = New System.Windows.Forms.TextBox
        Me.ckToFile = New System.Windows.Forms.CheckBox
        Me.ckToEmail = New System.Windows.Forms.CheckBox
        Me.dtExpire = New System.Windows.Forms.DateTimePicker
        Me.Label16 = New System.Windows.Forms.Label
        Me.dtMaintExpire = New System.Windows.Forms.DateTimePicker
        Me.SB = New System.Windows.Forms.TextBox
        Me.btnOverwrite = New System.Windows.Forms.Button
        Me.dsRead = New System.Data.DataSet
        Me.btnDecrypt = New System.Windows.Forms.Button
        Me.btnEncrypt = New System.Windows.Forms.Button
        Me.dgLicense = New System.Windows.Forms.DataGridView
        Me.Button1 = New System.Windows.Forms.Button
        Me.ckToClipboard = New System.Windows.Forms.CheckBox
        Me.Label17 = New System.Windows.Forms.Label
        Me.txtVersionNbr = New System.Windows.Forms.TextBox
        Me.txtCity = New System.Windows.Forms.TextBox
        Me.Label18 = New System.Windows.Forms.Label
        Me.btnParse = New System.Windows.Forms.Button
        Me.btnLoadLicenseFile = New System.Windows.Forms.Button
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog
        Me.btnClipboard = New System.Windows.Forms.Button
        Me.btnUploadLicense = New System.Windows.Forms.Button
        Me.Label15 = New System.Windows.Forms.Label
        Me.Label19 = New System.Windows.Forms.Label
        Me.cbLicenseType = New System.Windows.Forms.ComboBox
        Me.btnDelete = New System.Windows.Forms.Button
        Me.Panel1 = New System.Windows.Forms.Panel
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.txtMaxClients = New System.Windows.Forms.TextBox
        Me.txtSharePointNbr = New System.Windows.Forms.TextBox
        Me.txtSSINstance = New System.Windows.Forms.TextBox
        Me.txtServerName = New System.Windows.Forms.TextBox
        Me.btnSync = New System.Windows.Forms.Button
        Me.Label20 = New System.Windows.Forms.Label
        Me.Label21 = New System.Windows.Forms.Label
        Me.Label22 = New System.Windows.Forms.Label
        Me.ckSdk = New System.Windows.Forms.CheckBox
        Me.LicenseBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me._DMA_UD_LicenseDataSet = New ReconLicense._DMA_UD_LicenseDataSet
        Me.LicenseTableAdapter = New ReconLicense._DMA_UD_LicenseDataSetTableAdapters.LicenseTableAdapter
        Me.ckLease = New System.Windows.Forms.CheckBox
        Me.Label23 = New System.Windows.Forms.Label
        Me.Label24 = New System.Windows.Forms.Label
        Me.btnPull = New System.Windows.Forms.Button
        Me.dgRemote = New System.Windows.Forms.DataGridView
        Me.Label25 = New System.Windows.Forms.Label
        Me.Label26 = New System.Windows.Forms.Label
        Me.lblCurrStorageAllotment = New System.Windows.Forms.Label
        Me.TextBox1 = New System.Windows.Forms.TextBox
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        CType(Me.dsRead, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgLicense, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel1.SuspendLayout()
        CType(Me.LicenseBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._DMA_UD_LicenseDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.dgRemote, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(204, 61)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(82, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Customer Name"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(219, 298)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(65, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Customer ID"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(135, 324)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(151, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Lease License Expiration Date"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(158, 376)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(128, 13)
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "Number Seats Purchased"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(172, 402)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(114, 13)
        Me.Label5.TabIndex = 4
        Me.Label5.Text = "Number Users Allowed"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(192, 480)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(96, 13)
        Me.Label6.TabIndex = 5
        Me.Label6.Text = "Company Reset ID"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(200, 506)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(88, 13)
        Me.Label7.TabIndex = 6
        Me.Label7.Text = "Master Password"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(163, 532)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(125, 13)
        Me.Label8.TabIndex = 7
        Me.Label8.Text = "License Generation Date"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.rb180)
        Me.GroupBox1.Controls.Add(Me.rbDemoLicense)
        Me.GroupBox1.Controls.Add(Me.rbStdLicense)
        Me.GroupBox1.Controls.Add(Me.rbEnterpriseLicense)
        Me.GroupBox1.Location = New System.Drawing.Point(132, 552)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(238, 77)
        Me.GroupBox1.TabIndex = 8
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Type License"
        '
        'rb180
        '
        Me.rb180.AutoSize = True
        Me.rb180.Location = New System.Drawing.Point(134, 43)
        Me.rb180.Name = "rb180"
        Me.rb180.Size = New System.Drawing.Size(70, 17)
        Me.rb180.TabIndex = 4
        Me.rb180.Text = "180 Days"
        Me.rb180.UseVisualStyleBackColor = True
        '
        'rbDemoLicense
        '
        Me.rbDemoLicense.AutoSize = True
        Me.rbDemoLicense.Location = New System.Drawing.Point(134, 23)
        Me.rbDemoLicense.Name = "rbDemoLicense"
        Me.rbDemoLicense.Size = New System.Drawing.Size(53, 17)
        Me.rbDemoLicense.TabIndex = 3
        Me.rbDemoLicense.Text = "Demo"
        Me.rbDemoLicense.UseVisualStyleBackColor = True
        '
        'rbStdLicense
        '
        Me.rbStdLicense.AutoSize = True
        Me.rbStdLicense.Checked = True
        Me.rbStdLicense.Location = New System.Drawing.Point(13, 42)
        Me.rbStdLicense.Name = "rbStdLicense"
        Me.rbStdLicense.Size = New System.Drawing.Size(68, 17)
        Me.rbStdLicense.TabIndex = 1
        Me.rbStdLicense.TabStop = True
        Me.rbStdLicense.Text = "Standard"
        Me.rbStdLicense.UseVisualStyleBackColor = True
        '
        'rbEnterpriseLicense
        '
        Me.rbEnterpriseLicense.AutoSize = True
        Me.rbEnterpriseLicense.Location = New System.Drawing.Point(13, 21)
        Me.rbEnterpriseLicense.Name = "rbEnterpriseLicense"
        Me.rbEnterpriseLicense.Size = New System.Drawing.Size(72, 17)
        Me.rbEnterpriseLicense.TabIndex = 0
        Me.rbEnterpriseLicense.Text = "Enterprise"
        Me.rbEnterpriseLicense.UseVisualStyleBackColor = True
        '
        'txtCustName
        '
        Me.txtCustName.Location = New System.Drawing.Point(305, 57)
        Me.txtCustName.Name = "txtCustName"
        Me.txtCustName.Size = New System.Drawing.Size(448, 20)
        Me.txtCustName.TabIndex = 9
        '
        'txtCustID
        '
        Me.txtCustID.Location = New System.Drawing.Point(305, 294)
        Me.txtCustID.Name = "txtCustID"
        Me.txtCustID.Size = New System.Drawing.Size(217, 20)
        Me.txtCustID.TabIndex = 10
        '
        'txtNbrSeats
        '
        Me.txtNbrSeats.Location = New System.Drawing.Point(305, 372)
        Me.txtNbrSeats.Name = "txtNbrSeats"
        Me.txtNbrSeats.Size = New System.Drawing.Size(94, 20)
        Me.txtNbrSeats.TabIndex = 12
        '
        'txtNbrSimlSeats
        '
        Me.txtNbrSimlSeats.Location = New System.Drawing.Point(305, 398)
        Me.txtNbrSimlSeats.Name = "txtNbrSimlSeats"
        Me.txtNbrSimlSeats.Size = New System.Drawing.Size(94, 20)
        Me.txtNbrSimlSeats.TabIndex = 13
        '
        'txtCompanyResetID
        '
        Me.txtCompanyResetID.Location = New System.Drawing.Point(305, 476)
        Me.txtCompanyResetID.Name = "txtCompanyResetID"
        Me.txtCompanyResetID.Size = New System.Drawing.Size(217, 20)
        Me.txtCompanyResetID.TabIndex = 14
        '
        'txtMstrPw
        '
        Me.txtMstrPw.Location = New System.Drawing.Point(305, 502)
        Me.txtMstrPw.Name = "txtMstrPw"
        Me.txtMstrPw.Size = New System.Drawing.Size(217, 20)
        Me.txtMstrPw.TabIndex = 15
        '
        'txtLicenGenDate
        '
        Me.txtLicenGenDate.Location = New System.Drawing.Point(305, 528)
        Me.txtLicenGenDate.Name = "txtLicenGenDate"
        Me.txtLicenGenDate.Size = New System.Drawing.Size(217, 20)
        Me.txtLicenGenDate.TabIndex = 16
        '
        'GroupBox2
        '
        Me.GroupBox2.Controls.Add(Me.Button2)
        Me.GroupBox2.Controls.Add(Me.txtContactEmail)
        Me.GroupBox2.Controls.Add(Me.txtContactPhone)
        Me.GroupBox2.Controls.Add(Me.txtContactName)
        Me.GroupBox2.Controls.Add(Me.Label11)
        Me.GroupBox2.Controls.Add(Me.Label10)
        Me.GroupBox2.Controls.Add(Me.Label9)
        Me.GroupBox2.Location = New System.Drawing.Point(383, 552)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(410, 89)
        Me.GroupBox2.TabIndex = 17
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "Contact Information"
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(351, 21)
        Me.Button2.Margin = New System.Windows.Forms.Padding(2)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(54, 56)
        Me.Button2.TabIndex = 20
        Me.Button2.Text = "Email License"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'txtContactEmail
        '
        Me.txtContactEmail.Location = New System.Drawing.Point(128, 60)
        Me.txtContactEmail.Name = "txtContactEmail"
        Me.txtContactEmail.Size = New System.Drawing.Size(217, 20)
        Me.txtContactEmail.TabIndex = 19
        '
        'txtContactPhone
        '
        Me.txtContactPhone.Location = New System.Drawing.Point(128, 38)
        Me.txtContactPhone.Name = "txtContactPhone"
        Me.txtContactPhone.Size = New System.Drawing.Size(217, 20)
        Me.txtContactPhone.TabIndex = 18
        '
        'txtContactName
        '
        Me.txtContactName.Location = New System.Drawing.Point(128, 16)
        Me.txtContactName.Name = "txtContactName"
        Me.txtContactName.Size = New System.Drawing.Size(217, 20)
        Me.txtContactName.TabIndex = 17
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Location = New System.Drawing.Point(24, 63)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(72, 13)
        Me.Label11.TabIndex = 10
        Me.Label11.Text = "Contact Email"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(24, 41)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(78, 13)
        Me.Label10.TabIndex = 9
        Me.Label10.Text = "Contact Phone"
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(24, 19)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(75, 13)
        Me.Label9.TabIndex = 8
        Me.Label9.Text = "Contact Name"
        '
        'txtCustAddr
        '
        Me.txtCustAddr.Location = New System.Drawing.Point(305, 83)
        Me.txtCustAddr.Multiline = True
        Me.txtCustAddr.Name = "txtCustAddr"
        Me.txtCustAddr.Size = New System.Drawing.Size(448, 49)
        Me.txtCustAddr.TabIndex = 19
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(194, 100)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(92, 13)
        Me.Label12.TabIndex = 18
        Me.Label12.Text = "Customer Address"
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Location = New System.Drawing.Point(209, 168)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(79, 13)
        Me.Label13.TabIndex = 20
        Me.Label13.Text = "State/Province"
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(224, 195)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(64, 13)
        Me.Label14.TabIndex = 21
        Me.Label14.Text = "Postal Code"
        '
        'cbState
        '
        Me.cbState.FormattingEnabled = True
        Me.cbState.Location = New System.Drawing.Point(305, 164)
        Me.cbState.Name = "cbState"
        Me.cbState.Size = New System.Drawing.Size(115, 21)
        Me.cbState.TabIndex = 22
        '
        'txtZip
        '
        Me.txtZip.Location = New System.Drawing.Point(305, 191)
        Me.txtZip.Name = "txtZip"
        Me.txtZip.Size = New System.Drawing.Size(144, 20)
        Me.txtZip.TabIndex = 23
        '
        'txtCustCountry
        '
        Me.txtCustCountry.Location = New System.Drawing.Point(305, 215)
        Me.txtCustCountry.Name = "txtCustCountry"
        Me.txtCustCountry.Size = New System.Drawing.Size(255, 20)
        Me.txtCustCountry.TabIndex = 25
        '
        'btnWriteToFile
        '
        Me.btnWriteToFile.Location = New System.Drawing.Point(10, 186)
        Me.btnWriteToFile.Name = "btnWriteToFile"
        Me.btnWriteToFile.Size = New System.Drawing.Size(128, 48)
        Me.btnWriteToFile.TabIndex = 26
        Me.btnWriteToFile.Text = "Write License To File"
        Me.btnWriteToFile.UseVisualStyleBackColor = True
        '
        'btnGenerateLicense
        '
        Me.btnGenerateLicense.BackColor = System.Drawing.Color.PaleGreen
        Me.btnGenerateLicense.Location = New System.Drawing.Point(10, 12)
        Me.btnGenerateLicense.Name = "btnGenerateLicense"
        Me.btnGenerateLicense.Size = New System.Drawing.Size(128, 48)
        Me.btnGenerateLicense.TabIndex = 27
        Me.btnGenerateLicense.Text = "Generate License"
        Me.btnGenerateLicense.UseVisualStyleBackColor = False
        '
        'txtLicense
        '
        Me.txtLicense.Enabled = False
        Me.txtLicense.Location = New System.Drawing.Point(17, 648)
        Me.txtLicense.Multiline = True
        Me.txtLicense.Name = "txtLicense"
        Me.txtLicense.Size = New System.Drawing.Size(1071, 52)
        Me.txtLicense.TabIndex = 28
        '
        'ckToFile
        '
        Me.ckToFile.AutoSize = True
        Me.ckToFile.Checked = True
        Me.ckToFile.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckToFile.Location = New System.Drawing.Point(10, 240)
        Me.ckToFile.Name = "ckToFile"
        Me.ckToFile.Size = New System.Drawing.Size(58, 17)
        Me.ckToFile.TabIndex = 30
        Me.ckToFile.Text = "To File"
        Me.ckToFile.UseVisualStyleBackColor = True
        Me.ckToFile.Visible = False
        '
        'ckToEmail
        '
        Me.ckToEmail.AutoSize = True
        Me.ckToEmail.Location = New System.Drawing.Point(10, 262)
        Me.ckToEmail.Name = "ckToEmail"
        Me.ckToEmail.Size = New System.Drawing.Size(107, 17)
        Me.ckToEmail.TabIndex = 31
        Me.ckToEmail.Text = "To Contact Email"
        Me.ckToEmail.UseVisualStyleBackColor = True
        Me.ckToEmail.Visible = False
        '
        'dtExpire
        '
        Me.dtExpire.Location = New System.Drawing.Point(305, 320)
        Me.dtExpire.Name = "dtExpire"
        Me.dtExpire.Size = New System.Drawing.Size(217, 20)
        Me.dtExpire.TabIndex = 32
        Me.TT.SetToolTip(Me.dtExpire, "Check the Lease Option to enable.")
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.Location = New System.Drawing.Point(142, 350)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(144, 13)
        Me.Label16.TabIndex = 33
        Me.Label16.Text = "Maintenance Expiration Date"
        '
        'dtMaintExpire
        '
        Me.dtMaintExpire.Location = New System.Drawing.Point(305, 346)
        Me.dtMaintExpire.Name = "dtMaintExpire"
        Me.dtMaintExpire.Size = New System.Drawing.Size(217, 20)
        Me.dtMaintExpire.TabIndex = 34
        '
        'SB
        '
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(17, 706)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(1072, 20)
        Me.SB.TabIndex = 35
        '
        'btnOverwrite
        '
        Me.btnOverwrite.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.btnOverwrite.Location = New System.Drawing.Point(10, 72)
        Me.btnOverwrite.Name = "btnOverwrite"
        Me.btnOverwrite.Size = New System.Drawing.Size(128, 48)
        Me.btnOverwrite.TabIndex = 36
        Me.btnOverwrite.Text = "Update License"
        Me.btnOverwrite.UseVisualStyleBackColor = False
        '
        'dsRead
        '
        Me.dsRead.DataSetName = "MasterDS"
        '
        'btnDecrypt
        '
        Me.btnDecrypt.Location = New System.Drawing.Point(982, 606)
        Me.btnDecrypt.Name = "btnDecrypt"
        Me.btnDecrypt.Size = New System.Drawing.Size(83, 33)
        Me.btnDecrypt.TabIndex = 37
        Me.btnDecrypt.Text = "Decrypt"
        Me.btnDecrypt.UseVisualStyleBackColor = True
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Location = New System.Drawing.Point(813, 606)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(83, 33)
        Me.btnEncrypt.TabIndex = 38
        Me.btnEncrypt.Text = "Encrypt"
        Me.btnEncrypt.UseVisualStyleBackColor = True
        '
        'dgLicense
        '
        Me.dgLicense.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgLicense.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells
        Me.dgLicense.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgLicense.Location = New System.Drawing.Point(813, 66)
        Me.dgLicense.Name = "dgLicense"
        Me.dgLicense.RowTemplate.Height = 24
        Me.dgLicense.Size = New System.Drawing.Size(252, 505)
        Me.dgLicense.TabIndex = 39
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(7, 178)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(128, 35)
        Me.Button1.TabIndex = 40
        Me.Button1.Text = "Init"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'ckToClipboard
        '
        Me.ckToClipboard.AutoSize = True
        Me.ckToClipboard.Location = New System.Drawing.Point(10, 284)
        Me.ckToClipboard.Name = "ckToClipboard"
        Me.ckToClipboard.Size = New System.Drawing.Size(138, 17)
        Me.ckToClipboard.TabIndex = 41
        Me.ckToClipboard.Text = "Place Copy in Clipboard"
        Me.ckToClipboard.UseVisualStyleBackColor = True
        Me.ckToClipboard.Visible = False
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Location = New System.Drawing.Point(166, 245)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(122, 13)
        Me.Label17.TabIndex = 42
        Me.Label17.Text = "License Version Number"
        '
        'txtVersionNbr
        '
        Me.txtVersionNbr.Location = New System.Drawing.Point(305, 241)
        Me.txtVersionNbr.Name = "txtVersionNbr"
        Me.txtVersionNbr.Size = New System.Drawing.Size(40, 20)
        Me.txtVersionNbr.TabIndex = 43
        '
        'txtCity
        '
        Me.txtCity.Location = New System.Drawing.Point(305, 138)
        Me.txtCity.Name = "txtCity"
        Me.txtCity.Size = New System.Drawing.Size(279, 20)
        Me.txtCity.TabIndex = 44
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.Location = New System.Drawing.Point(264, 140)
        Me.Label18.Name = "Label18"
        Me.Label18.Size = New System.Drawing.Size(24, 13)
        Me.Label18.TabIndex = 45
        Me.Label18.Text = "City"
        '
        'btnParse
        '
        Me.btnParse.Location = New System.Drawing.Point(947, 12)
        Me.btnParse.Name = "btnParse"
        Me.btnParse.Size = New System.Drawing.Size(118, 48)
        Me.btnParse.TabIndex = 46
        Me.btnParse.Text = "Parse License"
        Me.btnParse.UseVisualStyleBackColor = True
        '
        'btnLoadLicenseFile
        '
        Me.btnLoadLicenseFile.Location = New System.Drawing.Point(7, 353)
        Me.btnLoadLicenseFile.Name = "btnLoadLicenseFile"
        Me.btnLoadLicenseFile.Size = New System.Drawing.Size(128, 48)
        Me.btnLoadLicenseFile.TabIndex = 47
        Me.btnLoadLicenseFile.Text = "Load License From File"
        Me.btnLoadLicenseFile.UseVisualStyleBackColor = True
        Me.btnLoadLicenseFile.Visible = False
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'btnClipboard
        '
        Me.btnClipboard.Location = New System.Drawing.Point(813, 12)
        Me.btnClipboard.Name = "btnClipboard"
        Me.btnClipboard.Size = New System.Drawing.Size(128, 48)
        Me.btnClipboard.TabIndex = 49
        Me.btnClipboard.Text = "Clipboard Current License"
        Me.btnClipboard.UseVisualStyleBackColor = True
        '
        'btnUploadLicense
        '
        Me.btnUploadLicense.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.btnUploadLicense.Location = New System.Drawing.Point(10, 131)
        Me.btnUploadLicense.Name = "btnUploadLicense"
        Me.btnUploadLicense.Size = New System.Drawing.Size(128, 48)
        Me.btnUploadLicense.TabIndex = 50
        Me.btnUploadLicense.Text = "Upload License to Server"
        Me.btnUploadLicense.UseVisualStyleBackColor = False
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(245, 219)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(43, 13)
        Me.Label15.TabIndex = 24
        Me.Label15.Text = "Country"
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.Location = New System.Drawing.Point(200, 271)
        Me.Label19.Name = "Label19"
        Me.Label19.Size = New System.Drawing.Size(74, 13)
        Me.Label19.TabIndex = 52
        Me.Label19.Text = "Type License:"
        '
        'cbLicenseType
        '
        Me.cbLicenseType.FormattingEnabled = True
        Me.cbLicenseType.Items.AddRange(New Object() {"Roaming", "Seat", "User", "Client", "SQLExpress", "SDK"})
        Me.cbLicenseType.Location = New System.Drawing.Point(305, 267)
        Me.cbLicenseType.Name = "cbLicenseType"
        Me.cbLicenseType.Size = New System.Drawing.Size(126, 21)
        Me.cbLicenseType.TabIndex = 53
        '
        'btnDelete
        '
        Me.btnDelete.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(128, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.btnDelete.Location = New System.Drawing.Point(10, 309)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(125, 42)
        Me.btnDelete.TabIndex = 54
        Me.btnDelete.Text = "Delete License"
        Me.TT.SetToolTip(Me.btnDelete, "Remove file from local server as well as the remote server.")
        Me.btnDelete.UseVisualStyleBackColor = False
        '
        'Panel1
        '
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.btnGenerateLicense)
        Me.Panel1.Controls.Add(Me.btnDelete)
        Me.Panel1.Controls.Add(Me.btnWriteToFile)
        Me.Panel1.Controls.Add(Me.ckToFile)
        Me.Panel1.Controls.Add(Me.ckToEmail)
        Me.Panel1.Controls.Add(Me.btnUploadLicense)
        Me.Panel1.Controls.Add(Me.btnOverwrite)
        Me.Panel1.Controls.Add(Me.ckToClipboard)
        Me.Panel1.Location = New System.Drawing.Point(597, 140)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(156, 368)
        Me.Panel1.TabIndex = 55
        '
        'txtMaxClients
        '
        Me.txtMaxClients.Location = New System.Drawing.Point(305, 424)
        Me.txtMaxClients.Name = "txtMaxClients"
        Me.txtMaxClients.Size = New System.Drawing.Size(94, 20)
        Me.txtMaxClients.TabIndex = 62
        Me.txtMaxClients.Text = "0"
        Me.TT.SetToolTip(Me.txtMaxClients, "A zero in this field sets the number of allowed to be equal to the number of seat" & _
                "s purchased. ")
        '
        'txtSharePointNbr
        '
        Me.txtSharePointNbr.Location = New System.Drawing.Point(305, 450)
        Me.txtSharePointNbr.Name = "txtSharePointNbr"
        Me.txtSharePointNbr.Size = New System.Drawing.Size(94, 20)
        Me.txtSharePointNbr.TabIndex = 63
        Me.txtSharePointNbr.Text = "0"
        Me.TT.SetToolTip(Me.txtSharePointNbr, "A zero in this field sets the number of allowed to be equal to the number of seat" & _
                "s purchased. ")
        '
        'txtSSINstance
        '
        Me.txtSSINstance.BackColor = System.Drawing.Color.Red
        Me.txtSSINstance.ForeColor = System.Drawing.SystemColors.Info
        Me.txtSSINstance.Location = New System.Drawing.Point(305, 32)
        Me.txtSSINstance.Name = "txtSSINstance"
        Me.txtSSINstance.Size = New System.Drawing.Size(255, 20)
        Me.txtSSINstance.TabIndex = 68
        Me.TT.SetToolTip(Me.txtSSINstance, "Enter the name of the SQL SERVER Instance that will house this repository.")
        '
        'txtServerName
        '
        Me.txtServerName.BackColor = System.Drawing.Color.Red
        Me.txtServerName.ForeColor = System.Drawing.SystemColors.Info
        Me.txtServerName.Location = New System.Drawing.Point(305, 8)
        Me.txtServerName.Name = "txtServerName"
        Me.txtServerName.Size = New System.Drawing.Size(255, 20)
        Me.txtServerName.TabIndex = 70
        Me.TT.SetToolTip(Me.txtServerName, "Enter the name of the SERVER where this repository will reside.")
        '
        'btnSync
        '
        Me.btnSync.Location = New System.Drawing.Point(16, 521)
        Me.btnSync.Name = "btnSync"
        Me.btnSync.Size = New System.Drawing.Size(83, 56)
        Me.btnSync.TabIndex = 71
        Me.btnSync.Text = "Sync Licenses"
        Me.TT.SetToolTip(Me.btnSync, "Add licenses not found on both machines.")
        Me.btnSync.UseVisualStyleBackColor = True
        '
        'Label20
        '
        Me.Label20.AutoSize = True
        Me.Label20.Font = New System.Drawing.Font("Monotype Corsiva", 36.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label20.Location = New System.Drawing.Point(12, 26)
        Me.Label20.Name = "Label20"
        Me.Label20.Size = New System.Drawing.Size(123, 57)
        Me.Label20.TabIndex = 56
        Me.Label20.Text = "ECM"
        '
        'Label21
        '
        Me.Label21.AutoSize = True
        Me.Label21.Font = New System.Drawing.Font("Arial", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label21.Location = New System.Drawing.Point(1, 83)
        Me.Label21.Name = "Label21"
        Me.Label21.Size = New System.Drawing.Size(144, 41)
        Me.Label21.TabIndex = 57
        Me.Label21.Text = "License"
        '
        'Label22
        '
        Me.Label22.AutoSize = True
        Me.Label22.Font = New System.Drawing.Font("Arial", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label22.Location = New System.Drawing.Point(10, 125)
        Me.Label22.Name = "Label22"
        Me.Label22.Size = New System.Drawing.Size(126, 41)
        Me.Label22.TabIndex = 58
        Me.Label22.Text = "Server"
        '
        'ckSdk
        '
        Me.ckSdk.AutoSize = True
        Me.ckSdk.Location = New System.Drawing.Point(458, 249)
        Me.ckSdk.Name = "ckSdk"
        Me.ckSdk.Size = New System.Drawing.Size(102, 17)
        Me.ckSdk.TabIndex = 59
        Me.ckSdk.Text = "SDK Purchased"
        Me.ckSdk.UseVisualStyleBackColor = True
        '
        'LicenseBindingSource
        '
        Me.LicenseBindingSource.DataMember = "License"
        Me.LicenseBindingSource.DataSource = Me._DMA_UD_LicenseDataSet
        '
        '_DMA_UD_LicenseDataSet
        '
        Me._DMA_UD_LicenseDataSet.DataSetName = "_DMA_UD_LicenseDataSet"
        Me._DMA_UD_LicenseDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'LicenseTableAdapter
        '
        Me.LicenseTableAdapter.ClearBeforeFill = True
        '
        'ckLease
        '
        Me.ckLease.AutoSize = True
        Me.ckLease.Location = New System.Drawing.Point(458, 271)
        Me.ckLease.Name = "ckLease"
        Me.ckLease.Size = New System.Drawing.Size(89, 17)
        Me.ckLease.TabIndex = 60
        Me.ckLease.Text = "Lease Option"
        Me.ckLease.UseVisualStyleBackColor = True
        '
        'Label23
        '
        Me.Label23.AutoSize = True
        Me.Label23.Location = New System.Drawing.Point(185, 428)
        Me.Label23.Name = "Label23"
        Me.Label23.Size = New System.Drawing.Size(103, 13)
        Me.Label23.TabIndex = 61
        Me.Label23.Text = "Max Clients Installed"
        '
        'Label24
        '
        Me.Label24.AutoSize = True
        Me.Label24.Location = New System.Drawing.Point(185, 454)
        Me.Label24.Name = "Label24"
        Me.Label24.Size = New System.Drawing.Size(107, 13)
        Me.Label24.TabIndex = 64
        Me.Label24.Text = "Max SharePoint DB's"
        '
        'btnPull
        '
        Me.btnPull.Location = New System.Drawing.Point(17, 583)
        Me.btnPull.Name = "btnPull"
        Me.btnPull.Size = New System.Drawing.Size(83, 56)
        Me.btnPull.TabIndex = 65
        Me.btnPull.Text = "Pull Missing Licenses"
        Me.btnPull.UseVisualStyleBackColor = True
        '
        'dgRemote
        '
        Me.dgRemote.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgRemote.Location = New System.Drawing.Point(12, 231)
        Me.dgRemote.Name = "dgRemote"
        Me.dgRemote.RowTemplate.Height = 24
        Me.dgRemote.Size = New System.Drawing.Size(123, 111)
        Me.dgRemote.TabIndex = 66
        '
        'Label25
        '
        Me.Label25.AutoSize = True
        Me.Label25.Location = New System.Drawing.Point(151, 37)
        Me.Label25.Name = "Label25"
        Me.Label25.Size = New System.Drawing.Size(137, 13)
        Me.Label25.TabIndex = 67
        Me.Label25.Text = "SQL Server Instance Name"
        '
        'Label26
        '
        Me.Label26.AutoSize = True
        Me.Label26.Location = New System.Drawing.Point(218, 12)
        Me.Label26.Name = "Label26"
        Me.Label26.Size = New System.Drawing.Size(69, 13)
        Me.Label26.TabIndex = 69
        Me.Label26.Text = "Server Name"
        '
        'lblCurrStorageAllotment
        '
        Me.lblCurrStorageAllotment.AutoSize = True
        Me.lblCurrStorageAllotment.Location = New System.Drawing.Point(584, 12)
        Me.lblCurrStorageAllotment.Name = "lblCurrStorageAllotment"
        Me.lblCurrStorageAllotment.Size = New System.Drawing.Size(107, 13)
        Me.lblCurrStorageAllotment.TabIndex = 72
        Me.lblCurrStorageAllotment.Text = "Storage Allotment TB"
        '
        'TextBox1
        '
        Me.TextBox1.BackColor = System.Drawing.Color.MediumSpringGreen
        Me.TextBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TextBox1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TextBox1.Location = New System.Drawing.Point(584, 32)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(107, 20)
        Me.TextBox1.TabIndex = 73
        Me.TextBox1.Text = ".5"
        Me.TT.SetToolTip(Me.TextBox1, "Enter the name of the SQL SERVER Instance that will house this repository.")
        '
        'FrmMainLicense
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.Silver
        Me.ClientSize = New System.Drawing.Size(1077, 710)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.lblCurrStorageAllotment)
        Me.Controls.Add(Me.btnSync)
        Me.Controls.Add(Me.txtServerName)
        Me.Controls.Add(Me.Label26)
        Me.Controls.Add(Me.txtSSINstance)
        Me.Controls.Add(Me.Label25)
        Me.Controls.Add(Me.dgRemote)
        Me.Controls.Add(Me.btnPull)
        Me.Controls.Add(Me.Label24)
        Me.Controls.Add(Me.txtSharePointNbr)
        Me.Controls.Add(Me.txtMaxClients)
        Me.Controls.Add(Me.Label23)
        Me.Controls.Add(Me.ckLease)
        Me.Controls.Add(Me.ckSdk)
        Me.Controls.Add(Me.Label22)
        Me.Controls.Add(Me.Label21)
        Me.Controls.Add(Me.Label20)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.cbLicenseType)
        Me.Controls.Add(Me.Label19)
        Me.Controls.Add(Me.btnClipboard)
        Me.Controls.Add(Me.btnLoadLicenseFile)
        Me.Controls.Add(Me.btnParse)
        Me.Controls.Add(Me.Label18)
        Me.Controls.Add(Me.txtCity)
        Me.Controls.Add(Me.txtVersionNbr)
        Me.Controls.Add(Me.Label17)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.dgLicense)
        Me.Controls.Add(Me.btnEncrypt)
        Me.Controls.Add(Me.btnDecrypt)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.dtMaintExpire)
        Me.Controls.Add(Me.Label16)
        Me.Controls.Add(Me.dtExpire)
        Me.Controls.Add(Me.txtLicense)
        Me.Controls.Add(Me.txtCustCountry)
        Me.Controls.Add(Me.Label15)
        Me.Controls.Add(Me.txtZip)
        Me.Controls.Add(Me.cbState)
        Me.Controls.Add(Me.Label14)
        Me.Controls.Add(Me.Label13)
        Me.Controls.Add(Me.txtCustAddr)
        Me.Controls.Add(Me.Label12)
        Me.Controls.Add(Me.GroupBox2)
        Me.Controls.Add(Me.txtLicenGenDate)
        Me.Controls.Add(Me.txtMstrPw)
        Me.Controls.Add(Me.txtCompanyResetID)
        Me.Controls.Add(Me.txtNbrSimlSeats)
        Me.Controls.Add(Me.txtNbrSeats)
        Me.Controls.Add(Me.txtCustID)
        Me.Controls.Add(Me.txtCustName)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "FrmMainLicense"
        Me.Text = "License Generator"
        Me.TT.SetToolTip(Me, "Clear the Screen.")
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        CType(Me.dsRead, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgLicense, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        CType(Me.LicenseBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._DMA_UD_LicenseDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.dgRemote, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents rbStdLicense As System.Windows.Forms.RadioButton
    Friend WithEvents rbEnterpriseLicense As System.Windows.Forms.RadioButton
    Friend WithEvents rbDemoLicense As System.Windows.Forms.RadioButton
    Friend WithEvents txtCustName As System.Windows.Forms.TextBox
    Friend WithEvents txtCustID As System.Windows.Forms.TextBox
    Friend WithEvents txtNbrSeats As System.Windows.Forms.TextBox
    Friend WithEvents txtNbrSimlSeats As System.Windows.Forms.TextBox
    Friend WithEvents txtCompanyResetID As System.Windows.Forms.TextBox
    Friend WithEvents txtMstrPw As System.Windows.Forms.TextBox
    Friend WithEvents txtLicenGenDate As System.Windows.Forms.TextBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents txtContactEmail As System.Windows.Forms.TextBox
    Friend WithEvents txtContactPhone As System.Windows.Forms.TextBox
    Friend WithEvents txtContactName As System.Windows.Forms.TextBox
    Friend WithEvents Label11 As System.Windows.Forms.Label
    Friend WithEvents txtCustAddr As System.Windows.Forms.TextBox
    Friend WithEvents Label12 As System.Windows.Forms.Label
    Friend WithEvents Label13 As System.Windows.Forms.Label
    Friend WithEvents Label14 As System.Windows.Forms.Label
    Friend WithEvents cbState As System.Windows.Forms.ComboBox
    Friend WithEvents txtZip As System.Windows.Forms.TextBox
    Friend WithEvents txtCustCountry As System.Windows.Forms.TextBox
    Friend WithEvents btnWriteToFile As System.Windows.Forms.Button
    Friend WithEvents btnGenerateLicense As System.Windows.Forms.Button
    Friend WithEvents txtLicense As System.Windows.Forms.TextBox
    Friend WithEvents ckToFile As System.Windows.Forms.CheckBox
    Friend WithEvents ckToEmail As System.Windows.Forms.CheckBox
    Friend WithEvents dtExpire As System.Windows.Forms.DateTimePicker
    Friend WithEvents Label16 As System.Windows.Forms.Label
    Friend WithEvents dtMaintExpire As System.Windows.Forms.DateTimePicker
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents btnOverwrite As System.Windows.Forms.Button
    Friend WithEvents dsRead As System.Data.DataSet
    Friend WithEvents _DMA_UD_LicenseDataSet As ReconLicense._DMA_UD_LicenseDataSet
    Friend WithEvents LicenseBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents LicenseTableAdapter As ReconLicense._DMA_UD_LicenseDataSetTableAdapters.LicenseTableAdapter
    Friend WithEvents btnDecrypt As System.Windows.Forms.Button
    Friend WithEvents btnEncrypt As System.Windows.Forms.Button
    Friend WithEvents dgLicense As System.Windows.Forms.DataGridView
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents ckToClipboard As System.Windows.Forms.CheckBox
    Friend WithEvents Label17 As System.Windows.Forms.Label
    Friend WithEvents txtVersionNbr As System.Windows.Forms.TextBox
    Friend WithEvents txtCity As System.Windows.Forms.TextBox
    Friend WithEvents Label18 As System.Windows.Forms.Label
    Friend WithEvents btnParse As System.Windows.Forms.Button
    Friend WithEvents btnLoadLicenseFile As System.Windows.Forms.Button
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents btnClipboard As System.Windows.Forms.Button
    Friend WithEvents btnUploadLicense As System.Windows.Forms.Button
    Friend WithEvents Label15 As System.Windows.Forms.Label
    Friend WithEvents Label19 As System.Windows.Forms.Label
    Friend WithEvents cbLicenseType As System.Windows.Forms.ComboBox
    Friend WithEvents btnDelete As System.Windows.Forms.Button
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Label20 As System.Windows.Forms.Label
    Friend WithEvents Label21 As System.Windows.Forms.Label
    Friend WithEvents Label22 As System.Windows.Forms.Label
    Friend WithEvents ckSdk As System.Windows.Forms.CheckBox
    Friend WithEvents ckLease As System.Windows.Forms.CheckBox
    Friend WithEvents txtMaxClients As System.Windows.Forms.TextBox
    Friend WithEvents txtSharePointNbr As System.Windows.Forms.TextBox
    Friend WithEvents Label23 As System.Windows.Forms.Label
    Friend WithEvents Label24 As System.Windows.Forms.Label
    Friend WithEvents btnPull As System.Windows.Forms.Button
    Friend WithEvents dgRemote As System.Windows.Forms.DataGridView
    Friend WithEvents rb180 As System.Windows.Forms.RadioButton
    Friend WithEvents txtSSINstance As System.Windows.Forms.TextBox
    Friend WithEvents Label25 As System.Windows.Forms.Label
    Friend WithEvents txtServerName As System.Windows.Forms.TextBox
    Friend WithEvents Label26 As System.Windows.Forms.Label
    Friend WithEvents btnSync As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents lblCurrStorageAllotment As System.Windows.Forms.Label
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox

End Class
