<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmOcrPdf
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
        Me.btnProcess = New System.Windows.Forms.Button
        Me.btnSelect = New System.Windows.Forms.Button
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog
        Me.txtFile = New System.Windows.Forms.TextBox
        Me.picGraphic = New System.Windows.Forms.PictureBox
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer
        Me.SplitContainer2 = New System.Windows.Forms.SplitContainer
        Me.txtErrors = New System.Windows.Forms.TextBox
        Me.txtOcr = New System.Windows.Forms.TextBox
        Me.SB = New System.Windows.Forms.Label
        Me.lbImages = New System.Windows.Forms.ListBox
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.rbResize = New System.Windows.Forms.RadioButton
        Me.rbNormal = New System.Windows.Forms.RadioButton
        CType(Me.picGraphic, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        Me.SplitContainer2.Panel1.SuspendLayout()
        Me.SplitContainer2.Panel2.SuspendLayout()
        Me.SplitContainer2.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnProcess
        '
        Me.btnProcess.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnProcess.Location = New System.Drawing.Point(755, 566)
        Me.btnProcess.Name = "btnProcess"
        Me.btnProcess.Size = New System.Drawing.Size(99, 30)
        Me.btnProcess.TabIndex = 0
        Me.btnProcess.Text = "Process"
        Me.btnProcess.UseVisualStyleBackColor = True
        '
        'btnSelect
        '
        Me.btnSelect.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnSelect.Location = New System.Drawing.Point(12, 566)
        Me.btnSelect.Name = "btnSelect"
        Me.btnSelect.Size = New System.Drawing.Size(99, 30)
        Me.btnSelect.TabIndex = 1
        Me.btnSelect.Text = "Select PDF"
        Me.btnSelect.UseVisualStyleBackColor = True
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'txtFile
        '
        Me.txtFile.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtFile.Enabled = False
        Me.txtFile.Location = New System.Drawing.Point(117, 571)
        Me.txtFile.Name = "txtFile"
        Me.txtFile.Size = New System.Drawing.Size(632, 20)
        Me.txtFile.TabIndex = 2
        '
        'picGraphic
        '
        Me.picGraphic.Dock = System.Windows.Forms.DockStyle.Fill
        Me.picGraphic.Location = New System.Drawing.Point(0, 0)
        Me.picGraphic.Name = "picGraphic"
        Me.picGraphic.Size = New System.Drawing.Size(276, 430)
        Me.picGraphic.TabIndex = 3
        Me.picGraphic.TabStop = False
        '
        'SplitContainer1
        '
        Me.SplitContainer1.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.SplitContainer1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.SplitContainer1.Location = New System.Drawing.Point(12, 12)
        Me.SplitContainer1.Name = "SplitContainer1"
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.Controls.Add(Me.picGraphic)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.SplitContainer2)
        Me.SplitContainer1.Size = New System.Drawing.Size(842, 434)
        Me.SplitContainer1.SplitterDistance = 280
        Me.SplitContainer1.TabIndex = 4
        '
        'SplitContainer2
        '
        Me.SplitContainer2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer2.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer2.Name = "SplitContainer2"
        Me.SplitContainer2.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer2.Panel1
        '
        Me.SplitContainer2.Panel1.Controls.Add(Me.txtErrors)
        '
        'SplitContainer2.Panel2
        '
        Me.SplitContainer2.Panel2.Controls.Add(Me.txtOcr)
        Me.SplitContainer2.Size = New System.Drawing.Size(554, 430)
        Me.SplitContainer2.SplitterDistance = 157
        Me.SplitContainer2.TabIndex = 1
        '
        'txtErrors
        '
        Me.txtErrors.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtErrors.Location = New System.Drawing.Point(0, 0)
        Me.txtErrors.Multiline = True
        Me.txtErrors.Name = "txtErrors"
        Me.txtErrors.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtErrors.Size = New System.Drawing.Size(554, 157)
        Me.txtErrors.TabIndex = 1
        '
        'txtOcr
        '
        Me.txtOcr.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtOcr.Location = New System.Drawing.Point(0, 0)
        Me.txtOcr.Multiline = True
        Me.txtOcr.Name = "txtOcr"
        Me.txtOcr.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.txtOcr.Size = New System.Drawing.Size(554, 269)
        Me.txtOcr.TabIndex = 0
        '
        'SB
        '
        Me.SB.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.SB.AutoSize = True
        Me.SB.Location = New System.Drawing.Point(12, 625)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(39, 13)
        Me.SB.TabIndex = 5
        Me.SB.Text = "Label1"
        '
        'lbImages
        '
        Me.lbImages.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbImages.FormattingEnabled = True
        Me.lbImages.Location = New System.Drawing.Point(15, 452)
        Me.lbImages.Name = "lbImages"
        Me.lbImages.Size = New System.Drawing.Size(839, 108)
        Me.lbImages.TabIndex = 6
        '
        'GroupBox1
        '
        Me.GroupBox1.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.GroupBox1.Controls.Add(Me.rbNormal)
        Me.GroupBox1.Controls.Add(Me.rbResize)
        Me.GroupBox1.Location = New System.Drawing.Point(592, 597)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(157, 41)
        Me.GroupBox1.TabIndex = 7
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Picture Control"
        '
        'rbResize
        '
        Me.rbResize.AutoSize = True
        Me.rbResize.Location = New System.Drawing.Point(26, 17)
        Me.rbResize.Name = "rbResize"
        Me.rbResize.Size = New System.Drawing.Size(36, 17)
        Me.rbResize.TabIndex = 0
        Me.rbResize.TabStop = True
        Me.rbResize.Text = "Fit"
        Me.rbResize.UseVisualStyleBackColor = True
        '
        'rbNormal
        '
        Me.rbNormal.AutoSize = True
        Me.rbNormal.Location = New System.Drawing.Point(87, 17)
        Me.rbNormal.Name = "rbNormal"
        Me.rbNormal.Size = New System.Drawing.Size(58, 17)
        Me.rbNormal.TabIndex = 1
        Me.rbNormal.TabStop = True
        Me.rbNormal.Text = "Normal"
        Me.rbNormal.UseVisualStyleBackColor = True
        '
        'frmOcrPdf
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(882, 647)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.lbImages)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.SplitContainer1)
        Me.Controls.Add(Me.txtFile)
        Me.Controls.Add(Me.btnSelect)
        Me.Controls.Add(Me.btnProcess)
        Me.Name = "frmOcrPdf"
        Me.Text = "frmOcrPdf"
        CType(Me.picGraphic, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.ResumeLayout(False)
        Me.SplitContainer2.Panel1.ResumeLayout(False)
        Me.SplitContainer2.Panel1.PerformLayout()
        Me.SplitContainer2.Panel2.ResumeLayout(False)
        Me.SplitContainer2.Panel2.PerformLayout()
        Me.SplitContainer2.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnProcess As System.Windows.Forms.Button
    Friend WithEvents btnSelect As System.Windows.Forms.Button
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents txtFile As System.Windows.Forms.TextBox
    Friend WithEvents picGraphic As System.Windows.Forms.PictureBox
    Friend WithEvents SplitContainer1 As System.Windows.Forms.SplitContainer
    Friend WithEvents SplitContainer2 As System.Windows.Forms.SplitContainer
    Friend WithEvents txtErrors As System.Windows.Forms.TextBox
    Friend WithEvents txtOcr As System.Windows.Forms.TextBox
    Friend WithEvents SB As System.Windows.Forms.Label
    Friend WithEvents lbImages As System.Windows.Forms.ListBox
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents rbNormal As System.Windows.Forms.RadioButton
    Friend WithEvents rbResize As System.Windows.Forms.RadioButton
End Class
