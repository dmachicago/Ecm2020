<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmOCRdisplay
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmOCRdisplay))
        Me.PictureBox1 = New System.Windows.Forms.PictureBox
        Me.rtbOcrText = New System.Windows.Forms.RichTextBox
        Me.cbFiles = New System.Windows.Forms.ComboBox
        Me.btnOcr = New System.Windows.Forms.Button
        Me.btnShowPic = New System.Windows.Forms.Button
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog
        Me.btnGetGraphic = New System.Windows.Forms.Button
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.rbCenter = New System.Windows.Forms.RadioButton
        Me.rbStretch = New System.Windows.Forms.RadioButton
        Me.rbZoom = New System.Windows.Forms.RadioButton
        Me.rbNormal = New System.Windows.Forms.RadioButton
        Me.SB = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.f1Help = New System.Windows.Forms.HelpProvider
        Me.ckPageScan = New System.Windows.Forms.CheckBox
        Me.ckWordScan = New System.Windows.Forms.CheckBox
        Me.TT = New System.Windows.Forms.ToolTip(Me.components)
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'PictureBox1
        '
        Me.PictureBox1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.PictureBox1.Image = CType(resources.GetObject("PictureBox1.Image"), System.Drawing.Image)
        Me.PictureBox1.Location = New System.Drawing.Point(29, 28)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(387, 447)
        Me.PictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox1.TabIndex = 0
        Me.PictureBox1.TabStop = False
        '
        'rtbOcrText
        '
        Me.rtbOcrText.Location = New System.Drawing.Point(422, 34)
        Me.rtbOcrText.Name = "rtbOcrText"
        Me.rtbOcrText.Size = New System.Drawing.Size(372, 441)
        Me.rtbOcrText.TabIndex = 1
        Me.rtbOcrText.Text = ""
        '
        'cbFiles
        '
        Me.cbFiles.FormattingEnabled = True
        Me.cbFiles.Location = New System.Drawing.Point(29, 509)
        Me.cbFiles.Name = "cbFiles"
        Me.cbFiles.Size = New System.Drawing.Size(765, 21)
        Me.cbFiles.TabIndex = 2
        '
        'btnOcr
        '
        Me.btnOcr.Location = New System.Drawing.Point(690, 543)
        Me.btnOcr.Name = "btnOcr"
        Me.btnOcr.Size = New System.Drawing.Size(103, 58)
        Me.btnOcr.TabIndex = 3
        Me.btnOcr.Text = "OCR Picture"
        Me.btnOcr.UseVisualStyleBackColor = True
        '
        'btnShowPic
        '
        Me.btnShowPic.Location = New System.Drawing.Point(175, 543)
        Me.btnShowPic.Name = "btnShowPic"
        Me.btnShowPic.Size = New System.Drawing.Size(140, 58)
        Me.btnShowPic.TabIndex = 4
        Me.btnShowPic.Text = "Show Graphic"
        Me.btnShowPic.UseVisualStyleBackColor = True
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'btnGetGraphic
        '
        Me.btnGetGraphic.Location = New System.Drawing.Point(29, 543)
        Me.btnGetGraphic.Name = "btnGetGraphic"
        Me.btnGetGraphic.Size = New System.Drawing.Size(140, 58)
        Me.btnGetGraphic.TabIndex = 6
        Me.btnGetGraphic.Text = "Select Graphic"
        Me.btnGetGraphic.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.ckWordScan)
        Me.GroupBox1.Controls.Add(Me.ckPageScan)
        Me.GroupBox1.Controls.Add(Me.rbCenter)
        Me.GroupBox1.Controls.Add(Me.rbStretch)
        Me.GroupBox1.Controls.Add(Me.rbZoom)
        Me.GroupBox1.Controls.Add(Me.rbNormal)
        Me.GroupBox1.Location = New System.Drawing.Point(344, 540)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(273, 68)
        Me.GroupBox1.TabIndex = 7
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Picture Handling"
        '
        'rbCenter
        '
        Me.rbCenter.AutoSize = True
        Me.rbCenter.Location = New System.Drawing.Point(107, 44)
        Me.rbCenter.Name = "rbCenter"
        Me.rbCenter.Size = New System.Drawing.Size(56, 17)
        Me.rbCenter.TabIndex = 3
        Me.rbCenter.TabStop = True
        Me.rbCenter.Text = "Center"
        Me.rbCenter.UseVisualStyleBackColor = True
        '
        'rbStretch
        '
        Me.rbStretch.AutoSize = True
        Me.rbStretch.Location = New System.Drawing.Point(107, 21)
        Me.rbStretch.Name = "rbStretch"
        Me.rbStretch.Size = New System.Drawing.Size(59, 17)
        Me.rbStretch.TabIndex = 2
        Me.rbStretch.TabStop = True
        Me.rbStretch.Text = "Stretch"
        Me.rbStretch.UseVisualStyleBackColor = True
        '
        'rbZoom
        '
        Me.rbZoom.AutoSize = True
        Me.rbZoom.Location = New System.Drawing.Point(28, 44)
        Me.rbZoom.Name = "rbZoom"
        Me.rbZoom.Size = New System.Drawing.Size(52, 17)
        Me.rbZoom.TabIndex = 1
        Me.rbZoom.TabStop = True
        Me.rbZoom.Text = "Zoom"
        Me.rbZoom.UseVisualStyleBackColor = True
        '
        'rbNormal
        '
        Me.rbNormal.AutoSize = True
        Me.rbNormal.Location = New System.Drawing.Point(28, 21)
        Me.rbNormal.Name = "rbNormal"
        Me.rbNormal.Size = New System.Drawing.Size(58, 17)
        Me.rbNormal.TabIndex = 0
        Me.rbNormal.TabStop = True
        Me.rbNormal.Text = "Normal"
        Me.rbNormal.UseVisualStyleBackColor = True
        '
        'SB
        '
        Me.SB.Location = New System.Drawing.Point(29, 615)
        Me.SB.Name = "SB"
        Me.SB.Size = New System.Drawing.Size(764, 20)
        Me.SB.TabIndex = 8
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(22, 493)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(538, 13)
        Me.Label1.TabIndex = 9
        Me.Label1.Text = "This screen is strictly for demonstration purposes. Many graphic files cannot be " & _
            "OCR'd for any number of reasons."
        '
        'f1Help
        '
        Me.f1Help.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/ocr results.htm"
        '
        'ckPageScan
        '
        Me.ckPageScan.AutoSize = True
        Me.ckPageScan.Checked = True
        Me.ckPageScan.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckPageScan.Location = New System.Drawing.Point(184, 20)
        Me.ckPageScan.Name = "ckPageScan"
        Me.ckPageScan.Size = New System.Drawing.Size(79, 17)
        Me.ckPageScan.TabIndex = 4
        Me.ckPageScan.Text = "Page Scan"
        Me.TT.SetToolTip(Me.ckPageScan, "Try a full page scan - fastest scan, more trouble with less quality documents.")
        Me.ckPageScan.UseVisualStyleBackColor = True
        '
        'ckWordScan
        '
        Me.ckWordScan.AutoSize = True
        Me.ckWordScan.Location = New System.Drawing.Point(184, 43)
        Me.ckWordScan.Name = "ckWordScan"
        Me.ckWordScan.Size = New System.Drawing.Size(80, 17)
        Me.ckWordScan.TabIndex = 5
        Me.ckWordScan.Text = "Word Scan"
        Me.TT.SetToolTip(Me.ckWordScan, "Try an individual word scan - slower, able to handle less quality documents.")
        Me.ckWordScan.UseVisualStyleBackColor = True
        '
        'frmOCRdisplay
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(835, 640)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.SB)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.btnGetGraphic)
        Me.Controls.Add(Me.btnShowPic)
        Me.Controls.Add(Me.btnOcr)
        Me.Controls.Add(Me.cbFiles)
        Me.Controls.Add(Me.rtbOcrText)
        Me.Controls.Add(Me.PictureBox1)
        Me.f1Help.SetHelpString(Me, "http://www.ecmlibrary.com/helpfiles/ocr results.htm")
        Me.Name = "frmOCRdisplay"
        Me.f1Help.SetShowHelp(Me, True)
        Me.Text = "OCR Results Display Screen"
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents rtbOcrText As System.Windows.Forms.RichTextBox
    Friend WithEvents cbFiles As System.Windows.Forms.ComboBox
    Friend WithEvents btnOcr As System.Windows.Forms.Button
    Friend WithEvents btnShowPic As System.Windows.Forms.Button
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents btnGetGraphic As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents rbCenter As System.Windows.Forms.RadioButton
    Friend WithEvents rbStretch As System.Windows.Forms.RadioButton
    Friend WithEvents rbZoom As System.Windows.Forms.RadioButton
    Friend WithEvents rbNormal As System.Windows.Forms.RadioButton
    Friend WithEvents SB As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents f1Help As System.Windows.Forms.HelpProvider
    Friend WithEvents ckWordScan As System.Windows.Forms.CheckBox
    Friend WithEvents TT As System.Windows.Forms.ToolTip
    Friend WithEvents ckPageScan As System.Windows.Forms.CheckBox
End Class
