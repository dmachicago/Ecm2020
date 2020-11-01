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
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FrmMainLicense))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.rb180 = New System.Windows.Forms.RadioButton()
        Me.rbDemoLicense = New System.Windows.Forms.RadioButton()
        Me.rbStdLicense = New System.Windows.Forms.RadioButton()
        Me.rbEnterpriseLicense = New System.Windows.Forms.RadioButton()
        Me.txtCustName = New System.Windows.Forms.TextBox()
        Me.txtCustID = New System.Windows.Forms.TextBox()
        Me.txtNbrSeats = New System.Windows.Forms.TextBox()
        Me.txtNbrSimlSeats = New System.Windows.Forms.TextBox()
        Me.txtCompanyResetID = New System.Windows.Forms.TextBox()
        Me.txtMstrPw = New System.Windows.Forms.TextBox()
        Me.txtLicenGenDate = New System.Windows.Forms.TextBox()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.txtContactEmail = New System.Windows.Forms.TextBox()
        Me.txtContactPhone = New System.Windows.Forms.TextBox()
        Me.txtContactName = New System.Windows.Forms.TextBox()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.txtCustAddr = New System.Windows.Forms.TextBox()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.Label14 = New System.Windows.Forms.Label()
        Me.cbState = New System.Windows.Forms.ComboBox()
        Me.txtZip = New System.Windows.Forms.TextBox()
        Me.txtCustCountry = New System.Windows.Forms.TextBox()
        Me.btnWriteToFile = New System.Windows.Forms.Button()
        Me.btnGenerateLicense = New System.Windows.Forms.Button()
        Me.txtLicense = New System.Windows.Forms.TextBox()
        Me.ckToFile = New System.Windows.Forms.CheckBox()
        Me.ckToEmail = New System.Windows.Forms.CheckBox()
        Me.dtExpire = New System.Windows.Forms.DateTimePicker()
        Me.Label16 = New System.Windows.Forms.Label()
        Me.dtMaintExpire = New System.Windows.Forms.DateTimePicker()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.btnOverwrite = New System.Windows.Forms.Button()
        Me.dsRead = New System.Data.DataSet()
        Me.btnDecrypt = New System.Windows.Forms.Button()
        Me.btnEncrypt = New System.Windows.Forms.Button()
        Me.dgLicense = New System.Windows.Forms.DataGridView()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.ckToClipboard = New System.Windows.Forms.CheckBox()
        Me.Label17 = New System.Windows.Forms.Label()
        Me.txtVersionNbr = New System.Windows.Forms.TextBox()
        Me.txtCity = New System.Windows.Forms.TextBox()
        Me.Label18 = New System.Windows.Forms.Label()
        Me.btnParse = New System.Windows.Forms.Button()
        Me.btnLoadLicenseFile = New System.Windows.Forms.Button()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.btnClipboard = New System.Windows.Forms.Button()
        Me.btnUploadLicense = New System.Windows.Forms.Button()
        Me.Label15 = New System.Windows.Forms.Label()
        Me.Label19 = New System.Windows.Forms.Label()
        Me.cbLicenseType = New System.Windows.Forms.ComboBox()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.btnGenInsertSQL = New System.Windows.Forms.Button()
        Me.btnGenUpdtSQL = New System.Windows.Forms.Button()
        Me.CheckBox1 = New System.Windows.Forms.CheckBox()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.txtMaxClients = New System.Windows.Forms.TextBox()
        Me.txtSharePointNbr = New System.Windows.Forms.TextBox()
        Me.txtSSINstance = New System.Windows.Forms.TextBox()
        Me.txtServerName = New System.Windows.Forms.TextBox()
        Me.btnSync = New System.Windows.Forms.Button()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Label20 = New System.Windows.Forms.Label()
        Me.Label21 = New System.Windows.Forms.Label()
        Me.Label22 = New System.Windows.Forms.Label()
        Me.ckSdk = New System.Windows.Forms.CheckBox()
        Me.LicenseBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me._DMA_UD_LicenseDataSet = New ReconLicense._DMA_UD_LicenseDataSet()
        Me.LicenseTableAdapter = New ReconLicense._DMA_UD_LicenseDataSetTableAdapters.LicenseTableAdapter()
        Me.ckLease = New System.Windows.Forms.CheckBox()
        Me.Label23 = New System.Windows.Forms.Label()
        Me.Label24 = New System.Windows.Forms.Label()
        Me.btnPull = New System.Windows.Forms.Button()
        Me.dgRemote = New System.Windows.Forms.DataGridView()
        Me.Label25 = New System.Windows.Forms.Label()
        Me.Label26 = New System.Windows.Forms.Label()
        Me.lblCurrStorageAllotment = New System.Windows.Forms.Label()
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
        Me.Label1.Location = New System.Drawing.Point(272, 75)
        Me.Label1.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(109, 17)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Customer Name"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(292, 367)
        Me.Label2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(85, 17)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Customer ID"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(180, 399)
        Me.Label3.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(200, 17)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Lease License Expiration Date"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(211, 463)
        Me.Label4.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(170, 17)
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "Number Seats Purchased"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(229, 495)
        Me.Label5.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(151, 17)
        Me.Label5.TabIndex = 4
        Me.Label5.Text = "Number Users Allowed"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(256, 591)
        Me.Label6.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(125, 17)
        Me.Label6.TabIndex = 5
        Me.Label6.Text = "Company Reset ID"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(267, 623)
        Me.Label7.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(116, 17)
        Me.Label7.TabIndex = 6
        Me.Label7.Text = "Master Password"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(217, 655)
        Me.Label8.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(166, 17)
        Me.Label8.TabIndex = 7
        Me.Label8.Text = "License Generation Date"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.rb180)
        Me.GroupBox1.Controls.Add(Me.rbDemoLicense)
        Me.GroupBox1.Controls.Add(Me.rbStdLicense)
        Me.GroupBox1.Controls.Add(Me.rbEnterpriseLicense)
        Me.GroupBox1.Location = New System.Drawing.Point(176, 679)
        Me.GroupBox1.Margin = New System.Windows.Forms.Padding(4)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Padding = New System.Windows.Forms.Padding(4)
        Me.GroupBox1.Size = New System.Drawing.Size(317, 95)
        Me.GroupBox1.TabIndex = 8
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Type License"
        '
        'rb180
        '
        Me.rb180.AutoSize = True
        Me.rb180.Location = New System.Drawing.Point(179, 53)
        Me.rb180.Margin = New System.Windows.Forms.Padding(4)
        Me.rb180.Name = "rb180"
        Me.rb180.Size = New System.Drawing.Size(89, 21)
        Me.rb180.TabIndex = 4
        Me.rb180.Text = "180 Days"
        Me.rb180.UseVisualStyleBackColor = True
        '
        'rbDemoLicense
        '
        Me.rbDemoLicense.AutoSize = True
        Me.rbDemoLicense.Location = New System.Drawing.Point(179, 28)
        Me.rbDemoLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.rbDemoLicense.Name = "rbDemoLicense"
        Me.rbDemoLicense.Size = New System.Drawing.Size(66, 21)
        Me.rbDemoLicense.TabIndex = 3
        Me.rbDemoLicense.Text = "Demo"
        Me.rbDemoLicense.UseVisualStyleBackColor = True
        '
        'rbStdLicense
        '
        Me.rbStdLicense.AutoSize = True
        Me.rbStdLicense.Checked = True
        Me.rbStdLicense.Location = New System.Drawing.Point(17, 52)
        Me.rbStdLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.rbStdLicense.Name = "rbStdLicense"
        Me.rbStdLicense.Size = New System.Drawing.Size(87, 21)
        Me.rbStdLicense.TabIndex = 1
        Me.rbStdLicense.TabStop = True
        Me.rbStdLicense.Text = "Standard"
        Me.rbStdLicense.UseVisualStyleBackColor = True
        '
        'rbEnterpriseLicense
        '
        Me.rbEnterpriseLicense.AutoSize = True
        Me.rbEnterpriseLicense.Location = New System.Drawing.Point(17, 26)
        Me.rbEnterpriseLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.rbEnterpriseLicense.Name = "rbEnterpriseLicense"
        Me.rbEnterpriseLicense.Size = New System.Drawing.Size(94, 21)
        Me.rbEnterpriseLicense.TabIndex = 0
        Me.rbEnterpriseLicense.Text = "Enterprise"
        Me.rbEnterpriseLicense.UseVisualStyleBackColor = True
        '
        'txtCustName
        '
        Me.txtCustName.Location = New System.Drawing.Point(407, 70)
        Me.txtCustName.Margin = New System.Windows.Forms.Padding(4)
        Me.txtCustName.Name = "txtCustName"
        Me.txtCustName.Size = New System.Drawing.Size(596, 22)
        Me.txtCustName.TabIndex = 9
        '
        'txtCustID
        '
        Me.txtCustID.Location = New System.Drawing.Point(407, 362)
        Me.txtCustID.Margin = New System.Windows.Forms.Padding(4)
        Me.txtCustID.Name = "txtCustID"
        Me.txtCustID.Size = New System.Drawing.Size(288, 22)
        Me.txtCustID.TabIndex = 10
        '
        'txtNbrSeats
        '
        Me.txtNbrSeats.Location = New System.Drawing.Point(407, 458)
        Me.txtNbrSeats.Margin = New System.Windows.Forms.Padding(4)
        Me.txtNbrSeats.Name = "txtNbrSeats"
        Me.txtNbrSeats.Size = New System.Drawing.Size(124, 22)
        Me.txtNbrSeats.TabIndex = 12
        '
        'txtNbrSimlSeats
        '
        Me.txtNbrSimlSeats.Location = New System.Drawing.Point(407, 490)
        Me.txtNbrSimlSeats.Margin = New System.Windows.Forms.Padding(4)
        Me.txtNbrSimlSeats.Name = "txtNbrSimlSeats"
        Me.txtNbrSimlSeats.Size = New System.Drawing.Size(124, 22)
        Me.txtNbrSimlSeats.TabIndex = 13
        '
        'txtCompanyResetID
        '
        Me.txtCompanyResetID.Location = New System.Drawing.Point(407, 586)
        Me.txtCompanyResetID.Margin = New System.Windows.Forms.Padding(4)
        Me.txtCompanyResetID.Name = "txtCompanyResetID"
        Me.txtCompanyResetID.Size = New System.Drawing.Size(288, 22)
        Me.txtCompanyResetID.TabIndex = 14
        '
        'txtMstrPw
        '
        Me.txtMstrPw.Location = New System.Drawing.Point(407, 618)
        Me.txtMstrPw.Margin = New System.Windows.Forms.Padding(4)
        Me.txtMstrPw.Name = "txtMstrPw"
        Me.txtMstrPw.Size = New System.Drawing.Size(288, 22)
        Me.txtMstrPw.TabIndex = 15
        '
        'txtLicenGenDate
        '
        Me.txtLicenGenDate.Location = New System.Drawing.Point(407, 650)
        Me.txtLicenGenDate.Margin = New System.Windows.Forms.Padding(4)
        Me.txtLicenGenDate.Name = "txtLicenGenDate"
        Me.txtLicenGenDate.Size = New System.Drawing.Size(288, 22)
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
        Me.GroupBox2.Location = New System.Drawing.Point(511, 679)
        Me.GroupBox2.Margin = New System.Windows.Forms.Padding(4)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Padding = New System.Windows.Forms.Padding(4)
        Me.GroupBox2.Size = New System.Drawing.Size(547, 110)
        Me.GroupBox2.TabIndex = 17
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "Contact Information"
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(468, 26)
        Me.Button2.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(72, 69)
        Me.Button2.TabIndex = 20
        Me.Button2.Text = "Email License"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'txtContactEmail
        '
        Me.txtContactEmail.Location = New System.Drawing.Point(171, 74)
        Me.txtContactEmail.Margin = New System.Windows.Forms.Padding(4)
        Me.txtContactEmail.Name = "txtContactEmail"
        Me.txtContactEmail.Size = New System.Drawing.Size(288, 22)
        Me.txtContactEmail.TabIndex = 19
        '
        'txtContactPhone
        '
        Me.txtContactPhone.Location = New System.Drawing.Point(171, 47)
        Me.txtContactPhone.Margin = New System.Windows.Forms.Padding(4)
        Me.txtContactPhone.Name = "txtContactPhone"
        Me.txtContactPhone.Size = New System.Drawing.Size(288, 22)
        Me.txtContactPhone.TabIndex = 18
        '
        'txtContactName
        '
        Me.txtContactName.Location = New System.Drawing.Point(171, 20)
        Me.txtContactName.Margin = New System.Windows.Forms.Padding(4)
        Me.txtContactName.Name = "txtContactName"
        Me.txtContactName.Size = New System.Drawing.Size(288, 22)
        Me.txtContactName.TabIndex = 17
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Location = New System.Drawing.Point(32, 78)
        Me.Label11.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(94, 17)
        Me.Label11.TabIndex = 10
        Me.Label11.Text = "Contact Email"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(32, 50)
        Me.Label10.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(101, 17)
        Me.Label10.TabIndex = 9
        Me.Label10.Text = "Contact Phone"
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(32, 23)
        Me.Label9.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(97, 17)
        Me.Label9.TabIndex = 8
        Me.Label9.Text = "Contact Name"
        '
        'txtCustAddr
        '
        Me.txtCustAddr.Location = New System.Drawing.Point(407, 102)
        Me.txtCustAddr.Margin = New System.Windows.Forms.Padding(4)
        Me.txtCustAddr.Multiline = True
        Me.txtCustAddr.Name = "txtCustAddr"
        Me.txtCustAddr.Size = New System.Drawing.Size(596, 59)
        Me.txtCustAddr.TabIndex = 19
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Location = New System.Drawing.Point(259, 123)
        Me.Label12.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(124, 17)
        Me.Label12.TabIndex = 18
        Me.Label12.Text = "Customer Address"
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Location = New System.Drawing.Point(279, 207)
        Me.Label13.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(100, 17)
        Me.Label13.TabIndex = 20
        Me.Label13.Text = "State/Province"
        '
        'Label14
        '
        Me.Label14.AutoSize = True
        Me.Label14.Location = New System.Drawing.Point(299, 240)
        Me.Label14.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label14.Name = "Label14"
        Me.Label14.Size = New System.Drawing.Size(84, 17)
        Me.Label14.TabIndex = 21
        Me.Label14.Text = "Postal Code"
        '
        'cbState
        '
        Me.cbState.FormattingEnabled = True
        Me.cbState.Location = New System.Drawing.Point(407, 202)
        Me.cbState.Margin = New System.Windows.Forms.Padding(4)
        Me.cbState.Name = "cbState"
        Me.cbState.Size = New System.Drawing.Size(152, 24)
        Me.cbState.TabIndex = 22
        '
        'txtZip
        '
        Me.txtZip.Location = New System.Drawing.Point(407, 235)
        Me.txtZip.Margin = New System.Windows.Forms.Padding(4)
        Me.txtZip.Name = "txtZip"
        Me.txtZip.Size = New System.Drawing.Size(191, 22)
        Me.txtZip.TabIndex = 23
        '
        'txtCustCountry
        '
        Me.txtCustCountry.Location = New System.Drawing.Point(407, 265)
        Me.txtCustCountry.Margin = New System.Windows.Forms.Padding(4)
        Me.txtCustCountry.Name = "txtCustCountry"
        Me.txtCustCountry.Size = New System.Drawing.Size(339, 22)
        Me.txtCustCountry.TabIndex = 25
        '
        'btnWriteToFile
        '
        Me.btnWriteToFile.Location = New System.Drawing.Point(13, 169)
        Me.btnWriteToFile.Margin = New System.Windows.Forms.Padding(4)
        Me.btnWriteToFile.Name = "btnWriteToFile"
        Me.btnWriteToFile.Size = New System.Drawing.Size(171, 42)
        Me.btnWriteToFile.TabIndex = 26
        Me.btnWriteToFile.Text = "Write License To File"
        Me.btnWriteToFile.UseVisualStyleBackColor = True
        '
        'btnGenerateLicense
        '
        Me.btnGenerateLicense.BackColor = System.Drawing.Color.PaleGreen
        Me.btnGenerateLicense.Location = New System.Drawing.Point(13, 10)
        Me.btnGenerateLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.btnGenerateLicense.Name = "btnGenerateLicense"
        Me.btnGenerateLicense.Size = New System.Drawing.Size(171, 42)
        Me.btnGenerateLicense.TabIndex = 27
        Me.btnGenerateLicense.Text = "Generate License"
        Me.btnGenerateLicense.UseVisualStyleBackColor = False
        '
        'txtLicense
        '
        Me.txtLicense.Enabled = False
        Me.txtLicense.Location = New System.Drawing.Point(23, 798)
        Me.txtLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.txtLicense.Multiline = True
        Me.txtLicense.Name = "txtLicense"
        Me.txtLicense.Size = New System.Drawing.Size(1427, 63)
        Me.txtLicense.TabIndex = 28
        '
        'ckToFile
        '
        Me.ckToFile.AutoSize = True
        Me.ckToFile.Checked = True
        Me.ckToFile.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckToFile.Location = New System.Drawing.Point(13, 355)
        Me.ckToFile.Margin = New System.Windows.Forms.Padding(4)
        Me.ckToFile.Name = "ckToFile"
        Me.ckToFile.Size = New System.Drawing.Size(73, 21)
        Me.ckToFile.TabIndex = 30
        Me.ckToFile.Text = "To File"
        Me.ckToFile.UseVisualStyleBackColor = True
        '
        'ckToEmail
        '
        Me.ckToEmail.AutoSize = True
        Me.ckToEmail.Location = New System.Drawing.Point(13, 382)
        Me.ckToEmail.Margin = New System.Windows.Forms.Padding(4)
        Me.ckToEmail.Name = "ckToEmail"
        Me.ckToEmail.Size = New System.Drawing.Size(137, 21)
        Me.ckToEmail.TabIndex = 31
        Me.ckToEmail.Text = "To Contact Email"
        Me.ckToEmail.UseVisualStyleBackColor = True
        '
        'dtExpire
        '
        Me.dtExpire.Format = System.Windows.Forms.DateTimePickerFormat.[Short]
        Me.dtExpire.Location = New System.Drawing.Point(407, 394)
        Me.dtExpire.Margin = New System.Windows.Forms.Padding(4)
        Me.dtExpire.Name = "dtExpire"
        Me.dtExpire.Size = New System.Drawing.Size(288, 22)
        Me.dtExpire.TabIndex = 32
        Me.TT.SetToolTip(Me.dtExpire, "Check the Lease Option to enable.")
        '
        'Label16
        '
        Me.Label16.AutoSize = True
        Me.Label16.Location = New System.Drawing.Point(189, 431)
        Me.Label16.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label16.Name = "Label16"
        Me.Label16.Size = New System.Drawing.Size(189, 17)
        Me.Label16.TabIndex = 33
        Me.Label16.Text = "Maintenance Expiration Date"
        '
        'dtMaintExpire
        '
        Me.dtMaintExpire.Format = System.Windows.Forms.DateTimePickerFormat.[Short]
        Me.dtMaintExpire.Location = New System.Drawing.Point(407, 426)
        Me.dtMaintExpire.Margin = New System.Windows.Forms.Padding(4)
        Me.dtMaintExpire.Name = "dtMaintExpire"
        Me.dtMaintExpire.Size = New System.Drawing.Size(288, 22)
        Me.dtMaintExpire.TabIndex = 34
        '
        'SB
        '
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(23, 869)
        Me.SB.Margin = New System.Windows.Forms.Padding(4)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(1428, 22)
        Me.SB.TabIndex = 35
        '
        'btnOverwrite
        '
        Me.btnOverwrite.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.btnOverwrite.Location = New System.Drawing.Point(13, 63)
        Me.btnOverwrite.Margin = New System.Windows.Forms.Padding(4)
        Me.btnOverwrite.Name = "btnOverwrite"
        Me.btnOverwrite.Size = New System.Drawing.Size(171, 42)
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
        Me.btnDecrypt.Location = New System.Drawing.Point(1309, 746)
        Me.btnDecrypt.Margin = New System.Windows.Forms.Padding(4)
        Me.btnDecrypt.Name = "btnDecrypt"
        Me.btnDecrypt.Size = New System.Drawing.Size(111, 41)
        Me.btnDecrypt.TabIndex = 37
        Me.btnDecrypt.Text = "Decrypt"
        Me.btnDecrypt.UseVisualStyleBackColor = True
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Location = New System.Drawing.Point(1084, 746)
        Me.btnEncrypt.Margin = New System.Windows.Forms.Padding(4)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(111, 41)
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
        Me.dgLicense.Location = New System.Drawing.Point(1084, 70)
        Me.dgLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.dgLicense.Name = "dgLicense"
        Me.dgLicense.RowTemplate.Height = 24
        Me.dgLicense.Size = New System.Drawing.Size(336, 602)
        Me.dgLicense.TabIndex = 39
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(16, 219)
        Me.Button1.Margin = New System.Windows.Forms.Padding(4)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(164, 43)
        Me.Button1.TabIndex = 40
        Me.Button1.Text = "Init"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'ckToClipboard
        '
        Me.ckToClipboard.AutoSize = True
        Me.ckToClipboard.Location = New System.Drawing.Point(13, 410)
        Me.ckToClipboard.Margin = New System.Windows.Forms.Padding(4)
        Me.ckToClipboard.Name = "ckToClipboard"
        Me.ckToClipboard.Size = New System.Drawing.Size(180, 21)
        Me.ckToClipboard.TabIndex = 41
        Me.ckToClipboard.Text = "Place Copy in Clipboard"
        Me.ckToClipboard.UseVisualStyleBackColor = True
        '
        'Label17
        '
        Me.Label17.AutoSize = True
        Me.Label17.Location = New System.Drawing.Point(221, 302)
        Me.Label17.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label17.Name = "Label17"
        Me.Label17.Size = New System.Drawing.Size(163, 17)
        Me.Label17.TabIndex = 42
        Me.Label17.Text = "License Version Number"
        '
        'txtVersionNbr
        '
        Me.txtVersionNbr.Location = New System.Drawing.Point(407, 297)
        Me.txtVersionNbr.Margin = New System.Windows.Forms.Padding(4)
        Me.txtVersionNbr.Name = "txtVersionNbr"
        Me.txtVersionNbr.Size = New System.Drawing.Size(52, 22)
        Me.txtVersionNbr.TabIndex = 43
        '
        'txtCity
        '
        Me.txtCity.Location = New System.Drawing.Point(407, 170)
        Me.txtCity.Margin = New System.Windows.Forms.Padding(4)
        Me.txtCity.Name = "txtCity"
        Me.txtCity.Size = New System.Drawing.Size(371, 22)
        Me.txtCity.TabIndex = 44
        '
        'Label18
        '
        Me.Label18.AutoSize = True
        Me.Label18.Location = New System.Drawing.Point(352, 172)
        Me.Label18.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label18.Name = "Label18"
        Me.Label18.Size = New System.Drawing.Size(31, 17)
        Me.Label18.TabIndex = 45
        Me.Label18.Text = "City"
        '
        'btnParse
        '
        Me.btnParse.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnParse.Location = New System.Drawing.Point(1263, 15)
        Me.btnParse.Margin = New System.Windows.Forms.Padding(4)
        Me.btnParse.Name = "btnParse"
        Me.btnParse.Size = New System.Drawing.Size(157, 46)
        Me.btnParse.TabIndex = 46
        Me.btnParse.Text = "Parse License"
        Me.btnParse.UseVisualStyleBackColor = True
        '
        'btnLoadLicenseFile
        '
        Me.btnLoadLicenseFile.Location = New System.Drawing.Point(16, 442)
        Me.btnLoadLicenseFile.Margin = New System.Windows.Forms.Padding(4)
        Me.btnLoadLicenseFile.Name = "btnLoadLicenseFile"
        Me.btnLoadLicenseFile.Size = New System.Drawing.Size(164, 59)
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
        Me.btnClipboard.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnClipboard.Location = New System.Drawing.Point(1084, 15)
        Me.btnClipboard.Margin = New System.Windows.Forms.Padding(4)
        Me.btnClipboard.Name = "btnClipboard"
        Me.btnClipboard.Size = New System.Drawing.Size(171, 46)
        Me.btnClipboard.TabIndex = 49
        Me.btnClipboard.Text = "Clipboard Current License"
        Me.btnClipboard.UseVisualStyleBackColor = True
        '
        'btnUploadLicense
        '
        Me.btnUploadLicense.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.btnUploadLicense.Location = New System.Drawing.Point(13, 116)
        Me.btnUploadLicense.Margin = New System.Windows.Forms.Padding(4)
        Me.btnUploadLicense.Name = "btnUploadLicense"
        Me.btnUploadLicense.Size = New System.Drawing.Size(171, 42)
        Me.btnUploadLicense.TabIndex = 50
        Me.btnUploadLicense.Text = "Upload License to Server"
        Me.btnUploadLicense.UseVisualStyleBackColor = False
        '
        'Label15
        '
        Me.Label15.AutoSize = True
        Me.Label15.Location = New System.Drawing.Point(327, 270)
        Me.Label15.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label15.Name = "Label15"
        Me.Label15.Size = New System.Drawing.Size(57, 17)
        Me.Label15.TabIndex = 24
        Me.Label15.Text = "Country"
        '
        'Label19
        '
        Me.Label19.AutoSize = True
        Me.Label19.Location = New System.Drawing.Point(267, 334)
        Me.Label19.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label19.Name = "Label19"
        Me.Label19.Size = New System.Drawing.Size(97, 17)
        Me.Label19.TabIndex = 52
        Me.Label19.Text = "Type License:"
        '
        'cbLicenseType
        '
        Me.cbLicenseType.FormattingEnabled = True
        Me.cbLicenseType.Items.AddRange(New Object() {"Roaming", "Seat", "User", "Client", "SQLExpress", "SDK", "180Days"})
        Me.cbLicenseType.Location = New System.Drawing.Point(407, 329)
        Me.cbLicenseType.Margin = New System.Windows.Forms.Padding(4)
        Me.cbLicenseType.Name = "cbLicenseType"
        Me.cbLicenseType.Size = New System.Drawing.Size(167, 24)
        Me.cbLicenseType.TabIndex = 53
        '
        'btnDelete
        '
        Me.btnDelete.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(128, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.btnDelete.Location = New System.Drawing.Point(13, 440)
        Me.btnDelete.Margin = New System.Windows.Forms.Padding(4)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(167, 52)
        Me.btnDelete.TabIndex = 54
        Me.btnDelete.Text = "Delete License"
        Me.TT.SetToolTip(Me.btnDelete, "Remove file from local server as well as the remote server.")
        Me.btnDelete.UseVisualStyleBackColor = False
        '
        'Panel1
        '
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel1.Controls.Add(Me.btnGenInsertSQL)
        Me.Panel1.Controls.Add(Me.btnGenUpdtSQL)
        Me.Panel1.Controls.Add(Me.CheckBox1)
        Me.Panel1.Controls.Add(Me.btnGenerateLicense)
        Me.Panel1.Controls.Add(Me.btnDelete)
        Me.Panel1.Controls.Add(Me.btnWriteToFile)
        Me.Panel1.Controls.Add(Me.ckToFile)
        Me.Panel1.Controls.Add(Me.ckToEmail)
        Me.Panel1.Controls.Add(Me.btnUploadLicense)
        Me.Panel1.Controls.Add(Me.btnOverwrite)
        Me.Panel1.Controls.Add(Me.ckToClipboard)
        Me.Panel1.Location = New System.Drawing.Point(796, 172)
        Me.Panel1.Margin = New System.Windows.Forms.Padding(4)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(207, 500)
        Me.Panel1.TabIndex = 55
        '
        'btnGenInsertSQL
        '
        Me.btnGenInsertSQL.Location = New System.Drawing.Point(13, 275)
        Me.btnGenInsertSQL.Margin = New System.Windows.Forms.Padding(4)
        Me.btnGenInsertSQL.Name = "btnGenInsertSQL"
        Me.btnGenInsertSQL.Size = New System.Drawing.Size(171, 42)
        Me.btnGenInsertSQL.TabIndex = 57
        Me.btnGenInsertSQL.Text = "Gen INSERT SQL"
        Me.btnGenInsertSQL.UseVisualStyleBackColor = True
        '
        'btnGenUpdtSQL
        '
        Me.btnGenUpdtSQL.Location = New System.Drawing.Point(13, 222)
        Me.btnGenUpdtSQL.Margin = New System.Windows.Forms.Padding(4)
        Me.btnGenUpdtSQL.Name = "btnGenUpdtSQL"
        Me.btnGenUpdtSQL.Size = New System.Drawing.Size(171, 42)
        Me.btnGenUpdtSQL.TabIndex = 56
        Me.btnGenUpdtSQL.Text = "Gen Update SQL"
        Me.btnGenUpdtSQL.UseVisualStyleBackColor = True
        '
        'CheckBox1
        '
        Me.CheckBox1.AutoSize = True
        Me.CheckBox1.Location = New System.Drawing.Point(13, 326)
        Me.CheckBox1.Margin = New System.Windows.Forms.Padding(4)
        Me.CheckBox1.Name = "CheckBox1"
        Me.CheckBox1.Size = New System.Drawing.Size(185, 21)
        Me.CheckBox1.TabIndex = 55
        Me.CheckBox1.Text = "Apply To Remote Server"
        Me.CheckBox1.UseVisualStyleBackColor = True
        '
        'txtMaxClients
        '
        Me.txtMaxClients.Location = New System.Drawing.Point(407, 522)
        Me.txtMaxClients.Margin = New System.Windows.Forms.Padding(4)
        Me.txtMaxClients.Name = "txtMaxClients"
        Me.txtMaxClients.Size = New System.Drawing.Size(124, 22)
        Me.txtMaxClients.TabIndex = 62
        Me.txtMaxClients.Text = "0"
        Me.TT.SetToolTip(Me.txtMaxClients, "A zero in this field sets the number of allowed to be equal to the number of seat" &
        "s purchased. ")
        '
        'txtSharePointNbr
        '
        Me.txtSharePointNbr.Location = New System.Drawing.Point(407, 554)
        Me.txtSharePointNbr.Margin = New System.Windows.Forms.Padding(4)
        Me.txtSharePointNbr.Name = "txtSharePointNbr"
        Me.txtSharePointNbr.Size = New System.Drawing.Size(124, 22)
        Me.txtSharePointNbr.TabIndex = 63
        Me.txtSharePointNbr.Text = "0"
        Me.TT.SetToolTip(Me.txtSharePointNbr, "A zero in this field sets the number of allowed to be equal to the number of seat" &
        "s purchased. ")
        '
        'txtSSINstance
        '
        Me.txtSSINstance.BackColor = System.Drawing.Color.Red
        Me.txtSSINstance.ForeColor = System.Drawing.SystemColors.Info
        Me.txtSSINstance.Location = New System.Drawing.Point(407, 39)
        Me.txtSSINstance.Margin = New System.Windows.Forms.Padding(4)
        Me.txtSSINstance.Name = "txtSSINstance"
        Me.txtSSINstance.Size = New System.Drawing.Size(339, 22)
        Me.txtSSINstance.TabIndex = 68
        Me.TT.SetToolTip(Me.txtSSINstance, "Enter the name of the SQL SERVER Instance that will house this repository.")
        '
        'txtServerName
        '
        Me.txtServerName.BackColor = System.Drawing.Color.Red
        Me.txtServerName.ForeColor = System.Drawing.SystemColors.Info
        Me.txtServerName.Location = New System.Drawing.Point(407, 10)
        Me.txtServerName.Margin = New System.Windows.Forms.Padding(4)
        Me.txtServerName.Name = "txtServerName"
        Me.txtServerName.Size = New System.Drawing.Size(339, 22)
        Me.txtServerName.TabIndex = 70
        Me.TT.SetToolTip(Me.txtServerName, "Enter the name of the SERVER where this repository will reside.")
        '
        'btnSync
        '
        Me.btnSync.Location = New System.Drawing.Point(21, 641)
        Me.btnSync.Margin = New System.Windows.Forms.Padding(4)
        Me.btnSync.Name = "btnSync"
        Me.btnSync.Size = New System.Drawing.Size(111, 69)
        Me.btnSync.TabIndex = 71
        Me.btnSync.Text = "Sync Licenses"
        Me.TT.SetToolTip(Me.btnSync, "Add licenses not found on both machines.")
        Me.btnSync.UseVisualStyleBackColor = True
        '
        'TextBox1
        '
        Me.TextBox1.BackColor = System.Drawing.Color.MediumSpringGreen
        Me.TextBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TextBox1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TextBox1.Location = New System.Drawing.Point(779, 39)
        Me.TextBox1.Margin = New System.Windows.Forms.Padding(4)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(141, 23)
        Me.TextBox1.TabIndex = 73
        Me.TextBox1.Text = ".5"
        Me.TT.SetToolTip(Me.TextBox1, "Enter the name of the SQL SERVER Instance that will house this repository.")
        '
        'Label20
        '
        Me.Label20.AutoSize = True
        Me.Label20.Font = New System.Drawing.Font("Monotype Corsiva", 36.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label20.Location = New System.Drawing.Point(16, 32)
        Me.Label20.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label20.Name = "Label20"
        Me.Label20.Size = New System.Drawing.Size(151, 72)
        Me.Label20.TabIndex = 56
        Me.Label20.Text = "ECM"
        '
        'Label21
        '
        Me.Label21.AutoSize = True
        Me.Label21.Font = New System.Drawing.Font("Arial", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label21.Location = New System.Drawing.Point(1, 102)
        Me.Label21.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label21.Name = "Label21"
        Me.Label21.Size = New System.Drawing.Size(184, 51)
        Me.Label21.TabIndex = 57
        Me.Label21.Text = "License"
        '
        'Label22
        '
        Me.Label22.AutoSize = True
        Me.Label22.Font = New System.Drawing.Font("Arial", 26.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label22.Location = New System.Drawing.Point(13, 154)
        Me.Label22.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label22.Name = "Label22"
        Me.Label22.Size = New System.Drawing.Size(158, 51)
        Me.Label22.TabIndex = 58
        Me.Label22.Text = "Server"
        '
        'ckSdk
        '
        Me.ckSdk.AutoSize = True
        Me.ckSdk.Location = New System.Drawing.Point(611, 306)
        Me.ckSdk.Margin = New System.Windows.Forms.Padding(4)
        Me.ckSdk.Name = "ckSdk"
        Me.ckSdk.Size = New System.Drawing.Size(130, 21)
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
        Me.ckLease.Location = New System.Drawing.Point(611, 334)
        Me.ckLease.Margin = New System.Windows.Forms.Padding(4)
        Me.ckLease.Name = "ckLease"
        Me.ckLease.Size = New System.Drawing.Size(115, 21)
        Me.ckLease.TabIndex = 60
        Me.ckLease.Text = "Lease Option"
        Me.ckLease.UseVisualStyleBackColor = True
        '
        'Label23
        '
        Me.Label23.AutoSize = True
        Me.Label23.Location = New System.Drawing.Point(247, 527)
        Me.Label23.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label23.Name = "Label23"
        Me.Label23.Size = New System.Drawing.Size(135, 17)
        Me.Label23.TabIndex = 61
        Me.Label23.Text = "Max Clients Installed"
        '
        'Label24
        '
        Me.Label24.AutoSize = True
        Me.Label24.Location = New System.Drawing.Point(247, 559)
        Me.Label24.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label24.Name = "Label24"
        Me.Label24.Size = New System.Drawing.Size(140, 17)
        Me.Label24.TabIndex = 64
        Me.Label24.Text = "Max SharePoint DB's"
        '
        'btnPull
        '
        Me.btnPull.Location = New System.Drawing.Point(23, 718)
        Me.btnPull.Margin = New System.Windows.Forms.Padding(4)
        Me.btnPull.Name = "btnPull"
        Me.btnPull.Size = New System.Drawing.Size(111, 69)
        Me.btnPull.TabIndex = 65
        Me.btnPull.Text = "Pull Missing Licenses"
        Me.btnPull.UseVisualStyleBackColor = True
        '
        'dgRemote
        '
        Me.dgRemote.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgRemote.Location = New System.Drawing.Point(16, 284)
        Me.dgRemote.Margin = New System.Windows.Forms.Padding(4)
        Me.dgRemote.Name = "dgRemote"
        Me.dgRemote.RowTemplate.Height = 24
        Me.dgRemote.Size = New System.Drawing.Size(164, 137)
        Me.dgRemote.TabIndex = 66
        '
        'Label25
        '
        Me.Label25.AutoSize = True
        Me.Label25.Location = New System.Drawing.Point(201, 46)
        Me.Label25.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label25.Name = "Label25"
        Me.Label25.Size = New System.Drawing.Size(180, 17)
        Me.Label25.TabIndex = 67
        Me.Label25.Text = "SQL Server Instance Name"
        '
        'Label26
        '
        Me.Label26.AutoSize = True
        Me.Label26.Location = New System.Drawing.Point(291, 15)
        Me.Label26.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label26.Name = "Label26"
        Me.Label26.Size = New System.Drawing.Size(91, 17)
        Me.Label26.TabIndex = 69
        Me.Label26.Text = "Server Name"
        '
        'lblCurrStorageAllotment
        '
        Me.lblCurrStorageAllotment.AutoSize = True
        Me.lblCurrStorageAllotment.Location = New System.Drawing.Point(779, 15)
        Me.lblCurrStorageAllotment.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblCurrStorageAllotment.Name = "lblCurrStorageAllotment"
        Me.lblCurrStorageAllotment.Size = New System.Drawing.Size(142, 17)
        Me.lblCurrStorageAllotment.TabIndex = 72
        Me.lblCurrStorageAllotment.Text = "Storage Allotment TB"
        '
        'FrmMainLicense
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.Silver
        Me.ClientSize = New System.Drawing.Size(1436, 904)
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
        Me.Margin = New System.Windows.Forms.Padding(4)
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
    Friend WithEvents CheckBox1 As CheckBox
    Friend WithEvents btnGenUpdtSQL As Button
    Friend WithEvents btnGenInsertSQL As Button
End Class
