<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmEncryptString
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
        Me.txtUnencrypted = New System.Windows.Forms.TextBox()
        Me.txtEncrypted = New System.Windows.Forms.TextBox()
        Me.btnEncrypt = New System.Windows.Forms.Button()
        Me.btnCopy = New System.Windows.Forms.Button()
        Me.txtConnstr = New System.Windows.Forms.TextBox()
        Me.btnTestConnStr = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'txtUnencrypted
        '
        Me.txtUnencrypted.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtUnencrypted.Location = New System.Drawing.Point(12, 51)
        Me.txtUnencrypted.Multiline = True
        Me.txtUnencrypted.Name = "txtUnencrypted"
        Me.txtUnencrypted.Size = New System.Drawing.Size(403, 95)
        Me.txtUnencrypted.TabIndex = 0
        '
        'txtEncrypted
        '
        Me.txtEncrypted.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtEncrypted.Location = New System.Drawing.Point(12, 152)
        Me.txtEncrypted.Multiline = True
        Me.txtEncrypted.Name = "txtEncrypted"
        Me.txtEncrypted.Size = New System.Drawing.Size(403, 109)
        Me.txtEncrypted.TabIndex = 1
        '
        'btnEncrypt
        '
        Me.btnEncrypt.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnEncrypt.Location = New System.Drawing.Point(430, 51)
        Me.btnEncrypt.Name = "btnEncrypt"
        Me.btnEncrypt.Size = New System.Drawing.Size(69, 59)
        Me.btnEncrypt.TabIndex = 2
        Me.btnEncrypt.Text = "Encrypt"
        Me.btnEncrypt.UseVisualStyleBackColor = True
        '
        'btnCopy
        '
        Me.btnCopy.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnCopy.Location = New System.Drawing.Point(430, 181)
        Me.btnCopy.Name = "btnCopy"
        Me.btnCopy.Size = New System.Drawing.Size(69, 59)
        Me.btnCopy.TabIndex = 3
        Me.btnCopy.Text = "Copy to Clipboard"
        Me.btnCopy.UseVisualStyleBackColor = True
        '
        'txtConnstr
        '
        Me.txtConnstr.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtConnstr.Location = New System.Drawing.Point(12, 12)
        Me.txtConnstr.Name = "txtConnstr"
        Me.txtConnstr.Size = New System.Drawing.Size(403, 20)
        Me.txtConnstr.TabIndex = 4
        '
        'btnTestConnStr
        '
        Me.btnTestConnStr.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnTestConnStr.Location = New System.Drawing.Point(430, 5)
        Me.btnTestConnStr.Name = "btnTestConnStr"
        Me.btnTestConnStr.Size = New System.Drawing.Size(64, 33)
        Me.btnTestConnStr.TabIndex = 5
        Me.btnTestConnStr.Text = "Test Conn"
        Me.btnTestConnStr.UseVisualStyleBackColor = True
        '
        'frmEncryptString
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(512, 273)
        Me.Controls.Add(Me.btnTestConnStr)
        Me.Controls.Add(Me.txtConnstr)
        Me.Controls.Add(Me.btnCopy)
        Me.Controls.Add(Me.btnEncrypt)
        Me.Controls.Add(Me.txtEncrypted)
        Me.Controls.Add(Me.txtUnencrypted)
        Me.Name = "frmEncryptString"
        Me.Text = "Encrypt Phrase       (frmEncryptString)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtUnencrypted As System.Windows.Forms.TextBox
    Friend WithEvents txtEncrypted As System.Windows.Forms.TextBox
    Friend WithEvents btnEncrypt As System.Windows.Forms.Button
    Friend WithEvents btnCopy As System.Windows.Forms.Button
    Friend WithEvents txtConnstr As System.Windows.Forms.TextBox
    Friend WithEvents btnTestConnStr As System.Windows.Forms.Button
End Class
