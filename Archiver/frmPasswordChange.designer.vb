<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPasswordChange
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
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.txtPw1 = New System.Windows.Forms.TextBox
        Me.txtPw2 = New System.Windows.Forms.TextBox
        Me.btnEnter = New System.Windows.Forms.Button
        Me.SB = New System.Windows.Forms.TextBox
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(18, 19)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(100, 17)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "New Password"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(18, 90)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(118, 17)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Retype Password"
        '
        'txtPw1
        '
        Me.txtPw1.Location = New System.Drawing.Point(18, 44)
        Me.txtPw1.Name = "txtPw1"
        Me.txtPw1.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPw1.Size = New System.Drawing.Size(241, 22)
        Me.txtPw1.TabIndex = 2
        '
        'txtPw2
        '
        Me.txtPw2.Location = New System.Drawing.Point(18, 116)
        Me.txtPw2.Name = "txtPw2"
        Me.txtPw2.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPw2.Size = New System.Drawing.Size(241, 22)
        Me.txtPw2.TabIndex = 3
        '
        'btnEnter
        '
        Me.btnEnter.Location = New System.Drawing.Point(79, 161)
        Me.btnEnter.Name = "btnEnter"
        Me.btnEnter.Size = New System.Drawing.Size(116, 41)
        Me.btnEnter.TabIndex = 4
        Me.btnEnter.Text = "Accept"
        Me.btnEnter.UseVisualStyleBackColor = True
        '
        'SB
        '
        Me.SB.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.SB.Enabled = False
        Me.SB.Location = New System.Drawing.Point(18, 221)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(241, 22)
        Me.SB.TabIndex = 5
        '
        'frmPasswordChange
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(282, 255)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.btnEnter)
        Me.Controls.Add(Me.txtPw2)
        Me.Controls.Add(Me.txtPw1)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Name = "frmPasswordChange"
        Me.Text = "Password Entry Form  (frmPasswordChange)"
        Me.TopMost = True
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents txtPw1 As System.Windows.Forms.TextBox
    Friend WithEvents txtPw2 As System.Windows.Forms.TextBox
    Friend WithEvents btnEnter As System.Windows.Forms.Button
    Friend WithEvents SB As System.Windows.Forms.TextBox
End Class
