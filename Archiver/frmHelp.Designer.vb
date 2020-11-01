<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmHelp
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
        Me.components = New System.ComponentModel.Container
        Me.rtbText = New System.Windows.Forms.RichTextBox
        Me.lblScreenName = New System.Windows.Forms.Label
        Me.lblObject = New System.Windows.Forms.Label
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.SuspendLayout()
        '
        'rtbText
        '
        Me.rtbText.Location = New System.Drawing.Point(12, 33)
        Me.rtbText.Name = "rtbText"
        Me.rtbText.Size = New System.Drawing.Size(260, 219)
        Me.rtbText.TabIndex = 0
        Me.rtbText.Text = ""
        '
        'lblScreenName
        '
        Me.lblScreenName.AutoSize = True
        Me.lblScreenName.Location = New System.Drawing.Point(12, 9)
        Me.lblScreenName.Name = "lblScreenName"
        Me.lblScreenName.Size = New System.Drawing.Size(79, 13)
        Me.lblScreenName.TabIndex = 1
        Me.lblScreenName.Text = "lblScreenName"
        '
        'lblObject
        '
        Me.lblObject.AutoSize = True
        Me.lblObject.Location = New System.Drawing.Point(169, 9)
        Me.lblObject.Name = "lblObject"
        Me.lblObject.Size = New System.Drawing.Size(48, 13)
        Me.lblObject.TabIndex = 2
        Me.lblObject.Text = "lblObject"
        '
        'Timer1
        '
        Me.Timer1.Enabled = True
        Me.Timer1.Interval = 5000
        '
        'frmHelp
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(284, 264)
        Me.Controls.Add(Me.lblObject)
        Me.Controls.Add(Me.lblScreenName)
        Me.Controls.Add(Me.rtbText)
        Me.Name = "frmHelp"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Help Screen"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents rtbText As System.Windows.Forms.RichTextBox
    Friend WithEvents lblScreenName As System.Windows.Forms.Label
    Friend WithEvents lblObject As System.Windows.Forms.Label
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
End Class
