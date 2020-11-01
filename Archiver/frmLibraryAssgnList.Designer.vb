<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmLibraryAssgnList
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
        Me.lbLibraries = New System.Windows.Forms.ListBox
        Me.SuspendLayout()
        '
        'lbLibraries
        '
        Me.lbLibraries.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lbLibraries.FormattingEnabled = True
        Me.lbLibraries.Location = New System.Drawing.Point(0, 0)
        Me.lbLibraries.Name = "lbLibraries"
        Me.lbLibraries.Size = New System.Drawing.Size(179, 160)
        Me.lbLibraries.TabIndex = 0
        '
        'frmLibraryAssgnList
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(179, 163)
        Me.Controls.Add(Me.lbLibraries)
        Me.Name = "frmLibraryAssgnList"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Assigned Libraries     (frmLibraryAssgnList)"
        Me.TopMost = True
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents lbLibraries As System.Windows.Forms.ListBox
End Class
