<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmExhangeMail
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
        Me.dgExchange = New System.Windows.Forms.DataGridView()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.ckSSL = New System.Windows.Forms.CheckBox()
        Me.ckDeleteAfterDownload = New System.Windows.Forms.CheckBox()
        Me.ckIMap = New System.Windows.Forms.CheckBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.cbUsers = New System.Windows.Forms.ComboBox()
        Me.cbRetention = New System.Windows.Forms.ComboBox()
        Me.txtUserLoginID = New System.Windows.Forms.TextBox()
        Me.txtPw = New System.Windows.Forms.TextBox()
        Me.txtPortNumber = New System.Windows.Forms.TextBox()
        Me.cbHostName = New System.Windows.Forms.ComboBox()
        Me.btnAdd = New System.Windows.Forms.Button()
        Me.btnUpdate = New System.Windows.Forms.Button()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.txtFolderName = New System.Windows.Forms.TextBox()
        Me.cbLibrary = New System.Windows.Forms.ComboBox()
        Me.nbrDaysToRetain = New System.Windows.Forms.NumericUpDown()
        Me.btnTest = New System.Windows.Forms.Button()
        Me.btnTestConnection = New System.Windows.Forms.Button()
        Me.btnShoaAllLib = New System.Windows.Forms.Button()
        Me.btnEncrypt = New System.Windows.Forms.Button()
        Me.f1Help = New System.Windows.Forms.HelpProvider()
        Me.txtUserID = New System.Windows.Forms.TextBox()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.HelpToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem1 = New System.Windows.Forms.ToolStripMenuItem()
        Me.Exchange2007Vs2003ToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExchnageJournalingToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SamplePOPMailScreenToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SampleIMAPSSLScreenToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SampleIMAPScreenToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SamplePOPSSLMailScreenToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SampleCorporateEmailScreenToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.ckPublic = New System.Windows.Forms.CheckBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.txtReject = New System.Windows.Forms.TextBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.ckConvertEmlToMsg = New System.Windows.Forms.CheckBox()
        Me.btnReset = New System.Windows.Forms.Button()
        Me.ckExcg2003 = New System.Windows.Forms.CheckBox()
        Me.ckExcg2007 = New System.Windows.Forms.CheckBox()
        Me.ckRtfFormat = New System.Windows.Forms.CheckBox()
        Me.ckPlainText = New System.Windows.Forms.CheckBox()
        Me.ckEnvelope = New System.Windows.Forms.CheckBox()
        Me.ckJournaled = New System.Windows.Forms.CheckBox()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.ContextMenuStrip1 = New System.Windows.Forms.ContextMenuStrip(Me.components)
        Me.ComplianceOverviewToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.ExchangeJournalingToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.SamplesToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.POPMailToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.IMAPSSLToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.IMAPToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.POPSSLToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.StandardCoporateToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        CType(Me.dgExchange, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.nbrDaysToRetain, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.MenuStrip1.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.ContextMenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'dgExchange
        '
        Me.dgExchange.AllowUserToAddRows = False
        Me.dgExchange.AllowUserToDeleteRows = False
        Me.dgExchange.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgExchange.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells
        Me.dgExchange.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgExchange.Location = New System.Drawing.Point(12, 58)
        Me.dgExchange.Name = "dgExchange"
        Me.dgExchange.ReadOnly = True
        Me.dgExchange.Size = New System.Drawing.Size(483, 524)
        Me.dgExchange.TabIndex = 0
        Me.TT.SetToolTip(Me.dgExchange, "Do not update data here, use input fields to the right.")
        '
        'Label1
        '
        Me.Label1.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(527, 40)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(60, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Host Name"
        '
        'Label2
        '
        Me.Label2.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(527, 84)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(72, 13)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "User Login ID"
        '
        'Label3
        '
        Me.Label3.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(527, 127)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(82, 13)
        Me.Label3.TabIndex = 3
        Me.Label3.Text = "Login Password"
        '
        'Label5
        '
        Me.Label5.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(524, 358)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(66, 13)
        Me.Label5.TabIndex = 5
        Me.Label5.Text = "Port Number"
        '
        'Label6
        '
        Me.Label6.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(524, 401)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(78, 13)
        Me.Label6.TabIndex = 6
        Me.Label6.Text = "RetentionCode"
        '
        'ckSSL
        '
        Me.ckSSL.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckSSL.AutoSize = True
        Me.ckSSL.Location = New System.Drawing.Point(526, 173)
        Me.ckSSL.Name = "ckSSL"
        Me.ckSSL.Size = New System.Drawing.Size(46, 17)
        Me.ckSSL.TabIndex = 7
        Me.ckSSL.Text = "SSL"
        Me.ckSSL.UseVisualStyleBackColor = True
        '
        'ckDeleteAfterDownload
        '
        Me.ckDeleteAfterDownload.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckDeleteAfterDownload.AutoSize = True
        Me.ckDeleteAfterDownload.Location = New System.Drawing.Point(526, 196)
        Me.ckDeleteAfterDownload.Name = "ckDeleteAfterDownload"
        Me.ckDeleteAfterDownload.Size = New System.Drawing.Size(133, 17)
        Me.ckDeleteAfterDownload.TabIndex = 8
        Me.ckDeleteAfterDownload.Text = "Delete After Download"
        Me.ckDeleteAfterDownload.UseVisualStyleBackColor = True
        '
        'ckIMap
        '
        Me.ckIMap.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckIMap.AutoSize = True
        Me.ckIMap.Location = New System.Drawing.Point(610, 173)
        Me.ckIMap.Name = "ckIMap"
        Me.ckIMap.Size = New System.Drawing.Size(50, 17)
        Me.ckIMap.TabIndex = 9
        Me.ckIMap.Text = "IMap"
        Me.ckIMap.UseVisualStyleBackColor = True
        '
        'Label4
        '
        Me.Label4.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(524, 445)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(93, 13)
        Me.Label4.TabIndex = 10
        Me.Label4.Text = "Execution User ID"
        '
        'cbUsers
        '
        Me.cbUsers.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbUsers.FormattingEnabled = True
        Me.cbUsers.Location = New System.Drawing.Point(524, 463)
        Me.cbUsers.Name = "cbUsers"
        Me.cbUsers.Size = New System.Drawing.Size(294, 21)
        Me.cbUsers.TabIndex = 11
        Me.TT.SetToolTip(Me.cbUsers, "Leave blank to default to your ID or Set this ID to be different than your curren" & _
                "t ID if another user is to run this utility.")
        '
        'cbRetention
        '
        Me.cbRetention.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbRetention.FormattingEnabled = True
        Me.cbRetention.Location = New System.Drawing.Point(524, 419)
        Me.cbRetention.Name = "cbRetention"
        Me.cbRetention.Size = New System.Drawing.Size(294, 21)
        Me.cbRetention.TabIndex = 12
        '
        'txtUserLoginID
        '
        Me.txtUserLoginID.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtUserLoginID.Location = New System.Drawing.Point(527, 102)
        Me.txtUserLoginID.Name = "txtUserLoginID"
        Me.txtUserLoginID.Size = New System.Drawing.Size(294, 20)
        Me.txtUserLoginID.TabIndex = 14
        '
        'txtPw
        '
        Me.txtPw.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtPw.Location = New System.Drawing.Point(527, 145)
        Me.txtPw.Name = "txtPw"
        Me.txtPw.Size = New System.Drawing.Size(179, 20)
        Me.txtPw.TabIndex = 15
        '
        'txtPortNumber
        '
        Me.txtPortNumber.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtPortNumber.Location = New System.Drawing.Point(524, 376)
        Me.txtPortNumber.Name = "txtPortNumber"
        Me.txtPortNumber.Size = New System.Drawing.Size(110, 20)
        Me.txtPortNumber.TabIndex = 16
        '
        'cbHostName
        '
        Me.cbHostName.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbHostName.FormattingEnabled = True
        Me.cbHostName.Location = New System.Drawing.Point(527, 58)
        Me.cbHostName.Name = "cbHostName"
        Me.cbHostName.Size = New System.Drawing.Size(294, 21)
        Me.cbHostName.TabIndex = 17
        Me.TT.SetToolTip(Me.cbHostName, "For a sample of how to fill this out, please click the help menu.")
        '
        'btnAdd
        '
        Me.btnAdd.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnAdd.Location = New System.Drawing.Point(640, 611)
        Me.btnAdd.Name = "btnAdd"
        Me.btnAdd.Size = New System.Drawing.Size(53, 36)
        Me.btnAdd.TabIndex = 18
        Me.btnAdd.Text = "&Insert"
        Me.btnAdd.UseVisualStyleBackColor = True
        '
        'btnUpdate
        '
        Me.btnUpdate.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnUpdate.Location = New System.Drawing.Point(699, 611)
        Me.btnUpdate.Name = "btnUpdate"
        Me.btnUpdate.Size = New System.Drawing.Size(53, 36)
        Me.btnUpdate.TabIndex = 19
        Me.btnUpdate.Text = "&Update"
        Me.btnUpdate.UseVisualStyleBackColor = True
        '
        'btnDelete
        '
        Me.btnDelete.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnDelete.Location = New System.Drawing.Point(767, 611)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(53, 36)
        Me.btnDelete.TabIndex = 20
        Me.btnDelete.Text = "&Delete"
        Me.btnDelete.UseVisualStyleBackColor = True
        '
        'SB
        '
        Me.SB.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(92, 663)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(403, 20)
        Me.SB.TabIndex = 21
        '
        'txtFolderName
        '
        Me.txtFolderName.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtFolderName.Enabled = False
        Me.txtFolderName.Location = New System.Drawing.Point(652, 376)
        Me.txtFolderName.Name = "txtFolderName"
        Me.txtFolderName.Size = New System.Drawing.Size(165, 20)
        Me.txtFolderName.TabIndex = 25
        Me.TT.SetToolTip(Me.txtFolderName, "Used in an IMAP definition.")
        '
        'cbLibrary
        '
        Me.cbLibrary.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbLibrary.FormattingEnabled = True
        Me.cbLibrary.Location = New System.Drawing.Point(524, 514)
        Me.cbLibrary.Name = "cbLibrary"
        Me.cbLibrary.Size = New System.Drawing.Size(269, 21)
        Me.cbLibrary.TabIndex = 28
        Me.TT.SetToolTip(Me.cbLibrary, "Leave blank to default to your ID or Set this ID to be different than your curren" & _
                "t ID if another user is to run this utility.")
        '
        'nbrDaysToRetain
        '
        Me.nbrDaysToRetain.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.nbrDaysToRetain.Location = New System.Drawing.Point(773, 194)
        Me.nbrDaysToRetain.Maximum = New Decimal(New Integer() {1000, 0, 0, 0})
        Me.nbrDaysToRetain.Name = "nbrDaysToRetain"
        Me.nbrDaysToRetain.Size = New System.Drawing.Size(56, 20)
        Me.nbrDaysToRetain.TabIndex = 31
        Me.TT.SetToolTip(Me.nbrDaysToRetain, "Zero means delete when downloaded")
        '
        'btnTest
        '
        Me.btnTest.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnTest.Location = New System.Drawing.Point(526, 611)
        Me.btnTest.Name = "btnTest"
        Me.btnTest.Size = New System.Drawing.Size(53, 36)
        Me.btnTest.TabIndex = 32
        Me.btnTest.Text = "Show All"
        Me.TT.SetToolTip(Me.btnTest, "Show the appropriate list of defined Exchange mail boxes.")
        Me.btnTest.UseVisualStyleBackColor = True
        '
        'btnTestConnection
        '
        Me.btnTestConnection.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnTestConnection.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.btnTestConnection.Location = New System.Drawing.Point(829, 53)
        Me.btnTestConnection.Name = "btnTestConnection"
        Me.btnTestConnection.Size = New System.Drawing.Size(30, 31)
        Me.btnTestConnection.TabIndex = 40
        Me.TT.SetToolTip(Me.btnTestConnection, "Press to test the connection to the server.")
        Me.btnTestConnection.UseVisualStyleBackColor = True
        '
        'btnShoaAllLib
        '
        Me.btnShoaAllLib.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnShoaAllLib.Location = New System.Drawing.Point(810, 514)
        Me.btnShoaAllLib.Name = "btnShoaAllLib"
        Me.btnShoaAllLib.Size = New System.Drawing.Size(19, 20)
        Me.btnShoaAllLib.TabIndex = 41
        Me.TT.SetToolTip(Me.btnShoaAllLib, "Show all libraries in system to choose from.")
        Me.btnShoaAllLib.UseVisualStyleBackColor = True
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnEncrypt.Location = New System.Drawing.Point(717, 145)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(103, 20)
        Me.btnEncrypt.TabIndex = 22
        Me.btnEncrypt.Text = "Encrypt PW"
        Me.btnEncrypt.UseVisualStyleBackColor = True
        '
        'f1Help
        '
        Me.f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmExchangeMail.htm"
        '
        'txtUserID
        '
        Me.txtUserID.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtUserID.Enabled = False
        Me.txtUserID.Location = New System.Drawing.Point(527, 656)
        Me.txtUserID.Name = "txtUserID"
        Me.txtUserID.Size = New System.Drawing.Size(293, 20)
        Me.txtUserID.TabIndex = 23
        '
        'MenuStrip1
        '
        Me.MenuStrip1.BackColor = System.Drawing.Color.Transparent
        Me.MenuStrip1.Dock = System.Windows.Forms.DockStyle.None
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.HelpToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(48, 24)
        Me.MenuStrip1.TabIndex = 24
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'HelpToolStripMenuItem
        '
        Me.HelpToolStripMenuItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
        Me.HelpToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ECMLibraryExchangeInterfaceToolStripMenuItem1, Me.Exchange2007Vs2003ToolStripMenuItem, Me.ExchnageJournalingToolStripMenuItem, Me.SamplePOPMailScreenToolStripMenuItem, Me.SampleIMAPSSLScreenToolStripMenuItem, Me.SampleIMAPScreenToolStripMenuItem, Me.SamplePOPSSLMailScreenToolStripMenuItem, Me.SampleCorporateEmailScreenToolStripMenuItem})
        Me.HelpToolStripMenuItem.Name = "HelpToolStripMenuItem"
        Me.HelpToolStripMenuItem.ShortcutKeys = CType((System.Windows.Forms.Keys.Control Or System.Windows.Forms.Keys.F1), System.Windows.Forms.Keys)
        Me.HelpToolStripMenuItem.Size = New System.Drawing.Size(40, 20)
        Me.HelpToolStripMenuItem.Text = "&Help"
        '
        'ECMLibraryExchangeInterfaceToolStripMenuItem1
        '
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem1.Name = "ECMLibraryExchangeInterfaceToolStripMenuItem1"
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem1.Size = New System.Drawing.Size(312, 22)
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem1.Text = "ECM Library Exchange Interface"
        '
        'Exchange2007Vs2003ToolStripMenuItem
        '
        Me.Exchange2007Vs2003ToolStripMenuItem.Name = "Exchange2007Vs2003ToolStripMenuItem"
        Me.Exchange2007Vs2003ToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.Exchange2007Vs2003ToolStripMenuItem.Text = "Microsoft Exchange Server 2007 Compliance Tour"
        '
        'ExchnageJournalingToolStripMenuItem
        '
        Me.ExchnageJournalingToolStripMenuItem.Name = "ExchnageJournalingToolStripMenuItem"
        Me.ExchnageJournalingToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.ExchnageJournalingToolStripMenuItem.Text = "Exchange Journaling"
        '
        'SamplePOPMailScreenToolStripMenuItem
        '
        Me.SamplePOPMailScreenToolStripMenuItem.Name = "SamplePOPMailScreenToolStripMenuItem"
        Me.SamplePOPMailScreenToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.SamplePOPMailScreenToolStripMenuItem.Text = "Sample POP Mail Screen"
        '
        'SampleIMAPSSLScreenToolStripMenuItem
        '
        Me.SampleIMAPSSLScreenToolStripMenuItem.Name = "SampleIMAPSSLScreenToolStripMenuItem"
        Me.SampleIMAPSSLScreenToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.SampleIMAPSSLScreenToolStripMenuItem.Text = "Sample IMAP SSL Screen"
        '
        'SampleIMAPScreenToolStripMenuItem
        '
        Me.SampleIMAPScreenToolStripMenuItem.Name = "SampleIMAPScreenToolStripMenuItem"
        Me.SampleIMAPScreenToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.SampleIMAPScreenToolStripMenuItem.Text = "Sample IMAP Screen"
        '
        'SamplePOPSSLMailScreenToolStripMenuItem
        '
        Me.SamplePOPSSLMailScreenToolStripMenuItem.Name = "SamplePOPSSLMailScreenToolStripMenuItem"
        Me.SamplePOPSSLMailScreenToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.SamplePOPSSLMailScreenToolStripMenuItem.Text = "Sample POP SSL Mail Screen"
        '
        'SampleCorporateEmailScreenToolStripMenuItem
        '
        Me.SampleCorporateEmailScreenToolStripMenuItem.Name = "SampleCorporateEmailScreenToolStripMenuItem"
        Me.SampleCorporateEmailScreenToolStripMenuItem.Size = New System.Drawing.Size(312, 22)
        Me.SampleCorporateEmailScreenToolStripMenuItem.Text = "Sample Corporate Email Screen"
        '
        'Label7
        '
        Me.Label7.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(649, 360)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(74, 13)
        Me.Label7.TabIndex = 26
        Me.Label7.Text = "Mailbox Name"
        '
        'Label8
        '
        Me.Label8.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(524, 496)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(80, 13)
        Me.Label8.TabIndex = 27
        Me.Label8.Text = "Select a Library"
        '
        'ckPublic
        '
        Me.ckPublic.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckPublic.AutoSize = True
        Me.ckPublic.Location = New System.Drawing.Point(524, 548)
        Me.ckPublic.Name = "ckPublic"
        Me.ckPublic.Size = New System.Drawing.Size(295, 17)
        Me.ckPublic.TabIndex = 29
        Me.ckPublic.Text = "Make all emails in this archive available for Public access"
        Me.ckPublic.UseVisualStyleBackColor = True
        '
        'Label9
        '
        Me.Label9.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(665, 198)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(102, 13)
        Me.Label9.TabIndex = 30
        Me.Label9.Text = "or Delete after days:"
        '
        'txtReject
        '
        Me.txtReject.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtReject.Location = New System.Drawing.Point(526, 585)
        Me.txtReject.Name = "txtReject"
        Me.txtReject.Size = New System.Drawing.Size(293, 20)
        Me.txtReject.TabIndex = 33
        '
        'Label10
        '
        Me.Label10.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(526, 569)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(131, 13)
        Me.Label10.TabIndex = 34
        Me.Label10.Text = "Reject if Subject contains:"
        '
        'ckConvertEmlToMsg
        '
        Me.ckConvertEmlToMsg.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckConvertEmlToMsg.AutoSize = True
        Me.ckConvertEmlToMsg.Location = New System.Drawing.Point(537, 308)
        Me.ckConvertEmlToMsg.Name = "ckConvertEmlToMsg"
        Me.ckConvertEmlToMsg.Size = New System.Drawing.Size(230, 17)
        Me.ckConvertEmlToMsg.TabIndex = 35
        Me.ckConvertEmlToMsg.Text = "Convert all emails in this folder to MSG files."
        Me.ckConvertEmlToMsg.UseVisualStyleBackColor = True
        '
        'btnReset
        '
        Me.btnReset.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnReset.Location = New System.Drawing.Point(12, 663)
        Me.btnReset.Name = "btnReset"
        Me.btnReset.Size = New System.Drawing.Size(53, 22)
        Me.btnReset.TabIndex = 37
        Me.btnReset.Text = "Reset"
        Me.btnReset.UseVisualStyleBackColor = True
        Me.btnReset.Visible = False
        '
        'ckExcg2003
        '
        Me.ckExcg2003.AutoSize = True
        Me.ckExcg2003.Location = New System.Drawing.Point(12, 29)
        Me.ckExcg2003.Name = "ckExcg2003"
        Me.ckExcg2003.Size = New System.Drawing.Size(101, 17)
        Me.ckExcg2003.TabIndex = 1
        Me.ckExcg2003.Text = "Exchange 2003"
        Me.ckExcg2003.UseVisualStyleBackColor = True
        '
        'ckExcg2007
        '
        Me.ckExcg2007.AutoSize = True
        Me.ckExcg2007.Location = New System.Drawing.Point(12, 6)
        Me.ckExcg2007.Name = "ckExcg2007"
        Me.ckExcg2007.Size = New System.Drawing.Size(101, 17)
        Me.ckExcg2007.TabIndex = 2
        Me.ckExcg2007.Text = "Exchange 2007"
        Me.ckExcg2007.UseVisualStyleBackColor = True
        '
        'ckRtfFormat
        '
        Me.ckRtfFormat.AutoSize = True
        Me.ckRtfFormat.Location = New System.Drawing.Point(161, 6)
        Me.ckRtfFormat.Name = "ckRtfFormat"
        Me.ckRtfFormat.Size = New System.Drawing.Size(47, 17)
        Me.ckRtfFormat.TabIndex = 3
        Me.ckRtfFormat.Text = "RTF"
        Me.ckRtfFormat.UseVisualStyleBackColor = True
        '
        'ckPlainText
        '
        Me.ckPlainText.AutoSize = True
        Me.ckPlainText.Location = New System.Drawing.Point(161, 30)
        Me.ckPlainText.Name = "ckPlainText"
        Me.ckPlainText.Size = New System.Drawing.Size(73, 17)
        Me.ckPlainText.TabIndex = 4
        Me.ckPlainText.Text = "Plain Text"
        Me.ckPlainText.UseVisualStyleBackColor = True
        '
        'ckEnvelope
        '
        Me.ckEnvelope.AutoSize = True
        Me.ckEnvelope.Location = New System.Drawing.Point(161, 54)
        Me.ckEnvelope.Name = "ckEnvelope"
        Me.ckEnvelope.Size = New System.Drawing.Size(71, 17)
        Me.ckEnvelope.TabIndex = 5
        Me.ckEnvelope.Text = "Envelope"
        Me.ckEnvelope.UseVisualStyleBackColor = True
        '
        'ckJournaled
        '
        Me.ckJournaled.AutoSize = True
        Me.ckJournaled.Location = New System.Drawing.Point(12, 54)
        Me.ckJournaled.Name = "ckJournaled"
        Me.ckJournaled.Size = New System.Drawing.Size(99, 17)
        Me.ckJournaled.TabIndex = 6
        Me.ckJournaled.Text = "Journal Mailbox"
        Me.ckJournaled.UseVisualStyleBackColor = True
        '
        'Panel1
        '
        Me.Panel1.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Panel1.Controls.Add(Me.ckJournaled)
        Me.Panel1.Controls.Add(Me.ckEnvelope)
        Me.Panel1.Controls.Add(Me.ckPlainText)
        Me.Panel1.Controls.Add(Me.ckRtfFormat)
        Me.Panel1.Controls.Add(Me.ckExcg2007)
        Me.Panel1.Controls.Add(Me.ckExcg2003)
        Me.Panel1.Enabled = False
        Me.Panel1.Location = New System.Drawing.Point(536, 219)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(283, 83)
        Me.Panel1.TabIndex = 38
        '
        'ContextMenuStrip1
        '
        Me.ContextMenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.ComplianceOverviewToolStripMenuItem, Me.ECMLibraryExchangeInterfaceToolStripMenuItem, Me.ExchangeJournalingToolStripMenuItem, Me.SamplesToolStripMenuItem})
        Me.ContextMenuStrip1.Name = "ContextMenuStrip1"
        Me.ContextMenuStrip1.Size = New System.Drawing.Size(241, 92)
        '
        'ComplianceOverviewToolStripMenuItem
        '
        Me.ComplianceOverviewToolStripMenuItem.Name = "ComplianceOverviewToolStripMenuItem"
        Me.ComplianceOverviewToolStripMenuItem.Size = New System.Drawing.Size(240, 22)
        Me.ComplianceOverviewToolStripMenuItem.Text = "Compliance Overview"
        '
        'ECMLibraryExchangeInterfaceToolStripMenuItem
        '
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem.Name = "ECMLibraryExchangeInterfaceToolStripMenuItem"
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem.Size = New System.Drawing.Size(240, 22)
        Me.ECMLibraryExchangeInterfaceToolStripMenuItem.Text = "ECM Library Exchange Interface"
        '
        'ExchangeJournalingToolStripMenuItem
        '
        Me.ExchangeJournalingToolStripMenuItem.Name = "ExchangeJournalingToolStripMenuItem"
        Me.ExchangeJournalingToolStripMenuItem.Size = New System.Drawing.Size(240, 22)
        Me.ExchangeJournalingToolStripMenuItem.Text = "Exchange Journaling"
        '
        'SamplesToolStripMenuItem
        '
        Me.SamplesToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.POPMailToolStripMenuItem, Me.IMAPSSLToolStripMenuItem, Me.IMAPToolStripMenuItem, Me.POPSSLToolStripMenuItem, Me.StandardCoporateToolStripMenuItem})
        Me.SamplesToolStripMenuItem.Name = "SamplesToolStripMenuItem"
        Me.SamplesToolStripMenuItem.Size = New System.Drawing.Size(240, 22)
        Me.SamplesToolStripMenuItem.Text = "Samples"
        '
        'POPMailToolStripMenuItem
        '
        Me.POPMailToolStripMenuItem.Name = "POPMailToolStripMenuItem"
        Me.POPMailToolStripMenuItem.Size = New System.Drawing.Size(166, 22)
        Me.POPMailToolStripMenuItem.Text = "POP Mail"
        '
        'IMAPSSLToolStripMenuItem
        '
        Me.IMAPSSLToolStripMenuItem.Name = "IMAPSSLToolStripMenuItem"
        Me.IMAPSSLToolStripMenuItem.Size = New System.Drawing.Size(166, 22)
        Me.IMAPSSLToolStripMenuItem.Text = "IMAP SSL"
        '
        'IMAPToolStripMenuItem
        '
        Me.IMAPToolStripMenuItem.Name = "IMAPToolStripMenuItem"
        Me.IMAPToolStripMenuItem.Size = New System.Drawing.Size(166, 22)
        Me.IMAPToolStripMenuItem.Text = "IMAP "
        '
        'POPSSLToolStripMenuItem
        '
        Me.POPSSLToolStripMenuItem.Name = "POPSSLToolStripMenuItem"
        Me.POPSSLToolStripMenuItem.Size = New System.Drawing.Size(166, 22)
        Me.POPSSLToolStripMenuItem.Text = "POP SSL"
        '
        'StandardCoporateToolStripMenuItem
        '
        Me.StandardCoporateToolStripMenuItem.Name = "StandardCoporateToolStripMenuItem"
        Me.StandardCoporateToolStripMenuItem.Size = New System.Drawing.Size(166, 22)
        Me.StandardCoporateToolStripMenuItem.Text = "Standard Coporate"
        '
        'frmExhangeMail
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.ActiveBorder
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.ClientSize = New System.Drawing.Size(867, 697)
        Me.Controls.Add(Me.btnShoaAllLib)
        Me.Controls.Add(Me.btnTestConnection)
        Me.Controls.Add(Me.Panel1)
        Me.Controls.Add(Me.btnReset)
        Me.Controls.Add(Me.ckConvertEmlToMsg)
        Me.Controls.Add(Me.Label10)
        Me.Controls.Add(Me.txtReject)
        Me.Controls.Add(Me.btnTest)
        Me.Controls.Add(Me.nbrDaysToRetain)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.ckPublic)
        Me.Controls.Add(Me.cbLibrary)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.txtFolderName)
        Me.Controls.Add(Me.txtUserID)
        Me.Controls.Add(Me.btnEncrypt)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.btnDelete)
        Me.Controls.Add(Me.btnUpdate)
        Me.Controls.Add(Me.btnAdd)
        Me.Controls.Add(Me.cbHostName)
        Me.Controls.Add(Me.txtPortNumber)
        Me.Controls.Add(Me.txtPw)
        Me.Controls.Add(Me.txtUserLoginID)
        Me.Controls.Add(Me.cbRetention)
        Me.Controls.Add(Me.cbUsers)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.ckIMap)
        Me.Controls.Add(Me.ckDeleteAfterDownload)
        Me.Controls.Add(Me.ckSSL)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.dgExchange)
        Me.Controls.Add(Me.MenuStrip1)
        Me.f1Help.SetHelpString(Me, "http://www.ecmlibrary.com/_helpfiles/frmExchangeMail.htm")
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "frmExhangeMail"
        Me.f1Help.SetShowHelp(Me, True)
        Me.Text = "Exhange Mail"
        CType(Me.dgExchange, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.nbrDaysToRetain, System.ComponentModel.ISupportInitialize).EndInit()
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.ContextMenuStrip1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents dgExchange As System.Windows.Forms.DataGridView
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents ckSSL As System.Windows.Forms.CheckBox
    Friend WithEvents ckDeleteAfterDownload As System.Windows.Forms.CheckBox
    Friend WithEvents ckIMap As System.Windows.Forms.CheckBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents cbUsers As System.Windows.Forms.ComboBox
    Friend WithEvents cbRetention As System.Windows.Forms.ComboBox
    Friend WithEvents txtUserLoginID As System.Windows.Forms.TextBox
    Friend WithEvents txtPw As System.Windows.Forms.TextBox
    Friend WithEvents txtPortNumber As System.Windows.Forms.TextBox
    Friend WithEvents cbHostName As System.Windows.Forms.ComboBox
    Friend WithEvents btnAdd As System.Windows.Forms.Button
    Friend WithEvents btnUpdate As System.Windows.Forms.Button
    Friend WithEvents btnDelete As System.Windows.Forms.Button
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents btnEncrypt As System.Windows.Forms.Button
    Friend WithEvents f1Help As System.Windows.Forms.HelpProvider
    Friend WithEvents txtUserID As System.Windows.Forms.TextBox
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents HelpToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ECMLibraryExchangeInterfaceToolStripMenuItem1 As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Exchange2007Vs2003ToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ExchnageJournalingToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents txtFolderName As System.Windows.Forms.TextBox
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents cbLibrary As System.Windows.Forms.ComboBox
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents ckPublic As System.Windows.Forms.CheckBox
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents nbrDaysToRetain As System.Windows.Forms.NumericUpDown
    Friend WithEvents btnTest As System.Windows.Forms.Button
    Friend WithEvents txtReject As System.Windows.Forms.TextBox
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents ckConvertEmlToMsg As System.Windows.Forms.CheckBox
    Friend WithEvents btnReset As System.Windows.Forms.Button
    Friend WithEvents ckExcg2003 As System.Windows.Forms.CheckBox
    Friend WithEvents ckExcg2007 As System.Windows.Forms.CheckBox
    Friend WithEvents ckRtfFormat As System.Windows.Forms.CheckBox
    Friend WithEvents ckPlainText As System.Windows.Forms.CheckBox
    Friend WithEvents ckEnvelope As System.Windows.Forms.CheckBox
    Friend WithEvents ckJournaled As System.Windows.Forms.CheckBox
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents btnTestConnection As System.Windows.Forms.Button
    Friend WithEvents btnShoaAllLib As System.Windows.Forms.Button
    Friend WithEvents SamplePOPMailScreenToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SampleIMAPSSLScreenToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SampleIMAPScreenToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SamplePOPSSLMailScreenToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SampleCorporateEmailScreenToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ContextMenuStrip1 As System.Windows.Forms.ContextMenuStrip
    Friend WithEvents ComplianceOverviewToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ECMLibraryExchangeInterfaceToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents ExchangeJournalingToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SamplesToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents POPMailToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents IMAPSSLToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents IMAPToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents POPSSLToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents StandardCoporateToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
End Class
