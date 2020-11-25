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
        Me.lblDetail = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(16, 11)
        Me.Label1.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(75, 17)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "CONTENT"
        '
        'lblFileSpec
        '
        Me.lblFileSpec.AutoSize = True
        Me.lblFileSpec.Location = New System.Drawing.Point(16, 71)
        Me.lblFileSpec.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblFileSpec.Name = "lblFileSpec"
        Me.lblFileSpec.Size = New System.Drawing.Size(34, 17)
        Me.lblFileSpec.TabIndex = 1
        Me.lblFileSpec.Text = "File:"
        '
        'lblPdgPages
        '
        Me.lblPdgPages.AutoSize = True
        Me.lblPdgPages.Location = New System.Drawing.Point(16, 41)
        Me.lblPdgPages.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblPdgPages.Name = "lblPdgPages"
        Me.lblPdgPages.Size = New System.Drawing.Size(52, 17)
        Me.lblPdgPages.TabIndex = 2
        Me.lblPdgPages.Text = "Pages:"
        '
        'lblDetail
        '
        Me.lblDetail.AutoSize = True
        Me.lblDetail.Location = New System.Drawing.Point(16, 97)
        Me.lblDetail.Margin = New System.Windows.Forms.Padding(4, 0, 4, 0)
        Me.lblDetail.Name = "lblDetail"
        Me.lblDetail.Size = New System.Drawing.Size(38, 17)
        Me.lblDetail.TabIndex = 3
        Me.lblDetail.Text = "Msg:"
        '
        'frmNotify
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.ClientSize = New System.Drawing.Size(941, 123)
        Me.Controls.Add(Me.lblDetail)
        Me.Controls.Add(Me.lblPdgPages)
        Me.Controls.Add(Me.lblFileSpec)
        Me.Controls.Add(Me.Label1)
        Me.DoubleBuffered = True
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Margin = New System.Windows.Forms.Padding(4, 4, 4, 4)
        Me.MaximizeBox = False
        Me.Name = "frmNotify"
        Me.Text = "Notice           (frmNotify)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents lblFileSpec As System.Windows.Forms.Label
    Friend WithEvents lblPdgPages As System.Windows.Forms.Label
    Friend WithEvents lblDetail As Label
End Class
