<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmMain
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
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.btnAttach = New System.Windows.Forms.Button()
        Me.cbServers = New System.Windows.Forms.TextBox()
        Me.btnTest = New System.Windows.Forms.Button()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.cbDatabase = New System.Windows.Forms.TextBox()
        Me.cbInstance = New System.Windows.Forms.TextBox()
        Me.txtSSLoginID = New System.Windows.Forms.TextBox()
        Me.txtSSLoginPW = New System.Windows.Forms.TextBox()
        Me.txtEncPW = New System.Windows.Forms.TextBox()
        Me.cbCompanyID = New System.Windows.Forms.ComboBox()
        Me.txtRepoID = New System.Windows.Forms.TextBox()
        Me.btnFetch = New System.Windows.Forms.Button()
        Me.btnShowRepo = New System.Windows.Forms.Button()
        Me.btnDelete = New System.Windows.Forms.Button()
        Me.btnEncrypt = New System.Windows.Forms.Button()
        Me.btnClipBoard = New System.Windows.Forms.Button()
        Me.btnTestGetCS = New System.Windows.Forms.Button()
        Me.txtConnStr = New System.Windows.Forms.TextBox()
        Me.txtEncCS = New System.Windows.Forms.TextBox()
        Me.dgConnStr = New System.Windows.Forms.DataGridView()
        Me.btnEdit = New System.Windows.Forms.Button()
        Me.btnReorder = New System.Windows.Forms.Button()
        Me.btnDuplicate = New System.Windows.Forms.Button()
        Me.btnSyncUsers = New System.Windows.Forms.Button()
        Me.hlGenConnectionString = New System.Windows.Forms.Button()
        Me.hlGenConfigKey = New System.Windows.Forms.Button()
        Me.hlTestDecryption = New System.Windows.Forms.Button()
        Me.txtRemoteCS = New System.Windows.Forms.TextBox()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.ckSuccess = New System.Windows.Forms.CheckBox()
        Me.ckAttachedToSecureLoginMgr = New System.Windows.Forms.CheckBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.ckDisabled = New System.Windows.Forms.CheckBox()
        Me.ckThesaurus = New System.Windows.Forms.CheckBox()
        Me.btnSave = New System.Windows.Forms.Button()
        CType(Me.dgConnStr, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Location = New System.Drawing.Point(8, 16)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(89, 17)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Secure SVR:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Location = New System.Drawing.Point(8, 42)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(72, 17)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "DB Name:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.Location = New System.Drawing.Point(8, 70)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(65, 17)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Instance:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.Location = New System.Drawing.Point(8, 98)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(64, 17)
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "Login ID:"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.Label5.Location = New System.Drawing.Point(8, 126)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(73, 17)
        Me.Label5.TabIndex = 4
        Me.Label5.Text = "Login PW:"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.BackColor = System.Drawing.Color.Transparent
        Me.Label6.Location = New System.Drawing.Point(8, 155)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(88, 17)
        Me.Label6.TabIndex = 5
        Me.Label6.Text = "Comapny ID:"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.BackColor = System.Drawing.Color.Transparent
        Me.Label7.Location = New System.Drawing.Point(8, 185)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(55, 17)
        Me.Label7.TabIndex = 6
        Me.Label7.Text = "SL PW:"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.BackColor = System.Drawing.Color.Transparent
        Me.Label8.Location = New System.Drawing.Point(8, 213)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(63, 17)
        Me.Label8.TabIndex = 7
        Me.Label8.Text = "Repo ID:"
        '
        'btnAttach
        '
        Me.btnAttach.Location = New System.Drawing.Point(103, 9)
        Me.btnAttach.Name = "btnAttach"
        Me.btnAttach.Size = New System.Drawing.Size(75, 30)
        Me.btnAttach.TabIndex = 8
        Me.btnAttach.Text = "Attach"
        Me.btnAttach.UseVisualStyleBackColor = True
        '
        'cbServers
        '
        Me.cbServers.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbServers.Location = New System.Drawing.Point(185, 13)
        Me.cbServers.Name = "cbServers"
        Me.cbServers.Size = New System.Drawing.Size(276, 22)
        Me.cbServers.TabIndex = 9
        '
        'btnTest
        '
        Me.btnTest.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnTest.Location = New System.Drawing.Point(467, 9)
        Me.btnTest.Name = "btnTest"
        Me.btnTest.Size = New System.Drawing.Size(75, 30)
        Me.btnTest.TabIndex = 10
        Me.btnTest.Text = "Test"
        Me.btnTest.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Button1.Location = New System.Drawing.Point(548, 9)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(75, 30)
        Me.Button1.TabIndex = 11
        Me.Button1.Text = "Fill"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'cbDatabase
        '
        Me.cbDatabase.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbDatabase.Location = New System.Drawing.Point(103, 42)
        Me.cbDatabase.Name = "cbDatabase"
        Me.cbDatabase.Size = New System.Drawing.Size(358, 22)
        Me.cbDatabase.TabIndex = 12
        '
        'cbInstance
        '
        Me.cbInstance.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbInstance.Location = New System.Drawing.Point(103, 70)
        Me.cbInstance.Name = "cbInstance"
        Me.cbInstance.Size = New System.Drawing.Size(358, 22)
        Me.cbInstance.TabIndex = 13
        '
        'txtSSLoginID
        '
        Me.txtSSLoginID.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtSSLoginID.Location = New System.Drawing.Point(103, 98)
        Me.txtSSLoginID.Name = "txtSSLoginID"
        Me.txtSSLoginID.Size = New System.Drawing.Size(175, 22)
        Me.txtSSLoginID.TabIndex = 14
        '
        'txtSSLoginPW
        '
        Me.txtSSLoginPW.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtSSLoginPW.Location = New System.Drawing.Point(103, 126)
        Me.txtSSLoginPW.Name = "txtSSLoginPW"
        Me.txtSSLoginPW.Size = New System.Drawing.Size(358, 22)
        Me.txtSSLoginPW.TabIndex = 15
        '
        'txtEncPW
        '
        Me.txtEncPW.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtEncPW.Location = New System.Drawing.Point(103, 185)
        Me.txtEncPW.Name = "txtEncPW"
        Me.txtEncPW.Size = New System.Drawing.Size(358, 22)
        Me.txtEncPW.TabIndex = 16
        Me.ToolTip1.SetToolTip(Me.txtEncPW, "Secure Login Password")
        '
        'cbCompanyID
        '
        Me.cbCompanyID.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbCompanyID.FormattingEnabled = True
        Me.cbCompanyID.Location = New System.Drawing.Point(103, 155)
        Me.cbCompanyID.Name = "cbCompanyID"
        Me.cbCompanyID.Size = New System.Drawing.Size(358, 24)
        Me.cbCompanyID.TabIndex = 17
        '
        'txtRepoID
        '
        Me.txtRepoID.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtRepoID.Location = New System.Drawing.Point(103, 213)
        Me.txtRepoID.Name = "txtRepoID"
        Me.txtRepoID.Size = New System.Drawing.Size(358, 22)
        Me.txtRepoID.TabIndex = 18
        '
        'btnFetch
        '
        Me.btnFetch.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnFetch.Location = New System.Drawing.Point(467, 152)
        Me.btnFetch.Name = "btnFetch"
        Me.btnFetch.Size = New System.Drawing.Size(75, 30)
        Me.btnFetch.TabIndex = 19
        Me.btnFetch.Text = "Fetch"
        Me.btnFetch.UseVisualStyleBackColor = True
        '
        'btnShowRepo
        '
        Me.btnShowRepo.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnShowRepo.Location = New System.Drawing.Point(467, 209)
        Me.btnShowRepo.Name = "btnShowRepo"
        Me.btnShowRepo.Size = New System.Drawing.Size(75, 30)
        Me.btnShowRepo.TabIndex = 20
        Me.btnShowRepo.Text = "Display"
        Me.btnShowRepo.UseVisualStyleBackColor = True
        Me.btnShowRepo.Visible = False
        '
        'btnDelete
        '
        Me.btnDelete.Location = New System.Drawing.Point(103, 241)
        Me.btnDelete.Name = "btnDelete"
        Me.btnDelete.Size = New System.Drawing.Size(88, 30)
        Me.btnDelete.TabIndex = 21
        Me.btnDelete.Text = "Delete"
        Me.btnDelete.UseVisualStyleBackColor = True
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Location = New System.Drawing.Point(197, 241)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(88, 30)
        Me.btnEncrypt.TabIndex = 22
        Me.btnEncrypt.Text = "Encrypt"
        Me.btnEncrypt.UseVisualStyleBackColor = True
        '
        'btnClipBoard
        '
        Me.btnClipBoard.Location = New System.Drawing.Point(291, 241)
        Me.btnClipBoard.Name = "btnClipBoard"
        Me.btnClipBoard.Size = New System.Drawing.Size(88, 30)
        Me.btnClipBoard.TabIndex = 23
        Me.btnClipBoard.Text = "Clipboard"
        Me.btnClipBoard.UseVisualStyleBackColor = True
        '
        'btnTestGetCS
        '
        Me.btnTestGetCS.Location = New System.Drawing.Point(385, 241)
        Me.btnTestGetCS.Name = "btnTestGetCS"
        Me.btnTestGetCS.Size = New System.Drawing.Size(76, 30)
        Me.btnTestGetCS.TabIndex = 24
        Me.btnTestGetCS.Text = "Get CS"
        Me.btnTestGetCS.UseVisualStyleBackColor = True
        '
        'txtConnStr
        '
        Me.txtConnStr.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtConnStr.Location = New System.Drawing.Point(103, 299)
        Me.txtConnStr.Name = "txtConnStr"
        Me.txtConnStr.Size = New System.Drawing.Size(519, 22)
        Me.txtConnStr.TabIndex = 25
        '
        'txtEncCS
        '
        Me.txtEncCS.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtEncCS.Location = New System.Drawing.Point(103, 327)
        Me.txtEncCS.Name = "txtEncCS"
        Me.txtEncCS.Size = New System.Drawing.Size(519, 22)
        Me.txtEncCS.TabIndex = 26
        '
        'dgConnStr
        '
        Me.dgConnStr.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.dgConnStr.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.dgConnStr.Location = New System.Drawing.Point(103, 356)
        Me.dgConnStr.Name = "dgConnStr"
        Me.dgConnStr.RowTemplate.Height = 24
        Me.dgConnStr.Size = New System.Drawing.Size(519, 150)
        Me.dgConnStr.TabIndex = 27
        '
        'btnEdit
        '
        Me.btnEdit.Location = New System.Drawing.Point(22, 356)
        Me.btnEdit.Name = "btnEdit"
        Me.btnEdit.Size = New System.Drawing.Size(75, 30)
        Me.btnEdit.TabIndex = 28
        Me.btnEdit.Text = "Edit"
        Me.btnEdit.UseVisualStyleBackColor = True
        '
        'btnReorder
        '
        Me.btnReorder.Location = New System.Drawing.Point(22, 385)
        Me.btnReorder.Name = "btnReorder"
        Me.btnReorder.Size = New System.Drawing.Size(75, 30)
        Me.btnReorder.TabIndex = 29
        Me.btnReorder.Text = "Order"
        Me.btnReorder.UseVisualStyleBackColor = True
        '
        'btnDuplicate
        '
        Me.btnDuplicate.Location = New System.Drawing.Point(22, 414)
        Me.btnDuplicate.Name = "btnDuplicate"
        Me.btnDuplicate.Size = New System.Drawing.Size(75, 30)
        Me.btnDuplicate.TabIndex = 30
        Me.btnDuplicate.Text = "DUP"
        Me.btnDuplicate.UseVisualStyleBackColor = True
        '
        'btnSyncUsers
        '
        Me.btnSyncUsers.Location = New System.Drawing.Point(22, 459)
        Me.btnSyncUsers.Name = "btnSyncUsers"
        Me.btnSyncUsers.Size = New System.Drawing.Size(75, 47)
        Me.btnSyncUsers.TabIndex = 31
        Me.btnSyncUsers.Text = "Sync Users"
        Me.btnSyncUsers.UseVisualStyleBackColor = True
        '
        'hlGenConnectionString
        '
        Me.hlGenConnectionString.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.hlGenConnectionString.Location = New System.Drawing.Point(102, 512)
        Me.hlGenConnectionString.Name = "hlGenConnectionString"
        Me.hlGenConnectionString.Size = New System.Drawing.Size(156, 30)
        Me.hlGenConnectionString.TabIndex = 32
        Me.hlGenConnectionString.Text = "Generate CS"
        Me.hlGenConnectionString.UseVisualStyleBackColor = True
        '
        'hlGenConfigKey
        '
        Me.hlGenConfigKey.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.hlGenConfigKey.Location = New System.Drawing.Point(284, 512)
        Me.hlGenConfigKey.Name = "hlGenConfigKey"
        Me.hlGenConfigKey.Size = New System.Drawing.Size(156, 30)
        Me.hlGenConfigKey.TabIndex = 33
        Me.hlGenConfigKey.Text = "Gen Config CS"
        Me.hlGenConfigKey.UseVisualStyleBackColor = True
        '
        'hlTestDecryption
        '
        Me.hlTestDecryption.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.hlTestDecryption.Location = New System.Drawing.Point(465, 512)
        Me.hlTestDecryption.Name = "hlTestDecryption"
        Me.hlTestDecryption.Size = New System.Drawing.Size(156, 30)
        Me.hlTestDecryption.TabIndex = 34
        Me.hlTestDecryption.Text = "Test Decrypt"
        Me.hlTestDecryption.UseVisualStyleBackColor = True
        '
        'txtRemoteCS
        '
        Me.txtRemoteCS.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtRemoteCS.Location = New System.Drawing.Point(102, 552)
        Me.txtRemoteCS.Name = "txtRemoteCS"
        Me.txtRemoteCS.Size = New System.Drawing.Size(519, 22)
        Me.txtRemoteCS.TabIndex = 35
        '
        'SB
        '
        Me.SB.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(64, Byte), Integer))
        Me.SB.ForeColor = System.Drawing.Color.Yellow
        Me.SB.Location = New System.Drawing.Point(102, 580)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(519, 22)
        Me.SB.TabIndex = 36
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.BackColor = System.Drawing.Color.Transparent
        Me.Label9.Location = New System.Drawing.Point(-1, 330)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(98, 17)
        Me.Label9.TabIndex = 37
        Me.Label9.Text = "Encrypted CS:"
        '
        'ckSuccess
        '
        Me.ckSuccess.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckSuccess.AutoSize = True
        Me.ckSuccess.BackColor = System.Drawing.Color.Transparent
        Me.ckSuccess.Location = New System.Drawing.Point(471, 42)
        Me.ckSuccess.Name = "ckSuccess"
        Me.ckSuccess.Size = New System.Drawing.Size(83, 21)
        Me.ckSuccess.TabIndex = 38
        Me.ckSuccess.Text = "Success"
        Me.ckSuccess.UseVisualStyleBackColor = False
        '
        'ckAttachedToSecureLoginMgr
        '
        Me.ckAttachedToSecureLoginMgr.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckAttachedToSecureLoginMgr.AutoSize = True
        Me.ckAttachedToSecureLoginMgr.BackColor = System.Drawing.Color.Transparent
        Me.ckAttachedToSecureLoginMgr.Location = New System.Drawing.Point(471, 72)
        Me.ckAttachedToSecureLoginMgr.Name = "ckAttachedToSecureLoginMgr"
        Me.ckAttachedToSecureLoginMgr.Size = New System.Drawing.Size(86, 21)
        Me.ckAttachedToSecureLoginMgr.TabIndex = 39
        Me.ckAttachedToSecureLoginMgr.Text = "Attached"
        Me.ckAttachedToSecureLoginMgr.UseVisualStyleBackColor = False
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.BackColor = System.Drawing.Color.Transparent
        Me.Label10.Location = New System.Drawing.Point(5, 304)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(67, 17)
        Me.Label10.TabIndex = 40
        Me.Label10.Text = "Conn Str:"
        '
        'Label11
        '
        Me.Label11.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label11.AutoSize = True
        Me.Label11.BackColor = System.Drawing.Color.Transparent
        Me.Label11.Font = New System.Drawing.Font("Microsoft Sans Serif", 7.8!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label11.ForeColor = System.Drawing.Color.Maroon
        Me.Label11.Location = New System.Drawing.Point(-1, 597)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(86, 17)
        Me.Label11.TabIndex = 41
        Me.Label11.Text = "11.08.18.1"
        '
        'ckDisabled
        '
        Me.ckDisabled.AutoSize = True
        Me.ckDisabled.BackColor = System.Drawing.Color.Transparent
        Me.ckDisabled.Location = New System.Drawing.Point(103, 270)
        Me.ckDisabled.Name = "ckDisabled"
        Me.ckDisabled.Size = New System.Drawing.Size(160, 21)
        Me.ckDisabled.TabIndex = 42
        Me.ckDisabled.Text = "Connection Disabled"
        Me.ckDisabled.UseVisualStyleBackColor = False
        '
        'ckThesaurus
        '
        Me.ckThesaurus.AutoSize = True
        Me.ckThesaurus.BackColor = System.Drawing.Color.Transparent
        Me.ckThesaurus.Location = New System.Drawing.Point(291, 272)
        Me.ckThesaurus.Name = "ckThesaurus"
        Me.ckThesaurus.Size = New System.Drawing.Size(173, 21)
        Me.ckThesaurus.TabIndex = 43
        Me.ckThesaurus.Text = "Thesaurus Connection"
        Me.ckThesaurus.UseVisualStyleBackColor = False
        '
        'btnSave
        '
        Me.btnSave.Location = New System.Drawing.Point(465, 242)
        Me.btnSave.Name = "btnSave"
        Me.btnSave.Size = New System.Drawing.Size(76, 30)
        Me.btnSave.TabIndex = 44
        Me.btnSave.Text = "SAVE"
        Me.btnSave.UseVisualStyleBackColor = True
        Me.btnSave.Visible = False
        '
        'frmMain
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.Gray
        Me.BackgroundImage = Global.ECMSecureAttachWF.My.Resources.Resources.City
        Me.ClientSize = New System.Drawing.Size(634, 614)
        Me.Controls.Add(Me.btnSave)
        Me.Controls.Add(Me.ckThesaurus)
        Me.Controls.Add(Me.ckDisabled)
        Me.Controls.Add(Me.Label11)
        Me.Controls.Add(Me.Label10)
        Me.Controls.Add(Me.ckAttachedToSecureLoginMgr)
        Me.Controls.Add(Me.ckSuccess)
        Me.Controls.Add(Me.Label9)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.txtRemoteCS)
        Me.Controls.Add(Me.hlTestDecryption)
        Me.Controls.Add(Me.hlGenConfigKey)
        Me.Controls.Add(Me.hlGenConnectionString)
        Me.Controls.Add(Me.btnSyncUsers)
        Me.Controls.Add(Me.btnDuplicate)
        Me.Controls.Add(Me.btnReorder)
        Me.Controls.Add(Me.btnEdit)
        Me.Controls.Add(Me.dgConnStr)
        Me.Controls.Add(Me.txtEncCS)
        Me.Controls.Add(Me.txtConnStr)
        Me.Controls.Add(Me.btnTestGetCS)
        Me.Controls.Add(Me.btnClipBoard)
        Me.Controls.Add(Me.btnEncrypt)
        Me.Controls.Add(Me.btnDelete)
        Me.Controls.Add(Me.btnShowRepo)
        Me.Controls.Add(Me.btnFetch)
        Me.Controls.Add(Me.txtRepoID)
        Me.Controls.Add(Me.cbCompanyID)
        Me.Controls.Add(Me.txtEncPW)
        Me.Controls.Add(Me.txtSSLoginPW)
        Me.Controls.Add(Me.txtSSLoginID)
        Me.Controls.Add(Me.cbInstance)
        Me.Controls.Add(Me.cbDatabase)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.btnTest)
        Me.Controls.Add(Me.cbServers)
        Me.Controls.Add(Me.btnAttach)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Name = "frmMain"
        Me.Text = "Secure Attach Admin"
        CType(Me.dgConnStr, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents Label4 As Label
    Friend WithEvents Label5 As Label
    Friend WithEvents Label6 As Label
    Friend WithEvents Label7 As Label
    Friend WithEvents Label8 As Label
    Friend WithEvents btnAttach As Button
    Friend WithEvents cbServers As TextBox
    Friend WithEvents btnTest As Button
    Friend WithEvents Button1 As Button
    Friend WithEvents cbDatabase As TextBox
    Friend WithEvents cbInstance As TextBox
    Friend WithEvents txtSSLoginID As TextBox
    Friend WithEvents txtSSLoginPW As TextBox
    Friend WithEvents txtEncPW As TextBox
    Friend WithEvents cbCompanyID As ComboBox
    Friend WithEvents txtRepoID As TextBox
    Friend WithEvents btnFetch As Button
    Friend WithEvents btnShowRepo As Button
    Friend WithEvents btnDelete As Button
    Friend WithEvents btnEncrypt As Button
    Friend WithEvents btnClipBoard As Button
    Friend WithEvents btnTestGetCS As Button
    Friend WithEvents txtConnStr As TextBox
    Friend WithEvents txtEncCS As TextBox
    Friend WithEvents dgConnStr As DataGridView
    Friend WithEvents btnEdit As Button
    Friend WithEvents btnReorder As Button
    Friend WithEvents btnDuplicate As Button
    Friend WithEvents btnSyncUsers As Button
    Friend WithEvents hlGenConnectionString As Button
    Friend WithEvents hlGenConfigKey As Button
    Friend WithEvents hlTestDecryption As Button
    Friend WithEvents txtRemoteCS As TextBox
    Friend WithEvents SB As TextBox
    Friend WithEvents Label9 As Label
    Friend WithEvents ckSuccess As CheckBox
    Friend WithEvents ckAttachedToSecureLoginMgr As CheckBox
    Friend WithEvents Label10 As Label
    Friend WithEvents ToolTip1 As ToolTip
    Friend WithEvents Label11 As Label
    Friend WithEvents ckDisabled As CheckBox
    Friend WithEvents ckThesaurus As CheckBox
    Friend WithEvents btnSave As Button
End Class
