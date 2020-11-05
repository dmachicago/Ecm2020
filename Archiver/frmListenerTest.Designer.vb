<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FrmListenerTest
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
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
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.txtDir = New System.Windows.Forms.TextBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.lbOutput = New System.Windows.Forms.ListBox()
        Me.ckStop = New System.Windows.Forms.CheckBox()
        Me.SB = New System.Windows.Forms.TextBox()
        Me.SuspendLayout()
        '
        'txtDir
        '
        Me.txtDir.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDir.Location = New System.Drawing.Point(37, 76)
        Me.txtDir.Name = "txtDir"
        Me.txtDir.ReadOnly = True
        Me.txtDir.Size = New System.Drawing.Size(700, 22)
        Me.txtDir.TabIndex = 0
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(37, 35)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(123, 35)
        Me.Button1.TabIndex = 1
        Me.Button1.Text = "Select DIR"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Button2.Location = New System.Drawing.Point(614, 35)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(123, 35)
        Me.Button2.TabIndex = 2
        Me.Button2.Text = "Start Listener"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'lbOutput
        '
        Me.lbOutput.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbOutput.FormattingEnabled = True
        Me.lbOutput.ItemHeight = 16
        Me.lbOutput.Location = New System.Drawing.Point(37, 155)
        Me.lbOutput.Name = "lbOutput"
        Me.lbOutput.Size = New System.Drawing.Size(700, 372)
        Me.lbOutput.TabIndex = 4
        '
        'ckStop
        '
        Me.ckStop.AutoSize = True
        Me.ckStop.Location = New System.Drawing.Point(280, 43)
        Me.ckStop.Name = "ckStop"
        Me.ckStop.Size = New System.Drawing.Size(178, 21)
        Me.ckStop.TabIndex = 5
        Me.ckStop.Text = "Check To Stop Listener"
        Me.ckStop.UseVisualStyleBackColor = True
        '
        'SB
        '
        Me.SB.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SB.Location = New System.Drawing.Point(37, 127)
        Me.SB.Name = "SB"
        Me.SB.ReadOnly = True
        Me.SB.Size = New System.Drawing.Size(700, 22)
        Me.SB.TabIndex = 6
        '
        'FrmListenerTest
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(758, 565)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.ckStop)
        Me.Controls.Add(Me.lbOutput)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.txtDir)
        Me.Name = "FrmListenerTest"
        Me.Text = "frmListenerTest"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents txtDir As TextBox
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
    Friend WithEvents lbOutput As ListBox
    Friend WithEvents ckStop As CheckBox
    Friend WithEvents SB As TextBox
End Class
