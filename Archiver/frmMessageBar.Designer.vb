<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmMessageBar
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmMessageBar))
        Me.lblmsg = New System.Windows.Forms.Label()
        Me.lblCnt = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'lblmsg
        '
        Me.lblmsg.AutoSize = True
        Me.lblmsg.ForeColor = System.Drawing.Color.White
        Me.lblmsg.Location = New System.Drawing.Point(16, 11)
        Me.lblmsg.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblmsg.Name = "lblmsg"
        Me.lblmsg.Size = New System.Drawing.Size(51, 17)
        Me.lblmsg.TabIndex = 0
        Me.lblmsg.Text = "Label1"
        '
        'lblCnt
        '
        Me.lblCnt.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblCnt.AutoSize = True
        Me.lblCnt.ForeColor = System.Drawing.Color.White
        Me.lblCnt.Location = New System.Drawing.Point(16, 36)
        Me.lblCnt.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblCnt.Name = "lblCnt"
        Me.lblCnt.Size = New System.Drawing.Size(51, 17)
        Me.lblCnt.TabIndex = 1
        Me.lblCnt.Text = "Label1"
        '
        'frmMessageBar
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.Maroon
        Me.ClientSize = New System.Drawing.Size(1211, 62)
        Me.Controls.Add(Me.lblCnt)
        Me.Controls.Add(Me.lblmsg)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.Name = "frmMessageBar"
        Me.Text = "Notice                  (frmMessageBar)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblmsg As System.Windows.Forms.Label
    Friend WithEvents lblCnt As System.Windows.Forms.Label
End Class
