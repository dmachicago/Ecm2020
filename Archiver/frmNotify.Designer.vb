<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmNotify
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmNotify))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.lblFileSpec = New System.Windows.Forms.Label()
        Me.lblPdgPages = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 9)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(59, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "CONTENT"
        '
        'lblFileSpec
        '
        Me.lblFileSpec.AutoSize = True
        Me.lblFileSpec.Location = New System.Drawing.Point(12, 58)
        Me.lblFileSpec.Name = "lblFileSpec"
        Me.lblFileSpec.Size = New System.Drawing.Size(26, 13)
        Me.lblFileSpec.TabIndex = 1
        Me.lblFileSpec.Text = "File:"
        '
        'lblPdgPages
        '
        Me.lblPdgPages.AutoSize = True
        Me.lblPdgPages.Location = New System.Drawing.Point(12, 33)
        Me.lblPdgPages.Name = "lblPdgPages"
        Me.lblPdgPages.Size = New System.Drawing.Size(40, 13)
        Me.lblPdgPages.TabIndex = 2
        Me.lblPdgPages.Text = "Pages:"
        '
        'frmNotify
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.ClientSize = New System.Drawing.Size(706, 80)
        Me.Controls.Add(Me.lblPdgPages)
        Me.Controls.Add(Me.lblFileSpec)
        Me.Controls.Add(Me.Label1)
        Me.DoubleBuffered = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "frmNotify"
        Me.Text = "Notice           (frmNotify)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents lblFileSpec As System.Windows.Forms.Label
    Friend WithEvents lblPdgPages As System.Windows.Forms.Label
End Class
