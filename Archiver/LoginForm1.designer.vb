<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<Global.System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1726")> _
Partial Class LoginForm1
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
    Friend WithEvents LogoPictureBox As System.Windows.Forms.PictureBox
    Friend WithEvents UsernameLabel As System.Windows.Forms.Label
    Friend WithEvents PasswordLabel As System.Windows.Forms.Label
    Friend WithEvents txtLoginID As System.Windows.Forms.TextBox
    Friend WithEvents PasswordTextBox As System.Windows.Forms.TextBox
    Friend WithEvents OK As System.Windows.Forms.Button
    Friend WithEvents Cancel As System.Windows.Forms.Button

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(LoginForm1))
        Me.LogoPictureBox = New System.Windows.Forms.PictureBox()
        Me.UsernameLabel = New System.Windows.Forms.Label()
        Me.PasswordLabel = New System.Windows.Forms.Label()
        Me.txtLoginID = New System.Windows.Forms.TextBox()
        Me.PasswordTextBox = New System.Windows.Forms.TextBox()
        Me.OK = New System.Windows.Forms.Button()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.btnChgPW = New System.Windows.Forms.Button()
        Me.lblRepo = New System.Windows.Forms.Label()
        Me.ckDisableListener = New System.Windows.Forms.CheckBox()
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.ckSaveAsDefaultLogin = New System.Windows.Forms.CheckBox()
        Me.lblAttachedMachineName = New System.Windows.Forms.Label()
        Me.lblCurrUserGuidID = New System.Windows.Forms.Label()
        Me.lblServerInstanceName = New System.Windows.Forms.Label()
        Me.lblLocalIP = New System.Windows.Forms.Label()
        Me.lblServerMachineName = New System.Windows.Forms.Label()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.Panel2 = New System.Windows.Forms.Panel()
        Me.ckAutoExecute = New System.Windows.Forms.CheckBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.lblNetworkID = New System.Windows.Forms.Label()
        Me.ckCancelAutoLogin = New System.Windows.Forms.CheckBox()
        Me.lblMsg = New System.Windows.Forms.Label()
        Me.Timer2 = New System.Windows.Forms.Timer(Me.components)
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.PictureBox1 = New System.Windows.Forms.PictureBox()
        Me.lblExecTime = New System.Windows.Forms.Label()
        Me.btnStopExec = New System.Windows.Forms.Button()
        Me.Timer3 = New System.Windows.Forms.Timer(Me.components)
        CType(Me.LogoPictureBox, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Panel2.SuspendLayout()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'LogoPictureBox
        '
        Me.LogoPictureBox.Image = CType(resources.GetObject("LogoPictureBox.Image"), System.Drawing.Image)
        Me.LogoPictureBox.Location = New System.Drawing.Point(16, 0)
        Me.LogoPictureBox.Margin = New System.Windows.Forms.Padding(4)
        Me.LogoPictureBox.Name = "LogoPictureBox"
        Me.LogoPictureBox.Size = New System.Drawing.Size(129, 96)
        Me.LogoPictureBox.TabIndex = 0
        Me.LogoPictureBox.TabStop = False
        '
        'UsernameLabel
        '
        Me.UsernameLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.UsernameLabel.ForeColor = System.Drawing.Color.Maroon
        Me.UsernameLabel.Location = New System.Drawing.Point(19, 0)
        Me.UsernameLabel.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.UsernameLabel.Name = "UsernameLabel"
        Me.UsernameLabel.Size = New System.Drawing.Size(293, 28)
        Me.UsernameLabel.TabIndex = 0
        Me.UsernameLabel.Text = "Login ID"
        Me.UsernameLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'PasswordLabel
        '
        Me.PasswordLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.PasswordLabel.ForeColor = System.Drawing.Color.Maroon
        Me.PasswordLabel.Location = New System.Drawing.Point(316, 0)
        Me.PasswordLabel.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.PasswordLabel.Name = "PasswordLabel"
        Me.PasswordLabel.Size = New System.Drawing.Size(247, 28)
        Me.PasswordLabel.TabIndex = 2
        Me.PasswordLabel.Text = "&Password"
        Me.PasswordLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'txtLoginID
        '
        Me.txtLoginID.BackColor = System.Drawing.Color.Gainsboro
        Me.txtLoginID.Location = New System.Drawing.Point(19, 32)
        Me.txtLoginID.Margin = New System.Windows.Forms.Padding(4)
        Me.txtLoginID.Name = "txtLoginID"
        Me.txtLoginID.Size = New System.Drawing.Size(292, 22)
        Me.txtLoginID.TabIndex = 1
        '
        'PasswordTextBox
        '
        Me.PasswordTextBox.BackColor = System.Drawing.Color.Gainsboro
        Me.PasswordTextBox.Location = New System.Drawing.Point(320, 32)
        Me.PasswordTextBox.Margin = New System.Windows.Forms.Padding(4)
        Me.PasswordTextBox.Name = "PasswordTextBox"
        Me.PasswordTextBox.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.PasswordTextBox.Size = New System.Drawing.Size(241, 22)
        Me.PasswordTextBox.TabIndex = 3
        '
        'OK
        '
        Me.OK.Location = New System.Drawing.Point(437, 98)
        Me.OK.Margin = New System.Windows.Forms.Padding(4)
        Me.OK.Name = "OK"
        Me.OK.Size = New System.Drawing.Size(125, 28)
        Me.OK.TabIndex = 4
        Me.OK.Text = "&Login"
        '
        'Cancel
        '
        Me.Cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Cancel.Location = New System.Drawing.Point(237, 98)
        Me.Cancel.Margin = New System.Windows.Forms.Padding(4)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.Size = New System.Drawing.Size(125, 28)
        Me.Cancel.TabIndex = 5
        Me.Cancel.Text = "&Cancel"
        '
        'btnChgPW
        '
        Me.btnChgPW.Location = New System.Drawing.Point(19, 98)
        Me.btnChgPW.Margin = New System.Windows.Forms.Padding(4)
        Me.btnChgPW.Name = "btnChgPW"
        Me.btnChgPW.Size = New System.Drawing.Size(125, 28)
        Me.btnChgPW.TabIndex = 22
        Me.btnChgPW.Text = "&Password"
        Me.TT.SetToolTip(Me.btnChgPW, "Press to change your password.")
        '
        'lblRepo
        '
        Me.lblRepo.AutoSize = True
        Me.lblRepo.Location = New System.Drawing.Point(665, 199)
        Me.lblRepo.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblRepo.Name = "lblRepo"
        Me.lblRepo.Size = New System.Drawing.Size(76, 17)
        Me.lblRepo.TabIndex = 28
        Me.lblRepo.Text = "Repository"
        Me.TT.SetToolTip(Me.lblRepo, "Selected repository from Gateway")
        '
        'ckDisableListener
        '
        Me.ckDisableListener.AutoSize = True
        Me.ckDisableListener.BackColor = System.Drawing.Color.DarkRed
        Me.ckDisableListener.ForeColor = System.Drawing.Color.Yellow
        Me.ckDisableListener.Location = New System.Drawing.Point(19, 134)
        Me.ckDisableListener.Name = "ckDisableListener"
        Me.ckDisableListener.Size = New System.Drawing.Size(139, 21)
        Me.ckDisableListener.TabIndex = 25
        Me.ckDisableListener.Text = "Disable Listeners"
        Me.TT.SetToolTip(Me.ckDisableListener, "Disable listener processing for this run only.")
        Me.ckDisableListener.UseVisualStyleBackColor = False
        '
        'Timer1
        '
        '
        'ckSaveAsDefaultLogin
        '
        Me.ckSaveAsDefaultLogin.AutoSize = True
        Me.ckSaveAsDefaultLogin.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckSaveAsDefaultLogin.ForeColor = System.Drawing.Color.Maroon
        Me.ckSaveAsDefaultLogin.Location = New System.Drawing.Point(19, 64)
        Me.ckSaveAsDefaultLogin.Margin = New System.Windows.Forms.Padding(4)
        Me.ckSaveAsDefaultLogin.Name = "ckSaveAsDefaultLogin"
        Me.ckSaveAsDefaultLogin.Size = New System.Drawing.Size(286, 21)
        Me.ckSaveAsDefaultLogin.TabIndex = 6
        Me.ckSaveAsDefaultLogin.Text = "Save as default login for auto-login"
        Me.ckSaveAsDefaultLogin.UseVisualStyleBackColor = True
        '
        'lblAttachedMachineName
        '
        Me.lblAttachedMachineName.AutoSize = True
        Me.lblAttachedMachineName.Location = New System.Drawing.Point(665, 17)
        Me.lblAttachedMachineName.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblAttachedMachineName.Name = "lblAttachedMachineName"
        Me.lblAttachedMachineName.Size = New System.Drawing.Size(102, 17)
        Me.lblAttachedMachineName.TabIndex = 16
        Me.lblAttachedMachineName.Text = "Machine Name"
        '
        'lblCurrUserGuidID
        '
        Me.lblCurrUserGuidID.AutoSize = True
        Me.lblCurrUserGuidID.Location = New System.Drawing.Point(665, 46)
        Me.lblCurrUserGuidID.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblCurrUserGuidID.Name = "lblCurrUserGuidID"
        Me.lblCurrUserGuidID.Size = New System.Drawing.Size(55, 17)
        Me.lblCurrUserGuidID.TabIndex = 17
        Me.lblCurrUserGuidID.Text = "User ID"
        '
        'lblServerInstanceName
        '
        Me.lblServerInstanceName.AutoSize = True
        Me.lblServerInstanceName.Location = New System.Drawing.Point(665, 108)
        Me.lblServerInstanceName.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblServerInstanceName.Name = "lblServerInstanceName"
        Me.lblServerInstanceName.Size = New System.Drawing.Size(102, 17)
        Me.lblServerInstanceName.TabIndex = 19
        Me.lblServerInstanceName.Text = "Instance Name"
        '
        'lblLocalIP
        '
        Me.lblLocalIP.AutoSize = True
        Me.lblLocalIP.Location = New System.Drawing.Point(665, 80)
        Me.lblLocalIP.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblLocalIP.Name = "lblLocalIP"
        Me.lblLocalIP.Size = New System.Drawing.Size(58, 17)
        Me.lblLocalIP.TabIndex = 18
        Me.lblLocalIP.Text = "Local IP"
        '
        'lblServerMachineName
        '
        Me.lblServerMachineName.AutoSize = True
        Me.lblServerMachineName.Location = New System.Drawing.Point(665, 140)
        Me.lblServerMachineName.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblServerMachineName.Name = "lblServerMachineName"
        Me.lblServerMachineName.Size = New System.Drawing.Size(91, 17)
        Me.lblServerMachineName.TabIndex = 20
        Me.lblServerMachineName.Text = "Server Name"
        '
        'SB
        '
        Me.SB.BackColor = System.Drawing.Color.WhiteSmoke
        Me.SB.Location = New System.Drawing.Point(13, 280)
        Me.SB.Margin = New System.Windows.Forms.Padding(4)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(916, 22)
        Me.SB.TabIndex = 21
        '
        'Panel2
        '
        Me.Panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.Panel2.Controls.Add(Me.ckDisableListener)
        Me.Panel2.Controls.Add(Me.ckAutoExecute)
        Me.Panel2.Controls.Add(Me.Button1)
        Me.Panel2.Controls.Add(Me.btnChgPW)
        Me.Panel2.Controls.Add(Me.ckSaveAsDefaultLogin)
        Me.Panel2.Controls.Add(Me.Cancel)
        Me.Panel2.Controls.Add(Me.OK)
        Me.Panel2.Controls.Add(Me.PasswordTextBox)
        Me.Panel2.Controls.Add(Me.txtLoginID)
        Me.Panel2.Controls.Add(Me.PasswordLabel)
        Me.Panel2.Controls.Add(Me.UsernameLabel)
        Me.Panel2.Location = New System.Drawing.Point(16, 100)
        Me.Panel2.Margin = New System.Windows.Forms.Padding(4)
        Me.Panel2.Name = "Panel2"
        Me.Panel2.Size = New System.Drawing.Size(603, 163)
        Me.Panel2.TabIndex = 24
        '
        'ckAutoExecute
        '
        Me.ckAutoExecute.AutoSize = True
        Me.ckAutoExecute.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ckAutoExecute.ForeColor = System.Drawing.Color.Maroon
        Me.ckAutoExecute.Location = New System.Drawing.Point(320, 64)
        Me.ckAutoExecute.Margin = New System.Windows.Forms.Padding(4)
        Me.ckAutoExecute.Name = "ckAutoExecute"
        Me.ckAutoExecute.Size = New System.Drawing.Size(126, 21)
        Me.ckAutoExecute.TabIndex = 24
        Me.ckAutoExecute.Text = "Auto-Execute"
        Me.ckAutoExecute.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Button1.Location = New System.Drawing.Point(438, 127)
        Me.Button1.Margin = New System.Windows.Forms.Padding(4)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(125, 28)
        Me.Button1.TabIndex = 23
        Me.Button1.Text = "Show CS"
        Me.Button1.Visible = False
        '
        'lblNetworkID
        '
        Me.lblNetworkID.AutoSize = True
        Me.lblNetworkID.Location = New System.Drawing.Point(665, 171)
        Me.lblNetworkID.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblNetworkID.Name = "lblNetworkID"
        Me.lblNetworkID.Size = New System.Drawing.Size(91, 17)
        Me.lblNetworkID.TabIndex = 25
        Me.lblNetworkID.Text = "Server Name"
        '
        'ckCancelAutoLogin
        '
        Me.ckCancelAutoLogin.AutoSize = True
        Me.ckCancelAutoLogin.Location = New System.Drawing.Point(440, 33)
        Me.ckCancelAutoLogin.Margin = New System.Windows.Forms.Padding(4)
        Me.ckCancelAutoLogin.Name = "ckCancelAutoLogin"
        Me.ckCancelAutoLogin.Size = New System.Drawing.Size(141, 21)
        Me.ckCancelAutoLogin.TabIndex = 26
        Me.ckCancelAutoLogin.Text = "Cancel Auto-login"
        Me.ckCancelAutoLogin.UseVisualStyleBackColor = True
        '
        'lblMsg
        '
        Me.lblMsg.AutoSize = True
        Me.lblMsg.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblMsg.ForeColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.lblMsg.Location = New System.Drawing.Point(436, 10)
        Me.lblMsg.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblMsg.Name = "lblMsg"
        Me.lblMsg.Size = New System.Drawing.Size(84, 20)
        Me.lblMsg.TabIndex = 27
        Me.lblMsg.Text = "Message"
        '
        'Timer2
        '
        Me.Timer2.Interval = 1000
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(665, 246)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(40, 17)
        Me.Label4.TabIndex = 29
        Me.Label4.Text = "3.2.3"
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 24.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.Color.Navy
        Me.Label5.Location = New System.Drawing.Point(153, 2)
        Me.Label5.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(112, 46)
        Me.Label5.TabIndex = 30
        Me.Label5.Text = "ECM"
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Font = New System.Drawing.Font("Microsoft Sans Serif", 21.75!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.ForeColor = System.Drawing.Color.Navy
        Me.Label6.Location = New System.Drawing.Point(203, 48)
        Me.Label6.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(139, 42)
        Me.Label6.TabIndex = 31
        Me.Label6.Text = "Library"
        '
        'PictureBox1
        '
        Me.PictureBox1.Image = CType(resources.GetObject("PictureBox1.Image"), System.Drawing.Image)
        Me.PictureBox1.Location = New System.Drawing.Point(840, 2)
        Me.PictureBox1.Margin = New System.Windows.Forms.Padding(4)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(109, 52)
        Me.PictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox1.TabIndex = 32
        Me.PictureBox1.TabStop = False
        '
        'lblExecTime
        '
        Me.lblExecTime.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblExecTime.ForeColor = System.Drawing.Color.Maroon
        Me.lblExecTime.Location = New System.Drawing.Point(88, 314)
        Me.lblExecTime.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblExecTime.Name = "lblExecTime"
        Me.lblExecTime.Size = New System.Drawing.Size(292, 31)
        Me.lblExecTime.TabIndex = 25
        Me.lblExecTime.Text = "Executing in 0 Secs."
        Me.lblExecTime.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.lblExecTime.Visible = False
        '
        'btnStopExec
        '
        Me.btnStopExec.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnStopExec.Location = New System.Drawing.Point(13, 315)
        Me.btnStopExec.Margin = New System.Windows.Forms.Padding(4)
        Me.btnStopExec.Name = "btnStopExec"
        Me.btnStopExec.Size = New System.Drawing.Size(67, 28)
        Me.btnStopExec.TabIndex = 33
        Me.btnStopExec.Text = "STOP"
        '
        'Timer3
        '
        Me.Timer3.Interval = 1000
        '
        'LoginForm1
        '
        Me.AcceptButton = Me.OK
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.ButtonHighlight
        Me.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.CancelButton = Me.Cancel
        Me.ClientSize = New System.Drawing.Size(949, 356)
        Me.Controls.Add(Me.btnStopExec)
        Me.Controls.Add(Me.lblExecTime)
        Me.Controls.Add(Me.PictureBox1)
        Me.Controls.Add(Me.Label6)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.lblRepo)
        Me.Controls.Add(Me.lblMsg)
        Me.Controls.Add(Me.ckCancelAutoLogin)
        Me.Controls.Add(Me.lblNetworkID)
        Me.Controls.Add(Me.Panel2)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.lblServerMachineName)
        Me.Controls.Add(Me.lblServerInstanceName)
        Me.Controls.Add(Me.lblLocalIP)
        Me.Controls.Add(Me.lblCurrUserGuidID)
        Me.Controls.Add(Me.lblAttachedMachineName)
        Me.Controls.Add(Me.LogoPictureBox)
        Me.DoubleBuffered = True
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.HelpButton = True
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "LoginForm1"
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "ECM Archive Login Screen"
        CType(Me.LogoPictureBox, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Panel2.ResumeLayout(False)
        Me.Panel2.PerformLayout()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents ckSaveAsDefaultLogin As System.Windows.Forms.CheckBox
    Friend WithEvents lblAttachedMachineName As System.Windows.Forms.Label
    Friend WithEvents lblCurrUserGuidID As System.Windows.Forms.Label
    Friend WithEvents lblServerInstanceName As System.Windows.Forms.Label
    Friend WithEvents lblLocalIP As System.Windows.Forms.Label
    Friend WithEvents lblServerMachineName As System.Windows.Forms.Label
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents btnChgPW As System.Windows.Forms.Button
    Friend WithEvents Panel2 As System.Windows.Forms.Panel
    Friend WithEvents lblNetworkID As System.Windows.Forms.Label
    Friend WithEvents ckCancelAutoLogin As System.Windows.Forms.CheckBox
    Friend WithEvents lblMsg As System.Windows.Forms.Label
    Friend WithEvents Timer2 As System.Windows.Forms.Timer
    Friend WithEvents lblRepo As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents Button1 As Button
    Friend WithEvents ckAutoExecute As CheckBox
    Friend WithEvents btnStopExec As Button
    Friend WithEvents lblExecTime As Label
    Friend WithEvents Timer3 As Timer
    Friend WithEvents ckDisableListener As CheckBox
End Class
