<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmLoadTest
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
        Me.FolderBrowserDialog1 = New System.Windows.Forms.FolderBrowserDialog()
        Me.lbFiles = New System.Windows.Forms.ListBox()
        Me.lbDirs = New System.Windows.Forms.ListBox()
        Me.txtSearch = New System.Windows.Forms.TextBox()
        Me.btnRun = New System.Windows.Forms.Button()
        Me.txtDir = New System.Windows.Forms.TextBox()
        Me.btnDir = New System.Windows.Forms.Button()
        Me.ckSubdir = New System.Windows.Forms.CheckBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'lbFiles
        '
        Me.lbFiles.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbFiles.FormattingEnabled = True
        Me.lbFiles.ItemHeight = 16
        Me.lbFiles.Location = New System.Drawing.Point(33, 253)
        Me.lbFiles.Name = "lbFiles"
        Me.lbFiles.SelectionMode = System.Windows.Forms.SelectionMode.MultiSimple
        Me.lbFiles.Size = New System.Drawing.Size(985, 356)
        Me.lbFiles.TabIndex = 0
        '
        'lbDirs
        '
        Me.lbDirs.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbDirs.FormattingEnabled = True
        Me.lbDirs.ItemHeight = 16
        Me.lbDirs.Location = New System.Drawing.Point(33, 99)
        Me.lbDirs.Name = "lbDirs"
        Me.lbDirs.Size = New System.Drawing.Size(985, 148)
        Me.lbDirs.TabIndex = 1
        '
        'txtSearch
        '
        Me.txtSearch.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtSearch.Location = New System.Drawing.Point(33, 635)
        Me.txtSearch.Name = "txtSearch"
        Me.txtSearch.Size = New System.Drawing.Size(863, 22)
        Me.txtSearch.TabIndex = 2
        '
        'btnRun
        '
        Me.btnRun.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnRun.Location = New System.Drawing.Point(902, 68)
        Me.btnRun.Name = "btnRun"
        Me.btnRun.Size = New System.Drawing.Size(116, 28)
        Me.btnRun.TabIndex = 3
        Me.btnRun.Text = "Scan"
        Me.btnRun.UseVisualStyleBackColor = True
        '
        'txtDir
        '
        Me.txtDir.Anchor = CType(((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.txtDir.Location = New System.Drawing.Point(33, 39)
        Me.txtDir.Name = "txtDir"
        Me.txtDir.Size = New System.Drawing.Size(985, 22)
        Me.txtDir.TabIndex = 4
        '
        'btnDir
        '
        Me.btnDir.Location = New System.Drawing.Point(33, 5)
        Me.btnDir.Name = "btnDir"
        Me.btnDir.Size = New System.Drawing.Size(116, 28)
        Me.btnDir.TabIndex = 5
        Me.btnDir.Text = "Select"
        Me.btnDir.UseVisualStyleBackColor = True
        '
        'ckSubdir
        '
        Me.ckSubdir.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.ckSubdir.AutoSize = True
        Me.ckSubdir.Checked = True
        Me.ckSubdir.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ckSubdir.Location = New System.Drawing.Point(356, 72)
        Me.ckSubdir.Name = "ckSubdir"
        Me.ckSubdir.Size = New System.Drawing.Size(127, 21)
        Me.ckSubdir.TabIndex = 6
        Me.ckSubdir.Text = "Include Subdirs"
        Me.ckSubdir.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.Button1.Location = New System.Drawing.Point(902, 632)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(116, 28)
        Me.Button1.TabIndex = 7
        Me.Button1.Text = "Scan"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'frmLoadTest
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(1030, 667)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.ckSubdir)
        Me.Controls.Add(Me.btnDir)
        Me.Controls.Add(Me.txtDir)
        Me.Controls.Add(Me.btnRun)
        Me.Controls.Add(Me.txtSearch)
        Me.Controls.Add(Me.lbDirs)
        Me.Controls.Add(Me.lbFiles)
        Me.Name = "frmLoadTest"
        Me.Text = "frmLoadTest"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents FolderBrowserDialog1 As FolderBrowserDialog
    Friend WithEvents lbFiles As ListBox
    Friend WithEvents lbDirs As ListBox
    Friend WithEvents txtSearch As TextBox
    Friend WithEvents btnRun As Button
    Friend WithEvents txtDir As TextBox
    Friend WithEvents btnDir As Button
    Friend WithEvents ckSubdir As CheckBox
    Friend WithEvents Button1 As Button
End Class
