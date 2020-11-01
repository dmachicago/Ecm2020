<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPstLoader
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
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog
        Me.txtPstFqn = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.btnSelectFile = New System.Windows.Forms.Button
        Me.btnLoad = New System.Windows.Forms.Button
        Me.lbMsg = New System.Windows.Forms.ListBox
        Me.btnArchive = New System.Windows.Forms.Button
        Me.SB = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.txtFoldersProcessed = New System.Windows.Forms.TextBox
        Me.txtEmailsProcessed = New System.Windows.Forms.TextBox
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        Me.Label4 = New System.Windows.Forms.Label
        Me.cbRetention = New System.Windows.Forms.ComboBox
        Me.cbLibrary = New System.Windows.Forms.ComboBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.btnRemove = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'txtPstFqn
        '
        Me.txtPstFqn.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtPstFqn.Location = New System.Drawing.Point(11, 28)
        Me.txtPstFqn.Margin = New System.Windows.Forms.Padding(2)
        Me.txtPstFqn.Name = "txtPstFqn"
        Me.txtPstFqn.Size = New System.Drawing.Size(439, 20)
        Me.txtPstFqn.TabIndex = 0
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(9, 9)
        Me.Label1.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(92, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Selected PST File"
        '
        'btnSelectFile
        '
        Me.btnSelectFile.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.btnSelectFile.Location = New System.Drawing.Point(460, 28)
        Me.btnSelectFile.Margin = New System.Windows.Forms.Padding(2)
        Me.btnSelectFile.Name = "btnSelectFile"
        Me.btnSelectFile.Size = New System.Drawing.Size(79, 51)
        Me.btnSelectFile.TabIndex = 2
        Me.btnSelectFile.Text = "&Select PST File"
        Me.TT.SetToolTip(Me.btnSelectFile, "Microsoft supports only local access to .pst files, not network access, and warns" & _
                " that excessive network traffic and data corruption can result if you try to acc" & _
                "ess .pst files over the network.")
        Me.btnSelectFile.UseVisualStyleBackColor = True
        '
        'btnLoad
        '
        Me.btnLoad.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.btnLoad.Location = New System.Drawing.Point(461, 93)
        Me.btnLoad.Margin = New System.Windows.Forms.Padding(2)
        Me.btnLoad.Name = "btnLoad"
        Me.btnLoad.Size = New System.Drawing.Size(79, 51)
        Me.btnLoad.TabIndex = 3
        Me.btnLoad.Text = "&Load File"
        Me.TT.SetToolTip(Me.btnLoad, "Microsoft supports only local access to .pst files, not network access, and warns" & _
                " that excessive network traffic and data corruption can result if you try to acc" & _
                "ess .pst files over the network.")
        Me.btnLoad.UseVisualStyleBackColor = True
        '
        'lbMsg
        '
        Me.lbMsg.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbMsg.FormattingEnabled = True
        Me.lbMsg.Location = New System.Drawing.Point(11, 50)
        Me.lbMsg.Margin = New System.Windows.Forms.Padding(2)
        Me.lbMsg.Name = "lbMsg"
        Me.lbMsg.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended
        Me.lbMsg.Size = New System.Drawing.Size(439, 290)
        Me.lbMsg.TabIndex = 4
        '
        'btnArchive
        '
        Me.btnArchive.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnArchive.Location = New System.Drawing.Point(461, 289)
        Me.btnArchive.Margin = New System.Windows.Forms.Padding(2)
        Me.btnArchive.Name = "btnArchive"
        Me.btnArchive.Size = New System.Drawing.Size(79, 51)
        Me.btnArchive.TabIndex = 5
        Me.btnArchive.Text = "&Archive Selected Folders"
        Me.btnArchive.UseVisualStyleBackColor = True
        '
        'SB
        '
        Me.SB.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Location = New System.Drawing.Point(12, 407)
        Me.SB.Margin = New System.Windows.Forms.Padding(2)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(439, 20)
        Me.SB.TabIndex = 6
        '
        'Label2
        '
        Me.Label2.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(461, 172)
        Me.Label2.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(41, 13)
        Me.Label2.TabIndex = 7
        Me.Label2.Text = "Folders"
        '
        'Label3
        '
        Me.Label3.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(461, 223)
        Me.Label3.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(37, 13)
        Me.Label3.TabIndex = 8
        Me.Label3.Text = "Emails"
        '
        'txtFoldersProcessed
        '
        Me.txtFoldersProcessed.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.txtFoldersProcessed.Location = New System.Drawing.Point(461, 191)
        Me.txtFoldersProcessed.Margin = New System.Windows.Forms.Padding(2)
        Me.txtFoldersProcessed.Name = "txtFoldersProcessed"
        Me.txtFoldersProcessed.Size = New System.Drawing.Size(75, 20)
        Me.txtFoldersProcessed.TabIndex = 9
        '
        'txtEmailsProcessed
        '
        Me.txtEmailsProcessed.Anchor = System.Windows.Forms.AnchorStyles.Right
        Me.txtEmailsProcessed.Location = New System.Drawing.Point(461, 240)
        Me.txtEmailsProcessed.Margin = New System.Windows.Forms.Padding(2)
        Me.txtEmailsProcessed.Name = "txtEmailsProcessed"
        Me.txtEmailsProcessed.Size = New System.Drawing.Size(75, 20)
        Me.txtEmailsProcessed.TabIndex = 10
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(127, 353)
        Me.Label4.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(126, 13)
        Me.Label4.TabIndex = 11
        Me.Label4.Text = "Selected Retention Rule:"
        '
        'cbRetention
        '
        Me.cbRetention.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbRetention.FormattingEnabled = True
        Me.cbRetention.Location = New System.Drawing.Point(258, 345)
        Me.cbRetention.Name = "cbRetention"
        Me.cbRetention.Size = New System.Drawing.Size(192, 21)
        Me.cbRetention.TabIndex = 12
        '
        'cbLibrary
        '
        Me.cbLibrary.FormattingEnabled = True
        Me.cbLibrary.Location = New System.Drawing.Point(258, 372)
        Me.cbLibrary.Name = "cbLibrary"
        Me.cbLibrary.Size = New System.Drawing.Size(192, 21)
        Me.cbLibrary.TabIndex = 14
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(179, 380)
        Me.Label5.Margin = New System.Windows.Forms.Padding(2, 0, 2, 0)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(74, 13)
        Me.Label5.TabIndex = 13
        Me.Label5.Text = "Select Library:"
        '
        'btnRemove
        '
        Me.btnRemove.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnRemove.Location = New System.Drawing.Point(465, 395)
        Me.btnRemove.Name = "btnRemove"
        Me.btnRemove.Size = New System.Drawing.Size(73, 44)
        Me.btnRemove.TabIndex = 15
        Me.btnRemove.Text = "Remove Imports"
        Me.btnRemove.UseVisualStyleBackColor = True
        '
        'frmPstLoader
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(550, 449)
        Me.Controls.Add(Me.btnRemove)
        Me.Controls.Add(Me.cbLibrary)
        Me.Controls.Add(Me.Label5)
        Me.Controls.Add(Me.cbRetention)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.txtEmailsProcessed)
        Me.Controls.Add(Me.txtFoldersProcessed)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.btnArchive)
        Me.Controls.Add(Me.lbMsg)
        Me.Controls.Add(Me.btnLoad)
        Me.Controls.Add(Me.btnSelectFile)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtPstFqn)
        Me.Margin = New System.Windows.Forms.Padding(2)
        Me.Name = "frmPstLoader"
        Me.Text = "PST Loader                  (frmPstLoader)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents txtPstFqn As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents btnSelectFile As System.Windows.Forms.Button
    Friend WithEvents btnLoad As System.Windows.Forms.Button
    Friend WithEvents lbMsg As System.Windows.Forms.ListBox
    Friend WithEvents btnArchive As System.Windows.Forms.Button
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtFoldersProcessed As System.Windows.Forms.TextBox
    Friend WithEvents txtEmailsProcessed As System.Windows.Forms.TextBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents cbRetention As System.Windows.Forms.ComboBox
    Friend WithEvents cbLibrary As System.Windows.Forms.ComboBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents btnRemove As System.Windows.Forms.Button
End Class
