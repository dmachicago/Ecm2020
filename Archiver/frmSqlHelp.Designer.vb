<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmSqlHelp
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
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer()
        Me.cbDirectory = New System.Windows.Forms.ComboBox()
        Me.btnOpenFile = New System.Windows.Forms.Button()
        Me.lbFiles = New System.Windows.Forms.ListBox()
        Me.btnAddFile = New System.Windows.Forms.Button()
        Me.btnCopy = New System.Windows.Forms.Button()
        Me.rtbFile = New System.Windows.Forms.RichTextBox()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        CType(Me.SplitContainer1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        Me.SuspendLayout()
        '
        'SplitContainer1
        '
        Me.SplitContainer1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.SplitContainer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer1.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer1.Name = "SplitContainer1"
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.Controls.Add(Me.cbDirectory)
        Me.SplitContainer1.Panel1.Controls.Add(Me.btnOpenFile)
        Me.SplitContainer1.Panel1.Controls.Add(Me.lbFiles)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.btnAddFile)
        Me.SplitContainer1.Panel2.Controls.Add(Me.btnCopy)
        Me.SplitContainer1.Panel2.Controls.Add(Me.rtbFile)
        Me.SplitContainer1.Size = New System.Drawing.Size(898, 621)
        Me.SplitContainer1.SplitterDistance = 347
        Me.SplitContainer1.TabIndex = 0
        '
        'cbDirectory
        '
        Me.cbDirectory.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.cbDirectory.FormattingEnabled = True
        Me.cbDirectory.Items.AddRange(New Object() {"Fulltext Index Routines", "SQL Routines"})
        Me.cbDirectory.Location = New System.Drawing.Point(13, 19)
        Me.cbDirectory.Name = "cbDirectory"
        Me.cbDirectory.Size = New System.Drawing.Size(310, 24)
        Me.cbDirectory.TabIndex = 2
        '
        'btnOpenFile
        '
        Me.btnOpenFile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnOpenFile.Location = New System.Drawing.Point(132, 562)
        Me.btnOpenFile.Name = "btnOpenFile"
        Me.btnOpenFile.Size = New System.Drawing.Size(75, 43)
        Me.btnOpenFile.TabIndex = 1
        Me.btnOpenFile.Text = "Open"
        Me.btnOpenFile.UseVisualStyleBackColor = True
        '
        'lbFiles
        '
        Me.lbFiles.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lbFiles.FormattingEnabled = True
        Me.lbFiles.ItemHeight = 16
        Me.lbFiles.Location = New System.Drawing.Point(12, 50)
        Me.lbFiles.Name = "lbFiles"
        Me.lbFiles.Size = New System.Drawing.Size(311, 484)
        Me.lbFiles.TabIndex = 0
        '
        'btnAddFile
        '
        Me.btnAddFile.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.btnAddFile.Location = New System.Drawing.Point(18, 562)
        Me.btnAddFile.Name = "btnAddFile"
        Me.btnAddFile.Size = New System.Drawing.Size(75, 43)
        Me.btnAddFile.TabIndex = 3
        Me.btnAddFile.Text = "Add"
        Me.btnAddFile.UseVisualStyleBackColor = True
        '
        'btnCopy
        '
        Me.btnCopy.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnCopy.Location = New System.Drawing.Point(456, 562)
        Me.btnCopy.Name = "btnCopy"
        Me.btnCopy.Size = New System.Drawing.Size(75, 43)
        Me.btnCopy.TabIndex = 2
        Me.btnCopy.Text = "Copy"
        Me.btnCopy.UseVisualStyleBackColor = True
        '
        'rtbFile
        '
        Me.rtbFile.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.rtbFile.Location = New System.Drawing.Point(18, 19)
        Me.rtbFile.Name = "rtbFile"
        Me.rtbFile.Size = New System.Drawing.Size(513, 527)
        Me.rtbFile.TabIndex = 0
        Me.rtbFile.Text = ""
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'frmSqlHelp
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(898, 621)
        Me.Controls.Add(Me.SplitContainer1)
        Me.Name = "frmSqlHelp"
        Me.Text = "frmSqlHelp"
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        CType(Me.SplitContainer1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SplitContainer1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents SplitContainer1 As SplitContainer
    Friend WithEvents btnOpenFile As Button
    Friend WithEvents lbFiles As ListBox
    Friend WithEvents btnCopy As Button
    Friend WithEvents rtbFile As RichTextBox
    Friend WithEvents cbDirectory As ComboBox
    Friend WithEvents btnAddFile As Button
    Friend WithEvents OpenFileDialog1 As OpenFileDialog
End Class
