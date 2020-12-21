<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmNotify2
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
        Me.lblEmailMsg = New System.Windows.Forms.Label()
        Me.lblMsg2 = New System.Windows.Forms.Label()
        Me.lblFolder = New System.Windows.Forms.Label()
        Me.PB = New System.Windows.Forms.ProgressBar()
        Me.SuspendLayout()
        '
        'lblEmailMsg
        '
        Me.lblEmailMsg.AutoSize = True
        Me.lblEmailMsg.Location = New System.Drawing.Point(16, 11)
        Me.lblEmailMsg.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblEmailMsg.Name = "lblEmailMsg"
        Me.lblEmailMsg.Size = New System.Drawing.Size(38, 17)
        Me.lblEmailMsg.TabIndex = 1
        Me.lblEmailMsg.Text = "Msg:"
        '
        'lblMsg2
        '
        Me.lblMsg2.AutoSize = True
        Me.lblMsg2.Location = New System.Drawing.Point(16, 37)
        Me.lblMsg2.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblMsg2.Name = "lblMsg2"
        Me.lblMsg2.Size = New System.Drawing.Size(38, 17)
        Me.lblMsg2.TabIndex = 2
        Me.lblMsg2.Text = "Msg:"
        '
        'lblFolder
        '
        Me.lblFolder.AutoSize = True
        Me.lblFolder.Location = New System.Drawing.Point(16, 60)
        Me.lblFolder.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblFolder.Name = "lblFolder"
        Me.lblFolder.Size = New System.Drawing.Size(38, 17)
        Me.lblFolder.TabIndex = 3
        Me.lblFolder.Text = "Msg:"
        '
        'PB
        '
        Me.PB.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.PB.Location = New System.Drawing.Point(19, 90)
        Me.PB.Name = "PB"
        Me.PB.Size = New System.Drawing.Size(791, 14)
        Me.PB.TabIndex = 4
        '
        'frmNotify2
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.ClientSize = New System.Drawing.Size(822, 116)
        Me.Controls.Add(Me.PB)
        Me.Controls.Add(Me.lblFolder)
        Me.Controls.Add(Me.lblMsg2)
        Me.Controls.Add(Me.lblEmailMsg)
        Me.DoubleBuffered = True
        Me.ForeColor = System.Drawing.Color.Black
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.MaximizeBox = False
        Me.Name = "frmNotify2"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Progress Tracking     (frmNotify2)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblEmailMsg As System.Windows.Forms.Label
    Friend WithEvents lblMsg2 As System.Windows.Forms.Label
    Friend WithEvents lblFolder As System.Windows.Forms.Label
    Friend WithEvents PB As ProgressBar
End Class
