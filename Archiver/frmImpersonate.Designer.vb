<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmImpersonate
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
        Me.txtUserID = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.txtPw1 = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.txtPw2 = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.btnAssign = New System.Windows.Forms.Button()
        Me.btnCancel = New System.Windows.Forms.Button()
        Me.btnRemoveAssignment = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'txtUserID
        '
        Me.txtUserID.Location = New System.Drawing.Point(3, 35)
        Me.txtUserID.Name = "txtUserID"
        Me.txtUserID.Size = New System.Drawing.Size(269, 20)
        Me.txtUserID.TabIndex = 0
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(3, 19)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(51, 13)
        Me.Label1.TabIndex = 99
        Me.Label1.Text = "Login As:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(3, 68)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(56, 13)
        Me.Label2.TabIndex = 99
        Me.Label2.Text = "Password:"
        '
        'txtPw1
        '
        Me.txtPw1.Location = New System.Drawing.Point(3, 84)
        Me.txtPw1.Name = "txtPw1"
        Me.txtPw1.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPw1.Size = New System.Drawing.Size(226, 20)
        Me.txtPw1.TabIndex = 1
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(3, 113)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(97, 13)
        Me.Label3.TabIndex = 99
        Me.Label3.Text = "Re-enter Password"
        '
        'txtPw2
        '
        Me.txtPw2.Location = New System.Drawing.Point(3, 129)
        Me.txtPw2.Name = "txtPw2"
        Me.txtPw2.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPw2.Size = New System.Drawing.Size(226, 20)
        Me.txtPw2.TabIndex = 2
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(3, 163)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(210, 13)
        Me.Label4.TabIndex = 99
        Me.Label4.Text = "Note: This login is set only for this machine."
        '
        'btnAssign
        '
        Me.btnAssign.Location = New System.Drawing.Point(292, 33)
        Me.btnAssign.Name = "btnAssign"
        Me.btnAssign.Size = New System.Drawing.Size(109, 25)
        Me.btnAssign.TabIndex = 4
        Me.btnAssign.Text = "Assign"
        Me.btnAssign.UseVisualStyleBackColor = True
        '
        'btnCancel
        '
        Me.btnCancel.Location = New System.Drawing.Point(292, 127)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(109, 25)
        Me.btnCancel.TabIndex = 3
        Me.btnCancel.Text = "Cancel"
        Me.btnCancel.UseVisualStyleBackColor = True
        '
        'btnRemoveAssignment
        '
        Me.btnRemoveAssignment.Location = New System.Drawing.Point(292, 82)
        Me.btnRemoveAssignment.Name = "btnRemoveAssignment"
        Me.btnRemoveAssignment.Size = New System.Drawing.Size(109, 25)
        Me.btnRemoveAssignment.TabIndex = 100
        Me.btnRemoveAssignment.Text = "Remove"
        Me.btnRemoveAssignment.UseVisualStyleBackColor = True
        '
        'frmImpersonate
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(413, 188)
        Me.Controls.Add(Me.btnRemoveAssignment)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.btnAssign)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.txtPw2)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.txtPw1)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.txtUserID)
        Me.Name = "frmImpersonate"
        Me.Text = "Auto-Launch Login   (frmImpersonate)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtUserID As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents txtPw1 As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents txtPw2 As System.Windows.Forms.TextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents btnAssign As System.Windows.Forms.Button
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents btnRemoveAssignment As System.Windows.Forms.Button
End Class
