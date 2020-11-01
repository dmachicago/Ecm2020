<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmHistory
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
        Me.lbHistory = New System.Windows.Forms.ListBox
        Me.SuspendLayout()
        '
        'lbHistory
        '
        Me.lbHistory.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lbHistory.FormattingEnabled = True
        Me.lbHistory.Location = New System.Drawing.Point(0, 0)
        Me.lbHistory.Name = "lbHistory"
        Me.lbHistory.Size = New System.Drawing.Size(890, 433)
        Me.lbHistory.TabIndex = 0
        '
        'frmHistory
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(890, 437)
        Me.Controls.Add(Me.lbHistory)
        Me.Name = "frmHistory"
        Me.Text = "History of improvements      (frmHistory)"
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents lbHistory As System.Windows.Forms.ListBox
End Class
