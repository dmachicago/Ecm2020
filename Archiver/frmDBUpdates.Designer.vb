<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmDBUpdates
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
        Me.lblFile = New System.Windows.Forms.Label()
        Me.txtFile = New System.Windows.Forms.TextBox()
        Me.txtSql = New System.Windows.Forms.TextBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'lblFile
        '
        Me.lblFile.AutoSize = True
        Me.lblFile.Location = New System.Drawing.Point(27, 22)
        Me.lblFile.Name = "lblFile"
        Me.lblFile.Size = New System.Drawing.Size(80, 17)
        Me.lblFile.TabIndex = 0
        Me.lblFile.Text = "Update File"
        '
        'txtFile
        '
        Me.txtFile.Location = New System.Drawing.Point(30, 43)
        Me.txtFile.Name = "txtFile"
        Me.txtFile.ReadOnly = True
        Me.txtFile.Size = New System.Drawing.Size(482, 22)
        Me.txtFile.TabIndex = 1
        '
        'txtSql
        '
        Me.txtSql.Location = New System.Drawing.Point(30, 91)
        Me.txtSql.Multiline = True
        Me.txtSql.Name = "txtSql"
        Me.txtSql.ReadOnly = True
        Me.txtSql.ScrollBars = System.Windows.Forms.ScrollBars.Both
        Me.txtSql.Size = New System.Drawing.Size(949, 390)
        Me.txtSql.TabIndex = 2
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(875, 548)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(104, 38)
        Me.Button1.TabIndex = 3
        Me.Button1.Text = "Close"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(30, 548)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(104, 38)
        Me.Button2.TabIndex = 4
        Me.Button2.Text = "Reapply"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'SB
        '
        Me.SB.Location = New System.Drawing.Point(30, 501)
        Me.SB.Name = "SB"
        Me.SB.ReadOnly = True
        Me.SB.Size = New System.Drawing.Size(949, 22)
        Me.SB.TabIndex = 5
        '
        'frmDBUpdates
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(991, 598)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.txtSql)
        Me.Controls.Add(Me.txtFile)
        Me.Controls.Add(Me.lblFile)
        Me.Name = "frmDBUpdates"
        Me.Text = "frmDBUpdates"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents lblFile As Label
    Friend WithEvents txtFile As TextBox
    Friend WithEvents txtSql As TextBox
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
    Friend WithEvents SB As TextBox
End Class
