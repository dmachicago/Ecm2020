<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class frmMain
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
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
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.txtPlain = New System.Windows.Forms.TextBox()
        Me.txtEncrypted = New System.Windows.Forms.TextBox()
        Me.btnEncrypt = New System.Windows.Forms.Button()
        Me.btnDecrypt = New System.Windows.Forms.Button()
        Me.btnCB01 = New System.Windows.Forms.Button()
        Me.btnCB02 = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.ckWindowsAuth = New System.Windows.Forms.CheckBox()
        Me.txtServerName = New System.Windows.Forms.TextBox()
        Me.txtInstanceName = New System.Windows.Forms.TextBox()
        Me.txtEcmUserName = New System.Windows.Forms.TextBox()
        Me.txtUserPW = New System.Windows.Forms.TextBox()
        Me.txtConnStr = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.btnTestConn = New System.Windows.Forms.Button()
        Me.btnEncConn = New System.Windows.Forms.Button()
        Me.btnGenConn = New System.Windows.Forms.Button()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.txtTimeOut = New System.Windows.Forms.TextBox()
        Me.txtDbName = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.btnParse = New System.Windows.Forms.Button()
        Me.btnParseCS = New System.Windows.Forms.Button()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.cbProvider = New System.Windows.Forms.ComboBox()
        Me.lblVerNo = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'txtPlain
        '
        Me.txtPlain.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtPlain.Location = New System.Drawing.Point(16, 15)
        Me.txtPlain.Margin = New System.Windows.Forms.Padding(4)
        Me.txtPlain.Multiline = True
        Me.txtPlain.Name = "txtPlain"
        Me.txtPlain.Size = New System.Drawing.Size(771, 156)
        Me.txtPlain.TabIndex = 0
        '
        'txtEncrypted
        '
        Me.txtEncrypted.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtEncrypted.Location = New System.Drawing.Point(17, 192)
        Me.txtEncrypted.Margin = New System.Windows.Forms.Padding(4)
        Me.txtEncrypted.Multiline = True
        Me.txtEncrypted.Name = "txtEncrypted"
        Me.txtEncrypted.Size = New System.Drawing.Size(771, 156)
        Me.txtEncrypted.TabIndex = 1
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnEncrypt.Location = New System.Drawing.Point(808, 15)
        Me.btnEncrypt.Margin = New System.Windows.Forms.Padding(4)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(107, 74)
        Me.btnEncrypt.TabIndex = 2
        Me.btnEncrypt.Text = "Encrypt"
        Me.btnEncrypt.UseVisualStyleBackColor = True
        '
        'btnDecrypt
        '
        Me.btnDecrypt.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnDecrypt.Location = New System.Drawing.Point(808, 192)
        Me.btnDecrypt.Margin = New System.Windows.Forms.Padding(4)
        Me.btnDecrypt.Name = "btnDecrypt"
        Me.btnDecrypt.Size = New System.Drawing.Size(107, 74)
        Me.btnDecrypt.TabIndex = 3
        Me.btnDecrypt.Text = "Decrypt"
        Me.btnDecrypt.UseVisualStyleBackColor = True
        '
        'btnCB01
        '
        Me.btnCB01.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnCB01.Location = New System.Drawing.Point(809, 97)
        Me.btnCB01.Margin = New System.Windows.Forms.Padding(4)
        Me.btnCB01.Name = "btnCB01"
        Me.btnCB01.Size = New System.Drawing.Size(107, 74)
        Me.btnCB01.TabIndex = 4
        Me.btnCB01.Text = "Clipboard Decrypted Text"
        Me.btnCB01.UseVisualStyleBackColor = True
        '
        'btnCB02
        '
        Me.btnCB02.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnCB02.Location = New System.Drawing.Point(809, 274)
        Me.btnCB02.Margin = New System.Windows.Forms.Padding(4)
        Me.btnCB02.Name = "btnCB02"
        Me.btnCB02.Size = New System.Drawing.Size(107, 74)
        Me.btnCB02.TabIndex = 5
        Me.btnCB02.Text = "Clipboard Ecrypted Text"
        Me.btnCB02.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(125, 376)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(111, 17)
        Me.Label1.TabIndex = 6
        Me.Label1.Text = "Server Name/IP:"
        '
        'Label2
        '
        Me.Label2.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(52, 407)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(184, 17)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "SQL Server Instance Name:"
        '
        'Label3
        '
        Me.Label3.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(75, 436)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(161, 17)
        Me.Label3.TabIndex = 8
        Me.Label3.Text = "SQL Server User Name:"
        '
        'Label4
        '
        Me.Label4.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(51, 467)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(185, 17)
        Me.Label4.TabIndex = 9
        Me.Label4.Text = "SQL Server User Password:"
        '
        'ckWindowsAuth
        '
        Me.ckWindowsAuth.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.ckWindowsAuth.AutoSize = True
        Me.ckWindowsAuth.Location = New System.Drawing.Point(492, 468)
        Me.ckWindowsAuth.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.ckWindowsAuth.Name = "ckWindowsAuth"
        Me.ckWindowsAuth.Size = New System.Drawing.Size(209, 21)
        Me.ckWindowsAuth.TabIndex = 10
        Me.ckWindowsAuth.Text = "Use Windows Authentication"
        Me.ckWindowsAuth.UseVisualStyleBackColor = True
        '
        'txtServerName
        '
        Me.txtServerName.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtServerName.Location = New System.Drawing.Point(243, 376)
        Me.txtServerName.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtServerName.Name = "txtServerName"
        Me.txtServerName.Size = New System.Drawing.Size(545, 22)
        Me.txtServerName.TabIndex = 11
        '
        'txtInstanceName
        '
        Me.txtInstanceName.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtInstanceName.Location = New System.Drawing.Point(243, 406)
        Me.txtInstanceName.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtInstanceName.Name = "txtInstanceName"
        Me.txtInstanceName.Size = New System.Drawing.Size(236, 22)
        Me.txtInstanceName.TabIndex = 12
        '
        'txtEcmUserName
        '
        Me.txtEcmUserName.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtEcmUserName.Location = New System.Drawing.Point(243, 436)
        Me.txtEcmUserName.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtEcmUserName.Name = "txtEcmUserName"
        Me.txtEcmUserName.Size = New System.Drawing.Size(236, 22)
        Me.txtEcmUserName.TabIndex = 14
        '
        'txtUserPW
        '
        Me.txtUserPW.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtUserPW.Location = New System.Drawing.Point(243, 466)
        Me.txtUserPW.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtUserPW.Name = "txtUserPW"
        Me.txtUserPW.Size = New System.Drawing.Size(236, 22)
        Me.txtUserPW.TabIndex = 15
        '
        'txtConnStr
        '
        Me.txtConnStr.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtConnStr.Location = New System.Drawing.Point(29, 624)
        Me.txtConnStr.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtConnStr.Name = "txtConnStr"
        Me.txtConnStr.Size = New System.Drawing.Size(887, 22)
        Me.txtConnStr.TabIndex = 16
        '
        'Label5
        '
        Me.Label5.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(29, 604)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(202, 17)
        Me.Label5.TabIndex = 17
        Me.Label5.Text = "SQL Server Connection String:"
        '
        'btnTestConn
        '
        Me.btnTestConn.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnTestConn.Location = New System.Drawing.Point(29, 652)
        Me.btnTestConn.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.btnTestConn.Name = "btnTestConn"
        Me.btnTestConn.Size = New System.Drawing.Size(141, 28)
        Me.btnTestConn.TabIndex = 18
        Me.btnTestConn.Text = "Test Connection"
        Me.btnTestConn.UseVisualStyleBackColor = True
        '
        'btnEncConn
        '
        Me.btnEncConn.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnEncConn.Location = New System.Drawing.Point(193, 652)
        Me.btnEncConn.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.btnEncConn.Name = "btnEncConn"
        Me.btnEncConn.Size = New System.Drawing.Size(141, 28)
        Me.btnEncConn.TabIndex = 19
        Me.btnEncConn.Text = "Encrypt"
        Me.btnEncConn.UseVisualStyleBackColor = True
        '
        'btnGenConn
        '
        Me.btnGenConn.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnGenConn.Location = New System.Drawing.Point(809, 376)
        Me.btnGenConn.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.btnGenConn.Name = "btnGenConn"
        Me.btnGenConn.Size = New System.Drawing.Size(109, 69)
        Me.btnGenConn.TabIndex = 20
        Me.btnGenConn.Text = "Generate"
        Me.btnGenConn.UseVisualStyleBackColor = True
        '
        'Label6
        '
        Me.Label6.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(489, 440)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(139, 17)
        Me.Label6.TabIndex = 21
        Me.Label6.Text = "Conn Timeout (secs)"
        '
        'txtTimeOut
        '
        Me.txtTimeOut.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtTimeOut.Location = New System.Drawing.Point(635, 436)
        Me.txtTimeOut.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtTimeOut.Name = "txtTimeOut"
        Me.txtTimeOut.Size = New System.Drawing.Size(69, 22)
        Me.txtTimeOut.TabIndex = 22
        Me.txtTimeOut.Text = "30"
        '
        'txtDbName
        '
        Me.txtDbName.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtDbName.Location = New System.Drawing.Point(567, 408)
        Me.txtDbName.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.txtDbName.Name = "txtDbName"
        Me.txtDbName.Size = New System.Drawing.Size(220, 22)
        Me.txtDbName.TabIndex = 24
        '
        'Label7
        '
        Me.Label7.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(489, 408)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(72, 17)
        Me.Label7.TabIndex = 23
        Me.Label7.Text = "DB Name:"
        '
        'btnParse
        '
        Me.btnParse.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnParse.Location = New System.Drawing.Point(773, 652)
        Me.btnParse.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.btnParse.Name = "btnParse"
        Me.btnParse.Size = New System.Drawing.Size(141, 28)
        Me.btnParse.TabIndex = 25
        Me.btnParse.Text = "Paste Clipboard"
        Me.btnParse.UseVisualStyleBackColor = True
        '
        'btnParseCS
        '
        Me.btnParseCS.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnParseCS.Location = New System.Drawing.Point(361, 653)
        Me.btnParseCS.Margin = New System.Windows.Forms.Padding(3, 2, 3, 2)
        Me.btnParseCS.Name = "btnParseCS"
        Me.btnParseCS.Size = New System.Drawing.Size(141, 28)
        Me.btnParseCS.TabIndex = 26
        Me.btnParseCS.Text = "Parse"
        Me.btnParseCS.UseVisualStyleBackColor = True
        '
        'Label8
        '
        Me.Label8.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(125, 500)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(106, 17)
        Me.Label8.TabIndex = 27
        Me.Label8.Text = "Provider Name:"
        '
        'cbProvider
        '
        Me.cbProvider.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.cbProvider.AutoCompleteCustomSource.AddRange(New String() {"System.Data.SqlClient"})
        Me.cbProvider.FormattingEnabled = True
        Me.cbProvider.Items.AddRange(New Object() {"NONE", "sqloledb", "SQLNCLI10", "System.Data.SqlClient"})
        Me.cbProvider.Location = New System.Drawing.Point(243, 496)
        Me.cbProvider.Margin = New System.Windows.Forms.Padding(4)
        Me.cbProvider.Name = "cbProvider"
        Me.cbProvider.Size = New System.Drawing.Size(236, 24)
        Me.cbProvider.TabIndex = 28
        '
        'lblVerNo
        '
        Me.lblVerNo.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblVerNo.AutoSize = True
        Me.lblVerNo.Location = New System.Drawing.Point(863, 604)
        Me.lblVerNo.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblVerNo.Name = "lblVerNo"
        Me.lblVerNo.Size = New System.Drawing.Size(51, 17)
        Me.lblVerNo.TabIndex = 29
        Me.lblVerNo.Text = "Label9"
        '
        'frmMain
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(937, 701)
        Me.Controls.Add(Me.lblVerNo)
        Me.Controls.Add(Me.cbProvider)
        Me.Controls.Add(Me.Label8)
        Me.Controls.Add(Me.btnParseCS)
        Me.Controls.Add(Me.btnParse)
        Me.Controls.Add(Me.txtDbName)
        Me.Controls.Add(Me.Label7)
        Me.Controls.Add(Me.txtTimeOut)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.btnGenConn)
        Me.Controls.Add(Me.btnEncConn)
        Me.Controls.Add(Me.btnTestConn)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.txtConnStr)
        Me.Controls.Add(Me.txtUserPW)
        Me.Controls.Add(Me.txtEcmUserName)
        Me.Controls.Add(Me.txtInstanceName)
        Me.Controls.Add(Me.txtServerName)
        Me.Controls.Add(Me.ckWindowsAuth)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.btnCB02)
        Me.Controls.Add(Me.btnCB01)
        Me.Controls.Add(Me.btnDecrypt)
        Me.Controls.Add(Me.btnEncrypt)
        Me.Controls.Add(Me.txtEncrypted)
        Me.Controls.Add(Me.txtPlain)
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.Name = "frmMain"
        Me.Text = "Encryption Module"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtPlain As System.Windows.Forms.TextBox
    Friend WithEvents txtEncrypted As System.Windows.Forms.TextBox
    Friend WithEvents btnEncrypt As System.Windows.Forms.Button
    Friend WithEvents btnDecrypt As System.Windows.Forms.Button
    Friend WithEvents btnCB01 As System.Windows.Forms.Button
    Friend WithEvents btnCB02 As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents ckWindowsAuth As System.Windows.Forms.CheckBox
    Friend WithEvents txtServerName As System.Windows.Forms.TextBox
    Friend WithEvents txtInstanceName As System.Windows.Forms.TextBox
    Friend WithEvents txtEcmUserName As System.Windows.Forms.TextBox
    Friend WithEvents txtUserPW As System.Windows.Forms.TextBox
    Friend WithEvents txtConnStr As System.Windows.Forms.TextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents btnTestConn As System.Windows.Forms.Button
    Friend WithEvents btnEncConn As System.Windows.Forms.Button
    Friend WithEvents btnGenConn As System.Windows.Forms.Button
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents txtTimeOut As System.Windows.Forms.TextBox
    Friend WithEvents txtDbName As System.Windows.Forms.TextBox
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents btnParse As System.Windows.Forms.Button
    Friend WithEvents btnParseCS As System.Windows.Forms.Button
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents cbProvider As System.Windows.Forms.ComboBox
    Friend WithEvents lblVerNo As Label
End Class
